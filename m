Return-Path: <cygwin-patches-return-7733-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5637 invoked by alias); 19 Oct 2012 09:22:31 -0000
Received: (qmail 4686 invoked by uid 22791); 19 Oct 2012 09:21:50 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 19 Oct 2012 09:21:39 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 484DA2C0351; Fri, 19 Oct 2012 11:21:35 +0200 (CEST)
Date: Fri, 19 Oct 2012 09:22:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch]: Decouple cygwin building from in-tree mingw/w32api building
Message-ID: <20121019092135.GA22432@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAEwic4ZBrjVPDV1Y3tc6r7baGzxNbrjgj1MUgse6zYSMHiCUhQ@mail.gmail.com> <20121017164440.GA12989@ednor.casa.cgf.cx> <20121017170514.GD10578@calimero.vinschen.de> <20121017193258.GA15271@ednor.casa.cgf.cx> <1350545597.3492.59.camel@YAAKOV04> <20121018083419.GC6221@calimero.vinschen.de> <1350580828.3492.73.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1350580828.3492.73.camel@YAAKOV04>
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
X-SW-Source: 2012-q4/txt/msg00010.txt.bz2

On Oct 18 12:20, Yaakov (Cygwin/X) wrote:
> On Thu, 2012-10-18 at 10:34 +0200, Corinna Vinschen wrote:
> > Any problem to move mingw64-i686-zlib into the distro?
> 
> None; should I also move the other setup.exe prerequisites for
> i686-w64-mingw32?  Would you also like x86_64 versions of any of those?

If it's not asked too much, sure on both accounts!

> > The idea of the branch is to collect all changes required to make Cygwin
> > 64 bit work, while keeping the trunk intact for normal releases for the
> > time being.  Since we would like to keep Cygwin working on 32 bit,
> > cygwin-64bit-branch is supposed to make sure that Cygwin still builds on
> > 32 bit as well.
> 
> This particular change doesn't really have to do with 32-vs-64-bit, but
> with switching from mingw.org's w32api/runtime to mingw-w64's.
> (Obviously, I'm testing this with i686.)  So, once thoroughly tested, it
> could go straight into HEAD.

Indeed.

> > I had a brief look into the patch but didn't test it yet.  It looks good,
> > but it misses out on one important thing:  In contrast to Kai's patch, it
> > does not test for the target CPU, so these patches don't allow to build
> > with --target=x86_64-pc-cygwin.
> 
> That's easy enough to fix.
> 
> > > -      FLAGS_FOR_TARGET=$FLAGS_FOR_TARGET' -L$$r/$(TARGET_SUBDIR)/winsup -L$$r/$(TARGET_SUBDIR)/winsup/cygwin -L$$r/$(TARGET_SUBDIR)/winsup/w32api/lib -isystem $$s/winsup/include -isystem $$s/winsup/cygwin/include -isystem $$s/winsup/w32api/include'
> > > +      FLAGS_FOR_TARGET=$FLAGS_FOR_TARGET' -L$$r/$(TARGET_SUBDIR)/winsup -L$$r/$(TARGET_SUBDIR)/winsup/cygwin -isystem $$s/winsup/include -isystem $$s/winsup/cygwin/include'
> > 
> > This change reminds me.  Why on earth do we have a
> > -L$$r/$(TARGET_SUBDIR)/winsup in there?  How old is that?  We don't
> > have any libs in the winsup dir anyway, so we should remove that,
> > isn't it?
> 
> Same goes for -isystem $$s/winsup/include.

Yep.

> Revised patch attached.

Thanks.  Looks good, I have problems with this patch.

The theory is that cygwin will continue to co-exist with mingw and
w32api for a while, but cygwin does not build or use mingw and w32api.
However, winsup/configure.in adds mingw and w32api subdirs to SUBDIRS
based on the mere existence of the dirs.
If we want to make Cygwin independent of mingw/w32api and vice versa,
I'd suggest the following patch to winsup/configure.in instead:

Index: winsup/configure.in
===================================================================
RCS file: /cvs/src/src/winsup/configure.in,v
retrieving revision 1.33
diff -u -p -r1.33 configure.in
--- winsup/configure.in	29 Jan 2011 06:41:28 -0000	1.33
+++ winsup/configure.in	19 Oct 2012 08:34:36 -0000
@@ -32,33 +32,17 @@ case "$target" in
     if ! test -d $srcdir/cygwin; then
       AC_MSG_ERROR("No cygwin dir.  Can't build Cygwin.  Exiting...")
     fi
-    AC_CONFIG_SUBDIRS(cygwin)
+    AC_CONFIG_SUBDIRS(cygwin cygserver lsaauth utils doc)
     INSTALL_LICENSE="install-license"
     ;;
   *mingw*)
     if ! test -d $srcdir/mingw; then
       AC_MSG_ERROR("No mingw dir.  Can't build Mingw.  Exiting...")
     fi
