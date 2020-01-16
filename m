Return-Path: <cygwin-patches-return-9938-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 81759 invoked by alias); 16 Jan 2020 11:05:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 78553 invoked by uid 89); 16 Jan 2020 11:05:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: conuserg-06.nifty.com
Received: from conuserg-06.nifty.com (HELO conuserg-06.nifty.com) (210.131.2.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 16 Jan 2020 11:05:04 +0000
Received: from localhost.localdomain (ntsitm247158.sitm.nt.ngn.ppp.infoweb.ne.jp [124.27.253.158]) (authenticated)	by conuserg-06.nifty.com with ESMTP id 00GB4tOa017146;	Thu, 16 Jan 2020 20:05:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-06.nifty.com 00GB4tOa017146
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1579172700;	bh=PHYkkhqlSQp1Ka32puhhoZXv0+LPPWKTclkWEIitUIQ=;	h=From:To:Cc:Subject:Date:From;	b=XPCYlgHPPfZd4cJmzkBvwsM+EoWO0YE5BnGNbHv2kJvn2ii7tfwtve7Iq0GydOsb9	 HO4Z7bzcWPrZgL4rgUBODveup9v78Fr68Hmpf4tafhce+vHuJ1T7dc317z14p7boDd	 fMrkvr3l8LC7PTvKWScqFzO0XR568cXxjcSm5WnQvd4b3/y7p03IsjtNJcXjNaABcy	 gZm5LOMMJqP16JSdXyHPOuVwlb4fGMarAeFOnVjcXzQogtn0dNKVSSqNd8gDhzJf0u	 QEu9lXyjEsux1ZxRXbHEBD+lbuKp2giJDc1pKYMPK9hAKIezpyKPNNGkSMSHUbjSR0	 mIgtFWtjMwh4g==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Fix state mismatch caused in octave gui.
Date: Thu, 16 Jan 2020 11:05:00 -0000
Message-Id: <20200116110447.1882-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00044.txt

- In octave gui, sometimes state mismatch between real pty state
  and state variable occurs. For example, this occurs when 'ls'
  command is executed in octave gui. This patch fixes the issue.
---
 winsup/cygwin/spawn.cc | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 08d52bb28..f7c6dd590 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -947,6 +947,15 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
     {
       FreeConsole ();
       AttachConsole (pid_restore);
+      cygheap_fdenum cfd (false);
+      int fd;
+      while ((fd = cfd.next ()) >= 0)
+	if (cfd->get_major () == DEV_PTYS_MAJOR)
+	  {
+	    fhandler_pty_slave *ptys =
+	      (fhandler_pty_slave *) (fhandler_base *) cfd;
+	    ptys->fixup_after_attach (false, fd);
+	  }
     }
 
   return (int) res;
-- 
2.21.0
