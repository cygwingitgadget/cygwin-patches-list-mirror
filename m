Return-Path: <cygwin-patches-return-8623-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 76920 invoked by alias); 31 Aug 2016 18:08:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 76886 invoked by uid 89); 31 Aug 2016 18:08:19 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:1135, HTo:U*cygwin-patches
X-HELO: smtp.salomon.at
Received: from smtp.salomon.at (HELO smtp.salomon.at) (193.186.16.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 31 Aug 2016 18:08:18 +0000
Received: from samail03.wamas.com ([172.28.33.235] helo=mailhost.salomon.at)	by smtp.salomon.at with esmtps (UNKNOWN:DHE-RSA-AES256-SHA:256)	(Exim 4.80.1)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1bf9vs-0004et-7w; Wed, 31 Aug 2016 20:08:16 +0200
Received: from [172.28.41.34] (helo=s01en24)	by mailhost.salomon.at with smtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1bf9vq-0006w8-Vp; Wed, 31 Aug 2016 20:08:16 +0200
Received: by s01en24 (sSMTP sendmail emulation); Wed, 31 Aug 2016 20:08:14 +0200
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
To: cygwin-patches@cygwin.com
Cc: michael.haubenwallner@ssi-schaefer.com
Subject: [PATCH 4/4] dlopen: on unspecified lib dir search exe dir
Date: Wed, 31 Aug 2016 18:08:00 -0000
Message-Id: <1472666829-32223-5-git-send-email-michael.haubenwallner@ssi-schaefer.com>
In-Reply-To: <1472666829-32223-1-git-send-email-michael.haubenwallner@ssi-schaefer.com>
References: <1472666829-32223-1-git-send-email-michael.haubenwallner@ssi-schaefer.com>
X-SW-Source: 2016-q3/txt/msg00031.txt.bz2

Applications installed to some prefix like /opt/application do expect
dlopen("libAPP.so") to load "/opt/application/bin/cygAPP.dll", which
is similar to "/opt/application/lib/libAPP.so" on Linux.

See also https://cygwin.com/ml/cygwin-developers/2016-08/msg00020.html

* dlfcn.cc (dlopen): For dlopen("N"), search directory where the
application executable is in.
---
 winsup/cygwin/dlfcn.cc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/winsup/cygwin/dlfcn.cc b/winsup/cygwin/dlfcn.cc
index f8b8743..974092e 100644
--- a/winsup/cygwin/dlfcn.cc
+++ b/winsup/cygwin/dlfcn.cc
@@ -232,6 +232,12 @@ dlopen (const char *name, int flags)
 	     not use the LD_LIBRARY_PATH environment variable. */
 	  finder.add_envsearchpath ("LD_LIBRARY_PATH");
 
+	  /* Search the current executable's directory like
+	     the Windows loader does for linked dlls. */
+	  int exedirlen = get_exedir (cpath, wpath);
+	  if (exedirlen)
+	    finder.add_searchdir (cpath, exedirlen);
+
 	  /* Finally we better have some fallback. */
 	  finder.add_searchdir ("/usr/bin", 8);
 	  finder.add_searchdir ("/usr/lib", 8);
-- 
2.7.3
