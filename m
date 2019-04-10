Return-Path: <cygwin-patches-return-9322-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31668 invoked by alias); 10 Apr 2019 15:08:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 31652 invoked by uid 89); 10 Apr 2019 15:08:00 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=HX-Gm-Message-State:APjAAAX, sk:format_
X-HELO: mail-wr1-f53.google.com
Received: from mail-wr1-f53.google.com (HELO mail-wr1-f53.google.com) (209.85.221.53) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 10 Apr 2019 15:07:59 +0000
Received: by mail-wr1-f53.google.com with SMTP id q1so3436271wrp.0        for <cygwin-patches@cygwin.com>; Wed, 10 Apr 2019 08:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=gmail.com; s=20161025;        h=from:to:subject:date:message-id;        bh=TPJd6yn/+UyyxPynbKRIavy31HBmPovYqn0l6SFsnC8=;        b=Z2mjALDc/uL5V7pa1LlDboih+XF3gJiWWevjaJDORBXAql3G6CQDYbM3A05aez3Osh         v9kCv+XkdB4xXeFArGZT58knenOtbxv7K3/GQ0AWS2CVjWlMZ84CpNovSDFj5I2Dwr3d         QJOwYQwD/2zG1ymhovR0fzsnua2HB08k/VtDrSK+Ean+To4wKDmqXgNx0INoeobZr2p0         GquvTJLLDf+Mx4JXT3U3qoF24niwq7NHPVWHLzbcmem5cxpVOmX0VVK15eRptgwMo7J7         YiMVxZYsjQehPSnBVRgcSSmuM5f99CfvyZrvPJRhgu3bzAOVtdBnxo8s+e/WGtDQtHxp         AaVQ==
Return-Path: <erik.m.bray@gmail.com>
Received: from smtp.lri.fr (lri30-247.lri.fr. [129.175.30.247])        by smtp.gmail.com with ESMTPSA id r6sm31916129wrt.38.2019.04.10.08.07.50        for <cygwin-patches@cygwin.com>        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);        Wed, 10 Apr 2019 08:07:50 -0700 (PDT)
From: "Erik M. Bray" <erik.m.bray@gmail.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Improve error handling in /proc/[pid]/ virtual files.
Date: Wed, 10 Apr 2019 15:08:00 -0000
Message-Id: <20190410150522.22920-1-erik.m.bray@gmail.com>
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00029.txt.bz2

* Changes error handling to allow /proc/[pid]/ virtual files to be
  empty in some cases (in this case the file's formatter should return
  -1 upon error, not 0).

* Better error handling of /proc/[pid]/stat for zombie processes:
  previously trying to open this file on zombie processes resulted
  in an EINVAL being returned by open().  Now the file can be read,
  and fields that can no longer be read are just zeroed.

* Similarly for /proc/[pid]/statm for zombie processes.

* Similarly for /proc/[pid]/maps for zombie processes (in this case the
  file can be read but is zero-length, which is consistent with observed
  behavior on Linux.
---
 winsup/cygwin/fhandler_process.cc | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/fhandler_process.cc b/winsup/cygwin/fhandler_process.cc
index 44410b223..5ee129317 100644
--- a/winsup/cygwin/fhandler_process.cc
+++ b/winsup/cygwin/fhandler_process.cc
@@ -355,7 +355,7 @@ fhandler_process::fill_filebuf ()
 	}
       else
 	filesize = process_tab[fileid].format_func (p, filebuf);
-      return !filesize ? false : true;
+      return filesize < 0 ? false : true;
     }
   return false;
 }
@@ -818,7 +818,22 @@ format_process_maps (void *data, char *&destbuf)
   HANDLE proc = OpenProcess (PROCESS_QUERY_INFORMATION
 			     | PROCESS_VM_READ, FALSE, p->dwProcessId);
   if (!proc)
-    return 0;
+    {
+      if (!(p->process_state & PID_EXITED))
+        {
+          DWORD error = GetLastError ();
+          __seterrno_from_win_error (error);
+          debug_printf ("OpenProcess: ret %u; pid: %d", error, p->dwProcessId);
+          return -1;
+        }
+      else
+        {
+          /* Else it's a zombie process; just return an empty string */
+          destbuf = (char *) crealloc_abort (destbuf, 1);
+          destbuf[0] = '\0';
+          return 0;
+        }
+    }
 
   NTSTATUS status;
   PROCESS_BASIC_INFORMATION pbi;
@@ -1101,9 +1116,14 @@ format_process_stat (void *data, char *&destbuf)
 			  FALSE, p->dwProcessId);
   if (hProcess == NULL)
     {
-      DWORD error = GetLastError ();
-      __seterrno_from_win_error (error);
-      debug_printf ("OpenProcess: ret %u", error);
+      if (!(p->process_state & PID_EXITED))
+        {
+          DWORD error = GetLastError ();
+          __seterrno_from_win_error (error);
+          debug_printf ("OpenProcess: ret %u; pid: %d", error, p->dwProcessId);
+          return -1;
+        }
+      /* Else it's a zombie process; just leave each structure zero'd */
     }
   else
     {
@@ -1258,9 +1278,10 @@ format_process_statm (void *data, char *&destbuf)
 {
   _pinfo *p = (_pinfo *) data;
   size_t vmsize = 0, vmrss = 0, vmtext = 0, vmdata = 0, vmlib = 0, vmshare = 0;
+
   if (!get_mem_values (p->dwProcessId, vmsize, vmrss, vmtext, vmdata,
-		       vmlib, vmshare))
-    return 0;
+		       vmlib, vmshare) && !(p->process_state & PID_EXITED))
+    return -1;  /* Error out unless it's a zombie process */
 
   destbuf = (char *) crealloc_abort (destbuf, 96);
   return __small_sprintf (destbuf, "%lu %lu %lu %lu %lu %lu 0\n",
-- 
2.15.1
