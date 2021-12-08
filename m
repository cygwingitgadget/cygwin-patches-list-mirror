Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id CB3FC3858D3C
 for <cygwin-patches@cygwin.com>; Wed,  8 Dec 2021 12:27:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org CB3FC3858D3C
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 1B8CQs67005547;
 Wed, 8 Dec 2021 21:26:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 1B8CQs67005547
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1638966419;
 bh=lcurY3MBcqON37TCGVRwaB3bWnvsgZmHZhltp0v7ruo=;
 h=From:To:Cc:Subject:Date:From;
 b=tuJFMX8q7e7L9P5MPw+mI6J4flkeKy4S85qLwGm3oMMOYmcBusm/HZbF1HMA6flP+
 ePz56XoEcim6T7/ktXRSH4nPTLXq9GmZ5bIQ/Jmh6jcjKqXToWhC0ExqO+ZLuFKUr1
 gt+MkIh+E3MnSEu7qdptdSh6h2RP33FtjGbW4WPqMnKRFByyoUHBC3g0NcJsV25phD
 KJz2KAP+SoBeb7tp7WTJtQ/zp8pHsP5ytmf+0myQx+tDM7BF8iM2VvQwbdobx/SA/t
 6HI3TzwNhBtL1EC8DREBQtGleSE+/KLOOSqAOyfgSoshyOq8WoPlU6E0MNPJb9/v5w
 /ZbykyPd4pJZw==
X-Nifty-SrcIP: [110.4.221.123]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: clipboard: Make intent of the code clearer.
Date: Wed,  8 Dec 2021 21:26:45 +0900
Message-Id: <20211208122645.1278-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.34.1
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
X-List-Received-Date: Wed, 08 Dec 2021 12:27:26 -0000

---
 winsup/cygwin/fhandler_clipboard.cc   | 4 ++--
 winsup/cygwin/include/sys/clipboard.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_clipboard.cc b/winsup/cygwin/fhandler_clipboard.cc
index 05f54ffb3..14820701c 100644
--- a/winsup/cygwin/fhandler_clipboard.cc
+++ b/winsup/cygwin/fhandler_clipboard.cc
@@ -76,7 +76,7 @@ fhandler_dev_clipboard::set_clipboard (const void *buf, size_t len)
       clipbuf->cb_sec  = clipbuf->ts.tv_sec;
 #endif
       clipbuf->cb_size = len;
-      memcpy (&clipbuf[1], buf, len); // append user-supplied data
+      memcpy (clipbuf->cb_data, buf, len); // append user-supplied data
 
       GlobalUnlock (hmem);
       EmptyClipboard ();
@@ -229,7 +229,7 @@ fhandler_dev_clipboard::read (void *ptr, size_t& len)
       if (pos < (off_t) clipbuf->cb_size)
 	{
 	  ret = (len > (clipbuf->cb_size - pos)) ? clipbuf->cb_size - pos : len;
-	  memcpy (ptr, (char *) (clipbuf + 1) + pos, ret);
+	  memcpy (ptr, clipbuf->cb_data + pos, ret);
 	  pos += ret;
 	}
     }
diff --git a/winsup/cygwin/include/sys/clipboard.h b/winsup/cygwin/include/sys/clipboard.h
index 4c00c8ea1..932fe98d9 100644
--- a/winsup/cygwin/include/sys/clipboard.h
+++ b/winsup/cygwin/include/sys/clipboard.h
@@ -44,6 +44,7 @@ typedef struct
     };
   };
   uint64_t      cb_size; // 8 bytes everywhere
+  char          cb_data[];
 } cygcb_t;
 
 #endif
-- 
2.34.1

