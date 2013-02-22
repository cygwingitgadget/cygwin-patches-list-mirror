Return-Path: <cygwin-patches-return-7832-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13605 invoked by alias); 22 Feb 2013 09:40:55 -0000
Received: (qmail 13593 invoked by uid 22791); 22 Feb 2013 09:40:53 -0000
X-SWARE-Spam-Status: No, hits=-5.3 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,KHOP_RCVD_TRUST,KHOP_SPAMHAUS_DROP,KHOP_THREADED,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE,TW_SF,TW_TM,TW_VP
X-Spam-Check-By: sourceware.org
Received: from mail-ie0-f173.google.com (HELO mail-ie0-f173.google.com) (209.85.223.173)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 22 Feb 2013 09:40:48 +0000
Received: by mail-ie0-f173.google.com with SMTP id 9so470791iec.32        for <cygwin-patches@cygwin.com>; Fri, 22 Feb 2013 01:40:48 -0800 (PST)
X-Received: by 10.50.88.226 with SMTP id bj2mr562833igb.105.1361526048229;        Fri, 22 Feb 2013 01:40:48 -0800 (PST)
Received: from YAAKOV04 (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id ip8sm1517215igc.4.2013.02.22.01.40.46        (version=SSLv3 cipher=RC4-SHA bits=128/128);        Fri, 22 Feb 2013 01:40:47 -0800 (PST)
Date: Fri, 22 Feb 2013 09:40:00 -0000
From: Yaakov (Cygwin/X) <yselkowitz@users.sourceforge.net>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 64bit] Export <io.h> symbols with underscore
Message-ID: <20130222034047.778e1e12@YAAKOV04>
In-Reply-To: <20130222084951.GJ28458@calimero.vinschen.de>
References: <20130220151600.5983c15a@YAAKOV04>	<20130221011432.GA2786@ednor.casa.cgf.cx>	<20130221111545.GA24054@calimero.vinschen.de>	<20130221194236.GA1163@ednor.casa.cgf.cx>	<20130222001848.7049805a@YAAKOV04>	<20130222065110.GA7834@ednor.casa.cgf.cx>	<20130222080025.GI28458@calimero.vinschen.de>	<20130222084951.GJ28458@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/aTyCaPN=jZ1jQMO7l_xK74l"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2013-q1/txt/msg00043.txt.bz2


--MP_/aTyCaPN=jZ1jQMO7l_xK74l
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Content-length: 839

On Fri, 22 Feb 2013 09:49:51 +0100, Corinna Vinschen wrote:
> > access should go, no doubt about it.
> > 
> > For get_osfhandle and setmode I would prefer maintaining backward
> > compatibility with existing applications.  Both variations, with and
> > without underscore are definitely in use.
> > 
> > What about exporting the underscored variants only, but define the
> > non-underscored ones:
> > 
> >   extern long _get_osfhandle(int);
> >   #define get_osfhandle(i) _get_osfhandle(i)
> > 
> >   extern int _setmode (int __fd, int __mode);
> >   #define setmode(f,m) _setmode((f),(m))
> 
> Just to be clear:  On 32 bit we should keep the exported symbols, too.
> On 64 bit we can drop the non-underscored ones (which just requires
> to rebuild gawk for me) and only keep the defines for backward
> compatibility.

Like this?


Yaakov

--MP_/aTyCaPN=jZ1jQMO7l_xK74l
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=cygwin-io_h-symbols.patch
Content-length: 2255

2013-02-22  Yaakov Selkowitz <yselkowitz@...>
	    Corinna Vinschen <corinna@...>

	* cygwin64.din (_get_osfhandle): Rename from get_osfhandle.
	(_setmode): Rename from setmode.
	* include/io.h: Ditto. Define unprefixed names with preprocessor
	macros for backwards source compatibility.
	(access): Remove.
	* syscalls.cc (get_osfhandle): Undefine compatibility macro.

Index: cygwin64.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/Attic/cygwin64.din,v
retrieving revision 1.1.2.7
diff -u -p -r1.1.2.7 cygwin64.din
--- cygwin64.din	15 Feb 2013 13:36:36 -0000	1.1.2.7
+++ cygwin64.din	22 Feb 2013 09:26:46 -0000
@@ -437,7 +437,7 @@ get_avphys_pages SIGFE
 get_current_dir_name SIGFE
 get_nprocs SIGFE
 get_nprocs_conf SIGFE
-get_osfhandle SIGFE
+_get_osfhandle = get_osfhandle SIGFE
 get_phys_pages SIGFE
 getaddrinfo = cygwin_getaddrinfo SIGFE
 getc SIGFE
@@ -1014,7 +1014,7 @@ setlinebuf SIGFE
 setlocale NOSIGFE
 setlogmask NOSIGFE
 setmntent SIGFE
-setmode = cygwin_setmode SIGFE
+_setmode = cygwin_setmode SIGFE
 setpassent NOSIGFE
 setpgid SIGFE
 setpgrp SIGFE
Index: syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.638.2.10
diff -u -p -r1.638.2.10 syscalls.cc
--- syscalls.cc	9 Feb 2013 20:38:03 -0000	1.638.2.10
+++ syscalls.cc	22 Feb 2013 09:26:46 -0000
@@ -2891,6 +2891,8 @@ truncate (const char *pathname, _off_t l
 }
 #endif
 
+#undef get_osfhandle
+
 extern "C" long
 get_osfhandle (int fd)
 {
Index: include/io.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/io.h,v
retrieving revision 1.3
diff -u -p -r1.3 io.h
--- include/io.h	17 Sep 2001 21:29:19 -0000	1.3
+++ include/io.h	22 Feb 2013 09:26:46 -0000
@@ -18,9 +18,10 @@ extern "C" {
 /*
  * Function to return a Win32 HANDLE from a fd.
  */
-extern long get_osfhandle(int);
-extern int setmode (int __fd, int __mode);
-int access(const char *__path, int __amode);
+extern long _get_osfhandle(int);
+#define get_osfhandle(i) _get_osfhandle(i);
+extern int _setmode (int __fd, int __mode);
+#define setmode(f,m) _setmode((f),(m))
 
 #ifdef __cplusplus
 };

--MP_/aTyCaPN=jZ1jQMO7l_xK74l--
