Return-Path: <cygwin-patches-return-6511-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3787 invoked by alias); 13 Apr 2009 19:20:52 -0000
Received: (qmail 3776 invoked by uid 22791); 13 Apr 2009 19:20:51 -0000
X-SWARE-Spam-Status: No, hits=-2.2 required=5.0 	tests=AWL,BAYES_00,HK_OBFDOM,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-fx0-f176.google.com (HELO mail-fx0-f176.google.com) (209.85.220.176)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 13 Apr 2009 19:20:46 +0000
Received: by fxm24 with SMTP id 24so2327720fxm.2         for <cygwin-patches@cygwin.com>; Mon, 13 Apr 2009 12:20:42 -0700 (PDT)
Received: by 10.103.24.11 with SMTP id b11mr3512210muj.76.1239650442855;         Mon, 13 Apr 2009 12:20:42 -0700 (PDT)
Received: from ?82.6.108.62? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id s10sm10856031muh.22.2009.04.13.12.20.41         (version=SSLv3 cipher=RC4-MD5);         Mon, 13 Apr 2009 12:20:42 -0700 (PDT)
Message-ID: <49E39301.8050903@gmail.com>
Date: Mon, 13 Apr 2009 19:20:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add libz to dumper.exe link  [was Re: Re: speclib vs.  	-lc  trouble.]
References: <49E3641E.6040407@gmail.com> <20090413165923.GA13222@ednor.casa.cgf.cx> <49E3778C.2020706@gmail.com> <20090413190428.GA32672@ednor.casa.cgf.cx>
In-Reply-To: <20090413190428.GA32672@ednor.casa.cgf.cx>
Content-Type: multipart/mixed;  boundary="------------010404020302040406000806"
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
X-SW-Source: 2009-q2/txt/msg00053.txt.bz2

This is a multi-part message in MIME format.
--------------010404020302040406000806
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 1112

Christopher Faylor wrote:
> On Mon, Apr 13, 2009 at 06:34:04PM +0100, Dave Korn wrote:
>> Christopher Faylor wrote:
>>> I think you can get by with just adding -lz to the ALL_LDFLAGS line and
>>> removing the other stuff.  The tests for libintl and libbfd are
>>> supposed to just detect if the appropriate directories are available.
>>> There isn't likely going to be a libz two levels above cygwin's source
>>> directory so I don't see any reason to specfically check for it.
>> I thought that might happen in a combined tree build with /src and /gcc
>> together?
> 
> That wasn't the intent of the current checks in the makefile.  They were
> just to detect newer versions of libbfd.a or libintl.a.  Even libintl.a
> isn't really necessary IMO.  It's not likely that is going to be under
> active development and different from what should be installed in /lib.

  Ah, OK, so just like this then:

winsup/utils/ChangeLog

	* Makefile.in (dumper.exe):  Add -lz to ALL_LDFLAGS.

  Tested by making clean then all in an existing
$objdir/i686-pc-cygwin/winsup/utils build directory.  Ok?

    cheers,
      DaveK

--------------010404020302040406000806
Content-Type: text/x-patch;
 name="dumper-lz-take2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dumper-lz-take2.patch"
Content-length: 741

Index: winsup/utils/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/utils/Makefile.in,v
retrieving revision 1.82
diff -p -u -r1.82 Makefile.in
--- winsup/utils/Makefile.in	18 Mar 2009 04:19:05 -0000	1.82
+++ winsup/utils/Makefile.in	13 Apr 2009 19:17:16 -0000
@@ -88,7 +88,7 @@ CYGWIN_BINS += dumper.exe
 dumper.o module_info.o parse_pe.o: CXXFLAGS += -I$(bupdir2)/bfd -I$(updir1)/include
 dumper.o parse_pe.o: dumper.h
 dumper.exe: module_info.o parse_pe.o
-dumper.exe: ALL_LDFLAGS += ${libbfd} ${libintl} -L$(bupdir1)/libiberty $(LIBICONV) -liberty
+dumper.exe: ALL_LDFLAGS += ${libbfd} ${libintl} -L$(bupdir1)/libiberty $(LIBICONV) -liberty -lz
 else
 all: warn_dumper
 endif

--------------010404020302040406000806--
