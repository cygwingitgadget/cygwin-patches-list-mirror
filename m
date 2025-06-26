Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 63895385B53A; Thu, 26 Jun 2025 11:46:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 63895385B53A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750938387;
	bh=uw5IQvicQML4obWZn/KRXEiX8Mb1NGMPZ/T7GZ17QC8=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=dQusXr+r1VATz0N6XX+0vZ5ts/asumbdvZEAdu8Gbt2dIrNfluNOCOx12BHZZTHaX
	 zbs74bRZlYzdTX3Vit9gLXsXW/xh7eblhR0n7iVNVtXQ9fEParggc3dgdz8uou7CyM
	 9A58dEaHhIRfUfmBtYG7lpqstpgf8ztrdsuOeMMM=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id E896CA80C93; Thu, 26 Jun 2025 13:46:24 +0200 (CEST)
Date: Thu, 26 Jun 2025 13:46:24 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Cygwin: doc: Install FAQ as well
Message-ID: <aF0zEM9tqmEBnuaK@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250626105925.29521-1-jon.turney@dronecode.org.uk>
 <20250626105925.29521-2-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250626105925.29521-2-jon.turney@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Jun 26 11:59, Jon Turney wrote:
> Just install the FAQ, so we can deploy the FAQ with it's matching CSS from
> the install directory.
> 
> There will be a separate change to the cygwin packaging to avoid
> including the FAQ in the cygwin-doc package. (I guess we'd rather people
> go online for that, to ensure they have the latest version?)

We could just keep the faq.html file in the cygwin-doc package.
It doesn't really hurt and it always matches the installed
version. What could possibly be wrong? :)


Corinna
