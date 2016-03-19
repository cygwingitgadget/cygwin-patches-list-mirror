Return-Path: <cygwin-patches-return-8418-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 63190 invoked by alias); 19 Mar 2016 17:46:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 63116 invoked by uid 89); 19 Mar 2016 17:46:16 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=premain, 1358, his, HTo:U*cygwin-patches
X-HELO: mail-qk0-f195.google.com
Received: from mail-qk0-f195.google.com (HELO mail-qk0-f195.google.com) (209.85.220.195) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Sat, 19 Mar 2016 17:46:14 +0000
Received: by mail-qk0-f195.google.com with SMTP id q184so4978714qkb.0        for <cygwin-patches@cygwin.com>; Sat, 19 Mar 2016 10:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:from:to:cc:subject:date:message-id;        bh=AJYFg+Z64Gg7yRDBckos9sP3ky4+dJYPV8I6q0gv5Ww=;        b=Tuj4LpaLAi5kxPm33ombfUPLTgD4AU/4jiamU8zN6+ALwhKKzcjA0oJA7toj5QlvUf         T3/Zj8OFJ6iOr7C/MBqjfkrzWtkclL5WH5f3+pASmPyH6oaDeX29fdrGEem+D9pjnyUo         zxk307gsVBpjFXrbl5HJuUyT62cpF3vJANcJDR+5mGU2qhJ3V0RufrqzrM3bnW2Je+ld         GoN+Ncrj1Ff42REbm6e1STd4jFPd+vTXw6kaMSxdxyrdAculjmKny9WDcoof2OVf8BVV         hGjw7eIH3HFfSjMhviSfpxd8o7IF4n4E1oaTqag+lqwD1LfAXQ+7vduOumK5sbRrBfUL         kGWg==
X-Gm-Message-State: AD7BkJJGNDW2+euSM7XwOlHhkX0IP38yQQ6/qsEdcvB8wh4M3J/iuiLHalAkaWUjqO/Pug==
X-Received: by 10.55.217.151 with SMTP id q23mr30297525qkl.88.1458409572604;        Sat, 19 Mar 2016 10:46:12 -0700 (PDT)
Received: from bronx.local.pefoley.com (foleype-1-pt.tunnel.tserv13.ash1.ipv6.he.net. [2001:470:7:ee7::2])        by smtp.gmail.com with ESMTPSA id 78sm8582720qgt.1.2016.03.19.10.46.11        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);        Sat, 19 Mar 2016 10:46:11 -0700 (PDT)
From: Peter Foley <pefoley2@pefoley.com>
To: cygwin-patches@cygwin.com
Cc: Peter Foley <pefoley2@pefoley.com>
Subject: [PATCH 01/11] Remove unused and unsafe call to __builtin_frame_address
Date: Sat, 19 Mar 2016 17:46:00 -0000
Message-Id: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com>
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00132.txt.bz2

initial_sp has been unused since commit fbf23e3 back in 2000.
Keep the value, so as to avoid changing the offset of magic_biscuit.

winsup/cygwin/lib/_cygwin_crt0_common.cc:140:52:
error: calling 'void* __builtin_frame_address(unsigned int)' with a
nonzero argument is unsafe [-Werror=frame-address]
   u->initial_sp = (char *) __builtin_frame_address (1);

winsup/cygwin/ChangeLog
lib/_cygwin_crt0_common.cc (_cygwin_crt0_common): Initialize initial_sp
with nullptr.

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
 winsup/cygwin/lib/_cygwin_crt0_common.cc | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/lib/_cygwin_crt0_common.cc b/winsup/cygwin/lib/_cygwin_crt0_common.cc
index 718ce94..96ebeee 100644
--- a/winsup/cygwin/lib/_cygwin_crt0_common.cc
+++ b/winsup/cygwin/lib/_cygwin_crt0_common.cc
@@ -135,9 +135,8 @@ _cygwin_crt0_common (MainFunc f, per_process *u)
   u->premain[3] = cygwin_premain3;
   u->fmode_ptr = &_fmode;
 
-  /* This is used to record what the initial sp was.  The value is needed
-     when copying the parent's stack to the child during a fork.  */
-  u->initial_sp = (char *) __builtin_frame_address (1);
+  /* Unused */
+  u->initial_sp = nullptr;
 
   /* Remember whatever the user linked his application with - or
      point to entries in the dll.  */
-- 
2.7.4
