Return-Path: <cygwin-patches-return-7006-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8278 invoked by alias); 4 Mar 2010 07:46:05 -0000
Received: (qmail 8268 invoked by uid 22791); 4 Mar 2010 07:46:05 -0000
X-SWARE-Spam-Status: No, hits=-3.0 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from out1.smtp.messagingengine.com (HELO out1.smtp.messagingengine.com) (66.111.4.25)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 04 Mar 2010 07:46:00 +0000
Received: from compute1.internal (compute1.internal [10.202.2.41]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id BBAE8E3041 	for <cygwin-patches@cygwin.com>; Thu,  4 Mar 2010 02:45:50 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])   by compute1.internal (MEProxy); Thu, 04 Mar 2010 02:45:50 -0500
Received: from [192.168.1.3] (user-0c6sbd2.cable.mindspring.com [24.110.45.162]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id 147271D697; 	Thu,  4 Mar 2010 02:45:42 -0500 (EST)
Message-ID: <4B8F6524.3060003@cwilson.fastmail.fm>
Date: Thu, 04 Mar 2010 07:46:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Add xdr support
References: <4B764A1F.6060003@cwilson.fastmail.fm>  <4B8D2F9D.4090309@cwilson.fastmail.fm>  <20100302180921.GO5683@calimero.vinschen.de>  <4B8DED87.1080801@cwilson.fastmail.fm>  <20100303091052.GB24732@calimero.vinschen.de>  <4B8E5AD0.9050703@cwilson.fastmail.fm> <20100303150642.GN17293@calimero.vinschen.de> <4B8F212A.3050404@cwilson.fastmail.fm>
In-Reply-To: <4B8F212A.3050404@cwilson.fastmail.fm>
Content-Type: multipart/mixed;  boundary="------------010508080904070600080501"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q1/txt/msg00122.txt.bz2

This is a multi-part message in MIME format.
--------------010508080904070600080501
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 558

Charles Wilson wrote:
> I'm testing a patch now; will post later.

2010-03-04  Charles Wilson  <...>

	* cygwin.din: Export __xdr functions.
	* include/cygwin/version.h: Bump version.
	* posix.sgml: Add a few more XDR functions to list
	of implemented Solaris functions.

With this, I can build libtirpc -- and then build a working RPC
client/server (*).

(*) Okay, I only tested the client on cygwin, talking to a server on
linux; to go the other way I also have to port rpcbind...and figure out
how to get it to run as a service, etc etc etc...

--
Chuck


--------------010508080904070600080501
Content-Type: text/x-patch;
 name="xdr-more-exports.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="xdr-more-exports.patch"
Content-length: 1816

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.221
diff -u -p -r1.221 cygwin.din
--- cygwin.din	3 Mar 2010 15:05:18 -0000	1.221
+++ cygwin.din	4 Mar 2010 07:41:08 -0000
@@ -1861,6 +1861,8 @@ xdrrec_create SIGFE
 xdrrec_endofrecord SIGFE
 xdrrec_eof SIGFE
 xdrrec_skiprecord SIGFE
+__xdrrec_getrec SIGFE
+__xdrrec_setnonblock SIGFE
 xdrstdio_create SIGFE
 y0 NOSIGFE
 y0f NOSIGFE
Index: posix.sgml
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/posix.sgml,v
retrieving revision 1.44
diff -u -p -r1.44 posix.sgml
--- posix.sgml	3 Mar 2010 15:05:19 -0000	1.44
+++ posix.sgml	4 Mar 2010 07:41:08 -0000
@@ -1124,6 +1124,8 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008)
     xdrrec_endofrecord
     xdrrec_eof
     xdrrec_skiprecord
+    __xdrrec_getrec
+    __xdrrec_setnonblock
     xdrstdio_create
 </screen>
 
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.311
diff -u -p -r1.311 version.h
--- include/cygwin/version.h	3 Mar 2010 15:05:19 -0000	1.311
+++ include/cygwin/version.h	4 Mar 2010 07:41:08 -0000
@@ -378,12 +378,13 @@ details. */
       222: CW_INT_SETLOCALE added.
       223: SIGPWR added.
       224: Export xdr* functions.
+      225: Export __xdr* functions.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 224
+#define CYGWIN_VERSION_API_MINOR 225
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible

--------------010508080904070600080501--
