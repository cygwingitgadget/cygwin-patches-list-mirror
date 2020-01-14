Return-Path: <cygwin-patches-return-9931-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 99140 invoked by alias); 14 Jan 2020 02:10:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 99127 invoked by uid 89); 14 Jan 2020 02:10:21 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=61026
X-HELO: conuserg-01.nifty.com
Received: from conuserg-01.nifty.com (HELO conuserg-01.nifty.com) (210.131.2.68) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 14 Jan 2020 02:10:19 +0000
Received: from localhost.localdomain (ntsitm247158.sitm.nt.ngn.ppp.infoweb.ne.jp [124.27.253.158]) (authenticated)	by conuserg-01.nifty.com with ESMTP id 00E29p5I019572;	Tue, 14 Jan 2020 11:09:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-01.nifty.com 00E29p5I019572
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1578967797;	bh=4ldWwh08BFcU+Ag+eEjdBSa1Eofh4u/dd3S6qzbLNxU=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=c9e4uz9zQNSGBy7LxCVAq2f5N75d7ZusKbEWJKPCWj5gmIX7zpOU8i8fmDFi03jOM	 DW3o0TdIrSWBZCe5aGGktryeo1CcgM/A6RiC/RSdDZ7bfJmr1humeQzORJADMML/6z	 wApK79TmV2HeQSzRrxiVTbX+8TDlXDHw6m1vu8WKuq/uD6h0k0S0YapljRGC3kq9V3	 hu/6D7pSFWpNBCDoD28vsrNkINE4g0/RR6+VfHJCfRVakPX595cH/WbWp7k+DUSrlw	 tGcTdIC/JFIaezS2V6WsFihku2cG8cCbSbBwcaLjaB9ZKv1YYIed48eOa7HxCmYJQs	 IMKY7NgART1/w==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2] Cygwin: console: Disable xterm mode for non cygwin process only.
Date: Tue, 14 Jan 2020 02:10:00 -0000
Message-Id: <20200114020942.2995-1-takashi.yano@nifty.ne.jp>
In-Reply-To: <20200113161118.GM5858@calimero.vinschen.de>
References: <20200113161118.GM5858@calimero.vinschen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00037.txt

- Special function keys such as arrow keys or function keys do not
  work in ConEmu with cygwin-connector after commit
  6a06c6bc8f8492ea09aa3ae180fe94e4ac265611. This patch fixes the
  issue.
---
 winsup/cygwin/fhandler_console.cc | 19 -------------------
 winsup/cygwin/fhandler_tty.cc     | 10 ----------
 winsup/cygwin/spawn.cc            | 21 ++++++++++++++++++++-
 winsup/cygwin/winlean.h           | 12 ++++++++++++
 4 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 8591f579d..337331be2 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -33,17 +33,6 @@ details. */
 #include "child_info.h"
 #include "cygwait.h"
 
-/* Not yet defined in Mingw-w64 */
-#ifndef ENABLE_VIRTUAL_TERMINAL_PROCESSING
-#define ENABLE_VIRTUAL_TERMINAL_PROCESSING 0x0004
-#endif /* ENABLE_VIRTUAL_TERMINAL_PROCESSING */
-#ifndef DISABLE_NEWLINE_AUTO_RETURN
-#define DISABLE_NEWLINE_AUTO_RETURN 0x0008
-#endif /* DISABLE_NEWLINE_AUTO_RETURN */
-#ifndef ENABLE_VIRTUAL_TERMINAL_INPUT
-#define ENABLE_VIRTUAL_TERMINAL_INPUT 0x0200
-#endif /* ENABLE_VIRTUAL_TERMINAL_INPUT */
-
 /* Don't make this bigger than NT_MAX_PATH as long as the temporary buffer
    is allocated using tmp_pathbuf!!! */
 #define CONVERT_LIMIT NT_MAX_PATH
