Return-Path: <cygwin-patches-return-9282-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 61258 invoked by alias); 31 Mar 2019 13:48:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 61234 invoked by uid 89); 31 Mar 2019 13:48:03 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-5.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE,URIBL_BLOCKED autolearn=ham version=3.3.1 spammy=H*Ad:D*ne.jp
X-HELO: conuserg-04.nifty.com
Received: from conuserg-04.nifty.com (HELO conuserg-04.nifty.com) (210.131.2.71) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 31 Mar 2019 13:48:00 +0000
Received: from localhost.localdomain (ntsitm424054.sitm.nt.ngn.ppp.infoweb.ne.jp [219.97.74.54]) (authenticated)	by conuserg-04.nifty.com with ESMTP id x2VDlggr021625;	Sun, 31 Mar 2019 22:47:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-04.nifty.com x2VDlggr021625
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1554040071;	bh=nl3pa8blEaaqAPM9yjhtF58NwJCzB7Y+MRys56m+VtA=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=MJVkhWoOMyIlAjHwx6lqaCAIVfFPX9cdah7fQnreURcjT2+i72yJd2Ho6CUPqYvg9	 yU8Gpkb4jShqFypxLm2Hc/xVOHcZDoXb+Mzs1Xn2E+duUEkGdCvHtVwp4iHUzhl+tH	 zyPSsUplPmETRKI/nxbE60SSxsdvROaVdmnQIYTETc+0U1+GJLlDR6FtY+e2+yTkbo	 RYbfHz2uK7AZzxJqkgkWKEWHpdhfIEFKkf8iorAGox1qUzpdEvoj/9bO08tq60b28Y	 MtncQGqHTDVGbKWHgGfR6NWnBLFx//JKz13XacdwQHD6tbp/lQCwty3AqhCe5SmWqC	 zbmKIGHQt+2+Q==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 0/3] Reworks for console code
Date: Sun, 31 Mar 2019 13:48:00 -0000
Message-Id: <20190331134718.1407-1-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190331094731.GC3337@calimero.vinschen.de>
References: <20190331094731.GC3337@calimero.vinschen.de>
X-IsSubscribed: yes
X-SW-Source: 2019-q1/txt/msg00092.txt.bz2

Hi Corinna,

I have revised the patches according to your advice.
Could you please have a look?

Takashi Yano (3):
  Cygwin: console: support 24 bit color
  Cygwin: console: fix select() behaviour
  Cygwin: console: Make I/O functions thread-safe

 winsup/cygwin/environ.cc          |    7 +-
 winsup/cygwin/fhandler.h          |   34 +-
 winsup/cygwin/fhandler_console.cc | 1153 +++++++++++++++++++----------
 winsup/cygwin/select.cc           |   90 +--
 winsup/cygwin/wincap.cc           |   10 +
 winsup/cygwin/wincap.h            |    2 +
 6 files changed, 840 insertions(+), 456 deletions(-)

-- 
2.17.0
