Return-Path: <cygwin-patches-return-9898-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24859 invoked by alias); 1 Jan 2020 06:52:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 24846 invoked by uid 89); 1 Jan 2020 06:52:11 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: conuserg-03.nifty.com
Received: from conuserg-03.nifty.com (HELO conuserg-03.nifty.com) (210.131.2.70) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 01 Jan 2020 06:52:10 +0000
Received: from localhost.localdomain (ntsitm247158.sitm.nt.ngn.ppp.infoweb.ne.jp [124.27.253.158]) (authenticated)	by conuserg-03.nifty.com with ESMTP id 0016pYwV003396;	Wed, 1 Jan 2020 15:51:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-03.nifty.com 0016pYwV003396
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1577861501;	bh=b9c1BIMKMnyvUsFMbwZM6sVh12D52SfjWVt8fsHRcJs=;	h=From:To:Cc:Subject:Date:From;	b=m0zfZyAwAvdzcn9zLBxNsriaLe2uUHaHlQTXQi/HLKsPC0NiWyPsXbVNUntpHYUIn	 ugUbTYZK3XrcdhB/OZW5uPs/wJntlt971uogv0Bp4ySRxl7CBBFz2F5fXRUYBXZd0R	 VFr+h7ezGYcycG8h8LCHQcQPMrAblSE8uag+CWywLJvXNg2Xtrj0gSIliG1U/ugXVQ	 QMglb3stzTuOBYCCEllz8CoFFBU+1tbPz8oIzM0u7X9BAitp8fj7p7W4zgpFjfZQ8L	 L4csdQjQcNVUC3GFi8e1yQPb8zB9ks7vk1dsjX2ZsrLBkPneFBySAWBZyaTvMwdwcb	 Dvw/+ViMuwGUQ==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: console: Disable xterm mode for non cygwin process only.
Date: Wed, 01 Jan 2020 06:52:00 -0000
Message-Id: <20200101065128.8897-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00004.txt

- Special function keys such as arrow keys or function keys do not
  work in ConEmu with cygwin-connector after commit
  6a06c6bc8f8492ea09aa3ae180fe94e4ac265611. This patch fixes the
  issue.
---
 winsup/cygwin/fhandler_console.cc |  8 --------
 winsup/cygwin/spawn.cc            | 29 ++++++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index b3095bbe3..e4e21e65e 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -2973,14 +2973,6 @@ fhandler_console::fixup_after_fork_exec (bool execing)
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
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index cea79e326..efd82c3c2 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -29,6 +29,14 @@ details. */
 #include "winf.h"
 #include "ntdll.h"
 
+/* Not yet defined in Mingw-w64 */
+#ifndef ENABLE_VIRTUAL_TERMINAL_PROCESSING
+#define ENABLE_VIRTUAL_TERMINAL_PROCESSING 0x0004
+#endif /* ENABLE_VIRTUAL_TERMINAL_PROCESSING */
+#ifndef ENABLE_VIRTUAL_TERMINAL_INPUT
+#define ENABLE_VIRTUAL_TERMINAL_INPUT 0x0200
+#endif /* ENABLE_VIRTUAL_TERMINAL_INPUT */
+
 static const suffix_info exe_suffixes[] =
 {
   suffix_info ("", 1),
@@ -610,7 +618,26 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
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
-- 
2.21.0
