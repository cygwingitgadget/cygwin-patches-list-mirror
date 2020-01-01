Return-Path: <cygwin-patches-return-9894-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17262 invoked by alias); 1 Jan 2020 06:48:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 17161 invoked by uid 89); 1 Jan 2020 06:48:24 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-15.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=retrieve, inherited, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-01.nifty.com
Received: from conuserg-01.nifty.com (HELO conuserg-01.nifty.com) (210.131.2.68) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 01 Jan 2020 06:48:21 +0000
Received: from localhost.localdomain (ntsitm247158.sitm.nt.ngn.ppp.infoweb.ne.jp [124.27.253.158]) (authenticated)	by conuserg-01.nifty.com with ESMTP id 0016ltpb031000;	Wed, 1 Jan 2020 15:48:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-01.nifty.com 0016ltpb031000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1577861281;	bh=t63MWRgQVJYhFGSRpUwMTc9nFdGLO/Eoi3sIMUwZvxE=;	h=From:To:Cc:Subject:Date:From;	b=T598k3aIlWnOilERLppq5/TgTaB6GupxUgFJ6m6J+JCX0pZviP5Kms9vC+kqezgNM	 Fqi1jP8ACXOqYrVoA8iOAwstN+mRkUNoDqdkvnck7CYUchwhPlmo6DWNL0MhaESYZP	 hHfHUZFFdtnbh1C8nOaLDaFzxdPatnhn0iiVd1u4tRfBXes5MtvxRL4dizB+RxzPKV	 mUzXJweQjSFOcE6yx4uFdYCRxjt5zrHkF9rJXWfPxqE9nrethWgpl0P3oB/fFr3sml	 wLq9PyFhYQx55i9Pa8mPnJ0salM2rBTXie0A7xmVlcwMugeo/wMi06eAYB12I7GGQZ	 xqqDr4faJjiJQ==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Fix the issue regarding open and close multiple PTYs.
Date: Wed, 01 Jan 2020 06:48:00 -0000
Message-Id: <20200101064748.8709-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00000.txt

- If two PTYs are opened in the same process and the first one
  is closed, the helper process for the first PTY remains running.
  This patch fixes the issue.
---
 winsup/cygwin/fhandler_tty.cc         |  8 ++++----
 winsup/utils/cygwin-console-helper.cc | 15 ++++++++++++++-
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index f10f0fc61..65b12fd6c 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2233,8 +2233,7 @@ fhandler_pty_master::close ()
     termios_printf ("CloseHandle (output_mutex<%p>), %E", output_mutex);
   if (!NT_SUCCESS (status))
     debug_printf ("NtQueryObject: %y", status);
-  else if (obi.HandleCount == (get_pseudo_console () ? 2 : 1))
-			      /* Helper process has inherited one. */
+  else if (obi.HandleCount == 1)
     {
       termios_printf ("Closing last master of pty%d", get_minor ());
       /* Close Pseudo Console */
@@ -3202,14 +3201,15 @@ fhandler_pty_master::setup_pseudoconsole ()
   path_conv helper ("/bin/cygwin-console-helper.exe");
   size_t len = helper.get_wide_win32_path_len ();
   helper.get_wide_win32_path (cmd);
-  __small_swprintf (cmd + len, L" %p %p %p", hello, goodbye, hw);
+  __small_swprintf (cmd + len, L" %p %p %p %p",
+		    hello, goodbye, hw, GetCurrentProcessId ());
   si_helper.StartupInfo.dwFlags = STARTF_USESTDHANDLES;
   si_helper.StartupInfo.hStdInput = NULL;
   si_helper.StartupInfo.hStdOutput = NULL;
   si_helper.StartupInfo.hStdError = NULL;
   PROCESS_INFORMATION pi_helper;
   CreateProcessW (NULL, cmd, &sec_none, &sec_none,
-		  TRUE, EXTENDED_STARTUPINFO_PRESENT,
+		  FALSE, EXTENDED_STARTUPINFO_PRESENT,
 		  NULL, NULL, &si_helper.StartupInfo, &pi_helper);
   WaitForSingleObject (hello, INFINITE);
   /* Retrieve pseudo console handles */
diff --git a/winsup/utils/cygwin-console-helper.cc b/winsup/utils/cygwin-console-helper.cc
index 66004bd15..6255fb93d 100644
--- a/winsup/utils/cygwin-console-helper.cc
+++ b/winsup/utils/cygwin-console-helper.cc
@@ -4,14 +4,24 @@ int
 main (int argc, char **argv)
 {
   char *end;
+  HANDLE parent = NULL;
   if (argc < 3)
     exit (1);
+  if (argc == 5)
+    parent = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
+			  strtoull (argv[4], &end, 0));
   HANDLE h = (HANDLE) strtoull (argv[1], &end, 0);
+  if (parent)
+    DuplicateHandle (parent, h, GetCurrentProcess (), &h,
+		     0, FALSE, DUPLICATE_SAME_ACCESS);
   SetEvent (h);
-  if (argc == 4) /* Pseudo console helper mode for PTY */
+  if (argc == 4 || argc == 5) /* Pseudo console helper mode for PTY */
     {
       SetConsoleCtrlHandler (NULL, TRUE);
       HANDLE hPipe = (HANDLE) strtoull (argv[3], &end, 0);
+      if (parent)
+	DuplicateHandle (parent, hPipe, GetCurrentProcess (), &hPipe,
+			 0, FALSE, DUPLICATE_SAME_ACCESS);
       char buf[64];
       sprintf (buf, "StdHandles=%p,%p\n",
 	       GetStdHandle (STD_INPUT_HANDLE),
@@ -21,6 +31,9 @@ main (int argc, char **argv)
       CloseHandle (hPipe);
     }
   h = (HANDLE) strtoull (argv[2], &end, 0);
+  if (parent)
+    DuplicateHandle (parent, h, GetCurrentProcess (), &h,
+		     0, FALSE, DUPLICATE_SAME_ACCESS);
   WaitForSingleObject (h, INFINITE);
   exit (0);
 }
-- 
2.21.0
