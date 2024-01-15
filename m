Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 8DD943858D28; Mon, 15 Jan 2024 10:44:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8DD943858D28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1705315497;
	bh=SXJm/xxjscoZ7nr8aonwnd8k6SC7SRvIFuSvIsHhxs4=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=O8qyy3pesTLfzpQ4jgzWLLvV/MAwarqTKF3wbGph4XfLhFYgUSCBvxoDVk+3kqHZw
	 NFzZmvHpHWCJhL5IoutCtBi4GEdDpy8OJUoSOY1xpg3ILOG4ZOWrmQiM5QiN9AJiQN
	 3pK1Z/wjLYU7a7woDpMGe2wQGv63OUAfX/QkjDVA=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 54B1BA8096D; Mon, 15 Jan 2024 11:44:55 +0100 (CET)
Date: Mon, 15 Jan 2024 11:44:55 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: introduce close_range
Message-ID: <ZaUMpz2oUXpokdAk@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <83cfd6b3-6824-fd9f-794b-7fc428f8c80d@t-online.de>
 <3ab13e94-fd3a-41c8-8392-fcd72042d0e9@dronecode.org.uk>
 <6b1723b1-12b1-a240-ff22-1f0f5ba73214@t-online.de>
 <2443ab23-4c2f-bf99-c38e-8410e642fe1f@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2443ab23-4c2f-bf99-c38e-8410e642fe1f@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

Hi Christian,

On Jan 15 09:56, Christian Franke wrote:
> Christian Franke wrote:
> > Jon Turney wrote:
> > > On 14/01/2024 16:07, Christian Franke wrote:
> > > > Recently I learned about the existence and usefulness of close_range():
> > > > https://github.com/smartmontools/smartmontools/issues/235
> > > > 
> > > > https://man.freebsd.org/cgi/man.cgi?query=close_range&sektion=2
> > > > https://man7.org/linux/man-pages/man2/close_range.2.html
> > > > 
> > > > Note that the above Linux man page is not fully correct. The
> > > > include file "linux/close_range.h" exists, but provides only the
> > > > defines. It is sufficient to include "unistd.h" as on FreeBSD.
> > > > 
> > > > The attached patch adds this to Cygwin. It does not implement
> > > > the Linux-specific CLOSE_RANGE_UNSHARE as I have no idea how to
> > > > do this :-)
> > > 
> > > This API should also be mentioned in the
> > > "System interfaces compatible with GNU or Linux extensions" section
> > > of doc/posix.xml
> > > 
> > > 
> > 
> > Thanks for the info. I used the recent "Cygwin: introduce fallocate(2)"
> > patch as a blueprint for which other files should be changed (fallocate
> > is also missing in the posix.xml file).
> > 
> > I will provide a new patch soon which also fixes an unlikely but
> > possible corner case: Pass a value larger than MAX_INT as lower limit.
> > 
> 
> Attached. I also decided to simply ignore CLOSE_RANGE_UNSHARE for now.

After reading up on this issue, I think we should not ignore
CLOSE_RANGE_UNSHARE, but quite explicitely not implement it as a valid
flag.

The whole idea behind CLOSE_RANGE_UNSHARE depends on the way the Linux
kernel creates threads and (forked) processes and the fact that it has a
wide range of ways to share parts of the execution context between
parent and child process/thread.

So on Linux, a process/thread can actually decide if they share or not
share the descriptor table with the created process/thread.  That's
what the CLONE_FILES flag to clone(2) and unshare(2) manage.

However, just as in FreeBSD, there's no such thing in Cygwin.  Threads
always share descriptors, processes never share file desriptors.

The bottom line is, I think the decision of the FreeBSD developer not to
expose the CLOSE_RANGE_UNSHARE flag at all, was the right decision.

We should not claim that we even remotely have a way of doing this
the Linux way.

Does that make sense?

Apart from this little thing I think the patch is nice.


Thanks,
Corinna



