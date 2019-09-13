Return-Path: <cygwin-patches-return-9671-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21369 invoked by alias); 13 Sep 2019 21:48:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 21334 invoked by uid 89); 13 Sep 2019 21:48:31 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-9.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*MI:1868, device, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-05.nifty.com
Received: from conuserg-05.nifty.com (HELO conuserg-05.nifty.com) (210.131.2.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 13 Sep 2019 21:48:29 +0000
Received: from localhost.localdomain (ntsitm283243.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.151.243]) (authenticated)	by conuserg-05.nifty.com with ESMTP id x8DLmI1k024407;	Sat, 14 Sep 2019 06:48:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-05.nifty.com x8DLmI1k024407
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1568411303;	bh=E67D79zXrpYF4p2QyC+Sx3ej/L7gZIyjxF6v1bnWRsE=;	h=From:To:Cc:Subject:Date:From;	b=2sYKUgR4c5ez8O6C9Tj2PuSrYlE9/+M8Xh+w/PmmjpAiQtCSLWd2Dqr4w6qXRQBWV	 qHQPE6h90MkGi5v4q+p9o3zg7SxMo1l0Wy3mi77L8dZ9lC7HQHrAto1d0vmz0cS7Bg	 HNAeHj1psQPHKW9+dKgC/zaP8CtUp54eEclbeBGj4n8+UE8NNvs6SI/Nr6AsA7Uiwk	 hW6x8EFHGnTirZ6Ek4z1CzcYKCEweLHg0CXvTbr55sOLfvNFeDgKCf7x/VTdQbZN2s	 UkU826C2xuEc8gladldnaXtc86xLZ88dmRGqd0h6wdmuczayQaVX06Frjo3Q0xPcoO	 vwQHVmz/O4RBg==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 0/1] Cygwin: pty: Switch input and output pipes individually.
Date: Fri, 13 Sep 2019 21:48:00 -0000
Message-Id: <20190913214814.1868-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00191.txt.bz2

- Previously, input and output pipes were switched together between
  the traditional pty and the pseudo console. However, for example,
  if stdin is redirected to another device, it is better to leave
  input pipe traditional pty side even for non-cygwin program. This
  patch realizes such behaviour.

v2:
Small bug fix.

Takashi Yano (1):
  Cygwin: pty: Switch input and output pipes individually.

 winsup/cygwin/dtable.cc           |   6 +-
 winsup/cygwin/fhandler.h          |   9 +-
 winsup/cygwin/fhandler_console.cc |   7 +-
 winsup/cygwin/fhandler_tty.cc     | 194 +++++++++++++++++++++---------
 winsup/cygwin/select.cc           |   4 +-
 winsup/cygwin/spawn.cc            |  44 +++----
 winsup/cygwin/tty.cc              |   5 +-
 winsup/cygwin/tty.h               |   5 +-
 8 files changed, 173 insertions(+), 101 deletions(-)

-- 
2.21.0
