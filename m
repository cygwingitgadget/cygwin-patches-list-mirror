Return-Path: <cygwin-patches-return-8655-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 128924 invoked by alias); 17 Nov 2016 12:09:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 128903 invoked by uid 89); 17 Nov 2016 12:09:17 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.5 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_SPAM,SPF_PASS autolearn=no version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mail-ua0-f182.google.com
Received: from mail-ua0-f182.google.com (HELO mail-ua0-f182.google.com) (209.85.217.182) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 17 Nov 2016 12:09:06 +0000
Received: by mail-ua0-f182.google.com with SMTP id b35so140456931uaa.3        for <cygwin-patches@cygwin.com>; Thu, 17 Nov 2016 04:09:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=6Sq04aMb1FOncMtwTImNfEnX5vYqJPy+4PRRFs2m7tc=;        b=m3ii6+6TpLFbjsJCxwDROx92S0rcolNwXoY2eWZt2T53sCe5Wj4NEAjl7gPNtYQ7AF         xVRZkH/MhmRvZDmf+kn4SqqmjptX0idhbcGhYK/p1Tq2VMV3b7ZPxQBJMntz+0AvYtti         /rUbTpCFWsdIJKc9vlxDrlZM8dMg6L3QHhfIBxUzZZqI2R9MOEK/t1et7f5zIcsoi8cD         +z0n0ZsAB94CMxfi8g2geMG6iJ7mhEJBEMPYwu5IzlY4QkamfdX2VYmx7yPHHJmsglWh         wwyAvgwGDrMvLW9Ka9xR+7M+ZqxZM1xy+DFWUhPMIWghs6QsML+N0Dj+8iW7vP1ucCh6         E7Nw==
X-Gm-Message-State: ABUngvcSSRYGpZqOKkKngGaDIX0iwchrzYr6meiGIjNcth98CjLLSolUBOXg7/I4riZMHpfk82xerO6HospHyg==
X-Received: by 10.176.64.234 with SMTP id i97mr1131524uad.7.1479384544671; Thu, 17 Nov 2016 04:09:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.103.80.207 with HTTP; Thu, 17 Nov 2016 04:09:03 -0800 (PST)
In-Reply-To: <20161117095453.GA29853@calimero.vinschen.de>
References: <CAOTD34ZMkY=Sfp6-8AFDg_Q=7NZB2oS+=QthfWauoboP6=szfg@mail.gmail.com> <20161115145849.GA25086@calimero.vinschen.de> <CAOTD34ajMRiL0RMJTrVvzK8bMwAta3XJ8Pi7sk27ww1B4HLp3Q@mail.gmail.com> <20161115161955.GD25086@calimero.vinschen.de> <CAOTD34Y=YeufL-kYHUsrQg1oWOdk3F_-Z+H6GSiadRXJ9LuRwA@mail.gmail.com> <6f461a14-f503-1aa1-e417-a5b4b24606bc@redhat.com> <CAOTD34biu0cNj5g7yS0GhUX2zTs6JDpdrvnFJ9knwPZMKJMzGw@mail.gmail.com> <20161117095453.GA29853@calimero.vinschen.de>
From: Erik Bray <erik.m.bray@gmail.com>
Date: Thu, 17 Nov 2016 12:09:00 -0000
Message-ID: <CAOTD34by3aHdEMsNiuPiOw+LPyH85kjkAoWAMRyNx6e6ERPxdw@mail.gmail.com>
Subject: Re: Return the correct value for sysconf(_SC_PAGESIZE)
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2016-q4/txt/msg00013.txt.bz2

On Thu, Nov 17, 2016 at 10:54 AM, Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> On Nov 16 15:51, Erik Bray wrote:
>> On Wed, Nov 16, 2016 at 3:01 PM, Eric Blake <eblake@redhat.com> wrote:
>> > On 11/16/2016 07:56 AM, Erik Bray wrote:
>> >
>> >>> There is no good reason to use the non-POSIXy page size.  It doesn't
>> >>> help you in the least for any pagesize-related functionality.  Mmap
>> >>> as well as malloc and friends only work with _SC_PAGESIZE sized pages.
>> >>>
>> >>> It sounds as if you're looking for a solution for which there's no
>> >>> problem...
>> >>
>> >>
>> >> FWIW the background here is that I'm working on porting psutil [1] to
>> >> Cygwin, and trying to accomplish as much as *possible* through the
>> >> POSIX interfaces without having to fall back on the Windows API.  It's
>> >> actually a great exercise in what is and isn't possible with Cygwin :)
>> >>
>> >> In this case I was trying to compute process memory usage from
>> >> /proc/<pid>/statm which gives values in page counts, so I need the
>> >> page size (the actual page size) to compute the values in bytes.
>> >
>> > If /proc/<pid>/statm is reporting memory in multiples that are not the
>> > POSIX _SC_PAGESIZE, that is a bug in the statm file emulation that
>> > should be fixed there.
>>
>> So then something like that attached (untested) patch should work,
>> though it made statm inconsistent with what is reported in
>> /proc/<pid>/status which reports memory in multiples of page size.  So
>> that has to be patched as well.
>
> Patches applied as obvious, thank you.
>
>> This of course leads to memory reporting that is inconsistent with
>> what Windows says.  But I guess if that's "normal" in Cygwin (for the
>> reasons stated by Corinna) then it's an acceptable trade-off?
>
> It is.  From the POSIX POV we have a 64K page size, from the Windows
> POV we have a bastard of 4K pages which can only be allocated in
> chunks of 16.  The latter simply doesn't fly well with POSIX
> assumptions.
>
> Since native Windows tools don't see the Cygwin internal assumptions,
> it doesn't matter, unless you mix Windows and Cygwin memory functions.
> Which, honestly, should only be done by Cygwin itself.

That works for me.  It makes things a bit tricky in my particular
case, but I admit it's an unusual one, and now that I'm aware of the
issue I can work with it.

Thanks for accepting the patch.

Erik
