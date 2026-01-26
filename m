Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id B964A4BC8955; Mon, 26 Jan 2026 10:27:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B964A4BC8955
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1769423233;
	bh=+3fhsbODrCWskdxchj8Oy0fehfFl74BwM5nzcfV/s+M=;
	h=From:To:Subject:Date:From;
	b=Z12Wg/qLk8FrfgdsIJDkuyr/iT1zd0qPPaOvGimjhxYGLdFH6+aobxVr7kzku2+Iy
	 pYa3Zd5OLxS3XZOW5I43tsEkp4V6Mr1IcHixDUlK7T/P7E8aBPMyOX+HYzKUlLDvrf
	 wHvx/Mqk0MaYEBrtfDnrXkzIn2NDPvarOftoWSd8=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D6BC0A81CEE; Mon, 26 Jan 2026 11:27:11 +0100 (CET)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: spawn: drop CREATE_SEPARATE_WOW_VDM process flag
Date: Mon, 26 Jan 2026 11:27:11 +0100
Message-ID: <20260126102711.382814-1-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

This is outdated and should have been removed when we dropped
32 bit support.

Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/spawn.cc | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 7d993d0810eb..04e4a4028b8a 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -401,7 +401,11 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
       c_flags = GetPriorityClass (GetCurrentProcess ());
       sigproc_printf ("priority class %d", c_flags);
 
-      c_flags |= CREATE_SEPARATE_WOW_VDM | CREATE_UNICODE_ENVIRONMENT;
+      /* Per MSDN, this must be specified even if lpEnvironment is set to NULL,
+	 otherwise UNICODE characters in the parent environment are not copied
+	 correctly to the child.  Omitting it may scramble %PATH% on non-English
+	 systems. */
+      c_flags |= CREATE_UNICODE_ENVIRONMENT;
 
       /* Add CREATE_DEFAULT_ERROR_MODE flag for non-Cygwin processes so they
 	 get the default error mode instead of inheriting the mode Cygwin
-- 
2.52.0

