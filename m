Return-Path: <cygwin-patches-return-8472-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 78234 invoked by alias); 21 Mar 2016 20:04:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 78181 invoked by uid 89); 21 Mar 2016 20:04:12 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: mail-ob0-f196.google.com
Received: from mail-ob0-f196.google.com (HELO mail-ob0-f196.google.com) (209.85.214.196) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Mon, 21 Mar 2016 20:04:11 +0000
Received: by mail-ob0-f196.google.com with SMTP id e7so15745367obv.2        for <cygwin-patches@cygwin.com>; Mon, 21 Mar 2016 13:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=ujflxZa5qPM9P379y50Zm/04tn1OB/0YhQ4LXunXurY=;        b=Q1oiu5lbEJovroR9u+baFb+VX7rzbI25xoqDfE0aVMTBJNEnHeBaeVYDFmd7qrqNsp         z0tn76QDvxPbnuVnd0HFJCR1Yi2QmnrgoGd9eJ/Jl0ymVs6AQJFMMN06PA9wNrAkP772         gLEeb4hpEeCsWA5Yyf70tloD6rBCDRc+WehoYc7bdm7dDpD/gnTJgCcpUJ/O1s455i3q         6gsjJxRaG+qTEuyYOJVGPW/zIkMhF0w+gdO/vbIREVYkaLABIZ6DzsDYfQvKzjprBLWb         EvQ3CPbSzIH1MIGnYIGBlOVnLoy/hcbLMC75WKUxDD4NRNqgkYmsE6xyqpt1vxd4Trn6         Nx5A==
X-Gm-Message-State: AD7BkJIQQDAlhFuaYTrQjCMsmgdnOJQZDFxR1sHg3E+IKgbs71UQkf1UltIT3SfFXHHBy6So+AXS1D72Gxr5Ag==
X-Received: by 10.60.141.227 with SMTP id rr3mr18339288oeb.57.1458590650022; Mon, 21 Mar 2016 13:04:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.86.194 with HTTP; Mon, 21 Mar 2016 13:03:50 -0700 (PDT)
In-Reply-To: <20160321195524.GK14892@calimero.vinschen.de>
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com> <1458409557-13156-9-git-send-email-pefoley2@pefoley.com> <20160320112837.GO25241@calimero.vinschen.de> <CAOFdcFPP79BaO=KTpF5oB3ewdYCh6GmfaxoJr03kKY7dSOjrKw@mail.gmail.com> <20160321171314.GA14892@calimero.vinschen.de> <CAOFdcFM1D17HSiLdeNv=S6zim6wOcqY41Ud-iTtiDLrN_YRYOg@mail.gmail.com> <20160321180903.GB14892@calimero.vinschen.de> <CAOFdcFN4wkv40M-BJPhhHwjaDxh7YD7iXDhLaUcnW6qw=pwnYg@mail.gmail.com> <20160321195524.GK14892@calimero.vinschen.de>
From: Peter Foley <pefoley2@pefoley.com>
Date: Mon, 21 Mar 2016 20:04:00 -0000
Message-ID: <CAOFdcFOSdpT3Bi=dne+8MQc82Oyio5atpeDF-W7yUMn-mhR3ew@mail.gmail.com>
Subject: Re: [PATCH 09/11] Add c++14 sized deallocation operator
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00178.txt.bz2

On Mon, Mar 21, 2016 at 3:55 PM, Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> But using -std= when building Cygwin wouldn't change the fact that we
> might need this delete anyway for applications built with -std=c++14
> or do I miss something?

This patch is specifically for building cygwin1.dll
I haven't tested building programs with -std=c++14, but that should
not be affected at all by this patch.
I believe the only reason this issue occurs at all is that cygwin1.dll
explicitly does not link with libstdc++.

Thanks,

Peter
