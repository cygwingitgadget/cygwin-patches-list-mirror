Return-Path: <cygwin-patches-return-8455-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 44947 invoked by alias); 21 Mar 2016 17:47:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 44929 invoked by uid 89); 21 Mar 2016 17:47:12 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.1 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS,URI_NOVOWEL autolearn=ham version=3.3.2 spammy=claims, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: mail-oi0-f65.google.com
Received: from mail-oi0-f65.google.com (HELO mail-oi0-f65.google.com) (209.85.218.65) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Mon, 21 Mar 2016 17:47:02 +0000
Received: by mail-oi0-f65.google.com with SMTP id r187so13140933oih.2        for <cygwin-patches@cygwin.com>; Mon, 21 Mar 2016 10:47:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=rcS12M8BSdIQSgO78iUFCamu2VvQcRotgeuz0FzmbBE=;        b=i0bsnDdj8gAPW9koDyu+i02SBIo7TsJMnNVpVaHZ+QsjP/jYlFXy9qKuyHhlc2RXrI         dpfpdHQtML5FnzjOL9qLMxEI17SZ6/ecrjjdyQJrAvFFnSm08Q6GbrMRyt0kPI6qJZdB         JN69v9r9XHGyhVdEiUYoLsNfE60c7lG9AKxCTgGRJgtMQzNIZywnUwOr1zdq3P5cgpER         Uuo3E9EcYPfZf6YpEDaHhkYBG5s6xLjjT5k+XC8oVRoLNAMROocTW7UXT9u9U/k2eMAy         gjoyYKoMGkIYURJQjC2RXAtBhBEHWD7FXpkhoO6dkEcB+bhYdI4UDzCK/nFquu8s2pv8         uTyw==
X-Gm-Message-State: AD7BkJIICtUMaAfxsRR0xZij7INBcYxQ/X4E2weyimazkvyq++A41SC+CD73xtC/VELB0bGniMCN8HiiNss0OA==
X-Received: by 10.157.13.20 with SMTP id 20mr1468658oti.35.1458582420715; Mon, 21 Mar 2016 10:47:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.86.194 with HTTP; Mon, 21 Mar 2016 10:46:41 -0700 (PDT)
In-Reply-To: <20160321171314.GA14892@calimero.vinschen.de>
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com> <1458409557-13156-9-git-send-email-pefoley2@pefoley.com> <20160320112837.GO25241@calimero.vinschen.de> <CAOFdcFPP79BaO=KTpF5oB3ewdYCh6GmfaxoJr03kKY7dSOjrKw@mail.gmail.com> <20160321171314.GA14892@calimero.vinschen.de>
From: Peter Foley <pefoley2@pefoley.com>
Date: Mon, 21 Mar 2016 17:47:00 -0000
Message-ID: <CAOFdcFM1D17HSiLdeNv=S6zim6wOcqY41Ud-iTtiDLrN_YRYOg@mail.gmail.com>
Subject: Re: [PATCH 09/11] Add c++14 sized deallocation operator
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00161.txt.bz2

On Mon, Mar 21, 2016 at 1:13 PM, Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> But we export these functions as fallback functions to the applications.
> See libstdcxx_wrapper.cc and the end of cxx.cc.  While the comment in
> cxx.cc claims that this should "not be used in practice", there might be
> c++14 code ending up with undefined references to the new delete
> operator, isn't it?
>
> https://cygwin.com/ml/cygwin-patches/2009-q3/msg00010.html outlines
> why these exports were necessary in the first place.

Ah, I'll look into updating those files as well then.
