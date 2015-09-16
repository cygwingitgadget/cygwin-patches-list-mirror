Return-Path: <cygwin-patches-return-8242-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 126989 invoked by alias); 16 Sep 2015 07:35:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 126976 invoked by uid 89); 16 Sep 2015 07:35:45 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.6 required=5.0 tests=AWL,BAYES_20,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mout.gmx.net
Received: from mout.gmx.net (HELO mout.gmx.net) (212.227.17.21) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Wed, 16 Sep 2015 07:35:43 +0000
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0MarAM-1ZIvPK2HGs-00KM2s for <cygwin-patches@cygwin.com>; Wed, 16 Sep 2015 09:35:40 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Wed, 16 Sep 2015 07:35:00 -0000
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Introduce the 'usertemp' filesystem type
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
Message-ID: <0MIuft-1ZZdDB2IaP-002Y2r@mail.gmx.com>
X-UI-Out-Filterresults: notjunk:1;V01:K0:IGSLnFRbWzg=:d7jXjek0JN6zBHLFAKmDso jOoXj8oflSuj2h4dNRAaheys3vXU9WqeFTspy7XTObPpq1sqqZph4DV3GP6QmN/IZsgKw4gyt zpVtzpkFXyaQNPGuZmNvkeFYU179qNufK6THBtjZk9hqDPvZfFmu3ijZazCV69G2fR5ypfXlG sf2GrpfWxxZv+xv9JwPrbAiHwRk5ZtWnArNlO2vkrZRHlvgFsrL5OLk+8cRcRlPhuqQF5kmB9 EMX7PBXj6ioqhDSHoINyLU8TRtRiZgkc89EDfGJOUfp8hMj26LLTk/pcPBUPt5QzGmb2CutO4 xZkZKj2f+apeQynpYjqHnX72nWz9tHuSkbepmT0cjynQ0ltGZoVX0GmSb/qqP8b5EGbMEam/3 DgjtNo6tQY+TtOsqfGKlNVk1M7WMwjJGCDzkAngVQc8ZfUw2dmuuChfM+6hkSbjXhfmR0yldG Rc1+mGwFssHYr4QId5JjAPhIL0E9BpcZlVBM7B4earsknc1aMZqA1UqrDyA2UGKHwgO0Tagui xsRx2Eo9ILVfC5I5+Vbnjq/uRGWN6IDjlnTkN27LWNJ2hk4NIkQ51GjQ8bjnpvXNmwC6tNP3o xTVOC9xG+LKFNEA6AtN+StlKxu+kcOhmL7zZsiltGIhIhRIZhd5S3ABdw3OQEDbyHKb94EndI GG8g+HN8QCGgzMBPfzH+haDU4mwIPb1cIvzhBT7CAfIoFMOE8tofz8HAOiJ3Pz0ZhJdAH7+ei Qgt9pZjjaRXi9SPlIPSx2qLxWPxn8RCNXQ5+Wg==
X-IsSubscribed: yes
X-SW-Source: 2015-q3/txt/msg00024.txt.bz2

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
 winsup/cygwin/mount.cc   | 17 +++++++++++++++++
 winsup/doc/pathnames.xml | 24 +++++++++++++++++++++---
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/mount.cc b/winsup/cygwin/mount.cc
index 6cf3ddf..0b3dbdc 100644
--- a/winsup/cygwin/mount.cc
+++ b/winsup/cygwin/mount.cc
@@ -1139,6 +1139,8 @@ mount_info::from_fstab_line (char *line, bool user)
   unsigned mount_flags = MOUNT_SYSTEM | MOUNT_BINARY;
   if (!strcmp (fs_type, "cygdrive"))
     mount_flags |= MOUNT_NOPOSIX;
+  if (!strcmp (fs_type, "usertemp"))
+    mount_flags |= MOUNT_IMMUTABLE;
   if (!fstab_read_flags (&c, mount_flags, false))
     return true;
   if (mount_flags & MOUNT_BIND)
@@ -1163,6 +1165,21 @@ mount_info::from_fstab_line (char *line, bool user)
       slashify (posix_path, cygdrive, 1);
       cygdrive_len = strlen (cygdrive);
     }
+  else if (!strcmp (fs_type, "usertemp"))
+    {
+      WCHAR tmp[MAX_PATH];
+
+      if (GetEnvironmentVariableW (L"TEMP", tmp, sizeof(tmp)) && *tmp)
+	{
+          DWORD len;
+          char mb_tmp[len = sys_wcstombs (NULL, 0, tmp)];
+          sys_wcstombs (mb_tmp, len, tmp);
+
+	  int res = mount_table->add_item (mb_tmp, posix_path, mount_flags);
+	  if (res && get_errno () == EMFILE)
+	    return false;
+	}
+    }
   else
     {
       int res = mount_table->add_item (native_path, posix_path, mount_flags);
diff --git a/winsup/doc/pathnames.xml b/winsup/doc/pathnames.xml
index cdbf9fa..166c504 100644
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
-- 
2.5.2.windows.2

