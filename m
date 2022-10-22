Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
	by sourceware.org (Postfix) with ESMTPS id 4AE173858422
	for <cygwin-patches@cygwin.com>; Sat, 22 Oct 2022 01:37:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 4AE173858422
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from HP-Z230 (aj136180.dynamic.ppp.asahi-net.or.jp [220.150.136.180]) (authenticated)
	by conssluserg-04.nifty.com with ESMTP id 29M1act9009177;
	Sat, 22 Oct 2022 10:36:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 29M1act9009177
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1666402599;
	bh=lByk/UXNajFjG1I4+AbEW5vCaHZA8GqBrwPW+riIV0Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P+BJMLQbDY8+QjZsMktQM5u+FZcSLgjsMW7d7+wsJA6IkUHVBbf6R7+wiM2vnrW4l
	 4qlKUHKDW7Q833RZOoixIhHwC2KTF6Q9JSATiaVjc5xVoFGZDqc7RdUbTDHYLrToFb
	 r4LR/n7Ba0ch0uLFcg1DmYV8/3qDzCNBlMMzo+CHM2tjfxuKeb/6D/hpqjWgEfessP
	 HAG6m2cV8GUtsoo/TXtoJ69z0sIL6Xcbl5hFKIHfi61GNtvgAj6R+Vbg/1CIVG+M4Q
	 OHiIhKRim/0r1AnieGBtUYXMuYLv0baQnKRdmqI3iJ47S9GcQ0bMtGZovTpBlvagfM
	 vF0egWdlbxEog==
X-Nifty-SrcIP: [220.150.136.180]
Date: Sat, 22 Oct 2022 10:36:39 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] Fix `Bad address` when running `cmd /c [...]`
Message-Id: <20221022103639.0be6d01709fc99d06b3d0d41@nifty.ne.jp>
In-Reply-To: <8rqs6n82-0oq9-2200-944n-74s7o699385o@tzk.qr>
References: <8rqs6n82-0oq9-2200-944n-74s7o699385o@tzk.qr>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, 21 Oct 2022 23:37:35 +0200 (CEST)
Johannes Schindelin wrote:
> In 2b4f986e49 (Cygwin: pty: Treat *.bat and *.cmd as a non-cygwin
> console app., 2022-07-31), we introduced a bug fix that specifically
> looks for a suffix of the command's file name.
> 
> However, that file name might be set to `NULL`, namely when
> `null_app_name == true`, which is the case when we detected a
> command-line `cmd /c [...]`.

It seems that this is msys2 specific issue.
I also noticed that
cmd //c 'echo AAA' instead of cmd /c 'echo AAA' works in msys2.

In cygwin, filename is
C:\WINDOWS\system32\cmd.exe
for cmd /c 'echo AAA'.

Why the filename can be NULL in msys2 in the case of cmd /c 'echo AAA'?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
