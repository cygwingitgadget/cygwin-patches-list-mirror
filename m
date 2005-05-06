Return-Path: <cygwin-patches-return-5432-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4678 invoked by alias); 6 May 2005 18:25:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4552 invoked from network); 6 May 2005 18:25:09 -0000
Received: from unknown (HELO agminet04.oracle.com) (141.146.126.231)
  by sourceware.org with SMTP; 6 May 2005 18:25:09 -0000
Received: from rgmgw1.us.oracle.com (rgmgw1.us.oracle.com [138.1.191.10])
	by agminet04.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id j46IP7CQ006483
	for <cygwin-patches@cygwin.com>; Fri, 6 May 2005 13:25:08 -0500
Received: from rgmgw1.us.oracle.com (localhost [127.0.0.1])
	by rgmgw1.us.oracle.com (Switch-3.1.4/Switch-3.1.0) with ESMTP id j46IP60m001143
	for <cygwin-patches@cygwin.com>; Fri, 6 May 2005 12:25:07 -0600
Received: from vzell-de.de.oracle.com (dhcp-munich-ppp-140-86-222-46.de.oracle.com [140.86.222.46])
	by rgmgw1.us.oracle.com (Switch-3.1.4/Switch-3.1.0) with ESMTP id j46IP4Yf000994
	for <cygwin-patches@cygwin.com>; Fri, 6 May 2005 12:25:05 -0600
To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Subject: [PATCH 21.5.20] HAVE_DECL_SYS_SIGLIST instead of
 SYS_SIGLIST_DECLARED in sysdep.c
From: "Dr. Volker Zell" <Dr.Volker.Zell@oracle.com>
Date: Fri, 06 May 2005 18:25:00 -0000
Message-ID: <87u0lgqkem.fsf@vzell-de.de.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SW-Source: 2005-q2/txt/msg00028.txt.bz2

2005-05-06  Dr. Volker Zell  <Dr.Volker.Zell@oracle.com>

	* sysdep.c: Use autoconf 2.59's HAVE_DECL_SYS_SIGLIST instead of
	SYS_SIGLIST_DECLARED.

diff -u -p /usr/src/xemacs-21.5.20/src/sysdep.c.orig /usr/src/xemacs-21.5.20/src/sysdep.c
--- /usr/src/xemacs-21.5.20/src/sysdep.c.orig	2005-05-06 20:23:47.473737600 +0200
+++ /usr/src/xemacs-21.5.20/src/sysdep.c	2005-05-06 20:23:47.533824000 +0200
@@ -3829,7 +3829,7 @@ get_random (void)
 /*               Strings corresponding to defined signals               */
 /************************************************************************/
 
-#if !defined (SYS_SIGLIST_DECLARED) && !defined (HAVE_SYS_SIGLIST)
+#if (!defined(HAVE_DECL_SYS_SIGLIST) || !HAVE_DECL_SYS_SIGLIST ) && !defined (HAVE_SYS_SIGLIST)
 
 #if defined(WIN32_NATIVE) || defined(CYGWIN)
 const char *sys_siglist[] =
@@ -4031,7 +4031,7 @@ const char *sys_siglist[NSIG + 1] =
   };
 #endif /* DGUX */
 
-#endif /* ! SYS_SIGLIST_DECLARED && ! HAVE_SYS_SIGLIST */
+#endif /* (!defined(HAVE_DECL_SYS_SIGLIST) || !HAVE_DECL_SYS_SIGLIST ) && !defined (HAVE_SYS_SIGLIST) */
 
 
 /************************************************************************/

Ciao
  Volker
