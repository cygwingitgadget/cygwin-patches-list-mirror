Return-Path: <cygwin-patches-return-5971-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21993 invoked by alias); 29 Aug 2006 16:49:12 -0000
Received: (qmail 21965 invoked by uid 22791); 29 Aug 2006 16:49:11 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Tue, 29 Aug 2006 16:49:09 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id AD4506D429F; Tue, 29 Aug 2006 18:49:06 +0200 (CEST)
Date: Tue, 29 Aug 2006 16:49:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com, gdb-patches@sourceware.org
Cc: mingw-patches@lists.sourceforge.net, binutils@sourceware.org, 	gcc-patches@gcc.gnu.org
Subject: Re: [RFC] Simplify MinGW canadian crosses
Message-ID: <20060829164906.GC21260@calimero.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com, gdb-patches@sourceware.org, 	mingw-patches@lists.sourceforge.net, binutils@sourceware.org, 	gcc-patches@gcc.gnu.org
References: <20060829114107.GA17951@calimero.vinschen.de> <20060829124525.GA13245@nevyn.them.org> <200608291459.k7TExRDT026512@greed.delorie.com> <20060829150948.GA18308@nevyn.them.org> <20060829153540.GA20893@calimero.vinschen.de> <20060829154718.GB17552@trixie.casa.cgf.cx> <20060829160406.GB21260@calimero.vinschen.de> <20060829160923.GB20830@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060829160923.GB20830@nevyn.them.org>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00066.txt.bz2

On Aug 29 12:09, Daniel Jacobowitz wrote:
> On Tue, Aug 29, 2006 at 06:04:06PM +0200, Corinna Vinschen wrote:
> > On Aug 29 11:47, Christopher Faylor wrote:
> > > Btw, I agree with Daniel's suggestion of using
> > > ../config/no-executables.m4 if that's possible.
> > 
> > I did that first, but the argument against this is that the
> > mingw-runtime package, does not contain a top-level config directory.
> > The source tree is supposed to be built stand-alone.  Therefore it's
> > required to have a stand-alone aclocal.m4 file.
> > 
> > [time passes]
> > 
> > Or do you mean I should just add an include(../config/no-executables.m4)
> > to winsup/acinclude.m4 and create the aclocal.m4 files from there?
> 
> If you do that it'll just emit a sinclude into aclocal.m4 anyway, won't
> it?

Hm, yes, I guess so.

But the problem is clear I hope.  If we refer to ../config/foo, the
mingw/aclocal.m4 file isn't self-sufficient anymore.  That's actually
the only reason I didn't refer to ../config/no-executables.m4, but
copied it instead.


Corinna

-- 
Corinna Vinschen
Cygwin Project Co-Leader
Red Hat
