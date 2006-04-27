Return-Path: <cygwin-patches-return-5843-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22790 invoked by alias); 27 Apr 2006 01:18:45 -0000
Received: (qmail 22780 invoked by uid 22791); 27 Apr 2006 01:18:42 -0000
X-Spam-Check-By: sourceware.org
Received: from pproxy.gmail.com (HELO pproxy.gmail.com) (64.233.166.180)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 27 Apr 2006 01:18:38 +0000
Received: by pproxy.gmail.com with SMTP id s49so1821441pyc         for <cygwin-patches@cygwin.com>; Wed, 26 Apr 2006 18:18:36 -0700 (PDT)
Received: by 10.35.70.17 with SMTP id x17mr2456738pyk;         Wed, 26 Apr 2006 18:18:36 -0700 (PDT)
Received: by 10.35.9.14 with HTTP; Wed, 26 Apr 2006 18:18:35 -0700 (PDT)
Message-ID: <ba40711f0604261818p6f19d1b0s410af631bb4aa8a3@mail.gmail.com>
Date: Thu, 27 Apr 2006 01:18:00 -0000
From: "Lev Bishop" <lev.bishop@gmail.com>
To: cygwin-patches@cygwin.com
Subject: Re: very poor cygwin scp performance in some situations
In-Reply-To: <20060328191607.GS20907@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <04b601c651b4$a1e9e020$b3db87d4@multiplay.co.uk> 	 <20060328074041.GJ20907@calimero.vinschen.de> 	 <01f501c65254$796572e0$b3db87d4@multiplay.co.uk> 	 <20060328143952.GN20907@calimero.vinschen.de> 	 <04e501c65297$7b4979b0$b3db87d4@multiplay.co.uk> 	 <20060328191607.GS20907@calimero.vinschen.de>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00031.txt.bz2

I've investigated the reports of poor network performance on cygwin
and I've made some conclusions. The main conclusion is that there are
serious problems which have nothing at all to do with ssh. Even a
straightforward TCP streaming write, as used by, eg netcat or ttcp,
can be hit by this. It's not a small effect. I was seeing 40kbytes/sec
to my openbsd box, over a 100Mbit fast-ethernet link (directly
attached with a crossover cable) versus the 11.3Mbyte/sec
theoretically available. So potential speedups of 30000% to be had
here. When people complain Cygwin performance is too low, mostly I
think it's just whining, but in this case I'm willing to accept this
one as a valid criticism :-) Note that cygwin doesn't have this
trouble receiving data over TCP, only sending. But this might well
expected, because 90% of the complexity in TCP sits at the sender's
end, and the receiver has a much simpler job to do. It's just much
easier to get receiving right than sending. Skip to the end for my
patches, keep reading for the (long-winded) rationale....

Sniffing packets on the segment in question, it is clear that the
culprit is windows' network stack waiting for all the data it sent to
be acked, under certain circumstances, before putting more data on the
wire, rather than allowing a window of unacked data as it normally
should. OpenBSD has a 200ms delayed-ack timeout, so there are a lot of
200ms delays. This explains a number of things, such as why does it
particularly occur with BSD at the other end (because Linux has some
rather nifty heuristics to force undelayed acks when that might be
good for performance (cf quickack and pingpong in the sources), and
when delaying acks it cleverly delays the minimum amount it has
measured it can get away with), whereas BSD just does the simple delay
in all cases; and why is it even worse for OpenBSD than FreeBSD
(OpenBSD does 200ms delay, FreeBSD does 100ms); and why does it
sometimes matter which party opened the connection (because: 1. by
default Windows will honour requests for TCP timestamps during TCP
handshake, but will not ask for them in the case that windows is the
initiator; 2. only every other ack is allowed to be delayed, so it's
only a problem if an odd number of packets are sent at a time; 3. TCP
timestamp option adds bytes to the headers, so reduces the segment
size, so what before may have fit in an even number of packets, now
requires an odd number).

