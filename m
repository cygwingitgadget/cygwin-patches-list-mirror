Return-Path: <SRS0=VX82=NE=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id 595FA3849ACB
	for <cygwin-patches@cygwin.com>; Sun,  2 Jun 2024 20:35:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 595FA3849ACB
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 595FA3849ACB
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1717360549; cv=none;
	b=LbxaRYrq2BM547sSWOk8C8ZsZAB0wqqPTsFIADJLcVhvJ2Pm0n8zm1bI/MQYrhpGR5ez1ja+d2A+EQkGxFon3hqk1qETVJ82YQrvVwAfiMCbJeJIdKH3wYqlpJ8BCCc9rWx31oGDkgMZ+SbJ1cxxduPIdNvQ+0ZQ20JrhrOnjCA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1717360549; c=relaxed/simple;
	bh=LbYagrMKbRbVvRA6n4XvrbwFTFdy82ZFxal6NcewU1U=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=N3Oe8PA2MQmctp5ndXXUSpdrWgW24JfRLLhvNRhRl0Xjcm6AFe39Nvc3Nij2a7u8edkaJbPv3FRRCP5KbKWlTLCYsmrF0Lyl/wtmNQDYg2yiW3KmHVmFS20WG3VSljKTyNNSmuTtOAEyY4vu3OFKF8rJ3W1v8mSf6Br/gNR9UCo=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20240602203544122.VKQO.93209.HP-Z230@nifty.com>;
          Mon, 3 Jun 2024 05:35:44 +0900
Date: Mon, 3 Jun 2024 05:35:42 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Jeremy Drake <cygwin@jdrake.com>
Subject: Re: [PATCH v1] Cygwin: disable high-entropy VA for ldh
Message-Id: <20240603053542.b4400d00e6751764379c952f@nifty.ne.jp>
In-Reply-To: <faafd9af-1d68-4153-b906-9b0fd5582c12@cornell.edu>
References: <651f7e9a-8f59-7874-75ff-be82153e9dd8@jdrake.com>
	<20240602070342.b53b20f7361d58e338dc3618@nifty.ne.jp>
	<faafd9af-1d68-4153-b906-9b0fd5582c12@cornell.edu>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1717360544;
 bh=X7hixMaycDJuVcsBKQh92bu5Zzjzi6ivngfXPSp3CjU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=LISHro2aJzkUMlWsDdgJ6bSxwQJ4rGVkfh4bGzhT78uJdgPnqG/YEOyr4aX+wECnU+RqpjEF
 P1tQ9o58GcQ2QUYPvLGSoE2ge2xaOIOfZJ7ZjKPzJU1B5+GcYNTvoK0kVzwlgbTeKm0u2Giz0S
 i10hLmguThi/yExXvQl58wmgirlCX8ElEvQ5VD2bEvP9kk/Rvf95qh5AFTrT2XjJBsubMbs8DE
 wrNVaWCpFTd3PgCjGs0Xm6dn+EhFl9g6ULi/iY2nHtbx2rPZZEqNd84HB26xnpxd7az+WK3raS
 Av7xmf8lOpWjNk+Xqvyd4phUM0Xhfe2mRtjhrMj6vn+QYdLQ==
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sun, 2 Jun 2024 15:22:41 -0400
Ken Brown <kbrown@cornell.edu> wrote:

> Hi Takashi,
> 
> On 6/1/2024 6:03 PM, Takashi Yano wrote:
> > Hi Ken,
> > 
> > On Tue, 28 May 2024 10:19:22 -0700 (PDT)
> > Jeremy Drake wrote:
> >> If ldd is run against a DLL which links to the Cygwin DLL, ldh will end
> >> up loading the Cygwin DLL dynamically, much like cygcheck or strace.
> >>
> >> Addresses: https://cygwin.com/pipermail/cygwin/2024-May/255991.html
> >> Fixes: 60675f1a7eb2 ("Cygwin: decouple shared mem regions from Cygwin DLL")
> >> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> >> ---
> >>   winsup/utils/mingw/Makefile.am | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/winsup/utils/mingw/Makefile.am b/winsup/utils/mingw/Makefile.am
> >> index b89d89490a..07b9f928d4 100644
> >> --- a/winsup/utils/mingw/Makefile.am
> >> +++ b/winsup/utils/mingw/Makefile.am
> >> @@ -53,6 +53,7 @@ cygcheck_LDADD = -lz -lwininet -lshlwapi -lpsapi -lntdll
> >>   cygwin_console_helper_SOURCES = cygwin-console-helper.cc
> >>
> >>   ldh_SOURCES = ldh.cc
> >> +ldh_LDFLAGS = ${AM_LDFLAGS} -Wl,--disable-high-entropy-va
> >>
> >>   strace_SOURCES = \
> >>   	path.cc \
> >> -- 
> >> 2.45.1.windows.1
> > 
> > If this looks good to you too, shall I commit this patch?
> 
> You and Jeremy know much more about this than I do, but I've read 
> through the thread leading to this patch, and it does look good to me. 
> So I think you should go ahead (after adding a release note).

Thanks! Pushed.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
