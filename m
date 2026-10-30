Return-Path: <SRS0=PQXH=IU=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id E12504BA23C3
	for <cygwin-patches@cygwin.com>; Fri, 30 Oct 2026 14:10:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E12504BA23C3
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E12504BA23C3
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1793369445; cv=none;
	b=PuitRk5e+cihgGqkI5tXFp33XRDYO+U/7yoFezX+YgFAhpMGNAZ78a5P5mJNGM4yny9Dok711I501JEnmvRIEU7RHo/S7l1tx64OVkd4OpLxjedmXv4HRk6vHdwWrEmLkNHMmQIs+8aPJ4ND76A//NenS9aj9kziKRM8MjRGSwk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1793369445; c=relaxed/simple;
	bh=irzlDeSRcWOSshOESJO9i4st3YU8qzEoPzScj5TQ9oI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=pWq/ygWxFhN23bHszDSulHpfLVWeSUHXA4v/KoTRHkF8b+ChlmhFuNE8fv0XmCv8ot6BeFJsnpl01jW6E7wKSQjJWME3qMPPn6C5ZRnvd+kfFOejENUq5NWnnbyfnBPtNgifyNbsLwh2Ts6CxqZSTETef2FYnMY3qWppmi3mQgA=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ayYIN16g
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E12504BA23C3
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ayYIN16g
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20261030141041920.PTJD.17441.HP-Z230@nifty.com>;
          Fri, 30 Oct 2026 23:10:41 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Do not use terminfo to determine the terminal capability
Date: Fri, 30 Oct 2026 23:10:24 +0900
Message-ID: <20261030141034.11993-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1793369441;
 bh=xbIxvbOjYqJSMKjUQwV37dogs3YxHFuHKUs+2PTJIwA=;
 h=From:To:Cc:Subject:Date;
 b=ayYIN16ggwup9Jvev8u3s/zkU25gd6gaMUHtqig6Shs7ey4xLj3OQOCBKn4spZ0WkSJ+iIP/
 Dm/LEWNE8l8pq5SFH4J8XN+cmoIxTKoFdm1Z3e7DZP3qL0GVn+Sc0AWc/qUFPN5svoe1A/yXHY
 b3lU4NMkFOKTBDZm01myzfuk12I6R1zfkXKJ5PpjUgNIWDCxMuGJAajj3sCaGRAu+5/SbLBTJS
 8ut/oCR54gOeKUZMTss9dgvRIGi88XfI4luaDFonpjWSuizwnWqqi/KMNJFyfuCU/lF/HCbfm3
 JXajw3PIJ/jCwOJIUoy/Ux4wHl/i9uyqxjofXYhshrYnr3QA==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently, pty checks whether the terminal has ANSI escape sequences
support which is needed by pseudo console using terminfo. If not, pty
does not start psuedo console. However, it does not seem natural for
a POSIX emulation layer to refer to terminfo. This patch disables
terminfo lookups and relying solely on checking the CSI6n responce
with a timeout.

Fixes: 4e08fe42c9f3 ("Cygwin: pty: Disable pseudo console if TERM does not have CSI6n.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:

---
 winsup/cygwin/fhandler/pty.cc | 76 +----------------------------------
 1 file changed, 2 insertions(+), 74 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 6d0183f5d..39525bd08 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -4274,75 +4274,6 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
     }
 }
 
-static bool
-has_ansi_escape_sequences (const WCHAR *env)
-{
-  /* Retrieve TERM name */
-  const char *term = NULL;
-  char term_str[260];
-  if (env)
-    {
-    for (const WCHAR *p = env; *p != L'\0'; p += wcslen (p) + 1)
-      if (swscanf (p, L"TERM=%236s", term_str) == 1)
-	{
-	  term = term_str;
-	  break;
-	}
-    }
-  else
-    term = getenv ("TERM");
-
-  if (!term)
-    return false;
-
-  /* If cursor_home is not "\033[H", terminal is not supposed to
-     support ANSI escape sequences. */
-  char tinfo[260];
-  __small_sprintf (tinfo, "/usr/share/terminfo/%02x/%s", term[0], term);
-  path_conv path (tinfo);
-  WCHAR wtinfo[260];
-  path.get_wide_win32_path (wtinfo);
-  HANDLE h;
-  h = CreateFileW (wtinfo, GENERIC_READ, FILE_SHARE_READ,
-		   NULL, OPEN_EXISTING, 0, NULL);
-  if (h == NULL)
-    return false;
-  char terminfo[4096];
-  DWORD n;
-  ReadFile (h, terminfo, sizeof (terminfo), &n, 0);
-  CloseHandle (h);
-
-  int num_size = 2;
-  if (*(int16_t *)terminfo == 01036 /* MAGIC2 */)
-    num_size = 4;
-  const int name_pos = 12; /* Position of terminal name */
-  const int name_size = *(int16_t *) (terminfo + 2);
-  const int bool_count = *(int16_t *) (terminfo + 4);
-  const int num_count = *(int16_t *) (terminfo + 6);
-  const int str_count = *(int16_t *) (terminfo + 8);
-  const int str_size = *(int16_t *) (terminfo + 10);
-  const int cursor_home = 12; /* cursor_home entry index */
-  if (cursor_home >= str_count)
-    return false;
-  int str_idx_pos = name_pos + name_size + bool_count + num_size * num_count;
-  if (str_idx_pos & 1)
-    str_idx_pos ++;
-  const int16_t *str_idx = (int16_t *) (terminfo + str_idx_pos);
-  const char *str_table = (const char *) (str_idx + str_count);
-  if (str_idx + cursor_home >= (int16_t *) (terminfo + n))
-    return false;
-  if (str_idx[cursor_home] == -1)
-    return false;
-  const char *cursor_home_str = str_table + str_idx[cursor_home];
-  if (cursor_home_str >= str_table + str_size)
-    return false;
-  if (cursor_home_str >= terminfo + n)
-    return false;
-  if (strcmp (cursor_home_str, "\033[H") != 0)
-    return false;
-  return true;
-}
-
 bool
 fhandler_pty_slave::term_has_pcon_cap (const WCHAR *env)
 {
@@ -4355,10 +4286,6 @@ fhandler_pty_slave::term_has_pcon_cap (const WCHAR *env)
   int len;
   int wait_cnt = 0;
 
-  /* Check if terminal has ANSI escape sequence. */
-  if (!has_ansi_escape_sequences (env))
-    goto maybe_dumb;
-
   /* Check if terminal has CSI6n */
   WaitForSingleObject (input_mutex, mutex_timeout);
   /* Set pcon_activated and pcon_start so that the response
@@ -4410,7 +4337,8 @@ not_has_csi6n:
   get_ttyp ()->pcon_start = false;
   get_ttyp ()->pcon_activated = false;
   ReleaseMutex (input_mutex);
-maybe_dumb:
+  for (int i = 0; i < 4; i++)
+    WriteFile (get_output_handle (), "\b \b", 3, &n, NULL);
   get_ttyp ()->pcon_cap_checked = true;
   return false;
 }
-- 
2.51.0

