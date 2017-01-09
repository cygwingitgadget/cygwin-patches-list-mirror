Return-Path: <cygwin-patches-return-8668-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 77528 invoked by alias); 9 Jan 2017 17:18:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 77497 invoked by uid 89); 9 Jan 2017 17:18:58 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.1 required=5.0 tests=BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_SORBS_SPAM,SPF_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mail-qk0-f196.google.com
Received: from mail-qk0-f196.google.com (HELO mail-qk0-f196.google.com) (209.85.220.196) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 09 Jan 2017 17:18:48 +0000
Received: by mail-qk0-f196.google.com with SMTP id a20so20119938qkc.3        for <cygwin-patches@cygwin.com>; Mon, 09 Jan 2017 09:18:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=UYJlLlbcKe/FKNy7QdL+Q3+5mBDTVghR7ZfK6C2TbLM=;        b=Zk2eRLV0ZJsGbyuhrJ0vp3ns2bA4kG8Suo5IKT9KfGO7kPV7X/ThYPLvJREm3tQry1         07Jdcz6PZfsgcC49vOkeP3oMd3qTRp8p+78TZoYfN2I/1xT2qZYBuOGQxOxYH0nzY49O         fpJuseBJS//YQbOIKbc/l3DOGyGxNcNA4cUvEPWsQ8oXjrfh+73jlJfDcnlEKDgJdBLo         j5CDfO+K0xmhhduJ87XlqEJZNjk1BX3oonftd7WD0YL4eeEpK4RQpUk5NllW8IjD9sIX         IKOQ4oArWh/ej1KVwS9Mo69bQrZ9WR5YSdkkO5NU827Wmhm5g/HqBTydKB2ezalTay2l         F0PA==
X-Gm-Message-State: AIkVDXK0gPCr3IfapInVoFt+NMPNG/hGeTf73bqgfM1bjr23BUHL4HogiOJKtgjq1i4A7aZNa1StXWIyPXhDZw==
X-Received: by 10.55.156.81 with SMTP id f78mr76479833qke.8.1483982326995; Mon, 09 Jan 2017 09:18:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.160.70 with HTTP; Mon, 9 Jan 2017 09:18:46 -0800 (PST)
In-Reply-To: <20170109165843.GA27881@calimero.vinschen.de>
References: <20170109163647.86144-1-erik.m.bray@gmail.com> <20170109165843.GA27881@calimero.vinschen.de>
From: Erik Bray <erik.m.bray@gmail.com>
Date: Mon, 09 Jan 2017 17:18:00 -0000
Message-ID: <CAOTD34Yig7V3zfrCUR5AfmeuaNFZYTfncAV5yhONzNC9sAvOHg@mail.gmail.com>
Subject: Re: [PATCH] Return the correct value for getsockopt(SO_REUSEADDR) after setting setsockopt(SO_REUSEADDR, 1).
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2017-q1/txt/msg00009.txt.bz2

On Mon, Jan 9, 2017 at 5:58 PM, Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> On Jan  9 17:36, Erik Bray wrote:
>> ---
>>  winsup/cygwin/net.cc | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/winsup/cygwin/net.cc b/winsup/cygwin/net.cc
>> index e4805d3..b02f9e3 100644
>> --- a/winsup/cygwin/net.cc
>> +++ b/winsup/cygwin/net.cc
>> @@ -925,6 +925,14 @@ cygwin_getsockopt (int fd, int level, int optname, void *optval,
>>         res = fh->getpeereid (&cred->pid, &cred->uid, &cred->gid);
>>         __leave;
>>       }
>> +      else if (optname == SO_REUSEADDR && level == SOL_SOCKET)
>> +    {
>> +      unsigned int *reuseaddr = (unsigned int *) optval;
>> +      *reuseaddr = fh->saw_reuseaddr();
>> +      *optlen = sizeof(*reuseaddr);
>                         ^^^
>                         space missing
>
>> +      res = 0;
>> +      __leave;
>> +    }
>
> Indentation of this block is wrong.
>
> Still, good catch.  I fixed the above manually and applied the patch
> as obvious (otherwise we're still needing your BSD sign-off).

Great, thanks!

I'll get back to you on the BSD sign-off and your comments on my other
patches tomorrow.

Thanks,
Erik
