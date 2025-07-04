Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 0721138515D2; Fri,  4 Jul 2025 11:06:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0721138515D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1751627175;
	bh=QeLSqMxvPrclXb/ce4gFUxOnSxWVWilQCaT0YMB57Bs=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=Q07AkdKYpB7OOZIGzgRjP88sR+slgC45i2YvZTl9tgXeAW8sjF+7cQXqn/6pbklKN
	 TCIKvqZ49QhF+QnXWOXUp0V4fXF3MLykIgbuHdon3+VksGNZGnnTHvXceGNZlcD6JE
	 PoB6AhwYSEbZSgzWEM5yBn2Kp/ucDCxeyLMPBrNc=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C84F1A80961; Fri, 04 Jul 2025 13:06:12 +0200 (CEST)
Date: Fri, 4 Jul 2025 13:06:12 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: define OUTPUT_FORMAT and SEARCH_DIR for AArch64
Message-ID: <aGe1pC9zNUhWzARd@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <DB9PR83MB0923BA573EA5101074C2F0B79278A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aFupr2xZJQY28zEQ@calimero.vinschen.de>
 <575e8838-b292-4f3c-9d47-76507703b747@dronecode.org.uk>
 <aFvgAEwrdLH-A5Ai@calimero.vinschen.de>
 <81096ca9-9542-4818-b363-f3856915050f@dronecode.org.uk>
 <aFwaB47HM8UDH9CK@calimero.vinschen.de>
 <DB9PR83MB09239C78F66E20045E2F4A269243A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <DB9PR83MB0923B144F86ADC301E17B3399242A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DB9PR83MB0923B144F86ADC301E17B3399242A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
List-Id: <cygwin-patches.cygwin.com>

On Jul  4 10:28, Radek Barton via Cygwin-patches wrote:
> Hello.
> 
> > In terms of this patch here I'm a bit puzzled.  It's nice that the
> > "=/lib/w32api" is sufficent.  I tested this locally on my fedora ->
> > x86_64-pc-cygwin cross and it builds fine, too.
> 
> > But why on earth is adding an unneeded dir to the search path
> > breaking the build, if the correct "=/lib/w32api" path is part of the
> >search path as well?  Why does this not break the x86_64 build, even
> > if that path neither exists for x86_64?
> 
> This is not consistent with my observations (tested on the GitHub CI):
> 
> `=/lib/w32api` breaks Fedora build

Oh, I'm sorry!  Somehow I didn't notice the =lib vs. =usr/lib, I only saw
a change in the directory order :(

> `=/usr/lib/w32api` works 
> `/usr/x86_64-pc-cygwin/lib/w32api`, resp. `/usr/aarch64-pc-cygwin/lib/w32api` does not change anything (builds pass whether it's present or not)
> 
> For this reason, I'd suggest to that the original patch https://sourceware.org/pipermail/cygwin-patches/2025q2/013892.html would be the safest to merge.

But in fact the =usr/lib should be sufficient as Jon pointed out.

The native sysroot is /, the cross-build sysroot is either
/usr/x86_64-pc-cygwin/sys-root/ or /usr/aarch64-pc-cygwin/sys-root.
So the search dir is always $SYSROOT/usr/lib/w32api aka =usr/lib/w32api.

I think your second patch is the way to go.

> Radek
> 
> PS: Thank you for your feedback, I'll be adding more information to the commit messages.

Thanks,
Corinna
