Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 650034BB58B6; Wed, 11 Mar 2026 14:54:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 650034BB58B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1773240864;
	bh=7x8o/eqb7GNth4nP0GlAsmqj1jXA99MyoBjIwSj69A8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=V4mBLg4JL/ywqYpJAKotpBbV7d3WLdMSQl9iyuxSw/m8AO2u3nT9WY1rz/Hog9uMI
	 bvgqSdNspyPMUqzyIqtl8wKEKJ66jfH2vAAEmEOS9HgSMKEjO/bRD/Uoyki8ab+0kc
	 rnXkeHozzTWj/6lnPKccZQWCsmfDszaDRI6VbOIE=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 7B0C2A80859; Wed, 11 Mar 2026 15:54:22 +0100 (CET)
Date: Wed, 11 Mar 2026 15:54:22 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Igor Podgainoi <Igor.Podgainoi@arm.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>,
	nd <nd@arm.com>,
	Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
Subject: Re: [PATCH 1/1] Cygwin: signal: Fix
 stabilize_sig_stack/setjmp/longjmp on AArch64
Message-ID: <abGCHjZ7hFQM-PNO@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Igor Podgainoi <Igor.Podgainoi@arm.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>,
	nd <nd@arm.com>,
	Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
References: <cover.1771489560.git.igor.podgainoi@arm.com>
 <318a0070a6edb6f21d702786966a6d89351573c6.1771489560.git.igor.podgainoi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <318a0070a6edb6f21d702786966a6d89351573c6.1771489560.git.igor.podgainoi@arm.com>
List-Id: <cygwin-patches.cygwin.com>

On Feb 19 08:44, Igor Podgainoi wrote:
> This commit fixes the AArch64 implementation of the following three
> functions: stabilize_sig_stack, setjmp and longjmp.
> 
> Changes made:
> 
> * Fixed code indentation in all three functions.
> * Corrected some comments and added additional ones.
> * Added missing SEH directives.
> * Changed the locking algorithm in stabilize_sig_stack to Test and
>   Test-and-Set (TTAS).
> * Stopped returning a value in x0 in stabilize_sig_stack to avoid
>   unnecessary clobbering. This should make it more similar to the
>   x86_64 version.
> * Using x10 instead of x0 in setjmp and longjmp where needed as per
>   the previous change.
> * Fixed bug in setjmp where the SP value after the prologue was used,
>   instead of the original one.
> * Fixed bug in setjmp where the stackptr was saved at the wrong offset
>   into jmp_buf (should be 0).
> * Now saving and restoring x0 in setjmp and x0/x1 in longjmp around the
>   call to stabilize_sig_stack. This should make it more similar to the
>   x86_64 version.
> * Removed the prologue and epilogue in longjmp, as the function never
>   returns.
> * Changed logic in longjmp to take the return value directly from the
>   second argument. This should make it more similar to the x86_64
>   version.
> * Fixed bug in longjmp where the TLS stack pointer restoration used an
>   invalid base register.
> * Using zero registers instead of an immediate 0 where possible.
> 
> Tests fixed on AArch64:
> winsup.api/mmaptest02.exe
> winsup.api/mmaptest03.exe
> winsup.api/ltp/mmap05.exe
> 
> Signed-off-by: Igor Podgainoi <igor.podgainoi@arm.com>
> ---
>  winsup/cygwin/scripts/gendef | 277 ++++++++++++++++++-----------------
>  1 file changed, 142 insertions(+), 135 deletions(-)

Pushed on top of Thirumalai's patches.


Thanks,
Corinna
