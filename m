Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id 873CF3950C30
 for <cygwin-patches@cygwin.com>; Mon, 31 Aug 2020 09:49:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 873CF3950C30
Received: from localhost.localdomain (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 07V9mtCd031622;
 Mon, 31 Aug 2020 18:48:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 07V9mtCd031622
X-Nifty-SrcIP: [124.155.38.192]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH v10] Cygwin: pty: Disable pseudo console if TERM does not have
 CSI6n.
Date: Mon, 31 Aug 2020 18:48:54 +0900
Message-Id: <20200831094854.725-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_BL,
 RCVD_IN_MSPIKE_L5, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Mon, 31 Aug 2020 09:49:26 -0000

- Pseudo console internally sends escape sequence CSI6n (query cursor
  position) on startup of non-cygwin apps. If the terminal does not
  support CSI6n, CreateProcess() hangs waiting for response. To prevent
  hang, this patch disables pseudo console if the terminal does not
  have CSI6n. This is checked on the first execution of non-cygwin
  app using the following steps.
    1) Check if the terminal support ANSI escape sequences by looking
       into terminfo database. If terminfo has cursor_home (ESC [H),
       the terminal is supposed to support ANSI escape sequences.
    2) If the terminal supports ANSI escape sequneces, send CSI6n for
       a test and wait for a responce for 40ms.
    3) If there is a responce within 40ms, CSI6n is supposed to be
       supported.
  Also set-title capability is checked, and removes escape sequence
  for setting window title if the terminal does not have the set-
  title capability.
---
 winsup/cygwin/fhandler.h      |   1 +
 winsup/cygwin/fhandler_tty.cc | 235 ++++++++++++++++++++++++++++++----
 winsup/cygwin/spawn.cc        |  18 ++-
 winsup/cygwin/tty.cc          |   3 +
 winsup/cygwin/tty.h           |   3 +
 5 files changed, 230 insertions(+), 30 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 9fd95c098..b4ba9428a 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2332,6 +2332,7 @@ class fhandler_pty_slave: public fhandler_pty_common
   }
   bool setup_pseudoconsole (STARTUPINFOEXW *si, bool nopcon);
   void close_pseudoconsole (void);
+  bool term_has_pcon_cap (const WCHAR *env);
   void set_switch_to_pcon (void);
   void reset_switch_to_pcon (void);
   void mask_switch_to_pcon_in (bool mask);
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 0865c1fac..5f089d3d4 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1631,33 +1631,27 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	  static char wpbuf[wpbuf_len];
 	  static int ixput = 0;
 
-	  if (ixput == 0 && buf[0] != '\033')
-	    { /* fail-safe */
-	      WriteFile (to_slave, "\033[1;1R", 6, &wLen, NULL); /* dummy */
-	      get_ttyp ()->pcon_start = false;
+	  if (ixput + nlen < wpbuf_len)
+	    {
+	      memcpy (wpbuf + ixput, buf, nlen);
+	      ixput += nlen;
 	    }
 	  else
 	    {
-	      if (ixput + nlen < wpbuf_len)
-		for (size_t i=0; i<nlen; i++)
-		  wpbuf[ixput++] = buf[i];
-	      else
-		{
-		  WriteFile (to_slave, wpbuf, ixput, &wLen, NULL);
-		  ixput = 0;
-		  get_ttyp ()->pcon_start = false;
-		  WriteFile (to_slave, buf, nlen, &wLen, NULL);
-		}
-	      if (ixput && memchr (wpbuf, 'R', ixput))
-		{
-		  WriteFile (to_slave, wpbuf, ixput, &wLen, NULL);
-		  ixput = 0;
-		  get_ttyp ()->pcon_start = false;
-		}
-	      ReleaseMutex (input_mutex);
-	      mb_str_free (buf);
-	      return len;
+	      WriteFile (to_slave, wpbuf, ixput, &wLen, NULL);
+	      ixput = 0;
+	      get_ttyp ()->pcon_start = false;
+	      WriteFile (to_slave, buf, nlen, &wLen, NULL);
 	    }
+	  if (ixput && memchr (wpbuf, 'R', ixput))
+	    {
+	      WriteFile (to_slave, wpbuf, ixput, &wLen, NULL);
+	      ixput = 0;
+	      get_ttyp ()->pcon_start = false;
+	    }
+	  ReleaseMutex (input_mutex);
+	  mb_str_free (buf);
+	  return len;
 	}
 
       WriteFile (to_slave, buf, nlen, &wLen, NULL);
