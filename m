Return-Path: <cygwin-patches-return-6665-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19425 invoked by alias); 30 Sep 2009 15:37:08 -0000
Received: (qmail 19413 invoked by uid 22791); 30 Sep 2009 15:37:07 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 30 Sep 2009 15:37:03 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 2179A6D5598; Wed, 30 Sep 2009 17:36:53 +0200 (CEST)
Date: Wed, 30 Sep 2009 15:37:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: detect . in a/.//
Message-ID: <20090930153652.GO7193@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4AC34A01.4070509@byu.net> <20090930152438.GA11977@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090930152438.GA11977@ednor.casa.cgf.cx>
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
X-SW-Source: 2009-q3/txt/msg00119.txt.bz2

On Sep 30 11:24, Christopher Faylor wrote:
> On Wed, Sep 30, 2009 at 06:07:29AM -0600, Eric Blake wrote:
> >-----BEGIN PGP SIGNED MESSAGE-----
> >Hash: SHA1
> >
> >My testing on rename found another corner case: we rejected
> >rename("dir","a/./") but accepted rename("dir","a/.//").  OK to commit?
> >
> >For reference, the test I am writing for hammering rename() and renameat()
> >corner cases is currently visible here; it will be part of the next
> >coreutils release, among other places.  It currently stands at 400+ lines,
> >and exposes bugs in NetBSD, Solaris 10, mingw, and cygwin 1.5, but passes
> >on cygwin 1.7 (after this patch) and on Linux:
> >http://repo.or.cz/w/gnulib/ericb.git?a=blob;f=tests/test-rename.h
> >
> >2009-09-30  Eric Blake  <ebb9@byu.net>
> >
> >	* path.cc (has_dot_last_component): Detect "a/.//".
> 
> No, I don't think so.  I don't think this function is right.  It
> shouldn't be doing a strrchr(dir, '//).

How is it supposed to find the last path component?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
