Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 1FCE03858404; Wed, 27 Nov 2024 17:01:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1FCE03858404
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1732726892;
	bh=xYjVrbqUkYJBvUF1Gmu67l8wBFsag433k5kfa4nzSrw=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=lIo3nTzImqcmBDZS79sTpTgLFJq/VhrOPlrhZcnmuqpKCgTiQJtmJtTCFDL2KtL2T
	 ciMU83xzdqNWn5T/lHaU9Vcfa54SMLVwm4con7ngeyx4zVo7rJ8hUcu4bc65GwZb0t
	 vaJKrIllTejdSxMwCnigGqa9YlY40pClyG7sZ3tI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id E3889A80E4D; Wed, 27 Nov 2024 18:01:29 +0100 (CET)
Date: Wed, 27 Nov 2024 18:01:29 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/7] Fix issues when too many signals arrive rapidly
Message-ID: <Z0dQaXYCFSet-Zv7@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241126085521.49604-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241126085521.49604-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Nov 26 17:54, Takashi Yano wrote:
> Takashi Yano (7):
>   Cygwin: signal: Fix deadlock between main thread and sig thread
>   Cygwin: signal: Handle queued signal without explicit __SIGFLUSH
>   Cygwin: signal: Cleanup signal queue after processing it
>   Cygwin: signal: Optimize the priority of the sig thread
>   Cygwin: signal: Drop unnecessary queue flush
>   Cygwin: cygtls: Prompt system to switch tasks explicitly in lock()
>   Cygwin: Document several fixes for signal handling in release note

For the time being, patches 1, 2 and 5 are already good to go.

Thanks,
Corinna
