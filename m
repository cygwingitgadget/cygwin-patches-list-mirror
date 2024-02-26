Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 0A1663858CDB; Mon, 26 Feb 2024 10:27:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0A1663858CDB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1708943261;
	bh=plJgeMC+lXx6e+sERsLfo4CIn69vRkdaU/dgZ/mcRHY=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=w4tlPZFwbVWA/L6kRBumVGrWuyIw7xwza/9NzkH1SmhGsur6WizidSjzdCKik6E58
	 Y/yQrBqD/jLY7IyMv0Y7xRv8W/KycW7vm7WD662dyBhPJ/XBl/zj5X0Eq4d3+O3oHY
	 Kn8eMcF+sk4fYgY0TuckB7Y4fIy3wX/+Yykn5Z98=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 9257DA80851; Mon, 26 Feb 2024 11:27:38 +0100 (CET)
Date: Mon, 26 Feb 2024 11:27:38 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Map ERROR_NO_SUCH_DEVICE and ERROR_MEDIA_CHANGED
 to ENODEV
Message-ID: <ZdxnmgMzIEdnr9GP@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <04f337bf-7197-b4af-3519-832ad2be5b14@t-online.de>
 <ZdnfSDqfh1ZCynjH@calimero.vinschen.de>
 <0894e3b9-1adf-f73f-9f66-160a15f5f137@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0894e3b9-1adf-f73f-9f66-160a15f5f137@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Feb 25 10:12, Christian Franke wrote:
> Corinna Vinschen wrote:
> > So the default was EPERM at first and has been changed to EACCES
> > because it "is better for the unknown error case".
> > 
> > I'm open to ideas for an improved error mapping.
> 
> I have no better suggestion for a default errno. Adding a cygwin specific
> one (like ENMFILE, ENOSHARE and ECASECLASH added 2000-2001) is possibly not
> desired.

ENOSHARE and ECASECLASH are not used anymore, fortunately, and ENMFILE
is hopefully never returned to userspace.  It might be a good idea to
remove it from Cygwin's code as well.

> Some thoughts about minor improvements of the errmap.h file:
> - Add error number to each /* ERROR_... */ comment, e.g. /* 2:
> ERROR_FILE_NOT_FOUND */.

Ok.

> - Update /* NUMBER */ comments using current MinGW-w64's winerror.h (~850
> changes).

Why so many?  I used winerror.h to populate the list not too long ago,
so I wonder why it suddenly has so many more error codes?

> - Max errno is 143, so data type size could be reduced from int to uint8_t
> aka unsigned char. Could even add a compile time check by using C++11's
> braced initializers which do not allow narrowing conversions.

Yeah, we could do that.

> - Remove trailing entries which only map to 0.
> - Append a static_assert which checks whether array size matches the last
> mapped error number.

Yeah, not so sure about that.  I'm aware that we only map errors
below 3000 somewhere, but it's no safe bet that it stays that way.

For instance, we handle NT status codes STATUS_TRANSACTIONAL_CONFLICT
and STATUS_TRANSACTION_NOT_ENLISTED and those translate into the TxF
error range between 6800 and 6899.  We don't convert those to userspace
errno yet, but consider having to add them at one point and thus having
to add the 3000 entries from the last used one up the newly used one.

The reason to keep them is to allow us to be lazy about it.  The list
also just takes ~36K, and with the change to uint8_t it only takes
9K, so what?

> I could provide separate patches if desired.

Always welcome!


Thanks,
Corinna
