Return-Path: <cygwin-patches-return-4718-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16016 invoked by alias); 6 May 2004 15:03:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15999 invoked from network); 6 May 2004 15:03:34 -0000
Message-ID: <409A53C5.2A512FCF@phumblet.no-ip.org>
Date: Thu, 06 May 2004 15:03:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: Pierre.Humblet@ieee.org
MIME-Version: 1.0
CC: cygwin-patches@cygwin.com
Subject: Re: [Patch]: chdir
References: <20040505002003.GA8846@coe.bosbc.com> <3.0.5.32.20040504200359.007fcec0@incoming.verizon.net> <20040505002003.GA8846@coe.bosbc.com> <3.0.5.32.20040505004236.007ff280@incoming.verizon.net> <20040505095134.GA6206@cygbert.vinschen.de> <3.0.5.32.20040505235853.00806100@incoming.verizon.net> <20040506094334.GV2201@cygbert.vinschen.de> <20040506123720.GB17511@cygbert.vinschen.de> <409A4505.7868167F@phumblet.no-ip.org>
Content-Type: multipart/mixed;
 boundary="------------399DAACFB7A37786BBB02E62"
X-SW-Source: 2004-q2/txt/msg00070.txt.bz2

This is a multi-part message in MIME format.
--------------399DAACFB7A37786BBB02E62
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 515


"Pierre A. Humblet" wrote:
> 
> Corinna Vinschen wrote:
> > Ooops:
> >
> >   $ cd /
> >   /: No such file or directory.
> 
> Oops, nothing to do with chdir. It's in the code that detects
> file components consisting entirely of dots or spaces.

And here is the corrected patch.

Pierre

2004-05-06  Pierre Humblet <pierre.humblet@ieee.org>

	* path.cc (path_conv::check): Strip trailing dots and spaces and returns
	error if the final component had only dots and spaces.
	(normalize_posix_path): Revert 2004-04-30.
--------------399DAACFB7A37786BBB02E62
Content-Type: text/plain; charset=us-ascii;
 name="path.cc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="path.cc.diff"
Content-length: 1544

Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.308
diff -u -p -r1.308 path.cc
--- path.cc	4 May 2004 15:14:48 -0000	1.308
+++ path.cc	6 May 2004 14:47:11 -0000
@@ -286,10 +286,6 @@ normalize_posix_path (const char *src, c
     }
 
 done:
-  /* Remove trailing dots and spaces which are ignored by Win32 functions but
-     not by native NT functions. */
-  while (dst[-1] == '.' || dst[-1] == ' ')
-    --dst;
   *dst = '\0';
   *tail = dst;
 
@@ -552,12 +548,25 @@ path_conv::check (const char *src, unsig
       /* Detect if the user was looking for a directory.  We have to strip the
 	 trailing slash initially while trying to add extensions but take it
 	 into account during processing */
-      if (tail > path_copy + 1 && isslash (*(tail - 1)))
+      if (tail > path_copy + 1)
 	{
-	  need_directory = 1;
-	  *--tail = '\0';
-	}
+          if (isslash (tail[-1]))
+            {
+	       need_directory = 1;
+	       tail--;
+	    }
+          /* Remove trailing dots and spaces which are ignored by Win32 functions but
+	     not by native NT functions. */
+          while (tail[-1] == '.' || tail[-1] == ' ') 
+	    tail--;
+          if (isslash (tail[-1]))
+            {
+	      error = ENOENT;
+              return;
+	    }
+        }
       path_end = tail;
+      *tail = '\0';
 
       /* Scan path_copy from right to left looking either for a symlink
 	 or an actual existing file.  If an existing file is found, just

--------------399DAACFB7A37786BBB02E62--
