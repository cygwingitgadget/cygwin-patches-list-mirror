Return-Path: <SRS0=0tdv=DF=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id 372304BA2E10
	for <cygwin-patches@cygwin.com>; Fri,  8 May 2026 02:51:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 372304BA2E10
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 372304BA2E10
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1778208677; cv=none;
	b=O8SHzOL0r7wFOG7Tp+c8AIRMflWQZSp0oMLaTqYc03mxLXREpsbeBXvKNVKxdvp6xMIjKSukakEpmE4euBE3XKXWxUDxuVZn6QjMd3zMyPxpkZqOm/C3mYukQ4g7NyfTBAij74ICBddd7SaweeADMeLYlddwcfPojGwvW7f/6hI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1778208677; c=relaxed/simple;
	bh=qedq886JsTcviDThL26UTrLsdcKuWgKfflyFyTrvOj8=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=DMWiS30ymNaemNg01hurDqq5FEaBJRKYUpH53dIDKimKzEkVuus4YJmtf3cZH0zw0XSBuTsV9+RbATZ5qTCnkEOMqyBV9mlQiQ4zt20G2tRw7X9MTeqXu7C0eCiGtswxUYfWzDlNMUNQ0f2Lv3/gTiCf2pvGj14pVTw5rC9ebys=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=DLLwDWui
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 372304BA2E10
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=DLLwDWui
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260508025114119.GYJ.19957.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 8 May 2026 11:51:14 +0900
Date: Fri, 8 May 2026 11:51:13 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: detect pcon-backed pty for
 non-Cygwin-spawned children
Message-Id: <20260508115113.6d73486274ab131bee493fe2@nifty.ne.jp>
In-Reply-To: <pull.7.cygwin.1777561444611.gitgitgadget@gmail.com>
References: <pull.7.cygwin.1777561444611.gitgitgadget@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Fri__8_May_2026_11_51_13_+0900_1awCj_5F6TFLl1r+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1778208674;
 bh=7L9x7GuUBjuJaNwWIujJmmquvOB29rUAonND4NIrBx8=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=DLLwDWuiYTfmo4yXgousPb1GoQgACc1gZ3YJNOO2kys/T6P3ryyWT4SBE3G3X7y/GnM+mZTM
 ewWxcY2r4pLE1G2OuKnnHsIupVNa3bldCBbysz50NcGupDZO8o0Ui9WtOtpVevG9GNlGNc5EhU
 HaLWjdhhcCWYX5dtp/9roUYdCK6it+QaluIKyGtTwR+tqR38zmludQFe6NT64Jr3uvhiM+v0Tg
 TfBUKu0ocKgZxfexW3ulHQbT2wk+rPPlgSsGKNK2diFmQoIhyjh4Q22y6K/360qON+IjtTdui8
 +5mRFGzxaGJU+wyK4Zk2bzM3V3PX7NCFVdzg92o7GIKBk6oQ==
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.

--Multipart=_Fri__8_May_2026_11_51_13_+0900_1awCj_5F6TFLl1r+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Johannes,

The basic idea looks great. Thanks!

While testing this patch, I encountered one major issue
and two minor ones.

1) Run 'cat' in cmd.exe and stop it by Ctrl-C. After that
   cmd.exe cannot receive key input.
2) Run 'ps' in cmd.exe. The cursor position will not be
   maintained correctly after that.

This two problems are resolved by the patch attached:
fixup_pcon_state.patch

3) Run 'sleep 10' in cmd.exe and enter 'ps\n' while sleeping
   and press Ctrl-C. 'ps' will be executed after terminating
   'sleep' by Ctrl-C.

This problem is resolved by the patch attachd:
discard_input.patch

Please consider incorporating these two patches into your
patch.

Line by line comments are as follows.

