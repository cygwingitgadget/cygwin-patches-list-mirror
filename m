Return-Path: <cygwin-patches-return-9930-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7442 invoked by alias); 14 Jan 2020 01:54:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 7432 invoked by uid 89); 14 Jan 2020 01:54:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=caps, screen
X-HELO: conuserg-04.nifty.com
Received: from conuserg-04.nifty.com (HELO conuserg-04.nifty.com) (210.131.2.71) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 14 Jan 2020 01:54:30 +0000
Received: from localhost.localdomain (ntsitm247158.sitm.nt.ngn.ppp.infoweb.ne.jp [124.27.253.158]) (authenticated)	by conuserg-04.nifty.com with ESMTP id 00E1s9Gv027420;	Tue, 14 Jan 2020 10:54:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-04.nifty.com 00E1s9Gv027420
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1578966854;	bh=7pTbFCyg0w0TUbiBL59tAAvAvObVcBTyBlGVL0xUauU=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=UaqZNrZAdSpXqulk5PmLSoFGmGGXeacHM4whK8UwBiQ8/+gLMQPbTTEazmhfPku1x	 tosBicAzzd3Kud3QLoQRcmUbuW4e80i4L10yjBhSDbNQm1HV0fLamfcf6J3iuq0mAV	 CNKcQk+oajHU5FaFMMiv3oqVayITXRQIiWQ1TE1aXl8JY9jJ92tdBl9DhtWoe8u/vP	 MtUAO7qfd9YtH6DnmjavBOEd4JtAZ2iK5HUIk1ZxKsHnzlMt2zm1EC62088tcZwofl	 lB4Ym7la3Ui58tiPfZIhIdJSgLQTskyH5zg0qKbGhkhsQH/Iiw0nUj1jLnwzQQ7xgt	 rOi8QjkSbmPrw==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2] Cygwin: console: Add workaround for broken CSI3J in Win10 1809.
Date: Tue, 14 Jan 2020 01:54:00 -0000
Message-Id: <20200114015359.1545-1-takashi.yano@nifty.ne.jp>
In-Reply-To: <20200113161506.GN5858@calimero.vinschen.de>
References: <20200113161506.GN5858@calimero.vinschen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00036.txt

- In Win10 1809, the cursor position sometimes goes out of screen
  by clear command in console. This seems to be caused by escape
  sequence CSI3J (ESC[3J). This happens only for 1809. This patch
  is a workaround for the issue.
---
 winsup/cygwin/fhandler_console.cc | 12 +++++++++
 winsup/cygwin/wincap.cc           | 41 ++++++++++++++++++++++++++++++-
 winsup/cygwin/wincap.h            |  2 ++
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index b286c6c10..8591f579d 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -1669,6 +1669,18 @@ bool fhandler_console::write_console (PWCHAR buf, DWORD len, DWORD& done)
   if (wincap.has_con_24bit_colors () && !con_is_legacy
       && memmem (buf, len*sizeof (WCHAR), L"\033[?1049", 7*sizeof (WCHAR)))
     need_fix_tab_position = true;
+  /* Workaround for broken CSI3J (ESC[3J) support in xterm compatible mode. */
+  if (wincap.has_con_24bit_colors () && !con_is_legacy &&
+      wincap.has_con_broken_csi3j ())
+    {
+      WCHAR *p = buf;
+      while ((p = (WCHAR *) memmem (p, (len - (p - buf))*sizeof (WCHAR),
+				    L"\033[3J", 4*sizeof (WCHAR))))
+	{
+	  memmove (p, p+4, (len - (p+4 - buf))*sizeof (WCHAR));
+	  len -= 4;
+	}
+    }
 
   if (con.iso_2022_G1
 	? con.vt100_graphics_mode_G1
diff --git a/winsup/cygwin/wincap.cc b/winsup/cygwin/wincap.cc
index 5c6e6428e..a52262b89 100644
--- a/winsup/cygwin/wincap.cc
+++ b/winsup/cygwin/wincap.cc
@@ -42,6 +42,7 @@ wincaps wincap_vista __attribute__((section (".cygwin_dll_common"), shared)) = {
     has_posix_rename_semantics:false,
     no_msv1_0_s4u_logon_in_wow64:true,
     has_con_24bit_colors:false,
+    has_con_broken_csi3j:false,
   },
 };
 
@@ -69,6 +70,7 @@ wincaps wincap_7 __attribute__((section (".cygwin_dll_common"), shared)) = {
     has_posix_rename_semantics:false,
     no_msv1_0_s4u_logon_in_wow64:true,
     has_con_24bit_colors:false,
+    has_con_broken_csi3j:false,
   },
 };
 
