Return-Path: <cygwin-patches-return-6959-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31912 invoked by alias); 14 Feb 2010 05:47:02 -0000
Received: (qmail 31898 invoked by uid 22791); 14 Feb 2010 05:47:01 -0000
X-SWARE-Spam-Status: No, hits=-2.1 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from out2.smtp.messagingengine.com (HELO out2.smtp.messagingengine.com) (66.111.4.26)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 14 Feb 2010 05:46:57 +0000
Received: from compute1.internal (compute1.internal [10.202.2.41]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id 69823E0487 	for <cygwin-patches@cygwin.com>; Sun, 14 Feb 2010 00:46:56 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])   by compute1.internal (MEProxy); Sun, 14 Feb 2010 00:46:56 -0500
Received: from [192.168.1.3] (user-0c6sbd2.cable.mindspring.com [24.110.45.162]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id 121774AF8FF; 	Sun, 14 Feb 2010 00:46:56 -0500 (EST)
Message-ID: <4B778E43.5020701@cwilson.fastmail.fm>
Date: Sun, 14 Feb 2010 05:47:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Add xdr support
References: <4B764A1F.6060003@cwilson.fastmail.fm>  <20100213113509.GJ5683@calimero.vinschen.de>  <4B76C334.8080101@cwilson.fastmail.fm> <20100213210122.GA20649@ednor.casa.cgf.cx> <4B773B70.8040208@cwilson.fastmail.fm> <4B778315.9090300@gmail.com>
In-Reply-To: <4B778315.9090300@gmail.com>
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
X-SW-Source: 2010-q1/txt/msg00075.txt.bz2

Dave Korn wrote:
> On 13/02/2010 23:53, Charles Wilson wrote:
> 
>> http://cygwin.com/ml/cygwin-developers/2009-10/msg00242.html
> 
>> IIRC at that time Corinna suggested that newlib was the appropriate
>> place for this, if I wanted to contribute it post-1.7.1. 
> 
> http://cygwin.com/ml/cygwin-developers/2009-10/msg00254.html
> 
>> I asked how to
>> go about adding something to newlib that might not work for all targets,
>> and she said:
> 
>> Unfortunately, my google-foo is not strong enough to find that message
>> in the cygwin archives, 
> 
> http://cygwin.com/ml/cygwin-developers/2009-10/msg00259.html

I bow to your superior google-foo. Interesting thing from those links,
apparently *I* was the first person to mention newlib as the appropriate
home for the XDR implementation, not Corinna.  Weird.

Well, historical oddities notwithstanding, I think newlib /is/ the
correct place, simply because I can easily see a demand/need for XDR
code on other newlib targets.  But obviously the ultimate call is Jeff
J's -- although I'm not planning on even submitting it over there unless
this group decides it is the correct thing to do.

--
Chuck
