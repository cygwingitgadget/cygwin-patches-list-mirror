Return-Path: <ben@wijen.net>
Received: from 14.mo6.mail-out.ovh.net (14.mo6.mail-out.ovh.net
 [46.105.56.113])
 by sourceware.org (Postfix) with ESMTPS id E64E7385480F
 for <cygwin-patches@cygwin.com>; Wed, 20 Jan 2021 16:11:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E64E7385480F
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=wijen.net
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ben@wijen.net
Received: from player772.ha.ovh.net (unknown [10.108.4.73])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id B5F15230AA7
 for <cygwin-patches@cygwin.com>; Wed, 20 Jan 2021 17:11:03 +0100 (CET)
Received: from wijen.net (80-112-22-40.cable.dynamic.v4.ziggo.nl
 [80.112.22.40]) (Authenticated sender: ben@wijen.net)
 by player772.ha.ovh.net (Postfix) with ESMTPSA id 9A3941A4B37CB;
 Wed, 20 Jan 2021 16:11:00 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R0024ea42e8c-7943-4738-8dfe-d0c70ae1e62e,
 8CFA42CD5E5EA73EE1AEF67635B773D7FE4E734C) smtp.auth=ben@wijen.net
X-OVh-ClientIp: 80.112.22.40
From: Ben Wijen <ben@wijen.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 1/8] syscalls.cc: unlink_nt: Try
 FILE_DISPOSITION_IGNORE_READONLY_ATTRIBUTE
Date: Wed, 20 Jan 2021 17:10:49 +0100
Message-Id: <20210120161056.77784-2-ben@wijen.net>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210115134534.13290-1-ben@wijen.net>
References: <20210115134534.13290-1-ben@wijen.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 6203427012573415172
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledruddvgdekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuvghnucghihhjvghnuceosggvnhesfihijhgvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepieelvddtjeffgeetjeduffegkeeltdetffektdfgvdejledugfeffefgfeefffeknecukfhppedtrddtrddtrddtpdektddrudduvddrvddvrdegtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepsggvnhesfihijhgvnhdrnhgvthdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Wed, 20 Jan 2021 16:11:06 -0000

Implement wincap.has_posix_unlink_semantics_with_ignore_readonly and when set
skip setting/clearing of READONLY attribute and instead use
FILE_DISPOSITION_IGNORE_READONLY_ATTRIBUTE
---
 winsup/cygwin/ntdll.h     |  3 ++-
 winsup/cygwin/syscalls.cc | 14 +++++-----
 winsup/cygwin/wincap.cc   | 11 ++++++++
 winsup/cygwin/wincap.h    | 56 ++++++++++++++++++++-------------------
 4 files changed, 49 insertions(+), 35 deletions(-)

diff --git a/winsup/cygwin/ntdll.h b/winsup/cygwin/ntdll.h
index d4f6aaf45..7eee383dd 100644
--- a/winsup/cygwin/ntdll.h
+++ b/winsup/cygwin/ntdll.h
@@ -497,7 +497,8 @@ enum {
   FILE_DISPOSITION_DELETE				= 0x01,
   FILE_DISPOSITION_POSIX_SEMANTICS			= 0x02,
   FILE_DISPOSITION_FORCE_IMAGE_SECTION_CHECK		= 0x04,
-  FILE_DISPOSITION_ON_CLOSE				= 0x08
+  FILE_DISPOSITION_ON_CLOSE				= 0x08,
+  FILE_DISPOSITION_IGNORE_READONLY_ATTRIBUTE		= 0x10,
 };
 
 enum
diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 4742c6653..2e50ad7d5 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -709,14 +709,11 @@ _unlink_nt (path_conv &pc, bool shareable)
 			   flags);
       if (!NT_SUCCESS (status))
 	goto out;
