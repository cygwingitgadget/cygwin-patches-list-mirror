Return-Path: <cygwin-patches-return-10071-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 92117 invoked by alias); 17 Feb 2020 09:46:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 91910 invoked by uid 89); 17 Feb 2020 09:46:04 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-5.5 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: conssluserg-01.nifty.com
Received: from conssluserg-01.nifty.com (HELO conssluserg-01.nifty.com) (210.131.2.80) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 17 Feb 2020 09:46:02 +0000
Received: from Express5800-S70 (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conssluserg-01.nifty.com with ESMTP id 01H9jfZP028468	for <cygwin-patches@cygwin.com>; Mon, 17 Feb 2020 18:45:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 01H9jfZP028468
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1581932741;	bh=sQhEI72LsKveUEv3nsEzL48OulXYJsAkgQjHA5RNDdw=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=Nf7xDcQc0Q16H+6A+1MVBAtGlXAL7DqU1G8e4EJbJqLSwjxPagfiOWA7cPNOFSE5l	 KBG3r/z5qV0hCmpzXVz9VrACEjTK2KTZXG7GZp7KyRpje5c5Ex155qppyQgJKPcy5V	 YE96qYTm4F9lRql23pFSbRZjX3W/6/pWlM1Fethe3xNYmIcw6CbLuov3X3q483cmRV	 rN+O3lRz7hrjSHlqe9B70mKdnkFdy+MfMwJHCzE5tYUBdu5YZZcqdCra4gzOO/0Rt6	 Hf21KHwGNbyQyzUMqBL1fnxRnNJ9+74Nw4c/Obpqd6kUSTeCnV6zaZN5M/w7P+BEWE	 ivuMTZhH5NdFQ==
Date: Mon, 17 Feb 2020 09:46:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Change timing of set/unset xterm compatible mode.
Message-Id: <20200217184545.43be636858734d029f2f5a11@nifty.ne.jp>
In-Reply-To: <20200217090015.GB4092@calimero.vinschen.de>
References: <20200216081322.1183-1-takashi.yano@nifty.ne.jp>	<20200217090015.GB4092@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00177.txt

On Mon, 17 Feb 2020 10:00:15 +0100
Corinna Vinschen wrote:
> On Feb 16 17:13, Takashi Yano wrote:
> > - If two cygwin programs are executed simultaneousley with pipes
> >   in cmd.exe, xterm compatible mode is accidentally disabled by
> >   the process which ends first. After that, escape sequences are
> >   not handled correctly in the other app. This is the problem 2
> >   reported in https://cygwin.com/ml/cygwin/2020-02/msg00116.html.
> >   This patch fixes the issue. This patch also fixes the problem 3.
> >   For these issues, the timing of setting and unsetting xterm
> >   compatible mode is changed. For read, xterm compatible mode is
> >   enabled only within read() or select() functions. For write, it
> >   is enabled every time write() is called, and restored on close().
> 
> Oh well, I was just going to release 3.1.3 :}
> 
> In terms of this patch, rather than to change the mode on every
> invocation of read/write/select/close, wouldn't it make more sense to
> count the number of mode switches in a shared per-console variable, i.e.
> 
> LONG shared_console_info::xterms_mode = 0;
> 
> on open:
> 
>   if (InterlockedIncrement (&xterm_mode) == 1)
>     switch to xterm mode;
> 
> on close:
> 
>   if (InterlockedDecrement (&xterm_mode)) == 0)
>     switch back to compat mode;
> 
> ?

Thanks for the advice. However this unfortunately does not work
in bash->cmd->bash case.
For cmd.exe, xterm mode should be disabled, however, the second
bash need xterm mode enabled.

On Mon, 17 Feb 2020 10:28:19 +0100
Corinna Vinschen wrote:
> On second thought, also consider that switching the mode and
> reading/writing is not atomic.  You'd either have to add locking, or you
> may suffer the same problem on unfortunate task switching.

Hmm, it may be. Let me consider. It may need time, so please
go ahead for 3.1.3.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
