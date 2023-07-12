Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 2D5993857C40; Wed, 12 Jul 2023 12:08:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2D5993857C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1689163688;
	bh=iUG6uepFSBMXGN0MOudGWTMBoOGkLE5+zHvUZT4b18w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tEBNpbv7C6E564ZmPayoX2vL0gQj8n/qDrNqFKNgRADXJi7fvNO16USyGFXISeK9W
	 Dx0MpWj2DoLf2dmc6qdCLMRggGVBPIdNrvBqYmpAyQve8r1Jx505F0u3F2q6iO51VX
	 oQp+ccPCRSmEOp7jVRMoTDmxUjUDPMV3blvI47MM=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id AF063A80F81; Wed, 12 Jul 2023 14:08:04 +0200 (CEST)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 5/5] Cygwin: add AT_EMPTY_PATH fix to release message
Date: Wed, 12 Jul 2023 14:08:04 +0200
Message-Id: <20230712120804.2992142-6-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230712120804.2992142-1-corinna-cygwin@cygwin.com>
References: <20230712120804.2992142-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/release/3.4.8 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/winsup/cygwin/release/3.4.8 b/winsup/cygwin/release/3.4.8
index d1e34ce3c633..581ed5a140ff 100644
--- a/winsup/cygwin/release/3.4.8
+++ b/winsup/cygwin/release/3.4.8
@@ -3,3 +3,7 @@ Bug Fixes
 
 - Make <sys/cpuset.h> safe for c89 compilations.
   Addresses: https://cygwin.com/pipermail/cygwin-patches/2023q3/012308.html
+
+- Fix AT_EMPTY_PATH handling in fchmodat and fstatat if dirfd referres to
+  a file other than a directory
+  Addresses: https://cygwin.com/pipermail/cygwin-patches/2023q2/012306.html
-- 
2.40.1

