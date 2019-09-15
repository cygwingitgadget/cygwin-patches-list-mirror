Return-Path: <cygwin-patches-return-9681-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2101 invoked by alias); 15 Sep 2019 04:06:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 1914 invoked by uid 89); 15 Sep 2019 04:06:18 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-9.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=UD:jp, screen, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-01.nifty.com
Received: from conuserg-01.nifty.com (HELO conuserg-01.nifty.com) (210.131.2.68) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 15 Sep 2019 04:06:16 +0000
Received: from localhost.localdomain (ntsitm283243.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.151.243]) (authenticated)	by conuserg-01.nifty.com with ESMTP id x8F45sLn026084;	Sun, 15 Sep 2019 13:05:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-01.nifty.com x8F45sLn026084
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1568520359;	bh=Py3lgof0sPSodB977iTzpJPLpyfj6W/YRqX31hLZ1VE=;	h=From:To:Cc:Subject:Date:From;	b=hswZhNDjEUo5gZ/3es77J5KY8pL25oi01rc3ATtD2GKRdqOLJe17G5OfI4Y8aWc0E	 I1SJRZP3HbeCHJjfPTKKul3wAyRFmSdfK8VWABQYJ5eNXnR7qJO8Mc9ssYw/z8vlp0	 jsTWcZcURcQW+USBWnBDn88s+ChdTKc+tGN6GRjlLXy/AAnth5rPded8XIqAKHcTJS	 7AyDd3R/YoPZuSH1sjKO81DgLieJFKv5uwd7/ojlbXVjG6ltGP0zGq6Tn38qCoXXtp	 zSdQZC1piTMNtEm3nOHTZ25M7WojK5RRlclgmc/n5X1Fs98+KIJTpj8+8hLqB7sja7	 5PsXtRctR21GQ==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 0/3] Some fixes for PTY with pseudo console support (3)
Date: Sun, 15 Sep 2019 04:06:00 -0000
Message-Id: <20190915040553.849-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00200.txt.bz2

[PATCH 1/3] Fix bad file descriptor error in some environment.
The bad file descriptor problem reported in:
https://cygwin.com/ml/cygwin-patches/2019-q3/msg00104.html
was recurring. Fixed again.

[PATCH 2/3] Use system NLS function instead of PTY's own one.
Since calling system __loadlocale() caused execution error,
PTY used its own NLS function. The cause of the error has been
found, the corresponding code has been rewritten using system
function.

[PATCH 3/3] Change the timing of clearing screen.
The code which clears screen is moved from reset_switch_to_pcon()
to fixup_after_exec() because it seems not too early even at this
timing.

Takashi Yano (3):
  Cygwin: pty: Fix bad file descriptor error in some environment.
  Cygwin: pty: Use system NLS function instead of PTY's own one.
  Cygwin: pty: Change the timing of clearing screen.

 winsup/cygwin/fhandler.h      |   1 +
 winsup/cygwin/fhandler_tty.cc | 527 ++++++++--------------------------
 winsup/cygwin/tty.cc          |   2 +-
 winsup/cygwin/tty.h           |   2 +-
 4 files changed, 120 insertions(+), 412 deletions(-)

-- 
2.21.0
