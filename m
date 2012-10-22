Return-Path: <cygwin-patches-return-7743-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13002 invoked by alias); 22 Oct 2012 08:29:52 -0000
Received: (qmail 12931 invoked by uid 22791); 22 Oct 2012 08:29:41 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Mon, 22 Oct 2012 08:29:15 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 2C0182C02AB; Mon, 22 Oct 2012 10:29:13 +0200 (CEST)
Date: Mon, 22 Oct 2012 08:29:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com, earnie@users.sourceforge.net
Subject: Re: [patch]: Decouple cygwin building from in-tree mingw/w32api building
Message-ID: <20121022082913.GB2469@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com, earnie@users.sourceforge.net
References: <1350545597.3492.59.camel@YAAKOV04> <20121018083419.GC6221@calimero.vinschen.de> <1350580828.3492.73.camel@YAAKOV04> <20121019092135.GA22432@calimero.vinschen.de> <1350664438.3492.114.camel@YAAKOV04> <20121019184636.GZ25877@calimero.vinschen.de> <20121021113320.GA2469@calimero.vinschen.de> <20121021171053.GA24725@ednor.casa.cgf.cx> <1350844361.1244.54.camel@YAAKOV04> <20121022040942.GA9515@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20121022040942.GA9515@ednor.casa.cgf.cx>
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
X-SW-Source: 2012-q4/txt/msg00020.txt.bz2

On Oct 22 00:09, Christopher Faylor wrote:
> On Sun, Oct 21, 2012 at 01:32:41PM -0500, Yaakov (Cygwin/X) wrote:
> >On Sun, 2012-10-21 at 13:10 -0400, Christopher Faylor wrote:
> >>That said, is it time to ask the mingw.org stuff to relocate their CVS
> >>repo?  I could tar up the affected CVS directories for them if so.
> >
> >What about some CVSROOT/modules magic to exclude winsup/mingw and
> >winsup/w32api from a Cygwin checkout?
> >
> >1) change the existing cygwin module to naked-cygwin; 2) add a new
> >cygwin module with "-a src-support naked-cygwin naked-newlib
> >naked-include"; 3) change the directions on cvs.html to "cvs co cygwin"
> >instead of "cvs co winsup" for new checkouts; 4) devs with existing
> >checkouts could just rm -fr winsup/mingw winsup/w32api if they so
> >choose (but with the patch, they won't be used anymore even if
> >present).

That sounds like we need it anyway.  It won't make sense to pack
a src archive with mingw and w32api dirs, if they are not used.

> >As mingw.org already treats winsup/mingw and winsup/w32api as separate
> >repos[1], that should do the trick for us without forcing them to move.
> >Given our long-standing cooperation until now, I think it's the least
> >we could do.
> 
> I wasn't trying to punish anyone.  I actually thought that they probably
> hadn't moved already mainly out of courtesy to us.  I vaguely recall some
> rumbling about this in the past.
> 
> I've cc'ed Earnie to see how he feels about it.
> 
> Earnie, we seem to be transitioning from the need to have a mingw/w32api
> in the source tree.  What do you think about removing these directories
> from the depot and moving repo to sourceforge, or some other place?
> 
> You've got a home for as long as you like on sourceware.org but I was

Yeah, since the changes to the configury separate Cygwin from mingw and
w32api, staying in src/winsup is no problem at all.  I always thought
mingw is part of the src tree for gcc bootstrap reasons.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
