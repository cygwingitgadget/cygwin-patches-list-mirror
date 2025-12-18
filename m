Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 164924BA2E04; Thu, 18 Dec 2025 11:23:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 164924BA2E04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1766056990;
	bh=tZLiC5EZ1YZhLBDA7YoPZc8ITPtnbXNcoA3JlpRxf3Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=j/sp0TWyvEb4uDcYhwmfpoWyhfQhPO+V9TQUFjYC0z8ZqHPLeyXO8hPdxpASgpXe8
	 lADkYN4Wq7oIqrtKMBoTcJA/I9MB9udQvmpWM/29EeDNNj3x8jcQY6SkGtYLpe+a5a
	 0MQOa8AHHHZnvCMf0CqJivG1U8uiKg0pnIF+Hcv0=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 53A99A80D59; Thu, 18 Dec 2025 12:23:08 +0100 (CET)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 4/4] Cygwin: add release note for primary group override fix
Date: Thu, 18 Dec 2025 12:23:08 +0100
Message-ID: <20251218112308.1004395-5-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218112308.1004395-1-corinna-cygwin@cygwin.com>
References: <20251218112308.1004395-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/release/3.6.6 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/winsup/cygwin/release/3.6.6 b/winsup/cygwin/release/3.6.6
index 194ff15d0b84..a98e2f9e9290 100644
--- a/winsup/cygwin/release/3.6.6
+++ b/winsup/cygwin/release/3.6.6
@@ -17,3 +17,7 @@ Fixes:
 
 - Improve newgrp(1) POSIX compatibility and its documentation.
   Addresses: https://cygwin.com/pipermail/cygwin/2025-December/259055.html
+
+- Fix primary group override for non-domain users and users of a
+  Microsoft account.
+  Addresses: https://cygwin.com/pipermail/cygwin/2025-December/259068.html
-- 
2.52.0