On Thu, 30 Apr 2026 15:04:04 +0000
"Johannes Schindelin via GitGitGadget" wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> When a Cygwin process (e.g. `bash` under MinTTY) spawns a native
> Win32 child (e.g. `git.exe`) with pseudo console support enabled,
> the child gets a pseudo console that bridges the pty. If that native
> child then spawns a Cygwin grandchild (e.g. `vim`, `less`), the
> grandchild inherits the pseudo console's console handles. In
> `init_std_file_from_handle()`, the grandchild's msys2-runtime sees
> `GetConsoleScreenBufferInfo()` succeed on those handles and, with
> no valid `ctty` set, falls back to `FH_CONSOLE` and gives the
> process `cons0` instead of connecting to the pty.
> 
> This causes scrollback clobbering in MinTTY because alternate screen
> sequences (`ESC[?1049h` / `ESC[?1049l`) are handled by
> `fhandler_console`'s `save_restore()` against the pseudo
> console's buffer, which has no correspondence to MinTTY's scrollback.
> 
> Fix this in the existing console branch of
> `init_std_file_from_handle()`: when there is no valid `ctty` and
> we are about to fall back to `FH_CONSOLE`, first scan the shared
> tty table for an entry whose `pcon_activated` is set and whose
> `nat_pipe_owner_pid` is in our console's process list (via
> `GetConsoleProcessList`). If found, parse the device as that pty
> slave instead of as a real console. The handle is closed in either
> fallback path, matching the existing `FH_CONSOLE` behavior.
> `myself->ctty` is left untouched; the regular
> `fhandler_pty_slave::open_setup()` path will set it via
> `myself->set_ctty()` when the pty slave is opened.
> 
> The structure of `find_pcon_pty()` matters and is easy to get
> wrong in case a keen developer would like to refactor this code in
> the future. This code runs on every Cygwin process startup whose
> parent is non-Cygwin, so the common path (no pty with an active
> pseudo console) must remain free of expensive operations. Two
> pitfalls to avoid: filtering tty entries with `tty::exists()`
> looks correct but creates and destroys a named pipe per entry
> (128 entries on every call), and hoisting the
> `GetConsoleProcessList()` call out of the loop pays the
> cross-process cost even when no candidate exists. The current
> shape, a cheap shared-memory boolean check first and a lazily
> fetched process list only on the first candidate, keeps the
> common case at a handful of pointer reads.
> 
> Reported downstream at https://github.com/git-for-windows/git/issues/5303
> and bisected to a Git for Windows release that upgraded the bundled
> msys2-runtime from 3.3.6 (no pseudo console code) to 3.4.6 (the new
> pseudo console architecture).
> 
> Fixes: bb4285206207 ("Cygwin: pty: Implement new pseudo console support.")
> Assisted-by: Claude Opus 4.7 (1M context)
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     Detect pcon-backed pty for non-Cygwin-spawned children
>     
>     A Git for Windows user reported that vim (or less, when paging git
>     output) clobbers the visible scrollback in MinTTY when invoked through
>     git.exe: https://github.com/git-for-windows/git/issues/5303
>     
>     Their bisect, with great patience across 60+ Git for Windows installer
>     reinstalls, narrowed the regression to the v2.40.1 -> v2.41.0
>     transition, which corresponds to the msys2-runtime upgrade from 3.3.6 to
>     3.4.6, i.e. the introduction of Takashi's pseudo console architecture
>     (bb4285206207). The user's diagnostic ps -f from inside vim showed the
>     editor on cons0 rather than pty0.
>     
>     I confirmed the root cause locally: with CYGWIN=disable_pcon the editor
>     lands on pty0 and the scrollback survives, with the default (pcon
>     enabled) it lands on cons0 and the alternate screen save/restore happens
>     against the pseudo console buffer, which has no relationship to MinTTY's
>     scrollback. The issue is reproducible without vim using a tiny
>     diagnostic GIT_EDITOR:
>     
>     GIT_EDITOR='sh -c "ps -f >&2; cat \"\\"" _' \
>         git commit --allow-empty --amend --allow-empty
>     
>     
>     The sh and ps show up on cons0; with disable_pcon, on pty0. The same
>     symptom occurs whenever any native console application spawns Cygwin
>     children, git.exe is just by far the most common case in practice.
>     
>     The patch teaches init_std_file_from_handle() that an inherited console
>     handle from a non-Cygwin parent might actually be a pseudo console
>     bridging a pty, and to connect to the pty slave in that case rather than
>     falling back to cons0. The mechanism, the alternative I considered, and
>     the performance considerations for the new shared-memory scan are all in
>     the commit message.
>     
>     The same patch is also applied downstream at
>     https://github.com/git-for-windows/msys2-runtime/pull/131 so Git for
>     Windows users can get the fix ahead of the next Cygwin release, but this
>     PR is the authoritative version intended for cygwin-3_6-branch.
> 
> Published-As: https://github.com/cygwingitgadget/cygwin/releases/tag/pr-7%2Fdscho%2Fpcon-fix-cygwin-v1
> Fetch-It-Via: git fetch https://github.com/cygwingitgadget/cygwin pr-7/dscho/pcon-fix-cygwin-v1
> Pull-Request: https://github.com/cygwingitgadget/cygwin/pull/7
> 
>  winsup/cygwin/dtable.cc            | 12 +++++++++-
>  winsup/cygwin/local_includes/tty.h |  5 ++++
>  winsup/cygwin/tty.cc               | 37 ++++++++++++++++++++++++++++++
>  3 files changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
> index 7303f7eac..ce29f4608 100644
> --- a/winsup/cygwin/dtable.cc
> +++ b/winsup/cygwin/dtable.cc
> @@ -327,7 +327,17 @@ dtable::init_std_file_from_handle (int fd, HANDLE handle)
>  	dev.parse (myself->ctty);
>        else
>  	{
> -	  dev.parse (FH_CONSOLE);
> +	  /* Check whether the inherited console is actually a pseudo
> +	     console bridging a pty.  This happens when our non-Cygwin
> +	     parent was itself spawned by a Cygwin process from a pty
> +	     (e.g. bash spawning git.exe which then spawns vim).  In
> +	     that case, connect to the pty slave instead of treating
> +	     the handle as a real console. */
> +	  int pcon_minor = cygwin_shared->tty.find_pcon_pty ();
> +	  if (pcon_minor >= 0)
> +	    dev.parse (FHDEV (DEV_PTYS_MAJOR, pcon_minor));
> +	  else
> +	    dev.parse (FH_CONSOLE);
>  	  CloseHandle (handle);
>  	  handle = INVALID_HANDLE_VALUE;

These two lines are dropped in master branch. Do you think
these are necessary for your patch in master branch?

These lines are dropped by the commit:
commit bbd3710fc83451426e3a58e5032437ca535fa444
Author: Takashi Yano <takashi.yano@nifty.ne.jp>
Date:   Thu Jul 3 09:06:22 2025 +0900

    Cygwin: console: Set console mode only if std{in,out,err} is console

    Currently, when cygwin app is launched, the console input mode is
    set to tty::cygwin, even if the stdin is not a console. However,
    it is not necessary because the cygwin app does not use stdin.
    This also applies to stdout and stderr.

    With this patch, the console mode is set only when std{in,out,err}
    is a console for the cygwin app for better coexistence with non-
    cygwin apps.

    Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>

However, I do not remember why. The commit message does not
mention that change.... :(

These lines are introduced by the commit:
commit 6ae28c22639d43de76a9d45362df5055cd38a867
Author: Christopher Faylor <me@cgf.cx>
Date:   Sat Oct 22 16:26:30 2011 +0000

    * dtable.cc (dtable::delete_archetype): Improve debugging output.
    (dtable::init_std_file_from_handle): Close console handle early, before
    initialization.  Build up openflags for passing to open_setup, just to be safe.
    (last_tty_dev): New variable.
    (fh_last_tty_dev): New macro.
    (fh_alloc): Try again to keep track of previously opened tty, this time by just
    saving the device and using that to potentially open an archetype.  Avoid
    setting the "/dev/tty" name if the creation of the fhandler failed.
    (build_fh_pc): Remove unused second argument.  Reorganize how and where the
    name is set.  Set last_tty_dev as appropriate.  Avoid a NULL dereference in a
    debug printf.
    * dtable.h (build_fh_pc): Reflect removal of second parameter.
    * fhandler.cc (fhandler_base::reset): Use new '<<' operator to copy pc since it
    preserves any potentially previously set name.
    (fhandler_base::set_name): Ditto.
    * fhandler.h (fhandler_*::clone): Throughout use ccalloc to allocate new
    fhandler, primarily to make sure that pc field is properly zeroed.
    (fhandler_termios::last): Eliminate.
    (fhandler_termios): Remove setting of last.
    (fhandler_base::~fhandler_termios): Ditto.
    * fhandler_console.cc (fhandler_console::open): Don't make decisions about
    opening close-on-exec handles here since it makes no sense for archetypes.
    (fhandler_console::init): Assume that input handle has already been opened.
    * fhandler_termios.cc (fhandler_termios::last): Delete.
    * path.h (path_conv::eq_worker): New function.  Move bulk of operator = here.
    (operator <<): New function.
    (operator =): Use eq_worker to perform old functionality.

but, this commit message also does not mention why....

>  	}
> diff --git a/winsup/cygwin/local_includes/tty.h b/winsup/cygwin/local_includes/tty.h
> index 6e70a74cd..f98059942 100644
> --- a/winsup/cygwin/local_includes/tty.h
> +++ b/winsup/cygwin/local_includes/tty.h
> @@ -175,6 +175,10 @@ public:
>    void wait_fwd ();
>    bool pty_input_state_eq (xfer_dir x) { return pty_input_state == x; }
>    bool nat_fg (pid_t pgid);
> +  bool has_active_pcon () const
> +    { return pcon_activated && switch_to_nat_pipe; }
> +  bool has_pcon_and_owner (DWORD pid) const
> +    { return pcon_activated && switch_to_nat_pipe && nat_pipe_owner_pid == pid; }
>    friend class fhandler_pty_common;
>    friend class fhandler_pty_master;
>    friend class fhandler_pty_slave;
> @@ -193,6 +197,7 @@ public:
>    int connect (int);
>    void init ();
>    tty_min *get_cttyp ();
> +  int find_pcon_pty ();
>    int attach (int n);
>    static void init_session ();
>    friend class lock_ttys;
> diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
> index c8730e81c..5cce05de3 100644
> --- a/winsup/cygwin/tty.cc
> +++ b/winsup/cygwin/tty.cc
> @@ -123,6 +123,43 @@ tty_list::init ()
>      }
>  }
>  
> +/* Search for a pty whose pseudo console owns our console.
> +   Return tty minor number or -1 if not found.
> +   Called from init_std_file_from_handle() for processes started by
> +   non-Cygwin parents to detect that inherited console handles are
> +   from a pcon-backed pty.
> +
> +   The cheap precondition (any tty with pcon active in shared memory)
> +   short-circuits the common case where no pty has a pseudo console
> +   active, avoiding the GetConsoleProcessList() LPC call entirely. */
> +int
> +tty_list::find_pcon_pty ()
> +{
> +  DWORD pids[128];
> +  DWORD count = 0;
> +  bool got_pids = false;
> +
> +  for (int i = 0; i < NTTYS; i++)
> +    {
> +      if (!ttys[i].has_active_pcon ())
> +	continue;
> +
> +      /* Fetch the console process list lazily, only on first candidate. */
> +      if (!got_pids)
> +	{
> +	  count = GetConsoleProcessList (pids, 128);
> +	  if (!count)
> +	    return -1;
> +	  got_pids = true;
> +	}
> +
> +      for (DWORD j = 0; j < count; j++)
> +	if (ttys[i].has_pcon_and_owner (pids[j]))
> +	  return i;
> +    }
> +  return -1;
> +}
> +
>  /* Search for a free tty and allocate it.
>     Return tty number or -1 if error.
>   */

