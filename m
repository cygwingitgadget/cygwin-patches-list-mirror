Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 0786C3858429; Mon, 26 Feb 2024 11:36:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0786C3858429
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1708947373;
	bh=FPscNvJ8a+PMfErA3hYyydHT1plOqMf5InsX+xr2+VA=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=RW64/fThqXueL0N4BYDcyYoGZXhQY3twofsTEBIjRADmjWFXTFyhq4+flTiiXQy1B
	 qpAvijGy8FOxHxj98qkyGl+E1jEiyP+Jmu6myowM62ovTk5setm6+XNPSvjBEcrKpe
	 LHkTdmzT73fot0uGl2PD3UfZJJzMEGXr2KuXceqk=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 7F5C8A80650; Mon, 26 Feb 2024 12:36:10 +0100 (CET)
Date: Mon, 26 Feb 2024 12:36:10 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Map ERROR_NO_SUCH_DEVICE and ERROR_MEDIA_CHANGED
 to ENODEV
Message-ID: <Zdx3qtxjpH-7Y4Py@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <04f337bf-7197-b4af-3519-832ad2be5b14@t-online.de>
 <ZdnfSDqfh1ZCynjH@calimero.vinschen.de>
 <0894e3b9-1adf-f73f-9f66-160a15f5f137@t-online.de>
 <ZdxnmgMzIEdnr9GP@calimero.vinschen.de>
 <d22da40f-ea54-096a-75ea-28a236125cf4@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d22da40f-ea54-096a-75ea-28a236125cf4@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Feb 26 12:14, Christian Franke wrote:
> Corinna Vinschen wrote:
> > Why so many?  I used winerror.h to populate the list not too long ago,
> > so I wonder why it suddenly has so many more error codes?
> 
> "Required for mozilla-central." - 850 insertions:
> https://sourceforge.net/p/mingw-w64/mingw-w64/ci/ddeb05a
> 
> Most or all would possible never occur with the NTDLL/Win32 API subset used
> by Cygwin.
> 
> Includes interesting codes like "ERROR_NO_WORK_DONE" :-)

LOL.  The only hint I found on that one is in Wine ChangeLog:

 "FormatMessage() now reports ERROR_NO_WORK_DONE error for empty string."


Corinna
