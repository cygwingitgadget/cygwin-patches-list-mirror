Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 956F63858023; Mon, 24 Mar 2025 10:57:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 956F63858023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1742813852;
	bh=QGiI7tVJPBt8HpsqIExtzhUmqRFiRT/7LceGaMQbrbc=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=Ur55p1KhPqukhABI96M816Zr7mUXSjnQjwKoaMHrbQvGJQhrZ0ncAvwSubijUWhJs
	 fewH69QkYLExda9TurTG86dXcCif1fpDVJ8zh9voJqJiBEEtsPJXJS36/Mw+/QIbqW
	 2Uu2DWSqKuCc0iif6XPZcQW7AS0o3cuZc62Ce2CI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 80995A80B7A; Mon, 24 Mar 2025 11:57:30 +0100 (CET)
Date: Mon, 24 Mar 2025 11:57:30 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Fix CI testsuite run with 3.6
Message-ID: <Z-E6mqsV4u6mqG8q@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250321140502.2122-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250321140502.2122-1-jon.turney@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Mar 21 14:04, Jon Turney wrote:
> I think there's been some changes in the way we compute the ACL for files we
> create, which is causing a couple of tests to fail in CI.
> 
> Get rid of inheritable permissions, so filemodes follow the simple behaviour
> (just controlled by umask) that tests expect.
> 
> (It seems like there must be something wrong with the contortions we go 
> through to run the testsuite against the just-built DLL, as otherwise we've 
> have noticed these failures earlier?)
> 
> Jon Turney (2):
>   CI: Remove inheritable permissions from working directory
>   Revert "Cygwin: CI: XFAIL umask03"
> 
>  .github/workflows/cygwin.yml | 3 +++
>  winsup/testsuite/Makefile.am | 6 +-----
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> -- 
> 2.45.1

+1


Corinna
