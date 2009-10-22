Return-Path: <cygwin-patches-return-6793-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1321 invoked by alias); 22 Oct 2009 23:09:58 -0000
Received: (qmail 1307 invoked by uid 22791); 22 Oct 2009 23:09:57 -0000
X-SWARE-Spam-Status: No, hits=-3.5 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from out2.smtp.messagingengine.com (HELO out2.smtp.messagingengine.com) (66.111.4.26)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 22 Oct 2009 23:09:54 +0000
Received: from compute2.internal (compute2.internal [10.202.2.42]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id A8F4DB555F 	for <cygwin-patches@cygwin.com>; Thu, 22 Oct 2009 19:09:52 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])   by compute2.internal (MEProxy); Thu, 22 Oct 2009 19:09:53 -0400
Received: from [192.168.1.3] (user-0c6sbc4.cable.mindspring.com [24.110.45.132]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id 381BB6EED1; 	Thu, 22 Oct 2009 19:09:52 -0400 (EDT)
Message-ID: <4AE0E614.4030305@cwilson.fastmail.fm>
Date: Thu, 22 Oct 2009 23:09:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Honor DESTDIR in w32api and mingw
References: <4AD78C5B.2080107@cwilson.fastmail.fm> <4AE0DE77.3090300@cwilson.fastmail.fm>
In-Reply-To: <4AE0DE77.3090300@cwilson.fastmail.fm>
Content-Type: multipart/mixed;  boundary="------------060103090009030406010300"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00124.txt.bz2

This is a multi-part message in MIME format.
--------------060103090009030406010300
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 323

Charles Wilson wrote:
> Latest rev, based on feedback @ mingw-dvlpr.  Avoid gmake conditionals
> and use explicit rules, instead. Detect problems in all applicable
> installation paths, not just $(prefix).
> 
> 2009-10-22  Charles Wilson  <...>

Attached in .gz form, so that the web archive doesn't inline it.

--
Chuck



--------------060103090009030406010300
Content-Type: application/gzip;
 name="mingw-destdir.patch4.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="mingw-destdir.patch4.gz"
Content-length: 3160

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

--------------060103090009030406010300--
