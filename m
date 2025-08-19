Return-Path: <SRS0=6ck4=27=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e06.mail.nifty.com (mta-snd-e06.mail.nifty.com [106.153.226.38])
	by sourceware.org (Postfix) with ESMTPS id C17383858C83
	for <cygwin-patches@cygwin.com>; Tue, 19 Aug 2025 12:50:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C17383858C83
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C17383858C83
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.38
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1755607833; cv=none;
	b=UgS1EMNheGfymDhC49Vu9AXizAvsAw6QPrDMqtO1isJ60PsUTPYljpq4gYmMokOB7jWbR1QfBLLdinNdzKYziYFoMwQZNQpu5i1AAdfFVioHF2r4fJDQQxOfAzX7nt6cbOuOloy+8/pDO47aXwIQ1d+QahrsLgjcWgJx8Xc+bz4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1755607833; c=relaxed/simple;
	bh=ZY+SvBy2WPKsEovLfAUlgJa79wOIfGtlWgFGFw+jPok=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=jkkA/bNf5UN8gl9P0vxGS8arYb/IL6vFkaX54cB682zoR7xHzjBXRs94p5ynVkC5HBvZjRyOrQFdFieSiSYpRf3ehc7USaycz20CshHPH7dZlhc2cPD1MuYYkw8GW763SRgkDCXs6UZ/KOe/I1OUKRW0hlrxZuVj41lXch93LC8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C17383858C83
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=GgR2riy3
Received: from HP-Z230 by mta-snd-e06.mail.nifty.com with ESMTP
          id <20250819125030499.HWOA.111119.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 19 Aug 2025 21:50:30 +0900
Date: Tue, 19 Aug 2025 21:50:30 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: fix finding overlaps from F_SETLKW.
Message-Id: <20250819215030.5a37ba3eb712022b04abbe0d@nifty.ne.jp>
In-Reply-To: <a8581a49-fe01-37a8-edb7-95ccccf66549@jdrake.com>
References: <a8581a49-fe01-37a8-edb7-95ccccf66549@jdrake.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1755607830;
 bh=5SJLWGLn+ELoJE/ORnP9j/ECUjkogQ/D9kktm1Uwln0=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=GgR2riy3vVnUWJRpJFnmUajQzuGZ3A4RtKJzyfC5KYoT3RnhxapVucDzw1Tt8h3svtUGZG7x
 WNLJk/6k7MEgNMg2x+6bp8HuOjUiNFFyaNH5ZXrRbOBWNV1mkN5/UYOEIlFIJREP/+qFe0doas
 7UTn5RRExL7hgL3vw/3MGlcobUZPOXJDOCwYus0tsV+PqhvBUF8f34mz6tHjgBbAOW1jbgpphF
 fggei5sEdlq4e+DB57tZf8FmRKlJ1VgzgaEyhOwDi+lyyZSU/hpewksl2SjoOPi4jGayIqgrbV
 tWdmvh2fVc3yRRtxyzv4lpl297VOP8qozqRLnSOarSZsOFsg==
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 18 Aug 2025 16:30:48 -0700 (PDT)
Jeremy Drake wrote:
> The commit adding OFD locks changed from comparing just the F_POSIX and
> F_LOCK flags to comparing the entire flags value in order to make sure
> the locks are of the same type.  However, the F_WAIT flag may or may not
> be set, and result in that comparison not matching.  Mask the F_WAIT
> flag when attempting to compare the types of the locks.
> 
> This fixes the "many_locks" stc.
> 
> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> Fixes: a66ed519884d ("Cygwin: fcntl: implement Open File Description (OFD) locks")
> ---
>  winsup/cygwin/flock.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/flock.cc b/winsup/cygwin/flock.cc
> index e9f49a8900..e03caba27a 100644
> --- a/winsup/cygwin/flock.cc
> +++ b/winsup/cygwin/flock.cc
> @@ -1722,7 +1722,7 @@ lf_findoverlap (lockf_t *lf, lockf_t *lock, int type, lockf_t ***prev,
>        /* We're "self" only if the semantics and the id matches.  OFD and POSIX
>           locks potentially block each other.  This is true even for OFD and
>  	 POSIX locks created by the same process. */
> -      bool self = (lf->lf_flags == lock->lf_flags)
> +      bool self = ((lf->lf_flags & ~F_WAIT) == (lock->lf_flags & ~F_WAIT))
>  		  && (lf->lf_id == lock->lf_id);
> 
>        if (bsd_flock || ((type & SELF) && !self) || ((type & OTHERS) && self))

The patch itself LGTM, however, I wonder why it is not necessary to compare
also 'lf_type' here. Or is it enough to compare only 'lf_id' by any chance?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
