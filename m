Return-Path: <cygwin-patches-return-8268-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 123474 invoked by alias); 27 Oct 2015 13:53:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 123454 invoked by uid 89); 27 Oct 2015 13:53:13 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.2 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,URI_NOVOWEL autolearn=no version=3.3.2
X-HELO: rgout0102.bt.lon5.cpcloud.co.uk
Received: from rgout0102.bt.lon5.cpcloud.co.uk (HELO rgout0102.bt.lon5.cpcloud.co.uk) (65.20.0.122) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 27 Oct 2015 13:53:08 +0000
X-OWM-Source-IP: 86.141.129.230 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090201.562F81C2.0017,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.10.19.141818:17:27.888,ip=86.141.129.230,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __ANY_URI, __URI_NO_WWW, __URI_NO_PATH, BODY_SIZE_3000_3999, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[230.129.141.86.fur], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, RDNS_SUSP, BODY_SIZE_7000_LESS, NO_URI_HTTPS
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (86.141.129.230) by rgout01.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 561CD2CD019B2F6B; Tue, 27 Oct 2015 13:53:05 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Remove spurious execute permissions from some Cygwin source and text files
Date: Tue, 27 Oct 2015 13:53:00 -0000
Message-Id: <1445953968-4932-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2015-q4/txt/msg00021.txt.bz2

2015-08-21  Jon Turney  <jon.turney@dronecode.org.uk>

	* cygwin-cxx.h: Remove execute permissions.
	* fenv.cc: Ditto.
	* how-startup-shutdown-works.txt: Ditto.
	* include/arpa/nameser.h: Ditto.
	* include/arpa/nameser_compat.h: Ditto.
	* include/fenv.h: Ditto.
	* include/resolv.h: Ditto.
	* libstdcxx_wrapper.cc: Ditto.

2015-10-27  Jon Turney  <jon.turney@dronecode.org.uk>

	* winsup.api/signal-into-win32-api.c: Remove execute permissions.

Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
---
 winsup/cygwin/ChangeLog                             | 11 +++++++++++
 winsup/cygwin/cygwin-cxx.h                          |  0
 winsup/cygwin/fenv.cc                               |  0
 winsup/cygwin/how-startup-shutdown-works.txt        |  0
 winsup/cygwin/include/arpa/nameser.h                |  0
 winsup/cygwin/include/arpa/nameser_compat.h         |  0
 winsup/cygwin/include/fenv.h                        |  0
 winsup/cygwin/include/resolv.h                      |  0
 winsup/cygwin/libstdcxx_wrapper.cc                  |  0
 winsup/testsuite/ChangeLog                          |  4 ++++
 winsup/testsuite/winsup.api/signal-into-win32-api.c |  0
 11 files changed, 15 insertions(+)
 mode change 100755 => 100644 winsup/cygwin/cygwin-cxx.h
 mode change 100755 => 100644 winsup/cygwin/fenv.cc
 mode change 100755 => 100644 winsup/cygwin/how-startup-shutdown-works.txt
 mode change 100755 => 100644 winsup/cygwin/include/arpa/nameser.h
 mode change 100755 => 100644 winsup/cygwin/include/arpa/nameser_compat.h
 mode change 100755 => 100644 winsup/cygwin/include/fenv.h
 mode change 100755 => 100644 winsup/cygwin/include/resolv.h
 mode change 100755 => 100644 winsup/cygwin/libstdcxx_wrapper.cc
 mode change 100755 => 100644 winsup/testsuite/winsup.api/signal-into-win32-api.c

diff --git a/winsup/cygwin/ChangeLog b/winsup/cygwin/ChangeLog
index 1f24c39..afbe7a2 100644
--- a/winsup/cygwin/ChangeLog
+++ b/winsup/cygwin/ChangeLog
@@ -1,3 +1,14 @@
+2015-08-21  Jon Turney  <jon.turney@dronecode.org.uk>
+
+	* cygwin-cxx.h: Remove execute permissions.
+	* fenv.cc: Ditto.
+	* how-startup-shutdown-works.txt: Ditto.
+	* include/arpa/nameser.h: Ditto.
+	* include/arpa/nameser_compat.h: Ditto.
+	* include/fenv.h: Ditto.
+	* include/resolv.h: Ditto.
+	* libstdcxx_wrapper.cc: Ditto.
+
 2015-10-23  Corinna Vinschen  <corinna@vinschen.de>
 
 	* cygtls.cc (_cygtls::remove): Call remove_pending_sigs.
diff --git a/winsup/cygwin/cygwin-cxx.h b/winsup/cygwin/cygwin-cxx.h
old mode 100755
new mode 100644
diff --git a/winsup/cygwin/fenv.cc b/winsup/cygwin/fenv.cc
old mode 100755
new mode 100644
diff --git a/winsup/cygwin/how-startup-shutdown-works.txt b/winsup/cygwin/how-startup-shutdown-works.txt
old mode 100755
new mode 100644
diff --git a/winsup/cygwin/include/arpa/nameser.h b/winsup/cygwin/include/arpa/nameser.h
old mode 100755
new mode 100644
diff --git a/winsup/cygwin/include/arpa/nameser_compat.h b/winsup/cygwin/include/arpa/nameser_compat.h
old mode 100755
new mode 100644
diff --git a/winsup/cygwin/include/fenv.h b/winsup/cygwin/include/fenv.h
old mode 100755
new mode 100644
diff --git a/winsup/cygwin/include/resolv.h b/winsup/cygwin/include/resolv.h
old mode 100755
new mode 100644
diff --git a/winsup/cygwin/libstdcxx_wrapper.cc b/winsup/cygwin/libstdcxx_wrapper.cc
old mode 100755
new mode 100644
diff --git a/winsup/testsuite/ChangeLog b/winsup/testsuite/ChangeLog
index e9cff49..2e6ed54 100644
--- a/winsup/testsuite/ChangeLog
+++ b/winsup/testsuite/ChangeLog
@@ -1,3 +1,7 @@
+2015-10-27  Jon Turney  <jon.turney@dronecode.org.uk>
+
+	* winsup.api/signal-into-win32-api.c: Remove execute permissions.
+
 2014-08-15  Corinna Vinschen  <corinna@vinschen.de>
 
 	* configure.ac: Convert to new AC_INIT style.
diff --git a/winsup/testsuite/winsup.api/signal-into-win32-api.c b/winsup/testsuite/winsup.api/signal-into-win32-api.c
old mode 100755
new mode 100644
-- 
2.5.3
