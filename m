Return-Path: <SRS0=yxTJ=63=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e06.mail.nifty.com (mta-snd-e06.mail.nifty.com [106.153.226.38])
	by sourceware.org (Postfix) with ESMTPS id 53AC94BA2E04
	for <cygwin-patches@cygwin.com>; Sun, 21 Dec 2025 10:12:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 53AC94BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 53AC94BA2E04
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.38
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766311937; cv=none;
	b=qmut/IsHLS2UdGuoeip5adfr8cB6PCWulpDVk40yk5uVRA3F4ju/RWpDuKKHsFphgu2sk3JK+Md6Lhqb36lThuXR16LccPLjkzo1tHvIVKImGydYO8riozexzGlGZFGFVymF0NWkUgQfFze9eQSBHzUPwxx1FwXr0uPQ8WMJ54Y=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766311937; c=relaxed/simple;
	bh=p3mESJ3szCPvve7wlYp68gfAuFoFxUxfrK7oPLh16Uk=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=gKrHxKH9gxcWUCqy3Y3uW8gFLugzjC+vWRxGWdTcGJqDosV4LykhmQ545/Z6xzTUJszCZSY9lKMkFPF+GB3TxMf9nABQZlQBNAhOqtBItJ3fZqzwrmi1e6Ldd0ds1vKyxCaIxloRmoOIN7OK1NNkE867EFY0v9E+RTTfyQ9imOc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 53AC94BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=NPzwIehI
Received: from HP-Z230 by mta-snd-e06.mail.nifty.com with ESMTP
          id <20251221101214204.XEES.111119.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 21 Dec 2025 19:12:14 +0900
Date: Sun, 21 Dec 2025 19:12:12 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/4] Cygwin: uinfo: correctly check and override
 primary group
Message-Id: <20251221191212.8a67b6b0e319e384f8bb21d4@nifty.ne.jp>
In-Reply-To: <20251218112308.1004395-2-corinna-cygwin@cygwin.com>
References: <20251218112308.1004395-1-corinna-cygwin@cygwin.com>
	<20251218112308.1004395-2-corinna-cygwin@cygwin.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1766311934;
 bh=pBtrcw/ul/7Kgytb55Ohd9XP56C9KyCpv7smtKzsPvU=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=NPzwIehIE77U7PHhqrZ47tbubhOqW/8XN0Qt1DogP8Yz/4W87ddJ5cp4w5+dhgjspc54CNmB
 nDnEhWevyp9E1Oo5OUu4CwlA3jw9+q3+zJ+XCfqujAnnc44pZKagN+3TcNJhR518JApqAJU0cf
 agMlhRt1azTcWpfGRYTM57nF7mMNrF1Tfdzx1TT2ZGrUY+yP3p85vO6GfpPbbRJ1Wimm0+vbho
 hs6b561IEIvSe5kIDAsDyGF+xHcFm0K079EYAr2DT6hUd0BqLu7sYL8m8Lts+BIZqlYrIsVOmX
 MVz/RSh3vvrpzk+TcBTU6HurUoGLfUuySx8zRSiBPjsy+UgQ==
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 18 Dec 2025 12:23:05 +0100
Corinna Vinschen wrote:
> From: Corinna Vinschen <corinna@vinschen.de>
> 
> Commit dc7b67316d01 ("Cygwin: uinfo: prefer token primary group")
> broke the code overriding the primary group in two different ways:
> 
> - It changed the way myself->gid was set before checking its value.
> 
>   Prior to dc7b67316d01, myself->gid was always set to the primary group
>   from the passwd entry (pw_gid).  With the patch, it was set to the
>   primary group from the Windows user token (token_gid) in the first
>   place.
> 
>   The following condition checking if pw_gid is different
>   from token_gid did so, by checking token_gid against myself->gid,
>   rather than against pw_gid.  After dc7b67316d01 this was always
>   false and the code block overriding the primary group in Cygwin and
>   the Windows user token with pw_gid was never called anymore.
> 
>   The solution is obvious: Do not check token_gid against myself->gid,
>   but against the desires primary GID value in pw_gid instead.
> 
> - The code block overriding the primary group simply assumed that
>   myself->gid was already set to pw_gid, but, as outlined above,
>   this was not true anymore after dc7b67316d01.
> 
>   This is a subtil error, because it leads to having the wrong primary
>   GID in `id' output, while the primary group SID in the user token was
>   correctly set.  But as soon as you run this under strace or GDB, the
>   problem disappears, because the second process tree under GDB or
>   strace takes over from the already changed user token.
> 
>   The solution is to override myself->gid with pw_gid once more, after
>   successfully changing the primary GID to pw_gid.
> 
> Fixes: dc7b67316d01 ("Cygwin: uinfo: prefer token primary group")
> Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
> ---
>  winsup/cygwin/uinfo.cc | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
> index ffe71ee0726c..8e9b9e07de9d 100644
> --- a/winsup/cygwin/uinfo.cc
> +++ b/winsup/cygwin/uinfo.cc
> @@ -174,7 +174,7 @@ internal_getlogin (cygheap_user &user)
>        gsid = cygheap->dom.account_sid ();
>        gsid.append (DOMAIN_GROUP_RID_USERS);
>        if (!pgrp
> -	  || (myself->gid != pgrp->gr_gid
> +	  || (pwd->pw_gid != pgrp->gr_gid
>  	      && cygheap->dom.account_sid () != cygheap->dom.primary_sid ()
>  	      && RtlEqualSid (gsid, user.groups.pgsid)))
>  	{
> @@ -209,7 +209,10 @@ internal_getlogin (cygheap_user &user)
>  			myself->gid = pwd->pw_gid = pgrp->gr_gid;
>  		    }
>  		  else
> -		    user.groups.pgsid = gsid;
> +		    {
> +		      user.groups.pgsid = gsid;
> +		      myself->gid = pwd->pw_gid;
> +		    }
>  		  clear_procimptoken ();
>  		}
>  	    }
> -- 
> 2.52.0
> 

LGTM. Please wait a bit for patches 2/4 and 3/4.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
