Return-Path: <cygwin-patches-return-8521-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 130836 invoked by alias); 31 Mar 2016 18:04:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 130812 invoked by uid 89); 31 Mar 2016 18:04:34 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:2348, HTo:U*cygwin-patches
X-HELO: mail-qg0-f41.google.com
Received: from mail-qg0-f41.google.com (HELO mail-qg0-f41.google.com) (209.85.192.41) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Thu, 31 Mar 2016 18:04:25 +0000
Received: by mail-qg0-f41.google.com with SMTP id j35so72346714qge.0        for <cygwin-patches@cygwin.com>; Thu, 31 Mar 2016 11:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to         :references;        bh=sIrPuXC/ylkyX4GgFv9fRbt8/r+VdgQUTX+tDMiwKbk=;        b=QKwm3xCxrEo9cZgov/7ssdbUb507Lh4tLH7oRAIDx4BHj2EqzBuNDax676H21fJwPo         Qln8UnK/u4T1E4EUQguNCyZjbAXXUo8xQ/kAtMEQvX+Jyknp5nOeyFro45UcG8yhOx0v         O1De6i3QlgFvlXTfNZdpwhPnJbu8rTBLe0k5qkpVX+dKXQgOD7ze2hX8+4ljucHkCEoS         tKKM1yxTkG/d9F9T9/rew4WjzVbtG2LNe9laIdw9tn+rcPn/ajyMF9RWdkXi05JRGAs+         RP3wMHkbE/EADQy+Nw4B1fPWZDErD8qc+s7VMRMyfmvSHXQR9qJh9rM82UiGU0co4/T2         MJ7g==
X-Gm-Message-State: AD7BkJJX3dM8RaI9eiTzJ8K0c6TJOr1ahI31Rx1eaIHa5tMfOY0lnuXN2D1PIwApdfn3cA==
X-Received: by 10.140.20.104 with SMTP id 95mr18137503qgi.40.1459447463283;        Thu, 31 Mar 2016 11:04:23 -0700 (PDT)
Received: from bronx.local.pefoley.com (foleype-1-pt.tunnel.tserv13.ash1.ipv6.he.net. [2001:470:7:ee7::2])        by smtp.gmail.com with ESMTPSA id 94sm4421831qgj.10.2016.03.31.11.04.22        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);        Thu, 31 Mar 2016 11:04:22 -0700 (PDT)
From: Peter Foley <pefoley2@pefoley.com>
To: cygwin-patches@cygwin.com
Cc: Peter Foley <pefoley2@pefoley.com>
Subject: [PATCH 2/4] Don't use deprecated acconfig.h for DEBUGGING
Date: Thu, 31 Mar 2016 18:04:00 -0000
Message-Id: <1459447458-6547-2-git-send-email-pefoley2@pefoley.com>
In-Reply-To: <1459447458-6547-1-git-send-email-pefoley2@pefoley.com>
References: <1459447458-6547-1-git-send-email-pefoley2@pefoley.com>
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00227.txt.bz2

Use the 3-arg form of AC_DEFINE.

winsup/cygwin/ChangeLog:
acconfig.h: Remove DEBUGGING define.
configure.ac: Add description to DEBUGGING define.
config.h.in: Regenerate.
configure: Ditto.

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
 winsup/cygwin/acconfig.h   | 3 ---
 winsup/cygwin/config.h.in  | 6 +++---
 winsup/cygwin/configure    | 3 ++-
 winsup/cygwin/configure.ac | 2 +-
 4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/acconfig.h b/winsup/cygwin/acconfig.h
index 2f8d58c..ffe9f81 100644
--- a/winsup/cygwin/acconfig.h
+++ b/winsup/cygwin/acconfig.h
@@ -1,6 +1,3 @@
-/* Define if DEBUGGING support is requested.  */
-#undef DEBUGGING
-
 /* Define if MALLOC_DEBUGGING support is requested.  */
 #undef MALLOC_DEBUG
 
diff --git a/winsup/cygwin/config.h.in b/winsup/cygwin/config.h.in
index 39eb968..32f191a 100644
--- a/winsup/cygwin/config.h.in
+++ b/winsup/cygwin/config.h.in
@@ -1,13 +1,13 @@
 /* config.h.in.  Generated from configure.ac by autoheader.  */
-/* Define if DEBUGGING support is requested.  */
-#undef DEBUGGING
-
 /* Define if MALLOC_DEBUGGING support is requested.  */
 #undef MALLOC_DEBUG
 
 /* Define if using new vfork functionality. */
 #undef NEWVFORK
 
+/* Define if DEBUGGING support is requested. */
+#undef DEBUGGING
+
 /* Define to the address where bug reports for this package should be sent. */
 #undef PACKAGE_BUGREPORT
 
diff --git a/winsup/cygwin/configure b/winsup/cygwin/configure
index 8e69354..5f67d1f 100755
--- a/winsup/cygwin/configure
+++ b/winsup/cygwin/configure
@@ -4429,7 +4429,8 @@ fi
 # Check whether --enable-debugging was given.
 if test "${enable_debugging+set}" = set; then :
   enableval=$enable_debugging; case "${enableval}" in
-yes)	 $as_echo "#define DEBUGGING 1" >>confdefs.h
+yes)
+$as_echo "#define DEBUGGING 1" >>confdefs.h
  ;;
 no)	 ;;
 esac
diff --git a/winsup/cygwin/configure.ac b/winsup/cygwin/configure.ac
index efef76f..88e9694 100644
--- a/winsup/cygwin/configure.ac
+++ b/winsup/cygwin/configure.ac
@@ -66,7 +66,7 @@ AC_PROG_MAKE_SET
 AC_ARG_ENABLE(debugging,
 [ --enable-debugging		Build a cygwin DLL which has more consistency checking for debugging],
 [case "${enableval}" in
-yes)	 AC_DEFINE(DEBUGGING) ;;
+yes)	 AC_DEFINE([DEBUGGING],[1],[Define if DEBUGGING support is requested.]) ;;
 no)	 ;;
 esac
 ])
-- 
2.8.0
