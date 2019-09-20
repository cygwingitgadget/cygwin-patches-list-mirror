Return-Path: <cygwin-patches-return-9706-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 49866 invoked by alias); 20 Sep 2019 03:04:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 49761 invoked by uid 89); 20 Sep 2019 03:04:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-10.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: conuserg-05.nifty.com
Received: from conuserg-05.nifty.com (HELO conuserg-05.nifty.com) (210.131.2.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 20 Sep 2019 03:04:54 +0000
Received: from localhost.localdomain (ntsitm283243.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.151.243]) (authenticated)	by conuserg-05.nifty.com with ESMTP id x8K34gZ6025993;	Fri, 20 Sep 2019 12:04:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-05.nifty.com x8K34gZ6025993
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1568948687;	bh=njTX3+BQvyQlOzJ6Lvljm2LZk1vf531YlfXRACyRfrQ=;	h=From:To:Cc:Subject:Date:From;	b=xNTtGb3SDNabMh3hZZCAviaNGMMzaPP3X9WvhzWtLUS8hP9oPghk60LZazf4NlOEX	 yj74Pg79NoPuUaTk4lNNjvMHPP3JJh6EMNjxOPn5vMJPIlteZGBmARtPuAyab+hRgh	 3q+FGH69VHKCpkPseA8lLWZzZbdMpcg8ErZQ8xtNbOKZ3r0EUSa/DLXBriJS+X8F4M	 CI4MXqOsEDfHnTW27ipiNjsWhfuBMn9CwABAUcgLbTUiPUFC/2Gdy5xTkiK7TGYsS0	 6zoL3YJvXvOEZwhsevCVw8M2VpDkM4OZ/ZOL60QQcaIf2yiwxPad2904iVVUR2roOE	 vRWpQgEw6anOA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 0/1] Cygwin: Fix incorrect TTY for non-cygwin process.
Date: Fri, 20 Sep 2019 03:04:00 -0000
Message-Id: <20190920030436.973-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00226.txt.bz2

- After commit d4045fdbef60d8e7e0d11dfe38b048ea2cb8708b, the TTY
  displayed by ps command is incorrect if the process is non-cygwin
  process. This patch fixes this issue.

v2:
Simplify the condition to call proc_subproc (PROC_CLEARWAIT, 1) in
exceptions.cc.

Takashi Yano (1):
  Cygwin: Fix incorrect TTY for non-cygwin process.

 winsup/cygwin/exceptions.cc | 2 +-
 winsup/cygwin/spawn.cc      | 5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

-- 
2.21.0
