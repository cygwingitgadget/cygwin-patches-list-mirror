Return-Path: <cygwin-patches-return-6500-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 475 invoked by alias); 11 Apr 2009 04:14:04 -0000
Received: (qmail 456 invoked by uid 22791); 11 Apr 2009 04:14:03 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-bw0-f226.google.com (HELO mail-bw0-f226.google.com) (209.85.218.226)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 11 Apr 2009 04:13:57 +0000
Received: by bwz26 with SMTP id 26so1446726bwz.2         for <cygwin-patches@cygwin.com>; Fri, 10 Apr 2009 21:13:53 -0700 (PDT)
Received: by 10.103.214.13 with SMTP id r13mr2190913muq.37.1239423233424;         Fri, 10 Apr 2009 21:13:53 -0700 (PDT)
Received: from ?82.6.108.62? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id j6sm4539505mue.4.2009.04.10.21.13.52         (version=SSLv3 cipher=RC4-MD5);         Fri, 10 Apr 2009 21:13:52 -0700 (PDT)
Message-ID: <49E013DC.4030509@gmail.com>
Date: Sat, 11 Apr 2009 04:14:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix type inconsistencies in stdint.h
References: <49D6B8D7.4020907@gmail.com> <20090404033545.GA3386@ednor.casa.cgf.cx> <49D6DDDD.4030504@gmail.com> <20090404062459.GB22452@ednor.casa.cgf.cx> <49DB4D95.7000903@byu.net> <49DB4FC4.7020903@cwilson.fastmail.fm> <20090407131534.GY852@calimero.vinschen.de>
In-Reply-To: <20090407131534.GY852@calimero.vinschen.de>
Content-Type: multipart/mixed;  boundary="------------010108020200090103050405"
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
X-SW-Source: 2009-q2/txt/msg00042.txt.bz2

This is a multi-part message in MIME format.
--------------010108020200090103050405
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 719

Corinna Vinschen wrote:

> Good point, I guess.  So, if we all agree on that, I'd suggest to
> change Dave's patch to the one below.

  Two hunks went astray in the adjustment, the fixes for INTPTR_Mxx and
SIZE_MAX still apply because we didn't change their types.

  Also, Joseph just introduced a new testcase in GCC SVN, and it shows up a
problem with our definition of WINT_MAX.  With the attached patch, and the one
I'm about to submit to gcc to update the types we just changed, everything
matches up and is correct and all the gcc.dg/c99-stdint-*.c tests pass.

  Ok?

winsup/cygwin/ChangeLog

	* include/stdint.h (INTPTR_MIN, INTPTR_MAX):  Add 'L' suffix.
	(WINT_MAX):  Add 'U' suffix.

    cheers,
      DaveK

--------------010108020200090103050405
Content-Type: text/x-c;
 name="stdint-patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stdint-patch.diff"
Content-length: 1108

Index: winsup/cygwin/include/stdint.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/stdint.h,v
retrieving revision 1.11
diff -p -u -r1.11 stdint.h
--- winsup/cygwin/include/stdint.h	7 Apr 2009 17:23:20 -0000	1.11
+++ winsup/cygwin/include/stdint.h	11 Apr 2009 03:37:11 -0000
@@ -119,8 +119,8 @@ typedef unsigned long long uintmax_t;
 
 /* Limits of integer types capable of holding object pointers */
 
-#define INTPTR_MIN (-2147483647 - 1)
-#define INTPTR_MAX (2147483647)
+#define INTPTR_MIN (-2147483647L - 1L)
+#define INTPTR_MAX (2147483647L)
 #define UINTPTR_MAX (4294967295UL)
 
 /* Limits of greatest-width integer types */
@@ -144,7 +144,7 @@ typedef unsigned long long uintmax_t;
 #endif
 
 #ifndef SIZE_MAX
-#define SIZE_MAX (4294967295UL)
+#define SIZE_MAX (4294967295U)
 #endif
 
 #ifndef WCHAR_MIN
@@ -159,7 +159,7 @@ typedef unsigned long long uintmax_t;
 
 #ifndef WINT_MIN
 #define WINT_MIN 0U
-#define WINT_MAX UINT_MAX
+#define WINT_MAX (4294967295U)
 #endif
 
 /* Macros for minimum-width integer constant expressions */

--------------010108020200090103050405--
