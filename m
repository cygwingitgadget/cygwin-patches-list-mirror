Return-Path: <cygwin-patches-return-1771-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 30441 invoked by alias); 24 Jan 2002 03:34:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30400 invoked from network); 24 Jan 2002 03:34:53 -0000
Message-ID: <02ce01c1a488$156d32b0$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Thomas Fitzsimmons" <fitzsim@redhat.com>,
	<cygwin-patches@cygwin.com>
Cc: <newlib@sources.redhat.com>
References: <1011834535.1278.46.camel@toggle>
Subject: Re: patch to allow newlib to compile when winsup not present
Date: Wed, 23 Jan 2002 19:34:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 24 Jan 2002 03:34:51.0308 (UTC) FILETIME=[14B63EC0:01C1A488]
X-SW-Source: 2002-q1/txt/msg00128.txt.bz2


===
----- Original Message -----
From: "Thomas Fitzsimmons" <fitzsim@redhat.com>
To: <cygwin-patches@cygwin.com>
Cc: <newlib@sources.redhat.com>
Sent: Thursday, January 24, 2002 12:08 PM
Subject: patch to allow newlib to compile when winsup not present


> I've applied this patch to newlib, so that it will compile for the
> i686-pc-cygwin target, when winsup is not in the source tree.
> Previously, the newlib build failed because pthread_t was undefined.

This is incorrect. Cygwin has pthread_kill, so you _will need_ the
cygwin header files to compile newlib for i686-pc-cygwin, regardless of
having winsup in the source tree or not.

Rob

> Index: libc/include/sys/signal.h
> ===================================================================
> RCS file: /cvs/src/src/newlib/libc/include/sys/signal.h,v
> retrieving revision 1.9
> retrieving revision 1.10
> diff -c -r1.9 -r1.10
> *** signal.h 2001/10/22 16:40:26 1.9
> --- signal.h 2002/01/24 00:52:27 1.10
> ***************
> *** 158,164 ****
>   int _EXFUN(sigsuspend, (const sigset_t *));
>   int _EXFUN(sigpause, (int));
>
> ! #if defined(_POSIX_THREADS)
>   int _EXFUN(pthread_kill, (pthread_t thread, int sig));
>   #endif
>
> --- 158,164 ----
>   int _EXFUN(sigsuspend, (const sigset_t *));
>   int _EXFUN(sigpause, (int));
>
> ! #if defined(_POSIX_THREADS) && !defined(__CYGWIN__)
>   int _EXFUN(pthread_kill, (pthread_t thread, int sig));
>   #endif
>
>
> --
> Thomas Fitzsimmons
> Red Hat Canada Limited        e-mail: fitzsim@redhat.com
> 2323 Yonge Street, Suite 300
> Toronto, ON M4P2C9
>
>