Where does the '128' come from? What happnes if the number of
processes attaching to the pseudo console is more that 128?

> 
> base-commit: daabea98682f3f4bef0044829a8d24226135bb71
> -- 
> cygwingitgadget


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

--Multipart=_Fri__8_May_2026_11_51_13_+0900_1awCj_5F6TFLl1r+
Content-Type: text/plain;
 name="fixup_pcon_state.patch"
Content-Disposition: attachment;
 filename="fixup_pcon_state.patch"
Content-Transfer-Encoding: 7bit

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 80331c36d..dfe16777b 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -388,6 +388,52 @@ atexit_func (void)
     }
 }
 
+void
+fhandler_pty_slave::req_fixup_pcon_state (void)
+{
+  while (true)
+    {
+      WaitForSingleObject (input_mutex, mutex_timeout);
+      if (!get_ttyp ()->pcon_start_pid)
+	break;
+      /* Another request is on going. */
+      ReleaseMutex (input_mutex);
+      yield ();
+    }
+
+  DWORD n;
+  /* indicates that this "ESC[6n" is just for fixing-up corsor position */
+  get_ttyp ()->req_fixup_pcon_cur_pos = true;
+  get_ttyp ()->req_xfer_input = true; /* indicates that this "ESC[6n"
+					 is just for transfer input */
+  get_ttyp ()->pcon_start = true;
+  get_ttyp ()->pcon_start_pid = myself->pid;
+  WriteFile (get_output_handle (), "\033[6n", 4, &n, NULL);
+  ReleaseMutex (input_mutex);
+  while (get_ttyp ()->pcon_start_pid)
+    /* wait for completion of fixing-up in master::write(). */
+    yield ();
+}
+
+void
+fhandler_pty_master::fixup_pcon_cursor_position (int x, int y)
+{
+  HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
+				   get_ttyp ()->nat_pipe_owner_pid);
+  HANDLE h_pcon_out = NULL;
+  DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_out,
+		   GetCurrentProcess (), &h_pcon_out,
+		   0, TRUE, DUPLICATE_SAME_ACCESS);
+  CloseHandle (pcon_owner);
+  DWORD target_pid = get_ttyp ()->nat_pipe_owner_pid;
+  DWORD resume_pid =
+    fhandler_pty_common::attach_console_temporarily (target_pid);
+  COORD cur_pos = {(SHORT) (x - 1), (SHORT) (y - 1)};
+  SetConsoleCursorPosition (h_pcon_out, cur_pos);
+  fhandler_pty_common::resume_from_temporarily_attach (resume_pid);
+  CloseHandle (h_pcon_out);
+}
+
 #define DEF_HOOK(name) static __typeof__ (name) *name##_Orig
 /* CreateProcess() is hooked for GDB etc. */
 DEF_HOOK (CreateProcessA);
