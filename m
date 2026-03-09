Return-Path: <SRS0=g9mI=BJ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id B6C3C4BA2E0B
	for <cygwin-patches@cygwin.com>; Mon,  9 Mar 2026 07:06:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B6C3C4BA2E0B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B6C3C4BA2E0B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773040014; cv=none;
	b=wvzOsGJ71jacYjf6oVhOQcUTN6FqVy059Ijbvf07XvXyg6Jaj1FQ4BAAScalAd67pOAh3JYY0bb0691pIAJbLZNNf+817hpLA5GbCixiv10OpRVGRnWX0a+seHjiyShm1wrETHrkTFW1vNxVSQC5YiQHjVDIut+TjGxR6M7H9R8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773040014; c=relaxed/simple;
	bh=yTxOLFj99WfQrtF89SKjHK9dDcmuTlTqw+PhQbM6eo4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=qeQznwo9qMNZ2AZHP+zDgPeRacK/9bCPV+zOi1YuD23hR4OnKN5PUcj0hFovhKWQBM9JKCcTubRd6rqvLqDzr35CgZF3sZOkwrbIjMRZ5uCpS9qTuaqDsz1d4KXYl5umfcdT8gmIuvnngP5QraJdaK7Wefdn7ZGw1SC0Zs5s5wY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B6C3C4BA2E0B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=bJbQ5doX
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260309070651882.CXYN.14880.HP-Z230@nifty.com>;
          Mon, 9 Mar 2026 16:06:51 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2] Cygwin: pty: Restore nat handles in all PTY-slave instances in GDB
Date: Mon,  9 Mar 2026 16:06:31 +0900
Message-ID: <20260309070645.5931-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773040011;
 bh=eb8GuUgiDw/eXh6polzF+2Zj3bDdQhQJ9/Brzs/eC38=;
 h=From:To:Cc:Subject:Date;
 b=bJbQ5doXA7QaqeBWz8RDYIRsb3+QsHAFKy4UfAiz1jM72aOCfNbqRS67kLQS4/6eMJZhrkGa
 7F1LhZ9z8c4qHGqE5tR2iFVCq3LTMGgJchDbqm6ZheoxvL1u6qjCbGDM616m3ClbcgAM1uH+75
 uSGsFbnlJzXns9hckf+cOCWcnkJ34tfmmrS1TrJCNE+tCSEYQVi8mczqTI6022TALSy7bKHyp7
 GlizU/qFpmVCi3vhSbhX7Y1ZEVs+qSFrSiw3WjIJ/vaLB3Oa1qQmq8BTKBosQobXlz8h0ECTyA
 ObUPe3jV7QyMThHgRvQn99jbtQyRn0ziVwf7S+4BkOxs/vJQ==
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,KAM_SHORT,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

If non-cygwin app is started in GDB and terminating it normally,
re-running the non-cygwin app might fail in setup_pseudoconsole().

The error is something like:

$ gdb ./winsleep
GNU gdb (GDB) (Cygwin 15.2-1) 15.2
Copyright (C) 2024 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "x86_64-pc-cygwin".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<https://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from ./winsleep...
(gdb) run
Starting program: /home/yano/winsleep
[New Thread 49324.0x14178]
[Thread 49324.0x14178 exited with code 0]
[Inferior 1 (process 49324) exited normally]
(gdb) run
Starting program: /home/yano/winsleep
      0 [] gdb 294 fhandler_pty_slave::setup_pseudoconsole: CreatePseudoConsole() failed. 00000057 80070057
                           [New Thread 86480.0xfd4]
[Thread 86480.0xfd4 exited with code 0]
[Inferior 1 (process 86480) exited normally]
(gdb)

The essential problem is lack of restoring nat handles for *ALL* the
PTY-slave instances after closing pseudo console in GDB.

Restoring handles from pseudo console handles to simple pipe handles
is not necessary in normal non-cygwin apps because pseudo console is
setup in the stub process for the non-cygwin app and the stub process
exits after the app is terminated.

However, for GDB, pseudo console is setup in GDB process in hooked
CreateProcess() because GDB does not use exec() to run an inferior
(debuggee). Therefore, after the inferior exits, nat handle must be
restored to simple pipe handles.

The current code restores only handles in the PTY-slave instance
that has called fhandler_pty_slave::reset_switch_to_nat_pipe(). If
this instance is different from the instance that will setup pseudo
console, the nat handles are not restored correctly, then call to
CreatePseudoConsole() causes error.

To solves this issue, restore nat handles in all the PTY-slave
instances to simple pipe handles when the inferior exits with this
patch.

In addition, if ctty is PTY-slave, fixup handles in it as well.

