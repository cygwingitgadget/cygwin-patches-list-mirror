Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 by sourceware.org (Postfix) with ESMTPS id 54FB53982435
 for <cygwin-patches@cygwin.com>; Wed, 23 Jun 2021 08:42:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 54FB53982435
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (y084232.dynamic.ppp.asahi-net.or.jp
 [118.243.84.232]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 15N8gQHq000596;
 Wed, 23 Jun 2021 17:42:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 15N8gQHq000596
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1624437752;
 bh=Vjjmpwr2jl4HbVCDIMyLEmBLaauQZrgL7unUBf7shvw=;
 h=From:To:Cc:Subject:Date:From;
 b=WjNVqL3ih4Ar2rgXDSOhhzPT8fqP/BrnY19vV+NtXCm1uCrsoIeH5Etx7+vNGXzOi
 mJFoZiWqoH5aFHAz/6f4IlCgan821QT4Jg0WIQ97rxCpbbE4hs76Lq5gUc3PZiGxH/
 fCzK6hO7paIq+DYrqaSXgeROKeV1wDoAtSRRdwSMgUiyV6evG+/Q7kbiLmazmyt4fq
 3VyZB/n57X5legdDfy3jrL/ItSFWudJwIyhTMQg2V0DLyI6KYcZ3+jnI6w9lwjGWDz
 Z4l6w2SSOJ8cz5P8TFq2/ACOufcrE3mdegV/jMVf6Yiqu89t8Kg6Z61iRaUB/eDbFW
 Fo0SZ6VkrVjdg==
X-Nifty-SrcIP: [118.243.84.232]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Fix garbled input for non-ASCII chars.
Date: Wed, 23 Jun 2021 17:42:16 +0900
Message-Id: <20210623084216.777-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Wed, 23 Jun 2021 08:42:48 -0000

- After the commit ff4440fc, non-ASCII input may sometimes be garbled.
  This patch fixes the issue.

  Addresses: https://cygwin.com/pipermail/cygwin/2021-June/248775.html
---
 winsup/cygwin/fhandler_console.cc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index b3eae6a5a..76689c674 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -213,7 +213,7 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
       switch (cygwait (p->input_handle, (DWORD) 0))
 	{
 	case WAIT_OBJECT_0:
-	  ReadConsoleInputA (p->input_handle,
+	  ReadConsoleInputW (p->input_handle,
 			     input_rec, INREC_SIZE, &total_read);
 	  break;
 	case WAIT_TIMEOUT:
@@ -326,7 +326,7 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 	}
       if (total_read)
 	/* Write back input records other than interrupt. */
-	WriteConsoleInput (p->input_handle, input_rec, total_read, &n);
+	WriteConsoleInputW (p->input_handle, input_rec, total_read, &n);
 skip_writeback:
       ReleaseMutex (p->input_mutex);
       cygwait (40);
-- 
2.32.0

