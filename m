Return-Path: <cygwin-patches-return-8863-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15039 invoked by alias); 17 Sep 2017 02:05:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 10939 invoked by uid 89); 17 Sep 2017 02:04:38 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-25.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RP_MATCHES_RCVD,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: limerock04.mail.cornell.edu
Received: from limerock04.mail.cornell.edu (HELO limerock04.mail.cornell.edu) (128.84.13.244) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 17 Sep 2017 02:04:37 +0000
X-CornellRouted: This message has been Routed already.
Received: from authusersmtp.mail.cornell.edu (granite4.serverfarm.cornell.edu [10.16.197.9])	by limerock04.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id v8H24ZhT018436;	Sat, 16 Sep 2017 22:04:35 -0400
Received: from nothing.nyroc.rr.com (mta-68-175-129-7.twcny.rr.com [68.175.129.7] (may be forged))	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id v8H24LfL025218	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);	Sat, 16 Sep 2017 22:04:34 -0400
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 08/12] cygwin: Remove comparison of 'this' to 'NULL' in _pinfo::fd
Date: Sun, 17 Sep 2017 02:05:00 -0000
Message-Id: <20170917020420.10488-8-kbrown@cornell.edu>
In-Reply-To: <20170917020420.10488-1-kbrown@cornell.edu>
References: <20170917020420.10488-1-kbrown@cornell.edu>
X-PMX-Cornell-Gauge: Gauge=XXXXX
X-PMX-CORNELL-AUTH-RESULTS: dkim-out=none;
X-IsSubscribed: yes
X-SW-Source: 2017-q3/txt/msg00066.txt.bz2

Fix all callers.
---
 winsup/cygwin/fhandler_process.cc | 2 +-
 winsup/cygwin/pinfo.cc            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_process.cc b/winsup/cygwin/fhandler_process.cc
index 7f122fbe4..360d8ea81 100644
--- a/winsup/cygwin/fhandler_process.cc
+++ b/winsup/cygwin/fhandler_process.cc
@@ -391,7 +391,7 @@ format_process_fd (void *data, char *&destbuf)
 	  set_errno (ENOENT);
 	  return 0;
 	}
-      destbuf = p->fd (fd, fs);
+      destbuf = p ? p->fd (fd, fs) : NULL;
       if (!destbuf || !*destbuf)
 	{
 	  set_errno (ENOENT);
diff --git a/winsup/cygwin/pinfo.cc b/winsup/cygwin/pinfo.cc
index 72aa658eb..044c4fc3c 100644
--- a/winsup/cygwin/pinfo.cc
+++ b/winsup/cygwin/pinfo.cc
@@ -832,7 +832,7 @@ char *
 _pinfo::fd (int fd, size_t &n)
 {
   char *s;
-  if (!this || !pid)
+  if (!pid)
     return NULL;
   if (pid != myself->pid)
     {
-- 
2.14.1
