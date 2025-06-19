Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id C669138515D8; Thu, 19 Jun 2025 10:49:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C669138515D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750330183;
	bh=hWrJMXZywT8yLa5Dq43Gog9j2QJCD2qI9VQQEodb1Yo=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=NaRdGezjR3aGNt7NLAzw/vewV01vcs7a1IFEpnvWCy8Gufjqfnc6Yhz6S/DWIQn8J
	 oTI1yx60dnFri7gVHcGl7Aw60vXay5Et72z2LKHDuiLxqeQJa+bui9DeMFMhKG7shD
	 FdLdmRmUOzJKn3UbEXcbhz29G8J6wpuRIOTWxl4E=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 953A4A8091F; Thu, 19 Jun 2025 12:49:40 +0200 (CEST)
Date: Thu, 19 Jun 2025 12:49:40 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: obtain stack base on AArch64
Message-ID: <aFPrRJJYf21DpAwp@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <DB9PR83MB0923187D66011DE1CB903BF09272A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <7b7b45f7-d126-5673-2961-7c7672f5f922@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b7b45f7-d126-5673-2961-7c7672f5f922@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Jun 18 10:36, Jeremy Drake via Cygwin-patches wrote:
> On Wed, 18 Jun 2025, Radek Barton via Cygwin-patches wrote:
> 
> > Hello.
> >
> > This patch ports reading of stack base from TEB on AArch64 at cygload.cc and __getreent.
> >
> > Radek
> >
> > ---
> > From 08f9be50573a085fd3e5cb840455ea5fc3b1e82a Mon Sep 17 00:00:00 2001
> > From: =?UTF-8?q?Radek=20Barto=C5=88?= <radek.barton@microsoft.com>
> > Date: Wed, 4 Jun 2025 13:38:10 +0200
> > Subject: [PATCH] Cygwin: obtain stack base on AArch64
> > MIME-Version: 1.0
> > Content-Type: text/plain; charset=UTF-8
> > Content-Transfer-Encoding: 8bit
> >
> > Signed-off-by: Radek Bartoň <radek.barton@microsoft.com>
> > ---
> >  winsup/cygwin/include/cygwin/config.h  | 7 ++++++-
> >  winsup/testsuite/winsup.api/cygload.cc | 7 +++++++
> >  2 files changed, 13 insertions(+), 1 deletion(-)
> > [...]
> 
> LGTM.  Should I be pushing these or just reviewing them on the list?

That would be great!


Thanks,
Corinna
