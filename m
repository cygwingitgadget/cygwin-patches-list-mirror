Return-Path: <cygwin-patches-return-8622-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 76912 invoked by alias); 31 Aug 2016 18:08:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 76874 invoked by uid 89); 31 Aug 2016 18:08:19 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.2 spammy=15325, 153,25, HTo:U*cygwin-patches
X-HELO: smtp.salomon.at
Received: from smtp.salomon.at (HELO smtp.salomon.at) (193.186.16.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 31 Aug 2016 18:08:12 +0000
Received: from samail03.wamas.com ([172.28.33.235] helo=mailhost.salomon.at)	by smtp.salomon.at with esmtps (UNKNOWN:DHE-RSA-AES256-SHA:256)	(Exim 4.80.1)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1bf9vj-0004en-N8; Wed, 31 Aug 2016 20:08:10 +0200
Received: from [172.28.41.34] (helo=s01en24)	by mailhost.salomon.at with smtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1bf9vi-0006w5-Ee; Wed, 31 Aug 2016 20:08:07 +0200
Received: by s01en24 (sSMTP sendmail emulation); Wed, 31 Aug 2016 20:08:06 +0200
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
To: cygwin-patches@cygwin.com
Cc: michael.haubenwallner@ssi-schaefer.com
Subject: [PATCH 3/4] dlopen: on x/lib search x/bin if exe is in x/bin
Date: Wed, 31 Aug 2016 18:08:00 -0000
Message-Id: <1472666829-32223-4-git-send-email-michael.haubenwallner@ssi-schaefer.com>
In-Reply-To: <1472666829-32223-1-git-send-email-michael.haubenwallner@ssi-schaefer.com>
References: <1472666829-32223-1-git-send-email-michael.haubenwallner@ssi-schaefer.com>
X-SW-Source: 2016-q3/txt/msg00030.txt.bz2

citing https://cygwin.com/ml/cygwin-developers/2016-08/msg00020.html
> Consider the file /usr/bin/cygz.dll:
> - dlopen (libz.so)            success
> - dlopen (/usr/bin/libz.so)   success
> - dlopen (/usr/lib/libz.so)   fails

* dlfcn.c (dlopen): For dlopen("x/lib/N"), when the application
executable is in "x/bin/", search for "x/bin/N" before "x/lib/N".
---
 winsup/cygwin/dlfcn.cc | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/dlfcn.cc b/winsup/cygwin/dlfcn.cc
index e592512..f8b8743 100644
--- a/winsup/cygwin/dlfcn.cc
+++ b/winsup/cygwin/dlfcn.cc
@@ -153,6 +153,25 @@ collect_basenames (pathfinder::basenamelist & basenames,
   basenames.appendv (basename, baselen, ext, extlen, NULL);
 }
 
+/* Identify dir of current executable into exedirbuf using wpathbuf buffer.
+   Return length of exedirbuf on success, or zero on error. */
+static int
+get_exedir (char * exedirbuf, wchar_t * wpathbuf)
+{
+  /* Unless we have a special cygwin loader, there is no such thing like
+     DT_RUNPATH on Windows we can use to search for dlls, except for the
+     directory of the main executable. */
+  GetModuleFileNameW (NULL, wpathbuf, NT_MAX_PATH);
+  wchar_t * lastwsep = wcsrchr (wpathbuf, L'\\');
+  if (!lastwsep)
+    return 0;
+  *lastwsep = L'\0';
+  *exedirbuf = '\0';
+  if (cygwin_conv_path (CCP_WIN_W_TO_POSIX, wpathbuf, exedirbuf, NT_MAX_PATH))
+    return 0;
+  return strlen (exedirbuf);
+}
+
 extern "C" void *
 dlopen (const char *name, int flags)
 {
@@ -184,13 +203,28 @@ dlopen (const char *name, int flags)
       /* handle for the named library */
       path_conv real_filename;
       wchar_t *wpath = tp.w_get ();
+      char *cpath = tp.c_get ();
 
       pathfinder finder (allocator, basenames); /* eats basenames */
 
       if (have_dir)
 	{
+	  int dirlen = basename - 1 - name;
+
+	  /* if the specified dir is x/lib, and the current executable
+	     dir is x/bin, do the /lib -> /bin mapping, which is the
+	     same actually as adding the executable dir */
+	  if (dirlen >= 4 && !strncmp (name + dirlen - 4, "/lib", 4))
+	    {
+	      int exedirlen = get_exedir (cpath, wpath);
+	      if (exedirlen == dirlen &&
+		  !strncmp (cpath, name, dirlen - 4) &&
+		  !strcmp (cpath + dirlen - 4, "/bin"))
+		finder.add_searchdir (cpath, exedirlen);
+	    }
+
 	  /* search the specified dir */
-	  finder.add_searchdir (name, basename - 1 - name);
+	  finder.add_searchdir (name, dirlen);
 	}
       else
 	{
-- 
2.7.3