@@ -2169,6 +2163,22 @@ fhandler_pty_master::pty_master_fwd_thread ()
       char *ptr = outbuf;
       if (get_ttyp ()->h_pseudo_console)
 	{
+	  if (!get_ttyp ()->has_set_title)
+	    {
+	      /* Remove Set title sequence */
+	      char *p0, *p1;
+	      p0 = outbuf;
+	      while ((p0 = (char *) memmem (p0, rlen, "\033]0;", 4)))
+		{
+		  p1 = (char *) memchr (p0, '\007', rlen - (p0 - outbuf));
+		  if (p1)
+		    {
+		      memmove (p0, p1 + 1, rlen - (p1 + 1 - outbuf));
+		      rlen -= p1 + 1 - p0;
+		      wlen = rlen;
+		    }
+		}
+	    }
 	  /* Remove CSI > Pm m */
 	  int state = 0;
 	  int start_at = 0;
@@ -2659,3 +2669,182 @@ fhandler_pty_slave::close_pseudoconsole (void)
       get_ttyp ()->pcon_start = false;
     }
 }
+
+static bool
+has_ansi_escape_sequences (const WCHAR *env)
+{
+  /* Retrieve TERM name */
+  const char *term = NULL;
+  char term_str[260];
+  if (env)
+    {
+    for (const WCHAR *p = env; *p != L'\0'; p += wcslen (p) + 1)
+      if (swscanf (p, L"TERM=%236s", term_str) == 1)
+	{
+	  term = term_str;
+	  break;
+	}
+    }
+  else
+    term = getenv ("TERM");
+
+  if (!term)
+    return false;
+
+  /* If cursor_home is not "\033[H", terminal is not supposed to
+     support ANSI escape sequences. */
+  char tinfo[260];
+  __small_sprintf (tinfo, "/usr/share/terminfo/%02x/%s", term[0], term);
+  path_conv path (tinfo);
+  WCHAR wtinfo[260];
+  path.get_wide_win32_path (wtinfo);
+  HANDLE h;
+  h = CreateFileW (wtinfo, GENERIC_READ, FILE_SHARE_READ,
+		   NULL, OPEN_EXISTING, 0, NULL);
+  if (h == NULL)
+    return false;
+  char terminfo[4096];
+  DWORD n;
+  ReadFile (h, terminfo, sizeof (terminfo), &n, 0);
+  CloseHandle (h);
+
+  int num_size = 2;
+  if (*(int16_t *)terminfo == 01036 /* MAGIC2 */)
+    num_size = 4;
+  const int name_pos = 12; /* Position of terminal name */
+  const int name_size = *(int16_t *) (terminfo + 2);
+  const int bool_count = *(int16_t *) (terminfo + 4);
+  const int num_count = *(int16_t *) (terminfo + 6);
+  const int str_count = *(int16_t *) (terminfo + 8);
+  const int str_size = *(int16_t *) (terminfo + 10);
+  const int cursor_home = 12; /* cursor_home entry index */
+  if (cursor_home >= str_count)
+    return false;
+  int str_idx_pos = name_pos + name_size + bool_count + num_size * num_count;
+  if (str_idx_pos & 1)
+    str_idx_pos ++;
+  const int16_t *str_idx = (int16_t *) (terminfo + str_idx_pos);
+  const char *str_table = (const char *) (str_idx + str_count);
+  if (str_idx + cursor_home >= (int16_t *) (terminfo + n))
+    return false;
+  if (str_idx[cursor_home] == -1)
+    return false;
+  const char *cursor_home_str = str_table + str_idx[cursor_home];
+  if (cursor_home_str >= str_table + str_size)
+    return false;
+  if (cursor_home_str >= terminfo + n)
+    return false;
+  if (strcmp (cursor_home_str, "\033[H") != 0)
+    return false;
+  return true;
+}
+
+bool
+fhandler_pty_slave::term_has_pcon_cap (const WCHAR *env)
+{
+  if (get_ttyp ()->pcon_cap_checked)
+    return get_ttyp ()->has_csi6n;
+
+  DWORD n;
+  char buf[1024];
+  char *p;
+  int len;
+  int x1, y1, x2, y2;
+  tcflag_t c_lflag;
+  DWORD t0;
+
+  /* Check if terminal has ANSI escape sequence. */
+  if (!has_ansi_escape_sequences (env))
+    goto maybe_dumb;
+
+  /* Check if terminal has CSI6n */
+  WaitForSingleObject (input_mutex, INFINITE);
+  c_lflag = get_ttyp ()->ti.c_lflag;
+  get_ttyp ()->ti.c_lflag &= ~ICANON;
+  /* Set h_pseudo_console and pcon_start so that the responce
+     will sent to io_handle rather than io_handle_cyg. */
+  get_ttyp ()->h_pseudo_console = (HPCON *) -1; /* dummy */
+  /* pcon_start will be cleared in master write()
+     when CSI6n is responced. */
+  get_ttyp ()->pcon_start = true;
+  WriteFile (get_output_handle_cyg (), "\033[6n", 4, &n, NULL);
+  ReleaseMutex (input_mutex);
+  p = buf;
+  len = sizeof (buf) - 1;
+  t0 = GetTickCount ();
+  do
+    {
+      if (::bytes_available (n, get_handle ()) && n)
+	{
+	  ReadFile (get_handle (), p, len, &n, NULL);
+	  p += n;
+	  len -= n;
+	  *p = '\0';
+	  char *p1 = strrchr (buf, '\033');
+	  if (p1 == NULL || sscanf (p1, "\033[%d;%dR", &y1, &x1) != 2)
+	    continue;
+	  break;
+	}
+      else if (GetTickCount () - t0 > 40) /* Timeout */
+	goto not_has_csi6n;
+      else
+	Sleep (1);
+    }
+  while (len);
+  if (len == 0)
+    goto not_has_csi6n;
+
+  get_ttyp ()->has_csi6n = true;
+  get_ttyp ()->pcon_cap_checked = true;
+
+  /* Check if terminal has set-title capability */
+  WaitForSingleObject (input_mutex, INFINITE);
+  /* Set pcon_start again because it should be cleared
+     in master write(). */
+  get_ttyp ()->pcon_start = true;
+  WriteFile (get_output_handle_cyg (), "\033]0;\033\\\033[6n", 10, &n, NULL);
+  ReleaseMutex (input_mutex);
+  p = buf;
+  len = sizeof (buf) - 1;
+  do
+    {
+      ReadFile (get_handle (), p, len, &n, NULL);
+      p += n;
+      len -= n;
+      *p = '\0';
+      char *p2 = strrchr (buf, '\033');
+      if (p2 == NULL || sscanf (p2, "\033[%d;%dR", &y2, &x2) != 2)
+	continue;
+      break;
+    }
+  while (len);
+  WaitForSingleObject (input_mutex, INFINITE);
+  get_ttyp ()->h_pseudo_console = NULL;
+  get_ttyp ()->ti.c_lflag = c_lflag;
+  ReleaseMutex (input_mutex);
+
+  if (len == 0)
+    return true;
+
+  if (x2 == x1 && y2 == y1)
+    /* If "\033]0;\033\\" does not move cursor position,
+       set-title is supposed to be supported. */
+    get_ttyp ()->has_set_title = true;
+  else
+    /* Try to erase garbage string caused by "\033]0;\033\\" */
+    for (int i=0; i<x2-x1; i++)
+      WriteFile (get_output_handle_cyg (), "\b \b", 3, &n, NULL);
+  return true;
+
+not_has_csi6n:
+  WaitForSingleObject (input_mutex, INFINITE);
+  /* If CSI6n is not responced, pcon_start is not cleared
+     in master write(). Therefore, clear it here manually. */
+  get_ttyp ()->pcon_start = false;
+  get_ttyp ()->h_pseudo_console = NULL;
+  get_ttyp ()->ti.c_lflag = c_lflag;
+  ReleaseMutex (input_mutex);
+maybe_dumb:
+  get_ttyp ()->pcon_cap_checked = true;
+  return false;
+}
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index a2f7697d7..92d190d1a 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -647,13 +647,17 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
       ZeroMemory (&si_pcon, sizeof (si_pcon));
       STARTUPINFOW *si_tmp = &si;
       if (!iscygwin () && ptys_primary && is_console_app (runpath))
