Return-Path: <SRS0=TcHI=ND=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w08.mail.nifty.com (mta-snd-w08.mail.nifty.com [106.153.227.40])
	by sourceware.org (Postfix) with ESMTPS id C9CFA3865C2B
	for <cygwin-patches@cygwin.com>; Sat,  1 Jun 2024 22:03:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C9CFA3865C2B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C9CFA3865C2B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.40
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1717279430; cv=none;
	b=ceTXOpYlkDiy/h78UuOANJHu1IwBlrzyL6a6bjyoFCbnAi7Wht0mD7sbR3qtLmKbpjHdR1AIvqb1qaKi4lWw9zxpDuoof29YOUG5K/hLcqj6QWsTGzcBpGw17cqhL7dip7oW1eoVxIL9XjTxY0j8Anz6YOlr1noRxm56D8R2ESY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1717279430; c=relaxed/simple;
	bh=RTosrjI+CR5bD0Oh3qgQtjLlYgc4rMdGDnyFfHk7dNg=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=fwjibYn2Z2RDmPcrbUeVmKV5Df2rIhAa1c7hYg0VDiHudPC6bMyPrw72F+hjo3pG18vkBjbjHpM7cbor6NV61ZyiY/OL6KMAcG9XhclLz+g2btbaq64vxjigTQtbTTDLeaMo/7UGxXraQfvvGQSSaHfiVZZGYE2nu0TeEZvCgYc=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-w08.mail.nifty.com with ESMTP
          id <20240601220343187.TEAV.4660.HP-Z230@nifty.com>;
          Sun, 2 Jun 2024 07:03:43 +0900
Date: Sun, 2 Jun 2024 07:03:42 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com, Ken Brown <kbrown@cornell.edu>
Cc: Jeremy Drake <cygwin@jdrake.com>
Subject: Re: [PATCH v1] Cygwin: disable high-entropy VA for ldh
Message-Id: <20240602070342.b53b20f7361d58e338dc3618@nifty.ne.jp>
In-Reply-To: <651f7e9a-8f59-7874-75ff-be82153e9dd8@jdrake.com>
References: <651f7e9a-8f59-7874-75ff-be82153e9dd8@jdrake.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1717279423;
 bh=TNMTAN4nzibLijjDWQJnsu/jn4wYNAk9J1UDQnlXMjE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=F3AlqmQvCZ3pX4LPOzwpo8UHPtJZkVPrVLpFdVbdriLcs814PTmzM361QALqwJW23zqMjcK/
 OnAu/kEySn41bVmGNt5F+YXLWfVq4hnkToJT9v51QweymKCc/7QTWDz7bzCi3IKEPAeuzRSzmi
 1P/eBEU9XUhrEvHWJv6Yu0RaNCBtePNtCmbBYr/pN/UeAdyysHB2a/vvQ3LkohEEu7UnVl+OeB
 vUAX80A/9joOTFC/VWym009xZ1UeWu4jyGP5aiUU4sMNhMcIrh5yoeQpI/w00Ahwp4waLxOW//
 3jPWxX22640mh+fmdPwiObIMj/FPb5mUqs9WuzxPQ3lKixIA==
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Ken,

On Tue, 28 May 2024 10:19:22 -0700 (PDT)
Jeremy Drake wrote:
> If ldd is run against a DLL which links to the Cygwin DLL, ldh will end
> up loading the Cygwin DLL dynamically, much like cygcheck or strace.
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2024-May/255991.html
> Fixes: 60675f1a7eb2 ("Cygwin: decouple shared mem regions from Cygwin DLL")
> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> ---
>  winsup/utils/mingw/Makefile.am | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/winsup/utils/mingw/Makefile.am b/winsup/utils/mingw/Makefile.am
> index b89d89490a..07b9f928d4 100644
> --- a/winsup/utils/mingw/Makefile.am
> +++ b/winsup/utils/mingw/Makefile.am
> @@ -53,6 +53,7 @@ cygcheck_LDADD = -lz -lwininet -lshlwapi -lpsapi -lntdll
>  cygwin_console_helper_SOURCES = cygwin-console-helper.cc
> 
>  ldh_SOURCES = ldh.cc
> +ldh_LDFLAGS = ${AM_LDFLAGS} -Wl,--disable-high-entropy-va
> 
>  strace_SOURCES = \
>  	path.cc \
> -- 
> 2.45.1.windows.1

If this looks good to you too, shall I commit this patch?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
