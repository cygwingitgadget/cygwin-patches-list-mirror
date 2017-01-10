Return-Path: <cygwin-patches-return-8678-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16746 invoked by alias); 10 Jan 2017 15:03:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 16669 invoked by uid 89); 10 Jan 2017 15:03:41 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.4 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_SPAM,SPF_PASS autolearn=no version=3.3.2 spammy=Hx-languages-length:1731, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mail-wm0-f67.google.com
Received: from mail-wm0-f67.google.com (HELO mail-wm0-f67.google.com) (74.125.82.67) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 10 Jan 2017 15:03:30 +0000
Received: by mail-wm0-f67.google.com with SMTP id l2so30441619wml.2        for <cygwin-patches@cygwin.com>; Tue, 10 Jan 2017 07:03:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to         :references;        bh=3fhSjOVZBQNA9GbVhXqq5EOqhvCHbPlGfqFhpifPvcw=;        b=H7mXT/lcCLUk8OMihJOUCSNbOQXn9L6ZHKJ6SmTtE89TSQDpX/OyEw2v+Htwqju2Am         TLzPE9RdekqxzXoVAW6Qgv2r2GnJrXphHbvyahZwI8EbZWPaK+4H/KD+oxTwFKc2Rs6c         S89TGmd48nyJZ5IKDECTWDsCAkuOMODY/meQItlNmQ1efCbI5fpm8g0JTJXn9m6sMJ6t         Qfg+N4HFIv4TY0zHyPkJFOayVgA8qG+FSlO5z7brTil8UTC8gx99i+yOHag2EtkI7zHp         2qkwuYIeBzcblMopC5BhfkaCgsarB67x4iim3hcajtIASudjhlmqp/GzTZWHfrgih40W         2mbg==
X-Gm-Message-State: AIkVDXJC6XcSvPV/HhOmRGIcnhNkyfqOzwzpRShLqaA7waAvpIdUfO1bGTIszKELy5Hg1A==
X-Received: by 10.28.216.65 with SMTP id p62mr222755wmg.92.1484060608599;        Tue, 10 Jan 2017 07:03:28 -0800 (PST)
Received: from localhost.localdomain (lri30-45.lri.fr. [129.175.30.45])        by smtp.gmail.com with ESMTPSA id jm6sm3701841wjb.27.2017.01.10.07.03.27        for <cygwin-patches@cygwin.com>        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);        Tue, 10 Jan 2017 07:03:28 -0800 (PST)
From: Erik Bray <erik.m.bray@gmail.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH 3/3] Add a /proc/<pid>/environ proc file handler, analogous to /proc/<pid>/cmdline.
Date: Tue, 10 Jan 2017 15:03:00 -0000
Message-Id: <20170110150310.79112-4-erik.m.bray@gmail.com>
In-Reply-To: <20170110150310.79112-2-erik.m.bray@gmail.com>
References: <20170110150310.79112-2-erik.m.bray@gmail.com>
X-IsSubscribed: yes
X-SW-Source: 2017-q1/txt/msg00019.txt.bz2

From: Erik M. Bray <erik.bray@lri.fr>

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
