Return-Path: <cygwin-patches-return-4789-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23320 invoked by alias); 30 May 2004 04:34:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23311 invoked from network); 30 May 2004 04:34:31 -0000
Date: Sun, 30 May 2004 04:34:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Make add_item smarter
Message-ID: <20040530043431.GA12896@coe.bosbc.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040530002148.0081b840@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040530002148.0081b840@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q2/txt/msg00141.txt.bz2

On Sun, May 30, 2004 at 12:21:48AM -0400, Pierre A. Humblet wrote:
>2004-05-30  Pierre Humblet <pierre.humblet@ieee.org>
>
>	* path.cc (mount_info::add_item): Make sure native path has drive 
>	or UNC form. Call normalize_xxx_path instead of [back]slashify.
>	Remove test for double slashes. Reorganize to always debug_print. 
>Index: path.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
>retrieving revision 1.313
>diff -u -p -b -r1.313 path.cc
>--- path.cc	28 May 2004 19:50:06 -0000	1.313
>+++ path.cc	30 May 2004 04:06:43 -0000
>@@ -2176,41 +2176,40 @@ mount_info::sort ()
> int
> mount_info::add_item (const char *native, const char *posix, unsigned mountflags, int reg_p)
> {
>+  char nativetmp[CYG_MAX_PATH];
>+  char posixtmp[CYG_MAX_PATH];
>+  char *tail;
>+  int err[2];

Why an array here?  It's not really being used as an array.

>   /* Something's wrong if either path is NULL or empty, or if it's
>      not a UNC or absolute path. */
>
>-  if ((native == NULL) || (*native == 0) ||
>-      (posix == NULL) || (*posix == 0) ||
>-      !isabspath (native) || !isabspath (posix) ||
>+  if (native == NULL || *native == 0 || !isabspath (native) ||

Do we need an "isabsdospath"?  Checking for isabspath and isdrive is
a little redundant although the compiler would probably optimize
nicely.

>+      !(is_unc_share (native) || isdrive (native)))
>+    err[0] = EINVAL;
>+  else
>+    err[0] = normalize_win32_path (native, nativetmp, &tail);
>+
>+  if (posix == NULL || *posix == 0 || !isabspath (posix) ||
>       is_unc_share (posix) || isdrive (posix))
>+    err[1] = EINVAL;
>+  else
>+    err[1] = normalize_posix_path (posix, posixtmp, &tail);
>+
>+  debug_printf ("%s[%s], %s[%s], %p",
>+                native, err[0]?"error":nativetmp, posix, err[1]?"error":posixtmp,
>+                mountflags);
>+
>+  if (err[0] || err[1])
>     {
>-      set_errno (EINVAL);
>+      set_errno (err[0]?:err[1]);
>       return -1;
>     }
>
>   /* Make sure both paths do not end in /. */
>-  char nativetmp[CYG_MAX_PATH];
>-  char posixtmp[CYG_MAX_PATH];
>-
>-  backslashify (native, nativetmp, 0);
>   nofinalslash (nativetmp, nativetmp);

    Do we still need the nofinalslash?

cgf
