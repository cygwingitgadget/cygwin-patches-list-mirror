Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id D68733858420; Wed, 22 Jan 2025 11:04:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D68733858420
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1737543887;
	bh=h5WzeTxadXkBSrEvuAqoc+U7FfDjyAo0r0PrNp0zH38=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=dKGflxYWGm8y1sAOFmT9R14zohaylzd1k/gjVOsGnCL/4a4XXtxAqlEB0qpdaNzvZ
	 irpfE7BDqaU9W7sL8nim//2WoK/PRv+8BXP+6IJpQDpdqPzSul3KUg3LohoipIK7Uc
	 oEq+PDUf4BADZrGDjnDV/QQ/jaYvsFHceXr4vkpg=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 3E130A80D1D; Wed, 22 Jan 2025 12:04:46 +0100 (CET)
Date: Wed, 22 Jan 2025 12:04:46 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v7 3/5] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 not implemented new additions
Message-ID: <Z5DQzmtsrcGeFPxx@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cover.1737132501.git.Brian.Inglis@SystematicSW.ab.ca>
 <342fdec23f175f816177ac73945ed7fbf5538b90.1737132501.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <342fdec23f175f816177ac73945ed7fbf5538b90.1737132501.git.Brian.Inglis@SystematicSW.ab.ca>
List-Id: <cygwin-patches.cygwin.com>

On Jan 17 10:01, Brian Inglis wrote:
> Add unavailable POSIX additions to Not Implemented section.
> 
> Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
> ---
>  winsup/doc/posix.xml | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
> index ac05657d2246..7e66cb8fc1c0 100644
> --- a/winsup/doc/posix.xml
> +++ b/winsup/doc/posix.xml
> @@ -16,6 +16,9 @@ ISO/IEC DIS 9945 Information technology
>  - Issue 8.</para>
>  
>  <screen>
> +    CMPLX			
> +    CMPLXF			
> +    CMPLXL			
>      FD_CLR
>      FD_ISSET
>      FD_SET
> @@ -554,6 +557,7 @@ ISO/IEC DIS 9945 Information technology
>      jn
>      jrand48
>      kill
> +    kill_dependency		
>      killpg
>      l64a
>      labs
> @@ -1466,6 +1470,8 @@ ISO/IEC DIS 9945 Information technology
>      mempcpy
>      memrchr
>      mkostemps
> +    posix_spawn_file_actions_addchdir_np
> +    posix_spawn_file_actions_addfchdir_np
>      pow10
>      pow10f
>      pow10l

These first three hunks belong into patch #1 of the set, don't they?

> @@ -1677,9 +1683,14 @@ ISO/IEC DIS 9945 Information technology
>  
>  </sect1>
>  
> -<sect1 id="std-notimpl"><title>NOT implemented system interfaces from the Single Unix Specification, Volume 7:</title>
> +<sect1 id="std-notimpl"><title>NOT implemented system interfaces from the Single UNIX® Specification Version 5:</title>
>  
>  <screen>
> +    _Fork			
> +    dcgettext_l			
> +    dcngettext_l		
> +    dgettext_l			
> +    dngettext_l			
>      endnetent
>      fattach
>      fmtmsg
> @@ -1691,17 +1702,28 @@ ISO/IEC DIS 9945 Information technology
>      getnetbyname
>      getnetent
>      getpmsg
> +    getresgid			
> +    getresuid			
> +    gettext_l			
>      isastream
>      mlockall
>      munlockall
> +    ngettext_l			
> +    posix_close			
> +    posix_devctl		(prototyped in cygwin-devel "devctl.h" header)

Hmm, I guess we should really keep this hint.

Note to self: However, given this is POSIX-1.2024 now, I think the
header in newlib is now incorrect.  We should rectify this.


Thanks,
Corinna
