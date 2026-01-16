Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 78BF64BA2E1C; Fri, 16 Jan 2026 11:01:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 78BF64BA2E1C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1768561315;
	bh=bQZU/fqlH7JSaE2PiS//GwjQ/2a/dyXqSwidleAIeYE=;
	h=From:To:Subject:Date:From;
	b=ipG38o8PTsCDQIoxqJ6h8MFkaahdqFBSb85yJQWE8TXSmOnJg+TiwaplWOO/f+Ynq
	 AAelv1XKr1936y9b8xgIJyGXa3/2s6oPc5HSxuvNeUH08c3HvVw/AZlheU707dC/8m
	 WlSEgHvK6XmecQ620Qof0v7Nes4NWaWdMjBehndI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 91387A80C7B; Fri, 16 Jan 2026 12:01:53 +0100 (CET)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: internal_getlogin: always call internal_getgroups
Date: Fri, 16 Jan 2026 12:01:53 +0100
Message-ID: <20260116110153.1021016-1-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

Commit 29b7313d2225 ("* cygheap.h (enum cygheap_pwdgrp::cache_t):
Remove.") changed an initial conditional to skip calling
internal_getgroups() if we're running with cygserver account caching
in place.  This breaks changing the primary group.

Unfortunately the commit message doesn't explain why the change was
made.

Just calling internal_getgroups() all the time fixes this behaviour.

Fixes: 29b7313d2225 ("* cygheap.h (enum cygheap_pwdgrp::cache_t): Remove.")
Addresses: https://cygwin.com/pipermail/cygwin/2026-January/259250.html
Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/release/3.6.7 | 4 ++++
 winsup/cygwin/uinfo.cc      | 3 +--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/release/3.6.7 b/winsup/cygwin/release/3.6.7
index defe55ffe75e..050f6008084e 100644
--- a/winsup/cygwin/release/3.6.7
+++ b/winsup/cygwin/release/3.6.7
@@ -3,3 +3,7 @@ Fixes:
 
 - Guard c32rtomb against invalid input characters.
   Addresses a testsuite error in current gawk git master.
+
+- Allow changing primary group even when running with cygserver account
+  caching.
+  Addresses: https://cygwin.com/pipermail/cygwin/2026-January/259250.html
diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
index 1eb52f14578c..73e61cbffc82 100644
--- a/winsup/cygwin/uinfo.cc
+++ b/winsup/cygwin/uinfo.cc
@@ -153,8 +153,7 @@ internal_getlogin (cygheap_user &user)
      and the primary group in the token. */
   pwd = internal_getpwsid (user.sid (), &cldap);
   pgrp = internal_getgrsid (user.groups.pgsid, &cldap);
-  if (!cygheap->pg.nss_cygserver_caching ())
-    internal_getgroups (0, NULL, &cldap);
+  internal_getgroups (0, NULL, &cldap);
   if (!pwd)
     debug_printf ("user not found in passwd DB");
   else
-- 
2.52.0

