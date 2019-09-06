Return-Path: <cygwin-patches-return-9644-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 108830 invoked by alias); 6 Sep 2019 12:48:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 108820 invoked by uid 89); 6 Sep 2019 12:48:37 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-9.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: conuserg-04.nifty.com
Received: from conuserg-04.nifty.com (HELO conuserg-04.nifty.com) (210.131.2.71) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 06 Sep 2019 12:48:35 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-04.nifty.com with ESMTP id x86CmIXS019442;	Fri, 6 Sep 2019 21:48:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-04.nifty.com x86CmIXS019442
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567774102;	bh=T46bQqyIlR92OjsUa0NrapVPvJqdlXxjeZ3RrHvNcy8=;	h=From:To:Cc:Subject:Date:From;	b=T+yFSp55dgb5Bv8u7FM7CZQlV9UCYN0+CnETmGKgOsB96kmutXff9KoWgj1cJf4WO	 nZa3SFt+CVPphGsdisxS/GhXhI6xIALa3vOiHZtt4b7/ZYr9Ezekn5mOba844m+Agd	 isssX6krylDSEWfC1FyvSe+XbrB4heX4lCQ7z8fqoUYOUtyQ0qDrMYotaZNs4/lXXK	 6IOzqRm7KI7hSEG89NxMfMb78g4RAZl/yIDw1bwsC7JACB1ByuFI5a28oBgQ4TmW9h	 0FR6Tx9EyKGiJAD349n8ssrweh9ueBwe9GGs29i1mNmPdcSHNo4QftEJd9vSmbSTGp	 j3BX4DkcdL6vg==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 0/1] Cygwin: pty: Fix the behaviour of Ctrl-C in the pseudo console mode.
Date: Fri, 06 Sep 2019 12:48:00 -0000
Message-Id: <20190906124816.1424-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00164.txt.bz2

- When the I/O pipe is switched to the pseudo console side, the
  behaviour of Ctrl-C is unstable. This rarely happens, however,
  for example, shell sometimes crashes by Ctrl-C in that situation.
  This patch fixes that issue.

Takashi Yano (1):
  Cygwin: pty: Fix the behaviour of Ctrl-C in the pseudo console mode.

 winsup/cygwin/fhandler.h      |   4 +-
 winsup/cygwin/fhandler_tty.cc |  32 +++++----
 winsup/cygwin/select.cc       |   2 +-
 winsup/cygwin/spawn.cc        | 128 +++++++++++++++++-----------------
 4 files changed, 88 insertions(+), 78 deletions(-)

-- 
2.21.0
