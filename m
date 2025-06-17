Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 2BA483852FC2; Tue, 17 Jun 2025 09:24:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2BA483852FC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750152280;
	bh=y3+kip6j9qFUY9aS3MhJCxREgruAFHqbe/q6VJ6ns2A=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=JjAwaOYEw27lMd6KvTiJ52eBRTwh3o8VNQrO+WyA8j+PGkYbMRdw9rqaZPequfpAA
	 W1/TnttQ+es6Wue7mKDx3i1/5gXN5vO99keUbTripYtbdrG2982pImEiq0aUXCt80R
	 KuFMHJ00JiNxWfwMiXlU+bBFG1EMPjMPz/N7JjoI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 16FE0A80961; Tue, 17 Jun 2025 11:24:38 +0200 (CEST)
Date: Tue, 17 Jun 2025 11:24:38 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [RFC PATCH 1/3] Cygwin: allow redirecting stderr in ch_spawn
Message-ID: <aFE0VoED9dQ4QppT@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4b5c620c-4fd9-470f-6e94-965e73f3b6ff@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4b5c620c-4fd9-470f-6e94-965e73f3b6ff@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On May 29 10:57, Jeremy Drake via Cygwin-patches wrote:
> stdin and stdout were alreadly allowed for popen, but implementing
> posix_spawn in terms of spawn would require stderr as well.
> ---
>  winsup/cygwin/dcrt0.cc                    | 2 ++
>  winsup/cygwin/local_includes/child_info.h | 6 +++---
>  winsup/cygwin/spawn.cc                    | 5 +++--
>  3 files changed, 8 insertions(+), 5 deletions(-)

LGTM

Thanks,
Corinna
