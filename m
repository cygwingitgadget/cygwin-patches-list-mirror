Return-Path: <cygwin-patches-return-5970-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13245 invoked by alias); 29 Aug 2006 16:04:14 -0000
Received: (qmail 13136 invoked by uid 22791); 29 Aug 2006 16:04:13 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Tue, 29 Aug 2006 16:04:09 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 081CE544001; Tue, 29 Aug 2006 18:04:07 +0200 (CEST)
Date: Tue, 29 Aug 2006 16:04:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com, gdb-patches@sourceware.org
Cc: mingw-patches@lists.sourceforge.net, binutils@sourceware.org, 	gcc-patches@gcc.gnu.org
Subject: Re: [RFC] Simplify MinGW canadian crosses
Message-ID: <20060829160406.GB21260@calimero.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com, gdb-patches@sourceware.org, 	mingw-patches@lists.sourceforge.net, binutils@sourceware.org, 	gcc-patches@gcc.gnu.org
References: <20060829114107.GA17951@calimero.vinschen.de> <20060829124525.GA13245@nevyn.them.org> <200608291459.k7TExRDT026512@greed.delorie.com> <20060829150948.GA18308@nevyn.them.org> <20060829153540.GA20893@calimero.vinschen.de> <20060829154718.GB17552@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060829154718.GB17552@trixie.casa.cgf.cx>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00065.txt.bz2

On Aug 29 11:47, Christopher Faylor wrote:
> Btw, I agree with Daniel's suggestion of using
> ../config/no-executables.m4 if that's possible.

I did that first, but the argument against this is that the
mingw-runtime package, does not contain a top-level config directory.
The source tree is supposed to be built stand-alone.  Therefore it's
required to have a stand-alone aclocal.m4 file.

[time passes]

Or do you mean I should just add an include(../config/no-executables.m4)
to winsup/acinclude.m4 and create the aclocal.m4 files from there?


Corinna

-- 
Corinna Vinschen
Cygwin Project Co-Leader
Red Hat