The next discovery is a MS KB article describing (in an evasive
manner) the cause of the problem: KB823764 states that the problem
occurs in the case that you are using nonblocking sockets, AND your
sends are at least as large as the socket's send buffer. In relation
to this there are 2 points to note: 1) cygwin implements every socket
send as nonblocking, for reasons of signal handling; 2) recent
versions of windows, running on modern hardware (at least 32Mb of RAM)
default the send buffer to 8192 bytes, and OpenSSH has a send window
of also 8192 bytes, which is exactly the right size to trigger this
problem. As Corinna said:
> Note that the performance suffers again, if the socket buffer is
> smaller than the application buffer.


Further investigation reveals that it's not just cygwin that hits this
problem. It looks like Microsoft's own software has been hit by it:
Internet Explorer: KB329781 "HTTP File Upload Operation Takes a Long
Time to Complete".
The printing subsystem: KB816627 "TCP/IP port printing may be slow in
Windows 2000"

In the first KB microsoft amusingly states in relation to the fact
that upload speed is limited to 80kbps no matter what the network
bandwidth that "this behaviour is by design". The mind boggles....
In the latter KB, they hint that it's not windows' fault, but rather a
problem with the receiving TCP/IP stack (in context, the stack running
on the printer) not conforming to the RFC 1122. They say that acks for
packets with the push bit set should not be delayed, and, looking at
the sources, BSD pays no attention whatsoever to the push bit of
incoming packets. Maybe we should look at the RFCs in question.

As far as I could tell, the only RFC that they might be thinking of is
RFC813 "window and acknowledgement strategy in tcp", an RFC whose
status is unclear to me, but certainly doesn't seem to be defining any
standards, (in particular it lacks the BP14/RFC2119 "MUST" "SHOULD"
etc, language). Anyway, in section 5 it says: "So, if a segment
arrives, postpone sending an  acknowledgement  if  both  of  the
following  conditions  hold.    First,  the  push  bit is not set in
the segment, since it is a reasonable assumption that  there  is  more
 data coming  in  a  subsequent  segment. ...."

So it would seem that BSD is violating the RFC. Trouble is, it seems
*everybody* violates this RFC, and I include Microsoft's own stack in
this statement. Closer inspection shows that {Net,Open}BSD have an
interesting sysctl net.inet.tcp.ackonpush, by default set to 0, and,
sure enough, setting it to 1 gives 4.5Mbyte/sec, a 10000% increase,
and putting us within a factor of 3 of the capacity of the link. That
was a nice improvement for a 1-line fix, but there's still that factor
of 3 to try to pick up, plus it's not always convenient to make
root-level configuration changes to every peer cygwin talks to....

So I looked at {Open,Net}BSD and try to see why that sysctl is 0 by
default. It seems that originally there was no sysctl, and the
behaviour was as if the sysctl were 0. Then in netbsd cvs
sys/netinet/tcp_input.c rev 1.8 (1994), the behaviour changed to be
like having tcp.ackonpush=3D1. Then this patch was reversed in rev 1.47
(Mar 1998) with a changelog "Per discussion with several members of
the TCPIMPL and TCPSAT IETF working groups." and finally the patch was
reintroduced in rev 1.55 (May 1998) this time conditional on the
tcp.ack_on_push sysctl. The situation is very similar on OpenBSD. I
wasn't there but I can imagine the story: They implement a change
which improves tcp performance. Then the IETF working group people say
"but any app which is improved by this is a fundamentally *broken*
app. If it can't handle a 200ms delayed ack, how can it expect to
handle the (indistinguishable) case where the acks are delayed due to
a 200ms RTT (which is typical for an intercontinental connection)". So
they back out the change, only discover that there really are an awful
lot of *broken* apps out there, and maybe it'd be nice to be able to
talk to them at a decent speed sometimes, even if they are undeniably
broken, so back in it goes, this time with an obscure sysctl to
control it.

