Return-Path: <cygwin-patches-return-6405-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30599 invoked by alias); 18 Jan 2009 05:06:53 -0000
Received: (qmail 30564 invoked by uid 22791); 18 Jan 2009 05:06:52 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-96-233-71-199.bstnma.fios.verizon.net (HELO cgf.cx) (96.233.71.199)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 18 Jan 2009 05:06:48 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id D23CB13C028; 	Sun, 18 Jan 2009 00:06:14 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id CF4242B385; Sun, 18 Jan 2009 00:06:14 -0500 (EST)
Date: Sun, 18 Jan 2009 05:06:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@sourceware.org>
To: cygwin-patches@cygwin.com, kirkshorts@googlemail.com, 	gdb-patches@sourceware.org, binutils@sourceware.org, 	gcc-patches@gcc.gnu.org
Subject: Re: [PATCH/libiberty] Fix PR38903 Cygwin GCC bootstrap failure 	[was Re: Libiberty issue vs cygwin [was Re: This is a Cygwin 	failure yeah?]]
Message-ID: <20090118050614.GA14669@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com, kirkshorts@googlemail.com, 	gdb-patches@sourceware.org, binutils@sourceware.org, 	gcc-patches@gcc.gnu.org
References: <2ca21dcc0901171652s44c72ca7teb1ca6041344e4a4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ca21dcc0901171652s44c72ca7teb1ca6041344e4a4@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2009-q1/txt/msg00003.txt.bz2

On Sun, Jan 18, 2009 at 12:52:14AM +0000, Dave Korn wrote:
>DJ Delorie wrote:
>>IIRC, that whole clause was because cygwin's dll itself linked with
>>libiberty, so the auto-detect stuff needed an override to make sure the
>>right files were there when you build cygwin1.dll.  Otherwise, it would
>>detect that cygwin had strsignal, not build it, then fail later when
>>cygwin1.dll couldn't find strsignal.
>>
>>If cygwin no longer links with libiberty, that whole clause can
>>probably go away now.  As it's target-specific, I'm OK with letting the
>>target maintainers have the last word about it, too.
>
>There are no longer any references to ../libiberty/* in Cygwin's
>Makefile, and indeed the libiberty subdir has been removed from the
>module definition for winsup so you don't even get it in a fresh
>checkout any more.
>
>Given that, I think we can remove the clause entirely.  I've tested
>this by doing (separate) native builds of GCC, winsup, binutils and
>GDB, with no issues arising.  I haven't tried cross-builds or combined
>source-tree builds, but there's no reason to believe they would be
>affected any differently.
>
>GCC is in stage 4, but this is target-specific and fixes a bootstrap
>failure on a secondary platform.
>
>Ok for HEAD of both gcc/ and src/ ?
>
>libiberty/ChangeLog
>
>* configure.ac (funcs, vars, checkfuncs): Don't munge on Cygwin, as it
>no longer shares libiberty object files.  * configure: Regenerated.

Just in case you need confirmation:  this looks fine.

I removed the dependence on libiberty a while ago partially because,
AFAICT, it actually subverted Red Hat's claim of owning all source code
in Cygwin.  You can't really say that if there are pure FSF GPLed or
LGPLed pieces.

cgf
