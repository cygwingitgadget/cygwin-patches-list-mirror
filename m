Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 by sourceware.org (Postfix) with ESMTPS id BF4C03858C20
 for <cygwin-patches@cygwin.com>; Fri,  4 Mar 2022 11:06:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org BF4C03858C20
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 224B64YR017871;
 Fri, 4 Mar 2022 20:06:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 224B64YR017871
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1646391995;
 bh=l1eBN+5NMZmLP/BaNObpRW1U3VIlqx8AQmS1jsuGMMs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=h8/DyU7dp+ipliyI8lH6hw2sbyX3YH/BzC+E1mtLgKO8et4+/zUAOX7mY2Vb7HkBF
 6NzmlNiwUPKQ+s4jeQp2AegP7zTIp/bEU0fxm18NgU7eEieG/269qs+Ob/3EbNJZy3
 YUDUUvVMPyCyo7tKtQyg8ZJdXJ2rCLllp2MbLyN+BR5dYDFocKXTfBxF5qbrRUs9Ub
 WS88GFiMXiNQyNKEPAVtriOuRkiXm+bnq9azpJbF4NpynkD+wsLG18tkh+bIF+Rdco
 3xzzT42vGpz0UpQIAn5shYz7AJQ+psdLP46zdHXvyg6KtzolMQgTlEl26nMNfmojEN
 daeTbmKgIXaIA==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Omit transfer_input() call where it is no longer
 needed.
Date: Fri,  4 Mar 2022 20:05:56 +0900
Message-Id: <20220304110556.2139-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304110556.2139-1-takashi.yano@nifty.ne.jp>
References: <20220304110556.2139-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Fri, 04 Mar 2022 11:06:53 -0000

- This patch removes the old code which calls transfer_input() but
  is no longer needed. These code was necessary indeed in the past,
  however, as a result of recent frequent code changes, it is no
  longer needed.
---
 winsup/cygwin/fhandler_tty.cc | 47 -----------------------------------
 1 file changed, 47 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 76c5e2413..a0a5a70ba 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1216,56 +1216,9 @@ fhandler_pty_slave::reset_switch_to_nat_pipe (void)
       && process_alive (get_ttyp ()->nat_pipe_owner_pid))
     {
       /* There is a process which owns nat pipe. */
-      if (!to_be_read_from_nat_pipe ()
-	  && get_ttyp ()->pty_input_state_eq (tty::to_nat))
-	{
-	  if (get_ttyp ()->pcon_activated)
-	    {
-	      HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
-					   get_ttyp ()->nat_pipe_owner_pid);
-	      if (pcon_owner)
-		{
-		  HANDLE h_pcon_in;
-		  DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
-				   GetCurrentProcess (), &h_pcon_in,
-				   0, TRUE, DUPLICATE_SAME_ACCESS);
-		  DWORD target_pid = get_ttyp ()->nat_pipe_owner_pid;
-		  DWORD resume_pid = attach_console_temporarily (target_pid);
-		  WaitForSingleObject (input_mutex, mutex_timeout);
-		  transfer_input (tty::to_cyg, h_pcon_in, get_ttyp (),
-				  input_available_event);
-		  ReleaseMutex (input_mutex);
-		  resume_from_temporarily_attach (resume_pid);
-		  CloseHandle (h_pcon_in);
-		  CloseHandle (pcon_owner);
-		}
-	    }
-	  else if (!get_ttyp ()->nat_fg (get_ttyp ()->getpgid ())
-		   && get_ttyp ()->switch_to_nat_pipe)
-	    {
-	      WaitForSingleObject (input_mutex, mutex_timeout);
-	      acquire_attach_mutex (mutex_timeout);
-	      transfer_input (tty::to_cyg, get_handle_nat (), get_ttyp (),
-			      input_available_event);
-	      release_attach_mutex ();
-	      ReleaseMutex (input_mutex);
-	    }
-	}
       ReleaseMutex (pipe_sw_mutex);
       return;
     }
-  /* This input transfer is needed if non-cygwin app is terminated
-     by Ctrl-C or killed. */
-  WaitForSingleObject (input_mutex, mutex_timeout);
-  if (get_ttyp ()->switch_to_nat_pipe && !get_ttyp ()->pcon_activated
-      && get_ttyp ()->pty_input_state_eq (tty::to_nat))
-    {
-      acquire_attach_mutex (mutex_timeout);
-      transfer_input (tty::to_cyg, get_handle_nat (), get_ttyp (),
-		      input_available_event);
-      release_attach_mutex ();
-    }
-  ReleaseMutex (input_mutex);
   /* Clean up nat pipe state */
   get_ttyp ()->pty_input_state = tty::to_cyg;
   get_ttyp ()->nat_pipe_owner_pid = 0;
-- 
2.35.1

