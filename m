Return-Path: <cygwin-patches-return-6490-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15766 invoked by alias); 7 Apr 2009 13:15:55 -0000
Received: (qmail 15754 invoked by uid 22791); 7 Apr 2009 13:15:52 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 07 Apr 2009 13:15:45 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 8E3826D5521; Tue,  7 Apr 2009 15:15:34 +0200 (CEST)
Date: Tue, 07 Apr 2009 13:15:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix type inconsistencies in stdint.h
Message-ID: <20090407131534.GY852@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <49D6B8D7.4020907@gmail.com> <20090404033545.GA3386@ednor.casa.cgf.cx> <49D6DDDD.4030504@gmail.com> <20090404062459.GB22452@ednor.casa.cgf.cx> <49DB4D95.7000903@byu.net> <49DB4FC4.7020903@cwilson.fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49DB4FC4.7020903@cwilson.fastmail.fm>
User-Agent: Mutt/1.5.19 (2009-02-20)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q2/txt/msg00032.txt.bz2

On Apr  7 09:06, Charles Wilson wrote:
> Eric Blake wrote:
> > Making the ABI change now (which
> > probably won't affect C apps, but will definitely affect any C++ code that
> > used uint32_t and friends in mangled names) 
> >
> > But I'm with Dave that IF we decide
> > the ABI change is the right thing to do, then NOW is the only time worth
> > doing it.
> 
> Especially as the transition to
> gcc4/dw2-eh/shared-libgcc/shared-libstdc++/--enable-fully-dynamic-string
> is *definitely* an ABI break for C++, anyway.

Good point, I guess.  So, if we all agree on that, I'd suggest to
change Dave's patch to the one below.


Corinna


	* include/stdint.h (int_least32_t): Define as int.
	(uint_least32_t): Ditto, unsigned.
	(int_fast16_t): Define as int.
	(int_fast32_t): Ditto.
	(uint_fast16_t): Ditto, unsigned.
	(uint_fast32_t): Ditto.
	(UINT32_MAX): Remove `L' long marker.
	(UINT_LEAST32_MAX): Ditto.
	(UINT_FAST16_MAX): Ditto.
	(UINT_FAST32_MAX): Ditto.
	(INT32_C): Ditto.
	(UINT32_C): Ditto.


Index: include/stdint.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/stdint.h,v
retrieving revision 1.10
diff -u -p -r1.10 stdint.h
--- include/stdint.h	17 May 2008 21:34:05 -0000	1.10
+++ include/stdint.h	7 Apr 2009 13:12:48 -0000
@@ -33,24 +33,24 @@ typedef unsigned long long uint64_t;
 
 typedef signed char int_least8_t;
 typedef short int_least16_t;
-typedef long int_least32_t;
+typedef int int_least32_t;
 typedef long long int_least64_t;
 
 typedef unsigned char uint_least8_t;
 typedef unsigned short uint_least16_t;
-typedef unsigned long uint_least32_t;
+typedef unsigned int uint_least32_t;
 typedef unsigned long long uint_least64_t;
 
 /* Fastest minimum-width integer types */
 
 typedef signed char int_fast8_t;
-typedef long int_fast16_t;
-typedef long int_fast32_t;
+typedef int int_fast16_t;
+typedef int int_fast32_t;
 typedef long long int_fast64_t;
 
 typedef unsigned char uint_fast8_t;
-typedef unsigned long uint_fast16_t;
-typedef unsigned long uint_fast32_t;
+typedef unsigned int uint_fast16_t;
+typedef unsigned int uint_fast32_t;
 typedef unsigned long long uint_fast64_t;
 
 /* Integer types capable of holding object pointers */
@@ -80,7 +80,7 @@ typedef unsigned long long uintmax_t;
 
 #define UINT8_MAX (255)
 #define UINT16_MAX (65535)
-#define UINT32_MAX (4294967295UL)
+#define UINT32_MAX (4294967295U)
 #define UINT64_MAX (18446744073709551615ULL)
 
 /* Limits of minimum-width integer types */
@@ -97,7 +97,7 @@ typedef unsigned long long uintmax_t;
 
 #define UINT_LEAST8_MAX (255)
 #define UINT_LEAST16_MAX (65535)
-#define UINT_LEAST32_MAX (4294967295UL)
+#define UINT_LEAST32_MAX (4294967295U)
 #define UINT_LEAST64_MAX (18446744073709551615ULL)
 
 /* Limits of fastest minimum-width integer types */
@@ -113,8 +113,8 @@ typedef unsigned long long uintmax_t;
 #define INT_FAST64_MAX (9223372036854775807LL)
 
 #define UINT_FAST8_MAX (255)
-#define UINT_FAST16_MAX (4294967295UL)
-#define UINT_FAST32_MAX (4294967295UL)
+#define UINT_FAST16_MAX (4294967295U)
+#define UINT_FAST32_MAX (4294967295U)
 #define UINT_FAST64_MAX (18446744073709551615ULL)
 
 /* Limits of integer types capable of holding object pointers */
@@ -166,12 +166,12 @@ typedef unsigned long long uintmax_t;
 
 #define INT8_C(x) x
 #define INT16_C(x) x
-#define INT32_C(x) x ## L
+#define INT32_C(x) x
 #define INT64_C(x) x ## LL
 
 #define UINT8_C(x) x
 #define UINT16_C(x) x
-#define UINT32_C(x) x ## UL
+#define UINT32_C(x) x ## U
 #define UINT64_C(x) x ## ULL
 
 /* Macros for greatest-width integer constant expressions */

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
