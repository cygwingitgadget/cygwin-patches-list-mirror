Return-Path: <cygwin-patches-return-7107-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15923 invoked by alias); 14 Sep 2010 09:39:17 -0000
Received: (qmail 15880 invoked by uid 22791); 14 Sep 2010 09:39:07 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 14 Sep 2010 09:39:02 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B91416D435B; Tue, 14 Sep 2010 11:38:59 +0200 (CEST)
Date: Tue, 14 Sep 2010 09:39:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Cygwin Filesystem Performance degradation 1.7.5 vs 1.7.7, and methods for improving performance
Message-ID: <20100914093859.GB15121@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4C84B9EF.9030109@gmail.com> <20100906132409.GB14327@calimero.vinschen.de> <4C8E0EED.4000606@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4C8E0EED.4000606@gmail.com>
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
X-SW-Source: 2010-q3/txt/msg00067.txt.bz2

On Sep 13 13:45, Yoni Londner wrote:
> Hi,
> 
> >> Abstract: I prepared a patch that improves Cygwin Filesystem
> >> performance by x4 on Cygwin 1.7.5 (1.7.5 vanilla 530ms -->  1.7.5
> >> patched 120ms). I ported the patch to 1.7.7, did tests, and found
> >> out that 1.7.7 had a very serious 9x (!) performance degradation
> >> from 1.7.5 (1.7.5 vanilla 530ms -->  1.7.7 vanilla 3900ms -->  1.7.7
> >> patched 3500ms), which does makes this patch useless until the
> >> performance degradation is fixed.
> >
> > The problem is, I can't reproduce such a degradation.  If I run sometimg
> > like `time ls -l /bin>  /dev/null', the times are very slightly better
> > with 1.7.7 than with 1.7.5 (without caching effect 1200ms vs. 1500ms,
> > with caching effect 500ms vs. 620ms on average).  Starting with 1.7.6,
> > Cygwin reused handles from symlink_info::check in stat() and other
> > syscalls.  If there is such degradation under some circumstances, I need
> > a reproducible scenario, or at least some strace output which shows at
> > which point this happens.  Apart from actual patches this should be
> > discussed on the cygwin-developer list.
> >
> 
> First of all, even your results of 1200-1500ms (1st time) and
> 500-600ms (2nd time) is still way way way too long. On linux with an
> NTFS mount of C:/cygwin, this took <2ms!
> 
> And even on Win32 CMD.EXE this same operation will take you less
> than 100ms. which is 5x to 10x faster.
> 
> The main reason for the difference: the Windows CMD.EXE does not
> open file handles, which make the NTFS file system to actually go
> and read each file's first 16KB of contents (even though you did not
> ask for it!).

I'm not exactly concerned about Linux being way faster accessing an NTFS
drive.  After all it's the OS itself and comes with it's own NTFS driver
which obviously is streamlined for typical POSIX operations.

And then there's Win32 which can go through a dir much faster as well,
since it doesn't have to care for POSIX compatibility of the result, and
the OS function calls coincidentally match what a cmd "dir" call needs.

If you're looking for a fair comparision, why don't you look for
Interix?  I did, and what I see is pretty much the same thing we do in
Cygwin.  Actually, with the last Cygwin from CVS an ls -lR on a
non-marginal directory tree is already faster than the same operation
under Interix.

That doesn't mean I won't look for more ways to enhance Cygwin's
performance, but it won't be by adding CYGWIN environment switches
or by neglecting correct information in stat.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
