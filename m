Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
	by sourceware.org (Postfix) with ESMTPS id 5FD593858C62
	for <cygwin-patches@cygwin.com>; Sat, 22 Oct 2022 06:13:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 5FD593858C62
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from HP-Z230 (aj136180.dynamic.ppp.asahi-net.or.jp [220.150.136.180]) (authenticated)
	by conssluserg-03.nifty.com with ESMTP id 29M6CkAv030055;
	Sat, 22 Oct 2022 15:12:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 29M6CkAv030055
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1666419166;
	bh=ZwM8jdwEIuJjf79VoPTv0/pW9t86cH/VbC4Ks4L1Iyg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RASNkKKwd3DIo5gpnOGZd/WMxb0RY1oQ8H0ECy+EJ37WYaJRvHNLPrXlsxDWEwc+i
	 +wWJG1UKIyXy0pVrMAPpKupXQ12Zb7fjdI4LFqTs+JYQmihA4Rz9po76u6X+y2rQGO
	 sTWqQiCTb7CYNsPevE67pTtiwd7CkV5dtx2NskZFQyEr+QlsaAvcwx145tXRB8ybW7
	 +dG62HM6cN8QfC68AHr0Lu6C/Div6WruW3QN91aYFYfLOH2MSLCpucFXmOhGfWGZKZ
	 olxcJsxdAOYL/7HtNk1/7egGLR4tn4RA+7dAcS9iB2F3DEjkrKDpIAmeMoETbuBSYR
	 RMxEokHYcqCRQ==
X-Nifty-SrcIP: [220.150.136.180]
Date: Sat, 22 Oct 2022 15:12:47 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] Cygwin: pty: Fix 'Bad address' error when running
 'cmd.exe /c dir'
Message-Id: <20221022151247.1b1cf1e3fc13d4c3dabc2191@nifty.ne.jp>
In-Reply-To: <6EED0655-71E5-43B4-988D-B5935AED8EC0@gmx.de>
References: <20221022053420.1842-1-takashi.yano@nifty.ne.jp>
	<6EED0655-71E5-43B4-988D-B5935AED8EC0@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, 22 Oct 2022 07:58:37 +0200
Johannes Schindelin wrote:
> On October 22, 2022 7:34:20 AM GMT+02:00, Takashi Yano <takashi.yano@nifty.ne.jp> wrote:
> >- If the command executed is 'cmd.exe /c [...]', runpath in spawn.cc
> >  will be NULL. In this case, is_console_app(runpath) check causes
> >  access violation. This case also the command executed is obviously
> >  console app., therefore, treat it as console app to fix this issue.
> >
> >  Addresses: https://github.com/msys2/msys2-runtime/issues/108
> >---
> > winsup/cygwin/spawn.cc | 2 ++
> > 1 file changed, 2 insertions(+)
> >
> >diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
> >index 5aa52ab1e..4fc842a2b 100644
> >--- a/winsup/cygwin/spawn.cc
> >+++ b/winsup/cygwin/spawn.cc
> >@@ -215,6 +215,8 @@ handle (int fd, bool writing)
> > static bool
> > is_console_app (WCHAR *filename)
> > {
> >+  if (filename == NULL)
> >+    return true; /* The command executed is command.com or cmd.exe. */
> >   HANDLE h;
> >   const int id_offset = 92;
> >   h = CreateFileW (filename, GENERIC_READ, FILE_SHARE_READ,
> 
> The commit message of the original patch was substantially clearer and offered a thorough analysis. This patch lost that.

The reason which I did not apply your patch as-is is:
is_console_app() returns false for 'cmd.exe /c [...]' case
with your patch, while it should return true. 

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
