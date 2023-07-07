Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 393EC3850AC4; Fri,  7 Jul 2023 15:49:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 393EC3850AC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1688744948;
	bh=/D7h7M3AsgUpkp2NwT1ttE5E7JX6czxHQXNiYZj91I8=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=XXuuF6yTb8pG+73QDUhtIquHDEcMniP1d60qYodxR9/wCQpNl2gc4rC6RFA1vUx0Y
	 PFhkZtbKGmb5XLx5bhXngEX9YgTAtknZKlzCahWjhOXbCftlAd2dKdS3irtgNlVn50
	 ZZlsFdPoyh3RdEAUNmSvPXWMX93rZYZs8DgUPvBA=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 3FDD5A80F43; Fri,  7 Jul 2023 17:49:06 +0200 (CEST)
Date: Fri, 7 Jul 2023 17:49:06 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Make gcc-specific code in <sys/cpuset.h>
 compiler-agnostic
Message-ID: <ZKgz8l4KnYKellRQ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230707074121.7880-1-mark@maxrnd.com>
 <ZKfeaMftPy8HmXyy@calimero.vinschen.de>
 <8bc70b04-7c0b-15de-b090-e2f38c424dd9@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8bc70b04-7c0b-15de-b090-e2f38c424dd9@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Jul  7 16:46, Jon Turney wrote:
> On 07/07/2023 10:44, Corinna Vinschen wrote:
> > Hi Mark,
> > 
> > On Jul  7 00:41, Mark Geisert wrote:
> > > The current version of <sys/cpuset.h> cannot be compiled by Clang due to
> > > the use of __builtin* functions.  Their presence here was a dubious
> > > optimization anyway, so their usage has been converted to standard
> > > library functions.  A popcnt (population count of 1 bits in a word)
> > > function is provided here because there isn't one in the standard library
> > > or elsewhere in the Cygwin DLL.
> > 
> > And clang really doesn't provide it?  That's unfortunate.
> 
> I suspect if we had a current clang this would not be a problem.
> 
> There's probably something to be said for solving this problem by removing
> our old and unmaintained clang packages...

Good point.


Corinna
