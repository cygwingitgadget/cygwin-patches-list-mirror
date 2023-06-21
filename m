Return-Path: <SRS0=A6qb=CJ=shaw.ca=brian.inglis@sourceware.org>
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
	by sourceware.org (Postfix) with ESMTPS id 78A9A3858D28
	for <cygwin-patches@cygwin.com>; Wed, 21 Jun 2023 04:51:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 78A9A3858D28
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=Shaw.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=shaw.ca
Received: from shw-obgw-4003a.ext.cloudfilter.net ([10.228.9.183])
	by cmsmtp with ESMTP
	id BgHVq6BKa6NwhBpo3qBvdo; Wed, 21 Jun 2023 04:50:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1687323059; bh=EXTv2Gvm2iY/QWMtqGn/+NvoeyNLd+k/d9n8V0ORllc=;
	h=Date:Reply-To:Subject:To:References:From:In-Reply-To;
	b=o9bZmry1MG+tRfitM5CSwlVZr/uwyTxz6NBmgr8dGRyITcRyTcOQG9rIL3rDoTIwo
	 RwP04gZyIpuO758kIzwRSqKDrMLz4BFUkCgYRwkmPRC2uDz/lyJtfrC3NmZAi0cl1Z
	 XuMLAH6DJYlOLcjc+uMqXxXqCrw7BaBCLZxaqjn5GP9gPW00X3/gEkhnRN6GabpwhZ
	 ex5a6HIFYeWWRQlYd42zyDfRGTVmp3qq2zcpgX1sgNig0GUCdR90zGzhC4SXjYK4mh
	 13NAgAnJuJTeX0i79xO4Bs3r696CPkkgKsuGZN0YnscY7XSzpdudi8FSgDEVmorlj2
	 Kkg1I4ICIiSQg==
Received: from [10.0.0.5] ([184.64.102.149])
	by cmsmtp with ESMTP
	id Bpo2q5lOXcyvuBpo3qZIUX; Wed, 21 Jun 2023 04:50:59 +0000
X-Authority-Analysis: v=2.4 cv=VbHkgXl9 c=1 sm=1 tr=0 ts=649281b3
 a=DxHlV3/gbUaP7LOF0QAmaA==:117 a=DxHlV3/gbUaP7LOF0QAmaA==:17
 a=IkcTkHD0fZMA:10 a=_Dj-zB-qAAAA:8 a=w_pzkKWiAAAA:8 a=VwQbUJbxAAAA:8
 a=5Pkri6VOpu_cglOfqyAA:9 a=QEXdDO2ut3YA:10 a=dyqNagk5bdkA:10
 a=sRI3_1zDfAgwuvI8zelB:22 a=AjGcO6oz07-iQ99wixmX:22
Message-ID: <6783769f-fb78-9ae7-bda9-ce64b79125d3@Shaw.ca>
Date: Tue, 20 Jun 2023 22:50:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 0/3] use wincap in format_proc_cpuinfo for user_shstk
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <cover.1687198150.git.Brian.Inglis@Shaw.ca>
 <ZJFh2Cy9PnCqNoYU@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@Shaw.ca>
Organization: Inglis
In-Reply-To: <ZJFh2Cy9PnCqNoYU@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfOJL+uTZ+mq6LCYZFVm4rN/K3dHF+KRdJ4zbGoy/uBBaTJ11wbowdofDsOOT0Jk3ZeN3U/gCyzShgSqg5j2Zb7yCdUrpZe4lSI5zcfKTGcwVX2QdOpGT
 a4Kl11eLtetG5/GIn3k5XhvqDzw6CxgDhSjQVDKYyH4xRberxKhmXCcmKX875t0ZGJo0kFNZ7JKgkgNjJ86HJHs2SKhZSZFBKc4=
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2023-06-20 02:22, Corinna Vinschen wrote:
> On Jun 19 12:15, Brian Inglis wrote:
>> In test for for AMD/Intel Control flow Enforcement Technology user mode
>> shadow stack support replace Windows version tests with test of wincap
>> member addition has_user_shstk with Windows version dependent value
>>
>> Fixes: 41fdb869f998 fhandler/proc.cc(format_proc_cpuinfo): Add Linux 6.3 cpuinfo
>> Signed-off-by: Brian Inglis <Brian.Inglis@Shaw.ca>
>>
>> Brian Inglis (3):
>>    wincap.h: add wincap member has_user_shstk
>>    wincap.cc: set wincap member has_user_shstk true for 2004+
>>    fhandler/proc.cc: use wincap.has_user_shstk
>>
>>   winsup/cygwin/fhandler/proc.cc        |  8 ++++----
>>   winsup/cygwin/local_includes/wincap.h |  2 ++
>>   winsup/cygwin/wincap.cc               | 10 ++++++++++
>>   3 files changed, 16 insertions(+), 4 deletions(-)
> 
> Never mind, I fixed the remaining problems.  Thanks for the patch,
> I pushed it with slight modifications to the commit messages.
> 
> I'm a bit puzzled if my original mail
> https://cygwin.com/pipermail/cygwin-patches/2023q2/012280.html
> was really that unclear.  Reiterating for the records:
> 
> - Commit messages should really try to explain why the patch is made and
>    what it's good for. In case of fixing a bug, the bug should be explained
>    and, ideally, explain why the patch is the better solution.
> 
> - If a patch fixes an older bug, it should say so and point out the
>    commit which introduced the bug using the Fixes: tag.  The format
>    is
>    
>      Fixes: <12-digit-SHA1> ("<commit headline>")
> 
>    The parens and quoting chars are part of the format.
> 
> - Every patch should contain a Signed-off-by: to indicate that
>    you did the patch by yourself.  That's easily automated by
>    using `git commit -s'.
> 
> - Other Tags like "Reported-by:" or "Tested-by:" are nice to have,
>    but not essential.

>> - For obvious reasons, the message text in your cover message won't make
>>   it into the git repo.  However, the commit messages in git should
>>   reflect why the change was made, so a future interested reader has
>>   a chance to understand why a change was made.

Not obvious to me unfortunately!

>> - As I already mentioned a couple of times on this list (but not
>>   lately), it would be great if you could always add a "Signed-off-by:"
>>   line.

I added that to my config.

>> - Also, given this patch fixes an earlier patch, it should contain
>>   a line
>> 
>>     Fixes: <12-digit-SHA1> ("commit headline")

ASSUME NOTHING (as we used to write in masm) about me, git, background info, or 
conventions: man page or link refs please?

I personally used CVS then Hg, and needed BK for another project.

I only use git seriously for this project, as most businesses supported at best 
CVS, most projects relied on backups of network shares, and saw little value in 
source control, even in software cos; others were anal about it, requiring 
diffs, but did not trust developers (maybe just contractors) with access to 
their secure vaults!
[It made for interesting chats, some after I was gone, when their test builds 
were still showing bugs I had fixed, tested, and submitted source changes for 
weeks earlier!]

After trying to earlier track down useful docs I just managed to find:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst

which presumably is the background I need?

Some stuff is also mentioned in:

https://git.kernel.org/pub/scm/git/git.git/tree/Documentation/SubmittingPatches

which may have a more explanatory and practical focus.

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retirer     but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
