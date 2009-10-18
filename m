Return-Path: <cygwin-patches-return-6791-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22336 invoked by alias); 18 Oct 2009 23:27:02 -0000
Received: (qmail 22316 invoked by uid 22791); 18 Oct 2009 23:27:00 -0000
X-SWARE-Spam-Status: No, hits=-3.3 required=5.0 	tests=AWL,BAYES_00,HK_OBFDOM,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from out1.smtp.messagingengine.com (HELO out1.smtp.messagingengine.com) (66.111.4.25)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 18 Oct 2009 23:26:51 +0000
Received: from compute1.internal (compute1.internal [10.202.2.41]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id 2B9ACAC2F9 	for <cygwin-patches@cygwin.com>; Sun, 18 Oct 2009 19:26:50 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])   by compute1.internal (MEProxy); Sun, 18 Oct 2009 19:26:50 -0400
Received: from [192.168.1.3] (user-0c6sbc4.cable.mindspring.com [24.110.45.132]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id 54D284FBC2; 	Sun, 18 Oct 2009 19:26:49 -0400 (EDT)
Message-ID: <4ADBA434.4010400@cwilson.fastmail.fm>
Date: Sun, 18 Oct 2009 23:27:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Honor DESTDIR in w32api and mingw
References: <4AD78C5B.2080107@cwilson.fastmail.fm> <4AD7C107.6000803@byu.net> <4AD7D356.8030703@cwilson.fastmail.fm> <4AD8DE16.3030506@cwilson.fastmail.fm> <20091018084824.GA25560@calimero.vinschen.de> <4ADB22B8.5060108@cwilson.fastmail.fm> <4ADB3D80.4050108@gmail.com> <4ADB542B.6020701@cwilson.fastmail.fm> <4ADB5F8A.7080902@gmail.com>
In-Reply-To: <4ADB5F8A.7080902@gmail.com>
Content-Type: multipart/mixed;  boundary="------------020902050007020600050909"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00122.txt.bz2

This is a multi-part message in MIME format.
--------------020902050007020600050909
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 3675

Dave Korn wrote:
> Yes, I think everything that lives in the /src repository should
> consider itself obliged to adhere to the common conventions. ... That
> ought to be able to accommodate everyone's wishes, no?

With regards to the limited issue of DESTDIR (not all the other issues
surrounding mingw/ and w32api/ as subdirs of the winsup tree), the
following revised patch ought to make everybody happy.


We'll see what Keith says -- I've pasted a copy of my latest message to
mingw-dvlpr, below:

Keith Marshall wrote:
> I would rather say that it [DESTDIR] is deliberately
> unsupported, because it cannot be made to work, on the platform for 
> which the code is designated.

The real issue is that when configured such that prefix (or any other
configured directory like includedir) contains X:, then DESTDIR won't work.

If prefix does not contain X:, then DESTDIR will work whether it does or
does not itself contain Y: -- subject to the usual caveats about does
the destination exist, do you have permission to write or create
directories there, etc.

And if neither prefix nor DESTDIR contain X:, as is the usual case when
win32 is not involved, then DESTDIR will work (subject to the usual
caveats).

So, how about we flag that with an explicit error message, thus making
it clear that the answer to "Doctor, it hurts when I do this" is "Don't
do that then -- it is *not supported*"

$ make -n install DESTDIR=/tmp/foo prefix=C:/bob
Makefile:26: *** DESTDIR not supported when prefix contains win32 path:
C:/bob.  Stop.

This is the key bit of code, repeated in all 7 makefiles:

prefix_drive:=$(shell echo "$(prefix)" | sed -n -e 's|\(^.:\).*$$|\1|p')
ifneq (,$(DESTDIR))
ifneq (,$(prefix_drive))
$(error DESTDIR not supported when prefix contains win32 path: $(prefix))
endif
endif


I could extend the error message, as below if desired:

$ make -n install DESTDIR=/tmp/foo prefix=C:/bob
Makefile:44: *** DESTDIR not supported when $(prefix) contains win32
path: C:/bob. Try this instead: 'make install prefix=/tmp/foo/bob'.  Stop.

Which would look like this:

prefix_drive:=$(shell echo "$(prefix)" | sed -n -e 's|\(^.:\).*$$|\1|p')
ifneq (,$(DESTDIR))
ifneq (,$(prefix_drive))
prefix_path:=$(shell echo "$(prefix)" | sed -e 's|^.:||')
$(error DESTDIR not supported when $$(prefix) contains win32 path:
$(prefix). Try this instead: 'make install prefix=$(DESTDIR)$(prefix_path)')
endif
endif




I suppose it's possible for prefix to contain a posix-style path, but
some OTHER configured directory to be win32-style. This error-checking
won't catch that.  But if somebody does "--prefix=/foo
--includedir=C:\bar" and then they ALSO try to do a DESTDIR
install...frankly, if they complain about that on the list we should
break out the giant clue-bat and metaphorically beat them with it. That
setup is just...pathological.


Anyway, this allows for mingw/ and winsup/ to support DESTDIR like the
rest of src -- for those platforms and configurations where it will
actually work; while making it clear that for win32ish configuration
"Don't Do That".

Revised patch attached.

2009-10-18  Charles Wilson  <...>

	Honor DESTDIR for winsup/mingw and winsup/w32api.
	Error if $(prefix) contains win32 path but DESTDIR non-empty.
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

--------------020902050007020600050909
Content-Type: text/plain;
 name="mingw-destdir.patch3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mingw-destdir.patch3"
Content-length: 12835

Index: mingw/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/mingw/Makefile.in,v
retrieving revision 1.89
diff -u -p -r1.89 Makefile.in
--- mingw/Makefile.in	27 Jul 2009 20:27:09 -0000	1.89
+++ mingw/Makefile.in	18 Oct 2009 22:52:37 -0000
@@ -36,6 +36,14 @@ target_alias = @target_alias@
 with_cross_host = @with_cross_host@
 prefix = @prefix@
 conf_prefix = @prefix@
+
+prefix_drive:=$(shell echo "$(prefix)" | sed -n -e 's|\(^.:\).*$$|\1|p')
+ifneq (,$(DESTDIR))
+ifneq (,$(prefix_drive))
+$(error DESTDIR not supported when prefix contains win32 path: $(prefix))
+endif
+endif
+
 host_os = @host_os@
 
 datarootdir = @datarootdir@
@@ -204,6 +212,7 @@ FLAGS_TO_PASS:=\
 	RANLIB="$(RANLIB)" \
 	LD="$(LD)" \
 	DLLTOOL="$(DLLTOOL)" \
+	DESTDIR="$(DESTDIR)" \
 	exec_prefix="$(exec_prefix)" \
 	bindir="$(bindir)" \
 	libdir="$(libdir)" \
@@ -274,7 +283,7 @@ all_dlls_host: $(DLLS)
 
 install_dlls_host:
 	for i in $(DLLS); do \
-		$(INSTALL_PROGRAM) $$i $(inst_bindir)/$$i ; \
+		$(INSTALL_PROGRAM) $$i $(DESTDIR)$(inst_bindir)/$$i ; \
 	done
 
 _libm_dummy.o:
@@ -494,37 +503,37 @@ info-html:
 install-info: info
 
 install-dirs:
-	$(mkinstalldirs) $(inst_bindir)
-	$(mkinstalldirs) $(inst_includedir)
-	$(mkinstalldirs) $(inst_libdir)
-	$(mkinstalldirs) $(inst_docdir)
-	$(mkinstalldirs) $(mandir)/man$(mansection)
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
 		dstdir=$(inst_includedir)/$$sub ; \
-		$(mkinstalldirs) $$dstdir ; \
+		$(mkinstalldirs) $(DESTDIR)$$dstdir ; \
 		for i in $(srcdir)/include/$$sub/*.h ; do \
-		  $(INSTALL_DATA) $$i $$dstdir/`basename $$i` ; \
+		  $(INSTALL_DATA) $$i $(DESTDIR)$$dstdir/`basename $$i` ; \
 		done ; \
 	done
 #
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
+++ mingw/mingwex/Makefile.in	18 Oct 2009 22:52:37 -0000
@@ -14,6 +14,13 @@ objdir = .
 target_alias = @target_alias@
 prefix = @prefix@
 
+prefix_drive:=$(shell echo "$(prefix)" | sed -n -e 's|\(^.:\).*$$|\1|p')
+ifneq (,$(DESTDIR))
+ifneq (,$(prefix_drive))
+$(error DESTDIR not supported when prefix contains win32 path: $(prefix))
+endif
+endif
+
 datarootdir = @datarootdir@
 program_transform_name = @program_transform_name@
 exec_prefix = @exec_prefix@
@@ -256,9 +263,9 @@ info-html:
 install-info: info
 
 install: all
-	$(mkinstalldirs) $(inst_libdir)
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
+++ mingw/profile/Makefile.in	18 Oct 2009 22:52:37 -0000
@@ -14,6 +14,13 @@ objdir = .
 target_alias = @target_alias@
 prefix = @prefix@
 
+prefix_drive:=$(shell echo "$(prefix)" | sed -n -e 's|\(^.:\).*$$|\1|p')
+ifneq (,$(DESTDIR))
+ifneq (,$(prefix_drive))
+$(error DESTDIR not supported when prefix contains win32 path: $(prefix))
+endif
+endif
+
 datarootdir = @datarootdir@
 program_transform_name = @program_transform_name@
 exec_prefix = @exec_prefix@
@@ -129,17 +136,17 @@ info-html:
 install-info: info
 
 install: all
-	$(mkinstalldirs) $(inst_libdir) 
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
+++ w32api/Makefile.in	18 Oct 2009 22:52:37 -0000
@@ -19,6 +19,14 @@ host_alias = @host@
 target_alias = @target@
 prefix = @prefix@
 conf_prefix = @prefix@
+
+prefix_drive:=$(shell echo "$(prefix)" | sed -n -e 's|\(^.:\).*$$|\1|p')
+ifneq (,$(DESTDIR))
+ifneq (,$(prefix_drive))
+$(error DESTDIR not supported when prefix contains win32 path: $(prefix))
+endif
+endif
+
 # FIXME: this needs an appropriate AC_SUBST
 host_os = mingw32
 
@@ -58,6 +66,7 @@ FLAGS_TO_PASS = \
 	RANLIB="$(RANLIB)" \
 	LD="$(LD)" \
 	DLLTOOL="$(DLLTOOL)" \
+	DESTDIR="$(DESTDIR)" \
 	TAR="$(TAR)" \
 	TARFLAGS="$(TARFLAGS)" \
 	TARFILEEXT="$(TARFILEEXT)" \
Index: w32api/lib/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/w32api/lib/Makefile.in,v
retrieving revision 1.46
diff -u -p -r1.46 Makefile.in
--- w32api/lib/Makefile.in	29 Jan 2008 21:18:49 -0000	1.46
+++ w32api/lib/Makefile.in	18 Oct 2009 22:52:37 -0000
@@ -23,6 +23,14 @@ build_alias = @build@
 target_alias = @target@
 with_cross_host = @with_cross_host@
 prefix = @prefix@
+
+prefix_drive:=$(shell echo "$(prefix)" | sed -n -e 's|\(^.:\).*$$|\1|p')
+ifneq (,$(DESTDIR))
+ifneq (,$(prefix_drive))
+$(error DESTDIR not supported when prefix contains win32 path: $(prefix))
+endif
+endif
+
 includedir:=@includedir@
 
 program_transform_name = @program_transform_name@
@@ -101,6 +109,7 @@ FLAGS_TO_PASS = \
 	RANLIB="$(RANLIB)" \
 	LD="$(LD)" \
 	DLLTOOL="$(DLLTOOL)" \
+	DESTDIR="$(DESTDIR)" \
 	TAR="$(TAR)" \
 	TARFLAGS="$(TARFLAGS)" \
 	TARFILEEXT="$(TARFILEEXT)" \
@@ -213,19 +222,19 @@ lib%.a: %.o
 install: install-libraries install-headers install-ddk install-directx
 
 install-libraries: all
-	$(mkinstalldirs) $(inst_libdir)
+	$(mkinstalldirs) $(DESTDIR)$(inst_libdir)
 	for i in $(LIBS); do \
-		$(INSTALL_DATA) $$i $(inst_libdir)/$$i ; \
+		$(INSTALL_DATA) $$i $(DESTDIR)$(inst_libdir)/$$i ; \
 	done
 
 install-headers:
-	$(mkinstalldirs) $(inst_includedir)
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
@@ -239,15 +248,15 @@ uninstall: uninstall-ddk uninstall-direc
 
 uninstall-libraries:
 	@for i in $(LIBS); do \
-		rm -f $(inst_libdir)/$$i ; \
+		rm -f $(DESTDIR)$(inst_libdir)/$$i ; \
 	done
-	rmdir $(inst_libdir)
+	rmdir $(DESTDIR)$(inst_libdir)
 
 uninstall-headers:
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
+++ w32api/lib/ddk/Makefile.in	18 Oct 2009 22:52:37 -0000
@@ -19,6 +19,14 @@ build_alias = @build@
 target_alias = @target@
 with_cross_host = @with_cross_host@
 prefix = @prefix@
+
+prefix_drive:=$(shell echo "$(prefix)" | sed -n -e 's|\(^.:\).*$$|\1|p')
+ifneq (,$(DESTDIR))
+ifneq (,$(prefix_drive))
+$(error DESTDIR not supported when prefix contains win32 path: $(prefix))
+endif
+endif
+
 includedir:=@includedir@
 
 program_transform_name = @program_transform_name@
@@ -145,15 +153,15 @@ lib%.a: %.o
 install: install-libraries install-headers
 
 install-libraries: all
-	$(mkinstalldirs) $(inst_libdir)
+	$(mkinstalldirs) $(DESTDIR)$(inst_libdir)
 	for i in $(LIBS); do \
-		$(INSTALL_DATA) $$i $(inst_libdir)/$$i ; \
+		$(INSTALL_DATA) $$i $(DESTDIR)$(inst_libdir)/$$i ; \
 	done
 
 install-headers:
-	$(mkinstalldirs) $(inst_includedir)
+	$(mkinstalldirs) $(DESTDIR)$(inst_includedir)
 	for i in $(HEADERS); do \
-		$(INSTALL_DATA) $(srcdir)/../../include/ddk/$$i $(inst_includedir)/$$i ; \
+		$(INSTALL_DATA) $(srcdir)/../../include/ddk/$$i $(DESTDIR)$(inst_includedir)/$$i ; \
 	done
 
 # uninstall headers and libraries from a target specified directory
@@ -161,15 +169,15 @@ uninstall: uninstall-libraries uninstall
 
 uninstall-libraries:
 	@for i in $(LIBS); do \
-		rm -f $(inst_libdir)/$$i ; \
+		rm -f $(DESTDIR)$(inst_libdir)/$$i ; \
 	done
-	rmdir $(inst_libdir)
+	rmdir $(DESTDIR)$(inst_libdir)
 
 uninstall-headers:
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
+++ w32api/lib/directx/Makefile.in	18 Oct 2009 22:52:37 -0000
@@ -19,6 +19,14 @@ build_alias = @build@
 target_alias = @target@
 with_cross_host = @with_cross_host@
 prefix = @prefix@
+
+prefix_drive:=$(shell echo "$(prefix)" | sed -n -e 's|\(^.:\).*$$|\1|p')
+ifneq (,$(DESTDIR))
+ifneq (,$(prefix_drive))
+$(error DESTDIR not supported when prefix contains win32 path: $(prefix))
+endif
+endif
+
 includedir:=@includedir@
 
 program_transform_name = @program_transform_name@
@@ -170,15 +178,15 @@ lib%.a: %.o
 install: install-libraries install-headers
 
 install-libraries: all
-	$(mkinstalldirs) $(inst_libdir)
+	$(mkinstalldirs) $(DESTDIR)$(inst_libdir)
 	for i in $(LIBS); do \
-		$(INSTALL_DATA) $$i $(inst_libdir)/$$i ; \
+		$(INSTALL_DATA) $$i $(DESTDIR)$(inst_libdir)/$$i ; \
 	done
 
 install-headers:
-	$(mkinstalldirs) $(inst_includedir)
+	$(mkinstalldirs) $(DESTDIR)$(inst_includedir)
 	for i in $(HEADERS); do \
-		$(INSTALL_DATA) $(srcdir)/../../include/directx/$$i $(inst_includedir)/$$i ; \
+		$(INSTALL_DATA) $(srcdir)/../../include/directx/$$i $(DESTDIR)$(inst_includedir)/$$i ; \
 	done
 
 # uninstall headers and libraries from a target specified directory
@@ -186,15 +194,15 @@ uninstall: uninstall-libraries uninstall
 
 uninstall-libraries:
 	@for i in $(LIBS); do \
-		rm -f $(inst_libdir)/$$i ; \
+		rm -f $(DESTDIR)$(inst_libdir)/$$i ; \
 	done
-	rmdir $(inst_libdir)
+	rmdir $(DESTDIR)$(inst_libdir)
 
 uninstall-headers:
 	@for i in $(HEADERS); do \
-		rm -r $(inst_includedir)/$$i ; \
+		rm -r $(DESTDIR)$(inst_includedir)/$$i ; \
 	done
-	rmdir $(inst_includedir)
+	rmdir $(DESTDIR)$(inst_includedir)
 
 
 dist:

--------------020902050007020600050909--
