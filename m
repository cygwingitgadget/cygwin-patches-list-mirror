Return-Path: <cygwin-patches-return-7001-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17305 invoked by alias); 3 Mar 2010 05:03:39 -0000
Received: (qmail 17105 invoked by uid 22791); 3 Mar 2010 05:03:37 -0000
X-SWARE-Spam-Status: No, hits=-2.9 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from out1.smtp.messagingengine.com (HELO out1.smtp.messagingengine.com) (66.111.4.25)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 03 Mar 2010 05:03:32 +0000
Received: from compute1.internal (compute1 [10.202.2.41]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id 53F64E2FE4 	for <cygwin-patches@cygwin.com>; Wed,  3 Mar 2010 00:03:31 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])   by compute1.internal (MEProxy); Wed, 03 Mar 2010 00:03:31 -0500
Received: from [192.168.1.3] (user-0c6sbd2.cable.mindspring.com [24.110.45.162]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id E9F0149F7E2; 	Wed,  3 Mar 2010 00:03:30 -0500 (EST)
Message-ID: <4B8DED87.1080801@cwilson.fastmail.fm>
Date: Wed, 03 Mar 2010 05:03:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Add xdr support
References: <4B764A1F.6060003@cwilson.fastmail.fm>  <4B8D2F9D.4090309@cwilson.fastmail.fm> <20100302180921.GO5683@calimero.vinschen.de>
In-Reply-To: <20100302180921.GO5683@calimero.vinschen.de>
Content-Type: multipart/mixed;  boundary="------------020202010300030407020307"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q1/txt/msg00117.txt.bz2

This is a multi-part message in MIME format.
--------------020202010300030407020307
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 1342

Corinna Vinschen wrote:
> ...and I would *love* to apply the patches, but unfortunately there's a
> serious, VERY serious problem with this patch.
> 
> The patch is missing the related changes to cygwin/posix.sgml and
> doc/new-features.sgml.
> 
> Would you mind to send a second patch for the documentation?

Well, for new-features, no problem; attached.

However, the xdr functions are defined by neither SuSv4 nor POSIX,
AFAICT.  They are defined by (variously) RFCs 1014 [1], 1832 [2], and
4506 [3], SVID.4 [4], and LSB [5].  It is also described in the XNFS [6]
standard.

But it ain't posix, so...should it really go in posix.sgml?

[1] http://www.faqs.org/rfcs/rfc1014.html (06/1987)
[2] http://www.faqs.org/rfcs/rfc1832.html (08/1995)
[3] http://www.faqs.org/rfcs/rfc4506.html (05/2006)
[4] System V Interface Definition, Third Edition
	American Telephone and Telegraph Company, System V
	Interface Definition, Issue 3; Morristown, NJ, UNIX Press, 1989.
	(ISBN 0201566524)
[5] http://linuxtesting.org/results/lsb_specs/by_lsb (13.3.1. RPC)
[6] http://www.opengroup.org/onlinepubs/009629799/chap3.htm#tagcjh_04

I also got good use out of Appendix A of the ONC+ developer's guide:
http://docs.sun.com/app/docs/doc/816-1435

2010-03-02  Charles Wilson  <...>

        * new-features.sgml (ov-new1.7.2): Describe XDR support.


--
Chuck

--------------020202010300030407020307
Content-Type: text/x-patch;
 name="xdr-doc-1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="xdr-doc-1.patch"
Content-length: 811

Index: new-features.sgml
===================================================================
RCS file: /cvs/src/src/winsup/doc/new-features.sgml,v
retrieving revision 1.40
diff -u -p -r1.40 new-features.sgml
--- new-features.sgml	26 Feb 2010 17:54:24 -0000	1.40
+++ new-features.sgml	3 Mar 2010 04:32:28 -0000
@@ -140,6 +140,14 @@ In other words, use the /cygdrive mount 
 Recognize NWFS filesystem and workaround broken OS call.
 </para></listitem>
 
+<listitem><para>
+New support for eXtensible Data Record (XDR) encoding and decoding,
+as defined by RFCs 1014, 1832, and 4506.  The XDR protocol and
+functions are useful for cross-platfrom data exchange, and are
+commonly used as the core data interchange format for Remote
+Procedure Call (RPC) and NFS.
+</para></listitem>
+
 </itemizedlist>
 
 </sect2>

--------------020202010300030407020307--
