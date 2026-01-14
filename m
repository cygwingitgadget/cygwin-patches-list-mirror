Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id C8A6C4BA2E2B; Wed, 14 Jan 2026 22:31:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C8A6C4BA2E2B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1768429868;
	bh=lgDdAGhGqc+2QQJ853uIqTZ3i7wic/3Jy4o/DROwNcQ=;
	h=From:To:Subject:Date:From;
	b=mez87VigciKQbjx3mn2tEiC8v2/TalYzMHcnhCXSmKrOX715v3rAk10QrN+sxSYnA
	 W7jQi0aRRFpaTFaFe06Ito64I4XH/qMinEEnXZJECBZxFyuCf/AtpjAJh+4pQVuYvN
	 oFnSu9B6C/7bUASwqyTyfvXJ7F5ZlfhiFycGQoN4=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D969BA80DDB; Wed, 14 Jan 2026 23:31:06 +0100 (CET)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: c32rtomb: add missing check for invalid UNICODE character
Date: Wed, 14 Jan 2026 23:31:06 +0100
Message-ID: <20260114223106.828985-1-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

c32rtomb neglects to check the input character for being outside
the valid UNICODE planes.  It happily converts the invalid character
into a valid (but wrong) surrogate pair and carries on.

Add a check so characters beyond 0x10ffff are not converted anymore.
Return -1 with errno set to EILSEQ instead.

Fixes: 4f258c55e87f ("Cygwin: Add ISO C11 functions c16rtomb, c32rtomb, mbrtoc16, mbrtoc32.")
Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/release/3.6.7 | 5 +++++
 winsup/cygwin/strfuncs.cc   | 7 +++++++
 2 files changed, 12 insertions(+)
 create mode 100644 winsup/cygwin/release/3.6.7

diff --git a/winsup/cygwin/release/3.6.7 b/winsup/cygwin/release/3.6.7
new file mode 100644
index 000000000000..defe55ffe75e
--- /dev/null
+++ b/winsup/cygwin/release/3.6.7
@@ -0,0 +1,5 @@
+Fixes:
+------
+
+- Guard c32rtomb against invalid input characters.
+  Addresses a testsuite error in current gawk git master.
diff --git a/winsup/cygwin/strfuncs.cc b/winsup/cygwin/strfuncs.cc
index eb6576051d90..0cf41cefc8a2 100644
--- a/winsup/cygwin/strfuncs.cc
+++ b/winsup/cygwin/strfuncs.cc
@@ -146,6 +146,13 @@ c32rtomb (char *s, char32_t wc, mbstate_t *ps)
     if (wc <= 0xffff || !s)
       return wcrtomb (s, (wchar_t) wc, ps);
 
+    /* Check for character outside valid UNICODE planes */
+    if (wc > 0x10ffff)
+      {
+	_REENT_ERRNO(_REENT) = EILSEQ;
+	return (size_t)(-1);
+      }
+
     wchar_t wc_arr[2];
     const wchar_t *wcp = wc_arr;
 
-- 
2.52.0

