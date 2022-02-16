Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id D4DAF3858D37
 for <cygwin-patches@cygwin.com>; Wed, 16 Feb 2022 09:40:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org D4DAF3858D37
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 21G9eI3Q012931;
 Wed, 16 Feb 2022 18:40:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 21G9eI3Q012931
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1645004422;
 bh=oaP9Fp+awyd/zKNB6GPAIEpBXgf16vs5m5vuuhRima0=;
 h=From:To:Cc:Subject:Date:From;
 b=CV7eMncXAnoAY6l9rEP5VyPtDYvCTTNSMK1n3e2uHNGCEWHnOUBCY5MkPZpLfR4Xx
 VK4ZSNJuDd8U9X1TV6qhelG6fwnRI+gMans48GIulNIUedLdUsDuhX9K/vIOa4+L5A
 h22JAPg/+JGwW8YJS+XDgVzfmToH5QX6Z2FyT3PevKKHxNwZArkKJ3wlItnslvjRHM
 LHMTBWHHBVNTSjx97nq24vmEXPyb2j6JvybcfxMJOs9EQwEr0PgJt3qFsxUwEYUplo
 pd1V40AGgLPriASUlC3xWPlwldVGMou7wv/d0o7BM1wmAREFAWI8yG7RLMqkS9avVn
 nNRxoB8+cqqOw==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2] Cygwin: wincap: Add capabilities for Windows 11.
Date: Wed, 16 Feb 2022 18:40:08 +0900
Message-Id: <20220216094008.2087-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Wed, 16 Feb 2022 09:40:57 -0000

- The capability changes since Windows 11 have been reflected in
  wincap.cc. The capability has_con_broken_tabs is added, which is
  false since Windows 11.
---
 winsup/cygwin/wincap.cc | 47 ++++++++++++++++++++++++++++++++++++++++-
 winsup/cygwin/wincap.h  |  2 ++
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/wincap.cc b/winsup/cygwin/wincap.cc
index b8376b8ed..ffc32140b 100644
--- a/winsup/cygwin/wincap.cc
+++ b/winsup/cygwin/wincap.cc
@@ -46,6 +46,7 @@ wincaps wincap_7 __attribute__((section (".cygwin_dll_common"), shared)) = {
     has_linux_tcp_keepalive_sockopts:false,
     has_tcp_maxrtms:false,
     has_query_process_handle_info:false,
+    has_con_broken_tabs:false,
   },
 };
 
@@ -77,6 +78,7 @@ wincaps wincap_8 __attribute__((section (".cygwin_dll_common"), shared)) = {
     has_linux_tcp_keepalive_sockopts:false,
     has_tcp_maxrtms:false,
     has_query_process_handle_info:true,
+    has_con_broken_tabs:false,
   },
 };
 
@@ -108,6 +110,7 @@ wincaps wincap_8_1 __attribute__((section (".cygwin_dll_common"), shared)) = {
     has_linux_tcp_keepalive_sockopts:false,
     has_tcp_maxrtms:false,
     has_query_process_handle_info:true,
+    has_con_broken_tabs:false,
   },
 };
 
@@ -139,6 +142,7 @@ wincaps  wincap_10_1507 __attribute__((section (".cygwin_dll_common"), shared))
     has_linux_tcp_keepalive_sockopts:false,
     has_tcp_maxrtms:false,
     has_query_process_handle_info:true,
+    has_con_broken_tabs:false,
   },
 };
 
@@ -170,6 +174,7 @@ wincaps  wincap_10_1607 __attribute__((section (".cygwin_dll_common"), shared))
     has_linux_tcp_keepalive_sockopts:false,
     has_tcp_maxrtms:true,
     has_query_process_handle_info:true,
+    has_con_broken_tabs:false,
   },
 };
 
@@ -201,6 +206,7 @@ wincaps wincap_10_1703 __attribute__((section (".cygwin_dll_common"), shared)) =
     has_linux_tcp_keepalive_sockopts:false,
     has_tcp_maxrtms:true,
     has_query_process_handle_info:true,
+    has_con_broken_tabs:true,
   },
 };
 
@@ -232,6 +238,7 @@ wincaps wincap_10_1709 __attribute__((section (".cygwin_dll_common"), shared)) =
     has_linux_tcp_keepalive_sockopts:true,
     has_tcp_maxrtms:true,
     has_query_process_handle_info:true,
