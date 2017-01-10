Return-Path: <cygwin-patches-return-8677-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16524 invoked by alias); 10 Jan 2017 15:03:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 16424 invoked by uid 89); 10 Jan 2017 15:03:39 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.4 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_SPAM,SPF_PASS autolearn=no version=3.3.2 spammy=
X-HELO: mail-wm0-f68.google.com
Received: from mail-wm0-f68.google.com (HELO mail-wm0-f68.google.com) (74.125.82.68) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 10 Jan 2017 15:03:29 +0000
Received: by mail-wm0-f68.google.com with SMTP id c85so30164426wmi.1        for <cygwin-patches@cygwin.com>; Tue, 10 Jan 2017 07:03:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to         :references;        bh=A2Yq7A6Df0Z4rYobAm0ti8ryy1fxLzrMJslmY6fvoy4=;        b=TCzWCOJh98XCZvBxgLrdb5mmrHIi8FGXgksWWC9T4MJA/WpwL3NbJbeoLeFikAW9Pi         dc1Mm9+mkwqp15n7FnjmO2o/z6Q/btZ/uPQcp2mavGtBR47fUoquwGg3DEdKoZBLE3U8         Y8CHkyYXZnMCYK5AihI2zafQuQZZiJ3I3boJUdI1SbzW0dr5/w+7GEN/zIpx5kPbobnu         RmMxU3H3oH0B1yF05ylcC/aK3nmTp5nud101q30XnIT4Mw6otKO16rMHkuqV6zbiPghe         GwLoTNb3LC8qPAfd4JCNC2mR5ZkKiB3KUB/rt2OjIHwPp+fHhPNKeIt3XvtAWIxvq06z         zdlQ==
X-Gm-Message-State: AIkVDXID5XfVzA/3lfmGRdZF/zcE3OUizFPsDWJTY0Rczo3PfnRAiijRL2Lw6RTYka38rA==
X-Received: by 10.28.180.132 with SMTP id d126mr208750wmf.123.1484060607032;        Tue, 10 Jan 2017 07:03:27 -0800 (PST)
Received: from localhost.localdomain (lri30-45.lri.fr. [129.175.30.45])        by smtp.gmail.com with ESMTPSA id jm6sm3701841wjb.27.2017.01.10.07.03.26        for <cygwin-patches@cygwin.com>        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);        Tue, 10 Jan 2017 07:03:26 -0800 (PST)
From: Erik Bray <erik.m.bray@gmail.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/3] Add a _pinfo.environ() method analogous to _pinfo.cmdline(), and others.
Date: Tue, 10 Jan 2017 15:03:00 -0000
Message-Id: <20170110150310.79112-3-erik.m.bray@gmail.com>
In-Reply-To: <20170110150310.79112-2-erik.m.bray@gmail.com>
References: <20170110150310.79112-2-erik.m.bray@gmail.com>
X-IsSubscribed: yes
X-SW-Source: 2017-q1/txt/msg00018.txt.bz2

From: Erik M. Bray <erik.bray@lri.fr>

Returns the process's environment concatenated into a single block of
null-terminated strings, along with the length of the environment block.

Adds an associated PICOM_ENVIRON commune_process handler.
---
 winsup/cygwin/pinfo.cc | 83 ++++++++++++++++++++++++++++++++++++++++++++++++--
 winsup/cygwin/pinfo.h  |  4 ++-
 2 files changed, 84 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/pinfo.cc b/winsup/cygwin/pinfo.cc
index 1ce6809..fc80efc 100644
--- a/winsup/cygwin/pinfo.cc
+++ b/winsup/cygwin/pinfo.cc
@@ -653,8 +653,26 @@ commune_process (void *arg)
 	else if (!WritePipeOverlapped (tothem, path, n, &nr, 1000L))
 	  sigproc_printf ("WritePipeOverlapped fd failed, %E");
 	break;
