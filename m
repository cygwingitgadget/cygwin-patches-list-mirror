Return-Path: <cygwin-patches-return-2958-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 29668 invoked by alias); 13 Sep 2002 03:49:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29654 invoked from network); 13 Sep 2002 03:49:50 -0000
Date: Thu, 12 Sep 2002 20:49:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: print_version missing newlines (for Joshua?)
Message-ID: <20020913035034.GB3882@redhat.com>
Mail-Followup-To: cygwin-patches@cygwin.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-SW-Source: 2002-q3/txt/msg00406.txt.bz2

Joshua,
The lack of newline seems to be a generic problem with at least a couple
of print_versions.

You can use your new checkin powers to fix this, if you want.
With a ChangeLog, of course.

I'll defer to your judgement on the rest of this patch, too.

cgf

----- Forwarded message from Igor Pechtchanski <pechtcha@cs.nyu.edu> -----

From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
To: cygwin-patches@cygwin.com
Subject: `cygpath --version` missing a newline
Date: Thu, 12 Sep 2002 23:39:05 -0400 (EDT)

Hi,
`cygpath --version` is missing a trailing newline.  I'm attaching a patch.
This probably doesn't merit a ChangeLog entry, but I'm providing one
anyway, feel free to disregard it.  I also took the opportunity to factor
out the short options array into a global variable.  I can split this into
two separate patches, if necessary.
	Igor

2002-09-12  Igor Pechtchanski <pechtcha@cs.nyu.edu>
	* cygpath.cc (options) New global variable.
	(main) Make short options global for easier change.
	(print_version) Add a missing newline.

-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

It took the computational power of three Commodore 64s to fly to the moon.
It takes a 486 to run Windows 95.  Something is wrong here. -- SC sig file

Index: cygpath.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/cygpath.cc,v
retrieving revision 1.22
diff -u -p -r1.22 cygpath.cc
--- cygpath.cc	23 Aug 2002 15:46:00 -0000	1.22
+++ cygpath.cc	13 Sep 2002 03:36:19 -0000
@@ -57,6 +57,8 @@ static struct option long_options[] = {
   {0, no_argument, 0, 0}
 };
 
+static char options[] = "ac:df:hilmopst:uvwADHPSW";
+
 static void
 usage (FILE * stream, int status)
 {
@@ -534,7 +536,8 @@ print_version ()
 cygpath (cygwin) %.*s\n\
 Path Conversion Utility\n\
 Copyright 1998, 1999, 2000, 2001, 2002 Red Hat, Inc.\n\
-Compiled on %s", len, v, __DATE__);
+Compiled on %s\n\
+", len, v, __DATE__);
 }
 
 int
@@ -562,7 +565,7 @@ main (int argc, char **argv)
   options_from_file_flag = 0;
   allusers_flag = 0;
   output_flag = 0;
-  while ((c = getopt_long (argc, argv, (char *) "ac:df:hilmopst:uvwADHPSW",
+  while ((c = getopt_long (argc, argv, options,
 			   long_options, (int *) NULL)) != EOF)
     {
       switch (c)


----- End forwarded message -----
