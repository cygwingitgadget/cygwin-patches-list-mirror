Return-Path: <cygwin-patches-return-6641-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7021 invoked by alias); 25 Sep 2009 08:35:56 -0000
Received: (qmail 7010 invoked by uid 22791); 25 Sep 2009 08:35:56 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 25 Sep 2009 08:35:51 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id A1D726D5598; Fri, 25 Sep 2009 10:35:40 +0200 (CEST)
Date: Fri, 25 Sep 2009 08:35:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: new exports
Message-ID: <20090925083540.GC26348@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4ABC3BA2.9000109@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ABC3BA2.9000109@byu.net>
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
X-SW-Source: 2009-q3/txt/msg00095.txt.bz2

On Sep 24 21:40, Eric Blake wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Followup to my faccessat patch.  Here's several functions exported by
> Linux which are trivial to support in cygwin, and which coreutils would
> like to use.  POSIX allows us to copy Linux' behavior about refusing to
> implement fchmodat(,AT_SYMLINK_NOFOLLOW) (aka BSD lchmod), so if/until we
> implement lchmod, we should not mistakenly change the permissions on the
> file the symlink is pointing to.  I've also posted a newlib patch to
> declare e[uid]access.
> 
> 2009-09-24  Eric Blake  <ebb9@byu.net>
> 
> 	* syscalls.cc (fchownat): lchmod is not yet implemented.
> 	(euidaccess): New function.
> 	* path.cc (realpath): Update comment.
> 	(canonicalize_file_name): New function.
> 	* include/cygwin/stdlib.h (canonicalize_file_name): Declare it.
> 	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.
> 	* cygwin.din: Export canonicalize_file_name, eaccess, euidaccess.
> 	* posix.sgml: Mention them.

This is basically ok since it doesn't change any existing functionality
anyway.  Three points:

- Could you please add a patch to winsup/doc/new-features.sgml as
  well, adding the new entry points to the "other new APIs" paragraph in
  the file access related section?
  
- Please add the year 2008 to the copyright dates of include/cygwin/stdlib.h.
  Another one I forgot back then.  Thanks.

> @@ -3880,9 +3888,13 @@ fchmodat (int dirfd, const char *pathname, mode_t mode, int flags)
>    myfault efault;
>    if (efault.faulted (EFAULT))
>      return -1;
> -  if (flags & ~AT_SYMLINK_NOFOLLOW)
> +  if (flags)
>      {
> -      set_errno (EINVAL);
> +      /* BSD has lchmod, but Linux does not.  POSIX says
> +	 AT_SYMLINK_NOFOLLOW is allowed to fail with EOPNOTSUPP, but
> +	 only if pathname was a symlink; but Linux blindly fails with
> +	 ENOTSUP even for non-symlinks.  */
> +      set_errno ((flags & ~AT_SYMLINK_NOFOLLOW) ? EINVAL : ENOTSUP);
>        return -1;

- Please use EOPNOTSUPP, rather than ENOTSUP.  Linux doesn't actually
  have ENOTSUP.  It defines ENOTSUP == EOPNOTSUPP, see
  /usr/include/bits/errno.h.  The comment can simply refer to POSIX
  instead of to Linux.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
