Return-Path: <cygwin-patches-return-8493-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 68084 invoked by alias); 23 Mar 2016 13:34:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 68072 invoked by uid 89); 23 Mar 2016 13:34:43 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=Couldnt, Couldn't, env, HTo:U*cygwin-patches
X-HELO: mail-qg0-f67.google.com
Received: from mail-qg0-f67.google.com (HELO mail-qg0-f67.google.com) (209.85.192.67) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Wed, 23 Mar 2016 13:34:24 +0000
Received: by mail-qg0-f67.google.com with SMTP id y89so1273794qge.0        for <cygwin-patches@cygwin.com>; Wed, 23 Mar 2016 06:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to         :references;        bh=Vys2mLQpeosXX5q3lmTdaBxTo7bekqc3qFCxRke9mRQ=;        b=FTaBk+jzQe9x1D0+lyrBO5iWWtEmxM80y5q2N9Xnt6AHQYcG6IJxiFeDV56EcphPEi         4KATJJ8nbVRYQzMQrQ8HYq5imDOcun1UmrmnHgkTRC0mWaAMRfk8a4cV63kkpnXkzu7M         2GZXk1XtT4qJgZ4/I1zLfR/I2382H+deZV0s6kFtBjg+1MNSP6eToH11Y13+ZjSHOkgD         5mXq0VNWCXPk3ZvW/HqVO42RWLalug3QLa42cDv2zC7iC6kaOTi0hN0iQeRmOzKTms/d         CIVFt57FImC+pBPZwtlnM5LdtouqJY3L2pHeYTkuaEMoKoWQCMcDL0iwzgr0xOvi6+8/         6G4Q==
X-Gm-Message-State: AD7BkJLfgOKaoQk50yNSMgMnESuqM1Jw0zXF4LgbQBFQ+QUzwzXMEQ4FTZ15UxPmyKSeTQ==
X-Received: by 10.140.160.214 with SMTP id g205mr3730429qhg.88.1458740062383;        Wed, 23 Mar 2016 06:34:22 -0700 (PDT)
Received: from bronx.local.pefoley.com (foleype-1-pt.tunnel.tserv13.ash1.ipv6.he.net. [2001:470:7:ee7::2])        by smtp.gmail.com with ESMTPSA id g76sm1087796qge.5.2016.03.23.06.34.21        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);        Wed, 23 Mar 2016 06:34:21 -0700 (PDT)
From: Peter Foley <pefoley2@pefoley.com>
To: cygwin-patches@cygwin.com
Cc: Peter Foley <pefoley2@pefoley.com>
Subject: [PATCH 3/3] Use just-built gcc for windres
Date: Wed, 23 Mar 2016 13:34:00 -0000
Message-Id: <1458740052-19618-3-git-send-email-pefoley2@pefoley.com>
In-Reply-To: <1458740052-19618-1-git-send-email-pefoley2@pefoley.com>
References: <1458740052-19618-1-git-send-email-pefoley2@pefoley.com>
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00199.txt.bz2

When building cygwin in a combined tree with binutils,
the just-built windres cannot find the just-buit gcc automatically.
Parse the CC env variable to use the correct compiler, rather then
falling back to the build-system's gcc which does not define the proper
preprocessor macros.

winsup/cygwin/ChangeLog
mkvers.sh: Manually specify preprocessor based on $CC

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
 winsup/cygwin/mkvers.sh | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/mkvers.sh b/winsup/cygwin/mkvers.sh
index db39087..9136948 100755
--- a/winsup/cygwin/mkvers.sh
+++ b/winsup/cygwin/mkvers.sh
@@ -37,6 +37,25 @@ done
     echo "**** Couldn't open file '$incfile'.  Aborting."
 }
 
+function parse_preproc_flags() {
+  # Since we're manually specifying the preprocessor, pass the default flags normally defined.
+  ccflags="--preprocessor=$1 --preprocessor-arg=-E --preprocessor-arg=-xc-header --define=RC_INVOKED "
+  shift
+  while [ -n "$*" ]; do
+      case "$1" in
+          # We need to be able to find the just-built cc1 binary.
+          -B*)
+            ccflags="$ccflags --preprocessor-arg=$1"
+            ;;
+      esac
+      shift
+  done
+}
+
+parse_preproc_flags $CC
+
+
+
 #
 # Load the current date so we can work on individual fields
 #
@@ -166,4 +185,4 @@ fi
 
 echo "Version $cygwin_ver"
 set -$- $builddate
-$windres $iflags --define CYGWIN_BUILD_DATE="$1" --define CYGWIN_BUILD_TIME="$2" --define CYGWIN_BUILD_YEAR=$y --define CYGWIN_VERSION='"'"$cygwin_ver"'"' $rcfile winver.o
+$windres $iflags $ccflags --define CYGWIN_BUILD_DATE="$1" --define CYGWIN_BUILD_TIME="$2" --define CYGWIN_BUILD_YEAR=$y --define CYGWIN_VERSION='"'"$cygwin_ver"'"' $rcfile winver.o
-- 
2.7.4
