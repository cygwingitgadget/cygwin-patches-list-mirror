Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 67AC14BA2E05; Thu, 18 Dec 2025 11:47:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 67AC14BA2E05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1766058431;
	bh=QDo1p0cjq+njU3UY25u9/wKoU4bwmMvUMQh1Qp8BFyA=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=VTN9X2WSxPp7RqxOlyaBbKJUfN54j+AKr5fxrJsrUxYGRpRtxfLe8k8fAt+o176x7
	 bCPz/ucxldHypUzHI4oFeOR4a3BI8wfoPfE3fHSnlGui0vyeUgOstcggWmKfOdt8WE
	 TEzEoBKTGb6lETiNqCF6Hq1Cjksmhm/VkeOCW8Yk=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 7748EA80B65; Thu, 18 Dec 2025 12:47:09 +0100 (CET)
Date: Thu, 18 Dec 2025 12:47:09 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/4] Fix overriding primary group
Message-ID: <aUPpvSw_kgeE6gdK@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20251218112308.1004395-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251218112308.1004395-1-corinna-cygwin@cygwin.com>
List-Id: <cygwin-patches.cygwin.com>

I forgot...

On Dec 18 12:23, Corinna Vinschen wrote:
> From: Corinna Vinschen <corinna@vinschen.de>
> 
> Fix broken code overriding primary group at process tree startup and
> overriding groups from local SAM comment on domain member machines.
> 
> The first bug is fallout from adding newgrp(1) to the Cygwin
> utils.  It turned out that the Cygwin startup code didn't take
> an already changed primary group in the user token into account,
> which made newgrp(1) a no-op.
> 
> Unfortunately the fix from commit dc7b67316d01 ("Cygwin: uinfo: prefer
> token primary group") made newgrp(1) work as desired, but broke the
> scenario where a user's primary group was changed in the passwd entry
> or in a SAM comment.
> 
> The second bug is actually pretty long-standing behaviour, but
> apparently local SAM accounts are not in muchg use on domain member
> machines...
> 
> Corinna Vinschen (4):
>   Cygwin: uinfo: correctly check and override primary group
>   Cygwin: uinfo: allow to override user account as primary group
>   Cygwin: uinfo: fix overriding group from SAM comment on AD member
>     machines
>   Cygwin: add release note for primary group override fix
> 
>  winsup/cygwin/release/3.6.6 |  4 ++++
>  winsup/cygwin/uinfo.cc      | 25 +++++++++++++++++++------
>  2 files changed, 23 insertions(+), 6 deletions(-)

v2: Try to improve commit messages, add patch fixing primary group
    override for local accounts on domain member machines to the
    patchset.


Sorry,
Corinna
