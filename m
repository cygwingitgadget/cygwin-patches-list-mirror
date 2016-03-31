Return-Path: <cygwin-patches-return-8522-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 130845 invoked by alias); 31 Mar 2016 18:04:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 130814 invoked by uid 89); 31 Mar 2016 18:04:34 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=UD:alloca.h, alloca.h, allocah, grows
X-HELO: mail-qg0-f43.google.com
Received: from mail-qg0-f43.google.com (HELO mail-qg0-f43.google.com) (209.85.192.43) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Thu, 31 Mar 2016 18:04:24 +0000
Received: by mail-qg0-f43.google.com with SMTP id w104so66712494qge.3        for <cygwin-patches@cygwin.com>; Thu, 31 Mar 2016 11:04:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:from:to:cc:subject:date:message-id;        bh=jtbv1iRMVCM+5fka6kX/xMtEQXEXXtqX1ZWPtaulABo=;        b=K35BbuQkelFS82dtnjtZAszaClw1eyZ/ixssg1I0DtblxOXi5ez2kEKyinX6zgbJea         YYpZ187Q0UWa/6ioNuHD2HX+G6CGgFOxi7USKiNvAUZFtZbTEuWu04MVkqfj8OcesABo         fuoHo/QHPUzsnaBO75c1ZgV1N2H9pivHjAQzbu/sv0Ro1lzTJVQXcX08Zi6iuh66k7kq         yX3Z9Pi9M4W6zfpaDLTJZ57HFC6bmRJr/FoL7AZWYJwscXqGFudQgbLNq1Thuqh9SkkR         ytyOQWQevaxjZJp8LCy/7xXHt9Ub7HKmy0hJESI5NedTw4J5V92dyo2d/Jt0a6KpY77G         5ELg==
X-Gm-Message-State: AD7BkJK1giZpAm4M50gvQmDfdbJxx26MIV68Ys8+L7xeOnhlAWBv7Vy7W5+TLuoWVW6bWQ==
X-Received: by 10.140.92.247 with SMTP id b110mr68273qge.88.1459447462431;        Thu, 31 Mar 2016 11:04:22 -0700 (PDT)
Received: from bronx.local.pefoley.com (foleype-1-pt.tunnel.tserv13.ash1.ipv6.he.net. [2001:470:7:ee7::2])        by smtp.gmail.com with ESMTPSA id 94sm4421831qgj.10.2016.03.31.11.04.21        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);        Thu, 31 Mar 2016 11:04:21 -0700 (PDT)
From: Peter Foley <pefoley2@pefoley.com>
To: cygwin-patches@cygwin.com
Cc: Peter Foley <pefoley2@pefoley.com>
Subject: [PATCH 1/4] Remove leftover cruft from config.h.in
Date: Thu, 31 Mar 2016 18:04:00 -0000
Message-Id: <1459447458-6547-1-git-send-email-pefoley2@pefoley.com>
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00228.txt.bz2

HAVE_BUILTIN_MEMTEST and AC_ALLOCA were removed in 4bd8eb7d1b.
Cleanup leftover references.

winsup/cygwin/ChangeLog
acconfig.h: remove HAVE_BUILTIN_MEMTEST
config.h.in: regenerate

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
 winsup/cygwin/acconfig.h  |  3 ---
 winsup/cygwin/config.h.in | 31 ++++---------------------------
 2 files changed, 4 insertions(+), 30 deletions(-)

diff --git a/winsup/cygwin/acconfig.h b/winsup/cygwin/acconfig.h
index 0c1dc66..2f8d58c 100644
--- a/winsup/cygwin/acconfig.h
+++ b/winsup/cygwin/acconfig.h
@@ -1,9 +1,6 @@
 /* Define if DEBUGGING support is requested.  */
 #undef DEBUGGING
 
-/* Define if GCC supports builtin memset.  */
-#undef HAVE_BUILTIN_MEMSET
-
 /* Define if MALLOC_DEBUGGING support is requested.  */
 #undef MALLOC_DEBUG
 
diff --git a/winsup/cygwin/config.h.in b/winsup/cygwin/config.h.in
index 32cba72..39eb968 100644
--- a/winsup/cygwin/config.h.in
+++ b/winsup/cygwin/config.h.in
@@ -1,31 +1,13 @@
-/* config.h.in.  Generated from configure.in by autoheader.  */
+/* config.h.in.  Generated from configure.ac by autoheader.  */
 /* Define if DEBUGGING support is requested.  */
 #undef DEBUGGING
 
-/* Define if GCC supports builtin memset.  */
-#undef HAVE_BUILTIN_MEMSET
-
 /* Define if MALLOC_DEBUGGING support is requested.  */
 #undef MALLOC_DEBUG
 
 /* Define if using new vfork functionality. */
 #undef NEWVFORK
 
-/* Define to one of `_getb67', `GETB67', `getb67' for Cray-2 and Cray-YMP
-   systems. This function is required for `alloca.c' support on those systems.
-   */
-#undef CRAY_STACKSEG_END
-
-/* Define to 1 if using `alloca.c'. */
-#undef C_ALLOCA
-
-/* Define to 1 if you have `alloca', as a function or macro. */
-#undef HAVE_ALLOCA
-
-/* Define to 1 if you have <alloca.h> and it should be used (not on Ultrix).
-   */
-#undef HAVE_ALLOCA_H
-
 /* Define to the address where bug reports for this package should be sent. */
 #undef PACKAGE_BUGREPORT
 
@@ -38,13 +20,8 @@
 /* Define to the one symbol short name of this package. */
 #undef PACKAGE_TARNAME
 
+/* Define to the home page for this package. */
+#undef PACKAGE_URL
+
 /* Define to the version of this package. */
 #undef PACKAGE_VERSION
-
-/* If using the C implementation of alloca, define if you know the
-   direction of stack growth for your system; otherwise it will be
-   automatically deduced at run-time.
-	STACK_DIRECTION > 0 => grows toward higher addresses
-	STACK_DIRECTION < 0 => grows toward lower addresses
-	STACK_DIRECTION = 0 => direction of growth unknown */
-#undef STACK_DIRECTION
-- 
2.8.0
