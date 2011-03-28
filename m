Return-Path: <cygwin-patches-return-7215-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2941 invoked by alias); 28 Mar 2011 22:17:05 -0000
Received: (qmail 2931 invoked by uid 22791); 28 Mar 2011 22:17:05 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm16-vm0.bullet.mail.ne1.yahoo.com (HELO nm16-vm0.bullet.mail.ne1.yahoo.com) (98.138.91.49)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Mon, 28 Mar 2011 22:17:00 +0000
Received: from [98.138.90.55] by nm16.bullet.mail.ne1.yahoo.com with NNFMP; 28 Mar 2011 22:16:59 -0000
Received: from [98.138.84.40] by tm8.bullet.mail.ne1.yahoo.com with NNFMP; 28 Mar 2011 22:16:59 -0000
Received: from [127.0.0.1] by smtp108.mail.ne1.yahoo.com with NNFMP; 28 Mar 2011 22:16:59 -0000
Received: from cgf.cx (cgf@72.70.43.165 with login)        by smtp108.mail.ne1.yahoo.com with SMTP; 28 Mar 2011 15:16:58 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id BE6AA13C02A	for <cygwin-patches@cygwin.com>; Mon, 28 Mar 2011 18:16:57 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id A8B112B35F; Mon, 28 Mar 2011 18:16:57 -0400 (EDT)
Date: Mon, 28 Mar 2011 22:17:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix return value and errno set by sem_init(), sem_destroy() and sem_close()
Message-ID: <20110328221657.GA12793@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4D91082B.1050102@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D91082B.1050102@dronecode.org.uk>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q1/txt/msg00070.txt.bz2

On Mon, Mar 28, 2011 at 11:14:03PM +0100, Jon TURNEY wrote:
>
>While looking into some mysterious failures of sem_init() in python, I was
>somewhat surprised to find the following comment in python/thread_pthread.h:
>
>> /*
>>  * As of February 2002, Cygwin thread implementations mistakenly report error
>>  * codes in the return value of the sem_ calls (like the pthread_ functions).
>>  * Correct implementations return -1 and put the code in errno. This supports
>>  * either.
>>  */
>
>While this comment refers to sem_wait() and sem_trywait(), which seem to have
>been fixed since [1], it seems that sem_init(), sem_destroy() and sem_close()
>are still non-conformant with SUS in that (i) they do not set errno, and (ii)
>they don't return -1 on failure, instead returning the value which should be
>set as errno.
>
>2011-03-28  Jon TURNEY  <jon.turney@dronecode.org.uk>
>
>	* thread.cc (semaphore::init, destroy, close): Standards conformance
>	fix.  On a failure, return -1 and set errno.
>	* thread.h (semaphore::terminate): Save errno since semaphore::close()
>	may now modify it.
>
>[1] http://cygwin.com/ml/cygwin/2002-02/msg01379.html

Looks good.  Please check in ASAP so this will make it into 1.7.9.

Thanks.

cgf
