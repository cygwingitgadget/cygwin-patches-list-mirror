Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 5BB2A3858D20; Wed,  4 Dec 2024 21:07:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5BB2A3858D20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1733346469;
	bh=29RGhFogfoKvIScc+eU1HevY0xHXyWhShdrG0WifaUM=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=tBA/RBzQSaCwEJPhOv0ajiNyhJjfWR+qpnsYibnmeddh5qfA5GA28JEXVzh66NvjD
	 CrPwn2Lyd62cThox4mwsD2QD/E7rdS6NmNI9X8AcuSxTscHf8Yl2ao2ZtjfP6MaYOi
	 mcN6ROwcbs4PkV4eJQ+2/ge8a5Jtif8FudC5lqdM=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id DB7F4A80659; Wed,  4 Dec 2024 22:06:51 +0100 (CET)
Date: Wed, 4 Dec 2024 22:06:51 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: sched_setscheduler: accept SCHED_OTHER,
 SCHED_FIFO and SCHED_RR
Message-ID: <Z1DEayhmKM5gmXzO@calimero.vinschen.de>
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

All three patches pushed.


Thanks,
Corinna
