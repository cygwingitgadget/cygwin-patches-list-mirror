Return-Path: <cygwin-patches-return-6139-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32667 invoked by alias); 6 Sep 2007 18:34:02 -0000
Received: (qmail 32188 invoked by uid 22791); 6 Sep 2007 18:33:32 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-174-251-188.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (71.174.251.188)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 06 Sep 2007 18:33:27 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 789852B35A; Thu,  6 Sep 2007 14:33:25 -0400 (EDT)
Date: Thu, 06 Sep 2007 18:34:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] Fix multithreaded snprintf
Message-ID: <20070906183325.GA19790@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <46E04739.F0B0D169@dessent.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46E04739.F0B0D169@dessent.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q3/txt/msg00014.txt.bz2

On Thu, Sep 06, 2007 at 11:30:17AM -0700, Brian Dessent wrote:
>
>I tracked down the problem reported in
><http://www.cygwin.com/ml/cygwin/2007-09/msg00120.html>.  The crash was
>occuring in pthread_mutex_lock, but that's a bit of a red herring.  The
>real problem is that both newlib and Cygwin provide a
>include/sys/stdio.h file, however they were out of sync with regard to
>the _flockfile definition.
>
>This comes about because vsnprintf() is implemented by creating a struct
>FILE that represents the string buffer and then this is passed to the
>standard vfprintf().  The 'flags' member of this FILE has the __SSTR
>flag set to indicate that this is just a string buffer, and consequently
>no locking should or can be performed; the lock member isn't even
>initialized.
>
>The newlib/libc/include/sys/stdio.h therefore has this:
>
>#if !defined(_flockfile)
>#ifndef __SINGLE_THREAD__
>#  define _flockfile(fp) (((fp)->_flags & __SSTR) ? 0 :
>__lock_acquire_recursive((fp)->_lock))
>#else
>#  define _flockfile(fp)
>#endif
>#endif
>
>#if !defined(_funlockfile)
>#ifndef __SINGLE_THREAD__
>#  define _funlockfile(fp) (((fp)->_flags & __SSTR) ? 0 :
>__lock_release_recursive((fp)->_lock))
>#else
>#  define _funlockfile(fp)
>#endif
>#endif
>
>However, the Cygwin version of this header with the same name gets
>preference and doesn't know to check the flags like this, and thus
>unconditionally tries to lock the stream.  This leads ultimately to a
>crash in pthread_mutex_lock because the lock member is just
>uninitialized junk.
>
>The attached patch fixes Cygwin's copy of the header and makes the
>poster's testcase function as expected.  This only would appear in a
>multithreaded program because the __cygwin_lock_* functions expand to
>no-op in the case where there's only one thread.
>
>Since this is used in a C++ file (syscalls.cc) I couldn't do the "test ?
>0 : func()" idiom where void is the return type as that generates a
>compiler error, so I use an 'if'.

Thanks for the patch.

Go ahead and check this in but could you add a comment indicating that
this part of include/sys/stdio.h has to be kept in sync with newlib?

Nice catch!

cgf
