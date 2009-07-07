Return-Path: <cygwin-patches-return-6561-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12026 invoked by alias); 7 Jul 2009 20:28:19 -0000
Received: (qmail 12011 invoked by uid 22791); 7 Jul 2009 20:28:18 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0 	tests=AWL,BAYES_00,J_CHICKENPOX_62,J_CHICKENPOX_82,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f213.google.com (HELO mail-ew0-f213.google.com) (209.85.219.213)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 07 Jul 2009 20:28:11 +0000
Received: by ewy9 with SMTP id 9so5719168ewy.2         for <cygwin-patches@cygwin.com>; Tue, 07 Jul 2009 13:28:08 -0700 (PDT)
Received: by 10.210.35.10 with SMTP id i10mr7687821ebi.52.1246998488554;         Tue, 07 Jul 2009 13:28:08 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 5sm465209eyh.40.2009.07.07.13.28.07         (version=SSLv3 cipher=RC4-MD5);         Tue, 07 Jul 2009 13:28:08 -0700 (PDT)
Message-ID: <4A53B2D3.6000405@gmail.com>
Date: Tue, 07 Jul 2009 20:28:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Libstdc++ support changes.
References: <4A537645.1070004@gmail.com>  <20090707171858.GR12258@calimero.vinschen.de> <20090707175615.GB4609@ednor.casa.cgf.cx>
In-Reply-To: <20090707175615.GB4609@ednor.casa.cgf.cx>
Content-Type: multipart/mixed;  boundary="------------020904040704010805030508"
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
X-SW-Source: 2009-q3/txt/msg00015.txt.bz2

This is a multi-part message in MIME format.
--------------020904040704010805030508
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 840

Christopher Faylor wrote:
> On Tue, Jul 07, 2009 at 07:18:58PM +0200, Corinna Vinschen wrote:

>> In the ChangeLogs,
>> please use just one space after the colon.

> Nope.  I noticed the comment style too (and missed the two spaces after
> the colon).  Obviously not a big deal but it would be nice to have them
> consistent.

  All tidied up and committed.  I even added missing pre-terminator spaces to
a couple of existing comments where they were in diff hunks anyway.

  As you mentioned the ChangeLog thing, well I always thought of that as the
start of a sentence, not counting the file/function name which I think of as
being like the number at the start of an itemised list item.  Anyway it's in
the coding standards that way, so I went back and fixed up my old entries.
Committed the attached as obvious.

    cheers,
      DaveK

--------------020904040704010805030508
Content-Type: text/x-c;
 name="changelog-fixups.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="changelog-fixups.diff"
Content-length: 1915

Index: ChangeLog
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/ChangeLog,v
retrieving revision 1.4560
diff -p -u -r1.4560 ChangeLog
--- ChangeLog	7 Jul 2009 20:12:44 -0000	1.4560
+++ ChangeLog	7 Jul 2009 20:24:08 -0000
@@ -116,7 +116,7 @@
 
 2009-07-04  Dave Korn  <dave.korn.cygwin@gmail.com>
 
-	* autoload.cc (AttachConsole):  Correct size of args.
+	* autoload.cc (AttachConsole): Correct size of args.
 
 2009-07-03  Christopher Faylor  <me+cygwin@cgf.cx>
 
@@ -495,8 +495,8 @@
 
 2009-06-05  Dave Korn  <dave.korn.cygwin@gmail.com>
 
-	* winbase.h (ilockexch):  Fix asm constraints.
-	(ilockcmpexch):  Likewise.
+	* winbase.h (ilockexch): Fix asm constraints.
+	(ilockcmpexch): Likewise.
 
 2009-06-05  Corinna Vinschen  <corinna@vinschen.de>
 
@@ -523,8 +523,8 @@
 
 2009-06-04  Dave Korn  <dave.korn.cygwin@gmail.com>
 
-	* thread.cc (__cygwin_lock_lock):  Delete racy optimisation.
-	(__cygwin_lock_unlock):  Likewise.
+	* thread.cc (__cygwin_lock_lock): Delete racy optimisation.
+	(__cygwin_lock_unlock): Likewise.
 
 2009-06-03  IWAMURO Motnori  <deenheart@gmail.com>
 
@@ -857,10 +857,10 @@
 
 2009-04-13  Dave Korn  <dave.korn.cygwin@gmail.com>
 
-	* include/stdint.h (intptr_t):  Remove long from type.
-	(uintptr_t):  Likewise.
-	(INTPTR_MIN):  Remove 'L' suffix.
-	(INTPTR_MAX, UINTPTR_MAX):  Likewise.
+	* include/stdint.h (intptr_t): Remove long from type.
+	(uintptr_t): Likewise.
+	(INTPTR_MIN): Remove 'L' suffix.
+	(INTPTR_MAX, UINTPTR_MAX): Likewise.
 
 2009-04-12  Christopher Faylor  <me+cygwin@cgf.cx>
 
@@ -894,8 +894,8 @@
 
 2009-04-11  Dave Korn <dave.korn.cygwin@googlemail.com>
 
-	* include/stdint.h (INTPTR_MIN, INTPTR_MAX):  Add 'L' suffix.
-	(WINT_MAX):  Add 'U' suffix.
+	* include/stdint.h (INTPTR_MIN, INTPTR_MAX): Add 'L' suffix.
+	(WINT_MAX): Add 'U' suffix.
 
 2009-04-10  Christopher Faylor  <me+cygwin@cgf.cx>
 

--------------020904040704010805030508--
