Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 2C41D4CF308A; Tue, 10 Feb 2026 10:23:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2C41D4CF308A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1770719038;
	bh=McgxLYMlTpGj4DScDJ7Ck7szO+TzbHrROC2CwdDph2Y=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=mKnTRU0VTdRmJm+L8RxWiOdJ4WW9pddWnf4a/lyPuXrkCCgszm2s6zO21KdujcPLf
	 b+3h+fXk+pDnPBedfrHPm3U0jWVN+pRfxT6bUj5JqXJRxLB0ARDCKOtPzvwgV53C1t
	 5o+PCavASyW3Ee6O7ZWfYnfWN+2a9EKsbfCVUU8s=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 40671A805BC; Tue, 10 Feb 2026 11:23:56 +0100 (CET)
Date: Tue, 10 Feb 2026 11:23:56 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Cygwin: gendef: support architecture-specific
 cygwin.din files
Message-ID: <aYsHPKk3pFo6qkMJ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>,
	cygwin-patches@cygwin.com
References: <MA0P287MB3082001F897D700E99FA82CD9F65A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MA0P287MB3082001F897D700E99FA82CD9F65A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
List-Id: <cygwin-patches.cygwin.com>

Hi Thirumalai,

On Feb  9 20:00, Thirumalai Nagalingam wrote:
> Hi Everyone,
> 
> This patch restores support for a common cygwin.din file combined with
> optional architecture-specific cygwin.din fragments, allowing exported
> symbols to vary by target CPU.
> [...]

Thanks, but this doesn't work as desired.

> index d543b9b19..a30ceed3b 100644
> --- a/winsup/cygwin/Makefile.am
> +++ b/winsup/cygwin/Makefile.am
> @@ -646,7 +646,9 @@ $(NEW_DLL_NAME): $(LDSCRIPT) libdll.a $(VERSION_OFILES) $(LIBSERVER)\
>  # cygwin import library
>  toolopts=--cpu=@target_cpu@ --ar=@AR@ --as=@AS@ --nm=@NM@ --objcopy=@OBJCOPY@
> 
> -$(DEF_FILE): scripts/gendef cygwin.din
> +# Architecture-specific .din files
> +ARCH_DIN = $(srcdir)/@target_cpu@/cygwin.din
> +$(DEF_FILE): scripts/gendef cygwin.din $(wildcard $(ARCH_DIN))
>         $(AM_V_GEN)$(srcdir)/scripts/gendef --cpu=@target_cpu@ --output-def=$(DEF_FILE) $(srcdir)/cygwin.din

The easiest way to add the arch specific cygwin.din file is to add it
here on the command line.

> --- a/winsup/cygwin/scripts/gendef
> +++ b/winsup/cygwin/scripts/gendef
> @@ -33,6 +33,23 @@ while (<>) {
>  }
>  my @in = cleanup <>;
> 
> +# Derive arch-specific cygwin.din relative to the common cygwin.din path
> +my $arch_din = $ARGV[0];
> +$arch_din =~ s/cygwin\.din$//;
> +$arch_din .= "$cpu/cygwin.din";
> +
> +if (-f $arch_din) {
> +    open(ARCH_DIN, '<', $arch_din) or die "Cannot open $arch_din: $!\n";
> +    my $in_exports = 0;
> +    while (<ARCH_DIN>) {
> +        $in_exports = 1 if /^\s*exports$/oi;
> +        next unless $in_exports;
> +        next if /^\s*exports$/oi;
> +        push(@in, cleanup $_);
> +    }
> +    close(ARCH_DIN);
> +}
> +

This doesn't work.  I didn't check the perl source, but in the end, with
the second patch moving _alloca to x86_66/cygwin.din, the _alloca symbol
is NOT part of the generated cygwin.def file on x86_64.

If I add $(ARCH_DIN) to the gendef command line in Makefile.am, it works
as desired, even without your gendef patch.

Another point is this:

When we still supported 32 bit x86, the arch-specific din file was
handled prior to the common din file.  The reason at the time was that
the arch-specific din file contained the default DLL address per
arch, i.e.

  LIBRARY "cygwin1.dll" BASE=0x180040000

vs.

  LIBRARY "cygwin1.dll" BASE=0x61000000

Honestly, I don't know if this might be still a problem in future, but
if so, shouldn't we keep the LIBRARY line in the arch-specific din file,
just as in mixed 32/64 bit times?


Thanks,
Corinna
