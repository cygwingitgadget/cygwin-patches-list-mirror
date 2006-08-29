Return-Path: <cygwin-patches-return-5969-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32183 invoked by alias); 29 Aug 2006 15:47:25 -0000
Received: (qmail 32156 invoked by uid 22791); 29 Aug 2006 15:47:23 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-229.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.229)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 29 Aug 2006 15:47:20 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 8FE3113C042; Tue, 29 Aug 2006 11:47:18 -0400 (EDT)
Date: Tue, 29 Aug 2006 15:47:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@sourceware.org>
To: cygwin-patches@cygwin.com, mingw-patches@lists.sourceforge.net, 	gdb-patches@sourceware.org, binutils@sourceware.org, 	gcc-patches@gcc.gnu.org
Subject: Re: [RFC] Simplify MinGW canadian crosses
Message-ID: <20060829154718.GB17552@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com, 	mingw-patches@lists.sourceforge.net, gdb-patches@sourceware.org, 	binutils@sourceware.org, gcc-patches@gcc.gnu.org
References: <20060829114107.GA17951@calimero.vinschen.de> <20060829124525.GA13245@nevyn.them.org> <200608291459.k7TExRDT026512@greed.delorie.com> <20060829150948.GA18308@nevyn.them.org> <20060829153540.GA20893@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060829153540.GA20893@calimero.vinschen.de>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00064.txt.bz2

On Tue, Aug 29, 2006 at 05:35:40PM +0200, Corinna Vinschen wrote:
>On Aug 29 11:09, Daniel Jacobowitz wrote:
>> On Tue, Aug 29, 2006 at 10:59:27AM -0400, DJ Delorie wrote:
>> > 
>> > > If you want to build some code that runs on mingw, I don't think
>> > > that having mingw tools installed is an unreasonable requirement.
>> > 
>> > This is how you *get* mingw tools installed.  The same logic that
>> > gives you a canadian (worst case) also gives you host-x-host.
>> 
>> Not so, unless I'm vastly confused.
>> 
>> Corinna is trying to generate --host=i686-mingw32 tools, with a
>> different --target.  This requires at least a --target=i686-mingw32
>> compiler coming from elsewhere.  That compiler can build the
>> --host=i686-mingw32 libraries, and usually should.
>> 
>> This is more like adding support for using the in tree newlib with an
>> arm-linux compiler so that you could build GCC to run on arm-linux,
>> without having to install an arm-linux C library first.  That's why
>> I'm dubious about the value.  But maybe Corinna has some good example
>> of when you want to do this?
>
>Sorry, but that's not the deal.  Using my patches, you can install a
>standard source tree, including gcc, gdb, binutils, [...], and last but
>not least the winsup directory on, say, a Linux machine, and then build
>a complete three stage canadian cross on *Linux*, which generates a
>i686-pc-mingw32-x-arm-elf toolchain.  You don't have to install the MinGW
>libraries and header files somewhere on the Linux machine and tweak the
>build process to find them.  Everything comes out of the same source
>tree.  From my point of view this simplifies stuff, it doesn't make it
>more complicated.

To be devil's advocate - I think the question is "Why should MinGW be
treated specially?"

I know that Cygwin is already treated specially in this regard (i.e.,
you can do an in-tree build to generate a cygwin cross-compiler without
necessarily having cygwin installed), and I believe that it is possible
to build newlib versions of gcc, but it apparently hasn't been a goal to
build MinGW without first installing a MinGW toolchain.

I think the answer is - since we already handle Cygwin and gcc's
configure already understands the winsup directory, why not just extend
configure to handle MinGW as well as Cygwin?  I don't think this
suggestion would make sense if we were talking about accommodating a
*new* directory in the build tree but since the MinGW directory is
almost handled now, I don't see any harm.

Btw, I agree with Daniel's suggestion of using
../config/no-executables.m4 if that's possible.

cgf
