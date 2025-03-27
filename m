Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 615AA3858D20; Thu, 27 Mar 2025 11:41:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 615AA3858D20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1743075674;
	bh=Sun74LrzNQLnI42OuA98K0S2iKzGQ7luK/bCpBAjOP8=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=sAwRsVDhi5B0G7+hLPNhqub8UIKUG/+q4jONb3FA19g22+/0kmlK8g3ll3zsHTxnt
	 iUDnX9dj9JH4rmQSXR0qtjxLd4yDrULI/iHzsZlGzCK6pfk49PdVld/xbINoh+RAME
	 FqEMZZOldyHeWbewGeLR2zmpt9IAyifNBXUFMl9Y=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 4F404A806F0; Thu, 27 Mar 2025 12:41:12 +0100 (CET)
Date: Thu, 27 Mar 2025 12:41:12 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 4/5] Cygwin: use udis86 to find fast cwd pointer on x64
Message-ID: <Z-U5WFBxoUfeVwn7@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <7d4f8d91-0a3f-4e14-047e-64b1bd7d9447@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7d4f8d91-0a3f-4e14-047e-64b1bd7d9447@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Jeremy,

ok, three questions...

Q1: How does it compare performancewise to the old code?  Fortunately
    it's only called once per process tree, so this shoudn't have much
    impact, but still nice to know...

Q2: Would you mind to add more comments?

On Mar 26 16:52, Jeremy Drake via Cygwin-patches wrote:
> From: Jeremy Drake <cygwin@jdrake.com>
> 
> This makes find_fast_cwd_pointer more resiliant in the face of changes
> to the generated code in ntdll.
> 
> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> ---
>  winsup/cygwin/x86_64/fastcwd_x86_64.cc | 204 +++++++++++++++----------
>  1 file changed, 124 insertions(+), 80 deletions(-)
> [...]

Q2a: A preceeding one line comment briefly explaining the function?

> +static inline const void *
> +rip_rel_offset (const ud_t *ud_obj, const ud_operand_t *opr, int sub_off=0)
> +{
> +  return (const void *) (ud_insn_off (ud_obj) + ud_insn_len (ud_obj) +
> +			 opr->lval.sdword - sub_off);
> +}
> 
>  /* This function scans the code in ntdll.dll to find the address of the
>     global variable used to access the CWD.  While the pointer is global,
> @@ -30,99 +37,136 @@ find_fast_cwd_pointer_x86_64 ()
>  			    GetProcAddress (ntdll, "RtlEnterCriticalSection");
>    if (!get_dir || !ent_crit)
>      return NULL;

Q2b: Comment like "Initializing" blah?

> +  ud_t ud_obj;
> +  ud_init (&ud_obj);
> +  ud_set_mode (&ud_obj, 64);
> +  ud_set_input_buffer (&ud_obj, get_dir, 80);
> +  ud_set_pc (&ud_obj, (const uint64_t) get_dir);
> +  const ud_operand_t *opr;
> +  ud_mnemonic_code_t insn;
>    /* Search first relative call instruction in RtlGetCurrentDirectory_U. */
> -  const uint8_t *rcall = (const uint8_t *) memchr (get_dir, 0xe8, 80);
> -  if (!rcall)
> +  const uint8_t *use_cwd = NULL;
> +  while (ud_disassemble (&ud_obj) &&
> +      (insn = ud_insn_mnemonic (&ud_obj)) != UD_Iret &&
> +      insn != UD_Ijmp)
> +    {
> +      if (insn == UD_Icall)
> +	{
> +	  opr = ud_insn_opr (&ud_obj, 0);
> +	  if (opr->type == UD_OP_JIMM && opr->size == 32)
> +	    {
> +	      /* Fetch offset from instruction and compute address of called
> +		 function.  This function actually fetches the current FAST_CWD
> +		 instance and performs some other actions, not important to us.
> +	       */
> +	      use_cwd = (const uint8_t *) rip_rel_offset (&ud_obj, opr);
> +	      break;
> +	    }
> +	}
> +    }
> +  if (!use_cwd)
>      return NULL;
> -  /* Fetch offset from instruction and compute address of called function.
> -     This function actually fetches the current FAST_CWD instance and
> -     performs some other actions, not important to us. */
> -  const uint8_t *use_cwd = rcall + 5 + peek32 (rcall + 1);
> +  ud_set_input_buffer (&ud_obj, use_cwd, 120);
> +  ud_set_pc (&ud_obj, (const uint64_t) use_cwd);
> +
>    /* Next we search for the locking mechanism and perform a sanity check.
> -     On Pre-Windows 8 we basically look for the RtlEnterCriticalSection call.
> -     Windows 8 does not call RtlEnterCriticalSection.  The code manipulates
> -     the FastPebLock manually, probably because RtlEnterCriticalSection has
> -     been converted to an inline function.  Either way, we test if the code
> -     uses the FastPebLock. */
> -  const uint8_t *movrbx;
> -  const uint8_t *lock = (const uint8_t *)
> -                        memmem ((const char *) use_cwd, 80,
> -                                "\xf0\x0f\xba\x35", 4);
> -  if (lock)
> +     On Pre- (or Post-) Windows 8 we basically look for the

Q3: or post?  Really?  AFAIK, this was only an issue on pre W8, so it
    affects Vista and W7 only.  Theoretically this check can go away,
    unless you have proof this is still an issue in some later Windows
    starting with 8.1.

> +     RtlEnterCriticalSection call.  Windows 8 does not call
> +     RtlEnterCriticalSection.  The code manipulates the FastPebLock manually,
> +     probably because RtlEnterCriticalSection has been converted to an inline
> +     function.  Either way, we test if the code uses the FastPebLock. */
> +  PRTL_CRITICAL_SECTION lockaddr = NULL;
> +
> +  /* both cases have an `lea rel(%rip)` on the lock */
> +  while (ud_disassemble (&ud_obj) &&
> +      (insn = ud_insn_mnemonic (&ud_obj)) != UD_Iret &&
> +      insn != UD_Ijmp)
>      {

Q2c: Roundabout here, I'm getting the impression we're losing
     more comments than we gain.  This is not a good way to raise
     confidence ;)

Codewise I have nothing to carp at, but comments are a bit sparse
for my taste...


Thanks,
Corinna
