Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 4D4B73858D20; Wed, 12 Jul 2023 12:08:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4D4B73858D20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1689163686;
	bh=F2Im6HvyrRFJrVWrX9s0Uwq7CLjXLZPRWu8rxwooM+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uV4v3Xau50zgZ/RSbrOb6gZOYZb9PKMhVneQRIT8n+ai2mQFxEsWI6tWMFo5H5gS/
	 3kkHFifVtUwjZrea3NRBWUWZFNQqPa1VFiIt54FT2wNCudgs9qgct8z7CmznuCqt7Y
	 A2bxQ2TySOYjLTPocCzagqRJUbSImILuLYAHlDII=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 9BF12A80F7B; Wed, 12 Jul 2023 14:08:04 +0200 (CEST)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/5] Define _AT_NULL_PATHNAME_ALLOWED
Date: Wed, 12 Jul 2023 14:08:01 +0200
Message-Id: <20230712120804.2992142-3-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230712120804.2992142-1-corinna-cygwin@cygwin.com>
References: <20230712120804.2992142-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

Cygwin needs an internal flag to allow specifying an empty pathname
in utimesat (GLIBC extension). We define it in _default_fcntl.h to
make sure we never introduce a value collision accidentally.
While at it, define the values as 16 bit hex values.

Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 newlib/libc/include/sys/_default_fcntl.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/newlib/libc/include/sys/_default_fcntl.h b/newlib/libc/include/sys/_default_fcntl.h
index 48914c92eab4..ce721fa23c02 100644
--- a/newlib/libc/include/sys/_default_fcntl.h
+++ b/newlib/libc/include/sys/_default_fcntl.h
@@ -162,12 +162,13 @@ extern "C" {
 #define AT_FDCWD -2
 
 /* Flag values for faccessat2) et al. */
-#define AT_EACCESS              1
-#define AT_SYMLINK_NOFOLLOW     2
-#define AT_SYMLINK_FOLLOW       4
-#define AT_REMOVEDIR            8
+#define AT_EACCESS                 0x0001
+#define AT_SYMLINK_NOFOLLOW        0x0002
+#define AT_SYMLINK_FOLLOW          0x0004
+#define AT_REMOVEDIR               0x0008
 #if __GNU_VISIBLE
-#define AT_EMPTY_PATH          16
+#define AT_EMPTY_PATH              0x0010
+#define _AT_NULL_PATHNAME_ALLOWED  0x4000 /* Internal flag used by futimesat */
 #endif
 #endif
 
-- 
2.40.1

