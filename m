Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-046.btinternet.com (mailomta14-re.btinternet.com
 [213.120.69.107])
 by sourceware.org (Postfix) with ESMTPS id DDD773833036
 for <cygwin-patches@cygwin.com>; Sun,  2 May 2021 15:26:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org DDD773833036
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
 by re-prd-fep-046.btinternet.com with ESMTP id
 <20210502152657.CUOF21941.re-prd-fep-046.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
 Sun, 2 May 2021 16:26:57 +0100
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 5ED9C0CC313CE533
X-Originating-IP: [81.153.98.246]
X-OWM-Source-IP: 81.153.98.246 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduledrvdefuddgudeflecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepfeeiudevhefgffffueeuheelfeegveefvdffleejfeehudetleetledvteethfdvnecukfhppeekuddrudehfedrleekrddvgeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekuddrudehfedrleekrddvgeeipdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.153.98.246) by
 re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C0CC313CE533; Sun, 2 May 2021 16:26:57 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 1/2] Unpick cygpath TESTSUITE
Date: Sun,  2 May 2021 16:25:35 +0100
Message-Id: <20210502152537.32312-2-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210502152537.32312-1-jon.turney@dronecode.org.uk>
References: <20210502152537.32312-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1199.9 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Sun, 02 May 2021 15:27:00 -0000

Rather than having testsuite.h do various things, depending on defines,
just have it do one thing, and then explicitly redirect to test stubs in
path.cc when building test.
---
 winsup/utils/path.cc      | 31 +++++++++++++------------------
 winsup/utils/path.h       | 10 ++++++++--
 winsup/utils/testsuite.cc | 31 ++++++++++++++++---------------
 winsup/utils/testsuite.h  | 34 +++++++++++-----------------------
 4 files changed, 48 insertions(+), 58 deletions(-)

diff --git a/winsup/utils/path.cc b/winsup/utils/path.cc
index 29344be02..0d41a45d8 100644
--- a/winsup/utils/path.cc
+++ b/winsup/utils/path.cc
@@ -25,7 +25,6 @@ details. */
 #include "../cygwin/include/sys/mount.h"
 #define _NOMNTENT_MACROS
 #include "../cygwin/include/mntent.h"
-#include "testsuite.h"
 #ifdef FSTAB_ONLY
 #include <sys/cygwin.h>
 #endif
@@ -255,14 +254,8 @@ readlink (HANDLE fh, char *path, size_t maxlen)
 }
 #endif /* !FSTAB_ONLY */
 
-#ifndef TESTSUITE
 mnt_t mount_table[255];
 int max_mount_entry;
-#else
-#  define TESTSUITE_MOUNT_TABLE
-#  include "testsuite.h"
-#  undef TESTSUITE_MOUNT_TABLE
-#endif
 
 inline void
 unconvert_slashes (char* name)
@@ -271,9 +264,6 @@ unconvert_slashes (char* name)
     *name++ = '\\';
 }
 
-/* These functions aren't called when defined(TESTSUITE) which results
-   in a compiler warning.  */
-#ifndef TESTSUITE
 inline char *
 skip_ws (char *in)
 {
@@ -555,11 +545,8 @@ from_fstab (bool user, PWCHAR path, PWCHAR path_end)
   CloseHandle (h);
 }
 #endif /* !FSTAB_ONLY */
-#endif /* !TESTSUITE */
 
 #ifndef FSTAB_ONLY
-
-#ifndef TESTSUITE
 static int
 mnt_sort (const void *a, const void *b)
 {
@@ -653,7 +640,11 @@ read_mounts ()
   from_fstab (true, path, path_end);
   qsort (mount_table, max_mount_entry, sizeof (mnt_t), mnt_sort);
 }
-#endif /* !defined(TESTSUITE) */
+
+#ifdef TESTSUITE
+#define read_mounts testsuite_read_mounts
+#endif
+
 
 /* Return non-zero if PATH1 is a prefix of PATH2.
    Both are assumed to be of the same path style and / vs \ usage.
@@ -757,6 +748,11 @@ concat (const char *s, ...)
   return vconcat (s, v);
 }
 
+#ifdef TESTSUITE
+#undef GetCurrentDirectory
+#define GetCurrentDirectory testsuite_getcwd
+#endif
+
 /* This is a helper function for when vcygpath is passed what appears
    to be a relative POSIX path.  We take a Win32 CWD (either as specified
    in 'cwd' or as retrieved with GetCurrentDirectory() if 'cwd' is NULL)
@@ -822,10 +818,9 @@ vcygpath (const char *cwd, const char *s, va_list v)
   size_t max_len = 0;
   mnt_t *m, *match = NULL;
 
-#ifndef TESTSUITE
   if (!max_mount_entry)
     read_mounts ();
-#endif
+
   char *path;
   if (s[0] == '.' && isslash (s[1]))
     s += 2;
@@ -912,10 +907,10 @@ extern "C" FILE *
 setmntent (const char *, const char *)
 {
   m = mount_table;
-#ifndef TESTSUITE
+
   if (!max_mount_entry)
     read_mounts ();
-#endif
+
   return NULL;
 }
 
diff --git a/winsup/utils/path.h b/winsup/utils/path.h
index a1840a003..c64f6ebfb 100644
--- a/winsup/utils/path.h
+++ b/winsup/utils/path.h
@@ -6,6 +6,9 @@ This software is a copyrighted work licensed under the terms of the
 Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
 details. */
 