-      /* Why didn't the devs add a FILE_DELETE_IGNORE_READONLY_ATTRIBUTE
-	 flag just like they did with FILE_LINK_IGNORE_READONLY_ATTRIBUTE
-	 and FILE_LINK_IGNORE_READONLY_ATTRIBUTE???
-
-         POSIX unlink semantics are nice, but they still fail if the file
+      /* POSIX unlink semantics are nice, but they still fail if the file
 	 has the R/O attribute set.  Removing the file is very much a safe
 	 bet afterwards, so, no transaction. */
-      if (pc.file_attributes () & FILE_ATTRIBUTE_READONLY)
+      if (!wincap.has_posix_unlink_semantics_with_ignore_readonly ()
+          && (pc.file_attributes () & FILE_ATTRIBUTE_READONLY))
 	{
 	  status = NtSetAttributesFile (fh, pc.file_attributes ()
 					    & ~FILE_ATTRIBUTE_READONLY);
@@ -727,10 +724,13 @@ _unlink_nt (path_conv &pc, bool shareable)
 	    }
 	}
       fdie.Flags = FILE_DISPOSITION_DELETE | FILE_DISPOSITION_POSIX_SEMANTICS;
+      if(wincap.has_posix_unlink_semantics_with_ignore_readonly ())
+          fdie.Flags |= FILE_DISPOSITION_IGNORE_READONLY_ATTRIBUTE;
       status = NtSetInformationFile (fh, &io, &fdie, sizeof fdie,
 				     FileDispositionInformationEx);
       /* Restore R/O attribute in case we have multiple hardlinks. */
