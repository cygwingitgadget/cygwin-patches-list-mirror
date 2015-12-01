Return-Path: <cygwin-patches-return-8278-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20428 invoked by alias); 1 Dec 2015 14:02:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 20410 invoked by uid 89); 1 Dec 2015 14:02:20 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.2 required=5.0 tests=AWL,BAYES_50,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mout.gmx.net
Received: from mout.gmx.net (HELO mout.gmx.net) (212.227.15.15) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Tue, 01 Dec 2015 14:02:18 +0000
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by mail.gmx.com (mrgmx002) with ESMTPSA (Nemesis) id 0Md3ZK-1Zmmqz1HjW-00IF0V for <cygwin-patches@cygwin.com>; Tue, 01 Dec 2015 15:02:15 +0100
Date: Tue, 01 Dec 2015 14:02:00 -0000
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2] Introduce the 'usertemp' filesystem type
In-Reply-To: <0MIuft-1ZZdDB2IaP-002Y2r@mail.gmx.com>
Message-ID: <3ddcb7adf1004c146964beda2f90521bb1c19d4a.1448978434.git.johannes.schindelin@gmx.de>
References: <0MIuft-1ZZdDB2IaP-002Y2r@mail.gmx.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-UI-Out-Filterresults: notjunk:1;V01:K0:pxIPcem77MA=:Z+WBDcwo/m9mll/j+F3svQ TYxC3WewLq0HW3m/4C5XyRtor0rG9QNbHC0TaazefTm3x4Ms6W7wG37gSiTSgRNJC3Zy6IK1P z6P8s3QHOm/o/XfQ55MwnJ6ap5Nfu9fuCxdOQY/1Z+Q6VjP2waRchdlmDvzVPACvCeZ5uyfoY aXrTYGPFfz74MYAIT46FfFSfW0A5X4RMKf2FXe+YA4MJE7PV6zTjJ1diMMfhm1FkqMvU4dWwy 1gliQcBHmw6pOMZHuLrZHWNo6VP6CfvmolC7W7kQWoNFdK7RNOJIB8njVf8eiIwodahe1AdDh uqAKq6z0lfyVkNNi5e+LmPnAvkkZYLcDYwd3EFZwDUoIBfe5on3Fl1BMDC2kmxQBpGVLWBRsP JQjjw2GMDJytWh/x5aOQ4agz8OwhCuRZ1EOm1Un/bM387Sdgvm3ql2Zvgq2C/rFd4VJHSHZ1q bzGs9mVJJhAiCUV57tfAbnHjR/AGkvOwYgjU5pzHFhCDGBXY27orudGgb9JobCVEoz+TuhnOp 4auUsH2x+rZHQlRmROYJWOGSAZ5Czfim7HjC9v9SYcDn5ssoq2QwmXVmvdTjmMXblMSXO//tu LNt5fcaEA5G6Itam0PMudi7pG32skOsKM91NGczIn7hfWW3iGcLx+77VXCvg6dfktcgRtEvAw VbHoAt+QyvDs5wLpMAL1PLbwF9mqyj54a8UBSG0QnDsp7njovmr4Vyg4V0dbGtW1hCwYVoAgB +CjHy858HZ86JUhtejCx8dEvlwqZ5Mo6wgaoWX1dOayqxcEuiqQnYplWUKFPz267I57r/Y/pu mnwGlP5
X-IsSubscribed: yes
X-SW-Source: 2015-q4/txt/msg00031.txt.bz2

	* mount.cc (mount_info::from_fstab_line): support mounting the
	current user's temp folder as /tmp/. This is particularly
	useful a feature when Cygwin's own files are write-protected.

	* pathnames.xml: document the new usertemp file system type

Detailed explanation:

In the context of Windows, there is a per-user directory for temporary
files, by default specified via the environment variable %TEMP%. Let's
allow to use that directory for our /tmp/ directory.

With this patch, we introduce the special filesystem type "usertemp":
By specifying

	none /tmp usertemp binary,posix=0 0 0

in /etc/fstab, the /tmp/ directory gets auto-mounted to the directory
specified by the %TEMP% variable.

