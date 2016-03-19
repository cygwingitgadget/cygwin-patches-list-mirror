Return-Path: <cygwin-patches-return-8426-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 64295 invoked by alias); 19 Mar 2016 17:46:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 63736 invoked by uid 89); 19 Mar 2016 17:46:21 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=4627, HTo:U*cygwin-patches
X-HELO: mail-qk0-f193.google.com
Received: from mail-qk0-f193.google.com (HELO mail-qk0-f193.google.com) (209.85.220.193) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Sat, 19 Mar 2016 17:46:18 +0000
Received: by mail-qk0-f193.google.com with SMTP id e124so5022202qkc.3        for <cygwin-patches@cygwin.com>; Sat, 19 Mar 2016 10:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to         :references;        bh=nn/zjYElw/uzMLrSFGvRi8U4iQ51Ef4feEeD801zNLs=;        b=KtDgJIAOA7Sru+TuAUzP1DYDtOPWnl8uMLvWMSTWz0us7XlF7wrVwVfannmErPGxrT         Yq83ctKLpDLAzmlKgTupOKKn85IVOKPDXvhe6xxTvrEJfRPUsA4cEm50ad4kDBJtDksI         IHZtkiaKCRSJUJeUt13dqfwTTuPrpRcdY1xYBoT/cJsHFK3jdAwnC2K6eC7m6brvfjDN         xxwxc/jdB7D+Gw66ueNNXCVAMKxTrKHznxyWVNwFTevWBafI9GoGMSu+SirxNTwe8VdK         5ekRDwIpPjnPVx20VoR+aAz+voDFwmd+fa9qmB0ufBJ87yeqax452DseDcI68qK3wFVP         M9tQ==
X-Gm-Message-State: AD7BkJKOPU1uB6AXmSFdbuZO60LyXru/BSeyVy1wThyRHpN+wJle1kFV5GIYzjrLP3H+pA==
X-Received: by 10.55.78.201 with SMTP id c192mr31291124qkb.9.1458409576460;        Sat, 19 Mar 2016 10:46:16 -0700 (PDT)
Received: from bronx.local.pefoley.com (foleype-1-pt.tunnel.tserv13.ash1.ipv6.he.net. [2001:470:7:ee7::2])        by smtp.gmail.com with ESMTPSA id 78sm8582720qgt.1.2016.03.19.10.46.15        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);        Sat, 19 Mar 2016 10:46:16 -0700 (PDT)
From: Peter Foley <pefoley2@pefoley.com>
To: cygwin-patches@cygwin.com
Cc: Peter Foley <pefoley2@pefoley.com>
Subject: [PATCH 07/11] The address of an class always evaluates to true
Date: Sat, 19 Mar 2016 17:46:00 -0000
Message-Id: <1458409557-13156-7-git-send-email-pefoley2@pefoley.com>
In-Reply-To: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com>
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com>
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00128.txt.bz2

winsup/cygwin/pinfo.cc:465:14: error: the compiler can assume that the
address of 'tc' will always evaluate to 'true' [-Werror=address]

winsup/cygwin/ChangeLog
* pinfo.cc (_pinfo::set_ctty): remove always true check.

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
 winsup/cygwin/pinfo.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/pinfo.cc b/winsup/cygwin/pinfo.cc
index 409a0b7..17bf063 100644
--- a/winsup/cygwin/pinfo.cc
+++ b/winsup/cygwin/pinfo.cc
@@ -462,7 +462,7 @@ _pinfo::set_ctty (fhandler_termios *fh, int flags)
 {
   tty_min& tc = *fh->tc ();
   debug_printf ("old %s, ctty device number %y, tc.ntty device number %y flags & O_NOCTTY %y", __ctty (), ctty, tc.ntty, flags & O_NOCTTY);
-  if (fh && &tc && (ctty <= 0 || ctty == tc.ntty) && !(flags & O_NOCTTY))
+  if (fh && (ctty <= 0 || ctty == tc.ntty) && !(flags & O_NOCTTY))
     {
       ctty = tc.ntty;
       if (cygheap->ctty != fh->archetype)
-- 
2.7.4
