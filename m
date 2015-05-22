Return-Path: <cygwin-patches-return-8141-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 101374 invoked by alias); 22 May 2015 13:38:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 101352 invoked by uid 89); 22 May 2015 13:38:40 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_50,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2
X-HELO: out5-smtp.messagingengine.com
Received: from out5-smtp.messagingengine.com (HELO out5-smtp.messagingengine.com) (66.111.4.29) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Fri, 22 May 2015 13:38:37 +0000
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])	by mailout.nyi.internal (Postfix) with ESMTP id 0E11A2082B	for <cygwin-patches@cygwin.com>; Fri, 22 May 2015 09:38:35 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])  by compute5.internal (MEProxy); Fri, 22 May 2015 09:38:35 -0400
Received: from [192.168.1.102] (unknown [31.51.206.76])	by mail.messagingengine.com (Postfix) with ESMTPA id A9C82680130	for <cygwin-patches@cygwin.com>; Fri, 22 May 2015 09:38:34 -0400 (EDT)
Message-ID: <555F3157.1040808@dronecode.org.uk>
Date: Fri, 22 May 2015 13:38:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Update the estimate of the size of installing everything
References: <1432226663-19744-1-git-send-email-jon.turney@dronecode.org.uk> <555E6DCB.5080005@tiscali.co.uk>
In-Reply-To: <555E6DCB.5080005@tiscali.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2015-q2/txt/msg00042.txt.bz2

On 22/05/2015 00:44, David Stacey wrote:
> On 21/05/2015 17:44, Jon TURNEY wrote:
>> Update the estimate of the size of installing everything from
>> "hundreds of
>> megabytes" to "tens of gigabytes", just in case someone should think
>> it's a
>> good idea with contemporary hard disk sizes:)
>
> Slightly off topic, but I can give you some real numbers if you're
> interested: x86_64 is the larger of the two installs, weighing in at
> 44.45 GB with just over 750,000 files - and growing all the time.
> Obviously, that's not installed on an SSD...

Thanks. But being precise here just means it will get out of date faster :)

On reflection, I think I'd prefer just to delete that sentence.  Nearly 
always, installing everything is not a good idea, so mentioning the 
possibility before mentioning you should install what you need doesn't 
really help.
