Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id DED183857836; Fri, 22 Nov 2024 13:00:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DED183857836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1732280439;
	bh=Bn6LUqpWE3Z39Uv1KV1cASJG0tKgGYOHLUb8evixZWg=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=bTf2V06c8k5BMWpcmNqdh1uh1zoNBvlHJwLKy3WlTwoq3dDtZVW4m06Wdn5PCYAsE
	 TXf3hH/d0tGUwgXiU5mfe1Is4zeV+ObUf5QY6tLcKKolRMXJHbhtLVTZr56+9ziAkK
	 qoNoDXhRVo2aHK3brdOvVBtYPwL2HHGj/+Gpwi6Q=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D1422A80B76; Fri, 22 Nov 2024 14:00:37 +0100 (CET)
Date: Fri, 22 Nov 2024 14:00:37 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Cygwin: cache IsWow64Process2 host arch in wincap.
Message-ID: <Z0CAdVAJgJgvAONa@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <d544a3f1-3b6f-0392-aecf-65125cf5e8f7@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d544a3f1-3b6f-0392-aecf-65125cf5e8f7@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Nov 21 11:42, Jeremy Drake via Cygwin-patches wrote:
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
> ---
> Note the elif defined (__i386__) case won't compile because it references
> the no-longer-present `wow64` value.  This was written and tested against
> 3.3.6, and the __i386__ case could just go away here...

Yeah, just kill it.

> +  const USHORT current_module_machine () const;

This is not necessary.

> @@ -282,4 +284,30 @@ wincapc::init ()
> 
>    __small_sprintf (osnam, "NT-%d.%d", version.dwMajorVersion,
>  		   version.dwMinorVersion);
> +
> +  if (!IsWow64Process2 (GetCurrentProcess (), &emul_mach, &host_mach))
> +    {
> +      /* assume the only way IsWow64Process2 fails for the current process is
> +	 that we're running on an OS version where it's not implemented yet.
> +	 As such, the only two realistic options are AMD64 or I386 */
> +#if defined (__x86_64__)
> +      host_mach = IMAGE_FILE_MACHINE_AMD64;
> +#elif defined (__i386__)
> +      host_mach = wow64 ? IMAGE_FILE_MACHINE_AMD64 : IMAGE_FILE_MACHINE_I386;
> +#else
> +      /* this should not happen */

It should actually result in

  #error unimplemented for this target

> +#endif
> +    }
> +}
> +
> +extern const IMAGE_DOS_HEADER
> +dosheader __asm__ ("__image_base__");
> +
> +const USHORT
> +wincapc::current_module_machine () const
> +{
> +  PIMAGE_NT_HEADERS ntheader = (PIMAGE_NT_HEADERS)((LPBYTE) &dosheader
> +                                                   + dosheader.e_lfanew);
> +  return ntheader->FileHeader.Machine;
>  }

Just scratch that.  First, we're using GetModuleHandle(NULL)
throughout to access the image base, but apart from that,
the info is already available in wincap via cpu_arch().


Corinna
