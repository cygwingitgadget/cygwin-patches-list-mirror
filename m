Return-Path: <cygwin-patches-return-1710-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 32075 invoked by alias); 16 Jan 2002 22:28:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32048 invoked from network); 16 Jan 2002 22:28:52 -0000
Message-ID: <178f01c19edd$27fce250$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
Subject: fnmatch
Date: Wed, 16 Jan 2002 14:28:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_178C_01C19F39.5AE824C0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 16 Jan 2002 22:28:50.0565 (UTC) FILETIME=[2BF6F350:01C19EDD]
X-SW-Source: 2002-q1/txt/msg00067.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_178C_01C19F39.5AE824C0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 41

Hopefully this is self-explanatory.

Rob

------=_NextPart_000_178C_01C19F39.5AE824C0
Content-Type: application/octet-stream;
	name="fnmatch.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="fnmatch.patch"
Content-length: 1699

Index: Makefile.in=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/Makefile.in,v=0A=
retrieving revision 1.63.2.9=0A=
diff -u -p -r1.63.2.9 Makefile.in=0A=
--- Makefile.in	2002/01/15 12:52:49	1.63.2.9=0A=
+++ Makefile.in	2002/01/16 22:12:31=0A=
@@ -126,7 +126,7 @@ DLL_OFILES:=3Dassert.o autoload.o cygheap.=0A=
 	fhandler_disk_file.o fhandler_dsp.o fhandler_floppy.o fhandler_mem.o \=0A=
 	fhandler_random.o fhandler_raw.o fhandler_serial.o fhandler_socket.o \=0A=
 	fhandler_tape.o fhandler_termios.o fhandler_tty.o fhandler_windows.o \=0A=
-	fhandler_zero.o fork.o glob.o grp.o heap.o init.o ioctl.o ipc.o \=0A=
+	fhandler_zero.o fnmatch.o fork.o glob.o grp.o heap.o init.o ioctl.o ipc.o=
 \=0A=
 	localtime.o malloc.o miscfuncs.o mmap.o net.o ntea.o passwd.o path.o \=0A=
 	pinfo.o pipe.o poll.o pthread.o regcomp.o regerror.o regexec.o \=0A=
 	regfree.o registry.o resource.o scandir.o sched.o sec_acl.o \=0A=
Index: cygwin.din=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v=0A=
retrieving revision 1.37.2.4=0A=
diff -u -p -r1.37.2.4 cygwin.din=0A=
--- cygwin.din	2002/01/04 03:56:06	1.37.2.4=0A=
+++ cygwin.din	2002/01/16 22:12:34=0A=
@@ -267,6 +267,7 @@ fmod=0A=
 _fmod =3D fmod=0A=
 fmodf=0A=
 _fmodf =3D fmodf=0A=
+fnmatch=0A=
 fopen=0A=
 _fopen =3D fopen=0A=
 fork=0A=

------=_NextPart_000_178C_01C19F39.5AE824C0
Content-Type: application/octet-stream;
	name="fnmatch.cc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="fnmatch.cc"
Content-length: 4496

/* fnmatch.cc: Filename amtch=0A=
=0A=
   Copyright 2001 Red Hat, Inc.=0A=
   Copyright 2001 Red Hat, Inc.=0A=
=0A=
   Written by Robert Collins <rbtcollins@hotmail.com>=0A=
=20=20=20=0A=
   This file is part of Cygwin.=0A=
=0A=
   This software is a copyrighted work licensed under the terms of the=0A=
   Cygwin license.  Please consult the file "CYGWIN_LICENSE" for=0A=
   details. */=0A=
=0A=
#include <fnmatch.h>=0A=
=0A=
#ifdef HAVE_CONFIG_H=0A=
# include "config.h"=0A=
#endif=0A=
=0A=
#include "winsup.h"=0A=
#include <errno.h>=0A=
#include "cygerrno.h"=0A=
#include <assert.h>=0A=
=0A=
/* compare pattern against string.=0A=
 * logic: iterate across pattern incrementing string=0A=
 * as appropriate.=0A=
 * for *, we skip across any following * or ? characters,=0A=
 * incrementing the string location for ?,=20=0A=
 * and then try to match the following component against the remaining stri=
ng.=0A=
 * but allowing it to slide to the right by up to=20=0A=
 * len (rem string) - (len (remaining pattern)=0A=
 */=0A=
