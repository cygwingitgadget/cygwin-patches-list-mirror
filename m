Return-Path: <SRS0=/go4=AY=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id 526AC4B9DB40
	for <cygwin-patches@cygwin.com>; Fri, 20 Feb 2026 17:20:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 526AC4B9DB40
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 526AC4B9DB40
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1771608008; cv=none;
	b=frd35qQkrqmj23zO12rjFlOFpRTTOhOagSTdoXGbmIRqpdp8eX6YHFl6wFQJ0+OWeJhLcImBbjUohcKB3Ci8vmZuTsX8++rSiAspDIlWCxlXpusHicvENq0FcAWMPXDtch0falFWfDBQ6nIPQ89xOPmelvgK6NKh/A1Jm1BDZXo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1771608008; c=relaxed/simple;
	bh=IrEK0fxpvEznv1hmA5SE2u3LGF2Gw2YgaNLoyqxQqj4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=E+PY7nM7HskZ2R6oGzRH6gSMKmVuWKbv1wMqBmOx2XyBOfG7ZQ1Jwdtkwi1Hi6DkdgC07Kb+MpflwzLI+K5VtdUkjrqxGg+962slFtOuEpdKFxRDXQlrpsjlh8IrhIjb1RjLpe/z2X5CNxtwCEHgULshBDxlkfuC71Vo/Ed6CQs=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 526AC4B9DB40
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=sdRswYKI
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260220172001210.HPNF.50988.HP-Z230@nifty.com>;
          Sat, 21 Feb 2026 02:20:01 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 2/4] Cygwin: pty: Update workaround for rlwrap for pseudo console
Date: Sat, 21 Feb 2026 02:19:13 +0900
Message-ID: <20260220171937.1969-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220171937.1969-1-takashi.yano@nifty.ne.jp>
References: <20260220171937.1969-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1771608001;
 bh=ggQTiIM9VEZ4meaTXUGVGIBVe/95peLwMiC7YbmX0+I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=sdRswYKIxmtFX+ygeplprhLd83CudH8nzBl6LgExGk7Wma0TOleplaqsqOUnagxk1+J0dz2x
 1JFVEUnMjJsMe0zdZprW2zS8OhAUEBSO9kJlxnnTIj2n76mUNK3FcPTElo/YUtjG9PKAXYBHht
 fZVxZPvLdea8qyOxGPSLSuq4Opkx3ldiWy1HMXEUfhhmAppP5umZld3fT0hQtDjW/Mbm4yw8Cl
 vJUJmMAeeDvWrrp+eDKa9oUSInMajfSxvRp4GP1S46WqFO/DPQ1pn3YNkMYv0uFAP4Gfu55881
 mpnia/T5Ur41R+pu1Drtnn5tUNcYlPkSTCdbbqYiXZkh0ZoA==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index a4bb53573..8963b9424 100644
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
 
@@ -2473,11 +2503,35 @@ int
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

