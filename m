Return-Path: <cygwin-patches-return-8102-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 48374 invoked by alias); 1 Apr 2015 13:20:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 48313 invoked by uid 89); 1 Apr 2015 13:20:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2
X-HELO: rgout01.bt.lon5.cpcloud.co.uk
Received: from rgout01.bt.lon5.cpcloud.co.uk (HELO rgout01.bt.lon5.cpcloud.co.uk) (65.20.0.178) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 01 Apr 2015 13:20:05 +0000
X-OWM-Source-IP: 31.51.205.126(GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090202.551BF084.008C,ss=1,re=0.001,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.3.24.102118:17:27.888,ip=31.51.205.126,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __IN_REP_TO, __REFERENCES, __ANY_URI, __URI_NO_WWW, __URI_NO_PATH, BODY_SIZE_3000_3999, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[126.205.51.31.fur], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, RDNS_SUSP, BODY_SIZE_7000_LESS, REFERENCES
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (31.51.205.126) by rgout01.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 5508763C01DDA0BF; Wed, 1 Apr 2015 14:20:04 +0100
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: [PATCH 3/3] Add cygwin_internal() operation to retrieve the EXCEPTION_RECORD from a siginfo_t *
Date: Wed, 01 Apr 2015 13:20:00 -0000
Message-Id: <1427894373-2576-4-git-send-email-jon.turney@dronecode.org.uk>
In-Reply-To: <1427894373-2576-1-git-send-email-jon.turney@dronecode.org.uk>
References: <1427894373-2576-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2015-q2/txt/msg00002.txt.bz2

	* external.cc (cygwin_internal): Add operation to retrieve a copy
	of the EXCEPTION_RECORD from a siginfo_t *.
	* include/sys/cygwin.h (cygwin_getinfo_types): Ditto.
	* exception.h (cygwin_exception): Add exception_record accessor.

Signed-off-by: Jon TURNEY <jon.turney@dronecode.org.uk>
---
 winsup/cygwin/ChangeLog            |  7 +++++++
 winsup/cygwin/exception.h          |  1 +
 winsup/cygwin/external.cc          | 14 ++++++++++++++
 winsup/cygwin/include/sys/cygwin.h |  5 ++++-
 4 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/ChangeLog b/winsup/cygwin/ChangeLog
index cff94f7..50f58e5 100644
--- a/winsup/cygwin/ChangeLog
+++ b/winsup/cygwin/ChangeLog
@@ -1,5 +1,12 @@
 2015-04-01  Jon TURNEY  <jon.turney@dronecode.org.uk>
 
+	* external.cc (cygwin_internal): Add operation to retrieve a copy
+	of the EXCEPTION_RECORD from a siginfo_t *.
+	* include/sys/cygwin.h (cygwin_getinfo_types): Ditto.
+	* exception.h (cygwin_exception): Add exception_record accessor.
+
+2015-04-01  Jon TURNEY  <jon.turney@dronecode.org.uk>
+
 	* include/sys/ucontext.h : New header.
 	* include/ucontext.h : Ditto.
 	* exceptions.cc (call_signal_handler): Provide ucontext_t
diff --git a/winsup/cygwin/exception.h b/winsup/cygwin/exception.h
index 3686bb0..0478daf 100644
--- a/winsup/cygwin/exception.h
+++ b/winsup/cygwin/exception.h
@@ -175,4 +175,5 @@ public:
     framep (in_framep), ctx (in_ctx), e (in_e), h (NULL) {}
   void dumpstack ();
   PCONTEXT context () const {return ctx;}
+  EXCEPTION_RECORD *exception_record () const {return e;}
 };
diff --git a/winsup/cygwin/external.cc b/winsup/cygwin/external.cc
index 5fac4bb..e379df1 100644
--- a/winsup/cygwin/external.cc
+++ b/winsup/cygwin/external.cc
@@ -27,6 +27,7 @@ details. */
 #include "environ.h"
 #include "cygserver_setpwd.h"
 #include "pwdgrp.h"
+#include "exception.h"
 #include <unistd.h>
 #include <stdlib.h>
 #include <wchar.h>
@@ -688,6 +689,19 @@ cygwin_internal (cygwin_getinfo_types t, ...)
 	res = 0;
 	break;
 
+      case CW_EXCEPTION_RECORD_FROM_SIGINFO_T:
+	{
+	  siginfo_t *si = va_arg(arg, siginfo_t *);
+	  EXCEPTION_RECORD *er = va_arg(arg, EXCEPTION_RECORD *);
+	  if (si && si->si_cyg && er)
+	    {
+	      memcpy(er, ((cygwin_exception *)si->si_cyg)->exception_record(),
+		     sizeof(EXCEPTION_RECORD));
+	      res = 0;
+	    }
+	}
+	break;
+
       default:
 	set_errno (ENOSYS);
     }
diff --git a/winsup/cygwin/include/sys/cygwin.h b/winsup/cygwin/include/sys/cygwin.h
index edfcc56..2ec6086 100644
--- a/winsup/cygwin/include/sys/cygwin.h
+++ b/winsup/cygwin/include/sys/cygwin.h
@@ -1,3 +1,4 @@
+
 /* sys/cygwin.h
 
    Copyright 1997, 1998, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008,
@@ -153,7 +154,8 @@ typedef enum
     CW_CYGNAME_FROM_WINNAME,
     CW_FIXED_ATEXIT,
     CW_GETNSS_PWD_SRC,
-    CW_GETNSS_GRP_SRC
+    CW_GETNSS_GRP_SRC,
+    CW_EXCEPTION_RECORD_FROM_SIGINFO_T,
   } cygwin_getinfo_types;
 
 #define CW_LOCK_PINFO CW_LOCK_PINFO
@@ -214,6 +216,7 @@ typedef enum
 #define CW_FIXED_ATEXIT CW_FIXED_ATEXIT
 #define CW_GETNSS_PWD_SRC CW_GETNSS_PWD_SRC
 #define CW_GETNSS_GRP_SRC CW_GETNSS_GRP_SRC
+#define CW_EXCEPTION_RECORD_FROM_SIGINFO_T CW_EXCEPTION_RECORD_FROM_SIGINFO_T
 
 /* Token type for CW_SET_EXTERNAL_TOKEN */
 enum
-- 
2.1.4
