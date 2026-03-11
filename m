Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 9779C4BB3BFA; Wed, 11 Mar 2026 14:53:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9779C4BB3BFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1773240810;
	bh=D1GntPuCIgZ2DhRfx6WPvPd0OZJ548zfkQw9JzN4tLA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=kiAoM0z3SIygIz7org8e9OSpoH3N71UjmqFlBLR2QOuJlSKFMSFZ/JBP9TRgRbjXL
	 VyzBUbPyZ/p6mmKHVASxX+rSg0xJowm9tz3Sp11LlqMHshjC2DKjC/WILt0B38NOj4
	 4Xc71GUP2fO7smi2dFHPGFVY2BsRsk5Ci3zkf+rk=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id AE069A80859; Wed, 11 Mar 2026 15:53:28 +0100 (CET)
Date: Wed, 11 Mar 2026 15:53:28 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Igor Podgainoi <Igor.Podgainoi@arm.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>,
	nd <nd@arm.com>
Subject: Re: [PATCH] Cygwin: signal: Implement sigdelayed assembly function
 for AArch64
Message-ID: <abGB6Axg-THTqXrd@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Igor Podgainoi <Igor.Podgainoi@arm.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>,
	nd <nd@arm.com>
References: <aZbDndyBRw1ZmRvh@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aZbDndyBRw1ZmRvh@arm.com>
List-Id: <cygwin-patches.cygwin.com>

On Feb 19 08:02, Igor Podgainoi wrote:
> This patch adds an AArch64 implementation of the sigdelayed assembly
> function to Cygwin.
> 
> Tests fixed on AArch64:
> winsup.api/msgtest.exe (partially)
> winsup.api/sigchld.exe
> winsup.api/ltp/alarm07.exe
> winsup.api/ltp/kill01.exe
> winsup.api/ltp/kill02.exe
> winsup.api/ltp/kill03.exe
> winsup.api/ltp/kill04.exe
> winsup.api/ltp/pause01.exe
> winsup.api/ltp/signal03.exe
> 
> Signed-off-by: Igor Podgainoi <igor.podgainoi@arm.com>
> ---
>  winsup/cygwin/scripts/gendef | 158 +++++++++++++++++++++++++++++++++++
>  1 file changed, 158 insertions(+)

Pushed.

Thanks,
Corinna
