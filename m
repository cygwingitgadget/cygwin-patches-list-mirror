Return-Path: <cygwin-patches-return-9058-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 44048 invoked by alias); 15 May 2018 06:23:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 43636 invoked by uid 89); 15 May 2018 06:23:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2 spammy=actions, mere, Actions, cygwins
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 15 May 2018 06:23:54 +0000
Received: from localhost (mark@localhost)	by m0.truegem.net (8.12.11/8.12.11) with ESMTP id w4F6NqUi056662	for <cygwin-patches@cygwin.com>; Mon, 14 May 2018 23:23:52 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Date: Tue, 15 May 2018 06:23:00 -0000
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/3] Posix asynchronous I/O support: aio files
In-Reply-To: <5037e322-3ad0-d963-d8db-9dae22e20633@SystematicSw.ab.ca>
Message-ID: <Pine.BSF.4.63.1805142318390.55746@m0.truegem.net>
References: <20180419080402.10932-1-mark@maxrnd.com> <20180419080402.10932-2-mark@maxrnd.com> <20180419133851.GP15911@calimero.vinschen.de> <Pine.BSF.4.63.1805020106340.6018@m0.truegem.net> <5037e322-3ad0-d963-d8db-9dae22e20633@SystematicSw.ab.ca>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1257701235-1526365432=:55746"
X-IsSubscribed: yes
X-SW-Source: 2018-q2/txt/msg00015.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1257701235-1526365432=:55746
Content-Type: TEXT/PLAIN; charset=utf-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-length: 3851

On Wed, 2 May 2018, Brian Inglis wrote:
> On 2018-05-02 02:21, Mark Geisert wrote:
>> I found a discrepancy in the Cygwin source tree and would like input on =
how to
>> resolve it...
>> On Thu, 19 Apr 2018, Corinna Vinschen wrote:
>>>> +static void
>>>> +aionotify (struct aiocb *aio)
>>>> +{
>>>> +=C2=A0 /* if signal notification wanted, send AIO-complete signal */
>>>> +=C2=A0 //XXX Is sigqueue() the best way to send signo+value within sa=
me process?
>>>> +=C2=A0 if (aio->aio_sigevent.sigev_notify =3D=3D SIGEV_SIGNAL)
>>>> +=C2=A0=C2=A0=C2=A0 sigqueue (mypid,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 aio->aio_sigevent.sigev_signo,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 aio->aio_sigevent.sigev_value);
>>> Given you have direct access to pinfo, you can just as well call
>>> sig_send (myself, ...). This also drop the requirement to know your pid.
>> While making the change from sigqueue() to sig_send() I was researching
>> siginfo_t, and I found that the values for element si_code in Cygwin's
>> /usr/include/sys/signal.h...
>> /* Signal Actions, P1003.1b-1993, p. 64 */
>> /* si_code values, p. 66 */
>> #define SI_USER=C2=A0=C2=A0=C2=A0 1=C2=A0 /* Sent by a user. kill(), abo=
rt(), etc */
>> #define SI_QUEUE=C2=A0=C2=A0 2=C2=A0 /* Sent by sigqueue() */
>> #define SI_TIMER=C2=A0=C2=A0 3=C2=A0 /* Sent by expiration of a timer_se=
ttime() timer */
>> #define SI_ASYNCIO 4=C2=A0 /* Indicates completion of asycnhronous IO */
>> #define SI_MESGQ=C2=A0=C2=A0 5=C2=A0 /* Indicates arrival of a message a=
t an empty queue */
>> ...are inconsistent with the enum values in internal file
>> winsup/cygwin/include/cygwin/signal.h...
>> enum
>> {
>> =C2=A0 SI_USER =3D 0,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 sent by kill, raise, pthread_kill */
>> =C2=A0 SI_ASYNCIO =3D 2,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* sent by AIO co=
mpletion (currently unimplemented) */
>> =C2=A0 SI_MESGQ,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 /* sent by real time mesq state change
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (currently unimplemented) */
>> =C2=A0 SI_TIMER,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 /* sent by timer expiration */
>> =C2=A0 SI_QUEUE,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 /* sent by sigqueue */
>> =C2=A0 SI_KERNEL,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* sent by system */
>>
>> =C2=A0 ILL_ILLOPC,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 /* illegal opcode */
>> =C2=A0 ILL_ILLOPN,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 /* illegal operand */
>> =C2=A0 [...]
>> };
>> I figure it's the /usr/include/sys/signal.h defines that should be chang=
ed,
>> given that Posix doesn't specify values but only the names of the values=
.=C2=A0 And
>> the winsup* enum values are the ones used internally so should likely no=
t be
>> changed.
>> Does this sound like the right way to go?
>
> The other values appear to be used by non-Cygwin newlib implementations
> bracketed by:
>
> 	#if defined(__CYGWIN__)
> 	#include <cygwin/signal.h>
> 	#else
> ... 100+ lines
> 	#endif /* defined(__CYGWIN__) */
>
> and, if that was required, should be changed via the newlib list.

Finally got this question popped to the top of my stack.  Thanks Brian.

It's all good as-is.  I had previously not thought to consider the myriad=20
nestings and cross-definitions accomplished by macros.  Props to those on=20
the team who keep all this stuff straight.  No mere mortals they.

..mark=

--0-1257701235-1526365432=:55746--
