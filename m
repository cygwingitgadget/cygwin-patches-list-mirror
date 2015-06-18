Return-Path: <cygwin-patches-return-8196-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 59702 invoked by alias); 18 Jun 2015 10:46:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 59687 invoked by uid 89); 18 Jun 2015 10:46:21 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.7 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2
X-HELO: out5-smtp.messagingengine.com
Received: from out5-smtp.messagingengine.com (HELO out5-smtp.messagingengine.com) (66.111.4.29) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Thu, 18 Jun 2015 10:46:18 +0000
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])	by mailout.nyi.internal (Postfix) with ESMTP id DF9CD20469	for <cygwin-patches@cygwin.com>; Thu, 18 Jun 2015 06:46:15 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])  by compute2.internal (MEProxy); Thu, 18 Jun 2015 06:46:15 -0400
Received: from [192.168.1.102] (unknown [86.141.128.210])	by mail.messagingengine.com (Postfix) with ESMTPA id 793E768015D	for <cygwin-patches@cygwin.com>; Thu, 18 Jun 2015 06:46:15 -0400 (EDT)
Message-ID: <5582A170.9010305@dronecode.org.uk>
Date: Thu, 18 Jun 2015 10:46:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/5] Generate cygwin-api manpages
References: <1434544626-2516-1-git-send-email-jon.turney@dronecode.org.uk> <20150617134936.GK31537@calimero.vinschen.de> <5581994C.6070107@dronecode.org.uk> <20150617162753.GN31537@calimero.vinschen.de>
In-Reply-To: <20150617162753.GN31537@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2015-q2/txt/msg00097.txt.bz2

On 17/06/2015 17:27, Corinna Vinschen wrote:
> On Jun 17 16:59, Jon TURNEY wrote:
>> On 17/06/2015 14:49, Corinna Vinschen wrote:
>>> On Jun 17 13:37, Jon TURNEY wrote:
>>>> This patch set changes the DocBook source XML for the Cygwin API reference to
>>>> use refentry elements, and also generates man pages from that.
>>>>
>>>> Again, note that after this, the chunked html now has a page for each function,
>>>> rather than one containing all functions.
>>>
>>> Patchset approved, basically, except...
>>>
>>> The next cygwin.cygport file will explicitly exclude the man pages
>>> section 1.  But it won't exclude section 3, and I'm rather not hot
>>> on excluding each newly generated API file explicitly.
>>
>> Yes, I hadn't noticed that regex.3 manpage, which makes things a bit of a
>> pain.
>>
>> But maybe you write in cygwin_devel_CONTENTS something like
>> "--exclude=usr/share/man/ usr/share/man/man3/regex.3.gz
>> usr/share/man/man7/regex.7.gz" ?
>
> exclude?  This would require to move both files to cygwin-doc
> as you outlined below.  It would essentially remove all man pages
> from the cygwin core packages and then we exclude usr/share/man,
> as you outlined below as well.

Hmm?  I thought perhaps this would exclude everything under 
usr/share/man, then include regex.3 and regex.7

But I don't think tar processes it's options left-to-right like that, so 
never mind.

>>> Do you have an idea how far away we are from including the cygwin-doc
>>> package into the cygwin package set?  I'm not planning a new release
>>> very soon, so we can coordinate that without pressure.
>>
>> After this patch set, the remaining things are:
>>
>> * newlib libc and libm .info documentation
>>
>> I think this just needs 'make info' adding to the .cygport, as newlib
>> doesn't build this on 'make all'
>
>    libc.info and libm.info are built by default, but they are not
>    installed with `make install'

That seems a little odd.

>> * intro.1 and intro.3 man pages for Cygwin, handwritten
>>
>> If these are worth keeping, this is straightforward
>>
>> * Cygwin User's Guide and API reference texinfo, generated from the DocBook
>> XML
>>
>> as is this
>
>    Isn't the HTML documentation sufficient?  I'm not opposed to
>    keeping the texinfo's, just wondering.

It's there currently and it's really not much work to keep it.

>> * man pages for newlib functions
>>
>> But this is a substantial piece of work.  Currently, I'm not even sure how
>> this can be done in an upstreamable way.
>>
>> I am experimenting with building an alternative to the makedoc tool, which
>> generates DocBook XML rather than .texinfo, which can then be processed into
>> manpages and other formats, but this is far from complete.
>>
>>
>> If the suggestion above doesn't work, I guess possible approaches to
>> coordination are:
>>
>> * Move regex.[37] from cygwin-devel to cygwin-doc, and exclude
>> /usr/share/man
>
> ... this sounds good to me.

Let's do things that way, then.
