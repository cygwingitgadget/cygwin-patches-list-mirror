Return-Path: <cygwin-patches-return-9699-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 92212 invoked by alias); 18 Sep 2019 20:50:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 92202 invoked by uid 89); 18 Sep 2019 20:50:23 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-10.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*f:sk:87pnjxy, H*i:sk:87pnjxy
X-HELO: conssluserg-03.nifty.com
Received: from conssluserg-03.nifty.com (HELO conssluserg-03.nifty.com) (210.131.2.82) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 18 Sep 2019 20:50:21 +0000
Received: from Express5800-S70 (ntsitm283243.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.151.243]) (authenticated)	by conssluserg-03.nifty.com with ESMTP id x8IKoDcD028155	for <cygwin-patches@cygwin.com>; Thu, 19 Sep 2019 05:50:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x8IKoDcD028155
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1568839813;	bh=K6vjAJJNMRnVFb2ckP/3XB+T29IytSftCKFtfCQv4pQ=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=KGdTECo+vuvrejgn/fZ6RHLufZteR7JlfrUUYF4Bh3M76G6eO5MqUD9FYqVCR2F6E	 14BaPsh05Q6Cr/Vga0rFnA3uXLne+8ERdg9+Dfb00aQMRkbwUQxgcl+TSW5b7dpUhF	 aDgibeXhmpL7+4oSOwPz+lls+CgkxzAmvmYKBkRJUh84lZ9C2Ram9iREQE76kHx4A4	 eAljH+OQDoh1WEcVi3+iPeNnW1Isd9ycZvIGqYOgZfe7DpPBIzSpi2JeaSYYufzhfZ	 qNA8Ru+CiQ35SbZQfwD/yIgEtNZ2lBw3Z93Q/Rr81LpzSIsYvxa68ZSQGmKvP82/M9	 bwsQ5m6MhzNcA==
Date: Wed, 18 Sep 2019 20:50:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Revive Win7 compatibility.
Message-Id: <20190919055015.f2fe5f614e1efabae59438c6@nifty.ne.jp>
In-Reply-To: <87pnjxy3qa.fsf@Rainer.invalid>
References: <20190918142831.787-1-takashi.yano@nifty.ne.jp>	<87pnjxy3qa.fsf@Rainer.invalid>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00219.txt.bz2

On Wed, 18 Sep 2019 18:21:49 +0200
Achim Gratz wrote:
> Takashi Yano writes:
> > - The commit fca4cda7a420d7b15ac217d008527e029d05758e broke Win7
> >   compatibility. This patch fixes the issue.
> > ---
> >  winsup/cygwin/fhandler_console.cc | 10 +++++-----
> >  winsup/cygwin/select.cc           |  2 +-
> >  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> It seems like an attractor for future bugs to define the same constant
> in two different places.  Would there be a header that could provide the
> definition instead?

I agree with you. I will post revised one as v2.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
