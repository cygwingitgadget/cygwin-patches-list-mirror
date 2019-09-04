Return-Path: <cygwin-patches-return-9602-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 88355 invoked by alias); 4 Sep 2019 01:46:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 88345 invoked by uid 89); 4 Sep 2019 01:46:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=inherited, Console, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-06.nifty.com
Received: from conuserg-06.nifty.com (HELO conuserg-06.nifty.com) (210.131.2.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Sep 2019 01:46:55 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-06.nifty.com with ESMTP id x841kPmX024773;	Wed, 4 Sep 2019 10:46:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-06.nifty.com x841kPmX024773
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567561596;	bh=wgtB8JuaaGiYFt7yLaJ9w/GJBKWe94kyYuyrr/WKBuc=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=O38flIUztjI/h8f7ijZehRamznm+PNVj2Db3LGsD1dcCr9pCzKqrkTI/VTd6YnhXF	 6/DlkadMPedupr+gdnNt0hRvqde1TZSGrl0sFBSr/DR8Wfzb0GY9Lqtky6m2irz/Zg	 9na3/6E4Um9kBcwYGPxzrGcKku1YQAMlVToE4I1rQw9sev1NweQUE/MmxpMTW+UZyc	 vewxtdomR+mCwn75PBJ+5a+I6mXQQpaB3AI1kjJ7JPnKBEQW9X6tVpZnbrW9ZZR+EX	 7MRe1Vo8LtXthHXPd5c6CLiJSEImLimyyiXwLKlgFFiT/M72glD0HCx3Dt0bRuDAOW	 X00ZOOvgHHPmw==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 1/2] Cygwin: pty: Add a workaround for ^C handling.
Date: Wed, 04 Sep 2019 01:46:00 -0000
Message-Id: <20190904014618.1372-2-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190904014618.1372-1-takashi.yano@nifty.ne.jp>
References: <20190904014618.1372-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00122.txt.bz2

- Pseudo console support introduced by commit
  169d65a5774acc76ce3f3feeedcbae7405aa9b57 sometimes cause random
  crash or freeze by pressing ^C while cygwin and non-cygwin
  processes are executed simultaneously in the same pty. This
  patch is a workaround for this issue.
---
 winsup/cygwin/fhandler_tty.cc | 5 +++++
 winsup/cygwin/spawn.cc        | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 240ee017c..283558985 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2846,6 +2846,9 @@ fhandler_pty_slave::fixup_after_fork (HANDLE parent)
   // fork_fixup (parent, inuse, "inuse");
   // fhandler_pty_common::fixup_after_fork (parent);
   report_tty_counts (this, "inherited", "");
+  if (getPseudoConsole ())
+    myself->ctty = 0; /* Avoid setting init_console_handler() in fork.cc.
+			 This is a workaround for ^C handling problem. */
 }
 
 void
@@ -2882,6 +2885,8 @@ fhandler_pty_slave::fixup_after_exec ()
 	  FreeConsole ();
 	}
     }
+  if (getPseudoConsole () && myself->ctty == 0)
+    myself->ctty = get_ttyp ()->ntty; /* Restore ctty */
 
 #if USE_API_HOOK
   /* Hook Console API */
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 4bb28c47b..22dafbce3 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -634,6 +634,12 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	}
       if (ptys)
 	ptys->fixup_after_attach (!iscygwin ());
+      if (attach_to_pcon && !iscygwin ())
+	{
+	  myself->ctty = 0; /* Random freezes caused by ^C can be avoided
+			       with this. */
+	  init_console_handler (true);
+	}
 
     loop:
       /* When ruid != euid we create the new process under the current original
-- 
2.21.0
