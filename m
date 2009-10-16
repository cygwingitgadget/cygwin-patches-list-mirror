Return-Path: <cygwin-patches-return-6773-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2406 invoked by alias); 16 Oct 2009 01:59:21 -0000
Received: (qmail 2395 invoked by uid 22791); 16 Oct 2009 01:59:20 -0000
X-SWARE-Spam-Status: No, hits=-3.5 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from out1.smtp.messagingengine.com (HELO out1.smtp.messagingengine.com) (66.111.4.25)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 16 Oct 2009 01:59:15 +0000
Received: from compute2.internal (compute2.internal [10.202.2.42]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id 212F0B23BC 	for <cygwin-patches@cygwin.com>; Thu, 15 Oct 2009 21:59:14 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])   by compute2.internal (MEProxy); Thu, 15 Oct 2009 21:59:14 -0400
Received: from [192.168.1.3] (user-0c6sbc4.cable.mindspring.com [24.110.45.132]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id 98C428CF1; 	Thu, 15 Oct 2009 21:59:13 -0400 (EDT)
Message-ID: <4AD7D356.8030703@cwilson.fastmail.fm>
Date: Fri, 16 Oct 2009 01:59:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Honor DESTDIR in w32api and mingw
References: <4AD78C5B.2080107@cwilson.fastmail.fm> <4AD7C107.6000803@byu.net>
In-Reply-To: <4AD7C107.6000803@byu.net>
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
X-SW-Source: 2009-q4/txt/msg00104.txt.bz2

Eric Blake wrote:
>> +++ winsup/mingw/Makefile.in    15 Oct 2009 20:30:09 -0000
>> @@ -26,6 +26,8 @@ srcdir = @srcdir@
>>  top_srcdir = @top_srcdir@
>>  top_builddir = @top_builddir@
> 
>> +DESTDIR =
>> +
> 
> Why are you setting DESTDIR?  My understanding is that for DESTDIR to work
> reliably, you need to use $(DESTDIR), but not set it.  Then make will
> default it to empty, which can be changed by either 'make DESTDIR=...' or
> 'env DESTDIR=... make -e'.

Oh, ok.  I'll take those bits out -- I'm just always used to explicitly
setting it (empty).  I see that, if they support DESTDIR at all, both
automake-generated and custom Makefile.in's in src/ seem to follow your
rule.

--
Chuck
