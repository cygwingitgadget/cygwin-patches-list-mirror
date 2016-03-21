Return-Path: <cygwin-patches-return-8480-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 86041 invoked by alias); 21 Mar 2016 21:04:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 85967 invoked by uid 89); 21 Mar 2016 21:04:10 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: mail-ob0-f196.google.com
Received: from mail-ob0-f196.google.com (HELO mail-ob0-f196.google.com) (209.85.214.196) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Mon, 21 Mar 2016 21:04:06 +0000
Received: by mail-ob0-f196.google.com with SMTP id e7so15868583obv.2        for <cygwin-patches@cygwin.com>; Mon, 21 Mar 2016 14:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=nWIkx6ej4YdinctTpa1sIbb9pG8byPCmEyGbX1y+Rc4=;        b=dwhbDg6vmpMCNCnQ93XylMqSu/NTEZxgpoAREynGsMOP9EZ4bWUalVL+kaLfNG8ZoR         tVon2GzvzoikTSnDjAzgHAjtZmF23ig1JOCmxnPOS7kvYpk5wK3H+oiF2d2kDEJRtpuM         3k6l6X/Vuv7yhVxjKueGgEtwVSY0kKmSMiR9yyWRti2wB1SnGmW5ECLM9jEQbRfoPoJU         jFiO3Yud0WPMWcQZD/ULmpk5W9xq0JUeyx1GXo6qcxDKiK9kfBRlR4P7q4BGYkBs0xV8         JAE4hPmYByYjqUfTKCFml8nCWrDz9egh8kcC8kQYDkv2xpjI+0yb9mwD8cxZKEgE7zsQ         Dbfg==
X-Gm-Message-State: AD7BkJIjdVPg6lSVAg2nEzLfBoaYdhQaeFeG6iu39xOft/yDIdgadO6KsKg3xvnI8AE8qfvn5+Lwx4btx/o4sw==
X-Received: by 10.60.141.227 with SMTP id rr3mr18482547oeb.57.1458594243555; Mon, 21 Mar 2016 14:04:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.86.194 with HTTP; Mon, 21 Mar 2016 14:03:44 -0700 (PDT)
In-Reply-To: <20160321203235.GM14892@calimero.vinschen.de>
References: <1458580546-14484-1-git-send-email-pefoley2@pefoley.com> <1458580546-14484-5-git-send-email-pefoley2@pefoley.com> <20160321194758.GH14892@calimero.vinschen.de> <CAOFdcFMC60YLscHWDzsRz3q9cF1-KAc-d=CPhS5W_LeFRb83tg@mail.gmail.com> <20160321203235.GM14892@calimero.vinschen.de>
From: Peter Foley <pefoley2@pefoley.com>
Date: Mon, 21 Mar 2016 21:04:00 -0000
Message-ID: <CAOFdcFMxbfteqjYWG_FOJ73Ey3LUbTQ-hKRJYOdBBBdM3k7m_w@mail.gmail.com>
Subject: Re: [PATCH 5/5] Add with-only-headers
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00186.txt.bz2

On Mon, Mar 21, 2016 at 4:32 PM, Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> Still hmm at this point.  AFAICS we only need the handful of definitions
> for new and delete operators, nothing else.  Is there perhaps a way to
> define this stuff by ourselves to avoid any requirement for libstdc++
> headers for building the DLL?  Or is that just not feasible?

Turns out that building libntdll.a and friends from mingw-w64 also
requires the cygwin headers to be installed.
So this patch is still necessary for configure-target-winsup to
succeed, as it currently requires libntdll.a to exist.
So even if the libstdc++v3 dependency is removed, we still have
mingw-crt depends on cygwin-headers
and cygwin-headers depends on mingw-crt in the current state.

Thanks,

Peter
