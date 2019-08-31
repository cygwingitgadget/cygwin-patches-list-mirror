Return-Path: <cygwin-patches-return-9579-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 37771 invoked by alias); 31 Aug 2019 14:54:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 37758 invoked by uid 89); 31 Aug 2019 14:54:15 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-7.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=redesigning, HDKIM-Filter:v2.10.3, HX-Spam-Relays-External:Sendmail, H*RU:Sendmail
X-HELO: conuserg-03.nifty.com
Received: from conuserg-03.nifty.com (HELO conuserg-03.nifty.com) (210.131.2.70) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 31 Aug 2019 14:54:13 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-03.nifty.com with ESMTP id x7VErhL3032446;	Sat, 31 Aug 2019 23:53:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-03.nifty.com x7VErhL3032446
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567263232;	bh=fvKB3KfMGNpI5gpMXCvAhF5tTu8gMzKGvKOLnlSDS9U=;	h=From:To:Cc:Subject:Date:From;	b=zVA9wAhcsXwAHqPG7k/S6OaVpf7ne/bKflil8dxnuUiIYYi0I/Pg5nowjErn9rdcx	 QegBSWPeuK8oGrgQBBRvR0w3RSKxQ7CAbUMAqcmcWf1IO1BPyE/gCPwdK2XxL+xIS/	 T0uP6po4rezjmzoTAalFhKTUubjJ8lGOffo/fIEt1tzdAM0HRpMkxcqsENUpP71Sj8	 U+hFEAChHpodMR4nZ1oBapxuMs3734XeDE8wI57PNi6ARN77fGrqjbDpkaQtNduc+E	 0VpWFLpUBxz7OBq5z8okSiHrY2/Rj+g0y5j08aHt88aS71yJpzdxoUG5VtVoy/+jtm	 6lme8LoF4JEfQ==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 0/1] Fix PTY state management in pseudo console support.
Date: Sat, 31 Aug 2019 14:54:00 -0000
Message-Id: <20190831145318.1854-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00099.txt.bz2

Pseudo console support in test release TEST: Cygwin 3.1.0-0.3,
introduced by commit 169d65a5774acc76ce3f3feeedcbae7405aa9b57,
has some bugs which cause mismatch between state variables and
real pseudo console state regarding console attaching and r/w
pipe switching. This patch fixes this issue by redesigning the
state management.

Takashi Yano (1):
  Cygwin: pty: Fix state management for pseudo console support.

 winsup/cygwin/dtable.cc           |  15 +-
 winsup/cygwin/fhandler.h          |   6 +-
 winsup/cygwin/fhandler_console.cc |   6 +-
 winsup/cygwin/fhandler_tty.cc     | 401 ++++++++++++++++--------------
 winsup/cygwin/fork.cc             |  24 +-
 winsup/cygwin/spawn.cc            |  65 ++---
 6 files changed, 280 insertions(+), 237 deletions(-)

-- 
2.21.0
