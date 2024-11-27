Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id C83293858CD1; Wed, 27 Nov 2024 17:17:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C83293858CD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1732727826;
	bh=OJg90DmyLyKzN3BFCQSOIHIBf2jrgcrb7PEsLxfaBfM=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=u+1d2xndJsqLeQrWu+TVaJJvaOF4l9ES4DpDsN/+79aqvHiymTvnuXwduWGgIRi1d
	 5+9YlBSUZgSvBVKs4rZXaEW9vyJ9ohhnDffKHAremKiYkAt/KeQAWGIrZYpsVF2DLO
	 a38/oEQDUs4eU2DtBp4IbDPVMDs+1T7Se/puzQBc=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id BB9DBA80E4D; Wed, 27 Nov 2024 18:17:04 +0100 (CET)
Date: Wed, 27 Nov 2024 18:17:04 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: sched_setscheduler: allow changes of the priority
Message-ID: <Z0dUEFsMzSI2Lspq@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4df78487-fdbd-7b63-d7ab-92377d44b213@t-online.de>
 <Z0RgpZA35z9S-ksG@calimero.vinschen.de>
 <42b59f14-19bf-c7c6-4acc-b5b91921af52@t-online.de>
 <Z0TM0zIpjWHTRpsq@calimero.vinschen.de>
 <5d40600d-8929-ebc4-d417-6e8b3221d09e@t-online.de>
 <Z0XFU636aT986Vtn@calimero.vinschen.de>
 <a4acc9e3-8363-b9af-e92e-b3a865b18d20@t-online.de>
 <Z0cu7Dzbq9RMSmrD@calimero.vinschen.de>
 <36947dfd-fa1b-0845-7017-c4f162926e16@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <36947dfd-fa1b-0845-7017-c4f162926e16@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Nov 27 16:44, Christian Franke wrote:
> Corinna Vinschen wrote:
> > And I think your patch here should go in as is, just with the release
> > message in release/3.5.5 so we can cherry-pick it to the 3.5 branch.
> 
> Attached. Message moved to 3.5.5 and "Fixes:" changed as suggested.
> 

> From 86266b67334d43ac52a9b7ac1ee879a8d34f0c62 Mon Sep 17 00:00:00 2001
> From: Christian Franke <christian.franke@t-online.de>
> Date: Wed, 27 Nov 2024 16:39:37 +0100
> Subject: [PATCH] Cygwin: sched_setscheduler: allow changes of the priority
> 
> Behave like sched_setparam() if the requested policy is identical
> to the fixed value (SCHED_FIFO) returned by sched_getscheduler().
> 
> Fixes: 9a08b2c02eea ("* sched.cc: New file.  Implement sched*.")
> Signed-off-by: Christian Franke <christian.franke@t-online.de>
> ---
>  winsup/cygwin/release/3.5.5 | 3 +++
>  winsup/cygwin/sched.cc      | 5 ++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)

Pushed.


Thanks,
Corinna

