Return-Path: <SRS0=g3Q1=WL=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:29])
	by sourceware.org (Postfix) with ESMTPS id 5B42B3856259
	for <cygwin-patches@cygwin.com>; Mon, 24 Mar 2025 12:33:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5B42B3856259
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5B42B3856259
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:29
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1742819594; cv=none;
	b=DS6KiYflux375qWb7ReHVq2S632PV0lDlPeLG/mT7hg0pXJDPkiN4NyS8I4Dz3Rr5H/16Sbj18YFJq9XZJClFbRvRFyv/LSLXro+9wCRVGAg1UhgUXxVXRB1BxxQMN61rTDk+KUDuP23tYxNNLnwm/SitB7dmRP72ELqGXPZ5os=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1742819594; c=relaxed/simple;
	bh=vn0m9IjaRHuKKvHbz6CJ7Ji1nM+xT/IMGwTD39YeS3s=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=bcGPQ7dmVRTKV/scnDCOaihPjy8HtiTEvtd+t0spugvDYkoP70CgluZnli0fLdOLxhwRwjAFw+BKC2lSvrIIzMX1EaAZjcMTl4+nnrVWcd8/j9rgR8MJVrgZzfmydifQLDhJYqEwCcloypaMDVCJDCAtFcy2U9mcr1o81VUDrbA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5B42B3856259
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=f0zs6yqx
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20250324123311111.CAGN.84842.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 24 Mar 2025 21:33:11 +0900
Date: Mon, 24 Mar 2025 21:33:10 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: signal: Clear direction flag in sigdeleyed
Message-Id: <20250324213310.5a155f7e869b7900ec1f4eb0@nifty.ne.jp>
In-Reply-To: <fd7be3fb-0f32-3653-def9-79402bba41c5@t-online.de>
References: <20250324012833.518-1-takashi.yano@nifty.ne.jp>
	<fd7be3fb-0f32-3653-def9-79402bba41c5@t-online.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1742819591;
 bh=xAyoQVDb9OF2mwhVoQqPhs5ZH7nDWeDbDnrihAyFSuo=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=f0zs6yqxr/WtVsvHReYqYUTzhKx9K6Vt2X7seh7vv6/h3DYdEBp2vsIaHZNvn426ARtepogk
 6QgIVQ/DkipGISCWZVCFqPED8tD0JbW7+/2rp44N0vbkpp6TPtwneEiTrCo2L0gf8jWY6gxisf
 ST/fH/N4m46J9GG2VML9f09iYCxqbgf+mn9YDA9QKNl6WmVldVykP8/cbx7QZ6YGYzyjrY/B8l
 GQtwKZ+5gPckM2u6QqsoGuX3SZ5Yo948NBbSELp7cOZUhYbrAxP2+lIEGdqwn7GaNyKcsz86JE
 HR14AnwI67mSSD8RfFiisX/MbIIcv0FXZS5cfy1cHoORG13A==
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,BODY_8BITS,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 24 Mar 2025 11:59:58 +0100
Christian Franke wrote:
> Takashi Yano wrote:
> > x86_64 ABI requires the direction flag in CPU flags register cleared.
> > https://learn.microsoft.com/en-us/cpp/build/x64-software-conventions
> > However, currently that flag is not maintained in signal handler.
> > Therefore, if the signal handler is called when that flag is set, it
> > destroys the data and may crash if rep instruction is used in the
> > signal handler. With this patch, the direction flag is cleared in
> > sigdelayed() by adding cld instruction.
> >
> > Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257704.html
> > Fixes: 1fd5e000ace5 ("import winsup-2000-02-17 snapshot")
> > Reported-by: Christian Franke <Christian.Franke@t-online.de>
> > Reviewed-by:
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > ---
> >   winsup/cygwin/scripts/gendef | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/winsup/cygwin/scripts/gendef b/winsup/cygwin/scripts/gendef
> > index a2f0392bc..861a2405b 100755
> > --- a/winsup/cygwin/scripts/gendef
> > +++ b/winsup/cygwin/scripts/gendef
> > @@ -179,6 +179,7 @@ sigdelayed:
> >   	movq	%rsp,%rbp
> >   	pushf
> >   	.seh_pushreg %rax			# fake, there's no .seh_pushreg for the flags
> > +	cld					# x86_64 ABI requires direction flag cleared
> >   	# stack is aligned or unaligned on entry!
> >   	# make sure it is aligned from here on
> >   	# We could be called from an interrupted thread which doesn't know
> 
> Works as expected:
> - the testcase no longer aborts.
> 
> - a version with modified main loop does not detect DF modification by 
> the signal:
> 
>    while ((cnt = sigcnt) < 1000) {
>      if (!(__builtin_ia32_readeflags_u64() & 0x0400) != !std)
>        return 13;
>      if ((cnt & 1) && !std) {
>        asm volatile ("std");
>        std = 1;
>      }
>      else if (!(cnt & 1) && std) {
>        asm volatile ("cld");
>        std = 0;
>      }
>    }
> 
> - The related stress-ng testcases no longer report segfaults:
> 
> $ n=0
> $ while
>    stress-ng --parallel 2 --with memcpy,tree --memcpy-method libc 
> --tree-method btree -t 2;
> do echo OK $((++n)); done
> ...
> OK 500
> ...

Thanks for testing!

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
