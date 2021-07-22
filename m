Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by sourceware.org (Postfix) with ESMTPS id 236023858002
 for <cygwin-patches@cygwin.com>; Thu, 22 Jul 2021 08:01:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 236023858002
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MXH7g-1lbBev3Vjq-00YhZF for <cygwin-patches@cygwin.com>; Thu, 22 Jul 2021
 10:01:07 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 4341CA80D50; Thu, 22 Jul 2021 10:01:07 +0200 (CEST)
Date: Thu, 22 Jul 2021 10:01:07 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fix nanosleep returning negative rem
Message-ID: <YPklw5blHYSEN7O5@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <000201d77d7a$2faae510$8f00af30$@cl.cam.ac.uk>
 <YPfdSyPTCdSWhRv/@calimero.vinschen.de>
 <0189b5495b2149c5a690de0431b7695c@metastack.com>
 <YPfpSgbZbr+bnOWE@calimero.vinschen.de>
 <YPfp0WgZUVo0nap7@calimero.vinschen.de>
 <2271051beb734ce984ed71eab4180746@metastack.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2271051beb734ce984ed71eab4180746@metastack.com>
X-Provags-ID: V03:K1:RHb5vFiRKDUJTLbeYd6PbTI7UYWIvP8ulgI/b4J7Sv/HVSw4EDS
 Q6nU3I+T+lQujMX5sQqg9NZsqg4PeSgO1byXso4KNrSss7vG93ly/gJjOImCGPwacCu4fpV
 P5jWNMFz1TouX6V9IJtrg8558nfLMHE2uS73SMYQQvAHIwJbhHXiWHy6J2388CjVjLLdJQw
 IyBwSWb4XfZI49PhIP+hA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Jpo6ByeSe3Q=:nfQPjVO+KP8+wSfrGFmPqA
 UxMKnxWAKym1w6FZWv8Jv/cKnzXnc1P4NO5Zaf9becTld+B6WB/GPok39He+Oz/p905xXf5Zf
 99QTQloubC+Wr2+ebHbLVBWrq91DFZ8u2BUU+Ag8lMYDYyROjpDAR4VMIn0LKb9TOnuMqqWwl
 Tn9B0GlokkNPn4dJ0xMUg5c5a1ut2qpw5XWKacPSjt0KZs1EhcG1Gcy+b5jr3MH5Um29oplfJ
 aCH18wsn+JtcoeToZIUslbYSx7uPKxaqxOmKzhy/Rmk4H4wBSIE101kxYl+JaxU6FFiZQyRwu
 qyLdpOtET1J4Dm5UYelrqZ99C4Y54ZcaeF8ElKq3uXCFgU+mx6FWfpM8wGlF16ebRMX8RbYBH
 NaxYYhtd3dsFhFSOPHeMjdmgeEWNzY4ch4cLO/rb/gwN85slzZls5SFYvetopBag50sazf2AD
 YnhO32qtbNYeRqZgU4Vk1t+DPBp9Xa8pDdzrD/oxw+RJelkIx3C9nSLxAErodzovw8bNU+Ef7
 JI/GGzshMlj/GLwFR4yU/9kkAix0R/IWuOMcOYv+0JAAv66a1t5llfNq9Z2q/AjY0x7I5efSO
 B8xdKzdwgpncQT6rRh2x91pSQ4Rw6+mV4LyDj3Ti4oDIZQkDdxRi28DkbKosCF08XozUf3Xdh
 XH87FkVzMFB51EvKpLZxzXiwcs+rAimYokrZoFoyMlMuedDZs1BhR1mt3Hn3XNImt3lSfdQrG
 MtWopj1rkP2nJTo8ZGOUlIRxguVLtttGFk5StOQ6JjeO0ctm2R//zqvO1kchKKvn2wMrN2VIL
 Zs2OugxC9TVuAuLYjQVd6FpKyJbO5SeYvt7WRaLinXYwwbyO+LRYvUeuTe2ZhFiJrgWJdht0J
 4pvFhjB1LTN/1O3NyOmg==
X-Spam-Status: No, score=-100.0 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE,
 SPF_NEUTRAL, TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
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
X-List-Received-Date: Thu, 22 Jul 2021 08:01:10 -0000

On Jul 21 16:02, David Allsopp wrote:
> Corinna Vinschen wrote:
> > Sent: 21 July 2021 10:33
> > To: cygwin-patches@cygwin.com
> > Subject: Re: Fix nanosleep returning negative rem
> > 
> > On Jul 21 11:30, Corinna Vinschen wrote:
> > > I wrote a quick STC using the NT API calls and I can't reproduce the
> > > problem with this code either.  The output is either
> > >
> > >   SignalState: 1 TimeRemaining: -5354077459183
> > >
> > > or
> > >
> > >   SignalState: 0 TimeRemaining: 653
> > >
> > > I never get a small negative value in the latter case.  Can you
> > > reproduce your problem with this testcase or tweak it to reproduce it?
> > 
> > Now I actually attached the code :}
> 
> :) Yes, I can reproduce - I didn't even need a loop! Third time:
> 
>   dra@Thor /cygdrive/c/Scratch/nanosleep
>   $ ./timer
>   SignalState: 0 TimeRemaining: -1151
> 
> That said, I can get it easily get this on my desktop (AMD Ryzen
> Threadripper 3990X) but not at all on my laptop (Intel Core i7-8650U).
> On the laptop, ignoring the couple of signalled cases, 747 runs of
> timer.c give values between 131597-149947 with a very narrow SD
> (~4000) whereas on the AMD chip, 738 runs gives a range of -2722 to
> 149896 with a relatively wider SD of ~23000.
> 
> The CI system where this was first seen is an virtualised Intel system
> so it doesn't appear to be as simple as CPU manufacturer or even core
> count.

Weird.  I pushed your patch.

> That said, I'm not at all familiar with the details of how this
> works, but I expect the timer for these things is part of the chipset,
> not the CPU?!

As timers go, the timer behind the NtCreateTimer scenes is a simple
interrupt based timer with a default resolution of 15 ms.


Thanks,
Corinna
