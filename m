Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 8043F3858D28; Wed,  8 Jan 2025 15:52:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8043F3858D28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1736351567;
	bh=lb78Xt4jSNE5ejwGEGrEwoY3uCLaHIIFOC2Rs7DATAc=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=fdoEFa9iQujxOFfyJX9nGGP/Chqu7YycC7mRafrPeuAOf4lDur+QwNCshQn5O6iTg
	 CkCNfa6Ymo8rktO4wd8cqu1/d956AIu6dBWTgDEuGhTBePrr8uBVDlvyElRjGcfBxe
	 StaNIPMrDVlcapLmJuv1ptVa2fgxheMNN6VY17c8=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 6A676A805BC; Wed,  8 Jan 2025 16:52:45 +0100 (CET)
Date: Wed, 8 Jan 2025 16:52:45 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4] Cygwin: winsup/doc/posix.xml: update to SUS V5, POSIX
 2024, TOG Base Specs Issue 8, ISO/IEC DIS 9945
Message-ID: <Z36fTdoM8eFAchEH@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <8ad8cb0b4bca9415835cf5391933392d61d2bcdb.1736294236.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8ad8cb0b4bca9415835cf5391933392d61d2bcdb.1736294236.git.Brian.Inglis@SystematicSW.ab.ca>
List-Id: <cygwin-patches.cygwin.com>

On Jan  7 16:58, Brian Inglis wrote:
> Update anchor id and description to current version, year, issue, etc.
> Move new POSIX entries in other sections to the SUS/POSIX section.
> Add new POSIX entries from din entries.
> Add new entries with interfaces available in headers and packages.
> Add those missing to Not Implemented section, with mentions of headers,
> packages, etc.
> 
> Move dropped entries out of the SUS/POSIX section to Deprecated
> Interfaces section and mark with (SUSv4).
> 
> Double checking found some functions in the wrong categories which have
> been moved to the correct sections, and some functions out of order
> which have been reordered.
> 
> Move circular TRIGl functions before hyperbolic TRIGh? entries to keep
> each together: should we keep them on separate lines out of order, so we
> can check if they exist, concatenate onto the same lines with slashes,
> or just add the suffixes /f/l on to the base entry?

Independently if we do this or not, I'd like to suggest one thing:

Please don't try to do everything in a single patch.  Creating the SUSv5
section and moving functions over from other sections is one thing.
Adding not-implemented functions is another thing.  Changing the order
of functions for whatever reason is another thing.

Smaller patches are easier to understand, review and handle :)


Thanks,
Corinna
