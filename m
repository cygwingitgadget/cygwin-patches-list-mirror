Return-Path: <cygwin-patches-return-7076-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29676 invoked by alias); 6 Sep 2010 13:24:48 -0000
Received: (qmail 29662 invoked by uid 22791); 6 Sep 2010 13:24:46 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Mon, 06 Sep 2010 13:24:12 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 9053C6D435B; Mon,  6 Sep 2010 15:24:09 +0200 (CEST)
Date: Mon, 06 Sep 2010 13:24:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Cygwin Filesystem Performance degradation 1.7.5 vs 1.7.7, and methods for improving performance
Message-ID: <20100906132409.GB14327@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4C84B9EF.9030109@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4C84B9EF.9030109@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q3/txt/msg00036.txt.bz2

Hi Yoni,

On Sep  6 12:52, Yoni Londner wrote:
> Hi,
> 
> Abstract: I prepared a patch that improves Cygwin Filesystem
> performance by x4 on Cygwin 1.7.5 (1.7.5 vanilla 530ms --> 1.7.5
> patched 120ms). I ported the patch to 1.7.7, did tests, and found
> out that 1.7.7 had a very serious 9x (!) performance degradation
> from 1.7.5 (1.7.5 vanilla 530ms --> 1.7.7 vanilla 3900ms --> 1.7.7
> patched 3500ms), which does makes this patch useless until the
> performance degradation is fixed.

The problem is, I can't reproduce such a degradation.  If I run sometimg
like `time ls -l /bin > /dev/null', the times are very slightly better
with 1.7.7 than with 1.7.5 (without caching effect 1200ms vs. 1500ms,
with caching effect 500ms vs. 620ms on average).  Starting with 1.7.6,
Cygwin reused handles from symlink_info::check in stat() and other
syscalls.  If there is such degradation under some circumstances, I need
a reproducible scenario, or at least some strace output which shows at
which point this happens.  Apart from actual patches this should be
discussed on the cygwin-developer list.

> =======================================================================
> My patch:
> ------------

First of all, your patch is very certainly significant in terms of code
size.  If you want to contribute code from it, we need a signed copyright
assignment from you.  See http://cygwin.com/contrib.html, the "Before you
get started" section.

The patch is also missing a ChangeLog entry.  I only took a quick glance
over the patch itself.  The code doesn't look correctly formatted in GNU
style.  Also, using the diff -up flags would be helpful.

> So I did some performace test on Cygwin 1.7.5, and found out the
> biggest bottleneck were:
> 
> - CreateFile()/CloseHandle() on syscalls that only need file node
> info retrival, not file contents retrival (such as stat()). This can
> be solved by calling Win32 that do not open the File handle itself,
> rather query by name, or opening the directory handle (which is MUCH
> faster).

That's what I tried to speed up in 1.7.6 by keeping the handle from
symlink_info::check for reuse in stat.

> - repetitive Win32 Kernel calls on a single syscall (stat() would
> call up to 5 CreateFile/CloseHandle pairs plus another additional 5
> to 10 Win32 APIs).
> on stat() system calls, managed to improve the performance of ls
> approx. by 4 times. This can be solved by caching: first time in a
> syscall the API is called the result is stored, so the second time
> the info is needed, it is re-used.

I agree.  We could use caching fileinfo more extensively, though carefully,
at least for the time of a single syscall.

> - ACLs: Windows is not a secure system. And its ACL model is strange
> to say the least... Most cygwin users do not use the unix
> permissions system on cygwin to achieve security. All they want is
> that the unix tools will run on Windows.

I don't agree.  Windows is a secure system on the file level if users
use the ACLs correctly.  It's not exactly a strange model, it's just
unnecessarily complicated for home users.  However, in corporate
environments it's utilized a lot.

Besides, I made some performance tests myself before 1.7.6, and it
turned out that the ACL checks for testing the POSIX permission bits
are really not the problem.  The problem was that ls(1) had a test which
resulted in calling getacl() twice, just to print the '+' character
attached to the POSIX permission bits in `ls -l' output.  That should
have gotten slightly better with the latest coreutils.

Other than that, just use the "noacl" mount option if you don't like to
be bothered with Windows ACLs or, FWIW, POSIX-like permissions.

> - stat inode number and inode link count: getting the inode in
> Windows requires a File handle or Directory handle (not possible to
> get inode by file name). Very few applications actually need a REAL
> inode number. So using the 'get file info by name' apis are used
> (and of course there is an envirnoment if you really want real inode
> numbers).

Just use the "ihash" mount option if you don't like to use real inode
numbers.  However, you don't see hardlinks anymore.

I don't like the idea to extend the CYGWIN environment variable with
this functionality at all.  I also don't like the idea that these
settings are on by default.  So by default you're trading correctness
(in a POSIX sense) for speed.  Speed is all well and nice, but it
shouldn't be handled more important than correctness.

There are certainly other ways to improve Cygwin's performance, which
don't trade in correctness in the first place.  We should more
concentrate on intelligent caching of file info and handles.

> - GetVolumeInfo: The C:\ drive does not tend to be changed every
> millisecond! Therefore no reason for every filesystem syscall to
> call it. Caching this further increased the performance.

Does your FS caching take volume mount points into account?

> - File security check: GetSecurityInfo() is implemented in Windows
> in usermode dll (Advapi32.dll). It calls at the end
> NtQuerySecurityObject(). So I implemented a faster version:
> zGetSecurityInfo() which does the same... just faster.

Does your code preserve the inheritance entries which are available via
GetSecurityInfo?  Note that I don't care at all for the GetSecurityInfo
API from a usage POV.  I would prefer to use NtQuerySecurityObject
directly.  However, the sole reason for using GetSecurityInfo is the
fact that NtQuerySecurityObject only returns the plain ACL as it's
stored for the file.  It does not return the ACEs which are inherited
from the parent objects.  These are only available via GetSecurityInfo,
or by checking the parent ACLs manually.

> - symbolic link files: Opening a file and reading its contents is an
> expensive operation. All file cygwin operations must check whether
> the file is a symbolic link or not, which is done by opening the
> file and reading its contents and checking whether it has the
> symlink magic at the beginning of this. Since symbolic link must be

That's not correct.  It only opens files which have cetain DOS flags
set.  Symlinks are either files with a SYSTEM DOS flag, or .lnk files
with the R/O DOS flag set, or reparse points.  So your extension for
the test might help a tiny little bit, but since the SYSTEM attribute
is only rarely set on file which are not Cygwin symlinks, it's a very
rare operation.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
