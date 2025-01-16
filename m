Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 79927384D19A; Thu, 16 Jan 2025 18:52:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 79927384D19A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1737053537;
	bh=P39WIGxGD7CbIpGFHevT5u0d/hU5Vgkk8QT4mBfIfys=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=dueP+FAc77coWFojU/8X2ufsOfSO7cCFqI/T8cEty5R4MEfofBQwMRKXMfalyFZFc
	 pObl29vPQGI5BnQxcC+gqkRotflbET1d0fzOTRV8zskW8B3DToYbc7e41hd4FP30AK
	 oxGm30QwEAjbTnDxPZUZVpdVMTY7VRNzKA04WFvg=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D57CDA80DAA; Thu, 16 Jan 2025 19:52:15 +0100 (CET)
Date: Thu, 16 Jan 2025 19:52:15 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v6 5/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 combine multiple notes
Message-ID: <Z4lVX9BHWaI3vdxN@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cover.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
 <f6784ba01723e392f2ab777adf27329923a82b84.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f6784ba01723e392f2ab777adf27329923a82b84.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
List-Id: <cygwin-patches.cygwin.com>

On Jan 15 12:39, Brian Inglis wrote:
> -<<<<<<< HEAD
> -    isastream
> -=======
> -    kill_dependency		(not available in "stdatomic.h" header)
> ->>>>>>> 5888275d7f48 (Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 move or remove dropped entries)

Oops.


Corinna
