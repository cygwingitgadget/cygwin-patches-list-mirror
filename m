Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 04B01385771C; Mon, 21 Aug 2023 08:20:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 04B01385771C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1692606035;
	bh=3nc5vWJnALELGuDV1kOpil+m4EH60V4K+BVP4pGM9jI=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=UfcySLMbc6qzPeLuEd0wU5dRXfV1f9PWIiYHvkQIlSUKwPXvLTipSpKBj1Vx6EiM3
	 x7JkVCjUOtme5WknfmIkOrGndMUTGGviY5f2TOt+sAQTtkpjKdjgfde6mEuVdljVKt
	 zwjjnKayCew0GNMsEa+Bp865KzkrRyh36kzz8BQM=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 43A35A80BD1; Mon, 21 Aug 2023 10:20:30 +0200 (CEST)
Date: Mon, 21 Aug 2023 10:20:30 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Fix failure to clear switch_to_nat_pipe
 flag.
Message-ID: <ZOMeTorrvdScqcZ2@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230819060739.898-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230819060739.898-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Aug 19 15:07, Takashi Yano wrote:
> After the commit fbfea31dd9b9, switch_to_nat_pipe is not cleared
> properly when non-cygwin app is terminated in the case where the
> pseudo console is disabled. This is because get_winpid_to_hand_over()
> sometimes returns PID of cygwin process even though it should return
> only PID of non-cygwin process. This patch fixes the issue by adding
> a new argument which requests only PID of non-cygwin process to
> get_console_process_id().

How critical is that? Do we need a 3.4.9 asap, or can we wait and
collect a few more bugfixes first?


Thanks,
Corinna
