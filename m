Return-Path: <cygwin-patches-return-6574-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26157 invoked by alias); 17 Jul 2009 23:37:38 -0000
Received: (qmail 26146 invoked by uid 22791); 17 Jul 2009 23:37:37 -0000
X-SWARE-Spam-Status: No, hits=-1.5 required=5.0 	tests=AWL,BAYES_00,HK_OBFDOM,J_CHICKENPOX_64,SARE_URI_CONS7,SPF_PASS,URI_NOVOWEL
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f205.google.com (HELO mail-ew0-f205.google.com) (209.85.219.205)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 17 Jul 2009 23:37:31 +0000
Received: by ewy1 with SMTP id 1so1215016ewy.2         for <cygwin-patches@cygwin.com>; Fri, 17 Jul 2009 16:37:29 -0700 (PDT)
Received: by 10.210.60.8 with SMTP id i8mr2025221eba.41.1247873849038;         Fri, 17 Jul 2009 16:37:29 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 24sm4252121eyx.23.2009.07.17.16.37.28         (version=SSLv3 cipher=RC4-MD5);         Fri, 17 Jul 2009 16:37:28 -0700 (PDT)
Message-ID: <4A610E3A.7030602@gmail.com>
Date: Fri, 17 Jul 2009 23:37:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [committed] Remove stray space in asm name.
Content-Type: multipart/mixed;  boundary="------------010103060609030204090904"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q3/txt/msg00028.txt.bz2

This is a multi-part message in MIME format.
--------------010103060609030204090904
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 533


  I spotted this trivial (and, for reasons you can probably guess at,
harmless) typo shortly after committing the patch in the first place, and now
have found a spare moment to fix it.  So, committed as
not-just-obvious-but-blindingly-so:

winsup/cygwin/ChangeLog:

	* libstdcxx_wrapper.cc (operator delete):  Remove stray space in
	asm name.

  As an anti-Murphy precaution, I did make sure it all still compiled before I
checked it in.  (I'm just getting down to work on the fortran/atexit/dtors thing.)

    cheers,
      DaveK


--------------010103060609030204090904
Content-Type: text/x-c;
 name="wrapper-asm-name-typofix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="wrapper-asm-name-typofix.diff"
Content-length: 793

Index: winsup/cygwin/libstdcxx_wrapper.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/libstdcxx_wrapper.cc,v
retrieving revision 1.1
diff -p -u -r1.1 libstdcxx_wrapper.cc
--- winsup/cygwin/libstdcxx_wrapper.cc	7 Jul 2009 20:12:44 -0000	1.1
+++ winsup/cygwin/libstdcxx_wrapper.cc	17 Jul 2009 22:51:02 -0000
@@ -28,7 +28,7 @@ extern void *operator new(std::size_t sz
 extern void *operator new[](std::size_t sz) throw (std::bad_alloc)
 			__asm__ ("___wrap__Znaj");
 extern void operator delete(void *p) throw()
-			__asm__ ("___wrap__ZdlPv ");
+			__asm__ ("___wrap__ZdlPv");
 extern void operator delete[](void *p) throw()
 			__asm__ ("___wrap__ZdaPv");
 extern void *operator new(std::size_t sz, const std::nothrow_t &nt) throw()

--------------010103060609030204090904--
