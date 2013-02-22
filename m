Return-Path: <cygwin-patches-return-7833-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16691 invoked by alias); 22 Feb 2013 09:51:57 -0000
Received: (qmail 16655 invoked by uid 22791); 22 Feb 2013 09:51:36 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 22 Feb 2013 09:51:31 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 06BB252030D; Fri, 22 Feb 2013 10:51:29 +0100 (CET)
Date: Fri, 22 Feb 2013 09:51:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 64bit] Export <io.h> symbols with underscore
Message-ID: <20130222095128.GF21700@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20130220151600.5983c15a@YAAKOV04> <20130221011432.GA2786@ednor.casa.cgf.cx> <20130221111545.GA24054@calimero.vinschen.de> <20130221194236.GA1163@ednor.casa.cgf.cx> <20130222001848.7049805a@YAAKOV04> <20130222065110.GA7834@ednor.casa.cgf.cx> <20130222080025.GI28458@calimero.vinschen.de> <20130222084951.GJ28458@calimero.vinschen.de> <20130222034047.778e1e12@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20130222034047.778e1e12@YAAKOV04>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2013-q1/txt/msg00044.txt.bz2

On Feb 22 03:40, Yaakov wrote:
> On Fri, 22 Feb 2013 09:49:51 +0100, Corinna Vinschen wrote:
> > > access should go, no doubt about it.
> > > 
> > > For get_osfhandle and setmode I would prefer maintaining backward
> > > compatibility with existing applications.  Both variations, with and
> > > without underscore are definitely in use.
> > > 
> > > What about exporting the underscored variants only, but define the
> > > non-underscored ones:
> > > 
> > >   extern long _get_osfhandle(int);
> > >   #define get_osfhandle(i) _get_osfhandle(i)
> > > 
> > >   extern int _setmode (int __fd, int __mode);
> > >   #define setmode(f,m) _setmode((f),(m))
> > 
> > Just to be clear:  On 32 bit we should keep the exported symbols, too.
> > On 64 bit we can drop the non-underscored ones (which just requires
> > to rebuild gawk for me) and only keep the defines for backward
> > compatibility.
> 
> Like this?

Almost.  The _setmode needs a tweak, too.  I also think it makes
sense to rename the functions inside of syscalls.cc:

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.256.2.1
diff -u -p -r1.256.2.1 cygwin.din
--- cygwin.din	22 Nov 2012 11:05:50 -0000	1.256.2.1
+++ cygwin.din	22 Feb 2013 09:49:26 -0000
@@ -678,8 +678,8 @@ get_avphys_pages SIGFE
 get_current_dir_name SIGFE
 get_nprocs SIGFE
 get_nprocs_conf SIGFE
-get_osfhandle SIGFE
-_get_osfhandle = get_osfhandle SIGFE
+_get_osfhandle SIGFE
+get_osfhandle = _get_osfhandle SIGFE
 get_phys_pages SIGFE
 getaddrinfo = cygwin_getaddrinfo SIGFE
 getc SIGFE
Index: cygwin64.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/Attic/cygwin64.din,v
retrieving revision 1.1.2.7
diff -u -p -r1.1.2.7 cygwin64.din
--- cygwin64.din	15 Feb 2013 13:36:36 -0000	1.1.2.7
+++ cygwin64.din	22 Feb 2013 09:49:26 -0000
@@ -437,7 +437,7 @@ get_avphys_pages SIGFE
 get_current_dir_name SIGFE
 get_nprocs SIGFE
 get_nprocs_conf SIGFE
-get_osfhandle SIGFE
+_get_osfhandle SIGFE
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
+++ syscalls.cc	22 Feb 2013 09:49:29 -0000
@@ -2754,7 +2754,7 @@ getmode (int fd)
    previous mode.  */
 
 extern "C" int
-setmode (int fd, int mode)
+_setmode (int fd, int mode)
 {
   cygheap_fdget cfd (fd);
   if (cfd < 0)
@@ -2792,7 +2792,7 @@ setmode (int fd, int mode)
 extern "C" int
 cygwin_setmode (int fd, int mode)
 {
-  int res = setmode (fd, mode);
+  int res = _setmode (fd, mode);
   if (res != -1)
     {
       _my_tls.locals.setmode_file = fd;
@@ -2892,7 +2892,7 @@ truncate (const char *pathname, _off_t l
 #endif
 
 extern "C" long
-get_osfhandle (int fd)
+_get_osfhandle (int fd)
 {
   long res;
 
Index: include/io.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/io.h,v
retrieving revision 1.3
diff -u -p -r1.3 io.h
--- include/io.h	17 Sep 2001 21:29:19 -0000	1.3
+++ include/io.h	22 Feb 2013 09:49:29 -0000
@@ -18,9 +18,10 @@ extern "C" {
 /*
  * Function to return a Win32 HANDLE from a fd.
  */
-extern long get_osfhandle(int);
-extern int setmode (int __fd, int __mode);
-int access(const char *__path, int __amode);
+extern long _get_osfhandle(int);
+#define get_osfhandle(i) _get_osfhandle(i)
+extern int _setmode (int __fd, int __mode);
+#define setmode(f,m) _setmode((f),(m))
 
 #ifdef __cplusplus
 };


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat
