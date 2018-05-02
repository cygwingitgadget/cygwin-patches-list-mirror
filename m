Return-Path: <cygwin-patches-return-9057-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 116789 invoked by alias); 2 May 2018 18:11:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 116758 invoked by uid 89); 2 May 2018 18:11:55 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW autolearn=no version=3.3.2 spammy=arrival, (unknown), researching, H*r:ip*192.168.1.100
X-HELO: smtp-out-so.shaw.ca
Received: from smtp-out-so.shaw.ca (HELO smtp-out-so.shaw.ca) (64.59.136.138) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 02 May 2018 18:11:54 +0000
Received: from [192.168.1.100] ([24.64.240.204])	by shaw.ca with ESMTP	id DwEJfmFMM5wO5DwEKfWpd3; Wed, 02 May 2018 12:11:52 -0600
X-Authority-Analysis: v=2.3 cv=SJtsqtnH c=1 sm=1 tr=0 a=MVEHjbUiAHxQW0jfcDq5EA==:117 a=MVEHjbUiAHxQW0jfcDq5EA==:17 a=IkcTkHD0fZMA:10 a=XfdLQCGf5dgBT0m4VKUA:9 a=QEXdDO2ut3YA:10
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH v2 1/3] Posix asynchronous I/O support: aio files
To: cygwin-patches@cygwin.com
References: <20180419080402.10932-1-mark@maxrnd.com> <20180419080402.10932-2-mark@maxrnd.com> <20180419133851.GP15911@calimero.vinschen.de> <Pine.BSF.4.63.1805020106340.6018@m0.truegem.net>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Message-ID: <5037e322-3ad0-d963-d8db-9dae22e20633@SystematicSw.ab.ca>
Date: Wed, 02 May 2018 18:11:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <Pine.BSF.4.63.1805020106340.6018@m0.truegem.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfKMWvL+7ZwnpuPzhuprFBtw6tQkBigNAVkRhu27cSyFYvSHu0s0snCESRiEUNVafpNbtaPgowJUHU/xfAE9c9kB3R9EsftL/FMOTMWmNhK5Vxm01A2H0 iO3Y1BHC5DjTiAGeQMXW03aDmGzrODQeP517GjivGqtgVVvLAlgaqD7t84wHTnGz2CEzAoTonZ+z4fAmfCBiPGm2OB3yD9FAjkY=
X-IsSubscribed: yes
X-SW-Source: 2018-q2/txt/msg00014.txt.bz2

On 2018-05-02 02:21, Mark Geisert wrote:
> I found a discrepancy in the Cygwin source tree and would like input on how to
> resolve it...
> On Thu, 19 Apr 2018, Corinna Vinschen wrote:
>>> +static void
>>> +aionotify (struct aiocb *aio)
>>> +{
>>> +Â  /* if signal notification wanted, send AIO-complete signal */
>>> +Â  //XXX Is sigqueue() the best way to send signo+value within same process?
>>> +Â  if (aio->aio_sigevent.sigev_notify == SIGEV_SIGNAL)
>>> +Â Â Â  sigqueue (mypid,
>>> +Â Â Â Â Â Â Â Â Â Â Â Â Â  aio->aio_sigevent.sigev_signo,
>>> +Â Â Â Â Â Â Â Â Â Â Â Â Â  aio->aio_sigevent.sigev_value);
>> Given you have direct access to pinfo, you can just as well call
>> sig_send (myself, ...). This also drop the requirement to know your pid.
> While making the change from sigqueue() to sig_send() I was researching
> siginfo_t, and I found that the values for element si_code in Cygwin's
> /usr/include/sys/signal.h...
> /* Signal Actions, P1003.1b-1993, p. 64 */
> /* si_code values, p. 66 */
> #define SI_USERÂ Â Â  1Â  /* Sent by a user. kill(), abort(), etc */
> #define SI_QUEUEÂ Â  2Â  /* Sent by sigqueue() */
> #define SI_TIMERÂ Â  3Â  /* Sent by expiration of a timer_settime() timer */
> #define SI_ASYNCIO 4Â  /* Indicates completion of asycnhronous IO */
> #define SI_MESGQÂ Â  5Â  /* Indicates arrival of a message at an empty queue */
> ...are inconsistent with the enum values in internal file
> winsup/cygwin/include/cygwin/signal.h...
> enum
> {
> Â  SI_USER = 0,Â Â Â Â Â Â Â Â  /* sent by kill, raise, pthread_kill */
> Â  SI_ASYNCIO = 2,Â Â Â Â Â  /* sent by AIO completion (currently unimplemented) */
> Â  SI_MESGQ,Â Â Â Â Â Â Â Â Â Â Â  /* sent by real time mesq state change
> Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â  (currently unimplemented) */
> Â  SI_TIMER,Â Â Â Â Â Â Â Â Â Â Â  /* sent by timer expiration */
> Â  SI_QUEUE,Â Â Â Â Â Â Â Â Â Â Â  /* sent by sigqueue */
> Â  SI_KERNEL,Â Â Â Â Â Â Â Â Â Â  /* sent by system */
> 
> Â  ILL_ILLOPC,Â Â Â Â Â Â Â Â Â  /* illegal opcode */
> Â  ILL_ILLOPN,Â Â Â Â Â Â Â Â Â  /* illegal operand */
> Â  [...]
> };
> I figure it's the /usr/include/sys/signal.h defines that should be changed,
> given that Posix doesn't specify values but only the names of the values.Â  And
> the winsup* enum values are the ones used internally so should likely not be
> changed.
> Does this sound like the right way to go?

The other values appear to be used by non-Cygwin newlib implementations
bracketed by:

	#if defined(__CYGWIN__)
	#include <cygwin/signal.h>
	#else
... 100+ lines
	#endif /* defined(__CYGWIN__) */

and, if that was required, should be changed via the newlib list.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada
