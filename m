Return-Path: <ben@wijen.net>
Received: from 9.mo68.mail-out.ovh.net (9.mo68.mail-out.ovh.net
 [46.105.78.111])
 by sourceware.org (Postfix) with ESMTPS id DA8A2396EC92
 for <cygwin-patches@cygwin.com>; Wed, 20 Jan 2021 16:11:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org DA8A2396EC92
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=wijen.net
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ben@wijen.net
Received: from player772.ha.ovh.net (unknown [10.109.138.180])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id A8FD1188D1F
 for <cygwin-patches@cygwin.com>; Wed, 20 Jan 2021 17:11:11 +0100 (CET)
Received: from wijen.net (80-112-22-40.cable.dynamic.v4.ziggo.nl
 [80.112.22.40]) (Authenticated sender: ben@wijen.net)
 by player772.ha.ovh.net (Postfix) with ESMTPSA id 046571A4B3875;
 Wed, 20 Jan 2021 16:11:08 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R002f990588d-36f5-4fd4-b065-def88287a59f,
 8CFA42CD5E5EA73EE1AEF67635B773D7FE4E734C) smtp.auth=ben@wijen.net
X-OVh-ClientIp: 80.112.22.40
From: Ben Wijen <ben@wijen.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 4/8] syscalls.cc: Implement non-path_conv dependent
 _unlink_nt
Date: Wed, 20 Jan 2021 17:10:52 +0100
Message-Id: <20210120161056.77784-5-ben@wijen.net>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210115134534.13290-1-ben@wijen.net>
References: <20210115134534.13290-1-ben@wijen.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 6205678814438573828
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledruddvgdekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuvghnucghihhjvghnuceosggvnhesfihijhgvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepieelvddtjeffgeetjeduffegkeeltdetffektdfgvdejledugfeffefgfeefffeknecukfhppedtrddtrddtrddtpdektddrudduvddrvddvrdegtdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepsggvnhesfihijhgvnhdrnhgvthdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Wed, 20 Jan 2021 16:11:15 -0000

Implement _unlink_nt: wich does not depend on patch_conv
---
 winsup/cygwin/fhandler_disk_file.cc |   4 +-
 winsup/cygwin/forkable.cc           |   4 +-
 winsup/cygwin/syscalls.cc           | 211 ++++++++++++++++++++++++++--
 3 files changed, 200 insertions(+), 19 deletions(-)

diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_disk_file.cc
index 07f9c513a..fe04f832b 100644
--- a/winsup/cygwin/fhandler_disk_file.cc
+++ b/winsup/cygwin/fhandler_disk_file.cc
@@ -1837,7 +1837,7 @@ fhandler_disk_file::mkdir (mode_t mode)
 int
 fhandler_disk_file::rmdir ()
 {
-  extern NTSTATUS unlink_nt (path_conv &pc);
+  extern NTSTATUS unlink_ntpc (path_conv &pc);
 
   if (!pc.isdir ())
     {
@@ -1850,7 +1850,7 @@ fhandler_disk_file::rmdir ()
       return -1;
     }
 
-  NTSTATUS status = unlink_nt (pc);
+  NTSTATUS status = unlink_ntpc (pc);
 
   if (!NT_SUCCESS (status))
     {
diff --git a/winsup/cygwin/forkable.cc b/winsup/cygwin/forkable.cc
index 350a95c3e..bd7421bf5 100644
--- a/winsup/cygwin/forkable.cc
+++ b/winsup/cygwin/forkable.cc
@@ -29,7 +29,7 @@ details. */
 
 /* Allow concurrent processes to use the same dll or exe
  * via their hardlink while we delete our hardlink. */
-extern NTSTATUS unlink_nt_shareable (path_conv &pc);
+extern NTSTATUS unlink_ntpc_shareable (path_conv &pc);
 
 #define MUTEXSEP L"@"
 #define PATHSEP L"\\"
@@ -132,7 +132,7 @@ rmdirs (WCHAR ntmaxpathbuf[NT_MAX_PATH])
 	      RtlInitUnicodeString (&fn, ntmaxpathbuf);
 
 	      path_conv pc (&fn);
-	      unlink_nt_shareable (pc); /* move to bin */
+	      unlink_ntpc_shareable (pc); /* move to bin */
 	    }
 
 	  if (!pfdi->NextEntryOffset)
diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index b220bedae..ab0c4c2d6 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -491,7 +491,7 @@ try_to_bin (path_conv &pc, HANDLE &fh, ACCESS_MASK access, ULONG flags)
       break;
     case STATUS_DIRECTORY_NOT_EMPTY:
       /* Uh oh!  This was supposed to be avoided by the check_dir_not_empty
-	 test in unlink_nt, but given that the test isn't atomic, this *can*
+	 test in unlink_ntpc, but given that the test isn't atomic, this *can*
 	 happen.  Try to move the dir back ASAP. */
       pfri->RootDirectory = NULL;
       pfri->FileNameLength = pc.get_nt_native_path ()->Length;
@@ -501,7 +501,7 @@ try_to_bin (path_conv &pc, HANDLE &fh, ACCESS_MASK access, ULONG flags)
       if (NT_SUCCESS (NtSetInformationFile (fh, &io, pfri, frisiz,
 					    FileRenameInformation)))
 	{
-	  /* Give notice to unlink_nt and leave immediately.  This avoids
+	  /* Give notice to unlink_ntpc and leave immediately.  This avoids
 	     closing the handle, which might still be used if called from
 	     the rm -r workaround code. */
 	  bin_stat = dir_not_empty;
@@ -545,7 +545,7 @@ try_to_bin (path_conv &pc, HANDLE &fh, ACCESS_MASK access, ULONG flags)
   if ((access & FILE_WRITE_ATTRIBUTES) && NT_SUCCESS (status) && !pc.isdir ())
     NtSetAttributesFile (fh, pc.file_attributes ());
   NtClose (fh);
-  fh = NULL; /* So unlink_nt doesn't close the handle twice. */
+  fh = NULL; /* So unlink_ntpc doesn't close the handle twice. */
   /* On success or when trying to unlink a directory we just return here.
      The below code only works for files.  It also fails on NFS. */
   if (NT_SUCCESS (status) || pc.isdir () || pc.fs_is_nfs ())
@@ -695,7 +695,157 @@ _unlink_nt_post_dir_check (NTSTATUS status, POBJECT_ATTRIBUTES attr, const path_
 }
 
 static NTSTATUS
-_unlink_nt (path_conv &pc, bool shareable)
+_unlink_nt (POBJECT_ATTRIBUTES attr, ULONG eflags)
+{
+  static bool has_posix_unlink_semantics =
+      wincap.has_posix_unlink_semantics ();
+  static bool has_posix_unlink_semantics_with_ignore_readonly =
+      wincap.has_posix_unlink_semantics_with_ignore_readonly ();
+
+  HANDLE fh;
+  ACCESS_MASK access = DELETE;
+  IO_STATUS_BLOCK io;
+  ULONG flags = FILE_OPEN_REPARSE_POINT | FILE_OPEN_FOR_BACKUP_INTENT
+      | FILE_DELETE_ON_CLOSE | eflags;
+  NTSTATUS fstatus, istatus = STATUS_SUCCESS;
+
+  syscall_printf("Trying to delete %S, isdir = %d", attr->ObjectName,
+                 eflags == FILE_DIRECTORY_FILE);
+
+  //FILE_DELETE_ON_CLOSE icw FILE_DIRECTORY_FILE only works when directory is empty
+  //-> We must assume directory not empty, therefore only do this for regular files.
+  if (eflags & FILE_NON_DIRECTORY_FILE)
+    {
+      //Step 1
+      //If the file is not 'in use' and not 'readonly', this should just work.
+      fstatus = NtOpenFile (&fh, access, attr, &io, FILE_SHARE_DELETE, flags);
+      debug_printf ("NtOpenFile %S: %y", attr->ObjectName, fstatus);
+    }
+
+  if (!(eflags & FILE_NON_DIRECTORY_FILE)    // Workaround for the non-empty-dir issue
+      || fstatus == STATUS_SHARING_VIOLATION // The file is 'in use'
+      || fstatus == STATUS_CANNOT_DELETE)    // The file is 'readonly'
+    {
+      //Step 2
+      //Reopen with all sharing flags, will set delete flag ourselves.
+      access |= FILE_READ_ATTRIBUTES | FILE_WRITE_ATTRIBUTES;
+      flags &= ~FILE_DELETE_ON_CLOSE;
+      fstatus = NtOpenFile (&fh, access, attr, &io, FILE_SHARE_VALID_FLAGS, flags);
+      debug_printf ("NtOpenFile %S: %y", attr->ObjectName, fstatus);
+
+      if (NT_SUCCESS (fstatus))
+        {
+          if (has_posix_unlink_semantics_with_ignore_readonly)
+            {
+              //Step 3
+              //Remove the file with POSIX unlink semantics, ignore readonly flags.
+              FILE_DISPOSITION_INFORMATION_EX fdie =
+                { FILE_DISPOSITION_DELETE | FILE_DISPOSITION_POSIX_SEMANTICS
+                    | FILE_DISPOSITION_IGNORE_READONLY_ATTRIBUTE };
+              istatus = NtSetInformationFile (fh, &io, &fdie, sizeof fdie,
+                                              FileDispositionInformationEx);
+              debug_printf ("NtSetInformation %S: %y", attr->ObjectName, istatus);
+
+              if(istatus == STATUS_INVALID_PARAMETER)
+                has_posix_unlink_semantics_with_ignore_readonly = false;
+            }
+
+          if (!has_posix_unlink_semantics_with_ignore_readonly
+              || !NT_SUCCESS (istatus))
+            {
+              //Step 4
+              //Check if we must clear the READONLY flag
+              FILE_BASIC_INFORMATION qfbi = { 0 };
+              istatus = NtQueryInformationFile (fh, &io, &qfbi, sizeof qfbi,
+                                                FileBasicInformation);
+              debug_printf ("NtQueryFileBasicInformation %S: %y",
+                            attr->ObjectName, istatus);
+
+              if (NT_SUCCESS (istatus))
+                {
+                  if (qfbi.FileAttributes & FILE_ATTRIBUTE_READONLY)
+                    {
+                      //Step 5
+                      //Remove the readonly flag
+                      FILE_BASIC_INFORMATION sfbi = { 0 };
+                      sfbi.FileAttributes = FILE_ATTRIBUTE_ARCHIVE;
+                      istatus = NtSetInformationFile (fh, &io, &sfbi,
+                                                      sizeof sfbi,
+                                                      FileBasicInformation);
+                      debug_printf ("NtSetFileBasicInformation %S: %y",
+                                    attr->ObjectName, istatus);
+                    }
+
+                  if (NT_SUCCESS (istatus))
+                    {
+                      //Step 6a
+                      //Now, mark the file ready for deletion
+                      if (has_posix_unlink_semantics)
+                        {
+                          FILE_DISPOSITION_INFORMATION_EX fdie =
+                            { FILE_DISPOSITION_DELETE
+                                | FILE_DISPOSITION_POSIX_SEMANTICS };
+                          istatus = NtSetInformationFile (
+                              fh, &io, &fdie, sizeof fdie,
+                              FileDispositionInformationEx);
+                          debug_printf (
+                              "NtSetFileDispositionInformationEx %S: %y",
+                              attr->ObjectName, istatus);
+
+                          if (istatus == STATUS_INVALID_PARAMETER)
+                            has_posix_unlink_semantics = false;
+                        }
+
+                      if (!has_posix_unlink_semantics
+                          || !NT_SUCCESS (istatus))
+                        {
+                          //Step 6b
+                          //This will remove a readonly file (as we have just cleared that flag)
+                          //As we don't have posix unlink semantics, this will still fail if the file is in use.
+                          FILE_DISPOSITION_INFORMATION fdi = { TRUE };
+                          istatus = NtSetInformationFile (
+                              fh, &io, &fdi, sizeof fdi,
+                              FileDispositionInformation);
+                          debug_printf ("NtSetFileDispositionInformation %S: %y",
+                                        attr->ObjectName, istatus);
+                        }
+
+                      if (qfbi.FileAttributes & FILE_ATTRIBUTE_READONLY)
+                        {
+                          //Step 7
+                          //Always mark the file as READONLY (as it was before) before closing the handle
+                          //* In case of failure: This file has correct attributes
+                          //* In case of hardlinks: The hardlinks have the correct attributes
+                          //* In case of success: This file is gone
+                          NTSTATUS tstatus = NtSetInformationFile (
+                              fh, &io, &qfbi, sizeof qfbi,
+                              FileBasicInformation);
+                          debug_printf ("NtSetFileBasicInformation %S: %y",
+                                        attr->ObjectName, tstatus);
+                        }
+                    }
+                }
+            }
+        }
+    }
+
+  if (NT_SUCCESS (fstatus))
+    {
+      fstatus = NtClose (fh);
+
+      if (!NT_SUCCESS (istatus))
+        fstatus = istatus;
+    }
+
+  if (fstatus == STATUS_FILE_DELETED)
+    fstatus = STATUS_SUCCESS;
+
+  syscall_printf ("%S, return status = %y", attr->ObjectName, fstatus);
+  return fstatus;
+}
+
+static NTSTATUS
+_unlink_ntpc (path_conv &pc, bool shareable)
 {
   NTSTATUS status;
   HANDLE fh, fh_ro = NULL;
@@ -709,7 +859,7 @@ _unlink_nt (path_conv &pc, bool shareable)
   int reopened = 0;
   bin_status bin_stat = dont_move;
 
-  syscall_printf ("Trying to delete %S, isdir = %d",
+  syscall_printf ("Fallback delete %S, isdir = %d",
 		  pc.get_nt_native_path (), pc.isdir ());
 
   /* Add the reparse point flag to known reparse points, otherwise we remove
@@ -1091,16 +1241,47 @@ out:
   return status;
 }
 
+static bool
+check_unlink_status(NTSTATUS status)
+{
+  //Return true when we don't want to call _unlink_ntpc
+  return NT_SUCCESS (status)
+      || status == STATUS_FILE_IS_A_DIRECTORY
+      || status == STATUS_DIRECTORY_NOT_EMPTY
+      || status == STATUS_NOT_A_DIRECTORY
+      || status == STATUS_OBJECT_NAME_NOT_FOUND
+      || status == STATUS_OBJECT_PATH_INVALID
+      || status == STATUS_OBJECT_PATH_NOT_FOUND;
+}
+
+static NTSTATUS
+_unlink_ntpc_ (path_conv& pc, bool shareable)
+{
+  OBJECT_ATTRIBUTES attr;
+  ULONG eflags = pc.isdir () ? FILE_DIRECTORY_FILE : FILE_NON_DIRECTORY_FILE;
+
+  pc.get_object_attr (attr, sec_none_nih);
+  NTSTATUS status = _unlink_nt (&attr, eflags);
+
+  if (pc.isdir ())
+    status = _unlink_nt_post_dir_check (status, &attr, pc);
+
+  if(!check_unlink_status (status))
+    status = _unlink_ntpc (pc, shareable);
+
+  return status;
+}
+
 NTSTATUS
-unlink_nt (path_conv &pc)
+unlink_ntpc (path_conv &pc)
 {
-  return _unlink_nt (pc, false);
+  return _unlink_ntpc_ (pc, false);
 }
 
 NTSTATUS
-unlink_nt_shareable (path_conv &pc)
+unlink_ntpc_shareable (path_conv &pc)
 {
-  return _unlink_nt (pc, true);
+  return _unlink_ntpc_ (pc, true);
 }
 
 extern "C" int
@@ -1138,7 +1319,7 @@ unlink (const char *ourname)
       goto done;
     }
 
-  status = unlink_nt (win32_name);
+  status = unlink_ntpc (win32_name);
   if (NT_SUCCESS (status))
     res = 0;
   else
@@ -2647,10 +2828,10 @@ rename2 (const char *oldpath, const char *newpath, unsigned int at2flags)
 	 ReplaceIfExists is set to TRUE and the existing dir is empty.  So
 	 we have to remove the destination dir first.  This also covers the
 	 case that the destination directory is not empty.  In that case,
-	 unlink_nt returns with STATUS_DIRECTORY_NOT_EMPTY. */
+	 unlink_ntpc returns with STATUS_DIRECTORY_NOT_EMPTY. */
       if (dstpc->isdir ())
 	{
-	  status = unlink_nt (*dstpc);
+	  status = unlink_ntpc (*dstpc);
 	  if (!NT_SUCCESS (status))
 	    {
 	      __seterrno_from_nt_status (status);
@@ -2791,13 +2972,13 @@ skip_pre_W10_checks:
 					? FILE_OPEN_REPARSE_POINT : 0));
 	      if (NT_SUCCESS (status))
 		{
-		  status = unlink_nt (*dstpc);
+		  status = unlink_ntpc (*dstpc);
 		  if (NT_SUCCESS (status))
 		    break;
 		}
 	      if (!NT_TRANSACTIONAL_ERROR (status) || !trans)
 		break;
-	      /* If NtOpenFile or unlink_nt fail due to transactional problems,
+	      /* If NtOpenFile or unlink_ntpc fail due to transactional problems,
 		 stop transaction and retry without. */
 	      NtClose (fh);
 	      stop_transaction (status, old_trans, trans);
@@ -2811,7 +2992,7 @@ skip_pre_W10_checks:
       if (NT_SUCCESS (status))
 	{
 	  if (removepc)
-	    unlink_nt (*removepc);
+	    unlink_ntpc (*removepc);
 	  res = 0;
 	}
       else
-- 
2.30.0