-	if (ptys_primary->setup_pseudoconsole (&si_pcon,
-			     mode != _P_OVERLAY && mode != _P_WAIT))
-	  {
-	    c_flags |= EXTENDED_STARTUPINFO_PRESENT;
-	    si_tmp = &si_pcon.StartupInfo;
-	    enable_pcon = true;
-	  }
+	{
+	  bool nopcon = mode != _P_OVERLAY && mode != _P_WAIT;
+	  if (!ptys_primary->term_has_pcon_cap (envblock))
+	    nopcon = true;
+	  if (ptys_primary->setup_pseudoconsole (&si_pcon, nopcon))
+	    {
+	      c_flags |= EXTENDED_STARTUPINFO_PRESENT;
+	      si_tmp = &si_pcon.StartupInfo;
+	      enable_pcon = true;
+	    }
+	}
 
     loop:
       /* When ruid != euid we create the new process under the current original
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index d60f27545..7e3b88b0b 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -242,6 +242,9 @@ tty::init ()
   term_code_page = 0;
   pcon_last_time = 0;
   pcon_start = false;
+  pcon_cap_checked = false;
+  has_csi6n = false;
+  has_set_title = false;
 }
 
 HANDLE
diff --git a/winsup/cygwin/tty.h b/winsup/cygwin/tty.h
index c491d3891..4e9199dba 100644
--- a/winsup/cygwin/tty.h
+++ b/winsup/cygwin/tty.h
@@ -101,6 +101,9 @@ private:
   UINT term_code_page;
   DWORD pcon_last_time;
   HANDLE h_pcon_write_pipe;
+  bool pcon_cap_checked;
+  bool has_csi6n;
+  bool has_set_title;
 
 public:
   HANDLE from_master () const { return _from_master; }
-- 
2.28.0

