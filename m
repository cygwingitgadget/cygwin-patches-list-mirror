Return-Path: <cygwin-patches-return-5849-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17320 invoked by alias); 10 May 2006 09:05:18 -0000
Received: (qmail 17307 invoked by uid 22791); 10 May 2006 09:05:17 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 10 May 2006 09:05:14 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.61) 	(envelope-from <brian@dessent.net>) 	id 1Fdkd6-0006bn-Mx 	for cygwin-patches@cygwin.com; Wed, 10 May 2006 09:05:12 +0000
Message-ID: <4461ACBB.DC6BA1BB@dessent.net>
Date: Wed, 10 May 2006 09:05:00 -0000
From: Brian Dessent <brian@dessent.net>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [patch] make clean
Content-Type: multipart/mixed;  boundary="------------9C1F551EEF62E010C9326C25"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00037.txt.bz2

This is a multi-part message in MIME format.
--------------9C1F551EEF62E010C9326C25
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 174


Doing a "make clean" inside winsup/cygwin leaves behind a stale
cygwin1.dbg file.

2006-05-10  Brian Dessent  <brian@dessent.net>

	* Makefile.in (clean): Also delete *.dbg.
--------------9C1F551EEF62E010C9326C25
Content-Type: text/plain; charset=us-ascii;
 name="dbg_clean.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dbg_clean.patch"
Content-length: 678

Index: Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/Makefile.in,v
retrieving revision 1.186
diff -u -p -u -p -r1.186 Makefile.in
--- Makefile.in	12 Apr 2006 15:53:22 -0000	1.186
+++ Makefile.in	10 May 2006 09:01:17 -0000
@@ -365,7 +365,7 @@ uninstall-man:
 	done
 
 clean:
-	-rm -f *.o *.dll *.a *.exp junk *.base version.cc regexp/*.o winver_stamp *.exe *.d *stamp* *_magic.h sigfe.s cygwin.def
+	-rm -f *.o *.dll *.dbg *.a *.exp junk *.base version.cc regexp/*.o winver_stamp *.exe *.d *stamp* *_magic.h sigfe.s cygwin.def
 	-@$(MAKE) -C $(bupdir)/cygserver libclean
 
 maintainer-clean realclean: clean

--------------9C1F551EEF62E010C9326C25--

