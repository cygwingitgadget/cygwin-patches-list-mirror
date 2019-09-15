Return-Path: <cygwin-patches-return-9684-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 118734 invoked by alias); 15 Sep 2019 10:56:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 118719 invoked by uid 89); 15 Sep 2019 10:56:07 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: conuserg-06.nifty.com
Received: from conuserg-06.nifty.com (HELO conuserg-06.nifty.com) (210.131.2.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 15 Sep 2019 10:56:05 +0000
Received: from localhost.localdomain (ntsitm283243.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.151.243]) (authenticated)	by conuserg-06.nifty.com with ESMTP id x8FAtgPL018313;	Sun, 15 Sep 2019 19:55:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-06.nifty.com x8FAtgPL018313
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1568544946;	bh=zdhJuQwny15O2NYXrrhizDGt+Qki0rpNUHOeq5nFqR4=;	h=From:To:Cc:Subject:Date:From;	b=Fa/rsYHWp4x+rCHdWyuNbMerkrZNIAa3ah8UBSx+v+mGQkd1KSs/yP0U9RuBGDnRb	 Czw+hBOSOl4I2k9vLeCLE+a6XuBadl83LOUPkWtWvP7Sq45u45sKFDJeS8t+d2A8SJ	 cQs/r0AuBnpHAbOvqAC5aZH0tbQeFeLHGAWOpaInpb+pIRP+fQfwL1lDOqX0cOVBHA	 yHeb2xlg6R2No47+etkHzFXAp6jWnDlbdkyU+1e3FEa/SbuDvfKbQYgtvdQFXJq8HY	 yb6yBQnoqmFjWpB2AkGpchZosLjqPYREAfukK05Hw+Eeq2YNAPE4PgnbmHI0SkQc0Y	 v5kgmtTf07uLw==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Use autoload feature for pseudo console system calls.
Date: Sun, 15 Sep 2019 10:56:00 -0000
Message-Id: <20190915105544.1918-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00204.txt.bz2

- The autoload feature is used rather than GetModuleHandle(),
  GetProcAddress() for CreatePseudoConsole(), ResizePseudoConsole()
  and ClosePseudoConsole().
---
 winsup/cygwin/autoload.cc     |  3 +++
 winsup/cygwin/fhandler_tty.cc | 36 +++++++++++++----------------------
 2 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/winsup/cygwin/autoload.cc b/winsup/cygwin/autoload.cc
index c4d91611e..1851ab3b6 100644
--- a/winsup/cygwin/autoload.cc
+++ b/winsup/cygwin/autoload.cc
@@ -759,4 +759,7 @@ LoadDLLfunc (PdhAddEnglishCounterW, 16, pdh)
 LoadDLLfunc (PdhCollectQueryData, 4, pdh)
 LoadDLLfunc (PdhGetFormattedCounterValue, 16, pdh)
 LoadDLLfunc (PdhOpenQueryW, 12, pdh)
+LoadDLLfuncEx (CreatePseudoConsole, 20, kernel32, 1)
+LoadDLLfuncEx (ResizePseudoConsole, 8, kernel32, 1)
+LoadDLLfuncEx (ClosePseudoConsole, 4, kernel32, 1)
 }
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 5072c6243..659e7b595 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -47,6 +47,12 @@ details. */
 extern "C" int sscanf (const char *, const char *, ...);
 extern "C" int ttyname_r (int, char*, size_t);
 
+extern "C" {
+  HRESULT WINAPI CreatePseudoConsole (COORD, HANDLE, HANDLE, DWORD, HPCON *);
+  HRESULT WINAPI ResizePseudoConsole (HPCON, COORD);
+  VOID WINAPI ClosePseudoConsole (HPCON);
+}
+
 #define close_maybe(h) \
   do { \
     if (h && h != INVALID_HANDLE_VALUE) \
@@ -2157,14 +2163,8 @@ fhandler_pty_master::close ()
 	  /* FIXME: Pseudo console can be accessed via its handle
 	     only in the process which created it. What else can we do? */
 	  if (master_pid_tmp == myself->pid)
-	    {
-	      /* Release pseudo console */
-	      HMODULE hModule = GetModuleHandle ("kernel32.dll");
-	      FARPROC func = GetProcAddress (hModule, "ClosePseudoConsole");
-	      VOID (WINAPI *ClosePseudoConsole) (HPCON) = NULL;
-	      ClosePseudoConsole = (VOID (WINAPI *) (HPCON)) func;
-	      ClosePseudoConsole (getPseudoConsole ());
-	    }
+	    /* Release pseudo console */
+	    ClosePseudoConsole (getPseudoConsole ());
 	  get_ttyp ()->switch_to_pcon_in = false;
 	  get_ttyp ()->switch_to_pcon_out = false;
 	}
@@ -2348,10 +2348,6 @@ fhandler_pty_master::ioctl (unsigned int cmd, void *arg)
 	 only in the process which created it. What else can we do? */
       if (getPseudoConsole () && get_ttyp ()->master_pid == myself->pid)
 	{
-	  HMODULE hModule = GetModuleHandle ("kernel32.dll");
-	  FARPROC func = GetProcAddress (hModule, "ResizePseudoConsole");
-	  HRESULT (WINAPI *ResizePseudoConsole) (HPCON, COORD) = NULL;
-	  ResizePseudoConsole = (HRESULT (WINAPI *) (HPCON, COORD)) func;
 	  COORD size;
 	  size.X = ((struct winsize *) arg)->ws_col;
 	  size.Y = ((struct winsize *) arg)->ws_row;
@@ -3103,22 +3099,16 @@ fhandler_pty_master::setup_pseudoconsole ()
      process in a pseudo console and get them from the helper.
      Slave process will attach to the pseudo console in the
      helper process using AttachConsole(). */
-  HMODULE hModule = GetModuleHandle ("kernel32.dll");
-  FARPROC func = GetProcAddress (hModule, "CreatePseudoConsole");
-  HRESULT (WINAPI *CreatePseudoConsole)
-    (COORD, HANDLE, HANDLE, DWORD, HPCON *) = NULL;
-  if (!func)
-    return false;
-  CreatePseudoConsole =
-    (HRESULT (WINAPI *) (COORD, HANDLE, HANDLE, DWORD, HPCON *)) func;
   COORD size = {80, 25};
   CreatePipe (&from_master, &to_slave, &sec_none, 0);
+  SetLastError (ERROR_SUCCESS);
   HRESULT res = CreatePseudoConsole (size, from_master, to_master,
 				     0, &get_ttyp ()->hPseudoConsole);
-  if (res != S_OK)
+  if (res != S_OK || GetLastError () == ERROR_PROC_NOT_FOUND)
     {
-      system_printf ("CreatePseudoConsole() failed. %08x\n",
-		     GetLastError ());
+      if (res != S_OK)
+	system_printf ("CreatePseudoConsole() failed. %08x\n",
+		       GetLastError ());
       CloseHandle (from_master);
       CloseHandle (to_slave);
       from_master = from_master_cyg;
-- 
2.21.0
