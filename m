Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 09BCB385DC29; Fri,  7 Jul 2023 10:10:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 09BCB385DC29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1688724656;
	bh=yEsd0y6aquBubF4SkUoq2RVUXHKiFayf9cvoLnptVnc=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=AXnJ4L57UkXAPYBhD0kfEIAyukbS8lj6Oe++j607+RKCwB4JYUpF1+Z6OFBETB6QY
	 Qa4jNIV500YLJwJDNOc+WRongGGorktK0GJb/fEbOBWbD6M/3Pz6Zl8dJLnyKCTYxc
	 pslEkwyeKXPVyXEvDaXRt8K39bmdKgoQekuMGJJ4=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 4B84FA80BDA; Fri,  7 Jul 2023 12:10:54 +0200 (CEST)
Date: Fri, 7 Jul 2023 12:10:54 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/2] Cygwin: fstat(): Fix st_rdev returned by fstat() for
 /dev/tty.
Message-ID: <ZKfkrrnMdbVv0N11@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230707033458.1034-1-takashi.yano@nifty.ne.jp>
 <20230707033458.1034-3-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230707033458.1034-3-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Jul  7 12:34, Takashi Yano wrote:
> While st_rdev returned by fstat() for /dev/tty should be FH_TTY,
> the current cygwin1.dll returns FH_PTYS+minor or FH_CONS+minor.
> Similarly, fstat() does not return correct value for /dev/console,
> /dev/conout, /dev/conin or /dev/ptmx.
> 
> This patch fixes the issue by:
> 1) Introduce dev_refered_via in fhandler_termios.
                       ^
               dev_referred_via, please


Thanks,
Corinna
