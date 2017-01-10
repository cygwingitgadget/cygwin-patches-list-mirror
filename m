Return-Path: <cygwin-patches-return-8671-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 120575 invoked by alias); 10 Jan 2017 10:48:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 120562 invoked by uid 89); 10 Jan 2017 10:48:33 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.3 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_SPAM,SPF_PASS autolearn=no version=3.3.2 spammy=Hx-languages-length:2010, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mail-ua0-f193.google.com
Received: from mail-ua0-f193.google.com (HELO mail-ua0-f193.google.com) (209.85.217.193) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 10 Jan 2017 10:48:22 +0000
Received: by mail-ua0-f193.google.com with SMTP id i68so52257558uad.1        for <cygwin-patches@cygwin.com>; Tue, 10 Jan 2017 02:48:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=10fMRbilHlY6FliFQVWhHsLXKFwKWrfl+AAiWheApoM=;        b=JQfu7a3OYxE95IsT6l7bETN/YvpuWaBgTcQpkfMc4SDDi/LCVO1of7YyKV2nRwJmEZ         ZbMcXJaZPkO/t8J9VHl2JnvU1y/legzLcsvX9S1xQ0M8TO1/AT9rs7PwM6UvQtJ2cRdy         x7L1LSi6LBDxYFhh3tw0dneagK65qTLTntr6iG8W8ZdGzTYgbiK6DqHPlj6oRSZPt3AM         hLF00nHTe49eS1eTTyb9ew1IvjYKq8TA3OYpdAu9mWh0As1m6Ts+Hsf/uVgoXZtvRu/p         ersd/jwK6MQGfqILXN7cctoS/1QumfjMjGf0FVhtWGOoCY4h2qOIDKZGWQ+zJZqwGbVI         OI4A==
X-Gm-Message-State: AIkVDXJfWsWvzvmO6AMmcPAFS5t/r87mYjBT+klGrz47K51C0udoxaRIdOcobaZFQmuUYpGI+jBEEJbWqkHvpA==
X-Received: by 10.159.34.237 with SMTP id 100mr1256786uan.53.1484045300736; Tue, 10 Jan 2017 02:48:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.103.133.147 with HTTP; Tue, 10 Jan 2017 02:48:20 -0800 (PST)
In-Reply-To: <20170109144304.GA13527@calimero.vinschen.de>
References: <20170105173929.65728-1-erik.m.bray@gmail.com> <20170109144304.GA13527@calimero.vinschen.de>
From: Erik Bray <erik.m.bray@gmail.com>
Date: Tue, 10 Jan 2017 10:48:00 -0000
Message-ID: <CAOTD34a4VmiqfLADGPj8a0a4gR=UzR=1UNBu8dN6mmC=zBGuHA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add support for /proc/<pid>/environ
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2017-q1/txt/msg00012.txt.bz2

On Mon, Jan 9, 2017 at 3:43 PM, Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> Hi Erik,
>
> On Jan  5 18:39, erik.m.bray@gmail.com wrote:
>> From: "Erik M. Bray" <erik.bray@lri.fr>
>>
>> Per this discussion started in this thread: https://cygwin.com/ml/cygwin/2016-11/msg00205.html
>>
>> I finally got around to finishing a patch for this feature. It supports both Cygwin and
>> native Windows processes, more or less following the example of how /proc/<pid>/cmdline is
>> implemented.
>>
>> Erik M. Bray (3):
>>   Move the core environment parsing of environ_init into a new
>>     win32env_to_cygenv function.
>>   Add a _pinfo.environ() method analogous to _pinfo.cmdline(), and
>>     others.
>>   Add a /proc/<pid>/environ proc file handler, analogous to
>>     /proc/<pid>/cmdline.
>>
>>  winsup/cygwin/environ.cc          | 84 +++++++++++++++++++++---------------
>>  winsup/cygwin/environ.h           |  2 +
>>  winsup/cygwin/fhandler_process.cc | 22 ++++++++++
>>  winsup/cygwin/pinfo.cc            | 89 ++++++++++++++++++++++++++++++++++++++-
>>  winsup/cygwin/pinfo.h             |  4 +-
>>  5 files changed, 163 insertions(+), 38 deletions(-)
>
> Patch looks good basically, but I have a few nits:
>
> - We need your 2-clause BSD license text per the "Before you get started"
>   section of https://cygwin.com/contrib.html.  For the text see
>   https://cygwin.com/git/?p=newlib-cygwin.git;a=blob;f=winsup/CONTRIBUTORS
>
> - While this appears to work nicely on other processes, it seems to be
>   broken on the process itself.  Did you try `cat /proc/self/environ'?
>   I'm getting a "Bad address" error when trying that.
>
> - A few formatting issues, see my next replies.
>
> Other than that, thanks for this nice addition!

Incidentally, I don't think I did test `/proc/self/environ`.  I'll
certainly fix whatever's wrong with that.

When I fix that and the issues you pointed out on the other patches,
should I just submit a new patch set?  When I do so I can also include
the BSD license statement.

Thanks,
Erik
