Return-Path: <cygwin-patches-return-4094-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9354 invoked by alias); 16 Aug 2003 04:23:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9344 invoked from network); 16 Aug 2003 04:23:46 -0000
From: David Rothenberger <daveroth@acm.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6kikIaGwxp"
Content-Transfer-Encoding: 7bit
Message-ID: <16189.45520.758000.679252@gargle.gargle.HOWL>
Date: Sat, 16 Aug 2003 04:23:00 -0000
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Package content search and listing functionality for
 cygcheck
In-Reply-To: <Pine.GSO.4.44.0308152358290.15497-100000@slinky.cs.nyu.edu>
References: <3F3DA55A.1070703@acm.org>
	<Pine.GSO.4.44.0308152358290.15497-100000@slinky.cs.nyu.edu>
Reply-To: daveroth@acm.org
X-SW-Source: 2003-q3/txt/msg00110.txt.bz2


--6kikIaGwxp
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit
Content-length: 2078

Igor Pechtchanski writes:
 > On Fri, 15 Aug 2003, David Rothenberger wrote:
 > 
 > > I notice that package_list() prints a message in this case with the -v
 > > switch, but package_find() does not.  My personal pref. is for the
 > > message, but I'll leave it to you to decide.
 > >
 > > Dave
 > 
 > Dave,
 > 
 > Actually, there's a reason for that (and, in fact, it used to be the way
 > you described, and I changed it).  If package_list() looks at a package,
 > the contents of that package were requested on the command line, and thus,
 > if the list file is not found, an error message makes sense.  On the other
 > hand, package_find() looks at *all* the packages, so if the list for one
 > of them is missing (which could happen if the package is empty, for
 > example), package_find() will (should, IMO) simply ignore it.
 > 	Igor

Igor,

Yeah, that makes perfect sense, and I would have seen it was
intentional if I had looked closely at the patch.  Sorry for the
false alarm.

Here's another small patch for "cygcheck -c" that strips leading ./
and / from filenames in the package lists.

I have Joshua's packages for building cygwin-doc installed, and the
entries in those packages' lists start with "./", which breaks the
postinstall check, causing them to show up as bad.

I know these are non-standard packages, but it's such a small little
fix to support them and I would really like my "cygcheck -c" output
to be clean.  This gets it closer; it still complains about empty
packages like diff, but I don't see an easy way to solve that.

This patch includes all your previous changes.

Dave
======================================================================
2003-08-15  David Rothenberger  <daveroth@acm.org>

	* dump_setup.cc (package_find): Don't stop searching on missing
	file list.
	(package_list): Ditto.
	(check_package_files): Strip leading ./ and / from package
	contents. 

2003-08-15  Igor Pechtchanski  <pechtcha@cs.nyu.edu>

	* dump_setup.cc: (package_list): Make output terse unless
	verbose requested.  Fix formatting.
	(package_find): Ditto.


--6kikIaGwxp
Content-Type: text/plain
Content-Disposition: attachment;
	filename="cygcheck-list-verbose.patch"
Content-Transfer-Encoding: 7bit
Content-length: 2289

Index: dump_setup.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/dump_setup.cc,v
retrieving revision 1.10
diff -u -p -r1.10 dump_setup.cc
--- dump_setup.cc	15 Aug 2003 20:26:11 -0000	1.10
+++ dump_setup.cc	16 Aug 2003 04:21:49 -0000
@@ -276,6 +276,12 @@ check_package_files (int verbose, char *
   while (fgets (buf, MAX_PATH, fp))
     {
       char *filename = strtok(buf, "\n");
+
+      if (*filename == '/')
+        ++filename;
+      else if (!strncmp (filename, "./", 2))
+        filename += 2;
+
       if (filename[strlen (filename) - 1] == '/')
         {
           if (!directory_exists (verbose, filename, package))
@@ -411,21 +417,22 @@ package_list (int verbose, char **argv)
     {
       FILE *fp = open_package_list (packages[i].name);
       if (!fp)
-      {
-	if (verbose)
-	  printf ("Can't open file list /etc/setup/%s.lst.gz for package %s\n",
-	      packages[i].name, packages[i].name);
-	return;
-      }
+	{
+	  if (verbose)
+	    printf ("Can't open file list /etc/setup/%s.lst.gz for package %s\n",
+		packages[i].name, packages[i].name);
+	  continue;
+	}
 
-      printf ("Package: %s-%s\n", packages[i].name, packages[i].ver);
+      if (verbose)
+	printf ("Package: %s-%s\n", packages[i].name, packages[i].ver);
 
       char buf[MAX_PATH + 1];
       while (fgets (buf, MAX_PATH, fp))
 	{
 	  char *lastchar = strchr(buf, '\n');
 	  if (lastchar[-1] != '/')
-	    printf ("    /%s", buf);
+	    printf ("%s/%s", (verbose?"    ":""), buf);
 	}
 
       fclose (fp);
@@ -450,12 +457,7 @@ package_find (int verbose, char **argv)
     {
       FILE *fp = open_package_list (packages[i].name);
       if (!fp)
-      {
-	if (verbose)
-	  printf ("Can't open file list /etc/setup/%s.lst.gz for package %s\n",
-	      packages[i].name, packages[i].name);
-	return;
-      }
+	continue;
 
       char buf[MAX_PATH + 2];
       buf[0] = '/';
@@ -479,7 +481,11 @@ package_find (int verbose, char **argv)
 	      if (!a && is_alias)
 		a = match_argv (argv, filename + 4);
 	      if (a > 0)
-		printf ("%s-%s\n", packages[i].name, packages[i].ver);
+		{
+		  if (verbose)
+		    printf ("%s: found in package ", filename);
+		  printf ("%s-%s\n", packages[i].name, packages[i].ver);
+		}
 	    }
 	}
 

--6kikIaGwxp--