@@ -96,6 +98,7 @@ wincaps wincap_8 __attribute__((section (".cygwin_dll_common"), shared)) = {
     has_posix_rename_semantics:false,
     no_msv1_0_s4u_logon_in_wow64:false,
     has_con_24bit_colors:false,
+    has_con_broken_csi3j:false,
   },
 };
 
@@ -123,6 +126,7 @@ wincaps wincap_8_1 __attribute__((section (".cygwin_dll_common"), shared)) = {
     has_posix_rename_semantics:false,
     no_msv1_0_s4u_logon_in_wow64:false,
     has_con_24bit_colors:false,
+    has_con_broken_csi3j:false,
   },
 };
 
@@ -150,6 +154,7 @@ wincaps  wincap_10_1507 __attribute__((section (".cygwin_dll_common"), shared))
     has_posix_rename_semantics:false,
     no_msv1_0_s4u_logon_in_wow64:false,
     has_con_24bit_colors:false,
+    has_con_broken_csi3j:false,
   },
 };
 
@@ -177,6 +182,7 @@ wincaps wincap_10_1703 __attribute__((section (".cygwin_dll_common"), shared)) =
     has_posix_rename_semantics:false,
     no_msv1_0_s4u_logon_in_wow64:false,
     has_con_24bit_colors:true,
+    has_con_broken_csi3j:false,
   },
 };
 
@@ -204,6 +210,7 @@ wincaps wincap_10_1709 __attribute__((section (".cygwin_dll_common"), shared)) =
     has_posix_rename_semantics:false,
     no_msv1_0_s4u_logon_in_wow64:false,
     has_con_24bit_colors:true,
+    has_con_broken_csi3j:false,
   },
 };
 
@@ -231,6 +238,7 @@ wincaps wincap_10_1803 __attribute__((section (".cygwin_dll_common"), shared)) =
     has_posix_rename_semantics:false,
     no_msv1_0_s4u_logon_in_wow64:false,
     has_con_24bit_colors:true,
+    has_con_broken_csi3j:false,
   },
 };
 
@@ -258,6 +266,35 @@ wincaps wincap_10_1809 __attribute__((section (".cygwin_dll_common"), shared)) =
     has_posix_rename_semantics:true,
     no_msv1_0_s4u_logon_in_wow64:false,
     has_con_24bit_colors:true,
+    has_con_broken_csi3j:true,
+  },
+};
+
+wincaps wincap_10_1903 __attribute__((section (".cygwin_dll_common"), shared)) = {
+  def_guard_pages:2,
+  mmap_storage_high:0x700000000000LL,
+  {
+    is_server:false,
+    needs_count_in_si_lpres2:false,
+    needs_query_information:false,
+    has_gaa_largeaddress_bug:false,
+    has_broken_alloc_console:true,
+    has_console_logon_sid:true,
+    has_precise_system_time:true,
+    has_microsoft_accounts:true,
+    has_processor_groups:true,
+    has_broken_prefetchvm:false,
+    has_new_pebteb_region:true,
+    has_broken_whoami:false,
+    has_unprivileged_createsymlink:true,
+    has_unbiased_interrupt_time:true,
+    has_precise_interrupt_time:true,
+    has_posix_unlink_semantics:true,
+    has_case_sensitive_dirs:true,
+    has_posix_rename_semantics:true,
+    no_msv1_0_s4u_logon_in_wow64:false,
+    has_con_24bit_colors:true,
+    has_con_broken_csi3j:false,
   },
 };
 
@@ -301,7 +338,9 @@ wincapc::init ()
 	break;
       case 10:
       default:
-	if (likely (version.dwBuildNumber >= 17763))
+	if (likely (version.dwBuildNumber >= 18362))
+	  caps = &wincap_10_1903;
+	else if (version.dwBuildNumber >= 17763)
 	  caps = &wincap_10_1809;
 	else if (version.dwBuildNumber >= 17134)
 	  caps = &wincap_10_1803;
diff --git a/winsup/cygwin/wincap.h b/winsup/cygwin/wincap.h
index ba01a1565..11902d976 100644
--- a/winsup/cygwin/wincap.h
+++ b/winsup/cygwin/wincap.h
@@ -36,6 +36,7 @@ struct wincaps
     unsigned has_posix_rename_semantics		: 1;
     unsigned no_msv1_0_s4u_logon_in_wow64	: 1;
     unsigned has_con_24bit_colors		: 1;
+    unsigned has_con_broken_csi3j		: 1;
   };
 };
 
@@ -95,6 +96,7 @@ public:
   bool	IMPLEMENT (has_posix_rename_semantics)
   bool	IMPLEMENT (no_msv1_0_s4u_logon_in_wow64)
   bool	IMPLEMENT (has_con_24bit_colors)
+  bool	IMPLEMENT (has_con_broken_csi3j)
 
   void disable_case_sensitive_dirs ()
   {
-- 
2.21.0
