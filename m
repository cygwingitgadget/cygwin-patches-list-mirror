Return-Path: <cygwin-patches-return-6173-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12469 invoked by alias); 22 Nov 2007 16:42:10 -0000
Received: (qmail 12459 invoked by uid 22791); 22 Nov 2007 16:42:10 -0000
X-Spam-Check-By: sourceware.org
Received: from s200aog11.obsmtp.com (HELO s200aog11.obsmtp.com) (207.126.144.125)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 22 Nov 2007 16:42:00 +0000
Received: from source ([164.129.1.35]) (using TLSv1) by eu1sys200aob011.postini.com ([207.126.147.11]) with SMTP; 	Thu, 22 Nov 2007 16:41:57 UTC
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9]) 	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C44C5DAF9 	for <cygwin-patches@cygwin.com>; Thu, 22 Nov 2007 16:41:56 +0000 (GMT)
Received: from mail1.bri.st.com (mail1.bri.st.com [164.129.8.218]) 	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 18E0C4C0DE 	for <cygwin-patches@cygwin.com>; Thu, 22 Nov 2007 16:41:55 +0000 (GMT)
Received: from [164.129.15.13] (bri1043.bri.st.com [164.129.15.13]) 	by mail1.bri.st.com (MOS 3.7.5a-GA) 	with ESMTP id CJL62143 (AUTH stubbsa); 	Thu, 22 Nov 2007 16:41:53 GMT
Message-ID: <4745B152.3070704@st.com>
Date: Thu, 22 Nov 2007 16:42:00 -0000
From: Andrew STUBBS <andrew.stubbs@st.com>
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Resource Temporarily Unavailable workaround
Content-Type: multipart/mixed;  boundary="------------090308040302060302030605"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00025.txt.bz2

This is a multi-part message in MIME format.
--------------090308040302060302030605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1510

Hi all,

I have recently been plagued by the 'Cannot fork: Resource temporarily 
unavailable' problem.

Searching the web reveals the there are about half as many solutions as 
there are people complaining about it, none of which work for me (or the 
other half of the complaining people, apparently).

If I'm wrong about this then stop me now, and tell me how I should have 
fixed it. :)

Anyway, here's *my* solution, and hopefully this one can be made to work 
for other people also.

The attached patch adds a 'retry' to the fork system call. Basically it 
waits 10 seconds to allow the 'resource temporarily unavailable' to 
become (temporarily) available once more, and tries again, up to a 
maximum of three attempts.

It also saves a log file (under /tmp) so that I can see whether it is 
doing anything or not - the problem is impossible to reproduce at will. 
This is merely a debugging aid and should be removed from the final 
patch. I did a complete build of our product and the log file indicates 
the problem was averted twice. On both occasions a single retry was 
sufficient.

I do not claim that this patch is in any way ready to commit. It is 
merely a proof of concept.

I do not know what the requirements are for submission of patches to 
this project. If I require any sort of copyright assignment then please 
feel free to use my idea, but I shall not be able to help with the final 
implementation.

I hope we can find some acceptable way of solving this nasty problem.

Andrew Stubbs

--------------090308040302060302030605
Content-Type: text/plain;
 name="cygwin-fork.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin-fork.patch"
Content-length: 1319

--- cygwin-1.5.24-2.orig/winsup/cygwin/fork.cc	2007-01-23 17:16:59.001000000 +0000
+++ cygwin-1.5.24-2/winsup/cygwin/fork.cc	2007-11-14 13:01:48.981500000 +0000
@@ -37,6 +37,8 @@ details. */
 /* FIXME: Once things stabilize, bump up to a few minutes.  */
 #define FORK_WAIT_TIMEOUT (300 * 1000)     /* 300 seconds */
 
+extern "C" int wrappedfork();
+
 class frok
 {
   dll *first_dll;
@@ -47,7 +49,7 @@ class frok
   int this_errno;
   int __stdcall parent (void *esp);
   int __stdcall child (void *esp);
-  friend int fork ();
+  friend int wrappedfork ();
 };
 
 static void
@@ -512,7 +514,7 @@ cleanup:
 }
 
 extern "C" int
-fork ()
+wrappedfork ()
 {
   frok grouped;
   MALLOC_CHECK;
@@ -580,6 +582,37 @@ fork ()
   syscall_printf ("%d = fork()", res);
   return res;
 }
+
+extern "C" int
+fork ()
+{
+  int i;
+  int result;
+
+  for (i=0; i<3; i++)
+    {
+      if (i > 0)
+        {
+          Sleep (10000);
+
+          debug_printf ("wrappedfork: retry %d\n", i);
+
+	  FILE *fd = fopen ("/tmp/fork.log", "a");
+	  fprintf (fd, "Fork failed: errno = %d, retry = %d\n", errno, i);
+          fclose (fd);
+        }
+
+      result = wrappedfork ();
+
+      if (result != -1)
+	break;
+
+      debug_printf ("wrappedfork() failed\n");
+    }
+
+  return result;
+}
+
 #ifdef DEBUGGING
 void
 fork_init ()

--------------090308040302060302030605--
