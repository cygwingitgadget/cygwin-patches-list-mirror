Return-Path: <SRS0=/CNS=XB=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e02.mail.nifty.com (mta-snd-e02.mail.nifty.com [106.153.227.178])
	by sourceware.org (Postfix) with ESMTPS id 6C20D385841C
	for <cygwin-patches@cygwin.com>; Tue, 15 Apr 2025 07:40:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6C20D385841C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6C20D385841C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.178
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1744702834; cv=none;
	b=i0ceptJlTj1ZopsVvUkqxm/D8WA9U4X4kCIqoTeei/UTgsTOm6CZh+lcGgtaJf+QOmznRSyyOwlf2mjzyp2FbMNXdLQhzt07eCm7/toGU8KBT1dwaV/oKjLBIyHCjK8JF/zMUCExHk5EM+pkDXv1jDlvMjmQ5r7mrZGJzU3UeNo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1744702834; c=relaxed/simple;
	bh=U9j7iIFeJeTPTmIdu/vLqmB5z30efmyo4ru782kwmBs=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=LmhRSHcKkjGSDEKkGiIgwqx62J82Lr30vlfcU3y/6H1990TG7N/ydYuO6iTd+ZixzMK2wiCtG/ts9zRivDjp3sSMJvgHbHNOwhi/KG/3LRBTwyAD0rjh2osAjZd3oI2CPQMI3oaaz6ncrgUdVRPW6eMb9xqHyB+OQZyskMtN+ac=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6C20D385841C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=mwoVMQWH
Received: from HP-Z230 by mta-snd-e02.mail.nifty.com with ESMTP
          id <20250415074031101.BKPY.120311.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 15 Apr 2025 16:40:31 +0900
Date: Tue, 15 Apr 2025 16:40:29 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: kill(1): skip kill(2) call if '-f -s -' is used
Message-Id: <20250415164029.c118309bc33c25f4b404b48d@nifty.ne.jp>
In-Reply-To: <16c95bad-2310-e66c-d538-403321033d2c@t-online.de>
References: <16c95bad-2310-e66c-d538-403321033d2c@t-online.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1744702831;
 bh=XinMSq9lGXRvo7sk5I7VXZMYbKqkRRHn9CUs+rKX468=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=mwoVMQWHmi4+hJYSjnHxh/A49RVACMSVFCpsJDSG29Q+LPQiwpZ1dv7N2PsOzqoKFXumNVKr
 2hwlQIJJgSjbQmCo068UJ2PW7q+j3YpZV8hdqDlcq1gXo5Yu0N16MFzDwbcLGY3a9DAfXTtoH2
 Ih7WtuvcnUr9MHl1NeQR/MzPSL2PNhBYRlkfzzK2QFxMTeZXsxJIzAJ9OoS/gB+G01lNIqHBs7
 goLuDbxI43YQtOXjl/8nA64pR2vGiWJDsyE1q7hlc7Cf6BG1DOyg/hhk50YHCVvAt4oL+MU7v3
 nOXYjM6EUKfDd0kbVI0FMPEAebffGGl8VciY6LnkPn/gn9mA==
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Christian,

On Fri, 11 Apr 2025 16:46:07 +0200
Christian Franke wrote:
> In rare cases, '/bin/kill -f PID' hangs because kill(2) is always tried 
> first. With this patch, this could be prevented with '/bin/kill -f -s - 
> PID'.

I wonder why kill(2) hangs. Do you have any idea?
If kill(2) hangs in some cases, shouldn't we fix that
rather than patching to kill(1)?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
