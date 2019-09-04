Return-Path: <cygwin-patches-return-9597-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 79332 invoked by alias); 4 Sep 2019 01:45:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 79143 invoked by uid 89); 4 Sep 2019 01:45:25 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=screen, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-05.nifty.com
Received: from conuserg-05.nifty.com (HELO conuserg-05.nifty.com) (210.131.2.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Sep 2019 01:45:23 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-05.nifty.com with ESMTP id x841iibD012450;	Wed, 4 Sep 2019 10:45:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-05.nifty.com x841iibD012450
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567561503;	bh=BQdjzBO+PCcCsbug5k2MJc7vmHHqTgQVNBB0yKdDmwo=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=h+h3WK6K7M62nmnN5gj6Fkqqd+z6hr5Yzq/iR9fjoY34AdXIJmLSIXkZLBR4bkksE	 R9i2pe08mggr9GkRMr4GLa29ENpqiIHedZMlzsYIC9ShNHJ1VGBupg6xoKZl1gmxAJ	 wxxusV5Y79r05G6qN0uqZtaH72YE81ydBBeIsdA3EPvKMhHSFowjj85W4rgCLvQ5nn	 ZFcmMhvhhEKZqs9YH1szLx6zvbDsdIjaPaPBfK0UXItttkcs8JTe03H912KxSIozeZ	 kZ2cLEWdk4yiU3MY232w0V2mLhzu9w4MiyPeJ3EMKaDQE2YvN5ji78Ha84yY6MxrLd	 ucNVi5fsiznnA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 1/4] Cygwin: pty: Code cleanup
Date: Wed, 04 Sep 2019 01:45:00 -0000
Message-Id: <20190904014426.1284-2-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190904014426.1284-1-takashi.yano@nifty.ne.jp>
References: <20190904014426.1284-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00117.txt.bz2

- Cleanup the code which is commented out by #if 0 regarding pseudo
  console.
- Remove #if 1 for experimental code which seems to be stable.
---
 winsup/cygwin/fhandler_tty.cc | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index dd5ab528a..4dbe96b4a 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -855,26 +855,6 @@ fhandler_pty_slave::cleanup ()
 int
 fhandler_pty_slave::close ()
 {
-#if 0
-  if (getPseudoConsole ())
-    {
-      INPUT_RECORD inp[128];
-      DWORD n;
-      PeekFunc =
-	PeekConsoleInputA_Orig ? PeekConsoleInputA_Orig : PeekConsoleInput;
-      PeekFunc (get_handle (), inp, 128, &n);
-      bool pipe_empty = true;
-      while (n-- > 0)
-	if (inp[n].EventType == KEY_EVENT && inp[n].Event.KeyEvent.bKeyDown)
-	  pipe_empty = false;
-      if (pipe_empty)
-	{
-	  /* Flush input buffer */
-	  size_t len = UINT_MAX;
-	  read (NULL, len);
-	}
-    }
-#endif
   termios_printf ("closing last open %s handle", ttyname ());
   if (inuse && !CloseHandle (inuse))
     termios_printf ("CloseHandle (inuse), %E");
@@ -1524,7 +1504,6 @@ fhandler_pty_slave::read (void *ptr, size_t& len)
 out:
   termios_printf ("%d = read(%p, %lu)", totalread, ptr, len);
   len = (size_t) totalread;
-#if 1 /* Experimenta code */
   /* Push slave read as echo to pseudo console screen buffer. */
   if (getPseudoConsole () && ptr0 && (get_ttyp ()->ti.c_lflag & ECHO))
     {
@@ -1532,7 +1511,6 @@ out:
       push_to_pcon_screenbuffer (ptr0, len);
       release_output_mutex ();
     }
-#endif
   mask_switch_to_pcon (false);
 }
 
@@ -2748,10 +2726,6 @@ restart:
   if (p)
     *p = L'-';
   LCID lcid = LocaleNameToLCID (lc, 0);
-#if 0
-  if (lcid == (LCID) -1)
-    return lcid;
-#endif
   if (!lcid && !strcmp (charset, "ASCII"))
     return 0;
 
@@ -2842,7 +2816,6 @@ fhandler_pty_slave::fixup_after_attach (bool native_maybe)
 			}
 		}
 
-#if 1 /* Experimental code */
 	      /* Clear screen to synchronize pseudo console screen buffer
 		 with real terminal. This is necessary because pseudo
 		 console screen buffer is empty at start. */
@@ -2854,7 +2827,6 @@ fhandler_pty_slave::fixup_after_attach (bool native_maybe)
 		/* Assume this is the first process using this pty slave. */
 		WriteFile (get_output_handle_cyg (),
 			   "\033[H\033[J", 6, &n, NULL);
-#endif
 
 	      pcon_attached[get_minor ()] = true;
 	      get_ttyp ()->num_pcon_attached_slaves ++;
-- 
2.21.0
