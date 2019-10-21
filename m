Return-Path: <cygwin-patches-return-9770-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 46436 invoked by alias); 21 Oct 2019 10:55:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 46426 invoked by uid 89); 21 Oct 2019 10:55:30 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=UD:jp, proxy, D*jp, HDKIM-Filter:v2.10.3
X-HELO: conssluserg-02.nifty.com
Received: from conssluserg-02.nifty.com (HELO conssluserg-02.nifty.com) (210.131.2.81) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 21 Oct 2019 10:55:29 +0000
Received: from Express5800-S70 (ntsitm355024.sitm.nt.ngn.ppp.infoweb.ne.jp [175.184.70.24]) (authenticated)	by conssluserg-02.nifty.com with ESMTP id x9LAtCxs028991	for <cygwin-patches@cygwin.com>; Mon, 21 Oct 2019 19:55:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x9LAtCxs028991
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1571655312;	bh=rGqQOUT8CimztnnhMNjqRe1wIE4mDNLusQ+8wr+CLms=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=JeWt0Gup4zA0BnssXG/5clGBQcMzp1JDUKf84WNUqBn8pwMGWOpI3HklnHFCCHUVV	 GCEHIpL48efdSJDzL6cyCE5x/VvHqnL9KE6dGIIIhHU2QL9XaMB+hJV3YNyjF0dSIK	 LkALs5cmr3llI5EDQwQ2zX0xFpzmdxVVHOw5/lHNYcLfwj+GOOib5kf3XnlAZpuKtA	 0ldQwPJTgMFyuFYwwX/sQa3cli3+GjciKGlyK8yWDTAqUeihkRGbe1BwJUlpJSsc4E	 1NJA80LFt6Kv7isjGh6noqFxhrD5MWINCBoKQYGeI/Dff2XK7CbcL9WMsxb3RIRMX6	 ol7k4ZL3dH36g==
Date: Mon, 21 Oct 2019 10:55:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Disable clear screen for ssh sessions with -t option.
Message-Id: <20191021195515.7ca1a3a7f7f85cca79ad80b0@nifty.ne.jp>
In-Reply-To: <20191021094356.GI16240@calimero.vinschen.de>
References: <20191018113721.2486-1-takashi.yano@nifty.ne.jp>	<20191018143306.GG16240@calimero.vinschen.de>	<20191019085051.4d2cc80811854d21b193fed6@nifty.ne.jp>	<20191021094356.GI16240@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00041.txt.bz2

On Mon, 21 Oct 2019 11:43:56 +0200
Corinna Vinschen wrote:
> So it seems cmd.exe is the only (or one of few) native CLI tools
> actually trying to manipulate the screen buffer.  And what it does is
> not so much clearing the screen, but to align buffer line 1 with the top
> of the screen, even if line 1 has been produced before cmd.exe started.

Powershell also redraws the screen.
netsh is even worse. The cursor position will be broken by the follwing
steps.

1) env TERM=dumb script
2) netsh
3) winhttp show proxy

> Other than that, my very personal opinion here is, not clearing the
> screen is more desired than the terminal type and application name (or
> SID) hacks just to pamper cmd.exe.  Others may disagree, so I'm open to
> discussion.

Even with Microsoft-provided OpenSSH server, the screen is cleared
upon login. Therefore, clearing screen is not so strange, I suppose.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
