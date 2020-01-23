Return-Path: <cygwin-patches-return-9978-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4499 invoked by alias); 23 Jan 2020 04:33:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 4490 invoked by uid 89); 23 Jan 2020 04:33:36 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*MI:nifty, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-01.nifty.com
Received: from conuserg-01.nifty.com (HELO conuserg-01.nifty.com) (210.131.2.68) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 23 Jan 2020 04:33:34 +0000
Received: from localhost.localdomain (ntsitm247158.sitm.nt.ngn.ppp.infoweb.ne.jp [124.27.253.158]) (authenticated)	by conuserg-01.nifty.com with ESMTP id 00N4XDu6017929;	Thu, 23 Jan 2020 13:33:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-01.nifty.com 00N4XDu6017929
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1579753998;	bh=ehBlFdrgrB7j7NqarF7dK43JlxJ9wwuyJnxp597vVB0=;	h=From:To:Cc:Subject:Date:From;	b=uamAn4k48Org/FfXwEylShs5ArVPjNRyv2QhN1c5BG16PpOqz6n25weMwDDjMgPtR	 YbJzcQ/xAPHm05j6XZ4RJtEIwJQDe8Oa0dW9w+ysaexTzwDd0IBkuHv09ZCYNSeEGX	 LxVUUTI6KMpiTCluRBEyAq3grLMncvfvNYQf2pcdn3FHo4zhENXcwrVz5J5HUUexFD	 1WhRWK/TIBIyHFygddb/obthCipm8K23MgaLOUJ4t2Uxr9HMwgaHANdPyUgEcpcsyT	 nXffOGou5PLoR85vWaxXVwk9t4XSwmcXKOZNu9L+JwTwyE+XBd+MXWgbYrok0D35Nq	 SvONGl1qoGeeA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Add missing console API hooks.
Date: Thu, 23 Jan 2020 04:33:00 -0000
Message-Id: <20200123043312.529-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00084.txt

- Following console APIs are additionally hooked for cygwin programs
  which directly call them.
  * FillConsoleOutputAttribute()
  * FillConsoleOutputCharacterA()
  * FillConsoleOutputCharacterW()
  * ScrollConsoleScreenBufferA()
  * ScrollConsoleScreenBufferW()
---
 winsup/cygwin/fhandler_tty.cc | 55 +++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 404216bf6..05070aa3b 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -192,6 +192,11 @@ DEF_HOOK (ReadConsoleInputA);
 DEF_HOOK (ReadConsoleInputW);
 DEF_HOOK (PeekConsoleInputA);
 DEF_HOOK (PeekConsoleInputW);
+DEF_HOOK (FillConsoleOutputAttribute);
+DEF_HOOK (FillConsoleOutputCharacterA);
+DEF_HOOK (FillConsoleOutputCharacterW);
+DEF_HOOK (ScrollConsoleScreenBufferA);
+DEF_HOOK (ScrollConsoleScreenBufferW);
 /* CreateProcess() is hooked for GDB etc. */
 DEF_HOOK (CreateProcessA);
 DEF_HOOK (CreateProcessW);
@@ -329,6 +334,43 @@ PeekConsoleInputW_Hooked
   set_ishybrid_and_switch_to_pcon (h);
   return PeekConsoleInputW_Orig (h, r, l, n);
 }
+static BOOL WINAPI
+FillConsoleOutputAttribute_Hooked
+     (HANDLE h, WORD a, DWORD l, COORD d, LPDWORD n)
+{
+  set_ishybrid_and_switch_to_pcon (h);
+  return FillConsoleOutputAttribute_Orig (h, a, l, d, n);
+}
+static BOOL WINAPI
+FillConsoleOutputCharacterA_Hooked
+     (HANDLE h, CHAR c, DWORD l, COORD d, LPDWORD n)
+{
+  set_ishybrid_and_switch_to_pcon (h);
+  return FillConsoleOutputCharacterA_Orig (h, c, l, d, n);
+}
+static BOOL WINAPI
+FillConsoleOutputCharacterW_Hooked
+     (HANDLE h, WCHAR c, DWORD l, COORD d, LPDWORD n)
+{
+  set_ishybrid_and_switch_to_pcon (h);
+  return FillConsoleOutputCharacterW_Orig (h, c, l, d, n);
+}
+static BOOL WINAPI
+ScrollConsoleScreenBufferA_Hooked
+     (HANDLE h, const SMALL_RECT *r, const SMALL_RECT *c, COORD d,
+      const CHAR_INFO *f)
+{
+  set_ishybrid_and_switch_to_pcon (h);
+  return ScrollConsoleScreenBufferA_Orig (h, r, c, d, f);
+}
+static BOOL WINAPI
+ScrollConsoleScreenBufferW_Hooked
+     (HANDLE h, const SMALL_RECT *r, const SMALL_RECT *c, COORD d,
+      const CHAR_INFO *f)
+{
+  set_ishybrid_and_switch_to_pcon (h);
+  return ScrollConsoleScreenBufferW_Orig (h, r, c, d, f);
+}
 /* CreateProcess() is hooked for GDB etc. */
 static BOOL WINAPI
 CreateProcessA_Hooked
@@ -2749,8 +2791,12 @@ fhandler_pty_slave::fixup_after_attach (bool native_maybe, int fd_set)
 		    (SHORT) (sbi.dwSize.X -1), (SHORT) (sbi.dwSize.Y - 1)};
 		  COORD dest = {0, 0};
 		  CHAR_INFO fill = {' ', 0};
-		  ScrollConsoleScreenBuffer (get_output_handle (),
-					     &rect, NULL, dest, &fill);
+		  BOOL (WINAPI *ScrollFunc)
+		    (HANDLE, const SMALL_RECT *, const SMALL_RECT *,
+		     COORD, const CHAR_INFO *);
+		  ScrollFunc = ScrollConsoleScreenBufferA_Orig ? :
+		    ScrollConsoleScreenBuffer;
+		  ScrollFunc (get_output_handle (), &rect, NULL, dest, &fill);
 		  get_ttyp ()->need_redraw_screen = false;
 		}
 	    }
@@ -2848,6 +2894,11 @@ fhandler_pty_slave::fixup_after_exec ()
       DO_HOOK (NULL, ReadConsoleInputW);
       DO_HOOK (NULL, PeekConsoleInputA);
       DO_HOOK (NULL, PeekConsoleInputW);
+      DO_HOOK (NULL, FillConsoleOutputAttribute);
+      DO_HOOK (NULL, FillConsoleOutputCharacterA);
+      DO_HOOK (NULL, FillConsoleOutputCharacterW);
+      DO_HOOK (NULL, ScrollConsoleScreenBufferA);
+      DO_HOOK (NULL, ScrollConsoleScreenBufferW);
       /* CreateProcess() is hooked for GDB etc. */
       DO_HOOK (NULL, CreateProcessA);
       DO_HOOK (NULL, CreateProcessW);
-- 
2.21.0
