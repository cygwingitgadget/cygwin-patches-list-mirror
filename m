Return-Path: <SRS0=rmVK=2E=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id F17753858D26
	for <cygwin-patches@cygwin.com>; Wed, 23 Jul 2025 10:55:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org F17753858D26
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org F17753858D26
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753268139; cv=none;
	b=IORcCF/HxPTDLoVDz6AJ7CzcU/Kum6n3cFOBq1eyHVz8PsN8MGfP/xkVeJyI+I/jONngd8BudB6BE3dqUjurf3MQmBQi7itEjv3heFCtFcYltlHMb7wnHlIXthj1caOp7xxTbjVibRMdCMiMkxh7xL8qd10OXU4yP20uC7K4YfM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753268139; c=relaxed/simple;
	bh=JyuqbFURUOfDVBFqYRu/wpKNl2OYvNPxCjD2tN7FRng=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=L9dyaH9mDMfq9F195ccfl8USG8MzqcHp65DqXub4bJJnvPMk4AjxkV7DzF9LeXs9X8v7YJHSrGi8GmmzsGYsb3QWUltdHoZsqAcO+qYD2gyXxOAdgLybAyyZCaQDHv2TgB58m6fMP+2gPB3UEeMnx6TnTHSWPt+fk0UUsPUiI2w=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F17753858D26
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Dveg4eLt
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20250723105536723.RLTU.127398.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 23 Jul 2025 19:55:36 +0900
Date: Wed, 23 Jul 2025 19:55:36 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: process_fd: Fix handling of archetype fhandler
Message-Id: <20250723195536.5783866c1683727f0ca49fb1@nifty.ne.jp>
In-Reply-To: <aIClgpTaJ_6khEmq@calimero.vinschen.de>
References: <20250722123240.349-1-takashi.yano@nifty.ne.jp>
	<aIClgpTaJ_6khEmq@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1753268136;
 bh=Pvg0MmDZDVlT8EuwczR1HQ1+10yhhkRRbfgYfOQxxfo=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=Dveg4eLtJXdKgk4C0khbGJPhbHkl7udW0HB2yTLsEvWwn0nCBSa1sOUFQjKZUeGhzgHpyPuN
 FQ3V47ZauY/ZXg4xYl39wDyx5gSQfDfU6i32vJIqIgLN0GCnnMEJ+5UCcXEgkTU6hcLLNEZfwR
 8faSGkDNhXQuVazDdsG9BQwAvvaP5KKEtUXr1Z2zzKtciwUKGwcWttAiCpxfgLk+3fXKmXzkVR
 MBJmnVLvL/dVKtFgHT+2p/HNRS8ouGNUK/o6ANpG5M2Nj/t8glRj+3y/thqS+sxFyHrQoSaKLw
 UXvqUfJf02nXkyn0rE4ZbB2VkyHFXNG5SmeUu6+VsHOBIrMA==
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 23 Jul 2025 11:04:02 +0200
Corinna Vinschen wrote:
> On Jul 22 21:32, Takashi Yano wrote:
> > Previously, process_fd did not handle fhandler using archetype
> > correctly. Due to lack of PC_OPEN flag for path_conv, build_fh_pc()
> > could not initialize archetype. Because of this bug, accessing pty
> > or console via process_fd fails.
> > 
> > With this patch, use build_fh_name() with PC_OPEN flag instead of
> > build_fh_pc() to set PC_OPEN flag to path_conv.
> 
> Your patch fixes the issue, ok, but I don't understand why this occurs.
> 
> If the process opens /proc/PID/fd/N with PID != MYPID, it uses the
> PICOM_FILE_PATHCONV commune request.  It copies the path_conv member
> of the fd from the target process and this pc is used in the
> build_fh_pc() call.
> 
> And here's what I don't get: If the pc has been fetched from a valid,
> open file descriptor in the target process, why is the PATH_OPEN
> flag not set?

Thanks for reviewing.

I looked into open process, and noticed that this is because fh_alloc()
called from build_fh_name() does not copy argument pc.path_flags to
fh->pc.path_flags.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
