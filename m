Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 2B3643857830; Thu, 31 Oct 2024 17:08:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2B3643857830
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1730394497;
	bh=6zoELaGtKFD5joCyb7FNzDmYUJ/Turcb0xkVworNQRs=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=Dluare/qbcVxRFsoD6RceJddeNTNf0KOrjIfqoDmRTOuzVPS4yWPJ1RCYvbJcY6sD
	 Sa7xSueXxrv/xXHAuOqslql8BHwfjDjzdKHdFsso/LnU6eg4I/byFume4/GPqFuOsI
	 X3wPc+1/cGygUaB154KHExicecWHfca6qZU+TxLY=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 722C3A80BEF; Thu, 31 Oct 2024 18:08:14 +0100 (CET)
Date: Thu, 31 Oct 2024 18:08:14 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v8] Cygwin: pipe: Switch pipe mode to blocking mode by
 default
Message-ID: <ZyO5fo1Q7SNj59pn@calimero.vinschen.de>
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
 <20241101013449.24ab0ac8929133f7af12220e@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241101013449.24ab0ac8929133f7af12220e@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Nov  1 01:34, Takashi Yano wrote:
> On Thu, 31 Oct 2024 11:15:59 +0100
> Corinna Vinschen wrote:
> > Do you get a different result?  Do you run this on an AMD CPU perhaps,
> > and the AMDs implement the SAL instruction differently?
> 
> BTW, how could you know I am using AMD cpu? :)

Magic!!!

> $ cat /proc/cpuinfo | grep 'model name' |uniq
> model name      : AMD Ryzen Threadripper 1950X 16-Core Processor
> 
> Not ready for Windows 11 :(

:(
