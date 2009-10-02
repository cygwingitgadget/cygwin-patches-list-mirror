Return-Path: <cygwin-patches-return-6669-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8426 invoked by alias); 2 Oct 2009 20:56:47 -0000
Received: (qmail 8415 invoked by uid 22791); 2 Oct 2009 20:56:47 -0000
X-SWARE-Spam-Status: No, hits=-2.2 required=5.0 	tests=AWL,BAYES_00,HK_OBFDOM,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f218.google.com (HELO mail-ew0-f218.google.com) (209.85.219.218)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 02 Oct 2009 20:56:43 +0000
Received: by ewy18 with SMTP id 18so1584764ewy.43         for <cygwin-patches@cygwin.com>; Fri, 02 Oct 2009 13:56:40 -0700 (PDT)
Received: by 10.210.6.21 with SMTP id 21mr26193ebf.58.1254517000467;         Fri, 02 Oct 2009 13:56:40 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 7sm413295eyb.13.2009.10.02.13.56.39         (version=SSLv3 cipher=RC4-MD5);         Fri, 02 Oct 2009 13:56:39 -0700 (PDT)
Message-ID: <4AC66C72.7070102@gmail.com>
Date: Fri, 02 Oct 2009 20:56:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [patch] Update build flags for new compiler feature
Content-Type: multipart/mixed;  boundary="------------040509080601000807090102"
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
X-SW-Source: 2009-q4/txt/msg00000.txt.bz2

This is a multi-part message in MIME format.
--------------040509080601000807090102
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 826


  So, nobody did ask for a compiler version check(*), so here's the patch plus
changelog, and I'd like to get separate OKs from both cgf and cv to say that
you've each either updated your cross-build environments or don't mind
patching the flag back out locally until you can.

winsup/cygwin/ChangeLog:

	* Makefile.in (CFLAGS): Add -mno-use-libstdc-wrappers

  (In case anyone was wondering, I think CFLAGS, rather than CXXFLAGS, is the
right place to add it; it applies to cross-language mixed linking situations
as much as it does to C++ alone).

    cheers,
      DaveK
-- 
(*) - I'm perfectly happy with the notion that if you want to run with the
bleeding edge y'gotta keep your prerequisites up-to-date too, and cygwin is
after all a self-hosted environment, and the distro compiler certainly
supports this feature :)

--------------040509080601000807090102
Content-Type: text/x-c;
 name="no-wrap-dll.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="no-wrap-dll.diff"
Content-length: 682

Index: winsup/cygwin/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/Makefile.in,v
retrieving revision 1.229
diff -p -u -r1.229 Makefile.in
--- winsup/cygwin/Makefile.in	12 Jul 2009 21:15:46 -0000	1.229
+++ winsup/cygwin/Makefile.in	2 Oct 2009 15:31:32 -0000
@@ -55,7 +55,8 @@ CC:=@CC@
 # FIXME: Which is it, CC or CC_FOR_TARGET?
 CC_FOR_TARGET:=$(CC)
 CFLAGS=@CFLAGS@
-override CFLAGS+=-MMD ${$(*F)_CFLAGS} -Werror -fmerge-constants -ftracer $(CCEXTRA)
+override CFLAGS+=-MMD ${$(*F)_CFLAGS} -Werror -fmerge-constants -ftracer \
+  -mno-use-libstdc-wrappers $(CCEXTRA)
 CXX=@CXX@
 override CXXFLAGS=@CXXFLAGS@
 

--------------040509080601000807090102--
