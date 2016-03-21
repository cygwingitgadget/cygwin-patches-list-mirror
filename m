Return-Path: <cygwin-patches-return-8481-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 89737 invoked by alias); 21 Mar 2016 21:30:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 89710 invoked by uid 89); 21 Mar 2016 21:30:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: mail-oi0-f68.google.com
Received: from mail-oi0-f68.google.com (HELO mail-oi0-f68.google.com) (209.85.218.68) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Mon, 21 Mar 2016 21:30:56 +0000
Received: by mail-oi0-f68.google.com with SMTP id n20so4334587oig.3        for <cygwin-patches@cygwin.com>; Mon, 21 Mar 2016 14:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=HnfZ8geKtARUbS4TOmrU9qw2qpFcYA+qwK4Bp4hW9o4=;        b=K34RiaT6uAHOsaK9fNO7jwoiKsorr6lazPmwf3nkNwAB0I9PHnkYuc24M7+vY2KUiK         VNYN1IBjQd4fn28VQ0W4twjKFob+6EM086ErXHV0r6UWhdPBNqxX0+LETyOapST4ddRW         Ux5qfQNTOxEMODyFdmUW41J+IZ7i8YzODLFiS6Ztw8Y0ULfz6FQBS96q2thEUUDMFE+8         +u5mLin6le8PpKLtKNOpA/kWIOWU21LOj6KuqOqBkEidsVtpzxpvp2f61Lu0FZmIqc61         SVmYjipSDrQhrW0LYkxU6Ceu0yQ8bdFEqpDULwrrMJSNm6VdwwByGsMZ0/G+BRNJj/se         7IoA==
X-Gm-Message-State: AD7BkJK+lqSx0jeVkMAq/ZWPPGJXhA0+Bye8gcfL2aHQumpxIa+P+cppMwLjNzO4rmsInK9svwwjUA0GSO/Znw==
X-Received: by 10.157.45.17 with SMTP id v17mr1499867ota.36.1458595854127; Mon, 21 Mar 2016 14:30:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.86.194 with HTTP; Mon, 21 Mar 2016 14:30:34 -0700 (PDT)
In-Reply-To: <CAOFdcFMxbfteqjYWG_FOJ73Ey3LUbTQ-hKRJYOdBBBdM3k7m_w@mail.gmail.com>
References: <1458580546-14484-1-git-send-email-pefoley2@pefoley.com> <1458580546-14484-5-git-send-email-pefoley2@pefoley.com> <20160321194758.GH14892@calimero.vinschen.de> <CAOFdcFMC60YLscHWDzsRz3q9cF1-KAc-d=CPhS5W_LeFRb83tg@mail.gmail.com> <20160321203235.GM14892@calimero.vinschen.de> <CAOFdcFMxbfteqjYWG_FOJ73Ey3LUbTQ-hKRJYOdBBBdM3k7m_w@mail.gmail.com>
From: Peter Foley <pefoley2@pefoley.com>
Date: Mon, 21 Mar 2016 21:30:00 -0000
Message-ID: <CAOFdcFNRzey3=r76N1RD=b3rYu7RRow_CzLQitZJc4cV2heY=A@mail.gmail.com>
Subject: Re: [PATCH 5/5] Add with-only-headers
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00187.txt.bz2

On Mon, Mar 21, 2016 at 5:03 PM, Peter Foley <pefoley2@pefoley.com> wrote:
> On Mon, Mar 21, 2016 at 4:32 PM, Corinna Vinschen
> <corinna-cygwin@cygwin.com> wrote:
>> Still hmm at this point.  AFAICS we only need the handful of definitions
>> for new and delete operators, nothing else.  Is there perhaps a way to
>> define this stuff by ourselves to avoid any requirement for libstdc++
>> headers for building the DLL?  Or is that just not feasible?

It is possible to avoid including libstdc++ headers, but since
cygserver.exe links against
libstdc++, we'd still need to build libstdc++, and we still have the
mingw-crt headers dependency.
So I'm not sure there's really any point essentially in-lining part of
libstdc++'s new header so that we
can build without libstdc++.

Thanks,

Peter
