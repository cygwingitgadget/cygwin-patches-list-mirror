Return-Path: <cygwin-patches-return-8071-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 59110 invoked by alias); 13 Mar 2015 10:04:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 59099 invoked by uid 89); 13 Mar 2015 10:04:03 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=1.7 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,KAM_FROM_URIBL_PCCC,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=no version=3.3.2
X-HELO: mail-qg0-f49.google.com
Received: from mail-qg0-f49.google.com (HELO mail-qg0-f49.google.com) (209.85.192.49) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Fri, 13 Mar 2015 10:04:02 +0000
Received: by qgaj5 with SMTP id j5so24526873qga.12        for <cygwin-patches@cygwin.com>; Fri, 13 Mar 2015 03:04:00 -0700 (PDT)
MIME-Version: 1.0
X-Received: by 10.140.202.209 with SMTP id x200mr49167190qha.44.1426241039945; Fri, 13 Mar 2015 03:03:59 -0700 (PDT)
Received: by 10.96.180.199 with HTTP; Fri, 13 Mar 2015 03:03:59 -0700 (PDT)
In-Reply-To: <20150313094412.GA20626@calimero.vinschen.de>
References: <CABEPuQJGji9Ue5E+j55to-u+VZV_oZ5kqF6piJFjhmMR+OJbhQ@mail.gmail.com>	<20150312192253.GD11522@calimero.vinschen.de>	<CABEPuQ+cpnyy3Ov6XHsLoJT=RDmNZoR7RvWwz0ZoqAieowcYgg@mail.gmail.com>	<20150313094412.GA20626@calimero.vinschen.de>
Date: Fri, 13 Mar 2015 10:04:00 -0000
Message-ID: <CABEPuQLGt+wvApfuDGihQoPf2SodQwBR3iCWdfgRK7VkneBOQQ@mail.gmail.com>
Subject: Re: braces around scalar initializer for type
From: Alexey Pavlov <alexpux@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2015-q1/txt/msg00026.txt.bz2

2015-03-13 12:44 GMT+03:00 Corinna Vinschen <corinna-cygwin@cygwin.com>:
> Hi Alexey,
>
> On Mar 12 22:47, Alexey Pavlov wrote:
>> 2015-03-12 22:22 GMT+03:00 Corinna Vinschen:
>> > I'm ok with that patch, but it's missing the ChangeLog entry,  Please
>> > provide ChangeLog entries per https://cygwin.com/contrib.html.
>>
>> + * net.cc: Remove extra braces.
>> +
>
> Please send the ChangeLog as plain text, not as diff.  It's not much of
> a problem in our current case, but ChangeLog diff's don't apply cleanly
> most of the time.

Ok will do next time.
>
>> -const struct in6_addr in6addr_any = {{IN6ADDR_ANY_INIT}};
>> -const struct in6_addr in6addr_loopback = {{IN6ADDR_LOOPBACK_INIT}};
>> +const struct in6_addr in6addr_any = IN6ADDR_ANY_INIT;
>> +const struct in6_addr in6addr_loopback = IN6ADDR_LOOPBACK_INIT;
>
> Patch applied.
>

Thanks!
>
> Thanks,
> Corinna
>
> --
> Corinna Vinschen                  Please, send mails regarding Cygwin to
> Cygwin Maintainer                 cygwin AT cygwin DOT com
> Red Hat
