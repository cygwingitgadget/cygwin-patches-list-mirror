Return-Path: <cygwin-patches-return-8463-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 44473 invoked by alias); 21 Mar 2016 19:46:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 44450 invoked by uid 89); 21 Mar 2016 19:46:19 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=untill, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: mail-oi0-f67.google.com
Received: from mail-oi0-f67.google.com (HELO mail-oi0-f67.google.com) (209.85.218.67) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Mon, 21 Mar 2016 19:46:18 +0000
Received: by mail-oi0-f67.google.com with SMTP id j206so6587099oig.1        for <cygwin-patches@cygwin.com>; Mon, 21 Mar 2016 12:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=tcoYODnFG8miouqdyO0q1t3RtvuxNlB8XMqFBO4poFs=;        b=JV/t8Z6aQ8JinjMMLuNV6nwie+Y2odMcNuhvAut0y1fZr+HE1FPLlW4BQiWqW/06YK         R4fnSmG2BFkEmHO8ro6QkfYkrCOw9gp0rDApu+74+4/gYEKrGIUh/CcfFKXGn8GHgBzA         R+xXA7OcSC8sX3qVdD0m+ujrrt27QI7KNsA9DaRyuwTXKW1DExICo5oEkhxrkLHLLQsf         oxTnJ4KJvWcQYbUS1EIsmyhldq5xG/qyrbx7fQviU83YeFodXPm1quX0S5bGNy3JYH91         DMwULpjazhTaUCHrpshambf11/ABrf17SntMV9MyC84bGzja1Q+02DTFdJYEAagrg/+J         6aNw==
X-Gm-Message-State: AD7BkJKzTlfl1aQyc3h0Y/7RorppRbwri89fUO9EN1BkaKfy3MBL8B0VhVBzhOFYS1mwXJPJXnk/DZxtHrGjAw==
X-Received: by 10.202.88.130 with SMTP id m124mr17789597oib.52.1458589576242; Mon, 21 Mar 2016 12:46:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.86.194 with HTTP; Mon, 21 Mar 2016 12:45:56 -0700 (PDT)
In-Reply-To: <20160321192450.GD14892@calimero.vinschen.de>
References: <1458580546-14484-1-git-send-email-pefoley2@pefoley.com> <1458580546-14484-2-git-send-email-pefoley2@pefoley.com> <20160321192450.GD14892@calimero.vinschen.de>
From: Peter Foley <pefoley2@pefoley.com>
Date: Mon, 21 Mar 2016 19:46:00 -0000
Message-ID: <CAOFdcFP=cJyuiB=dPEqa2XpFV5jmVoepwr0CQ1=2R0j9bA-CHA@mail.gmail.com>
Subject: Re: [PATCH 2/5] Link against libdnsapi to avoid undefined reference
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00169.txt.bz2

On Mon, Mar 21, 2016 at 3:24 PM, Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> On Mar 21 13:15, Peter Foley wrote:
>> /home/peter/cross/src/cygwin/winsup/cygwin/libc/minires-os-if.c:289:
>> undefined reference to `DnsFree'
>>
>> winsup/cygwin/ChangeLog
>> Makefile.in: Add libdnsapi to DLL_IMPORTS
>
> Apart from the fact that this is wrong and DnsFree should be added to
> autoload.cc instead, what exactly is that patch fixing?  DnsFree isn't
> used anywhere in Cygwin.

This fixes the above link error when building cygwin0.dll as part of a
cross toolchain.

The issue appears to be caused by this change in the mingw headers.
It probably won't show up for anybody not building against the latest
git version of mingw untill the next release.
https://github.com/mirror/mingw-w64/commit/38410a

I assume this function should still be added to autoload.cc, rather
then modifying DLL_IMPORTS.
I'll take a look at that.
