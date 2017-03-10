Return-Path: <cygwin-patches-return-8711-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 76581 invoked by alias); 10 Mar 2017 10:33:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 76550 invoked by uid 89); 10 Mar 2017 10:33:08 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-24.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=subsequently, owning, 4237, concurrency
X-HELO: smtp.salomon.at
Received: from smtp.salomon.at (HELO smtp.salomon.at) (193.186.16.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 10 Mar 2017 10:33:05 +0000
Received: from samail03.wamas.com ([172.28.33.235] helo=mailhost.salomon.at)	by smtp.salomon.at with esmtps (UNKNOWN:DHE-RSA-AES256-SHA:256)	(Exim 4.80.1)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1cmHr4-00041D-9F; Fri, 10 Mar 2017 11:33:03 +0100
Received: from s01en24.wamas.com ([172.28.41.101] helo=s01en24)	by mailhost.salomon.at with smtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1cmHr3-00072I-5w; Fri, 10 Mar 2017 11:33:02 +0100
Received: by s01en24 (sSMTP sendmail emulation); Fri, 10 Mar 2017 11:33:01 +0100
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
To: cygwin-patches@cygwin.com
Cc: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Subject: [PATCH] forkables: hardlink without WRITE_ATTRIBUTES first
Date: Fri, 10 Mar 2017 10:33:00 -0000
Message-Id: <20170310103254.5513-1-michael.haubenwallner@ssi-schaefer.com>
X-SW-Source: 2017-q1/txt/msg00052.txt.bz2

When the current process has renamed (to bin) a readonly dll, we get
STATUS_TRANSACTION_NOT_ACTIVE for unknown reason when subsequently
creating the forkable hardlink. A workaround is to open the original
file with FILE_WRITE_ATTRIBUTES access, but that fails with permission
denied for users not owning the original file.

* forkable.cc (dll::create_forkable): Retry hardlink creation using the
original file's handle opened with FILE_WRITE_ATTRIBUTES access when the
first attempt fails with STATUS_TRANSACTION_NOT_ACTIVE.
---
 winsup/cygwin/forkable.cc | 72 +++++++++++++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 24 deletions(-)

diff --git a/winsup/cygwin/forkable.cc b/winsup/cygwin/forkable.cc
index 2cb5e73..ec51ebf 100644
--- a/winsup/cygwin/forkable.cc
+++ b/winsup/cygwin/forkable.cc
@@ -423,7 +423,14 @@ dll::nominate_forkable (PCWCHAR dirx_name)
 }
 
 /* Create the nominated hardlink for one indivitual dll,
-   inside another subdirectory when dynamically loaded. */
+   inside another subdirectory when dynamically loaded.
+
+   We've not found a performant way yet to protect fork against
+   updates to main executables and/or dlls that do not reside on
+   the same NTFS filesystem as the <cygroot>/var/run/cygfork/
+   directory.  But as long as the main executable can be hardlinked,
+   dll redirection works for any other hardlink-able dll, while
+   non-hardlink-able dlls are used from their original location. */
 bool
 dll::create_forkable ()
 {
@@ -465,14 +472,6 @@ dll::create_forkable ()
   if (devhandle == INVALID_HANDLE_VALUE)
     return false; /* impossible */
 
-  HANDLE fh = dll_list::ntopenfile ((PCWCHAR)&fii.IndexNumber, NULL,
-				    FILE_OPEN_BY_FILE_ID,
-				    FILE_WRITE_ATTRIBUTES,
-				    devhandle);
-  NtClose (devhandle);
-  if (fh == INVALID_HANDLE_VALUE)
-    return false; /* impossible */
-
   int ntlen = wcslen (ntname);
   int bufsize = sizeof (FILE_LINK_INFORMATION) + ntlen * sizeof (*ntname);
   PFILE_LINK_INFORMATION pfli = (PFILE_LINK_INFORMATION) alloca (bufsize);
@@ -483,22 +482,47 @@ dll::create_forkable ()
   pfli->ReplaceIfExists = FALSE; /* allow concurrency */
   pfli->RootDirectory = NULL;
 
-  IO_STATUS_BLOCK iosb;
-  NTSTATUS status = NtSetInformationFile (fh, &iosb, pfli, bufsize,
-					  FileLinkInformation);
-  NtClose (fh);
-  debug_printf ("%y = NtSetInformationFile (%p, FileLink %W, iosb.Status %y)",
-		status, fh, pfli->FileName, iosb.Status);
-  if (NT_SUCCESS (status) || status == STATUS_OBJECT_NAME_COLLISION)
-    /* We've not found a performant way yet to protect fork against updates
-       to main executables and/or dlls that do not reside on the same NTFS
-       filesystem as the <cygroot>/var/run/cygfork/ directory.
-       But as long as the main executable can be hardlinked, dll redirection
-       works for any other hardlink-able dll, while non-hardlink-able dlls
-       are used from their original location. */
-    return true;
+  /* When we get STATUS_TRANSACTION_NOT_ACTIVE from hardlink creation,
+     the current process has renamed the file while it had the readonly
+     attribute.  The rename() function uses a transaction for combined
+     writeable+rename action if possible to provide atomicity.
+     Although the transaction is closed afterwards, creating a hardlink
+     for this file requires the FILE_WRITE_ATTRIBUTES access, for unknown
+     reason.  On the other hand, always requesting FILE_WRITE_ATTRIBUTES
+     would fail for users that do not own the original file. */
+  bool ret = false;
+  int access = 0; /* first attempt */
+  while (true)
+    {
+      HANDLE fh = dll_list::ntopenfile ((PCWCHAR)&fii.IndexNumber, NULL,
+					FILE_OPEN_BY_FILE_ID,
+					access,
+					devhandle);
+      if (fh == INVALID_HANDLE_VALUE)
+	break; /* impossible */
+
+      IO_STATUS_BLOCK iosb;
+      NTSTATUS status = NtSetInformationFile (fh, &iosb, pfli, bufsize,
+					      FileLinkInformation);
+      NtClose (fh);
+      debug_printf ("%y = NtSetInformationFile (%p, FileLink %W, iosb.Status %y)",
+		    status, fh, pfli->FileName, iosb.Status);
+      if (NT_SUCCESS (status) || status == STATUS_OBJECT_NAME_COLLISION)
+	{
+	  ret = true;
+	  break;
+	}
+
+      if (status != STATUS_TRANSACTION_NOT_ACTIVE ||
+	  access == FILE_WRITE_ATTRIBUTES)
+	break;
+
+      access = FILE_WRITE_ATTRIBUTES; /* second attempt */
+    }
+
+  NtClose (devhandle);
 
-  return false;
+  return ret;
 }
 
 /* return the number of characters necessary to store one forkable name */
-- 
2.10.2
