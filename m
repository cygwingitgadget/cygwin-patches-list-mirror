Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 9A2DC3858C60; Fri, 12 Jan 2024 18:44:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9A2DC3858C60
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1705085078;
	bh=397b7ktOp2t2SIxSJxbHww9PcM4z1MO0sdwlCd/YKOs=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=dIfAedVu6kjcrRh7tyFjQ8W/c2YImSJZJ4MXyoV4xVRLO0v+KV9jQnVRu6yWNUf12
	 MuAAI4lWF/MjfkcdciAx8IK1A83tCDNSX3pcLh8eJzGVsxlmbwDfYwTdpKSAJCow/m
	 icMSDMNkqquvT32WaVZDlyBKRHNjEWF5fRCwQ9q0=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id E316BA807B2; Fri, 12 Jan 2024 19:44:36 +0100 (CET)
Date: Fri, 12 Jan 2024 19:44:36 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 5/5] Cygwin: Update documentation for cygwin_stackdump
Message-ID: <ZaGIlGGizJxsC35M@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20240112140958.1694-1-jon.turney@dronecode.org.uk>
 <20240112140958.1694-6-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240112140958.1694-6-jon.turney@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Jan 12 14:09, Jon Turney wrote:
> ---
>  winsup/doc/misc-funcs.xml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/winsup/doc/misc-funcs.xml b/winsup/doc/misc-funcs.xml
> index 7463942e6..55c5cac94 100644
> --- a/winsup/doc/misc-funcs.xml
> +++ b/winsup/doc/misc-funcs.xml
> @@ -106,6 +106,10 @@ enum.  The second is an optional pointer.</para>
>    <refsect1 id="func-cygwin-stackdump-desc">
>      <title>Description</title>
>  <para> Outputs a stackdump to stderr from the called location.
> +</para>
> +<para> Note: This function is has an effect the first time it is called by a process.
                              ^^^^^^
This looks like a rephrasing attempt gone slightly wrong.

I'm also not quite sure what you're trying to say here. Maybe a bit more
detailed would help me and other readers?


Thanks,
Corinna
