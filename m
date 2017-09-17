Return-Path: <cygwin-patches-return-8855-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 127503 invoked by alias); 14 Sep 2017 13:44:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 127487 invoked by uid 89); 14 Sep 2017 13:44:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches
X-Spam-User: qpsmtpd, 2 recipients
X-HELO: mout.gmx.net
Received: from mout.gmx.net (HELO mout.gmx.net) (212.227.17.22) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 14 Sep 2017 13:44:11 +0000
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MHMRr-1df4272sMN-00E8L9; Thu, 14 Sep 2017 15:44:08 +0200
Date: Sun, 17 Sep 2017 02:04:00 -0000
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Yaakov Selkowitz <yselkowitz@cygwin.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix possible segmentation fault in strnstr() on 64-bit systems
In-Reply-To: <79298da3-0c76-d60b-d385-5c30fe938826@cygwin.com>
Message-ID: <alpine.DEB.2.21.1.1709141542180.4132@virtualbox>
References: <54549d65d520d71e1d3038f2e8a1c2f8c0f1f70a.1505317436.git.johannes.schindelin@gmx.de> <79298da3-0c76-d60b-d385-5c30fe938826@cygwin.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-UI-Out-Filterresults: notjunk:1;V01:K0:YwtUC9jjkMM=:wuTUQjQcVqYVXaAlEiZHke 7ASBo6qawnuSGWMJPPrDCKQ/G6wehhpAsAH0zPxKXRAEHMbLSDvCoGFjs8WlCb14PnLSxJOL4 qYCMzeZiHOfelbwI1wwcivBnwo2Pbh2WG81QVucb4Xbw+QIxXLbxxIROewS0NMMOnOaWwLY/T dKsqQiIKPHIxVLdz/bregCCsG2FQPaQNFiTUcCjMKGn/81+biKKXVRHrlLugJ+mAfKb9nbm1H DmsmmnoEIVPqTXH4pd/+zU7gcGpEp2BtEIGqUJwKfErxaUWg1zxlWUUBe5qvFu47y1S6D3iEQ +tX6BOEy41+Km9mgmo76UJpU0k92PR3L67wR6WY59bhNf6RLLAf90GHQ5KdFOs7pn3AChojPl hTgrnoyWihppKsyOZM0AIlA4Eh5oQ7I/RL80Wzmw9C69CT1gRKEg5PsKnSiTTTvukUodRRwVG 5RpH3JSmu2ZvKtSvn5sYlmXGv6fYUHj2OVoeJFI5veT0PLVh0BE8YqJ+dVXZCaDuoxBYIDE4x 68uIIcQHd9jyZ7M21l5h5ntcpmCpnSxU6JAdsORKdSZ0sznAeKRM9d/WfUq0/ITWv+60lFT+g ZoErocWhoi3PRlfT8ZNiuaFzFIJMU6oEk92rekXk0jnoVhMMdS+5GaXbuPLe/CiNYmnCInOtQ noD1OKMG6zmNElKEONTlR+MsWnU68w1xheeT0kxPwFJdnYumurjcZAwFGek/EzATj+BiH+01/ X9NZshKE8Qj5/p54Xc2xwa81T1Ah4hbt9s8NOJpr2MuCXa7kvzM1AsBiVP8veGBMgZmwqRo87 ua+cY0wr/rDzeTYNg0G7vz6TOLsSpE3hyxCOgp7/WSfeMfIhKs=
X-IsSubscribed: yes
X-SW-Source: 2017-q3/txt/msg00057.txt.bz2

Hi Yaakov,

On Wed, 13 Sep 2017, Yaakov Selkowitz wrote:

> On 2017-09-13 10:44, Johannes Schindelin wrote:
> > As of f22054c94d (Modify strnstr.c., 2017-08-30), the strnstr()
> > implementation was replaced by a version that segfaults (at least
> > sometimes) on 64-bit systems.
> > 
> > The reason: the new implementation uses memmem(), and the prototype of
> > memmem() is missing because the _GNU_SOURCE constant is not defined
> > before including <string.h>. As a consequence its return type defaults
> > to int (and GCC spits out a warning).
> > 
> > On 64-bit systems, the int data type is too small, though, to hold a
> > full char *, hence the upper 32-bit are cut off and bad things happen
> > due to a bogus pointer being used to access memory.
> > 
> > Reported as https://github.com/Alexpux/MINGW-packages/issues/2879 in
> > the MSYS2 project.
> 
> As this is part of newlib, the proper place for this is on the newlib
> list.  Others have already proposed similar patches, so please feel free
> to follow the discussion there.

Thank you for the hint. I am not subscribed to that list, neither do I
have the time to follow yet another mailing list, so maybe you want to add
the information that this "compiler warning" is in reality quite a bit
more serious?

Thanks!
Johannes
