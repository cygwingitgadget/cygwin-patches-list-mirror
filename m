From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: w32api patch
Date: Mon, 11 Dec 2000 10:13:00 -0000
Message-id: <20001211131337.A7293@redhat.com>
X-SW-Source: 2000-q4/msg00045.html

The patch below is necessary when installing cross toolchains.  This
mimics the behavior of the cygwin directory.

cgf

Mon Dec 11 13:11:36 2000  Christopher Faylor <cgf@cygnus.com>

	* lib/Makefile.in: Install headers and libraries in tooldir.

Index: lib/Makefile.in
===================================================================
RCS file: /cvs/uberbaum/winsup/w32api/lib/Makefile.in,v
retrieving revision 1.4
diff -u -p -r1.4 Makefile.in
--- Makefile.in	2000/11/06 16:17:16	1.4
+++ Makefile.in	2000/12/11 18:12:49
@@ -22,7 +22,15 @@ program_transform_name = @program_transf
 exec_prefix = @exec_prefix@
 bindir = @bindir@
 libdir = @libdir@
-tooldir = $(exec_prefix)/$(target_alias)
+ifeq ($(target_alias),$(host_alias))
+ifeq ($(build_alias),$(host_alias))
+tooldir:=$(exec_prefix)
+else
+tooldir:=$(exec_prefix)/$(target_alias)
+endif
+else
+tooldir:=$(exec_prefix)/$(target_alias)
+endif
 datadir = @datadir@
 infodir = @infodir@
 includedir = @includedir@
@@ -158,16 +166,16 @@ xuninstall-headers:
 install: install-libraries install-headers
 
 install-libraries: all
-	$(mkinstalldirs) $(exec_prefix)/lib
+	$(mkinstalldirs) $(tooldir)/lib
 	for i in $(LIBS); do \
-		$(INSTALL_DATA) $$i $(exec_prefix)/lib/$$i ; \
+		$(INSTALL_DATA) $$i $(tooldir)/lib/$$i ; \
 	done
 
 install-headers:
-	$(mkinstalldirs) $(exec_prefix)/include/w32api
+	$(mkinstalldirs) $(tooldir)/include/w32api
 	for i in $(HEADERS); do \
-		$(INSTALL_DATA) $(srcdir)/../include/$$i $(exec_prefix)/include/w32api/$$i ; \
-		echo "#include <w32api/$$i>" > $(exec_prefix)/include/$$i ; \
+		$(INSTALL_DATA) $(srcdir)/../include/$$i $(tooldir)/include/w32api/$$i ; \
+		echo "#include <w32api/$$i>" > $(tooldir)/include/$$i ; \
 	done
 
 # uninstall headers and libraries 
@@ -175,14 +183,14 @@ uninstall: uninstall-libraries uninstall
 
 uninstall-libraries:
 	@for i in $(LIBS); do \
-		rm -f $(exec_prefix)/lib/$$i ; \
+		rm -f $(tooldir)/lib/$$i ; \
 	done
 
 uninstall-headers:
 	@for i in $(HEADERS); do \
-		rm -f $(exec_prefix)/include/w32api/$$i ; \
+		rm -f $(tooldir)/include/w32api/$$i ; \
 	done
-	rmdir $(exec_prefix)/include/w32api
+	rmdir $(tooldir)/include/w32api
 
 dist:
 	mkdir $(distdir)/include
