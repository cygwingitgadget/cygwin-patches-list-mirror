Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 415B23852FCD; Wed,  2 Jul 2025 12:22:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 415B23852FCD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1751458940;
	bh=xUkXER+aY40PAFVktOe3uXzEoh0JGHTPDrJaIN+nY8c=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=aT3z1FAlucPdXOTHlHuC2k+KSd9bkIUhaBtWVYAMX97Hi+vSv3/Q/n+TyVC5NBodq
	 BvY25GGcA/UxwqWVpNunetPUPh7ZI3tkK1ATFsrxXrVDLLJiURYIBZHYWXVEQVZHdr
	 QNpyLxxNtxXwA9FXP5rnuIj/W/QwkgUo7xnSccQI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 1AC8AA80CFD; Wed, 02 Jul 2025 14:22:18 +0200 (CEST)
Date: Wed, 2 Jul 2025 14:22:18 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 2/6] Cygwin: add ability to pass cwd to child process
Message-ID: <aGUketWC7RES61Nx@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <66a1dec3-77a2-6c9f-0388-da2f85489e89@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <66a1dec3-77a2-6c9f-0388-da2f85489e89@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Jul  1 16:43, Jeremy Drake via Cygwin-patches wrote:
> This will be used by posix_spawn_fileaction_add_(f)chdir.
> 
> The int cwdfd is placed such that it fits into space previously unused
> due to alignment in the cygheap_exec_info class.
> 
> This uses a file descriptor rather than a path both because it is easier
> to marshal to the child and because this should protect against races
> where the directory might be renamed or removed between addfchdir and
> the actual setting of the cwd in the child.
> 
> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> ---
>  winsup/cygwin/dcrt0.cc                    |  19 +++-
>  winsup/cygwin/local_includes/child_info.h |   4 +-
>  winsup/cygwin/local_includes/path.h       |   6 +-
>  winsup/cygwin/local_includes/winf.h       |   2 +-
>  winsup/cygwin/spawn.cc                    | 100 ++++++++++++++++++----
>  winsup/cygwin/syscalls.cc                 |   4 +-
>  6 files changed, 113 insertions(+), 22 deletions(-)
> 
> diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
> index b0fb5c9c1e..6adc31495a 100644
> --- a/winsup/cygwin/dcrt0.cc
> +++ b/winsup/cygwin/dcrt0.cc
> @@ -46,6 +46,7 @@ extern "C" void __sinit (_reent *);
> 
>  static int NO_COPY envc;
>  static char NO_COPY **envp;
> +static int NO_COPY cwdfd = AT_FDCWD;
> 
>  bool NO_COPY jit_debug;
> 
> @@ -656,6 +657,7 @@ child_info_spawn::handle_spawn ()
>    __argv = moreinfo->argv;
>    envp = moreinfo->envp;
>    envc = moreinfo->envc;
> +  cwdfd = moreinfo->cwdfd;
>    if (!dynamically_loaded)
>      cygheap->fdtab.fixup_after_exec ();
>    if (__stdin >= 0)
> @@ -842,7 +844,22 @@ dll_crt0_1 (void *)
> 
>    ProtectHandle (hMainThread);
> 
> -  cygheap->cwd.init ();
> +  if (cwdfd >= 0)
> +    {
> +      int res = fchdir (cwdfd);
> +      if (res < 0)
> +	{
> +	  /* if the error occurs after the calling process successfully
> +	     returns, the child process shall exit with exit status 127. */
> +	  /* why is this byteswapped? */
> +	  set_api_fatal_return (0x7f00);
> +	  api_fatal ("can't fchdir, %R", res);
> +	}
> +      close (cwdfd);
> +      cwdfd = AT_FDCWD;
> +    }
> +  else
> +    cygheap->cwd.init ();

Weeeeell, as discussed in the other thread, and on second thought, maybe
this is the right spot to handle all the posix_spawn stuff.

But then, it should be in it's own function.  And you don't need
moreinfo->cwdfd, because the entire set of actions requested by the
posix_spawn caller should run one at a time in that function, so
multiple chdir and fchdir actions may be required.

I would also suggest to pimp cwdstuff::init() by adding an argument
which allows to say 

Eventually, this code snippet in dll_crt0_1 should probably look like
this:

  cygheap->cwd.init ();
  if (posix_spawn_actions_present)
    posix_spawn_run_child_actions (...);
    
Regardless if posix_spawn chdir/fchdir file actions are present or not,
in the first place the cwd of the child is the parent's cwd.  The
posix_spawn chdir/fchdir file actions run afterwards.


Thanks,
Corinna
