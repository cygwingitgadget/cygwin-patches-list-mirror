Return-Path: <cygwin-patches-return-5274-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8870 invoked by alias); 23 Dec 2004 16:42:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8809 invoked from network); 23 Dec 2004 16:42:17 -0000
Received: from unknown (HELO apmail1.astralpoint.com) (65.114.186.130)
  by sourceware.org with SMTP; 23 Dec 2004 16:42:17 -0000
Received: from [127.0.0.1] (helo=phumblet.no-ip.org)
	by usched40576.usa1ma.alcatel.com with esmtp (Exim 4.43)
	id I96P2G-0000CN-0V
	for cygwin-patches@cygwin.com; Thu, 23 Dec 2004 11:42:16 -0500
Message-ID: <41CAF567.365C09F7@phumblet.no-ip.org>
Date: Thu, 23 Dec 2004 16:42:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: pierre.humblet@ieee.org
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH]: Still stripping
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q4/txt/msg00275.txt.bz2

In a case such as "abc..exe", the posix_path "abc." should not be
stripped. The patch below only strips the posix path if the win32
path was stripped. I don't think that the posix path can be empty
in that case.

Pierre
 

2004-12-23  Pierre Humblet <pierre.humblet@ieee.org>

	* path.h (path_conv::set_normalized_path): Add second argument.
	* path.cc (path_conv::check): Declare, set and use "strip_tail".
	(path_conv::set_normalized_path): Add and use second argument,
	replacing all tail stripping tests.



Index: path.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.h,v
retrieving revision 1.67
diff -u -p -r1.67 path.h
--- path.h      2 Oct 2004 02:20:20 -0000       1.67
+++ path.h      23 Dec 2004 16:07:45 -0000
@@ -214,7 +214,7 @@ class path_conv
   unsigned __stdcall ndisk_links (DWORD);
   char *normalized_path;
   size_t normalized_path_size;
-  void set_normalized_path (const char *) __attribute__ ((regparm (2)));
+  void set_normalized_path (const char *, bool strip=false) __attribute__ ((regparm (2)));
   DWORD get_symlink_length () { return symlink_length; };
  private:
   DWORD symlink_length;  
Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.333
diff -u -p -r1.333 path.cc
--- path.cc     22 Dec 2004 11:31:30 -0000      1.333
+++ path.cc     23 Dec 2004 16:24:52 -0000
@@ -424,21 +424,18 @@ path_conv::fillin (HANDLE h)
 }
 
 void
-path_conv::set_normalized_path (const char *path_copy)
+path_conv::set_normalized_path (const char *path_copy, bool strip_tail)
 {
   char *eopath = strchr (path, '\0');
-  size_t n;
+  char *p = strchr (path_copy, '\0');
 
-  if (dev.devn != FH_FS || !*path_copy || strncmp (path_copy, "//./", 4) == 0)
-    n = strlen (path_copy) + 1;
-  else
+  if (strip_tail)
     {
-      char *p = strchr (path_copy, '\0');
-      while (*--p == '.' || *p == ' ')
-       continue;
-      p[1] = '\0';
-      n = 2 + p - path_copy;
+      while (p[-1] == '.' || p[-1] == ' ')
+        p--;
+      *p = '\0';
     }
+   size_t n = p + 1 - path_copy;
 
   normalized_path = path + sizeof (path) - n;
   if (normalized_path > eopath)
@@ -804,6 +801,7 @@ path_conv::check (const char *src, unsig
     add_ext_from_sym (sym);
 
 out:
+  bool strip_tail = false;
   /* If the user wants a directory, do not return a symlink */
   if (!need_directory || error)
     /* nothing to do */;
@@ -836,7 +834,10 @@ out:
          if (!tail)
            /* nothing */;
          else if (tail[-1] != '\\')
-           *tail = '\0';
+           {
+             *tail = '\0';
+             strip_tail = true;
+           }
          else
            {
              error = ENOENT;
@@ -901,7 +902,7 @@ out:
     {
       if (tail < path_end && tail > path_copy + 1)
        *tail = '/';
-      set_normalized_path (path_copy);
+      set_normalized_path (path_copy, strip_tail);
     }
 
 #if 0
