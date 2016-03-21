Return-Path: <cygwin-patches-return-8474-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 80666 invoked by alias); 21 Mar 2016 20:05:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 80649 invoked by uid 89); 21 Mar 2016 20:05:52 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:298, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches, carry
X-HELO: mail-ob0-f176.google.com
Received: from mail-ob0-f176.google.com (HELO mail-ob0-f176.google.com) (209.85.214.176) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Mon, 21 Mar 2016 20:05:50 +0000
Received: by mail-ob0-f176.google.com with SMTP id xj3so14768200obb.0        for <cygwin-patches@cygwin.com>; Mon, 21 Mar 2016 13:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=PlOc9azGAVLY31QothHAkF32xGqCitQXCHoUr0nkAW0=;        b=l29as0baFrEzO4xTnBFXcaG+ksPeqwPFLWYm0KOUfy5NqUuUA1Nik1gccePrBVj+/b         p/6zpjzafk6mJno2rkoYfm6BgOFErAAZIlqvfYmWshhuf2LYUKqSSjiVuFvb1qYZWyh0         IqbgLkmMAcauSp+UOFrQHNGE30nRJi8ZnRTQK3p2MAh6A4tD/22rvvClxKuVhjjyEBO4         LXlQmG1QfhmsFJ9J4Fwn1RMQqjEu8++LDPX4xoC8SPb7l+yyRMafuLmRZgtR+OJoVt1e         S//zpU6+k5ONk27qXHCn8IvB3F4Tq1phme8XxmlCsMw3t+RQIpWyI56nvn3inET+fS7U         koqA==
X-Gm-Message-State: AD7BkJLz/pIyZJRHW+m0MkB/HFlgIQZSRdcePuV8GSLrgNnGNq/M+OKckIPnp8e+t6Az8+X7hFFPxgEyCX69FQ==
X-Received: by 10.60.178.202 with SMTP id da10mr18168139oec.11.1458590748766; Mon, 21 Mar 2016 13:05:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.86.194 with HTTP; Mon, 21 Mar 2016 13:05:29 -0700 (PDT)
In-Reply-To: <20160321192550.GE14892@calimero.vinschen.de>
References: <CAOFdcFNPgJrf3KcNaOvmoT+Aj3Gp46w=ob=okPT0vwJ4TvMTCg@mail.gmail.com> <20160321192550.GE14892@calimero.vinschen.de>
From: Peter Foley <pefoley2@pefoley.com>
Date: Mon, 21 Mar 2016 20:05:00 -0000
Message-ID: <CAOFdcFMESQp3_Ddn8vqEibAY-=8Z+v5XOvFKPsaGGbP2RFLR+g@mail.gmail.com>
Subject: Re: Update toplevel files from gcc
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00180.txt.bz2

On Mon, Mar 21, 2016 at 3:25 PM, Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> Yes, but that's time-consuming since there's no automatism.  Give me
> a few days.

Sure, I can just carry my local patch until you get a chance to work on it.

Thanks,

Peter
