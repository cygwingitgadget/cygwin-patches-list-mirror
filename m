Return-Path: <cygwin-patches-return-8661-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 73586 invoked by alias); 5 Jan 2017 17:39:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 73422 invoked by uid 89); 5 Jan 2017 17:39:50 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.4 required=5.0 tests=BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_SPAM,SPF_PASS autolearn=no version=3.3.2 spammy=Hx-languages-length:1733, Erik, defunct, erik
X-HELO: mail-wm0-f66.google.com
Received: from mail-wm0-f66.google.com (HELO mail-wm0-f66.google.com) (74.125.82.66) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 05 Jan 2017 17:39:49 +0000
Received: by mail-wm0-f66.google.com with SMTP id l2so72514240wml.2        for <cygwin-patches@cygwin.com>; Thu, 05 Jan 2017 09:39:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to         :references;        bh=QpHSTl2hHzNjYp+MtvfBblOBStF+IXH2wQ/f3e8kpR4=;        b=MsxsJ/gMR7qA04wgzuzKBJjnLfe4k1KZYHh70Wiy8x0ZVVJcCVK6mR449EhFRwv2nP         kqGYQikrwADQmPZzASJtoDxnU1EWa3dkjhaJyiMV8rLhgItK2s8iNwtyeh9jPKt4Re1F         33UXXrXI2g6iLbAO+GlAwkEM/DU+46+BV1JuXeoMXuB9aMYhLgnsIm3UD/KnuHYsuBMm         M0tuvqH3gN2rIol8fZZMDTjaNnba7MmsRXsfbGLznQVI0D6NDGNAQGEwp3cR0nNbPoKY         swBB3M3Ox3YcCQcphPFtGQjj/PUU6+JkIEkKnLSbF36sXTg7ixZ4CD+STwpbkg6XBXF+         6ObQ==
X-Gm-Message-State: AIkVDXKFKyXtG8VkcsRK7wDcWja/wq+q/c5ewM2KU0G/nMRluC7oV5MHQo/CFSKQoB/YXg==
X-Received: by 10.28.152.137 with SMTP id a131mr5864512wme.139.1483637986739;        Thu, 05 Jan 2017 09:39:46 -0800 (PST)
Received: from localhost.localdomain (lri30-45.lri.fr. [129.175.30.45])        by smtp.gmail.com with ESMTPSA id t194sm84773wmd.1.2017.01.05.09.39.45        for <cygwin-patches@cygwin.com>        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);        Thu, 05 Jan 2017 09:39:46 -0800 (PST)
From: erik.m.bray@gmail.com
To: cygwin-patches@cygwin.com
Subject: [PATCH 3/3] Add a /proc/<pid>/environ proc file handler, analogous to /proc/<pid>/cmdline.
Date: Thu, 05 Jan 2017 17:39:00 -0000
Message-Id: <20170105173929.65728-4-erik.m.bray@gmail.com>
In-Reply-To: <20170105173929.65728-1-erik.m.bray@gmail.com>
References: <20170105173929.65728-1-erik.m.bray@gmail.com>
X-IsSubscribed: yes
X-SW-Source: 2017-q1/txt/msg00002.txt.bz2

From: "Erik M. Bray" <erik.bray@lri.fr>

---
 winsup/cygwin/fhandler_process.cc | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/winsup/cygwin/fhandler_process.cc b/winsup/cygwin/fhandler_process.cc
index 5f530a2..bbb44fa 100644
--- a/winsup/cygwin/fhandler_process.cc
+++ b/winsup/cygwin/fhandler_process.cc
@@ -49,6 +49,7 @@ static off_t format_process_ctty (void *, char *&);
 static off_t format_process_fd (void *, char *&);
 static off_t format_process_mounts (void *, char *&);
 static off_t format_process_mountinfo (void *, char *&);
+static off_t format_process_environ (void *, char *&);
 
 static const virt_tab_t process_tab[] =
 {
@@ -57,6 +58,7 @@ static const virt_tab_t process_tab[] =
   { _VN ("cmdline"),    FH_PROCESS,   virt_file,      format_process_cmdline },
   { _VN ("ctty"),       FH_PROCESS,   virt_file,      format_process_ctty },
   { _VN ("cwd"),        FH_PROCESS,   virt_symlink,   format_process_cwd },
+  { _VN ("environ"),    FH_PROCESS,   virt_file,      format_process_environ },
   { _VN ("exe"),        FH_PROCESS,   virt_symlink,   format_process_exename },
   { _VN ("exename"),    FH_PROCESS,   virt_file,      format_process_exename },
   { _VN ("fd"),         FH_PROCESSFD, virt_directory, format_process_fd },
@@ -570,6 +572,26 @@ format_process_winexename (void *data, char *&destbuf)
   return len;
 }
 
+static off_t
+format_process_environ (void *data, char *&destbuf)
+{
+  _pinfo *p = (_pinfo *) data;
+  size_t fs;
+
+  if (destbuf)
+    {
+      cfree (destbuf);
+      destbuf = NULL;
+    }
+  destbuf = p->environ (fs);
+  if (!destbuf || !*destbuf)
+    {
+      destbuf = cstrdup ("<defunct>");
+      fs = strlen (destbuf) + 1;
+    }
+  return fs;
+}
+
 struct heap_info
 {
   struct heap
-- 
2.8.3
