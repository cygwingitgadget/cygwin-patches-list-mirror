Return-Path: <cygwin-patches-return-1770-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 2538 invoked by alias); 24 Jan 2002 01:08:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2503 invoked from network); 24 Jan 2002 01:08:57 -0000
Subject: patch to allow newlib to compile when winsup not present
From: Thomas Fitzsimmons <fitzsim@redhat.com>
To: cygwin-patches@cygwin.com
Cc: newlib@sources.redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: Wed, 23 Jan 2002 17:08:00 -0000
Message-Id: <1011834535.1278.46.camel@toggle>
Mime-Version: 1.0
X-SW-Source: 2002-q1/txt/msg00127.txt.bz2

I've applied this patch to newlib, so that it will compile for the
i686-pc-cygwin target, when winsup is not in the source tree.
Previously, the newlib build failed because pthread_t was undefined.

Index: libc/include/sys/signal.h
===================================================================
RCS file: /cvs/src/src/newlib/libc/include/sys/signal.h,v
retrieving revision 1.9
retrieving revision 1.10
diff -c -r1.9 -r1.10
*** signal.h	2001/10/22 16:40:26	1.9
--- signal.h	2002/01/24 00:52:27	1.10
***************
*** 158,164 ****
  int _EXFUN(sigsuspend, (const sigset_t *));
  int _EXFUN(sigpause, (int));
  
! #if defined(_POSIX_THREADS)
  int _EXFUN(pthread_kill, (pthread_t thread, int sig));
  #endif
  
--- 158,164 ----
  int _EXFUN(sigsuspend, (const sigset_t *));
  int _EXFUN(sigpause, (int));
  
! #if defined(_POSIX_THREADS) && !defined(__CYGWIN__)
  int _EXFUN(pthread_kill, (pthread_t thread, int sig));
  #endif
  

-- 
Thomas Fitzsimmons
Red Hat Canada Limited        e-mail: fitzsim@redhat.com
2323 Yonge Street, Suite 300
Toronto, ON M4P2C9
