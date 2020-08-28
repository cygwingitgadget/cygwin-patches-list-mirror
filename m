Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id CCF9D3857023
 for <cygwin-patches@cygwin.com>; Fri, 28 Aug 2020 19:30:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org CCF9D3857023
Received: from localhost.localdomain (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 07SJTSKN029278;
 Sat, 29 Aug 2020 04:29:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 07SJTSKN029278
X-Nifty-SrcIP: [124.155.38.192]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2] Cygwin: pty: Disable pseudo console if TERM is dumb or not
 set.
Date: Sat, 29 Aug 2020 04:29:21 +0900
Message-Id: <20200828192921.127-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Fri, 28 Aug 2020 19:30:06 -0000

- Pseudo console internally sends escape sequence CSI6n (query cursor
  position) on startup of non-cygwin apps. If the terminal does not
  support CSI6n, CreateProcess() hangs waiting for response. This
  patch prevents hang in dumb terminal by disabling pseudo console.
---
 winsup/cygwin/fhandler.h      |  1 +
 winsup/cygwin/fhandler_tty.cc | 24 ++++++++++++++++++++++++
 winsup/cygwin/spawn.cc        | 18 +++++++++++-------
 3 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 9fd95c098..b4ba9428a 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2332,6 +2332,7 @@ class fhandler_pty_slave: public fhandler_pty_common
   }
   bool setup_pseudoconsole (STARTUPINFOEXW *si, bool nopcon);
   void close_pseudoconsole (void);
+  bool term_has_pcon_cap (const WCHAR *env);
   void set_switch_to_pcon (void);
   void reset_switch_to_pcon (void);
   void mask_switch_to_pcon_in (bool mask);
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 0865c1fac..a52319851 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2659,3 +2659,27 @@ fhandler_pty_slave::close_pseudoconsole (void)
       get_ttyp ()->pcon_start = false;
     }
 }
+
+bool
+fhandler_pty_slave::term_has_pcon_cap (const WCHAR *env)
+{
+  bool has_pcon_cap = false;
+  if (env)
+    for (const WCHAR *p = env; *p != L'\0'; p += wcslen (p) + 1)
+      {
+	if (wcscmp (p, L"TERM=dumb") == 0)
+	  break;
+	else if (wcsncmp (p, L"TERM=", 5) == 0)
+	  {
+	    has_pcon_cap = true;
+	    break;
+	  }
+      }
+  else
+    {
+      const char *term = getenv ("TERM");
+      if (term && strcmp (term, "dumb") != 0)
+	has_pcon_cap = true;
+    }
+  return has_pcon_cap;
+}
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index a2f7697d7..92d190d1a 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -647,13 +647,17 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
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
+	  if (!ptys_primary->term_has_pcon_cap (envblock))
+	    nopcon = true;
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

