Return-Path: <cygwin-patches-return-6265-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12450 invoked by alias); 9 Mar 2008 09:40:36 -0000
Received: (qmail 12439 invoked by uid 22791); 9 Mar 2008 09:40:36 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 09 Mar 2008 09:40:09 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1JYI0m-000450-2k 	for cygwin-patches@cygwin.com; Sun, 09 Mar 2008 09:40:08 +0000
Message-ID: <47D3B079.C8BA614C@dessent.net>
Date: Sun, 09 Mar 2008 09:40:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [patch] cygcheck.cc update for cygpath()
References: <47D2E28C.3FC392D3@dessent.net> <20080308212718.GB5863@ednor.casa.cgf.cx> <47D3550B.76D34355@dessent.net> <20080309032437.GB6777@ednor.casa.cgf.cx> <47D36406.F7D7AB61@dessent.net> <20080309092806.GW18407@calimero.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00039.txt.bz2

Corinna Vinschen wrote:

> Given that Cygwin changes to support long path names, I don't really
> like to see new code still using MAX_PATH and Win32 Ansi functions
> in the utils dir.

Regardless of this patch, path.cc:rel_vconcat() currently uses
GetCurrentDirectory() to resolve relative paths.  It would be nice if
rel_vconcat() (or really, cygpath()) had an interface that let the
caller supply a CWD instead, as that would bypass the whole issue of
length since what this patch is doing is simply setting CWD just so that
rel_vconcat() can then get it again.  I thought about doing it that way
but it seemed more invasive.

> I know that the Win32 cwd is always restricted to
> 259 chars.  However, there *is* a way to recognize the current working
> directory of the parent Cygwin application.
> 
> Bash as well as tcsh, as well as zsh (and probbaly pdksh, too) create an
> environment variable $PWD.  Maybe Cygwin should create $PWD for native
> apps if it's not already available through the parent shell.  I'd
> suggest that the Cygwin utils first try to fetch $PWD from the
> environment and use that as cwd.  Only if that fails, use
> GetCurrentDirectory.

I will work on a patch that both adds an interface to allow the caller
to supply a CWD as well as trying to use $PWD to get the value
otherwise.

> Never use SetCurrentDirectory, rather convert the path to an absolute
> path, prepend \\?\ and call the Win32 unicode functions (CreateFileW,
> etc).

Setting the CWD can be totally avoided I think, by the above replumbing.

> SYMLINK_MAX is PATH_MAX - 1 == 4095.
> 
> I'm wondering if you would like to tweak the readlink functions, too.
> Cygwin shortcuts can now have the path name appended to the actual
> shortcut data.  This hack was necessary to support pathnames longer than
> 2000 chars.  See the comment and code in cygwin/path.cc, line 3139ff.

Oh, I didn't know that.  I'll add that to the list.

Brian
