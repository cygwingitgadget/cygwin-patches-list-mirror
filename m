Return-Path: <SRS0=7rK+=FC=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 6CD3C4BA5436
	for <cygwin-patches@cygwin.com>; Wed,  8 Jul 2026 08:04:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6CD3C4BA5436
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6CD3C4BA5436
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1783497843; cv=none;
	b=OrxIPpzMsrcXyX7zjwUSdLcYf5tpi+GrwAG68JZQT5HHhfPSHwT15m6cbPDUGJxr/VfYFP9Z6z5jGiOyf67DAidgYdWHSlhJXJ5kf/obw/ASY3pR1pQh/Wqe4SfciCj0MEQKmNOfCERxlHl8EnD60WOe20Io8FpfiZkoi4DpUB4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783497843; c=relaxed/simple;
	bh=9WVWdge4g7azztPPbcEFrgytf8+LkR6g8uZ01SlgFXI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=D65l8zyZeoo5eRmUYU1Tivz6OTORavx1rjcp9n7QDeaMOTA2wz0AukMQxfSGrIe2GO9jV/PJYcQSalYj9Tq1/3/bPGNnEKr27t77YOhg6Bbuawlce1eZBQAebhqNibnaVb6sdawIK4oTWQraUl1Lmsg2iJQzfxO4kFlxsECE2JY=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6CD3C4BA5436
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 6688IoNf095473;
	Wed, 8 Jul 2026 01:18:50 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "zotac"
 via SMTP by m0.truegem.net, id smtpd2mfDDu; Wed Jul  8 01:18:43 2026
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>,
        Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH v2] Cygwin: Fix error return for madvise()
Date: Wed,  8 Jul 2026 01:03:05 -0700
Message-ID: <20260708080349.570-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <https://cygwin.com/pipermail/cygwin-patches/2026q3/015163.html>
References: <https://cygwin.com/pipermail/cygwin-patches/2026q3/015163.html>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently madvise() and posix_madvise() are wired together as one
function: the latter.  But their error returns should be different.
Make madvise a first-class export in cygwin.din.

v2: Create madvise_worker() and have madvise() and posix_madvise()
    call it, then handling their error returns compliant to POSIX.
    Add a release note for 3.7.0.

Reported-by: Christian Franke <Christian.Franke@t-online.de>
Addresses: https://cygwin.com/pipermail/cygwin/2026-July/259872.html
Signed-off-by: Mark Geisert <mark@maxrnd.com>
Fixes: 61522196c715 (* Merge in cygwin-64bit-branch.)
Reviewed-by: Takashi Yano, Christian Franke

---
 winsup/cygwin/cygwin.din    |  2 +-
 winsup/cygwin/mm/mmap.cc    | 24 ++++++++++++++++++++++--
 winsup/cygwin/release/3.7.0 |  8 ++++++++
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/cygwin.din b/winsup/cygwin/cygwin.din
index 2e53bc819..937eacdaf 100644
--- a/winsup/cygwin/cygwin.din
+++ b/winsup/cygwin/cygwin.din
@@ -951,7 +951,7 @@ lseek SIGFE
 lsetxattr SIGFE
 lstat SIGFE
 lutimes SIGFE
-madvise = posix_madvise SIGFE
+madvise SIGFE
 makecontext NOSIGFE
 mallinfo SIGFE
 malloc SIGFE
diff --git a/winsup/cygwin/mm/mmap.cc b/winsup/cygwin/mm/mmap.cc
index 1416e4ddc..bce819eb0 100644
--- a/winsup/cygwin/mm/mmap.cc
+++ b/winsup/cygwin/mm/mmap.cc
@@ -1422,8 +1422,8 @@ munlock (const void *addr, size_t len)
   return ret;
 }
 
-extern "C" int
-posix_madvise (void *addr, size_t len, int advice)
+static int
+madvise_worker (void *addr, size_t len, int advice)
 {
   int ret = 0;
   /* Check parameters. */
@@ -1514,6 +1514,26 @@ posix_madvise (void *addr, size_t len, int advice)
       break;
     }
 out:
+  return ret;
+}
+
+extern "C" int
+madvise (void *addr, size_t len, int advice)
+{
+  int ret = madvise_worker (addr, len, advice);
+  if (ret > 0)
+    {
+      set_errno (ret);
+      ret = -1;
+    }
+  syscall_printf ("%R = madvise(%p, %lu, %d)", ret, addr, len, advice);
+  return ret;
+}
+
+extern "C" int
+posix_madvise (void *addr, size_t len, int advice)
+{
+  int ret = madvise_worker (addr, len, advice);
   syscall_printf ("%d = posix_madvise(%p, %lu, %d)", ret, addr, len, advice);
   return ret;
 }
diff --git a/winsup/cygwin/release/3.7.0 b/winsup/cygwin/release/3.7.0
index 3fc32433e..3f6a0ecd7 100644
--- a/winsup/cygwin/release/3.7.0
+++ b/winsup/cygwin/release/3.7.0
@@ -25,3 +25,11 @@ What's new:
 - Now, a Cygwin process started from a non‑Cygwin process on a pseudo console
   runs on a pty rather than on the console device originating from the pseudo
   console.
+
+Fixes:
+------
+
+- Error return logic for madvise() is now separated from posix_madvise().
+  If madvise() errors, it returns -1 with errno set. If posix_madvise()
+  errors, it returns an error number without changing errno.
+  Addresses: https://cygwin.com/pipermail/cygwin/2026-July/259872.html
-- 
2.51.0

