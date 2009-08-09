Return-Path: <cygwin-patches-return-6586-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22785 invoked by alias); 9 Aug 2009 19:29:09 -0000
Received: (qmail 22773 invoked by uid 22791); 9 Aug 2009 19:29:08 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f217.google.com (HELO mail-ew0-f217.google.com) (209.85.219.217)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 09 Aug 2009 19:28:58 +0000
Received: by ewy17 with SMTP id 17so2689901ewy.2         for <cygwin-patches@cygwin.com>; Sun, 09 Aug 2009 12:28:56 -0700 (PDT)
Received: by 10.210.110.2 with SMTP id i2mr2137853ebc.31.1249846136021;         Sun, 09 Aug 2009 12:28:56 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 5sm9113782eyf.48.2009.08.09.12.28.54         (version=SSLv3 cipher=RC4-MD5);         Sun, 09 Aug 2009 12:28:55 -0700 (PDT)
Message-ID: <4A7F269B.6070009@gmail.com>
Date: Sun, 09 Aug 2009 19:29:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Find MinGW in more places
Content-Type: multipart/mixed;  boundary="------------000204090404030008000902"
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
X-SW-Source: 2009-q3/txt/msg00040.txt.bz2

This is a multi-part message in MIME format.
--------------000204090404030008000902
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 873


     Hi gang,

  I often run into this problem when I'm using a compiler that I've installed in
a non-standard $prefix: the utils/mingw script expects to find the MinGW sysroot
in the same place the compiler's --print-prog-name= option finds ld.exe, which
won't be the case if you've got a binutils in your non-standard $prefix as well.

  The attached patch simply falls back to looking in the same set of directories
relative to the root directory, which will locate anything installed with prefix
/ or /usr.  It would also work if it only looked in /usr, but I decided to
mirror the existing behaviour only in a different prefix just for consistency; I
could always simplify it if wanted.

winsup/utils/ChangeLog:

	* mingw: Add fallbacks to search for MinGW components in standard
	install locations if not found in compiler's $prefix.

  Ok?

    cheers,
      DaveK

--------------000204090404030008000902
Content-Type: text/x-c;
 name="find-mingw-more.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="find-mingw-more.diff"
Content-length: 694

Index: winsup/utils/mingw
===================================================================
RCS file: /cvs/src/src/winsup/utils/mingw,v
retrieving revision 1.5
diff -p -u -r1.5 mingw
--- winsup/utils/mingw	13 Oct 2008 00:56:09 -0000	1.5
+++ winsup/utils/mingw	9 Aug 2009 19:20:03 -0000
@@ -14,7 +14,8 @@ dir=$(cd $(dirname $("$compiler" -print-
 #
 [ "$dir" = '/' ] && dir=''
 mingw_dir=''
-for d in "$dir"/*-mingw32 "$dir"/usr/*-mingw32 "$dir"/*-mingw* "$dir"/usr/*-mingw*; do
+for d in "$dir"/*-mingw32 "$dir"/usr/*-mingw32 "$dir"/*-mingw* "$dir"/usr/*-mingw* \
+         /*-mingw32 /usr/*-mingw32 /*-mingw* /usr/*-mingw*; do
     case "$d" in
 	*\**)	continue ;;
 	*)	mingw_dir=$d; break;

--------------000204090404030008000902--
