Return-Path: <cygwin-patches-return-4024-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31240 invoked by alias); 23 Jul 2003 17:01:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31213 invoked from network); 23 Jul 2003 17:01:16 -0000
X-Authentication-Warning: localhost.localdomain: ronald set sender to blytkerchan@users.sourceforge.net using -f
Date: Wed, 23 Jul 2003 17:01:00 -0000
From: Ronald Landheer-Cieslak <blytkerchan@users.sourceforge.net>
To: cygwin-patches@cygwin.com
Subject: patch for winsup/cygwin/Makefile.in
Message-ID: <20030723171718.GA2875@linux_rln.harvest>
Mail-Followup-To: cygwin-patches@cygwin.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Disclaimer: I had nothing to do with it - I swear!
X-loop: linux_rln.harvest
X-SW-Source: 2003-q3/txt/msg00040.txt.bz2


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 685

The attached patch fixes a (micro) problem that has been bugging me for a while
now: the various header files could not be installed with a `make install` 
without creating the proper directories first.

patch is against current CVS

HTH

rlc

NB: I've re-sent this because I don't think it arrived: I just switched to 
    mutt as a MUA (from Pine) and I didn't quite get the .muttrc file right
    the first time - sorry if you're getting this twice

Changelog is:
2003-07-23	Ronald Landheer-Cieslak <blytkerchan@users.sourceforge.net>
	* winsup/cygwin/Makefile.in <install-headers>: run mkinstalldirs before install for each directory
	<install-man>: ditto for each manpage dir
--


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="Makefile.in.diff"
Content-length: 1428

2003-07-23	Ronald Landheer-Cieslak <blytkerchan@users.sourceforge.net>
	* winsup/cygwin/Makefile.in <install-headers>: run mkinstalldirs before install for each directory
	<install-man>: ditto for each manpage dir

diff -u -r1.127 Makefile.in
--- winsup/cygwin/Makefile.in	7 Jul 2003 05:30:33 -0000	1.127
+++ winsup/cygwin/Makefile.in	23 Jul 2003 13:54:52 -0000
@@ -269,6 +269,7 @@
 	cd $(srcdir); \
 	for sub in `find include -name '[a-z]*' -type d -print | sort`; do \
 	    for i in $$sub/*.h ; do \
+	      $(SHELL) $(srcdir)/mkinstalldirs $(tooldir)/$$sub ; \
 	      $(INSTALL_DATA) $$i $(tooldir)/$$sub/`basename $$i` ; \
 	    done ; \
 	done ; \
@@ -277,15 +278,19 @@
 install-man:
 	cd $(srcdir); \
+	$(SHELL) $(srcdir)/mkinstalldirs $(tooldir)/man/man2 ; \
 	for i in `find . -type f -name '*.2'`; do \
 	    $(INSTALL_DATA) $$i $(tooldir)/man/man2/`basename $$i` ; \
 	done; \
+	$(SHELL) $(srcdir)/mkinstalldirs $(tooldir)/man/man3 ; \
 	for i in `find . -type f -name '*.3'`; do \
 	    $(INSTALL_DATA) $$i $(tooldir)/man/man3/`basename $$i` ; \
 	done; \
+	$(SHELL) $(srcdir)/mkinstalldirs $(tooldir)/man/man5 ; \
 	for i in `find . -type f -name '*.5'`; do \
 	    $(INSTALL_DATA) $$i $(tooldir)/man/man5/`basename $$i` ; \
 	done; \
+	$(SHELL) $(srcdir)/mkinstalldirs $(tooldir)/man/man7 ; \
 	for i in `find . -type f -name '*.7'`; do \
 	    $(INSTALL_DATA) $$i $(tooldir)/man/man7/`basename $$i` ; \
 	done
 

--ew6BAiZeqk4r7MaW--
