Return-Path: <cygwin-patches-return-4773-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21527 invoked by alias); 17 May 2004 16:57:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21516 invoked from network); 17 May 2004 16:57:56 -0000
X-Originating-IP: [24.236.218.217]
X-Originating-Email: [yjfwhhvvvhzk6wdy@hotmail.com]
X-Sender: yjfwhhvvvhzk6wdy@hotmail.com
From: "Stephen Cleary" <yjfwhhvvvhzk6wdy@hotmail.com>
To: cygwin-patches@cygwin.com
Bcc: 
Subject: [Patch] To handle Win32 pipe names
Date: Mon, 17 May 2004 16:57:00 -0000
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_66eb_6ae5_16b0"
Message-ID: <BAY9-F265VSSFcl3imp0000784b@hotmail.com>
X-OriginalArrivalTime: 17 May 2004 16:57:55.0483 (UTC) FILETIME=[195CDEB0:01C43C30]
X-SW-Source: 2004-q2/txt/msg00125.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_66eb_6ae5_16b0
Content-Type: text/plain; format=flowed
Content-length: 417

Attached is a patch against the current CVS sources, with a ChangeLog. This 
patch allows Win32 pipe names to be opened as files.

The legal paperwork just got in the mail this morning, but this patch may be 
small enough that it wouldn't require it anyway.

        -Steve

_________________________________________________________________
Check out the coupons and bargains on MSN Offers! http://youroffers.msn.com

------=_NextPart_000_66eb_6ae5_16b0
Content-Type: text/plain; name="patch"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="patch"
Content-length: 3169

Index: winsup/cygwin/fhandler_disk_file.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_disk_file.cc,v
retrieving revision 1.90
diff -u -p -r1.90 fhandler_disk_file.cc
--- winsup/cygwin/fhandler_disk_file.cc	20 Apr 2004 15:51:24 -0000	1.90
+++ winsup/cygwin/fhandler_disk_file.cc	17 May 2004 16:41:30 -0000
@@ -159,6 +159,20 @@ fhandler_base::fstat_by_name (struct __s
int __stdcall
fhandler_base::fstat_fs (struct __stat64 *buf)
{
+  // If this is a Win32 pipe name, don't attempt to open the file
+  if (is_win32_pipe_name (get_win32_name ()))
+  {
+    debug_printf("Circumventing this function for Win32 pipe");
+    buf->st_mode = S_IFCHR | STD_RBITS | STD_WBITS | S_IWGRP | S_IWOTH;
+    buf->st_uid = geteuid32 ();
+    buf->st_gid = getegid32 ();
+    buf->st_nlink = 1;
+    buf->st_blksize = S_BLKSIZE;
+    time_as_timestruc_t (&buf->st_ctim);
+    buf->st_atim = buf->st_mtim = buf->st_ctim;
+    return 0;
+  }
+
   int res = -1;
   int oret;
   int open_flags = O_RDONLY | O_BINARY;
Index: winsup/cygwin/path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.312
diff -u -p -r1.312 path.cc
--- winsup/cygwin/path.cc	15 May 2004 15:55:43 -0000	1.312
+++ winsup/cygwin/path.cc	17 May 2004 16:41:44 -0000
@@ -137,6 +137,20 @@ create_shortcut_header (void)
#define isvirtual_dev(devn) \
   (devn == FH_CYGDRIVE || devn == FH_PROC || devn == FH_REGISTRY || devn == 
FH_PROCESS)

+// Win32 pipe names have a prefix that follows the pattern: 
"\\\\[^\\]+\\pipe\\"
+bool
+is_win32_pipe_name (const char * const s)
+{
+  if (strncmp(s, "\\\\", 2))
+    return false;
+  const char * const p = strchr(s + 2, '\\');
+  if (!p || p - s == 2)
+    return false;
+  if (strnicmp(p + 1, "pipe\\", 5))
+    return false;
+  return true;
+}
+
/* Return non-zero if PATH1 is a prefix of PATH2.
    Both are assumed to be of the same path style and / vs \ usage.
    Neither may be "".
@@ -3020,6 +3034,17 @@ symlink_info::check (char *path, const s
   pflags &= ~(PATH_SYMLINK | PATH_LNK);

   case_clash = false;
+
+  // Calling GetFileAttributes on a Win32 pipe path will cause undefined 
behavior.
+  // Since Win32 pipe paths cannot contain symlinks, this function is just 
skipped.
+  if (is_win32_pipe_name (path))
+  {
+    debug_printf("Circumventing this function for Win32 pipe");
+    error = 0;
+    is_symlink = false;
+    fileattr = FILE_ATTRIBUTE_DEVICE;
+    return 0;
+  }

   while (suffix.next ())
     {
Index: winsup/cygwin/path.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.h,v
retrieving revision 1.65
diff -u -p -r1.65 path.h
--- winsup/cygwin/path.h	11 May 2004 15:39:50 -0000	1.65
+++ winsup/cygwin/path.h	17 May 2004 16:41:45 -0000
@@ -271,6 +271,8 @@ bool fnunmunge (char *, const char *) __

int path_prefix_p (const char *path1, const char *path2, int len1) 
__attribute__ ((regparm (3)));

+bool is_win32_pipe_name (const char * const s);
+
/* FIXME: Move to own include file eventually */

#define MAX_ETC_FILES 2


------=_NextPart_000_66eb_6ae5_16b0
Content-Type: text/plain; name="ChangeLog"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="ChangeLog"
Content-length: 307

2004-05-17 Stephen Cleary  <yjfwhhvvvhzk6wdy@hotmail.com>

* path.h (is_win32_pipe_name): Add function.

* path.cc (is_win32_pipe_name): Add function.

* fhandler_disk_file.cc (fhandler_base::fstat_fs): Special handling for 
Win32 pipes.

* path.cc (symlink_info::check): Special handling for Win32 pipes.


------=_NextPart_000_66eb_6ae5_16b0--
