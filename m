Return-Path: <cygwin-patches-return-8279-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 53891 invoked by alias); 1 Dec 2015 14:12:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 53880 invoked by uid 89); 1 Dec 2015 14:12:15 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.1 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mout.gmx.net
Received: from mout.gmx.net (HELO mout.gmx.net) (212.227.17.20) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Tue, 01 Dec 2015 14:12:13 +0000
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0M4ScS-1aDbrl01ee-00yiNE for <cygwin-patches@cygwin.com>; Tue, 01 Dec 2015 15:07:09 +0100
Date: Tue, 01 Dec 2015 14:12:00 -0000
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Introduce the 'usertemp' filesystem type
In-Reply-To: <3ddcb7adf1004c146964beda2f90521bb1c19d4a.1448978434.git.johannes.schindelin@gmx.de>
Message-ID: <alpine.DEB.1.00.1512011504240.1686@s15462909.onlinehome-server.info>
References: <0MIuft-1ZZdDB2IaP-002Y2r@mail.gmx.com> <3ddcb7adf1004c146964beda2f90521bb1c19d4a.1448978434.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-UI-Out-Filterresults: notjunk:1;V01:K0:ylLlH3S+5P4=:mcGmpekqwsQKjptd+RG9iM UsI9JYGwbro7GDEq2kiNnbBm/+bjrnZMH/hiU1evD6IeMKfw6ENw6qPjAecLvkbVykMRfv3hz 755aR0jSR/xRKnER6qj11GLllExYRzft/xKVidWd1FhPg4xvsMjkzy5a/JtpgLpyGpCj2MEY0 Gz0QyAx+pzg957+7ffcjZtSCYZZumnSYN2nALdV3/3kNRzTUeG4f8NqEwUogsI/qMKzqq/1NG ai0hczOJMtBedKag/vTwmDFw7eQ/DsPqe7rg3y4l/z3lOdZo7q8r1UwWM5rS+NfVidC/ktJ8u cxvGYwYFhZNLRi1pwK09Uq56+X5cKYCB+Y6PuUZ1PBYwLQWHIg4WDACQhYlpqkb4taOPZhg27 TG5Pk6C+q7iGaCDk1yPgQvII6rb5VY3mqFMaDPH3fqS+1u7hfFukVdnPzOptfRDQsiHToL9YU hmqwdW+CtxCPd4olb7JfWh6V8uC2dSCH7tS1b+yiVGWRwkpGj73PxHOxI9b7EsfVDzc6j5K7d nKL5utkwzJDOe6VUDNH65rG2EIAA3YuBcfm+KPJE9EgKFF/X/9uG6Wg/j3HPqoLfGbTq39loV nhuItOYLm2nTYoy6D0Hn9QfgnrwfNkMAPV4azEud6usA/kxdaKVtnnlPAyyMVOGhBSGBiE8OD SOmusbSxtpnjPTz09IUv4L4Ohp4zIYEKHII9Lkh8S0lTrbLsIvTeWvl0oDeHmuHQzaLyKEUQX 7XDq4QNFitM00eXelEJMWIvUQOTNBLXQsqEK4yt04TyG+wieX4Mi2T1cf22C4T149OagQWWbg ztySYba
X-IsSubscribed: yes
X-SW-Source: 2015-q4/txt/msg00032.txt.bz2

... and here is the interdiff vs v1 (compare also to the 'pseudo Pull
Request' at
https://github.com/dscho/msys2-runtime/compare/tempfs-cygwin-v1-rebased...tempfs-cygwin-v2):

diff --git a/winsup/cygwin/include/sys/mount.h
b/winsup/cygwin/include/sys/mount.h
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