Because TCP provides reliable service, any implementation has to keep
data in its send buffer waiting until acks have been received. The
problem with the winsock implementation is that the granularity of
removing data from the buffer is one whole send, rather than something
smaller, like one packet. It seems to be because, at lower levels, the
windows TCP implementation is consistent with other windows IO and
works in terms of overlapped IO directly out of user buffers. There
are advantages to this system, but it is very different to the unix
sockets interface, so winsock is built as a separate layer on top of
the transport, implemented in  AFD.SYS and MSAFD.DLL. (The structure
of the microsoft stack is shown in figure 1 at
http://snipurl.com/akjj ).
My reverse-engineered logic for how AFD does send buffer management
goes like this:

sock_send (userbuf)
  if (bufferedbytes < so_sndbuf)
        allocate tmpBuffer of size len (userbuf)
        copy userbuf to tmpBuffer
        initiate overlapped send on tmpBuffer
        bufferedbytes +=3D len (userbuf)
        return len (userbuf)
  else if (overlapped)
        initiate overlapped send directly on userbuf
        return INPROGRESS
  else if (blocking)
        allocate tmpBuffer of size len (userbuf)
        initiate overlapped send on tmpBuffer
        bufferedbytes +=3D len (userbuf)
        block until (only 1 overlapped send outstanding OR
                 bufferedbytes<so_sndbuf)
        return len (userbuf)
  else /* nonblocking and nonoverlapped */
        return EAGAIN
end

overlapped_send_completion_handler (buffer)
   reduce bufferedbytes by length of completed buffer
end

The winsock documentation notwithstanding, I have never seen a send()
return anything other than the full amount passed to it, or an error -- no
partial sends.

The above is similar to what KB214397 says happens, but subtley
different (if the KB were correct, then the problems wouldn't occur).
KB214397 says:

> Winsock uses the following rules to indicate a send completion to the
> application (depending on how the send is invoked, the completion notific=
ation
> could be the function returning from a blocking call, signaling an event =
or
> calling a notification function, and so forth):
> *) If the socket is still within SO_SNDBUF quota, Winsock copies the data
> from the application send and indicates the send completion to the applic=
ation.
> *) If the socket is beyond SO_SNDBUF quota and there is only one previous=
ly
> buffered send still in the stack kernel buffer, Winsock copies the data f=
rom the
> application send and indicates the send completion to the application.
> *) If the socket is beyond SO_SNDBUF quota and there is more than one
> previously buffered send in the stack kernel buffer, Winsock copies the d=
ata
> from the application send. Winsock does not indicate the send completion =
to
> the application until the stack completes enough sends to put the socket
> back within SO_SNDBUF quota or only one outstanding send condition.

There are various possible workarounds for this situation. One way
might be to disable winsock's buffering (setsockopt so_sndbuf to 0)
and do our own buffering, somehow keeping multiple sends pending. We'd
probably end up reimplementing all the hairy buffer preallocation
stuff that AFD already deals with so I didn't feel like going this
way. I still think it's worth investigating, because it might provide
a route to improving cygwin's linux emulation, by emulating
draft-minshall-nagle style nagling (as used by linux 2.4 onwards) and
Linux/FreeBSD TCP_CORK/MSG_MORE and so on. I'm not sure whether these
things would make a noticeable difference to any apps people are
likely to be running under cygwin, though (apache?). The route I
instead chose to follow was to split any large sends into chunks such
that the size of the chunk:
1) is as large as possible (to minimize system calls)
2) is always less than so_sndbuf (to avoid the delayed acks problem)
3) is always at least 1 MSS large, if the original send was at least 1
MSS large (to avoid Nagle-related delays)
4) is an integer multiple of MSS (except for the final chunk) (to
maximize network efficiency)

These constraints can't be simultaneously satisfied unless so_sndbuf
>=3D 2*MSS (ok for ethernet MSS=3D1460 and winsock default
so_sndbuf=3D8192), so I relax them one at a time as so_sndbuf shrinks
relative to MSS. The only disadvantage of this chunking (that I can
think of, and assuming so_sndbuf>=3D2*MSS) is that it can cause cygwin
to put out a lot more packets with the TCP PUSH bit set. I think this
will have very little impact, since BSD ignores the push bit, Linux
uses it only to select packets to consider for MSS estimation. One
platform which does pay attention to received push bits, though, is
windows: unless the IgnorePushBitOnReceives registry entry is set,
windows uses push bits to decide when to return from recv(), so this
chunking may cause slightly increased CPU usage on the remote peer, if
it has a microsoft stack (but this should be no worse than setting
IgnorePushBitOnReceives on the remote peer).

