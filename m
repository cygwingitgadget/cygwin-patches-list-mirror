Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 by sourceware.org (Postfix) with ESMTPS id 507A23858C51
 for <cygwin-patches@cygwin.com>; Wed, 15 Jun 2022 04:37:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 507A23858C51
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak044095.dynamic.ppp.asahi-net.or.jp
 [119.150.44.95]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 25F4ae3s018708;
 Wed, 15 Jun 2022 13:36:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 25F4ae3s018708
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1655267805;
 bh=NMVPErZbHdOOXiF/VSEjOqGT5f3YnQ9AHSbEhP67taU=;
 h=From:To:Cc:Subject:Date:From;
 b=IhVvYDYDhN2yRiffkb2wgtf4zsxhe/31uSxY4tia5LiyxF0/9WKk7y4XtSvJ4v8lE
 ADmZEKJm+bPtGFj18nCXzbmdNFJPBp968qLztjT1lec2coY6/VxaKMMnFYsIt1C0jx
 dP07Xmjqfm8sKEKA6MPZRL1i/SOvlfAthPfkyfZy6AEmf6NLPDGNXi7/00ejg73yjr
 NXDWy4vZqSzwRLp0pqeUF+7rxO6+yFNc4IfWYZHdzQnbe2B9GpAqt03VkomnIN27ih
 o0X6+rKFlCjtkF1rUt/sFaDw1/Z5VTs96bGm9JMu46Hdqrnwv0zUjYb2vH2vh2RYuz
 dzBOQsDqVGJ/g==
X-Nifty-SrcIP: [119.150.44.95]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Retain ENABLE_VIRTUAL_TERMIANL_PROCESSING
 flag.
Date: Wed, 15 Jun 2022 13:36:32 +0900
Message-Id: <20220615043632.504-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Wed, 15 Jun 2022 04:37:24 -0000

- Currently, ENABLE_VIRTUAL_TERMINAL_PROCESSING flag is disabled
  unconditionally when exiting from cygwin. This causes ANSI escape
  sequence disabled in Windows Terminal where it is enables by
  default. This patch retains that flag if it is originally enabled.
---
 winsup/cygwin/fhandler.h          | 1 +
 winsup/cygwin/fhandler_console.cc | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index dfad07f72..d7c358e7f 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2022,6 +2022,7 @@ class dev_console
 {
   pid_t owner;
   bool is_legacy;
+  bool orig_virtual_terminal_processing_mode;
 
   WORD default_color, underline_color, dim_color;
 
diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 52239c2f9..12c2c4f12 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -597,6 +597,8 @@ fhandler_console::set_output_mode (tty::cons_mode m, const termios *t,
 				   const handle_set_t *p)
 {
   DWORD flags = ENABLE_PROCESSED_OUTPUT | ENABLE_WRAP_AT_EOL_OUTPUT;
+  if (con.orig_virtual_terminal_processing_mode)
+    flags |= ENABLE_VIRTUAL_TERMINAL_PROCESSING;
   WaitForSingleObject (p->output_mutex, mutex_timeout);
   switch (m)
     {
@@ -1505,6 +1507,8 @@ fhandler_console::open (int flags, mode_t)
       /* Check xterm compatible mode in output */
       acquire_attach_mutex (mutex_timeout);
       GetConsoleMode (get_output_handle (), &dwMode);
+      con.orig_virtual_terminal_processing_mode =
+	!!(dwMode & ENABLE_VIRTUAL_TERMINAL_PROCESSING);
       if (!SetConsoleMode (get_output_handle (),
 			   dwMode | ENABLE_VIRTUAL_TERMINAL_PROCESSING))
 	is_legacy = true;
-- 
2.36.1

