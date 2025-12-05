Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 3D0CC4CCCA05; Fri,  5 Dec 2025 16:38:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3D0CC4CCCA05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1764952738;
	bh=qTTVAMNtLTNWa7ZyndUikQeTWtbLWRQBADPEwMKFyh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yT4ddw4Gj7bvCQy77TcQH7XJHiskrhlHQU63HN1FySIav+aFjB2HQwJItISr4NwPc
	 YmNnMQSZmqwkuKnR4r2lyR+UmQpWy2KNyOO/UNY+1mJMo/AKujZa/K0V2DLdruXFrs
	 c6oY254KLlsv+AIoHTZ5BsjzLXCbdMLTs2I6OrYs=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 4B6ACA814B3; Fri, 05 Dec 2025 17:38:56 +0100 (CET)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Marco Atzeri <marco.atzeri@gmail.com>
Subject: [PATCH 3/3] Cygwin: add release note for primary group override fix
Date: Fri,  5 Dec 2025 17:38:56 +0100
Message-ID: <20251205163856.3993550-4-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251205163856.3993550-1-corinna-cygwin@cygwin.com>
References: <20251205163856.3993550-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/release/3.6.6 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/winsup/cygwin/release/3.6.6 b/winsup/cygwin/release/3.6.6
index 09b6a3913df4..817bf8b99e54 100644
--- a/winsup/cygwin/release/3.6.6
+++ b/winsup/cygwin/release/3.6.6
@@ -14,3 +14,7 @@ Fixes:
 
 - Fix the problem that tmp_pathbuf area is destroyed regarding flock().
   Addresses: https://cygwin.com/pipermail/cygwin/2025-October/258914.html
+
+- Fix primary group override for non-domain users and users of a
+  Microsoft account.
+  Addresses: https://cygwin.com/pipermail/cygwin/2025-December/259068.html
-- 
2.51.1

