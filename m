Return-Path: <cygwin-patches-return-6778-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4226 invoked by alias); 17 Oct 2009 12:19:40 -0000
Received: (qmail 4205 invoked by uid 22791); 17 Oct 2009 12:19:38 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0 	tests=AWL,BAYES_00
X-Spam-Check-By: sourceware.org
Received: from mailout01.t-online.de (HELO mailout01.t-online.de) (194.25.134.80)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 17 Oct 2009 12:19:33 +0000
Received: from fwd02.aul.t-online.de  	by mailout01.t-online.de with smtp  	id 1Mz8Fu-0004t4-03; Sat, 17 Oct 2009 14:19:30 +0200
Received: from [10.3.2.2] (S+TL7iZp8h0mycIkEh76GC8mhMsZcYVW5GJkpyo3xvq0Pypfn2kJEs4qwqYPynegbp@[217.235.179.250]) by fwd02.aul.t-online.de 	with esmtp id 1Mz8Fh-1kbldw0; Sat, 17 Oct 2009 14:19:17 +0200
Message-ID: <4AD9B646.5000906@t-online.de>
Date: Sat, 17 Oct 2009 12:19:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090825 SeaMonkey/1.1.18
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Allow to disable root privileges with CYGWIN=noroot
References: <4AC8F299.1020303@t-online.de> <20091004195723.GH4563@calimero.vinschen.de> <20091004200843.GK4563@calimero.vinschen.de> <4ACFAE4D.90502@t-online.de> <20091010100831.GA13581@calimero.vinschen.de> <4AD243ED.6080505@t-online.de> <20091013102502.GG11169@calimero.vinschen.de> <4AD4E38A.2050301@t-online.de> <20091014104003.GA24593@calimero.vinschen.de> <1My1yO-0KvdnE0@fwd09.aul.t-online.de> <20091014120237.GA27964@calimero.vinschen.de>
In-Reply-To: <20091014120237.GA27964@calimero.vinschen.de>
Content-Type: multipart/mixed;  boundary="------------040607000500020407000308"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00109.txt.bz2

This is a multi-part message in MIME format.
--------------040607000500020407000308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1139

Corinna Vinschen wrote:
> I have a self-hacked version of such a tool which you can download
> from here: http://cygwin.de/gettokinfo/
>
>   `gettokinfo' prints everything except for the list of user rights.
>   `gettokinfo foo' prints everything including the user rights.
>
>   

Thanks. I added option -t to print the thread token, patch is attached.

Observation: When Cygwin spawns a process with CreateProcessAsUser(), 
the child process main thread has a token after startup.

$ ./gettokinfo -t
OpenThreadToken: 1008

$ ./cygdrop ./gettokinfo -t
Thread Token
Type: Impersonation
Impersonation Level: SecurityImpersonation
...

The problem is that some calls (from _cygtls?) to user.reimpersonate() 
appear between startup and uinfo_init(). uinfo_init() does not call 
RevertToSelf() after closing the inherited token.

Quick fix:

 @@ -155,7 +161,7 @@ uinfo_init ()
    cygheap->user.curr_token_is_restricted = false;
    cygheap->user.setuid_to_restricted = false;
    cygheap->user.set_saved_sid ();      /* Update the original sid */
 -  cygheap->user.reimpersonate ();
 +  cygheap->user.deimpersonate ();
 }

Typo ?

Christian


--------------040607000500020407000308
Content-Type: text/x-diff;
 name="gettokinfo-t-flag.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gettokinfo-t-flag.patch"
Content-length: 1271

--- gettokinfo.cc.orig	2009-10-14 14:35:29.000000000 +0200
+++ gettokinfo.cc	2009-10-17 13:27:28.406250000 +0200
@@ -403,13 +403,40 @@
 int
 main (int argc, char **argv)
 {
-  HANDLE token;
+  bool p_flag = false, t_flag = false;
+
+  for (int ai = 1; ai < argc; ai++)
+    {
+      if (!strcmp (argv[ai], "-p"))
+	p_flag = true;
+      else if (!strcmp (argv[ai], "-t"))
+	t_flag = true;
+      else
+	{
+	  printf ("Usage: %s [-p] [-t]\n", argv[0]);
+	  return 1;
+	}
+    }
 
-  if (!OpenProcessToken (GetCurrentProcess (),
-                         MAXIMUM_ALLOWED, //TOKEN_QUERY|TOKEN_QUERY_SOURCE,
-                         &token))
-    return error ("OpenProcessToken");
-  print_token_info (token, argc > 1);
+  HANDLE token;
+  if (t_flag)
+    {
+      if (!OpenThreadToken (GetCurrentThread (),
+			    MAXIMUM_ALLOWED, //TOKEN_QUERY|TOKEN_QUERY_SOURCE,
+			    FALSE, // !OpenAsSelf ?
+			    &token))
+	return error ("OpenThreadToken");
+      printf ("Thread Token\n");
+    }
+  else
+    {
+      if (!OpenProcessToken (GetCurrentProcess (),
+			     MAXIMUM_ALLOWED, //TOKEN_QUERY|TOKEN_QUERY_SOURCE,
+			     &token))
+	return error ("OpenProcessToken");
+      printf ("Process Token\n");
+    }
+  print_token_info (token, p_flag);
   return 0;
 }
 

--------------040607000500020407000308--
