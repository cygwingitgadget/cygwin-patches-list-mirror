From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: A few fixes to winsup/utils/cygpath.cc
Date: Wed, 26 Dec 2001 09:35:00 -0000
Message-ID: <20011226173530.GB21023@redhat.com>
References: <20011226130350.7718.qmail@lizard.curl.com>
X-SW-Source: 2001-q4/msg00354.html
Message-ID: <20011226093500.hfd0enRVh7I6sb6NL1Cmhad_9AvQKDq4zaCumtjEQKM@z>

Looks good but it's missing a ChangeLog.

cgf

On Wed, Dec 26, 2001 at 08:03:50AM -0500, Jonathan Kamens wrote:
>I sent this patch in last night, but I don't think it made it to the
>list because I wasn't subscribed properly (at least, it's not in the
>archive yet, and I assume it would have shown up by now), so here it
>is again.
>
>The patch below fixes the following three problems in
>winsup/utils/cygpath.cc:
>
>1) Calculate prog_name correctly -- skip over the final slash or
>   backslash.
>2) Print a useful error message and exit with non-zero status if the
>   user tries to convert an empty path.
>3) Detect if a path conversion function returns -1 (indicating
>   failure) and print an error message if so.
>
>jik

>Index: cygpath.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/utils/cygpath.cc,v
>retrieving revision 1.10
>diff -u -r1.10 cygpath.cc
>--- cygpath.cc	2001/12/11 22:51:01	1.10
>+++ cygpath.cc	2001/12/26 13:03:13
>@@ -141,6 +141,8 @@
> {
>   char *buf;
>   size_t len;
>+  int retval;
>+  int (*conv_func)(const char *, char *);
> 
>   if (path_flag)
>     {
>@@ -155,7 +157,14 @@
>     }
> 
>   if (! path_flag)
>-    len = strlen (filename) + 100;
>+    {
>+      len = strlen (filename) + 100;
>+      if (len == 100)
>+        {
>+          fprintf(stderr, "%s: can't convert empty path\n", prog_name);
>+          exit (1);
>+        }
>+    }
>   else
>     {
>       if (unix_flag)
>@@ -188,13 +197,20 @@
>   else
>     {
>       if (unix_flag)
>-	(absolute_flag ? cygwin_conv_to_full_posix_path : cygwin_conv_to_posix_path) (filename, buf);
>+	conv_func = (absolute_flag ? cygwin_conv_to_full_posix_path : 
>+                     cygwin_conv_to_posix_path);
>       else
>-	{
>-	  (absolute_flag ? cygwin_conv_to_full_win32_path : cygwin_conv_to_win32_path) (filename, buf);
>-	  if (shortname_flag)
>-	    buf = get_short_name (buf);
>-	}
>+        conv_func = (absolute_flag ? cygwin_conv_to_full_win32_path :
>+                     cygwin_conv_to_win32_path);
>+      retval = conv_func (filename, buf);
>+      if (retval < 0)
>+        {
>+          fprintf (stderr, "%s: error converting \"%s\"\n",
>+                   prog_name, filename);
>+          exit (1);
>+        }
>+      if (!unix_flag && shortname_flag)
>+        buf = get_short_name (buf);
>     }
> 
>   puts (buf);
>@@ -214,6 +230,8 @@
>     prog_name = strrchr (argv[0], '\\');
>   if (prog_name == NULL)
>     prog_name = argv[0];
>+  else
>+    prog_name++;
> 
>   path_flag = 0;
>   unix_flag = 0;

-- 
cgf@redhat.com                        Red Hat, Inc.
http://sources.redhat.com/            http://www.redhat.com/
