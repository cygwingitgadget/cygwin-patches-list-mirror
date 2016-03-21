Return-Path: <cygwin-patches-return-8462-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12865 invoked by alias); 21 Mar 2016 19:35:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 12778 invoked by uid 89); 21 Mar 2016 19:35:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:1024, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: mail-oi0-f65.google.com
Received: from mail-oi0-f65.google.com (HELO mail-oi0-f65.google.com) (209.85.218.65) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Mon, 21 Mar 2016 19:35:00 +0000
Received: by mail-oi0-f65.google.com with SMTP id j206so6555226oig.1        for <cygwin-patches@cygwin.com>; Mon, 21 Mar 2016 12:34:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to:content-transfer-encoding;        bh=dR3IZEizp+5jWj12iVO4IjS/1MUSkh3/iZBKVkWAKyE=;        b=NbQ9HlaFtbbTHvgcy8D/3PqJIjCTdsIKIpp+4v9rpwnnJdNoH+lNHrO6QhvsTsuwxh         NPAWIwurKpRZAnj2qwFUK03XtlTCMjFC640beW7XjI+YC49m8fxVI7sREk8mTMZxkQpr         T3Kt5Nl7sgmCnu21NuSGlcblPuyuvYtpsqStdjh08/c8JHh4saNyoxBqsTLo74uQT/rs         QcVYFxCPWOfk19oNRmNLNTnSyK3Lal64Ot6G4gEmLbqjmM7MqEkGRVaXBtYz28VbZ8r6         nGJ7N0J28nV4/d7Nt8WPusNO/VgsJijlkPk+v7x5nb4cv5SdGtmsqVS5YTaMDcxlz0wA         8CDw==
X-Gm-Message-State: AD7BkJJEGlViO2fi2g04ykCJTLOXxuJUpNxbMSgRh3FpkgYbiUhg7ndRYPNs6tCnPpXbgsnYrJmnDeAweG8IAg==
X-Received: by 10.202.88.130 with SMTP id m124mr17762110oib.52.1458588898086; Mon, 21 Mar 2016 12:34:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.86.194 with HTTP; Mon, 21 Mar 2016 12:34:38 -0700 (PDT)
In-Reply-To: <20160321180903.GB14892@calimero.vinschen.de>
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com> <1458409557-13156-9-git-send-email-pefoley2@pefoley.com> <20160320112837.GO25241@calimero.vinschen.de> <CAOFdcFPP79BaO=KTpF5oB3ewdYCh6GmfaxoJr03kKY7dSOjrKw@mail.gmail.com> <20160321171314.GA14892@calimero.vinschen.de> <CAOFdcFM1D17HSiLdeNv=S6zim6wOcqY41Ud-iTtiDLrN_YRYOg@mail.gmail.com> <20160321180903.GB14892@calimero.vinschen.de>
From: Peter Foley <pefoley2@pefoley.com>
Date: Mon, 21 Mar 2016 19:35:00 -0000
Message-ID: <CAOFdcFN4wkv40M-BJPhhHwjaDxh7YD7iXDhLaUcnW6qw=pwnYg@mail.gmail.com>
Subject: Re: [PATCH 09/11] Add c++14 sized deallocation operator
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00168.txt.bz2

On Mon, Mar 21, 2016 at 2:09 PM, Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> I realized that your orignal patch isn't invalidated by this so I tried
> to apply it and we could then add the other stuff later.  However, it
> doesn't compile due to a warning, and since we're always building with
> -Werror...
>
> [...]/cxx.cc:33:1: error: =E2=80=98void operator delete(void*, size_t)=E2=
=80=99 is a usual (non-placement) deallocation function in C++14 (or with -=
fsized-deallocation) [-Werror=3Dc++14-compat]
>  operator delete (void *p, size_t)
>  ^
> cc1plus: all warnings being treated as errors
>
> I'm not sure it's the right thing to switch to C++14 by default using
> gcc 5.3 yet.

Ah, in that case, a better solution might be to drop this patch and
add an explicit -std=3D to the Makefile.
In that case, Cygwin won't have any issues when the default changes to
c++14 in gcc 6.0
I'm not sure what level of -std would be appropriate by default though.

Thanks,

Peter Foley
