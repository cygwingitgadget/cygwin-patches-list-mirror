Return-Path: <SRS0=8gjk=QE=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w06.mail.nifty.com (mta-snd-w06.mail.nifty.com [106.153.227.38])
	by sourceware.org (Postfix) with ESMTPS id EFF82385C6E1
	for <cygwin-patches@cygwin.com>; Fri,  6 Sep 2024 17:00:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EFF82385C6E1
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EFF82385C6E1
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.38
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1725642059; cv=none;
	b=Gog74w9xCMxT0khjpcLITgBQHnml81FuguP0NnMA0lQ4IOPd+LwwU8ZVlunm6kHWPowoSen7v/1uEA4GbS3RFDRy+rtA8kWwlPDrAaOrxqkXQBaXHu5lcQEMGk0TeHQh2ziqTOkRT9MvP0+IVTV4OLvtVA1YS4yXysGqEcBt9s8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1725642059; c=relaxed/simple;
	bh=yBW2KA1P0iZ+7h26YB6c1sUZRHn0ozfW/xymR/azOss=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=lmVL/eqFmQTbUlD6j8gF689XQVA9m9VMSY2SQQ6MD94tzrVuVPZJKdc0DvFIaCzjKPLRVydZIt+HyD3ctRMxgfnKgK6T2ZyD+LV2ZiwUgmckEUqL+K4Cmyz30SPmFq0GLVTge0aYC4D/8xc5e1GChUhx1a72baoKstCy/u0FUDY=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-w06.mail.nifty.com with ESMTP
          id <20240906170055945.TQIK.90861.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sat, 7 Sep 2024 02:00:55 +0900
Date: Sat, 7 Sep 2024 02:00:55 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Restore blocking mode of read pipe on
 close()
Message-Id: <20240907020055.268f6da380c37c4c03cdacab@nifty.ne.jp>
In-Reply-To: <20240906180127.15335289a2810d2334e52212@nifty.ne.jp>
References: <20240830141553.12128-1-takashi.yano@nifty.ne.jp>
	<ZtWdJ7FtgZcAaA74@calimero.vinschen.de>
	<a2800cf1-6a69-75ee-5494-a14b1a10a1f1@gmx.de>
	<20240902225045.21e496d3af5b70b0a8c47c7d@nifty.ne.jp>
	<20240902233313.171fb48cc8243cd095d7280f@nifty.ne.jp>
	<20240905221841.002f3f6fa53baa468b0cd136@nifty.ne.jp>
	<ZtnQY6Cxf_6Bbo6Q@calimero.vinschen.de>
	<20240906180127.15335289a2810d2334e52212@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1725642056;
 bh=NK3z1ifG3eNUm9aQ4CEZLKn1j5wMpBM1G3CTaHFUqjs=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=ZyUreoynLD4citBEvp6cdWCoBDFHzAYvlaqjkvBQxC9pnx0sk23UFI5nzMMVzLeIOr1+0DFG
 o7wXq57if3gN1Bz52Pn0KH5cKQm9wS5S8H+EWNwPbKjENJ1iSqAC67TSKAOzx6ae670P/JmOh+
 nP4pGVyyIwDHKDBuxv8qEzlFumluKlOl/rYlQg4wi5vyT6VXAvjGecvwnXywIy4BJrpht++IpD
 kHtdchAmaG3miltsr/Yp1VPMHWhMC4HGDU4GtqRaZPSmQd3j3AS/vPWikc2Uq03xazuoGDbgQ0
 u6ANAOkkJs3xe2CFqWc5wdrLxL41aGzpORo6tPpqvHU/0SGQ==
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, 6 Sep 2024 18:01:27 +0900
Takashi Yano wrote:
> On Thu, 5 Sep 2024 17:38:11 +0200
> Corinna Vinschen wrote:
> > I think you should push your original patch to the 3.5 branch for now,
> > and we test the big change in the main branch first.
> 
> Sounds reasonable. I'll submit a v2 patch for 3.5 branch:
> [PATCH v2] Cygwin: pipe: Restore blocking mode of read pipe on close()
> and v2 patch for 3.6 branch:
> [PATCH v2] Cygwin: pipe: Switch pipe mode to blocking mode by defaut

[PATCH v3] Cygwin: pipe: Switch pipe mode to blocking mode by defaut
- Use NtQueryInformationFile(FilePipeLocalInformation) instead of
  PeekNamedPipe(). This make raw_read() faster a bit.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
