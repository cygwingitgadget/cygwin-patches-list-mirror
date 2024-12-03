Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 2B4F43858D33; Tue,  3 Dec 2024 19:42:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2B4F43858D33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1733254927;
	bh=+LZ3G0Brtv95Y1niRvijeqW6hBYhGBDk6XNJvr/L/wc=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=isV7EM1nP0lsKBpcKDomXFDBtWIp06PksHsS3k371CvGpGcHYlnYAwTOJtJg4VsZM
	 upYl3TjM6l+G8bRu+kSd4mUSLOE50fOlYMjxFXLUh/KwEW5SuAsllV1j3TmbJ4AYFx
	 0oJTiWn++lplE4fJtwlJQyrSXtap11xJ16scr1T4=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id B7968A80B66; Tue,  3 Dec 2024 20:42:04 +0100 (CET)
Date: Tue, 3 Dec 2024 20:42:04 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: sched_setscheduler: accept SCHED_OTHER,
 SCHED_FIFO and SCHED_RR
Message-ID: <Z09fDDuScXc7Ro6b@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <eabbcf15-1605-8b77-bf77-ec5fde2d6001@t-online.de>
 <Z03Tik1rbM4sMpKl@calimero.vinschen.de>
 <e79eb78a-c8a1-d2c6-4a8d-9c21415b15e9@t-online.de>
 <8734j6q6qk.fsf@Gerda.invalid>
 <c6f21ed2-679d-4a89-a8a3-b0b1e9d1714f@SystematicSW.ab.ca>
 <80e1716d-d268-e5cd-b9ff-484aa5dcc344@t-online.de>
 <Z08EFs_LTnjKL6xr@calimero.vinschen.de>
 <cb5f0aa9-82f7-4a1f-9788-05b05162923a@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cb5f0aa9-82f7-4a1f-9788-05b05162923a@SystematicSW.ab.ca>
List-Id: <cygwin-patches.cygwin.com>

On Dec  3 08:23, Brian Inglis wrote:
> On 2024-12-03 06:13, Corinna Vinschen wrote:
> > On Dec  3 10:20, Christian Franke wrote:
> > > SCHED_IDLE: Ignore nice value and set IDLE_PRIORITY_CLASS ?
> > 
> > Would make sense, I guess.
> > [...]
> > SCHED_SPORADIC is a bit of a problem.  It requires extension of the
> > sched_param struct with values we're not able to handle.
> 
> => SCHED_IDLE?
> Could be something like a background process on a real time system?
> 
> > Also, SCHED_SPORADIC doesn't exist in Linux either, so why bother.
> 
> 	https://pubs.opengroup.org/onlinepubs/9799919799/
> 
> sched.h Change History:
> 
> "Sporadic server members are added to the sched_param structure, and the
> SCHED_SPORADIC scheduling policy is added for alignment with IEEE Std
> 1003.1d-1999."
> 
> It's been in POSIX since at least Issue 6 thru 8, with no changes in last go
> round, so presumably it exists and is used on some major platform(s)?

Nevertheless, it's optional:

[SS] Process Sporadic Server 
    The functionality described is optional. The functionality described
    is also an extension to the ISO C standard.

It's only supported on systems defining _POSIX_SPORADIC_SERVER or
_POSIX_THREAD_SPORADIC_SERVER.

Also, the desired behavior is quite complex. Check out
https://pubs.opengroup.org/onlinepubs/9799919799/functions/V2_chap02.html#tag_16_08_04_01
We'll never be able to model it and given Linux doesn't support it...


Corinna
