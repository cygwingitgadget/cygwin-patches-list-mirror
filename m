Return-Path: <cygwin-patches-return-2479-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 25114 invoked by alias); 21 Jun 2002 04:12:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25050 invoked from network); 21 Jun 2002 04:12:12 -0000
Message-Id: <3.0.5.32.20020621000918.007f9dc0@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Thu, 20 Jun 2002 21:12:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: uinfo.cc & environ.cc
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q2/txt/msg00462.txt.bz2

Chris,

just a few nits.

Pierre

2002-06-20  Pierre Humblet <pierre.humblet@ieee.org>

	* uinfo.cc (cygheap_user::ontherange): Use env_name for NetUserGetInfo.
	(cygheap_user::env_logsrv): Verify env_domain is valid.
	* environ.cc: Include child_info.h and keep spenvs[] sorted.
	(environ_init): Check child_proc_info instead of myself->ppid_handle.

--- uinfo.cc.orig       2002-06-20 21:29:52.000000000 -0400
+++ uinfo.cc    2002-06-20 23:58:52.000000000 -0400
@@ -251,7 +251,7 @@
              WCHAR wlogsrv[INTERNET_MAX_HOST_NAME_LENGTH + 3];
              sys_mbstowcs (wlogsrv, env_logsrv (),
                            sizeof (wlogsrv) / sizeof(*wlogsrv));
-             sys_mbstowcs (wuser, name (), sizeof (wuser) / sizeof (*wuser));
+             sys_mbstowcs (wuser, env_name (), sizeof (wuser) / sizeof
(*wuser));
              if (!(ret = NetUserGetInfo (wlogsrv, wuser, 3,(LPBYTE *)&ui)))
                {
                  char *p;
@@ -304,7 +304,7 @@
   if (plogsrv)
     return plogsrv;
 
-  if (strcasematch (env_name (), "SYSTEM"))
+  if (!env_domain () || strcasematch (env_name (), "SYSTEM"))
     return NULL;
 
   char logsrv[INTERNET_MAX_HOST_NAME_LENGTH + 3];


--- environ.cc.orig     2002-06-20 21:37:52.000000000 -0400
+++ environ.cc  2002-06-20 23:11:00.000000000 -0400
@@ -25,6 +25,7 @@
 #include "cygheap.h"
 #include "registry.h"
 #include "environ.h"
+#include "child_info.h"
 
 extern BOOL allow_daemon;
 extern BOOL allow_glob;
@@ -712,7 +713,7 @@
       char *eq;
       if ((eq = strchr (newp, '=')) == NULL)
        eq = strchr (newp, '\0');
-      if (!myself->ppid_handle)
+      if (!child_proc_info)
        ucenv (newp, eq);
       if (*newp == 'T' && strncmp (newp, "TERM=", 5) == 0)
        sawTERM = 1;
@@ -765,8 +766,8 @@
 /* Keep this list in upper case and sorted */
 static NO_COPY spenv spenvs[] =
 {
-  {NL ("HOMEPATH="), &cygheap_user::env_homepath},
   {NL ("HOMEDRIVE="), &cygheap_user::env_homedrive},
+  {NL ("HOMEPATH="), &cygheap_user::env_homepath},
   {NL ("LOGONSERVER="), &cygheap_user::env_logsrv},
   {NL ("SYSTEMDRIVE="), NULL},
   {NL ("SYSTEMROOT="), NULL},

