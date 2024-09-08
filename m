Return-Path: <SRS0=f7tR=QG=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e06.mail.nifty.com (mta-snd-e06.mail.nifty.com [106.153.226.38])
	by sourceware.org (Postfix) with ESMTPS id 49E00385840C
	for <cygwin-patches@cygwin.com>; Sun,  8 Sep 2024 06:03:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 49E00385840C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 49E00385840C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.38
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1725775407; cv=none;
	b=Rawae3u2cQf/lQOAQ8+85GOOhWU7/Q2wIZ7Pb8kGsIXrg1GlCVic6wnBLiM9MVFq0AbDAHDvvha+XWzodLJYCZnBBdY8E+9vgI4bAPIrBT/Stg/Xr7/TOilzDE3GaxK5TvzgGHLRNf0bUDzduB4htH6M1Xc/moUj99bv2/5v7XA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1725775407; c=relaxed/simple;
	bh=VIk4S8ZDjnHMYNA+NYUHY1UnZwynETDqEBXZpOp00Rw=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=Aecvsw3lYeRUbmUnKvMsVkGmlJ1rTgToFoyKNZvCJtta+idCC6l6SiPJ5PDmaI1yf1GewnAu2TX0fUMaFg3fmsbhSvUDzJj4jtQ0DDf/2/XJb/DHuPWAk4rHFYRVRplAGV8TfSo6PgP6maRddrp/mFikabshvqBe6hgCn9IFdMs=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-e06.mail.nifty.com with ESMTP
          id <20240908060322042.MAZW.102422.HP-Z230@nifty.com>;
          Sun, 8 Sep 2024 15:03:22 +0900
Date: Sun, 8 Sep 2024 15:03:21 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Ken Brown <kbrown@cornell.edu>
Subject: Re: [PATCH] Cygwin: pipe: Restore blocking mode of read pipe on
 close()
Message-Id: <20240908150321.841c6b0e9375e9244b91b6ec@nifty.ne.jp>
In-Reply-To: <20240907020055.268f6da380c37c4c03cdacab@nifty.ne.jp>
References: <20240830141553.12128-1-takashi.yano@nifty.ne.jp>
	<ZtWdJ7FtgZcAaA74@calimero.vinschen.de>
	<a2800cf1-6a69-75ee-5494-a14b1a10a1f1@gmx.de>
	<20240902225045.21e496d3af5b70b0a8c47c7d@nifty.ne.jp>
	<20240902233313.171fb48cc8243cd095d7280f@nifty.ne.jp>
	<20240905221841.002f3f6fa53baa468b0cd136@nifty.ne.jp>
	<ZtnQY6Cxf_6Bbo6Q@calimero.vinschen.de>
	<20240906180127.15335289a2810d2334e52212@nifty.ne.jp>
	<20240907020055.268f6da380c37c4c03cdacab@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1725775402;
 bh=60heI4PlOkJWZ+y/jzwzCOE3fRivzO7eRmHJrOjWgzM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=JeIPfHe0emVxOV50n51AScgR+NbasvdNOpNojJltMmO7fE2ERmLCe0i/lfi9kQNPBjwe+wt7
 nh3/EQa8iMsuBCITL7Y67yGYlYcARzDLJzADs0j3uHJz6eW228upNpGHyDTXBec4nBPKRAV8Ak
 zCQAZe0hQrPMH+j6NXk0iub5Eu057ry2aTu1gISoIP5BIxdJGkTl38MBZL57HrHis4Gc56yK4/
 mg2NPP6LtO1JkjjxY6BQH8EXrascMiXzGebRDrY/ghtC1QlRZGlv0CDFf2xTfUeeG3zPzeRJpH
 qbRwB96ObFkZlglcQDRTVS92WAN+kfr9MySz7gWkE3HfZW8Q==
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Ken,

On Sat, 7 Sep 2024 02:00:55 +0900
Takashi Yano wrote:
> On Fri, 6 Sep 2024 18:01:27 +0900
> Takashi Yano wrote:
> > On Thu, 5 Sep 2024 17:38:11 +0200
> > Corinna Vinschen wrote:
> > > I think you should push your original patch to the 3.5 branch for now,
> > > and we test the big change in the main branch first.
> > 
> > Sounds reasonable. I'll submit a v2 patch for 3.5 branch:
> > [PATCH v2] Cygwin: pipe: Restore blocking mode of read pipe on close()
> > and v2 patch for 3.6 branch:
> > [PATCH v2] Cygwin: pipe: Switch pipe mode to blocking mode by defaut
> 
> [PATCH v3] Cygwin: pipe: Switch pipe mode to blocking mode by defaut
> - Use NtQueryInformationFile(FilePipeLocalInformation) instead of
>   PeekNamedPipe(). This make raw_read() faster a bit.

I would appreciate if you could review:
[PATCH v2] Cygwin: pipe: Restore blocking mode of read pipe on close()
(for cygwin-3_5-branch)

And any suggestions for
[PATCH v4.2] Cygwin: pipe: Switch pipe mode to blocking mode by defaut
(for master branch)
?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
