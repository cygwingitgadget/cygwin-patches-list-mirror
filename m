Return-Path: <cygwin-patches-return-5381-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15553 invoked by alias); 26 Mar 2005 15:48:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15483 invoked from network); 26 Mar 2005 15:48:25 -0000
Received: from unknown (HELO sccrmhc11.comcast.net) (204.127.202.55)
  by sourceware.org with SMTP; 26 Mar 2005 15:48:25 -0000
Received: from [192.168.0.100] (c-24-10-254-137.client.comcast.net[24.10.254.137])
          by comcast.net (sccrmhc11) with ESMTP
          id <2005032615482401100lltbge>; Sat, 26 Mar 2005 15:48:24 +0000
Message-ID: <4245843E.10700@byu.net>
Date: Sat, 26 Mar 2005 15:48:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: exceeding PATH_MAX
Content-Type: multipart/mixed;
 boundary="------------050207080503090300000903"
X-SW-Source: 2005-q1/txt/msg00084.txt.bz2

This is a multi-part message in MIME format.
--------------050207080503090300000903
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 3446

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The attached program is a derivative of the configure-time test used in
coreutils to see if getcwd is broken.  Many systems support relative
pathnames whose absolute name is longer than PATH_MAX, and on some of
them, getcwd fails in that case.  But I understand that cygwin currently
treats PATH_MAX as the maximum length of the absolute Windows pathname
that corresponds to the POSIX name, whether relative or absolute, since
Windows 95 and the ASCII versions of Windows syscalls refuse to work on
path names longer than 260 bytes.  This means that even with relative
paths, it is impossible to creat() or mkdir() a path that would exceed the
name limitations of Windows.  Therefore, on cygwin, getcwd() currently
can't fail on a current working directory longer than PATH_MAX, since it
is trivially provable that since such a directory can't be created, it
can't be the current working directory; but the configure test was failing
to detect that.

The problem here is that the test program shows that mkdir is failing with
EINVAL (22); when looking at POSIX,
http://www.opengroup.org/onlinepubs/009695399/functions/mkdir.html, mkdir
is not documented as returning EINVAL, but is allowed to return
ENAMETOOLONG (91).  Likewise, many other functions are documented as
allowing ENAMETOOLONG when the pathname exceeds implementation
limitations.  Furthermore, if I replace mkdir/errno with
CreateDirectory/GetLastError, Windows is returning
ERROR_FILENAME_EXCED_RANGE, which is a good candidate for mapping cleanly
to ENAMETOOLONG.

On NT systems, and using the Unicode versions of Windows syscalls, Windows
supports up to 32k for pathnames, with component names up to 255 bytes, by
using the \\?\ prefix.  Cygwin could actually support the XSI-recommended
minimum PATH_MAX of 1024, rather than the POSIX-required minimum of 256,
and support it on the Posix name rather than the Windows name as is
currently done.  That would also let cygwin support relative pathnames
whose absolute name is greater than PATH_MAX, up to the 32k limit of the
absolute path name, as is done on many other systems.  The XSI-recommended
NAME_MAX of 255 is a bit problematic - on managed mounts, it is possible
for an 85-char POSIX name to occupy 255 Windows characters, but at least
that is still greater than the POSIX recommended minimum NAME_MAX of 14.
However, changing cygwin to support filenames greater than 260 on systems
that support it would be a big patch to cygwin, and I don't have an
assignment in place.

One other comment - limits.h defines PATH_MAX as 259 (#define PATH_MAX
(260 - 1 /*NUL*/)) instead of the Windows API MAX_PATH of 260.  But POSIX
states that PATH_MAX includes the trailing NUL, so there is no reason for
cygwin to short-change the length by a byte.

This patch fixes the smaller issues:

2005-03-26  Eric Blake  <ebb9@byu.net>

	* errno.cc (FILENAME_EXCED_RANGE): Map to ENAMETOOLONG.
	* include/limits.h (NAME_MAX): New define.
	(PATH_MAX): POSIX allows PATH_MAX to include trailing NUL.

- --
Life is short - so eat dessert first!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCRYQ984KuGfSFAYARAg9PAJ9IBnJU99Mk7dLMMciIt9xSvEwk5gCfaXML
snkvzBf+BcDbXS+CG5SFmnk=
=OvLe
-----END PGP SIGNATURE-----

--------------050207080503090300000903
Content-Type: text/plain;
 name="foo.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="foo.c"
Content-length: 2546

#include <errno.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <limits.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <fcntl.h>
#include <stdio.h>

#ifndef AT_FDCWD
# define AT_FDCWD 0
#endif
#ifdef ENAMETOOLONG
# define is_ENAMETOOLONG(x) ((x) == ENAMETOOLONG)
#else
# define is_ENAMETOOLONG(x) 0
#endif

/* The length of this name must be 8.  */
#define DIR_NAME "confdir3"
#define DIR_NAME_LEN 8
#define DIR_NAME_SIZE (DIR_NAME_LEN + 1)