+    has_con_broken_tabs:true,
   },
 };
 
@@ -263,6 +270,7 @@ wincaps wincap_10_1803 __attribute__((section (".cygwin_dll_common"), shared)) =
     has_linux_tcp_keepalive_sockopts:true,
     has_tcp_maxrtms:true,
     has_query_process_handle_info:true,
+    has_con_broken_tabs:true,
   },
 };
 
@@ -294,6 +302,7 @@ wincaps wincap_10_1809 __attribute__((section (".cygwin_dll_common"), shared)) =
     has_linux_tcp_keepalive_sockopts:true,
     has_tcp_maxrtms:true,
     has_query_process_handle_info:true,
+    has_con_broken_tabs:true,
   },
 };
 
@@ -325,6 +334,7 @@ wincaps wincap_10_1903 __attribute__((section (".cygwin_dll_common"), shared)) =
     has_linux_tcp_keepalive_sockopts:true,
     has_tcp_maxrtms:true,
     has_query_process_handle_info:true,
+    has_con_broken_tabs:true,
   },
 };
 
@@ -356,6 +366,39 @@ wincaps wincap_10_2004 __attribute__((section (".cygwin_dll_common"), shared)) =
     has_linux_tcp_keepalive_sockopts:true,
     has_tcp_maxrtms:true,
     has_query_process_handle_info:true,
+    has_con_broken_tabs:true,
+  },
+};
+
+wincaps wincap_11 __attribute__((section (".cygwin_dll_common"), shared)) = {
+  def_guard_pages:2,
+  mmap_storage_high:0x700000000000LL,
+  {
+    is_server:false,
+    needs_query_information:false,
+    has_gaa_largeaddress_bug:false,
+    has_precise_system_time:true,
+    has_microsoft_accounts:true,
+    has_broken_prefetchvm:false,
+    has_new_pebteb_region:true,
+    has_broken_whoami:false,
+    has_unprivileged_createsymlink:true,
+    has_precise_interrupt_time:true,
+    has_posix_unlink_semantics:true,
+    has_posix_unlink_semantics_with_ignore_readonly:true,
+    has_case_sensitive_dirs:true,
+    has_posix_rename_semantics:true,
+    no_msv1_0_s4u_logon_in_wow64:false,
+    has_con_24bit_colors:true,
+    has_con_broken_csi3j:false,
+    has_con_broken_il_dl:false,
+    has_con_esc_rep:true,
+    has_extended_mem_api:true,
+    has_tcp_fastopen:true,
+    has_linux_tcp_keepalive_sockopts:true,
+    has_tcp_maxrtms:true,
+    has_query_process_handle_info:true,
+    has_con_broken_tabs:false,
   },
 };
 
@@ -396,7 +439,9 @@ wincapc::init ()
 	break;
       case 10:
       default:
-	if (likely (version.dwBuildNumber >= 19041))
+	if (likely (version.dwBuildNumber >= 22000))
+	  caps = &wincap_11;
+	else if (version.dwBuildNumber >= 19041)
 	  caps = &wincap_10_2004;
 	else if (version.dwBuildNumber >= 18362)
 	  caps = &wincap_10_1903;
diff --git a/winsup/cygwin/wincap.h b/winsup/cygwin/wincap.h
index ba9a3b59d..1602ed6e1 100644
--- a/winsup/cygwin/wincap.h
+++ b/winsup/cygwin/wincap.h
@@ -40,6 +40,7 @@ struct wincaps
     unsigned has_linux_tcp_keepalive_sockopts			: 1;
     unsigned has_tcp_maxrtms					: 1;
     unsigned has_query_process_handle_info			: 1;
+    unsigned has_con_broken_tabs				: 1;
   };
 };
 
@@ -103,6 +104,7 @@ public:
   bool	IMPLEMENT (has_linux_tcp_keepalive_sockopts)
   bool	IMPLEMENT (has_tcp_maxrtms)
   bool	IMPLEMENT (has_query_process_handle_info)
+  bool	IMPLEMENT (has_con_broken_tabs)
 
   void disable_case_sensitive_dirs ()
   {
-- 
2.35.1

