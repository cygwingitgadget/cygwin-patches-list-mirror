Return-Path: <cygwin-patches-return-8650-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21071 invoked by alias); 16 Nov 2016 13:56:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 19215 invoked by uid 89); 16 Nov 2016 13:56:19 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.3 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_SPAM,SPF_PASS autolearn=no version=3.3.2 spammy=Hx-languages-length:2701, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches, mass
X-HELO: mail-wm0-f51.google.com
Received: from mail-wm0-f51.google.com (HELO mail-wm0-f51.google.com) (74.125.82.51) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 16 Nov 2016 13:56:09 +0000
Received: by mail-wm0-f51.google.com with SMTP id a197so241079604wmd.0        for <cygwin-patches@cygwin.com>; Wed, 16 Nov 2016 05:56:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=DsUHB1iSvu1Db/LqCMK8/1lHL/nIBzI7MI3CV9SAfxI=;        b=C4XTJBc00tRePlg67Zt5r6W+rp1QIuVj5sE4p9bqe7gT0VtE+Tsi03cd1PnBVqeRQ+         EYGLXvvnKSFGh1qrlaRR8dzwyOY9QPPrMV6kgkDzvd29W1f1DH/ktvsAunD4LsThI51G         KxwSbQaAWYR8ruAUtb4uGDUzYhxUk42lqJMvUrpvOUEUXJhvzllWP214z3TJNbzY19ft         ZSgeXDzXpqYtgnjk+HeaO5sfxFsb15GOars1AvGFto8q015SwFo22ud9Rs32qhx0o5wJ         XMLKV4+jmUVl6d5iOt3h0SoQXtXOYQNGAzlAfDd8PICAgw1oXgQD/flA0qsNF4ihJTKe         4cQg==
X-Gm-Message-State: ABUngvea5GQ5OKdMYPtwx4F1uwZa0WsgvhPPJbRlXZItXxtF90PlBldJ13t2snl6wpzsXnKIkcyynKA1wqXqmw==
X-Received: by 10.194.191.161 with SMTP id gz1mr2026326wjc.22.1479304567090; Wed, 16 Nov 2016 05:56:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.151.145 with HTTP; Wed, 16 Nov 2016 05:56:06 -0800 (PST)
In-Reply-To: <20161115161955.GD25086@calimero.vinschen.de>
References: <CAOTD34ZMkY=Sfp6-8AFDg_Q=7NZB2oS+=QthfWauoboP6=szfg@mail.gmail.com> <20161115145849.GA25086@calimero.vinschen.de> <CAOTD34ajMRiL0RMJTrVvzK8bMwAta3XJ8Pi7sk27ww1B4HLp3Q@mail.gmail.com> <20161115161955.GD25086@calimero.vinschen.de>
From: Erik Bray <erik.m.bray@gmail.com>
Date: Wed, 16 Nov 2016 13:56:00 -0000
Message-ID: <CAOTD34Y=YeufL-kYHUsrQg1oWOdk3F_-Z+H6GSiadRXJ9LuRwA@mail.gmail.com>
Subject: Re: Return the correct value for sysconf(_SC_PAGESIZE)
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2016-q4/txt/msg00008.txt.bz2

On Tue, Nov 15, 2016 at 5:19 PM, Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> On Nov 15 16:47, Erik Bray wrote:
>> On Tue, Nov 15, 2016 at 3:58 PM, Corinna Vinschen
>> <corinna-cygwin@cygwin.com> wrote:
>> > On Nov 15 14:51, Erik Bray wrote:
>> >> Greetings,
>> >>
>> >> Currently sysconf(_SC_PAGESIZE) returns the value of
>> >> wincap.allocation_granularity()--a change I *think* had to have been
>> >> made by mistake in
>> >> https://cygwin.com/git/gitweb.cgi?p=newlib-cygwin.git;a=commit;f=winsup/cygwin/sysconf.cc;h=177dc6c7f6d0608ef6540fd997d9b444e324cae2
>> >>
>> >> There's no obvious reason, anyways, that this value should be returned
>> >> and not the actual page size.
>> >
>> > That's no accident, but a deliberate decision.  Originally we used the
>> > page size at this point, but that's long ago.  This has been discussed
>> > on the cygwin-developers mailing list years ago.  The problem is the
>> > POSIX assumption that the allocation granularity equals the page size.
>> > The only working solution which does not break assumptions is to return
>> > the allocation granularity as page size.
>>
>> Okay, sorry for suggesting otherwise.  When I looked at that commit it
>> seemed like a there was a lot of mass renaming going on, so I thought
>> it might have been an accident.  I didn't see the threads where this
>> was discussed.
>>
>> I see the reason for the change now, but the fact remains
>> sysconf(_SC_PAGESIZE) cannot, then, be relied on to make any
>> memory-related calculations from page counts.
>
> What do you mean?  If you call sysconf(_SC_PHYS_PAGES) or
> sysconf(_SC_AVPHYS_PAGES) you get the number of pages in _SC_PAGESIZE
> chunks so all is good.
>
>> Is there a different
>> (posix-compliant) way to get the actual page size, or at least maybe
>> it could be somewhere in /proc?
>
> There is no good reason to use the non-POSIXy page size.  It doesn't
> help you in the least for any pagesize-related functionality.  Mmap
> as well as malloc and friends only work with _SC_PAGESIZE sized pages.
>
> It sounds as if you're looking for a solution for which there's no
> problem...


FWIW the background here is that I'm working on porting psutil [1] to
Cygwin, and trying to accomplish as much as *possible* through the
POSIX interfaces without having to fall back on the Windows API.  It's
actually a great exercise in what is and isn't possible with Cygwin :)

In this case I was trying to compute process memory usage from
/proc/<pid>/statm which gives values in page counts, so I need the
page size (the actual page size) to compute the values in bytes.

Erik


[1] https://github.com/giampaolo/psutil
