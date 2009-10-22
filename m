Return-Path: <cygwin-patches-return-6792-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32415 invoked by alias); 22 Oct 2009 22:37:43 -0000
Received: (qmail 32386 invoked by uid 22791); 22 Oct 2009 22:37:35 -0000
X-SWARE-Spam-Status: No, hits=-3.3 required=5.0 	tests=AWL,BAYES_00,HK_OBFDOM,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from out2.smtp.messagingengine.com (HELO out2.smtp.messagingengine.com) (66.111.4.26)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 22 Oct 2009 22:37:25 +0000
Received: from compute2.internal (compute2.internal [10.202.2.42]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id E9980B421B 	for <cygwin-patches@cygwin.com>; Thu, 22 Oct 2009 18:37:23 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])   by compute2.internal (MEProxy); Thu, 22 Oct 2009 18:37:24 -0400
Received: from [192.168.1.3] (user-0c6sbc4.cable.mindspring.com [24.110.45.132]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id 499CA6EEF3; 	Thu, 22 Oct 2009 18:37:23 -0400 (EDT)
Message-ID: <4AE0DE77.3090300@cwilson.fastmail.fm>
Date: Thu, 22 Oct 2009 22:37:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Honor DESTDIR in w32api and mingw
References: <4AD78C5B.2080107@cwilson.fastmail.fm>
In-Reply-To: <4AD78C5B.2080107@cwilson.fastmail.fm>
Content-Type: multipart/mixed;  boundary="------------000103070903060308010500"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00123.txt.bz2

This is a multi-part message in MIME format.
--------------000103070903060308010500
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 790

Latest rev, based on feedback @ mingw-dvlpr.  Avoid gmake conditionals
and use explicit rules, instead. Detect problems in all applicable
installation paths, not just $(prefix).

2009-10-22  Charles Wilson  <...>

	Honor DESTDIR for winsup/mingw and winsup/w32api.
	Detect and report error if installation paths are win32
	format, but DESTDIR is non-empty.

	* winsup/mingw/Makefile.in: Honor DESTDIR and add to
	FLAGS_TO_PASS.
	* winsup/mingw/mingwex/Makefile.in: Honor DESTDIR.
	* winsup/mingw/profile/Makefile.in: Honor DESTDIR.
	* winsup/w32api/Makefile.in Honor DESTDIR and add to
	FLAGS_TO_PASS.
	* winsup/w32api/lib/Makefile.in: Honor DESTDIR and add to
	FLAGS_TO_PASS.
	* winsup/w32api/lib/ddk/Makefile.in: Honor DESTDIR.
	* w32api/lib/directx/Makefile.in: Honor DESTDIR.

--
Chuck

--------------000103070903060308010500
Content-Type: text/plain;
 name="mingw-destdir.patch4"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mingw-destdir.patch4"
Content-length: 16846

Index: mingw/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/mingw/Makefile.in,v
retrieving revision 1.89
diff -u -p -r1.89 Makefile.in
--- mingw/Makefile.in	27 Jul 2009 20:27:09 -0000	1.89
+++ mingw/Makefile.in	22 Oct 2009 20:43:27 -0000
@@ -90,6 +90,7 @@ inst_bindir:=$(tooldir)/bin
 inst_includedir:=$(tooldir)/include/mingw
 inst_libdir:=$(tooldir)/lib/mingw
 inst_docdir:=$(tooldir)/share/doc/mingw-runtime
+need-DESTDIR-compatibility = prefix exec_prefix tooldir mandir
 else
 ifneq (,$(with_cross_host))
 #
@@ -104,11 +105,13 @@ inst_bindir:=$(tooldir)/bin
 inst_includedir:=$(tooldir)/include
 inst_libdir:=$(tooldir)/lib
 inst_docdir:=$(tooldir)/share/doc/mingw-runtime
+need-DESTDIR-compatibility = prefix exec_prefix tooldir mandir
 else
 inst_bindir:=$(bindir)
 inst_includedir:=$(includedir)
 inst_libdir:=$(libdir)
 inst_docdir:=$(prefix)/doc/runtime
+need-DESTDIR-compatibility = prefix bindir includedir libdir mandir
 endif
 endif
 
@@ -204,6 +207,7 @@ FLAGS_TO_PASS:=\
 	RANLIB="$(RANLIB)" \
 	LD="$(LD)" \
 	DLLTOOL="$(DLLTOOL)" \
+	DESTDIR="$(DESTDIR)" \
 	exec_prefix="$(exec_prefix)" \
 	bindir="$(bindir)" \
 	libdir="$(libdir)" \
@@ -274,7 +278,7 @@ all_dlls_host: $(DLLS)
 
 install_dlls_host:
 	for i in $(DLLS); do \
-		$(INSTALL_PROGRAM) $$i $(inst_bindir)/$$i ; \
+		$(INSTALL_PROGRAM) $$i $(DESTDIR)$(inst_bindir)/$$i ; \
 	done
 
 _libm_dummy.o:
@@ -493,25 +497,44 @@ info-html:
 
 install-info: info
 
-install-dirs:
-	$(mkinstalldirs) $(inst_bindir)
-	$(mkinstalldirs) $(inst_includedir)
-	$(mkinstalldirs) $(inst_libdir)
-	$(mkinstalldirs) $(inst_docdir)
-	$(mkinstalldirs) $(mandir)/man$(mansection)
+.PHONY: check-DESTDIR-compatibility $(need-DESTDIR-compatibility)
+
+check-DESTDIR-compatibility:
+	 @test -z "$(DESTDIR)" || { status=0; \
+	   for path in $(need-DESTDIR-compatibility); do \
+	     $(MAKE) --no-print-directory $$path  DESTDIR="$(DESTDIR)" || status=$$?; \
+	     test 0 -eq $$status || break ;\
+	   done; \
+	   exit $$status; }
+
+$(need-DESTDIR-compatibility):
+	 @case "$($@)" in *:*) \
+	   echo DESTDIR is not supported when $@ contains Win32 path \`$($@)\'\; \
+	   try adding \`$@=$(shell echo '$($@)' | sed s,:,:$(DESTDIR),)\' to \`[overrides ...]\', \
+	   and execute \`make install [overrides ...]\' instead. ;\
+	   exit 2 ;; \
+	 esac
+
+install-dirs: check-DESTDIR-compatibility
+	@echo all DESTDIR checks passed
+	$(mkinstalldirs) $(DESTDIR)$(inst_bindir)
+	$(mkinstalldirs) $(DESTDIR)$(inst_includedir)
+	$(mkinstalldirs) $(DESTDIR)$(inst_libdir)
+	$(mkinstalldirs) $(DESTDIR)$(inst_docdir)
+	$(mkinstalldirs) $(DESTDIR)$(mandir)/man$(mansection)
 
 install: all install-dirs $(install_dlls_host)
 	for i in $(LIBS); do \
-		$(INSTALL_DATA) $$i $(inst_libdir)/$$i ; \
+		$(INSTALL_DATA) $$i $(DESTDIR)$(inst_libdir)/$$i ; \
 	done
 	for i in $(CRT0S); do \
-		$(INSTALL_DATA) $$i $(inst_libdir)/$$i ; \
+		$(INSTALL_DATA) $$i $(DESTDIR)$(inst_libdir)/$$i ; \
 	done
 	for i in $(INSTDOCS); do \
-		$(INSTALL_DATA) $(srcdir)/$$i $(inst_docdir)/$$i ; \
+		$(INSTALL_DATA) $(srcdir)/$$i $(DESTDIR)$(inst_docdir)/$$i ; \
 	done
 	for sub in . sys ; do \
-		dstdir=$(inst_includedir)/$$sub ; \
+		dstdir=$(DESTDIR)$(inst_includedir)/$$sub ; \
 		$(mkinstalldirs) $$dstdir ; \
 		for i in $(srcdir)/include/$$sub/*.h ; do \
 		  $(INSTALL_DATA) $$i $$dstdir/`basename $$i` ; \
@@ -521,10 +544,10 @@ install: all install-dirs $(install_dlls
 # This provisional hack installs the only manpage we have at present...
 # It simply CANNOT suffice, when we have more manpages to ship.
 #
-	$(mkinstalldirs) $(mandir)/man$(mansection)
-	$(INSTALL_DATA) $(srcdir)/man/dirname.man $(mandir)/man$(mansection)/`\
+	$(mkinstalldirs) $(DESTDIR)$(mandir)/man$(mansection)
+	$(INSTALL_DATA) $(srcdir)/man/dirname.man $(DESTDIR)$(mandir)/man$(mansection)/`\
 	  echo dirname.man|sed '$(manpage_transform);s,man$$,$(mansection),'`
