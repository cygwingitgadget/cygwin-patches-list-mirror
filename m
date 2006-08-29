Return-Path: <cygwin-patches-return-5967-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18018 invoked by alias); 29 Aug 2006 15:35:48 -0000
Received: (qmail 17991 invoked by uid 22791); 29 Aug 2006 15:35:46 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Tue, 29 Aug 2006 15:35:44 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id DBC5F6D429F; Tue, 29 Aug 2006 17:35:40 +0200 (CEST)
Date: Tue, 29 Aug 2006 15:35:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: gcc-patches@gcc.gnu.org, gdb-patches@sourceware.org, 	binutils@sourceware.org, mingw-patches@lists.sourceforge.net, 	cygwin-patches@cygwin.com
Subject: Re: [RFC] Simplify MinGW canadian crosses
Message-ID: <20060829153540.GA20893@calimero.vinschen.de>
Mail-Followup-To: gcc-patches@gcc.gnu.org, gdb-patches@sourceware.org, 	binutils@sourceware.org, mingw-patches@lists.sourceforge.net, 	cygwin-patches@cygwin.com
References: <20060829114107.GA17951@calimero.vinschen.de> <20060829124525.GA13245@nevyn.them.org> <200608291459.k7TExRDT026512@greed.delorie.com> <20060829150948.GA18308@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060829150948.GA18308@nevyn.them.org>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00062.txt.bz2

On Aug 29 11:09, Daniel Jacobowitz wrote:
> On Tue, Aug 29, 2006 at 10:59:27AM -0400, DJ Delorie wrote:
> > 
> > > If you want to build some code that runs on mingw, I don't think
> > > that having mingw tools installed is an unreasonable requirement.
> > 
> > This is how you *get* mingw tools installed.  The same logic that
> > gives you a canadian (worst case) also gives you host-x-host.
> 
> Not so, unless I'm vastly confused.
> 
> Corinna is trying to generate --host=i686-mingw32 tools, with a
> different --target.  This requires at least a --target=i686-mingw32
> compiler coming from elsewhere.  That compiler can build the
> --host=i686-mingw32 libraries, and usually should.
> 
> This is more like adding support for using the in tree newlib with an
> arm-linux compiler so that you could build GCC to run on arm-linux,
> without having to install an arm-linux C library first.  That's why
> I'm dubious about the value.  But maybe Corinna has some good example
> of when you want to do this?

Sorry, but that's not the deal.  Using my patches, you can install a
standard source tree, including gcc, gdb, binutils, [...], and last but
not least the winsup directory on, say, a Linux machine, and then build
a complete three stage canadian cross on *Linux*, which generates a
i686-pc-mingw32-x-arm-elf toolchain.  You don't have to install the MinGW
libraries and header files somewhere on the Linux machine and tweak the
build process to find them.  Everything comes out of the same source
tree.  From my point of view this simplifies stuff, it doesn't make it
more complicated.


Corinna

-- 
Corinna Vinschen
Cygwin Project Co-Leader
Red Hat
