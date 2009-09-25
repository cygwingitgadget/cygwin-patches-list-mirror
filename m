Return-Path: <cygwin-patches-return-6640-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28948 invoked by alias); 25 Sep 2009 08:16:42 -0000
Received: (qmail 28937 invoked by uid 22791); 25 Sep 2009 08:16:41 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 25 Sep 2009 08:16:36 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 618696D55B9; Fri, 25 Sep 2009 10:16:26 +0200 (CEST)
Date: Fri, 25 Sep 2009 08:16:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [1.7] rename/renameat error
Message-ID: <20090925081626.GB26348@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20090907192046.GA12492@calimero.vinschen.de> <loom.20090909T005422-847@post.gmane.org> <loom.20090909T183010-83@post.gmane.org> <loom.20090922T225033-801@post.gmane.org> <4ABA1B92.9080406@byu.net> <20090923133015.GA16976@calimero.vinschen.de> <20090923140905.GA2527@ednor.casa.cgf.cx> <20090923160846.GA18954@calimero.vinschen.de> <20090923164127.GB3172@ednor.casa.cgf.cx> <4ABC39A1.1060702@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ABC39A1.1060702@byu.net>
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
X-SW-Source: 2009-q3/txt/msg00094.txt.bz2

On Sep 24 21:31, Eric Blake wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> According to Christopher Faylor on 9/23/2009 10:41 AM:
> >> Also less risky would be to make changes locally in mkdir, link, and
> >> rename for now.
> 
> Done - this patch narrows the scope of the changes to just the interfaces
> in question.  I've also tested that it made it through the coreutils
> testsuite without any regressions.
> 
> > 
> > I'm not clear if this is a regression or not.  If it isn't a regression,
> > I'd opt for leaving it until 1.7.2.
> 
> Now that I'm not touching path.cc, these are all much more self-contained,
> and make cygwin more consistent with Linux.  For example:
> 
> touch a
> ln -s c b
> link a b/
> 
> should fail because b/ is not an existing directory, but without this
> patch, it succeeds and creates the regular file c as a link to a.
> 
> 2009-09-24  Eric Blake  <ebb9@byu.net>
> 
> 	* syscalls.cc (link): Delete obsolete comment.  Reject directories
> 	and missing source up front.
> 	(rename): Use correct errno for trailing '.'.  Allow trailing
> 	slash to newpath iff oldpath is directory.
> 	* dir.cc (mkdir): Reject dangling symlink with trailing slash.
> 	* fhandler_disk_file.cc (fhandler_disk_file::link): Reject
> 	trailing slash.
> 	* fhandler.cc (fhandler_base::link): Match Linux errno.

Looks good to me.  Chris?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
