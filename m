Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id 10E9F385842F
 for <cygwin-patches@cygwin.com>; Wed, 23 Feb 2022 17:47:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 10E9F385842F
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 21NHlXs3016976;
 Thu, 24 Feb 2022 02:47:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 21NHlXs3016976
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1645638458;
 bh=NJ83TrOg5k3VL95pXCS4vgkvGdzMF6USpoLXosBWDu8=;
 h=From:To:Cc:Subject:Date:From;
 b=uzzDDK5O1LloxxS0TIGwxwTAZcy7Bcw0nbZbf30XGmzouaWctHAfllVi93VX7lbn5
 s13C7MaDuoKaOoW2+eE0Sk6g+3/q4LvwDvNvwDN67+V3VbwhwyxqplmfO0ciFYQ3Br
 dqlMz+n2c1nZkP5TOkxUgsYBAsBmjExlPSZLlGjlKvZUrBLe6qa38v/11oWb2apEYY
 YS3LuspzlN2pHE3m19qdDsIvni399Fa3iMW5DZkf5ddtUe1hk7HZWW/gNbfi01VZIY
 D+pmLGtR+tl2pTF80Ihqp/L5Pwc4hr0+VKIyUeBsg2dOeYpBA1jyMXiD8TgATrlTf1
 c1uKNHGZwoZew==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty,
 console: Add a workaround for GDB SIGINT handling.
Date: Thu, 24 Feb 2022 02:47:28 +0900
Message-Id: <20220223174728.35908-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP,
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
X-List-Received-Date: Wed, 23 Feb 2022 17:47:53 -0000

- The inferior of the GDB cannot be continued after SIGINT even
  though nopass option is set. This seems because cygwin GDB does
  not support hooking cygwin signal. Therefore, a workaround for
  GDB is added. With this patch, only CTRL_C_EVENT is sent to the
  GDB inferior by Ctrl-C and sending SIGINT is omitted. Note that
  "handle SIGINT (no)pass" command does not take effect even with
  or without this patch.
---
 winsup/cygwin/fhandler.h          |  3 ++-
 winsup/cygwin/fhandler_console.cc |  1 +
 winsup/cygwin/fhandler_termios.cc | 29 ++++++++++++++++++++++++++++-
 winsup/cygwin/fhandler_tty.cc     |  9 ++++++++-
 4 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index b252b6e1c..7ddf7e450 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1906,7 +1906,8 @@ class fhandler_termios: public fhandler_base
     signalled,
     not_signalled,
     not_signalled_but_done,
-    not_signalled_with_nat_reader
+    not_signalled_with_nat_reader,
+    done_with_debugger
   };
 
  public:
diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index a7516f238..b290cde08 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -251,6 +251,7 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 		{
 		case signalled:
 		case not_signalled_but_done:
+		case done_with_debugger:
 		  processed = true;
 		  ttyp->output_stopped = false;
 		  if (ti.c_lflag & NOFLSH)
diff --git a/winsup/cygwin/fhandler_termios.cc b/winsup/cygwin/fhandler_termios.cc
index 953aeade0..383e20764 100644
--- a/winsup/cygwin/fhandler_termios.cc
+++ b/winsup/cygwin/fhandler_termios.cc
@@ -315,12 +315,16 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
   termios &ti = ttyp->ti;
   pid_t pgid = ttyp->pgid;
 
+  pinfo leader (pgid);
+  bool cyg_leader = leader && !(leader->process_state & PID_NOTCYGWIN);
   bool ctrl_c_event_sent = false;
   bool need_discard_input = false;
   bool pg_with_nat = false;
   bool need_send_sig = false;
   bool nat_shell = false;
   bool cyg_reader = false;
+  bool with_debugger = false;
+  bool with_debugger_nat = false;
 
   winpids pids ((DWORD) 0);
   for (unsigned i = 0; i < pids.npids; i++)
@@ -328,6 +332,7 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
       _pinfo *p = pids[i];
       if (c == '\003' && p && p->ctty == ttyp->ntty && p->pgid == pgid
 	  && ((p->process_state & PID_NOTCYGWIN)
+	      || (p->process_state & PID_NEW_PG)
 	      || !(p->process_state & PID_CYGPARENT)))
 	{
 	  pinfo pinfo_resume = pinfo (myself->ppid);
@@ -350,7 +355,8 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
 	  /* CTRL_C_EVENT does not work for the process started with
 	     CREATE_NEW_PROCESS_GROUP flag, so send CTRL_BREAK_EVENT
 	     instead. */
-	  if (p->process_state & PID_NEW_PG)
+	  if ((p->process_state & PID_NEW_PG)
+	      && (p->process_state & PID_NOTCYGWIN))
 	    {
 	      GenerateConsoleCtrlEvent (CTRL_BREAK_EVENT,
 					p->dwProcessId);
@@ -378,8 +384,28 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
 	    nat_shell = true;
 	  if (p->process_state & PID_TTYIN)
 	    cyg_reader = true;
+	  if (!p->cygstarted && !(p->process_state & PID_NOTCYGWIN)
+	      && (p != myself || being_debugged ())
+	      && cyg_leader) /* inferior is cygwin app */
+	    with_debugger = true;
+	  if (!(p->process_state & PID_NOTCYGWIN)
+	      && (p->process_state & PID_NEW_PG) /* Check marker */
+	      && p->pid == pgid) /* inferior is non-cygwin app */
+	    with_debugger_nat = true;
 	}
     }
+  if ((with_debugger || with_debugger_nat) && need_discard_input)
+    {
+      if (!(ti.c_lflag & NOFLSH) && fh)
+	{
+	  fh->eat_readahead (-1);
+	  fh->discard_input ();
+	}
+      ti.c_lflag &= ~FLUSHO;
+      return done_with_debugger;
+    }
+  if (with_debugger_nat)
+    return not_signalled;
   /* Send SIGQUIT to non-cygwin process. */
   if ((ti.c_lflag & ISIG) && CCEQ (ti.c_cc[VQUIT], c)
       && pg_with_nat && need_send_sig && !nat_shell)
@@ -491,6 +517,7 @@ fhandler_termios::line_edit (const char *rptr, size_t nread, termios& ti,
 	  sawsig = true;
 	  fallthrough;
 	case not_signalled_but_done:
+	case done_with_debugger:
 	  get_ttyp ()->output_stopped = false;
 	  continue;
 	case not_signalled_with_nat_reader:
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index b9549bba9..4aafe08fa 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2293,7 +2293,14 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 
       for (size_t i = 0; i < nlen; i++)
 	{
-	  fhandler_termios::process_sigs (buf[i], get_ttyp (), this);
+	  process_sig_state r = process_sigs (buf[i], get_ttyp (), this);
+	  if (r == done_with_debugger)
+	    {
+	      for (size_t j = i; j < nlen - 1; j++)
+		buf[j] = buf[j + 1];
+	      nlen--;
+	      i--;
+	    }
 	  process_stop_start (buf[i], get_ttyp (), true);
 	}
 
-- 
2.35.1

