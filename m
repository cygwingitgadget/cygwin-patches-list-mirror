Return-Path: <cygwin-patches-return-9932-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32884 invoked by alias); 14 Jan 2020 02:50:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 32872 invoked by uid 89); 14 Jan 2020 02:50:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: conuserg-06.nifty.com
Received: from conuserg-06.nifty.com (HELO conuserg-06.nifty.com) (210.131.2.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 14 Jan 2020 02:50:29 +0000
Received: from localhost.localdomain (ntsitm247158.sitm.nt.ngn.ppp.infoweb.ne.jp [124.27.253.158]) (authenticated)	by conuserg-06.nifty.com with ESMTP id 00E2oDxi023789;	Tue, 14 Jan 2020 11:50:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-06.nifty.com 00E2oDxi023789
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1578970217;	bh=g8zOqQ2Do7ETBt5p2DltoReyVEQqgfhCqiRqsEZzh3A=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=lJoKN1i5jf97+bqWvmPAKI7JfIWGyOkrFei6mHNyJJPJUPkAbaSOJer7Qj6nqxzrT	 XPbCFIUT1DuM/WNwtDtU5Dy7qOqkBNQ+ZlUhM8FMVwuChWmhiJOEiSvhGjyInJ2oL9	 ZSqvC7UX+VByn48aJVz7T7CKu52IqFDfW3GnjloIzcZ7E4d6OMia+8cNGsK0I/mZTN	 wSwCzcI5dWksHr8APW/EjPRB4URmrCzILTh3JicWW3ig4w1pZUaPHi5PNnikyOKpWD	 LC0xieTbJ85X8jm4wSr3fUiNjrN6+WpFgNOKoNkiq0kB62iLZ82QM1ZloFIw6oyPtI	 XDNFWZjg/bvPA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2] Cygwin: pty: Add missing CloseHandle() calls.
Date: Tue, 14 Jan 2020 02:50:00 -0000
Message-Id: <20200114025004.670-1-takashi.yano@nifty.ne.jp>
In-Reply-To: <20200113155619.GJ5858@calimero.vinschen.de>
References: <20200113155619.GJ5858@calimero.vinschen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00038.txt

- PTY code which support pseudo console has a problem that causes
  handle leaks. Four of these are bug in pty code, and the other
  one seems to be a bug of Windows10. ClosePseudoConsole() fails
  to close one internal handle. This patch fixes the issue.
---
 winsup/cygwin/fhandler_tty.cc | 16 ++++++++++++++--
 winsup/cygwin/ntdll.h         | 13 +++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index ca4dc1c20..1a3bdc5ea 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2224,11 +2224,21 @@ fhandler_pty_master::close ()
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
+	      HPCON_INTERNAL *hp = (HPCON_INTERNAL *) get_pseudo_console ();
+	      HANDLE tmp = hp->hConHostProcess;
+	      /* Release pseudo console */
+	      ClosePseudoConsole (get_pseudo_console ());
+	      CloseHandle (tmp);
+	    }
 	  get_ttyp ()->switch_to_pcon_in = false;
 	  get_ttyp ()->switch_to_pcon_out = false;
 	}
@@ -3191,6 +3201,8 @@ fhandler_pty_master::setup_pseudoconsole ()
 		  TRUE, EXTENDED_STARTUPINFO_PRESENT,
 		  NULL, NULL, &si_helper.StartupInfo, &pi_helper);
   WaitForSingleObject (hello, INFINITE);
+  CloseHandle (hello);
+  CloseHandle (pi_helper.hThread);
   /* Retrieve pseudo console handles */
   DWORD rLen;
   char buf[64];
diff --git a/winsup/cygwin/ntdll.h b/winsup/cygwin/ntdll.h
index 1c07d0255..8a08111db 100644
--- a/winsup/cygwin/ntdll.h
+++ b/winsup/cygwin/ntdll.h
@@ -1763,4 +1763,17 @@ extern "C"
     return status;
   }
 }
+
+/* This is for pseudo console workaround. ClosePseudoConsole()
+   seems to have a bug that one internal handle remains opend.
+   This causes handle leak. To close this handle, it is needed
+   to access internal of HPCON. HPCON_INTERNAL is defined for
+   this purpose. The structure of internal of HPCON is not
+   documented. Refer to: https://github.com/Biswa96/XConPty */
+typedef struct _HPCON_INTERNAL
+{
+  HANDLE hWritePipe;
+  HANDLE hConDrvReference;
+  HANDLE hConHostProcess;
+} HPCON_INTERNAL;
 #endif
-- 
2.21.0
