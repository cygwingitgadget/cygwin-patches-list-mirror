Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id E1A603858407
 for <cygwin-patches@cygwin.com>; Sun, 13 Feb 2022 14:40:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org E1A603858407
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 21DEdOvJ000575;
 Sun, 13 Feb 2022 23:39:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 21DEdOvJ000575
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1644763191;
 bh=Y0EsVzfvQ0VnTTgFN7VH4ntew6QQPVbZ+GZO4VkHO5w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oyLpg/7h/rSuacYySsfP5lN50PYH88/Z57gwA5WVaBBDVmvBrZJHN3ZtM9QHk4xCq
 SvFOYj3IIMWXiYTeQjKZeXWnkFXY1gYKVV3OWrZ1ABQdVF8rFEco4OHw/1e3QDcD9e
 PkPMy8I3HKMdIuMznd/1snT7C9u126s2k+C7lKoZpl8kmwEdher1beMXbMsncIwDku
 Zu83yGzM2Fgeq0r2Y45QxNl43Acze68sOcMjGtrZzsGfRd4YWT+JZ+tR0ivAQupiwZ
 rW0X/L7JfMWZIW/jCRkRefzMZOOUlu/x6wr3prAc949fVJ9O+RnK+4PMi9Pbu3uwz4
 /ulXEsfMy0whw==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 3/8] Cygwin: pty: Prevent deadlock on echo output.
Date: Sun, 13 Feb 2022 23:39:05 +0900
Message-Id: <20220213143910.1947-4-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220213143910.1947-1-takashi.yano@nifty.ne.jp>
References: <20220213143910.1947-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sun, 13 Feb 2022 14:40:15 -0000

- If the slave process writes a lot of text output, doecho() can
  cause deadlock. This is because output_mutex is held in slave::
  write() and if WriteFile() is blocked due to pipe full, doecho()
  tries to acquire output_mutex and gets into deadlock. With this
  patch, the deadlock is prevented on the sacrifice of atomicity
  of doecho().
---
 winsup/cygwin/fhandler_tty.cc | 2 --
 1 file changed, 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 7bef6958c..7e065c46a 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -496,11 +496,9 @@ void
 fhandler_pty_master::doecho (const void *str, DWORD len)
 {
   ssize_t towrite = len;
-  acquire_output_mutex (mutex_timeout);
   if (!process_opost_output (echo_w, str, towrite, true,
 			     get_ttyp (), is_nonblocking ()))
     termios_printf ("Write to echo pipe failed, %E");
-  release_output_mutex ();
 }
 
 int
-- 
2.35.1

