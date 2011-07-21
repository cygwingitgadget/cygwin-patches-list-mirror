Return-Path: <cygwin-patches-return-7443-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22064 invoked by alias); 21 Jul 2011 07:54:51 -0000
Received: (qmail 22036 invoked by uid 22791); 21 Jul 2011 07:54:29 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 21 Jul 2011 07:53:50 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 70D462CAE8D; Thu, 21 Jul 2011 09:53:47 +0200 (CEST)
Date: Thu, 21 Jul 2011 07:54:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] clock_nanosleep(2), pthread_condattr_[gs]etclock(3)
Message-ID: <20110721075347.GF15150@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1311126880.7796.9.camel@YAAKOV04> <20110720075654.GA3667@calimero.vinschen.de> <1311153377.7796.66.camel@YAAKOV04> <1311155453.7796.70.camel@YAAKOV04> <20110720141125.GA15232@calimero.vinschen.de> <1311199441.6248.9.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1311199441.6248.9.camel@YAAKOV04>
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
X-SW-Source: 2011-q3/txt/msg00019.txt.bz2

On Jul 20 17:03, Yaakov (Cygwin/X) wrote:
> On Wed, 2011-07-20 at 16:11 +0200, Corinna Vinschen wrote:
> > (*) Does it also influence pthread_cond_timedwait?  This information seems
> >     to be missing in SUSv4.
> 
> The last paragraph of RATIONALE -> Timed Wait Semantics states:
> 
> > For cases when the system clock is advanced discontinuously by an
> > operator, it is expected that implementations process any timed wait
> > expiring at an intervening time as if that time had actually occurred.
> 
> Of course, this would be an old problem with pthread_cond_timedwait().

Thanks, I missed that.

> 2011-07-20  Yaakov Selkowitz  <yselkowitz@...>
> 
> 	* sysconf.cc (sca): Set _SC_CLOCK_SELECTION to _POSIX_CLOCK_SELECTION.
> 
> 2011-07-20  Yaakov Selkowitz  <yselkowitz@...>
> 
> 	* cygwin.din (pthread_condattr_getclock): Export.
> 	(pthread_condattr_setclock): Export.
> 	* posix.sgml (std-notimpl): Move pthread_condattr_getclock and
> 	pthread_condattr_setclock from here...
> 	(std-susv4): ... to here.
> 	* thread.cc: (pthread_condattr::pthread_condattr): Initialize clock_id.
> 	(pthread_cond::pthread_cond): Initialize clock_id.
> 	(pthread_cond_timedwait): Use clock_gettime() instead of gettimeofday()
> 	in order to support all allowed clocks.
> 	(pthread_condattr_getclock): New function.
> 	(pthread_condattr_setclock): New function.
> 	* thread.h (class pthread_condattr): Add clock_id member.
> 	(class pthread_cond): Ditto.
> 	* include/pthread.h: Remove obsolete comment.
> 	(pthread_condattr_getclock): Declare.
> 	(pthread_condattr_setclock): Declare.

This patch looks good, please apply.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
