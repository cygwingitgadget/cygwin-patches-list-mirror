Return-Path: <cygwin-patches-return-8895-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29528 invoked by alias); 2 Nov 2017 15:21:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 29516 invoked by uid 89); 2 Nov 2017 15:21:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-25.1 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_SPAM,SPF_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:1065, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mail-io0-f169.google.com
Received: from mail-io0-f169.google.com (HELO mail-io0-f169.google.com) (209.85.223.169) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 02 Nov 2017 15:21:00 +0000
Received: by mail-io0-f169.google.com with SMTP id h70so14798258ioi.4        for <cygwin-patches@cygwin.com>; Thu, 02 Nov 2017 08:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=u4ab3QpHbgS2+LK0qTPDahD8CbpgNejN3IiHKUj5NJU=;        b=b4FipYl6cI2vfx25BAFnrSyfVvZbHrcgRnHy8rnumX9R5kyUkdp/b/sirMZmKTULUb         qEKlAo+1y7jIHzwW5hL4FrfDvDJ9lEvRhsOZ8vaO/UQD2JvJLjVPX3Eib4mh/rKVWK0O         1uDKoTRnHmguIZ8jt80PtfUcnGRBfTx9K9tNAL9FJKXaqHUjtiT2beIeJVMX53K9b8xx         hMmMbT1Hka/q6NKrugk3zHFE+mtPqtoYnQbNg18NvEQ3+o+Ks/ke/FgflFsH3kNEhhy+         OHL/tLcjZkhnHFn00uYCENK+bcbgw00QmZYRZlpq9KSXnOWkyNs9TdjyJ/UKF6x8dtAh         njpw==
X-Gm-Message-State: AMCzsaVqEJ4oWsMjnrR8xozZAoYuGpBrPskjRJcJ+zKp95pctqRvKhNN	EdAMZO8BH9iBmGHQla1IXm3JQiXr+trELPh8sU2gPQ==
X-Google-Smtp-Source: ABhQp+Tq9ryG8dyivAfOOzMnRtSv9elvByghxzdLWxH4ek31FgtFbaYG1JI+SRuZ7ghxBEXU1Lg1XMa8zsJxtnG0Tqw=
X-Received: by 10.36.62.3 with SMTP id s3mr3076248its.113.1509636058518; Thu, 02 Nov 2017 08:20:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.2.105.151 with HTTP; Thu, 2 Nov 2017 08:20:58 -0700 (PDT)
In-Reply-To: <20171102150604.GF8599@calimero.vinschen.de>
References: <20171102141512.4732-1-erik.m.bray@gmail.com> <20171102150604.GF8599@calimero.vinschen.de>
From: Erik Bray <erik.m.bray@gmail.com>
Date: Thu, 02 Nov 2017 15:21:00 -0000
Message-ID: <CAOTD34beHbdr9sGv_YtRHCPCOaTOxdkhq6=OC+-FuK8m5KhrgA@mail.gmail.com>
Subject: Re: [PATCH 2/2] posix_fallocate() *returns* error codes but does not set errno
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset="UTF-8"
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00025.txt.bz2

On Thu, Nov 2, 2017 at 4:06 PM, Corinna Vinschen wrote:
> Hi Erik,
>
> On Nov  2 15:15, Erik M. Bray wrote:
>> diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_disk_file.cc
>> index f46e355..9d5ec30 100644
>> --- a/winsup/cygwin/fhandler_disk_file.cc
>> +++ b/winsup/cygwin/fhandler_disk_file.cc
>> @@ -1116,11 +1116,11 @@ fhandler_disk_file::ftruncate (off_t length, bool allow_truncate)
>>    int res = -1;
>
> Shouldn't this initialization to -1 go away then?  Or set to 0 and...
>
>> @@ -1160,7 +1159,7 @@ fhandler_disk_file::ftruncate (off_t length, bool allow_truncate)
>>                                    &feofi, sizeof feofi,
>>                                    FileEndOfFileInformation);
>>        if (!NT_SUCCESS (status))
>> -     __seterrno_from_nt_status (status);
>> +     res = geterrno_from_nt_status (status);
>>        else
>>       res = 0;
>
> ...this else branch go away like you did in posix_fallocate?

Yes, I think you're right.  I'll rework this and the other patch per
your suggestions and re-post.

Thanks for the quick review,
Erik
