Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 430433858D1E; Mon, 21 Jul 2025 09:48:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 430433858D1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1753091299;
	bh=Of/pga+AtO54nIXwCcD56TWtABCOyzcx1qA2+fnhY/o=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=eu77odlzoh11m942NQ+bOALk9UAUFfTi84zl1ybAXM/vABlalbiQf3VZibxwuOewl
	 hDtLpmqdBmBnXYG/RA91H+pxeOOD/DdK9FMApOV9kilXGt1asU+YnV9NIiFSICuNQM
	 T5ZvFAa/eDzJYc3y+wlvidotdCtZYg5U9roV7g0I=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 80DD7A80DCD; Mon, 21 Jul 2025 11:48:17 +0200 (CEST)
Date: Mon, 21 Jul 2025 11:48:17 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Radek Barton <radek.barton@microsoft.com>
Cc: Jon Turney <jon.turney@dronecode.org.uk>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v4] Cygwin: configure: add possibility to skip build of
 cygserver and utils
Message-ID: <aH4M4bMkevolWp0N@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Radek Barton <radek.barton@microsoft.com>,
	Jon Turney <jon.turney@dronecode.org.uk>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <DB9PR83MB09232A0A1E4EC3D43BBAFA089242A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <DB9PR83MB0923C35FB2253C8C2A21927C9248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <52fd7877-6abc-4e01-8f3c-405cf075b1ff@dronecode.org.uk>
 <DB9PR83MB09237AD6BA4BFE16B03AEBD99256A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <DB9PR83MB0923F0FF53C98FB27E03C376925DA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB9PR83MB0923F0FF53C98FB27E03C376925DA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
List-Id: <cygwin-patches.cygwin.com>

Jon?

