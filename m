Return-Path: <cygwin-patches-return-9763-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 758 invoked by alias); 18 Oct 2019 11:37:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 660 invoked by uid 89); 18 Oct 2019 11:37:38 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=screen, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-06.nifty.com
Received: from conuserg-06.nifty.com (HELO conuserg-06.nifty.com) (210.131.2.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 18 Oct 2019 11:37:37 +0000
Received: from localhost.localdomain (ntsitm283243.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.151.243]) (authenticated)	by conuserg-06.nifty.com with ESMTP id x9IBbMtc011786;	Fri, 18 Oct 2019 20:37:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-06.nifty.com x9IBbMtc011786
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1571398648;	bh=eofx1K4UQAMYBVUr68j4x9unmjUPMp7Tae5cOnqW6PQ=;	h=From:To:Cc:Subject:Date:From;	b=UsRepPhCk4xGnIU1kq4dhpA+tkqgharxEKkgb50y6rSvyaufcqj3+Z0kReaWVJIaH	 cvE0UCeZf/mgw/LG72tR4bb7wN1evjeRhOaaujY0BuHY2cOJ4NPmJwIqWW2+vS9JwT	 J8Pk0vxVoFwXUW0DNn0bbviVdwtfTEDYsK4Farn94rdH+YHadNIxF/ydJUoBTrlOKM	 ytTuQC5ZQaxLhXneyaLTrq2U6iA+VooiOXPMzoA1P2uxw+mSwag4chY/5HcPFj06dn	 +Kpdpu2MJNXu82cFIG+w32t2bzd88sCpg3Z47oTcXQzZQMvg4HYWpkg2wGLjbkYYY3	 hlFsSmLmEVGMg==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Disable clear screen for ssh sessions with -t option.
Date: Fri, 18 Oct 2019 11:37:00 -0000
Message-Id: <20191018113721.2486-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00034.txt.bz2

---
 winsup/cygwin/fhandler_tty.cc | 21 ++++++++++++++++++++-
 winsup/cygwin/tty.cc          |  1 +
 winsup/cygwin/tty.h           |  1 +
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index da6119dfb..163f93f35 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1305,6 +1305,20 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
   if (bg <= bg_eof)
     return (ssize_t) bg;
 
+  if (get_ttyp ()->need_clear_screen_on_write)
+    {
+      const char *term = getenv ("TERM");
+      if (term && strcmp (term, "dumb") && !strstr (term, "emacs") &&
+	  wcsstr (myself->progname, L"\\usr\\sbin\\sshd.exe"))
+	{
+	  /* FIXME: Clearing sequence may not be "^[[H^[[J"
+	     depending on the terminal type. */
+	  DWORD n;
+	  WriteFile (get_output_handle_cyg (), "\033[H\033[J", 6, &n, NULL);
+	}
+      get_ttyp ()->need_clear_screen_on_write = false;
+    }
+
   termios_printf ("pty%d, write(%p, %lu)", get_minor (), ptr, len);
 
   push_process_state process_state (PID_TTYOU);
@@ -2668,7 +2682,12 @@ fhandler_pty_slave::fixup_after_attach (bool native_maybe, int fd_set)
 	  if (get_ttyp ()->num_pcon_attached_slaves == 0
 	      && !ALWAYS_USE_PCON)
 	    /* Assume this is the first process using this pty slave. */
-	    get_ttyp ()->need_clear_screen = true;
+	    {
+	      if (wcsstr (myself->progname, L"\\usr\\sbin\\sshd.exe"))
+		get_ttyp ()->need_clear_screen_on_write = true;
+	      else
+		get_ttyp ()->need_clear_screen = true;
+	    }
 
 	  get_ttyp ()->num_pcon_attached_slaves ++;
 	}
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index 460153cdb..1595d0278 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -245,6 +245,7 @@ tty::init ()
   num_pcon_attached_slaves = 0;
   term_code_page = 0;
   need_clear_screen = false;
+  need_clear_screen_on_write = false;
 }
 
 HANDLE
diff --git a/winsup/cygwin/tty.h b/winsup/cygwin/tty.h
index 927d7afd9..c7aeef85b 100644
--- a/winsup/cygwin/tty.h
+++ b/winsup/cygwin/tty.h
@@ -106,6 +106,7 @@ private:
   int num_pcon_attached_slaves;
   UINT term_code_page;
   bool need_clear_screen;
+  bool need_clear_screen_on_write;
 
 public:
   HANDLE from_master () const { return _from_master; }
-- 
2.21.0
