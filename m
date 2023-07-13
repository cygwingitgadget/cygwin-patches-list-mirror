Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 66BA43858D32; Thu, 13 Jul 2023 18:00:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 66BA43858D32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1689271233;
	bh=3F5E/wUHxmdSSlYNQKR9SYbGZ9yFxlePDzUBLMTt4ho=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=X2ytBGlQvI+0oHPrSEyf+cDgQjdK4SVSr0CCkG3s4kOaK1T+QtE75MSJQ7PeD/o+A
	 2rSLc5wW3ux+P5A2d30wIS5uZP0q861fyK/CPrjcbceQXJvc+n5iBLh3kE78uvr0Uf
	 dS+TlYlw4FUGBYOzZkVNIRDIZFTcn7sTLXISqwgw=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 9D623A80B9C; Thu, 13 Jul 2023 20:00:31 +0200 (CEST)
Date: Thu, 13 Jul 2023 20:00:31 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pthread: Take note of schedparam in
 pthread_create
Message-ID: <ZLA7vxwYFR0st7Xo@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230713131414.3013-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230713131414.3013-1-jon.turney@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Jul 13 14:14, Jon Turney wrote:
> Take note of schedparam in any pthread_attr_t passed to pthread_create.
> 
> postcreate() (racily, after the thread is actually created), sets the
> scheduling priority if it's inherited, but precreate() doesn't store any
> scheduling priority explicitly set via a non-default attr to create, so
> schedparam.sched_priority has the default value of 0.
> 
> (I think this is another long-standing bug exposed by 4b51e4c1.  Now we
> don't lie about the actual thread priority, it's apparent it's not
> really being set in this case.)
> 
> Fixes testcase priority2.

Fixes: tag?
Signed-off-by: tag?

Looks good otherwise.


Thanks,
Corinna
