Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id 452ED3858423
 for <cygwin-patches@cygwin.com>; Mon, 25 Oct 2021 09:25:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 452ED3858423
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 19P9PrGs038174;
 Mon, 25 Oct 2021 02:25:53 -0700 (PDT) (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpd2Mxe7Z; Mon Oct 25 02:25:51 2021
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2] Cygwin: Make native clipboard layout same for 32- and
 64-bit
Date: Mon, 25 Oct 2021 02:25:40 -0700
Message-Id: <20211025092540.4819-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Mon, 25 Oct 2021 09:25:58 -0000

This patch unifies the layout of the clipboard descriptor cygcb_t for
32- and 64-bit Cygwin.  It allows correct copy/paste between the two
environments without corruption of user's copied data and without access
violations due to interpreting that data as a size field.

The definitions of CYGWIN_NATIVE and cygcb_t are moved to a new include
file, sys/clipboard.h.  The include file is used by fhandler_clipboard.cc
as well as getclip.c and putclip.c in the Cygwin cygutils package.

When copy/pasting between 32- and 64-bit Cygwin environments, both must
be running version 3.3.0 or later for successful operation.

---
 winsup/cygwin/fhandler_clipboard.cc   | 42 +++++++++++++----------
 winsup/cygwin/include/sys/clipboard.h | 49 +++++++++++++++++++++++++++
 winsup/cygwin/release/3.3.0           |  4 +++
 3 files changed, 78 insertions(+), 17 deletions(-)
 create mode 100644 winsup/cygwin/include/sys/clipboard.h

diff --git a/winsup/cygwin/fhandler_clipboard.cc b/winsup/cygwin/fhandler_clipboard.cc
index ccdb295f3..7adb50991 100644
--- a/winsup/cygwin/fhandler_clipboard.cc
+++ b/winsup/cygwin/fhandler_clipboard.cc
@@ -17,6 +17,7 @@ details. */
 #include "dtable.h"
 #include "cygheap.h"
 #include "child_info.h"
+#include "sys/clipboard.h"
 
 /*
  * Robert Collins:
@@ -24,15 +25,6 @@ details. */
  * changed? How does /dev/clipboard operate under (say) linux?
  */
 
-static const WCHAR *CYGWIN_NATIVE = L"CYGWIN_NATIVE_CLIPBOARD";
-
-typedef struct
-{
-  timestruc_t	timestamp;
-  size_t	len;
-  char		data[1];
-} cygcb_t;
-
 fhandler_dev_clipboard::fhandler_dev_clipboard ()
   : fhandler_base (), pos (0), membuffer (NULL), msize (0)
 {
@@ -74,9 +66,17 @@ fhandler_dev_clipboard::set_clipboard (const void *buf, size_t len)
 	}
       clipbuf = (cygcb_t *) GlobalLock (hmem);
 
-      clock_gettime (CLOCK_REALTIME, &clipbuf->timestamp);
-      clipbuf->len = len;
-      memcpy (clipbuf->data, buf, len);
+      clock_gettime (CLOCK_REALTIME, &clipbuf->ts);
+#ifdef __x86_64__
+      /* ts overlays cb_sec and cb_nsec such that no conversion is needed */
+#elif __i386__
+      /* Expand 32-bit timespec layout to 64-bit layout.
+         NOTE: Steps must be done in this order to avoid data loss. */
+      clipbuf->cb_nsec = clipbuf->ts.tv_nsec;
+      clipbuf->cb_sec  = clipbuf->ts.tv_sec;
+#endif
+      clipbuf->cb_size = len;
+      memcpy (&clipbuf[1], buf, len); // append user-supplied data
 
       GlobalUnlock (hmem);
       EmptyClipboard ();
@@ -179,8 +179,16 @@ fhandler_dev_clipboard::fstat (struct stat *buf)
 	  && (hglb = GetClipboardData (format))
 	  && (clipbuf = (cygcb_t *) GlobalLock (hglb)))
 	{
-	  buf->st_atim = buf->st_mtim = clipbuf->timestamp;
-	  buf->st_size = clipbuf->len;
+#ifdef __x86_64__
+	  /* ts overlays cb_sec and cb_nsec such that no conversion is needed */
+#elif __i386__
+	  /* Compress 64-bit timespec layout to 32-bit layout.
+	     NOTE: Steps must be done in this order to avoid data loss. */
+	  clipbuf->ts.tv_sec  = clipbuf->cb_sec;
+	  clipbuf->ts.tv_nsec = clipbuf->cb_nsec;
+#endif
+	  buf->st_atim = buf->st_mtim = clipbuf->ts;
+	  buf->st_size = clipbuf->cb_size;
 	  GlobalUnlock (hglb);
 	}
       CloseClipboard ();
@@ -218,10 +226,10 @@ fhandler_dev_clipboard::read (void *ptr, size_t& len)
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
diff --git a/winsup/cygwin/include/sys/clipboard.h b/winsup/cygwin/include/sys/clipboard.h
new file mode 100644
index 000000000..4c00c8ea1
--- /dev/null
+++ b/winsup/cygwin/include/sys/clipboard.h
@@ -0,0 +1,49 @@
+/* sys/clipboard.h
+
+This file is part of Cygwin.
+
+This software is a copyrighted work licensed under the terms of the
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+details. */
+
+#ifndef _SYS_CLIPBOARD_H_
+#define _SYS_CLIPBOARD_H_
+
+/*
+ * These definitions are used in fhandler_clipboard.cc
+ * as well as in the Cygwin cygutils package, specifically
+ * getclip.c and putclip.c.
+ */
+
+static const WCHAR *CYGWIN_NATIVE = L"CYGWIN_NATIVE_CLIPBOARD";
+
+/*
+ * The following layout of cygcb_t is new with Cygwin 3.3.0.  It aids in the
+ * transfer of clipboard contents between 32- and 64-bit Cygwin environments.
+ */
+typedef struct
+{
+  union
+  {
+    /*
+     * Note that ts below overlays the struct following it.  On 32-bit Cygwin
+     * timespec values have to be converted to|from cygcb_t layout.  On 64-bit
+     * Cygwin timespec values perfectly conform to the struct following, so
+     * no conversion is needed.
+     *
+     * We avoid directly using 'struct timespec' or 'size_t' here because they
+     * are different sizes on different architectures.  When copy/pasting
+     * between 32- and 64-bit Cygwin, the pasted data could appear corrupted,
+     * or partially interpreted as a size which can cause an access violation.
+     */
+    struct timespec ts;  // 8 bytes on 32-bit Cygwin, 16 bytes on 64-bit Cygwin
+    struct
+    {
+      uint64_t  cb_sec;  // 8 bytes everywhere
+      uint64_t  cb_nsec; // 8 bytes everywhere
+    };
+  };
+  uint64_t      cb_size; // 8 bytes everywhere
+} cygcb_t;
+
+#endif
diff --git a/winsup/cygwin/release/3.3.0 b/winsup/cygwin/release/3.3.0
index 2df81a4ae..895c27397 100644
--- a/winsup/cygwin/release/3.3.0
+++ b/winsup/cygwin/release/3.3.0
@@ -74,3 +74,7 @@ Bug Fixes
 
 - Fix pty master closing error regarding attach_mutex.
   Addresses: https://cygwin.com/pipermail/cygwin-developers/2021-October/012418.html
+
+- Fix access violation that can sometimes occur when copy/pasting between
+  32-bit and 64-bit Cygwin environments.  Align clipboard descriptor layouts.
+  Addresses: https://cygwin.com/pipermail/cygwin-patches/2021q4/011517.html
-- 
2.33.0

