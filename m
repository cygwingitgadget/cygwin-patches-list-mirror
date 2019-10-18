Return-Path: <cygwin-patches-return-9766-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 92212 invoked by alias); 18 Oct 2019 23:52:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 92200 invoked by uid 89); 18 Oct 2019 23:52:07 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:4166, screen
X-HELO: conuserg-02.nifty.com
Received: from conuserg-02.nifty.com (HELO conuserg-02.nifty.com) (210.131.2.69) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 18 Oct 2019 23:52:05 +0000
Received: from localhost.localdomain (ntsitm283243.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.151.243]) (authenticated)	by conuserg-02.nifty.com with ESMTP id x9INplYt031899;	Sat, 19 Oct 2019 08:51:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-02.nifty.com x9INplYt031899
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1571442713;	bh=T9FTHsviLLY0gbO4r+1ktQKAJ9HNyWcWTvwkVsHTizo=;	h=From:To:Cc:Subject:Date:From;	b=jAjJKD4F9JcsQRA/fH05S+fCs4AEWCV/pLh8IZti2KXHU10DBL37P0ocxJGHj1quN	 i3dZjRa8XmaYvDWSICMSr7SKHnVZ5fvBWJ8ndc3ubOvC3k6RVF6IZO7mO3325t3Rgb	 wkm9Ti/Z7EkzQoARglcpAowhcNePdLdF4WdmZTRDG6AmAY4QfEoygm0PGdyXxaplNc	 pmX9D27pt5m0meILqy4A00RYq9vZXdMBrVgv7CDQ9Yg/UcHhwOd10K910unlHyNB2u	 FttsNXB8f8KqD+CYoOM7RIQtCDqyt63oPDNt62FEuL/IEaj7T8RgAvAge/QchsImhJ	 uIqywcG0AMPmw==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2] Cygwin: pty: Disable clear screen for ssh sessions with -t option.
Date: Fri, 18 Oct 2019 23:52:00 -0000
Message-Id: <20191018235140.1506-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00037.txt.bz2

---
 winsup/cygwin/fhandler_tty.cc | 67 ++++++++++++++++++++++-------------
 winsup/cygwin/tty.cc          |  1 +
 winsup/cygwin/tty.h           |  1 +
 3 files changed, 44 insertions(+), 25 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index da6119dfb..d82757e97 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1296,6 +1296,30 @@ detach:
   restore_reattach_pcon ();
 }
 
+/* If master process is running as service, attaching to
+   pseudo console should be done in fork. If attaching
+   is done in spawn for inetd or sshd, it fails because
+   the helper process is running as privileged user while
+   slave process is not. This function is used to determine
+   if the process is running as a srvice or not. */
+static bool
+is_running_as_service (void)
+{
+  DWORD dwSize = 0;
+  PTOKEN_GROUPS pGroupInfo;
+  tmp_pathbuf tp;
+  pGroupInfo = (PTOKEN_GROUPS) tp.w_get ();
+  NtQueryInformationToken (hProcToken, TokenGroups, pGroupInfo,
+					2 * NT_MAX_PATH, &dwSize);
+  for (DWORD i=0; i<pGroupInfo->GroupCount; i++)
+    if (RtlEqualSid (well_known_service_sid, pGroupInfo->Groups[i].Sid))
+      return true;
+  for (DWORD i=0; i<pGroupInfo->GroupCount; i++)
+    if (RtlEqualSid (mandatory_system_integrity_sid, pGroupInfo->Groups[i].Sid))
+      return true;
+  return false;
+}
+
 ssize_t __stdcall
 fhandler_pty_slave::write (const void *ptr, size_t len)
 {
@@ -1305,6 +1329,18 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
   if (bg <= bg_eof)
     return (ssize_t) bg;
 
+  if (get_ttyp ()->need_clear_screen_on_write)
+    {
+      if (is_running_as_service ())
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
@@ -2668,7 +2704,12 @@ fhandler_pty_slave::fixup_after_attach (bool native_maybe, int fd_set)
 	  if (get_ttyp ()->num_pcon_attached_slaves == 0
 	      && !ALWAYS_USE_PCON)
 	    /* Assume this is the first process using this pty slave. */
-	    get_ttyp ()->need_clear_screen = true;
+	    {
+	      if (is_running_as_service ())
+		get_ttyp ()->need_clear_screen_on_write = true;
+	      else
+		get_ttyp ()->need_clear_screen = true;
+	    }
 
 	  get_ttyp ()->num_pcon_attached_slaves ++;
 	}
@@ -3088,30 +3129,6 @@ pty_master_fwd_thread (VOID *arg)
   return ((fhandler_pty_master *) arg)->pty_master_fwd_thread ();
 }
 
-/* If master process is running as service, attaching to
-   pseudo console should be done in fork. If attaching
-   is done in spawn for inetd or sshd, it fails because
-   the helper process is running as privileged user while
-   slave process is not. This function is used to determine
-   if the process is running as a srvice or not. */
-static bool
-is_running_as_service (void)
-{
-  DWORD dwSize = 0;
-  PTOKEN_GROUPS pGroupInfo;
-  tmp_pathbuf tp;
-  pGroupInfo = (PTOKEN_GROUPS) tp.w_get ();
-  NtQueryInformationToken (hProcToken, TokenGroups, pGroupInfo,
-					2 * NT_MAX_PATH, &dwSize);
-  for (DWORD i=0; i<pGroupInfo->GroupCount; i++)
-    if (RtlEqualSid (well_known_service_sid, pGroupInfo->Groups[i].Sid))
-      return true;
-  for (DWORD i=0; i<pGroupInfo->GroupCount; i++)
-    if (RtlEqualSid (well_known_interactive_sid, pGroupInfo->Groups[i].Sid))
-      return false;
-  return true;
-}
-
 bool
 fhandler_pty_master::setup_pseudoconsole ()
 {
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
