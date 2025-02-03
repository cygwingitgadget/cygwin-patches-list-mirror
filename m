Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id A632A3858C33; Mon,  3 Feb 2025 18:51:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A632A3858C33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1738608683;
	bh=UukWkZg4MLVn9nDb22ZXsW4m3Alr8f8qIxBF542mnlA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=FwukZFeowDowDcxMsvRAyPBjWaSCPVYljnq3DZJltfuu37B4yg/pTY40LQ+3Z8IoW
	 /NcOzijrxxOyebT9kE9E5i1UGAJiujk51dfipc03f+6Mg5YIlA0mkM6IhWnD1uVz0a
	 gL038TQNvkr4LBq78jKzcBy9tQ9wvlZcGRGXWNlI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 8B1F4A80DE0; Mon,  3 Feb 2025 19:51:20 +0100 (CET)
Date: Mon, 3 Feb 2025 19:51:20 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Jeremy Drake <cygwin@jdrake.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: factor out code to resolve a symlink target.
Message-ID: <Z6EQKFABRWnfi1Fc@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Jeremy Drake <cygwin@jdrake.com>,
	cygwin-patches@cygwin.com
References: <00a51487-ed74-8ad6-39aa-bd6963af54c2@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00a51487-ed74-8ad6-39aa-bd6963af54c2@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Jeremy,

On Feb  1 10:22, Jeremy Drake via Cygwin-patches wrote:
> This code was duplicated between the lnk symlink type and the native
> symlink type.
> 
> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> ---
> 
> I have been working on cleaning up msys2's "deepcopy" symlink mode code
> and noticed it was doing the same thing in a different way.  I copy-pasted
> the code from the lnk path, then factored it out into a function when I
> noticed the native path doing the same thing.  Then I realized, "that's
> stupid, I'm creating a bigger diff from upstream for a code cleanup".
> So I reverted it there and figured I'd send it here first, and adopt
> using it in the deepcopy code if/when it's applied here and in a released
> version.
> 
>  winsup/cygwin/path.cc | 52 ++++++++++++++++++++-----------------------
>  1 file changed, 24 insertions(+), 28 deletions(-)
> 
> diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
> index 658f3f9cf7..69675b2e23 100644
> --- a/winsup/cygwin/path.cc
> +++ b/winsup/cygwin/path.cc
> @@ -1756,6 +1756,28 @@ symlink (const char *oldpath, const char *newpath)
>    return -1;
>  }
> 
> +static bool
> +resolve_symlink_target (const char *oldpath, const path_conv &win32_newpath,
> +			path_conv &win32_oldpath)
> +{
> +  if (isabspath (oldpath))
> +    {
> +      win32_oldpath.check (oldpath, PC_SYM_NOFOLLOW, stat_suffixes);
> +      return true;
> +    }
> +  else
> +    {
> +      tmp_pathbuf tp;
> +      size_t len = strrchr (win32_newpath.get_posix (), '/')
> +		    - win32_newpath.get_posix () + 1;
> +      char *absoldpath = tp.t_get ();
> +      stpcpy (stpncpy (absoldpath, win32_newpath.get_posix (), len),
> +	      oldpath);
> +      win32_oldpath.check (absoldpath, PC_SYM_NOFOLLOW, stat_suffixes);
> +      return false;
> +    }
> +}
> +
>  static int
>  symlink_nfs (const char *oldpath, path_conv &win32_newpath)
>  {
> @@ -1816,23 +1838,12 @@ symlink_native (const char *oldpath, path_conv &win32_newpath)
>    UNICODE_STRING final_oldpath_buf;
>    DWORD flags;
> 
> -  if (isabspath (oldpath))
> +  if (resolve_symlink_target (oldpath, win32_newpath, win32_oldpath))
>      {
> -      win32_oldpath.check (oldpath, PC_SYM_NOFOLLOW, stat_suffixes);
>        final_oldpath = win32_oldpath.get_nt_native_path ();
>      }

Would be nice to drop the braces since it's a oneliner now.

>    else
>      {
> -      /* The symlink target is relative to the directory in which
> -	 the symlink gets created, not relative to the cwd.  Therefore
> -	 we have to mangle the path quite a bit before calling path_conv. */

This comment is removed here, while...

> @@ -2137,21 +2147,7 @@ symlink_worker (const char *oldpath, path_conv &win32_newpath, bool isdevice)
>  	      /* The symlink target is relative to the directory in which the
>  		 symlink gets created, not relative to the cwd.  Therefore we
>  		 have to mangle the path quite a bit before calling path_conv.*/

...it's still here.

The comment should be moved to resolve_symlink_target(), ideally
in front of the function rather than inside, to make clear what the
function is doing.  Both former comments can then go away.


Thanks,
Corinna
