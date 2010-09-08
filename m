Return-Path: <cygwin-patches-return-7078-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22779 invoked by alias); 8 Sep 2010 22:27:27 -0000
Received: (qmail 22768 invoked by uid 22791); 8 Sep 2010 22:27:27 -0000
X-SWARE-Spam-Status: No, hits=-0.5 required=5.0	tests=AWL,BAYES_00,TW_CP,T_RP_MATCHES_RCVD
X-Spam-Check-By: sourceware.org
Received: from ixqw-mail-out.ixiacom.com (HELO ixqw-mail-out.ixiacom.com) (66.77.12.12)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 08 Sep 2010 22:27:17 +0000
Received: from [10.64.33.35] (10.64.33.35) by IXCA-HC1.ixiacom.com (10.200.2.55) with Microsoft SMTP Server (TLS) id 8.1.358.0; Wed, 8 Sep 2010 15:27:15 -0700
Message-ID: <4C880DC2.1070706@ixiacom.com>
Date: Wed, 08 Sep 2010 22:27:00 -0000
From: Earl Chew <echew@ixiacom.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-GB; rv:1.9.2.9) Gecko/20100825 Thunderbird/3.1.3
MIME-Version: 1.0
To: <cygwin-patches@cygwin.com>
Subject: Mounting /tmp at TMP or TEMP as a last resort
References: <4C880761.2030503@ixiacom.com>
In-Reply-To: <4C880761.2030503@ixiacom.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q3/txt/msg00038.txt.bz2

We have an installation that we deploy to a bunch of workstations. We prefer
if the installation uses the temporary file directory that Windows has already
allocated for the user.

The entry for /tmp in /etc/fstab, or the directory /tmp, is preferred.
If neither is found, the patch mounts /tmp at the directory indicated
by the environment variable TMP or, if that is not set, TEMP. The patch
does nothing if neither environment variable is set.

Earl

--- mount.h.orig	2010-03-18 07:57:09.000000000 -0700
+++ mount.h	2010-09-08 11:10:23.218802900 -0700
@@ -140,6 +140,7 @@
   int nmounts;
   mount_item mount[MAX_MOUNTS];
 
+  static bool got_tmp;
   static bool got_usr_bin;
   static bool got_usr_lib;
   static int root_idx;
--- mount.cc.orig	2010-03-30 03:03:09.000000000 -0700
+++ mount.cc	2010-09-08 11:35:27.765251900 -0700
@@ -45,6 +45,7 @@
 #define isproc(path) \
   (path_prefix_p (proc, (path), proc_len, false))
 
+bool NO_COPY mount_info::got_tmp;
 bool NO_COPY mount_info::got_usr_bin;
 bool NO_COPY mount_info::got_usr_lib;
 int NO_COPY mount_info::root_idx = -1;
@@ -390,6 +391,24 @@
 		  MOUNT_SYSTEM | MOUNT_BINARY | MOUNT_AUTOMATIC);
       }
     }
+
+  if (!got_tmp)
+    {
+      char tmpdir[PATH_MAX];
+      if (root_idx < 0)
+	api_fatal ("root_idx %d, user_shared magic %p, nmounts %d", root_idx, user_shared->version, nmounts);
+      char *p = stpcpy (tmpdir, mount[root_idx].native_path);
+      stpcpy (p, "\\tmp");
+      if (GetFileAttributes (tmpdir) != FILE_ATTRIBUTE_DIRECTORY)
+        {
+	  const char *tmp = getenv("TMP");
+	  if (!tmp)
+	    tmp = getenv("TEMP");
+	  if (tmp)
+	    add_item (tmp, "/tmp",
+		      MOUNT_SYSTEM | MOUNT_BINARY | MOUNT_AUTOMATIC);
+	}
+    }
 }
 
 static void
@@ -1342,6 +1361,9 @@
   if (i == nmounts)
     nmounts++;
 
+  if (strcmp (posixtmp, "/tmp") == 0)
+    got_tmp = true;
+
   if (strcmp (posixtmp, "/usr/bin") == 0)
     got_usr_bin = true;
 