Another potential problem with this chunking is that the MSS, needed
in (3) and (4) above, seems to be impossible to retrieve on windows.
Winsock does not implement the getsockopt TCP_MAXSEG or IP_MTU options
nor the linux-specific TCP_INFO. Nor does it implement the TCP_CORK or
TCP_NOPUSH options nor the MSG_MORE flag, which really would be The
Right Way(TM) to deal with this (and many other problems). So we're
stuck with taking the interface MTU (which we can only get reliably on
recent Windows versions) and guessing which IP and TCP options are in
effect, effectively assuming that PMTU changes nothing and that the
remote MTU is at least as large as our MTU. Our guess will probably be
correct in many cases, and when we guess wrong, so long as there is
enough data in the send buffer, the lower layers of the stack will
coalesce sends to make full size segments anyway (on my hardware, this
seems to start to happen reliably once there is about 32kb in the send
buffer, but it probably depends on network cards, drivers, etc). Even
if the packets don't get coalesced, it's only the last packet of each
chunk which is less than full size, so in a bad case (with the default
send buffer of 8192, and the maximum usual internet MTU of 1460), we
could be putting out 20% of short packets -- with the TCP/IP and
ethernet overheads, this works out to at worst a 1.5% penalty on the
wire, so I'm not too worried, but if necessary it can always be
improved by increasing the send buffer, which you should be doing
anyway if you care about efficiency.

