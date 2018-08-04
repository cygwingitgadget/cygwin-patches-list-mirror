Return-Path: <cygwin-patches-return-9167-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 130123 invoked by alias); 4 Aug 2018 20:37:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 130107 invoked by uid 89); 4 Aug 2018 20:37:24 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-23.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY autolearn=ham version=3.3.2 spammy=H*u:6.1, Hx-languages-length:1312
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 04 Aug 2018 20:37:22 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id w74KbK1J081506	for <cygwin-patches@cygwin.com>; Sat, 4 Aug 2018 13:37:20 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Received: from 76-217-5-154.lightspeed.irvnca.sbcglobal.net(76.217.5.154), claiming to be "[192.168.1.100]" via SMTP by m0.truegem.net, id smtpdTotwRJ; Sat Aug  4 13:37:16 2018
Subject: Re: [PATCH] Fix return value on aio_read/write success
To: cygwin-patches@cygwin.com
References: <20180804084426.4128-1-mark@maxrnd.com> <20180804202329.GA4180@calimero.vinschen.de>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <7c052d97-0c7b-b3bb-f9e3-07f32912871d@maxrnd.com>
Date: Sat, 04 Aug 2018 20:37:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:49.0) Gecko/20100101 Firefox/49.0 SeaMonkey/2.46
MIME-Version: 1.0
In-Reply-To: <20180804202329.GA4180@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2018-q3/txt/msg00062.txt.bz2

Corinna Vinschen wrote:
> On Aug  4 01:44, Mark Geisert wrote:
>> Oops. Something that iozone testing had found but I regarded as an
>> iozone bug.  Re-reading the man pages set me straight.
>> ---
>>  winsup/cygwin/aio.cc | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/winsup/cygwin/aio.cc b/winsup/cygwin/aio.cc
>> index fe63dec04..571a9621b 100644
>> --- a/winsup/cygwin/aio.cc
>> +++ b/winsup/cygwin/aio.cc
>> @@ -712,7 +712,7 @@ aio_read (struct aiocb *aio)
>>        ; /* I think this is not possible */
>>      }
>>
>> -  return res;
>> +  return res < 0 ? res : 0; /* Return 0 on success, not byte count */
>
> The comment only makes sense in comparison to the former code.
> I'd reduce this to just "Return 0 on success".

OKWD (Okay, will do).

>
>>  }
>>
>>  ssize_t
>> @@ -902,7 +902,7 @@ aio_write (struct aiocb *aio)
>>        ; /* I think this is not possible */
>>      }
>>
>> -  return res;
>> +  return res < 0 ? res : 0; /* Return 0 on success, not byte count */
>
> Ditto.

Yup.

>
>>  }
>>
>>  int
>> --
>> 2.17.0
>
> While we're at it, I just found that asyncread/asyncwrite return int.
> Shouldn't they return ssize_t?  That's 32 vs. 64 bit on x86_64.

Oops++.  Yes, of course.  Will do.  Saw no compiler warning for this.
Thanks,

..mark