extern "C" int=0A=
fnmatch (const char *pattern, const char *string, int flags)=0A=
{=0A=
  const char *p =3D pattern, *s =3D string;=0A=
  char current;=0A=
  while ((current =3D *p++) !=3D '\0')=0A=
    {=0A=
      switch (current)=0A=
	{=0A=
	case '?':=0A=
	  if ((*s =3D=3D '\0') ||=0A=
	      ((flags & FNM_PATHNAME) && *s =3D=3D '/') ||=0A=
	      (((flags & FNM_PERIOD) && *s =3D=3D '.') &&=0A=
	       ((s =3D=3D string) || ((flags & FNM_PATHNAME) && s[-1] =3D=3D '/'))=
))=0A=
	    return FNM_NOMATCH;=0A=
	  s++;=0A=
	  break;=0A=
=0A=
	case '*':=0A=
	  if (*s =3D=3D '\0')=0A=
	    return 0;		// * matches NULL strings.=0A=
	  if ((flags & FNM_PERIOD) && *s =3D=3D '.'=0A=
	      && ((s =3D=3D string) || ((flags & FNM_PATHNAME) && s[-1] =3D=3D '/'=
)))=0A=
	    return FNM_NOMATCH;=0A=
	  /* walk through any wildcards - ** =3D=3D *, and *? =3D * with a length =
minimum. */=0A=
	  for (current =3D *p++; current =3D=3D '*' || current =3D=3D '?';=0A=
	       current =3D *p++)=0A=
	    {=0A=
	      if ((flags & FNM_PATHNAME) && *s =3D=3D '/')=0A=
		return FNM_NOMATCH;=0A=
	      // Can't get a . here, it must follow / caught aboce=0A=
	      if (current =3D=3D '?')=0A=
		{=0A=
		  if (*s =3D=3D '\0')=0A=
		    return FNM_NOMATCH;=0A=
		  else=0A=
		    // use up a character.=0A=
		    s++;=0A=
		}=0A=
	    }=0A=
	  if (current =3D=3D '\0')=0A=
	    return 0;		// success=0A=
	  --p;			// get back a pointer to the remaining pattern=0A=
	  if (current =3D=3D '\\' && !(flags & FNM_NOESCAPE))=0A=
	    {=0A=
	      current =3D p[1];	// preserve the location=0A=
	      if (current =3D=3D '\0')=0A=
		return FNM_NOMATCH;=0A=
	    }=0A=
	  while (*s)=0A=
	    {=0A=
	      int subflags =3D flags & ~FNM_PERIOD;=0A=
	      if ((flags & FNM_PATHNAME) && *s =3D=3D '/')=0A=
		return FNM_NOMATCH;=0A=
	      if (current =3D=3D *s && (fnmatch (p, s, subflags) =3D=3D 0))=0A=
		return 0;	// recursion worked=0A=
	      ++s;=0A=
	    }=0A=
	  return FNM_NOMATCH;=0A=
	case '[':=0A=
	  // Grr regexp time=0A=
	  return FNM_NOMATCH;=0A=
	  break;=0A=
//        '!' is the negatopr, not '^' as usual=0A=
	case '\\':=0A=
	  if (!(flags & FNM_NOESCAPE))=0A=
	    {=0A=
	      current =3D *p++;=0A=
	      if (current =3D=3D '\0')=0A=
		// \ without character=0A=
		return FNM_NOMATCH;=0A=
	    }=0A=
	  if (*s =3D=3D '\0' || current !=3D *s++)=0A=
	    return FNM_NOMATCH;=0A=
=0A=
	  break;=0A=
	case '|':		/* fallthru */=0A=
	case '&':		/* fallthru */=0A=
	case ';':		/* fallthru */=0A=
	case '<':		/* fallthru */=0A=
	case '>':		/* fallthru */=0A=
	case '(':		/* fallthru */=0A=
	case ')':		/* fallthru */=0A=
	case '$':		/* fallthru */=0A=
	case '\"':		/* fallthru */=0A=
	case ' ':		/* fallthru */=0A=
	case '\t':		/* fallthru */=0A=
	case '\n':		/* fallthru */=0A=
	case '#':		/* fallthru *//* these next 4 may need to be allowed */=0A=
	case '~':		/* fallthru */=0A=
	case '=3D':		/* fallthru */=0A=
	case '%':		/* These characters _have_ to be escaped according to=0A=
				   IEEE P1003.1, Draft 6, April 2001/ Open Group Technical Standard, Is=
sue 6=0A=
				   2.13.1=0A=
				 */=0A=
	  return FNM_NOMATCH;=0A=
=0A=
	default:=0A=
	  if (current !=3D *s++)=0A=
	    return FNM_NOMATCH;=0A=
=0A=
	}=0A=
    }=0A=
=0A=
  if (*s =3D=3D '\0')=0A=
    return 0;=0A=
=0A=
  // Gotta love the non-posix extensions required to satisfy GNU AC tests=
=20=0A=
  if(*s =3D=3D '/' && (flags & FNM_LEADING_DIR))=0A=
    return 0;=0A=
=0A=
  return FNM_NOMATCH;=0A=
}=0A=

