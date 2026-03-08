Return-Path: <SRS0=dH/q=BI=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id 3E0244B9DB4E
	for <cygwin-patches@cygwin.com>; Sun,  8 Mar 2026 11:19:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3E0244B9DB4E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3E0244B9DB4E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772968782; cv=none;
	b=FhseH8ITnzxZJT70FCuQKEn04erjsxr+ZuAtBZ4yZ8dGhu4v7PxJNDQQ7AeSxc/DDk5NNGgjJ5bTnAKRmCSarHxqnYvJ15zwVQBOIQ4a/eSmzUB/KSfMJ++aeFMBouxyKCpJWohid2iU140XwkK6HaiRpT9j+ZGcMuKyqjMHH2I=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772968782; c=relaxed/simple;
	bh=FMezcykB213nsnwLY7Pxh+K0GBDW+DwHDE7QaLLPWCo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=rP5+xnj6nx5u9qwNIU9FABI9OAA/JhvYqqCHzdAe2MaGHQQEhTkPV43QLh5uwhZeYyy/JbPZwxupMCzKEmyHamnZrIf1kKg9e+KQHRvZy4zTTt1Y1TcXO4CBfmxlG34z3E4lkXHKKp/HzZa2bdIPWSJ28/5A31gcsOn5j/IhCkU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3E0244B9DB4E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=MZj3jNnn
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260308111940284.LFRX.19957.HP-Z230@nifty.com>;
          Sun, 8 Mar 2026 20:19:40 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Restore nat handles in all PTY-slave instances in GDB
Date: Sun,  8 Mar 2026 20:19:21 +0900
Message-ID: <20260308111932.1380-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1772968780;
 bh=vEORHXQ1cKdYufN0OzN0rRQ8IxwKu9EuJiLmFaxg+NM=;
 h=From:To:Cc:Subject:Date;
 b=MZj3jNnngmgP9rdxXfbnkNoKNCSuCJF6PyRUmnBmn+YX6K5fUP50pwtkkaEChS73UuNV9Fyh
 1YbAovcwl0cf6JaGyyC3YXEh9PkpzzRPr1FcDzFQM6E9D2Ph8HjbeTxt8MIIXIOzLjGalaptzh
 GiP54uF2jseNmT3M6ML1/0q+r50TzuudJiTjZSPbq0dT6WagZMBaZn7xD2TNe24hGf8KoV0DIs
 IaEUDX33rjcdFDZHOO8z6GxkzIGvZ5zKe4U9kUpYIS+3Ed9No1MmIN0NRL0say2zMTWsAMiW/t
 gxy26BCToKOGPowcdyj8a3pSyDlcRZ3NPNOTvbYyaEwtqbzQ==
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,KAM_SHORT,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Fixes: 8aeb3f3e5037 ("Cygwin: pty: Make apps using console APIs be able to debug with gdb.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/pty.cc | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 2c2917525..781273688 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -1277,6 +1277,8 @@ fhandler_pty_slave::reset_switch_to_nat_pipe (void)
 	      else
 		hand_over_only (get_ttyp ());
 	      ReleaseMutex (pipe_sw_mutex);
+
+	      HANDLE input_handle_nat, output_handle_nat;
 	      if (need_restore_handles)
 		{
 		  pinfo p (get_ttyp ()->master_pid);
@@ -1284,16 +1286,15 @@ fhandler_pty_slave::reset_switch_to_nat_pipe (void)
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
@@ -1313,11 +1314,26 @@ fhandler_pty_slave::reset_switch_to_nat_pipe (void)
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
+			if (ptys->get_output_handle_nat () == orig_output_handle_nat)
+			  ptys->set_output_handle_nat (output_handle_nat);
+		      }
+		  CloseHandle (orig_input_handle_nat);
+		  CloseHandle (orig_output_handle_nat);
 		}
 	      myself->exec_dwProcessId = 0;
 	      isHybrid = false;
-- 
2.51.0

