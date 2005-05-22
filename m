Return-Path: <cygwin-patches-return-5481-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13462 invoked by alias); 22 May 2005 19:23:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13364 invoked by uid 22791); 22 May 2005 19:23:52 -0000
Received: from dessent.net (HELO dessent.net) (66.17.244.20)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Sun, 22 May 2005 19:23:52 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net)
	by dessent.net with esmtp (Exim 4.44)
	id 1DZw39-0000MA-3S
	for cygwin-patches@cygwin.com; Sun, 22 May 2005 19:23:47 +0000
Message-ID: <4290DC81.8311E428@dessent.net>
Date: Sun, 22 May 2005 19:23:00 -0000
From: Brian Dessent <brian@dessent.net>
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [patch] dump service info in cygcheck
Content-Type: multipart/mixed;
 boundary="------------DC3898DFC3C7F5E731668CFD"
X-SW-Source: 2005-q2/txt/msg00077.txt.bz2

This is a multi-part message in MIME format.
--------------DC3898DFC3C7F5E731668CFD
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 1261


(Okay, this time I hope this is the correct mailing list since this lives in
winsup/utils.)

Here is a first stab at the aforementioned patch to dump service information for
"cygcheck -s".  If you do not provide "-v" then you get the condensed output
(i.e. "cygrunsrv -Q service" for each service), otherwise you get the full
output of cygrunsrv -LV.  This has logic to deal with the following conditions:

- Not running NT
- cygrunsrv package not installed or can't execute
- cygrunsrv is older than v1.10
- no services installed

It also acts in the same way as the other "cygcheck -s" checks, in that if -h is
given it is slightly more verbose.

I used existing code that calls '/bin/id.exe' as a model, so that it looks up
the location in the mounts rather than searching the path.

I also changed 'Cygnus' to 'Cygwin' in an unrelated printf that I happened to
notice.  Not sure if that's desired or not but I would imagine most direct
references to Cygnus are probably anachronisms.

Brian

2005-05-22  Brian Dessent  <brian@dessent.net>

	* cygcheck.cc (dump_sysinfo_services): Add new function that uses
	new cygrunsrv options to dump service info.
	(dump_sysinfo): Call dump_sysinfo_services if running under NT.
	Change 'Cygnus' to 'Cygwin' in output.
--------------DC3898DFC3C7F5E731668CFD
Content-Type: text/plain; charset=us-ascii;
 name="cygcheck_services.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygcheck_services.patch"
Content-length: 3877

Index: cygcheck.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/cygcheck.cc,v
retrieving revision 1.71
diff -u -p -r1.71 cygcheck.cc
--- cygcheck.cc	20 May 2005 16:50:39 -0000	1.71
+++ cygcheck.cc	22 May 2005 19:08:48 -0000
@@ -870,6 +870,94 @@ pretty_id (const char *s, char *cygwin, 
       }
 }
 
+/* This dumps information about each installed cygwin service, if cygrunsrv
+   is available.  */
+void
+dump_sysinfo_services ()
+{
+  char buf[1024];
+  char buf2[1024];
+  FILE *f;
+  
+  if (givehelp)
+    printf ("\nChecking for any Cygwin services... %s\n\n", 
+                  verbose ? "" : "(use -v for more detail)");
+  else
+    fputc ('\n', stdout);
+  
+  /* find the location of cygrunsrv.exe */
+  char *cygrunsrv = cygpath ("/bin/cygrunsrv.exe", NULL);  
+  for (char *p = cygrunsrv; (p = strchr (p, '/')); p++)
+    *p = '\\';
+
+  if (access (cygrunsrv, X_OK))
+    {
+      puts ("Can't find the cygrunsrv utility, skipping services check.\n");
+      return;
+    }
+  
+  /* check for a recent cygrunsrv */
+  snprintf (buf, sizeof (buf), "%s --version", cygrunsrv);
+  if ((f = popen (buf, "rt")) == NULL)    
+    {
+      printf ("Failed to execute '%s', skipping services check.\n", buf);
+      return;
+    }
+  int maj, min;
+  int ret = fscanf (f, "cygrunsrv V%u.%u", &maj, &min);
+  if (ferror (f) || feof (f) || ret == EOF || maj < 1 || min < 10)
+    {
+      puts ("The version of cygrunsrv installed is too old to dump service info.\n");
+      return;
+    }
+  fclose (f);
+  
+  /* run cygrunsrv --list */
+  snprintf (buf, sizeof (buf), "%s --list", cygrunsrv);
+  if ((f = popen (buf, "rt")) == NULL)
+    {
+      printf ("Failed to execute '%s', skipping services check.\n", buf);
+      return;
+    }
+  size_t nchars = fread ((void *) buf, 1, sizeof (buf), f);
+  pclose (f);
+  
+  /* were any services found?  */
+  if (nchars < 1)
+    {
+      puts ("No Cygwin services found.\n");
+      return;
+    }
+  
+  
+  /* In verbose mode, just run 'cygrunsrv --list --verbose' and copy the 
+     entire output.  Otherwise run 'cygrunsrv --query' for each service.  */
+  for (char *srv = strtok (buf, "\n"); srv; srv = strtok (NULL, "\n"))
+    {
+      if (verbose)
+        snprintf (buf2, sizeof (buf2), "%s --list --verbose", cygrunsrv);
+      else
+        snprintf (buf2, sizeof (buf2), "%s --query %s", cygrunsrv, srv);
+      if ((f = popen (buf2, "rt")) == NULL)
+        {
+          printf ("Failed to execute '%s', skipping services check.\n", buf2);
+          return;
+        }
+        
+      /* copy output to stdout */
+      do
+        {
+          nchars = fread ((void *)buf2, 1, sizeof (buf2), f);
+          fwrite ((void *)buf2, 1, nchars, stdout);
+        }
+      while (!feof (f) && !ferror (f));
+      pclose (f);
+      
+      if (verbose)
+        break;
+    }
+}
+
 static void
 dump_sysinfo ()
 {
@@ -877,6 +965,7 @@ dump_sysinfo ()
   char tmp[4000];
   time_t now;
   char *found_cygwin_dll;
+  bool is_nt = false;
 
   printf ("\nCygwin Configuration Diagnostics\n");
   time (&now);
@@ -916,6 +1005,7 @@ dump_sysinfo ()
 	}
       break;
     case VER_PLATFORM_WIN32_NT:
+      is_nt = true;
       if (osversion.dwMajorVersion == 5)
 	{
 	  BOOL more_info = FALSE;
@@ -1248,7 +1338,7 @@ dump_sysinfo ()
   printf ("\n");
 
   if (givehelp)
-    printf ("Looking for various Cygnus DLLs...  (-v gives version info)\n");
+    printf ("Looking for various Cygwin DLLs...  (-v gives version info)\n");
   int cygwin_dll_count = 0;
   for (i = 1; i < num_paths; i++)
     {
@@ -1288,6 +1378,9 @@ dump_sysinfo ()
     puts ("Warning: There are multiple cygwin1.dlls on your path");
   if (!cygwin_dll_count)
     puts ("Warning: cygwin1.dll not found on your path");
+
+  if (is_nt)
+    dump_sysinfo_services ();
 }
 
 static int

--------------DC3898DFC3C7F5E731668CFD--
