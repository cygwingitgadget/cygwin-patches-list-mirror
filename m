Return-Path: <cygwin-patches-return-4706-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4782 invoked by alias); 5 May 2004 04:45:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4771 invoked from network); 5 May 2004 04:45:39 -0000
Message-Id: <3.0.5.32.20040505004236.007ff280@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Wed, 05 May 2004 04:45:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: chdir
In-Reply-To: <20040505002510.GB8846@coe.bosbc.com>
References: <20040505002003.GA8846@coe.bosbc.com>
 <3.0.5.32.20040504200359.007fcec0@incoming.verizon.net>
 <20040505002003.GA8846@coe.bosbc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q2/txt/msg00058.txt.bz2

At 08:25 PM 5/4/2004 -0400, Christopher Faylor wrote:
>On Tue, May 04, 2004 at 08:20:03PM -0400, Christopher Faylor wrote:
>>On Tue, May 04, 2004 at 08:03:59PM -0400, Pierre A. Humblet wrote:
>>>Here is a simple patch that simplifies chdir processing
>>>and avoids calling normalized_posix_path multiple times.
>>>
>>>If it doesn't break anything it will simplify removing
>>>trailing dots and spaces, as discussed earlier today.
>>
>>"If it doesn't break anything" does not leave me filled with confidence
>>that this patch is appropriate for application as we are anticipating
>>releasing 1.5.10.
>
>Another thing occurs to me -- maybe it would simplify things just to
>store a patch_conv structure on the cygheap rather than use a separate
>cwdstuff structure.  It would take up more space on the cygheap but I
>think it would probably be cleaner in general.

Maybe, but the simplicity isn't obvious to me. For example a path_conv
would have a win32 path and a normalized_path, but the normalized_path
could start with a drive. That's not what cwdstuff::posix currently
expects, because it might confuse Unix programs. 

The "If it doesn't break anything" doesn't mean it's likely to 
break. All my tests pass but some parts of the existing comment aren't
clear to me, which gives me an uneasy feeling.

The main questions are whether using the normalized_path below is valid
and why pcheck_case == PCHECK_RELAXED is needed.

-  else if ((!path.has_symlinks () && strpbrk (dir, ":\\") == NULL
-           && pcheck_case == PCHECK_RELAXED) || isvirtual_dev (devn))
-    cygheap->cwd.set (native_dir, dir);
+  else if (!isdrive (path.normalized_path) 
+           && pcheck_case == PCHECK_RELAXED)
+    cygheap->cwd.set (native_dir, path.normalized_path);
   else
     cygheap->cwd.set (native_dir, NULL);

If that works then the patch below reverts Corinna's tail stripping
patch while taking care of tail stripping for posix and win32 paths, 
with and without final /, and returning ENOENT for final components
consisting entirely of dots and spaces.
Something like that needed to release 1.5.10.

2004-05-05  Pierre Humblet <pierre.humblet@ieee.org>

	* path.cc (path_conv::check): Strip trailing dots and spaces and returns
	error if the final component had only dots and spaces.
	(normalize_posix_path): Revert 2004-04-30.

Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.308
diff -u -p -r1.308 path.cc
--- path.cc     4 May 2004 15:14:48 -0000       1.308
+++ path.cc     5 May 2004 04:41:56 -0000
@@ -286,10 +286,6 @@ normalize_posix_path (const char *src, c
     }
 
 done:
-  /* Remove trailing dots and spaces which are ignored by Win32 functions but
-     not by native NT functions. */
-  while (dst[-1] == '.' || dst[-1] == ' ')
-    --dst;
   *dst = '\0';
   *tail = dst;
 
@@ -555,9 +551,19 @@ path_conv::check (const char *src, unsig
       if (tail > path_copy + 1 && isslash (*(tail - 1)))
        {
          need_directory = 1;
-         *--tail = '\0';
+         tail--;
+       }
+      /* Remove trailing dots and spaces which are ignored by Win32
functions but
+        not by native NT functions. */
+      while (tail[-1] == '.' || tail[-1] == ' ') 
+       tail--;
+      if (tail[-1] == '/')
+        {
+         error = ENOENT;
+          return;
        }
       path_end = tail;
+      *tail = '\0';
 
       /* Scan path_copy from right to left looking either for a symlink
         or an actual existing file.  If an existing file is found, just
