Return-Path: <cygwin-patches-return-3847-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15310 invoked by alias); 6 May 2003 13:34:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15296 invoked from network); 6 May 2003 13:34:51 -0000
Date: Tue, 06 May 2003 13:34:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix nanosleep
Message-ID: <20030506133450.GB3312@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.WNT.4.44.0305061513150.1572-200000@algeria.intern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.WNT.4.44.0305061513150.1572-200000@algeria.intern.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00074.txt.bz2

On Tue, May 06, 2003 at 03:24:56PM +0200, Thomas Pfaff wrote:
>While i am investigating some problems with threads and signals

I don't know what you're investigating but the basic problem with threads
and signals is that you can't send a signal to a thread.  I never implemented
that part of signal delivery.

>i have found a bug in nanosleep where signal_arrived is unnecessary
>checked twice.  This will lead to problems if the event is reset
>between the two checks.  I can provide a testcase if someone is
>interested in details.  AFAICT this problem occurs only in
>multithreaded apps.
>
>2002-05-06 Thomas Pfaff <tpfaff@gmx.net>
>
>* signal.cc (nanosleep): Do not wait twice for signal arrival.

Please check this in.  Looks like an old bug.

cgf

>--- signal.cc.org	2003-05-06 15:10:03.000000000 +0200
>+++ signal.cc	2003-05-06 15:11:04.000000000 +0200
>@@ -88,7 +88,7 @@ nanosleep (const struct timespec *rqtp, 
>   int rc = pthread::cancelable_wait (signal_arrived, req);
>   DWORD now = GetTickCount ();
>   DWORD rem = (rc == WAIT_TIMEOUT || now >= end_time) ? 0 : end_time - now;
>-  if (WaitForSingleObject (signal_arrived, 0) == WAIT_OBJECT_0)
>+  if (rc == WAIT_OBJECT_0)
>     {
>       (void) thisframe.call_signal_handler ();
>       set_errno (EINTR);
