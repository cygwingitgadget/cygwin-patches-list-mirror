Return-Path: <cygwin-patches-return-7818-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7762 invoked by alias); 20 Feb 2013 21:16:07 -0000
Received: (qmail 7748 invoked by uid 22791); 20 Feb 2013 21:16:07 -0000
X-SWARE-Spam-Status: No, hits=-4.6 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,KHOP_RCVD_TRUST,KHOP_SPAMHAUS_DROP,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE,TW_SF,TW_TM
X-Spam-Check-By: sourceware.org
Received: from mail-ie0-f180.google.com (HELO mail-ie0-f180.google.com) (209.85.223.180)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 20 Feb 2013 21:16:02 +0000
Received: by mail-ie0-f180.google.com with SMTP id bn7so10335772ieb.39        for <cygwin-patches@cygwin.com>; Wed, 20 Feb 2013 13:16:01 -0800 (PST)
X-Received: by 10.50.208.68 with SMTP id mc4mr11158529igc.35.1361394961269;        Wed, 20 Feb 2013 13:16:01 -0800 (PST)
Received: from YAAKOV04 (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id ww6sm14659732igb.2.2013.02.20.13.15.59        (version=SSLv3 cipher=RC4-SHA bits=128/128);        Wed, 20 Feb 2013 13:16:00 -0800 (PST)
Date: Wed, 20 Feb 2013 21:16:00 -0000
From: Yaakov (Cygwin/X) <yselkowitz@users.sourceforge.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH 64bit] Export <io.h> symbols with underscore
Message-ID: <20130220151600.5983c15a@YAAKOV04>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/mc5DNGZI.1k4wOxWCYncHJp"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2013-q1/txt/msg00029.txt.bz2


--MP_/mc5DNGZI.1k4wOxWCYncHJp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Content-length: 355

I have already encountered issues with the lack of leading-underscored
exports for symbols declared in <io.h>, as usage thereof often occurs
in shared Cygwin/Win32 conditional code, and on Win32 these are
underscored.  Patch attached for the two symbols I have seen so far,
but I wonder if I should just get it over with and add _access as well.


Yaakov

--MP_/mc5DNGZI.1k4wOxWCYncHJp
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=cygwin-io_h-symbols.patch
Content-length: 820

2013-02-20  Yaakov Selkowitz  <yselkowitz@...>

	* cygwin64.din: Restore _get_osfhandle and _setmode.

Index: cygwin64.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/Attic/cygwin64.din,v
retrieving revision 1.1.2.7
diff -u -p -r1.1.2.7 cygwin64.din
--- cygwin64.din	15 Feb 2013 13:36:36 -0000	1.1.2.7
+++ cygwin64.din	20 Feb 2013 21:02:32 -0000
@@ -438,6 +438,7 @@ get_current_dir_name SIGFE
 get_nprocs SIGFE
 get_nprocs_conf SIGFE
 get_osfhandle SIGFE
+_get_osfhandle = get_osfhandle SIGFE
 get_phys_pages SIGFE
 getaddrinfo = cygwin_getaddrinfo SIGFE
 getc SIGFE
@@ -1015,6 +1016,7 @@ setlocale NOSIGFE
 setlogmask NOSIGFE
 setmntent SIGFE
 setmode = cygwin_setmode SIGFE
+_setmode = cygwin_setmode SIGFE
 setpassent NOSIGFE
 setpgid SIGFE
 setpgrp SIGFE

--MP_/mc5DNGZI.1k4wOxWCYncHJp--
