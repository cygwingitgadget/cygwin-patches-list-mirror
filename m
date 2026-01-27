Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 261074BA2E25; Tue, 27 Jan 2026 20:14:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 261074BA2E25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1769544863;
	bh=dcnH96aoRbWcRYjj6e3twU6svQZVCTYVraoWlYLcHcA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CC3BXz0qZQ9dSWZkrkKE6Iszdy5UQ3qawVthRJ6+i2mYm5xUfS87vfr2FzRpiQz6N
	 wY0VYzBW/+0CLLGBNfrooHpVBTE/QxcAp3NfXLAwhU4XDlt17JA+ZrovUiuvujlOCx
	 Ei/z8Bf5sW5zKmme7YHcmMk9pIfpYcd/pVdt0iic=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id EB3E9A80439; Tue, 27 Jan 2026 21:14:20 +0100 (CET)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 2/2] Cygwin: gencat: define __dead
Date: Tue, 27 Jan 2026 21:14:20 +0100
Message-ID: <20260127201420.580616-2-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260127201420.580616-1-corinna-cygwin@cygwin.com>
References: <20260126120611.392483-1-corinna-cygwin@cygwin.com>
 <20260127201420.580616-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

NetBSD defines __dead as __attribute__((__noreturn__)).  Add a matching
macro expression.

Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/utils/gencat.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/winsup/utils/gencat.c b/winsup/utils/gencat.c
index b009b77c09b6..430d097cb341 100644
--- a/winsup/utils/gencat.c
+++ b/winsup/utils/gencat.c
@@ -96,6 +96,10 @@ up-to-date.  Many thanks.
 #define NL_MSGMAX 2048
 #endif
 
+#ifndef __dead
+#define __dead __attribute__((__noreturn__))
+#endif
+
 struct _msgT {
 	long    msgId;
 	char   *str;
-- 
2.52.0

