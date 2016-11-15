Return-Path: <cygwin-patches-return-8646-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 91076 invoked by alias); 15 Nov 2016 15:47:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 91065 invoked by uid 89); 15 Nov 2016 15:47:15 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.3 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_SPAM,SPF_PASS autolearn=no version=3.3.2 spammy=mass, sk:corinna, corinna-cygwin@cygwin.com, U*corinna-cygwin
X-HELO: mail-wm0-f54.google.com
Received: from mail-wm0-f54.google.com (HELO mail-wm0-f54.google.com) (74.125.82.54) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 15 Nov 2016 15:47:05 +0000
Received: by mail-wm0-f54.google.com with SMTP id t79so7122765wmt.0        for <cygwin-patches@cygwin.com>; Tue, 15 Nov 2016 07:47:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=5xzlQWR4d8Fi731+FnDSQMBozj1oj6Gzm8MjMrYioL8=;        b=bZuP0F5ZK2zXH9TUPIfcQXM6M5Whg/aE2Jz136uR9yik+nfx/y5k1oFH78JaFHHlNH         4Sb7FRO7AcqSul9LfEjj54DWwy1kW1NMQkGvCDTljfZ3Jux7wEi4UlxxDPtHN8TyERMZ         A6aNkWPomBrxEUmWHSuqA2kPA4Zm7yLLimnVcI5jec9Tw+/XDj5zjORcGK/Klh+R3Vdk         LO8r6SsEva6At+0yrroiKSf3GiS7iuzcB2Ut+QJivbL8F7amMlAj/lTXngSTI4ELYGI3         BXAhRatTqXBeezYIMmeQYM45U6iMHLJkHnvj226IwmI0ooPFjCtXplCnZz570/pAfcWO         rRwA==
X-Gm-Message-State: ABUngvdNtUOwzRxRaQ6++k5OzJ/stZ2Cb+gALlVgp2MPsS2v9zg8BLI6F2o27okqqH2kyOBxDugBYS1if6l7IQ==
X-Received: by 10.28.98.130 with SMTP id w124mr4695215wmb.125.1479224823494; Tue, 15 Nov 2016 07:47:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.151.145 with HTTP; Tue, 15 Nov 2016 07:47:02 -0800 (PST)
In-Reply-To: <20161115145849.GA25086@calimero.vinschen.de>
References: <CAOTD34ZMkY=Sfp6-8AFDg_Q=7NZB2oS+=QthfWauoboP6=szfg@mail.gmail.com> <20161115145849.GA25086@calimero.vinschen.de>
From: Erik Bray <erik.m.bray@gmail.com>
Date: Tue, 15 Nov 2016 15:47:00 -0000
Message-ID: <CAOTD34ajMRiL0RMJTrVvzK8bMwAta3XJ8Pi7sk27ww1B4HLp3Q@mail.gmail.com>
Subject: Re: Return the correct value for sysconf(_SC_PAGESIZE)
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2016-q4/txt/msg00004.txt.bz2

On Tue, Nov 15, 2016 at 3:58 PM, Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> On Nov 15 14:51, Erik Bray wrote:
>> Greetings,
>>
>> Currently sysconf(_SC_PAGESIZE) returns the value of
>> wincap.allocation_granularity()--a change I *think* had to have been
>> made by mistake in
>> https://cygwin.com/git/gitweb.cgi?p=newlib-cygwin.git;a=commit;f=winsup/cygwin/sysconf.cc;h=177dc6c7f6d0608ef6540fd997d9b444e324cae2
>>
>> There's no obvious reason, anyways, that this value should be returned
>> and not the actual page size.
>
> That's no accident, but a deliberate decision.  Originally we used the
> page size at this point, but that's long ago.  This has been discussed
> on the cygwin-developers mailing list years ago.  The problem is the
> POSIX assumption that the allocation granularity equals the page size.
> The only working solution which does not break assumptions is to return
> the allocation granularity as page size.

Okay, sorry for suggesting otherwise.  When I looked at that commit it
seemed like a there was a lot of mass renaming going on, so I thought
it might have been an accident.  I didn't see the threads where this
was discussed.

I see the reason for the change now, but the fact remains
sysconf(_SC_PAGESIZE) cannot, then, be relied on to make any
memory-related calculations from page counts.  Is there a different
(posix-compliant) way to get the actual page size, or at least maybe
it could be somewhere in /proc?

Sorry otherwise for the noise.

Thanks,
Erik
