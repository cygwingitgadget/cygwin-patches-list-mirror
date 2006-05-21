Return-Path: <cygwin-patches-return-5856-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5121 invoked by alias); 21 May 2006 01:43:23 -0000
Received: (qmail 5111 invoked by uid 22791); 21 May 2006 01:43:22 -0000
X-Spam-Check-By: sourceware.org
Received: from py-out-1112.google.com (HELO py-out-1112.google.com) (64.233.166.182)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 21 May 2006 01:43:18 +0000
Received: by py-out-1112.google.com with SMTP id o67so1209961pye         for <cygwin-patches@cygwin.com>; Sat, 20 May 2006 18:43:17 -0700 (PDT)
Received: by 10.35.101.9 with SMTP id d9mr540506pym;         Sat, 20 May 2006 18:43:16 -0700 (PDT)
Received: by 10.35.30.7 with HTTP; Sat, 20 May 2006 18:43:16 -0700 (PDT)
Message-ID: <ba40711f0605201843g3ed55755ue3140fd2b1b66acb@mail.gmail.com>
Date: Sun, 21 May 2006 01:43:00 -0000
From: "Lev Bishop" <lev.bishop@gmail.com>
To: cygwin-patches@cygwin.com
Subject: Getting the pipe guard
MIME-Version: 1.0
Content-Type: multipart/mixed;  	boundary="----=_Part_468_17523270.1148175796426"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00044.txt.bz2


------=_Part_468_17523270.1148175796426
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-length: 2173

I was trying to make nonblocking pipe reads actually not block. Here's
an example of the problem:

bash-3.1$ exec 8< <(while :; do sleep 1 ; echo -n \* ; done )
bash-3.1$ cat <&8 >/dev/null &
[2] 308
bash-3.1$ dd iflag=3Dnonblock bs=3D1 <&8
dd: reading `standard input': Resource temporarily unavailable
0+0 records in
0+0 records out
0 bytes (0 B) copied, 3.2 seconds, 0.0 kB/s

I tracked down the problem and made the attached patch to get the
guard mutex, which I believe was cgf's intention when he put get_guard
(I'm guessing from the changelogs, here), since the previous code was
a no-op.

2006-05-15 Lev Bishop <lev.bishop+cygwin@gmail.com>
=09
	* select.cc (fhandler_pipe::ready_for_read): Actually get the
	guard mutex.

However, although this improves things, the "nonblocking" read can
still block for the duration of one read in the other process. I
deduce that, despite the msdn article on PeekNamedPipe:
> The function always returns immediately, even if there is no data in the
> pipe. The wait mode of a named pipe handle (blocking or nonblocking) has
> no effect on the function.
...actually it can block for the duration of another process's
blocking read. Presumably, windows has an internal guard mutex of it's
own.....

There are 2 questions I have related to this:
1) Why does cygwin go to all the trouble of having guard mutexes and
so on for it's pipes, to simulate nonblocking operations (imperfectly
for pipe reads, not at all for pipe writes) when there's the
PIPE_NOWAIT flag available which appears to do it in a built-in
fashion? Has this been considered and rejected for some reason I can't
think of?
2) In my example above I had 2 descriptors to the same pipe, one set
blocking and one nonblocking. Unix behaviour doesn't allow this
because O_NONBLOCK applies to the file description, not to a
particular file descriptor. The same goes for O_APPEND, O_ASYNC, etc.
For full unix compatibility these flags (and I would guess various
parts of the fhandler_xxx structures, like my fhandler_socket::chunk)
would have to be put in shared regions or similar. Has something like
this been contemplated?

Consider this patch untested at present.

L

------=_Part_468_17523270.1148175796426
Content-Type: text/plain; name=selectpatch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_engogh0b
Content-Disposition: attachment; filename="selectpatch"
Content-length: 814

Index: select.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/select.cc,v
retrieving revision 1.123
diff -u -p -d -r1.123 select.cc
--- select.cc	24 Apr 2006 15:16:45 -0000	1.123
+++ select.cc	21 May 2006 00:56:04 -0000
@@ -689,14 +689,18 @@ pipe_cleanup (select_record *, select_st
 int
 fhandler_pipe::ready_for_read (int fd, DWORD howlong)
 {
-  int res;
+  int res = true;
+  const HANDLE w4[2] = {signal_arrived, get_guard ()};
   if (howlong)
-    res = true;
+    {
+      if (w4[2] && WAIT_OBJECT_0 == WaitForMultipleObjects (2, w4, 0, INFINITE))
+	{
+	  set_sig_errno (EINTR);
+	  return 0;
+	}
+    }
   else
     res = fhandler_base::ready_for_read (fd, howlong);
-
-  if (res)
-    get_guard ();
   return res;
 }
 



























------=_Part_468_17523270.1148175796426--
