Return-Path: <cygwin-patches-return-6885-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9731 invoked by alias); 9 Jan 2010 11:14:25 -0000
Received: (qmail 9715 invoked by uid 22791); 9 Jan 2010 11:14:24 -0000
X-SWARE-Spam-Status: No, hits=-2.2 required=5.0 	tests=AWL,BAYES_00,HK_OBFDOM,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f222.google.com (HELO mail-ew0-f222.google.com) (209.85.219.222)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 09 Jan 2010 11:14:20 +0000
Received: by ewy22 with SMTP id 22so24059154ewy.19         for <cygwin-patches@cygwin.com>; Sat, 09 Jan 2010 03:14:17 -0800 (PST)
Received: by 10.213.46.145 with SMTP id j17mr2302798ebf.8.1263035655844;         Sat, 09 Jan 2010 03:14:15 -0800 (PST)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 10sm47000966eyz.7.2010.01.09.03.14.14         (version=SSLv3 cipher=RC4-MD5);         Sat, 09 Jan 2010 03:14:15 -0800 (PST)
Message-ID: <4B4868F7.1000100@gmail.com>
Date: Sat, 09 Jan 2010 11:14:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Fix maybe-used-uninitialised warning.
Content-Type: multipart/mixed;  boundary="------------060105080107010603060106"
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
X-SW-Source: 2010-q1/txt/msg00001.txt.bz2

This is a multi-part message in MIME format.
--------------060105080107010603060106
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 875


    Hi,

  Here are two small fixes shown up by more sensitive warnings in gcc-4.5.0.
In hookapi.cc, it notices that the loop might not run even once; in
fhandler_tty, it appears to miss that the loops can never exit.  That probably
needs fixing upstream (but it may be some odd artifact of C++ language rules,
since it only happens there, not in plain C; something to do with exceptional
exits, maybe), but until then it seemed harmless to add a trivial return zero;
it'll only add a handful of bytes to the dll.  (I tested attribute noreturn
and it didn't help.)

winsup/cygwin/ChangeLog:

	* hookapi.cc (hook_or_detect_cygwin): Initialise i earlier to avoid
	warning.

  OK?

winsup/cygwin/ChangeLog:

	* fhandler_tty.cc (process_input): Add redundant final return to
	silence (bogus?) warning.

  OK, or wait to see what upstream says about it?

    cheers,
      DaveK

--------------060105080107010603060106
Content-Type: text/x-c;
 name="hookapi-uninit-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="hookapi-uninit-fix.diff"
Content-length: 661

Index: winsup/cygwin/hookapi.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/hookapi.cc,v
retrieving revision 1.19
diff -p -u -r1.19 hookapi.cc
--- winsup/cygwin/hookapi.cc	11 Sep 2008 04:34:23 -0000	1.19
+++ winsup/cygwin/hookapi.cc	9 Jan 2010 08:24:29 -0000
@@ -252,7 +252,7 @@ hook_or_detect_cygwin (const char *name,
   fh.origfn = NULL;
   fh.hookfn = fn;
   char *buf = (char *) alloca (strlen (name) + sizeof ("_64"));
-  int i;
+  int i = -1;
   // Iterate through each import descriptor, and redirect if appropriate
   for (PIMAGE_IMPORT_DESCRIPTOR pd = pdfirst; pd->FirstThunk; pd++)
     {

--------------060105080107010603060106
Content-Type: text/x-c;
 name="ttyhandler-missing-retvals-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ttyhandler-missing-retvals-fix.diff"
Content-length: 714

Index: winsup/cygwin/fhandler_tty.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_tty.cc,v
retrieving revision 1.190
diff -p -u -r1.190 fhandler_tty.cc
--- winsup/cygwin/fhandler_tty.cc	24 Jul 2009 20:54:33 -0000	1.190
+++ winsup/cygwin/fhandler_tty.cc	9 Jan 2010 08:25:06 -0000
@@ -225,6 +225,7 @@ process_input (void *)
 	  == line_edit_signalled)
 	tty_master->console->eat_readahead (-1);
     }
+  return 0;
 }
 
 bool
@@ -438,6 +439,7 @@ process_ioctl (void *)
 				  : (void *) &ttyp->arg);
       SetEvent (tty_master->ioctl_done_event);
     }
+  return 0;
 }
 
 /**********************************************************************/

--------------060105080107010603060106--