@@ -1147,6 +1201,19 @@ err_no_msg:
 bool
 fhandler_pty_slave::open_setup (int flags)
 {
+  if (get_ttyp ()->pcon_activated)
+    {
+      HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
+				       get_ttyp ()->nat_pipe_owner_pid);
+      DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
+		       GetCurrentProcess (), &get_handle_nat (),
+		       0, TRUE, DUPLICATE_SAME_ACCESS);
+      DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_out,
+		       GetCurrentProcess (), &get_output_handle_nat (),
+		       0, TRUE, DUPLICATE_SAME_ACCESS);
+      CloseHandle (pcon_owner);
+    }
+
   set_flags ((flags & ~O_TEXT) | O_BINARY);
   myself->set_ctty (this, flags);
   report_tty_counts (this, "opened", "");
@@ -1156,6 +1223,9 @@ fhandler_pty_slave::open_setup (int flags)
 void
 fhandler_pty_slave::cleanup ()
 {
+  if (get_ttyp ()->pcon_activated && get_ttyp ()->getpgid () == myself->pgid)
+    req_fixup_pcon_state ();
+
   /* This used to always call fhandler_pty_common::close when we were execing
      but that caused multiple closes of the handles associated with this pty.
      Since close_all_files is not called until after the cygwin process has
@@ -2424,7 +2494,14 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	      /* req_xfer_input is true if "ESC[6n" was sent just for
 		 triggering transfer_input() in master. In this case,
 		 the response sequence should not be written. */
-	      if (!get_ttyp ()->req_xfer_input)
+	      if (get_ttyp ()->req_fixup_pcon_cur_pos)
+		{
+		  int x, y;
+		  sscanf (wpbuf, "\033[%d;%dR", &y, &x);
+		  fixup_pcon_cursor_position (x, y);
+		  get_ttyp ()->req_fixup_pcon_cur_pos = false;
+		}
+	      else if (!get_ttyp ()->req_xfer_input)
 		WriteFile (to_slave_nat, wpbuf, ixput, &n, NULL);
 	      ixput = 0;
 	      state = 0;
@@ -4047,8 +4125,6 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
 	  ttyp->pcon_activated = false;
 	  ttyp->switch_to_nat_pipe = false;
 	  ttyp->nat_pipe_owner_pid = 0;
-	  ttyp->pcon_start = false;
-	  ttyp->pcon_start_pid = 0;
 	}
     }
   else
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 4f5605524..97adbeb3c 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2531,6 +2531,7 @@ class fhandler_pty_slave: public fhandler_pty_common
   void setpgid_aux (pid_t pid);
   static void release_ownership_of_nat_pipe (tty *ttyp, fhandler_termios *fh);
   void replace_nat_handles (HANDLE new_input, HANDLE new_output);