On Jul 21 07:40, Radek Barton via Cygwin-patches wrote:
> Hello.
> 
> Sending a patch with your suggestion applied. I'll address the `--with-cross-bootstrap` option handling in a separate patch submission as it requires more complex solution to fully allow zero-bootstrap of x64/AArch64 Linux -> AArch64 Cygwin or x64 Cygwin -> AArch64 Cygwin cross-compiler.
> 
> Radek
> 
> ---
> >From 7770246d173d869f79f5d87e1bce1621c0fe1308 Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Radek=20Barto=C5=88?= <radek.barton@microsoft.com>
> Date: Sat, 21 Jun 2025 22:56:58 +0200
> Subject: [PATCH v4] Cygwin: configure: add possibility to skip build of
>  cygserver and utils
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> This patch adds configure options allowing to disable build of cygserver
> and Cygwin utilities. This is useful when one needs to build only
> cygwin1.dll and crt0.o with stage1 compiler that is not yet capable of
> linking executables as it is missing cygwin1.dll and crt0.o.
> 
> Signed-off-by: Radek Bartoň <radek.barton@microsoft.com>
> ---
>  winsup/Makefile.am             | 20 ++++++++++++++++++--
>  winsup/configure.ac            | 12 ++++++++++++
>  winsup/cygserver/Makefile.am   |  2 ++
>  winsup/doc/faq-programming.xml | 17 ++++++++++++++++-
>  4 files changed, 48 insertions(+), 3 deletions(-)
> 
> diff --git a/winsup/Makefile.am b/winsup/Makefile.am
> index 9efdd4cb1..877c4e6b9 100644
> --- a/winsup/Makefile.am
> +++ b/winsup/Makefile.am
> @@ -14,10 +14,26 @@ cygdoc_DATA = \
>  	CYGWIN_LICENSE \
>  	COPYING
>  
> -SUBDIRS = cygwin cygserver utils testsuite
> +SUBDIRS = cygwin testsuite
> +
> +if BUILD_CYGSERVER
> +SUBDIRS += cygserver
> +endif
> +
> +if BUILD_UTILS
> +SUBDIRS += utils
> +endif
>  
>  if BUILD_DOC
>  SUBDIRS += doc
>  endif
>  
> -cygserver utils testsuite: cygwin
> +testsuite: cygwin
> +
> +if BUILD_CYGSERVER
> +cygserver: cygwin
> +endif
> +
> +if BUILD_UTILS
> +utils: cygwin
> +endif
> diff --git a/winsup/configure.ac b/winsup/configure.ac
> index 18adf3d97..e7ac814b1 100644
> --- a/winsup/configure.ac
> +++ b/winsup/configure.ac
> @@ -83,6 +83,18 @@ AC_ARG_ENABLE(doc,
>  	      enable_doc=yes)
>  AM_CONDITIONAL(BUILD_DOC, [test $enable_doc != "no"])
>  
> +# Disabling build of cygserver and utils is needed for zero-bootstrap build of
> +# stage 1 Cygwin toolchain where the linker is not able to produce executables
> +# yet.
> +AC_ARG_ENABLE(cygserver,
> +	      [AS_HELP_STRING([--disable-cygserver], [do not build cygserver])],,
> +	      enable_cygserver=yes)
> +AM_CONDITIONAL(BUILD_CYGSERVER, [test $enable_cygserver != "no"])
> +AC_ARG_ENABLE(utils,
> +	      [AS_HELP_STRING([--disable-utils], [do not build utils])],,
> +	      enable_utils=yes)
> +AM_CONDITIONAL(BUILD_UTILS, [test $enable_utils != "no"])
> +
>  AC_CHECK_PROGS([DOCBOOK2XTEXI], [docbook2x-texi db2x_docbook2texi])
>  if test -z "$DOCBOOK2XTEXI" ; then
>      if test "x$enable_doc" != "xno"; then
> diff --git a/winsup/cygserver/Makefile.am b/winsup/cygserver/Makefile.am
> index ec7a62240..efb578e53 100644
> --- a/winsup/cygserver/Makefile.am
> +++ b/winsup/cygserver/Makefile.am
> @@ -12,7 +12,9 @@ cygserver_flags=$(cxxflags_common) -Wimplicit-fallthrough=5 -Werror -DSYSCONFDIR
>  AM_CXXFLAGS = $(CFLAGS)
>  
>  noinst_LIBRARIES = libcygserver.a
> +if BUILD_CYGSERVER
>  sbin_PROGRAMS = cygserver
> +endif
>  bin_SCRIPTS = cygserver-config
>  
>  cygserver_SOURCES = \
> diff --git a/winsup/doc/faq-programming.xml b/winsup/doc/faq-programming.xml
> index 39610b916..ae9bdb8dc 100644
> --- a/winsup/doc/faq-programming.xml
> +++ b/winsup/doc/faq-programming.xml
> @@ -698,8 +698,23 @@ Building these programs can be disabled with the <literal>--without-cross-bootst
>  option to <literal>configure</literal>.
>  </para>
>  
> +<para>
> +Build of <literal>cygserver</literal> can be skipped with
> +<literal>--disable-cygserver</literal> and build of other Cygwin utilities with
> +<literal>--disable-utils</literal>.
> +</para>
> +
> +<para>
> +In combination, <literal>--disable-cygserver</literal>,
> +<literal>--disable-dumper</literal>, <literal>--disable-utils</literal>
> +and  <literal>--without-cross-bootstrap</literal> allow building of just
> +<literal>cygwin1.dll</literal> and <literal>crt0.o</literal> for a stage2
> +compiler, when being built with stage1 compiler which does not support linking
> +executables yet (because those files are missing).
> +</para>
> +
>  <!-- If you want to run the tests <literal>busybox</literal> and
> -     <literal>cygutils-extra<literal> are also required. -->
> +     <literal>cygutils-extra</literal> are also required. -->
>  
>  <para>
>  Building the documentation also requires the <literal>dblatex</literal>,
> -- 
> 2.50.1.vfs.0.0
> 


