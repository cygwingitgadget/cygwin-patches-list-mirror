Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id DBE8A4BA2E06; Wed, 10 Dec 2025 17:37:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DBE8A4BA2E06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1765388274;
	bh=ikzClLobAcpN3f9zzNcsMWn3gOPF9WsoTUpPY7UC9uE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Qs6qhB12vh8v0f0CWLRC55TOrA0YSoy3/D77wNya8wzdpjSIl3KsdiDZThf+BhIi1
	 /Abhoe9Ky25TGHPKxBAahuVkHZmFDkZ3JflbrTa7g0GkvHspbh3ZGQOZzWjvIvg6ol
	 YUfkOXn9kVZnE3qVEMLfZw2FHo5Z5SmO8KmNs6Kg=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 18CA5A80D1A; Wed, 10 Dec 2025 18:37:53 +0100 (CET)
Date: Wed, 10 Dec 2025 18:37:53 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Jon Turney <jon.turney@dronecode.org.uk>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Drop __MINGW64_VERSION_MAJOR version conditionals
Message-ID: <aTmv8d1P5Vi0lRXw@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Jon Turney <jon.turney@dronecode.org.uk>,
	cygwin-patches@cygwin.com
References: <20251210111804.16215-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251210111804.16215-1-jon.turney@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Dec 10 11:18, Jon Turney wrote:
> Unneeded now we check the version at configure-time.
> ---
>  winsup/cygwin/local_includes/ntdll.h | 31 ----------------------------
>  winsup/cygwin/sec/auth.cc            | 19 -----------------
>  2 files changed, 50 deletions(-)

LGTM, thanks!


Corinna
