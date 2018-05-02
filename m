Return-Path: <cygwin-patches-return-9056-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26645 invoked by alias); 2 May 2018 08:21:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 26621 invoked by uid 89); 2 May 2018 08:21:27 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2 spammy=arrival, Cause, researching, Hx-languages-length:2214
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 02 May 2018 08:21:23 +0000
Received: from localhost (mark@localhost)	by m0.truegem.net (8.12.11/8.12.11) with ESMTP id w428LMlr007558	for <cygwin-patches@cygwin.com>; Wed, 2 May 2018 01:21:22 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Date: Wed, 02 May 2018 08:21:00 -0000
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/3] Posix asynchronous I/O support: aio files
In-Reply-To: <20180419133851.GP15911@calimero.vinschen.de>
Message-ID: <Pine.BSF.4.63.1805020106340.6018@m0.truegem.net>
References: <20180419080402.10932-1-mark@maxrnd.com> <20180419080402.10932-2-mark@maxrnd.com> <20180419133851.GP15911@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-IsSubscribed: yes
X-SW-Source: 2018-q2/txt/msg00013.txt.bz2

Hi Corinna,
I found a discrepancy in the Cygwin source tree and would like input on 
how to resolve it...

On Thu, 19 Apr 2018, Corinna Vinschen wrote:
>> +static void
>> +aionotify (struct aiocb *aio)
>> +{
>> +  /* if signal notification wanted, send AIO-complete signal */
>> +  //XXX Is sigqueue() the best way to send signo+value within same process?
>> +  if (aio->aio_sigevent.sigev_notify == SIGEV_SIGNAL)
>> +    sigqueue (mypid,
>> +              aio->aio_sigevent.sigev_signo,
>> +              aio->aio_sigevent.sigev_value);
>
> Given you have direct access to pinfo, you can just as well call
> sig_send (myself, ...). This also drop the requirement to know your pid.

While making the change from sigqueue() to sig_send() I was researching 
siginfo_t, and I found that the values for element si_code in Cygwin's
/usr/include/sys/signal.h...

/* Signal Actions, P1003.1b-1993, p. 64 */
/* si_code values, p. 66 */

#define SI_USER    1  /* Sent by a user. kill(), abort(), etc */
#define SI_QUEUE   2  /* Sent by sigqueue() */
#define SI_TIMER   3  /* Sent by expiration of a timer_settime() timer */
#define SI_ASYNCIO 4  /* Indicates completion of asycnhronous IO */
#define SI_MESGQ   5  /* Indicates arrival of a message at an empty queue */

typedef struct {
   int          si_signo;    /* Signal number */
   int          si_code;     /* Cause of the signal */
   union sigval si_value;    /* Signal value */
} siginfo_t;

...are inconsistent with the enum values in internal file
winsup/cygwin/include/cygwin/signal.h...

enum
{
   SI_USER = 0,         /* sent by kill, raise, pthread_kill */
   SI_ASYNCIO = 2,      /* sent by AIO completion (currently unimplemented) */
   SI_MESGQ,            /* sent by real time mesq state change
                                            (currently unimplemented) */
   SI_TIMER,            /* sent by timer expiration */
   SI_QUEUE,            /* sent by sigqueue */
   SI_KERNEL,           /* sent by system */

   ILL_ILLOPC,          /* illegal opcode */
   ILL_ILLOPN,          /* illegal operand */
   [...]
};

I figure it's the /usr/include/sys/signal.h defines that should be 
changed, given that Posix doesn't specify values but only the names of 
the values.  And the winsup* enum values are the ones used internally so 
should likely not be changed.

Does this sound like the right way to go?
Thanks,

..mark
