Return-Path: <cygwin-patches-return-9695-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30452 invoked by alias); 18 Sep 2019 14:30:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 30350 invoked by uid 89); 18 Sep 2019 14:30:31 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=sig, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-03.nifty.com
Received: from conuserg-03.nifty.com (HELO conuserg-03.nifty.com) (210.131.2.70) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 18 Sep 2019 14:30:15 +0000
Received: from localhost.localdomain (ntsitm283243.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.151.243]) (authenticated)	by conuserg-03.nifty.com with ESMTP id x8IEU5eK021709;	Wed, 18 Sep 2019 23:30:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-03.nifty.com x8IEU5eK021709
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1568817011;	bh=/vmkWwyz0gBxAla4h36I2whz/eGsq6aQa1Wdl5FZDvE=;	h=From:To:Cc:Subject:Date:From;	b=GkHujK3kqd4ZsUqvwLmlJYNaORaGBfNM8PpPkOHGk0WwlbW5Vnq16Qw+F8QJgyCCf	 NSnJtCVsV4hgkIqYkbrY9dw0sF1zPIYPxK3UXu+tDPV5FHw6wWOUrXLozp5zTtrUef	 vOkgaLRjS7ixb4ftMmTGSEJwkCDdywrCB8MvOI783xIqNwUkkBQK0rBLbeJ9W4ri1/	 71WGcAWvI2RP8nVsr0nOaP/rz8P6HIIA1Epepu9AtAB+Dnv8Abb2PHXDSy34qAcsZm	 fWbEJYE0S2kzNVBu8ZPUKinJ7o1ZIFaSFUwxlgM1HY0LqIo/i9pSMmKGizGy8HnpHT	 8r3BYrtT4eQKg==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: console: Make console input work in GDB and strace.
Date: Wed, 18 Sep 2019 14:30:00 -0000
Message-Id: <20190918143006.888-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00215.txt.bz2

- After commit 2232498c712acc97a38fdc297cbe53ba74d0ec2c, console
  input cause error in GDB or strace. This patch fixes this issue.
---
 winsup/cygwin/fhandler_termios.cc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_termios.cc b/winsup/cygwin/fhandler_termios.cc
index 5b0ba5603..282f0fbf4 100644
--- a/winsup/cygwin/fhandler_termios.cc
+++ b/winsup/cygwin/fhandler_termios.cc
@@ -202,7 +202,8 @@ fhandler_termios::bg_check (int sig, bool dontsignal)
   */
   if (!myself->pgid || !tc () || tc ()->getpgid () == myself->pgid ||
 	myself->ctty != tc ()->ntty ||
-	((sig == SIGTTOU) && !(tc ()->ti.c_lflag & TOSTOP)))
+	((sig == SIGTTOU) && !(tc ()->ti.c_lflag & TOSTOP)) ||
+	being_debugged ())
     return bg_ok;
 
   /* sig -SIGTTOU is used to indicate a change to terminal settings, where
-- 
2.21.0
