From: Corinna Vinschen <corinna@vinschen.de>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: Re: rootdir
Date: Thu, 16 Mar 2000 11:06:00 -0000
Message-id: <38D130B0.E8B37262@vinschen.de>
References: <38D0E4C2.5F8DA404@vinschen.de> <20000316112658.A22419@cygnus.com> <38D1108D.593F9C71@vinschen.de> <20000316121257.A23537@cygnus.com> <38D12124.53280E68@vinschen.de>
X-SW-Source: 2000-q1/msg00008.html

Corinna Vinschen wrote:
> [...]
> at the end of path_conv::path_conv() and I can get a relative path
> in full_path if the cwd is on a remote drive that is _not_ mounted
> with drive letter:
> 
>         cd //server/share
>         strace ls -l some_file
> === snip ===
> x y [main] ls 1008 path_conv::path_conv: full_path = some_file
> === snap ===

I believe, I have the found the problem. The following is a code
snippet from mount_info::conv_to_win32_path(), near line 1002:

===== SNIP =====
  if (i >= nmounts)
    {
      if (slash_drive_prefix_p (pathbuf))
        slash_drive_to_win32_path (pathbuf, dst, trailing_slash_p);
      else
        backslashify (src_path, dst, trailing_slash_p); /* just convert
*/
===== SNAP =====

Shouldn't this be:

        backslashify (pathbuf, dst, trailing_slash_p); /* just convert
*/
                      ^^^^^^^

??? I'll try it in a few minutes...

Corinna
