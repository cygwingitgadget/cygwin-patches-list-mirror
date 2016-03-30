Return-Path: <cygwin-patches-return-8502-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 81961 invoked by alias); 30 Mar 2016 13:09:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 81944 invoked by uid 89); 30 Mar 2016 13:09:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=trees, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: mail-ob0-f176.google.com
Received: from mail-ob0-f176.google.com (HELO mail-ob0-f176.google.com) (209.85.214.176) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Wed, 30 Mar 2016 13:09:46 +0000
Received: by mail-ob0-f176.google.com with SMTP id fp4so64570604obb.2        for <cygwin-patches@cygwin.com>; Wed, 30 Mar 2016 06:09:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=o0lzHQDgAtRV3pz/FOaO0H9sgPoJxLwhsbNG5uxKYYA=;        b=FPwgHF4mLZEvTLIDnUBibbScg/92ruzO2ZEwi5+hblrtIGRj0pBRv/K04Br/931xHQ         pplRE96ehZJcH1hABIpxkNWp2nkEy+834wixd10Dvj2LYS0oBQ41COxf6dUNNl8YgHWN         ffmvXnLECCnYUJ1pC2y0/2RfLPX8ERUgwLfjrTfLlwaB8ADYdDkuTl+Jb4m9XcZNx9PL         JjwoH4RwJODqwaoru6Ivw312s/0gIDjq2Ull6aA2m/0YNwxmaLi/qakPgCgzqkvxnZz/         Ah7NEEsQh07yHg9j+Pdy9BvhDuxm3M8KRI63O3QtOtkRP+2Mvh/nOe/IW48+Qpa5CTgK         EafA==
X-Gm-Message-State: AD7BkJJPTq6PivHAFXtTewFLttoJLgg7nrOfCcrM9YLvcd/GKA1bf8ngRYpKVwxqV0gLxzmUha+6M/tFQ7jm7w==
X-Received: by 10.157.61.137 with SMTP id l9mr4354269otc.36.1459343335192; Wed, 30 Mar 2016 06:08:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.157.136 with HTTP; Wed, 30 Mar 2016 06:08:35 -0700 (PDT)
In-Reply-To: <20160330123108.GI3793@calimero.vinschen.de>
References: <1458740052-19618-1-git-send-email-pefoley2@pefoley.com> <1458740052-19618-3-git-send-email-pefoley2@pefoley.com> <20160330123108.GI3793@calimero.vinschen.de>
From: Peter Foley <pefoley2@pefoley.com>
Date: Wed, 30 Mar 2016 13:09:00 -0000
Message-ID: <CAOFdcFM9-0-ymF9K__vvd3YoYKybQTFGj-D+ySDHXTjKHTbffA@mail.gmail.com>
Subject: Re: [PATCH 3/3] Use just-built gcc for windres
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00208.txt.bz2

On Wed, Mar 30, 2016 at 8:31 AM, Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> Are you sure this works as desired?  In my standard cross build
> environment, the only -B option added here is
>
>   --preprocessor-arg=-B/build/cygwin/x86_64/vanilla/x86_64-pc-cygwin/newlib/

The only case in which -B is needed at all is for an in-tree build.
That is, gcc and winsup are in the same source tree, so CC is set to
something like ./gcc/xgcc.
In that case, the -B is necessary so that gcc knows where to find the
cc1 binary.
If gcc and winsup are built from separate source trees, it isn't an issue.

Thanks,

Peter
