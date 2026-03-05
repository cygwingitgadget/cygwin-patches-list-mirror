Return-Path: <SRS0=UDMs=BF=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 5CC1B4BA2E0E
	for <cygwin-patches@cygwin.com>; Thu,  5 Mar 2026 10:53:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5CC1B4BA2E0E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5CC1B4BA2E0E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772708009; cv=none;
	b=VhrGQcxH39P+yrbCdP/6hNgpdCkIRIhUvOk7SIpQrqqRwn4i8Exy3wbuArh7ybYSgeujbwJAhsQlV8eWwTt6k8WuPZEwhu9MHlOROAsWLwikYBOKDUXdH05iH273vdsMDqYqzaWD/VxGuX9l+Szc9GAjBFnme9u4NETOEOQdGnQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772708009; c=relaxed/simple;
	bh=iwQmpqz+bdmhvA2/EK71wnWwLp89ghzI1JTP8Sv9gBo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lX8/3Nz7wRNdPPye8dYY7oEBJangTd+jnKcCtf93+3zY0vZeQbgF2buKcNkjxW9jLsJ5rSddQUga3E1I9PmuBM8fvlDsFY2GiOxGcd96O6RMI8+X1qgMn9NWpaY4etkNp3VvleEPj6HNGxDMy7tpKaoQ2KnKoAUxThV0o4zTLQA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5CC1B4BA2E0E
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 625B9wK6099829;
	Thu, 5 Mar 2026 03:09:58 -0800 (PST)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "zotac"
 via SMTP by m0.truegem.net, id smtpdJoA9fL; Thu Mar  5 03:09:54 2026
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH] Cygwin: Change mappings of Windows ERROR*QUOTA*
Date: Thu,  5 Mar 2026 02:52:33 -0800
Message-ID: <20260305105320.36284-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <https://cygwin.com/pipermail/cygwin-patches/2026q1/014707.html>
References: <https://cygwin.com/pipermail/cygwin-patches/2026q1/014707.html>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

While testing the new rlimit implementation, it was noticed fork()
returns an EIO error on hitting the process count limit.  Per POSIX,
the error should be EAGAIN.  This patch makes the change.

Along the way it was noticed Windows ERROR_DISK_QUOTA_EXCEEDED was not
being mapped to any POSIX error.  This patch changes the mapping to EFBIG.

Addresses: https://cygwin.com/pipermail/cygwin-patches/2026q1/014707.html
Signed-off-by: Mark Geisert <mark@maxrnd.com>
Fixes: c2f6c0415501 (Cygwin: errmap[]: update comments using current winerror.h)

---
 winsup/cygwin/local_includes/errmap.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/local_includes/errmap.h b/winsup/cygwin/local_includes/errmap.h
index 354968f86..bbe4b6a35 100644
--- a/winsup/cygwin/local_includes/errmap.h
+++ b/winsup/cygwin/local_includes/errmap.h
@@ -1301,7 +1301,7 @@ constexpr uint8_t errmap[] =
   0,			/* 1292: ERROR_IMPLEMENTATION_LIMIT */
   0,			/* 1293: ERROR_PROCESS_IS_PROTECTED */
   0,			/* 1294: ERROR_SERVICE_NOTIFY_CLIENT_LAGGING */
-  0,			/* 1295: ERROR_DISK_QUOTA_EXCEEDED */
+  EFBIG,		/* 1295: ERROR_DISK_QUOTA_EXCEEDED */
   0,			/* 1296: ERROR_CONTENT_BLOCKED */
   0,			/* 1297: ERROR_INCOMPATIBLE_SERVICE_PRIVILEGE */
   0,			/* 1298: ERROR_APP_HANG */
@@ -1822,7 +1822,7 @@ constexpr uint8_t errmap[] =
   0,			/* 1813: ERROR_RESOURCE_TYPE_NOT_FOUND */
   0,			/* 1814: ERROR_RESOURCE_NAME_NOT_FOUND */
   0,			/* 1815: ERROR_RESOURCE_LANG_NOT_FOUND */
-  EIO,			/* 1816: ERROR_NOT_ENOUGH_QUOTA */
+  EAGAIN,		/* 1816: ERROR_NOT_ENOUGH_QUOTA */
   0,			/* 1817 */
   0,			/* 1818 */
   0,			/* 1819 */
-- 
2.51.0

