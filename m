Return-Path: <cygwin-patches-return-2016-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17563 invoked by alias); 2 Apr 2002 02:28:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17547 invoked from network); 2 Apr 2002 02:28:04 -0000
Message-ID: <20020402022804.15975.qmail@web14503.mail.yahoo.com>
Date: Mon, 01 Apr 2002 18:28:00 -0000
From: =?iso-8859-1?q?Danny=20Smith?= <danny_r_smith_2001@yahoo.co.nz>
Subject: FWD: mingw-runtime: problem with -mno-cygwin and profiling (libgmon.a) 
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SW-Source: 2002-q2/txt/msg00000.txt.bz2

From: "Henrik Stokseth" <hstokset at tiscali dot no> 


> as a quick solution i have copied the file libgmon.a from the lib/ 
directory
> in the official mingw32 distribution and pasted it into /lib/mingw/ in my
> cygwin installation and it seemed to work. i'm not sure if the problem is
> the /lib/libgmon.a is dependant on parts of the cygwin runtime, but if
> that's the case whoever is the maintainer (christopher faylor i guess?)
of
> the mingw-runtime package should include the mingw gmon library here.


This patch should fix.  Can anyone see any problems with this?  
It also puts gcrt1.o and gcrt2.o in the mingw/lib. With current cygwin
specs, they are not used.  

(gcrt1.o and gcrt2.o are actually identical, and probably also
interchangeable with cygwins gcrt0.o) 

winsup/mingw/ChangeLog

2002-04-02  Danny Smith  <dannysmith@users.sourceforge.net>

	* profile/makefile.in (install): Install to inst_libdir and
	inst_includedir, not tooldir.


--- mingw/profile/makefile.in.ori	Tue Jun 12 06:57:39 2001
+++ mingw/profile/makefile.in	Tue Apr  2 13:35:52 2002
@@ -95,17 +95,17 @@ info-html:
 install-info: info
 
 install: all
-	$(mkinstalldirs) $(tooldir)/lib 
+	$(mkinstalldirs) $(inst_libdir)
 	for i in $(LIBS); do \
-		$(INSTALL_DATA) $$i $(tooldir)/lib/$$i ; \
+		$(INSTALL_DATA) $$i $(inst_libdir)/$$i ; \
 	done
 	for i in $(CRT0S); do \
-		$(INSTALL_DATA) $$i $(tooldir)/lib/$$i ; \
+		$(INSTALL_DATA) $$i $(inst_libdir)/$$i ; \
 	done
 	for sub in . ; do \
-	$(mkinstalldirs) $(tooldir)/include/$$sub ; \
+	$(mkinstalldirs) $(inst_includedir)/$$sub ; \
 		for i in $(srcdir)/$$sub/*.h ; do \
-		  $(INSTALL_DATA) $$i $(tooldir)/include/$$sub/`basename $$i` ; \
+		  $(INSTALL_DATA) $$i $(inst_includedir)/$$sub/`basename $$i` ; \
 		done ; \
 	done
  



http://www.sold.com.au - SOLD.com.au Auctions
- 1,000s of Bargains!
