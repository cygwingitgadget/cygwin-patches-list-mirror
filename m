Return-Path: <SRS0=9ylK=SD=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 098643858D20
	for <cygwin-patches@cygwin.com>; Fri,  8 Nov 2024 05:55:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 098643858D20
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 098643858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1731045358; cv=none;
	b=LW5tZyIfNllHKR4uDhl/GATOSo1vFf1fJLf56IhayVEAcUfdIn6lPwLgpjBX30y+wUC5Qk48SlYXt8o6PTGP+ubcPrXBmQuSniv488S2YLWUqemEgcYwfOz1Ad8kfETR1YIXI/Ti8VKV2Zz2cfxW4U6TBMM1pmFwz2Na16qDzWQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1731045358; c=relaxed/simple;
	bh=RmMobfpEQyL4ZAwFqI0wIWuXMToArutnbuqd87dxgL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=BUZ+Oigtn0ZFAqfixkbXfjTLMRG7yntNJNidTbjgrM1heN79jGVrCJHHLAR9ZXsGUEwFM1T+cmpTV6iTvNPtS++2pMwMqYuxcjNeYBDnna0Ha2auxOp5opjpVwuiUYjkpZY66gap2uBwSScfkyRsYb1JW3gk95qEdYL19cejCCw=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 4A85x2i9014874
	for <cygwin-patches@cygwin.com>; Thu, 7 Nov 2024 21:59:02 -0800 (PST)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-245-188.fiber.dynamic.sonic.net(50.1.245.188), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpd8Pf2hi; Thu Nov  7 21:58:54 2024
Message-ID: <fc51157a-729b-4ce9-a310-b2947ecefbbe@maxrnd.com>
Date: Thu, 7 Nov 2024 21:55:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Cygwin: Change pthread_sigqueue() to accept thread id
To: cygwin-patches@cygwin.com
References: <20241107072935.1630-1-mark@maxrnd.com>
 <ZyygzyX08grVNe6X@calimero.vinschen.de>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <ZyygzyX08grVNe6X@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On 11/7/2024 3:13 AM, Corinna Vinschen wrote:
> Hi Mark,
> 
> On Nov  6 23:29, Mark Geisert wrote:
>> Change the first parameter of pthread_sigqueue() to be a thread id rather
>> than a thread pointer. The change is to match the Linux implementation of
>> this function.
>>
>> The user-visible function prototype is changed in include/pthread.h.
>> The pthread_sigqueue() function is modified to work with a passed-in thread
>> id rather than an indirect thread pointer as before.  (It was
>> "pthread_t *thread", i.e., class pthread **.)  The release note for Cygwin
>> 3.5.5 is updated.  CYGWIN_VERSION_API_MINOR is bumped to 351.
> 
> This patch is against cygwin-3_5-branch.  All patches should go to the
> main branch in the first place and only then backported to the 3.5
> branch if it's a bugfix.  So the patch sent to cygwin-patches should
> always be against main.

Oops & Sheesh. Consider me reminded of this basic rule :-()

> That leads to a problem with your patch.  CYGWIN_VERSION_API_MINOR is
> already at 355 in the main branch, while it's at 350 in the 3.5 branch.
> That means, if your patch bumps CYGWIN_VERSION_API_MINOR, it would have
> to bump to 356.  However, 356 doesn't make sense in the 3.5 branch,
> and setting it to 351 in the 3.5 branch would collide with the 351
> bump in main having a different meaning.
> 
> The way out is, your patch should not bump CYGWIN_VERSION_API_MINOR
> at all.  Rather, just add a comment to version.h. There's already the
> note preceding the definition of CYGWIN_VERSION_API_MAJOR:
> 
>    Note that we forgot to bump the api for ualarm, strtoll, strtoull,
>    sigaltstack, sethostname. */
> 
> Just add the pthread_sigqueue bugfix here if you like, along the lines of
> 
>    Note that fixing the first pthread_sigqueue argument did not bump the api.
> 
> Alternatively we could just go ahead without touching version.h.

I like the latter alternative best.  v4 incoming shortly...

>> Reported-by: Christian Franke <Christian.Franke@t-online.de>
>> Addresses: https://cygwin.com/pipermail/cygwin/2024-September/256439.html
>> Signed-off-by: Mark Geisert <mark@maxrnd.com>
>> Fixes: 2041af1a535a (cygwin.din (pthread_sigqueue): Export.)
> 
>    $ git show 2041af1a535a
>    fatal: ambiguous argument '2041af1a535a': unknown revision or path not in the working tree.
>    Use '--' to separate paths from revisions, like this:
>    'git <command> [<revision>...] -- [<file>...]'
> 
> Shouldn't that be 50350cafb375?  The Fixes commit message text is
> supposed to be set in quotes,btw.:
> 
>    Fixes: 50350cafb375 ("* cygwin.din (pthread_sigqueue): Export.")

Of course, on the formatting.  Re incorrect hash: I must have flubbed 
the copy/paste from cgit by pointing at the wrong thing.  I'll verify 
where I went wrong there.

> Other than the above points, the patch itself is fine.

Thank you for the review.

..mark