This feature comes handy in particularly in scenarios where the
administrator might want to write-protect the entire Cygwin directory
yet still needs to allow users to write into the /tmp/ directory.
This is the case in the context of Git for Windows, where the
Cygwin (MSys2) root directory lives inside C:\Program Files and hence
/tmp/ would not be writable otherwise.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 winsup/cygwin/include/sys/mount.h |  3 ++-
 winsup/cygwin/mount.cc            | 21 +++++++++++++++++++++
 winsup/doc/pathnames.xml          | 24 +++++++++++++++++++++---
 3 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/include/sys/mount.h b/winsup/cygwin/include/sys/mount.h
index 458cf80..ec92794 100644
--- a/winsup/cygwin/include/sys/mount.h
+++ b/winsup/cygwin/include/sys/mount.h
@@ -44,7 +44,8 @@ enum
   MOUNT_DOS =		0x40000,	/* convert leading spaces and trailing
 					   dots and spaces to private use area */
   MOUNT_IHASH =		0x80000,	/* Enforce hash values for inode numbers */
-  MOUNT_BIND =		0x100000	/* Allows bind syntax in fstab file. */
+  MOUNT_BIND =		0x100000,	/* Allows bind syntax in fstab file. */
+  MOUNT_USER_TEMP =	0x200000	/* Mount the user's $TMP. */
 };
 
 int mount (const char *, const char *, unsigned __flags);
diff --git a/winsup/cygwin/mount.cc b/winsup/cygwin/mount.cc
index c04805b..fc080c9 100644
--- a/winsup/cygwin/mount.cc
+++ b/winsup/cygwin/mount.cc
@@ -1172,6 +1172,8 @@ mount_info::from_fstab_line (char *line, bool user)
   unsigned mount_flags = MOUNT_SYSTEM | MOUNT_BINARY;
   if (!strcmp (fs_type, "cygdrive"))
     mount_flags |= MOUNT_NOPOSIX;
+  if (!strcmp (fs_type, "usertemp"))
+    mount_flags |= MOUNT_IMMUTABLE;
   if (!fstab_read_flags (&c, mount_flags, false))
     return true;
   if (mount_flags & MOUNT_BIND)
@@ -1196,6 +1198,22 @@ mount_info::from_fstab_line (char *line, bool user)
       slashify (posix_path, cygdrive, 1);
       cygdrive_len = strlen (cygdrive);
     }
