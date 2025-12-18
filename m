Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id B44684BA2E06; Thu, 18 Dec 2025 10:39:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B44684BA2E06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1766054377;
	bh=Fg7/Arv8Uoh4LqKTf2Rk+o++xrzgM6ACpoL00kiS5tQ=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=rqXr/b+7q7pmXl4tMCmwL2Ry0t2RSQR0SbpdMM9fKQysqJOVmWJb88uFnsw/9xgCK
	 7TZC3iSjsEcsMARWOzBgmg2+Sp2t5nb+Q+50yK7zR16A+ZabLlKW/2Q3qxkhuU8rF/
	 9I76G9+q2DLjVIHz2dcbglui0rK9XVLiADc+LDpo=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D65E7A80797; Thu, 18 Dec 2025 11:39:35 +0100 (CET)
Date: Thu, 18 Dec 2025 11:39:35 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: uinfo: fix overriding group from SAM comment on
 domain machines
Message-ID: <aUPZ51vVfkbWg5vF@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20251215212916.741883-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251215212916.741883-1-corinna-cygwin@cygwin.com>
List-Id: <cygwin-patches.cygwin.com>

On Dec 15 22:29, Corinna Vinschen wrote:
> From: Corinna Vinschen <corinna@vinschen.de>
> 
> When overriding the primary group of a local SAM account via comment
> entry (e.g. '<cygwin group="some_group"/>') on a domain member machine,
> we're prepending the local account domain to the group name before
> fetching the group entry for that group.  While this is necessary to
> fetch real local groups, it disallows to fetch aliases or builtin accounts.
> 
> If the group prepended with the local account domain doesn't fetch a
> valid group, try again with the naked group name, to allow aliases or
> builtin accounts as primary group.
> 
> Fixes: cc332c9e271b ("* uinfo.cc [...] (pwdgrp::fetch_account_from_windows): Drop outdated comment.  Fix code fetching primary group gid of group setting in SAM description field.")
> Signed-off-by: Corinna Vinschen <corinna@vinschen.de>

I'll add this patch to the series fixing the primary group override.
On a pure theoretical base it's independent, but without fixing the
other problem it only makse marginal sense...


Corinna
