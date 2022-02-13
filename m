Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id 01CEF3858418
 for <cygwin-patches@cygwin.com>; Sun, 13 Feb 2022 14:40:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 01CEF3858418
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 21DEdOvN000575;
 Sun, 13 Feb 2022 23:39:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 21DEdOvN000575
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1644763196;
 bh=iUbtjOMkXQyjThkB5KhjKMtmniJIcu2KiLQOcokkQWA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Pr7KXrzZNzBf/mSX85OFdCtNeYXc59wS7+xBMS/CczmChSBt4C9dq8iCcPuAAfte/
 LdZKuH1hzDcZvaCve36uIjlUdfExD5O7cfLCgJvsF5tRS3KgMH8453bEJYAfbUmxti
 FHyiCKUvVA/zrjYXHwl2XNIV2ZBcTSNy8V+CZuGvWM19jAiAayoUmoYmQ5kB17vwAC
 /U+dF4/+I5JuaY1ko0Ply43I2P1F0GAYfIINYRN3ltnQuIatDZMrCtvMwpngHFhTlz
 wX1jPvSTMKDzUBwbApuG16TRJf9eGQgpj5pnpx344JYfmz/GDg+X823M+T4Lw0w+TJ
 IL7IgBAs0i+dg==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 5/8] Cygwin: pty: Discard input in from_master_nat pipe on
 signal as well.
Date: Sun, 13 Feb 2022 23:39:07 +0900
Message-Id: <20220213143910.1947-6-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220213143910.1947-1-takashi.yano@nifty.ne.jp>
References: <20220213143910.1947-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sun, 13 Feb 2022 14:40:16 -0000

- Currently, pty discards input only in from_master pipe on signal.
  Due to this, if pty is started without pseudo console support and
  start a non-cygwin process from cmd.exe, type adhead input is not
  discarded on signals such as Ctrl-C. This patch fixes the issue.
---
 winsup/cygwin/fhandler_tty.cc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 7e733e49a..8c9a10c23 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -438,6 +438,9 @@ fhandler_pty_master::discard_input ()
   while (::bytes_available (bytes_in_pipe, from_master) && bytes_in_pipe)
     ReadFile (from_master, buf, sizeof(buf), &n, NULL);
   ResetEvent (input_available_event);
+  if (!get_ttyp ()->pcon_activated)
+    while (::bytes_available (bytes_in_pipe, from_master_nat) && bytes_in_pipe)
+      ReadFile (from_master_nat, buf, sizeof(buf), &n, NULL);
   get_ttyp ()->discard_input = true;
   ReleaseMutex (input_mutex);
 }
-- 
2.35.1

