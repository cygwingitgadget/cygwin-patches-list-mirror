Return-Path: <cygwin-patches-return-3088-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 26024 invoked by alias); 28 Oct 2002 06:58:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25950 invoked from network); 28 Oct 2002 06:58:34 -0000
Message-ID: <3DBCDFA6.5070905@netstd.com>
Date: Sun, 27 Oct 2002 22:58:00 -0000
From: Wu Yongwei <adah@netstd.com>
Organization: Kingnet Security, Inc.
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en, en-us, zh-cn, zh
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Make ip.h and tcp.h work under -fnative-struct or -fms-bitfields
Content-Type: multipart/mixed;
 boundary="------------080806020900080200000009"
X-SW-Source: 2002-q4/txt/msg00039.txt.bz2

This is a multi-part message in MIME format.
--------------080806020900080200000009
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 578

These header files use "u_int xxx:4, yyy:4", which in the MS convetion
will generate 4-byte instead of 1-byte bit fields.

A trivial alignment problem owing to my previous slip is also corrected.

Sorry that it is inconvenient for me to diff against CVS. But I use only
one diff file so it should be no problem.

Best regards,

Wu Yongwei

----------

ChangeLog:

2002-10-28  Wu Yongwei <adah@netstd.com>

	* ip.h (struct ip): Use u_char to indicate bitfields to make it
	work with -fnative-struct/-fms-bitfields.
	(struct ip_timestamp): Ditto.
	* tcp.h (struct tcphdr): Ditto.

--------------080806020900080200000009
Content-Type: text/plain;
 name="netinet.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="netinet.diff"
Content-length: 2331

diff -u -r netinet.orig/ip.h netinet/ip.h
--- netinet.orig/ip.h	2002-07-06 14:19:02.000000000 +0800
+++ netinet/ip.h	2002-10-26 16:58:01.000000000 +0800
@@ -60,11 +60,11 @@
         u_char  ip_vhl;                 /* version << 4 | header length >> 2 */
 #else
 #if BYTE_ORDER == LITTLE_ENDIAN
-        u_int   ip_hl:4,                /* header length */
+        u_char  ip_hl:4,                /* header length */
                 ip_v:4;                 /* version */
 #endif
 #if BYTE_ORDER == BIG_ENDIAN
-        u_int   ip_v:4,                 /* version */
+        u_char  ip_v:4,                 /* version */
                 ip_hl:4;                /* header length */
 #endif
 #endif /* not _IP_VHL */
@@ -156,11 +156,11 @@
         u_char  ipt_len;                /* size of structure (variable) */
         u_char  ipt_ptr;                /* index of current entry */
 #if BYTE_ORDER == LITTLE_ENDIAN
-        u_int   ipt_flg:4,              /* flags, see below */
+        u_char  ipt_flg:4,              /* flags, see below */
                 ipt_oflw:4;             /* overflow counter */
 #endif
 #if BYTE_ORDER == BIG_ENDIAN
-        u_int   ipt_oflw:4,             /* overflow counter */
+        u_char  ipt_oflw:4,             /* overflow counter */
                 ipt_flg:4;              /* flags, see below */
 #endif
         union ipt_timestamp {
diff -u -r netinet.orig/tcp.h netinet/tcp.h
--- netinet.orig/tcp.h	2002-07-06 14:19:04.000000000 +0800
+++ netinet/tcp.h	2002-10-26 16:58:39.000000000 +0800
@@ -43,7 +43,7 @@
 #define BIG_ENDIAN      4321
 #endif
 #ifndef BYTE_ORDER
-#define BYTE_ORDER     LITTLE_ENDIAN
+#define BYTE_ORDER      LITTLE_ENDIAN
 #endif
 
 typedef u_int32_t tcp_seq;
@@ -62,11 +62,11 @@
         tcp_seq th_seq;                 /* sequence number */
         tcp_seq th_ack;                 /* acknowledgement number */
 #if BYTE_ORDER == LITTLE_ENDIAN
-        u_int   th_x2:4,                /* (unused) */
+        u_char  th_x2:4,                /* (unused) */
                 th_off:4;               /* data offset */
 #endif
 #if BYTE_ORDER == BIG_ENDIAN
-        u_int   th_off:4,               /* data offset */
+        u_char  th_off:4,               /* data offset */
                 th_x2:4;                /* (unused) */
 #endif
         u_char  th_flags;




--------------080806020900080200000009--

