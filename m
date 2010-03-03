Return-Path: <cygwin-patches-return-7003-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2471 invoked by alias); 3 Mar 2010 12:49:57 -0000
Received: (qmail 2391 invoked by uid 22791); 3 Mar 2010 12:49:56 -0000
X-SWARE-Spam-Status: No, hits=-2.9 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from out1.smtp.messagingengine.com (HELO out1.smtp.messagingengine.com) (66.111.4.25)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 03 Mar 2010 12:49:51 +0000
Received: from compute2.internal (compute2.internal [10.202.2.42]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id 2C99EE35C4 	for <cygwin-patches@cygwin.com>; Wed,  3 Mar 2010 07:49:50 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])   by compute2.internal (MEProxy); Wed, 03 Mar 2010 07:49:50 -0500
Received: from [192.168.1.3] (user-0c6sbd2.cable.mindspring.com [24.110.45.162]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id A8C0549F2CD; 	Wed,  3 Mar 2010 07:49:49 -0500 (EST)
Message-ID: <4B8E5AD0.9050703@cwilson.fastmail.fm>
Date: Wed, 03 Mar 2010 12:49:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Add xdr support
References: <4B764A1F.6060003@cwilson.fastmail.fm>  <4B8D2F9D.4090309@cwilson.fastmail.fm>  <20100302180921.GO5683@calimero.vinschen.de>  <4B8DED87.1080801@cwilson.fastmail.fm> <20100303091052.GB24732@calimero.vinschen.de>
In-Reply-To: <20100303091052.GB24732@calimero.vinschen.de>
Content-Type: multipart/mixed;  boundary="------------080405000707020307080200"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q1/txt/msg00119.txt.bz2

This is a multi-part message in MIME format.
--------------080405000707020307080200
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 1268

Corinna Vinschen wrote:
> On Mar  3 00:03, Charles Wilson wrote:
>> But it ain't posix, so...should it really go in posix.sgml?
> 
> Yes!  The filename posix.sgml is just historical, it could be better
> named api.sgml, I guess, but here we are.  Have a look, it contains
> various chapters with all APIs which follow some lead, SUSv4, BSD,
> Linux, Solaris, deprecated or "other".  In case of the XDR calls, they
> should probably go into the Solaris section, unless you think they fit
> better in one of the other sections.

OK:

2010-03-03  Charles Wilson  <...>

        * posix.sgml: Add xdr_array, xdr_bool, xdr_bytes, xdr_char,
	xdr_double, xdr_enum, xdr_float, xdr_free, xdr_hyper, xdr_int,
	xdr_int16_t, xdr_int32_t, xdr_int64_t, xdr_int8_t, xdr_long,
	xdr_longlong_t, xdr_netobj, xdr_opaque, xdr_pointer,
	xdr_reference, xdr_short, xdr_sizeof, xdr_string, xdr_u_char,
	xdr_u_hyper, xdr_u_int, xdr_u_int16_t, xdr_u_int32_t,
	xdr_u_int64_t, xdr_u_int8_t, xdr_u_long, xdr_u_longlong_t,
	xdr_u_short, xdr_uint16_t, xdr_uint32_t, xdr_uint64_t,
	xdr_uint8_t, xdr_union, xdr_vector, xdr_void, xdr_wrapstring,
	xdrmem_create, xdrrec_create, xdrrec_endofrecord, xdrrec_eof,
	xdrrec_skiprecord, and xdrstdio_create to list of implemented
	Solaris functions.

--
Chuck

--------------080405000707020307080200
Content-Type: text/x-patch;
 name="xdr-doc-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="xdr-doc-2.patch"
Content-length: 1206

Index: posix.sgml
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/posix.sgml,v
retrieving revision 1.43
diff -u -p -r1.43 posix.sgml
--- posix.sgml	22 Jan 2010 22:33:22 -0000	1.43
+++ posix.sgml	3 Mar 2010 12:41:28 -0000
@@ -1078,6 +1078,53 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008)
     getmntent
     memalign
     setmntent
+    xdr_array
+    xdr_bool
+    xdr_bytes
+    xdr_char
+    xdr_double
+    xdr_enum
+    xdr_float
+    xdr_free
+    xdr_hyper
+    xdr_int
+    xdr_int16_t
+    xdr_int32_t
+    xdr_int64_t
+    xdr_int8_t
+    xdr_long
+    xdr_longlong_t
+    xdr_netobj
+    xdr_opaque
+    xdr_pointer
+    xdr_reference
+    xdr_short
+    xdr_sizeof
+    xdr_string
+    xdr_u_char
+    xdr_u_hyper
+    xdr_u_int
+    xdr_u_int16_t
+    xdr_u_int32_t
+    xdr_u_int64_t
+    xdr_u_int8_t
+    xdr_u_long
+    xdr_u_longlong_t
+    xdr_u_short
+    xdr_uint16_t
+    xdr_uint32_t
+    xdr_uint64_t
+    xdr_uint8_t
+    xdr_union
+    xdr_vector
+    xdr_void
+    xdr_wrapstring
+    xdrmem_create
+    xdrrec_create
+    xdrrec_endofrecord
+    xdrrec_eof
+    xdrrec_skiprecord
+    xdrstdio_create
 </screen>
 
 </sect1>

--------------080405000707020307080200--
