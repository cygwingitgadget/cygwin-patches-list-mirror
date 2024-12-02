Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 2B9903858C54; Mon,  2 Dec 2024 15:34:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2B9903858C54
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1733153677;
	bh=YqHPeiL544tNZXLYXvoNtBBiyt9IhWw0GpW+AQzr3p0=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=lCsf5oVEGbA4u1YEjkFo31ej5nvn4XevWjKqHTrAHQkQU2xRRtvpLLGjjz7SlMnX/
	 PBy0DDDqGX4ZvIMj3EpJmwd8+y0NxF5i1E/KNhXi5dWqwt2E4wyFNZiKdcRpHn9GZY
	 L6lFNdn1sRA0fph6EGytYxdnL6KV9t1X4zaJOn5k=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C8E34A80BC2; Mon,  2 Dec 2024 16:34:34 +0100 (CET)
Date: Mon, 2 Dec 2024 16:34:34 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: sched_setscheduler: accept SCHED_OTHER,
 SCHED_FIFO and SCHED_RR
Message-ID: <Z03Tik1rbM4sMpKl@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <eabbcf15-1605-8b77-bf77-ec5fde2d6001@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eabbcf15-1605-8b77-bf77-ec5fde2d6001@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Nov 29 18:48, Christian Franke wrote:
> A very first attempt to let sched_setscheduler() do something possibly
> useful.
> 
> This patch is on top of
> Cygwin: setpriority, sched_setparam: add missing process access right


Looks quite nice.  If you're confident this is ready for the main
branch, just give the word!


Thanks,
Corinna
