Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 1BA723858D20; Fri,  8 Nov 2024 10:39:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1BA723858D20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1731062347;
	bh=yJpFGIRivkEOmvvFqPuEjIwhWqMS0rYhTCotCoRCEVQ=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=NIZUMkVikQVUWcua0EbbAOqOMYdAYapBjnrocA1y+Fyjui3Tc6Ek2b1CvOQV6OfwL
	 0CVLTfCY1K4PXEtaB4DmBpdMwHmcc+p7A6XTKDtnTV7m60qYYaXOzRmRgKqYznHd4O
	 8+Ctn7Tt2YgordPaxWZMTma+5FqYvw2JQIHmdkVk=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id CC00DA816F5; Fri,  8 Nov 2024 11:39:04 +0100 (CET)
Date: Fri, 8 Nov 2024 11:39:04 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: When submitting a bugfix patch *initially*
Message-ID: <Zy3qSDVLEMS9-1eX@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.BSF.4.63.2411072217390.16767@m0.truegem.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.BSF.4.63.2411072217390.16767@m0.truegem.net>
List-Id: <cygwin-patches.cygwin.com>

On Nov  7 22:29, Mark Geisert wrote:
> ..to the main branch, which release version file gets the bugfix
> description?  Assuming current branches...
> version/3.6.0 because the patch is initially going to master, or
> version/3.5.5 on the main branch because bugfixes get backported?
> 
> If version/3.6.0 initially, then when the bugfix gets backported does the
> bugfix description move from version/3.6.0 to version/3.5.5 or does it exist
> in both version files?

It's pretty simple:

- If you create a bugfix which is supposed to be backported to the 3.5
  branch anyway, the release text should go to 3.5.x, with x being the
  next version.

- If the patch is not supposed to be backported to the 3.5 branch -->
  release/3.6.0.  This includes new functionality, bugfixes to code
  only in the main branch, everything else.


Corinna