@@ -2987,14 +2976,6 @@ fhandler_console::fixup_after_fork_exec (bool execing)
 {
   set_unit ();
   setup_io_mutex ();
-  if (wincap.has_con_24bit_colors () && !con_is_legacy)
-    {
-      DWORD dwMode;
-      /* Disable xterm compatible mode in input */
-      GetConsoleMode (get_handle (), &dwMode);
-      dwMode &= ~ENABLE_VIRTUAL_TERMINAL_INPUT;
-      SetConsoleMode (get_handle (), dwMode);
-    }
 }
 
 // #define WINSTA_ACCESS (WINSTA_READATTRIBUTES | STANDARD_RIGHTS_READ | STANDARD_RIGHTS_WRITE | WINSTA_CREATEDESKTOP | WINSTA_EXITWINDOWS)
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 0837b63e1..ca4dc1c20 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -31,19 +31,9 @@ details. */
 #define ALWAYS_USE_PCON false
 #define USE_API_HOOK true
 
-/* Not yet defined in Mingw-w64 */
-#ifndef ENABLE_VIRTUAL_TERMINAL_PROCESSING
-#define ENABLE_VIRTUAL_TERMINAL_PROCESSING 0x0004
-#endif /* ENABLE_VIRTUAL_TERMINAL_PROCESSING */
-#ifndef DISABLE_NEWLINE_AUTO_RETURN
-#define DISABLE_NEWLINE_AUTO_RETURN 0x0008
-#endif /* DISABLE_NEWLINE_AUTO_RETURN */
 #ifndef PROC_THREAD_ATTRIBUTE_PSEUDOCONSOLE
 #define PROC_THREAD_ATTRIBUTE_PSEUDOCONSOLE 0x00020016
 #endif /* PROC_THREAD_ATTRIBUTE_PSEUDOCONSOLE */
-#ifndef ENABLE_VIRTUAL_TERMINAL_INPUT
-#define ENABLE_VIRTUAL_TERMINAL_INPUT 0x0200
-#endif /* ENABLE_VIRTUAL_TERMINAL_INPUT */
 
 extern "C" int sscanf (const char *, const char *, ...);
 extern "C" int ttyname_r (int, char*, size_t);
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index cea79e326..6a5034219 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -610,7 +610,26 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 		}
 	    }
 	  else if (fh && fh->get_major () == DEV_CONS_MAJOR)
-	    attach_to_console = true;
+	    {
+	      attach_to_console = true;
+	      if (wincap.has_con_24bit_colors () && !iscygwin ())
+		{
+		  DWORD dwMode;
+		  if (fd == 0)
+		    {
+		      /* Disable xterm compatible mode in input */
+		      GetConsoleMode (fh->get_handle (), &dwMode);
+		      dwMode &= ~ENABLE_VIRTUAL_TERMINAL_INPUT;
+		      SetConsoleMode (fh->get_handle (), dwMode);
+		    }
+		  else
+		    {
+		      GetConsoleMode (fh->get_output_handle (), &dwMode);
+		      dwMode &= ~ENABLE_VIRTUAL_TERMINAL_PROCESSING;
+		      SetConsoleMode (fh->get_output_handle (), dwMode);
+		    }
+		}
+	    }
 	}
 
       /* Set up needed handles for stdio */
diff --git a/winsup/cygwin/winlean.h b/winsup/cygwin/winlean.h
index deb79bef8..3d79a92e4 100644
--- a/winsup/cygwin/winlean.h
+++ b/winsup/cygwin/winlean.h
@@ -93,4 +93,16 @@ details. */
    use this function.  Use GetSystemWindowsDirectoryW. */
 #define GetWindowsDirectoryW dont_use_GetWindowsDirectory
 #define GetWindowsDirectoryA dont_use_GetWindowsDirectory
+
+/* For console with xterm compatible mode */
+/* Not yet defined in Mingw-w64 */
+#ifndef ENABLE_VIRTUAL_TERMINAL_PROCESSING
+#define ENABLE_VIRTUAL_TERMINAL_PROCESSING 0x0004
+#endif /* ENABLE_VIRTUAL_TERMINAL_PROCESSING */
+#ifndef ENABLE_VIRTUAL_TERMINAL_INPUT
+#define ENABLE_VIRTUAL_TERMINAL_INPUT 0x0200
+#endif /* ENABLE_VIRTUAL_TERMINAL_INPUT */
+#ifndef DISABLE_NEWLINE_AUTO_RETURN
+#define DISABLE_NEWLINE_AUTO_RETURN 0x0008
+#endif /* DISABLE_NEWLINE_AUTO_RETURN */
 #endif /*_WINLEAN_H*/
-- 
2.21.0
