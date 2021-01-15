Return-Path: <ben@wijen.net>
Received: from 4.mo68.mail-out.ovh.net (4.mo68.mail-out.ovh.net [46.105.59.63])
 by sourceware.org (Postfix) with ESMTPS id 271563973016
 for <cygwin-patches@cygwin.com>; Fri, 15 Jan 2021 13:45:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 271563973016
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=wijen.net
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ben@wijen.net
Received: from player772.ha.ovh.net (unknown [10.108.57.38])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id EBC52188B58
 for <cygwin-patches@cygwin.com>; Fri, 15 Jan 2021 14:45:54 +0100 (CET)
Received: from wijen.net (80-112-22-40.cable.dynamic.v4.ziggo.nl
 [80.112.22.40]) (Authenticated sender: ben@wijen.net)
 by player772.ha.ovh.net (Postfix) with ESMTPSA id 835F01A220179;
 Fri, 15 Jan 2021 13:45:52 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G0066390d31b-9760-43db-a3be-5a17364c9b6e,
 A7E4B4729D754038BE6A0219279DD51DC757EBD6) smtp.auth=ben@wijen.net
X-OVh-ClientIp: 80.112.22.40
From: Ben Wijen <ben@wijen.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH 05/11] Cygwin: Move post-dir unlink check
Date: Fri, 15 Jan 2021 14:45:28 +0100
Message-Id: <20210115134534.13290-6-ben@wijen.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210115134534.13290-1-ben@wijen.net>
References: <20210115134534.13290-1-ben@wijen.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11282080018075633412
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrtddvgdefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuvghnucghihhjvghnuceosggvnhesfihijhgvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepieelvddtjeffgeetjeduffegkeeltdetffektdfgvdejledugfeffefgfeefffeknecukfhppedtrddtrddtrddtpdektddrudduvddrvddvrdegtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepsggvnhesfihijhgvnhdrnhgvthdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-Spam-Status: No, score=-12.9 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Fri, 15 Jan 2021 13:45:57 -0000

Move post-dir unlink check from
fhandler_disk_file::rmdir to _unlink_nt
---
 winsup/cygwin/fhandler_disk_file.cc | 20 --------------------
 winsup/cygwin/syscalls.cc           | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 20 deletions(-)

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
index 043ccdb99..f86a93825 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -1071,6 +1071,27 @@ out:
   /* Stop transaction if we started one. */
   if (trans)
     stop_transaction (status, old_trans, trans);
+
+  /* Check for existence of remote dirs after trying to delete them.
+     Two reasons:
+     - Sometimes SMB indicates failure when it really succeeds.
+     - Removing a directory on a Samba drive using an old Samba version
+       sometimes doesn't return an error, if the directory can't be removed
+       because it's not empty. */
+  if (pc.isdir () && pc.isremote ())
+    {
+      FILE_BASIC_INFORMATION fbi;
+      NTSTATUS q_status;
+
+      pc.get_object_attr (attr, sec_none_nih);
+      q_status = NtQueryAttributesFile (&attr, &fbi);
+      if (!NT_SUCCESS (status) && q_status == STATUS_OBJECT_NAME_NOT_FOUND)
+        status = STATUS_SUCCESS;
+      else if (pc.fs_is_samba ()
+               && NT_SUCCESS (status) && NT_SUCCESS (q_status))
+        status = STATUS_DIRECTORY_NOT_EMPTY;
+    }
+
   syscall_printf ("%S, return status = %y", pc.get_nt_native_path (), status);
   return status;
 }
-- 
2.29.2

