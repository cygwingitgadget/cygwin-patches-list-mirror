Return-Path: <cygwin-patches-return-4097-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7586 invoked by alias); 16 Aug 2003 17:33:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7577 invoked from network); 16 Aug 2003 17:33:23 -0000
From: David Rothenberger <daveroth@acm.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1ZVV00o4jt"
Content-Transfer-Encoding: 7bit
Message-ID: <16190.27360.563000.784032@gargle.gargle.HOWL>
Date: Sat, 16 Aug 2003 17:33:00 -0000
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Package content search and listing functionality for cygcheck
In-Reply-To: <Pine.GSO.4.44.0308160842240.15497-100000@slinky.cs.nyu.edu>
References: <16189.45520.758000.679252@gargle.gargle.HOWL>
	<Pine.GSO.4.44.0308160842240.15497-100000@slinky.cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
X-SW-Source: 2003-q3/txt/msg00113.txt.bz2


--1ZVV00o4jt
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit
Content-length: 1261

Igor Pechtchanski writes:
 > On Fri, 15 Aug 2003, David Rothenberger wrote:
 > 
 > > Here's another small patch for "cygcheck -c" that strips leading ./
 > > and / from filenames in the package lists.
 > >
 > > I have Joshua's packages for building cygwin-doc installed, and the
 > > entries in those packages' lists start with "./", which breaks the
 > > postinstall check, causing them to show up as bad.
 > >
 > > I know these are non-standard packages, but it's such a small little
 > > fix to support them and I would really like my "cygcheck -c" output
 > > to be clean.  This gets it closer; it still complains about empty
 > > packages like diff, but I don't see an easy way to solve that.
 > >
 > > This patch includes all your previous changes.
 > >
 > 
 > Dave,
 > 
 > Oops, Corinna just applied my previous patch.  I guess you'll have to
 > re-generate this one against the CVS HEAD...  Sorry.
 > 	Igor

No problem.  Here it is.  I wasn't sure whether to add to the
existing ChangeLog entry or make a new one.  Here's a new one.

Dave

======================================================================
2003-08-16  David Rothenberger  <daveroth@acm.org>

	* dump_setup.cc (check_package_files): Strip leading / and ./ from
	package file names.


--1ZVV00o4jt
Content-Type: text/plain
Content-Disposition: attachment;
	filename="cygcheck-nonstd-packages.patch"
Content-Transfer-Encoding: 7bit
Content-length: 691

Index: dump_setup.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/dump_setup.cc,v
retrieving revision 1.11
diff -u -p -r1.11 dump_setup.cc
--- dump_setup.cc	16 Aug 2003 09:09:09 -0000	1.11
+++ dump_setup.cc	16 Aug 2003 17:28:53 -0000
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

--1ZVV00o4jt--

