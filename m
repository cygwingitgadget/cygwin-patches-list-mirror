Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
 by sourceware.org (Postfix) with ESMTPS id 26669385843E
 for <cygwin-patches@cygwin.com>; Fri,  8 Jul 2022 03:42:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 26669385843E
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak044095.dynamic.ppp.asahi-net.or.jp
 [119.150.44.95]) (authenticated)
 by conuserg-12.nifty.com with ESMTP id 2683g0sD008161;
 Fri, 8 Jul 2022 12:42:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 2683g0sD008161
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1657251726;
 bh=l2HZsdSO63LI/b2mWjmNqsnygho85sp0ivQU2CC+V64=;
 h=From:To:Cc:Subject:Date:From;
 b=crz0bL0+Gz5LE+b1giD5aRXYDlnLs7e1Hq70bfHAZfPFQXRgyuIZlmVxoR7UtTaxW
 HeXrpxfixFHRkdNUgG1t4wf4XycikW3gak5gafDkXusAdBum2KJ0KR5YoE5Ok3Ipb7
 vSOd9ztYBuUdYtVfeJW2w3VHqk3ui7QPHn2OFnU80Zm8P0zfCVf3b2LrJnL9G1z3aT
 dU3aLzBFjQMvH8O1cNDKmk+J1Fg/3kJUM29VDpgZbREQI3Jlka65ZhAVUFMz0CQI+p
 Dhe7B7nqXixavR2xFX+jxdbe7URqHU5LRiN9oSwLvoSpJbxXCkWcSEvKBMPbBZEebK
 IOnqDk8wdPdeg==
X-Nifty-SrcIP: [119.150.44.95]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: clipboard: Add workaround for setting clipboard
 failure.
Date: Fri,  8 Jul 2022 12:41:51 +0900
Message-Id: <20220708034151.1780-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Fri, 08 Jul 2022 03:42:24 -0000

- OpenClipboard() just after CloseClipboard() sometimes fails. Due
  to this, /dev/clipboard sometimes fails to set CF_UNICODETEXT
  data. This patch add a workaround for this issue.
---
 winsup/cygwin/fhandler_clipboard.cc | 47 +++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/winsup/cygwin/fhandler_clipboard.cc b/winsup/cygwin/fhandler_clipboard.cc
index 4886968b2..fe3545bf5 100644
--- a/winsup/cygwin/fhandler_clipboard.cc
+++ b/winsup/cygwin/fhandler_clipboard.cc
@@ -20,6 +20,27 @@ details. */
 #include <sys/clipboard.h>
 #include <unistd.h>
 
+/* Opening clipboard immediately after CloseClipboard()
+   sometimes fails. Therefore use retry-loop. */
+static inline bool
+open_clipboard ()
+{
+  const int max_retry = 10;
+  for (int i = 0; i < max_retry; i++)
+    {
+      if (OpenClipboard (NULL))
+	return true;
+      Sleep (1);
+    }
+  return false;
+}
+
+static inline bool
+close_clipboard ()
+{
+  return CloseClipboard ();
+}
+
 /*
  * Robert Collins:
  * FIXME: should we use GetClipboardSequenceNumber to tell if the clipboard has
@@ -30,9 +51,9 @@ fhandler_dev_clipboard::fhandler_dev_clipboard ()
   : fhandler_base (), pos (0), membuffer (NULL), msize (0)
 {
   /* FIXME: check for errors and loop until we can open the clipboard */
-  OpenClipboard (NULL);
+  open_clipboard ();
   cygnativeformat = RegisterClipboardFormatW (CYGWIN_NATIVE);
-  CloseClipboard ();
+  close_clipboard ();
 }
 
 /*
@@ -54,7 +75,7 @@ fhandler_dev_clipboard::set_clipboard (const void *buf, size_t len)
 {
   HGLOBAL hmem;
   /* Native CYGWIN format */
-  if (OpenClipboard (NULL))
+  if (open_clipboard ())
     {
       cygcb_t *clipbuf;
 
@@ -62,7 +83,7 @@ fhandler_dev_clipboard::set_clipboard (const void *buf, size_t len)
       if (!hmem)
 	{
 	  __seterrno ();
-	  CloseClipboard ();
+	  close_clipboard ();
 	  return -1;
 	}
       clipbuf = (cygcb_t *) GlobalLock (hmem);
@@ -74,7 +95,7 @@ fhandler_dev_clipboard::set_clipboard (const void *buf, size_t len)
       GlobalUnlock (hmem);
       EmptyClipboard ();
       HANDLE ret = SetClipboardData (cygnativeformat, hmem);
-      CloseClipboard ();
+      close_clipboard ();
       /* According to MSDN, hmem must not be free'd after transferring the
 	 data to the clipboard via SetClipboardData. */
       /* GlobalFree (hmem); */
@@ -92,7 +113,7 @@ fhandler_dev_clipboard::set_clipboard (const void *buf, size_t len)
       set_errno (EILSEQ);
       return -1;
     }
-  if (OpenClipboard (NULL))
+  if (open_clipboard ())
     {
       PWCHAR clipbuf;
 
@@ -100,14 +121,14 @@ fhandler_dev_clipboard::set_clipboard (const void *buf, size_t len)
       if (!hmem)
 	{
 	  __seterrno ();
-	  CloseClipboard ();
+	  close_clipboard ();
 	  return -1;
 	}
       clipbuf = (PWCHAR) GlobalLock (hmem);
       sys_mbstowcs (clipbuf, len + 1, (const char *) buf);
       GlobalUnlock (hmem);
       HANDLE ret = SetClipboardData (CF_UNICODETEXT, hmem);
-      CloseClipboard ();
+      close_clipboard ();
       /* According to MSDN, hmem must not be free'd after transferring the
 	 data to the clipboard via SetClipboardData. */
       /* GlobalFree (hmem); */
@@ -161,7 +182,7 @@ fhandler_dev_clipboard::fstat (struct stat *buf)
   buf->st_ctim.tv_nsec = 0L;
   buf->st_birthtim = buf->st_atim = buf->st_mtim = buf->st_ctim;
 
-  if (OpenClipboard (NULL))
+  if (open_clipboard ())
     {
       UINT formatlist[1] = { cygnativeformat };
       int format;
@@ -176,7 +197,7 @@ fhandler_dev_clipboard::fstat (struct stat *buf)
 	  buf->st_size = clipbuf->cb_size;
 	  GlobalUnlock (hglb);
 	}
-      CloseClipboard ();
+      close_clipboard ();
     }
 
   return 0;
@@ -192,7 +213,7 @@ fhandler_dev_clipboard::read (void *ptr, size_t& len)
   LPVOID cb_data;
   int rach;
 
-  if (!OpenClipboard (NULL))
+  if (!open_clipboard ())
     {
       len = 0;
       return;
@@ -203,7 +224,7 @@ fhandler_dev_clipboard::read (void *ptr, size_t& len)
       || !(hglb = GetClipboardData (format))
       || !(cb_data = GlobalLock (hglb)))
     {
-      CloseClipboard ();
+      close_clipboard ();
       len = 0;
       return;
     }
@@ -290,7 +311,7 @@ fhandler_dev_clipboard::read (void *ptr, size_t& len)
 	}
     }
   GlobalUnlock (hglb);
-  CloseClipboard ();
+  close_clipboard ();
   len = ret;
 }
 
-- 
2.36.1

