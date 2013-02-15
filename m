Return-Path: <cygwin-patches-return-7796-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29507 invoked by alias); 15 Feb 2013 02:10:09 -0000
Received: (qmail 29484 invoked by uid 22791); 15 Feb 2013 02:10:06 -0000
X-SWARE-Spam-Status: No, hits=-4.6 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,KHOP_RCVD_TRUST,KHOP_SPAMHAUS_DROP,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mail-ie0-f179.google.com (HELO mail-ie0-f179.google.com) (209.85.223.179)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 15 Feb 2013 02:09:59 +0000
Received: by mail-ie0-f179.google.com with SMTP id k11so4134076iea.38        for <cygwin-patches@cygwin.com>; Thu, 14 Feb 2013 18:09:58 -0800 (PST)
X-Received: by 10.50.33.203 with SMTP id t11mr560698igi.97.1360894198399;        Thu, 14 Feb 2013 18:09:58 -0800 (PST)
Received: from YAAKOV04 (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id fa6sm2301845igb.2.2013.02.14.18.09.56        (version=SSLv3 cipher=RC4-SHA bits=128/128);        Thu, 14 Feb 2013 18:09:57 -0800 (PST)
Date: Fri, 15 Feb 2013 02:10:00 -0000
From: Yaakov (Cygwin/X) <yselkowitz@users.sourceforge.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH 64bit] lsaauth: skip 32bit DLL on 64bit target
Message-ID: <20130214200956.35632ae0@YAAKOV04>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/QcyfU5RTgsfE4eTeoHfEnub"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2013-q1/txt/msg00007.txt.bz2


--MP_/QcyfU5RTgsfE4eTeoHfEnub
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Content-length: 0


--MP_/QcyfU5RTgsfE4eTeoHfEnub
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=lsaauth-64bit.patch
Content-length: 1020

2013-02-14  Yaakov Selkowitz  <yselkowitz@...>

	* Makefile.in: Do not build or install 32bit DLL for 64bit target.

Index: Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/lsaauth/Makefile.in,v
retrieving revision 1.6.2.2
diff -u -p -r1.6.2.2 Makefile.in
--- Makefile.in	23 Nov 2012 15:14:39 -0000	1.6.2.2
+++ Makefile.in	15 Feb 2013 01:15:48 -0000
@@ -46,9 +46,11 @@ WIN32_LDFLAGS	:= $(CFLAGS) -nostdlib -Wl
 # not recognized by LSA.
 LIBS		:= -ladvapi32 -lkernel32 -lntdll
 
+ifneq ($(target_alias),x86_64-pc-cygwin)
 DLL32	:=	cyglsa.dll
 DEF32	:=	cyglsa.def
 OBJ32	:=	cyglsa.o
+endif
 
 DLL64	:=	cyglsa64.dll
 DEF64	:=	cyglsa64.def
@@ -84,6 +86,8 @@ clean:
 
 install: all
 	/bin/mkdir -p $(DESTDIR)$(bindir)
+ifneq ($(target_alias),x86_64-pc-cygwin)
 	$(INSTALL_PROGRAM) $(DLL32) $(DESTDIR)$(bindir)/$(DLL32)
+endif
 	$(INSTALL_PROGRAM) $(DLL64) $(DESTDIR)$(bindir)/$(DLL64)
 	$(INSTALL_PROGRAM) $(srcdir)/cyglsa-config $(DESTDIR)$(bindir)/cyglsa-config

--MP_/QcyfU5RTgsfE4eTeoHfEnub--
