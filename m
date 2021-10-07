Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id DF02A3858C39
 for <cygwin-patches@cygwin.com>; Thu,  7 Oct 2021 05:22:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org DF02A3858C39
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 1975MtVo076206;
 Wed, 6 Oct 2021 22:22:55 -0700 (PDT) (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpdOewASi; Wed Oct  6 22:22:48 2021
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: Make native clipboard layout same for 32- and 64-bit
Date: Wed,  6 Oct 2021 22:22:37 -0700
Message-Id: <20211007052237.7139-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Thu, 07 Oct 2021 05:22:59 -0000

This allows correct copy and pasting between the two Cygwin flavors.

What's done is to overlay the differing timespec formats via a union
within the control structure cygcb_t.  Then conversion between the two
formats is done on the 32-bit side only.

The cygutils package has two programs, putclip and getclip, that also
depend on the layout of the cygcb_t.  At present they have duplicate
defs of struct cygcb_t defined here as no Cygwin header provides it.

---
 winsup/cygwin/fhandler_clipboard.cc | 39 +++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/winsup/cygwin/fhandler_clipboard.cc b/winsup/cygwin/fhandler_clipboard.cc
index ccdb295f3..649e57072 100644
--- a/winsup/cygwin/fhandler_clipboard.cc
+++ b/winsup/cygwin/fhandler_clipboard.cc
@@ -28,9 +28,16 @@ static const WCHAR *CYGWIN_NATIVE = L"CYGWIN_NATIVE_CLIPBOARD";
 
 typedef struct
 {
-  timestruc_t	timestamp;
-  size_t	len;
-  char		data[1];
+  union
+  {
+    struct timespec ts; // 8 bytes on 32-bit Cygwin, 16 bytes on 64-bit Cygwin
+    struct
+    {
+      uint64_t	cb_sec;
+      uint64_t	cb_nsec;
+    };
+  };
+  uint64_t	cb_size;
 } cygcb_t;
 
 fhandler_dev_clipboard::fhandler_dev_clipboard ()
@@ -74,9 +81,14 @@ fhandler_dev_clipboard::set_clipboard (const void *buf, size_t len)
 	}
       clipbuf = (cygcb_t *) GlobalLock (hmem);
 
-      clock_gettime (CLOCK_REALTIME, &clipbuf->timestamp);
-      clipbuf->len = len;
-      memcpy (clipbuf->data, buf, len);
+      clock_gettime (CLOCK_REALTIME, &clipbuf->ts);
+#ifndef __x86_64__
+      // expand 32-bit timespec layout to 64-bit layout
+      clipbuf->cb_nsec = clipbuf->ts.tv_nsec;
+      clipbuf->cb_sec = clipbuf->ts.tv_sec;
+#endif
+      clipbuf->cb_size = len;
+      memcpy (&clipbuf[1], buf, len); // append data
 
       GlobalUnlock (hmem);
       EmptyClipboard ();
@@ -179,8 +191,13 @@ fhandler_dev_clipboard::fstat (struct stat *buf)
 	  && (hglb = GetClipboardData (format))
 	  && (clipbuf = (cygcb_t *) GlobalLock (hglb)))
 	{
-	  buf->st_atim = buf->st_mtim = clipbuf->timestamp;
-	  buf->st_size = clipbuf->len;
+#ifndef __x86_64__
+	  // compress 64-bit timespec layout to 32-bit layout
+	  clipbuf->ts.tv_sec = clipbuf->cb_sec;
+	  clipbuf->ts.tv_nsec = clipbuf->cb_nsec;
+#endif
+	  buf->st_atim = buf->st_mtim = clipbuf->ts;
+	  buf->st_size = clipbuf->cb_size;
 	  GlobalUnlock (hglb);
 	}
       CloseClipboard ();
@@ -218,10 +235,10 @@ fhandler_dev_clipboard::read (void *ptr, size_t& len)
     {
       cygcb_t *clipbuf = (cygcb_t *) cb_data;
 
-      if (pos < (off_t) clipbuf->len)
+      if (pos < (off_t) clipbuf->cb_size)
 	{
-	  ret = ((len > (clipbuf->len - pos)) ? (clipbuf->len - pos) : len);
-	  memcpy (ptr, clipbuf->data + pos , ret);
+	  ret = (len > (clipbuf->cb_size - pos)) ? clipbuf->cb_size - pos : len;
+	  memcpy (ptr, &clipbuf[1] + pos , ret);
 	  pos += ret;
 	}
     }
-- 
2.33.0

