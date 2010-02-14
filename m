Return-Path: <cygwin-patches-return-6963-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22562 invoked by alias); 14 Feb 2010 14:00:20 -0000
Received: (qmail 22550 invoked by uid 22791); 14 Feb 2010 14:00:19 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from out2.smtp.messagingengine.com (HELO out2.smtp.messagingengine.com) (66.111.4.26)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 14 Feb 2010 14:00:16 +0000
Received: from compute1.internal (compute1 [10.202.2.41]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id B70E3E01A3 	for <cygwin-patches@cygwin.com>; Sun, 14 Feb 2010 09:00:14 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])   by compute1.internal (MEProxy); Sun, 14 Feb 2010 09:00:14 -0500
Received: from [192.168.1.3] (user-0c6sbd2.cable.mindspring.com [24.110.45.162]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id 5904297E3; 	Sun, 14 Feb 2010 09:00:14 -0500 (EST)
Message-ID: <4B7801E1.6090708@cwilson.fastmail.fm>
Date: Sun, 14 Feb 2010 14:00:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Add xdr support
References: <4B764A1F.6060003@cwilson.fastmail.fm>  <20100213113509.GJ5683@calimero.vinschen.de>  <4B76C334.8080101@cwilson.fastmail.fm>  <20100213210122.GA20649@ednor.casa.cgf.cx>  <4B773B70.8040208@cwilson.fastmail.fm>  <4B778315.9090300@gmail.com>  <4B778E43.5020701@cwilson.fastmail.fm> <20100214102059.GP5683@calimero.vinschen.de>
In-Reply-To: <20100214102059.GP5683@calimero.vinschen.de>
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
X-SW-Source: 2010-q1/txt/msg00079.txt.bz2

Corinna Vinschen wrote:
> On Feb 14 00:46, Charles Wilson wrote:
>> Well, historical oddities notwithstanding, I think newlib /is/ the
>> correct place, simply because I can easily see a demand/need for XDR
>> code on other newlib targets.  But obviously the ultimate call is Jeff
>> J's -- although I'm not planning on even submitting it over there unless
>> this group decides it is the correct thing to do.
> 
> Well, ultimately it's your decision where you provide this stuff.  After
> all, you're the one who did all the work 

Well, sure -- but as a practical matter, a single word from you or cgf,
on the newlib list, can torpedo the contribution in Jeff's mind, I'm
sure.  So...

> and if you think that newlib is
> a good place, then, so be it.

Ok, but since cgf raised the issue first, I'd like to hear again from
him.  On another note, other than the 'where to put it' issue and the
'where should the initialization code go', any other substantive
comments on the code itself?

Or, pending cgf, would you rather wait until I repost over on the newlib
list, or a decision not to do so and to respin is made?

> Personally I never used nor needed XDR,
> but that doesn't mean it's useless for others.

Well, you've USED it, just not directly.  It's part of the core
implementation of the RPC and NFS protocols.

--
Chuck
