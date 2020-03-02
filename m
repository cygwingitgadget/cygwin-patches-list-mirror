Return-Path: <cygwin-patches-return-10153-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 52427 invoked by alias); 2 Mar 2020 01:13:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 52414 invoked by uid 89); 2 Mar 2020 01:13:18 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-8.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*Ad:D*jp, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-05.nifty.com
Received: from conuserg-05.nifty.com (HELO conuserg-05.nifty.com) (210.131.2.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 02 Mar 2020 01:13:17 +0000
Received: from localhost.localdomain (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conuserg-05.nifty.com with ESMTP id 0221D5nM031112;	Mon, 2 Mar 2020 10:13:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-05.nifty.com 0221D5nM031112
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1583111591;	bh=FYT2hYcitRP72179gnVpxksFAmL/gKjbsh4xZbxfCpw=;	h=From:To:Cc:Subject:Date:From;	b=hTobIuDdWia3M5mUz0MnxgushUOx/6kYozhQwFNaWvO2DxyBMgyX2FZvr6+P5mnou	 UKNq/JQC/9uaoh6WF6Q7r55NYF8Bfx7XRtsDSS6/KYFi9w82urLZ44jVIusXJus7ye	 OsiVNXasCeTZK3aZQsExo46rYfIOBbABDaj6Y6sOT9V73JgwDDso/sUXzXe1WFF8OI	 GcaSCXqB9UH+VVmixZyJYrho/66v5h7Al2mRdcFeHNwhhMnlQn/bJ70NYC7XdpUo/f	 BnsygUoFfgLmtVR5nKfmqd+4fXWIfMNGKoC7pn7ESxMNoR27oXzHgAmlyRpqNOSp+d	 YfhX4WALnGy+w==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 0/4] Cygwin: console: Some fixes for console in xterm mode.
Date: Mon, 02 Mar 2020 01:13:00 -0000
Message-Id: <20200302011258.592-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00259.txt

Takashi Yano (4):
  Cygwin: console: Revise the code to fix tab position.
  Cygwin: console: Fix setting/unsetting xterm mode for input.
  Cygwin: console: Prevent buffer overrun.
  Cygwin: console: Add a workaround for "ESC 7" and "ESC 8".

 winsup/cygwin/fhandler.h          |  1 +
 winsup/cygwin/fhandler_console.cc | 91 ++++++++++++++++++-------------
 2 files changed, 55 insertions(+), 37 deletions(-)

-- 
2.21.0
