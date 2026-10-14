Return-Path: <SRS0=2D/O=IE=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id DC8EE4BA2E06
	for <cygwin-patches@cygwin.com>; Wed, 14 Oct 2026 07:49:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DC8EE4BA2E06
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DC8EE4BA2E06
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1791964174; cv=none;
	b=AS2cE2RxGBTy6SNSEZOyum9azE2ZEOvo0F65AX1bwcsSjbiRwgJ34djya4JCR4Bw/sGOUYcx5jQcJxlxFzUzveR0yzGvjJhjKZOeAsI3OzIkSLcv1toXFyCnFTHxwoeVoZD8NCpDGzjZ8+mDEYrjhX8yAjE1WmlAog4IX6IM0hA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1791964174; c=relaxed/simple;
	bh=QZCaZBX38zmzb0EXVELwYvYip06VsNmvrCAodP+b3X8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=WrolY+NF4xodRKeucfPut83NKeKKlhSLdaTuNsT5Q/+RYE0Tj8I1aA72wAnab78b4YtP4vDxcgrSwXspwQcz3saRwPmGOWgmZsbr9WlBy0Tp43xDttmvJCeJ/aWtA+WfiuWipEq+7BSsL4yA6SQYd6HymzcrAF+Vx2DNgQWHEL8=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DC8EE4BA2E06
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 69E832ZV009460
	for <cygwin-patches@cygwin.com>; Wed, 14 Oct 2026 01:03:02 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdvqHYWJ; Wed Oct 14 01:02:55 2026
Message-ID: <162a3cb8-fdfd-47bb-9bed-4f7b0621743c@maxrnd.com>
Date: Wed, 14 Oct 2026 00:49:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Porting "Cygwin: Handle uids/gids correctly on NFSv4 filesystems"
 to Cygwin 3.6? Fwd: [PATCH] Cygwin: Handle uids/gids correctly on NFSv4
 filesystems
To: cygwin-patches@cygwin.com
References: <20260920035524.60008-1-mark@maxrnd.com>
 <CAPJSo4UaKfnUZCB1zjYD1mVXzUcE38c+e_Nu2QTXH0VJUg_k0g@mail.gmail.com>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <CAPJSo4UaKfnUZCB1zjYD1mVXzUcE38c+e_Nu2QTXH0VJUg_k0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Lionel,

On 10/13/2026 11:24 PM, Lionel Cons wrote:
> Can this patch please be ported to Cygwin 3.6-branch? The scope,
> impact and risk is clearly defined as being limited to NFSv4
> filesystems. As the current code in Cygwin3.6-release does not work
> with NFSv4 filesystems this patch would fix things without impacting
> anything else.
> 
> Lionel
> 
> ---------- Forwarded message ---------
> From: Mark Geisert <mark@maxrnd.com>
> Date: Sun, 20 Sept 2026 at 05:55
> Subject: [PATCH] Cygwin: Handle uids/gids correctly on NFSv4 filesystems[...]

I have no objection to that request.  As 3.6.11 was released just a 
couple weeks ago, you would need to run an as-yet-unplanned pre-3.6.12 
test release to obtain the fix.

I'm checking off-line to see how much further the 3.6.x train is planned 
to go.  I will backport the patch, if I can, after I get the answer.

..mark
