Return-Path: <cygwin-patches-return-6507-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29603 invoked by alias); 13 Apr 2009 16:00:51 -0000
Received: (qmail 29586 invoked by uid 22791); 13 Apr 2009 16:00:47 -0000
X-SWARE-Spam-Status: No, hits=-2.2 required=5.0 	tests=AWL,BAYES_00,HK_OBFDOM,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-bw0-f226.google.com (HELO mail-bw0-f226.google.com) (209.85.218.226)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 13 Apr 2009 16:00:43 +0000
Received: by bwz26 with SMTP id 26so2269800bwz.2         for <cygwin-patches@cygwin.com>; Mon, 13 Apr 2009 09:00:39 -0700 (PDT)
Received: by 10.103.244.4 with SMTP id w4mr3399185mur.90.1239638439531;         Mon, 13 Apr 2009 09:00:39 -0700 (PDT)
Received: from ?82.6.108.62? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 7sm10304022mup.19.2009.04.13.09.00.38         (version=SSLv3 cipher=RC4-MD5);         Mon, 13 Apr 2009 09:00:38 -0700 (PDT)
Message-ID: <49E3641E.6040407@gmail.com>
Date: Mon, 13 Apr 2009 16:00:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Add libz to dumper.exe link  [was Re: Re: speclib vs. -lc  trouble.]
Content-Type: multipart/mixed;  boundary="------------020803040400020503030000"
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
X-SW-Source: 2009-q2/txt/msg00049.txt.bz2

This is a multi-part message in MIME format.
--------------020803040400020503030000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 843

[  Why don't I resend this to the proper list, eh?  ]

Dave Korn wrote:

> One slight catch: recent libbfds have grown a dependency on zlib, as they
> can natively handle compressed files.  This broke the build for dumper.exe,
> which uses libbfd.  The attached patch adds libz unconditionally, as it
> won't do any harm with older libbfds that don't need it, and because it's a
> bog-standard package that's easily available everywhere, so I didn't see
> the need to go to great lengths to only require it if the installed libbfd
> is sufficiently new to actually need it.  Anyone building winsup from
> source would probably have zlib-devel installed already anyway.

  Ok?

winsup/utils/ChangeLog

	* Makefile.in (libz):  New makefile variable.
	(build_dumper):  Test it was correctly set.
	(dumper.exe):  Use it.

    cheers,
      DaveK


--------------020803040400020503030000
Content-Type: text/x-patch;
 name="dumper-lz.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dumper-lz.patch"
Content-length: 1410

? winsup/cygwin/include/stdint-h.diff
Index: winsup/utils/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/utils/Makefile.in,v
retrieving revision 1.82
diff -p -u -r1.82 Makefile.in
--- winsup/utils/Makefile.in	18 Mar 2009 04:19:05 -0000	1.82
+++ winsup/utils/Makefile.in	13 Apr 2009 15:07:21 -0000
@@ -81,14 +81,16 @@ ldh.exe: MINGW_LDFLAGS := -nostdlib -lke
 # Check for dumper's requirements and enable it if found.
 LIBICONV := @libiconv@
 libbfd   := ${shell $(CC) -B$(bupdir2)/bfd/ --print-file-name=libbfd.a}
+# Recent libbfd requires libz as it handles compressed files.
+libz     := ${shell $(CC) -B$(bupdir2)/zlib/ --print-file-name=libz.a}
 libintl  := ${shell $(CC) -B$(bupdir2)/intl/ --print-file-name=libintl.a}
-build_dumper := ${shell test -r $(libbfd) -a -r $(libintl) -a -n "$(LIBICONV)" && echo 1}
+build_dumper := ${shell test -r $(libbfd) -a -r $(libz) -a -r $(libintl) -a -n "$(LIBICONV)" && echo 1}
 ifdef build_dumper
 CYGWIN_BINS += dumper.exe
 dumper.o module_info.o parse_pe.o: CXXFLAGS += -I$(bupdir2)/bfd -I$(updir1)/include
 dumper.o parse_pe.o: dumper.h
 dumper.exe: module_info.o parse_pe.o
-dumper.exe: ALL_LDFLAGS += ${libbfd} ${libintl} -L$(bupdir1)/libiberty $(LIBICONV) -liberty
+dumper.exe: ALL_LDFLAGS += ${libbfd} ${libintl} ${libz} -L$(bupdir1)/libiberty $(LIBICONV) -liberty
 else
 all: warn_dumper
 endif


--------------020803040400020503030000--
