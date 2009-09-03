Return-Path: <cygwin-patches-return-6614-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28044 invoked by alias); 3 Sep 2009 21:04:59 -0000
Received: (qmail 28030 invoked by uid 22791); 3 Sep 2009 21:04:58 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 03 Sep 2009 21:04:53 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 60A686D55B9; Thu,  3 Sep 2009 23:04:39 +0200 (CEST)
Date: Thu, 03 Sep 2009 21:04:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [1.7] bugs in faccessat
Message-ID: <20090903210438.GA25677@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <loom.20090903T175736-252@post.gmane.org> <4AA01449.6060707@byu.net> <20090903191856.GB3998@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090903191856.GB3998@ednor.casa.cgf.cx>
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
X-SW-Source: 2009-q3/txt/msg00068.txt.bz2

On Sep  3 15:18, Christopher Faylor wrote:
> On Thu, Sep 03, 2009 at 01:08:57PM -0600, Eric Blake wrote:
> >-----BEGIN PGP SIGNED MESSAGE-----
> >Hash: SHA1
> >
> >According to Eric Blake on 9/3/2009 9:58 AM:
> >> faccessat has at least two, and probably three bugs.
> >
> >Here's a fix for 1 (typo) and 3 (check for EINVAL in more places), but not
> >for 2 (euidaccess, and the followup request of lchmod).
> >
> >2009-09-03  Eric Blake  <ebb9@byu.net>
> >
> >	* syscalls.cc (faccessat): Fix typo, reject bad flags.
> >	(fchmodat, fchownat, fstatat, utimensat, linkat, unlinkat): Reject
> >	bad flags.
> >
> >diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
> >index 3798587..6dee7d3 100644
> >--- a/winsup/cygwin/syscalls.cc
> >+++ b/winsup/cygwin/syscalls.cc
> >@@ -3825,7 +3825,8 @@ faccessat (int dirfd, const char *pathname, int mode, int flags)
> >   char *path = tp.c_get ();
> >   if (!gen_full_path_at (path, dirfd, pathname))
> >     {
> >-      if (flags & ~(F_OK|R_OK|W_OK|X_OK))
> >+      if ((mode & ~(F_OK|R_OK|W_OK|X_OK))
> >+	  || (flags & ~(AT_SYMLINK_NOFOLLOW|AT_EACCESS)))
> 
> It's hard to tell from the patch.  Is this properly aligned?  The || should be under the
> (mode.
> 
> With that minor comment please check in.

Thanks for the patches Eric, but, here's a problem.  We still have no
copyright assignment in place from you.  The fcntl patch is barely
trivial, but the faccessat patch certainly isn't anymore.  Would it
be a big problem for you to send the filled out copyright assignemnt form
from http://cygwin.com/assign.txt to Red Hat ASAP?  With any luck it
will have arrived and will be signed before I'm back from vacation.


Thanks in advance,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
