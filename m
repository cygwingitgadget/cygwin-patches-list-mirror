Return-Path: <cygwin-patches-return-9904-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 60721 invoked by alias); 10 Jan 2020 11:46:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 60707 invoked by uid 89); 10 Jan 2020 11:46:39 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*Ad:D*jp, UD:www.cygwin.com, www.cygwin.com, wwwcygwincom
X-HELO: conuserg-06.nifty.com
Received: from conuserg-06.nifty.com (HELO conuserg-06.nifty.com) (210.131.2.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 10 Jan 2020 11:46:36 +0000
Received: from localhost.localdomain (ntsitm247158.sitm.nt.ngn.ppp.infoweb.ne.jp [124.27.253.158]) (authenticated)	by conuserg-06.nifty.com with ESMTP id 00ABkRTq022812;	Fri, 10 Jan 2020 20:46:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-06.nifty.com 00ABkRTq022812
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1578656792;	bh=6rUqauc9Wk6c9jahK/xLtpjZPGqhxOzEHbo0Jx07jFU=;	h=From:To:Cc:Subject:Date:From;	b=IR7vccUR3AOQHKt7tVLTqUVYGfcdMWVFxYHTZg9TXNFe1sjqqzgLoaM9eP7Awxwx8	 Ig7Xer2WaJWgIcK3F5akVHLG10R6Q0511xzbDJyg4GE8/9BvPbeVHLDLPNKjLNnWpp	 oOQJ7oMxAsGU7XQgpMayFUQrKaa3+FYXvCncIP3Q0jx5S+A/iJqNfW/Z3Cm63XJRE+	 0oLUls5ZTe3EVytmv777jzHIjD2CaCTZkiW668ZP5sVs21+VeJapaDT5A5mVcYTlNV	 WtecjEeqcO0EC8ZIcqolBpAAcavCPSzoGj/WebehZMI3ys8xLxrcviE/bX1gQnvTB/	 AmSUN4ypGOYOQ==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Disable FreeConsole() on close for non cygwin process.
Date: Fri, 10 Jan 2020 11:46:00 -0000
Message-Id: <20200110114626.388-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00010.txt

- After commit e1a0775dc0545b5f9c81b09a327fc110c538b7b4, the problem
  reported in https://www.cygwin.com/ml/cygwin/2020-01/msg00093.html
  occurs. For Gnu scren and tmux, calling FreeConsole() on pty close
  is necessary. However, if FreeConsole() is called, cygwin setup
  with '-h' option does not work. Therefore, the commit
  e1a0775dc0545b5f9c81b09a327fc110c538b7b4 delayed closing pty.
  This is the cause of the problem above. Now, instead of delaying
  pty close, FreeConsole() is not called if the process is non cygwin
  processes such as cygwin setup.
---
 winsup/cygwin/fhandler.h      |  1 +
 winsup/cygwin/fhandler_tty.cc | 13 +++++++++++--
 winsup/cygwin/spawn.cc        |  6 ++++--
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 4a71c1628..c0d56b4da 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2200,6 +2200,7 @@ class fhandler_pty_slave: public fhandler_pty_common
     return get_ttyp ()->ti.c_lflag & ICANON;
   }
   void setup_locale (void);
+  void set_freeconsole_on_close (bool val);
 };
 
 #define __ptsname(buf, unit) __small_sprintf ((buf), "/dev/pty%d", (unit))
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index e0aa5df9f..368054beb 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -76,6 +76,7 @@ struct pipe_reply {
 static int pcon_attached_to = -1;
 static bool isHybrid;
 static bool do_not_reset_switch_to_pcon;
+static bool freeconsole_on_close = true;
 
 #if USE_API_HOOK
 static void
@@ -735,7 +736,8 @@ fhandler_pty_slave::~fhandler_pty_slave ()
       if (used == 0)
 	{
 	  init_console_handler (false);
-	  FreeConsole ();
+	  if (freeconsole_on_close)
+	    FreeConsole ();
 	}
     }
 }
@@ -2676,6 +2678,12 @@ fhandler_pty_slave::setup_locale (void)
 	}
 }
 
+void
+fhandler_pty_slave::set_freeconsole_on_close (bool val)
+{
+  freeconsole_on_close = val;
+}
+
 void
 fhandler_pty_slave::fixup_after_attach (bool native_maybe, int fd_set)
 {
@@ -2799,7 +2807,8 @@ fhandler_pty_slave::fixup_after_exec ()
       if (used == 1 /* About to close this tty */)
 	{
 	  init_console_handler (false);
-	  FreeConsole ();
+	  if (freeconsole_on_close)
+	    FreeConsole ();
 	}
     }
 
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index efd82c3c2..aa45667c2 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -615,6 +615,8 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 			attach_to_console = true;
 		    }
 		  ptys->fixup_after_attach (!iscygwin (), fd);
+		  if (mode == _P_OVERLAY)
+		    ptys->set_freeconsole_on_close (iscygwin ());
 		}
 	    }
 	  else if (fh && fh->get_major () == DEV_CONS_MAJOR)
@@ -817,6 +819,8 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	  NtClose (old_winpid_hdl);
 	  real_path.get_wide_win32_path (myself->progname); // FIXME: race?
 	  sigproc_printf ("new process name %W", myself->progname);
+	  if (!iscygwin ())
+	    close_all_files ();
 	}
       else
 	{
@@ -915,8 +919,6 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 		wait_for_myself ();
 	    }
 	  myself.exit (EXITCODE_NOSET);
-	  if (!iscygwin ())
-	    close_all_files ();
 	  break;
 	case _P_WAIT:
 	case _P_SYSTEM:
-- 
2.21.0
