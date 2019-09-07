Return-Path: <cygwin-patches-return-9657-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14555 invoked by alias); 7 Sep 2019 05:39:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 14546 invoked by uid 89); 7 Sep 2019 05:39:43 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-9.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: conuserg-04.nifty.com
Received: from conuserg-04.nifty.com (HELO conuserg-04.nifty.com) (210.131.2.71) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 07 Sep 2019 05:39:40 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-04.nifty.com with ESMTP id x875dWYd029235;	Sat, 7 Sep 2019 14:39:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-04.nifty.com x875dWYd029235
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567834776;	bh=puBfMelQqDlAEYLrpMh8mpB5moERZbnbKW7EqbUqQoY=;	h=From:To:Cc:Subject:Date:From;	b=dntgyo5skhZFW9TSz+KTvVvpgFKUGfHV5jwN8AaTqzgbUaoN+DCnz2jULNJs5TzGp	 t6M6bZO+v4TyUBvwzYQ4Uj0YPdHBoGVwzv8TPRVVLo25bcPSvY/GYtSlZlLLChbp0I	 NiojPy2SYbQjCQST/ZvLW6CzTfDrCVFpaHUTxGKxVB79oaC+zw9nmCk+ZyN7kdVrDg	 ng3Jc6J/gNPadhsgB4nVCMzE2/veplhBfdUHC0ogDL6DL4nIzZewY7mrDvDcmI90TM	 d5JoOdCAXF7nU7lbJHE04n8w+MMQuQ+SG6TCjeHBmqC5w7j3/z/e66ar03C5rkp9e9	 MUuDOvcfCVLGQ==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v4 0/1] Cygwin: pty: Fix the behaviour of Ctrl-C in the pseudo console mode.
Date: Sat, 07 Sep 2019 05:39:00 -0000
Message-Id: <20190907053925.828-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00177.txt.bz2

- When the I/O pipe is switched to the pseudo console side, the
  behaviour of Ctrl-C is unstable. This rarely happens, however,
  for example, shell sometimes crashes by Ctrl-C in that situation.
  This patch fixes that issue.

v4:
Fix the problem 1 and 2 reported in
https://cygwin.com/ml/cygwin-patches/2019-q3/msg00175.html

v3:
Fix mistake in v2.

v2:
Remove the code which accidentally clears ENABLE_ECHO_INPUT flag.

Takashi Yano (1):
  Cygwin: pty: Fix the behaviour of Ctrl-C in the pseudo console mode.

 winsup/cygwin/fhandler.h      |  4 ----
 winsup/cygwin/fhandler_tty.cc | 33 +++++++++++++++++----------
 winsup/cygwin/select.cc       |  2 +-
 winsup/cygwin/spawn.cc        | 42 ++++++++++++++---------------------
 4 files changed, 39 insertions(+), 42 deletions(-)

-- 
2.21.0
