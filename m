Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id A90703858401; Mon,  5 Aug 2024 10:18:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A90703858401
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1722853087;
	bh=g6qTyET+yZihxs5PMSTE1KUQvPXVNYXKVH3KQKkivtM=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=VXePERpnI7xh5kuWC/BwyQiGAISjPMbGb/gom13+vZy1fmpKiricaeZwYLNlKdU8o
	 OUq9dbxW6yO1cJvkB3RNYKaeEyGYSDnUPoUAimAADZB9rUdbKddXo/hFf6lbfHBD+S
	 gC25HqSFXVtZMm/9kgAq5LaoEP9vXRInhD4wiUS4=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 8D846A80EB0; Mon,  5 Aug 2024 12:18:05 +0200 (CEST)
Date: Mon, 5 Aug 2024 12:18:05 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/6] Cygwin: Fix warning about address known to be
 non-NULL in /proc/locales
Message-ID: <ZrCm3YnYsmg3IWQB@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20240804214829.43085-1-jon.turney@dronecode.org.uk>
 <20240804214829.43085-4-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240804214829.43085-4-jon.turney@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Aug  4 22:48, Jon Turney wrote:
> Fix a gcc 12 warning about an address known to be non-NULL in
> format_proc_locale_proc().
> 
> > ../../../../src/winsup/cygwin/fhandler/proc.cc: In function ‘BOOL format_proc_locale_proc(LPWSTR, DWORD, LPARAM)’:
> > ../../../../src/winsup/cygwin/fhandler/proc.cc:2156:11: error: the address of ‘iso15924’ will never be NULL [-Werror=address]
> >  2156 |       if (iso15924)
> >       |           ^~~~~~~~
> > ../../../../src/winsup/cygwin/fhandler/proc.cc:2133:11: note: ‘iso15924’ declared here
> >  2133 |   wchar_t iso15924[ENCODING_LEN + 1] = { 0 };
> >       |           ^~~~~~~~
> ---
>  winsup/cygwin/fhandler/proc.cc | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler/proc.cc b/winsup/cygwin/fhandler/proc.cc
> index 8c7a4ab06..f1cd468fc 100644
> --- a/winsup/cygwin/fhandler/proc.cc
> +++ b/winsup/cygwin/fhandler/proc.cc
> @@ -2193,8 +2193,7 @@ format_proc_locale_proc (LPWSTR win_locale, DWORD info, LPARAM param)
>        if (!(cp2 = wcschr (cp + 2, L'-')))
>          return TRUE;
>        /* Otherwise, store in iso15924 */
> -      if (iso15924)
> -        wcpcpy (wcpncpy (iso15924, cp, cp2 - cp), L";");
> +      wcpcpy (wcpncpy (iso15924, cp, cp2 - cp), L";");
>      }
>    cp = wcsrchr (win_locale, L'-');
>    if (cp)
> -- 
> 2.45.1

I think iso15924 was supposed to be a pointer at first and after
converting it to an array I just forgot to take out the check.

Can you please add

  Fixes: c42b98bdc665f ("Cygwin: introduce /proc/codesets and /proc/locales")

Oh and, while I'm at it, please add your Signed-off-by to all your
patches.

Thanks,
Corinna
