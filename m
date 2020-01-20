Return-Path: <cygwin-patches-return-9954-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 80990 invoked by alias); 20 Jan 2020 02:50:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 80979 invoked by uid 89); 20 Jan 2020 02:50:37 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=UD:jp, H*Ad:D*jp, pty, 1206
X-HELO: conuserg-06.nifty.com
Received: from conuserg-06.nifty.com (HELO conuserg-06.nifty.com) (210.131.2.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 20 Jan 2020 02:50:34 +0000
Received: from localhost.localdomain (ntsitm247158.sitm.nt.ngn.ppp.infoweb.ne.jp [124.27.253.158]) (authenticated)	by conuserg-06.nifty.com with ESMTP id 00K2oGbS021950;	Mon, 20 Jan 2020 11:50:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-06.nifty.com 00K2oGbS021950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1579488621;	bh=f4hY66uBrk4O73Hc59RHcvy0cAD+A17lSV9/H5jbp4U=;	h=From:To:Cc:Subject:Date:From;	b=WLhq87Yu8NV74J2sbXjwi+TRZW3fUT8Hag/2v0JVOCxyqgVXsTK366OEO6kM25mnM	 QTL08wNmyT6gHnciZTqdkbq3t8jrxddJNcr/9NrKRVKoz1b5ja6g+zmCOVdspsw7vR	 vismh/0z/QDK5YIY50BCYhNnj63GzuSLnnFuVJ82cjTVZ7XaQ+FSuvptjB07cRK0TK	 muIPBScvIDmENKguTZFf86vvjnvHzT/4Yok/quqY3uQN0Au6YJqdvapU3b8utuc6Vt	 50d+gYPbPL01lYifmI5TZ4mnFT0n/KWkECDCVL/l7HDSxS31KRTYYaXl0lzmTtF+m1	 33XRkklaZbeYA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Introduce disable_pcon in environment CYGWIN.
Date: Mon, 20 Jan 2020 02:50:00 -0000
Message-Id: <20200120025015.1520-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00060.txt

- For programs which does not work properly with pseudo console,
  disable_pcon in environment CYGWIN is introduced. If disable_pcon
  is set, pseudo console support is disabled.
---
 winsup/cygwin/environ.cc      | 1 +
 winsup/cygwin/fhandler_tty.cc | 2 ++
 winsup/cygwin/globals.cc      | 1 +
 3 files changed, 4 insertions(+)

diff --git a/winsup/cygwin/environ.cc b/winsup/cygwin/environ.cc
index 8c5ce64e1..7eb4780a8 100644
--- a/winsup/cygwin/environ.cc
+++ b/winsup/cygwin/environ.cc
@@ -120,6 +120,7 @@ static struct parse_thing
   {"reset_com", {&reset_com}, setbool, NULL, {{false}, {true}}},
   {"wincmdln", {&wincmdln}, setbool, NULL, {{false}, {true}}},
   {"winsymlinks", {func: set_winsymlinks}, isfunc, NULL, {{0}, {0}}},
+  {"disable_pcon", {&disable_pcon}, setbool, NULL, {{false}, {true}}},
   {NULL, {0}, setdword, 0, {{0}, {0}}}
 };
 
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index fff5bebe3..a5db0967b 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -3132,6 +3132,8 @@ is_running_as_service (void)
 bool
 fhandler_pty_master::setup_pseudoconsole ()
 {
+  if (disable_pcon)
+    return false;
   /* If the legacy console mode is enabled, pseudo console seems
      not to work as expected. To determine console mode, registry
      key ForceV2 in HKEY_CURRENT_USER\Console is checked. */
diff --git a/winsup/cygwin/globals.cc b/winsup/cygwin/globals.cc
index ebe8b569f..a9648fe6a 100644
--- a/winsup/cygwin/globals.cc
+++ b/winsup/cygwin/globals.cc
@@ -71,6 +71,7 @@ bool pipe_byte;
 bool reset_com;
 bool wincmdln;
 winsym_t allow_winsymlinks = WSYM_sysfile;
+bool disable_pcon;
 
 bool NO_COPY in_forkee;
 
-- 
2.21.0
