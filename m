Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 353DC4BA2E0D; Thu, 12 Feb 2026 20:34:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 353DC4BA2E0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1770928441;
	bh=yG36CGNJ0C/gHB7y6V14OobVsPIyjzoRHtf0bWoAgBw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=PXCYBTbbEK70wH1LOv7HoKJMuw8YSRQkh4tHgQySr2qHczzevc0Ofz4v49bWERFNu
	 AHo/LGObZ7M4/rnA29DlpT+4EdeTxu/g9m4XZxE+bUukCkXsaLWldThb/KLY1kTRMP
	 pcR2tNV336/r4biw56FIl4oIHZEnG1Pc9t7V38+g=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 53123A80714; Thu, 12 Feb 2026 21:33:59 +0100 (CET)
Date: Thu, 12 Feb 2026 21:33:59 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Igor Podgainoi <Igor.Podgainoi@arm.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>,
	nd <nd@arm.com>
Subject: Re: [PATCH] Cygwin: configure: disable High Entropy VA (64-bit ASLR)
 on AArch64
Message-ID: <aY45Nwdx38DwAg_S@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Igor Podgainoi <Igor.Podgainoi@arm.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>,
	nd <nd@arm.com>
References: <aY3_QASxmA5tGa7u@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aY3_QASxmA5tGa7u@arm.com>
List-Id: <cygwin-patches.cygwin.com>

On Feb 12 16:26, Igor Podgainoi wrote:
> Currently Cygwin does not support the High Entropy Virtual Addressing
> feature, also known as IMAGE_DLL_CHARACTERISTICS_HIGH_ENTROPY_VA and
> 64-bit Address Space Layout Randomization in Windows.
> 
> Whereas on systems running on the x86_64 architecture this feature is
> already disabled by default in the toolchain during the build process,
> the AArch64 version of the toolchain leaves it enabled, even though it
> is not mandatory to use it on Windows on Arm. Only the normal ASLR flag
> IMAGE_DLLCHARACTERISTICS_DYNAMIC_BASE is mandatory, which this patch
> does not address.
> 
> Therefore, this patch manually introduces the addition of High Entropy
> VA disabling flags into several places in various Makefile.am files.
> This should prevent memory overlap bugs on AArch64.
> 
> Tests fixed on AArch64:
> winsup.api/ltp/fork06.exe
> winsup.api/ltp/fork07.exe
> winsup.api/ltp/fork11.exe
> 
> Signed-off-by: Igor Podgainoi <igor.podgainoi@arm.com>
> ---
>  winsup/cygserver/Makefile.am | 2 +-
>  winsup/cygwin/Makefile.am    | 2 +-
>  winsup/testsuite/Makefile.am | 2 +-
>  winsup/utils/Makefile.am     | 4 ++--
>  4 files changed, 5 insertions(+), 5 deletions(-)

Pushed.  We can keep this in, it won't hurt and makes sure we never
build Cygwin with HEVA enabled by accident.


Thanks,
Corinna
