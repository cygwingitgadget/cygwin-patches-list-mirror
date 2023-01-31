Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
	by sourceware.org (Postfix) with ESMTPS id 350C63858D38
	for <cygwin-patches@cygwin.com>; Tue, 31 Jan 2023 11:31:03 +0000 (GMT)
Authentication-Results: sourceware.org; dmarc=permerror header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mlvr3-1ox4PG46uR-00ixpZ for <cygwin-patches@cygwin.com>; Tue, 31 Jan 2023
 12:31:02 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 6B5BBA81B7B; Tue, 31 Jan 2023 12:31:01 +0100 (CET)
Date: Tue, 31 Jan 2023 12:31:01 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: dsp: Implement SNDCTL_DSP_SETFRAGMENT ioctl().
Message-ID: <Y9j79bru+tCEPObx@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230130130916.47489-1-takashi.yano@nifty.ne.jp>
 <Y9jfSM8nB6Z+eT3O@calimero.vinschen.de>
 <20230131202049.d5da058b1865fbe9fda95a8f@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230131202049.d5da058b1865fbe9fda95a8f@nifty.ne.jp>
X-Provags-ID: V03:K1:5yDHliZmGwWnJkRJjZXRrjtk3Am6NPkRSp0nBARtPItAwpW4BI8
 uouqlJ2tel1oaiCT74FhvanDYefDdZrErxcVM7owiQ9yipeLONmru0jsw9oOw6ZXTbfBQDx
 YEYJImtEdM/8qgz5Pg3bl1IiuAw9xAApgUH38IGWV3UDbEt2tNkV4TSyXFk21xa4QMOimRw
 w7BYf9MWTjIfhVjHJoMtA==
UI-OutboundReport: notjunk:1;M01:P0:jgN9/5VfdBI=;EhXFstgvqBSA3NxnoW+b3tT3bn4
 QiDfk0hm7kwOvy3EEXcXqEZ+rErUz+yJ3JvExGvorBDzcIiHu4A2tP0cV9V8wcOeeaioCvJCx
 PfNwOwtMdm9icMXIWxjtdQ9m8hB46EhC9GzU2VNdEYXq8onuFyhFuLplBNFxatlyoan+0ef2Y
 DCwr2Nw+T6xzWW71hIMrSvCxn9L5gDAdqrpgaz88FByqRiElVT+6h15CGGKR2GVRdIK8Nd/Dy
 yiOZ1b2k+hedFxia3xwEnvDml2XQMtrw2vw1ZXFxZnMrzQ4W1PpWC6Az1sibhxxW4/gdcb8qy
 XvW5FhK/N83vcEfeBcSf//Mt+7+ux1WpZLA/vSaz5bnhjmIcHdL9SHl1uE6VPeXC4vCLDwMjD
 pJUUGkmQiY79XqZqctnNaZabedB3aZlNkm7sj/Ws+vIgansISHTx01qxtUY1A/ZuSnTHR0qMd
 npZoGhz/aJ46Itd4BVehlJxlFLE+TTNAoTX300YdEUWetqFn8Aakf1escbSwv9Ptpr48KoGdt
 NFhtPNG7Gz6zrpgLQXm4BfSds9iB9grkf+grX+FaZtw8loOwyxqUz+VDLH0p+ysgaPJuxB+U4
 mmOYJOG3yWZgzz7SnmO082yfC6Kod41BofOvCLIjREcmoYhsx5NoXkLGMhNlUNyDIjl8W2MYc
 6/SIbajOsgaMwSqwNnyUtKQVsHu8SOR7/eITPADpEg==
X-Spam-Status: No, score=-97.1 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Jan 31 20:20, Takashi Yano wrote:
> On Tue, 31 Jan 2023 10:28:40 +0100
> Corinna Vinschen wrote:
> > On Jan 30 22:09, Takashi Yano wrote:
> > > Previously, SNDCTL_DSP_SETFRAGMENT was just a fake. In this patch,
> > > it has been implemented to allow latency control in some apps.
> > > 
> > > Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> > > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > > ---
> > >  winsup/cygwin/fhandler/dsp.cc           | 78 ++++++++++++-------------
> > >  winsup/cygwin/local_includes/fhandler.h |  3 +
> > >  2 files changed, 42 insertions(+), 39 deletions(-)
> > 
> > LGTM.  Given how much I *don't* use the audio stuff in Cygwin,
> > would you just like to take over maintainership for this code?
> 
> BTW, should this pach be applied only for master branch?
> What do you think?

It's new functionality, so, yeah, main branch only.


Thanks,
Corinna
