Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id AEB883858C33; Wed, 19 Jul 2023 15:33:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AEB883858C33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1689780825;
	bh=7mEi3Vx7D+R5cHNuQ6anjpejxtU7PJQP+XGXwDDPP0c=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=ymegla0IHiXE6Xz8Pqiz5QfCK5R0ldj3AFaQ6/ppk9i0Q9VjtMOQDHB/YnaQU0iFp
	 fHJ77mn6hnpxQOUcTT4SZA3EBzDyFfwNTFNaBoxEWDMl3t31V49sKdyFmEKSgwiSVe
	 jLjE2yghDgDmTh0H7820QLk2qwEqqKt3Wta0gNUw=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 83F55A81B0B; Wed, 19 Jul 2023 17:33:43 +0200 (CEST)
Date: Wed, 19 Jul 2023 17:33:43 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Testsuite adjustment and relevant fix
Message-ID: <ZLgCVymLYi9ZB0uZ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230719124142.10310-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230719124142.10310-1-jon.turney@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Jul 19 13:41, Jon Turney wrote:
> [1/2] has the side effect of flipping test stat06 from working to failing.
> [2/2] fixes that
> 
> When run with TDIRECTORY set, libltp just uses that directory and assumes
> something else will clean it up.
> 
> When TDIRECTORY is not set, libltp creates a subdirectory under /tmp, and when
> the test is completed, removes the expected files and verifies that the
> directory is empty.
> 
> stat06 fails that check, because it creates the a file named "file" there, and
> tries stat("file", -1), testing that it returns the expected value EFAULT.
> 
> "file" is removed, but lingers in the STATUS_DELETE_PENDING state until the
> Windows handle which stat_worker() leaks when an exception occurs is closed
> (when the processes exits).

Great find. Please push.

> Future work: It looks like similar problems might generically occur in similar
> code througout syscalls.cc.

Uh oh...


Corinna