Fixes: 8aeb3f3e5037 ("Cygwin: pty: Make apps using console APIs be able to debug with gdb.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/pty.cc | 53 +++++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 9868e88e5..0717c043b 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -1118,6 +1118,8 @@ fhandler_pty_slave::reset_switch_to_nat_pipe (void)
 	      else
 		hand_over_only (get_ttyp ());
 	      ReleaseMutex (pipe_sw_mutex);
+
+	      HANDLE input_handle_nat, output_handle_nat;
 	      if (need_restore_handles)
 		{
 		  pinfo p (get_ttyp ()->master_pid);
@@ -1125,16 +1127,15 @@ fhandler_pty_slave::reset_switch_to_nat_pipe (void)
 		    OpenProcess (PROCESS_DUP_HANDLE, FALSE, p->dwProcessId);
 		  if (pty_owner)
 		    {
-		      CloseHandle (get_handle_nat ());
 		      DuplicateHandle (pty_owner,
 				       get_ttyp ()->from_master_nat (),
-				       GetCurrentProcess (), &get_handle_nat (),
+				       GetCurrentProcess (),
+				       &input_handle_nat,
 				       0, TRUE, DUPLICATE_SAME_ACCESS);
-		      CloseHandle (get_output_handle_nat ());
 		      DuplicateHandle (pty_owner,
 				       get_ttyp ()->to_master_nat (),
 				       GetCurrentProcess (),
-				       &get_output_handle_nat (),
+				       &output_handle_nat,
 				       0, TRUE, DUPLICATE_SAME_ACCESS);
 		      CloseHandle (pty_owner);
 		    }
@@ -1154,11 +1155,37 @@ fhandler_pty_slave::reset_switch_to_nat_pipe (void)
 		      CloseHandle (repl.to_master); /* not used. */
 		      CloseHandle (repl.to_slave_nat); /* not used. */
 		      CloseHandle (repl.to_slave); /* not used. */
-		      CloseHandle (get_handle_nat ());
-		      set_handle_nat (repl.from_master_nat);
-		      CloseHandle (get_output_handle_nat ());
-		      set_output_handle_nat (repl.to_master_nat);
+		      input_handle_nat = repl.from_master_nat;
+		      output_handle_nat = repl.to_master_nat;
 		    }
+
+		  /* Restore nat handles in all pty slave instances */
+		  HANDLE orig_input_handle_nat = get_handle_nat();
+		  HANDLE orig_output_handle_nat = get_output_handle_nat();
+		  cygheap_fdenum cfd (false);
+		  while (cfd.next () >= 0)
+		    if (cfd->get_device () == get_device ())
+		      {
+			fhandler_base *fh = cfd;
+			fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
+			if (ptys->get_handle_nat () == orig_input_handle_nat)
+			  ptys->set_handle_nat (input_handle_nat);
+			if (ptys->get_output_handle_nat () ==
+			    orig_output_handle_nat)
+			  ptys->set_output_handle_nat (output_handle_nat);
+		      }
+		  if (cygheap->ctty->get_device () == get_device ())
+		    {
+		      fhandler_pty_slave *ptys =
+			(fhandler_pty_slave *) cygheap->ctty;
+		      if (ptys->get_handle_nat () == orig_input_handle_nat)
+			ptys->set_handle_nat (input_handle_nat);
+		      if (ptys->get_output_handle_nat () ==
+			  orig_output_handle_nat)
+			ptys->set_output_handle_nat (output_handle_nat);
+		    }
+		  CloseHandle (orig_input_handle_nat);
+		  CloseHandle (orig_output_handle_nat);
 		}
 	      myself->exec_dwProcessId = 0;
 	      isHybrid = false;
@@ -3465,7 +3492,7 @@ fhandler_pty_slave::setup_pseudoconsole ()
 skip_create:
   do
     {
-      /* Fixup handles */
+      /* Fixup handles in all PTY-slave instances */
       HANDLE orig_input_handle_nat = get_handle_nat ();
       HANDLE orig_output_handle_nat = get_output_handle_nat ();
       cygheap_fdenum cfd (false);
@@ -3479,6 +3506,14 @@ skip_create:
 	    if (ptys->get_output_handle_nat () == orig_output_handle_nat)
 	      ptys->set_output_handle_nat (hpConOut);
 	  }
+      if (cygheap->ctty->get_device () == get_device ())
+	{
+	  fhandler_pty_slave *ptys = (fhandler_pty_slave *) cygheap->ctty;
+	  if (ptys->get_handle_nat () == orig_input_handle_nat)
+	    ptys->set_handle_nat (hpConIn);
+	  if (ptys->get_output_handle_nat () == orig_output_handle_nat)
+	    ptys->set_output_handle_nat (hpConOut);
+	}
       CloseHandle (orig_input_handle_nat);
       CloseHandle (orig_output_handle_nat);
     }
-- 
2.51.0

