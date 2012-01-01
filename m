Return-Path: <cygwin-patches-return-7579-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7009 invoked by alias); 1 Jan 2012 07:13:40 -0000
Received: (qmail 6999 invoked by uid 22791); 1 Jan 2012 07:13:39 -0000
X-SWARE-Spam-Status: No, hits=-2.3 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,TW_CP,TW_SF,TW_TW,TW_VP,TW_VT
X-Spam-Check-By: sourceware.org
Received: from mail-iy0-f171.google.com (HELO mail-iy0-f171.google.com) (209.85.210.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 01 Jan 2012 07:13:26 +0000
Received: by iagw33 with SMTP id w33so29451961iag.2        for <cygwin-patches@cygwin.com>; Sat, 31 Dec 2011 23:13:25 -0800 (PST)
Received: by 10.42.163.200 with SMTP id d8mr47263448icy.41.1325402004541;        Sat, 31 Dec 2011 23:13:24 -0800 (PST)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id r18sm149235776ibh.4.2011.12.31.23.13.22        (version=SSLv3 cipher=OTHER);        Sat, 31 Dec 2011 23:13:23 -0800 (PST)
Message-ID: <1325402005.2376.5.camel@YAAKOV04>
Subject: Re: [PATCH] Add get_current_dir_name(3)
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Date: Sun, 01 Jan 2012 07:13:00 -0000
In-Reply-To: <20120101064630.GB3446@ednor.casa.cgf.cx>
References: <1325385907.4064.7.camel@YAAKOV04>	 <20120101064630.GB3446@ednor.casa.cgf.cx>
Content-Type: multipart/mixed; boundary="=-ElewqlIpH33pXBDjVJDt"
Mime-Version: 1.0
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q1/txt/msg00002.txt.bz2


--=-ElewqlIpH33pXBDjVJDt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 559

On Sun, 2012-01-01 at 01:46 -0500, Christopher Faylor wrote:
> On Sat, Dec 31, 2011 at 08:45:07PM -0600, Yaakov (Cygwin/X) wrote:
> >+extern "C" char *
> >+get_current_dir_name (void)
> >+{
> >+  char *pwd = getenv ("PWD");
> >+  char *cwd = getcwd (NULL, 0);
> >+
> >+  if (pwd)
> >+    {
> >+      struct __stat64 pwdbuf, cwdbuf;
> >+      stat64 (pwd, &pwdbuf);
> >+      stat64 (cwd, &cwdbuf);
> >+      if (pwdbuf.st_ino == cwdbuf.st_ino)
> 
> You have to check st_dev here too don't you?

Of course.  Revised patch for winsup/cygwin attached.


Yaakov


--=-ElewqlIpH33pXBDjVJDt
Content-Disposition: attachment; filename="cygwin-get_current_dir_name.patch"
Content-Type: text/x-patch; name="cygwin-get_current_dir_name.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 2972

2012-01-01  Yaakov Selkowitz  <yselkowitz@...>

	* cygwin.din (get_current_dir_name): Export.
	* path.cc (get_current_dir_name): New function.
	* posix.sgml (std-gnu): Add get_current_dir_name.
	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.250
diff -u -p -r1.250 cygwin.din
--- cygwin.din	30 Dec 2011 20:22:27 -0000	1.250
+++ cygwin.din	1 Jan 2012 07:11:31 -0000
@@ -672,6 +672,7 @@ _gcvt = gcvt SIGFE
 gcvtf SIGFE
 _gcvtf = gcvtf SIGFE
 get_avphys_pages SIGFE
+get_current_dir_name SIGFE
 get_nprocs SIGFE
 get_nprocs_conf SIGFE
 get_osfhandle SIGFE
Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.644
diff -u -p -r1.644 path.cc
--- path.cc	24 Dec 2011 13:11:34 -0000	1.644
+++ path.cc	1 Jan 2012 07:11:31 -0000
@@ -2855,6 +2855,27 @@ getwd (char *buf)
   return getcwd (buf, PATH_MAX + 1);  /*Per SuSv3!*/
 }
 
+extern "C" char *
+get_current_dir_name (void)
+{
+  char *pwd = getenv ("PWD");
+  char *cwd = getcwd (NULL, 0);
+
+  if (pwd)
+    {
+      struct __stat64 pwdbuf, cwdbuf;
+      stat64 (pwd, &pwdbuf);
+      stat64 (cwd, &cwdbuf);
+      if ((pwdbuf.st_dev == cwdbuf.st_dev) && (pwdbuf.st_ino == cwdbuf.st_ino))
+        {
+          cwd = (char *) malloc (strlen (pwd) + 1);
+          strcpy (cwd, pwd);
+        }
+    }
+
+  return cwd;
+}
+
 /* chdir: POSIX 5.2.1.1 */
 extern "C" int
 chdir (const char *in_dir)
Index: posix.sgml
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/posix.sgml,v
retrieving revision 1.73
diff -u -p -r1.73 posix.sgml
--- posix.sgml	30 Dec 2011 20:22:27 -0000	1.73
+++ posix.sgml	1 Jan 2012 07:11:32 -0000
@@ -1111,6 +1111,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008)
     fremovexattr
     fsetxattr
     get_avphys_pages
+    get_current_dir_name
     get_phys_pages
     get_nprocs
     get_nprocs_conf
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.358
diff -u -p -r1.358 version.h
--- include/cygwin/version.h	30 Dec 2011 20:22:28 -0000	1.358
+++ include/cygwin/version.h	1 Jan 2012 07:11:32 -0000
@@ -426,12 +426,13 @@ details. */
       255: Export ptsname_r.
       256: Add CW_ALLOC_DRIVE_MAP, CW_MAP_DRIVE_MAP, CW_FREE_DRIVE_MAP.
       257: Export getpt.
+      258: Export get_current_dir_name.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 257
+#define CYGWIN_VERSION_API_MINOR 258
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible

--=-ElewqlIpH33pXBDjVJDt--
