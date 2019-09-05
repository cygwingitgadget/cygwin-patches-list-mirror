Return-Path: <cygwin-patches-return-9629-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 80154 invoked by alias); 5 Sep 2019 00:25:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 79775 invoked by uid 89); 5 Sep 2019 00:24:59 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-9.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=screen, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-06.nifty.com
Received: from conuserg-06.nifty.com (HELO conuserg-06.nifty.com) (210.131.2.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 05 Sep 2019 00:24:55 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-06.nifty.com with ESMTP id x850OYlK003102;	Thu, 5 Sep 2019 09:24:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-06.nifty.com x850OYlK003102
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567643082;	bh=sYMFUtGeH3cTOc6WwYVHMxPQgtNiEXWUAmwoI8CN20E=;	h=From:To:Cc:Subject:Date:From;	b=hDXZFWFsuQpB4sBQCi+7LUCC4a9b6VTYDW15/9SoeEc6oomSi6b8XB642dc36Q8wS	 lN8obSz2YfAL/Kdkjh0PLJNWniNVshHQUXedzWgEbJMqSGTmSlnL9MDc5l+Tr7grqN	 9Q6jGsibjaHnSskqHQhdkWCl2uZ9lOW9KzqRtE/4xCU3cfcGtqx4wWjKxa8DHEbY3w	 vcExM+KsgNZ+ufJJQp9sFOyvm7FZgbRe96+qdBsNUmC+N3SM6qORSzYRj1I/DoJ/8o	 SnebgSmV0Nuqpz0YijbcAobLe+ub+FuaiAWLhSCWar1resHSkti19AgknIuwevsvh2	 LZi2qp0b1LTjw==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 0/1] Disable clear screen on new pty if TERM=dumb or emacs*.
Date: Thu, 05 Sep 2019 00:25:00 -0000
Message-Id: <20190905002426.362-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00149.txt.bz2

- Pseudo console support introduced by commit
  169d65a5774acc76ce3f3feeedcbae7405aa9b57 shows garbage ^[[H^[[J in
  some of emacs screens. These screens do not handle ANSI escape
  sequences. Therefore, clear screen is disabled on these screens.

v2:
Remove check for TERM in fixup_after_attach().

Takashi Yano (1):
  Cygwin: pty: Disable clear screen on new pty if TERM=dumb or emacs*.

 winsup/cygwin/fhandler_tty.cc | 19 ++++++++++++++-----
 winsup/cygwin/tty.cc          |  1 +
 winsup/cygwin/tty.h           |  1 +
 3 files changed, 16 insertions(+), 5 deletions(-)

-- 
2.21.0
