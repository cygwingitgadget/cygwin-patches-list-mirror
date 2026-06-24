Return-Path: <SRS0=WipY=EU=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 80CBA4BA2E04
	for <cygwin-patches@cygwin.com>; Wed, 24 Jun 2026 07:14:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 80CBA4BA2E04
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 80CBA4BA2E04
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782285265; cv=none;
	b=tZBbFBBH2lgm3/37R+tg+oOm270qXlDzYhENr7HjF0sA/yT5DxhA8jwa+w9JFqbW47mdVNeAEPN95ewdfIeRfB7D2Q4NV83wk1EsdnvIkMfvj3DymhDqc932ZzOPxx++VX81ptkzYbLMgHVYk0j0XKC+oJYpmC9l/PgtB8H1YGw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782285265; c=relaxed/simple;
	bh=ckivO2QeAq3Dd/CbqIMNpPHgFzpwABCEifbE1rsqQfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=n1mugDVmTtGJj4rhdv8OndgMXNllp8tXmvhmZRmpd+Phb+WLJ2DL5ZyntqBb4DnDqq1PqAamfrZYPIQn3Niw4dyr8MC7OaE7ztHTexX+2Rpoxeko67Fa9/YALpO/jHWfrbShdweR4zClbQdUV0iF1IFMMzSmNoh7Lf7gLach1uA=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 80CBA4BA2E04
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 65O7TQi8038030
	for <cygwin-patches@cygwin.com>; Wed, 24 Jun 2026 00:29:26 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdXxZInw; Wed Jun 24 00:29:21 2026
Message-ID: <69c93160-c59a-4403-908a-56971df01ca2@maxrnd.com>
Date: Wed, 24 Jun 2026 00:14:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: pty: Treat CR/NL in accept_input() the same as in
 transfer_input()
To: cygwin-patches@cygwin.com
References: <20260612124728.38921-1-takashi.yano@nifty.ne.jp>
 <e24b66b2-4518-4fff-8b05-1fb349a1b491@maxrnd.com>
 <20260623220407.824a42b50f122e2cd31fe462@nifty.ne.jp>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <20260623220407.824a42b50f122e2cd31fe462@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On 6/23/2026 6:04 AM, Takashi Yano wrote:
> Hi Mark,
> 
> Thanks for reviewing!
> 
> On Tue, 23 Jun 2026 00:41:11 -0700
> Mark Geisert wrote:
>> Hi Takashi,
>>
>> On 6/12/2026 5:47 AM, Takashi Yano wrote:
>>> In transfer_input(), CR and NL in the data transferred to nat-pipe
>>> is treated as follows:
>>>     1) If pseudo console is activated, convert NL to CR.
>>>     2) If pseudo console is disabled, convert CR to NL.
>>> This conversion is necessary to ensure non-cygwin apps can handle
>>> CR/NL as expected. Therefor, CR and NL should be treated as the
>>> same way in accept_input() if the data is sent to nat-pipe.
>>
>> The above block is fine.
>>
>>> Usually, when pseudo console is activated, the input data for non-
>>> cygwin app is not treated by accept_input. However, accept_input()
>>> handle the input data in pseudo console enabled mode, only in a
>>> very short duration when pseudo console is about to setup, because
>>> master::write() calls line_edit() in the pcon_start mode. If pseudo
>>> console is disabled, accept_input() handles them, however usually
>>> ICRNL flag is set, so line_edit() do this conversion. However, if
>>> this flag is not set, the conversion added by this patch is needed
>>> as well.
>>
>> This block I'm having a bit of trouble to follow.  Can you possibly
>> reword to describe it in more orderly fashion?
> 
> What about:
>    In the previous implementation, problems rarely occurred because
>    accept_input() normally does not handle input for non-cygwin apps
>    when the pseudo console is active. Under typical conditions, such
>    input is snet to pseudo console directly by WriteFile(), so
               ^^^^
>    accept_input() is not involved and no onversion issues arise.
                                            ^^^^^^^^^
> 
>    There is, however, a brief period during pseudo console initialization
>    in which accept_input *does* handle the input. This happens because
>    master::write() invokes line_edit() while in pcons_start mode. During
>    this short window, the input is processed in pseudo-console-enabled
>    mode, and the usual conversion behaviour may not apply.
> 
>    When the pseudo console is disabled, accept_input() always handles
>    the input, and in most cases the ICRNL flag is set by shell, so
>    line_edit() performs the CR->NL conversion. But if the flag is not
>    set, this conversion does not occur. Therefore, the additional
>    conversion introduced by this patch is required to ensure consistent
>    behaviour in both cases.

Much better!  Please fix the minor typos indicated and it will LGTM.
OK to push.

..mark
