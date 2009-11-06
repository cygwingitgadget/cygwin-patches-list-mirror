Return-Path: <cygwin-patches-return-6812-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20146 invoked by alias); 6 Nov 2009 00:03:21 -0000
Received: (qmail 19909 invoked by uid 22791); 6 Nov 2009 00:03:20 -0000
X-SWARE-Spam-Status: No, hits=-3.6 required=5.0 	tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from out4.smtp.messagingengine.com (HELO out4.smtp.messagingengine.com) (66.111.4.28)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 06 Nov 2009 00:03:13 +0000
Received: from compute1.internal (compute1.internal [10.202.2.41]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id DC67BBCEE0 	for <cygwin-patches@cygwin.com>; Thu,  5 Nov 2009 19:03:11 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])   by compute1.internal (MEProxy); Thu, 05 Nov 2009 19:03:11 -0500
Received: from [192.168.1.3] (user-0c6sbc4.cable.mindspring.com [24.110.45.132]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id 78AF535250; 	Thu,  5 Nov 2009 19:03:11 -0500 (EST)
Message-ID: <4AF367BA.2000005@cwilson.fastmail.fm>
Date: Fri, 06 Nov 2009 00:03:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Allow to disable root privileges  with CYGWIN=noroot
References: <4AC8F299.1020303@t-online.de> <20091004195723.GH4563@calimero.vinschen.de> <20091004200843.GK4563@calimero.vinschen.de> <4ACFAE4D.90502@t-online.de> <20091010100831.GA13581@calimero.vinschen.de> <4AD243ED.6080505@t-online.de> <20091013102502.GG11169@calimero.vinschen.de> <4AD4E38A.2050301@t-online.de> <20091014104003.GA24593@calimero.vinschen.de> <1My1yO-0KvdnE0@fwd09.aul.t-online.de> <20091014120237.GA27964@calimero.vinschen.de>
In-Reply-To: <20091014120237.GA27964@calimero.vinschen.de>
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
X-SW-Source: 2009-q4/txt/msg00143.txt.bz2

Corinna Vinschen wrote:
> On Oct 14 13:24, Christian Franke wrote:
>> Corinna Vinschen wrote:
>>> Cool.  Another interesting option could be to remove the domain admins
>>> group as well, if the user is a domain user and, of course, removing
>>> any single user right, similar to the "capsh" tool under SELinux.
>>>
>> Yes, makes sense.
>>
>>
>>> I'm just not sure if that tool should be part of the Cygwin package or
>>> a package of its own right.  I'm leaning towards the latter choice.
>>>
>>>
>> ... or add it to the cygutils package ?
> 
> Sure, if Chuck likes the idea.

I've no objections to incorporating this/these utilities into cygutils.
 Take a look at
http://cygwin.com/cgi-bin/cvsweb.cgi/cygutils/HOW-TO-CONTRIBUTE?rev=1.11&cvsroot=cygwin-apps
to see how best to integrate the tool(s) into cygutils.

--
Chuck
