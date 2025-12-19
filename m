Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 128B24BA2E37; Fri, 19 Dec 2025 09:51:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 128B24BA2E37
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1766137902;
	bh=szmQrvyesnefnMoBIS+8ixD9NAruVWDv95hLJYOY6Mw=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=ReSxbblOongQh2Yo5I+hEvDm1Pgf0pirq0zeXjEL694NVaa5gv+dxCM0yhsac6HMv
	 KpYheX4wPrvSD9uXE0b+5LrONTtzvKvyvgGWWI+0ivXHJjiMEKFsX9xoJOWimdDRfl
	 pcRG9eFVOOJsGRaVXKbsWG9t5AUlByBpB4oW1+S0=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 23AACA80BEF; Fri, 19 Dec 2025 10:51:40 +0100 (CET)
Date: Fri, 19 Dec 2025 10:51:40 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5 1/6] Cygwin: termios: Make is_console_app() return
 true for unknown
Message-ID: <aUUgLNKPCx8WJmuB@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20251219022650.2239-1-takashi.yano@nifty.ne.jp>
 <20251219022650.2239-2-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251219022650.2239-2-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Dec 19 11:26, Takashi Yano wrote:
> If is_console_app() returns false, it means the app is GUI. In this case,
> standard handles would not be setup for non-cygwin app. Therefore, it is
> safer to return true for unknown case. Setting-up standard handles for
> GUI apps is poinless indeed, but not unsafe.
              pointless


Corinna