-      }
-    }
+	  }
+	case PICOM_ENVIRON:
+	  {
+	sigproc_printf ("processing PICOM_ENVIRON");
+	unsigned n = 0;
+	char **env = cur_environ ();
+	for (char **e = env; *e; e++)
+	  n += strlen (*e) + 1;
+	if (!WritePipeOverlapped (tothem, &n, sizeof n, &nr, 1000L))
+	  sigproc_printf ("WritePipeOverlapped sizeof argv failed, %E");
+	else
+	  for (char **e = env; *e; e++)
+	    if (!WritePipeOverlapped (tothem, *e, strlen (*e) + 1, &nr, 1000L))
+	      {
+	        sigproc_printf ("WritePipeOverlapped arg %d failed, %E", e - env);
+	        break;
+	      }
+	break;
+	  }
+	}
   if (process_sync)
     {
       DWORD res = WaitForSingleObject (process_sync, 5000);
@@ -730,6 +748,7 @@ _pinfo::commune_request (__uint32_t code, ...)
     {
     case PICOM_CMDLINE:
     case PICOM_CWD:
+    case PICOM_ENVIRON:
     case PICOM_ROOT:
     case PICOM_FDS:
     case PICOM_FD:
@@ -993,6 +1012,66 @@ _pinfo::cmdline (size_t& n)
   return s;
 }
 
+
+char *
+_pinfo::environ (size_t& n)
+{
+  char **env = NULL;
+  if (!this || !pid)
+    return NULL;
+  if (ISSTATE (this, PID_NOTCYGWIN))
+    {
+      RTL_USER_PROCESS_PARAMETERS rupp;
+      HANDLE proc = open_commune_proc_parms (dwProcessId, &rupp);
+
+      if (!proc)
+        return NULL;
+
+      MEMORY_BASIC_INFORMATION mbi;
+      SIZE_T envsize;
+      PWCHAR envblock;
+      if (!VirtualQueryEx (proc, rupp.Environment, &mbi, sizeof(mbi)))
+        {
+          NtClose (proc);
+          return NULL;
+        }
+
+      SIZE_T read;
+      envsize = (ptrdiff_t) mbi.RegionSize
+                - ((ptrdiff_t) rupp.Environment - (ptrdiff_t) mbi.BaseAddress);
+      envblock = (PWCHAR) cmalloc_abort (HEAP_COMMUNE, envsize);
+
+      if (ReadProcessMemory (proc, rupp.Environment, envblock, envsize, &read))
+        env = win32env_to_cygenv (envblock, false);
+
+      NtClose (proc);
+    }
+  else if (pid != myself->pid)
+    {
+      commune_result cr = commune_request (PICOM_ENVIRON);
+      n = cr.n;
+      return cr.s;
+    }
+  else
+    env = cur_environ ();
+
+  if (env == NULL)
+      return NULL;
+
+  n = 0;
+  for (char **e = env; *e; e++)
+    n += strlen (*e) + 1;
+
+  char *p, *s;
+  p = s = (char *) cmalloc_abort (HEAP_COMMUNE, n);
+  for (char **e = env; *e; e++)
+    {
+      strcpy (p, *e);
+      p = strchr (p, '\0') + 1;
+    }
+  return s;
+}
+
 /* This is the workhorse which waits for the write end of the pipe
    created during new process creation.  If the pipe is closed or a zero
    is received on the pipe, it is assumed that the cygwin pid has exited.
diff --git a/winsup/cygwin/pinfo.h b/winsup/cygwin/pinfo.h
index fd76c8d..7ad1294 100644
--- a/winsup/cygwin/pinfo.h
+++ b/winsup/cygwin/pinfo.h
@@ -26,7 +26,8 @@ enum picom
   PICOM_ROOT = 3,
   PICOM_FDS = 4,
   PICOM_FD = 5,
-  PICOM_PIPE_FHANDLER = 6
+  PICOM_PIPE_FHANDLER = 6,
+  PICOM_ENVIRON = 7
 };
 
 #define EXITCODE_SET		0x8000000
@@ -106,6 +107,7 @@ public:
   char *root (size_t &);
   char *cwd (size_t &);
   char *cmdline (size_t &);
+  char *environ (size_t &);
   char *win_heap_info (size_t &);
   bool set_ctty (class fhandler_termios *, int);
   bool alert_parent (char);
-- 
2.8.3
