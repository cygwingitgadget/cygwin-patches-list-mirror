Return-Path: <cygwin-patches-return-6488-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8699 invoked by alias); 7 Apr 2009 13:06:29 -0000
Received: (qmail 8683 invoked by uid 22791); 7 Apr 2009 13:06:25 -0000
X-SWARE-Spam-Status: No, hits=-3.4 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from out2.smtp.messagingengine.com (HELO out2.smtp.messagingengine.com) (66.111.4.26)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 07 Apr 2009 13:06:19 +0000
Received: from compute2.internal (compute2.internal [10.202.2.42]) 	by out1.messagingengine.com (Postfix) with ESMTP id 8CF98312FD0 	for <cygwin-patches@cygwin.com>; Tue,  7 Apr 2009 09:06:17 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])   by compute2.internal (MEProxy); Tue, 07 Apr 2009 09:06:17 -0400
Received: from [192.168.1.3] (user-0cej09l.cable.mindspring.com [24.233.129.53]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id 2E5913BD97; 	Tue,  7 Apr 2009 09:06:17 -0400 (EDT)
Message-ID: <49DB4FC4.7020903@cwilson.fastmail.fm>
Date: Tue, 07 Apr 2009 13:06:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.21) Gecko/20090302 Thunderbird/2.0.0.21 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix type inconsistencies in stdint.h
References: <49D6B8D7.4020907@gmail.com> <20090404033545.GA3386@ednor.casa.cgf.cx> <49D6DDDD.4030504@gmail.com> <20090404062459.GB22452@ednor.casa.cgf.cx> <49DB4D95.7000903@byu.net>
In-Reply-To: <49DB4D95.7000903@byu.net>
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
X-SW-Source: 2009-q2/txt/msg00030.txt.bz2

Eric Blake wrote:
> Making the ABI change now (which
> probably won't affect C apps, but will definitely affect any C++ code that
> used uint32_t and friends in mangled names) 
>
> But I'm with Dave that IF we decide
> the ABI change is the right thing to do, then NOW is the only time worth
> doing it.

Especially as the transition to
gcc4/dw2-eh/shared-libgcc/shared-libstdc++/--enable-fully-dynamic-string
is *definitely* an ABI break for C++, anyway.

--
Chuck
