Return-Path: <ben@wijen.net>
Received: from 6.mo6.mail-out.ovh.net (6.mo6.mail-out.ovh.net [87.98.177.69])
 by sourceware.org (Postfix) with ESMTPS id C4720396ECA0
 for <cygwin-patches@cygwin.com>; Wed, 20 Jan 2021 16:11:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C4720396ECA0
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=wijen.net
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ben@wijen.net
Received: from player772.ha.ovh.net (unknown [10.110.103.168])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 73EDA2395BA
 for <cygwin-patches@cygwin.com>; Wed, 20 Jan 2021 17:11:16 +0100 (CET)
Received: from wijen.net (80-112-22-40.cable.dynamic.v4.ziggo.nl
 [80.112.22.40]) (Authenticated sender: ben@wijen.net)
 by player772.ha.ovh.net (Postfix) with ESMTPSA id 15A011A4B38D3;
 Wed, 20 Jan 2021 16:11:14 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R002c769058a-cc5b-42c4-981e-f2fa64f5451c,
 8CFA42CD5E5EA73EE1AEF67635B773D7FE4E734C) smtp.auth=ben@wijen.net
X-OVh-ClientIp: 80.112.22.40
From: Ben Wijen <ben@wijen.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 6/8] syscalls.cc: Expose shallow-pathconv unlink_nt
Date: Wed, 20 Jan 2021 17:10:54 +0100
Message-Id: <20210120161056.77784-7-ben@wijen.net>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210115134534.13290-1-ben@wijen.net>
References: <20210115134534.13290-1-ben@wijen.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 6207086189552682756
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledruddvgdekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuvghnucghihhjvghnuceosggvnhesfihijhgvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepieelvddtjeffgeetjeduffegkeeltdetffektdfgvdejledugfeffefgfeefffeknecukfhppedtrddtrddtrddtpdektddrudduvddrvddvrdegtdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepsggvnhesfihijhgvnhdrnhgvthdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Wed, 20 Jan 2021 16:11:24 -0000

Not having to query file information improves unlink speed.
---
 winsup/cygwin/syscalls.cc | 78 ++++++++++++++++++++++++++-------------
 1 file changed, 52 insertions(+), 26 deletions(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index ab0c4c2d6..b5ab6ac5e 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -1272,6 +1272,28 @@ _unlink_ntpc_ (path_conv& pc, bool shareable)
   return status;
 }
 
+NTSTATUS
+unlink_nt (const char *ourname, ULONG eflags)
+{
+  uint32_t opt = PC_SYM_NOFOLLOW | PC_SKIP_SYM_CHECK | PC_SKIP_FS_CHECK;
+  if (!(eflags & FILE_NON_DIRECTORY_FILE))
+    opt &= ~PC_SKIP_FS_CHECK;
+
+  path_conv pc (ourname, opt, NULL);
+  if (pc.error || pc.isspecial ())
+    return STATUS_CANNOT_DELETE;
+
+  OBJECT_ATTRIBUTES attr;
+  PUNICODE_STRING ntpath = pc.get_nt_native_path ();
+  InitializeObjectAttributes(&attr, ntpath, 0, NULL, NULL);
+  NTSTATUS status = _unlink_nt (&attr, eflags);
+
+  if (!(eflags & FILE_NON_DIRECTORY_FILE))
+    status = _unlink_nt_post_dir_check (status, &attr, pc);
+
+  return status;
+}
+
 NTSTATUS
 unlink_ntpc (path_conv &pc)
 {
@@ -1289,37 +1311,41 @@ unlink (const char *ourname)
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
2.30.0

