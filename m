Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id CA5AA3858C50; Tue, 26 Nov 2024 13:19:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CA5AA3858C50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1732627194;
	bh=0u52yByOK+1bisABbqeZZ7dRGr7r50PiqHUrCzbIR+4=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=JyXIerM39jFZoOoGMYjnYAJN+Pdl5glqU2Ex2CNntZMSkWFeXshLl4ednq2NRrDFw
	 3BdpDf50he6cdl7HqDimiNOoJieAkExVyX/kQIivVtr5BNZQP4eH0vaS4eaLr+GQnt
	 +4GYHSR2Qw/6XmMtw7XtMUP8/7ZacjyFGIbm09Dk=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 90287A80E83; Tue, 26 Nov 2024 14:19:52 +0100 (CET)
Date: Tue, 26 Nov 2024 14:19:52 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/2] Cygwin: cache IsWow64Process2 host arch in wincap.
Message-ID: <Z0XK-JE0c950m0um@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <9d0630f7-e8d6-b4f6-116b-1df6095877c3@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9d0630f7-e8d6-b4f6-116b-1df6095877c3@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Nov 25 11:21, Jeremy Drake via Cygwin-patches wrote:
> From: Jeremy Drake <cygwin@jdrake.com>
> 
> This was already used in the FAST_CWD check, and could be used in a
> couple other places.
> 
> I found the "emulated"/process value returned from the function largely
> useless, so I did not cache it.  It is useless because, as the docs say,
> it is set to IMAGE_FILE_MACHINE_UNKNOWN (0) if the process is not
> running under WOW64, but Microsoft also doesn't consider x64-on-ARM64 to
> be WOW64, so it is set to 0 regardless if the process is ARM64 or x64.
> You can tell the difference via
> GetProcessInformation(ProcessMachineTypeInfo), but for the current
> process even that's overkill: what we really want to know is the
> IMAGE_FILE_MACHINE_* constant for the Cygwin dll itself, which is
> conveniently located in memory already, so make an accessor function to
> access that.  (It could also be cached in a member variable for a
> simpler accessor, and looked up in init).
> 
> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> ---
> v2: rename current_module_machine to cygwin_machine, adjust comment and
> remove ifdefs from fallback case when IsWow64Process2 fails.
> 
>  winsup/cygwin/local_includes/wincap.h |  3 +++
>  winsup/cygwin/path.cc                 |  6 ++----
>  winsup/cygwin/wincap.cc               | 22 ++++++++++++++++++++++
>  3 files changed, 27 insertions(+), 4 deletions(-)
> [...]
> +extern const IMAGE_DOS_HEADER
> +dosheader __asm__ ("__image_base__");

On second thought, shouldn't we just use GetModuleHandle ("cygwin1.dll")
instead of going asm here?


Thanks,
Corinna
