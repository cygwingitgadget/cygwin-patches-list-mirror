Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id AACBD4BA2E04; Mon, 15 Dec 2025 15:23:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AACBD4BA2E04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1765812211;
	bh=2m3Rps6zxlFbPIi3vEQIOU5ncyhFnoqyRdMXcISWgnw=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=I3nDhadMcLazPE53nOKDiy2LZ/nNJdbHz/tnEV7yB1ln67b2yioX+RzebSLEioDDH
	 DysO8IafK118EeVt8LyygaBAvEH3y/Gq3+He92dEL5Gl1/KB5gEK4v+3RdGy6Y04A9
	 LssT04ezDu9JWKIGWIr3c8X5M2LuGHp+0fxq/pz0=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id CB3A7A80BA1; Mon, 15 Dec 2025 16:23:29 +0100 (CET)
Date: Mon, 15 Dec 2025 16:23:29 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Fix overriding primary group
Message-ID: <aUAn8aPCHHOWpEoO@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20251205163856.3993550-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251205163856.3993550-1-corinna-cygwin@cygwin.com>
List-Id: <cygwin-patches.cygwin.com>

On Dec  5 17:38, Corinna Vinschen wrote:
> From: Corinna Vinschen <corinna@vinschen.de>
> 
> Fix broken code overriding primary group at process tree startup.  THis
> is fallout frokm the newgrp(1) introduction which showed a problem with
> this code.  The fix from commit dc7b67316d01 ("Cygwin: uinfo: prefer
> token primary group") broke this differently, so here we go, trying to
> fix the second problem without breaking the first again.
> 
> Corinna Vinschen (3):
>   Cygwin: uinfo: correctly check and override primary group
>   Cygwin: uinfo: allow to override user account as primary group
>   Cygwin: add release note for primary group override fix

Ping?  Anybody willing to review?


Thanks,
Corinna
