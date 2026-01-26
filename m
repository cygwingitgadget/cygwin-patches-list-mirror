Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id C536F4B920ED; Mon, 26 Jan 2026 10:26:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C536F4B920ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1769423214;
	bh=vhSSO4ok7H7ia27zCCxkZGyAD43wl8blnCpnZWcsKe8=;
	h=From:To:Subject:Date:From;
	b=jhfh3D0DGYXFTwLeBqA9RpbsKTGRpuq5WjpKc3NZvAr1bne6V2mW5QtbIPhqyb95/
	 BWyQKiI/C5Y3u+kgAXzpTscgq4sEoyP1HIAQosTuKLBrbqhDdvoOz2fg6OC4sJy6LZ
	 ecKh3nnps2h4P9k8nJuO8mN4pEnXBjnwA5ERx0sw=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id DE68BA81D16; Mon, 26 Jan 2026 11:26:52 +0100 (CET)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: child_info: remove filler bytes
Date: Mon, 26 Jan 2026 11:26:52 +0100
Message-ID: <20260126102652.382670-1-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

The filler bytes in child_info were only necessary for Vista to
workaround a bug in WOW64. We just neglected to remove them so far.

Fixes: a4efb2a6698f ("Cygwin: remove support for Vista entirely")
Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/local_includes/child_info.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/winsup/cygwin/local_includes/child_info.h b/winsup/cygwin/local_includes/child_info.h
index 25d99fa7de36..dc0b75dee694 100644
--- a/winsup/cygwin/local_includes/child_info.h
+++ b/winsup/cygwin/local_includes/child_info.h
@@ -33,7 +33,7 @@ enum child_status
 #define EXEC_MAGIC_SIZE sizeof(child_info)
 
 /* Change this value if you get a message indicating that it is out-of-sync. */
-#define CURR_CHILD_INFO_MAGIC 0x77f25a01U
+#define CURR_CHILD_INFO_MAGIC 0x3c5c4429U
 
 #include "pinfo.h"
 struct cchildren
@@ -111,7 +111,6 @@ public:
   void *stackbase;	// StackBase of parent thread
   size_t guardsize;     // size of POSIX guard region or (size_t) -1 if
 			// user stack
-  char filler[4];
   child_info_fork ();
   void handle_fork ();
   bool abort (const char *fmt = NULL, ...);
@@ -145,7 +144,6 @@ public:
   cygheap_exec_info *moreinfo;
   int __stdin;
   int __stdout;
-  char filler[4];
 
   void cleanup ();
   child_info_spawn () {};
-- 
2.52.0