-	$(INSTALL_DATA) $(srcdir)/man/dirname.man $(mandir)/man$(mansection)/`\
+	$(INSTALL_DATA) $(srcdir)/man/dirname.man $(DESTDIR)$(mandir)/man$(mansection)/`\
 	  echo basename.man|sed '$(manpage_transform);s,man$$,$(mansection),'`
 #
 # End provisional hack.
Index: mingw/mingwex/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/mingw/mingwex/Makefile.in,v
retrieving revision 1.47
diff -u -p -r1.47 Makefile.in
--- mingw/mingwex/Makefile.in	27 Jul 2009 20:27:09 -0000	1.47
+++ mingw/mingwex/Makefile.in	22 Oct 2009 20:43:27 -0000
@@ -255,10 +255,30 @@ info-html:
 
 install-info: info
 
-install: all
-	$(mkinstalldirs) $(inst_libdir)
+need-DESTDIR-compatibility = prefix libdir
+.PHONY: check-DESTDIR-compatibility $(need-DESTDIR-compatibility)
+
+check-DESTDIR-compatibility:
+	 @test -z "$(DESTDIR)" || { status=0; \
+	   for path in $(need-DESTDIR-compatibility); do \
+	     $(MAKE) --no-print-directory $$path  DESTDIR="$(DESTDIR)" || status=$$?; \
+	     test 0 -eq $$status || break ;\
+	   done; \
+	   exit $$status; }
+
+$(need-DESTDIR-compatibility):
+	 @case "$($@)" in *:*) \
+	   echo DESTDIR is not supported when $@ contains Win32 path \`$($@)\'\; \
+	   try adding \`$@=$(shell echo '$($@)' | sed s,:,:$(DESTDIR),)\' to \`[overrides ...]\', \
+	   and execute \`make install [overrides ...]\' instead. ;\
+	   exit 2 ;; \
+	 esac
+
+install: all check-DESTDIR-compatibility
+	@echo all DESTDIR checks passed
+	$(mkinstalldirs) $(DESTDIR)$(inst_libdir)
 	for i in $(LIBS); do \
-		$(INSTALL_DATA) $$i $(inst_libdir)/$$i ; \
+		$(INSTALL_DATA) $$i $(DESTDIR)$(inst_libdir)/$$i ; \
 	done
 
 clean:
Index: mingw/profile/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/mingw/profile/Makefile.in,v
retrieving revision 1.17
diff -u -p -r1.17 Makefile.in
--- mingw/profile/Makefile.in	27 Jul 2009 20:27:09 -0000	1.17
+++ mingw/profile/Makefile.in	22 Oct 2009 20:43:27 -0000
@@ -128,18 +128,38 @@ info-html:
 
 install-info: info
 
-install: all
-	$(mkinstalldirs) $(inst_libdir) 
+need-DESTDIR-compatibility = prefix libdir includedir
+.PHONY: check-DESTDIR-compatibility $(need-DESTDIR-compatibility)
+
+check-DESTDIR-compatibility:
+	 @test -z "$(DESTDIR)" || { status=0; \
+	   for path in $(need-DESTDIR-compatibility); do \
+	     $(MAKE) --no-print-directory $$path  DESTDIR="$(DESTDIR)" || status=$$?; \
+	     test 0 -eq $$status || break ;\
+	   done; \
+	   exit $$status; }
+
+$(need-DESTDIR-compatibility):
+	 @case "$($@)" in *:*) \
+	   echo DESTDIR is not supported when $@ contains Win32 path \`$($@)\'\; \
+	   try adding \`$@=$(shell echo '$($@)' | sed s,:,:$(DESTDIR),)\' to \`[overrides ...]\', \
+	   and execute \`make install [overrides ...]\' instead. ;\
+	   exit 2 ;; \
+	 esac
+
+install: all check-DESTDIR-compatibility
+	@echo all DESTDIR checks passed
+	$(mkinstalldirs) $(DESTDIR)$(inst_libdir) 
 	for i in $(LIBS); do \
-		$(INSTALL_DATA) $$i $(inst_libdir)/$$i ; \
+		$(INSTALL_DATA) $$i $(DESTDIR)$(inst_libdir)/$$i ; \
 	done
 	for i in $(CRT0S); do \
-		$(INSTALL_DATA) $$i $(inst_libdir)/$$i ; \
+		$(INSTALL_DATA) $$i $(DESTDIR)$(inst_libdir)/$$i ; \
 	done
 	for sub in . ; do \
-	$(mkinstalldirs) $(inst_includedir)/$$sub ; \
+	$(mkinstalldirs) $(DESTDIR)$(inst_includedir)/$$sub ; \
 		for i in $(srcdir)/$$sub/*.h ; do \
-		  $(INSTALL_DATA) $$i $(inst_includedir)/$$sub/`basename $$i` ; \
+		  $(INSTALL_DATA) $$i $(DESTDIR)$(inst_includedir)/$$sub/`basename $$i` ; \
 		done ; \
 	done
 
Index: w32api/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/w32api/Makefile.in,v
retrieving revision 1.47
diff -u -p -r1.47 Makefile.in
--- w32api/Makefile.in	6 Dec 2008 02:25:28 -0000	1.47
+++ w32api/Makefile.in	22 Oct 2009 20:43:28 -0000
@@ -58,6 +58,7 @@ FLAGS_TO_PASS = \
 	RANLIB="$(RANLIB)" \
 	LD="$(LD)" \
 	DLLTOOL="$(DLLTOOL)" \
+	DESTDIR="$(DESTDIR)" \
 	TAR="$(TAR)" \
 	TARFLAGS="$(TARFLAGS)" \
 	TARFILEEXT="$(TARFILEEXT)" \
@@ -89,7 +90,7 @@ test:
 
 install uninstall:
 	for i in $(SUBDIRS); do \
-		(cd $$i; $(MAKE) $@); \
+		(cd $$i; $(MAKE) $@ $(FLAGS_TO_PASS)); \
 	done
 
 ifdef SNAPDATE
Index: w32api/lib/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/w32api/lib/Makefile.in,v
retrieving revision 1.46
diff -u -p -r1.46 Makefile.in
--- w32api/lib/Makefile.in	29 Jan 2008 21:18:49 -0000	1.46
+++ w32api/lib/Makefile.in	22 Oct 2009 20:43:28 -0000
@@ -101,6 +101,7 @@ FLAGS_TO_PASS = \
 	RANLIB="$(RANLIB)" \
 	LD="$(LD)" \
 	DLLTOOL="$(DLLTOOL)" \
+	DESTDIR="$(DESTDIR)" \
 	TAR="$(TAR)" \
 	TARFLAGS="$(TARFLAGS)" \
 	TARFILEEXT="$(TARFILEEXT)" \
@@ -208,24 +209,45 @@ lib%.a: %.o
 	$(AR) rc $@ $*.o
 	$(RANLIB) $@
 
+need-DESTDIR-compatibility = prefix libdir includedir
+.PHONY: check-DESTDIR-compatibility $(need-DESTDIR-compatibility)
+
+check-DESTDIR-compatibility:
+	@test -z "$(DESTDIR)" || { status=0; \
+	  for path in $(need-DESTDIR-compatibility); do \
+	    $(MAKE) --no-print-directory $$path  DESTDIR="$(DESTDIR)" || status=$$?; \
+	    test 0 -eq $$status || break ;\
+	  done; \
+	  exit $$status; }
+
+$(need-DESTDIR-compatibility):
+	@case "$($@)" in *:*) \
+	  echo DESTDIR is not supported when $@ contains Win32 path \`$($@)\'\; \
+	  try adding \`$@=$(shell echo '$($@)' | sed s,:,:$(DESTDIR),)\' to \`[overrides ...]\', \
+	  and execute \`make install [overrides ...]\' instead. ;\
+	  exit 2 ;; \
+	esac
+
 .PHONY: install install-libraries install-headers install-ddk
 # install headers and libraries in a target specified directory.
 install: install-libraries install-headers install-ddk install-directx
 
-install-libraries: all
-	$(mkinstalldirs) $(inst_libdir)
+install-libraries: all check-DESTDIR-compatibility
+	@echo all DESTDIR checks passed
+	$(mkinstalldirs) $(DESTDIR)$(inst_libdir)
 	for i in $(LIBS); do \
-		$(INSTALL_DATA) $$i $(inst_libdir)/$$i ; \
+		$(INSTALL_DATA) $$i $(DESTDIR)$(inst_libdir)/$$i ; \
 	done
 
-install-headers:
-	$(mkinstalldirs) $(inst_includedir)
+install-headers: check-DESTDIR-compatibility
+	@echo all DESTDIR checks passed
+	$(mkinstalldirs) $(DESTDIR)$(inst_includedir)
 	for i in $(HEADERS); do \
-		$(INSTALL_DATA) $(srcdir)/../include/$$i $(inst_includedir)/$$i ; \
+		$(INSTALL_DATA) $(srcdir)/../include/$$i $(DESTDIR)$(inst_includedir)/$$i ; \
 	done
-	$(mkinstalldirs) $(inst_includedir)/GL
+	$(mkinstalldirs) $(DESTDIR)$(inst_includedir)/GL
 	for i in $(GL_HEADERS); do \
-		$(INSTALL_DATA) $(srcdir)/../include/GL/$$i $(inst_includedir)/GL/$$i ; \
+		$(INSTALL_DATA) $(srcdir)/../include/GL/$$i $(DESTDIR)$(inst_includedir)/GL/$$i ; \
 	done
 
 install-ddk: install-libraries install-headers
@@ -237,17 +259,19 @@ install-directx: install-libraries insta
 # uninstall headers and libraries from a target specified directory
 uninstall: uninstall-ddk uninstall-directx uninstall-libraries uninstall-headers
 
-uninstall-libraries:
+uninstall-libraries: check-DESTDIR-compatibility
+	@echo all DESTDIR checks passed
 	@for i in $(LIBS); do \
-		rm -f $(inst_libdir)/$$i ; \
+		rm -f $(DESTDIR)$(inst_libdir)/$$i ; \
 	done
-	rmdir $(inst_libdir)
+	rmdir $(DESTDIR)$(inst_libdir)
 
-uninstall-headers:
+uninstall-headers: check-DESTDIR-compatibility
+	@echo all DESTDIR checks passed
 	@for i in $(HEADERS); do \
-		rm -r $(inst_includedir)/$$i ; \
+		rm -r $(DESTDIR)$(inst_includedir)/$$i ; \
 	done
-	rmdir $(inst_includedir)
+	rmdir $(DESTDIR)$(inst_includedir)
 
 uninstall-ddk:
 	cd ddk && $(MAKE) -C uninstall $(FLAGS_TO_PASS)
Index: w32api/lib/ddk/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/w32api/lib/ddk/Makefile.in,v
retrieving revision 1.5
diff -u -p -r1.5 Makefile.in
--- w32api/lib/ddk/Makefile.in	12 Sep 2006 00:29:04 -0000	1.5
+++ w32api/lib/ddk/Makefile.in	22 Oct 2009 20:43:28 -0000
@@ -141,35 +141,58 @@ lib%.a: %.o
 	$(AR) rc $@ $*.o
 	$(RANLIB) $@
 
+need-DESTDIR-compatibility = prefix libdir includedir
+.PHONY: check-DESTDIR-compatibility $(need-DESTDIR-compatibility)
+
+check-DESTDIR-compatibility:
+	@test -z "$(DESTDIR)" || { status=0; \
+	  for path in $(need-DESTDIR-compatibility); do \
+	    $(MAKE) --no-print-directory $$path  DESTDIR="$(DESTDIR)" || status=$$?; \
+	    test 0 -eq $$status || break ;\
+	  done; \
+	exit $$status; }
+
+$(need-DESTDIR-compatibility):
+	@case "$($@)" in *:*) \
+	  echo DESTDIR is not supported when $@ contains Win32 path \`$($@)\'\; \
+	  try adding \`$@=$(shell echo '$($@)' | sed s,:,:$(DESTDIR),)\' to \`[overrides ...]\', \
+	  and execute \`make install [overrides ...]\' instead. ;\
+	  exit 2 ;; \
+	esac
+
 # install headers and libraries in a target specified directory.
 install: install-libraries install-headers
 
-install-libraries: all
-	$(mkinstalldirs) $(inst_libdir)
+install-libraries: all check-DESTDIR-compatibility
+	@echo all DESTDIR checks passed
+	$(mkinstalldirs) $(DESTDIR)$(inst_libdir)
 	for i in $(LIBS); do \
-		$(INSTALL_DATA) $$i $(inst_libdir)/$$i ; \
+		$(INSTALL_DATA) $$i $(DESTDIR)$(inst_libdir)/$$i ; \
 	done
 
-install-headers:
-	$(mkinstalldirs) $(inst_includedir)
+install-headers: check-DESTDIR-compatibility
+	@echo all DESTDIR checks passed
+	$(mkinstalldirs) $(DESTDIR)$(inst_includedir)
 	for i in $(HEADERS); do \
-		$(INSTALL_DATA) $(srcdir)/../../include/ddk/$$i $(inst_includedir)/$$i ; \
+		$(INSTALL_DATA) $(srcdir)/../../include/ddk/$$i $(DESTDIR)$(inst_includedir)/$$i ; \
 	done
 
 # uninstall headers and libraries from a target specified directory
 uninstall: uninstall-libraries uninstall-headers
 
-uninstall-libraries:
+uninstall-libraries: check-DESTDIR-compatibility
+	@echo all DESTDIR checks passed
 	@for i in $(LIBS); do \
-		rm -f $(inst_libdir)/$$i ; \
+		rm -f $(DESTDIR)$(inst_libdir)/$$i ; \
 	done
-	rmdir $(inst_libdir)
+	rmdir $(DESTDIR)$(inst_libdir)
 
-uninstall-headers:
+uninstall-headers: check-DESTDIR-compatibility
+	@echo all DESTDIR checks passed
 	@for i in $(HEADERS); do \
-		rm -r $(inst_includedir)/$$i ; \
+		rm -r $(DESTDIR)$(inst_includedir)/$$i ; \
 	done
-	rmdir $(inst_includedir)
+	rmdir $(DESTDIR)$(inst_includedir)
 
 
 dist:
Index: w32api/lib/directx/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/w32api/lib/directx/Makefile.in,v
retrieving revision 1.4
diff -u -p -r1.4 Makefile.in
--- w32api/lib/directx/Makefile.in	12 Sep 2006 00:29:04 -0000	1.4
+++ w32api/lib/directx/Makefile.in	22 Oct 2009 20:43:28 -0000
@@ -166,35 +166,58 @@ lib%.a: %.o
 	$(AR) rc $@ $*.o
 	$(RANLIB) $@
 
+need-DESTDIR-compatibility = prefix libdir includedir
+.PHONY: check-DESTDIR-compatibility $(need-DESTDIR-compatibility)
+
+check-DESTDIR-compatibility:
+	@test -z "$(DESTDIR)" || { status=0; \
+	  for path in $(need-DESTDIR-compatibility); do \
+	    $(MAKE) --no-print-directory $$path  DESTDIR="$(DESTDIR)" || status=$$?; \
+	    test 0 -eq $$status || break ;\
+	  done; \
+	  exit $$status; }
+
+$(need-DESTDIR-compatibility):
+	@case "$($@)" in *:*) \
+	  echo DESTDIR is not supported when $@ contains Win32 path \`$($@)\'\; \
+	  try adding \`$@=$(shell echo '$($@)' | sed s,:,:$(DESTDIR),)\' to \`[overrides ...]\', \
+	  and execute \`make install [overrides ...]\' instead. ;\
+	  exit 2 ;; \
+	esac
+
 # install headers and libraries in a target specified directory.
 install: install-libraries install-headers
 
-install-libraries: all
-	$(mkinstalldirs) $(inst_libdir)
+install-libraries: all check-DESTDIR-compatibility
+	@echo all DESTDIR checks passed
+	$(mkinstalldirs) $(DESTDIR)$(inst_libdir)
 	for i in $(LIBS); do \
-		$(INSTALL_DATA) $$i $(inst_libdir)/$$i ; \
+		$(INSTALL_DATA) $$i $(DESTDIR)$(inst_libdir)/$$i ; \
 	done
 
-install-headers:
-	$(mkinstalldirs) $(inst_includedir)
+install-headers: check-DESTDIR-compatibility
+	@echo all DESTDIR checks passed
+	$(mkinstalldirs) $(DESTDIR)$(inst_includedir)
 	for i in $(HEADERS); do \
-		$(INSTALL_DATA) $(srcdir)/../../include/directx/$$i $(inst_includedir)/$$i ; \
+		$(INSTALL_DATA) $(srcdir)/../../include/directx/$$i $(DESTDIR)$(inst_includedir)/$$i ; \
 	done
 
 # uninstall headers and libraries from a target specified directory
 uninstall: uninstall-libraries uninstall-headers
 
-uninstall-libraries:
+uninstall-libraries: check-DESTDIR-compatibility
+	@echo all DESTDIR checks passed
 	@for i in $(LIBS); do \
-		rm -f $(inst_libdir)/$$i ; \
+		rm -f $(DESTDIR)$(inst_libdir)/$$i ; \
 	done
-	rmdir $(inst_libdir)
+	rmdir $(DESTDIR)$(inst_libdir)
 
-uninstall-headers:
+uninstall-headers: check-DESTDIR-compatibility
+	@echo all DESTDIR checks passed
 	@for i in $(HEADERS); do \
-		rm -r $(inst_includedir)/$$i ; \
+		rm -r $(DESTDIR)$(inst_includedir)/$$i ; \
 	done
-	rmdir $(inst_includedir)
+	rmdir $(DESTDIR)$(inst_includedir)
 
 
 dist:

--------------000103070903060308010500--
