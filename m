Return-Path: <cygwin-patches-return-9072-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 120565 invoked by alias); 4 Jun 2018 19:36:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 117022 invoked by uid 89); 4 Jun 2018 19:36:18 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-26.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: limerock02.mail.cornell.edu
Received: from limerock02.mail.cornell.edu (HELO limerock02.mail.cornell.edu) (128.84.13.242) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 04 Jun 2018 19:36:17 +0000
X-CornellRouted: This message has been Routed already.
Received: from authusersmtp.mail.cornell.edu (granite4.serverfarm.cornell.edu [10.16.197.9])	by limerock02.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id w54JaFIv030233;	Mon, 4 Jun 2018 15:36:15 -0400
Received: from nothing.nyroc.rr.com (mta-68-175-129-7.twcny.rr.com [68.175.129.7] (may be forged))	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id w54Ja677027599	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);	Mon, 4 Jun 2018 15:36:15 -0400
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 3/5] Cygwin: Implement the GNU extension clearenv
Date: Mon, 04 Jun 2018 19:36:00 -0000
Message-Id: <20180604193607.17088-4-kbrown@cornell.edu>
In-Reply-To: <20180604193607.17088-1-kbrown@cornell.edu>
References: <20180604193607.17088-1-kbrown@cornell.edu>
X-PMX-Cornell-Gauge: Gauge=XXXXX
X-PMX-CORNELL-AUTH-RESULTS: dkim-out=none;
X-IsSubscribed: yes
X-SW-Source: 2018-q2/txt/msg00029.txt.bz2

---
 winsup/cygwin/common.din              |  1 +
 winsup/cygwin/environ.cc              | 20 ++++++++++++++++++++
 winsup/cygwin/include/cygwin/stdlib.h |  1 +
 3 files changed, 22 insertions(+)

diff --git a/winsup/cygwin/common.din b/winsup/cygwin/common.din
index 6e8bf9185..426cf172c 100644
--- a/winsup/cygwin/common.din
+++ b/winsup/cygwin/common.din
@@ -306,6 +306,7 @@ cimag NOSIGFE
 cimagf NOSIGFE
 cimagl NOSIGFE
 cleanup_glue NOSIGFE
+clearenv SIGFE
 clearerr SIGFE
 clearerr_unlocked SIGFE
 clock SIGFE
diff --git a/winsup/cygwin/environ.cc b/winsup/cygwin/environ.cc
index 8e6bbe561..3676bd9ea 100644
--- a/winsup/cygwin/environ.cc
+++ b/winsup/cygwin/environ.cc
@@ -720,6 +720,26 @@ unsetenv (const char *name)
   return -1;
 }
 
+/* Clear the environment.  */
+extern "C" int
+clearenv ()
+{
+  __try
+    {
+      if (cur_environ () == lastenviron && lastenviron != NULL)
+	{
+	  free (lastenviron);
+	  lastenviron = NULL;
+	}
+      __cygwin_environ = NULL;
+      update_envptrs ();
+      return 0;
+    }
+  __except (EFAULT) {}
+  __endtry
+  return -1;
+}
+
 /* Minimal list of Windows vars which must be converted to uppercase.
    Either for POSIX compatibility of for backward compatibility with
    existing applications. */
diff --git a/winsup/cygwin/include/cygwin/stdlib.h b/winsup/cygwin/include/cygwin/stdlib.h
index 845d2d81b..55d75e402 100644
--- a/winsup/cygwin/include/cygwin/stdlib.h
+++ b/winsup/cygwin/include/cygwin/stdlib.h
@@ -22,6 +22,7 @@ void	setprogname (const char *);
 
 #if __GNU_VISIBLE
 char *canonicalize_file_name (const char *);
+int clearenv ();
 #endif
 #if __BSD_VISIBLE || __POSIX_VISIBLE >= 200112
 int unsetenv (const char *);
-- 
2.17.0
