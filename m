Return-Path: <cygwin-patches-return-9642-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 95458 invoked by alias); 5 Sep 2019 13:22:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 95440 invoked by uid 89); 5 Sep 2019 13:22:54 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=screen, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-02.nifty.com
Received: from conuserg-02.nifty.com (HELO conuserg-02.nifty.com) (210.131.2.69) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 05 Sep 2019 13:22:52 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-02.nifty.com with ESMTP id x85DMT8Y017033;	Thu, 5 Sep 2019 22:22:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-02.nifty.com x85DMT8Y017033
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567689763;	bh=ET1I53AXgjeRF7YWxTePrOcP87gQveVM6uMFmoQ1FO8=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=m5QmWE3QmLkzwc/BIgSc46Uvte6N8x+rivzicj16yR3ddsBjjpHvkN82Mx5I+aS4v	 lwt0ZXQ2oLrsx5qiHZ8S27sC2xDCghe+r3IRRYbk1/UUJggLynAToGZK0VBXA8wcOx	 zIx/cmIhYU9xvATeDordpyqpnNFi3ECO7Zvyeq/GGnUdKyMbuartK1r6adP0OAAiKa	 UyWl4rb7mwPkMSFVZwFYIMuHR5l2CQIQg2ry79Lpdnxr9yd7yxMfHlXDEN+5gwWvMp	 h8LlfgmNXgjsspuFXoSu9wsRpG7DKs4DXMwFwddGNHudLEAuRlQOmdkFzndgVdil6W	 aEV1L6XNMuKmA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 1/1] Cygwin: pty: Make it sure to show up system error messages.
Date: Thu, 05 Sep 2019 13:22:00 -0000
Message-Id: <20190905132227.1967-2-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190905132227.1967-1-takashi.yano@nifty.ne.jp>
References: <20190905132227.1967-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00162.txt.bz2

- Forcibly attach to pseudo console in advance so that the error
  messages by system_printf() is displayed to screen reliably.
  This is needed when stdout is redirected to another pty. In this
  case, process has two ptys opened. However, process can attach
  to only one console. So it is necessary to change console attached.
---
 winsup/cygwin/fhandler_tty.cc | 55 +++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 6 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 78c9c9128..1a1ae1a5c 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -88,16 +88,59 @@ set_switch_to_pcon (void)
       }
 }
 
+static void
+force_attach_to_pcon (HANDLE h)
+{
+  bool attach_done = false;
+  for (int n = 0; n < 2; n ++)
+    {
+      /* First time, attach to the pty whoes handle value is match.
+	 Second time, try to attach to any pty. */
+      cygheap_fdenum cfd (false);
+      while (cfd.next () >= 0)
+	if (cfd->get_major () == DEV_PTYS_MAJOR)
+	  {
+	    fhandler_base *fh = cfd;
+	    fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
+	    if (n != 0
+		|| h == ptys->get_handle ()
+		|| h == ptys->get_output_handle ())
+	      {
+		if (fhandler_console::get_console_process_id
+				  (ptys->getHelperProcessId (), true))
+		  attach_done = true;
+		else
+		  {
+		    FreeConsole ();
+		    if (AttachConsole (ptys->getHelperProcessId ()))
+		      {
+			pcon_attached_to = ptys->get_minor ();
+			attach_done = true;
+		      }
+		    else
+		      pcon_attached_to = -1;
+		  }
+		break;
+	      }
+	  }
+      if (attach_done)
+	break;
+    }
+}
+
 void
 set_ishybrid_and_switch_to_pcon (HANDLE h)
 {
-  DWORD dummy;
-  if (!isHybrid
-      && GetFileType (h) == FILE_TYPE_CHAR
-      && GetConsoleMode (h, &dummy))
+  if (GetFileType (h) == FILE_TYPE_CHAR)
     {
-      isHybrid = true;
-      set_switch_to_pcon ();
+      force_attach_to_pcon (h);
+      DWORD dummy;
+      if (!isHybrid && (GetConsoleMode (h, &dummy)
+			|| GetLastError () != ERROR_INVALID_HANDLE))
+	{
+	  isHybrid = true;
+	  set_switch_to_pcon ();
+	}
     }
 }
 
-- 
2.21.0
