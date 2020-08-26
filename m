Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id 68F53386184A
 for <cygwin-patches@cygwin.com>; Wed, 26 Aug 2020 12:00:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 68F53386184A
Received: from localhost.localdomain (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 07QBxwMI004451;
 Wed, 26 Aug 2020 21:00:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 07QBxwMI004451
X-Nifty-SrcIP: [124.155.38.192]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Disable pseudo console if TERM is dumb or not
 set.
Date: Wed, 26 Aug 2020 21:00:15 +0900
Message-Id: <20200826120015.1188-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Wed, 26 Aug 2020 12:00:31 -0000

Pseudo console generates escape sequences on execution of non-cygwin
apps.  If the terminal does not support escape sequence, output will
be garbled. This patch prevents garbled output in dumb terminal by
disabling pseudo console.
---
 winsup/cygwin/spawn.cc | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 8308bccf3..b6d58e97a 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -647,13 +647,35 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
       ZeroMemory (&si_pcon, sizeof (si_pcon));
       STARTUPINFOW *si_tmp = &si;
       if (!iscygwin () && ptys_primary && is_console_app (runpath))
-	if (ptys_primary->setup_pseudoconsole (&si_pcon,
-			     mode != _P_OVERLAY && mode != _P_WAIT))
-	  {
-	    c_flags |= EXTENDED_STARTUPINFO_PRESENT;
-	    si_tmp = &si_pcon.StartupInfo;
-	    enable_pcon = true;
-	  }
+	{
+	  bool nopcon = mode != _P_OVERLAY && mode != _P_WAIT;
+	  /* If TERM is "dumb" or not set, disable pseudo console */
+	  if (envblock)
+	    {
+	      bool term_is_set = false;
+	      for (PWCHAR p = envblock; *p != L'\0'; p += wcslen (p) + 1)
+		{
+		  if (wcscmp (p, L"TERM=dumb") == 0)
+		    nopcon = true;
+		  if (wcsncmp (p, L"TERM=", 5) == 0)
+		    term_is_set = true;
+		}
+	      if (!term_is_set)
+		nopcon = true;
+	    }
+	  else
+	    {
+	      const char *term = getenv ("TERM");
+	      if (!term || strcmp (term, "dumb") == 0)
+		nopcon = true;
+	    }
+	  if (ptys_primary->setup_pseudoconsole (&si_pcon, nopcon))
+	    {
+	      c_flags |= EXTENDED_STARTUPINFO_PRESENT;
+	      si_tmp = &si_pcon.StartupInfo;
+	      enable_pcon = true;
+	    }
+	}
 
     loop:
       /* When ruid != euid we create the new process under the current original
-- 
2.28.0

