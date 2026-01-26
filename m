Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 047C34BC8974; Mon, 26 Jan 2026 10:26:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 047C34BC8974
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1769423161;
	bh=St5Kh7yKnDTu/eyPYg7SVORuuiTc+czvePFQxb80qgg=;
	h=From:To:Subject:Date:From;
	b=vDaOtpTNTYwhfjCFQgCmNXGGj1t1DBmYux7fMS3lf6cdVZgfOxuaE3N+M+N2S55Zi
	 UPngMRp/cephLBKC8url55Y6O7eKSaaZ15SgAcnvrzsQlMf9mMhKlrF+P7834RHhY7
	 Utki8ye1VUmI+Uj2cICsKnTu2hFD0Uob/u+27D2s=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 11CF8A81CEE; Mon, 26 Jan 2026 11:25:59 +0100 (CET)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: fhandler_socket::fchown: fix check for admin user
Date: Mon, 26 Jan 2026 11:25:58 +0100
Message-ID: <20260126102559.382483-1-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

This has never worked as desired.  The check for admin permissions
is broken.  The call to check_token_membership() expects a PSID
argument.  What it gets is a pointer to a cygpsid.  There's no
class-specific type conversion for this to a PSID, so the pointer
is converted verbatim.

Pass the cygpsid directly, because cygpsid has a type conversion
method to PSID defined.

Pity that GCC doesn't warn here...

Fixes: 859d215b7e00 ("Cygwin: split out fhandler_socket into inet and local classes")
Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/fhandler/socket.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/socket.cc b/winsup/cygwin/fhandler/socket.cc
index c0cef7d3eeb1..0e1fb1bd25f1 100644
--- a/winsup/cygwin/fhandler/socket.cc
+++ b/winsup/cygwin/fhandler/socket.cc
@@ -258,7 +258,7 @@ fhandler_socket::fchmod (mode_t newmode)
 int
 fhandler_socket::fchown (uid_t newuid, gid_t newgid)
 {
-  bool perms = check_token_membership (&well_known_admins_sid);
+  bool perms = check_token_membership (well_known_admins_sid);
 
   /* Admin rulez */
   if (!perms)
-- 
2.52.0

