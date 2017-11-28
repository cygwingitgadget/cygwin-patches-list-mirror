Return-Path: <cygwin-patches-return-8932-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7567 invoked by alias); 28 Nov 2017 07:54:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 7554 invoked by uid 89); 28 Nov 2017 07:54:25 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-23.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY,KB_WAM_FROM_NAME_SINGLEWORD autolearn=ham version=3.3.2 spammy=H*F:U*mark, HTo:U*cygwin-patches
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 28 Nov 2017 07:54:21 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id vAS7sKg1077194;	Mon, 27 Nov 2017 23:54:20 -0800 (PST)	(envelope-from mark@maxrnd.com)
Received: from 76-217-5-154.lightspeed.irvnca.sbcglobal.net(76.217.5.154), claiming to be "localhost.localdomain" via SMTP by m0.truegem.net, id smtpdDH6q9Z; Mon Nov 27 23:54:10 2017
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH] Initialize IO_STATUS_BLOCK for pread, pwrite
Date: Tue, 28 Nov 2017 07:54:00 -0000
Message-Id: <20171128075357.224-1-mark@maxrnd.com>
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00062.txt.bz2

---
 winsup/cygwin/fhandler_disk_file.cc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_disk_file.cc
index 5dfcae4d9..2ead9948c 100644
--- a/winsup/cygwin/fhandler_disk_file.cc
+++ b/winsup/cygwin/fhandler_disk_file.cc
@@ -1548,7 +1548,7 @@ fhandler_disk_file::pread (void *buf, size_t count, off_t offset)
     {
       extern int __stdcall is_at_eof (HANDLE h);
       NTSTATUS status;
-      IO_STATUS_BLOCK io;
+      IO_STATUS_BLOCK io = {{0}, 0};
       LARGE_INTEGER off = { QuadPart:offset };
 
       if (!prw_handle && prw_open (false))
@@ -1630,7 +1630,7 @@ fhandler_disk_file::pwrite (void *buf, size_t count, off_t offset)
   if (wbinary () && !mandatory_locking ())
     {
       NTSTATUS status;
-      IO_STATUS_BLOCK io;
+      IO_STATUS_BLOCK io = {{0}, 0};
       LARGE_INTEGER off = { QuadPart:offset };
 
       if (!prw_handle && prw_open (true))
-- 
2.15.0
