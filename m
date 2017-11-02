Return-Path: <cygwin-patches-return-8896-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 33998 invoked by alias); 2 Nov 2017 15:45:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 33978 invoked by uid 89); 2 Nov 2017 15:45:47 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-25.0 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.2 spammy=
X-HELO: mail-wm0-f49.google.com
Received: from mail-wm0-f49.google.com (HELO mail-wm0-f49.google.com) (74.125.82.49) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 02 Nov 2017 15:45:46 +0000
Received: by mail-wm0-f49.google.com with SMTP id t139so12380526wmt.1        for <cygwin-patches@cygwin.com>; Thu, 02 Nov 2017 08:45:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;        h=x-gm-message-state:from:to:subject:date:message-id;        bh=FNYTsIv3jpZ8AX5oZ0NCUQ2PTyjisnS/7eaN9XcGLBU=;        b=k/f4u0+ho0pJo/bCCt8loDjf5zE9cueH+uGwc9VGVR8K9Wi9C4sZRTdWSHZSwav/mt         dJ28qGEpzda3KA8HU0t8HiFqJiYjma/37C7gWgOvcVcr60tgUVPlzjS4tyueMNy/u2dH         Ln9hEJEWdHhkT0HOU8YPOGHj+5t5T7tl2w9QTpr5UOpkuKgd1K8/QrcReNZuot6NbDjE         Izg9J7MCTTW8oTm1SF3rbxbVot949sJ+Pq0urxlt9T66flNAlEXcLlIPir7XM0+/BHhQ         DAx5xJakVGMauNJX1xhc7j7c2H8aVEgpLoTQsaAjCcP8qrAHJXDPLh6JZZwyowCtRyKy         IYZQ==
X-Gm-Message-State: AMCzsaWxsVCVfQ5E8salhAXIxaIG5IDGWdyb1/Im/h/Q9RcXhV2NtSWI	uWT2S0N3dU644etWYe05bzDuayRS
X-Google-Smtp-Source: ABhQp+SQ3ljDizoFq0WnmSH/cg62gmJmrxoBW/oSYlDghOypx1tuUn7jzPV8nvOWXx8+CmVLd3rBkQ==
X-Received: by 10.28.178.81 with SMTP id b78mr2020051wmf.157.1509637543781;        Thu, 02 Nov 2017 08:45:43 -0700 (PDT)
Received: from localhost.localdomain (lri30-45.lri.fr. [129.175.30.45])        by smtp.gmail.com with ESMTPSA id e71sm3168869wma.13.2017.11.02.08.45.42        for <cygwin-patches@cygwin.com>        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);        Thu, 02 Nov 2017 08:45:42 -0700 (PDT)
From: "Erik M. Bray" <erik.m.bray@gmail.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/2] posix_fadvise() *returns* error codes but does not set errno
Date: Thu, 02 Nov 2017 15:45:00 -0000
Message-Id: <20171102154535.12176-1-erik.m.bray@gmail.com>
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00026.txt.bz2

Also updates the fhandler_*::fadvise implementations to adhere to the same
semantics.
---
 winsup/cygwin/fhandler_disk_file.cc | 11 +++--------
 winsup/cygwin/pipe.cc               |  3 +--
 winsup/cygwin/syscalls.cc           |  2 +-
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_disk_file.cc
index 2144a4c..252dc66 100644
--- a/winsup/cygwin/fhandler_disk_file.cc
+++ b/winsup/cygwin/fhandler_disk_file.cc
@@ -1075,10 +1075,7 @@ int
 fhandler_disk_file::fadvise (off_t offset, off_t length, int advice)
 {
   if (advice < POSIX_FADV_NORMAL || advice > POSIX_FADV_NOREUSE)
-    {
-      set_errno (EINVAL);
-      return -1;
-    }
+    return EINVAL;
 
   /* Windows only supports advice flags for the whole file.  We're using
      a simplified test here so that we don't have to ask for the actual
@@ -1097,9 +1094,7 @@ fhandler_disk_file::fadvise (off_t offset, off_t length, int advice)
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
@@ -1111,7 +1106,7 @@ fhandler_disk_file::fadvise (off_t offset, off_t length, int advice)
       __seterrno_from_nt_status (status);
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
