Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 669EC3858D29; Fri, 29 Nov 2024 09:58:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 669EC3858D29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1732874321;
	bh=ZkMVn813HnyBAR7L0YnMyA3Edgt2UQuqoCEwsTwo9NI=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=JiBkzbBbqVtCFJkdlhB+aOxLODh18WQXi9S1Xb0R7pKFQM7VtqZnqwLeBzN+moT3u
	 1cBIo9q022FWKl3G4bBizvqYlbnnyI0wrKm7EQZZ/Nuiy5Qp9K/uUaC2FkozvyOo7A
	 32q0nAdTkZ/mSQFBclec349DaEGa3lpQ0H3SdPDQ=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 62AEFA80984; Fri, 29 Nov 2024 10:58:39 +0100 (CET)
Date: Fri, 29 Nov 2024 10:58:39 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 2/2] Cygwin: uname: add host machine tag to sysname.
Message-ID: <Z0mQT_vVL3e62dmZ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <018bf8a4-0aa3-8885-8532-d2db9e73e390@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <018bf8a4-0aa3-8885-8532-d2db9e73e390@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Nov 27 11:26, Jeremy Drake via Cygwin-patches wrote:
> From: Jeremy Drake <cygwin@jdrake.com>
> 
> If the Cygwin dll's architecture is different from the host system's
> architecture, append an additional tag that indicates the host system
> architecture (the Cygwin dll's architecture is already indicated in
> machine).
> 
> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> ---
> v2: get rid of hardcoded string lengths, use wincap accessors
> directly instead of caching their returns, actually add "n" variable as
> intended
> 
> v3: inline append_host_suffix, remove unnecessary switch cases, fix typo
> strcpy -> stpcpy in ARM64 case
> 
>  winsup/cygwin/uname.cc | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)

Pushed.


Thanks,
Corinna