/* The length of "../".  */
#define DOTDOTSLASH_LEN 3

/* Leftover bytes in the buffer, to work around library or OS bugs.  */
#define BUF_SLOP 20

int
main (void)
{
  char buf[PATH_MAX * (DIR_NAME_SIZE / DOTDOTSLASH_LEN + 1)
	   + DIR_NAME_SIZE + BUF_SLOP];
  char *cwd = getcwd (buf, PATH_MAX);
  size_t initial_cwd_len;
  size_t cwd_len;
  int fail = 0;
  size_t n_chdirs = 0;

  if (cwd == NULL)
    exit (1);

  cwd_len = initial_cwd_len = strlen (cwd);

  while (1)
    {
      size_t dotdot_max = PATH_MAX * (DIR_NAME_SIZE / DOTDOTSLASH_LEN);
      char *c = NULL;

      cwd_len += DIR_NAME_SIZE;
      /* If mkdir or chdir fails, be pessimistic and consider that
	 as a failure, too.  */
      if (mkdir (DIR_NAME, S_IRWXU) < 0)
	{
	  printf ("mkdir failed: %d\n", errno);
	  fail = 2;
	  break;
	}
      if (chdir (DIR_NAME) < 0)
	{
	  printf ("chdir failed: %d\n", errno);
	  fail = 2;
	  break;
	}

      if (PATH_MAX <= cwd_len && cwd_len < PATH_MAX + DIR_NAME_SIZE)
	{
	  c = getcwd (buf, PATH_MAX);
	  if (!c && errno == ENOENT)
	    {
	      fail = 1;
	      break;
	    }
	  if (c || ! (errno == ERANGE || is_ENAMETOOLONG (errno)))
	    {
	      fail = 2;
	      break;
	    }
	}

      if (dotdot_max <= cwd_len - initial_cwd_len)
	{
	  if (dotdot_max + DIR_NAME_SIZE < cwd_len - initial_cwd_len)
	    break;
	  c = getcwd (buf, cwd_len + 1);
	  if (!c)
	    {
	      if (! (errno == ERANGE || errno == ENOENT
		     || is_ENAMETOOLONG (errno)))
		{
		  fail = 2;
		  break;
		}
	      if (AT_FDCWD || errno == ERANGE || errno == ENOENT)
		{
		  fail = 1;
		  break;
		}
	    }
	}

      if (c && strlen (c) != cwd_len)
	{
	  fail = 2;
	  break;
	}
      ++n_chdirs;
    }

  /* Leaving behind such a deep directory is not polite.
     So clean up here, right away, even though the driving
     shell script would also clean up.  */
  {
    size_t i;

    /* Unlink first, in case the chdir failed.  */
    unlink (DIR_NAME);
    for (i = 0; i <= n_chdirs; i++)
      {
	if (chdir ("..") < 0)
	  break;
	rmdir (DIR_NAME);
      }
  }

  exit (fail);
}

--------------050207080503090300000903
Content-Type: text/plain;
 name="cygwin.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin.patch"
Content-length: 1528

Index: errno.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/errno.cc,v
retrieving revision 1.50
diff -u -p -r1.50 errno.cc
--- errno.cc	16 Mar 2005 01:00:05 -0000	1.50
+++ errno.cc	26 Mar 2005 15:46:11 -0000
@@ -78,7 +78,7 @@ static NO_COPY struct
   X (BUSY,			EBUSY),
   X (ALREADY_EXISTS,		EEXIST),
   X (NO_SIGNAL_SENT,		EIO),
-  X (FILENAME_EXCED_RANGE,	EINVAL),
+  X (FILENAME_EXCED_RANGE,	ENAMETOOLONG),
   X (META_EXPANSION_TOO_LONG,	EINVAL),
   X (INVALID_SIGNAL_NUMBER,	EINVAL),
   X (THREAD_1_INACTIVE,		EINVAL),
Index: include/limits.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/limits.h,v
retrieving revision 1.13
diff -u -p -r1.13 limits.h
--- include/limits.h	25 Jan 2005 22:45:10 -0000	1.13
+++ include/limits.h	26 Mar 2005 15:46:11 -0000
@@ -124,8 +124,15 @@ details. */
 #undef SSIZE_MAX
 #define SSIZE_MAX (__LONG_MAX__)
 
-/* Maximum length of a path */
-#define PATH_MAX (260 - 1 /*NUL*/)
+/* Maximum length of a path, including NUL.  This limit is on the underlying
+   absolute Windows name; the limit on POSIX names is mount-point
+   dependent.  */
+#define PATH_MAX 260
+
+/* Maximum length of a path component.  This limit is on the underlying
+   Windows name; on managed mounts an 85-character name can expand to be
+   this large.  */
+#define NAME_MAX 255
 
 /* Max num groups for a user, value taken from NT documentation */
 /* Must match <sys/param.h> NGROUPS */

--------------050207080503090300000903--
