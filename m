From: Chris Faylor <cgf@cygnus.com>
To: cygwin-patches@sourceware.cygnus.com
Subject: [PATCH] Another mingw Makefile patch
Date: Sat, 17 Jun 2000 15:31:00 -0000
Message-id: <20000617183123.A26076@cygnus.com>
X-SW-Source: 2000-q2/msg00108.html

Last March Mumit checked in a patch to deal with broken shells' handling of
'for f ; in do whatever; done' but the shell in question was too clever
for his fix and still reported an error.

So, I've reorganized the subdirs rule of mingw Makfile.in a little more
to hopefully work around this.

cgf

Sat Jun 17 18:27:59 2000  Christopher Faylor <cgf@cygnus.com>

	* Makefile.in (subdirs): Previous change did not fix problem in
	broken shells.

Index: Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/mingw/Makefile.in,v
retrieving revision 1.3
diff -u -p -r1.3 Makefile.in
--- Makefile.in	2000/06/17 17:48:36	1.3
+++ Makefile.in	2000/06/17 22:23:54
@@ -219,10 +219,9 @@ install: all $(install_dlls_host)
 	@$(MAKE) subdirs DO=$@ $(FLAGS_TO_PASS)
 
 subdirs: force
-	@test -z "$(SUBDIRS)" && exit 0; \
-	for i in $(SUBDIRS); do \
-	   echo "Making $(DO) in $${i}..." ; \
+	@for i in should-never-exist $(SUBDIRS); do \
 	   if [ -d ./$$i ] ; then \
+	     echo "Making $(DO) in $${i}..." ; \
 	     if (rootme=`pwd`/ ; export rootme ; \
 	       rootsrc=`cd $(srcdir); pwd`/ ; export rootsrc ; \
 	       cd ./$$i; \
