Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 193CB3858D37; Mon, 25 Nov 2024 19:15:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 193CB3858D37
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1732562134;
	bh=aVO++tvoeEfScrI4g4QiP7blrLRQUMtmF+01cvG16vk=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=q8wCdLy6PomU3l61zq9/ciNWE73/MpOhyWXP6R33gc2cc6ugnlxlegORzq7WCjflQ
	 JP/5Lj+jhvBjeSmsCyBF0l329YD+FrTLI4JHNbbW9xxbyY1n5akG77q0WlraEhho3/
	 Q0C/wsx0uLtND9CfQylO9OtBo9L7rBTvIBjZEtRQ=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 4C42FA80D93; Mon, 25 Nov 2024 20:15:31 +0100 (CET)
Date: Mon, 25 Nov 2024 20:15:31 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: sched_setscheduler: allow changes of the priority
Message-ID: <Z0TM0zIpjWHTRpsq@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4df78487-fdbd-7b63-d7ab-92377d44b213@t-online.de>
 <Z0RgpZA35z9S-ksG@calimero.vinschen.de>
 <42b59f14-19bf-c7c6-4acc-b5b91921af52@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <42b59f14-19bf-c7c6-4acc-b5b91921af52@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

Hi Christian,

On Nov 25 15:00, Christian Franke wrote:
> Corinna Vinschen wrote:
> > Fixes: ...?
> 
> ... the very first commit (cgf 2001) of sched.cc :-)
> 
> New patch attached.
> 
> From e95fc1aceb5287f9ad65c6c078125fecba6c6de9 Mon Sep 17 00:00:00 2001
> From: Christian Franke <christian.franke@t-online.de>
> Date: Mon, 25 Nov 2024 14:51:04 +0100
> Subject: [PATCH] Cygwin: sched_setscheduler: allow changes of the priority
> 
> Behave like sched_setparam() if the requested policy is identical
> to the fixed value (SCHED_FIFO) returned by sched_getscheduler().
> 
> Fixes: 6b2a2aa4af1e ("Add missing files.")

Huh, yeah, this is spot on.  I wonder if it would make sense to change
that to 9a08b2c02eea ("* sched.cc: New file.  Implement sched*.")
though, given that was the patch intended to add sched.cc :)))

Sorry, but I have to ask two more questions:

- Isn't returning SCHED_FIFO sched_getscheduler() just as wrong?
  Shouldn't that be SCHED_OTHER, and sched_setscheduler() should check
  for that instead?  Cygwin in a real-time scenario sounds a bit
  far-fetched...

- Don't you want this patch in 3.5.5?  I'd merge the other patch
  into 3.5.5 anyway...


Thanks,
Corinna
