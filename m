Return-Path: <cygwin-patches-return-7167-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20385 invoked by alias); 7 Feb 2011 11:59:17 -0000
Received: (qmail 20351 invoked by uid 22791); 7 Feb 2011 11:59:05 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Mon, 07 Feb 2011 11:59:00 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 4A8312CA2E9; Mon,  7 Feb 2011 12:58:57 +0100 (CET)
Date: Mon, 07 Feb 2011 11:59:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Crosscompiling configure fix
Message-ID: <20110207115857.GC24247@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <7630E3AFCCB3F84AB86B9B1EBF730D536ACF9B01@SERVER.foleyremote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7630E3AFCCB3F84AB86B9B1EBF730D536ACF9B01@SERVER.foleyremote.com>
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
X-SW-Source: 2011-q1/txt/msg00022.txt.bz2

On Feb  5 21:34, Peter Foley wrote:
> I've submitted a fix for a problem I came across while trying to build a Linux-hosted Cygwin cross compiler. While bootstrapping Cygwin the autoconf scripts in winsup/cygwin and winsup/cygserver fail because the bootstrap compiler is missing some of the files needed to link a Cygwin executable. Because the source for some of the needed files is in the winsup directory, this creates a curricular dependency. The attached patch lets autoconf complete successfully by not running the tests that require linking if Cygwin is being crosscompiled.
> 
> Thanks,
> 
> Peter Foley
> 
> winsup/cygserver/ChangeLog:
> 
> 2011-02-5 Peter Foley <...>
> 
> 	* configure.in: Skip tests that require linking if cross compiling.
> 	* configure: Regenerate.
> 
> winsup/cygwin/ChangeLog:
> 
> 2011-02-5 Peter Foley <...>
> 
> 	* configure.in: Skip tests that require linking if cross compiling.
> 	* configure: Regenerate.

Thanks for the patch.  Btw., you don't have to provide the generated
files, the configure.in files are sufficient.

I'm just wondering why we need this stuff at all.  I mean, is there
really any good reason to do the AC_ALLOCA test, and why do we have
this AC_TRY_COMPILE test for __builtin_memset?  Both results are not
used anywhere, they are just written to config.h and then forgotten.

So I take it, we could just drop this stuff.

Chris?  What do you say?

Index: cygserver/configure.in
===================================================================
RCS file: /cvs/src/src/winsup/cygserver/configure.in,v
retrieving revision 1.4
diff -u -p -r1.4 configure.in
--- cygserver/configure.in	24 May 2006 16:59:02 -0000	1.4
+++ cygserver/configure.in	7 Feb 2011 11:57:29 -0000
@@ -44,26 +44,8 @@ AC_CHECK_TOOL(NM, nm, nm)
 AC_CHECK_TOOL(DLLTOOL, dlltool, dlltool)
 AC_CHECK_TOOL(WINDRES, windres, windres)
 
-AC_ALLOCA
 AC_PROG_MAKE_SET
 
-dnl check whether gcc supports __builtin_memset.
-# Test for builtin mem* functions.
-AC_LANG_SAVE
-AC_LANG_CPLUSPLUS
-AC_TRY_COMPILE([
-#include <string.h>
-void foo(char *s, int c, size_t n)
-{
-  __builtin_memset(s, c, n);
-}
-], [ ],
-use_builtin_memset=yes, use_builtin_memset=no)
-if test $use_builtin_memset = "yes"; then
-  AC_DEFINE(HAVE_BUILTIN_MEMSET)
-fi
-AC_LANG_RESTORE
-
 AC_ARG_ENABLE(debugging,
 [ --enable-debugging		Build a cygwin DLL which has more consistency checking for debugging],
 [case "${enableval}" in
Index: cygwin/configure.in
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/configure.in,v
retrieving revision 1.34
diff -u -p -r1.34 configure.in
--- cygwin/configure.in	29 Jan 2011 06:41:28 -0000	1.34
+++ cygwin/configure.in	7 Feb 2011 11:57:29 -0000
@@ -48,26 +48,8 @@ AC_CHECK_TOOL(RANLIB, ranlib, ranlib)
 AC_CHECK_TOOL(STRIP, strip, strip)
 AC_CHECK_TOOL(WINDRES, windres, windres)
 
-AC_ALLOCA
 AC_PROG_MAKE_SET
 
-dnl check whether gcc supports __builtin_memset.
-# Test for builtin mem* functions.
-AC_LANG_SAVE
-AC_LANG_CPLUSPLUS
-AC_TRY_COMPILE([
-#include <string.h>
-void foo(char *s, int c, size_t n)
-{
-  __builtin_memset(s, c, n);
-}
-], [ ],
-use_builtin_memset=yes, use_builtin_memset=no)
-if test $use_builtin_memset = "yes"; then
-  AC_DEFINE(HAVE_BUILTIN_MEMSET)
-fi
-AC_LANG_RESTORE
-
 AC_ARG_ENABLE(debugging,
 [ --enable-debugging		Build a cygwin DLL which has more consistency checking for debugging],
 [case "${enableval}" in

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
