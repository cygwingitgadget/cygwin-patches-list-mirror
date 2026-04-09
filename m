Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 8031E4BA2E09; Thu,  9 Apr 2026 17:35:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8031E4BA2E09
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1775756144;
	bh=CrBwLkwoPqCn6mUz2+SBm2TsR/4zi4wx79JcsEgw49s=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=LVoG7Tyg1gz039NrBkJxPKwAUNydMNB8MylX3sGI/XIqw+Tr3/DigfdGlD+ZYF4d9
	 81YzwjZgKWqtzltodMsV/i66EUty3oFo3Py+Fz6iaQK5Omvdxt+kG8p3nrZqS738P1
	 ThH2cDFmC3OCdW1o45lomr2hAe1/H4bF3/8+V2l8=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 9D316A80661; Thu, 09 Apr 2026 19:35:42 +0200 (CEST)
Date: Thu, 9 Apr 2026 19:35:42 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Joel Sherrill <joel@rtems.org>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/1] Cygwin: winsup/cygwin/include/limits.h: Add C23
 ..._WIDTH definitions
Message-ID: <adfjbpR0weBVzkWS@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Joel Sherrill <joel@rtems.org>, cygwin-patches@cygwin.com
References: <20260408151902.2022129-1-joel@rtems.org>
 <20260408151902.2022129-2-joel@rtems.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260408151902.2022129-2-joel@rtems.org>
List-Id: <cygwin-patches.cygwin.com>

On Apr  8 10:19, Joel Sherrill wrote:
> C23 adds the following constants to reflect the bit width of various
> types: CHAR_WIDTH, SCHAR_WIDTH, UCHAR_WIDTH, SHRT_WIDTH, USHRT_WIDTH,
> INT_WIDTH, UINT_WIDTH, LONG_WIDTH, ULONG_WIDTH, LLONG_WIDTH, and
> ULLONG_WIDTH.
> ---
>  winsup/cygwin/include/limits.h | 56 ++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)

Pushed.

Thanks,
Corinna
