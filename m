Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 728E63858427; Fri, 14 Feb 2025 12:09:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 728E63858427
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1739534973;
	bh=1dKYB3TurDaQTrxiSh3ZvvhamBpFQcWNOKGzH+pkzxg=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=Eujuz/vok+krK3ZbqMcQO9QKKpfSfSuQcstPLreekXouY1jnUCF1dEMt9ikBHQZcC
	 W3EjyxiaL89easzFimarkY3KGQ6m/Xzx0tbXX2lfIcZyoLJRTOj3RsSwiw718FEt0x
	 T4GoFw8vNUuIVSUFjN3NkAJN1z1OHNI4aZaqTmtQ=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 6A6A2A80D3F; Fri, 14 Feb 2025 13:09:31 +0100 (CET)
Date: Fri, 14 Feb 2025 13:09:31 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: 3.6.0: add release entries for my patches.
Message-ID: <Z68ye-6LPqHRZu06@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <88cff69f-e6df-2aa7-cb00-e86ddb10796d@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <88cff69f-e6df-2aa7-cb00-e86ddb10796d@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Feb 13 16:23, Jeremy Drake via Cygwin-patches wrote:
> These are:
>   04a5b07294 Cygwin: expose all windows volume mount points.
>   0d113da235 Cygwin: /proc/<PID>/mount*: escape strings.
>   7923059bff Cygwin: uname: add host machine tag to sysname.
>   b091b47b9e cygthread: suspend thread before terminating.
> 
> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> ---
>  winsup/cygwin/release/3.6.0 | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

Pushed. I also updated the docs.

Thanks,
Corinna
