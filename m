Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 2785A384D14C; Thu, 16 Jan 2025 18:41:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2785A384D14C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1737052903;
	bh=DogViMPg4vPNwsSWn64JkXJMgu/WCpT5HlrtAJeBLXQ=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=lqiK29pKkLoinROD+gz5WHQBBBvKuacNllW5BBSZSoHDaV4BJ7xzx5PlXXOb3ga6h
	 X9ONwNxVYjmuzvgGsqnfo/TYHU96y0cIazDr3jBiPeh+et6jfAMrI0ujffHlYWQUur
	 xYFqiGKFgZfYYQfaqIEa4ceAkEo02LZNYYHZxISk=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 8FFA0A8076D; Thu, 16 Jan 2025 19:41:41 +0100 (CET)
Date: Thu, 16 Jan 2025 19:41:41 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v6 3/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 not implemented new additions
Message-ID: <Z4lS5SKVFB4FdcLq@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cover.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
 <a216df577267a5e8b61b220969da57691f6a341f.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a216df577267a5e8b61b220969da57691f6a341f.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
List-Id: <cygwin-patches.cygwin.com>

On Jan 15 12:39, Brian Inglis wrote:
> Add unavailable POSIX additions to Not Implemented section,
> with mentions of headers and packages where they are expected.
> 
> Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
> ---
>  winsup/doc/posix.xml | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
> index 0b23a2251028..89728e050bef 100644
> --- a/winsup/doc/posix.xml
> +++ b/winsup/doc/posix.xml
> @@ -1681,9 +1681,14 @@ ISO/IEC DIS 9945 Information technology
>  
>  </sect1>
>  
> -<sect1 id="std-notimpl"><title>NOT implemented system interfaces from the Single Unix Specification, Volume 7:</title>
> +<sect1 id="std-notimpl"><title>NOT implemented system interfaces from the Single UNIX® Specification Version 5:</title>
>  
>  <screen>
> +    _Fork			(not available in "(sys/)unistd.h" header)
> +    dcgettext_l			(not available in external gettext "libintl" library)
> +    dcngettext_l		(not available in external gettext "libintl" library)
> +    dgettext_l			(not available in external gettext "libintl" library)
> +    dngettext_l			(not available in external gettext "libintl" library)

Sorry, but they are not available.  It doesn't matter *where* they are
not available.  Please drop the hints.


Thanks,
Corinna
