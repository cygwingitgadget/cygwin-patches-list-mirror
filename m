Return-Path: <cygwin-patches-return-6262-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3761 invoked by alias); 9 Mar 2008 08:55:40 -0000
Received: (qmail 3750 invoked by uid 22791); 9 Mar 2008 08:55:40 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 09 Mar 2008 08:55:14 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1JYHJI-0003xR-0Z 	for cygwin-patches@cygwin.com; Sun, 09 Mar 2008 08:55:12 +0000
Message-ID: <47D3A5F1.4EF422A6@dessent.net>
Date: Sun, 09 Mar 2008 08:55:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [patch] utils/path.cc fixes and testsuite
References: <47D2E28C.3FC392D3@dessent.net> <20080308212718.GB5863@ednor.casa.cgf.cx> <47D3550B.76D34355@dessent.net> <20080309032437.GB6777@ednor.casa.cgf.cx> <20080309084452.GV18407@calimero.vinschen.de>
Content-Type: multipart/mixed;  boundary="------------C6F6C7AA344CF56AFFE4B1F0"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00036.txt.bz2

This is a multi-part message in MIME format.
--------------C6F6C7AA344CF56AFFE4B1F0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 122

Corinna Vinschen wrote:

> Doesn't that install testsuite.exe at `make install' time?

Ack, how about the attached?

Brian
--------------C6F6C7AA344CF56AFFE4B1F0
Content-Type: text/plain; charset=us-ascii;
 name="utils_noinstall_testsuite.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="utils_noinstall_testsuite.patch"
Content-length: 710

2008-03-09  Brian Dessent  <brian@dessent.net>

	* Makefile.in (install): Don't install the testsuite.

Index: Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/utils/Makefile.in,v
retrieving revision 1.70
diff -u -p -r1.70 Makefile.in
--- Makefile.in	9 Mar 2008 04:10:10 -0000	1.70
+++ Makefile.in	9 Mar 2008 08:52:06 -0000
@@ -157,7 +157,7 @@ realclean: clean
 
 install: all
 	$(SHELL) $(updir1)/mkinstalldirs $(bindir)
-	for i in $(CYGWIN_BINS) $(MINGW_BINS) ; do \
+	for i in $(CYGWIN_BINS) ${filter-out testsuite.exe,$(MINGW_BINS)} ; do \
 	  n=`echo $$i | sed '$(program_transform_name)'`; \
 	  $(INSTALL_PROGRAM) $$i $(bindir)/$$n; \
 	done

--------------C6F6C7AA344CF56AFFE4B1F0--
