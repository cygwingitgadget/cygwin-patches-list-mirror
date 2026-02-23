Return-Path: <SRS0=vXQ3=A3=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e01.mail.nifty.com (mta-snd-e01.mail.nifty.com [106.153.226.33])
	by sourceware.org (Postfix) with ESMTPS id 3BF3C4BA23DD
	for <cygwin-patches@cygwin.com>; Mon, 23 Feb 2026 08:02:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3BF3C4BA23DD
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3BF3C4BA23DD
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.33
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1771833731; cv=none;
	b=TLJytTRCKzgalSgvqJGZILJi+NCbHc8NsjuO3PJGb27GMuwbCyN+dHjFxAz1g7Yd62kk0r1yCiflbxBcTy2qVmS4g9Z2RZoRDUERJ9QcnfBDcTZb/60kwxSne7o5rZ1431B3uipj8x6OZpjufcTHVvTBVlkYCtybRc3f+Jc3k3s=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1771833731; c=relaxed/simple;
	bh=silDUgOQLkK23pHd6FfdZiO6ZmPR8E8L0hSHZgOnFO0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=fMz8dx3ke5MLY2FBnuf4Lz+TPQgQGW6S/OHKdC4LGPBLH6Ri9SVkjYPVQtoQNA8qj9SIX2O0OXHwrjosuSUFsn915HT4GBkwr1QQOT5961Xo6Eg8OW16HqGJ1k2iA8QobI9ORn6Y0We3kEFkINIc3Y0E9nEmpI7pytfHVSWcNxQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3BF3C4BA23DD
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Ab+9cGeW
Received: from HP-Z230 by mta-snd-e01.mail.nifty.com with ESMTP
          id <20260223080208147.UFUA.48098.HP-Z230@nifty.com>;
          Mon, 23 Feb 2026 17:02:08 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v3 2/4] Cygwin: pty: Update workaround for rlwrap for pseudo console
Date: Mon, 23 Feb 2026 17:01:28 +0900
Message-ID: <20260223080141.340-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260223080141.340-1-takashi.yano@nifty.ne.jp>
References: <20260223080141.340-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1771833728;
 bh=nDSZ2WWowBofJBbJWG8qN7fakz+a+lxwLHF4L7fEsaw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Ab+9cGeWQfAFZnYZbKt1HB7rUwOpMQ3iYH3ie5QDovGEkPdbXTkH1eohI0KEJFYbkc35qTZh
 U9MIW6wnZN+7ObWbiJnZhXnYwDTAFUkg7/ZQDZMOdbuUX+Jkv/0NYQhuVsWn07AEsBPbCICORc
 SRPAFqGhPJ6UA6BHd2eldnAjcu5hW4pplVIjS7fpS+QmyjWNvfFVLQUh826L1GBuSEhycSwwzb
 5Esn/39Glz4/gBKWEovUiZgAUCsdCdLYQTXWDDFIsTqlDrTQdzyN9pru00ZLXjsbNnpYb7pq+e
 cuxutb1MlpM9Kbe8OKsBsLGdvx4YUWX6yhERTT+RY9vTqclA==
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

