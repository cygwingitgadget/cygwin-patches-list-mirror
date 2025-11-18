Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id C993A3857704; Tue, 18 Nov 2025 12:40:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C993A3857704
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1763469637;
	bh=Qd+oDpIZbfwimggj6ywlBWlyFgmADwml8Gg+KW2jmiA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TEA7owz3zUbJMW5eklxAbjGnrmdsLvQAiQfRHiz3XWjdRBfxSBb8lAEdCF/MYD7yH
	 0NC502MuewOpOgAsqzpfP80VpG6X88vcloFg64jaD8kp7ibFB2YXHLCnrk99ZjcYlq
	 g3+u9OrNTtrum6IXBKJso0KsOnNvCRC7TZo8O2Zk=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id AD8D4A80432; Tue, 18 Nov 2025 13:40:34 +0100 (CET)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/2] Cygwin: wincap: add wincap entry for Windows 11 24H2
Date: Tue, 18 Nov 2025 13:40:33 +0100
Message-ID: <20251118124034.1097179-2-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251118124034.1097179-1-corinna-cygwin@cygwin.com>
References: <20251118124034.1097179-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

Also add a wincap bit allowing to check existence of
AllocConsoleWithOptions().

Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/local_includes/wincap.h |  2 ++
 winsup/cygwin/wincap.cc               | 37 ++++++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/local_includes/wincap.h b/winsup/cygwin/local_includes/wincap.h
index 250866f0614c..2416eee1d9c7 100644
--- a/winsup/cygwin/local_includes/wincap.h
+++ b/winsup/cygwin/local_includes/wincap.h
@@ -33,6 +33,7 @@ struct wincaps
     unsigned has_tcp_maxrtms					: 1;
     unsigned has_con_broken_tabs				: 1;
     unsigned has_user_shstk					: 1;
+    unsigned has_alloc_console_with_options			: 1;
   };
 };
 
@@ -90,6 +91,7 @@ public:
   bool	IMPLEMENT (has_tcp_maxrtms)
   bool	IMPLEMENT (has_con_broken_tabs)
   bool	IMPLEMENT (has_user_shstk)
+  bool	IMPLEMENT (has_alloc_console_with_options)
 
   void disable_case_sensitive_dirs ()
   {
diff --git a/winsup/cygwin/wincap.cc b/winsup/cygwin/wincap.cc
index deecf8ba519d..91caefe9bc4b 100644
--- a/winsup/cygwin/wincap.cc
+++ b/winsup/cygwin/wincap.cc
@@ -32,6 +32,7 @@ static const wincaps wincap_8_1 = {
     has_tcp_maxrtms:false,
     has_con_broken_tabs:false,
     has_user_shstk:false,
+    has_alloc_console_with_options:false,
   },
 };
 
@@ -54,6 +55,7 @@ static const wincaps  wincap_10_1507 = {
     has_tcp_maxrtms:false,
     has_con_broken_tabs:false,
     has_user_shstk:false,
+    has_alloc_console_with_options:false,
   },
 };
 
@@ -76,6 +78,7 @@ static const wincaps  wincap_10_1607 = {
     has_tcp_maxrtms:true,
     has_con_broken_tabs:false,
     has_user_shstk:false,
+    has_alloc_console_with_options:false,
   },
 };
 
@@ -98,6 +101,7 @@ static const wincaps wincap_10_1703 = {
     has_tcp_maxrtms:true,
     has_con_broken_tabs:true,
     has_user_shstk:false,
+    has_alloc_console_with_options:false,
   },
 };
 
@@ -120,6 +124,7 @@ static const wincaps wincap_10_1709 = {
     has_tcp_maxrtms:true,
     has_con_broken_tabs:true,
     has_user_shstk:false,
+    has_alloc_console_with_options:false,
   },
 };
 
@@ -142,6 +147,7 @@ static const wincaps wincap_10_1803 = {
     has_tcp_maxrtms:true,
     has_con_broken_tabs:true,
     has_user_shstk:false,
+    has_alloc_console_with_options:false,
   },
 };
 
@@ -164,6 +170,7 @@ static const wincaps wincap_10_1809 = {
     has_tcp_maxrtms:true,
     has_con_broken_tabs:true,
     has_user_shstk:false,
+    has_alloc_console_with_options:false,
   },
 };
 
@@ -186,6 +193,7 @@ static const wincaps wincap_10_1903 = {
     has_tcp_maxrtms:true,
     has_con_broken_tabs:true,
     has_user_shstk:false,
+    has_alloc_console_with_options:false,
   },
 };
 
@@ -208,6 +216,7 @@ static const wincaps wincap_10_2004 = {
     has_tcp_maxrtms:true,
     has_con_broken_tabs:true,
     has_user_shstk:true,
+    has_alloc_console_with_options:false,
   },
 };
 
@@ -230,6 +239,30 @@ static const wincaps wincap_11 = {
     has_tcp_maxrtms:true,
     has_con_broken_tabs:false,
     has_user_shstk:true,
+    has_alloc_console_with_options:false,
+  },
+};
+
+static const wincaps wincap_11_24h2 = {
+  {
+    has_new_pebteb_region:true,
+    has_unprivileged_createsymlink:true,
+    has_precise_interrupt_time:true,
+    has_posix_unlink_semantics:true,
+    has_posix_unlink_semantics_with_ignore_readonly:true,
+    has_case_sensitive_dirs:true,
+    has_posix_rename_semantics:true,
+    has_con_24bit_colors:true,
+    has_con_broken_csi3j:false,
+    has_con_broken_il_dl:false,
+    has_con_esc_rep:true,
+    has_extended_mem_api:true,
+    has_tcp_fastopen:true,
+    has_linux_tcp_keepalive_sockopts:true,
+    has_tcp_maxrtms:true,
+    has_con_broken_tabs:false,
+    has_user_shstk:true,
+    has_alloc_console_with_options:true,
   },
 };
 
@@ -264,7 +297,9 @@ wincapc::init ()
 	break;
       case 10:
       default:
-	if (likely (version.dwBuildNumber >= 22000))
+	if (likely (version.dwBuildNumber >= 26100))
+	  caps = &wincap_11_24h2;
+	else if (version.dwBuildNumber >= 22000)
 	  caps = &wincap_11;
 	else if (version.dwBuildNumber >= 19041)
 	  caps = &wincap_10_2004;
-- 
2.51.1

