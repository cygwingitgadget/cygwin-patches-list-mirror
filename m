Return-Path: <cygwin-patches-return-6261-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30756 invoked by alias); 9 Mar 2008 08:45:22 -0000
Received: (qmail 30742 invoked by uid 22791); 9 Mar 2008 08:45:22 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Sun, 09 Mar 2008 08:44:55 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 244866D430A; Sun,  9 Mar 2008 09:44:52 +0100 (CET)
Date: Sun, 09 Mar 2008 08:45:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] utils/path.cc fixes and testsuite
Message-ID: <20080309084452.GV18407@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <47D2E28C.3FC392D3@dessent.net> <20080308212718.GB5863@ednor.casa.cgf.cx> <47D3550B.76D34355@dessent.net> <20080309032437.GB6777@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080309032437.GB6777@ednor.casa.cgf.cx>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00035.txt.bz2

On Mar  8 22:24, Christopher Faylor wrote:
> On Sat, Mar 08, 2008 at 07:10:03PM -0800, Brian Dessent wrote:
> >Index: Makefile.in
> >===================================================================
> >RCS file: /cvs/src/src/winsup/utils/Makefile.in,v
> >retrieving revision 1.69
> >diff -u -p -r1.69 Makefile.in
> >--- Makefile.in	8 Mar 2008 17:52:49 -0000	1.69
> >+++ Makefile.in	9 Mar 2008 03:01:17 -0000
> >@@ -99,10 +99,23 @@ else
> > all: warn_cygcheck_zlib
> > endif
> > 
> >-# the rest of this file contains generic rules
> >-
> > all: Makefile $(CYGWIN_BINS) $(MINGW_BINS)
> > 
> >+# test harness support (note: the "MINGW_BINS +=" should come after the
> >+# "all:" above so that the testsuite is not run for "make" but only
> >+# "make check".)
> >+MINGW_BINS += testsuite.exe

Doesn't that install testsuite.exe at `make install' time?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
