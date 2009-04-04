Return-Path: <cygwin-patches-return-6470-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6897 invoked by alias); 4 Apr 2009 01:23:10 -0000
Received: (qmail 6707 invoked by uid 22791); 4 Apr 2009 01:23:09 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f173.google.com (HELO mail-ew0-f173.google.com) (209.85.219.173)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 04 Apr 2009 01:22:56 +0000
Received: by ewy21 with SMTP id 21so1225474ewy.2         for <cygwin-patches@cygwin.com>; Fri, 03 Apr 2009 18:22:53 -0700 (PDT)
Received: by 10.210.111.17 with SMTP id j17mr983756ebc.13.1238808173850;         Fri, 03 Apr 2009 18:22:53 -0700 (PDT)
Received: from ?82.6.108.62? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 10sm3723407eyz.29.2009.04.03.18.22.53         (version=SSLv3 cipher=RC4-MD5);         Fri, 03 Apr 2009 18:22:53 -0700 (PDT)
Message-ID: <49D6B8D7.4020907@gmail.com>
Date: Sat, 04 Apr 2009 01:23:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Fix type inconsistencies in stdint.h
Content-Type: multipart/mixed;  boundary="------------000608080306060909070702"
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
X-SW-Source: 2009-q2/txt/msg00012.txt.bz2

This is a multi-part message in MIME format.
--------------000608080306060909070702
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 1550


    Hi team,

  Upstream GCC just gained the ability to know all about the stdint.h types
and limits internally.  If you're interested in the background, see

    http://gcc.gnu.org/ml/gcc/2009-04/msg00000.html

and thread for further reading.

  I've submitted the necessary info for the cygwin GCC backend, and now the
associated testcases show up a few bugs in our stdint.h declarations.
Basically:-

- uint32_t is "unsigned int", but UINT32_MAX is an unsigned long int constant
(denoted by the 'UL' suffix).
- int_least32_t is "long", where INT_LEAST32_MIN and INT_LEAST32_MAX are plain
(unsuffixed) int constants.
- int_fast16_t and int_fast32_t are both "long", where INT_FAST16/32_MIN/MAX
are all plain (unsuffixed) ints.
- intptr_t is "long" but INTPTR_MIN and INTPTR_MAX lack the "L" suffix and so
are just ints.
- size_t is "unsigned int" but the SIZE_MAX constant is unsigned long.

  This is bad because if the value of one of these MIN or MAX limits is not of
the correct integer type matching the integer type it is used in conjunction
with, there will be an implicit cast operation anytime you assign the
wrongly-typed value to a variable of the type for which it is supposed to be
the limit.

  The attached patch fixes all these by adjusting only the suffix letters.  OK
for head?

winsup/cygwin/ChangeLog

	* include/stdint.h (UINT32_MAX, INT_LEAST32_MIN, INT_LEAST32_MAX,
	INT_FAST16_MIN, INT_FAST32_MIN, INT_FAST16_MAX, INT_FAST32_MAX,
	INTPTR_MIN, INTPTR_MAX, SIZE_MAX):  Fix integer constant suffixes.

    cheers,
      DaveK

--------------000608080306060909070702
Content-Type: text/x-c;
 name="cygwin-gcc-stdint-types-patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin-gcc-stdint-types-patch.diff"
Content-length: 2222

Index: winsup/cygwin/include/stdint.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/stdint.h,v
retrieving revision 1.10
diff -p -u -r1.10 stdint.h
--- winsup/cygwin/include/stdint.h	17 May 2008 21:34:05 -0000	1.10
+++ winsup/cygwin/include/stdint.h	3 Apr 2009 23:07:50 -0000
@@ -80,19 +80,19 @@ typedef unsigned long long uintmax_t;
 
 #define UINT8_MAX (255)
 #define UINT16_MAX (65535)
-#define UINT32_MAX (4294967295UL)
+#define UINT32_MAX (4294967295U)
 #define UINT64_MAX (18446744073709551615ULL)
 
 /* Limits of minimum-width integer types */
 
 #define INT_LEAST8_MIN (-128)
 #define INT_LEAST16_MIN (-32768)
-#define INT_LEAST32_MIN (-2147483647 - 1)
+#define INT_LEAST32_MIN (-2147483647L - 1L)
 #define INT_LEAST64_MIN (-9223372036854775807LL - 1LL)
 
 #define INT_LEAST8_MAX (127)
 #define INT_LEAST16_MAX (32767)
-#define INT_LEAST32_MAX (2147483647)
+#define INT_LEAST32_MAX (2147483647L)
 #define INT_LEAST64_MAX (9223372036854775807LL)
 
 #define UINT_LEAST8_MAX (255)
@@ -103,13 +103,13 @@ typedef unsigned long long uintmax_t;
 /* Limits of fastest minimum-width integer types */
 
 #define INT_FAST8_MIN (-128)
-#define INT_FAST16_MIN (-2147483647 - 1)
-#define INT_FAST32_MIN (-2147483647 - 1)
+#define INT_FAST16_MIN (-2147483647L - 1L)
+#define INT_FAST32_MIN (-2147483647L - 1L)
 #define INT_FAST64_MIN (-9223372036854775807LL - 1LL)
 
 #define INT_FAST8_MAX (127)
-#define INT_FAST16_MAX (2147483647)
-#define INT_FAST32_MAX (2147483647)
+#define INT_FAST16_MAX (2147483647L)
+#define INT_FAST32_MAX (2147483647L)
 #define INT_FAST64_MAX (9223372036854775807LL)
 
 #define UINT_FAST8_MAX (255)
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

--------------000608080306060909070702--
