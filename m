Return-Path: <cygwin-patches-return-8859-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13669 invoked by alias); 17 Sep 2017 02:04:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 10576 invoked by uid 89); 17 Sep 2017 02:04:34 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-25.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RP_MATCHES_RCVD,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=_pinfo, UD:pinfo.cc, pinfo.cc, pinfocc
X-HELO: limerock03.mail.cornell.edu
Received: from limerock03.mail.cornell.edu (HELO limerock03.mail.cornell.edu) (128.84.13.243) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 17 Sep 2017 02:04:33 +0000
X-CornellRouted: This message has been Routed already.
Received: from authusersmtp.mail.cornell.edu (granite4.serverfarm.cornell.edu [10.16.197.9])	by limerock03.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id v8H24VmW002436;	Sat, 16 Sep 2017 22:04:31 -0400
Received: from nothing.nyroc.rr.com (mta-68-175-129-7.twcny.rr.com [68.175.129.7] (may be forged))	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id v8H24LfG025218	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);	Sat, 16 Sep 2017 22:04:31 -0400
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 03/12] cygwin: Remove comparison of 'this' to 'NULL' in _pinfo::root
Date: Sun, 17 Sep 2017 02:04:00 -0000
Message-Id: <20170917020420.10488-3-kbrown@cornell.edu>
In-Reply-To: <20170917020420.10488-1-kbrown@cornell.edu>
References: <20170917020420.10488-1-kbrown@cornell.edu>
X-PMX-Cornell-Gauge: Gauge=XXXXX
X-PMX-CORNELL-AUTH-RESULTS: dkim-out=none;
X-IsSubscribed: yes
X-SW-Source: 2017-q3/txt/msg00058.txt.bz2

Fix all callers.
---
 winsup/cygwin/fhandler_process.cc | 2 +-
 winsup/cygwin/pinfo.cc            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_process.cc b/winsup/cygwin/fhandler_process.cc
index 97436dd1b..08cc7ea92 100644
--- a/winsup/cygwin/fhandler_process.cc
+++ b/winsup/cygwin/fhandler_process.cc
@@ -478,7 +478,7 @@ format_process_root (void *data, char *&destbuf)
       cfree (destbuf);
       destbuf = NULL;
     }
-  destbuf = p->root (fs);
+  destbuf = p ? p->root (fs) : NULL;
   if (!destbuf || !*destbuf)
     {
       destbuf = cstrdup ("<defunct>");
diff --git a/winsup/cygwin/pinfo.cc b/winsup/cygwin/pinfo.cc
index bba9ee494..9fe1b3a88 100644
--- a/winsup/cygwin/pinfo.cc
+++ b/winsup/cygwin/pinfo.cc
@@ -884,7 +884,7 @@ char *
 _pinfo::root (size_t& n)
 {
   char *s;
-  if (!this || !pid)
+  if (!pid)
     return NULL;
   if (pid != myself->pid && !ISSTATE (this, PID_NOTCYGWIN))
     {
-- 
2.14.1
