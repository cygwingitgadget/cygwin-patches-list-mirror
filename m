Return-Path: <cygwin-patches-return-8889-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 55711 invoked by alias); 2 Nov 2017 13:26:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 55698 invoked by uid 89); 2 Nov 2017 13:26:42 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-24.6 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mail-wm0-f50.google.com
Received: from mail-wm0-f50.google.com (HELO mail-wm0-f50.google.com) (74.125.82.50) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 02 Nov 2017 13:26:40 +0000
Received: by mail-wm0-f50.google.com with SMTP id p75so11099543wmg.3        for <cygwin-patches@cygwin.com>; Thu, 02 Nov 2017 06:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;        h=x-gm-message-state:from:to:subject:date:message-id;        bh=niMYu3NRzIS0aI+T427QhEUzYpkfFf/RpZpit41GbO8=;        b=mAqxTn/LuYsE9L6D34Ifx9biXNKayWVvlsUw7RVpRzvFJhrsXSchZ859GkL4DlXHIy         G3UBMkgBsTjKZ1VJkZ4Qtib2cM9a2VE7ssNqBcusbVV/H6ZluHWQTAJLWlMQdHRVwFrp         Uhw9cwCV4yjO2iB8Ca9vE/zqYBsCsk85Vh66ThvSb4VFQ/n6hHN3Ib8r4QpoBWnDECTn         3sD3c/7ebiUntjTdMEzbxVt+/5En/BMagaCK1jsSBMnt4VjELEPln37FU6+lb8XFkByu         vebCgVsRlM4lAiYaJNh0lEwyFstAc6xwyHzLxa37oh0QJKPJyg+PdDMy8Bgu/jlPvPdg         ozVQ==
X-Gm-Message-State: AMCzsaVeAdsLtmQwMgwD+1Y4/1CGU8LgSvOGh3zxsATiBHRsa2+MDNsV	IeVJbwLBPb9RpY6YZzEVCR6i53Cg
X-Google-Smtp-Source: ABhQp+S5jZk57iZbzTsGC+sHj2U+S597oRg8a/5bu3ptUT/yWFcYiWk3xz+UezSRNlMcwlkpPBFrDw==
X-Received: by 10.28.37.195 with SMTP id l186mr1801297wml.144.1509629198013;        Thu, 02 Nov 2017 06:26:38 -0700 (PDT)
Received: from localhost.localdomain (lri30-45.lri.fr. [129.175.30.45])        by smtp.gmail.com with ESMTPSA id v8sm2394995wrg.80.2017.11.02.06.26.36        for <cygwin-patches@cygwin.com>        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);        Thu, 02 Nov 2017 06:26:37 -0700 (PDT)
From: "Erik M. Bray" <erik.m.bray@gmail.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] posix_fadvise() *returns* error codes but does not set errno
Date: Thu, 02 Nov 2017 13:26:00 -0000
Message-Id: <20171102132622.5756-1-erik.m.bray@gmail.com>
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00019.txt.bz2

Also updates the fhandler_*::fadvise implementations to adhere to the same
semantics.
---
 winsup/cygwin/fhandler.cc           |  3 +--
 winsup/cygwin/fhandler_disk_file.cc | 16 ++++++----------
 winsup/cygwin/pipe.cc               |  3 +--
 winsup/cygwin/syscalls.cc           |  2 +-
 4 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/winsup/cygwin/fhandler.cc b/winsup/cygwin/fhandler.cc
index d719b7c..858c1fd 100644
--- a/winsup/cygwin/fhandler.cc
+++ b/winsup/cygwin/fhandler.cc
@@ -1764,8 +1764,7 @@ fhandler_base::fsetxattr (const char *name, const void *value, size_t size,
 int
 fhandler_base::fadvise (off_t offset, off_t length, int advice)
 {
-  set_errno (EINVAL);
-  return -1;
+  return EINVAL;
 }
 
 int
diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_disk_file.cc
index 2144a4c..f46e355 100644
--- a/winsup/cygwin/fhandler_disk_file.cc
+++ b/winsup/cygwin/fhandler_disk_file.cc
@@ -1076,8 +1076,7 @@ fhandler_disk_file::fadvise (off_t offset, off_t length, int advice)
 {
   if (advice < POSIX_FADV_NORMAL || advice > POSIX_FADV_NOREUSE)
     {
-      set_errno (EINVAL);
-      return -1;
+      return EINVAL;
     }
 
   /* Windows only supports advice flags for the whole file.  We're using
@@ -1097,21 +1096,18 @@ fhandler_disk_file::fadvise (off_t offset, off_t length, int advice)
   NTSTATUS status = NtQueryInformationFile (get_handle (), &io,
 					    &fmi, sizeof fmi,
 					    FileModeInformation);
-  if (!NT_SUCCESS (status))
-    __seterrno_from_nt_status (status);
-  else
+  if (NT_SUCCESS (status))
     {
       fmi.Mode &= ~FILE_SEQUENTIAL_ONLY;
       if (advice == POSIX_FADV_SEQUENTIAL)
-	fmi.Mode |= FILE_SEQUENTIAL_ONLY;
+        fmi.Mode |= FILE_SEQUENTIAL_ONLY;
       status = NtSetInformationFile (get_handle (), &io, &fmi, sizeof fmi,
-				     FileModeInformation);
+                                     FileModeInformation);
       if (NT_SUCCESS (status))
-	return 0;
-      __seterrno_from_nt_status (status);
+	    return 0;
     }
 
-  return -1;
+  return geterrno_from_nt_status (status);
 }
 
 int
diff --git a/winsup/cygwin/pipe.cc b/winsup/cygwin/pipe.cc
index 79b7966..8738d34 100644
--- a/winsup/cygwin/pipe.cc
+++ b/winsup/cygwin/pipe.cc
@@ -165,8 +165,7 @@ fhandler_pipe::lseek (off_t offset, int whence)
 int
 fhandler_pipe::fadvise (off_t offset, off_t length, int advice)
 {
-  set_errno (ESPIPE);
-  return -1;
+  return ESPIPE;
 }
 
 int
diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index caa3a77..d0d735b 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -2937,7 +2937,7 @@ posix_fadvise (int fd, off_t offset, off_t len, int advice)
   if (cfd >= 0)
     res = cfd->fadvise (offset, len, advice);
   else
-    set_errno (EBADF);
+    res = EBADF;
   syscall_printf ("%R = posix_fadvice(%d, %D, %D, %d)",
 		  res, fd, offset, len, advice);
   return res;
-- 
2.8.3
