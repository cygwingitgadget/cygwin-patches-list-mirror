Return-Path: <cygwin-patches-return-7217-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14860 invoked by alias); 29 Mar 2011 07:51:51 -0000
Received: (qmail 14826 invoked by uid 22791); 29 Mar 2011 07:51:41 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 29 Mar 2011 07:51:30 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D40002C0168; Tue, 29 Mar 2011 09:51:27 +0200 (CEST)
Date: Tue, 29 Mar 2011 07:51:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix return value and errno set by sem_init(), sem_destroy() and sem_close()
Message-ID: <20110329075127.GE15349@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4D91082B.1050102@dronecode.org.uk> <20110328221657.GA12793@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20110328221657.GA12793@ednor.casa.cgf.cx>
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
X-SW-Source: 2011-q1/txt/msg00072.txt.bz2

On Mar 28 18:16, Christopher Faylor wrote:
> On Mon, Mar 28, 2011 at 11:14:03PM +0100, Jon TURNEY wrote:
> >
> >While looking into some mysterious failures of sem_init() in python, I was
> >somewhat surprised to find the following comment in python/thread_pthread.h:
> >
> >> /*
> >>  * As of February 2002, Cygwin thread implementations mistakenly report error
> >>  * codes in the return value of the sem_ calls (like the pthread_ functions).
> >>  * Correct implementations return -1 and put the code in errno. This supports
> >>  * either.
> >>  */
> >
> >While this comment refers to sem_wait() and sem_trywait(), which seem to have
> >been fixed since [1], it seems that sem_init(), sem_destroy() and sem_close()
> >are still non-conformant with SUS in that (i) they do not set errno, and (ii)
> >they don't return -1 on failure, instead returning the value which should be
> >set as errno.
> >
> >2011-03-28  Jon TURNEY  <jon.turney@dronecode.org.uk>
> >
> >	* thread.cc (semaphore::init, destroy, close): Standards conformance
> >	fix.  On a failure, return -1 and set errno.
> >	* thread.h (semaphore::terminate): Save errno since semaphore::close()
> >	may now modify it.
> >
> >[1] http://cygwin.com/ml/cygwin/2002-02/msg01379.html
> 
> Looks good.  Please check in ASAP so this will make it into 1.7.9.

Jon, your copyright assignment has been forwarded to my manager who's
going to sign it tomorrow.  So I took the liberty to check in this change
since I'd like to get out 1.7.9 today.  Actually, today *and* ASAP.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
