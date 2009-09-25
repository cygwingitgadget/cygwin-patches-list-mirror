Return-Path: <cygwin-patches-return-6646-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26356 invoked by alias); 25 Sep 2009 15:11:35 -0000
Received: (qmail 26131 invoked by uid 22791); 25 Sep 2009 15:11:30 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-98-110-183-151.bstnma.fios.verizon.net (HELO cgf.cx) (98.110.183.151)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 25 Sep 2009 15:11:24 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id B490B13C0C4 	for <cygwin-patches@cygwin.com>; Fri, 25 Sep 2009 11:11:14 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 882C22B352; Fri, 25 Sep 2009 11:11:14 -0400 (EDT)
Date: Fri, 25 Sep 2009 15:11:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [1.7] rename/renameat error
Message-ID: <20090925151114.GA23857@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20090907192046.GA12492@calimero.vinschen.de>  <loom.20090909T005422-847@post.gmane.org>  <loom.20090909T183010-83@post.gmane.org>  <loom.20090922T225033-801@post.gmane.org>  <4ABA1B92.9080406@byu.net>  <20090923133015.GA16976@calimero.vinschen.de>  <20090923140905.GA2527@ednor.casa.cgf.cx>  <20090923160846.GA18954@calimero.vinschen.de>  <20090923164127.GB3172@ednor.casa.cgf.cx>  <4ABC39A1.1060702@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ABC39A1.1060702@byu.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q3/txt/msg00100.txt.bz2

On Thu, Sep 24, 2009 at 09:31:45PM -0600, Eric Blake wrote:
>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>According to Christopher Faylor on 9/23/2009 10:41 AM:
>>> Also less risky would be to make changes locally in mkdir, link, and
>>> rename for now.
>
>Done - this patch narrows the scope of the changes to just the interfaces
>in question.  I've also tested that it made it through the coreutils
>testsuite without any regressions.
>
>> 
>> I'm not clear if this is a regression or not.  If it isn't a regression,
>> I'd opt for leaving it until 1.7.2.
>
>Now that I'm not touching path.cc, these are all much more self-contained,
>and make cygwin more consistent with Linux.  For example:
>
>touch a
>ln -s c b
>link a b/
>
>should fail because b/ is not an existing directory, but without this
>patch, it succeeds and creates the regular file c as a link to a.
>
>2009-09-24  Eric Blake  <ebb9@byu.net>
>
>	* syscalls.cc (link): Delete obsolete comment.  Reject directories
>	and missing source up front.
>	(rename): Use correct errno for trailing '.'.  Allow trailing
>	slash to newpath iff oldpath is directory.
>	* dir.cc (mkdir): Reject dangling symlink with trailing slash.
>	* fhandler_disk_file.cc (fhandler_disk_file::link): Reject
>	trailing slash.
>	* fhandler.cc (fhandler_base::link): Match Linux errno.
>
>- --
>Don't work too hard, make some time for fun as well!
>
>Eric Blake             ebb9@byu.net
>-----BEGIN PGP SIGNATURE-----
>Version: GnuPG v1.4.9 (Cygwin)
>Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
>Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/
>
>iEYEARECAAYFAkq8OaEACgkQ84KuGfSFAYAiLACghYLCFaIGmFR4AuzKAmBuQcg/
>kFoAoJcX+ufE6YUq7S1AeVRvHtyZ30wc
>=4otJ
>-----END PGP SIGNATURE-----

>diff --git a/winsup/cygwin/dir.cc b/winsup/cygwin/dir.cc
>index 2b9125f..b7c31e4 100644
>--- a/winsup/cygwin/dir.cc
>+++ b/winsup/cygwin/dir.cc
>@@ -1,6 +1,7 @@
> /* dir.cc: Posix directory-related routines
>
>-   Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2006, 2007 Red Hat, Inc.
>+   Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2006, 2007,
>+   2009 Red Hat, Inc.
>
> This file is part of Cygwin.
>
>@@ -21,6 +22,7 @@ details. */
> #include "dtable.h"
> #include "cygheap.h"
> #include "cygtls.h"
>+#include "tls_pbuf.h"
>
> extern "C" int
> dirfd (DIR *dir)
>@@ -273,11 +275,26 @@ mkdir (const char *dir, mode_t mode)
> {
>   int res = -1;
>   fhandler_base *fh = NULL;
>+  size_t dlen;
>+  char *newbuf;
>+  tmp_pathbuf tp;
>
>   myfault efault;
>   if (efault.faulted (EFAULT))
>     return -1;
>
>+  /* POSIX says mkdir("symlink-to-missing/") should create the
>+     directory "missing", but Linux rejects it with EEXIST.  Copy
>+     Linux behavior for now.  */
>+
>+  dlen = strlen (dir);
>+  if (isdirsep (dir[dlen - 1]))

Couldn't this index negatively if dir is zero length?

>+    {
>+      stpcpy (newbuf = tp.c_get (), dir);

Since stpcpy returns a pointer to the end of the buffer couldn't we use that
and do pointer arithmetic rather than index arithmetic?

>+      while (dlen > 0 && isdirsep (dir[dlen - 1]))
>+        newbuf[--dlen] = '\0';
>+      dir = newbuf;
>+    }
>   if (!(fh = build_fh_name (dir, NULL, PC_SYM_NOFOLLOW)))
>     goto done;   /* errno already set */;
>
>diff --git a/winsup/cygwin/fhandler.cc b/winsup/cygwin/fhandler.cc
>index b52d7c2..44311ca 100644
>--- a/winsup/cygwin/fhandler.cc
>+++ b/winsup/cygwin/fhandler.cc
>@@ -1541,7 +1541,7 @@ fhandler_base::ftruncate (_off64_t length, bool allow_truncate)
> int
> fhandler_base::link (const char *newpath)
> {
>-  set_errno (EINVAL);
>+  set_errno (EPERM);
>   return -1;
> }
>
>diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_disk_file.cc
>index 214be47..4c4b559 100644
>--- a/winsup/cygwin/fhandler_disk_file.cc
>+++ b/winsup/cygwin/fhandler_disk_file.cc
>@@ -1186,6 +1186,7 @@ fhandler_disk_file::ftruncate (_off64_t length, bool allow_truncate)
> int
> fhandler_disk_file::link (const char *newpath)
> {
>+  size_t nlen = strlen (newpath);
>   path_conv newpc (newpath, PC_SYM_NOFOLLOW | PC_POSIX, stat_suffixes);
>   if (newpc.error)
>     {
>@@ -1200,7 +1201,13 @@ fhandler_disk_file::link (const char *newpath)
>       return -1;
>     }
>
>-  char new_buf[strlen (newpath) + 5];
>+  if (isdirsep (newpath[nlen - 1]) || has_dot_last_component (newpath, false))

Same observation:  Couldn't newpath be zero length?

cgf
