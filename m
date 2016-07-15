Return-Path: <cygwin-patches-return-8603-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 88705 invoked by alias); 15 Jul 2016 20:05:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 88691 invoked by uid 89); 15 Jul 2016 20:05:22 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:770, states, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: mail-wm0-f67.google.com
Received: from mail-wm0-f67.google.com (HELO mail-wm0-f67.google.com) (74.125.82.67) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Fri, 15 Jul 2016 20:05:12 +0000
Received: by mail-wm0-f67.google.com with SMTP id i5so3482460wmg.2        for <cygwin-patches@cygwin.com>; Fri, 15 Jul 2016 13:05:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=XlT7+PHfK0QNsOZPUw/2tLcDFZpQpvFG1aqJEhVMcD4=;        b=Nxaw+yduHdz1086Inou3nrqkM6IJaah56VW1Pr63NNkz208becPY4ECEKB/JF2ilj/         ZPOK60jdmmOICCQtQTMhZ2wanhL3YUYPhJH2tjdQWLXcr+EUH5WLOQl0XP1gdoVy3LFp         lZ6kLLgMRSpHnAA6KcHqaSbc98n5h42AflrxJtpYZcWRKsNriKH5T8VAqKm5s2+pkn3V         TRhOIH46FbRn4QOuBzWsq2kxKG4wYnuYGb9DLkqotabfYPFftUqU9fOvntlJfyfSE/j0         8rhp/mab7vJDgipMkqpoviXawbuSKwM3KGEok6NIct6DZ2zha5oYnoXx2MCY7srr15hM         McJw==
X-Gm-Message-State: ALyK8tKCE+X16Ex//L9k+ShTDRamSOmFnbNjwIXHr0ifFQ7x02250J0kqpixIwuxsLZkZdZ8cntBdj/JtuQqQw==
X-Received: by 10.28.182.136 with SMTP id g130mr23497806wmf.21.1468613109200; Fri, 15 Jul 2016 13:05:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.112.10 with HTTP; Fri, 15 Jul 2016 13:05:08 -0700 (PDT)
In-Reply-To: <20160714171215.GA19533@calimero.vinschen.de>
References: <CAOYw7dtjewWMjXR2iO5454smDBxDKkLP9HirZzT4hPqMzZdpeQ@mail.gmail.com> <20160714171215.GA19533@calimero.vinschen.de>
From: Ray Donnelly <mingw.android@gmail.com>
Date: Fri, 15 Jul 2016 20:05:00 -0000
Message-ID: <CAOYw7dtnK29GbYGoT_THS6_CXTfGUSRNQH_p2WPySrKccKRFhg@mail.gmail.com>
Subject: Re: [PATCH 01/01] machine/_types.h: __blkcnt_t should be signed
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2016-q3/txt/msg00011.txt.bz2

On Thu, Jul 14, 2016 at 6:12 PM, Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> On Jul 14 16:37, Ray Donnelly wrote:
>> Hi,
>>
>> Please review and consider applying the attached patch. The commit message is:
>>
>> [1] states: "blkcnt_t and off_t shall be signed integer types."
>> This causes pacman to fail when the size requirement
>> of the net update operation is negative, instead it
>> calculated a huge positive number.
>>
>> [1] http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/sys_types.h.html
>
> Patch applied.
>
>
> Thanks,
> Corinna
>

Many thanks Corinna.

> --
> Corinna Vinschen                  Please, send mails regarding Cygwin to
> Cygwin Maintainer                 cygwin AT cygwin DOT com
> Red Hat
