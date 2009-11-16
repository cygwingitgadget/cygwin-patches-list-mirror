Return-Path: <cygwin-patches-return-6841-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20854 invoked by alias); 16 Nov 2009 16:09:29 -0000
Received: (qmail 20841 invoked by uid 22791); 16 Nov 2009 16:09:28 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-42-77.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.42.77)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 16 Nov 2009 16:08:39 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 9ACE13B0002 	for <cygwin-patches@cygwin.com>; Mon, 16 Nov 2009 11:08:29 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 963642B352; Mon, 16 Nov 2009 11:08:29 -0500 (EST)
Date: Mon, 16 Nov 2009 16:09:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: fix setenv
Message-ID: <20091116160829.GB20652@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4B015A3F.9020809@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B015A3F.9020809@byu.net>
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
X-SW-Source: 2009-q4/txt/msg00172.txt.bz2

On Mon, Nov 16, 2009 at 06:57:19AM -0700, Eric Blake wrote:
>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>I noticed that cygwin setenv differs from Linux and from POSIX
>requirements.  STC:
>
>#include <stdlib.h>
>#include <errno.h>
>#include <string.h>
>#include <assert.h>
>int
>main (void)
>{
>  /* Test overwriting.  */
>  assert (setenv ("a", "=", -1) == 0);
>  assert (setenv ("a", "2", 0) == 0);
>  assert (strcmp (getenv ("a"), "=") == 0); // fails here
>
>  /* Required to fail with EINVAL.  */
>  errno = 0;
>  assert (setenv ("", "", 1) == -1); // and here
>  assert (errno == EINVAL);
>  errno = 0;
>  assert (setenv ("a=b", "", 0) == -1); // and here
>  assert (errno == EINVAL);
>  errno = 0;
>  assert (setenv (NULL, "", 0) == -1);
>  assert (errno == EINVAL); // and here
>  return 0;
>}
>
>
>2009-11-16  Eric Blake  <ebb9@byu.net>
>
>	* environ.cc (setenv): Detect invalid argument.
>	(unsetenv): Distinguish EFAULT from EINVAL.
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
>iEYEARECAAYFAksBWj4ACgkQ84KuGfSFAYCwngCdG+FVRKgMjTzXnn0AKhRzPCh3
>OxsAn35wV0l/J8Q4AAKrAyqPvMmfyGQB
>=LaHp
>-----END PGP SIGNATURE-----

>diff --git a/winsup/cygwin/environ.cc b/winsup/cygwin/environ.cc
>index bc11303..4935bc8 100644
>--- a/winsup/cygwin/environ.cc
>+++ b/winsup/cygwin/environ.cc
>@@ -413,10 +413,11 @@ setenv (const char *name, const char *value, int overwrite)
>   myfault efault;
>   if (efault.faulted (EFAULT))
>     return -1;
>-  if (!*name)
>-    return 0;
>-  if (*value == '=')
>-    value++;
>+  if (!name || !*name || strchr (name, '='))
>+    {
>+      set_errno (EINVAL);
>+      return -1;
>+    }
>   return _addenv (name, value, !!overwrite);
> }
>
>@@ -427,7 +428,9 @@ unsetenv (const char *name)
>   register char **e;
>   int offset;
>   myfault efault;
>-  if (efault.faulted () || *name == '\0' || strchr (name, '='))
>+  if (efault.faulted (EFAULT))
>+    return -1;
>+  if (!name || *name == '\0' || strchr (name, '='))
>     {
>       set_errno (EINVAL);
>       return -1;


Looks ok.  Please check in.

Thanks.

cgf