------=_NextPart_000_178C_01C19F39.5AE824C0
Content-Type: application/octet-stream;
	name="fnmatch.h"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="fnmatch.h"
Content-length: 1360

/* dlfcn.h=0A=
=0A=
   Copyright 1998, 1999, 2000, 2001 Red Hat, Inc.=0A=
=0A=
This file is part of Cygwin.=0A=
=0A=
This software is a copyrighted work licensed under the terms of the=0A=
Cygwin license.  Please consult the file "CYGWIN_LICENSE" for=0A=
details. */=0A=
=0A=
#ifndef _FNMATCH_H_=0A=
#define	_FNMATCH_H_=0A=
=0A=
#include <sys/cdefs.h>=0A=
=0A=
#define FNM_NOMATCH  1  /* The string does not match the specified pattern.=
 */=0A=
#define FNM_PATHNAME 2  /* Slash in string only matches slash in pattern.  =
 */=0A=
#define FNM_PERIOD   4  /* Leading period in string must be exactly matched=
=20=0A=
			   by period in pattern. */=0A=
#define FNM_NOESCAPE 8  /* Disable backslash escaping. */=0A=
#define FNM_NOSYS    16 /* The implementation does not support this functio=
n. */=0A=
=0A=
/* For folk who don't read POSIX manuals */=0A=
#if !defined (_POSIX_C_SOURCE) || _POSIX_C_SOURCE < 2 || defined (_GNU_SOUR=
CE)=0A=
#define FNM_FILE_NAME   FNM_PATHNAME=0A=
#define FNM_LEADING_DIR 32 /* Ignore `/...' after a match.  */=0A=
#endif=0A=
=0A=
__BEGIN_DECLS=0A=
=0A=
#undef DLLEXPORT=0A=
#ifdef __INSIDE_CYGWIN__=0A=
# define DLLEXPORT=0A=
#else=0A=
# define DLLEXPORT __declspec(dllimport)=0A=
#endif=0A=
int	DLLEXPORT fnmatch(const char *, const char *, int);=0A=
=0A=
#undef DLLEXPORT=0A=
__END_DECLS=0A=
=0A=
#endif /* _FNMATCH_H_ */=0A=

------=_NextPart_000_178C_01C19F39.5AE824C0
Content-Type: application/octet-stream;
	name="fnmatch.ChangeLog"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="fnmatch.ChangeLog"
Content-length: 221

2002-01-17  Robert Collins  <rbtcollins@hotmail.com>=0A=
=0A=
	* fnmatch.cc: New file.=0A=
	* include/fnmatch.h: New file.=0A=
	* Makefile.in: Add fnmatch object to cygwin.=0A=
	* cygwin.din: And export the function.=0A=

------=_NextPart_000_178C_01C19F39.5AE824C0--
