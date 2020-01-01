Return-Path: <cygwin-patches-return-9895-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18078 invoked by alias); 1 Jan 2020 06:49:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 18013 invoked by uid 89); 1 Jan 2020 06:49:13 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-16.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: conuserg-03.nifty.com
Received: from conuserg-03.nifty.com (HELO conuserg-03.nifty.com) (210.131.2.70) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 01 Jan 2020 06:49:10 +0000
Received: from localhost.localdomain (ntsitm247158.sitm.nt.ngn.ppp.infoweb.ne.jp [124.27.253.158]) (authenticated)	by conuserg-03.nifty.com with ESMTP id 0016mpwa002337;	Wed, 1 Jan 2020 15:48:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-03.nifty.com 0016mpwa002337
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1577861337;	bh=Cf5aKfMfqh19maq4UmklXcfUce7N0NSokUcZvF5u3Bo=;	h=From:To:Cc:Subject:Date:From;	b=niBBLji9DMj0Qm9b/Tp9O8l7B1C3scNMVDAhleDylcf+ocNzxea3hqrZz7N+XTdhg	 8Z/haUioj4B2RCdFaLYIAQ06w5m8Y6A4BDOtQ2BTV9cLuvqVrz/D+NVotkUCfhik5o	 8qK5dE19UesiTlguR2bP4PP1wdMTXaPrykUyazittyo67+N4v1H5O2rq8BbY3PgHLI	 bGmYYj3QNV9F3YLlMURlPe2LbRfPUb0xTCexcBYuIA2di/ZfcwLROn5hpGXeAoiYP9	 hfXd/F7Q8nJ0SMrQi2Xe/EA50WeP37btPpgj6gRj8Mhrwer7/HATY7oyfCDkcKYw4m	 L2H3Pg6+3WFTw==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Add missing CloseHandle() calls.
Date: Wed, 01 Jan 2020 06:49:00 -0000
Message-Id: <20200101064845.8756-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00001.txt

---
 winsup/cygwin/fhandler_tty.cc | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 65b12fd6c..23156f977 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2242,11 +2242,27 @@ fhandler_pty_master::close ()
 	  /* Terminate helper process */
 	  SetEvent (get_ttyp ()->h_helper_goodbye);
 	  WaitForSingleObject (get_ttyp ()->h_helper_process, INFINITE);
+	  CloseHandle (get_ttyp ()->h_helper_goodbye);
+	  CloseHandle (get_ttyp ()->h_helper_process);
 	  /* FIXME: Pseudo console can be accessed via its handle
 	     only in the process which created it. What else can we do? */
 	  if (master_pid_tmp == myself->pid)
-	    /* Release pseudo console */
-	    ClosePseudoConsole (get_pseudo_console ());
+	    {
+	      /* ClosePseudoConsole() seems to have a bug that one
+		 internal handle remains opened. This causes handle leak.
+		 This is a workaround for this problem. */
+	      typedef struct
+	      {
+		HANDLE hWritePipe;
+		HANDLE hConDrvReference;
+		HANDLE hConHostProcess;
+	      } HPCON_INTERNAL;
+	      HPCON_INTERNAL *hp = (HPCON_INTERNAL *) get_pseudo_console ();
+	      HANDLE tmp = hp->hConHostProcess;
+	      /* Release pseudo console */
+	      ClosePseudoConsole (get_pseudo_console ());
+	      CloseHandle (tmp);
+	    }
 	  get_ttyp ()->switch_to_pcon_in = false;
 	  get_ttyp ()->switch_to_pcon_out = false;
 	}
@@ -3212,6 +3228,8 @@ fhandler_pty_master::setup_pseudoconsole ()
 		  FALSE, EXTENDED_STARTUPINFO_PRESENT,
 		  NULL, NULL, &si_helper.StartupInfo, &pi_helper);
   WaitForSingleObject (hello, INFINITE);
+  CloseHandle (hello);
+  CloseHandle (pi_helper.hThread);
   /* Retrieve pseudo console handles */
   DWORD rLen;
   char buf[64];
-- 
2.21.0
