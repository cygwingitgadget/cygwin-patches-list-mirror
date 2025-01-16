Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id DDCF1385841C; Thu, 16 Jan 2025 17:19:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DDCF1385841C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1737047983;
	bh=Fd2JlKe/v+UIb5PQI91f5Kooz40wLgUozXutPjtjMVM=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=mOY35vMNQugQJv3j3ckY0jHzhDoNPCpAmuctMmexyGRHyBAD9AM2/X+G4blvQXuo1
	 H8R86Vva9embjWeZNLYnYvVSQOvJ+Odyun/JkJtURNQmOUvGQwm3oz6IvVx+HsE5dr
	 EkK018aq3oqCEm94DFotkRdP0rUNrJR7lMcvYLaw=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 49EF0A8076D; Thu, 16 Jan 2025 18:19:42 +0100 (CET)
Date: Thu, 16 Jan 2025 18:19:42 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v6 1/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 move new entries
Message-ID: <Z4k_rpmDDPjYWp6h@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cover.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
 <0b9a9708e62ca8a77a5efbbc18543d77b73704b0.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0b9a9708e62ca8a77a5efbbc18543d77b73704b0.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
List-Id: <cygwin-patches.cygwin.com>

Hi Brian,

On Jan 15 12:39, Brian Inglis wrote:
> +    aligned_alloc		(ISO C11)
> +    assert			(SVID - available in "assert.h" header)
> +    at_quick_exit		(ISO C11)
> +    c16rtomb			(ISO C11)
> +    c32rtomb			(ISO C11)

The source hint in parens should go away.  Everything which *is* in
POSIX *and* part of the newlib/Cygwin package, doesn't need a source
hint.

> +    mbrtoc16			(ISO C23 - available in "uchar.h" header)
> +    mbrtoc32			(ISO C23 - available in "uchar.h" header)

And these are wrong, btw.  mbrtoc16/mbrtoc32 are C11 just like
c16rtomb/c32rtomb.  Only the c8 variants are C23.  But given they
are POSIX and implemented in Cygwin itself, just scratch the hint.

> +    dladdr			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
>      encrypt			(available in external "crypt" library)

These are still ok and the only type of hints which should be maintained
in the SUS chapter.

> +    posix_spawn_file_actions_addchdir	(available as posix_spawn_file_actions_addchdir_np)
> +    posix_spawn_file_actions_addfchdir	(available as posix_spawn_file_actions_addfchdir_np)

Oh, I missed that these two are defined in POSIX now.  Scratch the hint,
I'll change the header and add matching exports, and...

> -    posix_spawn_file_actions_addchdir_np
> -    posix_spawn_file_actions_addfchdir_np

...these two should stay where they are.


Thanks,
Corinna
