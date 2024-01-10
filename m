Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 178843858C52; Wed, 10 Jan 2024 15:31:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 178843858C52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1704900704;
	bh=T8HvUjxB5oTfbt7sERBz7MJqjDXQ+JZuGj+7u+PFnc0=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=WaFXm2VgIG6Y4NbQsxj7MBdGU8uYL1fbNNdOJv/vF5C6Ljsfvw63SsMo/i8eRlL0b
	 iOr1s9qq95AHJLTnehLGFzfIZiOxQfmQr1DcnRpOn/RhfOGc+Fwid6rw6AB0iVS9k6
	 Vl6yK4y4JIM/MJQhcKcV9WrTsqoJVf6mD2Spbuyc=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 58844A80871; Wed, 10 Jan 2024 16:31:42 +0100 (CET)
Date: Wed, 10 Jan 2024 16:31:42 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Fix a stray '\n' in cygcheck manpage
Message-ID: <ZZ64XvQD2M0ElHap@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20240110135752.598-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240110135752.598-1-jon.turney@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Jan 10 13:57, Jon Turney wrote:
> ---
>  winsup/doc/utils.xml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/winsup/doc/utils.xml b/winsup/doc/utils.xml
> index 8261e7ebd..692dae38f 100644
> --- a/winsup/doc/utils.xml
> +++ b/winsup/doc/utils.xml
> @@ -210,7 +210,7 @@ At least one command option or a PROGRAM is required, as shown above.
>                         plain console only, not from a pty/rxvt/xterm)
>    -e, --search-package list all available packages matching PATTERN
>                         PATTERN is a glob pattern with * and ? as wildcard chars
> -      search selection specifiers (multiple allowed):\n\
> +      search selection specifiers (multiple allowed):
>        --requires       list packages depending on packages matching PATTERN
>        --build-reqs     list packages depending on packages matching PATTERN
>                         when building these packages
> -- 
> 2.42.1

Yep, thanks!
