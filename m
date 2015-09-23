Return-Path: <cygwin-patches-return-8244-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 84883 invoked by alias); 23 Sep 2015 11:07:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 84860 invoked by uid 89); 23 Sep 2015 11:07:03 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=1.6 required=5.0 tests=BAYES_50,FREEMAIL_FROM,KAM_STOCKGEN,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=no version=3.3.2
X-HELO: forward20m.cmail.yandex.net
Received: from forward20m.cmail.yandex.net (HELO forward20m.cmail.yandex.net) (5.255.216.151) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Wed, 23 Sep 2015 11:07:01 +0000
Received: from web2m.yandex.ru (web2m.yandex.ru [IPv6:2a02:6b8:0:2519::202])	by forward20m.cmail.yandex.net (Yandex) with ESMTP id 3C8A9212A7	for <cygwin-patches@cygwin.com>; Wed, 23 Sep 2015 14:06:56 +0300 (MSK)
Received: from 127.0.0.1 (localhost [127.0.0.1])	by web2m.yandex.ru (Yandex) with ESMTP id 92B4A33A0DD8;	Wed, 23 Sep 2015 14:06:55 +0300 (MSK)
Received: by web2m.yandex.ru with HTTP;	Wed, 23 Sep 2015 14:06:54 +0300
From: Evgeny Grin <k2k@yandex.ru>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Add ability to use NTFS native directory symlinks without admin rights on XP and later
MIME-Version: 1.0
Message-Id: <408941443006414@web2m.yandex.ru>
Date: Wed, 23 Sep 2015 11:07:00 -0000
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-IsSubscribed: yes
X-SW-Source: 2015-q3/txt/msg00026.txt.bz2

This patch will add ability to create directory junction which are supported from Windows 2000 and not require any special rights (unlike file/directory symbolic links).
New three modes for symbolic links creation added: "safenative", "safenativestrict" and "safenativeonly". First two allow fallback to "native" and "nativesctrict", last one use only directory junction for symbolic links (file links will fail with this setting, but it can be useful for derived projects like MSys or Git for Windows).

Only creation of directory junctions is implemented in this patch, reading and resolving junction as symbolic links are already supported by Cygwin.
I'd recommend to set default mode to "safenative" as it allow to use system functionality out-of-box with fallback to Cygwin's functionality where system's symlinks are not available.

---
 winsup/cygwin/environ.cc |   9 ++
 winsup/cygwin/globals.cc |   5 +-
 winsup/cygwin/path.cc    | 215 ++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 226 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/environ.cc b/winsup/cygwin/environ.cc
index 8f25fb1..b02d685 100644
--- a/winsup/cygwin/environ.cc
+++ b/winsup/cygwin/environ.cc
@@ -84,6 +84,15 @@ set_winsymlinks (const char *buf)
     allow_winsymlinks = WSYM_lnk;
   else if (ascii_strncasematch (buf, "lnk", 3))
     allow_winsymlinks = WSYM_lnk;
+  else if (ascii_strncasematch (buf, "safenative", 10))
+    {
+      if (ascii_strcasematch (buf + 10, "strict"))
+        allow_winsymlinks = WSYM_safenativestrict;
+      else if (ascii_strcasematch (buf + 10, "only"))
+        allow_winsymlinks = WSYM_safenativeonly;
+      else
+        allow_winsymlinks = WSYM_safenative;
+    }
   /* Make sure to try native symlinks only on systems supporting them. */
   else if (ascii_strncasematch (buf, "native", 6))
     {
diff --git a/winsup/cygwin/globals.cc b/winsup/cygwin/globals.cc
index 09c08f2..c468741 100644
--- a/winsup/cygwin/globals.cc
+++ b/winsup/cygwin/globals.cc
@@ -59,7 +59,10 @@ enum winsym_t
   WSYM_lnk,
   WSYM_native,
   WSYM_nativestrict,
-  WSYM_nfs
+  WSYM_nfs,
+  WSYM_safenative,
+  WSYM_safenativestrict,
+  WSYM_safenativeonly
 };
 
 exit_states NO_COPY exit_state;
diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index 89dbdab..fb7b191 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -1734,6 +1734,207 @@ symlink_native (const char *oldpath, path_conv &win32_newpath)
   return 0;
 }
 
+static int
+symlink_safenative (const char *oldpath, path_conv &win32_newpath)
+{
+  tmp_pathbuf tp;
+  path_conv win32_oldpath;
+  PUNICODE_STRING nt_oldpath;
+  NTSTATUS status;
+  HANDLE fh;
+  OBJECT_ATTRIBUTES attr;
+  IO_STATUS_BLOCK io;
+  PREPARSE_DATA_BUFFER prdb;
+  ACCESS_MASK access_mask;
+
+  syscall_printf ("symlink_safenative (oldpath: '%s', newpath: '%s')", oldpath,
+                win32_newpath.get_posix ());
+
+  /* Directory junction cannot be created on remote drive.
+     Leave this check here to simplify routing in symlink_worker(). */
+  if (win32_newpath.isremote ())
+    {
+      debug_printf ("'%S' is on remote drive",
+                    win32_newpath.get_nt_native_path ());
+      set_errno (EXDEV);
+      return -1;
+    }
+
+  win32_oldpath.check (oldpath, PC_SYM_NOFOLLOW);
+
+  /* Make sure that symlink target is directory as directory junction
+     can point only to directory. If target is not exist yet then
+     don't create junction to prevent an invalid state with junction
+     pointing to later created regular file. */
+  if (!win32_oldpath.exists () || !win32_oldpath.isdir ())
+    {
+      debug_printf ("'%S' does not exist or is not a directory",
+                    win32_oldpath.get_nt_native_path ());
+      set_errno (ENOTDIR);
+      return -1;
+    }
+
+  nt_oldpath = win32_oldpath.get_nt_native_path ();
+
+  /* Directory junction can point only to local mounted drive. */
+  if (nt_oldpath->Length < 6 * sizeof (wchar_t) ||
+      nt_oldpath->Buffer[5] != L':')
+    {
+      debug_printf ("'%S' is not on local mounted drive", nt_oldpath);
+      set_errno (EXDEV);
+      return -1;
+    }
+
+  /* Make sure that slash for root directory is present otherwise OS will 
+     misbehavior when resolving such junction. This is an extra care as 
+     get_nt_native_path() should return correct path. */
+  if (nt_oldpath->Length < 7 * sizeof (wchar_t) ||
+      nt_oldpath->Buffer[6] != L'\\')
+    {
+      set_errno (ENOTDIR);
+      return -1;
+    }
+
+  if (offsetof (REPARSE_DATA_BUFFER, MountPointReparseBuffer.PathBuffer) +
+      nt_oldpath->Length * 2 + (2 - 4) * sizeof (wchar_t)
+      > MAXIMUM_REPARSE_DATA_BUFFER_SIZE)
+    {
+      set_errno (ENAMETOOLONG);
+      return -1;
