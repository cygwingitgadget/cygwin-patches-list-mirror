Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id E53B14BA2E22; Wed, 10 Dec 2025 17:32:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E53B14BA2E22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1765387923;
	bh=3pCP8AhhWviTyULy+agfGzEEIaIMl3tdlDDnhQIcuas=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DH+hcIgwrtvPuSD25GqXRafHgH55uqJ68dskO817pAmGUaLiueP8U30+O+JBnDEDj
	 4cug2wiDnjvVTPe37+ovz8a4QwHgV5sgRswzsQDXtR9o28qgkOiej5NWeiWSuZxWcb
	 FpG09J2UOXsMoL+LhrrzhUTtDsIyLIkrep81Cu4E=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C8FBAA80D34; Wed, 10 Dec 2025 18:32:01 +0100 (CET)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 3/3] Cygwin: add release note for newgrp(1) fixes
Date: Wed, 10 Dec 2025 18:32:01 +0100
Message-ID: <20251210173201.193740-4-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210173201.193740-1-corinna-cygwin@cygwin.com>
References: <20251210173201.193740-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/release/3.6.6 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/winsup/cygwin/release/3.6.6 b/winsup/cygwin/release/3.6.6
index 09b6a3913df4..194ff15d0b84 100644
--- a/winsup/cygwin/release/3.6.6
+++ b/winsup/cygwin/release/3.6.6
@@ -14,3 +14,6 @@ Fixes:
 
 - Fix the problem that tmp_pathbuf area is destroyed regarding flock().
   Addresses: https://cygwin.com/pipermail/cygwin/2025-October/258914.html
+
+- Improve newgrp(1) POSIX compatibility and its documentation.
+  Addresses: https://cygwin.com/pipermail/cygwin/2025-December/259055.html
-- 
2.52.0

