Return-Path: <cygwin-patches-return-6630-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14082 invoked by alias); 23 Sep 2009 13:30:36 -0000
Received: (qmail 14066 invoked by uid 22791); 23 Sep 2009 13:30:34 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 23 Sep 2009 13:30:27 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 5BEED6D5598; Wed, 23 Sep 2009 15:30:15 +0200 (CEST)
Date: Wed, 23 Sep 2009 13:30:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [1.7] rename/renameat error
Message-ID: <20090923133015.GA16976@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4AA52B5E.8060509@byu.net> <20090907192046.GA12492@calimero.vinschen.de> <loom.20090909T005422-847@post.gmane.org> <loom.20090909T183010-83@post.gmane.org> <loom.20090922T225033-801@post.gmane.org> <4ABA1B92.9080406@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ABA1B92.9080406@byu.net>
User-Agent: Mutt/1.5.19 (2009-02-20)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q3/txt/msg00084.txt.bz2

On Sep 23 06:58, Eric Blake wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> According to Eric Blake on 9/22/2009 3:02 PM:
> > I've got a patch in testing for both of these issues.
> 
> Does this look okay to apply?  The fix in path.cc affects more than just
> link, hence I had to add a new option to keep mkdir("d/",mode) still
> working, while link("file","d/") now fails with the same ENOENT as Linux.
>  rename was tricky, as rename("file","d/") must fail whether or not d
> exists, while rename("dir","d/") must succeed if d does not exist or
> exists and is empty.  I think I got it all, but it can't hurt to
> double-check things.
> 
> 2009-09-23  Eric Blake  <ebb9@byu.net>
> 
> 	* path.h (PC_MKDIR): New enum value.
> 	* path.cc (check): Ensure 'a/' resolves to a directory.
> 	* syscalls.cc (link): Fix comment.
> 	(rename): Use correct errno for trailing '.'.  Allow trailing
> 	slash to newpath iff oldpath is directory.
> 	* dir.cc (mkdir): Allow trailing slash.
> [...]
> @@ -698,7 +698,7 @@ path_conv::check (const char *src, unsig
>  	 into account during processing */
>        if (tail > path_copy + 2 && isslash (tail[-1]))
>  	{
> -	  need_directory = 1;
> +	  need_directory = !(opt & PC_MKDIR);
>  	  *--tail = '\0';
>  	}
>        path_end = tail;
> @@ -899,7 +899,7 @@ is_virtual_symlink:
>  	     these operations again on the newly derived path. */
>  	  else if (symlen > 0)
>  	    {
> -	      saw_symlinks = 1;
> +	      saw_symlinks = true;
>  	      if (component == 0 && !need_directory && !(opt & PC_SYM_FOLLOW))
>  		{
>  		  set_symlink (symlen); // last component of path is a symlink.
> @@ -914,7 +914,7 @@ is_virtual_symlink:
>  	      else
>  		break;
>  	    }
> -	  else if (sym.error && sym.error != ENOENT)
> +	  else if (sym.error && (sym.error != ENOENT || need_directory))
>  	    {
>  	      error = sym.error;
>  	      goto out;

Urgh.  I stumbled over the need_directory flag only two days ago.  while
debugging the symlink errno problem you reported on the list.  CGF is my
witness.  It's the reason I made the trailing slash change in symlink
rather than in path_conv::check.  It's quite tricky to keep all possible
cases working.  Have you tested this change with the entire coreutils
testsuite?  It seems to be quite thorough.

> @@ -1124,12 +1124,7 @@ isatty (int fd)
>  }
>  EXPORT_ALIAS (isatty, _isatty)
>  
> -/* Under NT, try to make a hard link using backup API.  If that
> -   fails or we are Win 95, just copy the file.
> -   FIXME: We should actually be checking partition type, not OS.
> -   Under NTFS, we should support hard links.  On FAT partitions,
> -   we should just copy the file.
> -*/
> +/* Under NT, try to make a hard link using backup API.  */

Thanks for fixing the comment, but actually we're not using the backup
API for some time, and we're now always under NT.  I guess we should get
rid of this comment entirely since the actual work is done in
fhandler_disk_file::link anyway.

>  extern "C" int
>  link (const char *oldpath, const char *newpath)
> @@ -1650,13 +1645,13 @@ rename (const char *oldpath, const char 
>    if (has_dot_last_component (oldpath, true))
>      {
>        oldpc.check (oldpath, PC_SYM_NOFOLLOW, stat_suffixes);
> -      set_errno (oldpc.isdir () ? EBUSY : ENOTDIR);
> +      set_errno (oldpc.isdir () ? EINVAL : ENOTDIR);
>        goto out;
>      }
>    if (has_dot_last_component (newpath, true))
>      {
>        newpc.check (newpath, PC_SYM_NOFOLLOW, stat_suffixes);
> -      set_errno (!newpc.exists () ? ENOENT : newpc.isdir () ? EBUSY : ENOTDIR);
> +      set_errno (!newpc.exists () ? ENOENT : newpc.isdir () ? EINVAL : ENOTDIR);
>        goto out;
>      }
>  
> @@ -1701,6 +1696,11 @@ rename (const char *oldpath, const char 
>    nlen = strlen (newpath);
>    if (isdirsep (newpath[nlen - 1]))
>      {
> +      if (!oldpc.isdir())
> +	{
> +	  set_errno (ENOTDIR);
> +	  goto out;
> +	}
>        stpcpy (newbuf = tp.c_get (), newpath);
>        while (nlen > 0 && isdirsep (newbuf[nlen - 1]))
>  	newbuf[--nlen] = '\0';
> @@ -1718,7 +1718,7 @@ rename (const char *oldpath, const char 
>        set_errno (EROFS);
>        goto out;
>      }
> -  if (new_dir_requested && !newpc.isdir ())
> +  if (new_dir_requested && newpc.exists() && !newpc.isdir ())
>      {
>        set_errno (ENOTDIR);
>        goto out;

This part of the patch looks good to me.  I'm just sweating some
blood over the need_directory change in path_conv::check due to my
own experience.  Does it really not break something in the path
handling?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