> From f7704bf77a926e53e8200528ab6abc1c9fdca511 Mon Sep 17 00:00:00 2001
> From: Christian Franke <christian.franke@t-online.de>
> Date: Mon, 15 Jan 2024 09:52:50 +0100
> Subject: [PATCH] Cygwin: introduce close_range(2)
> 
> This function closes or sets the close-on-exec flag for a specified
> range of file descriptors.  It is available on FreeBSD and Linux.
> 
> Signed-off-by: Christian Franke <christian.franke@t-online.de>
> ---
>  newlib/libc/include/sys/unistd.h       |  9 ++++++
>  winsup/cygwin/cygwin.din               |  1 +
>  winsup/cygwin/include/cygwin/version.h |  3 +-
>  winsup/cygwin/release/3.5.0            |  2 ++
>  winsup/cygwin/syscalls.cc              | 43 ++++++++++++++++++++++++++
>  winsup/doc/new-features.xml            |  4 +++
>  winsup/doc/posix.xml                   |  5 +++
>  7 files changed, 66 insertions(+), 1 deletion(-)
> 
> diff --git a/newlib/libc/include/sys/unistd.h b/newlib/libc/include/sys/unistd.h
> index 25532251c..0a31544ed 100644
> --- a/newlib/libc/include/sys/unistd.h
> +++ b/newlib/libc/include/sys/unistd.h
> @@ -26,6 +26,15 @@ int     chown (const char *__path, uid_t __owner, gid_t __group);
>  int     chroot (const char *__path);
>  #endif
>  int     close (int __fildes);
> +#if defined(__CYGWIN__) && (__BSD_VISIBLE || __GNU_VISIBLE)
> +/* Available on FreeBSD (__BSD_VISIBLE) and Linux (__GNU_VISIBLE). */
> +int     close_range (unsigned int __firstfd, unsigned int __lastfd, int __flags);
> +#if __GNU_VISIBLE
> +/* Linux-specific, ignored by Cygwin. */
> +#define CLOSE_RANGE_UNSHARE (1 << 1)
> +#endif
> +#define CLOSE_RANGE_CLOEXEC (1 << 2)
> +#endif
>  #if __POSIX_VISIBLE >= 199209
>  size_t	confstr (int __name, char *__buf, size_t __len);
>  #endif
> diff --git a/winsup/cygwin/cygwin.din b/winsup/cygwin/cygwin.din
> index 9b76ce67a..9e354acc6 100644
> --- a/winsup/cygwin/cygwin.din
> +++ b/winsup/cygwin/cygwin.din
> @@ -347,6 +347,7 @@ clog10l NOSIGFE
>  clogf NOSIGFE
>  clogl NOSIGFE
>  close SIGFE
> +close_range SIGFE
>  closedir SIGFE
>  closelog SIGFE
>  cnd_broadcast SIGFE
> diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/include/cygwin/version.h
> index c8177c2b1..3036878c4 100644
> --- a/winsup/cygwin/include/cygwin/version.h
> +++ b/winsup/cygwin/include/cygwin/version.h
> @@ -484,12 +484,13 @@ details. */
>    347: Add c16rtomb, c32rtomb, mbrtoc16, mbrtoc32.
>    348: Add c8rtomb, mbrtoc.
>    349: Add fallocate.
> +  350: Add close_range.
>  
>    Note that we forgot to bump the api for ualarm, strtoll, strtoull,
>    sigaltstack, sethostname. */
>  
>  #define CYGWIN_VERSION_API_MAJOR 0
> -#define CYGWIN_VERSION_API_MINOR 349
> +#define CYGWIN_VERSION_API_MINOR 350
>  
>  /* There is also a compatibity version number associated with the shared memory
>     regions.  It is incremented when incompatible changes are made to the shared
> diff --git a/winsup/cygwin/release/3.5.0 b/winsup/cygwin/release/3.5.0
> index d0a6c2fc8..6209064a6 100644
> --- a/winsup/cygwin/release/3.5.0
> +++ b/winsup/cygwin/release/3.5.0
> @@ -43,6 +43,8 @@ What's new:
>  
>  - New API calls: c8rtomb, c16rtomb, c32rtomb, mbrtoc8, mbrtoc16, mbrtoc32.
>  
> +- New API call: close_range (available on FreeBSD and Linux).
> +
>  - New API call: fallocate (Linux-specific).
>  
>  - Implement OSS-based sound mixer device (/dev/mixer).
> diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
> index 486db1db6..2e1b56b7f 100644
> --- a/winsup/cygwin/syscalls.cc
> +++ b/winsup/cygwin/syscalls.cc
> @@ -85,6 +85,49 @@ close_all_files (bool norelease)
>    cygheap->fdtab.unlock ();
>  }
>  
> +/* Close or set the close-on-exec flag for all open file descriptors
> +   from firstfd to lastfd.  CLOSE_RANGE_UNSHARE is ignored.
> +   Available on FreeBSD since 13 and Linux since 5.9 */
> +extern "C" int
> +close_range (unsigned int firstfd, unsigned int lastfd, int flags)
> +{
> +  pthread_testcancel ();
> +
> +  if (!(firstfd <= lastfd &&
> +      !(flags & ~(CLOSE_RANGE_UNSHARE | CLOSE_RANGE_CLOEXEC))))
> +    {
> +      set_errno (EINVAL);
> +      return -1;
> +    }
> +
> +  cygheap->fdtab.lock ();
> +
> +  unsigned int size = (lastfd < cygheap->fdtab.size ? lastfd + 1 :
> +		      cygheap->fdtab.size);
> +
> +  for (unsigned int i = firstfd; i < size; i++)
> +    {
> +      cygheap_fdget cfd ((int) i, false, false);
> +      if (cfd < 0)
> +	continue;
> +
> +      if (flags & CLOSE_RANGE_CLOEXEC)
> +	{
> +	  syscall_printf ("set FD_CLOEXEC on fd %u", i);
> +	  cfd->fcntl (F_SETFD, FD_CLOEXEC);
> +	}
> +      else
> +	{
> +	  syscall_printf ("closing fd %u", i);
> +	  cfd->close_with_arch ();
> +	  cfd.release ();
> +	}
> +    }
> +
> +  cygheap->fdtab.unlock ();
> +  return 0;
> +}
> +
>  extern "C" int
>  dup (int fd)
>  {
> diff --git a/winsup/doc/new-features.xml b/winsup/doc/new-features.xml
> index 6ae420031..0abe1c41c 100644
> --- a/winsup/doc/new-features.xml
> +++ b/winsup/doc/new-features.xml
> @@ -74,6 +74,10 @@ posix_spawn_file_actions_addfchdir_np.
>  New API calls: c8rtomb, c16rtomb, c32rtomb, mbrtoc8, mbrtoc16, mbrtoc32.
>  </para></listitem>
>  
> +<listitem><para>
> +New API call: close_range (available on FreeBSD and Linux).
> +</para></listitem>
> +
>  <listitem><para>
>  New API call: fallocate (Linux-specific).
>  </para></listitem>
> diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
> index 151aeb9fe..4ece761a8 100644
> --- a/winsup/doc/posix.xml
> +++ b/winsup/doc/posix.xml
> @@ -1143,6 +1143,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>      cfmakeraw
>      cfsetspeed
>      clearerr_unlocked
> +    close_range
>      daemon
>      dn_comp
>      dn_expand
> @@ -1297,6 +1298,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>      clog10
>      clog10f
>      clog10l
> +    close_range			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
>      crypt_r			(available in external "crypt" library)
>      dladdr			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
>      dremf
> @@ -1655,6 +1657,9 @@ CLOCK_REALTIME and CLOCK_MONOTONIC.  <function>clock_setres</function>,
>  <function>clock_settime</function>, and <function>timer_create</function>
>  currently support only CLOCK_REALTIME.</para>
>  
> +<para><function>close_range</function> ignores the Linux-specific flag
> +CLOSE_RANGE_UNSHARE.</para>
> +
>  <para>POSIX file locks via <function>fcntl</function> or
>  <function>lockf</function>, as well as BSD <function>flock</function> locks
>  are advisory locks.  They don't interact with Windows mandatory locks, nor
> -- 
> 2.42.1
> 

