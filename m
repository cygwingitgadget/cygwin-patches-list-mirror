Return-Path: <cygwin-patches-return-6579-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7460 invoked by alias); 30 Jul 2009 13:34:12 -0000
Received: (qmail 7443 invoked by uid 22791); 30 Jul 2009 13:34:11 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0 	tests=AWL,BAYES_00,HK_OBFDOM,J_CHICKENPOX_72,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from ey-out-1920.google.com (HELO ey-out-1920.google.com) (74.125.78.145)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 30 Jul 2009 13:34:05 +0000
Received: by ey-out-1920.google.com with SMTP id 13so308595eye.20         for <cygwin-patches@cygwin.com>; Thu, 30 Jul 2009 06:34:02 -0700 (PDT)
Received: by 10.211.201.8 with SMTP id d8mr1704200ebq.50.1248960842659;         Thu, 30 Jul 2009 06:34:02 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 28sm1713415eyg.40.2009.07.30.06.34.01         (version=SSLv3 cipher=RC4-MD5);         Thu, 30 Jul 2009 06:34:01 -0700 (PDT)
Message-ID: <4A71A45A.10409@gmail.com>
Date: Thu, 30 Jul 2009 13:34:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Fix order of dtors problem.
Content-Type: multipart/mixed;  boundary="------------070904010106000308070408"
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
X-SW-Source: 2009-q3/txt/msg00033.txt.bz2

This is a multi-part message in MIME format.
--------------070904010106000308070408
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 457


  This is the patch I'm currently testing (so far, uneventfully).  I thought I'd
send it here for posterity just in case I get squashed by a falling hippo or
anything over the weekend.

winsup/cygwin/ChangeLog:

	* globals.cc (enum exit_states::ES_GLOBAL_DTORS): Delete.
	* dcrt0.cc (__main): Schedule dll_global_dtors to run
	atexit before global dtors.
	(do_exit): Delete test for ES_GLOBAL_DTORS and call to
	dll_global_dtors.

    cheers,
      DaveK


--------------070904010106000308070408
Content-Type: text/x-c;
 name="no-ES_GLOBAL_DTORS.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="no-ES_GLOBAL_DTORS.diff"
Content-length: 1668

? foo
Index: dcrt0.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dcrt0.cc,v
retrieving revision 1.359
diff -p -u -r1.359 dcrt0.cc
--- dcrt0.cc	3 Jul 2009 18:05:50 -0000	1.359
+++ dcrt0.cc	29 Jul 2009 15:22:07 -0000
@@ -993,8 +993,17 @@ cygwin_dll_init ()
 extern "C" void
 __main (void)
 {
+  /* Ordering is critical here.  DLL ctors have already been
+     run as they were being loaded, so we should stack the 
+     queued call to DLL dtors now.  */
+  atexit (dll_global_dtors);
   do_global_ctors (user_data->ctors, false);
+  /* Now we have run global ctors, register their dtors.  */
   atexit (do_global_dtors);
+  /* At exit, global dtors will run first, so the app can still
+     use shared library functions while terminating; then the
+     DLLs will be destroyed; finally newlib will shut down stdio
+     and terminate itself.  */
 }
 
 void __stdcall
@@ -1013,12 +1022,6 @@ do_exit (int status)
 
   lock_process until_exit (true);
 
-  if (exit_state < ES_GLOBAL_DTORS)
-    {
-      exit_state = ES_GLOBAL_DTORS;
-      dll_global_dtors ();
-    }
-
   if (exit_state < ES_EVENTS_TERMINATE)
     {
       exit_state = ES_EVENTS_TERMINATE;
Index: globals.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/globals.cc,v
retrieving revision 1.7
diff -p -u -r1.7 globals.cc
--- globals.cc	17 Jul 2009 09:00:19 -0000	1.7
+++ globals.cc	29 Jul 2009 15:22:07 -0000
@@ -30,7 +30,6 @@ enum exit_states
   {
     ES_NOT_EXITING = 0,
     ES_PROCESS_LOCKED,
-    ES_GLOBAL_DTORS,
     ES_EVENTS_TERMINATE,
     ES_THREADTERM,
     ES_SIGNAL,

--------------070904010106000308070408--
