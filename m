Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 39A7D38582A5; Mon, 15 Jan 2024 09:50:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 39A7D38582A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1705312224;
	bh=ZGvIQdns6tfd9ELTc/H2F1O1xhwv4g5mbPbbzZ+ow4s=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=xTGbKujOVV6sSSQWWAPQpC5SABNFeFq7OdISuB82Myq88c520hEpdSGEssDq8VwEL
	 Jx+9Vg4C4Z0ES9vVH403xMAfhsUxobYojZJgY33JgiJY9fN3MysI6NEm10yuNKJnZ3
	 2Eh1o1SX/NqusFpjRKlgYeRer1HYdx59+7P1cGWw=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 6C5B4A80A6B; Mon, 15 Jan 2024 10:50:22 +0100 (CET)
Date: Mon, 15 Jan 2024 10:50:22 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: introduce close_range
Message-ID: <ZaT_3kLV_04z7BJb@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <83cfd6b3-6824-fd9f-794b-7fc428f8c80d@t-online.de>
 <3ab13e94-fd3a-41c8-8392-fcd72042d0e9@dronecode.org.uk>
 <6b1723b1-12b1-a240-ff22-1f0f5ba73214@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6b1723b1-12b1-a240-ff22-1f0f5ba73214@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Jan 14 19:53, Christian Franke wrote:
> Jon Turney wrote:
> > On 14/01/2024 16:07, Christian Franke wrote:
> > > Recently I learned about the existence and usefulness of close_range():
> > > https://github.com/smartmontools/smartmontools/issues/235
> > > 
> > > https://man.freebsd.org/cgi/man.cgi?query=close_range&sektion=2
> > > https://man7.org/linux/man-pages/man2/close_range.2.html
> > > 
> > > Note that the above Linux man page is not fully correct. The include
> > > file "linux/close_range.h" exists, but provides only the defines. It
> > > is sufficient to include "unistd.h" as on FreeBSD.
> > > 
> > > The attached patch adds this to Cygwin. It does not implement the
> > > Linux-specific CLOSE_RANGE_UNSHARE as I have no idea how to do this
> > > :-)
> > 
> > This API should also be mentioned in the
> > "System interfaces compatible with GNU or Linux extensions" section of
> > doc/posix.xml
> > 
> > 
> 
> Thanks for the info. I used the recent "Cygwin: introduce fallocate(2)"
> patch as a blueprint for which other files should be changed (fallocate is
> also missing in the posix.xml file).

Oops, thanks for notifying. I'll add it in a bit...


Corinna
