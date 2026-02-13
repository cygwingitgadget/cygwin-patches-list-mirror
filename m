Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 80C0C4B9DB52; Fri, 13 Feb 2026 19:35:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 80C0C4B9DB52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1771011337;
	bh=RMSrDtc9iWySaiAm/hPKZON+QKYlD/S36hSctEbN6SQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=j/aThbau2LFunnXVInsdTodNFLwzRk1w/YuRsZ6H3m542OnxhC3ELuCvev04CO0wq
	 Sfa70uxyIJkt3QeHx5OwIU7q1fJSwV6XlrlB6Iz7j32dAUxN13WMpvyJsmmFv9mie9
	 RZ8CTOvF7zv6uVf3E4w8TBswS+EcWXGsXsqWE0zE=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id A05ABA81C4F; Fri, 13 Feb 2026 20:35:35 +0100 (CET)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: PEHeaderFromHModule: allow only images matching build architecture
Date: Fri, 13 Feb 2026 20:35:35 +0100
Message-ID: <20260213193535.2983506-1-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aY9Ky2rJmDLyRqt7@calimero.vinschen.de>
References: <aY9Ky2rJmDLyRqt7@calimero.vinschen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

This makes sure that we only ever handle images which can be executed
on the current architecture.

Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/hookapi.cc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/winsup/cygwin/hookapi.cc b/winsup/cygwin/hookapi.cc
index b0126ac04e3e..5b25443c8365 100644
--- a/winsup/cygwin/hookapi.cc
+++ b/winsup/cygwin/hookapi.cc
@@ -43,10 +43,13 @@ PEHeaderFromHModule (HMODULE hModule)
   /* Return valid PIMAGE_NT_HEADERS only for supported architectures. */
   switch (pNTHeader->FileHeader.Machine)
     {
+#if defined(__x86_64__)
     case IMAGE_FILE_MACHINE_AMD64:
       break;
+#elif defined (__aarch64__)
     case IMAGE_FILE_MACHINE_ARM64:
       break;
+#endif
     default:
       return NULL;
     }
-- 
2.53.0

