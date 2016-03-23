Return-Path: <cygwin-patches-return-8490-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 39585 invoked by alias); 23 Mar 2016 12:58:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 39563 invoked by uid 89); 23 Mar 2016 12:58:37 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:148, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: mail-oi0-f50.google.com
Received: from mail-oi0-f50.google.com (HELO mail-oi0-f50.google.com) (209.85.218.50) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Wed, 23 Mar 2016 12:58:27 +0000
Received: by mail-oi0-f50.google.com with SMTP id d205so18179489oia.0        for <cygwin-patches@cygwin.com>; Wed, 23 Mar 2016 05:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=A3RPGb337693pgBlhvx90znp2LICy/hVAi+O4X44LeA=;        b=NPmoavJ/UXPj75vRQmbbdK32rqBe1uNsHX8goCRs0tPOhoB0b0Og9xIS7bgv2302Qr         fAIg/iQRF4c3EvOucNJ12YDa9vUAi6oGgQi34klvJSFQnSitemMo6Eok8wOGIbU3xyOn         pR1ifs5kfe/pKUUx+q/yWayS+zBpN6GXYRtRfPDvZ0q9KuUtEdRVRRcmGM5fnz5QyqHl         k1fBZP7aGo4ogwNsXigiUru8M+8RCI/jdapHOXbaJM7h5turoKAPr0A0lfF9bJE0iihq         imhrqpjwQ173qC2p7Vy1nZGDxjd0nC2qK6FAP+4T5mF4zfHlYS1FaK7nm8xD9SkTauyw         xbrA==
X-Gm-Message-State: AD7BkJI/7imhu9MCFAKU0j49tP+kTDQsIajmhCC3ZAjusq4MQbLR+iwuWszD6lVkQBONYPPcM0cRzuZWQoIAbA==
X-Received: by 10.157.61.137 with SMTP id l9mr1171755otc.36.1458737887182; Wed, 23 Mar 2016 05:58:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.86.194 with HTTP; Wed, 23 Mar 2016 05:57:47 -0700 (PDT)
In-Reply-To: <20160323104105.GO14892@calimero.vinschen.de>
References: <CAOFdcFNPgJrf3KcNaOvmoT+Aj3Gp46w=ob=okPT0vwJ4TvMTCg@mail.gmail.com> <20160321192550.GE14892@calimero.vinschen.de> <CAOFdcFMESQp3_Ddn8vqEibAY-=8Z+v5XOvFKPsaGGbP2RFLR+g@mail.gmail.com> <20160323104105.GO14892@calimero.vinschen.de>
From: Peter Foley <pefoley2@pefoley.com>
Date: Wed, 23 Mar 2016 12:58:00 -0000
Message-ID: <CAOFdcFNWQYjBq_F5tG57umdj-Khe9YXVqPjgNhqzDwMp8eE6Hw@mail.gmail.com>
Subject: Re: Update toplevel files from gcc
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00196.txt.bz2

On Wed, Mar 23, 2016 at 6:41 AM, Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> Done yesterday.

Thanks!
