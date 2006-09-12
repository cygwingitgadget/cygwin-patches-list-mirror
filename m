Return-Path: <cygwin-patches-return-5976-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13519 invoked by alias); 12 Sep 2006 12:05:16 -0000
Received: (qmail 13507 invoked by uid 22791); 12 Sep 2006 12:05:15 -0000
X-Spam-Check-By: sourceware.org
Received: from rwcrmhc15.comcast.net (HELO rwcrmhc15.comcast.net) (204.127.192.85)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 12 Sep 2006 12:05:08 +0000
Received: from rmailcenter99.comcast.net ([204.127.197.199])           by comcast.net (rwcrmhc15) with SMTP           id <20060912120507m1500nrk28e>; Tue, 12 Sep 2006 12:05:07 +0000
Received: from [24.10.241.225] by rmailcenter99.comcast.net; 	Tue, 12 Sep 2006 12:05:06 +0000
From: ericblake@comcast.net (Eric Blake)
To: cygwin-patches@cygwin.com
Subject: Re: [ANNOUNCEMENT] Updated [experimental]: bash-3.1-7
Date: Tue, 12 Sep 2006 12:05:00 -0000
Message-Id: <091220061205.16953.4506A2720005FBDD0000423922135285730A050E040D0C079D0A@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Apr 11 2006)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="NextPart_Webmail_9m3u9jl4l_16953_1158062706_0"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00071.txt.bz2


--NextPart_Webmail_9m3u9jl4l_16953_1158062706_0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Content-length: 1016

> > That is being set by cygcheck, just before invoking external programs.  It 
> > probably had something to do with forcing external programs to not rearrange 
> > option arguments (for example, "ls foo --all" treats --all as an option, 
> > but "POSIXLY_CORRECT=1 ls foo --all" treats --all as a filename).  But I think 
> > it is possible to get along without doing it (repeating the example, "ls -- 
> > foo --all" treats --all as a filename), and I personally think that cygcheck 
> > should be patched to QUIT setting POSIXLY_CORRECT, so that we can tell the 
> > masochists apart from normal users.
> 
> Ah, ok, so seeing it in cygcheck is a false positive. Didn't think that 
> cygcheck would tinker with my environment (maybe it should know it is 
> doing so and preserve the invocation value and print that?), so I didn't 
> think to actually 'echo $POSIXLY_CORRECT'. :-)
> 

2006-09-11  Eric Blake  <ebb9@byu.net>

	* cygcheck.cc (main): Restore POSIXLY_CORRECT before displaying
	user's environment.




--NextPart_Webmail_9m3u9jl4l_16953_1158062706_0
Content-Type: application/octet-stream; name="cygwin.patch3"
Content-Transfer-Encoding: 7bit
Content-length: 975

Index: utils/cygcheck.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/cygcheck.cc,v
retrieving revision 1.90
diff -u -p -b -r1.90 cygcheck.cc
--- utils/cygcheck.cc	8 Feb 2006 14:19:40 -0000	1.90
+++ utils/cygcheck.cc	12 Sep 2006 12:04:40 -0000
@@ -1835,6 +1835,10 @@ main (int argc, char **argv)
   bool ok = true;
   load_cygwin (argc, argv);
 
+  /* Need POSIX sorting while parsing args, but don't forget the
+     user's original environment.  */
+  char *posixly = getenv ("POSIXLY_CORRECT");
+  if (posixly == NULL)
   (void) putenv("POSIXLY_CORRECT=1");
   while ((i = getopt_long (argc, argv, opts, longopts, NULL)) != EOF)
     switch (i)
@@ -1877,6 +1881,8 @@ main (int argc, char **argv)
        /*NOTREACHED*/}
   argc -= optind;
   argv += optind;
+  if (posixly == NULL)
+    putenv ("POSIXLY_CORRECT=");
 
   if (argc == 0 && !sysinfo && !keycheck && !check_setup && !list_package)
     if (givehelp)

--NextPart_Webmail_9m3u9jl4l_16953_1158062706_0--
