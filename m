Return-Path: <cygwin-patches-return-8897-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 34408 invoked by alias); 2 Nov 2017 15:45:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 34349 invoked by uid 89); 2 Nov 2017 15:45:51 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-24.7 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_SPAM,SPF_PASS autolearn=ham version=3.3.2 spammy=
X-HELO: mail-wr0-f194.google.com
Received: from mail-wr0-f194.google.com (HELO mail-wr0-f194.google.com) (209.85.128.194) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 02 Nov 2017 15:45:49 +0000
Received: by mail-wr0-f194.google.com with SMTP id o44so5417370wrf.11        for <cygwin-patches@cygwin.com>; Thu, 02 Nov 2017 08:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to         :references;        bh=65tV+v6LN5lCh5tUu1fUyJADauX/mfF6cVthIja1E4s=;        b=GQUHkAuwhZCCRshxiSxTvqm6Ua30mf+wXl0ajwKjgbGol6vPzinDqoxT0OBH8U5gFP         nwHzFyyduSY3nKc91yYxqU4jNGEebGzBaTOUHWNWLsOxSYu4LoAhxgYufr/RBcIQWOh4         ZJfK9f4Jg0he5gQcTqa+IlaHmLj83LkGtlR7CsbwQYBaWHtDUWPDc3nXz3hNJE5BYT6V         XtoTd5Hvy9BQMAR9dLE80OzYUqe36yVL4hBFHRhZDEN3e+z7oe37YGeWw6G5f8wpN96P         2CGo9dAyG3EDAddEglIIiQDPovbCTJLmQlo69kTWiZB8awYpFdhfUQTMfhoyJ7Da0hy1         eHMA==
X-Gm-Message-State: AMCzsaVvztZ5mbsGjH83SV0FS1hg/5L8JJBAMehXpme+ggV/EM7RS4ZU	VCltfXdeWX4LTCVSrnl0URas1u/1
X-Google-Smtp-Source: ABhQp+RTnnwJgzYIIHY34pM+lLSTB4S8vqhx6V8YId/6WHza6EhmUuG+iOMSM9p5Iwb7mbQH1cNzjA==
X-Received: by 10.223.147.166 with SMTP id 35mr3679724wrp.90.1509637546907;        Thu, 02 Nov 2017 08:45:46 -0700 (PDT)
Received: from localhost.localdomain (lri30-45.lri.fr. [129.175.30.45])        by smtp.gmail.com with ESMTPSA id e71sm3168869wma.13.2017.11.02.08.45.45        for <cygwin-patches@cygwin.com>        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);        Thu, 02 Nov 2017 08:45:46 -0700 (PDT)
From: "Erik M. Bray" <erik.m.bray@gmail.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/2] posix_fallocate() *returns* error codes but does not set errno
Date: Thu, 02 Nov 2017 15:45:00 -0000
Message-Id: <20171102154535.12176-2-erik.m.bray@gmail.com>
In-Reply-To: <20171102154535.12176-1-erik.m.bray@gmail.com>
References: <20171102154535.12176-1-erik.m.bray@gmail.com>
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00027.txt.bz2

Also updates the fhandler_*::ftruncate implementations to adhere to the same
semantics.  The error handling semantics of those syscalls that use
fhandler_*::ftruncate are moved to the implementations of those syscalls (
in particular ftruncate() and friends still set errno and return -1 on error
but that logic is handled in the syscall implementation).
---
 winsup/cygwin/fhandler.cc           |  3 +--
 winsup/cygwin/fhandler_disk_file.cc | 17 ++++++-----------
 winsup/cygwin/pipe.cc               |  3 +--
 winsup/cygwin/syscalls.cc           | 11 ++++++++---
 4 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/winsup/cygwin/fhandler.cc b/winsup/cygwin/fhandler.cc
index d719b7c..5b7d002 100644
--- a/winsup/cygwin/fhandler.cc
+++ b/winsup/cygwin/fhandler.cc
@@ -1771,8 +1771,7 @@ fhandler_base::fadvise (off_t offset, off_t length, int advice)
 int
 fhandler_base::ftruncate (off_t length, bool allow_truncate)
 {
-  set_errno (EINVAL);
-  return -1;
+  return EINVAL;
 }
 
 int
diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_disk_file.cc
index 252dc66..bc8fead 100644
--- a/winsup/cygwin/fhandler_disk_file.cc
+++ b/winsup/cygwin/fhandler_disk_file.cc
@@ -1112,14 +1112,14 @@ fhandler_disk_file::fadvise (off_t offset, off_t length, int advice)
 int
 fhandler_disk_file::ftruncate (off_t length, bool allow_truncate)
 {
-  int res = -1;
+  int res = 0;
 
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
@@ -1130,10 +1130,7 @@ fhandler_disk_file::ftruncate (off_t length, bool allow_truncate)
       status = NtQueryInformationFile (get_handle (), &io, &fsi, sizeof fsi,
 				       FileStandardInformation);
       if (!NT_SUCCESS (status))
-	{
-	  __seterrno_from_nt_status (status);
-	  return -1;
-	}
+	return geterrno_from_nt_status (status);
 
       /* If called through posix_fallocate, silently succeed if length
 	 is less than the file's actual length. */
@@ -1159,9 +1156,7 @@ fhandler_disk_file::ftruncate (off_t length, bool allow_truncate)
 				     &feofi, sizeof feofi,
 				     FileEndOfFileInformation);
       if (!NT_SUCCESS (status))
-	__seterrno_from_nt_status (status);
-      else
-	res = 0;
+	res = geterrno_from_nt_status (status);
     }
   return res;
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
