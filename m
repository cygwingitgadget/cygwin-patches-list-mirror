Return-Path: <cygwin-patches-return-3053-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 2835 invoked by alias); 14 Oct 2002 20:00:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2728 invoked from network); 14 Oct 2002 20:00:12 -0000
Message-ID: <3DAB2264.2000508@yahoo.com>
Date: Mon, 14 Oct 2002 13:00:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
Reply-To:  cygwin-patches@cygwin.com
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: w32api autoconfiscation changes
References: <3DA78C2A.9010709@yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00004.txt.bz2

I've just implemented this.

Earnie Boyd wrote:
> This is a warning of changes about to occur.  I've tested these chages 
> with both native mingw32 and native cygwin.  I've not tested these 
> changes with a cross build system.  The purpose of the change is to add 
> targets for the ddk recently added to the sources and making a few 
> modifications due to differences in the way newer versions of autoconf 
> generates the results of important variables such as host_alias.  I'm 
> attaching w32api.cvsdiff.txt without ChangeLog entry for your enjoyment. 
>  The generated configure script will be with autoconf 2.53.
> 
> Earnie.
> 
> 
> ------------------------------------------------------------------------
> 
> ? autom4te.cache
> ? include/_w32api.h
> Index: Makefile.in
> ===================================================================
> RCS file: /cvs/src/src/winsup/w32api/Makefile.in,v
> retrieving revision 1.24
> diff -u -3 -r1.24 Makefile.in
> --- Makefile.in	28 Aug 2002 22:26:46 -0000	1.24
> +++ Makefile.in	12 Oct 2002 02:20:02 -0000
> @@ -14,9 +14,9 @@
>  srcdir = @srcdir@
>  VPATH = @srcdir@
>  
> -build_alias = @build_alias@
> -host_alias = @host_alias@
> -target_alias = @target_alias@
> +build_alias = @build@
> +host_alias = @host@
> +target_alias = @target@
>  prefix = @prefix@
>  conf_prefix = @prefix@
>  
> Index: configure.in
> ===================================================================
> RCS file: /cvs/src/src/winsup/w32api/configure.in,v
> retrieving revision 1.2
> diff -u -3 -r1.2 configure.in
> --- configure.in	19 Oct 2000 20:56:50 -0000	1.2
> +++ configure.in	12 Oct 2002 02:20:35 -0000
> @@ -19,6 +19,7 @@
>  CFLAGS=${CFLAGS-"-O2 -g"}
>  AC_CHECK_TOOL(CC, gcc, gcc)
>  AC_SUBST(CC)
> +AC_SUBST(CFLAGS)
>  
>  dnl check for various tools
>  AC_CHECK_TOOL(AR, ar, ar)
> @@ -46,4 +47,4 @@
>  fi
>  AC_SUBST(BUILDENV)
>  
> -AC_OUTPUT(Makefile lib/Makefile)
> +AC_OUTPUT(Makefile lib/Makefile lib/ddk/Makefile)
> Index: lib/Makefile.in
> ===================================================================
> RCS file: /cvs/src/src/winsup/w32api/lib/Makefile.in,v
> retrieving revision 1.22
> diff -u -3 -r1.22 Makefile.in
> --- lib/Makefile.in	6 Sep 2002 03:24:06 -0000	1.22
> +++ lib/Makefile.in	12 Oct 2002 02:20:42 -0000
> @@ -15,9 +15,12 @@
>  srcdir = @srcdir@
>  VPATH = @srcdir@
>  
> -host_alias = @host_alias@
> -build_alias = @build_alias@
> -target_alias = @target_alias@
> +SUBDIRS := ddk
> +subdirs := ddk
> +
> +host_alias = @host@
> +build_alias = @build@
> +target_alias = @target@
>  prefix = @prefix@
>  includedir:=@includedir@
>  
> @@ -82,6 +85,21 @@
>  AR = @AR@
>  LD = @LD@
>  
> +FLAGS_TO_PASS = \
> +	AS="$(AS)" \
> +	CC="$(CC)" \
> +	CPPFLAGS="$(CPPFLAGS)" \
> +	CFLAGS="$(CFLAGS)" \
> +	CXXFLAGS="$(CXXFLAGS)" \
> +	AR="$(AR)" \
> +	RANLIB="$(RANLIB)" \
> +	LD="$(LD)" \
> +	DLLTOOL="$(DLLTOOL)" \
> +	TAR="$(TAR)" \
> +	TARFLAGS="$(TARFLAGS)" \
> +	TARFILEEXT="$(TARFILEEXT)" \
> +	WINDRES="$(WINDRES)"
> +
>  # end config section
>  
>  # headers
> @@ -105,7 +123,15 @@
>  .NOTPARALLEL:
>  
>  # targets
> -all: $(LIBS) $(EXTRA_OBJS)
> +all: $(LIBS) $(EXTRA_OBJS) ddk
> +
> +%-subdirs:
> +	for i in $(SUBDIRS); do \
> +	  $(MAKE) $(FLAGS_TO_PASS) -C $$i $*; \
> +	done
> +
> +ddk:
> +	$(MAKE) $(FLAGS_TO_PASS) -C $@
>  
>  TEST_OPTIONS = $(ALL_CFLAGS) -DWINVER=0x0666  \
>  	-Wall -pedantic -Wsystem-headers -c $(srcdir)/test.c -o test.o
> @@ -146,8 +172,9 @@
>  	$(AR) rc $@ $*.o
>  	$(RANLIB) $@
>  
> +.PHONY: install install-libraries install-headers install-pdk
>  # install headers and libraries in a target specified directory.
> -install: install-libraries install-headers
> +install: install-libraries install-headers install-ddk
>  
>  install-libraries: all
>  	$(mkinstalldirs) $(inst_libdir)
> @@ -165,8 +192,11 @@
>  		$(INSTALL_DATA) $(srcdir)/../include/GL/$$i $(inst_includedir)/GL/$$i ; \
>  	done
>  
> +install-ddk: install-libraries install-headers
> +	(cd ddk; $(MAKE) install)
> +
>  # uninstall headers and libraries from a target specified directory
> -uninstall: uninstall-libraries uninstall-headers
> +uninstall: uninstall-pdk uninstall-libraries uninstall-headers
>  
>  uninstall-libraries:
>  	@for i in $(LIBS); do \
> @@ -180,6 +210,8 @@
>  	done
>  	rmdir $(inst_includedir)
>  
> +uninstall-pdk:
> +	cd ddk && $(MAKE) -C uninstall
>  
>  dist:
>  	mkdir $(distdir)/include
> @@ -208,3 +240,4 @@
>  	rm -f config.cache config.status config.log Makefile
>  
>  maintainer-clean: distclean
> +
> Index: lib/ddk/Makefile.in
> ===================================================================
> RCS file: /cvs/src/src/winsup/w32api/lib/ddk/Makefile.in,v
> retrieving revision 1.1
> diff -u -3 -r1.1 Makefile.in
> --- lib/ddk/Makefile.in	6 Oct 2002 22:18:25 -0000	1.1
> +++ lib/ddk/Makefile.in	12 Oct 2002 02:20:42 -0000
> @@ -14,9 +14,9 @@
>  srcdir = @srcdir@
>  VPATH = @srcdir@
>  
> -host_alias = @host_alias@
> -build_alias = @build_alias@
> -target_alias = @target_alias@
> +host_alias = @host@
> +build_alias = @build@
> +target_alias = @target@
>  prefix = @prefix@
>  includedir:=@includedir@
>  
> @@ -85,7 +85,7 @@
>  
>  # headers
>  
> -HEADERS = $(notdir $(wildcard $(srcdir)/../include/*.h))
> +HEADERS = $(notdir $(wildcard $(srcdir)/../../include/ddk/*.h))
>  
>  # libraries
>  
> @@ -147,7 +147,7 @@
>  install-headers:
>  	$(mkinstalldirs) $(inst_includedir)
>  	for i in $(HEADERS); do \
> -		$(INSTALL_DATA) $(srcdir)/../../ddk/include/$$i $(inst_includedir)/$$i ; \
> +		$(INSTALL_DATA) $(srcdir)/../../include/ddk/$$i $(inst_includedir)/$$i ; \
>  	done
>  
>  # uninstall headers and libraries from a target specified directory
