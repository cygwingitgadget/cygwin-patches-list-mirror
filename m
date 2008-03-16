Return-Path: <cygwin-patches-return-6307-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11031 invoked by alias); 16 Mar 2008 16:08:10 -0000
Received: (qmail 11010 invoked by uid 22791); 16 Mar 2008 16:08:09 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Sun, 16 Mar 2008 16:07:51 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 473146D430A; Sun, 16 Mar 2008 17:07:49 +0100 (CET)
Date: Sun, 16 Mar 2008 16:08:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] normalize_posix_path and c:/foo/bar
Message-ID: <20080316160749.GD19345@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <47DCCAFF.36C14CB@dessent.net> <20080316151557.GC29148@calimero.vinschen.de> <47DD4212.86606B25@dessent.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47DD4212.86606B25@dessent.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00081.txt.bz2

On Mar 16 08:51, Brian Dessent wrote:
> Corinna Vinschen wrote:
> 
> > Actually that was intended, but unfortunately the current path handling
> > deliberately creates DOS paths with slashes (in find_exec) right now,
> > so that doesn't work ATM.
> 
> I guess what I don't understand is how it's both possible for
> open("c:/foo/bar.exe") to succeed and for this code to treat it as a
> relative posix path instead of absolute win32.  Or is that the point,
> that forward-slash win32 paths are intended not to work?

That was my point originally but I gave up on it.  I thought it might
be a good idea to recognize a path as Win32 path only if it starts
with x:\ or \, because "a:" could be a perfectly valid POSIX file or
directory name.  In the latter case a:/foo could be the file foo in
$cwd/a:/foo.  I'd still like to see it hanbdled that way, but that's
probably taking it a step too far...

> is going to be quite a lot of affected code unfortunately... as I said
> the only real reason I went looking here is I updated my tree to current
> CVS and insight stopped functioning.

I found it by calling `make x':

  $ make x
  make: cc: Nosuch file or directory.

:-P


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
