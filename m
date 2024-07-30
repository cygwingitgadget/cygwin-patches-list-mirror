Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id DB7CF385B50C; Tue, 30 Jul 2024 12:48:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DB7CF385B50C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1722343692;
	bh=qBP/4TYpjQ/8fO3KIGXRsI7dCfYfSsvUdFtVTHasnrM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=pl7YTQT1dYSu7wMJx0163riZVP4FrXXgxzE2MicumfQj2MFJOXP+vwAikENTq/HVe
	 AJkxjrXEgnoKccJPBpo+aC3lhxhA88bX9u9p/XccMwRdRdQPoCJSPzLwkAoByx7q52
	 /BXhocOYE7oZu1uCRirGofCS2IGNpCmey+H5OfV4=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D5C57A80CFF; Tue, 30 Jul 2024 14:48:10 +0200 (CEST)
Date: Tue, 30 Jul 2024 14:48:10 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Brian Inglis <Brian.Inglis@systematicsw.ab.ca>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/3] Cygwin: fhandler/proc.cc(format_proc_cpuinfo): Linux
 6.10 changes
Message-ID: <ZqjhCnxyZVnReXBA@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Brian Inglis <Brian.Inglis@systematicsw.ab.ca>,
	cygwin-patches@cygwin.com
References: <cover.1721213593.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1721213593.git.Brian.Inglis@SystematicSW.ab.ca>
List-Id: <cygwin-patches.cygwin.com>

On Jul 18 10:27, Brian Inglis wrote:
> Linux 6.10 "Baby Opossum Posse" added cpuinfo feature flags for output. 
> 
> Linux cpuinfo follows output for each processor with a blank line,
> so we output newlines to get a blank line.
> 
> Linux 6.10 changed the content of cpufeatures.h to require explicit
> quoted flag names for output in comments, instead of requiring a null
> quoted string "" at the start of comments to suppress flag name output.
> As a result, some flags (not all for output) were renamed and others moved.
> 
> Brian Inglis (3):
>   Cygwin: fhandler/proc.cc(format_proc_cpuinfo): Linux 6.10 flags added
>   Cygwin: fhandler/proc.cc(format_proc_cpuinfo): add newlines
>   Cygwin: fhandler/proc.cc(format_proc_cpuinfo): Linux 6.10 flags resync
> 
>  winsup/cygwin/fhandler/proc.cc | 50 ++++++++++++++++++++--------------
>  1 file changed, 30 insertions(+), 20 deletions(-)
> 
> -- 
> 2.45.1

Pushed.

Thanks,
Corinna
