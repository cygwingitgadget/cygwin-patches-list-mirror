Return-Path: <cygwin-patches-return-7941-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12072 invoked by alias); 8 Jan 2014 15:24:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 12033 invoked by uid 89); 8 Jan 2014 15:24:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mail-we0-f170.google.com
Received: from mail-we0-f170.google.com (HELO mail-we0-f170.google.com) (74.125.82.170) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-SHA encrypted) ESMTPS; Wed, 08 Jan 2014 15:24:01 +0000
Received: by mail-we0-f170.google.com with SMTP id u57so1380935wes.1        for <cygwin-patches@cygwin.com>; Wed, 08 Jan 2014 07:23:57 -0800 (PST)
MIME-Version: 1.0
X-Received: by 10.194.93.3 with SMTP id cq3mr83258720wjb.26.1389194637847; Wed, 08 Jan 2014 07:23:57 -0800 (PST)
Received: by 10.227.69.9 with HTTP; Wed, 8 Jan 2014 07:23:57 -0800 (PST)
In-Reply-To: <20140108143814.GA4931@ednor.casa.cgf.cx>
References: <CAOYw7dvP64FFXUJS60ixUqj2jr01Dzf3YrchyR79m7AQEb8TKA@mail.gmail.com>	<20131222071118.GB2110@ednor.casa.cgf.cx>	<CAOYw7dt68FHWKmaHwQ5bPoOZTODBAhbVFv5UkoiBbY1-kU6kjQ@mail.gmail.com>	<20140108143814.GA4931@ednor.casa.cgf.cx>
Date: Wed, 08 Jan 2014 15:24:00 -0000
Message-ID: <CAOYw7dsxk0jHi4npO3rYU16SVonZPN1Hht+ZveO1O=iQRRY3=Q@mail.gmail.com>
Subject: Re: [PATCH] Fix potentially uninitialized variable p
From: Ray Donnelly <mingw.android@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=ISO-8859-1
X-IsSubscribed: yes
X-SW-Source: 2014-q1/txt/msg00014.txt.bz2

On Wed, Jan 8, 2014 at 2:38 PM, Christopher Faylor wrote:
> On Wed, Jan 08, 2014 at 11:00:14AM +0000, Ray Donnelly wrote:
>>On Sun, Dec 22, 2013 at 7:11 AM, Christopher Faylor wrote:
>>> On Sun, Dec 22, 2013 at 12:40:20AM +0000, Ray Donnelly wrote:
>>>>-      PWCHAR p;
>>>>+      PWCHAR p = NULL;
>>>
>>> AFAICT, that would result in a NULL dereference.  I've checked in
>>> a different change to handle this.
>>
>>Thanks,
>>
>>A NULL dereference is maybe more consistent than the random
>>dereference that would have otherwise happened.
>>
>>I was only trying to ensure -Werror builds succeed.
>
> -Werror is the default for Cygwin.  This code has been around for a long
> time and the compiler has never complained before.  Nevertheless, if the
> compiler found a valid issue, making an invalid change to make it shut
> up is hardly "more consistent".
>

I meant more consistent from the "data is always zero so it'd be more
deterministically debuggable" perspective rather than what I think you
are implying.

I was using MSYS2's GCC 4.8.2 with DEBUG defined at -O0, AFAIR.

Do you build debug at -O0? Optimization passes can often remove the
possibility of a variable being uninitialized.

Anyway, thanks for fixing it properly.

> cgf
