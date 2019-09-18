Return-Path: <cygwin-patches-return-9691-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27541 invoked by alias); 18 Sep 2019 14:29:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 27524 invoked by uid 89); 18 Sep 2019 14:29:39 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-9.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=pty, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-06.nifty.com
Received: from conuserg-06.nifty.com (HELO conuserg-06.nifty.com) (210.131.2.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 18 Sep 2019 14:29:38 +0000
Received: from localhost.localdomain (ntsitm283243.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.151.243]) (authenticated)	by conuserg-06.nifty.com with ESMTP id x8IETKDr031962;	Wed, 18 Sep 2019 23:29:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-06.nifty.com x8IETKDr031962
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1568816965;	bh=6Sk28cMtC05EYCPhUbUHdQ2E51yxIDDC9jAcXvC3gno=;	h=From:To:Cc:Subject:Date:From;	b=TiGFpeX7h94792GX6yuY2mikVo2a1oeqI9Eo4dI5RIiCxKjPl7qrlCHJ64AEc9mSF	 WybhmLlKBwBI5wMEBO7r+8RkZiFeSSgGdxamqo2NwKMaggfsLmoz7SSG0wadH/RO0N	 Q1xnA7kpiXfHciczQXagOCc8VDV3NKrU0yQPvjbG2sIQlgNxbAhSdbrO2OMlkl26Ur	 YWLtGvJmWih0bb6Oy9wy0BZa9HnA9XIWlE3LOxpoHnUNtn5HvQSBlj78LFJGSsVUuV	 W5lD1Oyib6nr3jOW90o84UOAPIzkC6EmQn9UHowzOiDcZY/tHPqsm0a3GxmdHqLoZ0	 nBjutPDi5y+3A==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 0/5] Some fixes for PTY with pseudo console support (4)
Date: Wed, 18 Sep 2019 14:29:00 -0000
Message-Id: <20190918142921.835-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00211.txt.bz2

Takashi Yano (5):
  Cygwin: pty: Avoid potential segfault in PTY code when ppid = 1.
  Cygwin: pty: Make GDB work again on pty.
  Cygwin: pty: Unify the charset conversion codes into a function.
  Cygwin: pty: Add charset conversion for console apps in legacy PTY.
  Cygwin: pty: Add missing guard when PTY is in the legacy mode.

 winsup/cygwin/fhandler_tty.cc | 188 +++++++++++++++++++---------------
 1 file changed, 104 insertions(+), 84 deletions(-)

-- 
2.21.0
