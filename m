Return-Path: <cygwin-patches-return-1773-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 14374 invoked by alias); 24 Jan 2002 17:07:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14358 invoked from network); 24 Jan 2002 17:07:34 -0000
Subject: Re: patch to allow newlib to compile when winsup not present
From: Thomas Fitzsimmons <fitzsim@redhat.com>
To: Robert Collins <robert.collins@itdomain.com.au>
Cc: cygwin-patches@cygwin.com, newlib@sources.redhat.com
In-Reply-To: <02ce01c1a488$156d32b0$0200a8c0@lifelesswks>
References: <1011834535.1278.46.camel@toggle> 
	<02ce01c1a488$156d32b0$0200a8c0@lifelesswks>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: Thu, 24 Jan 2002 09:07:00 -0000
Message-Id: <1011892037.16026.53.camel@toggle>
Mime-Version: 1.0
X-SW-Source: 2002-q1/txt/msg00130.txt.bz2

On Wed, 2002-01-23 at 22:34, Robert Collins wrote:
> 
> ===
> ----- Original Message -----
> From: "Thomas Fitzsimmons" <fitzsim@redhat.com>
> To: <cygwin-patches@cygwin.com>
> Cc: <newlib@sources.redhat.com>
> Sent: Thursday, January 24, 2002 12:08 PM
> Subject: patch to allow newlib to compile when winsup not present
> 
> 
> > I've applied this patch to newlib, so that it will compile for the
> > i686-pc-cygwin target, when winsup is not in the source tree.
> > Previously, the newlib build failed because pthread_t was undefined.
> 
> This is incorrect. Cygwin has pthread_kill, so you _will need_ the
> cygwin header files to compile newlib for i686-pc-cygwin, regardless of
> having winsup in the source tree or not.
> 

Then would a better solution be to include
winsup/cygwin/include/cygwin/types.h in the newlib distribution?

We would probably put it in newlib/libc/include/sys/cygwin.  The patch
would look like this:

*** signal.h	2002/01/24 00:52:27	1.10
--- signal.h	2002/01/24 17:04:17
***************
*** 158,164 ****
  int _EXFUN(sigsuspend, (const sigset_t *));
  int _EXFUN(sigpause, (int));
  
! #if defined(_POSIX_THREADS) && !defined(__CYGWIN__)
  int _EXFUN(pthread_kill, (pthread_t thread, int sig));
  #endif
  
--- 158,164 ----
  int _EXFUN(sigsuspend, (const sigset_t *));
  int _EXFUN(sigpause, (int));
  
! #if defined(_POSIX_THREADS)
  int _EXFUN(pthread_kill, (pthread_t thread, int sig));
  #endif
  
Index: types.h
===================================================================
RCS file: /cvs/src/src/newlib/libc/include/sys/types.h,v
retrieving revision 1.9
diff -c -r1.9 types.h
*** types.h	2001/12/19 03:03:29	1.9
--- types.h	2002/01/24 17:04:17
***************
*** 327,333 ****
  } pthread_once_t;       /* dynamic package initialization */
  #else
  #if defined (__CYGWIN__)
! #include <cygwin/types.h>
  #endif
  #endif /* defined(_POSIX_THREADS) */
  
--- 327,333 ----
  } pthread_once_t;       /* dynamic package initialization */
  #else
  #if defined (__CYGWIN__)
! #include "cygwin/types.h"
  #endif
  #endif /* defined(_POSIX_THREADS) */
  

 
> Rob
> 
> > Index: libc/include/sys/signal.h
> > ===================================================================
> > RCS file: /cvs/src/src/newlib/libc/include/sys/signal.h,v
> > retrieving revision 1.9
> > retrieving revision 1.10
> > diff -c -r1.9 -r1.10
> > *** signal.h 2001/10/22 16:40:26 1.9
> > --- signal.h 2002/01/24 00:52:27 1.10
> > ***************
> > *** 158,164 ****
> >   int _EXFUN(sigsuspend, (const sigset_t *));
> >   int _EXFUN(sigpause, (int));
> >
> > ! #if defined(_POSIX_THREADS)
> >   int _EXFUN(pthread_kill, (pthread_t thread, int sig));
> >   #endif
> >
> > --- 158,164 ----
> >   int _EXFUN(sigsuspend, (const sigset_t *));
> >   int _EXFUN(sigpause, (int));
> >
> > ! #if defined(_POSIX_THREADS) && !defined(__CYGWIN__)
> >   int _EXFUN(pthread_kill, (pthread_t thread, int sig));
> >   #endif
> >
> >
> > --
> > Thomas Fitzsimmons
> > Red Hat Canada Limited        e-mail: fitzsim@redhat.com
> > 2323 Yonge Street, Suite 300
> > Toronto, ON M4P2C9
> >
> >
> 
-- 
Thomas Fitzsimmons
Red Hat Canada Limited        e-mail: fitzsim@redhat.com
2323 Yonge Street, Suite 300
Toronto, ON M4P2C9
