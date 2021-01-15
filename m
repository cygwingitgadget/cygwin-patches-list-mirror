Return-Path: <ben@wijen.net>
Received: from 4.mo69.mail-out.ovh.net (4.mo69.mail-out.ovh.net
 [46.105.42.102])
 by sourceware.org (Postfix) with ESMTPS id CE7BE3985811
 for <cygwin-patches@cygwin.com>; Fri, 15 Jan 2021 13:46:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org CE7BE3985811
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=wijen.net
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ben@wijen.net
Received: from player772.ha.ovh.net (unknown [10.108.54.59])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id C3619A693B
 for <cygwin-patches@cygwin.com>; Fri, 15 Jan 2021 14:46:06 +0100 (CET)
Received: from wijen.net (80-112-22-40.cable.dynamic.v4.ziggo.nl
 [80.112.22.40]) (Authenticated sender: ben@wijen.net)
 by player772.ha.ovh.net (Postfix) with ESMTPSA id 66F581A220259;
 Fri, 15 Jan 2021 13:46:04 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G006c07f87ed-488b-4d12-92ec-3b5379009268,
 A7E4B4729D754038BE6A0219279DD51DC757EBD6) smtp.auth=ben@wijen.net
X-OVh-ClientIp: 80.112.22.40
From: Ben Wijen <ben@wijen.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH 10/11] syscalls.cc: Expose shallow-pathconv unlink_nt
Date: Fri, 15 Jan 2021 14:45:33 +0100
Message-Id: <20210115134534.13290-11-ben@wijen.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210115134534.13290-1-ben@wijen.net>
References: <20210115134534.13290-1-ben@wijen.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11285457717005797124
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrtddvgdefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuvghnucghihhjvghnuceosggvnhesfihijhgvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepieelvddtjeffgeetjeduffegkeeltdetffektdfgvdejledugfeffefgfeefffeknecukfhppedtrddtrddtrddtpdektddrudduvddrvddvrdegtdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepsggvnhesfihijhgvnhdrnhgvthdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-Spam-Status: No, score=-13.3 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE,
 SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Fri, 15 Jan 2021 13:46:09 -0000

Not having to query file information improves unlink speed.
---
 winsup/cygwin/syscalls.cc | 68 ++++++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 26 deletions(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 79e4a4422..8aecdf453 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -1305,6 +1305,18 @@ _unlink_ntpc_ (path_conv& pc, bool shareable)
   return status;
 }
 
+NTSTATUS
+unlink_nt (const char *ourname, ULONG eflags)
+{
+  path_conv pc (ourname, PC_SYM_NOFOLLOW | PC_FS_USE_PREFIX_HASH | PC_SKIP_SYM_CHECK, NULL);
+  dev_t devn = pc.get_device ();
+  if (pc.error || isproc_dev (devn))
+    return STATUS_CANNOT_DELETE;
+
+  PUNICODE_STRING ntpath = pc.get_nt_native_path ();
+  return _unlink_nt (ntpath, eflags, 0);
+}
+
 NTSTATUS
 unlink_ntpc (path_conv &pc)
 {
@@ -1322,37 +1334,41 @@ unlink (const char *ourname)
 {
   int res = -1;
   dev_t devn;
-  NTSTATUS status;
+  NTSTATUS status = unlink_nt (ourname, FILE_NON_DIRECTORY_FILE);
 
-  path_conv win32_name (ourname, PC_SYM_NOFOLLOW, stat_suffixes);
+  if (!NT_SUCCESS (status))
+  {
+    path_conv win32_name (ourname, PC_SYM_NOFOLLOW, stat_suffixes);
 
-  if (win32_name.error)
-    {
-      set_errno (win32_name.error);
-      goto done;
-    }
+    if (win32_name.error)
+      {
+        set_errno (win32_name.error);
+        goto done;
+      }
 
-  devn = win32_name.get_device ();
-  if (isproc_dev (devn))
-    {
-      set_errno (EROFS);
-      goto done;
-    }
+    devn = win32_name.get_device ();
+    if (isproc_dev (devn))
+      {
+        set_errno (EROFS);
+        goto done;
+      }
 
-  if (!win32_name.exists ())
-    {
-      debug_printf ("unlinking a nonexistent file");
-      set_errno (ENOENT);
-      goto done;
-    }
-  else if (win32_name.isdir ())
-    {
-      debug_printf ("unlinking a directory");
-      set_errno (EISDIR);
-      goto done;
-    }
+    if (!win32_name.exists ())
+      {
+        debug_printf ("unlinking a nonexistent file");
+        set_errno (ENOENT);
+        goto done;
+      }
+    else if (win32_name.isdir ())
+      {
+        debug_printf ("unlinking a directory");
+        set_errno (EISDIR);
+        goto done;
+      }
+
+    status = unlink_ntpc (win32_name);
+  }
 
-  status = unlink_ntpc (win32_name);
   if (NT_SUCCESS (status))
     res = 0;
   else
-- 
2.29.2

