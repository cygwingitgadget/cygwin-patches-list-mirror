Return-Path: <cygwin-patches-return-6335-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2057 invoked by alias); 9 Jun 2008 12:12:31 -0000
Received: (qmail 2045 invoked by uid 22791); 9 Jun 2008 12:12:30 -0000
X-Spam-Check-By: sourceware.org
Received: from qmta02.westchester.pa.mail.comcast.net (HELO QMTA02.westchester.pa.mail.comcast.net) (76.96.62.24)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 09 Jun 2008 12:12:02 +0000
Received: from OMTA13.westchester.pa.mail.comcast.net ([76.96.62.52]) 	by QMTA02.westchester.pa.mail.comcast.net with comcast 	id bmAR1Z00K17dt5G520Kk00; Mon, 09 Jun 2008 12:12:00 +0000
Received: from [192.168.0.103] ([67.166.125.73]) 	by OMTA13.westchester.pa.mail.comcast.net with comcast 	id boBz1Z0071b8C2B3ZoC0Q7; Mon, 09 Jun 2008 12:12:00 +0000
X-Authority-Analysis: v=1.0 c=1 a=xe8BsctaAAAA:8 a=p44_HhNtxtLJduBsMvoA:9  a=pM0QfBQpqquzY_8FNNPpZw7YN8YA:4 a=eDFNAWYWrCwA:10 a=rPt6xJ-oxjAA:10  a=P3WduwiKEJfMPm97gIQA:9 a=qgNHuYqF0gkRAlNkvv0A:7  a=gopxFm7_cUy3ATYqPa4gqbSFqPwA:4 a=5WZzfXpOq_gA:10
Message-ID: <484D1E09.8030301@byu.net>
Date: Mon, 09 Jun 2008 12:12:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: abort() bug
References: <loom.20080606T161417-232@post.gmane.org> <20080606175426.GA31949@ednor.casa.cgf.cx>
In-Reply-To: <20080606175426.GA31949@ednor.casa.cgf.cx>
Content-Type: multipart/mixed;  boundary="------------000904050201070509010909"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q2/txt/msg00006.txt.bz2

This is a multi-part message in MIME format.
--------------000904050201070509010909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1062

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Christopher Faylor on 6/6/2008 11:54 AM:
|> Any reason that cygwin abort() closes all stdio streams prior to issuing
|> SIGABRT?
|>
|> In other words, I think that signal.cc needs to rearrange the
|> _GLOBAL_REENT->__cleanup to occur _after_ _my_tls.call_signal_handler.
|
| I think you're right.  The call to call_signal_handler was added years
| after the addition of the cleanup so it would make sense to move the
| cleanup handling after that.
|
| Want to submit a patch?

Sure.

2008-06-09  Eric Blake  <ebb9@byu.net>

	* signal.cc (abort): Only flush streams after signal handler.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkhNHggACgkQ84KuGfSFAYAIbQCglNJ0n46HGjTn1tcGqt7gEqbI
QgIAn08olZlxWhW9kaz+zjigM7PEcXpL
=xFlg
-----END PGP SIGNATURE-----

--------------000904050201070509010909
Content-Type: text/plain;
 name="cygwin.patch12"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin.patch12"
Content-length: 1243

Index: signal.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/signal.cc,v
retrieving revision 1.87
diff -u -p -r1.87 signal.cc
--- signal.cc	7 Apr 2008 18:45:58 -0000	1.87
+++ signal.cc	9 Jun 2008 12:10:43 -0000
@@ -324,16 +324,6 @@ abort (void)
 {
   _my_tls.incyg++;
   sig_dispatch_pending ();
-  /* Flush all streams as per SUSv2.
-     From my reading of this document, this isn't strictly correct.
-     The streams are supposed to be flushed prior to exit.  However,
-     if there is I/O in any signal handler that will not necessarily
-     be flushed.
-     However this is the way FreeBSD does it, and it is much easier to
-     do things this way, so... */
-  if (_GLOBAL_REENT->__cleanup)
-    _GLOBAL_REENT->__cleanup (_GLOBAL_REENT);
-
   /* Ensure that SIGABRT can be caught regardless of blockage. */
   sigset_t sig_mask;
   sigfillset (&sig_mask);
@@ -342,6 +332,10 @@ abort (void)
 
   raise (SIGABRT);
   _my_tls.call_signal_handler (); /* Call any signal handler */
+
+  /* Flush all streams as per SUSv2.  */
+  if (_GLOBAL_REENT->__cleanup)
+    _GLOBAL_REENT->__cleanup (_GLOBAL_REENT);
   do_exit (SIGABRT);	/* signal handler didn't exit.  Goodbye. */
 }
 

--------------000904050201070509010909--
