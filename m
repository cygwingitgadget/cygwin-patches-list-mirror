Return-Path: <cygwin-patches-return-1626-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 5719 invoked by alias); 26 Dec 2001 13:03:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5700 invoked from network); 26 Dec 2001 13:03:51 -0000
Date: Thu, 08 Nov 2001 23:59:00 -0000
Message-ID: <20011226130350.7718.qmail@lizard.curl.com>
From: Jonathan Kamens <jik@curl.com>
To: cygwin-patches@cygwin.com
Subject: A few fixes to winsup/utils/cygpath.cc
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Multipart_Wed_Dec_26_08:03:50_2001"
Content-Transfer-Encoding: 7bit
X-SW-Source: 2001-q4/txt/msg00158.txt.bz2

--Multipart_Wed_Dec_26_08:03:50_2001
Content-Type: text/plain; charset=US-ASCII
Content-length: 600

I sent this patch in last night, but I don't think it made it to the
list because I wasn't subscribed properly (at least, it's not in the
archive yet, and I assume it would have shown up by now), so here it
is again.

The patch below fixes the following three problems in
winsup/utils/cygpath.cc:

1) Calculate prog_name correctly -- skip over the final slash or
   backslash.
2) Print a useful error message and exit with non-zero status if the
   user tries to convert an empty path.
3) Detect if a path conversion function returns -1 (indicating
   failure) and print an error message if so.

jik

--Multipart_Wed_Dec_26_08:03:50_2001
Content-Type: text/plain; name="cygpath-diff.txt"; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-length: 1770

Index: cygpath.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/cygpath.cc,v
retrieving revision 1.10
diff -u -r1.10 cygpath.cc
--- cygpath.cc	2001/12/11 22:51:01	1.10
+++ cygpath.cc	2001/12/26 13:03:13
@@ -141,6 +141,8 @@
 {
   char *buf;
   size_t len;
+  int retval;
+  int (*conv_func)(const char *, char *);
 
   if (path_flag)
     {
@@ -155,7 +157,14 @@
     }
 
   if (! path_flag)
-    len = strlen (filename) + 100;
+    {
+      len = strlen (filename) + 100;
+      if (len == 100)
+        {
+          fprintf(stderr, "%s: can't convert empty path\n", prog_name);
+          exit (1);
+        }
+    }
   else
     {
       if (unix_flag)
@@ -188,13 +197,20 @@
   else
     {
       if (unix_flag)
-	(absolute_flag ? cygwin_conv_to_full_posix_path : cygwin_conv_to_posix_path) (filename, buf);
+	conv_func = (absolute_flag ? cygwin_conv_to_full_posix_path : 
+                     cygwin_conv_to_posix_path);
       else
-	{
-	  (absolute_flag ? cygwin_conv_to_full_win32_path : cygwin_conv_to_win32_path) (filename, buf);
-	  if (shortname_flag)
-	    buf = get_short_name (buf);
-	}
+        conv_func = (absolute_flag ? cygwin_conv_to_full_win32_path :
+                     cygwin_conv_to_win32_path);
+      retval = conv_func (filename, buf);
+      if (retval < 0)
+        {
+          fprintf (stderr, "%s: error converting \"%s\"\n",
+                   prog_name, filename);
+          exit (1);
+        }
+      if (!unix_flag && shortname_flag)
+        buf = get_short_name (buf);
     }
 
   puts (buf);
@@ -214,6 +230,8 @@
     prog_name = strrchr (argv[0], '\\');
   if (prog_name == NULL)
     prog_name = argv[0];
+  else
+    prog_name++;
 
   path_flag = 0;
   unix_flag = 0;
--Multipart_Wed_Dec_26_08:03:50_2001--
