Return-Path: <SRS0=8Q9v=64=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id B1A314BA2E04
	for <cygwin-patches@cygwin.com>; Mon, 22 Dec 2025 01:32:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B1A314BA2E04
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B1A314BA2E04
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766367135; cv=none;
	b=M9dSJB79MZZ5B3YJ+yrMN2G9OPyLY5TkTbYDJTxiZUV+Q/E2R8Z6IrNrFKjxmBJQQJJXvCHjASJ/zOesY/BGR6mN0el/6AA2f5NeQieMK3TClEBmjbRcx5VFZV9Ppr2zut7lmHAD3yB6IgTMcQJWkPMxwWUR5JG0kZYXOgCTNU8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766367135; c=relaxed/simple;
	bh=MstLdm9G8bpBSjmWf6C6WFGadsaQyGmEKEjZQZ2a520=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=lyljxxX0jb3JzOKUdV+AAOjsjfuUXEn8oqXLFVVzSVykwPUW32Fpe9AdTFGkuiNO9W3pk/i5QWwMNTmcrRZYPN3paj1MEH3txtGtL3XzWsnHemrJUuO8gyn2rMle5TznmN6fRQjqj4VEsbu6Mj5GSO0dJNM3zMyLPgnazGtW0xU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B1A314BA2E04
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 5BM1gEmF088755
	for <cygwin-patches@cygwin.com>; Sun, 21 Dec 2025 17:42:14 -0800 (PST)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdmiNPoP; Sun Dec 21 17:42:06 2025
Message-ID: <a8f84af2-409a-4afa-a78a-94727071f672@maxrnd.com>
Date: Sun, 21 Dec 2025 17:32:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] Cygwin: uinfo: correctly check and override
 primary group
To: cygwin-patches@cygwin.com
References: <20251218112308.1004395-1-corinna-cygwin@cygwin.com>
 <20251218112308.1004395-2-corinna-cygwin@cygwin.com>
 <20251221192038.25aa53bf2575e30a79a8a505@nifty.ne.jp>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <20251221192038.25aa53bf2575e30a79a8a505@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi folks,
A small spelling correction is needed; shown below...

On 12/21/2025 2:20 AM, Takashi Yano wrote:
> On Thu, 18 Dec 2025 12:23:05 +0100
> Corinna Vinschen wrote:
>> From: Corinna Vinschen <corinna@vinschen.de>
>>
>> Commit dc7b67316d01 ("Cygwin: uinfo: prefer token primary group")
>> broke the code overriding the primary group in two different ways:
>>
>> - It changed the way myself->gid was set before checking its value.
>>
>>    Prior to dc7b67316d01, myself->gid was always set to the primary group
>>    from the passwd entry (pw_gid).  With the patch, it was set to the
>>    primary group from the Windows user token (token_gid) in the first
>>    place.
>>
>>    The following condition checking if pw_gid is different
>>    from token_gid did so, by checking token_gid against myself->gid,
>>    rather than against pw_gid.  After dc7b67316d01 this was always
>>    false and the code block overriding the primary group in Cygwin and
>>    the Windows user token with pw_gid was never called anymore.
>>
>>    The solution is obvious: Do not check token_gid against myself->gid,
>>    but against the desires primary GID value in pw_gid instead.
>>
>> - The code block overriding the primary group simply assumed that
>>    myself->gid was already set to pw_gid, but, as outlined above,
>>    this was not true anymore after dc7b67316d01.
>>
>>    This is a subtil error, because it leads to having the wrong primary
                 ^^^^^^
                 subtle

..mark
