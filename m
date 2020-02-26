Return-Path: <cygwin-patches-return-10125-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 92500 invoked by alias); 26 Feb 2020 15:33:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 92489 invoked by uid 89); 26 Feb 2020 15:33:49 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-11.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: conuserg-03.nifty.com
Received: from conuserg-03.nifty.com (HELO conuserg-03.nifty.com) (210.131.2.70) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 26 Feb 2020 15:33:39 +0000
Received: from localhost.localdomain (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conuserg-03.nifty.com with ESMTP id 01QFXDf4021601;	Thu, 27 Feb 2020 00:33:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-03.nifty.com 01QFXDf4021601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1582731200;	bh=3XPinC0tKZkRlFxjFANr4ej7OJ/XfvWJZi6dvyId3b8=;	h=From:To:Cc:Subject:Date:From;	b=mfGbul8Y9+FnxN9BVMp9t/VsEus4R01yKL1JylHmSqKhfqu9RuSLVFG+tADPXOl8n	 qxO8mC+4JWc2JRp/ovzrvwSxhJFvBRy1o9r9tjaFpDSue6jE9mTgYV/VvOyCxxnl/D	 uuQipW1kP+ASaj8yPLJfsOA/8VWW/HMnLG2URala+h0PpKuIRy5JJzanYl09AlFOuM	 tHJTsSK/8IVZdZN9xg4tuhEJ0RR1xjtG+RkQIdgaNAuyN+34Ivp//LkPUxea2OLhKM	 +yr3u1yLqCez+GuvQCGFudzyGLp04uVWl8aQdAbIZVW7DdFbeVksasjUVRqtADUEQ+	 bWgP4CGRQFiAw==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 0/4] Modify handling of several ESC sequences in xterm mode.
Date: Wed, 26 Feb 2020 15:33:00 -0000
Message-Id: <20200226153302.584-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00231.txt

Takashi Yano (4):
  Cygwin: console: Add workaround for broken IL/DL in xterm mode.
  Cygwin: console: Unify workaround code for CSI3J and CSI?1049h/l.
  Cygwin: console: Add support for REP escape sequence to xterm mode.
  Cygwin: console: Add emulation of CSI3J on Win10 1809.

 winsup/cygwin/fhandler_console.cc | 247 +++++++++++++++++++++++++++---
 winsup/cygwin/wincap.cc           |  20 +++
 winsup/cygwin/wincap.h            |   4 +
 3 files changed, 248 insertions(+), 23 deletions(-)

-- 
2.21.0
