Return-Path: <SRS0=d9R/=64=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.227.117])
	by sourceware.org (Postfix) with ESMTPS id B05AF4BA2E04
	for <cygwin-patches@cygwin.com>; Mon, 22 Dec 2025 06:56:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B05AF4BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B05AF4BA2E04
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.117
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766386570; cv=none;
	b=MXS0yGfrD9fQhpdBA7uFv6iTuUpCfU1jH30r6DKwVdXoETyVYRnLelW1/LsVO0Kg6IHIHxhllDozqd8fgXyTWYeTf7SwNfR3uBP89Y94LzVnO9NFDprck5+/IWAgnCMnk/q9RESsH8ixymdQD52ifymEvxBggar8okxKVkGZyLc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766386570; c=relaxed/simple;
	bh=FspaLALfAXT3GVoTjc9cdDZt8Djt4J0hK2O6R8AKTqs=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=NYiVz2p0Exj0h6kj4ecoYOKncn+RcRkkqvQXZPJPZLIYYOEB4JsjAA/ARbHrpuWEm4lgHXe3pItDjo7Su59L6ynabAY9MNJnw8frrRcLmrBascBo1qKoycphuMdPz6AIuFGNkx6BUCvcL67KOhb02N63JTTGsQ86or+dKi9oo8g=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B05AF4BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=e+X/tJIV
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20251222065607916.VNTR.36235.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 22 Dec 2025 15:56:07 +0900
Date: Mon, 22 Dec 2025 15:56:06 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 3/4] Cygwin: uinfo: fix overriding group from SAM
 comment on AD member machines
Message-Id: <20251222155606.4cd511a366054fc2f4f41d34@nifty.ne.jp>
In-Reply-To: <20251218112308.1004395-4-corinna-cygwin@cygwin.com>
References: <20251218112308.1004395-1-corinna-cygwin@cygwin.com>
	<20251218112308.1004395-4-corinna-cygwin@cygwin.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1766386567;
 bh=zuVdTohKAtMa4OAVdAeBfPMLzRnEliWk6ubB5EXJNFg=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=e+X/tJIVPeUgE6BXLo+ik9AiN4FraKWFXe6NbTuv1lK+41SbZpdH9OeZQ/eidleVgMY8koK2
 Q/IJK5F2ci0YcmJHepTHr4ysgqaFlwMIovYN4CNAHeDE8G1kLP2K8dT44Ib3M22TnMIVEV5M+6
 whGeStX1vP0ipi4fKc3BNClK/njlbQzTJEmQgC3zI8fvbJ2/sQSLU8GNtqSLIBpi0E0dAhpRj3
 +49OmzFLRrkSo2d4XbBVCcZVPJ9m9r6tempBzgSeFLhZ6RS48Bt+ZV7C/jlX55iNy9gSxqF1a1
 leK93OscQGAgaZIVOV+i9vYEsXRsc9kmJl6rK+UlQTt8YqQQ==
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 18 Dec 2025 12:23:07 +0100
Corinna Vinschen wrote:
> From: Corinna Vinschen <corinna@vinschen.de>
> 
> When overriding the (localized) primary group "None" of a local SAM
> account via SAM comment entry (e.g. '<cygwin group="some_group"/>') on a
> Active Directory domain member machine, we have to take into account,
> that the local account domain (actually the machine name) is always
> prepended to local account names, i. e.
> 
>   MACHINE+account
> 
> because the names without prepended domain are reserved for the
> primary AD domain accounts.
> 
> Therefore commit cc332c9e271b added code to prepend the local account
> domain to the group name from the SAM comment, if the machine is a
> domain member.
> 
> But here's the problem:
> 
> If the group in the SAM comment entry is a real local group, prepending
> the local account domain is all nice and dandy.  But if the account used
> in the SAM comment is a builtin like "Authenticated Users" (S-1-5-11) or
> an alias like "Users" (S-1-5-32-545), this falls flat.
> 
> This patch keeps the check for "MACHINE+account" first.  This avoids
> fetching the AD group rather than the local SAM group, if a local
> group has the same name as an AD group.
> 
> But now, if the group prepended with the local account domain doesn't
> result in a valid group entry, try again with the naked group name, to
> allow aliases or builtin accounts to pass as primary group.
> 
> Fixes: cc332c9e271b ("* uinfo.cc [...] (pwdgrp::fetch_account_from_windows): Drop outdated comment.  Fix code fetching primary group gid of group setting in SAM description field.")
> Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
> ---
>  winsup/cygwin/uinfo.cc | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
> index fb4618b8a19e..1eb52f14578c 100644
> --- a/winsup/cygwin/uinfo.cc
> +++ b/winsup/cygwin/uinfo.cc
> @@ -2563,7 +2563,11 @@ pwdgrp::fetch_account_from_windows (fetch_user_arg_t &arg, cyg_ldap *pldap)
>  	      if (pgrp)
>  		{
>  		  /* Set primary group from the "Description" field.  Prepend
> -		     account domain if this is a domain member machine. */
> +		     account domain if this is a domain member machine.  Do
> +		     this first, to find a local group even if a domain
> +		     group with this name exists.  Only if that doesn't
> +		     result in a valid group, try the group name without prefix
> +		     to catch builtin and alias groups. */
>  		  char gname[2 * DNLEN + strlen (pgrp) + 1], *gp = gname;
>  		  struct group *gr;
>  
> @@ -2575,7 +2579,9 @@ pwdgrp::fetch_account_from_windows (fetch_user_arg_t &arg, cyg_ldap *pldap)
>  		      *gp++ = NSS_SEPARATOR_CHAR;
>  		    }
>  		  stpcpy (gp, pgrp);
> -		  if ((gr = internal_getgrnam (gname, cldap)))
> +		  if ((gr = internal_getgrnam (gname, cldap)) ||
> +		      (cygheap->dom.member_machine ()
> +		       && (gr = internal_getgrnam (pgrp, cldap))))
>  		    gid = gr->gr_gid;
>  		}
>  	      char *e;
> -- 
> 2.52.0
> 

LGTM.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
