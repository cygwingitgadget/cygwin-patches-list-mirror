Return-Path: <cygwin-patches-return-4784-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23989 invoked by alias); 28 May 2004 17:58:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23977 invoked from network); 28 May 2004 17:58:28 -0000
Message-ID: <40B77DBA.D147A597@phumblet.no-ip.org>
Date: Fri, 28 May 2004 17:58:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: Pierre.Humblet@ieee.org
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [Patch] fallout of path conversion work?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q2/txt/msg00136.txt.bz2

Here it is.

FYI, in 1.5.9 the test changed below was

if ((!path.has_symlinks () && strpbrk (dir, ":\\") == NULL
	    && pcheck_case == PCHECK_RELAXED)
   posix_cwd = normalized_posix_path (dir)


I think it's correct this time, but more testing never hurts.

/>mount
d:\cygwin on / type system (binmode)
d: on /test type system (textmode)
<snip>
/> cygpath -M .
.: binary
/> cd test
/test
/test> cd cygwin
/test/cygwin
/test/cygwin> cygpath -M .
.: text
/test/cygwin> ls -l ttt sss
lrwxrwxrwx    1 PHumblet Clearuse        9 May 28 12:10 sss -> d:/cygwin/
lrwxrwxrwx    1 PHumblet Clearuse       12 May 28 12:09 ttt -> /test/cygwin/
/test/cygwin> cd ttt
/test/cygwin/ttt
/test/cygwin/ttt> cygpath -M .
.: text
/test/cygwin/ttt> cd sss
/test/cygwin/ttt/sss
/test/cygwin/ttt/sss> cygpath -M .
.: binary
/test/cygwin/ttt/sss> /bin/pwd
/

A strange thing:

/test/cygwin/ttt/sss> cd /test/cygwin/ttt
/test/cygwin/ttt> /bin/pwd
/test/cygwin
/test/cygwin/ttt> cd ..
/test/cygwin> /bin/pwd
/test/cygwin             <= I was expecting /test
/test/cygwin> sh
\e[34m\]\w\[\e[0m\]> PS1=': ' 
: cd /test/cygwin/ttt
: /bin/pwd
/test/cygwin
: cd ..
: /bin/pwd
/test                   <= Result above is due to bash


"find /" still works OK.

Pierre

2004-05-28 Pierre Humblet  <Pierre.Humblet@ieee.org>

	* path.cc (chdir): Always use the normalized_path as posix_cwd,
	except if it starts with a drive.


Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.312
diff -u -p -b -r1.312 path.cc
--- path.cc     15 May 2004 15:55:43 -0000      1.312
+++ path.cc     28 May 2004 16:16:54 -0000
@@ -3325,7 +3325,7 @@ chdir (const char *in_dir)
         The posix_cwd is just path.normalized_path.
         In other cases we let cwd.set obtain the Posix path through
         the mount table. */
-      if (!path.has_symlinks () && !isabspath (in_dir))
+      if (!isdrive(path.normalized_path))
        posix_cwd = path.normalized_path;
       res = 0;
       doit = true;
