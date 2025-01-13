Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 9B03F3857B8C; Mon, 13 Jan 2025 11:16:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9B03F3857B8C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1736766972;
	bh=rrAwD38pzRfycwe1N8KmB0KtV3U72lbQ3mMcjbf2ohI=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=S4GcCmxrBrDAP+/joqokR/yVy/w4N/RRpsNRmdg4mblXfIwFtOQksWN+plZtzFmVU
	 ehHuB5Z1fPA6NSG7yZkeZFx7ugP6PqTUWH3K+ZsPahj+X0BD4HGWoAmH2DpyK9dW+4
	 x7PWS4Rgi7mR2szSRcKjqgXApHOryHr6uDWV/DkI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id EAC08A80A67; Mon, 13 Jan 2025 12:16:10 +0100 (CET)
Date: Mon, 13 Jan 2025 12:16:10 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5 1/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 TOG Issue 8 ISO 9945 move new
Message-ID: <Z4T1-rjrkks8j57g@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <ce4fb1f0bb4390758b48d56bf635de71b5809b42.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce4fb1f0bb4390758b48d56bf635de71b5809b42.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
List-Id: <cygwin-patches.cygwin.com>

Hi Brian,

On Jan 10 17:01, Brian Inglis wrote:
> Update anchor id and description to current version, year, issue, etc.
> Move new POSIX entries in other sections to the SUS/POSIX section.
> 
> Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
> ---
>  winsup/doc/posix.xml | 140 ++++++++++++++++++++++---------------------
>  1 file changed, 73 insertions(+), 67 deletions(-)
> 
> diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
> index 2782beb86547..1b893e9e19ae 100644
> --- a/winsup/doc/posix.xml
> +++ b/winsup/doc/posix.xml
> @@ -5,10 +5,16 @@
>  <chapter id="compatibility" xmlns:xi="http://www.w3.org/2001/XInclude">
>  <title>Compatibility</title>
>  
> -<sect1 id="std-susv4"><title>System interfaces compatible with the Single Unix Specification, Version 7:</title>
> +<sect1 id="std-susv5"><title>System interfaces compatible with the Single UNIX® Specification Version 5:</title>
>  
> -<para>Note that the core of the Single Unix Specification, Version 7 is
> -also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
> +<para>Note that the core of the Single UNIX® Specification Version 5 is
> +POSIX®.1-2024 also simultaneously IEEE Std 1003.1™-2024 Edition,
> +The Open Group Base Specifications Issue 8
> +(see https://pubs.opengroup.org/onlinepubs/9799919799/), and
> +ISO/IEC DIS 9945 Information technology
> +- Portable Operating System Interface (POSIX®) base specifications
> +- Issue 8 (expected to replace ISO/IEC/IEEE 9945:2009 - Issue 7 in the coming months

This hint is outdating itself.  It might be a good idea to
phrase it time-independent...

>  <sect1 id="std-iso"><title>System interfaces not in POSIX but compatible with ISO C requirements:</title>
>  
>  <screen>
> -    aligned_alloc		(ISO C11)
> -    at_quick_exit		(ISO C11)
> -    c16rtomb			(ISO C11)
> -    c32rtomb			(ISO C11)
>      c8rtomb			(ISO C23)

Did they really miss to standarize c8rtomb/mbrtoc8 as well?
I guess C23 was too fresh... ;)


Corinna
