Return-Path: <nejamuljumu1203@gmail.com>
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 by sourceware.org (Postfix) with ESMTPS id 924883856DE7
 for <cygwin-patches@cygwin.com>; Wed, 11 May 2022 14:56:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 924883856DE7
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-xe30.google.com with SMTP id t85so2269517vst.4
 for <cygwin-patches@cygwin.com>; Wed, 11 May 2022 07:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GCvsDvw2I77be3/0RPDwXIpMeqrlhuvK1CtZ7esLlwI=;
 b=aaUYRTU82RjQBTIzPOtjfWyscW1eAT4I8cvol/GeL1IadboMKZjLQoUbTP6QCCInFE
 SyPsHsPf6ChXFdOFkgKwDz9kamQWe+LHkVOxrNC/S4UodbRp+UyeK3lP0qnC56yJFuf5
 I9U0loRKR9l0h2eogqe7ZBHpI/7TxQ/xd4+gzc9jTFgXK9tg0jin3cJsygJk9LzcHY7+
 mt4aXXVuXNf3fAkDKIzpm98jpsk4KuLP0NbT+xSlFn9vZrux3BI/g6GR63wjAbnBvkrf
 FYzT76LF6bUGTPJIuTLetn3hRBhoxg1on0h70JZP/bHsGnP8l3+JOC8h/f/4AhiJ9BbP
 OvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GCvsDvw2I77be3/0RPDwXIpMeqrlhuvK1CtZ7esLlwI=;
 b=p2kEUcbSthfpa2JqoPWLYszX9SGHIxzwNqnLYulDpi2+4PcE+2iJXqO7Wj0Wisch6q
 rh0sn+haozgnHi6Y7BXFX//4wJgPeErvaeHSgQlNUhUleEyCYzfFYZhFJOX9n8yJs/QR
 h5skLGWklFHehGpakNE5YZ7NpyXfoXzRB0NyX/g9CCDAjSy++pKYUDbQdctwo1bYWu5A
 ruWvwwONvwpFXJyBaddZ+/ZfziLOP5+e9hPFwhv+vwDPbqgUNpWtieJoUW3Iv5N6IYDu
 XjKbCOKqFz6oNYyu9zc9/pHApMF8zpLyJaDnollNi+TcLGv/Ue4OdbLd+0uYoAZUb6Ov
 gKYg==
X-Gm-Message-State: AOAM533qD6I8a1BqC7narvJU54INVAAIF4J8PeAtCJa9EWRPvZKjpibv
 z5tRdQRfxLuDPl7EAIFNMZZBCxLwxFH4H134OmL6kf5J93TnkQ==
X-Google-Smtp-Source: ABdhPJy9RTauD7KzD7kHBJmpkZ7YOG+HBhKJXxB6Qg6krTJgTjHV2yg3+bylTUrjkvDw9r5XOsVDASzCIpAuGU+e4Uc=
X-Received: by 2002:a67:2d17:0:b0:32c:e934:770e with SMTP id
 t23-20020a672d17000000b0032ce934770emr13447606vst.85.1652280967848; Wed, 11
 May 2022 07:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220510144443.5555-1-Brian.Inglis@SystematicSW.ab.ca>
In-Reply-To: <20220510144443.5555-1-Brian.Inglis@SystematicSW.ab.ca>
From: Mohammad HOQUE <nejamuljumu1203@gmail.com>
Date: Wed, 11 May 2022 20:55:58 +0600
Message-ID: <CAFgkkcsxPgp98_eC3Vdkj+g3Dte3xm1gUC5F3T0NeGOD9bcRgA@mail.gmail.com>
Subject: Re: [PATCH 0/1] fhandler_process.cc(format_process_stat): fix
 /proc/pid/stat issues