-    ;;
-esac
-
-if test -d $srcdir/mingw; then
-  AC_CONFIG_SUBDIRS(mingw)
-fi
-AC_CONFIG_SUBDIRS(w32api cygserver)
-
-case "$with_cross_host" in
-  ""|*cygwin*)
-    # if test -d $srcdir/bz2lib; then
-    #  AC_CONFIG_SUBDIRS(bz2lib)
-    # fi
-    # if test -d $srcdir/zlib; then
-    #   AC_CONFIG_SUBDIRS(zlib)
-    # fi
-    if test -d $srcdir/lsaauth; then
-      AC_CONFIG_SUBDIRS(lsaauth)
+    AC_CONFIG_SUBDIRS(mingw)
+    if test -d $srcdir/w32api; then
+      AC_CONFIG_SUBDIRS(w32api)
     fi
-    AC_CONFIG_SUBDIRS(utils doc)
     ;;
 esac
 
This builds cygwin, cygserver, lsaauth, utils and doc dirs
if the target is Cygwin, mingw and w32api otherwise.  

> Index: winsup/lsaauth/Makefile.in
> ===================================================================
> RCS file: /cvs/src/src/winsup/lsaauth/Makefile.in,v
> retrieving revision 1.6
> diff -u -p -r1.6 Makefile.in
> --- winsup/lsaauth/Makefile.in	29 May 2012 12:46:01 -0000	1.6
> +++ winsup/lsaauth/Makefile.in	18 Oct 2012 17:13:54 -0000
> @@ -33,7 +33,7 @@ CFLAGS          := @CFLAGS@
>  
>  include $(srcdir)/../Makefile.common
>  
> -WIN32_INCLUDES  := -I. -I$(srcdir) $(w32api_include) $(w32api_include)/ddk
> +WIN32_INCLUDES  := -I. -I$(srcdir)
>  WIN32_CFLAGS    := $(CFLAGS) $(WIN32_COMMON) $(WIN32_INCLUDES)
>  WIN32_LDFLAGS	:= $(CFLAGS) $(WIN32_COMMON) -nostdlib -Wl,-shared

Just as a note for the future, we don't have to fix that immediately:

Given that the lsaauth modules don't call any Cygwin function but rather
only use a few Cygwin datastructure, and given that we now require a
mingw compiler to build the native utils anyway, I'm wondering if we
shouldn't simply require the x86 and x86_64 targeting mingw compilers to
build the lsaauth modules as well.

If we do that, we could already build the 32 and the 64 bit versions
of the lsaauth module today, right from the Makefile.  That sounds 
like a much better solution than the make-64bit-version-with-mingw-w64.sh
script and keeping the 64 bit DLL as a binary blob in the repo, doesn't
it?

> Index: winsup/utils/configure.in
> ===================================================================
> RCS file: /cvs/src/src/winsup/utils/configure.in,v
> retrieving revision 1.9
> diff -u -p -r1.9 configure.in
> --- winsup/utils/configure.in	25 Jul 2008 15:03:25 -0000	1.9
> +++ winsup/utils/configure.in	18 Oct 2012 17:13:55 -0000
> @@ -27,5 +27,7 @@ INSTALL="/bin/sh "`cd $srcdir/../..; ech
>  
>  AC_PROG_INSTALL
>  
> +AC_CHECK_PROGS(MINGW_CXX, $target_cpu-w64-mingw32-g++ $target_cpu-pc-mingw32-g++)

A very minor nit:  Personally I feel better if variables are braced in
such a scenario. From my POV it's also easier readable:

  AC_CHECK_PROGS(MINGW_CXX, ${target_cpu}-w64-mingw32-g++ ${target_cpu}-pc-mingw32-g++)

Other than that, I think it's good to go in after the 1.7.17 release.
I'll try to do the release at some point between now and Monday.

Now it would just be good if we got the latest Mingw headers and libs
into F17, but for the time being, the rawhide version of the
mingw{32,64}-{crt,headers}.noarch packages will do.  They have been cut
from upstream just three days ago.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
