Return-Path: <SRS0=/TCY=AV=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 9D0054BAD168
	for <cygwin-patches@cygwin.com>; Tue, 17 Feb 2026 09:26:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9D0054BAD168
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9D0054BAD168
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1771320409; cv=none;
	b=LbbQss6aqGcwOf/egzjpPzGMVptD+PguTO7b7xotNWJCLX1bqV4KzVdnASIt5n3EFvlR9eGOaiF7966Ie/vCkx0FY4TcDpz9NJr3vXRazOVK0tJgpu/0Hcvgs8QhfsBNsVXtN/0hvuVc5MpJrVnChUbAWaLkD3MafQbte+WpBiA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1771320409; c=relaxed/simple;
	bh=dEJ7dHBGMk6aZ9WjFnL69iUUVM8jk0lv98lQqtAsDUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=OPXKAAwGPozKaArTrpBZ72jVjjm8GqDbtR1Sh45n8Dj3125PTX+5h2G2f2eGFGwMZo7Us5E24Ndg7POLiNBlIEtfMmixEXmr/EAduoUX2cUNnZt+jCH9/lhFmJdgEpO3lEuPKaeBxUn3A5/cfuRvk+1BXSc4/5q5nztEqWFUkRc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9D0054BAD168
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 61H9a3O5025273
	for <cygwin-patches@cygwin.com>; Tue, 17 Feb 2026 01:36:03 -0800 (PST)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdffWfvV; Tue Feb 17 01:35:54 2026
Message-ID: <b3b833d3-3a4a-4668-a017-b5e3d2651403@maxrnd.com>
Date: Tue, 17 Feb 2026 01:26:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Rewrite rlimits using OS job objects
To: cygwin-patches@cygwin.com
References: <20260126111345.386303-1-corinna-cygwin@cygwin.com>
 <aY97v9UZOl12UOeK@calimero.vinschen.de>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <aY97v9UZOl12UOeK@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2/13/2026 11:30 AM, Corinna Vinschen wrote:
> Ping?
> 
> Anybody willing to review?
I'll review this. I've started looking into it.
Don't let that stop anybody else from doing so too :-)

..mark
