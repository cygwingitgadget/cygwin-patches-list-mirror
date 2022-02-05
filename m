Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id B1D443858D28
 for <cygwin-patches@cygwin.com>; Sat,  5 Feb 2022 08:08:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org B1D443858D28
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 21587TkN023407;
 Sat, 5 Feb 2022 17:07:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 21587TkN023407
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1644048466;
 bh=EtdysO1LWTQOp9+/DbF7f4an+hF2lFTkysBdGJY9PCE=;
 h=From:To:Cc:Subject:Date:From;
 b=Xc3C8UAW7C43+DpyvjrJLza+Ji6T3RItu4utuLByI9Q3rz1VA/883DTzYrbk9csyO
 sr63QrNAn9vtbi06eC2Qd+NYdL8ugLcGQ9Wt6JHdxVmQekvlJurPbqzLWPq8wzWsLL
 n5Uf7j0VcHb+wDrsPKWubiCKkoqoi4HSuNHYfWUmKB3qn5tgJmh1SP556XFiYaHS0q
 ley6qcnftXUj+tXKPviheU8/YK7LA8r+bYtvjU+7LIQ798LSHz1yRFP2rRoQK/mWgt
 4CWoRGpq+kR8V/ztCu/mY1JkAY+SodJtr9wlR85rhK2dMS2zlX7C2QWTEzZ3417ikv
 7j8aURO9X3u0A==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: wincap: Add capabilities for Windows 10 2004 and
 newer.
Date: Sat,  5 Feb 2022 17:07:19 +0900
Message-Id: <20220205080719.928-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Sat, 05 Feb 2022 08:08:03 -0000

- The capability changes since Windows 10 2004 have been reflected
  in wincap.cc. (has_con_broken_il_dl has been changed to false.)
---
 winsup/cygwin/wincap.cc | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/wincap.cc b/winsup/cygwin/wincap.cc
index 83a49eb8e..b8376b8ed 100644
--- a/winsup/cygwin/wincap.cc
+++ b/winsup/cygwin/wincap.cc
@@ -328,6 +328,37 @@ wincaps wincap_10_1903 __attribute__((section (".cygwin_dll_common"), shared)) =
   },
 };
 
+wincaps wincap_10_2004 __attribute__((section (".cygwin_dll_common"), shared)) = {
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
+  },
+};
+
 wincapc wincap __attribute__((section (".cygwin_dll_common"), shared));
 
 void
@@ -365,7 +396,9 @@ wincapc::init ()
 	break;
       case 10:
       default:
-	if (likely (version.dwBuildNumber >= 18362))
+	if (likely (version.dwBuildNumber >= 19041))
+	  caps = &wincap_10_2004;
+	else if (version.dwBuildNumber >= 18362)
 	  caps = &wincap_10_1903;
 	else if (version.dwBuildNumber >= 17763)
 	  caps = &wincap_10_1809;
-- 
2.35.1

