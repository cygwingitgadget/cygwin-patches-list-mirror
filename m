Return-Path: <cygwin-patches-return-10051-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 100901 invoked by alias); 9 Feb 2020 14:47:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 100880 invoked by uid 89); 9 Feb 2020 14:47:46 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: conuserg-02.nifty.com
Received: from conuserg-02.nifty.com (HELO conuserg-02.nifty.com) (210.131.2.69) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 09 Feb 2020 14:47:44 +0000
Received: from localhost.localdomain (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conuserg-02.nifty.com with ESMTP id 019ElVr5010129;	Sun, 9 Feb 2020 23:47:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-02.nifty.com 019ElVr5010129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1581259659;	bh=pzIUPXKoneaNKO8bNjTg5M9u0htWHzMvMGT/4XffSU0=;	h=From:To:Cc:Subject:Date:From;	b=ykTICCYv0xEqwHv8L3UIIk1bIIxoNBvUqFaTWwU+flC09mf0edh3VTaxcjxf8sc1f	 bvPfyD7Y3nASduQ9Wk9S3zOkwRjZ/jFZ8y/UgEbYp76soOlh7zuFYu0Gh7akS12wo7	 h8hlm4ZdhyLOZ7aTMHleTsEq8tm+cK+MXRalTm8tzpbFFRLF1fQiTnHqkWGX+s4518	 85tucV8R69CW/cRVKnyZkBSvoDhRZjFihcYXwtp/KepZhJ0kOgi+62pSaEyPe1XlAr	 PBDewMVqR9ACodg59ArtWPN8z8TUEvr+/NQzk5z1kAfV1S1IovatY400Sa4t3ezgZn	 TMqMhlFmltMlQ==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Fix state mismatch caused in mintty.
Date: Sun, 09 Feb 2020 14:47:00 -0000
Message-Id: <20200209144730.489-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00157.txt

- PTY has a bug reported in:
  https://cygwin.com/ml/cygwin/2020-02/msg00067.html.
  This is the result of state mismatch between real pseudo console
  attaching state and state variable. This patch fixes the issue.
---
 winsup/cygwin/fhandler_tty.cc | 16 ++++++++++++++--
 winsup/cygwin/fork.cc         |  2 ++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 5df5fe752..c36730d41 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -65,6 +65,12 @@ static bool isHybrid;
 static bool do_not_reset_switch_to_pcon;
 static bool freeconsole_on_close = true;
 
+void
+clear_pcon_attached_to (void)
+{
+  pcon_attached_to = -1;
+}
+
 static void
 set_switch_to_pcon (void)
 {
@@ -727,7 +733,10 @@ fhandler_pty_slave::~fhandler_pty_slave ()
 	{
 	  init_console_handler (false);
 	  if (freeconsole_on_close)
-	    FreeConsole ();
+	    {
+	      FreeConsole ();
+	      pcon_attached_to = -1;
+	    }
 	}
     }
 }
@@ -2982,7 +2991,10 @@ fhandler_pty_slave::fixup_after_exec ()
 	{
 	  init_console_handler (false);
 	  if (freeconsole_on_close)
-	    FreeConsole ();
+	    {
+	      FreeConsole ();
+	      pcon_attached_to = -1;
+	    }
 	}
     }
 
diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
index a8f0fb82a..691d08137 100644
--- a/winsup/cygwin/fork.cc
+++ b/winsup/cygwin/fork.cc
@@ -161,6 +161,8 @@ frok::child (volatile char * volatile here)
 	      }
 	  }
       }
+  extern void clear_pcon_attached_to (void); /* fhandler_tty.cc */
+  clear_pcon_attached_to ();
 
   HANDLE& hParent = ch.parent;
 
-- 
2.21.0
