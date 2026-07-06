Return-Path: <SRS0=UO30=FA=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id C77DE4BA2E09
	for <cygwin-patches@cygwin.com>; Mon,  6 Jul 2026 23:48:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C77DE4BA2E09
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C77DE4BA2E09
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1783381683; cv=none;
	b=XNzLCLi8JPVAiBzShPX4pMak7U1xgausbWx/Ow+bSWLieP/C9ZSqTK86INXh3zE/35F5F5osulyyKqaPWOUcMfBGHkoxapTT+XnYG1bERPI2NRBuHxkGK8LWikiHFUKOJ3AFecRNekwzw+RLCmjrOw1FIBP8bm4rkaUq5BpFpY4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783381683; c=relaxed/simple;
	bh=jtpfh41bkAt1RpjvWotve8W4mf0pkYL7uK/lnjwoz3I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lY+BForD/F9LTkzSsdyId87haaX2GaE5x7JGTQonZ2S2n/C6JNJXqB1PL4E3JbbB94apk1L7X7fFW0G+4hh4worZrUBsIDHkGRsRgxS1bfnDZHbcdtvcYpA0Bns0Idv4GmCiC1NFA28mV/n80YQTCNrIMWeJrWhnwdZlX2OjeOg=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C77DE4BA2E09
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 66702qwB030980;
	Mon, 6 Jul 2026 17:02:52 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "zotac"
 via SMTP by m0.truegem.net, id smtpdO1nsA8; Mon Jul  6 17:02:49 2026
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>,
        Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH] Cygwin: Fix error return for madvise()
Date: Mon,  6 Jul 2026 16:47:43 -0700
Message-ID: <20260706234758.89659-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently madvise() and posix_madvise() are wired together as one
function: the latter.  But their error returns should be different.
Make madvise a first-class export in cygwin.din; code a new madvise()
that calls posix_madvise() and massages any error return.

Reported-by: Christian Franke <Christian.Franke@t-online.de>
Addresses: https://cygwin.com/pipermail/cygwin/2026-July/259872.html
Signed-off-by: Mark Geisert <mark@maxrnd.com>
Fixes: 61522196c715 (* Merge in cygwin-64bit-branch.)

---
 winsup/cygwin/cygwin.din               |  2 +-
 winsup/cygwin/include/cygwin/version.h |  3 ++-
 winsup/cygwin/mm/mmap.cc               | 12 ++++++++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

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
diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/include/cygwin/version.h
index 71ac5282b..fc838e23e 100644
--- a/winsup/cygwin/include/cygwin/version.h
+++ b/winsup/cygwin/include/cygwin/version.h
@@ -502,12 +502,13 @@ details. */
   360: Add RLIMIT_NPROC.
   361: Export _Fork.
   362: Export C23 stdbit functions.
+  363: Export madvise separately from posix_madvise.
 
   Note that we forgot to bump the api for ualarm, strtoll, strtoull,
   sigaltstack, sethostname. */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 362
+#define CYGWIN_VERSION_API_MINOR 363
 
 /* There is also a compatibity version number associated with the shared memory
    regions.  It is incremented when incompatible changes are made to the shared
diff --git a/winsup/cygwin/mm/mmap.cc b/winsup/cygwin/mm/mmap.cc
index 1416e4ddc..93db9e474 100644
--- a/winsup/cygwin/mm/mmap.cc
+++ b/winsup/cygwin/mm/mmap.cc
@@ -1422,6 +1422,18 @@ munlock (const void *addr, size_t len)
   return ret;
 }
 
+extern "C" int
+madvise (void *addr, size_t len, int advice)
+{
+  int ret = posix_madvise (addr, len, advice);
+  if (ret > 0)
+    {
+      set_errno (ret);
+      ret = -1;
+    }
+  return ret;
+}
+
 extern "C" int
 posix_madvise (void *addr, size_t len, int advice)
 {
-- 
2.51.0

