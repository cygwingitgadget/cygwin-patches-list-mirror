Return-Path: <cygwin-patches-return-4140-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26243 invoked by alias); 29 Aug 2003 12:15:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26184 invoked from network); 29 Aug 2003 12:15:28 -0000
Date: Fri, 29 Aug 2003 12:15:00 -0000
From: Elfyn McBratney <elfyn@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Small patch for the FAQ
Message-ID: <20030829121814.GR614@emcb.co.uk>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00156.txt.bz2


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 3739

Index: how-programming.texinfo
===================================================================
RCS file: /cvs/src/src/winsup/doc/how-programming.texinfo,v
retrieving revision 1.25
diff -u -u -p -r1.25 how-programming.texinfo
--- how-programming.texinfo	13 Feb 2003 14:20:32 -0000	1.25
+++ how-programming.texinfo	29 Aug 2003 12:11:04 -0000
@@ -6,12 +6,15 @@ If you are willing to be a package maint
 volunteers to prepare and maintain packages, because the priority of the
 Cygwin Team is Cygwin itself.
 
-There will be a separate web page where all the details are documented,
-but this is not prepared yet.  Meanwhile, pore through the cygwin-apps
-mailing archives (start at @file{http://cygwin.com/lists.html}), and
-subscribe.  Charles Wilson posted a short recipe of what's involved,
-using texinfo as an example,
-at @file{http://cygwin.com/ml/cygwin-apps/2000-11/msg00055.html}.  This
+There's a Cygwin Contributor's Guide on the project web page available
+here @file{http://cygwin.com/setup.html}, which details everything you'll
+need to know about being a package maintainer.  If you need any extra
+help you can ask on cygwin-apps @emph{at} cygwin @emph{dot} com mailing
+list, or alternatively you can search the cygwin-apps archives
+(start at @file{http://http://cygwin.com/lists.html}), as your question
+may well have been asked before.  Charles Wilson posted a short recipe
+of what's involved, using texinfo as an example, available at
+@file{http://cygwin.com/ml/cygwin-apps/2000-11/msg00055.html}.  This
 should give you an idea of what is required.
 
 You should announce your intentions to the general cygwin list, in case
Index: how-resources.texinfo
===================================================================
RCS file: /cvs/src/src/winsup/doc/how-resources.texinfo,v
retrieving revision 1.7
diff -u -u -p -r1.7 how-resources.texinfo
--- how-resources.texinfo	21 Feb 2003 20:13:55 -0000	1.7
+++ how-resources.texinfo	29 Aug 2003 12:11:05 -0000
@@ -18,10 +18,6 @@ There is a comprehensive Cygwin User's G
 and an API Reference at
 @file{http://cygwin.com/cygwin-api/cygwin-api.html}.
 
-There is an interesting paper about Cygwin from the 1998 USENIX Windows
-NT Workshop Proceedings at
-@file{http://cygwin.com/usenix-98/cygwin.html}.
-
 You can find documentation for the individual GNU tools at
 @file{http://www.fsf.org/manual/}.  (You should read GNU manuals from a
 local mirror, check @file{http://www.fsf.org/server/list-mirrors.html}
Index: what.texinfo
===================================================================
RCS file: /cvs/src/src/winsup/doc/what.texinfo,v
retrieving revision 1.21
diff -u -u -p -r1.21 what.texinfo
--- what.texinfo	27 Jul 2002 23:05:45 -0000	1.21
+++ what.texinfo	29 Aug 2003 12:11:06 -0000
@@ -32,17 +32,16 @@ exhibit different limitations, on the va
 
 @section Where can I get it?
 
-The main location for the Cygwin project is
-@file{http://cygwin.com/}.  There you should find
-everything you need for Cygwin, including links for download and setup,
-a current list of ftp mirror sites, a User's Guide, an API Reference,
-mailing lists and archives, and additional ported software.
+The home page for the Cygwin project is @file{http://cygwin.com/}.
+There you should find everything you need for Cygwin, including links
+for download and setup, a current list of ftp mirror sites,
+a User's Guide, an API Reference, mailing lists and archives, and
+additional ported software.
 
 You can find documentation for the individual GNU tools at
 @file{http://www.fsf.org/manual/}.  (You should read GNU manuals from a
 local mirror.  Check @file{http://www.fsf.org/server/list-mirrors.html}
 for a list of them.)
-
 
 @section Is it free software?
 

-- Elfyn

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cygfaq.patch"
Content-length: 3729

Index: how-programming.texinfo
===================================================================
RCS file: /cvs/src/src/winsup/doc/how-programming.texinfo,v
retrieving revision 1.25
diff -u -u -p -r1.25 how-programming.texinfo
--- how-programming.texinfo	13 Feb 2003 14:20:32 -0000	1.25
+++ how-programming.texinfo	29 Aug 2003 12:11:04 -0000
@@ -6,12 +6,15 @@ If you are willing to be a package maint
 volunteers to prepare and maintain packages, because the priority of the
 Cygwin Team is Cygwin itself.
 
-There will be a separate web page where all the details are documented,
-but this is not prepared yet.  Meanwhile, pore through the cygwin-apps
-mailing archives (start at @file{http://cygwin.com/lists.html}), and
-subscribe.  Charles Wilson posted a short recipe of what's involved,
-using texinfo as an example,
-at @file{http://cygwin.com/ml/cygwin-apps/2000-11/msg00055.html}.  This
+There's a Cygwin Contributor's Guide on the project web page available
+here @file{http://cygwin.com/setup.html}, which details everything you'll
+need to know about being a package maintainer.  If you need any extra
+help you can ask on cygwin-apps @emph{at} cygwin @emph{dot} com mailing
+list, or alternatively you can search the cygwin-apps archives
+(start at @file{http://http://cygwin.com/lists.html}), as your question
+may well have been asked before.  Charles Wilson posted a short recipe
+of what's involved, using texinfo as an example, available at
+@file{http://cygwin.com/ml/cygwin-apps/2000-11/msg00055.html}.  This
 should give you an idea of what is required.
 
 You should announce your intentions to the general cygwin list, in case
Index: how-resources.texinfo
===================================================================
RCS file: /cvs/src/src/winsup/doc/how-resources.texinfo,v
retrieving revision 1.7
diff -u -u -p -r1.7 how-resources.texinfo
--- how-resources.texinfo	21 Feb 2003 20:13:55 -0000	1.7
+++ how-resources.texinfo	29 Aug 2003 12:11:05 -0000
@@ -18,10 +18,6 @@ There is a comprehensive Cygwin User's G
 and an API Reference at
 @file{http://cygwin.com/cygwin-api/cygwin-api.html}.
 
-There is an interesting paper about Cygwin from the 1998 USENIX Windows
-NT Workshop Proceedings at
-@file{http://cygwin.com/usenix-98/cygwin.html}.
-
 You can find documentation for the individual GNU tools at
 @file{http://www.fsf.org/manual/}.  (You should read GNU manuals from a
 local mirror, check @file{http://www.fsf.org/server/list-mirrors.html}
Index: what.texinfo
===================================================================
RCS file: /cvs/src/src/winsup/doc/what.texinfo,v
retrieving revision 1.21
diff -u -u -p -r1.21 what.texinfo
--- what.texinfo	27 Jul 2002 23:05:45 -0000	1.21
+++ what.texinfo	29 Aug 2003 12:11:06 -0000
@@ -32,17 +32,16 @@ exhibit different limitations, on the va
 
 @section Where can I get it?
 
-The main location for the Cygwin project is
-@file{http://cygwin.com/}.  There you should find
-everything you need for Cygwin, including links for download and setup,
-a current list of ftp mirror sites, a User's Guide, an API Reference,
-mailing lists and archives, and additional ported software.
+The home page for the Cygwin project is @file{http://cygwin.com/}.
+There you should find everything you need for Cygwin, including links
+for download and setup, a current list of ftp mirror sites,
+a User's Guide, an API Reference, mailing lists and archives, and
+additional ported software.
 
 You can find documentation for the individual GNU tools at
 @file{http://www.fsf.org/manual/}.  (You should read GNU manuals from a
 local mirror.  Check @file{http://www.fsf.org/server/list-mirrors.html}
 for a list of them.)
-
 
 @section Is it free software?
 

--vkogqOf2sHV7VnPd--
