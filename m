Return-Path: <cygwin-patches-return-8473-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 79253 invoked by alias); 21 Mar 2016 20:04:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 79236 invoked by uid 89); 21 Mar 2016 20:04:55 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: mail-ob0-f195.google.com
Received: from mail-ob0-f195.google.com (HELO mail-ob0-f195.google.com) (209.85.214.195) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Mon, 21 Mar 2016 20:04:54 +0000
Received: by mail-ob0-f195.google.com with SMTP id z10so14822198obg.0        for <cygwin-patches@cygwin.com>; Mon, 21 Mar 2016 13:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=TF/KYOn6JtEkiQSGGGto33752kU/ayBpg2z5tEhV+dw=;        b=IuBiW1kj/MDpTe4mMcBNDpzTA75LlkLZOJxYvr7SddSvVlYvx/l9yi2oU8abAu51Pv         ulQWR5Kg6pzSZQ7ZCfwj1SNklphkvFT7NPSm0cafgDy8eDy7cLGfB17M1T8JaBnqGGQh         pe2j8OlwzJ7ygLAM1ed7AqO6QoTFVlb1AW9Yq1xJ0SKegPwOIsepudpvJN7pCGtLt7+c         3A2HiJVEnzipJyINpG5uiAUtxuQ/IcKGbIpJyWk8dw7yaaquTKutpHLOA0v4DzKEa1mZ         SqMVaLSp973Gk3zlMVkRM5R/TIE8/0sU+FujCxAdx1LA7Fa8Bha/N/9tKMdrJV/9ldB4         qcKg==
X-Gm-Message-State: AD7BkJIfc9ACKGKMYOU1xb/xW489UlMw50bguIp/dWpFimhi10EYAdVOfZEBOQgfD/AOBtLJxbFlqvOgOaAGtg==
X-Received: by 10.182.47.165 with SMTP id e5mr20025246obn.69.1458590692500; Mon, 21 Mar 2016 13:04:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.86.194 with HTTP; Mon, 21 Mar 2016 13:04:32 -0700 (PDT)
In-Reply-To: <20160321195244.GJ14892@calimero.vinschen.de>
References: <1458580546-14484-1-git-send-email-pefoley2@pefoley.com> <1458580546-14484-2-git-send-email-pefoley2@pefoley.com> <20160321192450.GD14892@calimero.vinschen.de> <CAOFdcFP=cJyuiB=dPEqa2XpFV5jmVoepwr0CQ1=2R0j9bA-CHA@mail.gmail.com> <20160321195244.GJ14892@calimero.vinschen.de>
From: Peter Foley <pefoley2@pefoley.com>
Date: Mon, 21 Mar 2016 20:04:00 -0000
Message-ID: <CAOFdcFOc3A+MSDY+b+iKjWjBAsaQ_HJDnd=5n6W+2O7VV=3FvA@mail.gmail.com>
Subject: Re: [PATCH 2/5] Link against libdnsapi to avoid undefined reference
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00179.txt.bz2

On Mon, Mar 21, 2016 at 3:52 PM, Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> While you're at it, ideally we make ourselves independent of the MingW
> header version and use DnsFree directly, replacing DnsRecordListFree
> in autoload.cc and libc/minires-os-if.c, no?

Alright, I'll work on that.

Thanks,

Peter
