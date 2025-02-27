Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 3CABF3858D26; Thu, 27 Feb 2025 12:18:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3CABF3858D26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1740658684;
	bh=SWu+Ci6D6Oj3cWpoI7xugzqh+g+B0zHd8Eje9bLvCHU=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=bHjT527e+UVLn62ReugAvLlxKIaQFrVgt2bQ5kgnl2DjWF5H70Eyp/5kp9cba/PSS
	 sruDGGsGiLdbnBXsExdCpydp2NPn+6se5YqeB906e9ckbBv9RJzKn18+GmI77IV51Z
	 tCtgo7n8dIE/1joj8mmF8gKZpW8M81bJovGLF2Ko=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 32FE1A809BA; Thu, 27 Feb 2025 13:18:02 +0100 (CET)
Date: Thu, 27 Feb 2025 13:18:02 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: Add spawn family of functions to docs
Message-ID: <Z8BX-l89GF780MMF@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <https://cygwin.com/pipermail/cygwin-patches/2025q1/013425.html>
 <20250227063608.53165-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250227063608.53165-1-mark@maxrnd.com>
List-Id: <cygwin-patches.cygwin.com>

On Feb 26 22:35, Mark Geisert wrote:
> In the doc tree, add a new section "Other system interfaces[...]" that
> lists the spawn family of functions, most of the exposed cygwin internal
> functions that a user might have use for, and some other functions
> duplicating Windows or DOS interfaces that might have some utility.
> 
> ---
>  winsup/doc/posix.xml | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)

Pushed.

Thanks,
Corinna