+  else if (!strcmp (fs_type, "usertemp"))
+    {
+      WCHAR tmp[PATH_MAX + 1];
+
+      if (GetTempPathW (PATH_MAX, tmp))
+	{
+	  tmp_pathbuf tp;
+	  char *mb_tmp = tp.c_get ();
+	  sys_wcstombs (mb_tmp, PATH_MAX, tmp);
+
+	  mount_flags |= MOUNT_USER_TEMP;
+	  int res = mount_table->add_item (mb_tmp, posix_path, mount_flags);
+	  if (res && get_errno () == EMFILE)
+	    return false;
+	}
+    }
   else
     {
       int res = mount_table->add_item (native_path, posix_path, mount_flags);
@@ -1653,6 +1671,9 @@ fillout_mntent (const char *native_path, const char *posix_path, unsigned flags)
   if (flags & (MOUNT_BIND))
     strcat (_my_tls.locals.mnt_opts, (char *) ",bind");
 
+  if (flags & (MOUNT_USER_TEMP))
+    strcat (_my_tls.locals.mnt_opts, (char *) ",usertemp");
+
   ret.mnt_opts = _my_tls.locals.mnt_opts;
 
   ret.mnt_freq = 1;
diff --git a/winsup/doc/pathnames.xml b/winsup/doc/pathnames.xml
index 9077303..9941633 100644
--- a/winsup/doc/pathnames.xml
+++ b/winsup/doc/pathnames.xml
@@ -74,9 +74,10 @@ doesn't matter if you write <literal>FAT</literal> into this field even if
 the filesystem is NTFS.  Cygwin figures out the filesystem type and its
 capabilities by itself.</para>
 
-<para>The only exception is the file system type cygdrive.  This type is
-used to set the cygdrive prefix.  For a description of the cygdrive prefix
-see <xref linkend="cygdrive"></xref></para>
+<para>The only two exceptions are the file system types cygdrive and usertemp.
+The cygdrive type is used to set the cygdrive prefix.  For a description of
+the cygdrive prefix see <xref linkend="cygdrive"></xref>, for a description of
+the usertemp file system type see <xref linkend="usertemp"></xref></para>
 
 <para>The fourth field describes the mount options associated
 with the filesystem.  It is formatted as a comma separated list of
@@ -354,6 +355,23 @@ independently from the current cygdrive prefix:</para>
 
 </sect2>
 
+<sect2 id="usertemp"><title>The usertemp file system type</title>
+
+<para>On Windows, the environment variable <literal>TEMP</literal> specifies
+the location of the temp folder.  It serves the same purpose as the /tmp/
+directory in Unix systems.  In contrast to /tmp/, it is by default a
+different folder for every Windows.  By using the special purpose usertemp
+file system, that temp folder can be mapped to /tmp/.  This is particularly
+useful in setups where the administrator wants to write-protect the entire
+Cygwin directory.  The usertemp file system can be configured in /etc/fstab
+like this:</para>
+
+<screen>
+  none /tmp usertemp binary,posix=0 0 0
+</screen>
+
+</sect2>
+
 <sect2 id="pathnames-symlinks"><title>Symbolic links</title>
 
 <para>Symbolic links are not present and supported on Windows until Windows
Interdiff vs v1:

diff --git a/winsup/cygwin/include/sys/mount.h b/winsup/cygwin/include/sys/mount.h
index 458cf80..ec92794 100644
--- a/winsup/cygwin/include/sys/mount.h
+++ b/winsup/cygwin/include/sys/mount.h
@@ -44,7 +44,8 @@ enum
   MOUNT_DOS =		0x40000,	/* convert leading spaces and trailing
 					   dots and spaces to private use area */
   MOUNT_IHASH =		0x80000,	/* Enforce hash values for inode numbers */
-  MOUNT_BIND =		0x100000	/* Allows bind syntax in fstab file. */
+  MOUNT_BIND =		0x100000,	/* Allows bind syntax in fstab file. */
+  MOUNT_USER_TEMP =	0x200000	/* Mount the user's $TMP. */
 };
 
 int mount (const char *, const char *, unsigned __flags);
diff --git a/winsup/cygwin/mount.cc b/winsup/cygwin/mount.cc
index be5de61..fc080c9 100644
--- a/winsup/cygwin/mount.cc
+++ b/winsup/cygwin/mount.cc
@@ -1200,14 +1200,15 @@ mount_info::from_fstab_line (char *line, bool user)
     }
   else if (!strcmp (fs_type, "usertemp"))
     {
-      WCHAR tmp[MAX_PATH];
+      WCHAR tmp[PATH_MAX + 1];
 
-      if (GetEnvironmentVariableW (L"TEMP", tmp, sizeof(tmp)) && *tmp)
+      if (GetTempPathW (PATH_MAX, tmp))
 	{
-          DWORD len;
-          char mb_tmp[len = sys_wcstombs (NULL, 0, tmp)];
-          sys_wcstombs (mb_tmp, len, tmp);
+	  tmp_pathbuf tp;
+	  char *mb_tmp = tp.c_get ();
+	  sys_wcstombs (mb_tmp, PATH_MAX, tmp);
 
+	  mount_flags |= MOUNT_USER_TEMP;
 	  int res = mount_table->add_item (mb_tmp, posix_path, mount_flags);
 	  if (res && get_errno () == EMFILE)
 	    return false;
@@ -1670,6 +1671,9 @@ fillout_mntent (const char *native_path, const char *posix_path, unsigned flags)
   if (flags & (MOUNT_BIND))
     strcat (_my_tls.locals.mnt_opts, (char *) ",bind");
 
+  if (flags & (MOUNT_USER_TEMP))
+    strcat (_my_tls.locals.mnt_opts, (char *) ",usertemp");
+
   ret.mnt_opts = _my_tls.locals.mnt_opts;
 
   ret.mnt_freq = 1;

-- 
2.1.4
