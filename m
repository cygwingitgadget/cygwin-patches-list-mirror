Return-Path: <cygwin-patches-return-3251-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14603 invoked by alias); 1 Dec 2002 22:10:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14594 invoked from network); 1 Dec 2002 22:10:22 -0000
Date: Sun, 01 Dec 2002 14:10:00 -0000
From: Alexander Gottwald <Alexander.Gottwald@s1999.tu-chemnitz.de>
To: cygwin-patches@cygwin.com
Subject: Xfixes required libs
Message-ID: <Pine.LNX.4.44.0212012309140.3663-100000@lupus.ago.vpn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Spam-Score: -1.0 (-)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18IcI9-0003sZ-00*QxQoVKeqZJo*
X-SW-Source: 2002-q4/txt/msg00202.txt.bz2

The patch adds the SharedXfixesReqs for cygwin

Index: cygwin.tmpl
===================================================================
RCS file: /cvs/xc/config/cf/cygwin.tmpl,v
retrieving revision 3.12
diff -u -3 -r3.12 cygwin.tmpl
--- cygwin.tmpl	2002/10/17 08:18:18	3.12
+++ cygwin.tmpl	2002/12/01 22:08:53
@@ -35,6 +35,7 @@
 #define SharedXmuuReqs $(LDPRELIB) $(XTOOLLIB) $(XLIB)
 #define SharedXrandrReqs $(LDPRELIB) $(XRENDERLIB) $(XLIB)
 #define SharedXcursorReqs $(LDPRELIB) $(XRENDERLIB) $(XLIB) 
+#define SharedXfixesReqs $(LDPRELIB) $(XLIB) 
 
 
 #ifndef FixupLibReferences

NP: JBO - Ällabätsch
-- 
 Alexander.Gottwald@informatik.tu-chemnitz.de 
 http://www.gotti.org           ICQ: 126018723
