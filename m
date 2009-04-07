Return-Path: <cygwin-patches-return-6494-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21067 invoked by alias); 7 Apr 2009 14:57:17 -0000
Received: (qmail 21044 invoked by uid 22791); 7 Apr 2009 14:57:15 -0000
X-SWARE-Spam-Status: No, hits=-3.4 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from out2.smtp.messagingengine.com (HELO out2.smtp.messagingengine.com) (66.111.4.26)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 07 Apr 2009 14:57:10 +0000
Received: from compute2.internal (compute2.internal [10.202.2.42]) 	by out1.messagingengine.com (Postfix) with ESMTP id 02EBD3139FE 	for <cygwin-patches@cygwin.com>; Tue,  7 Apr 2009 10:57:08 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])   by compute2.internal (MEProxy); Tue, 07 Apr 2009 10:57:08 -0400
Received: from [192.168.1.3] (user-0cej09l.cable.mindspring.com [24.233.129.53]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id 9C34C3BE52; 	Tue,  7 Apr 2009 10:57:07 -0400 (EDT)
Message-ID: <49DB69BE.80203@cwilson.fastmail.fm>
Date: Tue, 07 Apr 2009 14:57:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.21) Gecko/20090302 Thunderbird/2.0.0.21 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix type inconsistencies in stdint.h
References: <49D6B8D7.4020907@gmail.com> <20090404033545.GA3386@ednor.casa.cgf.cx> <49D6DDDD.4030504@gmail.com> <20090404062459.GB22452@ednor.casa.cgf.cx> <49D70B05.6020509@gmail.com> <20090407144659.GA22338@ednor.casa.cgf.cx>
In-Reply-To: <20090407144659.GA22338@ednor.casa.cgf.cx>
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
X-SW-Source: 2009-q2/txt/msg00036.txt.bz2

Christopher Faylor wrote:
> I don't entirely understand when people think it's ok to make sweeping
> changes for 1.7 and when they think we need to be conservative.

MHO is that 1.7+gcc4 is already such a sweeping change (e.g.
"conservative" left the building sometime last year), that if we DO plan
on any more such sweeping changes before cygwin2.dll it's better to do
'em now.

OTOH, if we DON'T actually plan on any more such changes, then there's
no reason to make changes gratuitously, no matter how Just Mean We Are.

> I think it is very regrettable that Cygwin doesn't have the same int
> types as linux and it would be interesting to see how much would be
> broken by changing these types.

"Interesting" in the sense of the old Chinese curse [*], I assume?

--
Chuck

[*] "May you live in interesting times"
