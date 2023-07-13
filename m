Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id BBE393858C62; Thu, 13 Jul 2023 18:17:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BBE393858C62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1689272269;
	bh=MpnN44ClSTdEyu+B/6dIsr3rcO/voJ+eeORaavN989U=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=y4I1wzdjb2Grm9827p9thj+/IkwXTVpOoZDdd8GqfbLchx3iK1wo17DX7mL1Sw9Rj
	 FEOyRHZOo536RRRkIso+RfPtFVWojiZdB8f1Y7SM7xVcAxxtjNW318iXj18EaLJF4t
	 Wk07oJdzkolI1I6dtXqJ7yfjSHpEPKRS5W3M/g74=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id CF138A80B9C; Thu, 13 Jul 2023 20:17:47 +0200 (CEST)
Date: Thu, 13 Jul 2023 20:17:47 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 09/11] Cygwin: testsuite: Fix a buffer overflow in
 symlink01
Message-ID: <ZLA/ywCZHkougQ5F@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
 <20230713113904.1752-10-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230713113904.1752-10-jon.turney@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Jul 13 12:39, Jon Turney wrote:
> See ltp commit 44d51c3f

Can you please add some text which helps the reader to understand the
issue without having to refer to the ltp repo?


Thanks,
Corinna