+  void req_fixup_pcon_state (void);
 };
 
 #define __ptsname(buf, unit) __small_sprintf ((buf), "/dev/pty%d", (unit))
@@ -2637,6 +2638,7 @@ public:
   void get_master_fwd_thread_param (master_fwd_thread_param_t *p);
   bool need_send_ctrl_c_event ();
   void apply_line_edit_to_transferred_input ();
+  void fixup_pcon_cursor_position (int x, int y);
 };
 
 class fhandler_dev_null: public fhandler_base
diff --git a/winsup/cygwin/local_includes/tty.h b/winsup/cygwin/local_includes/tty.h
index cbc31cff0..a87b31926 100644
--- a/winsup/cygwin/local_includes/tty.h
+++ b/winsup/cygwin/local_includes/tty.h
@@ -144,6 +144,7 @@ private:
   xfer_dir pty_input_state;
   bool discard_input;
   bool stop_fwd_thread;
+  bool req_fixup_pcon_cur_pos;
 
 public:
   HANDLE from_master_nat () const { return _from_master_nat; }

--Multipart=_Fri__8_May_2026_11_51_13_+0900_1awCj_5F6TFLl1r+
Content-Type: text/plain;
 name="discard_input.patch"
Content-Disposition: attachment;
 filename="discard_input.patch"
