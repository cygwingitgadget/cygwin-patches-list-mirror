Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
	by sourceware.org (Postfix) with ESMTPS id F05933858C62
	for <cygwin-patches@cygwin.com>; Sat, 22 Oct 2022 05:37:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org F05933858C62
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from HP-Z230 (aj136180.dynamic.ppp.asahi-net.or.jp [220.150.136.180]) (authenticated)
	by conssluserg-06.nifty.com with ESMTP id 29M5b85C009029;
	Sat, 22 Oct 2022 14:37:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 29M5b85C009029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1666417028;
	bh=QKfQ9pbrU447yexSI/KiJYInt65cTkIshKuGVnkLpvo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LVp8U/1MZGUuibcDb9XAxEBXj7jebQu9gR22F1zOcoXS3Eu8cffwcqub8aby44Fh8
	 YuxcS4RYZheMkrKYgrks64b+xOFjfCiLKR0XVx89fRt7bjeBXk2SxFKDVLtLf43Ujl
	 vSzzCr3lD1TAk54/p2TlFs1BUDtILJW83A/addUiiJrgGqLB+dq2UNQ2GrFBiFK/pg
	 veeJD5DCvWWy2oEQQgroe2MabzPouQcsPn/szmocYaQdpSl+IjTlO2WZNKpBaFZMN9
	 Hp0ZkHGvW+zK/1UdIebfM2Ka/tBmN+pIm5IqaswhmL3osEWjLTqs9jiqaKv8YeN6N4
	 oNakK35uLn9ZA==
X-Nifty-SrcIP: [220.150.136.180]
Date: Sat, 22 Oct 2022 14:37:09 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] Fix `Bad address` when running `cmd /c [...]`
Message-Id: <20221022143709.b54643c7b29b3d6260382e85@nifty.ne.jp>
In-Reply-To: <20221022105406.12f2c65e497e80df4014a8fb@nifty.ne.jp>
References: <8rqs6n82-0oq9-2200-944n-74s7o699385o@tzk.qr>
	<20221022103639.0be6d01709fc99d06b3d0d41@nifty.ne.jp>
	<20221022105406.12f2c65e497e80df4014a8fb@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, 22 Oct 2022 10:54:06 +0900
Takashi Yano wrote:
> On Sat, 22 Oct 2022 10:36:39 +0900
> Takashi Yano wrote:
> > On Fri, 21 Oct 2022 23:37:35 +0200 (CEST)
> > Johannes Schindelin wrote:
> > > In 2b4f986e49 (Cygwin: pty: Treat *.bat and *.cmd as a non-cygwin
> > > console app., 2022-07-31), we introduced a bug fix that specifically
> > > looks for a suffix of the command's file name.
> > > 
> > > However, that file name might be set to `NULL`, namely when
> > > `null_app_name == true`, which is the case when we detected a
> > > command-line `cmd /c [...]`.
> > 
> > It seems that this is msys2 specific issue.
> > I also noticed that
> > cmd //c 'echo AAA' instead of cmd /c 'echo AAA' works in msys2.
> > 
> > In cygwin, filename is
> > C:\WINDOWS\system32\cmd.exe
> > for cmd /c 'echo AAA'.
> > 
> > Why the filename can be NULL in msys2 in the case of cmd /c 'echo AAA'?
> 
> I can reproduce the issue in cygwin with cmd.exe /c 'echo AAA'
> instead of cmd /c 'echo AAA'.

I have just pushed a counter patch. Thanks for the report.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
