Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 8F4004BA2E37; Mon, 26 Jan 2026 12:06:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8F4004BA2E37
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1769429173;
	bh=DYueGyY5czDtoJN3LaBlHQYMYE3VG5zxMmP6kyzXFFo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=uK29E+lNGgEt7NC1LJYNI7tY4qFtAPPDiWUpjhVRVYdBVyCHw0bjD6yPSrladJGJy
	 STzfv4P1yoHd0YVhvj0p8hXTpp7UZHgBPB/wEqAUdwUwezJaVcRZpz3TYWuMK9I95Q
	 bXXzfoSTmMNfiI04DJh8m5W6yiPCJqF46sjSYHX0=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 74AE5A81CEE; Mon, 26 Jan 2026 13:06:11 +0100 (CET)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/2] Cygwin: gencat: fix handling of \<oct> expressions
Date: Mon, 26 Jan 2026 13:06:11 +0100
Message-ID: <20260126120611.392483-2-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126120611.392483-1-corinna-cygwin@cygwin.com>
References: <20260126120611.392483-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

The code handling \<oct> expressions (backslash with 3 octal digits)
neglects to increment the pointer to the target string afterwards,
thus the next character simply overwrites the character created from
the \<oct> expression.

Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/utils/gencat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/winsup/utils/gencat.c b/winsup/utils/gencat.c
index f86b17b4a922..5b9e149739db 100644
--- a/winsup/utils/gencat.c
+++ b/winsup/utils/gencat.c
@@ -448,6 +448,7 @@ getmsg(int fd, char *cptr, char quote)
 							*tptr += (*cptr - '0');
 							++cptr;
 						}
+						++tptr;
 					} else {
 						warning(cptr, "unrecognized escape sequence");
 					}
-- 
2.52.0

