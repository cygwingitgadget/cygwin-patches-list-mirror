Return-Path: <cygwin-patches-return-9934-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4080 invoked by alias); 14 Jan 2020 04:11:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 4068 invoked by uid 89); 14 Jan 2020 04:11:25 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: conuserg-05.nifty.com
Received: from conuserg-05.nifty.com (HELO conuserg-05.nifty.com) (210.131.2.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 14 Jan 2020 04:11:23 +0000
Received: from localhost.localdomain (ntsitm247158.sitm.nt.ngn.ppp.infoweb.ne.jp [124.27.253.158]) (authenticated)	by conuserg-05.nifty.com with ESMTP id 00E4B1cO024055;	Tue, 14 Jan 2020 13:11:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-05.nifty.com 00E4B1cO024055
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1578975067;	bh=fmDtLG3dru8z8z1h72Sqk8sDv2573EoLQDWAwZDIC14=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=FbtbTpNIOw0wjpT0ClI2Ycy9KDk2eXLlA0I6yMspa/J2bQRkbrpuoIVUFiyZXF7+V	 mdNqle0DtPzRy5i6FFpGioTJCAbgt3w/s1e2gqo03dAnra3RVFinLfTsv2vdgKQ9WC	 vk+z8Si/4X7cA//ZqCnhnIkQECLYlVc/2r/10zddppnq/0b9IhqTw96yiios6HOt8D	 /S37EG3HBiv03HAKfx0Ov2fewNjJeMN+NMDJsVGsot93yoH5QP+I+ztbUfWaH3eIbG	 /GdOz00UdJzFbZ6IwlSk1q97zxi5rt7NtrAnhzCEKPhQxJr/yJmrH3xfWP1pXqW6b9	 NAd08mjm4RifA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2] Cygwin: pty: Fix the issue regarding open and close multiple PTYs.
Date: Tue, 14 Jan 2020 04:11:00 -0000
Message-Id: <20200114041054.1673-1-takashi.yano@nifty.ne.jp>
In-Reply-To: <20200113154952.GI5858@calimero.vinschen.de>
References: <20200113154952.GI5858@calimero.vinschen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00040.txt

- If two PTYs are opened in the same process and the first one
  is closed, the helper process for the first PTY remains running.
  This patch fixes the issue.
---
 winsup/cygwin/fhandler_tty.cc | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 1a3bdc5ea..042ffd19c 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2214,8 +2214,7 @@ fhandler_pty_master::close ()
     termios_printf ("CloseHandle (output_mutex<%p>), %E", output_mutex);
   if (!NT_SUCCESS (status))
     debug_printf ("NtQueryObject: %y", status);
-  else if (obi.HandleCount == (get_pseudo_console () ? 2 : 1))
-			      /* Helper process has inherited one. */
+  else if (obi.HandleCount == 1)
     {
       termios_printf ("Closing last master of pty%d", get_minor ());
       /* Close Pseudo Console */
@@ -3167,14 +3166,14 @@ fhandler_pty_master::setup_pseudoconsole ()
     get_ttyp ()->attach_pcon_in_fork = true;
 
   SIZE_T bytesRequired;
-  InitializeProcThreadAttributeList (NULL, 1, 0, &bytesRequired);
+  InitializeProcThreadAttributeList (NULL, 2, 0, &bytesRequired);
   STARTUPINFOEXW si_helper;
   ZeroMemory (&si_helper, sizeof (si_helper));
   si_helper.StartupInfo.cb = sizeof (STARTUPINFOEXW);
   si_helper.lpAttributeList = (PPROC_THREAD_ATTRIBUTE_LIST)
     HeapAlloc (GetProcessHeap (), 0, bytesRequired);
   InitializeProcThreadAttributeList (si_helper.lpAttributeList,
-				     1, 0, &bytesRequired);
+				     2, 0, &bytesRequired);
   UpdateProcThreadAttribute (si_helper.lpAttributeList,
 			     0,
 			     PROC_THREAD_ATTRIBUTE_PSEUDOCONSOLE,
@@ -3186,6 +3185,14 @@ fhandler_pty_master::setup_pseudoconsole ()
   /* Create a pipe for receiving pseudo console handles */
   HANDLE hr, hw;
   CreatePipe (&hr, &hw, &sec_none, 0);
+  /* Inherit only handles which are needed by helper. */
+  HANDLE handles_to_inherit[] = {hello, goodbye, hw};
+  UpdateProcThreadAttribute (si_helper.lpAttributeList,
+			     0,
+			     PROC_THREAD_ATTRIBUTE_HANDLE_LIST,
+			     handles_to_inherit,
+			     sizeof (handles_to_inherit),
+			     NULL, NULL);
   /* Create helper process */
   WCHAR cmd[MAX_PATH];
   path_conv helper ("/bin/cygwin-console-helper.exe");
-- 
2.21.0
