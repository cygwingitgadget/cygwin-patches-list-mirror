Return-Path: <cygwin-patches-return-7938-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6265 invoked by alias); 8 Jan 2014 11:00:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 6252 invoked by uid 89); 8 Jan 2014 11:00:19 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mail-wg0-f45.google.com
Received: from mail-wg0-f45.google.com (HELO mail-wg0-f45.google.com) (74.125.82.45) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-SHA encrypted) ESMTPS; Wed, 08 Jan 2014 11:00:17 +0000
Received: by mail-wg0-f45.google.com with SMTP id y10so1263647wgg.0        for <cygwin-patches@cygwin.com>; Wed, 08 Jan 2014 03:00:14 -0800 (PST)
MIME-Version: 1.0
X-Received: by 10.194.93.3 with SMTP id cq3mr82099315wjb.26.1389178814466; Wed, 08 Jan 2014 03:00:14 -0800 (PST)
Received: by 10.227.69.9 with HTTP; Wed, 8 Jan 2014 03:00:14 -0800 (PST)
In-Reply-To: <20131222071118.GB2110@ednor.casa.cgf.cx>
References: <CAOYw7dvP64FFXUJS60ixUqj2jr01Dzf3YrchyR79m7AQEb8TKA@mail.gmail.com>	<20131222071118.GB2110@ednor.casa.cgf.cx>
Date: Wed, 08 Jan 2014 11:00:00 -0000
Message-ID: <CAOYw7dt68FHWKmaHwQ5bPoOZTODBAhbVFv5UkoiBbY1-kU6kjQ@mail.gmail.com>
Subject: Re: [PATCH] Fix potentially uninitialized variable p
From: Ray Donnelly <mingw.android@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=ISO-8859-1
X-IsSubscribed: yes
X-SW-Source: 2014-q1/txt/msg00011.txt.bz2

On Sun, Dec 22, 2013 at 7:11 AM, Christopher Faylor wrote:
> On Sun, Dec 22, 2013 at 12:40:20AM +0000, Ray Donnelly wrote:
>>-      PWCHAR p;
>>+      PWCHAR p = NULL;
>
> AFAICT, that would result in a NULL dereference.  I've checked in
> a different change to handle this.

Thanks,

A NULL dereference is maybe more consistent than the random
dereference that would have otherwise happened.

I was only trying to ensure -Werror builds succeed.

>
> cgf