Here's the results (variance is about +/- 0.1MByte/s), between cygwin
and openbsd on a single segment of 100Base-T fast ethernet with a
crossover cable:
Theoretical Maximum: 100**6 * (1500-40)/(1500+38)/1024/1024/8 =3D=3D 11.3MB=
yte/s.
Best from raw winsock, every possible combination of settings I tried
(including overlapped IO, etc), 11.1MByte/s.
ttcp -tsn 30000 -l 7300 (=3D=3D1460*5): 11.1MByte/s
ttcp -tsn 30000 -l 2920 (=3D=3D1460*2): 10.9MByte/s
ttcp -tsn 30000 -b 32768: 11.0MByte/s (This represents the performance
you should see by default if you set the TcpWindowSize to 32768)
ttcp, default settings: 9.3MBytes/s (This represents the performance
you should see by default if you don't change any registry settings,
and your app doesn't change socket settings)

So there's maybe 20% overhead left in the case that the user is using
default settings and an application which doesn't play with socket
options. As far as I can tell, this remaining overhead is due to
(scheduling?) delays waiting for the thread to wake up after getting
WSAEWOULDBLOCK and calling waitformultipleevents (if I change
fhandler_socket:sendmsg() to spin without calling wait() then I get an
extra 0.7MByte/s, and also playing with the process priorities has
some effect). This isn't completely satisfying, but, still, 20% away
from the best raw winsock can do isn't all bad, for an emulation
environment (and is a 28000% increase over the situation I started
with), and as I said, increasing the window size reduces this overhead
to negligable.

Finally, lets look at the original reported problem and test with scp.
Copying from cygwin -> openbsd, initiated on cygwin I get 6.8 MB/s,
apparently cpu-limited. I'm relatively happy with that. Copying
openbsd -> cygwin, initiated on cygwin I get 1.5MB/s. Not so hot. Why
can this be? Hmm. CPU usage is only 30% so it's not that.... <sounds
of frenzied hairy debugging, gradually whittling down the entirety of
scp/ssh to a 1-page testcase. ugh>.... Turns out its due to the 10ms
Sleep() in thread_pipe(). I made a patch to reduce the impact of this
sleep. Hmm... I notice that Corinna checked in a patch to CVS a couple
of days ago which will also help with this exact problem. Perhaps
combining the two approaches will be better than either alone?
Corinna's patch should help when the pipe being select()ed on
eventually terminates the select() and mine should help in the case
that some other event terminates the select(), which is the case for
scp (incoming data on the network socket terminates the select() ). I
haven't tested this combination yet. I don't have sshd configured on
my cygwin, so I haven't tested doing copies initiated from the openbsd
side....

Anyway, with my patches to sockets and to thread_pipe(), I can scp
from openbsd -> cygwin, initiated on cygwin, at 6.8MB/s, which is the
same speed as in the other direction, and over 400% better than
without the patch.

So... my patches (against cygwin-1.5.19-4)  are attached. I hope they
are useful to someone. I have only tested them on one machine, running
windows xp sp2, so there are probably problems on other windows
versions. The select.cc patch should probably do more error checking.
The fhandler_socket patch probably has some minor race conditions on
the new class-variables (mss, mtu, chunk, sndbuf, sndbuf_old) but
since this would at worst cause only a performance problem (I think)
and because there seem to be very few POSIX guarantees on what happens
when multiple threads read on a socket in parallel anyway (other than
it won't crash), I decided not to introduce the overhead of
synchronization structures, but maybe someone has comments?

To get maximum benefit, it's advised, but not required, to increase
HKLM\System\CurrentControlSet\Services\Tcpip\Parameters\TcpWindowSize(DWORD)
to an appropriate value for your network. For my hardware, I needed
0x7fff to get segments coalescing fully, and for long fat pipes it
should be calculated from the bandwidth-delay-product, as described in
the accompanying materials for the HSN patches described earlier in
the thread.

I made an honest effort to format this patch correctly. I hope I did
everything right.

Lev
PS: If the maintainers want to incorporate this patch, and consider it
"significant" enough to require a copyright assignment, I'll be happy
to submit one.

ChangeLog:
2006-04-25  Lev Bishop  <Lev.Bishop+cygwin@gmail.com>

    * fhandler.h (fhandler_socket::mtu, fhandler_socket::mss)
    (fhandler_socket::chunk, fhandler_socket::sndbuf)
    (fhandler_socket::sndbuf_old): New class members. Keep track of
    socket params to allow sensible chunking of sends.
    * fhandler_socket.cc (nextchunk): New static function. Takes the next
    chunk from the user's buffers.
    (fhandler_socket::update_mtu, fhandler_socket::update_mss)
    (fhandler_socket::update_chunk, fhandler_socket::get_chunk)
    (fhandler_socket::update_sndbuf): New methods. Access functions for
    new variables.
    (fhandler_socket::sendmsg): Break sends into chunks.
    * net.cc (cygwin_setsockopt): Keep track of so_sndbuf.

    * select.cc (pipeinf::wakeup): New element.
    (thread_pipe, start_thread_pipe, pipe_cleanup): Use pipeinf::wakeup
    event to allow timely termination of pipe-select thread.

diff -Naurp cygwin/fhandler.h cygwin.patched/fhandler.h
--- cygwin/fhandler.h   2006-01-16 12:14:35.001000000 -0500
+++ cygwin.patched/fhandler.h   2006-04-25 04:23:23.536720700 -0400
@@ -408,6 +408,19 @@ class fhandler_socket: public fhandler_b
 void af_local_set_sockpair_cred ();

 private:
+  ssize_t mtu;
+  void update_mtu ();
+  ssize_t mss;
+  void update_mss ();
+  ssize_t chunk;
+  void update_chunk ();
+  ssize_t get_chunk (ssize_t tosend=3D0);
+  ssize_t sndbuf;
+  ssize_t sndbuf_old; // So we can tell if it changed, to update chunk
+ public:
+  void update_sndbuf ();
+
+ private:
 struct _WSAPROTOCOL_INFOA *prot_info_ptr;
 char *sun_path;
 struct status_flags
diff -Naurp cygwin/fhandler_socket.cc cygwin.patched/fhandler_socket.cc
--- cygwin/fhandler_socket.cc   2006-01-20 10:54:29.001000000 -0500
+++ cygwin.patched/fhandler_socket.cc   2006-04-25 04:23:23.566763900 -0400
@@ -126,6 +126,11 @@ get_inet_addr (const struct sockaddr *in

 fhandler_socket::fhandler_socket () :
 fhandler_base (),
+  mtu(0),
+  mss(0),
+  chunk(0),
+  sndbuf(0),
+  sndbuf_old(-1), // Different from sndbuf, to force update of chunk
 sun_path (NULL),
 status ()
 {
@@ -1242,6 +1247,163 @@ fhandler_socket::sendto (const void *ptr
 return res;
 }

+static int
+nextchunk (WSABUF *wsabuf, const struct msghdr *msg, ssize_t chunksize,
+          DWORD *bufs, DWORD *cur)
+{
+  int bytes=3D0;
+
+  const struct iovec *iov =3D msg->msg_iov + *cur;
+  const size_t iovcnt =3D msg->msg_iovlen;
+
+  u_long offset=3D0;
+  if (*bufs)
+    offset =3D wsabuf[*bufs-1].buf - (char *)iov->iov_base + wsabuf[*bufs-=
1].len;
+  for (*bufs=3D0; *cur !=3D iovcnt; ++*cur)
+    {
+      if (offset!=3Diov->iov_len)
+       {
+         wsabuf[*bufs].buf =3D (char *)iov->iov_base + offset;
+         bytes +=3D (wsabuf[*bufs].len =3D iov->iov_len - offset);
+         ++*bufs;
+         ++iov;
+         if (chunksize && bytes>=3Dchunksize)
+           {
+             wsabuf[*bufs-1].len -=3D bytes-chunksize;
+             return bytes;
+           }
+       }
+      offset =3D 0;
+    }
+  return bytes;
+}
+
+void
+fhandler_socket::update_sndbuf()
+{
+  int newsndbuf;
+  int optlen =3D sizeof(newsndbuf);
+  if (getsockopt (get_socket (), SOL_SOCKET, SO_SNDBUF,
+                 (char *)&newsndbuf, &optlen))
+    {
+      debug_printf ("unable to get so_sndbuf");
+      newsndbuf =3D 8192; // Default for windows with >32Mb or >64 Mb RAM
+    }
+  if (newsndbuf !=3D sndbuf)
+    {
+      debug_printf ("Sendbuf: %d",newsndbuf);
+      sndbuf =3D newsndbuf;
+    }
+}
+
+void
+fhandler_socket::update_mtu ()
+{
+  mtu =3D 1500; // Ethernet mtu
+  struct sockaddr_in addr;
+  int addrlen =3D sizeof(addr);
+  if (!::getsockname (get_socket (), (sockaddr *)&addr, &addrlen))
+    {
+      struct ifconf ifc;
+      struct ifreq ifr[20]; // XXX hardcoded limit
+      ifc.ifc_req =3D ifr;
+      ifc.ifc_len =3D sizeof(ifr);
+      extern int get_ifconf (struct ifconf *ifc, int what); /* net.cc */
+      if (!get_ifconf (&ifc, SIOCGIFCONF))
+       for (struct ifreq *ifrp =3D ifc.ifc_req;
+            (caddr_t) ifrp < ifc.ifc_buf + ifc.ifc_len;
+            ++ifrp)
+         if ( ((sockaddr_in*)(&ifrp->ifr_addr))->sin_addr.S_un.S_addr
+              =3D=3D addr.sin_addr.S_un.S_addr)
+           {
+             /* Check the name to avoid some races. Still a possibility
+                for races if, eg, two eth adapters change places, because
+                get_ifconf will baptise the first it finds eth0, the next
+                eth1, etc. Could avoid by coding directly to IP Helper
+                library but is it worth it? XXX
+             */
+
+             char name[strlen (ifrp->ifr_name)+1];
+             strcpy (name, ifrp->ifr_name);
+             if (!get_ifconf (&ifc, SIOCGIFMTU)
+                 && (caddr_t)ifrp < ifc.ifc_buf + ifc.ifc_len
+                 && !strcmp (name, ifrp->ifr_name))
+               {
+                 mtu =3D ifrp->ifr_mtu;
+                 debug_printf ("Using interface %s, mtu %d", name, mtu);
+               }
+             break;
+           }
+    }
+  if (mtu<576)
+    {
+      debug_printf ("Forcing minimum IP mtu of 576! (was %d)", mtu);
+      mtu =3D 576;
+    }
+}
+
+void
+fhandler_socket::update_mss ()
+{
+  /* Finding MSS is hard because winsock doesn't implement TCP_MAXSEG,
+   * TCP_INFO, IP_MTU, etc
+   *
+   * We try to estimate MSS, using the interface MTU, but.....
+   *   1) we have to assume minimal headers (timestamps? options?)
+   *   2) the interface MTU is only an upper bound on the path MTU, which
+   *      changes dynamically with PMTU-D (default enabled on windows)
+   *   3) get_ifconf() only gives accurate MTU on recent windows versions
+   * So at best we can say we have an upper bound on the MTU. At least
+   * this allows us to avoid bad nagle interactions.
+   */
+  const int hdr =3D 20 + 20; // XXX Assume default TCP/IP hdrs, no options
+  if (!mtu) update_mtu ();
+  mss =3D mtu - hdr;
+}
+
+ssize_t
+fhandler_socket::get_chunk (ssize_t tosend)
+{
+  if (sndbuf_old !=3D sndbuf) update_chunk ();
+  if (!chunk) return 0;
+  if (!tosend) return chunk;
+
+  ssize_t newchunk =3D chunk;
+  if (tosend<sndbuf) newchunk =3D 0;
+  else if (tosend-chunk<mss && chunk>mss) newchunk -=3D mss;
+#if 0 /* Slows things down */
+  if (newchunk !=3D chunk)
+    debug_printf ("Force chunk size:%d (was: %d tosend:%d)",
+                 newchunk, chunk, tosend);
+#endif
+  return newchunk;
+}
+
+void
+fhandler_socket::update_chunk ()
+{
+  ssize_t newchunk;
+  if (get_addr_family () !=3D AF_INET || get_socket_type () !=3D SOCK_STRE=
AM)
+    {
+      chunk =3D 0; // Not TCP, don't chunk
+      return;
+    }
+  /* for TCP, chunk size should be, in decreasing order of importance:
+       1) < SO_SNDBUF (to allow some bytes unacked on the channel)
+       2) >=3D MSS  (to avoid having nagle on every send)
+       3) integer*MSS (to avoid short segments), or else as large as
+            possible, to reduce their frequency
+     Relax these requirements if SO_SNDBUF is too small to allow
+     satisfying them all simultaneously. */
+  if (!mss) update_mss ();
+  if (!sndbuf) update_sndbuf ();
+  newchunk =3D mss*((sndbuf-1)/mss);
+  sndbuf_old =3D sndbuf;
+  if (newchunk =3D=3D chunk) return;
+  chunk =3D newchunk;
+  debug_printf ("Using chunk size:%d (mss:%d)", chunk, mss);
+ }
+
 int
 fhandler_socket::sendmsg (const struct msghdr *msg, int flags, ssize_t tot)
 {
@@ -1254,28 +1416,16 @@ fhandler_socket::sendmsg (const struct m
   /*TODO*/
 }

-  struct iovec *const iov =3D msg->msg_iov;
-  const int iovcnt =3D msg->msg_iovlen;
-
 int res =3D SOCKET_ERROR;

-  WSABUF wsabuf[iovcnt];
-
-  const struct iovec *iovptr =3D iov + iovcnt;
-  WSABUF *wsaptr =3D wsabuf + iovcnt;
-  do
-    {
-      iovptr -=3D 1;
-      wsaptr -=3D 1;
-      wsaptr->len =3D iovptr->iov_len;
-      wsaptr->buf =3D (char *) iovptr->iov_base;
-    }
-  while (wsaptr !=3D wsabuf);
-
+  WSABUF wsabuf[msg->msg_iovlen];
+  DWORD bufcnt =3D 0, nxtbuf =3D 0;
+  ssize_t thischunk =3D get_chunk (tot);
+  nextchunk (wsabuf, msg, thischunk, &bufcnt, &nxtbuf);
 DWORD ret =3D 0;

 if (is_nonblocking () || closed () || async_io ())
-    res =3D WSASendTo (get_socket (), wsabuf, iovcnt, &ret,
+    res =3D WSASendTo (get_socket (), wsabuf, bufcnt, &ret,
                 flags & MSG_WINMASK, (struct sockaddr *) msg->msg_name,
                 msg->msg_namelen, NULL, NULL);
 else
@@ -1283,21 +1433,29 @@ fhandler_socket::sendmsg (const struct m
   HANDLE evt;
   if (prepare (evt, FD_CLOSE | FD_WRITE | (owner () ? FD_OOB : 0)))
    {
+         DWORD partialret =3D 0;
      do
        {
-             res =3D WSASendTo (get_socket (), wsabuf, iovcnt,
-                              &ret, flags & MSG_WINMASK,
-                              (struct sockaddr *) msg->msg_name,
-                              msg->msg_namelen, NULL, NULL);
+             do
+               {
+                 res =3D WSASendTo (get_socket (), wsabuf, bufcnt,
+                                  &partialret, flags & MSG_WINMASK,
+                                  (struct sockaddr *) msg->msg_name,
+                                  msg->msg_namelen, NULL, NULL);
+               }
+             while (res =3D=3D SOCKET_ERROR
+                    && WSAGetLastError () =3D=3D WSAEWOULDBLOCK
+                    && !(res =3D wait (evt, 0))
+                    && !closed ());
+             if (res =3D=3D SOCKET_ERROR) break;
+             ret +=3D partialret;
        }
-         while (res =3D=3D SOCKET_ERROR
-                && WSAGetLastError () =3D=3D WSAEWOULDBLOCK
-                && !(res =3D wait (evt, 0))
-                && !closed ());
-         release (evt);
+         while (partialret =3D=3D thischunk
+                && nextchunk (wsabuf, msg, thischunk =3D get_chunk (tot-re=
t),
+                              &bufcnt, &nxtbuf));
    }
+      release (evt);
 }
-
 if (res =3D=3D SOCKET_ERROR)
 set_winsock_errno ();
 else
diff -Naurp cygwin/net.cc cygwin.patched/net.cc
--- cygwin/net.cc       2006-01-20 10:54:29.001000000 -0500
+++ cygwin.patched/net.cc       2006-04-25 04:23:23.606821500 -0400
@@ -686,6 +686,9 @@ cygwin_setsockopt (int fd, int level, in
   res =3D setsockopt (fh->get_socket (), level, optname,
                    (const char *) optval, optlen);

+      if (SO_SNDBUF=3D=3Doptname && SOL_SOCKET=3D=3Dlevel)
+       fh->update_sndbuf ();
+
   if (optlen =3D=3D 4)
    syscall_printf ("setsockopt optval=3D%x", *(long *) optval);

diff -Naurp cygwin/select.cc cygwin.patched/select.cc
--- cygwin/select.cc    2006-01-16 12:14:36.001000000 -0500
+++ cygwin.patched/select.cc    2006-04-25 04:23:23.646879100 -0400
@@ -615,6 +615,7 @@ struct pipeinf
 cygthread *thread;
 bool stop_thread_pipe;
 select_record *start;
+    HANDLE wakeup;
 };

 static DWORD WINAPI
@@ -645,7 +646,7 @@ thread_pipe (void *arg)
    }
   if (gotone)
    break;
-      Sleep (10);
+      WaitForSingleObject(pi->wakeup,10);
 }
 out:
 return 0;
@@ -662,6 +663,7 @@ start_thread_pipe (select_record *me, se
 pipeinf *pi =3D new pipeinf;
 pi->start =3D &stuff->start;
 pi->stop_thread_pipe =3D false;
+  pi->wakeup=3DCreateEvent(0,0,0,0);
 pi->thread =3D new cygthread (thread_pipe, 0, pi, "select_pipe");
 me->h =3D *pi->thread;
 if (!me->h)
@@ -677,7 +679,9 @@ pipe_cleanup (select_record *, select_st
 if (pi && pi->thread)
 {
   pi->stop_thread_pipe =3D true;
+      SetEvent(pi->wakeup);
   pi->thread->detach ();
+      CloseHandle(pi->wakeup);
   delete pi;
   stuff->device_specific_pipe =3D NULL;
 }
