Return-Path: <cygwin-patches-return-6840-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31787 invoked by alias); 16 Nov 2009 13:58:39 -0000
Received: (qmail 31776 invoked by uid 22791); 16 Nov 2009 13:58:38 -0000
X-SWARE-Spam-Status: No, hits=-2.0 required=5.0 	tests=AWL,BAYES_00,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta03.emeryville.ca.mail.comcast.net (HELO QMTA03.emeryville.ca.mail.comcast.net) (76.96.30.32)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 16 Nov 2009 13:57:47 +0000
Received: from OMTA16.emeryville.ca.mail.comcast.net ([76.96.30.72]) 	by QMTA03.emeryville.ca.mail.comcast.net with comcast 	id 5pi41d0051ZMdJ4A3pxnQ6; Mon, 16 Nov 2009 13:57:47 +0000
Received: from [192.168.0.104] ([24.10.247.15]) 	by OMTA16.emeryville.ca.mail.comcast.net with comcast 	id 5q721d0010Lg2Gw8cq7MnP; Mon, 16 Nov 2009 14:07:28 +0000
Message-ID: <4B015A3F.9020809@byu.net>
Date: Mon, 16 Nov 2009 13:58:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: fix setenv
Content-Type: multipart/mixed;  boundary="------------090508080706040908020400"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00171.txt.bz2

This is a multi-part message in MIME format.
--------------090508080706040908020400
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 1271

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I noticed that cygwin setenv differs from Linux and from POSIX
requirements.  STC:

#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <assert.h>
int
main (void)
{
  /* Test overwriting.  */
  assert (setenv ("a", "=", -1) == 0);
  assert (setenv ("a", "2", 0) == 0);
  assert (strcmp (getenv ("a"), "=") == 0); // fails here

  /* Required to fail with EINVAL.  */
  errno = 0;
  assert (setenv ("", "", 1) == -1); // and here
  assert (errno == EINVAL);
  errno = 0;
  assert (setenv ("a=b", "", 0) == -1); // and here
  assert (errno == EINVAL);
  errno = 0;
  assert (setenv (NULL, "", 0) == -1);
  assert (errno == EINVAL); // and here
  return 0;
}


2009-11-16  Eric Blake  <ebb9@byu.net>

	* environ.cc (setenv): Detect invalid argument.
	(unsetenv): Distinguish EFAULT from EINVAL.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAksBWj4ACgkQ84KuGfSFAYCwngCdG+FVRKgMjTzXnn0AKhRzPCh3
OxsAn35wV0l/J8Q4AAKrAyqPvMmfyGQB
=LaHp
-----END PGP SIGNATURE-----

--------------090508080706040908020400
Content-Type: text/plain;
 name="cygwin.patch32"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin.patch32"
Content-length: 849

diff --git a/winsup/cygwin/environ.cc b/winsup/cygwin/environ.cc
index bc11303..4935bc8 100644
--- a/winsup/cygwin/environ.cc
+++ b/winsup/cygwin/environ.cc
@@ -413,10 +413,11 @@ setenv (const char *name, const char *value, int overwrite)
   myfault efault;
   if (efault.faulted (EFAULT))
     return -1;
-  if (!*name)
-    return 0;
-  if (*value == '=')
-    value++;
+  if (!name || !*name || strchr (name, '='))
+    {
+      set_errno (EINVAL);
+      return -1;
+    }
   return _addenv (name, value, !!overwrite);
 }

@@ -427,7 +428,9 @@ unsetenv (const char *name)
   register char **e;
   int offset;
   myfault efault;
-  if (efault.faulted () || *name == '\0' || strchr (name, '='))
+  if (efault.faulted (EFAULT))
+    return -1;
+  if (!name || *name == '\0' || strchr (name, '='))
     {
       set_errno (EINVAL);
       return -1;

--------------090508080706040908020400--
