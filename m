Return-Path: <ben@wijen.net>
Received: from 8.mo68.mail-out.ovh.net (8.mo68.mail-out.ovh.net
 [46.105.74.219])
 by sourceware.org (Postfix) with ESMTPS id 893B6396EC8C
 for <cygwin-patches@cygwin.com>; Wed, 20 Jan 2021 16:11:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 893B6396EC8C
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=wijen.net
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ben@wijen.net
Received: from player772.ha.ovh.net (unknown [10.108.57.18])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 2F5681891BF
 for <cygwin-patches@cygwin.com>; Wed, 20 Jan 2021 17:11:09 +0100 (CET)
Received: from wijen.net (80-112-22-40.cable.dynamic.v4.ziggo.nl
 [80.112.22.40]) (Authenticated sender: ben@wijen.net)
 by player772.ha.ovh.net (Postfix) with ESMTPSA id 307A31A4B383F;
 Wed, 20 Jan 2021 16:11:06 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R00208c8d54a-2b0f-4cff-a2d5-dded8243c2ae,
 8CFA42CD5E5EA73EE1AEF67635B773D7FE4E734C) smtp.auth=ben@wijen.net
X-OVh-ClientIp: 80.112.22.40
From: Ben Wijen <ben@wijen.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 3/8] Cygwin: Move post-dir unlink check
Date: Wed, 20 Jan 2021 17:10:51 +0100
Message-Id: <20210120161056.77784-4-ben@wijen.net>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210115134534.13290-1-ben@wijen.net>
References: <20210115134534.13290-1-ben@wijen.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 6204834387383109380
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledruddvgdekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuvghnucghihhjvghnuceosggvnhesfihijhgvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepieelvddtjeffgeetjeduffegkeeltdetffektdfgvdejledugfeffefgfeefffeknecukfhppedtrddtrddtrddtpdektddrudduvddrvddvrdegtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepsggvnhesfihijhgvnhdrnhgvthdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL,
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
X-List-Received-Date: Wed, 20 Jan 2021 16:11:11 -0000

Move post-dir unlink check from fhandler_disk_file::rmdir to
_unlink_nt_post_dir_check

If a directory is not removed through fhandler_disk_file::rmdir
we can now make sure the post dir check is performed.
---
 winsup/cygwin/fhandler_disk_file.cc | 20 --------------------
 winsup/cygwin/syscalls.cc           | 28 ++++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_disk_file.cc
index 885b59161..07f9c513a 100644
--- a/winsup/cygwin/fhandler_disk_file.cc
+++ b/winsup/cygwin/fhandler_disk_file.cc
@@ -1852,26 +1852,6 @@ fhandler_disk_file::rmdir ()
 
   NTSTATUS status = unlink_nt (pc);
 
-  /* Check for existence of remote dirs after trying to delete them.
-     Two reasons:
-     - Sometimes SMB indicates failure when it really succeeds.
-     - Removing a directory on a Samba drive using an old Samba version
-       sometimes doesn't return an error, if the directory can't be removed
-       because it's not empty. */
-  if (isremote ())
-    {
-      OBJECT_ATTRIBUTES attr;
-      FILE_BASIC_INFORMATION fbi;
-      NTSTATUS q_status;
-
-      q_status = NtQueryAttributesFile (pc.get_object_attr (attr, sec_none_nih),
-					&fbi);
-      if (!NT_SUCCESS (status) && q_status == STATUS_OBJECT_NAME_NOT_FOUND)
-	status = STATUS_SUCCESS;
-      else if (pc.fs_is_samba ()
-	       && NT_SUCCESS (status) && NT_SUCCESS (q_status))
-	status = STATUS_DIRECTORY_NOT_EMPTY;
-    }
   if (!NT_SUCCESS (status))
     {
       __seterrno_from_nt_status (status);
diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 54b065733..b220bedae 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -670,6 +670,30 @@ check_dir_not_empty (HANDLE dir, path_conv &pc)
   return STATUS_SUCCESS;
 }
 
+static NTSTATUS
+_unlink_nt_post_dir_check (NTSTATUS status, POBJECT_ATTRIBUTES attr, const path_conv &pc)
+{
+  /* Check for existence of remote dirs after trying to delete them.
+     Two reasons:
+     - Sometimes SMB indicates failure when it really succeeds.
+     - Removing a directory on a Samba drive using an old Samba version
+       sometimes doesn't return an error, if the directory can't be removed
+       because it's not empty. */
+  if (pc.isremote ())
+    {
+      FILE_BASIC_INFORMATION fbi;
+      NTSTATUS q_status;
+
+      q_status = NtQueryAttributesFile (attr, &fbi);
+      if (!NT_SUCCESS (status) && q_status == STATUS_OBJECT_NAME_NOT_FOUND)
+          status = STATUS_SUCCESS;
+      else if (pc.fs_is_samba ()
+               && NT_SUCCESS (status) && NT_SUCCESS (q_status))
+          status = STATUS_DIRECTORY_NOT_EMPTY;
+    }
+  return status;
+}
+
 static NTSTATUS
 _unlink_nt (path_conv &pc, bool shareable)
 {
@@ -1059,6 +1083,10 @@ out:
   /* Stop transaction if we started one. */
   if (trans)
     stop_transaction (status, old_trans, trans);
+
+  if (pc.isdir ())
+    status = _unlink_nt_post_dir_check (status, &attr, pc);
+
   syscall_printf ("%S, return status = %y", pc.get_nt_native_path (), status);
   return status;
 }
-- 
2.30.0

