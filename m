Return-Path: <cygwin-patches-return-5623-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8288 invoked by alias); 17 Aug 2005 00:28:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8202 invoked by uid 22791); 17 Aug 2005 00:28:02 -0000
Received: from dessent.net (HELO dessent.net) (69.60.119.225)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Wed, 17 Aug 2005 00:28:02 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net)
	by dessent.net with esmtp (Exim 4.52)
	id 1E5Bmi-00007k-1Y
	for cygwin-patches@cygwin.com; Wed, 17 Aug 2005 00:28:00 +0000
Message-ID: <4302850A.A3AC4F4E@dessent.net>
Date: Wed, 17 Aug 2005 00:28:00 -0000
From: Brian Dessent <brian@dessent.net>
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix cygrunsrv invocation in cygcheck
References: <Pine.GSO.4.61.0508161203480.9560@slinky.cs.nyu.edu> <4302715C.528696C3@dessent.net> <430274CC.FA870D37@dessent.net>
Content-Type: multipart/mixed;
 boundary="------------B6FB5CAD644B8675A355FDBA"
X-SW-Source: 2005-q3/txt/msg00078.txt.bz2

This is a multi-part message in MIME format.
--------------B6FB5CAD644B8675A355FDBA
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 353

Brian Dessent wrote:

> Now that I re-read what you said I think I misunderstood.  You're right,
> it could have simply done

Here is a patch that fixes both issues.

Brian

2005-08-16  Brian Dessent  <brian@dessent.net>

	* cygcheck.cc (dump_sysinfo_services): Properly null-terminate 'buf'.
	Avoid extraneous cygrunsrv invocation if 'verbose' is true.
--------------B6FB5CAD644B8675A355FDBA
Content-Type: text/plain; charset=us-ascii;
 name="cygcheck.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygcheck.patch"
Content-length: 3275

Index: cygcheck.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/cygcheck.cc,v
retrieving revision 1.76
diff -u -p -r1.76 cygcheck.cc
--- cygcheck.cc	19 Jul 2005 21:00:34 -0000	1.76
+++ cygcheck.cc	17 Aug 2005 00:14:33 -0000
@@ -888,6 +888,7 @@ dump_sysinfo_services ()
   char buf[1024];
   char buf2[1024];
   FILE *f;
+  bool no_services = false;
 
   if (givehelp)
     printf ("\nChecking for any Cygwin services... %s\n\n",
@@ -922,49 +923,60 @@ dump_sysinfo_services ()
     }
   fclose (f);
 
-  /* run cygrunsrv --list */
-  snprintf (buf, sizeof (buf), "%s --list", cygrunsrv);
+  /* For verbose mode, just run cygrunsrv --list --verbose and copy output
+     verbatim; otherwise run cygrunsrv --list and then cygrunsrv --query for
+     each service.  */
+  snprintf (buf, sizeof (buf), (verbose ? "%s --list --verbose" : "%s --list"),
+	    cygrunsrv);
   if ((f = popen (buf, "rt")) == NULL)
     {
       printf ("Failed to execute '%s', skipping services check.\n", buf);
       return;
     }
-  size_t nchars = fread ((void *) buf, 1, sizeof (buf), f);
-  pclose (f);
 
-  /* were any services found?  */
-  if (nchars < 1)
+  if (verbose)
     {
-      puts ("No Cygwin services found.\n");
-      return;
+      /* copy output to stdout */
+      size_t nchars = 0;
+      while (!feof (f) && !ferror (f))
+	  nchars += fwrite ((void *) buf, 1,
+			    fread ((void *) buf, 1, sizeof (buf), f), stdout);
+
+      /* cygrunsrv outputs nothing if there are no cygwin services found */
+      if (nchars < 1)
+	no_services = true;
+      pclose (f);
     }
-
-  /* In verbose mode, just run 'cygrunsrv --list --verbose' and copy the
-     entire output.  Otherwise run 'cygrunsrv --query' for each service.  */
-  for (char *srv = strtok (buf, "\n"); srv; srv = strtok (NULL, "\n"))
+  else
     {
-      if (verbose)
-	snprintf (buf2, sizeof (buf2), "%s --list --verbose", cygrunsrv);
-      else
-	snprintf (buf2, sizeof (buf2), "%s --query %s", cygrunsrv, srv);
-      if ((f = popen (buf2, "rt")) == NULL)
-	{
-	  printf ("Failed to execute '%s', skipping services check.\n", buf2);
-	  return;
-	}
-
-      /* copy output to stdout */
-      do
-	{
-	  nchars = fread ((void *)buf2, 1, sizeof (buf2), f);
-	  fwrite ((void *)buf2, 1, nchars, stdout);
-	}
-      while (!feof (f) && !ferror (f));
+      /* read the output of --list, and then run --query for each service */
+      size_t nchars = fread ((void *) buf, 1, sizeof (buf) - 1, f);
+      buf[nchars] = 0;
       pclose (f);
 
-      if (verbose)
-	break;
+      if (nchars > 0)
+	for (char *srv = strtok (buf, "\n"); srv; srv = strtok (NULL, "\n"))
+	  {
+	    snprintf (buf2, sizeof (buf2), "%s --query %s", cygrunsrv, srv);
+	    if ((f = popen (buf2, "rt")) == NULL)
+	      {
+		printf ("Failed to execute '%s', skipping services check.\n", buf2);
+		return;
+	      }
+
+	    /* copy output to stdout */
+	    while (!feof (f) && !ferror (f))
+	      fwrite ((void *) buf2, 1,
+		      fread ((void *) buf2, 1, sizeof (buf2), f), stdout);
+	    pclose (f);
+	  }
+      else
+	no_services = true;
     }
+
+  /* inform the user if nothing found */
+  if (no_services)
+    puts ("No Cygwin services found.\n");
 }
 
 static void

--------------B6FB5CAD644B8675A355FDBA--

