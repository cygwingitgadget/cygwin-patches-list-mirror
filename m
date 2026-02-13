Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 703C84B9DB52; Fri, 13 Feb 2026 19:29:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 703C84B9DB52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1771010947;
	bh=1Wo0zXcsdnyIXToRTM6uZpHNkznnLUSks3tyrAq5Fww=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=GuI6BTeF6J3qRZBVVux1Qxnl7ZklhIGM9pM7nLQ6yjrO5JpGNAM7CyD3x/Uf2w3xk
	 q2fwz3kkugrXUqioXRF2d7jqdVbwlNXtshTAE6ncWcDOLeF9orbrL1g1gB4kRfwztV
	 gUETJwgd+xnIaRjHRUbzt4vct2Cra4J5y5x3o/is=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 8EF3BA81C4F; Fri, 13 Feb 2026 20:29:05 +0100 (CET)
Date: Fri, 13 Feb 2026 20:29:05 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: setrlimit: fix comments in terms of input
 checking
Message-ID: <aY97gX1ePB0QBsHj@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20260126102941.383039-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260126102941.383039-1-corinna-cygwin@cygwin.com>
List-Id: <cygwin-patches.cygwin.com>

On Jan 26 11:29, Corinna Vinschen wrote:
> From: Corinna Vinschen <corinna@vinschen.de>
> 
> Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
> ---
>  winsup/cygwin/resource.cc | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Pushed.


Corinna
