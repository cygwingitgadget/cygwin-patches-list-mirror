Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id AE98D4BA2E06; Wed, 14 Jan 2026 22:35:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AE98D4BA2E06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1768430148;
	bh=sXjt18qUBRD6p5nTEjvr7p2giJK772OSFWxp9SZfmC4=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=GTvzRGyIJBUbbMV4V44eNCHdhcvPD80BcU1xWWXRplqQMesXwmI9yo+Cb/BcC8Rma
	 DYLuHOhAuKkKRj0QjZix8ERtXopIH4zKU+qIlt3FvBaGJHd3nZtGMhfJ/hhxyf2J/h
	 Gz0Mu0KhEBL0psZ2I1qNjPqJ/DGvREN9qE2GU2jY=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id BD9F5A80DDB; Wed, 14 Jan 2026 23:35:46 +0100 (CET)
Date: Wed, 14 Jan 2026 23:35:46 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: doc: Explciitly name the output when building
 .info files
Message-ID: <aWgaQtq5XHqZWfGi@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20260114142803.3097-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260114142803.3097-1-jon.turney@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

Hi Jon,

On Jan 14 14:28, Jon Turney wrote:
> This works arounda bug in docbook2x-texi seen with current bash in
> Fedora 42 during cross-building.
> 
> If the -output-dir option to db2x_texixml isn't specified (always the
> case when invoked by docbook2x-texi), then the script attempts cd ''
> which is now an error ("cd: null directory") rather being treated as
                                                   ^^^^^
                                                   than


Other than that, LGTM.


Cheers,
Corinna
