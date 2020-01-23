Return-Path: <cygwin-patches-return-9980-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 42871 invoked by alias); 23 Jan 2020 11:34:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 42862 invoked by uid 89); 23 Jan 2020 11:34:36 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:794, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-06.nifty.com
Received: from conuserg-06.nifty.com (HELO conuserg-06.nifty.com) (210.131.2.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 23 Jan 2020 11:34:35 +0000
Received: from localhost.localdomain (ntsitm247158.sitm.nt.ngn.ppp.infoweb.ne.jp [124.27.253.158]) (authenticated)	by conuserg-06.nifty.com with ESMTP id 00NBYMio010007;	Thu, 23 Jan 2020 20:34:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-06.nifty.com 00NBYMio010007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1579779266;	bh=uwE5mju96T18hOiFScWjnk0jsH/zJ+4aIwrr/76RFBU=;	h=From:To:Cc:Subject:Date:From;	b=NyRgHB01lEoXIv0PmMpdoRltXYTta6o315r0cd99VVF097BQsHk1zSKtTvpFdeguZ	 29Jxjc8KGZYvMcEymum3OkAz6XVWabI/FoF96Dz/p50z+KKGGLbxOq65IfA1WldIXc	 mOB/eYS/axSl00lv+nfsMCDxXfcMAyCYpHXdROT+QHlFbqtQsfc4JodfCGsbrGB5Lv	 eo7Kfk7f4yevNDY3j+2i+tPtbIrBy+phVdD4I/aqDLmF3NYibv/sxKh2XDGSOaE/p/	 AxyfpIfdxYVsdFVonlBWs0Sr4mjnl6oFhPyjvBsgvowgc35hwwC5KwrI9Y+rsv08HV	 pKNEKVBGSbePg==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Remove close() call just before reopening slave.
Date: Thu, 23 Jan 2020 11:34:00 -0000
Message-Id: <20200123113425.1967-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00086.txt

- After commit da4ee7d60b9ff0bcdc081609a4467adb428d58e6, the issue
  reported in https://www.cygwin.com/ml/cygwin/2020-01/msg00209.html
  occurs. This patch fixes the issue.
---
 winsup/cygwin/fhandler_tty.cc | 1 -
 1 file changed, 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 73aeff37f..35a48338f 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1326,7 +1326,6 @@ fhandler_pty_slave::push_to_pcon_screenbuffer (const char *ptr, size_t len)
     {
       termios_printf ("GetConsoleMode failed, %E");
       /* Re-open handles */
-      this->close ();
       this->open (0, 0);
       /* Fix pseudo console window size */
       this->ioctl (TIOCSWINSZ, &get_ttyp ()->winsize);
-- 
2.21.0
