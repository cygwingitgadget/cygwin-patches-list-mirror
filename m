Return-Path: <cygwin-patches-return-8636-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31677 invoked by alias); 2 Sep 2016 11:57:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 31666 invoked by uid 89); 2 Sep 2016 11:57:34 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.2 spammy=
X-HELO: smtp.salomon.at
Received: from smtp.salomon.at (HELO smtp.salomon.at) (193.186.16.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 02 Sep 2016 11:57:24 +0000
Received: from samail03.wamas.com ([172.28.33.235] helo=mailhost.salomon.at)	by smtp.salomon.at with esmtps (UNKNOWN:DHE-RSA-AES256-SHA:256)	(Exim 4.80.1)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1bfn60-0003CH-V6	for cygwin-patches@cygwin.com; Fri, 02 Sep 2016 13:57:22 +0200
Received: from s01en24.wamas.com ([172.28.41.34])	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1bfn60-00059V-Ik	for cygwin-patches@cygwin.com; Fri, 02 Sep 2016 13:57:20 +0200
Subject: Re: [PATCH 3/4] dlopen: on x/lib search x/bin if exe is in x/bin
To: cygwin-patches@cygwin.com
References: <1472666829-32223-1-git-send-email-michael.haubenwallner@ssi-schaefer.com> <1472666829-32223-4-git-send-email-michael.haubenwallner@ssi-schaefer.com> <20160901133255.GC1128@calimero.vinschen.de> <21ed8215-f321-ed7f-e06a-fa6f36900d65@ssi-schaefer.com> <20160902090302.GB7709@calimero.vinschen.de>
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Message-ID: <cbd1d3ad-9130-6fa8-92c7-59b656d40f2a@ssi-schaefer.com>
Date: Fri, 02 Sep 2016 11:57:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20160902090302.GB7709@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------0F765ACA12752B618B18F239"
X-SW-Source: 2016-q3/txt/msg00044.txt.bz2

This is a multi-part message in MIME format.
--------------0F765ACA12752B618B18F239
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-length: 977

On 09/02/2016 11:03 AM, Corinna Vinschen wrote:
> On Sep  2 10:46, Michael Haubenwallner wrote:
>> On 09/01/2016 03:32 PM, Corinna Vinschen wrote:
>>> You could just use the global variable program_invocation_name.  If in
>>> doubt, use the Windows path global_progname and convert it to full POSIX
>>> via cygwin_conv_path.
>>
>> Patch updated, using global_progname now.
> 
> Looks good and you're right to do it this way since I just noticed
> that program_invocation_name may return a relative pathname.

Yep.

> Btw., in other calls which require the full POSIX path we use
> mount_table->conv_to_posix_path instead of cygwin_conv_path (see
> e. g. fillout_pinfo()).  It's a bit faster.  Maybe something for a 
> followup patch.

No problem - attached.
This renders the original patch 4/4 valid again.

> Note for some later improvement:  I really wonder why we don't store
> the absolute POSIX path of the current executable globally yet...

Same here.

Thanks!
/haubi/


--------------0F765ACA12752B618B18F239
Content-Type: text/x-patch;
 name="0003-dlopen-on-x-lib-search-x-bin-if-exe-is-in-x-bin.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0003-dlopen-on-x-lib-search-x-bin-if-exe-is-in-x-bin.patch"
Content-length: 3080

From f7255edd33cb4abe34f27188aab8dccdfa5dd2a0 Mon Sep 17 00:00:00 2001
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Date: Wed, 31 Aug 2016 18:05:11 +0200
Subject: [PATCH 3/4] dlopen: on x/lib search x/bin if exe is in x/bin

citing https://cygwin.com/ml/cygwin-developers/2016-08/msg00020.html
> Consider the file /usr/bin/cygz.dll:
> - dlopen (libz.so)            success
> - dlopen (/usr/bin/libz.so)   success
> - dlopen (/usr/lib/libz.so)   fails

* dlfcn.c (dlopen): For dlopen("x/lib/N"), when the application
executable is in "x/bin/", search for "x/bin/N" before "x/lib/N".
---
 winsup/cygwin/dlfcn.cc | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/dlfcn.cc b/winsup/cygwin/dlfcn.cc
index e592512..159d4fe 100644
--- a/winsup/cygwin/dlfcn.cc
+++ b/winsup/cygwin/dlfcn.cc
@@ -20,6 +20,7 @@ details. */
 #include "cygtls.h"
 #include "tls_pbuf.h"
 #include "ntdll.h"
+#include "shared_info.h"
 #include "pathfinder.h"
 
 /* Dumb allocator using memory from tmp_pathbuf.w_get ().
@@ -153,6 +154,31 @@ collect_basenames (pathfinder::basenamelist & basenames,
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
+  *exedirbuf = '\0';
+
+  wchar_t * wlastsep = wcpcpy (wpathbuf, global_progname);
+  /* like wcsrchr(L'\\'), but we know the wcslen already */
+  while (--wlastsep > wpathbuf)
+    if (*wlastsep == L'\\')
+      break;
+  if (wlastsep <= wpathbuf)
+    return 0;
+  *wlastsep = L'\0';
+
+  if (mount_table->conv_to_posix_path (wpathbuf, exedirbuf, 0))
+    return 0;
+
+  return strlen (exedirbuf);
+}
+
 extern "C" void *
 dlopen (const char *name, int flags)
 {
@@ -184,13 +210,28 @@ dlopen (const char *name, int flags)
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
2.8.3


--------------0F765ACA12752B618B18F239--