Content-Transfer-Encoding: 7bit

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 80331c36d..dfe16777b 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -583,6 +629,14 @@ fhandler_pty_master::discard_input ()
   if (!get_ttyp ()->pcon_activated)
     while (::bytes_available (bytes_in_pipe, from_master_nat) && bytes_in_pipe)
       ReadFile (from_master_nat, buf, sizeof(buf), &n, NULL);
+  else
+    {
+      DWORD target_pid = get_ttyp ()->nat_pipe_owner_pid;
+      DWORD resume_pid =
+	fhandler_pty_common::attach_console_temporarily (target_pid);
+      FlushConsoleInputBuffer (h_pcon_in_dupped);
+      fhandler_pty_common::resume_from_temporarily_attach (resume_pid);
+    }
   get_ttyp ()->discard_input = true;
   ReleaseMutex (input_mutex);
 }
@@ -2529,7 +2606,8 @@ fhandler_pty_master::write (const void *ptr, size_t len)
       for (size_t i = 0, j = 0; i < len; i++)
 	{
 	  process_sig_state r = process_sigs (buf[i], get_ttyp (), this);
-	  if (r != done_with_debugger)
+	  if (r != done_with_debugger &&
+	      (r != signalled || (ti.c_lflag & NOFLSH) || buf[i] == '\003'))
 	    {
 	      char c = buf[i];
 	      /* Workaround for pseudo console in Windows 11 */

--Multipart=_Fri__8_May_2026_11_51_13_+0900_1awCj_5F6TFLl1r+--
