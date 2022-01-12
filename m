Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id B6E783858406
 for <cygwin-patches@cygwin.com>; Wed, 12 Jan 2022 19:25:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org B6E783858406
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N1Ofr-1mMrrU12ap-012lKF for <cygwin-patches@cygwin.com>; Wed, 12 Jan 2022
 20:25:07 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id C8F2DA80B83; Wed, 12 Jan 2022 20:25:06 +0100 (CET)
Date: Wed, 12 Jan 2022 20:25:06 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: doc: drop mention of 32-bit installer
Message-ID: <Yd8rEsDBRyCL/2VE@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220112155241.1635-1-jon.turney@dronecode.org.uk>
 <Yd8jSyIZCPmkKd1E@calimero.vinschen.de>
 <31607842-7ac3-44ee-8099-ae53de5d1ed0@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <31607842-7ac3-44ee-8099-ae53de5d1ed0@dronecode.org.uk>
X-Provags-ID: V03:K1:IO8hnC5NBfOf+qwql+FfkX6pUo5JwT8tAnGYQjs1L74aT4cZH2Q
 MWyg7Zn2MJebQbKfMMTJEs4Gq2F+KOnN47UxgYlL87OCvIQl6iPP+uF7OPfgPQd6bZlWfRN
 Wo/CgErmgMhYPPSC/WuzsjtRaVUoFmjtCs99cSazGJ5lToEgSqercGDV16z3B+9Tjrgla4L
 y6qi2jtGb1xM7uafywDvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0NG0EKJbIqw=:MtxmGnpOMrN8Q1gRNwMHTl
 tVwSZLbXTvBts7b44PSBstg2lI6AvTQd35+rzEvf3pVg3R/5l57tpL6V/wXkQPyjZQMCJpIVO
 VnCkORpabJsrSWPprmlIfMerjvYAh+qhFW1oE8AiwP+feJstse03D9cArjT0lqNTA/GCp4L0G
 ECUovdiQUnKcYX9kEyyDxH/4nHOD1BLpe9TcOZHrg2jSAFFN9FegoXE8R2MsAa46D+e/Zl9iJ
 SRqV4RTi2Vv5pgxgysQ4QALb4GVyL/1aJvg8Hkb5S/QaNuEObnzEU+XyzKB6WoWCEc1pgp/K9
 T70lKBazOSxnEvnYD18KgMgEXX+HTX7lUBWo7MfuvhuArfZYOoBxmBZSphCN63ztOK19oTd4C
 TwdFPD/+DSMzjMrNoj3oKHLryrel5/B7mcZy61K2xWudah8fbEPmTsWmz6ATr+hE/5MBM6gz5
 egzBUVPgtY4F9guL7DJYpgM/CCn2cctmVCLuQKTxB2KeFOyYw5Y57W1A50raB5x5CIluwoAm+
 YvPDEcLasqBoyfH5HAylEZgbJijvcNDlQpCqLAxJkNRpHmZKZbTokxjqQRuLpVMkmo9JGCkER
 WUckavDQrQy1yXGPv3UoAmXfXHsy5gqtnooaQYe4dcN2WBtZY5zmdHzFhhAodT0oDJgUf2/to
 JX2cJkiqKhi4uKWtlAE+ESxiam2lGl4kGOfvE4aAHeeSmIzas5Ebt6xZ46mQzP9prYUAKDgN4
 hGRPeOHvO3/uQXOy
X-Spam-Status: No, score=-94.8 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_FAIL, SPF_HELO_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Wed, 12 Jan 2022 19:25:10 -0000

On Jan 12 19:17, Jon Turney wrote:
> On 12/01/2022 18:51, Corinna Vinschen wrote:
> > On Jan 12 15:52, Jon Turney wrote:
> > > Drop mention of 32-bit installer, since it's offically discouraged, and
> > > planned to be dropped soon.
> > > 
> > > Adjust various references to be something more generic, like 'the Cygwin
> > > Setup program' to accomodate this.
> > > ---
> > >   winsup/doc/faq-setup.xml | 12 +++----
> > >   winsup/doc/setup-net.xml | 74 ++++++++++++++++------------------------
> > >   2 files changed, 34 insertions(+), 52 deletions(-)
> > > [...]
> > >   <para>
> > > -On Windows Vista and later, <command>setup.exe</command> will check by
> > > +On Windows Vista and later, <command>setup</command> will check by
> >                ^^^^^
> > This will have to be changed for the master branch to mention W7
> > instead.  Vista is a dead stinkin' fish at that time.  That reminds me,
> > we have to do this throughout.  Do you want to or shall I?
> 
> Please go ahead.
> 
> In this particular case, the leading clause can simply be dropped, since
> "setup will check by default if it runs with administrative privileges ..."
> describes the behaviour on all supported Windows versions.

Yeah, makes sense.


Corinna
