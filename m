Return-Path: <cygwin-patches-return-7005-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1573 invoked by alias); 4 Mar 2010 02:56:17 -0000
Received: (qmail 1563 invoked by uid 22791); 4 Mar 2010 02:56:16 -0000
X-SWARE-Spam-Status: No, hits=-3.0 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from out1.smtp.messagingengine.com (HELO out1.smtp.messagingengine.com) (66.111.4.25)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 04 Mar 2010 02:56:11 +0000
Received: from compute2.internal (compute2 [10.202.2.42]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id 5E8BDE2544 	for <cygwin-patches@cygwin.com>; Wed,  3 Mar 2010 21:56:10 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])   by compute2.internal (MEProxy); Wed, 03 Mar 2010 21:56:10 -0500
Received: from [192.168.1.3] (user-0c6sbd2.cable.mindspring.com [24.110.45.162]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id EEF594A00A5; 	Wed,  3 Mar 2010 21:56:09 -0500 (EST)
Message-ID: <4B8F212A.3050404@cwilson.fastmail.fm>
Date: Thu, 04 Mar 2010 02:56:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Add xdr support
References: <4B764A1F.6060003@cwilson.fastmail.fm>  <4B8D2F9D.4090309@cwilson.fastmail.fm>  <20100302180921.GO5683@calimero.vinschen.de>  <4B8DED87.1080801@cwilson.fastmail.fm>  <20100303091052.GB24732@calimero.vinschen.de>  <4B8E5AD0.9050703@cwilson.fastmail.fm> <20100303150642.GN17293@calimero.vinschen.de>
In-Reply-To: <20100303150642.GN17293@calimero.vinschen.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q1/txt/msg00121.txt.bz2

Corinna Vinschen wrote:
> Thank you!  Everything's applied.  I just trimmed the ChangeLog entry
> slighty.

Thanks.

I've found a (small) problem though.  I was trying to compile the
(external) tirpc library, and discovered that we need to export two
additional "private" functions from XDR:

__xdrrec_getrec
__xdrrec_setnonblock

There's nothing really "private" about them, but they are not declared
in the xdr.h header -- the libtirpc's rpc implementation declares the
functions itself, but expects them to be provided by XDR.  The newlib
XDR implementation provides them, but I just didn't include them in
cygwin.din.

I'm testing a patch now; will post later.

--
Chuck