To: Brian Inglis <Brian.Inglis@systematicsw.ab.ca>
Cc: Cygwin Patches <cygwin-patches@cygwin.com>
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, FREEMAIL_ENVFROM_END_DIGIT,
 FREEMAIL_FROM, HTML_MESSAGE, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
 TXREP, T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Wed, 11 May 2022 14:56:10 -0000

On Tue, May 10, 2022, 8:45 PM Brian Inglis <Brian.Inglis@systematicsw.ab.ca>
wrote:

> Noticed some issues with x86 32 bit procps and checked /proc/pid/stat which
> looked misaligned compared to x86_64 64 bit, due to int64_t format
> mismatches.
> There were also issues with the tty_nr encoding (uses ctty which has major
> in
> top 16 bits and minor in bottom 16 bits, where tty_nr is specified to have
> major in bits 15:8 and minor across 31:20 and 7:0) and rsslim units in
> bytes
> not pages.
> This patch fixes those issues.
> Below are the old and new /proc/pid/stat values and decoded listings for 32
> bit; only tty_nr and rsslim values changed in 64 bit; tty_nr listing
> decoding
> was also changed after.
>
> ==> proc-pid-stat-old-32.log <==
> 1025 (bash) S 1024 1025 1025 8912896 -1 0 147513 147513 0 0 49546 0 45000
> 49546 45000 0 20 0 0 4115675647 0 7397376
>
> ==> proc-pid-stat-new-32.log <==
> 27991 (bash) S 1 27991 1025 34816 -1 0 9662 9662 0 0 312 562 312 562 20 0
> 0 0 5113740411 7241728 2901 1413120
>
> ==> proc-pid-stat-list-old-32.log <==
> CLK_TCK 1000 PAGE_SIZE 65536 boot time 5110786.43
>  1 pid                1025 process
>  2 comm             (bash) executable
>  3 state                 S ?
>  4 ppid               1024 parent
>  5 pgrp               1025 group
>  6 session            1025 id
>  7 tty_nr         136    0 15:8,31:20,7:0
>  8 tpgid                -1 group
>  9 flags                 0 sys
> 10 minflt           147425 minor
> 11 cminflt          147425 minorchild
> 12 majflt                0 major
> 13 cmajflt               0 majorchild
> 14 utime            49.546 user
> 15 stime             0.000 sys
> 16 cutime           44.984 userchild
> 17 cstime           49.546 syschild
> 18 priority          44984 0..39->-20..19
> 19 nice                  0 -20..19
> 20 num_threads          20 threads
> 21 itrealvalue           0 timer
> 22 starttime   59 3:39:46.430 start
> 23 vsize        4115675647 memory
> 24 rss                   0 pages
> 25 rsslim          7397376 limit
>
> ==> proc-pid-stat-list-new-32.log <==
> CLK_TCK 1000 PAGE_SIZE 65536 boot time 5114365.42
>  1 pid               27991 process
>  2 comm             (bash) executable
>  3 state                 S ?
>  4 ppid                  1 parent
>  5 pgrp              27991 group
>  6 session            1025 id
>  7 tty_nr         136    0 15:8,31:20,7:0
>  8 tpgid                -1 group
>  9 flags                 0 sys
> 10 minflt             9662 minor
> 11 cminflt            9662 minorchild
> 12 majflt                0 major
> 13 cmajflt               0 majorchild
> 14 utime             0.312 user
> 15 stime             0.562 sys
> 16 cutime            0.312 userchild
> 17 cstime            0.562 syschild
> 18 priority             20 0..39->-20..19
> 19 nice                  0 -20..19
> 20 num_threads           0 threads
> 21 itrealvalue           0 timer
> 22 starttime     10:25.009 start
> 23 vsize           7241728 memory
> 24 rss                2901 pages
> 25 rsslim          1413120 limit
>
> Brian Inglis (1):
>   fhandler_process.cc(format_process_stat): fix /proc/pid/stat issues
>
>  winsup/cygwin/fhandler_process.cc | 33 +++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 13 deletions(-)
>
> --
> 2.36.0
>
>
