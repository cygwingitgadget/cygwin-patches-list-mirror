Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by sourceware.org (Postfix) with ESMTPS id DA4FB3858D39
 for <cygwin-patches@cygwin.com>; Wed,  2 Mar 2022 20:35:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org DA4FB3858D39
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MVuXT-1noUhi3fFt-00Rqdq for <cygwin-patches@cygwin.com>; Wed, 02 Mar 2022
 21:35:23 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 202A0A80885; Wed,  2 Mar 2022 21:35:23 +0100 (CET)
Date: Wed, 2 Mar 2022 21:35:23 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Cygwin sysconf.cc
Message-ID: <Yh/VCzCrgxftws6+@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220225163959.48753-1-Brian.Inglis@SystematicSW.ab.ca>
 <20220225163959.48753-3-Brian.Inglis@SystematicSW.ab.ca>
 <Yhy6OKd/2o8VqIUH@calimero.vinschen.de>
 <d71a5b05-531f-8028-7b06-6ee466053f5f@SystematicSw.ab.ca>
 <2a8615a6-1214-ed7a-71f1-d191bcf2f3fe@SystematicSw.ab.ca>
 <Yh8p80lFZNuUYWTw@calimero.vinschen.de>
 <b7a385c3-5480-9881-9feb-7fb49350c755@SystematicSw.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b7a385c3-5480-9881-9feb-7fb49350c755@SystematicSw.ab.ca>
X-Provags-ID: V03:K1:WGxZYOZDoV3+bdttsm/yjNhFy+WA6VpypC75FHNEfEo93U92+lH
 frvFZ+PEWQ08m9n/duwksjI7bnWS6MF1lmueqgft/OLeMbawDZqBEYhpco1eOK579hYh+A/
 BQEEy4SSsdUmgu+BaO23f0AvVOOQ+R6c9WkfuJf+GrLLcem2YTtynih/pIIvHUTLAWg75xL
 Wt2VmheRTYi1TycZ6JbqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gm63D4kTK0E=:T8mprWxUzGRi/KMhmw1yu7
 as1UAIIrnVkxRO4KJ6Nsyx0XX88bXi/ZEq32v2GQVLydnvCfncGSTzrGDbIZkMsUC2QQa2HGU
 KBBem4J772hayUYzL9E4QaGhvX9hHQGke8pvQZyIboZupGnL2eRESbZEgubdBzkiskMjS6z4I
 KMTsGMOccowVpTGkV23uNrGFJ2/ZAzkXUvmt+CilSQxlq9lZWhoVThtvnDV6lSPig4Xh/Kgbg
 3oW+kK+VU0gFZWjoVPcu8bQOC6h184H22PySjDQtKcxl1HaHLxrdk39NIUQVHfHyvRzXAKizi
 VlzGn4RKILsQiZSpJXESZ/cLB9MTBrFksMh1EaGlly6xEdUioXwpnxtJ+8V1uDWmJbsCiW3Lj
 N0tQ9HDihONFHA+64cdrmY0bMPAyutc/RI0mPETJl8s+gaGFMaRVxIOn6FDzdtxdrSkeaZYKG
 rXT3mw8spWBRVP4jGb0l3N1ZH7Eey9MIzwtkLeyNke9FbErrm72AJG8rZwtZerdFn7ADJ9ecx
 P8oSVjGwbZ/Lm/azetwKllqk0t2ZAdP7rr+ZAX5dRKy4p0XZlpKAU3ncSr2Gxd4mL6KQEIyqE
 xWTQMLwwDllwJY7hcttwxwGsTLMxEjmoAKGhwIu/jcBPguqjJNx97jdkfkVEOqCij9dI4SGhe
 a3Rse+LLFg9fIgY9iISXAjNV9N2nuZ8pn3KJdUEZTmbACYpv9g4JxKnFdMeXVH7bnnfNNwVyv
 ppU5g0C4jjlwuz7O
X-Spam-Status: No, score=-96.6 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_MSPIKE_H2,
 SPF_FAIL, SPF_HELO_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Wed, 02 Mar 2022 20:35:27 -0000

On Mar  2 12:45, Brian Inglis wrote:
> On 2022-03-02 01:25, Corinna Vinschen wrote:
> > Hi Brian,
> > 
> > On Mar  1 13:20, Brian Inglis wrote:
> > > Interested in a patch for sysconf.cc to return:
> > > 
> > >       _SC_TZNAME_MAX => TZNAME_MAX and
> > > _SC_MONOTONIC_CLOCK => _POSIX_MONOTONIC_CLOCK?
> > 
> > not sure I understand the question.  Both are already implemented.
> > 
> >    $ getconf -a | egrep '(TZNAME_MAX|MONOTONIC_CLOCK)'
> >    _POSIX_TZNAME_MAX                   6
> >    TZNAME_MAX                          undefined
> >    _POSIX_MONOTONIC_CLOCK              200809
> 
> Sorry, must have been looking at very *OLD* version online, as
> _SC_CLOCK_SELECTION and _SC_MONOTONIC_CLOCK were not defined.
> 
> Why did you not define _SC_TZNAME_MAX => _POSIX_TZNAME_MAX when you tweaked
> it?

Because it's wrong.  _POSIX_TZNAME_MAX is just a minimum value required
by POSIX, not the correct value to return for TZNAME_MAX.

> My rereading of the man and POSIX pages leads me to believe that for all
> known values of _SC_... the entries now showing {nsup, {c:0}} should be
> {cons, {c:-1L}} supported but undefined, and only out of range values for
> the parameter should be treated as {nsup, {c:-1L}}?

These are really not undefined, but not supported on Cygwin.  That's
why they return with EINVAL.  I see what you mean, though, let me think
about it.

while looking into this I see at least one obvious bug.  While adding
POSIX per-process timers in 2019 I added a valid DELAYTIMER_MAX value,
but I neglected to add this to sysconf.  I'm going to fix this.


Corinna