In tcgetattr(), the conventional workaround for rlwrap v0.40 or later
is not work as expected with OpenConsole.exe for some reason. This
patch update the workaround so that it works even with OpenConsole.exe
by rebuilding tcgetattr responce reffering the corrent console mode
instead of just overriding it depends on pseudo console setting up
state.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/pty.cc | 86 ++++++++++++++++++++++++++++-------
 1 file changed, 70 insertions(+), 16 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 576f11dea..b9ca5658d 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -1738,18 +1738,48 @@ fhandler_pty_slave::tcgetattr (struct termios *t)
 {
   *t = get_ttyp ()->ti;
 
-  /* Workaround for rlwrap */
-  cygheap_fdenum cfd (false);
-  while (cfd.next () >= 0)
-    if (cfd->get_major () == DEV_PTYM_MAJOR
-	&& cfd->get_minor () == get_minor ())
-      {
-	if (get_ttyp ()->pcon_start)
-	  t->c_lflag &= ~(ICANON | ECHO);
-	if (get_ttyp ()->pcon_activated)
-	  t->c_iflag &= ~ICRNL;
-	break;
-      }
+  /* Conventional workaround for rlwrap v0.40 or later is not work
+     as expected with OpenConsole.exe for some reason. The following
+     workaround is perhaps better solution even for apps other than
+     rlwrap under pcon_activated mode. */
+  if (get_ttyp ()->pcon_activated)
+    {
+      DWORD mode = ENABLE_LINE_INPUT | ENABLE_ECHO_INPUT;
+      t->c_lflag &= ~(ICANON | ECHO);
+      t->c_iflag &= ~ICRNL;
+      cygheap_fdenum cfd (false);
+      while (cfd.next () >= 0)
+	if (cfd->get_major () == DEV_PTYM_MAJOR
+	    && cfd->get_minor () == get_minor ())
+	  {
+	    if (nat_pipe_owner_self (get_ttyp ()->nat_pipe_owner_pid))
+	      {
+		DWORD resume_pid =
+		  attach_console_temporarily (get_ttyp()->nat_pipe_owner_pid);
+		GetConsoleMode (get_ttyp ()->h_pcon_in, &mode);
+		resume_from_temporarily_attach (resume_pid);
+		break;
+	      }
+	    HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
+					     get_ttyp ()->nat_pipe_owner_pid);
+	    HANDLE h_pcon_in;
+	    DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
+			     GetCurrentProcess (), &h_pcon_in,
+			     0, FALSE, DUPLICATE_SAME_ACCESS);
+	    DWORD resume_pid =
+	      attach_console_temporarily (get_ttyp()->nat_pipe_owner_pid);
+	    if (!GetConsoleMode (h_pcon_in, &mode) && get_ttyp ()->pcon_start)
+	      mode = 0;
+	    resume_from_temporarily_attach (resume_pid);
+	    CloseHandle (h_pcon_in);
+	    CloseHandle (pcon_owner);
+	    break;
+	  }
+      if (mode & ENABLE_LINE_INPUT)
+	t->c_lflag |= ICANON;
+      if (mode & ENABLE_ECHO_INPUT)
+	t->c_lflag |= ECHO;
+    }
   return 0;
 }
 
@@ -2469,11 +2499,35 @@ int
 fhandler_pty_master::tcgetattr (struct termios *t)
 {
   *t = cygwin_shared->tty[get_minor ()]->ti;
-  /* Workaround for rlwrap v0.40 or later */
-  if (get_ttyp ()->pcon_start)
-    t->c_lflag &= ~(ICANON | ECHO);
+
+  /* Conventional workaround for rlwrap v0.40 or later is not work
+     as expected with OpenConsole.exe for some reason. The following
+     workaround is perhaps better solution even for apps other than
+     rlwrap under pcon_activated mode. */
   if (get_ttyp ()->pcon_activated)
-    t->c_iflag &= ~ICRNL;
+    {
+      t->c_lflag &= ~(ICANON | ECHO);
+      t->c_iflag &= ~ICRNL;
+
+      HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
+				       get_ttyp ()->nat_pipe_owner_pid);
+      HANDLE h_pcon_in;
+      DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
+		       GetCurrentProcess (), &h_pcon_in,
+		       0, FALSE, DUPLICATE_SAME_ACCESS);
+      DWORD resume_pid =
+	attach_console_temporarily (get_ttyp()->nat_pipe_owner_pid);
+      DWORD mode = ENABLE_LINE_INPUT | ENABLE_ECHO_INPUT;
+      if (!GetConsoleMode (h_pcon_in, &mode) && get_ttyp ()->pcon_start)
+	mode = 0;
+      resume_from_temporarily_attach (resume_pid);
+      CloseHandle (h_pcon_in);
+      CloseHandle (pcon_owner);
+      if (mode & ENABLE_LINE_INPUT)
+	t->c_lflag |= ICANON;
+      if (mode & ENABLE_ECHO_INPUT)
+	t->c_lflag |= ECHO;
+    }
   return 0;
 }
 
-- 
2.51.0

