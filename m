Return-Path: <cygwin-patches-return-8890-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 40196 invoked by alias); 2 Nov 2017 14:15:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 40147 invoked by uid 89); 2 Nov 2017 14:15:30 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-24.3 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_SPAM,SPF_PASS autolearn=ham version=3.3.2 spammy=1718, H*RU:209.85.128.196, Hx-spam-relays-external:209.85.128.196, H*Ad:U*cygwin-patches
X-HELO: mail-wr0-f196.google.com
Received: from mail-wr0-f196.google.com (HELO mail-wr0-f196.google.com) (209.85.128.196) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 02 Nov 2017 14:15:23 +0000
Received: by mail-wr0-f196.google.com with SMTP id l8so5147276wre.12        for <cygwin-patches@cygwin.com>; Thu, 02 Nov 2017 07:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;        h=x-gm-message-state:from:to:subject:date:message-id;        bh=6uh+3TQEqfmPlm31J1qd+DEilRqiz3QmFVh4KeOyuZ4=;        b=re6dfkB5wqEUA6C6qNhYoOUbMu+uy2TjFvIf5G3w9c+F05RVwfkvVuNF4TViQ27aI0         1jlgJiZeLFaDir0uN2ONyHwtgdT/bnXxtfvN6pSxgWiz9aww1StOZGMxBPgJ2gqkFx8d         CBljxoc8bK4TVxg4rh1AKTi3y0p+RfrnAyV5rQr3XEef/1OE2x9ggAvvc+bz2H/fdCkE         N0HPRraZJiuSP479PV5HMohgD5qHnQwUC7wM8CY8GWFu9erArnEfeb3FBffQRZLjFoOh         oEnthm5OnnCUUu3aLwNE4z9fB7zXkt0Ma+shIEkVsocyL5+5OeeL1fbQe8MzsZkpxniy         P4WQ==
X-Gm-Message-State: AMCzsaV1+yMfysp8sYYPPhsg1VnRgH8GruaMkv40bl5RRgaIjM6LRoK6	NnUEwSptgcMKmPhGM5m2ys7ku/ow
X-Google-Smtp-Source: ABhQp+Tk3/fP1W0eClEUkqeBBsRMyAexk8vMF9B4NsRFyHPXxSphZE9iuoQqE0JrdNsOohvYZ3G6Yw==
X-Received: by 10.223.170.67 with SMTP id q3mr2804148wrd.193.1509632120754;        Thu, 02 Nov 2017 07:15:20 -0700 (PDT)
Received: from localhost.localdomain (lri30-45.lri.fr. [129.175.30.45])        by smtp.gmail.com with ESMTPSA id r29sm3815503wra.71.2017.11.02.07.15.19        for <cygwin-patches@cygwin.com>        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);        Thu, 02 Nov 2017 07:15:19 -0700 (PDT)
From: "Erik M. Bray" <erik.m.bray@gmail.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/2] posix_fallocate() *returns* error codes but does not set errno
Date: Thu, 02 Nov 2017 14:15:00 -0000
Message-Id: <20171102141512.4732-1-erik.m.bray@gmail.com>
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00020.txt.bz2

Also updates the fhandler_*::ftruncate implementations to adhere to the same
semantics.  The error handling semantics of those syscalls that use
fhandler_*::ftruncate are moved to the implementations of those syscalls (
in particular ftruncate() and friends still set errno and return -1 on error
but that logic is handled in the syscall implementation).
---
 winsup/cygwin/fhandler.cc           |  3 +--
 winsup/cygwin/fhandler_disk_file.cc | 11 +++++------
 winsup/cygwin/pipe.cc               |  3 +--
 winsup/cygwin/syscalls.cc           | 11 ++++++++---
 4 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/winsup/cygwin/fhandler.cc b/winsup/cygwin/fhandler.cc
index 858c1fd..109bf4e 100644
--- a/winsup/cygwin/fhandler.cc
+++ b/winsup/cygwin/fhandler.cc
@@ -1770,8 +1770,7 @@ fhandler_base::fadvise (off_t offset, off_t length, int advice)
 int
 fhandler_base::ftruncate (off_t length, bool allow_truncate)
 {
-  set_errno (EINVAL);
-  return -1;
+  return EINVAL;
 }
 
 int
diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_disk_file.cc
index f46e355..9d5ec30 100644
--- a/winsup/cygwin/fhandler_disk_file.cc
+++ b/winsup/cygwin/fhandler_disk_file.cc
@@ -1116,11 +1116,11 @@ fhandler_disk_file::ftruncate (off_t length, bool allow_truncate)
   int res = -1;
 
   if (length < 0 || !get_handle ())
-    set_errno (EINVAL);
+    res = EINVAL;
   else if (pc.isdir ())
-    set_errno (EISDIR);
+    res = EISDIR;
   else if (!(get_access () & GENERIC_WRITE))
-    set_errno (EBADF);
+    res = EBADF;
   else
     {
       NTSTATUS status;
@@ -1132,8 +1132,7 @@ fhandler_disk_file::ftruncate (off_t length, bool allow_truncate)
 				       FileStandardInformation);
       if (!NT_SUCCESS (status))
 	{
-	  __seterrno_from_nt_status (status);
-	  return -1;
+	  return geterrno_from_nt_status (status);
 	}
 
       /* If called through posix_fallocate, silently succeed if length
@@ -1160,7 +1159,7 @@ fhandler_disk_file::ftruncate (off_t length, bool allow_truncate)
 				     &feofi, sizeof feofi,
 				     FileEndOfFileInformation);
       if (!NT_SUCCESS (status))
-	__seterrno_from_nt_status (status);
+	res = geterrno_from_nt_status (status);
       else
 	res = 0;
     }
diff --git a/winsup/cygwin/pipe.cc b/winsup/cygwin/pipe.cc
index 8738d34..f1eace6 100644
--- a/winsup/cygwin/pipe.cc
+++ b/winsup/cygwin/pipe.cc
@@ -171,8 +171,7 @@ fhandler_pipe::fadvise (off_t offset, off_t length, int advice)
 int
 fhandler_pipe::ftruncate (off_t length, bool allow_truncate)
 {
-  set_errno (allow_truncate ? EINVAL : ESPIPE);
-  return -1;
+  return allow_truncate ? EINVAL : ESPIPE;
 }
 
 char *
diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index d0d735b..1807afc 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -2946,16 +2946,16 @@ posix_fadvise (int fd, off_t offset, off_t len, int advice)
 extern "C" int
 posix_fallocate (int fd, off_t offset, off_t len)
 {
-  int res = -1;
+  int res = 0;
   if (offset < 0 || len == 0)
-    set_errno (EINVAL);
+    res = EINVAL;
   else
     {
       cygheap_fdget cfd (fd);
       if (cfd >= 0)
 	res = cfd->ftruncate (offset + len, false);
       else
-	set_errno (EBADF);
+	res = EBADF;
     }
   syscall_printf ("%R = posix_fallocate(%d, %D, %D)", res, fd, offset, len);
   return res;
@@ -2968,6 +2968,11 @@ ftruncate64 (int fd, off_t length)
   cygheap_fdget cfd (fd);
   if (cfd >= 0)
     res = cfd->ftruncate (length, true);
+    if (res)
+      {
+        set_errno (res);
+        res = -1;
+      }
   else
     set_errno (EBADF);
   syscall_printf ("%R = ftruncate(%d, %D)", res, fd, length);
-- 
2.8.3
