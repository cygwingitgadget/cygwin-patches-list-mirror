Return-Path: <SRS0=JKSM=G3=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 281D23858D20
	for <cygwin-patches@cygwin.com>; Tue, 14 Nov 2023 08:58:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 281D23858D20
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 281D23858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1699952286; cv=none;
	b=UfcB8AX+xcqW5Htf0QNul+QXX+QSIqz9OBrXw2CO0ch+rpMjnq//p2TPSr7Bl8vAvMPkqAhUcb9TwnB5zefUk9wAKqBVBnxwgp+lGX90NDvWPCuRHpdH1cESdarxyhwQtuKLHFbAY/rTk9KpM+qnqHJLx938q/ZStLXyqM2GZTs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1699952286; c=relaxed/simple;
	bh=YzAU7+IGzTLss83sGs5I038z6lLwybVE3DPxNmOwn4A=;
	h=Date:From:To:Subject:Message-ID:MIME-Version; b=WipeoesKIiC3k2Ovs4SAxODEjhRk8RWO+l+hu1J0Rszq67y3AuQ6z59x+1sPMOZzJKVlmotWjooB86JxYNT/hMg1YpL7ixgAhuPfpsb34J5apD7pgqrmsb+j+LOMSC/h37dwvUCF9x4Fpk9xgYgKpTtNLK2hjDrrMNx33xtq7y0=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost (mark@localhost)
	by m0.truegem.net (8.12.11/8.12.11) with ESMTP id 3AE8vUbL011620
	for <cygwin-patches@cygwin.com>; Tue, 14 Nov 2023 00:57:30 -0800 (PST)
	(envelope-from mark@maxrnd.com)
X-Authentication-Warning: m0.truegem.net: mark owned process doing -bs
Date: Tue, 14 Nov 2023 00:57:30 -0800 (PST)
From: Mark Geisert <mark@maxrnd.com>
X-X-Sender: mark@m0.truegem.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Fix profiler error() definition and usage
In-Reply-To: <ZVJXISABdv5P8pqw@calimero.vinschen.de>
Message-ID: <Pine.BSF.4.63.2311140055190.11286@m0.truegem.net>
References: <20231113094622.6710-1-mark@maxrnd.com> <ZVJXISABdv5P8pqw@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,SPF_HELO_NONE,SPF_NONE,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On Mon, 13 Nov 2023, Corinna Vinschen wrote:
> On Nov 13 01:46, Mark Geisert wrote:
>> Minor updates to profiler and gmondump, which share some code:
>> - fix operation of error() so it actually works as intended
>> - resize 4K-size auto buffer reservations to BUFSIZ (==1K)
>> - remove trailing '\n' from 2nd arg on error() calls everywhere
>> - provide consistent annotation of Windows error number displays
>>
>> Fixes: 9887fb27f6126 ("Cygwin: New tool: profiler")
>> Fixes: 087a3d76d7335 ("Cygwin: New tool: gmondump")
>> Signed-off-by: Mark Geisert <mark@maxrnd.com>
>
> Looks good basically, but I noticed some minor problem already
> in the former version of this code:
>
>> @@ -650,7 +652,7 @@ ctrl_c (DWORD)
>>    static int tic = 1;
>>
>>    if ((tic ^= 1) && !GenerateConsoleCtrlEvent (CTRL_C_EVENT, 0))
>> -    error (0, "couldn't send CTRL-C to child, win32 error %d\n",
>> +    error (0, "couldn't send CTRL-C to child, Windows error %d",
>>             GetLastError ());
>>    return TRUE;
>
> GetLastError returns a DWORD == unsigned int. %u would be the
> right format specifier.  Care to fix that, too?

Thanks for catching this.  Patch v2 is incoming, and it includes a
relnote for 3.4.10.
Cheers & Regards,

..mark
