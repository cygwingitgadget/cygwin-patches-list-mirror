Return-Path: <cygwin-patches-return-9694-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27643 invoked by alias); 18 Sep 2019 14:29:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 27538 invoked by uid 89); 18 Sep 2019 14:29:39 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=1979, pty, HX-Languages-Length:2078, hooked
X-HELO: conuserg-06.nifty.com
Received: from conuserg-06.nifty.com (HELO conuserg-06.nifty.com) (210.131.2.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 18 Sep 2019 14:29:38 +0000
Received: from localhost.localdomain (ntsitm283243.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.151.243]) (authenticated)	by conuserg-06.nifty.com with ESMTP id x8IETKDv031962;	Wed, 18 Sep 2019 23:29:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-06.nifty.com x8IETKDv031962
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1568816969;	bh=o4WKJS6q6Jk2VLhpnoEuoMPofKGqZb/UfvRQVotbcgY=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=F0WzywTtoQwF8mKASuvQBkYTAFeGVuH21aSRivGPR3VNRRTTiS7LHzIsOQRyGvMV1	 AXIOf0hdwYIdKyNfD3dn83kwygTenk1I4fYPlpXi3IvasOlXSII/NNlPRcR48LYWS/	 y70RW4ZiL3EeXfXkZqQQlUHeI7wa6jBKYKRNrB9BHu3tQLb69JXzDaeEgW8KaxJaW3	 fIrAHd2rlcy7h74CgPP53oo4gTRUPN/7dloLyNBhUD4SiOamerDEzozXEdyBRtH/qG	 oTUXO+2QDTQgFJbXnoKoPjf5jnP+M6k0lgEhyB0RqKhUjOQalQ3EoBNyA5ASnARBV4	 AOCXGasIa67Bg==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 2/5] Cygwin: pty: Make GDB work again on pty.
Date: Wed, 18 Sep 2019 14:29:00 -0000
Message-Id: <20190918142921.835-3-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190918142921.835-1-takashi.yano@nifty.ne.jp>
References: <20190918142921.835-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00213.txt.bz2

---
 winsup/cygwin/fhandler_tty.cc | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 2a1c34f7d..843807aab 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -197,6 +197,9 @@ DEF_HOOK (ReadConsoleInputA);
 DEF_HOOK (ReadConsoleInputW);
 DEF_HOOK (PeekConsoleInputA);
 DEF_HOOK (PeekConsoleInputW);
+/* CreateProcess() is hooked for GDB etc. */
+DEF_HOOK (CreateProcessA);
+DEF_HOOK (CreateProcessW);
 
 static BOOL WINAPI
 WriteFile_Hooked
@@ -331,6 +334,35 @@ PeekConsoleInputW_Hooked
   set_ishybrid_and_switch_to_pcon (h);
   return PeekConsoleInputW_Orig (h, r, l, n);
 }
+/* CreateProcess() is hooked for GDB etc. */
+static BOOL WINAPI
+CreateProcessA_Hooked
+     (LPCSTR n, LPSTR c, LPSECURITY_ATTRIBUTES pa, LPSECURITY_ATTRIBUTES ta,
+      BOOL inh, DWORD f, LPVOID e, LPCSTR d,
+      LPSTARTUPINFOA si, LPPROCESS_INFORMATION pi)
+{
+  HANDLE h;
+  if (si->dwFlags & STARTF_USESTDHANDLES)
+    h = si->hStdOutput;
+  else
+    h = GetStdHandle (STD_OUTPUT_HANDLE);
+  set_ishybrid_and_switch_to_pcon (h);
+  return CreateProcessA_Orig (n, c, pa, ta, inh, f, e, d, si, pi);
+}
+static BOOL WINAPI
+CreateProcessW_Hooked
+     (LPCWSTR n, LPWSTR c, LPSECURITY_ATTRIBUTES pa, LPSECURITY_ATTRIBUTES ta,
+      BOOL inh, DWORD f, LPVOID e, LPCWSTR d,
+      LPSTARTUPINFOW si, LPPROCESS_INFORMATION pi)
+{
+  HANDLE h;
+  if (si->dwFlags & STARTF_USESTDHANDLES)
+    h = si->hStdOutput;
+  else
+    h = GetStdHandle (STD_OUTPUT_HANDLE);
+  set_ishybrid_and_switch_to_pcon (h);
+  return CreateProcessW_Orig (n, c, pa, ta, inh, f, e, d, si, pi);
+}
 #else /* USE_API_HOOK */
 #define WriteFile_Orig 0
 #define ReadFile_Orig 0
@@ -2778,6 +2810,9 @@ fhandler_pty_slave::fixup_after_exec ()
       DO_HOOK (NULL, ReadConsoleInputW);
       DO_HOOK (NULL, PeekConsoleInputA);
       DO_HOOK (NULL, PeekConsoleInputW);
+      /* CreateProcess() is hooked for GDB etc. */
+      DO_HOOK (NULL, CreateProcessA);
+      DO_HOOK (NULL, CreateProcessW);
     }
 #endif /* USE_API_HOOK */
 }
-- 
2.21.0
