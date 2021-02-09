Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id 0BEF23857C48
 for <cygwin-patches@cygwin.com>; Tue,  9 Feb 2021 10:50:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 0BEF23857C48
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=mark@maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 119AoNGq037376;
 Tue, 9 Feb 2021 02:50:23 -0800 (PST) (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpdHiKysx; Tue Feb  9 02:50:16 2021
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: Have tmpfile(3) use O_TMPFILE
Date: Tue,  9 Feb 2021 02:50:00 -0800
Message-Id: <20210209105000.26544-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, SPF_HELO_NONE, SPF_NONE,
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
X-List-Received-Date: Tue, 09 Feb 2021 10:50:25 -0000

Per discussion on cygwin-developers, a Cygwin tmpfile(3) implementation
has been added to syscalls.cc.  This overrides the one supplied by
newlib.  Then the open(2) flag O_TMPFILE was added to the open call that
tmpfile internally makes.
---
 winsup/cygwin/release/3.2.0 |  4 ++++
 winsup/cygwin/syscalls.cc   | 20 ++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/winsup/cygwin/release/3.2.0 b/winsup/cygwin/release/3.2.0
index f748a9bc8..d02d16863 100644
--- a/winsup/cygwin/release/3.2.0
+++ b/winsup/cygwin/release/3.2.0
@@ -19,6 +19,10 @@ What changed:
 
 - A few FAQ updates.
 
+- Have tmpfile(3) make use of Win32 FILE_ATTRIBUTE_TEMPORARY via open(2)
+  flag O_TMPFILE.
+  Addresses: https://cygwin.com/pipermail/cygwin/2021-January/247304.html
+
 
 Bug Fixes
 ---------
diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 52a020f07..b79c1c7cd 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -5225,3 +5225,23 @@ pipe2 (int filedes[2], int mode)
   syscall_printf ("%R = pipe2([%d, %d], %y)", res, read, write, mode);
   return res;
 }
+
+extern "C" FILE *
+tmpfile (void)
+{
+  char *dir = getenv ("TMPDIR");
+  if (!dir)
+    dir = P_tmpdir;
+  int fd = open (dir, O_RDWR | O_CREAT | O_BINARY | O_TMPFILE,
+                 S_IRUSR | S_IWUSR);
+  if (fd < 0)
+    return NULL;
+  FILE *fp = fdopen (fd, "wb+");
+  int e = errno;
+  if (!fp)
+    close (fd); // ..will remove file
+  set_errno (e);
+  return fp;
+}
+
+EXPORT_ALIAS (tmpfile, tmpfile64);
-- 
2.30.0

