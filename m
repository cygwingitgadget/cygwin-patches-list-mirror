Return-Path: <SRS0=A6qb=CJ=shaw.ca=brian.inglis@sourceware.org>
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
	by sourceware.org (Postfix) with ESMTPS id A37413858D28
	for <cygwin-patches@cygwin.com>; Wed, 21 Jun 2023 15:04:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A37413858D28
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=Shaw.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=shaw.ca
Received: from shw-obgw-4003a.ext.cloudfilter.net ([10.228.9.183])
	by cmsmtp with ESMTP
	id Bx3Dq7Ifx6NwhBzNhqCj8W; Wed, 21 Jun 2023 15:04:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1687359865; bh=dDc2wM6dzzdgCM/A1o3AeXehzIG0cogT+mqcOCuNHJE=;
	h=Date:Reply-To:Subject:To:References:From:In-Reply-To;
	b=s7yPRpcy4I5V+YOQzM+/fOVPJDu2SnGLsrUVxBAJjW8UXwg/qpi8KEGcdO3YMcc5E
	 G2FW6d8uocjRE2Xg87gdcz1QMmzJYiRfrGAIfNxC8ufgz6ALVTtKb6g3dr8pkWojaw
	 mSZBAutkbnMFht5vhFJrWtClxWPbauyY1gK/CDTPxVHG55DYmkXrFrzxsFEqaw0lYP
	 HhgvQ536/eH31/8ENtcK+Av68wQ2MWAtmXLrmbEupzjejNzffbOFeWwIR2lkzQ3nSU
	 sekDCRcy5gnAa/WcQaZoHNPtPMjfqeJyti/P0aulRjCLmNLNIRrQR7Fa/wbIl44EuJ
	 SOXntDUhYlXqg==
Received: from [10.0.0.5] ([184.64.102.149])
	by cmsmtp with ESMTP
	id BzNgq8Ao9cyvuBzNgqZzCB; Wed, 21 Jun 2023 15:04:25 +0000
X-Authority-Analysis: v=2.4 cv=VbHkgXl9 c=1 sm=1 tr=0 ts=64931179
 a=DxHlV3/gbUaP7LOF0QAmaA==:117 a=DxHlV3/gbUaP7LOF0QAmaA==:17
 a=IkcTkHD0fZMA:10 a=w_pzkKWiAAAA:8 a=VwQbUJbxAAAA:8 a=yuJ0Uhft01uisukBEcoA:9
 a=QEXdDO2ut3YA:10 a=dyqNagk5bdkA:10 a=sRI3_1zDfAgwuvI8zelB:22
 a=AjGcO6oz07-iQ99wixmX:22
Message-ID: <93b075ef-3b5e-4025-ab37-11707c1a14e4@Shaw.ca>
Date: Wed, 21 Jun 2023 09:04:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 0/3] use wincap in format_proc_cpuinfo for user_shstk
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <cover.1687198150.git.Brian.Inglis@Shaw.ca>
 <ZJFh2Cy9PnCqNoYU@calimero.vinschen.de>
 <6783769f-fb78-9ae7-bda9-ce64b79125d3@Shaw.ca>
 <ZJKzVwjLe7UeYHDI@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@Shaw.ca>
Organization: Inglis
In-Reply-To: <ZJKzVwjLe7UeYHDI@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfKtsq5WkxZBV5jLBCszN0KSFpEczbjPiD4705qS2dln/+cA2N68oSGsCa3HuGgLtp6OB4+bkqCZKTWXA+vNvv1ZNgnGIY2cvSexb3AfZDdb998Lr+1gE
 YU/p9IyYxd0sgwsAb/92FTwudPbchlPfg/48B85bsXBK8qNhQ9k+Er5CxmTZNkQslY6gFg54JJdYBZFvX8jTNCBl3MSSF9TbaZo=
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2023-06-21 02:22, Corinna Vinschen wrote:
> On Jun 20 22:50, Brian Inglis wrote:
>> On 2023-06-20 02:22, Corinna Vinschen wrote:
>>> Never mind, I fixed the remaining problems.  Thanks for the patch,
>>> I pushed it with slight modifications to the commit messages.
>>>
>>> I'm a bit puzzled if my original mail
>>> https://cygwin.com/pipermail/cygwin-patches/2023q2/012280.html
>>> was really that unclear.  Reiterating for the records:
>>>
>>> - Commit messages should really try to explain why the patch is made and
>>>     what it's good for. In case of fixing a bug, the bug should be explained
>>>     and, ideally, explain why the patch is the better solution.
>>>
>>> - If a patch fixes an older bug, it should say so and point out the
>>>     commit which introduced the bug using the Fixes: tag.  The format
>>>     is
>>>       Fixes: <12-digit-SHA1> ("<commit headline>")
>>>
>>>     The parens and quoting chars are part of the format.
>>>
>>> - Every patch should contain a Signed-off-by: to indicate that
>>>     you did the patch by yourself.  That's easily automated by
>>>     using `git commit -s'.
>>>
>>> - Other Tags like "Reported-by:" or "Tested-by:" are nice to have,
>>>     but not essential.
>>
>>>> - For obvious reasons, the message text in your cover message won't make
>>>>    it into the git repo.  However, the commit messages in git should
>>>>    reflect why the change was made, so a future interested reader has
>>>>    a chance to understand why a change was made.
>>
>> Not obvious to me unfortunately!
> 
> No worries, we're all learning while we're going along.
> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst
> 
> This is pretty well written, and it very nicely explains how to write
> commit messages and use tagging.
> 
> Writing useful commit messages helps other people a lot to understand
> why a patch was made, especially in tricky error cases (locking issues
> are hard to follow, a good explanation is key).
> 
> If you ask me, there's no such thing as a too long commit message.
> 
> We're a small group so we're not supposed to follow the above document
> to the core.  However, things like "Fixes:" are really great, because
> they connect a patch with a history of other patches and allow an aha
> effect when checking on the referenced older patch.  I can honestely
> tell you that it already helped me a lot when working on the Linux
> kernel.  That's why I'd like to make this standard for our small project
> here, too.
> 
> And one of the core expressions used in this doc is this:
>    Don't get discouraged - or impatient
> :)

Cheers - never discouraged - a bit impatient because often frustrated - 
sometimes confused - like Alice and the White Knight's song "Haddocks' Eyes" - 
finding that the /footers/ are sometimes called /headers/ and other times /tags/ 
but actually named *trailers* finally gave more useful results where /fixes/ did 
not! ;^>

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retirer     but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
