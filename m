Return-Path: <cygwin-patches-return-6955-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30900 invoked by alias); 13 Feb 2010 15:20:40 -0000
Received: (qmail 30890 invoked by uid 22791); 13 Feb 2010 15:20:39 -0000
X-SWARE-Spam-Status: No, hits=-1.3 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from out2.smtp.messagingengine.com (HELO out2.smtp.messagingengine.com) (66.111.4.26)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 13 Feb 2010 15:20:34 +0000
Received: from compute2.internal (compute2.internal [10.202.2.42]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id CE6A6DDF2A 	for <cygwin-patches@cygwin.com>; Sat, 13 Feb 2010 10:20:32 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])   by compute2.internal (MEProxy); Sat, 13 Feb 2010 10:20:32 -0500
Received: from [192.168.1.3] (user-0c6sbd2.cable.mindspring.com [24.110.45.162]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id 5C7B54C31C4; 	Sat, 13 Feb 2010 10:20:32 -0500 (EST)
Message-ID: <4B76C334.8080101@cwilson.fastmail.fm>
Date: Sat, 13 Feb 2010 15:20:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Add xdr support
References: <4B764A1F.6060003@cwilson.fastmail.fm> <20100213113509.GJ5683@calimero.vinschen.de>
In-Reply-To: <20100213113509.GJ5683@calimero.vinschen.de>
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
X-SW-Source: 2010-q1/txt/msg00071.txt.bz2

Corinna Vinschen wrote:
> On Feb 13 01:43, Charles Wilson wrote:
>> The attached patch(es) add XDR support to cygwin
> 
> Cool.
> 
>>   The cygwin components are basically just adding the
>> new exports, and providing a callback function for the error reporting
>> framework in the xdr implementation, that uses (in effect) debug_printf().
> 
> Is it really necessary to do that in init.cc?  Shouldn't it be sufficient
> to set it in dll_crt0_1?

Yes, I just wasn't sure /where/ it should be done.  It needs to be
early, before anything would try to use XDR. If you think dll_crt0_1 is
more appropriate, that's fine with me.

Alternatively, the newlib code could be changed so that the error
reports go /nowhere/ until a caller sets up a reporting mechanism.
Then, I suppose, it's much less important how early cygwin does that.
Right now, the newlib code defaults to using stderr.

I'd have to make the 'set up error reporting' function public, in that
case. (Right now, it is sorta hidden: that's why cygxdr.h has to declare
the setter function itself).

--
Chuck
