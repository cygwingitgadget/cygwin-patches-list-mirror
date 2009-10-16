Return-Path: <cygwin-patches-return-6777-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10967 invoked by alias); 16 Oct 2009 20:57:33 -0000
Received: (qmail 10953 invoked by uid 22791); 16 Oct 2009 20:57:32 -0000
X-SWARE-Spam-Status: No, hits=-3.3 required=5.0 	tests=AWL,BAYES_00,HK_OBFDOM,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from out1.smtp.messagingengine.com (HELO out1.smtp.messagingengine.com) (66.111.4.25)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 16 Oct 2009 20:57:28 +0000
Received: from compute1.internal (compute1.internal [10.202.2.41]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id 6D288B0A89 	for <cygwin-patches@cygwin.com>; Fri, 16 Oct 2009 16:57:26 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])   by compute1.internal (MEProxy); Fri, 16 Oct 2009 16:57:26 -0400
Received: from [192.168.1.3] (user-0c6sbc4.cable.mindspring.com [24.110.45.132]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id C390117D427; 	Fri, 16 Oct 2009 16:57:25 -0400 (EDT)
Message-ID: <4AD8DE16.3030506@cwilson.fastmail.fm>
Date: Fri, 16 Oct 2009 20:57:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Honor DESTDIR in w32api and mingw
References: <4AD78C5B.2080107@cwilson.fastmail.fm> <4AD7C107.6000803@byu.net> <4AD7D356.8030703@cwilson.fastmail.fm>
In-Reply-To: <4AD7D356.8030703@cwilson.fastmail.fm>
Content-Type: multipart/mixed;  boundary="------------050804040209060201000309"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00108.txt.bz2

This is a multi-part message in MIME format.
--------------050804040209060201000309
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 1063

Charles Wilson wrote:
>> Why are you setting DESTDIR?  My understanding is that for DESTDIR to work
>> reliably, you need to use $(DESTDIR), but not set it.  Then make will
>> default it to empty, which can be changed by either 'make DESTDIR=...' or
>> 'env DESTDIR=... make -e'.
> 
> Oh, ok.  I'll take those bits out -- I'm just always used to explicitly
> setting it (empty).  I see that, if they support DESTDIR at all, both
> automake-generated and custom Makefile.in's in src/ seem to follow your
> rule.

Better?  Who can approve this?

2009-10-15  Charles Wilson  <...>

	Honor DESTDIR for winsup/mingw and winsup/w32api.
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


--------------050804040209060201000309
Content-Type: text/plain;
 name="mingw-destdir.patch2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mingw-destdir.patch2"
Content-length: 10149

Index: winsup/mingw/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/mingw/Makefile.in,v
retrieving revision 1.89
diff -u -p -r1.89 Makefile.in
--- winsup/mingw/Makefile.in	27 Jul 2009 20:27:09 -0000	1.89
+++ winsup/mingw/Makefile.in	15 Oct 2009 20:30:09 -0000
@@ -204,6 +204,7 @@ FLAGS_TO_PASS:=\
 	RANLIB="$(RANLIB)" \
 	LD="$(LD)" \
 	DLLTOOL="$(DLLTOOL)" \
+	DESTDIR="$(DESTDIR)" \
 	exec_prefix="$(exec_prefix)" \
 	bindir="$(bindir)" \
 	libdir="$(libdir)" \
@@ -274,7 +275,7 @@ all_dlls_host: $(DLLS)
 
 install_dlls_host:
 	for i in $(DLLS); do \
-		$(INSTALL_PROGRAM) $$i $(inst_bindir)/$$i ; \
+		$(INSTALL_PROGRAM) $$i $(DESTDIR)$(inst_bindir)/$$i ; \
 	done
 
 _libm_dummy.o:
@@ -494,37 +495,37 @@ info-html:
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
Index: winsup/mingw/mingwex/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/mingw/mingwex/Makefile.in,v
retrieving revision 1.47
diff -u -p -r1.47 Makefile.in
--- winsup/mingw/mingwex/Makefile.in	27 Jul 2009 20:27:09 -0000	1.47
+++ winsup/mingw/mingwex/Makefile.in	15 Oct 2009 20:30:09 -0000
@@ -256,9 +256,9 @@ info-html:
 install-info: info
 
 install: all
-	$(mkinstalldirs) $(inst_libdir)
+	$(mkinstalldirs) $(DESTDIR)$(inst_libdir)
 	for i in $(LIBS); do \
-		$(INSTALL_DATA) $$i $(inst_libdir)/$$i ; \
+		$(INSTALL_DATA) $$i $(DESTDIR)$(inst_libdir)/$$i ; \
 	done
 
 clean:
Index: winsup/mingw/profile/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/mingw/profile/Makefile.in,v
retrieving revision 1.17
diff -u -p -r1.17 Makefile.in
--- winsup/mingw/profile/Makefile.in	27 Jul 2009 20:27:09 -0000	1.17
+++ winsup/mingw/profile/Makefile.in	15 Oct 2009 20:30:09 -0000
@@ -129,17 +129,17 @@ info-html:
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
 
Index: winsup/w32api/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/w32api/Makefile.in,v
retrieving revision 1.47
diff -u -p -r1.47 Makefile.in
--- winsup/w32api/Makefile.in	6 Dec 2008 02:25:28 -0000	1.47
+++ winsup/w32api/Makefile.in	15 Oct 2009 20:30:09 -0000
@@ -58,6 +58,7 @@ FLAGS_TO_PASS = \
 	RANLIB="$(RANLIB)" \
 	LD="$(LD)" \
 	DLLTOOL="$(DLLTOOL)" \
+	DESTDIR="$(DESTDIR)" \
 	TAR="$(TAR)" \
 	TARFLAGS="$(TARFLAGS)" \
 	TARFILEEXT="$(TARFILEEXT)" \
Index: winsup/w32api/lib/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/w32api/lib/Makefile.in,v
retrieving revision 1.46
diff -u -p -r1.46 Makefile.in
--- winsup/w32api/lib/Makefile.in	29 Jan 2008 21:18:49 -0000	1.46
+++ winsup/w32api/lib/Makefile.in	15 Oct 2009 20:30:09 -0000
@@ -101,6 +101,7 @@ FLAGS_TO_PASS = \
 	RANLIB="$(RANLIB)" \
 	LD="$(LD)" \
 	DLLTOOL="$(DLLTOOL)" \
+	DESTDIR="$(DESTDIR)" \
 	TAR="$(TAR)" \
 	TARFLAGS="$(TARFLAGS)" \
 	TARFILEEXT="$(TARFILEEXT)" \
@@ -213,19 +214,19 @@ lib%.a: %.o
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
@@ -239,15 +240,15 @@ uninstall: uninstall-ddk uninstall-direc
 
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
Index: winsup/w32api/lib/ddk/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/w32api/lib/ddk/Makefile.in,v
retrieving revision 1.5
diff -u -p -r1.5 Makefile.in
--- winsup/w32api/lib/ddk/Makefile.in	12 Sep 2006 00:29:04 -0000	1.5
+++ winsup/w32api/lib/ddk/Makefile.in	15 Oct 2009 20:30:09 -0000
@@ -145,15 +145,15 @@ lib%.a: %.o
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
@@ -161,15 +161,15 @@ uninstall: uninstall-libraries uninstall
 
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
Index: winsup/w32api/lib/directx/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/w32api/lib/directx/Makefile.in,v
retrieving revision 1.4
diff -u -p -r1.4 Makefile.in
--- winsup/w32api/lib/directx/Makefile.in	12 Sep 2006 00:29:04 -0000	1.4
+++ winsup/w32api/lib/directx/Makefile.in	15 Oct 2009 20:30:09 -0000
@@ -170,15 +170,15 @@ lib%.a: %.o
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
@@ -186,15 +186,15 @@ uninstall: uninstall-libraries uninstall
 
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

--------------050804040209060201000309--
