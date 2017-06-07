Return-Path: <cygwin-patches-return-8770-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 119090 invoked by alias); 7 Jun 2017 12:25:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 108382 invoked by uid 89); 7 Jun 2017 12:24:52 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-24.3 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.2 spammy=back!, corinna-cygwin@cygwin.com, U*corinna-cygwin, corinnacygwincygwincom
X-HELO: mail-yw0-f193.google.com
Received: from mail-yw0-f193.google.com (HELO mail-yw0-f193.google.com) (209.85.161.193) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 07 Jun 2017 12:24:50 +0000
Received: by mail-yw0-f193.google.com with SMTP id y64so531405ywe.0        for <cygwin-patches@cygwin.com>; Wed, 07 Jun 2017 05:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=njNKIhr1+o8LHil7q8+SV3PM0DHkjbgFVl4LW/0sTUc=;        b=E8l21/3+yMu13oS+2r61JxkN8ErQn5KTjmI9rEiSgMJnYm8iPS8aAXCXLnjDDhmXOI         QBRGWII9U5AiX1XHGKkGmGxYlY3hpfgve2M1PxON5E3S7rnpgwvpsUDBG3TjLi4j1n+q         mNyPR6vuGaAEgnX4Q5lw0N+La0eavhbmFIAKsw22mBlBXd1g9/PdFHsYZmPs0YqRMBKV         2kWWf9ViBmr8Q1k0umJb/vzQ67g8QJoOCFhQw3TuAGwM6Oaen0Q1rY4tTD71jVGTVMjH         C+VRfohmnO1ekWF2YPhfU794qQYdbjIkqpvfYC0MKIY4igsB1CJ6Og1rCnDuJlFt6n+e         NRvw==
X-Gm-Message-State: AODbwcBCV8PE5gqeKihCBdSCx/OMZpp2uigKkDfVvUe5WM1ujs5K0/up	DyIVrMeQTih5TjkZ7GOH1LPVZKwNlXI2
X-Received: by 10.129.108.75 with SMTP id h72mr6541662ywc.302.1496838292543; Wed, 07 Jun 2017 05:24:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.164.34 with HTTP; Wed, 7 Jun 2017 05:24:52 -0700 (PDT)
In-Reply-To: <20170606142311.GA23208@calimero.vinschen.de>
References: <20170511140534.26860-1-erik.m.bray@gmail.com> <20170511140534.26860-2-erik.m.bray@gmail.com> <20170606142311.GA23208@calimero.vinschen.de>
From: Erik Bray <erik.m.bray@gmail.com>
Date: Wed, 07 Jun 2017 12:25:00 -0000
Message-ID: <CAOTD34ayQcO4KXhmAPSJ949JYsYd9neOwtr0LDw=fumniFKXfg@mail.gmail.com>
Subject: Re: [PATCH] Ensure that a blocking send() on a socket returns (with success) if a signal is handled mid-transition and SA_RESTART is not set.
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset="UTF-8"
X-IsSubscribed: yes
X-SW-Source: 2017-q2/txt/msg00041.txt.bz2

On Tue, Jun 6, 2017 at 4:23 PM, Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> Hi Erik,
>
> [vacation-induced late reply]

No problem--you had been silent here for a while so I guessed you were
on vacation. Welcome back!

> On May 11 16:05, Erik M. Bray wrote:
>> ---
>>  winsup/cygwin/fhandler_socket.cc | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/winsup/cygwin/fhandler_socket.cc b/winsup/cygwin/fhandler_socket.cc
>> index f3d1d69..c7ed681 100644
>> --- a/winsup/cygwin/fhandler_socket.cc
>> +++ b/winsup/cygwin/fhandler_socket.cc
>> @@ -1851,7 +1851,7 @@ fhandler_socket::send_internal (struct _WSAMSG *wsamsg, int flags)
>>         if (get_socket_type () != SOCK_STREAM || ret < out_len)
>>           break;
>>       }
>> -      else if (is_nonblocking () || err != WSAEWOULDBLOCK)
>> +      else if (is_nonblocking () || WSAGetLastError() != WSAEWOULDBLOCK)
>>       break;
>>      }
>
> Thanks for catching!  Given that the loop isn't guaranteed to set `err'
> correctly all the time, I wonder if we shouldn't get rid of `err'
> completely.  Checking WSAGetLastError is plain user-space memory access
> anyway, and there's no reason the compiler can't optimize this by
> itself.

I agree, it can probably be removed entirely, likely resulting in clearer code.

> Also, I would prefer to have a shorter subject (<=72 chars or so) and
> to describe this in the log message a bit more detailed.
>
> Would you like to provide another patch along these lines?

Sure, no problem.

Erik
