Return-Path: <cygwin-patches-return-4043-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8999 invoked by alias); 7 Aug 2003 19:27:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8990 invoked from network); 7 Aug 2003 19:27:16 -0000
Message-ID: <3F32A747.4070106@netscape.net>
Date: Thu, 07 Aug 2003 19:27:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH]: Add some interoperability macros to sys/param.h
X-Enigmail-Version: 0.76.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030007010206090001020902"
X-AOL-IP: 130.127.121.187
X-SW-Source: 2003-q3/txt/msg00059.txt.bz2


--------------030007010206090001020902
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 980

Hi,

This patch adds 11 new macros to Cygwin's sys/param.h.  They include:

setbit(a,i)
clrbit(a,i)
isset(a,i)
isclr(a,i)
howmany(x, y)
rounddown(x, y)
roundup(x, y)
roundup2(x, y)
powerof2(x)
MIN(a,b)
MAX(a,b)

I find some to be very useful for many mundane routines (esp. MIN/MAX). 
  It should be noted that I chose to add all 11 of them (as opposed to 
just the ones I use) because this subset of macros seems to be common 
across all *bsd and linux distributions.  In doing so we improve our 
interoperability and make porting easier.  Although I "peeked" at the 
param.h header on my linux box to see if they were all defined, the 
macros I used were copied verbatim from the freebsd cvs 
src/sys/sys/param.h.  Furthermore, I didn't actually check the 
definition expression in the linux header, so I feel confident that I 
have violated no licenses.  I have an assignment pending, but I was 
hoping this change would be small enough to go in before then.

Cheers,
Nicholas

--------------030007010206090001020902
Content-Type: text/plain;
 name="Changelog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Changelog.txt"
Content-length: 424

2003-08-07  Nicholas Wourms  <nwourms@netscape.net>

    * include/sys/param.h (setbit): Add new bitmap related macro.
    (clrbit): Likewise.
    (isset): Likewise.
    (isclr): Likewise.
    (howmany): Add new counting/rounding macro.
    (rounddown): Likewise.
    (roundup): Likewise.
    (roundup2): Likewise.
    (powerof2): Likewise
    (MIN): Add macro for calculating min.
    (MAX): Add macro for calculating max.

--------------030007010206090001020902
Content-Type: text/plain;
 name="param_h-add-macros.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="param_h-add-macros.patch"
Content-length: 1138

Index: cygwin/include/sys/param.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/sys/param.h,v
retrieving revision 1.2
diff -u -3 -p -r1.2 param.h
--- cygwin/include/sys/param.h  30 May 2003 08:39:02 -0000  1.2
+++ cygwin/include/sys/param.h  7 Aug 2003 17:03:14 -0000
@@ -53,4 +53,23 @@
 #define NULL            0L
 #endif
 
+/* Bit map related macros. */
+#define    setbit(a,i) ((a)[(i)/NBBY] |= 1<<((i)%NBBY))
+#define    clrbit(a,i) ((a)[(i)/NBBY] &= ~(1<<((i)%NBBY)))
+#define    isset(a,i)  ((a)[(i)/NBBY] & (1<<((i)%NBBY)))
+#define    isclr(a,i)  (((a)[(i)/NBBY] & (1<<((i)%NBBY))) == 0)
+
+/* Macros for counting and rounding. */
+#ifndef howmany
+#define    howmany(x, y)   (((x)+((y)-1))/(y))
+#endif
+#define    rounddown(x, y) (((x)/(y))*(y))
+#define    roundup(x, y)   ((((x)+((y)-1))/(y))*(y))  /* to any y */
+#define    roundup2(x, y)  (((x)+((y)-1))&(~((y)-1))) /* if y is powers of two */
+#define powerof2(x)    ((((x)-1)&(x))==0)
+
+/* Macros for min/max. */
+#define    MIN(a,b)    (((a)<(b))?(a):(b))
+#define    MAX(a,b)    (((a)>(b))?(a):(b))
+

--------------030007010206090001020902--
