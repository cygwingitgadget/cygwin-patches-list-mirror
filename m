Return-Path: <cygwin-patches-return-6266-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15102 invoked by alias); 9 Mar 2008 09:51:38 -0000
Received: (qmail 15092 invoked by uid 22791); 9 Mar 2008 09:51:37 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Sun, 09 Mar 2008 09:51:12 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id CFB1E6D430A; Sun,  9 Mar 2008 10:51:09 +0100 (CET)
Date: Sun, 09 Mar 2008 09:51:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] cygcheck.cc update for cygpath()
Message-ID: <20080309095109.GX18407@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <47D2E28C.3FC392D3@dessent.net> <20080308212718.GB5863@ednor.casa.cgf.cx> <47D3550B.76D34355@dessent.net> <20080309032437.GB6777@ednor.casa.cgf.cx> <47D36406.F7D7AB61@dessent.net> <20080309092806.GW18407@calimero.vinschen.de> <47D3B079.C8BA614C@dessent.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47D3B079.C8BA614C@dessent.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00040.txt.bz2

On Mar  9 01:40, Brian Dessent wrote:
> Corinna Vinschen wrote:
> 
> > Given that Cygwin changes to support long path names, I don't really
> > like to see new code still using MAX_PATH and Win32 Ansi functions
> > in the utils dir.
> 
> Regardless of this patch, path.cc:rel_vconcat() currently uses
> GetCurrentDirectory() to resolve relative paths.  

Yup, that's why I said "new code".  The existing code simply didn't have
that problem.  I just think it would be a waste to introduce new code
which sticks to the old ways.

> > Bash as well as tcsh, as well as zsh (and probbaly pdksh, too) create an
> > environment variable $PWD.  Maybe Cygwin should create $PWD for native
> > apps if it's not already available through the parent shell.  I'd
> > suggest that the Cygwin utils first try to fetch $PWD from the
> > environment and use that as cwd.  Only if that fails, use
> > GetCurrentDirectory.
> 
> I will work on a patch that both adds an interface to allow the caller
> to supply a CWD as well as trying to use $PWD to get the value
> otherwise.

Cool, thank you!

> > Never use SetCurrentDirectory, rather convert the path to an absolute
> > path, prepend \\?\ and call the Win32 unicode functions (CreateFileW,
> > etc).
> 
> Setting the CWD can be totally avoided I think, by the above replumbing.
> 
> > SYMLINK_MAX is PATH_MAX - 1 == 4095.
> > 
> > I'm wondering if you would like to tweak the readlink functions, too.
> > Cygwin shortcuts can now have the path name appended to the actual
> > shortcut data.  This hack was necessary to support pathnames longer than
> > 2000 chars.  See the comment and code in cygwin/path.cc, line 3139ff.
> 
> Oh, I didn't know that.  I'll add that to the list.

Thanks again.  I'm finally seeing light at the end of the long path
name tunnel :)


Have a nice weekend,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
