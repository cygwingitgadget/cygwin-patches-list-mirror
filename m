Return-Path: <cygwin-patches-return-5379-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6190 invoked by alias); 24 Mar 2005 09:52:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6034 invoked from network); 24 Mar 2005 09:51:42 -0000
Received: from unknown (HELO dessent.net) (66.17.244.20)
  by sourceware.org with SMTP; 24 Mar 2005 09:51:42 -0000
Received: from localhost ([127.0.0.1] helo=dessent.net)
	by dessent.net with esmtp (Exim 4.44)
	id 1DEOyU-0005FN-6R
	for cygwin-patches@cygwin.com; Thu, 24 Mar 2005 09:49:58 +0000
Message-ID: <42428E10.3569CCB7@dessent.net>
Date: Thu, 24 Mar 2005 09:52:00 -0000
From: Brian Dessent <brian@dessent.net>
Organization: My own little world...
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [patch] fix for cygcheck -s if run from /usr/bin
Content-Type: multipart/mixed;
 boundary="------------00739657BB7EAC73EB0DD44B"
X-SW-Source: 2005-q1/txt/msg00082.txt.bz2

This is a multi-part message in MIME format.
--------------00739657BB7EAC73EB0DD44B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 1333


Currently, if you run cygcheck -s with the current directory as /usr/bin
you get every cyg*.dll found twice, once with ".\" prefix and the second
time with "\cygwin\bin\" prefix.  The user gets a spurious "Multiple
Cygwin DLLs found" warning even if there is only one present.

The following patch tries to correct this.  In init_paths(), the
paths[1] value is populated by GetCurrentDirectory() instead of just
".".  This causes the existing duplicate checking code in add_path() to
reject a later attempt to add a directory from $PATH that is the same as
CWD.

However, this also means that if "." is in $PATH it will no longer be
rejected by that same duplicate checking code, so init_paths() is also
modified to not add "." since we already have the CWD added explicitly.

Finally, in dump_sysinfo() the loop is changed to check starting with
paths[1] instead of paths[0], since paths[0] is a special "placeholder"
value that is initialized to ".".  paths[1] contains the CWD anyway so
there's no need to examine paths[0].

Brian

===================================================================

2005-03-24  Brian Dessent  <brian@dessent.net>

	* cygcheck.cc (init_paths): Use full path instead of "." for the
	current directory.  Do not add "." if present in $PATH.
	(dump_sysinfo): Skip placeholder first value of paths[].
--------------00739657BB7EAC73EB0DD44B
Content-Type: text/plain; charset=us-ascii;
 name="cygcheck-path.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygcheck-path.diff"
Content-length: 1248

Index: cygcheck.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/cygcheck.cc,v
retrieving revision 1.64
diff -u -p -r1.64 cygcheck.cc
--- cygcheck.cc	18 Nov 2004 05:20:23 -0000	1.64
+++ cygcheck.cc	24 Mar 2005 09:41:40 -0000
@@ -158,7 +158,12 @@ init_paths ()
 {
   char tmp[4000], *sl;
   add_path ((char *) ".", 1);	/* to be replaced later */
-  add_path ((char *) ".", 1);	/* the current directory */
+  
+  if (GetCurrentDirectory (4000, tmp))
+    add_path (tmp, strlen (tmp));
+  else
+    display_error ("init_paths: GetCurrentDirectory()");  
+  
   if (GetSystemDirectory (tmp, 4000))
     add_path (tmp, strlen (tmp));
   else
@@ -180,7 +185,8 @@ init_paths ()
       while (1)
 	{
 	  for (e = b; *e && *e != ';'; e++);
-	  add_path (b, e - b);
+	  if (strncmp(b, ".", 1) && strncmp(b, ".\\", 2))
+	    add_path (b, e - b);
 	  if (!*e)
 	    break;
 	  b = e + 1;
@@ -1237,7 +1243,7 @@ dump_sysinfo ()
   if (givehelp)
     printf ("Looking for various Cygnus DLLs...  (-v gives version info)\n");
   int cygwin_dll_count = 0;
-  for (i = 0; i < num_paths; i++)
+  for (i = 1; i < num_paths; i++)
     {
       WIN32_FIND_DATA ffinfo;
       sprintf (tmp, "%s/*.*", paths[i]);


--------------00739657BB7EAC73EB0DD44B--

