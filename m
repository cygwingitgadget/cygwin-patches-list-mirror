Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 64D143857718; Tue, 18 Nov 2025 14:41:25 +0000 (GMT)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id B9CD8A80CFD; Tue, 18 Nov 2025 15:41:23 +0100 (CET)
Date: Tue, 18 Nov 2025 15:41:23 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Mark Geisert <mark@maxrnd.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: Testsuite: fixes for compatibility with GCC 15
Message-ID: <aRyFk7UmXiJKrg_n@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Mark Geisert <mark@maxrnd.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <MA0P287MB3082B86D9A27A995509C8EAC9FFCA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
 <39e50846-f6d2-4dec-9d9e-ce4c4e963ace@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <39e50846-f6d2-4dec-9d9e-ce4c4e963ace@maxrnd.com>
List-Id: <cygwin-patches.cygwin.com>

On Oct 30 20:49, Mark Geisert wrote:
> [...]
> Thanks for looking into this issue.  Our Cygwin coding conventions specify
> that function names should be at the left margin.  So...
> 
> int
> main(int argc, char **argv)
> {
>     ...
> }
> 
> I've not patched the testsuite before so I'm unsure if the same submission
> format applies here as applies to Cygwin DLL patches.
> 

Just FTR:

For historical reasons(*), the tests within testsuite/winsup.api are not
actually using Cygwin or GNU coding style, rather a bastardized version
of BSD and GNU style, freely mixed and shaken.

Cygwin style is mostly GNU style with changes only in the comment style,
IIRC.  BSD sources in regex and libc subdirs are taken verbatim in terms
of style, even if tweaked.

Diversion from style are often historical as well or simple neglect.

Ideally, patches should use the coding style used by the already
existing code.  New files should ideally use Cygwin/GNU-coding style.


Corinna


(*) The base of this testsuite are the ltp tests from SGI.
