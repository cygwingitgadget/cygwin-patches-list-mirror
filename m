Return-Path: <SRS0=6xLJ=5S=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
	by sourceware.org (Postfix) with ESMTPS id 59CD63858D20
	for <cygwin-patches@cygwin.com>; Sat, 21 Jan 2023 15:23:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 59CD63858D20
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from HP-Z230 (aj135041.dynamic.ppp.asahi-net.or.jp [220.150.135.41]) (authenticated)
	by conssluserg-01.nifty.com with ESMTP id 30LFMb6R025595
	for <cygwin-patches@cygwin.com>; Sun, 22 Jan 2023 00:22:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 30LFMb6R025595
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1674314557;
	bh=xqC0W/YuRuoeHRyQAYoIZxQYIFWtmZnY3McpcOD5Az4=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=kMYrGULpGmzINhiT7ZBdlTD7+/y56xMz48xuvixv7iyct1gCN4Af/grLlJPHAn6GE
	 ZGih6ujKgawLiwNNatyY0/g7onY4QB3Pf1exjCTRZUq/vd5jDnTFxY6NCxT8aoqZnj
	 q+x6k1G2O2lWh8Goja54FAPF4D78Wwx521qEejAwpIpqZMOypHrx6YHvDHAAih+mYV
	 q6FKFN1bME7dyTwHpneIHo4HGqglV5fyMDja96vSsLDx7gzuBFK7GUO1GcxR9bwlA+
	 sgREfrvhB4TnCYCrpXCYGY/hXNnRNUbPO6ildNaHVvJbUsnjGBRj4FBfJqIinranFy
	 +saxioRuKsf4w==
X-Nifty-SrcIP: [220.150.135.41]
Date: Sun, 22 Jan 2023 00:22:37 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: fsync: Fix EINVAL for block device.
Message-Id: <20230122002237.1770130e6ab0b0fadd7189b2@nifty.ne.jp>
In-Reply-To: <Y8v8cdscNlnXbVxE@calimero.vinschen.de>
References: <20230121124403.1847-1-takashi.yano@nifty.ne.jp>
	<Y8v8cdscNlnXbVxE@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, 21 Jan 2023 15:53:37 +0100
Corinna Vinschen wrote:
> Hi Takashi,
> 
> On Jan 21 21:44, Takashi Yano wrote:
> > The commit af8a7c13b516 has a problem that fsync returns EINVAL for
> > block device. This patch treats block devices as a special case.
> > https://cygwin.com/pipermail/cygwin/2023-January/252916.html
> > 
> > Fixes: af8a7c13b516 ("Cygwin: fsync: Return EINVAL for special files.")
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > ---
> >  winsup/cygwin/fhandler/base.cc | 23 ++++++++++++++++++++++-
> >  1 file changed, 22 insertions(+), 1 deletion(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/base.cc b/winsup/cygwin/fhandler/base.cc
> > index b2738cf20..fc0410522 100644
> > --- a/winsup/cygwin/fhandler/base.cc
> > +++ b/winsup/cygwin/fhandler/base.cc
> > @@ -1725,10 +1725,31 @@ fhandler_base::utimens (const struct timespec *tvp)
> >    return -1;
> >  }
> >  
> > +static bool
> > +is_block_device (_major_t major)
> > +{
> > +  switch (major)
> > +    {
> > +    case DEV_FLOPPY_MAJOR:
> > +    case DEV_SD_MAJOR:
> > +    case DEV_CDROM_MAJOR:
> > +    case DEV_SD1_MAJOR:
> > +    case DEV_SD2_MAJOR:
> > +    case DEV_SD3_MAJOR:
> > +    case DEV_SD4_MAJOR:
> > +    case DEV_SD5_MAJOR:
> > +    case DEV_SD6_MAJOR:
> > +    case DEV_SD7_MAJOR:
> > +      return true;
> > +    }
> > +  return false;
> > +}
> > +
> 
> You shouldn't need that. Just check S_ISBLK (pc.dev.mode ())

Thanks for the advice. I looked into the S_ISBLK macro and
winsup/cygwin/devices.cc and noticed that S_ISBLK() returns
true for tape device. Is this the right thing?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
