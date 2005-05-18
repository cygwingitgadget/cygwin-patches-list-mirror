Return-Path: <cygwin-patches-return-5466-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11245 invoked by alias); 18 May 2005 13:50:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11185 invoked from network); 18 May 2005 13:50:07 -0000
Received: from unknown (HELO dessent.net) (66.17.244.20)
  by sourceware.org with SMTP; 18 May 2005 13:50:07 -0000
Received: from localhost ([127.0.0.1] helo=dessent.net)
	by dessent.net with esmtp (Exim 4.44)
	id 1DYOvy-00024i-Iw
	for cygwin-patches@cygwin.com; Wed, 18 May 2005 13:50:05 +0000
Message-ID: <428B480D.E465C6E8@dessent.net>
Date: Wed, 18 May 2005 13:50:00 -0000
From: Brian Dessent <brian@dessent.net>
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [patch] gcc4 fixes
References: <428A7520.7FD9925C@dessent.net> <20050518080133.GA25438@calimero.vinschen.de> <20050518133417.GB19793@trixie.casa.cgf.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2005-q2/txt/msg00062.txt.bz2

Christopher Faylor wrote:

> >While this might help to avoid... something, I'm seriously wondering
> >what's wrong with this expression.  Why does each new version of gcc
> >add new incompatibilities?
> 
> Well, it might actually be "a gcc bug".

Here I admit to using a snapshot verion of gcc and not the 4.0 release,
primarily because I had read of bug reports e.g. KDE blacklisting 4.0
entirely in their build scripts due to compiler problems.  So who knows,
maybe I should try with a release build.

$ g++-4 -v
Using built-in specs.
Target: i686-pc-cygwin
Configured with: ../gcc-4.1-20050501/configure --verbose
--prefix=/usr/local --exec-prefix=/usr/local --sysconfdir=/etc
--libdir=/usr/local/lib --libexecdir=/usr/local/lib
--mandir=/usr/local/man --infodir=/usr/local/info --program-suffix=-4
--enable-languages=c,c++ --disable-nls --without-included-gettext
--with-system-zlib --enable-interpreter --enable-threads=posix
--enable-sjlj-exceptions --disable-version-specific-runtime-libs
--disable-win32-registry
Thread model: posix
gcc version 4.1.0 20050501 (experimental)

Brian
