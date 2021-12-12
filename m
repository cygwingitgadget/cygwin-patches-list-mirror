Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id B82A9385841C
 for <cygwin-patches@cygwin.com>; Sun, 12 Dec 2021 13:05:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org B82A9385841C
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 1BCD59Ug022149;
 Sun, 12 Dec 2021 22:05:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 1BCD59Ug022149
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1639314319;
 bh=0g6jIUWe2ABVpHgeS1LaKSfMtjoPAz93olAKae0ksFg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=amGWrOvhs00KplK3PppWA99taJDBE43hH6u7qhSAzK5tfOVH/9g4zPPrejVmRLV+I
 PBTQC8fNZQoC1bf68xZu1cmjF9sTqDSNE+YSnYkwC8NBaStAJTkgfAn5/cf1jg6m51
 neihE1UyZeYLB4CgMQp7eVy49VfEOMzSElGBRrbhmT9YliJvyiI9lmjrHOaZ6Y9laJ
 cOFI+2fyT7Gq/DHXBJgNeQzSeRa0z5RmTIOfj69+TzxgciSroCR/Il7piFa3/Oclve
 wsNU3QYQkSiIjcGAop/DHVOZ6EiER5v+GxVVWicKUFA1GR6OeHxXgQE6Yz9lYWXDNI
 KzCLTHe8XHLBA==
X-Nifty-SrcIP: [110.4.221.123]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/3] Cygwin: pty: Fix console mode of non-cygwin apps in
 background.
Date: Sun, 12 Dec 2021 22:05:00 +0900
Message-Id: <20211212130501.10091-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211212130501.10091-1-takashi.yano@nifty.ne.jp>
References: <20211212130501.10091-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Sun, 12 Dec 2021 13:05:40 -0000

- If the non-cygwin app is started in the background in pseudo
  console, the console mode is broken for the app. This patch fixes
  the issue.
---
 winsup/cygwin/fhandler_tty.cc | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 904398179..cd0de9bc0 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -3384,7 +3384,7 @@ skip_create:
   if (get_ttyp ()->previous_output_code_page)
     SetConsoleOutputCP (get_ttyp ()->previous_output_code_page);
 
-  do
+  if (get_ttyp ()->getpgid () == myself->pgid)
     {
       termios &t = get_ttyp ()->ti;
       DWORD mode;
@@ -3409,7 +3409,6 @@ skip_create:
 	mode |= DISABLE_NEWLINE_AUTO_RETURN;
       SetConsoleMode (hpConOut, mode);
     }
-  while (false);
 
   return true;
 
-- 
2.34.1

