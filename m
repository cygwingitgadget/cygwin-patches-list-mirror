Return-Path: <cygwin-patches-return-8190-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 65016 invoked by alias); 17 Jun 2015 15:59:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 65004 invoked by uid 89); 17 Jun 2015 15:59:19 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.7 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2
X-HELO: out5-smtp.messagingengine.com
Received: from out5-smtp.messagingengine.com (HELO out5-smtp.messagingengine.com) (66.111.4.29) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Wed, 17 Jun 2015 15:59:17 +0000
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])	by mailout.nyi.internal (Postfix) with ESMTP id C8255208BA	for <cygwin-patches@cygwin.com>; Wed, 17 Jun 2015 11:59:14 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])  by compute3.internal (MEProxy); Wed, 17 Jun 2015 11:59:14 -0400
Received: from [192.168.1.102] (unknown [86.141.128.210])	by mail.messagingengine.com (Postfix) with ESMTPA id 6E4586800A5	for <cygwin-patches@cygwin.com>; Wed, 17 Jun 2015 11:59:14 -0400 (EDT)
Message-ID: <5581994C.6070107@dronecode.org.uk>
Date: Wed, 17 Jun 2015 15:59:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/5] Generate cygwin-api manpages
References: <1434544626-2516-1-git-send-email-jon.turney@dronecode.org.uk> <20150617134936.GK31537@calimero.vinschen.de>
In-Reply-To: <20150617134936.GK31537@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2015-q2/txt/msg00091.txt.bz2

On 17/06/2015 14:49, Corinna Vinschen wrote:
> On Jun 17 13:37, Jon TURNEY wrote:
>> This patch set changes the DocBook source XML for the Cygwin API reference to
>> use refentry elements, and also generates man pages from that.
>>
>> Again, note that after this, the chunked html now has a page for each function,
>> rather than one containing all functions.
>
> Patchset approved, basically, except...
>
> The next cygwin.cygport file will explicitly exclude the man pages
> section 1.  But it won't exclude section 3, and I'm rather not hot
> on excluding each newly generated API file explicitly.

Yes, I hadn't noticed that regex.3 manpage, which makes things a bit of 
a pain.

But maybe you write in cygwin_devel_CONTENTS something like 
"--exclude=usr/share/man/ usr/share/man/man3/regex.3.gz 
usr/share/man/man7/regex.7.gz" ?

> Do you have an idea how far away we are from including the cygwin-doc
> package into the cygwin package set?  I'm not planning a new release
> very soon, so we can coordinate that without pressure.

After this patch set, the remaining things are:

* newlib libc and libm .info documentation

I think this just needs 'make info' adding to the .cygport, as newlib 
doesn't build this on 'make all'

* intro.1 and intro.3 man pages for Cygwin, handwritten

If these are worth keeping, this is straightforward

* Cygwin User's Guide and API reference texinfo, generated from the 
DocBook XML

as is this

* man pages for newlib functions

But this is a substantial piece of work.  Currently, I'm not even sure 
how this can be done in an upstreamable way.

I am experimenting with building an alternative to the makedoc tool, 
which generates DocBook XML rather than .texinfo, which can then be 
processed into manpages and other formats, but this is far from complete.


If the suggestion above doesn't work, I guess possible approaches to 
coordination are:

* Move regex.[37] from cygwin-devel to cygwin-doc, and exclude 
/usr/share/man

* Assuming I can finish the first 3 items on that list before the next 
cygwin release, move the newlib manpages to a new package 
(man-pages-newlib?) and make that a dependency of cygwin-doc.
