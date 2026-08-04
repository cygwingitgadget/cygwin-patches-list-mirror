Return-Path: <SRS0=G+v8=F5=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id CD9D94BB24CB
	for <cygwin-patches@cygwin.com>; Tue,  4 Aug 2026 03:59:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CD9D94BB24CB
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CD9D94BB24CB
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1785815969; cv=none;
	b=Ba9CgwyVAEFILrChnjB5wL18YHhzyApHcfXZcUyoJcmjulFmLkC947kZ7nooilQgS//4RI3jWgqw9D0aFjt2If3BAwrOu7sS4TQ2oF0IqNWsDPr/GPmi2xg9/IWPCphqaumYyfhqurLGxDeLm/s+UQzKWwzwdjOM8ocZLGGlOHk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1785815969; c=relaxed/simple;
	bh=9S5WJ2nQh03lhxwaF5OJXk8pvpJOmsd8weZ+uQdVZm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=ZSCcHmO79tHZ1GHuaznlxlELcqzfPyRt4LEL3tBdAo67s1k7MTnAv/SHBEv1g4t6Etj/Af/6NWoaHAliHs7Qz8tld9kPmUh9XrOjQY4DhaIioypWTYnj5H/stNpFg5W/RghsgepjecX61hEhZMAGnce8CdbQ4o8nVDl9eTlFjv4=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CD9D94BB24CB
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 6744DtIe097236
	for <cygwin-patches@cygwin.com>; Mon, 3 Aug 2026 21:13:55 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdlTurRu; Mon Aug  3 21:13:54 2026
Message-ID: <18b718f2-c432-4c16-b00a-a3d3790c8dbf@maxrnd.com>
Date: Mon, 3 Aug 2026 20:59:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: open: Add missing unlock on error
To: cygwin-patches@cygwin.com
References: <20260803032303.5382-1-takashi.yano@nifty.ne.jp>
 <0f3a1f92-f9fa-5aff-c837-249a2408b95f@gmx.de>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <0f3a1f92-f9fa-5aff-c837-249a2408b95f@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On 8/3/2026 12:36 PM, Johannes Schindelin wrote:
> Hi Takashi,
> 
> I independently reviewed this and reached the same conclusion: the fix is
> correct and minimal. I see it already landed on master as 0d3ea0ee653f
> (with Mark's Reviewed-by), so it's kind of a belated review.
> 
> On Mon, 3 Aug 2026, Takashi Yano wrote:
> 
>> the commit 524d75ff7398 ("Cygwin: open: Unlock fdtab before open_
>> with_arch()") introduced a bug that fdtab lock was not unlocked
>> when new fd cannot be allocated due to an error.
> 
> Worth restating how much this matters, because the leaked lock is not
> fd-table-local. The dtable lock acquires and releases
> `lock_process::locker`, a process-wide recursive muto that also guards
> `fork`, exec/spawn, `dup`, and every `open` and `close`. So the pre-fix
> code let the owning thread hold it forever, turning a transient
> out-of-descriptors failure (`EMFILE`) into a permanent, process-wide
> deadlock. That is why it is a showstopper even though the trigger is rare.

I've neglected to add a h/t to Johannes for his series of analyses that 
have proven to me that often there is much more going on within Cygwin 
than meets the eye.  These comments are invaluable, every one.
Thank you Johannes very much!

..mark
