Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id BC8123858D1E; Wed,  8 Jan 2025 17:00:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BC8123858D1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1736355653;
	bh=wXzbKiIVhV5aRntAL0A72TirXpcnRQvdAxYA7ADT0+A=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=eNwtpiX+5acfJIHOc/hKnEb6Hvap3MyuQLp6f8zm/V2KaE7bqBc49/L82rAfl3XUT
	 cH19dYPgFAhzqn/cWHMIltTHM2sti7RveE/Aj6WqdqybNk7JFeY0obKOqY48t+HMsr
	 LbgXSYiVIXQX+FcRpwC+KgLqosY0cGPjviKdoicw=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 005F0A805BC; Wed,  8 Jan 2025 18:00:51 +0100 (CET)
Date: Wed, 8 Jan 2025 18:00:51 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [RFC] POSIX Issue 8 2024 SUS V5 Cygwin Doc Changes
Message-ID: <Z36vQ5aPOGcubnPB@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <430aadfe-1bfd-41d1-8b7e-067f0b8cbbc6@SystematicSW.ab.ca>
 <Z36dhfYCP97fjUZx@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z36dhfYCP97fjUZx@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

On Jan  8 16:45, Corinna Vinschen wrote:
> - Deprectaed SUS functions from older SUS issues should be added to the
                                                             ^^^^^
                                                             moved
>   std-deprec section and its title updated accordingly.


Corinna
