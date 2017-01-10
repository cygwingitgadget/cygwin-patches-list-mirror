Return-Path: <cygwin-patches-return-8673-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19293 invoked by alias); 10 Jan 2017 10:57:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 19273 invoked by uid 89); 10 Jan 2017 10:56:59 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.3 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_SPAM,SPF_PASS autolearn=no version=3.3.2 spammy=acknowledge, tabs, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mail-ua0-f193.google.com
Received: from mail-ua0-f193.google.com (HELO mail-ua0-f193.google.com) (209.85.217.193) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 10 Jan 2017 10:56:49 +0000
Received: by mail-ua0-f193.google.com with SMTP id i68so52272726uad.1        for <cygwin-patches@cygwin.com>; Tue, 10 Jan 2017 02:56:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=apW4B8wz3nW5pAJXeRdaP4ylHG0jSvU6GmdBFuVZVhg=;        b=O5Yyc2kSm4j9/6q/f8tPFnhzbuh6YbP/UbOs4Wzvu9wJtClOQCvVFLmhYNFiNKYxQd         COkRITJImxSYhBfD1jSqfE3ReKVdc4rNm5R2H+K/NaYolESiippCpK0Sff7PzJWVsOYp         whmZfctgVM/LB8I6w/Dg64RH0wLDfRfrqz78Je52bSLKNMia3TNPC/JicGihb2Q9Mjux         kv2By/upPA2EGLw6JIuCc8sw68vaLDoSwoGHaG5rx9VtQh0M/BA6NMNXpGjAgZF3p2Lt         qdjMtqiLmLGLeqUDwMUkCRRnc5ecmAkHo7TXhaBHezNsvaV1rpKpdfxVNTkaKyS03cdG         sO+g==
X-Gm-Message-State: AIkVDXLrvjAaSejnHdM01Jj509v/7z4f7yxCAwjOb2DymGgtXrrhaaq+PotZQpyAZ3xBsxE0XMudEp0Q1yhAiQ==
X-Received: by 10.159.34.237 with SMTP id 100mr1272240uan.53.1484045807453; Tue, 10 Jan 2017 02:56:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.103.133.147 with HTTP; Tue, 10 Jan 2017 02:56:46 -0800 (PST)
In-Reply-To: <20170109145813.GC13527@calimero.vinschen.de>
References: <20170105173929.65728-1-erik.m.bray@gmail.com> <20170105173929.65728-3-erik.m.bray@gmail.com> <20170109145813.GC13527@calimero.vinschen.de>
From: Erik Bray <erik.m.bray@gmail.com>
Date: Tue, 10 Jan 2017 10:57:00 -0000
Message-ID: <CAOTD34YRzFfRfjLjxQ5HZDj2RGPpzz_9DAwg6yrSbGA3pv-ybQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] Add a _pinfo.environ() method analogous to _pinfo.cmdline(), and others.
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2017-q1/txt/msg00014.txt.bz2

On Mon, Jan 9, 2017 at 3:58 PM, Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> On Jan  5 18:39, Erik M. Bray wrote:
>> diff --git a/winsup/cygwin/pinfo.cc b/winsup/cygwin/pinfo.cc
>> index 1ce6809..a3e376c 100644
>> --- a/winsup/cygwin/pinfo.cc
>> +++ b/winsup/cygwin/pinfo.cc
>> @@ -653,8 +653,29 @@ commune_process (void *arg)
>>       else if (!WritePipeOverlapped (tothem, path, n, &nr, 1000L))
>>         sigproc_printf ("WritePipeOverlapped fd failed, %E");
>>       break;
>> -      }
>> -    }
>> +       }
>> +     case PICOM_ENVIRON:
>> +       {
>> +     sigproc_printf ("processing PICOM_ENVIRON");
>> +     unsigned n = 0;
>> +    char **env = cur_environ ();
>> +    for (char **e = env; *e; e++)
>> +        n += strlen (*e) + 1;
>> +     if (!WritePipeOverlapped (tothem, &n, sizeof n, &nr, 1000L))
>> +       {
>> +         sigproc_printf ("WritePipeOverlapped sizeof argv failed, %E");
>> +       }
>
>           No curlies here, please, just as in sibling cases.
>
>> +     else
>> +       for (char **e = env; *e; e++)
>> +         if (!WritePipeOverlapped (tothem, *e, strlen (*e) + 1, &nr, 1000L))
>> +           {
>> +             sigproc_printf ("WritePipeOverlapped arg %d failed, %E",
>> +                             e - env);
>> +             break;
>> +           }
>> +     break;
>> +       }
>> +     }
>
> Please have another look into the PICOM_ENVIRON case.  Indentation is
> completely broken in this code snippet, as if it has been moved around
> a bit and then left at the wrong spot.

One note on indentation: I tried to be consistent but it's hard
because in that file and others there's a lot of mixing of tabs and
spaces.  I'm happy to get everything cleaned up, I'm just not sure
what the "intended" convention is wrt tabs vs. spaces (I know you're
using the GNU coding standards otherwise).

Would you welcome a separate patch with general whitespace cleanup?

I acknowledge and can fix every other point.

Thanks,
Erik
