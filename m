Return-Path: <SRS0=nJKE=26=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w04.mail.nifty.com (mta-snd-w04.mail.nifty.com [106.153.227.36])
	by sourceware.org (Postfix) with ESMTPS id ACE673857B8F
	for <cygwin-patches@cygwin.com>; Mon, 18 Aug 2025 23:49:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org ACE673857B8F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org ACE673857B8F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.36
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1755560983; cv=none;
	b=YglJSeudPhrm/i533WL0ZUWzKUuKjQ28YnUITLmASGX/H1+Nfugp9ex8q0L+AdDq41uO7O+BOdSTxnY4Sq/7sX0xKpQODgbNIE+roHbYRTgqCLJs1zWafWUv9nsMWZ6xoOJlmm8AA4Bpjz7rUWFXf3Q8XzX7Ej6FDvGgc5i+GAw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1755560983; c=relaxed/simple;
	bh=+Udo+sOFVFpLu9l9wo8CLXTghidHZ9sPU7OspcAWep0=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=o1DhKLiA9bX+SSD0ZOtBU/MukvHwl8K4k1JqIpiVEcPSSKSOXk4Za2QeFGaoD0bD3KeEGoghpl3Ur4CB4uqZ6/OC9fhOQebOb19TaXajBNbXZ7hssVJydm2lEjFxjBd/PIZuL6XFFHFUKLkdXTDFpAb4cbR8hb/4/70tf4aSLeU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org ACE673857B8F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=E2M3+irx
Received: from HP-Z230 by mta-snd-w04.mail.nifty.com with ESMTP
          id <20250818234940520.JXIK.52630.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 19 Aug 2025 08:49:40 +0900
Date: Tue, 19 Aug 2025 08:49:39 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: fix fcntl F_GETLK
Message-Id: <20250819084939.be53446badda9800742ba1ab@nifty.ne.jp>
In-Reply-To: <cdba49be-7b3d-d270-9d3f-f1c04f3287a3@jdrake.com>
References: <cdba49be-7b3d-d270-9d3f-f1c04f3287a3@jdrake.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1755560980;
 bh=TVIZlC6ig1gQQqS2RyKNr8cSqhf+FNXngntYJqYqF0w=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=E2M3+irx1DMFa7isQgSAvN/crGm8GOwsCfGHjvXY2EBJKveGs76PXiOV6Mj9Ouq9w6rLAoPH
 iDL1IAB8o1H6qENhTdk8T5ABwm/zeo7g+J/ycHN6JknLcOJcjL0bUyGga8IWm8LLer9aDz0bCE
 pTeGmjaL9mnphkdcxPjUp/ilnmqVk6gaJu39eByHaocSrZs1mZVbIuP6xmKDmVwYkmSxugv/N6
 i4x/Q421U6OvqpuMIY2UzGT2dvuGdSEEaxD4Mm/d+Q29FugMERoQ/GoIcKhseqqj2WOOrfY/rh
 YA4CkeFuYnrE2Y5tG3WcaRDiq+1nsGe/zOV/H0wTYCf5G8Aw==
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 18 Aug 2025 13:25:33 -0700 (PDT)
Jeremy Drake wrote:
> The commit implementing OFD locks dropped the F_GETLK case from the
> switch in fhandler_base::lock, replacing it with F_OFD_GETLK.  This
> appears to have been an oversight, as F_OFD_SETLK was added as an
> additional case above.
> 
> This resulted in the winsup.api/ltp/fcntl05 test failing.
> 
> Fixes: a66ed519884d ("Cygwin: fcntl: implement Open File Description (OFD) locks")
> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> ---
> After this fix, the stc tests can run in CI and I'm also seeing many_locks
> test fail with EDEADLK.
> 
>  winsup/cygwin/flock.cc | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/winsup/cygwin/flock.cc b/winsup/cygwin/flock.cc
> index 85800e9714..e9f49a8900 100644
> --- a/winsup/cygwin/flock.cc
> +++ b/winsup/cygwin/flock.cc
> @@ -1162,6 +1162,7 @@ restart:	/* Entry point after a restartable signal came in. */
>        clean = lock;
>        break;
> 
> +    case F_GETLK:
>      case F_OFD_GETLK:
>        error = lf_getlock (lock, node, fl);
>        lock->lf_next = clean;

LGTM. Thanks!

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
