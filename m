Return-Path: <cygwin-patches-return-10048-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 98445 invoked by alias); 9 Feb 2020 14:46:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 98340 invoked by uid 89); 9 Feb 2020 14:46:30 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-17.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*Ad:D*jp, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-04.nifty.com
Received: from conuserg-04.nifty.com (HELO conuserg-04.nifty.com) (210.131.2.71) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 09 Feb 2020 14:46:28 +0000
Received: from localhost.localdomain (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conuserg-04.nifty.com with ESMTP id 019Ek4RX005877;	Sun, 9 Feb 2020 23:46:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-04.nifty.com 019Ek4RX005877
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1581259572;	bh=15RjbEKjKvpY3EUS6Lwx5KYHTC8iy5DafoeyXFtcNJ4=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=eSnC1QRDw+32CG9V1ulwa8wnB8Tt5/MMS9bGTnnW8kzIFt7fV/9GvgUDQciXvak/s	 +IzdRjA/6KUjCXjMHKYwWnc+9JlihClZeoS256IrukFDOdEWEu9CPcMZIX7OnoM7BQ	 9V/5dHi+6PY6kXomLOK8mWk2+X87dq+9WOL2vwml+kSmcyfMW9Xe3MqRfExgvI20ls	 pBpPc/jgifvQqkt4bpAOLtrkjuAC/0auP/vyRnJS16zT6u2r7Kl6WWO3qDXXat71ER	 7AXwE3WVxb7cnL0NxV7Po2Z1ZxGbtMp4FXqcBKZvMxhK1afCHo3okCtAS8Gf2I3NXR	 C4pxyEZoLo9eQ==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 1/4] Cygwin: pty: Define mask_switch_to_pcon_in() in fhandler_tty.cc.
Date: Sun, 09 Feb 2020 14:46:00 -0000
Message-Id: <20200209144603.389-2-takashi.yano@nifty.ne.jp>
In-Reply-To: <20200209144603.389-1-takashi.yano@nifty.ne.jp>
References: <20200209144603.389-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00154.txt

- This patch moves the definition of mask_switch_to_pcon() from
  fhandler.h to fhandler_tty.cc.
---
 winsup/cygwin/fhandler.h      |  9 +--------
 winsup/cygwin/fhandler_tty.cc | 10 ++++++++++
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 82527eca3..53b6c2c45 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2207,14 +2207,7 @@ class fhandler_pty_slave: public fhandler_pty_common
   void set_switch_to_pcon (int fd);
   void reset_switch_to_pcon (void);
   void push_to_pcon_screenbuffer (const char *ptr, size_t len);
-  void mask_switch_to_pcon_in (bool mask)
-  {
-    if (!mask && get_ttyp ()->pcon_pid &&
-	get_ttyp ()->pcon_pid != myself->pid &&
-	!!pinfo (get_ttyp ()->pcon_pid))
-      return;
-    get_ttyp ()->mask_switch_to_pcon_in = mask;
-  }
+  void mask_switch_to_pcon_in (bool mask);
   void fixup_after_attach (bool native_maybe, int fd);
   bool is_line_input (void)
   {
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 181bed5a9..a92bcfc40 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1395,6 +1395,16 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
   return towrite;
 }
 
+void
+fhandler_pty_slave::mask_switch_to_pcon_in (bool mask)
+{
+  if (!mask && get_ttyp ()->pcon_pid &&
+      get_ttyp ()->pcon_pid != myself->pid &&
+      !!pinfo (get_ttyp ()->pcon_pid))
+    return;
+  get_ttyp ()->mask_switch_to_pcon_in = mask;
+}
+
 bool
 fhandler_pty_common::to_be_read_from_pcon (void)
 {
-- 
2.21.0
