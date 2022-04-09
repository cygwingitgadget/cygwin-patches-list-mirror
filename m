Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id 774CA3858C51
 for <cygwin-patches@cygwin.com>; Sat,  9 Apr 2022 04:37:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 774CA3858C51
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak044095.dynamic.ppp.asahi-net.or.jp
 [119.150.44.95]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 2394baI7023401;
 Sat, 9 Apr 2022 13:37:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 2394baI7023401
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1649479061;
 bh=u++f7suA94/uZXQqe224wE1HlkfdCHmpD4IF8uvwNXo=;
 h=From:To:Cc:Subject:Date:From;
 b=KwygqExXHNpVSilu6HUxBZCAZaENXV5+hyCx57ZGDDcmnIq8Luh1OTAkLqiS3DOWE
 DhJONfxpY5rGuEeIF/tGaPhy3r3EwuLbXqjQuqjv8Sx+yQJsEAy5Y+RGV82S00BXtY
 6C3oTwtgUPkRZrF9gPmmRlidnjpRxaIpsKecnNIXzRtcvtEoA3Hz7DA+WQRkdLkr+x
 y5r+KxEiSFbtj1XbNj+BGWo8VljsZgrAM5UKOSP62mDGx0LqVxtjx/HA8mEdKviBGP
 N50NnhC7J6Iy3Hq4iZd7lXuGM+NxhAlJQMxYrf+7CWcsHeHvqvPsVw/yfSTzY2TzFI
 mnjxzgEFhp/Gg==
X-Nifty-SrcIP: [119.150.44.95]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Close pseudo console only if the process is the
 owner.
Date: Sat,  9 Apr 2022 13:37:36 +0900
Message-Id: <20220409043736.849-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
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
X-List-Received-Date: Sat, 09 Apr 2022 04:37:59 -0000

- Currently, close_pseudoconsole() is called unconditionally from
  fhandler_termios::process_sigs() on Ctrl-C. This causes deadlock
  if Ctrl-C is pressed while setup_pseudoconsole() is called. With
  this patch, close_pseudoconsole() is called only if the master
  process is the owner of the nat-pipe to avoid the deadlock.
---
 winsup/cygwin/fhandler_tty.cc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 4cb5f1411..c02dfb8ed 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -4152,7 +4152,8 @@ void
 fhandler_pty_slave::release_ownership_of_nat_pipe (tty *ttyp,
 						   fhandler_termios *fh)
 {
-  if (fh->get_major () == DEV_PTYM_MAJOR)
+  if (fh->get_major () == DEV_PTYM_MAJOR
+      && nat_pipe_owner_self (ttyp->nat_pipe_owner_pid))
     {
       fhandler_pty_master *ptym = (fhandler_pty_master *) fh;
       WaitForSingleObject (ptym->pipe_sw_mutex, INFINITE);
-- 
2.35.1

