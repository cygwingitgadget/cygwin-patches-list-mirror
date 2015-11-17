Return-Path: <cygwin-patches-return-8270-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 39814 invoked by alias); 17 Nov 2015 18:29:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 39800 invoked by uid 89); 17 Nov 2015 18:29:02 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.0 required=5.0 tests=AWL,BAYES_00,RP_MATCHES_RCVD,SPF_HELO_PASS autolearn=ham version=3.3.2
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Tue, 17 Nov 2015 18:29:01 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])	by mx1.redhat.com (Postfix) with ESMTPS id 7BC1B91C15	for <cygwin-patches@cygwin.com>; Tue, 17 Nov 2015 18:29:00 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-28.rdu2.redhat.com [10.10.116.28])	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id tAHISw44004524	(version=TLSv1/SSLv3 cipher=AES256-SHA256 bits=256 verify=NO)	for <cygwin-patches@cygwin.com>; Tue, 17 Nov 2015 13:28:59 -0500
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] cygwin: export rpmatch(3)
Date: Tue, 17 Nov 2015 18:29:00 -0000
Message-Id: <1447784925-9024-1-git-send-email-yselkowi@redhat.com>
X-SW-Source: 2015-q4/txt/msg00023.txt.bz2

winsup/cygwin/
* common.din (rpmatch): Export.
* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.

winsup/doc/
* new-features.xml (ov-new2.4): New section. Document rpmatch.
* posix.xml (std-bsd): Add rpmatch.

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
---
This depends on the newlib patch sent to their list.

 winsup/cygwin/ChangeLog                |  5 +++++
 winsup/cygwin/common.din               |  1 +
 winsup/cygwin/include/cygwin/version.h |  3 ++-
 winsup/doc/ChangeLog                   |  5 +++++
 winsup/doc/new-features.xml            | 12 ++++++++++++
 winsup/doc/posix.xml                   |  1 +
 6 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/ChangeLog b/winsup/cygwin/ChangeLog
index bdaab40..1bab25c 100644
--- a/winsup/cygwin/ChangeLog
+++ b/winsup/cygwin/ChangeLog
@@ -1,3 +1,8 @@
+2015-11-17  Yaakov Selkowitz  <yselkowi@redhat.com>
+
+	* common.din (rpmatch): Export.
+	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.
+
 2015-11-12  Corinna Vinschen  <corinna@vinschen.de>
 
 	* flock.cc (lockf_t::create_lock_obj): Correctly recreate lock object
diff --git a/winsup/cygwin/common.din b/winsup/cygwin/common.din
index 5d22e97..0b0e196 100644
--- a/winsup/cygwin/common.din
+++ b/winsup/cygwin/common.din
@@ -1017,6 +1017,7 @@ rindex NOSIGFE
 rmdir SIGFE
 round NOSIGFE
 roundf NOSIGFE
+rpmatch SIGFE
 rresvport = cygwin_rresvport SIGFE
 rresvport_af = cygwin_rresvport_af SIGFE
 ruserok SIGFE
diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/include/cygwin/version.h
index af5afd5..2edd7d7 100644
--- a/winsup/cygwin/include/cygwin/version.h
+++ b/winsup/cygwin/include/cygwin/version.h
@@ -473,13 +473,14 @@ details. */
       289: Export sigsetjmp, siglongjmp.
       290: Add sysconf cache handling.
       291: Export aligned_alloc, at_quick_exit, quick_exit.
+      292: Export rpmatch.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull,
 	sigaltstack, sethostname. */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 291
+#define CYGWIN_VERSION_API_MINOR 292
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible
diff --git a/winsup/doc/ChangeLog b/winsup/doc/ChangeLog
index 14dd387..df8c641 100644
--- a/winsup/doc/ChangeLog
+++ b/winsup/doc/ChangeLog
@@ -1,3 +1,8 @@
+2015-11-17  Yaakov Selkowitz  <yselkowi@redhat.com>
+
+	* new-features.xml (ov-new2.4): New section. Document rpmatch.
+	* posix.xml (std-bsd): Add rpmatch.
+
 2015-11-02  Corinna Vinschen  <corinna@vinschen.de>
 
 	* new-features.xml (ov-new2.3): Document Parallels Desktop FS support.
diff --git a/winsup/doc/new-features.xml b/winsup/doc/new-features.xml
index 88eb25c..e054a8e 100644
--- a/winsup/doc/new-features.xml
+++ b/winsup/doc/new-features.xml
@@ -4,6 +4,18 @@
 
 <sect1 id="ov-new"><title>What's new and what changed in Cygwin</title>
 
+<sect2 id="ov-new2.4"><title>What's new and what changed in 2.4</title>
+
+<itemizedlist mark="bullet">
+
+<listitem><para>
+New API: rpmatch.
+</para></listitem>
+
+</itemizedlist>
+
+</sect2>
+
 <sect2 id="ov-new2.3"><title>What's new and what changed in 2.3</title>
 
 <itemizedlist mark="bullet">
diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index dc6c148..7b6efba 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -1086,6 +1086,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     res_send
     revoke
     rexec
+    rpmatch
     rresvport
     rresvport_af
     ruserok
-- 
2.5.3
