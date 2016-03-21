Return-Path: <cygwin-patches-return-8446-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 65246 invoked by alias); 21 Mar 2016 16:35:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 65234 invoked by uid 89); 21 Mar 2016 16:35:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=2373, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: mail-oi0-f66.google.com
Received: from mail-oi0-f66.google.com (HELO mail-oi0-f66.google.com) (209.85.218.66) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Mon, 21 Mar 2016 16:35:46 +0000
Received: by mail-oi0-f66.google.com with SMTP id n20so3438145oig.3        for <cygwin-patches@cygwin.com>; Mon, 21 Mar 2016 09:35:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=NdZxtgwZmBm0Lmu0R2Yn2ef7GNEJ80D0d1BTlhm8JJw=;        b=gw+eno9mE8Txh5lm8jjnKEzWDyloxTvBPtl1gVTKH90IVCSpJ0KB1kRmM/ExqDWvs0         mKS2M90LEWkwtaRHZrCT4k7QQWS+layBwfXovMFbP4WgMgYppZLd6ruSxKM+S2fDLaSy         hs5S46qKbkvgKjBVk+Buii+mUGavAtHOd7Fo8LtqpdlpeKeQeGsQGRRaRXwomPT57biO         U44xBk/2LwBS3XWm7WInBbkoCVhqSeM50xg8zDeXs0JNIhoTXKylVkDVcQlYNoHa8j5a         ulrElucdikbiN1IatWCBbm246HdR00h/qZMcwsHZ+qJmqs8wxtDBLGIiSA5sjIh+n1j5         oaQQ==
X-Gm-Message-State: AD7BkJLhFZIjtJWxTIUbGv1xGc5qgmi2HMdrTm7Enc8zNH1ExDC0cg1Bbb7p47m7aJ69xO2tt1s8l8Nw2G8YCw==
X-Received: by 10.202.195.146 with SMTP id t140mr17965356oif.26.1458578145013; Mon, 21 Mar 2016 09:35:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.86.194 with HTTP; Mon, 21 Mar 2016 09:35:25 -0700 (PDT)
In-Reply-To: <20160320112837.GO25241@calimero.vinschen.de>
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com> <1458409557-13156-9-git-send-email-pefoley2@pefoley.com> <20160320112837.GO25241@calimero.vinschen.de>
From: Peter Foley <pefoley2@pefoley.com>
Date: Mon, 21 Mar 2016 16:35:00 -0000
Message-ID: <CAOFdcFPP79BaO=KTpF5oB3ewdYCh6GmfaxoJr03kKY7dSOjrKw@mail.gmail.com>
Subject: Re: [PATCH 09/11] Add c++14 sized deallocation operator
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00152.txt.bz2

On Sun, Mar 20, 2016 at 7:28 AM, Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> This looks incomplete to me.  Don't we have to export the symbol?

I don't believe so.
As I understand it, if you're overriding the standard c++ delete
implementation, starting with c++14, you also need to provide an
implementation of the sized deallocation operator, which is designed
to increase performance of deallocation if the size of the object to
be deallocated is known.
See http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2013/n3663.html
However, the sized deallocation operator can simply be defined as an
call to the original delete operator, which simply preserves the
current behavior.
Adding this definition fixes a whole host of errors like the below:

 /home/peter/cross/src/cygwin/winsup/cygwin/fhandler_disk_file.cc:2373:
undefined reference to `operator delete(void*, unsigned long)'

Hope that makes more sense.

Thanks,

Peter
