Return-Path: <cygwin-patches-return-5844-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1428 invoked by alias); 27 Apr 2006 10:33:15 -0000
Received: (qmail 1413 invoked by uid 22791); 27 Apr 2006 10:33:11 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Thu, 27 Apr 2006 10:33:05 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 79C5C6D42B2; Thu, 27 Apr 2006 12:33:02 +0200 (CEST)
Date: Thu, 27 Apr 2006 10:33:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: very poor cygwin scp performance in some situations
Message-ID: <20060427103302.GE11497@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <04b601c651b4$a1e9e020$b3db87d4@multiplay.co.uk> <20060328074041.GJ20907@calimero.vinschen.de> <01f501c65254$796572e0$b3db87d4@multiplay.co.uk> <20060328143952.GN20907@calimero.vinschen.de> <04e501c65297$7b4979b0$b3db87d4@multiplay.co.uk> <20060328191607.GS20907@calimero.vinschen.de> <ba40711f0604261818p6f19d1b0s410af631bb4aa8a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba40711f0604261818p6f19d1b0s410af631bb4aa8a3@mail.gmail.com>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00032.txt.bz2

Lev,

On Apr 26 21:18, Lev Bishop wrote:
> I've investigated the reports of poor network performance on cygwin
> [lots of interesting description erased]

thanks for doing this awful lot of debugging and the patch.  I see that
you didn't expect this patch getting applied without some discussion,
so, here we go.

> Corinna's patch should help when the pipe being select()ed on
> eventually terminates the select() and mine should help in the case
> that some other event terminates the select(), which is the case for
> scp (incoming data on the network socket terminates the select() ). I
> haven't tested this combination yet. I don't have sshd configured on
> my cygwin, so I haven't tested doing copies initiated from the openbsd
> side....
> 
> Anyway, with my patches to sockets and to thread_pipe(), I can scp
> from openbsd -> cygwin, initiated on cygwin, at 6.8MB/s, which is the
> same speed as in the other direction, and over 400% better than
> without the patch.

Just to clarify.  I looked into the performance problem, too, and it
turned out that the biggest problem in case of using scp was the 10ms
delay in thread_pipe.  The idea of my patch is to have practically no
delay in thread_pipe if a lot of data is going over the pipe.  In my
case, the performance gain was:

  cygwin-box> scp linux-box:file .
  ... 1.3 MB/s

vs.

  cygwin-box> scp linux-box:file .
  ... 11.8 MB/s

This *is* scp, so I'm not sure your change to thread_pipe is really
necessary anymore.  It adds another creation of an OS object on each
select invocation.  Hmm.

Btw., I also noticed the small 8K SO_SNDBUF and SO_RCVBUF sizes, so I
compared them with Linux.  As a result I changed net.cc, function
fdsock, to set the start values of the SO_SNDBUF and SO_RCVBUF buffers
to the same as on Linux, which is 85K rcv/16K snd for TCP connections,
resp. 120K for UDP or AF_LOCAL sockets (just local inet sockets, as
you're well aware, probably).  Your update_sndbuf function would have to
take this into account, though.

> So... my patches (against cygwin-1.5.19-4)  are attached.

That's a problem.  Please send patches against the latest from CVS.
That's where it's getting applied against and it's no fun to have to
manually tweak a patch to be able to apply it.

>  I decided not to introduce the overhead of
> synchronization structures, but maybe someone has comments?

Not yet.  I would also think sync'ing isn't of major importance here.

> To get maximum benefit, it's advised, but not required, to increase
> HKLM\System\CurrentControlSet\Services\Tcpip\Parameters\TcpWindowSize(DWORD)
> to an appropriate value for your network. 

We shouldn't think about this at all :-)  The registry settings aren't
really under our control, so we have to live with what we get.  However,
if it's useful to *know* the value, we could of course use the current
setting for further tweaking...

> I made an honest effort to format this patch correctly. I hope I did
> everything right.
> 
> Lev
> PS: If the maintainers want to incorporate this patch, and consider it
> "significant" enough to require a copyright assignment, I'll be happy
> to submit one.

A few comments:

The patch is slightly longer than the usual "10 lines are trivial" rule,
so, yes, you will have to sign and send the copyright assignment form.

The formatting of the patch seem to be broken as far as indentation
is concerned (by the mail client?)

In the ChangeLog we would prefer a new line for each changed or new
function.  Rather use "Ditto." than to put multiple function names into
one bracket expression.

I'd like to play with this patch and to apply it eventually, but it's a
bit late for 1.5.20, sorry.

This is my second last day until vacation and a 10 days hospital stay
right after that.  So I'm not available for the next four weeks.  Any
further action has to wait until June, sorry again.


Thanks for this patch and the really interesting discussion of the
internals.  It's highly appreciated.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
