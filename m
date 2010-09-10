Return-Path: <cygwin-patches-return-7093-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17184 invoked by alias); 10 Sep 2010 21:44:03 -0000
Received: (qmail 17158 invoked by uid 22791); 10 Sep 2010 21:43:54 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-46-163.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.46.163)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 10 Sep 2010 21:43:49 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id EFF2113C061	for <cygwin-patches@cygwin.com>; Fri, 10 Sep 2010 17:43:47 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id E4FBE2B352; Fri, 10 Sep 2010 17:43:47 -0400 (EDT)
Date: Fri, 10 Sep 2010 21:44:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add fenv.h and support.
Message-ID: <20100910214347.GA23700@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4C8A9AC8.7070904@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4C8A9AC8.7070904@gmail.com>
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
X-SW-Source: 2010-q3/txt/msg00053.txt.bz2

On Fri, Sep 10, 2010 at 09:53:28PM +0100, Dave Korn wrote:
>
>
>    Hi folks,
>
>  This patch adds fenv.h and the related support routines in the Cygwin DLL.
>It's an entirely unencumbered implementation that I wrote from scratch using
>only the public docs for reference.  We've been missing this for a while, what
>with PR323 and all, and if we add it in we'll be able to switch on the new
>decimal-floating-point features in the compiler.  (Amongst I'm sure many other
>uses).
>
>winsup/cygwin/ChangeLog:
>
>	* Makefile.in (DLL_OFILES): Add new fenv.o module.
>	(fenv_CFLAGS): New flags definition for fenv.o compile.
>	* autoload.cc (std_dll_init): Use fenv.h functions instead of direct
>	manipulation of x87 FPU registers.
>	* crt0.c (mainCRTStartup): Likewise.
>	* cygwin.din (feclearexcept, fegetexceptflag, feraiseexcept,
>	fesetexceptflag, fetestexcept, fegetround, fesetround, fegetenv,
>	feholdexcept, fesetenv, feupdateenv, fegetprec, fesetprec,
>	feenableexcept, fedisableexcept, fegetexcept, _feinitialise,
>	_fe_dfl_env, _fe_nomask_env): Export new functions and data items.
>	* fenv.cc: New file.
>	* posix.sgml: Update status of newly-implemented APIs.
>	* include/fenv.h: Likewise related header.
>	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.
>
>  Testing: well, I'm running the GCC testsuite against it to verify it builds
>functioning decimal floating point code, and I've manually tested some of the
>simple functionality like setting the exceptions on and off.  That's all so
>far, but I think it's close enough (and given that it's new functionality) to
>check in and fix any bugs that crop up on HEAD.  (I'd like to also see if I
>can run some of the LSB or Posix verification testsuites against it, but I
>don't know what's involved in that yet; if anyone has any experience with any
>of that stuff, I'd appreciate being dropped a note off-list with a few pointers.)

Looks nice to me with one HUGE caveat:  Please maintain the pseudo-sorted
order in cygwin.din.  Sorry to have to impose this burden on you.

Other than that, please check in and thanks for the patch.  It was obviously
a lot of work.

cgf
