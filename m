Return-Path: <cygwin-patches-return-7601-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15325 invoked by alias); 24 Feb 2012 09:38:52 -0000
Received: (qmail 15225 invoked by uid 22791); 24 Feb 2012 09:38:26 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 24 Feb 2012 09:38:11 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 21EBA2C006D; Fri, 24 Feb 2012 10:38:09 +0100 (CET)
Date: Fri, 24 Feb 2012 09:38:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add pthread_getname_np, pthread_setname_np
Message-ID: <20120224093809.GA20683@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1330054695.6828.15.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1330054695.6828.15.camel@YAAKOV04>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q1/txt/msg00024.txt.bz2

On Feb 23 21:38, Yaakov (Cygwin/X) wrote:
> This patchset adds pthread_getname_np and pthread_setname_np.  These
> were added to glibc in 2.12[1] and are also present in some form on
> NetBSD and several UNIXes.  IIUC recent versions of GDB can benefit from
> this support.

Thanks for your patch, but I don't think it's the whole thing.

Consider, if you implement pthread_[gs]etname_np as you did, then you
have pthread names which are only available to the process in which
the threads are running.  So, how could GDB get the information for
its inferior process?

Actually GDB reads the thread name using a target specific function
which is so far only implemented for Linux.  It does not use
pthread_getname_np, rather it reads the name from /proc/$PID/task/$TID/comm.

And that's a bit of a problem in Cygwin.  Every Cygwin process is
multi-threaded (think signals), but only the application-started threads
are pthreads.

So, again, thanks for doing this, but I think this requires more work to
be useful.  The basic task is to provide /proc/$PID/task for all threads
running in a Cygwin process.  If that's available, the pthread_[gs]etname_np
will become useful and their (different) implementation probably falls into
place.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
