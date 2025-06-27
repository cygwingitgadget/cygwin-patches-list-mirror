Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id CFF423858408; Fri, 27 Jun 2025 11:14:37 +0000 (GMT)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id A4F18A806FF; Fri, 27 Jun 2025 13:14:35 +0200 (CEST)
Date: Fri, 27 Jun 2025 13:14:35 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/5] Cygwin: allow redirecting stderr in ch_spawn
Message-ID: <aF59GwzNozRYeAp4@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cb938c47-80dd-78c6-876f-7a36112960af@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cb938c47-80dd-78c6-876f-7a36112960af@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Jun 26 16:55, Jeremy Drake via Cygwin-patches wrote:
> stdin and stdout were alreadly allowed for popen, but implementing
> posix_spawn in terms of spawn would require stderr as well.
> 
> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> ---
>  winsup/cygwin/dcrt0.cc                    | 2 ++
>  winsup/cygwin/local_includes/child_info.h | 6 +++---
>  winsup/cygwin/spawn.cc                    | 5 +++--
>  3 files changed, 8 insertions(+), 5 deletions(-)

LGTM.  A sentence on why we can actually use the filler bytes now
wouldn't hurt in the commit message.


Thanks,
Corinna
