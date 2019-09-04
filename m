Return-Path: <cygwin-patches-return-9601-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 87391 invoked by alias); 4 Sep 2019 01:46:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 87366 invoked by uid 89); 4 Sep 2019 01:46:38 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-10.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GIT_PATCH_3,HEXHASH_WORD,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:1065, screen, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-06.nifty.com
Received: from conuserg-06.nifty.com (HELO conuserg-06.nifty.com) (210.131.2.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Sep 2019 01:46:37 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-06.nifty.com with ESMTP id x841kPmV024773;	Wed, 4 Sep 2019 10:46:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-06.nifty.com x841kPmV024773
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567561594;	bh=1v6J6J4S48Z+VolX4QYeC1P+Xj7rPYXrMaMWTZriisg=;	h=From:To:Cc:Subject:Date:From;	b=zMKFXtCBdbnlC78hN38j0BWnw3I4Y3B2sq3wJU/oaB2hqwufMSJuOe2FXkcU37Iou	 B1K1UoglCiRQRqCurBgQ8CxfCPRyZdxhUjpqT4Dt5hJny7RT/AclqqsITmLGs66t5J	 SVQV7t4U6m75x2PSyv2YISfOwbfvmMKdZoGWb+Bah9d+tItv5PL/UMdGt3lTCpOjHN	 b167Rf9E8gumkoihRP0vNfhyWm5fILMMFPuEMLn4oSqR8q566mtLnRC5M7O/xHmPQu	 OvdveSyOkmaal/wlLmG8S2H01pe6p6r56OUbGKsWPEz6WuSEvJ7+lYFN2cfpn6GdGJ	 O/jiF6D6KkHWA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 0/2] Some fixes for PTY with pseudo console support (2)
Date: Wed, 04 Sep 2019 01:46:00 -0000
Message-Id: <20190904014618.1372-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00121.txt.bz2

[PATCH 1/2] Cygwin: pty: Add a workaround for ^C handling.
- Pseudo console support introduced by commit
  169d65a5774acc76ce3f3feeedcbae7405aa9b57 sometimes cause random
  crash or freeze by pressing ^C while cygwin and non-cygwin
  processes are executed simultaneously in the same pty. This
  patch is a workaround for this issue.

[PATCH 2/2] Cygwin: pty: Disable clear screen on new pty if TERM=dumb or emacs*.
- Pseudo console support introduced by commit
  169d65a5774acc76ce3f3feeedcbae7405aa9b57 shows garbage ^[[H^[[J in
  some of emacs screens. These screens do not handle ANSI escape
  sequences. Therefore, clear screen is disabled on these screens.

Takashi Yano (2):
  Cygwin: pty: Add a workaround for ^C handling.
  Cygwin: pty: Disable clear screen on new pty if TERM=dumb or emacs*.

 winsup/cygwin/fhandler_tty.cc | 31 ++++++++++++++++++++++++-------
 winsup/cygwin/spawn.cc        |  6 ++++++
 winsup/cygwin/tty.cc          |  1 +
 winsup/cygwin/tty.h           |  1 +
 4 files changed, 32 insertions(+), 7 deletions(-)

-- 
2.21.0
