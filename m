Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 7B9A23854835; Tue, 22 Jul 2025 08:40:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7B9A23854835
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1753173653;
	bh=mKDgq9tIG0Kmt2JJYyBUvKa0/7ypi6rlY1nw005pKvo=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=pRc8XKEXk8rb6kQOP3D5I7kretZWsyCymRhUvGnmj4kpjDcQ2HYhdRfeZ4UHv5c00
	 c04S0kfwxE3+NVBdPNWpsuuGRwYw9QkFHBYva9OeoOlC4Bt5WUZjamrKrFdHOTKU5F
	 RgjINcFgRGtyYStMhnfXtF4n0/xd82LSPd4agxsI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 00F97A80D00; Tue, 22 Jul 2025 10:40:50 +0200 (CEST)
Date: Tue, 22 Jul 2025 10:40:50 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5 2/3] Cygwin: spawn: Lock cygheap from
 refresh_cygheap() until child_copy()
Message-ID: <aH9OkvKh_qsBRC5T@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250722003142.4722-1-takashi.yano@nifty.ne.jp>
 <20250722003142.4722-3-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722003142.4722-3-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Jul 22 09:31, Takashi Yano wrote:
> ...completion in child process because the cygheap should not be
> changed to avoid mismatch between child_info::cygheap_max and
> ::cygheap_max. Otherwise, child_copy() might copy cygheap being
> modified by other process. However, do not lock cygheap if the
> child process is non-cygwin process, because child_copy() will
> not be called in it. Not only it is unnecessary, it can also fall
> into deadlock in close_all_files() while cygheap is already locked.
> 
> Fixes: 977ad5434cc0 ("* spawn.cc (spawn_guts): Call refresh_cygheap before creating a new process to ensure that cygheap_max is up-to-date.")
> Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---

When you create a new patch version, it would be nice if you could
add version info after the three dashes, kind of like

  v3: add cygheap_init::lock method
  v4: inline cygheap_init::lock method
  v5: don't lock cygheap for non-cygwin child
  v6: add spawn_cygheap_lock

Otherwise it's a bit tricky to review because one has to first find
out why a new version exists at all.

>  winsup/cygwin/spawn.cc | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
> index cb58b6eed..cf344d382 100644
> --- a/winsup/cygwin/spawn.cc
> +++ b/winsup/cygwin/spawn.cc
> @@ -542,7 +542,6 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
>  	::cygheap->ctty ? ::cygheap->ctty->tc_getpgid () : 0;
>        if (!iscygwin () && ctty_pgid && ctty_pgid != myself->pgid)
>  	c_flags |= CREATE_NEW_PROCESS_GROUP;
> -      refresh_cygheap ();
>  
>        if (mode == _P_DETACH)
>  	/* all set */;
> @@ -611,6 +610,9 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
>  
>        cygpid = (mode != _P_OVERLAY) ? create_cygwin_pid () : myself->pid;
>  
> +      if (iscygwin ())
> +	cygheap->lock ();
> +      refresh_cygheap ();

I compared v5 and v6, and I think we should not introduce the
spawn_cygheap_lock() method.  It hides a crucial problem.

Assuming no further change, I'd prefer v5, BUT with a comment preceeding
the `if (iscygwin ())' condition, along the lines of

   /* Lock the cygheap here to make sure the child doesn't copy a
      cygheap while it's being modified in parallel.  Don't lock if
      the child is a non-Cygwin child to avoid a deadlock in
      close_all_files(). */

However, IIUC this situation only occurs if a non-Cygwin child is
execve'd, and we're talking about the close_all_files() call in line 768
in origin/main, which potentially occurs while the cygheap would be
locked by your patch, right?

I see two different ways out:

- Either convert the SRWLOCK to a muto to allow a recursive cygheap lock.

- Or move the close_all_files() call.

The latter seems to me like the way to go here.

The close_all_files() call was introduced by commit 2f415d5efae5a
("Cygwin: pty: Disable FreeConsole() on close for non cygwin process.")

Why not move it out of the locked region?

diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index cb58b6eed066..1caa6feb64e7 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -764,8 +764,6 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	  NtClose (old_winpid_hdl);
 	  real_path.get_wide_win32_path (myself->progname); // FIXME: race?
 	  sigproc_printf ("new process name %W", myself->progname);
-	  if (!iscygwin ())
-	    close_all_files ();
 	}
       else
 	{
@@ -860,8 +858,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	    }
 	  else
 	    {
-	      if (iscygwin ())
-		close_all_files (true);
+	      close_all_files (iscygwin ());
 	      if (!my_wr_proc_pipe
 		  && WaitForSingleObject (pi.hProcess, 0) == WAIT_TIMEOUT)
 		wait_for_myself ();

If the situation is more complex, please explain.


Thanks,
Corinna
