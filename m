Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id 74246385781A
 for <cygwin-patches@cygwin.com>; Tue, 16 Nov 2021 03:19:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 74246385781A
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 1AG3Ir60008345;
 Tue, 16 Nov 2021 12:18:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 1AG3Ir60008345
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1637032739;
 bh=EOUQC0bHvljI2TL3dPEcMTQfXWW3rKYgviXeDgbPXKo=;
 h=From:To:Cc:Subject:Date:From;
 b=zHes3qsHdeBj/m2NRaxrqQ3JxNWQYxrd7QvVuQlJy1U6nEcSk+BgFr8JsiMiPXgH4
 cgamSTyCotBu8wtW1kRRJV4l+6a7tsyGjDZ2NZrc4Wrdl4E6+scjZJJTex/p4p01td
 cvXutEUYCmTSigwtXreC4FUyq3NO2fGZuoOwnckVT5Rt8yvMVouFW4OttnIi4lNHzI
 /3km5qPtXu5LphLMINv0liICCWRK6sapaOXymkypDkIWn9UEsYt/LrUkbDd9+1diFO
 eV37YFSvdIYKTacyskpOqIFxL8INO0IpuGV2P27HvTqJgzgO7Jm8Ytsjt5hwR+yuI9
 tqOokT1TGAJ3w==
X-Nifty-SrcIP: [110.4.221.123]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pipe: Handle STATUS_PENDING even for nonblocking mode.
Date: Tue, 16 Nov 2021 12:18:47 +0900
Message-Id: <20211116031848.247-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Tue, 16 Nov 2021 03:19:44 -0000

- NtReadFile() and NtWriteFile() seems to return STATUS_PENDING
  occasionally even in nonblocking mode. This patch adds handling
  for STATUS_PENDING in nonblocking mode.

Addresses:
  https://cygwin.com/pipermail/cygwin/2021-November/249910.html
---
 winsup/cygwin/fhandler_pipe.cc | 10 ++++++----
 winsup/cygwin/release/3.3.3    |  5 +++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler_pipe.cc b/winsup/cygwin/fhandler_pipe.cc
index 1ebf4de10..f70ff56fe 100644
--- a/winsup/cygwin/fhandler_pipe.cc
+++ b/winsup/cygwin/fhandler_pipe.cc
@@ -336,9 +336,10 @@ fhandler_pipe::raw_read (void *ptr, size_t& len)
 	break;
       status = NtReadFile (get_handle (), evt, NULL, NULL, &io, ptr,
 			   len1, NULL, NULL);
-      if (evt && status == STATUS_PENDING)
+      if (status == STATUS_PENDING)
 	{
-	  waitret = cygwait (evt, INFINITE, cw_cancel | cw_sig);
+	  HANDLE w = evt ?: get_handle ();
+	  waitret = cygwait (w, INFINITE, cw_cancel | cw_sig);
 	  /* If io.Status is STATUS_CANCELLED after CancelIo, IO has actually
 	     been cancelled and io.Information contains the number of bytes
 	     processed so far.
@@ -507,10 +508,11 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
 	    break;
 	  len1 >>= 1;
 	}
-      if (evt && status == STATUS_PENDING)
+      if (status == STATUS_PENDING)
 	{
+	  HANDLE w = evt ?: get_handle ();
 	  while (WAIT_TIMEOUT ==
-		 (waitret = cygwait (evt, (DWORD) 0, cw_cancel | cw_sig)))
+		 (waitret = cygwait (w, (DWORD) 0, cw_cancel | cw_sig)))
 	    {
 	      if (reader_closed ())
 		{
diff --git a/winsup/cygwin/release/3.3.3 b/winsup/cygwin/release/3.3.3
index 1eb25e2fc..49c1bcdc3 100644
--- a/winsup/cygwin/release/3.3.3
+++ b/winsup/cygwin/release/3.3.3
@@ -16,3 +16,8 @@ Bug Fixes
 - Fix long-standing problem that new files don't get created with the
   FILE_ATTRIBUTE_ARCHIVE DOS attribute set.
   Addresses: https://cygwin.com/pipermail/cygwin/2021-November/249909.html
+
+- Fix issue that pipe read()/write() occationally returns a garnage
+  length when NtReadFile/NtWriteFile returns STATUS_PENDING in non-
+  blocking mode.
+  Addresses: https://cygwin.com/pipermail/cygwin/2021-November/249910.html
-- 
2.33.0

