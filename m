Return-Path: <cygwin-patches-return-7749-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23377 invoked by alias); 24 Oct 2012 09:17:05 -0000
Received: (qmail 23367 invoked by uid 22791); 24 Oct 2012 09:17:04 -0000
X-SWARE-Spam-Status: No, hits=-3.5 required=5.0	tests=AWL,BAYES_00,DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,KHOP_RCVD_TRUST,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE,TW_JN,TW_OV
X-Spam-Check-By: sourceware.org
Received: from mail-wg0-f45.google.com (HELO mail-wg0-f45.google.com) (74.125.82.45)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 24 Oct 2012 09:17:00 +0000
Received: by mail-wg0-f45.google.com with SMTP id dq12so182171wgb.2        for <cygwin-patches@cygwin.com>; Wed, 24 Oct 2012 02:16:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.216.45.144 with SMTP id p16mr9377899web.170.1351070218738; Wed, 24 Oct 2012 02:16:58 -0700 (PDT)
Received: by 10.216.24.147 with HTTP; Wed, 24 Oct 2012 02:16:58 -0700 (PDT)
Date: Wed, 24 Oct 2012 09:17:00 -0000
Message-ID: <CAEwic4ZiqULxgATmLT02tvyGM+c=0AOdtvGePggJrWh4dUqEYw@mail.gmail.com>
Subject: [patch cygwin]: Replace inline-assembler in string.h by C implementation
From: Kai Tietz <ktietz70@googlemail.com>
To: cygwin-patches@cygwin.com
Cc: Corinna Vinschen <corinna@vinschen.de>
Content-Type: text/plain; charset=ISO-8859-1
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
X-SW-Source: 2012-q4/txt/msg00026.txt.bz2

Hello,

this patch replaces the inline-assember used in string.h by C implementation.
There are three reasons why I want to suggest this.  First, the C-code might
be optimized further by fixed (constant) arguments.  Secondly, it is
architecture
independent and so we just need to maintain on code-path.  And as
third point, by
inspecting generated assembly code produced by compiler out of C code
vs. inline-assembler
it shows that compiler produces better code.  It handles
jump-threading better, and also
improves average executed instructions.

ChangeLog

2012-10-24  Kai Tietz

	* string.h (strechr): Replace assembler by
	C code.
	(ascii_strcasematch): Likewise.
	(ascii_strncasematch): Likwise.

Ok for apply?

Regards,
Kai

Index: string.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/string.h,v
retrieving revision 1.14
diff -p -u -r1.14 string.h
--- string.h	19 Jan 2011 09:41:54 -0000	1.14
+++ string.h	24 Oct 2012 09:10:27 -0000
@@ -22,20 +22,9 @@ extern "C" {
 static inline __stdcall char *
 strechr (const char *s, int c)
 {
-  register char * res;
-  __asm__ __volatile__ ("\
-	movb	%%al,%%ah\n\
-1:	movb	(%1),%%al\n\
-	cmpb	%%ah,%%al\n\
-	je	2f\n\
-	incl	%1\n\
-	testb	%%al,%%al\n\
-	jne	1b\n\
-	decl	%1\n\
-2:	movl	%1,%0\n\
-	":"=a" (res), "=r" (s)
-	:"0" (c), "1" (s));
-  return res;
+  while (*s != (char) c && *s != 0)
+    ++s;
+  return (char *) s;
 }

 #ifdef __INSIDE_CYGWIN__
@@ -45,57 +34,38 @@ extern const char isalpha_array[];
 static inline int
 ascii_strcasematch (const char *cs, const char *ct)
 {
-  register int __res;
-  int d0, d1;
-  __asm__ ("\
-	.global	_isalpha_array			\n\
-	cld					\n\
-	andl	$0xff,%%eax			\n\
-1:	lodsb					\n\
-	scasb					\n\
-	je	2f				\n\
-	xorb	_isalpha_array(%%eax),%%al	\n\
-	cmpb	-1(%%edi),%%al			\n\
-	jne	3f				\n\
-2:	testb	%%al,%%al			\n\
-	jnz	1b				\n\
-	movl	$1,%%eax			\n\
-	jmp	4f				\n\
-3:	xor	%0,%0				\n\
-4:"
-	:"=a" (__res), "=&S" (d0), "=&D" (d1)
-		     : "1" (cs),   "2" (ct));
+  register const unsigned char *us, *ut;

-  return __res;
+  us = (const unsigned char *) cs;
+  ut = (const unsigned char *) ct;
+
+  while (us[0] == ut[0] || (us[0] ^ isalpha_array[us[0]]) == ut[0])
+    {
+      if (us[0] == 0)
+	return 1;
+      ++us, ++ut;
+    }
+  return 0;
 }

 static inline int
 ascii_strncasematch (const char *cs, const char *ct, size_t n)
 {
-  register int __res;
-  int d0, d1, d2;
-  __asm__ ("\
-	.global	_isalpha_array;			\n\
-	cld					\n\
-	andl	$0xff,%%eax			\n\
-1:	decl	%3				\n\
-	js	3f				\n\
-	lodsb					\n\
-	scasb					\n\
-	je	2f				\n\
-	xorb	_isalpha_array(%%eax),%%al	\n\
-	cmpb	-1(%%edi),%%al			\n\
-	jne	4f				\n\
-2:	testb	%%al,%%al			\n\
-	jnz	1b				\n\
-3:	movl	$1,%%eax			\n\
-	jmp	5f				\n\
-4:	xor	%0,%0				\n\
-5:"
-	:"=a" (__res), "=&S" (d0), "=&D" (d1), "=&c" (d2)
-		       :"1" (cs),  "2" (ct), "3" (n));
+  register const unsigned char *us, *ut;

-  return __res;
+  if (!n)
+   return 1;
+  us = (const unsigned char *) cs;
+  ut = (const unsigned char *) ct;
+
+  while (us[0] == ut[0] || (us[0] ^ isalpha_array[us[0]]) == ut[0])
+    {
+      --n;
+      if (!n || us[0] == 0)
+        return 1;
+      ++us, ++ut;
+    }
+  return 0;
 }

 #undef strcasecmp
