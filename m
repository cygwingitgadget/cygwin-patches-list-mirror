Return-Path: <cygwin-patches-return-6460-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14040 invoked by alias); 3 Apr 2009 03:11:13 -0000
Received: (qmail 14028 invoked by uid 22791); 3 Apr 2009 03:11:12 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from qw-out-1920.google.com (HELO qw-out-1920.google.com) (74.125.92.150)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 03 Apr 2009 03:11:06 +0000
Received: by qw-out-1920.google.com with SMTP id 9so659429qwj.20         for <cygwin-patches@cygwin.com>; Thu, 02 Apr 2009 20:11:04 -0700 (PDT)
Received: by 10.224.73.205 with SMTP id r13mr1001176qaj.315.1238728264330;         Thu, 02 Apr 2009 20:11:04 -0700 (PDT)
Received: from ?192.168.0.101? (S010600112f237275.wp.shawcable.net [24.76.253.194])         by mx.google.com with ESMTPS id 6sm1883506qwk.27.2009.04.02.20.11.03         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Thu, 02 Apr 2009 20:11:03 -0700 (PDT)
Message-ID: <49D57E45.4000409@users.sourceforge.net>
Date: Fri, 03 Apr 2009 03:11:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] <asm/byteorder.h> missing prototypes warning
Content-Type: multipart/mixed;  boundary="------------060205030401000404010204"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q2/txt/msg00002.txt.bz2

This is a multi-part message in MIME format.
--------------060205030401000404010204
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 857

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

This is similar in concept to the <stdio.h> patch I just posted to
newlib@.  It looks like I mistakenly removed the prototypes when I was
trying to fix the C99 inline issue in <asm/byteorder.h>.

Since this makes four lines which need the C99 inline workaround, I
decided to make a macro similar to that in <stdio.h>.  I didn't use the
same macro name, since I didn't want to deal with a possible collision
with, or dependency on, <stdio.h>.  Perhaps there is a better way of
dealing with this; I'm certainly open to ideas.

Patch attached.


Yaakov

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEAREIAAYFAknVfjsACgkQpiWmPGlmQSPH/gCgoxK1UgezIcUwFH3EHc0+rHRB
C14AnRZ2yQhc6uwvJbcQ98hUSxnxP38X
=8YGC
-----END PGP SIGNATURE-----

--------------060205030401000404010204
Content-Type: text/x-patch;
 name="cygwin-asm_byteorder.h-Wmissing-prototypes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin-asm_byteorder.h-Wmissing-prototypes.patch"
Content-length: 1302

2009-04-02  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* include/asm/byteorder.h (__ntohl, __ntohs): Prototype before
	define to avoid a warning with -Wmissing-prototypes.

Index: cygwin/include/asm/byteorder.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/asm/byteorder.h,v
retrieving revision 1.11
diff -u -r1.11 byteorder.h
--- include/asm/byteorder.h	26 Mar 2009 10:40:29 -0000	1.11
+++ include/asm/byteorder.h	3 Apr 2009 01:48:34 -0000
@@ -31,9 +31,15 @@
 extern uint16_t	htons(uint16_t);
 
 #if defined(__GNUC__) && !defined(__GNUC_STDC_INLINE__)
-extern
+#define __ASM_BYTEORDER_INLINE extern __inline__
+#else
+#define __ASM_BYTEORDER_INLINE __inline__
 #endif
-__inline__ uint32_t
+
+__ASM_BYTEORDER_INLINE uint32_t __ntohl(uint32_t x);
+__ASM_BYTEORDER_INLINE uint16_t __ntohs(uint16_t x);
+
+__ASM_BYTEORDER_INLINE uint32_t
 __ntohl(uint32_t x)
 {
 	__asm__("xchgb %b0,%h0\n\t"	/* swap lower bytes	*/
@@ -50,10 +56,7 @@
 		   (((uint32_t)(x) & 0x00ff0000U) >>  8) | \
 		   (((uint32_t)(x) & 0xff000000U) >> 24)))
 
-#if defined(__GNUC__) && !defined(__GNUC_STDC_INLINE__)
-extern
-#endif
-__inline__ uint16_t
+__ASM_BYTEORDER_INLINE uint16_t
 __ntohs(uint16_t x)
 {
 	__asm__("xchgb %b0,%h0"		/* swap bytes		*/

--------------060205030401000404010204--
