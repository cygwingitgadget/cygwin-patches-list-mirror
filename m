Return-Path: <cygwin-patches-return-4318-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2475 invoked by alias); 28 Oct 2003 21:59:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2466 invoked from network); 28 Oct 2003 21:59:35 -0000
Message-ID: <20031028215934.31453.qmail@web21409.mail.yahoo.com>
Date: Tue, 28 Oct 2003 21:59:00 -0000
From: =?iso-8859-1?q?Danny=20Smith?= <danny_r_smith_2001@yahoo.co.nz>
Subject: More stdint.h teaks
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SW-Source: 2003-q4/txt/msg00037.txt.bz2

Hello

This gets rid of signed->unsigned warnings

Changelog

2003-10-29  Danny Smith  <dannysmith@users.sourceforege.net>

	include/stdint.h: Prevent signed->unsigned conversion
	for 32 and 64 bit min value constants.

  
*** stdint.h.orig	Tue Oct 28 16:03:52 2003
--- stdint.h	Tue Oct 28 21:45:37 2003
*************** typedef unsigned long long uintmax_t;
*** 70,77 ****
  
  #define INT8_MIN (-128)
  #define INT16_MIN (-32768)
! #define INT32_MIN (-2147483647-1)
! #define INT64_MIN (-9223372036854775808LL)
  
  #define INT8_MAX (127)
  #define INT16_MAX (32767)
--- 70,77 ----
  
  #define INT8_MIN (-128)
  #define INT16_MIN (-32768)
! #define INT32_MIN (-2147483647 - 1)
! #define INT64_MIN (-9223372036854775807LL - 1LL)
  
  #define INT8_MAX (127)
  #define INT16_MAX (32767)
*************** typedef unsigned long long uintmax_t;
*** 87,94 ****
  
  #define INT_LEAST8_MIN (-128)
  #define INT_LEAST16_MIN (-32768)
! #define INT_LEAST32_MIN (-2147483648)
! #define INT_LEAST64_MIN (-9223372036854775808LL)
  
  #define INT_LEAST8_MAX (127)
  #define INT_LEAST16_MAX (32767)
--- 87,94 ----
  
  #define INT_LEAST8_MIN (-128)
  #define INT_LEAST16_MIN (-32768)
! #define INT_LEAST32_MIN (-2147483647 - 1)
! #define INT_LEAST64_MIN (-9223372036854775807LL - 1LL)
  
  #define INT_LEAST8_MAX (127)
  #define INT_LEAST16_MAX (32767)
*************** typedef unsigned long long uintmax_t;
*** 103,111 ****
  /* Limits of fastest minimum-width integer types */
  
  #define INT_FAST8_MIN (-128)
! #define INT_FAST16_MIN (-2147483648)
! #define INT_FAST32_MIN (-2147483648)
! #define INT_FAST64_MIN (-9223372036854775808LL)
  
  #define INT_FAST8_MAX (127)
  #define INT_FAST16_MAX (2147483647)
--- 103,111 ----
  /* Limits of fastest minimum-width integer types */
  
  #define INT_FAST8_MIN (-128)
! #define INT_FAST16_MIN (-2147483647 - 1)
! #define INT_FAST32_MIN (-2147483647 - 1)
! #define INT_FAST64_MIN (-9223372036854775807LL - 1LL)
  
  #define INT_FAST8_MAX (127)
  #define INT_FAST16_MAX (2147483647)
*************** typedef unsigned long long uintmax_t;
*** 119,143 ****
  
  /* Limits of integer types capable of holding object pointers */
  
! #define INTPTR_MIN (-2147483648)
  #define INTPTR_MAX (2147483647)
  #define UINTPTR_MAX (4294967295UL)
  
  /* Limits of greatest-width integer types */
  
! #define INTMAX_MIN (-9223372036854775808)
! #define INTMAX_MAX (9223372036854775807)
  #define UINTMAX_MAX (18446744073709551615ULL)
  
  /* Limits of other integer types */
  
  #ifndef PTRDIFF_MIN
! #define PTRDIFF_MIN (-2147483648)
  #define PTRDIFF_MAX (2147483647)
  #endif
  
  #ifndef SIG_ATOMIC_MIN
! #define SIG_ATOMIC_MIN (-2147483648)
  #endif
  #ifndef SIG_ATOMIC_MAX
  #define SIG_ATOMIC_MAX (2147483647)
--- 119,143 ----
  
  /* Limits of integer types capable of holding object pointers */
  
! #define INTPTR_MIN (-2147483647 - 1)
  #define INTPTR_MAX (2147483647)
  #define UINTPTR_MAX (4294967295UL)
  
  /* Limits of greatest-width integer types */
  
! #define INTMAX_MIN (-9223372036854775807LL - 1LL)
! #define INTMAX_MAX (9223372036854775807LL)
  #define UINTMAX_MAX (18446744073709551615ULL)
  
  /* Limits of other integer types */
  
  #ifndef PTRDIFF_MIN
! #define PTRDIFF_MIN (-2147483647 - 1)
  #define PTRDIFF_MAX (2147483647)
  #endif
  
  #ifndef SIG_ATOMIC_MIN
! #define SIG_ATOMIC_MIN (-2147483647 - 1)
  #endif
  #ifndef SIG_ATOMIC_MAX
  #define SIG_ATOMIC_MAX (2147483647)
*************** typedef unsigned long long uintmax_t;
*** 158,164 ****
  #endif
  
  #ifndef WINT_MIN
! #define WINT_MIN (-2147483648)
  #define WINT_MAX (2147483647)
  #endif
  
--- 158,164 ----
  #endif
  
  #ifndef WINT_MIN
! #define WINT_MIN (-2147483647 - 1)
  #define WINT_MAX (2147483647)
  #endif
  

http://personals.yahoo.com.au - Yahoo! Personals
New people, new possibilities. FREE for a limited time.
