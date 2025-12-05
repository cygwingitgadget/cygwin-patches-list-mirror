Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id BBEC64CCCA37; Fri,  5 Dec 2025 19:42:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BBEC64CCCA37
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1764963722;
	bh=K1roDFkuWLVmnV4dipP6/SVpgpngtWqW6MvSvs4UpG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ffRrTIh5MlkpE1PBDObRCPfR898YhxYibk8El4juAxozmzKY3blJ4oFtCk7K9Uwxc
	 H46wYxhrSRLO+YLfXnkrL9aFhL+27CHkZJWhMjz9ybiv2o+yBQ684svwt1qLjxkU3U
	 NwZcsCUbsK/PsTHIEMQS7YickhoDEooF98Kv6a+8=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D3EFFA814B3; Fri, 05 Dec 2025 20:42:00 +0100 (CET)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Marco Atzeri <marco.atzeri@gmail.com>
Subject: [PATCH 3/3] Cygwin: add release note for newgrp(1) fixes
Date: Fri,  5 Dec 2025 20:42:00 +0100
Message-ID: <20251205194200.4011206-4-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251205194200.4011206-1-corinna-cygwin@cygwin.com>
References: <20251205194200.4011206-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/release/3.6.6 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/winsup/cygwin/release/3.6.6 b/winsup/cygwin/release/3.6.6
index 817bf8b99e54..ca7818b94abb 100644
--- a/winsup/cygwin/release/3.6.6
+++ b/winsup/cygwin/release/3.6.6
@@ -18,3 +18,6 @@ Fixes:
 - Fix primary group override for non-domain users and users of a
   Microsoft account.
   Addresses: https://cygwin.com/pipermail/cygwin/2025-December/259068.html
+
+- Improve newgrp(1) POSIX compatibility and its documentation.
+  Addresses: https://cygwin.com/pipermail/cygwin/2025-December/259055.html
-- 
2.51.1