+#ifndef _PATH_H_
+#define _PATH_H_
+
 struct mnt_t
 {
   char *native;
@@ -22,11 +25,14 @@ int get_word (HANDLE, int);
 int get_dword (HANDLE, int);
 bool from_fstab_line (mnt_t *m, char *line, bool user);
 
-#ifndef TESTSUITE
 extern mnt_t mount_table[255];
 extern int max_mount_entry;
-#endif
 
 #ifndef SYMLINK_MAX
 #define SYMLINK_MAX 4095  /* PATH_MAX - 1 */
 #endif
+
+DWORD testsuite_getcwd (DWORD nBufferLength, LPSTR lpBuffer);
+void testsuite_read_mounts (void);
+
+#endif
diff --git a/winsup/utils/testsuite.cc b/winsup/utils/testsuite.cc
index 23ed8e0d8..ef9f14fa7 100644
--- a/winsup/utils/testsuite.cc
+++ b/winsup/utils/testsuite.cc
@@ -15,22 +15,9 @@ details. */
 #include <unistd.h>
 #define WIN32_LEAN_AND_MEAN
 #include <windows.h>
-#ifndef TESTSUITE
-#define TESTSUITE
-#endif
+#include "path.h"
 #include "testsuite.h"
 
-typedef struct
-  {
-    const char *cwd;    /* in win32 form, as if by GetCurrentDirectory */
-    const char *posix;  /* input */
-    const char *win32;  /* expected output */
-  } test_t;
-
-#define TESTSUITE_TESTS
-#include "testsuite.h"
-#undef TESTSUITE_TESTS
-
 static int curtest;
 
 /* A replacement for the w32api GetCurrentDirectory() that returns
@@ -55,7 +42,21 @@ testsuite_getcwd (DWORD nBufferLength, LPSTR lpBuffer)
   return len;
 }
 
-extern char *cygpath (const char *s, ...);
+/*
+  A replacement for read_mounts that installs the test mount table
+ */
+void
+testsuite_read_mounts (void)
+{
+  int i;
+  for (i = 0; test_mount_table[i].posix; i++)
+    {
+      mount_table[i] = test_mount_table[i];
+    }
+  max_mount_entry = i;
+}
+
+WCHAR cygwin_dll_path[32768];
 
 int
 main (int argc, char **argv)
diff --git a/winsup/utils/testsuite.h b/winsup/utils/testsuite.h
index 0dd631539..c3d9ad60d 100644
--- a/winsup/utils/testsuite.h
+++ b/winsup/utils/testsuite.h
@@ -6,6 +6,10 @@ This software is a copyrighted work licensed under the terms of the
 Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
 details. */
 
+#include "path.h"
+#include "../cygwin/include/cygwin/bits.h"
+#include "../cygwin/include/sys/mount.h"
+
 /* This file implements a test harness for the MinGW implementation of
    POSIX path translation in utils/path.cc.  This code is used by strace
    and cygcheck which cannot depend on the Cygwin DLL.  The tests below
@@ -13,9 +17,6 @@ details. */
    absolute paths from POSIX form to Win32 form based on the contents of
    a mount table.  */
 
-/* Including this file should be a no-op if TESTSUITE is not defined.  */
-#ifdef TESTSUITE
-
 /* These definitions are common to both the testsuite mount table
    as well as the testsuite definitions themselves, so define them
    here so that they are only defined in one location.  */
@@ -26,9 +27,7 @@ details. */
    This is used in place of actually reading the host mount
    table from the registry for the duration of the testsuite.  This
    table should match the battery of tests below.  */
-
-#if defined(TESTSUITE_MOUNT_TABLE)
-static mnt_t mount_table[] = {
+static mnt_t test_mount_table[] = {
 /* native                 posix               flags */
  { (char*)TESTSUITE_ROOT,        (char*)"/",                MOUNT_SYSTEM},
  { (char*)"O:\\other",           (char*)"/otherdir",        MOUNT_SYSTEM},
@@ -39,12 +38,16 @@ static mnt_t mount_table[] = {
  { NULL,                  (char*)NULL,               0}
 };
 
+typedef struct
+  {
+    const char *cwd;    /* in win32 form, as if by GetCurrentDirectory */
+    const char *posix;  /* input */
+    const char *win32;  /* expected output */
+  } test_t;
 
 /* Define the main set of tests.  This is defined here instead of in
    testsuite.cc so that all test harness data is in one place and not
    spread over several files.  */
-
-#elif defined(TESTSUITE_TESTS)
 #define NO_CWD "N/A"
 static test_t testsuite_tests[] = {
  { NO_CWD,                     "/file.ext",              TESTSUITE_ROOT"\\file.ext" },
@@ -112,18 +115,3 @@ static test_t testsuite_tests[] = {
  { NO_CWD,                     "//server/share/foo/bar", "\\\\server\\share\\foo\\bar" },
  { NO_CWD,                     NULL,                     NULL }
 };
-
-#else
-
-/* Redirect calls to GetCurrentDirectory() to the testsuite instead.  */
-#ifdef GetCurrentDirectory
-#undef GetCurrentDirectory
-#endif
-#define GetCurrentDirectory testsuite_getcwd
-
-DWORD testsuite_getcwd (DWORD, LPSTR);
-
-#endif
-
-#endif /* TESTSUITE */
-
-- 
2.31.1

