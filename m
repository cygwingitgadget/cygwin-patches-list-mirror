Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 915D83858D35; Thu, 31 Oct 2024 19:14:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 915D83858D35
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1730402073;
	bh=lXf1ObfP4OPY6SSx+2844JU8dH3XPj/h+8QhOHNtHRQ=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=GnDRUYKR3XyAehTC8lveh3g1oijB298aU1PaHKHr7+8FpsZIcxqsd1w3fFxW/Xgd6
	 6QeKkywVVgjtDdsI+5pWR1y6Qeo9n/xhPNgN7AiHzMDFPnM3nKueWonAKZdhot9wKO
	 SxkL0jk7HXx+OlC1pcotHQ1Tv1gpeESCybPSE16A=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 57097A80BEF; Thu, 31 Oct 2024 20:14:08 +0100 (CET)
Date: Thu, 31 Oct 2024 20:14:08 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v8] Cygwin: pipe: Switch pipe mode to blocking mode by
 default
Message-ID: <ZyPXAHDCVfsUgKf0@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241024175845.74efaa1eb6ca067d88d28b51@nifty.ne.jp>
 <ZxofkPUww7LOZ9ZB@calimero.vinschen.de>
 <20241027175722.827ae77c67c88a112862e07e@nifty.ne.jp>
 <Zx9fk6yQ1etCVwek@calimero.vinschen.de>
 <20241028202301.7499a9f04335f362c72310db@nifty.ne.jp>
 <20241028202516.0dd4c86cb2efa9f7db8c856d@nifty.ne.jp>
 <Zx98ETE7E1DMGirF@calimero.vinschen.de>
 <20241031173642.34cf4980cea2276e7402c4d2@nifty.ne.jp>
 <ZyNY36rwRtAVglBP@calimero.vinschen.de>
 <20241101015033.f3c40670d8c48eff1c0a549c@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241101015033.f3c40670d8c48eff1c0a549c@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Nov  1 01:50, Takashi Yano wrote:
> On Thu, 31 Oct 2024 11:15:59 +0100
> Corinna Vinschen wrote:
> With your latest patch, my v9 patch works as expected.
> 
> $ ./a.exe 40000 1
> pipe capacity: 65536
> write: writable 1, 40000 25536
> write: writable 1, 24576 960
> write: writable 0, 512 448
> write: writable 0, 256 192
> write: writable 0, 128 64
> write: writable 0, 64 0
> write: writable 0, -1 / Resource temporarily unavailable
> 
> Thanks!
> 
> Any other suggestions for v9 patch?

No, just go ahead (as with the sigfe patches if that wasn't clear from
my mail earlier today).


Thanks,
Corinna