-      if (pc.file_attributes () & FILE_ATTRIBUTE_READONLY)
+      if (!wincap.has_posix_unlink_semantics_with_ignore_readonly ()
+          && (pc.file_attributes () & FILE_ATTRIBUTE_READONLY))
 	NtSetAttributesFile (fh, pc.file_attributes ());
       NtClose (fh);
       /* Trying to delete in-use executables and DLLs using
diff --git a/winsup/cygwin/wincap.cc b/winsup/cygwin/wincap.cc
index b18e732cd..635e0892b 100644
--- a/winsup/cygwin/wincap.cc
+++ b/winsup/cygwin/wincap.cc
@@ -38,6 +38,7 @@ wincaps wincap_vista __attribute__((section (".cygwin_dll_common"), shared)) = {
     has_unbiased_interrupt_time:false,
     has_precise_interrupt_time:false,
     has_posix_unlink_semantics:false,
+    has_posix_unlink_semantics_with_ignore_readonly:false,
     has_case_sensitive_dirs:false,
     has_posix_rename_semantics:false,
     no_msv1_0_s4u_logon_in_wow64:true,
@@ -72,6 +73,7 @@ wincaps wincap_7 __attribute__((section (".cygwin_dll_common"), shared)) = {
     has_unbiased_interrupt_time:true,
     has_precise_interrupt_time:false,
     has_posix_unlink_semantics:false,
+    has_posix_unlink_semantics_with_ignore_readonly:false,
     has_case_sensitive_dirs:false,
     has_posix_rename_semantics:false,
     no_msv1_0_s4u_logon_in_wow64:true,
@@ -106,6 +108,7 @@ wincaps wincap_8 __attribute__((section (".cygwin_dll_common"), shared)) = {
     has_unbiased_interrupt_time:true,
     has_precise_interrupt_time:false,
     has_posix_unlink_semantics:false,
+    has_posix_unlink_semantics_with_ignore_readonly:false,
     has_case_sensitive_dirs:false,
     has_posix_rename_semantics:false,
     no_msv1_0_s4u_logon_in_wow64:false,
@@ -140,6 +143,7 @@ wincaps wincap_8_1 __attribute__((section (".cygwin_dll_common"), shared)) = {
     has_unbiased_interrupt_time:true,
     has_precise_interrupt_time:false,
     has_posix_unlink_semantics:false,
+    has_posix_unlink_semantics_with_ignore_readonly:false,
     has_case_sensitive_dirs:false,
     has_posix_rename_semantics:false,
     no_msv1_0_s4u_logon_in_wow64:false,
@@ -174,6 +178,7 @@ wincaps  wincap_10_1507 __attribute__((section (".cygwin_dll_common"), shared))
     has_unbiased_interrupt_time:true,
     has_precise_interrupt_time:true,
     has_posix_unlink_semantics:false,
+    has_posix_unlink_semantics_with_ignore_readonly:false,
     has_case_sensitive_dirs:false,
     has_posix_rename_semantics:false,
     no_msv1_0_s4u_logon_in_wow64:false,
@@ -208,6 +213,7 @@ wincaps  wincap_10_1607 __attribute__((section (".cygwin_dll_common"), shared))
     has_unbiased_interrupt_time:true,
     has_precise_interrupt_time:true,
     has_posix_unlink_semantics:false,
+    has_posix_unlink_semantics_with_ignore_readonly:false,
     has_case_sensitive_dirs:false,
     has_posix_rename_semantics:false,
     no_msv1_0_s4u_logon_in_wow64:false,
@@ -242,6 +248,7 @@ wincaps wincap_10_1703 __attribute__((section (".cygwin_dll_common"), shared)) =
     has_unbiased_interrupt_time:true,
     has_precise_interrupt_time:true,
     has_posix_unlink_semantics:false,
+    has_posix_unlink_semantics_with_ignore_readonly:false,
     has_case_sensitive_dirs:false,
     has_posix_rename_semantics:false,
     no_msv1_0_s4u_logon_in_wow64:false,
@@ -276,6 +283,7 @@ wincaps wincap_10_1709 __attribute__((section (".cygwin_dll_common"), shared)) =
     has_unbiased_interrupt_time:true,
     has_precise_interrupt_time:true,
     has_posix_unlink_semantics:true,
+    has_posix_unlink_semantics_with_ignore_readonly:false,
     has_case_sensitive_dirs:false,
     has_posix_rename_semantics:false,
     no_msv1_0_s4u_logon_in_wow64:false,
@@ -310,6 +318,7 @@ wincaps wincap_10_1803 __attribute__((section (".cygwin_dll_common"), shared)) =
     has_unbiased_interrupt_time:true,
     has_precise_interrupt_time:true,
     has_posix_unlink_semantics:true,
+    has_posix_unlink_semantics_with_ignore_readonly:false,
     has_case_sensitive_dirs:true,
     has_posix_rename_semantics:false,
     no_msv1_0_s4u_logon_in_wow64:false,
@@ -344,6 +353,7 @@ wincaps wincap_10_1809 __attribute__((section (".cygwin_dll_common"), shared)) =
     has_unbiased_interrupt_time:true,
     has_precise_interrupt_time:true,
     has_posix_unlink_semantics:true,
+    has_posix_unlink_semantics_with_ignore_readonly:true,
     has_case_sensitive_dirs:true,
     has_posix_rename_semantics:true,
     no_msv1_0_s4u_logon_in_wow64:false,
@@ -378,6 +388,7 @@ wincaps wincap_10_1903 __attribute__((section (".cygwin_dll_common"), shared)) =
     has_unbiased_interrupt_time:true,
     has_precise_interrupt_time:true,
     has_posix_unlink_semantics:true,
+    has_posix_unlink_semantics_with_ignore_readonly:true,
     has_case_sensitive_dirs:true,
     has_posix_rename_semantics:true,
     no_msv1_0_s4u_logon_in_wow64:false,
diff --git a/winsup/cygwin/wincap.h b/winsup/cygwin/wincap.h
index 2f4191aa1..687e51843 100644
--- a/winsup/cygwin/wincap.h
+++ b/winsup/cygwin/wincap.h
@@ -16,33 +16,34 @@ struct wincaps
   /* The bitfields must be 8 byte aligned on x86_64, otherwise the bitfield
      ops generated by gcc are off by 4 bytes. */
   struct  __attribute__ ((aligned (8))) {
-    unsigned is_server				: 1;
-    unsigned needs_count_in_si_lpres2		: 1;
-    unsigned needs_query_information		: 1;
-    unsigned has_gaa_largeaddress_bug		: 1;
-    unsigned has_broken_alloc_console		: 1;
-    unsigned has_console_logon_sid		: 1;
-    unsigned has_precise_system_time		: 1;
-    unsigned has_microsoft_accounts		: 1;
-    unsigned has_processor_groups		: 1;
-    unsigned has_broken_prefetchvm		: 1;
-    unsigned has_new_pebteb_region		: 1;
-    unsigned has_broken_whoami			: 1;
-    unsigned has_unprivileged_createsymlink	: 1;
-    unsigned has_unbiased_interrupt_time	: 1;
-    unsigned has_precise_interrupt_time		: 1;
-    unsigned has_posix_unlink_semantics		: 1;
-    unsigned has_case_sensitive_dirs		: 1;
-    unsigned has_posix_rename_semantics		: 1;
-    unsigned no_msv1_0_s4u_logon_in_wow64	: 1;
-    unsigned has_con_24bit_colors		: 1;
-    unsigned has_con_broken_csi3j		: 1;
-    unsigned has_con_broken_il_dl		: 1;
-    unsigned has_con_esc_rep			: 1;
-    unsigned has_extended_mem_api		: 1;
-    unsigned has_tcp_fastopen			: 1;
-    unsigned has_linux_tcp_keepalive_sockopts	: 1;
-    unsigned has_tcp_maxrtms			: 1;
+    unsigned is_server						: 1;
+    unsigned needs_count_in_si_lpres2				: 1;
+    unsigned needs_query_information				: 1;
+    unsigned has_gaa_largeaddress_bug				: 1;
+    unsigned has_broken_alloc_console				: 1;
+    unsigned has_console_logon_sid				: 1;
+    unsigned has_precise_system_time				: 1;
+    unsigned has_microsoft_accounts				: 1;
+    unsigned has_processor_groups				: 1;
+    unsigned has_broken_prefetchvm				: 1;
+    unsigned has_new_pebteb_region				: 1;
+    unsigned has_broken_whoami					: 1;
+    unsigned has_unprivileged_createsymlink			: 1;
+    unsigned has_unbiased_interrupt_time			: 1;
+    unsigned has_precise_interrupt_time				: 1;
+    unsigned has_posix_unlink_semantics				: 1;
+    unsigned has_posix_unlink_semantics_with_ignore_readonly	: 1;
+    unsigned has_case_sensitive_dirs				: 1;
+    unsigned has_posix_rename_semantics				: 1;
+    unsigned no_msv1_0_s4u_logon_in_wow64			: 1;
+    unsigned has_con_24bit_colors				: 1;
+    unsigned has_con_broken_csi3j				: 1;
+    unsigned has_con_broken_il_dl				: 1;
+    unsigned has_con_esc_rep					: 1;
+    unsigned has_extended_mem_api				: 1;
+    unsigned has_tcp_fastopen					: 1;
+    unsigned has_linux_tcp_keepalive_sockopts			: 1;
+    unsigned has_tcp_maxrtms					: 1;
   };
 };
 
@@ -98,6 +99,7 @@ public:
   bool	IMPLEMENT (has_unbiased_interrupt_time)
   bool	IMPLEMENT (has_precise_interrupt_time)
   bool	IMPLEMENT (has_posix_unlink_semantics)
+  bool  IMPLEMENT (has_posix_unlink_semantics_with_ignore_readonly)
   bool	IMPLEMENT (has_case_sensitive_dirs)
   bool	IMPLEMENT (has_posix_rename_semantics)
   bool	IMPLEMENT (no_msv1_0_s4u_logon_in_wow64)
-- 
2.30.0

