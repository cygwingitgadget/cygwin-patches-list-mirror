Return-Path: <cygwin-patches-return-5228-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13684 invoked by alias); 17 Dec 2004 03:09:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13662 invoked from network); 17 Dec 2004 03:09:51 -0000
Received: from unknown (HELO phumblet.no-ip.org) (68.163.186.67)
  by sourceware.org with SMTP; 17 Dec 2004 03:09:51 -0000
Received: from [192.168.1.156] (helo=hpn5170)
	by phumblet.no-ip.org with smtp (Exim 4.43)
	id I8UJLJ-001S0D-6Z
	for cygwin-patches@cygwin.com; Thu, 16 Dec 2004 22:12:55 -0500
Message-Id: <3.0.5.32.20041216220441.0082a400@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Fri, 17 Dec 2004 03:09:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: Patch to allow trailing dots on managed mounts
In-Reply-To: <20041216160607.GH23488@trixie.casa.cgf.cx>
References: <20041216160322.GC16474@cygbert.vinschen.de>
 <41C1A1F4.CD3CC833@phumblet.no-ip.org>
 <20041216150040.GA23488@trixie.casa.cgf.cx>
 <20041216155339.GA16474@cygbert.vinschen.de>
 <20041216155707.GG23488@trixie.casa.cgf.cx>
 <20041216160322.GC16474@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q4/txt/msg00229.txt.bz2

At 11:06 AM 12/16/2004 -0500, Christopher Faylor wrote:
>On Thu, Dec 16, 2004 at 05:03:22PM +0100, Corinna Vinschen wrote:
>>On Dec 16 10:57, Christopher Faylor wrote:
>>> On Thu, Dec 16, 2004 at 04:53:39PM +0100, Corinna Vinschen wrote:
>>> >Since the mount code is called from path_conv anyway, wouldn't it be
>>> >better to pass the information "managed mount or not" up to path_conv?
>>> 
>>> How about just doing the pathname munging in `conv_to_win32_path' if/when
>>> it's needed?
>>
>>Erm... I'm not quite sure, but didn't the "remove trailing dots and spaces"
>>code start there and has been moved to path_conv by Pierre to circumvent
>>some problem?  I recall only very vaguely right now.
>
>One problem that it would circumvent is that currently, if you do this:
>
>ls /bin......................................
>
>You'll get a listing of the bin directory.  If you move the code to
>conv_to_win32_path that may not be as easy to get right.

The initial trailing dots and space test was put in normalize_posix path,
not conv_to_win32_path. That was done to fix a side effect of
NtCreateFile, without considering all the many issues.

Putting it in conv_to_win32_path will forbid files ending in .lnk
or .exe but that are called without these suffixes. 
This should not happen:
~: ln -s /etc 'abc . .'
~: ls abc*
ls: abc . .: No such file or directory
~: rm 'abc . ..lnk'
rm: remove `abc . ..lnk'? y

It's also called during each iteration of the check() loop, which is
unnecessary.

Putting it in mount_item::build_win32 (as Mark as just done) suffers
from the same problems, and misses a number of cases where it's needed.

The attached patch puts the test at the end of check(), and only if the
file doesn't start with //./ 
I can't test for the moment due to the state of my sandbox.

I believe that the tests for .... in normalize_{posix,win32}_path are now
irrelevant, but I'd like Corinna to confirm (she introduced the test
on 2003-10-25).
Due to those tests, suffixes consisting entirely of dots are still 
disallowed.

Also, for my info, what is the unc\ in
       !strncasematch (this->path + 4, "unc\\", 4)))
around line 868? I have never seen that documented.

Pierre


	* path.cc (path_conv::check): Check the output Win32 path for trailing
	spaces and dots, not the input path.



Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.326
diff -u -p -r1.326 path.cc
--- path.cc     3 Dec 2004 02:00:37 -0000       1.326
+++ path.cc     17 Dec 2004 02:58:57 -0000
@@ -546,25 +546,12 @@ path_conv::check (const char *src, unsig
       /* Detect if the user was looking for a directory.  We have to strip
the
         trailing slash initially while trying to add extensions but take it
         into account during processing */
-      if (tail > path_copy + 1)
+      if (tail > path_copy + 1 && isslash (tail[-1]))
        {
-         if (isslash (tail[-1]))
-           {
-              need_directory = 1;
-              tail--;
-           }
-         /* Remove trailing dots and spaces which are ignored by Win32
functions but
-            not by native NT functions. */
-         while (tail[-1] == '.' || tail[-1] == ' ')
-           tail--;
-         if (tail > path_copy + 1 && isslash (tail[-1]))
-           {
-             error = ENOENT;
-             return;
-           }
+          need_directory = 1;
+          *--tail = '\0';
        }
       path_end = tail;
-      *tail = '\0';
 
       /* Scan path_copy from right to left looking either for a symlink
         or an actual existing file.  If an existing file is found, just
@@ -835,6 +822,18 @@ out:
 
   if (dev.devn == FH_FS)
     {
+      if (strncmp (path, "\\\\.\\", 4))
+        {
+          /* Windows ignores trailing dots and spaces */
+          char *tail = strchr (path, '\0');
+          while (tail[-1] == ' ' || tail[-1] == '.')
+            tail[-1] = '\0';
+          if (tail[-1] == '\\')
+            {  
+              error = ENOENT;
+              return;
+            }
+        } 
       if (fs.update (path))
        {
          debug_printf ("this->path(%s), has_acls(%d)", path, fs.has_acls ());
