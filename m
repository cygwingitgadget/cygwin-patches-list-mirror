Return-Path: <cygwin-patches-return-5209-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9241 invoked by alias); 16 Dec 2004 14:56:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8919 invoked from network); 16 Dec 2004 14:56:19 -0000
Received: from unknown (HELO apmail1.astralpoint.com) (65.114.186.130)
  by sourceware.org with SMTP; 16 Dec 2004 14:56:18 -0000
Received: from [127.0.0.1] (helo=phumblet.no-ip.org)
	by usched40576.usa1ma.alcatel.com with esmtp (Exim 4.43)
	id I8TLHO-0000AO-0U; Thu, 16 Dec 2004 09:56:12 -0500
Message-ID: <41C1A1F4.CD3CC833@phumblet.no-ip.org>
Date: Thu, 16 Dec 2004 14:56:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: pierre.humblet@ieee.org
MIME-Version: 1.0
To: mark.paulus@mci.com, cygwin-patches@cygwin.com
Subject: Re: Patch to allow trailing dots on managed mounts
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q4/txt/msg00210.txt.bz2


Here is an untested patch.
I hope Mark can test it (on managed and unmanaged mounts,
including basenames consisting entirely of dots and spaces)
and possibly make adjustments, without having to file the 
paperwork.

Pierre

	* path.cc (path_conv::check): Do not strip trailing dots and spaces.
	* fhandler.cc (fhandler_base::open): Strip trailing dots and spaces.



Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.326
diff -u -p -r1.326 path.cc
--- path.cc     3 Dec 2004 02:00:37 -0000       1.326
+++ path.cc     16 Dec 2004 14:42:58 -0000
@@ -546,25 +546,12 @@ path_conv::check (const char *src, unsig
       /* Detect if the user was looking for a directory.  We have to strip the
         trailing slash initially while trying to add extensions but take it
         into account during processing */
-      if (tail > path_copy + 1)
+      if (tail > path_copy + 1 && isslash (tail[-1]))
        {
-         if (isslash (tail[-1]))
-           {
-              need_directory = 1;
-              tail--;
-           }
-         /* Remove trailing dots and spaces which are ignored by Win32 functions but
-            not by native NT functions. */
-         while (tail[-1] == '.' || tail[-1] == ' ')
-           tail--;
-         if (tail > path_copy + 1 && isslash (tail[-1]))
-           {
-             error = ENOENT;
-             return;
-           }
+          need_directory = 1;
+          *--tail = '\0';
        }
       path_end = tail;
-      *tail = '\0';
 
       /* Scan path_copy from right to left looking either for a symlink
         or an actual existing file.  If an existing file is found, just
Index: fhandler.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
retrieving revision 1.207
diff -u -p -r1.207 fhandler.cc
--- fhandler.cc 20 Nov 2004 23:42:36 -0000      1.207
+++ fhandler.cc 16 Dec 2004 14:43:51 -0000
@@ -537,6 +537,17 @@ fhandler_base::open (int flags, mode_t m
   UNICODE_STRING upath = {0, sizeof (wpath), wpath};
   pc.get_nt_native_path (upath);
 
+  /* Remove trailing dots and spaces which are ignored by Win32 functions but
+     not by native NT functions. */
+  WCHAR *tail = upath.Buffer + upath.Length;
+  while (tail[-1] == '.' || tail[-1] == ' ')
+    tail--;
+  if (tail[-1] == '\\')
+    {
+      set_errno (ENOENT);
+      return 0;
+    }
+
   if (RtlIsDosDeviceName_U (upath.Buffer))
     return fhandler_base::open_9x (flags, mode);
