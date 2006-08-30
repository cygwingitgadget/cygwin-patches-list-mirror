Return-Path: <cygwin-patches-return-5975-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4423 invoked by alias); 30 Aug 2006 13:16:00 -0000
Received: (qmail 4387 invoked by uid 22791); 30 Aug 2006 13:15:58 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Wed, 30 Aug 2006 13:15:55 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id CDEB56D429F; Wed, 30 Aug 2006 15:15:52 +0200 (CEST)
Date: Wed, 30 Aug 2006 13:16:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: gcc-patches@gcc.gnu.org, gdb-patches@sourceware.org, 	binutils@sourceware.org, mingw-patches@lists.sourceforge.net, 	cygwin-patches@cygwin.com
Subject: Re: [RFC] Simplify MinGW canadian crosses
Message-ID: <20060830131552.GN20467@calimero.vinschen.de>
Mail-Followup-To: gcc-patches@gcc.gnu.org, gdb-patches@sourceware.org, 	binutils@sourceware.org, mingw-patches@lists.sourceforge.net, 	cygwin-patches@cygwin.com
References: <20060829114107.GA17951@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060829114107.GA17951@calimero.vinschen.de>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00070.txt.bz2

On Aug 29 13:41, Corinna Vinschen wrote:
> ChangeLogs:
> ===========
> 
> Top-Level:
> 
>         * configure.in: Never build newlib for a Mingw host.
>         Never build newlib as Mingw target library.
>         Test the existence of winsup/cygwin for building a Cygwin newlib,
>         rather than just winsup.
>         Add winsup/mingw and winsup/w32api paths to FLAGS_FOR_TARGET if
>         building a Mingw target.
>         * configure: Regenerate.
> 
> libiberty:
> 
>         * configure.ac: Add case for Mingw as host.
>         * configure: Regenerate.
> 
> winsup:
> 
>         * Makefile.in: Make installation of CYGWIN_LICENSE configurable.
>         * acinclude.m4: Add GCC_NO_EXECUTABLES from config/no-executables.m4.
>         * aclocal.m4: Regenerate.
>         * configure.in: Add GCC_NO_EXECUTABLES call. Add configuration for
>         INSTALL_LICENSE.  Make cygwin subdirectory optional.  Add sanity
>         check for cygwin resp. mingw subdirectories dependent of the target.
>         * configure: Regenerate.
> 
> winsup/mingw:
> 
>         * Makefile.in: Add with_cross_host to allow more granular checks.
>         Set installation directories accordingly.  Override CC setting only
>         if building a Cygwin target.
>         * aclocal.m4: Regenerate from ../acinclude.m4.
>         * configure.in: Move AC_CANONICAL_SYSTEM check up.  Add
>         GCC_NO_EXECUTABLES.  Substitute with_cross_host in depending files.
>         Test AC_ALLOCA only if building on a native system.
>         * configure: Regenerate.
> 
> winsup/w32api:
> 
>         * configure.in: Substitute with_cross_host in depending files.
>         * configure: Regenerate.
>         * lib/Makefile.in: Add with_cross_host to allow more granular checks.
>         Set installation directories accordingly.
>         * lib/ddk/Makefile.in: Ditto.
>         * lib/directx/Makefile.in: Ditto.

I applied these patches to the sourceware repository.  I have no
checkin privileges to gcc and mingw, so, could somebody having
these rights apply the appropriate patches there?


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Project Co-Leader
Red Hat
