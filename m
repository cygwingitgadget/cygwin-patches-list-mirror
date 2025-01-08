Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id A76CD3858D28; Wed,  8 Jan 2025 15:45:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A76CD3858D28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1736351110;
	bh=4MOHYUZy/xUkTEmxRxpQ+vAbrcXK+2jTGyJFvFRbGhQ=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=EsBqfuSgj+1jr3wEGsm226tMC6aRAEQPCIqafNpjNzabyAxFpsCwLoNbx32k95byQ
	 QB4SLdkkqaINH1LA2cAgPZOUxgaYCjgbcCdp4bmk0yIuoujlzy50Q5veuRFJLFZE+e
	 XdBZOdv/7VmTh5atTTa9gBc5FjT8at7GqW9rNe44=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 15E1CA805BC; Wed,  8 Jan 2025 16:45:09 +0100 (CET)
Date: Wed, 8 Jan 2025 16:45:09 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [RFC] POSIX Issue 8 2024 SUS V5 Cygwin Doc Changes
Message-ID: <Z36dhfYCP97fjUZx@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <430aadfe-1bfd-41d1-8b7e-067f0b8cbbc6@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <430aadfe-1bfd-41d1-8b7e-067f0b8cbbc6@SystematicSW.ab.ca>
List-Id: <cygwin-patches.cygwin.com>

Hi Brian,

Hayy New Year!

On Jan  5 13:43, Brian Inglis wrote:
> - Move or copy the "new" entries to the SUS/POSIX section, update the
> description to SUS V5 POSIX Issue 8 2024 and IEEE and ISO/IEC (almost)
> Standards, update the id "std-susv4" and any refs.
> Should we copy and keep original entries under their original sections or not?
> Add any "din" entries; and decide if Notes are needed for any new entries?
> 
> - Move "cut" entries out of the SUS/POSIX section to deprecated interfaces
> section and mark dropped from SUS V5 POSIX Issue 8 2024 (SUSv4)?
> 
> - Decide how to check if any "non" entries are available in other packages,
> add Notes about them, and references in entries to add?
> If not available, add to Not Implemented section?
> 
> What have I got wrong or missed, how should we proceed, anything else?

More or less spot on.  In my own words:

- There should be only one SUS section, referencing the latest issue.
  So this should be updated to "Single Unix Specification, Version 8".
  Whether or not we change the id from "std-susv4" to "std-susv5" is up
  to us, given it's usually not visible ion the created docs.  If it's
  simple as dirt, change it.

- Each function showing up in one of the other sections, but has been
  upgraded to an official SUS function should be moved to the SUS
  section.

- Deprectaed SUS functions from older SUS issues should be added to the
  std-deprec section and its title updated accordingly.

- SUS functions not implemented (yet) should be added to the std-notimpl
  section and its title updated accordingly.

Make sense?


Thanks,
Corinna
