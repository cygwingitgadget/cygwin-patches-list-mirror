Return-Path: <cygwin-patches-return-7726-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8434 invoked by alias); 17 Oct 2012 17:05:35 -0000
Received: (qmail 8380 invoked by uid 22791); 17 Oct 2012 17:05:24 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Wed, 17 Oct 2012 17:05:16 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 802F22C0469; Wed, 17 Oct 2012 19:05:14 +0200 (CEST)
Date: Wed, 17 Oct 2012 17:05:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch]: Decouple cygwin building from in-tree mingw/w32api building
Message-ID: <20121017170514.GD10578@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAEwic4ZBrjVPDV1Y3tc6r7baGzxNbrjgj1MUgse6zYSMHiCUhQ@mail.gmail.com> <20121017164440.GA12989@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20121017164440.GA12989@ednor.casa.cgf.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q4/txt/msg00003.txt.bz2

On Oct 17 12:44, Christopher Faylor wrote:
> On Wed, Oct 17, 2012 at 06:13:18PM +0200, Kai Tietz wrote:
> >-[ "$dir" = '/' ] && dir=''
> >+[ "$dir" = '/' ] && dir='';
> 
> No need for a semicolon here.
> 
> I have other comments but I wonder if it would just be best to scrap this
> script and assume that there is a mingw compiler installed.  When I first
> wrote this script there was no mingw compiler in the distro.  Now there
> is.  So I think we should just make that a requirement for building.

When I told Kai what to do I was always grumpy about requiring a
non-cygwin compiler to build parts of Cygwin.  That's why this
mingw script allows to build with a mingw64, a mingw32 or a cygwin
compiler.

But it really looks like the easiest solution is to require a mingw
compiler since the mingw headers and libs have to be installed anyway.

That just requires to change configure.in to test for a
${cpu}-w64-mingw32 compiler and to define MINGW_CXX accordingly, afaics.

> Then, no more head standing is required.
> 
> >Index: winsup/Makefile.common
> >===================================================================
> >RCS file: /cvs/src/src/winsup/Makefile.common,v
> >retrieving revision 1.59
> >diff -p -u -3 -r1.59 Makefile.common
> >--- winsup/Makefile.common	30 Jul 2012 04:43:21 -0000	1.59
> >+++ winsup/Makefile.common	17 Oct 2012 15:21:32 -0000
> 
> Can we just get rid of this as well?  That's what I did in my now-unneeded
> revamp of the configury in the cygwin git repository.
> 
> I think I'd rather just move everything into winsup, cygserver, utils and
> not bother with this "common" stuff.

But it's still a nice way to have certain definitions only once.
The BSD build systems use something similar.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
