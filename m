From: Corinna Vinschen <corinna@vinschen.de>
To: cygwin-patches@sourceware.cygnus.com
Subject: Re: rmdir says it isn't a directory about a read only directory.
Date: Thu, 25 May 2000 12:40:00 -0000
Message-id: <392D752E.F7F13BBB@vinschen.de>
References: <s1sog5vw1l3.fsf@jaist.ac.jp> <392D003F.81A81CA8@vinschen.de> <20000525133109.A2490@cygnus.com>
X-SW-Source: 2000-q2/msg00086.html

Yes, in fact there's a good reason:

The (needed) use of GetFileAttributes a few lines above
has let me overlooked that.

Will you check that in? You already have the patch.

Corinna

Chris Faylor wrote:
> 
> Is there any reason why we can't use the 'fileattr' element of the
> path_conv class rather than calling GetFileAttributes again?
> 
> (see below)
> cgf
> 
> On Thu, May 25, 2000 at 12:28:15PM +0200, Corinna Vinschen wrote:
> >Kazuhiro Fujieda wrote:
> >>
> >> rmdir() sets ENOTDIR to the errno about a read only directory
> >> like the following.
> >>
> >> $ mkdir aaa
> >> $ chmod -w aaa
> >> $ rmdir aaa
> >> rmdir: aaa: Not a directory
> >>
> >> The following patch can fix this problem.
> >>
> >> 2000-05-25  Kazuhiro Fujieda <fujieda@jaist.ac.jp>
> >>
> >>         * dir.cc (rmdir): Correct the manner in checking the target directory.
> 
> Thu May 25 13:29:23 2000  Christopher Faylor <cgf@cygnus.com>
> 
>         * dir.cc (rmdir): Use file attributes that have already been discovered
>         by path_conv.
> 
> Index: dir.cc
> ===================================================================
> RCS file: /cvs/src/src/winsup/cygwin/dir.cc,v
> retrieving revision 1.5
> diff -u -p -r1.5 dir.cc
> --- dir.cc      2000/05/25 10:27:36     1.5
> +++ dir.cc      2000/05/25 17:29:22
> @@ -341,8 +341,7 @@ rmdir (const char *dir)
>        /* Under Windows 9X or on a samba share, ERROR_ACCESS_DENIED is
>           returned if you try to remove a file. On 9X the same error is
>           returned if you try to remove a non-empty directory. */
> -     int attr = GetFileAttributes (real_dir.get_win32());
> -     if (attr != -1 && !(attr & FILE_ATTRIBUTE_DIRECTORY))
> +     if (real_dir.fileattr != (DWORD) -1 && !(real_dir.fileattr & FILE_ATTRIBUTE_DIRECTORY))
>         set_errno (ENOTDIR);
>       else if (os_being_run != winNT)
>         set_errno (ENOTEMPTY);

-- 
Corinna Vinschen
Cygwin Developer
Cygnus Solutions, a Red Hat company
