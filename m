Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id 954043857C65
 for <cygwin-patches@cygwin.com>; Wed,  9 Sep 2020 07:21:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 954043857C65
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M1HmG-1kEGWf3w9C-002pGh for <cygwin-patches@cygwin.com>; Wed, 09 Sep 2020
 09:21:23 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 6AB5EA83A96; Wed,  9 Sep 2020 09:21:23 +0200 (CEST)
Date: Wed, 9 Sep 2020 09:21:23 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset ==
 "UTF-8"
Message-ID: <20200909072123.GX4127@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <nycvar.QRO.7.76.6.2009011818560.56@tvgsbejvaqbjf.bet>
 <20200904190337.cde290e4b690793ef6a0f496@nifty.ne.jp>
 <nycvar.QRO.7.76.6.2009040822000.56@tvgsbejvaqbjf.bet>
 <20200905000302.9c777e3d2df4f49f3a641e42@nifty.ne.jp>
 <nycvar.QRO.7.76.6.2009072309070.56@tvgsbejvaqbjf.bet>
 <20200908171648.e65665caebb643ce99910fa3@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200908171648.e65665caebb643ce99910fa3@nifty.ne.jp>
X-Provags-ID: V03:K1:Lyk2T4vGTsDQsoWKzvTaf7K1haj7zb9LF6aHRO+MBuVZ2Giy6Bc
 niOdCFFH4fjvta8c29euFzWjXNYVHfsEgDPko6nYkiI2VMSJcw9+bE5Aae2UgY0i8N0yDU0
 0kKkOIqr9Su7C9G7ZofmZkAE8QpKF8Ta+0eXQf0o/KwiZUJOS6CJthEQaA503xffHPp6vE/
 eGn+UIH9C8cxyIeimuyZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jPf6IPNkXBo=:QqAx1X+gejYbpEJTsZJxEU
 5+AWEhG65heLaSxgPAkG6l3G2dyc9mBIPW9jeHlnDZNtd1YziSNJDcRXDpbthFa/eYwn3R0q7
 3z/KCzDXq4L89pOsYtDh81TTdzkx9qSOIEMVyUM7IrGm+WXSGii+ShHbxEg3Vztej7x38dky8
 QJ6N6P51T+Z6Lv8AVRJakc7ewV3sKARDJ2bWUqBszP3lMNHEKlavratfhpD6aYAhSsM//bbit
 85OtfNZMdEgLulyoru1YxNNGq/OV+nD0SW4LBEDZ4XQoB6TjqJMj5mGOG31bPTm+rax+W/eG9
 Yx/JXVLF9uDMMrj8wCUR2aO3heM7h2cXFI2tHLtuwkdkX70AO/3R2vA6OGbLqQA6i8cNA6Mcc
 MR3A5jowNsVbuytHdlr9po2szxOoXBy3gbca0nDybI7YocZ14mXW1pv3QcMQn9VPPSp+tUXy9
 Gnfnd/xbb80pGKP64ytQgl1ZOA5sExfaByEnQpZnSKQuLxI1OWwfJVzSoxM7nMddpES/icIMq
 XKqQgBWrcPDD7r96tL5cfYaPGMMcH+BoWlP2k3/Ke9UeBXBeJwKDlhvS4kCs4d9n4RIvwcuhr
 Uq3mheNcjhMWOhAi82DHjp8ColNw3/af71LRGynOuppdRVSM4qo1S18oR9jqxJLGqj6urpO7i
 097MCKueCyvmTZkSzr0T9B6UVI0xIU4F5miglHICAjzSft4Tqs+lw9miCWuYsfuz5OAF1cG4c
 5xYJq/vtal8AW3+AP/UXYa73L6LCaHyaXnOELz96ZvZyYXCt+UgAjDkEv35VXxcpYF8fkElcE
 VxFw2OAeF0DwYwk82wfqVCU06ddHD2K/tT5iqAGLhzrm3DMe5+z5u5P2J9Q2AEYQ/ai2uTRHV
 I4xVixqILkCBB1wv/6Cw==
X-Spam-Status: No, score=-100.6 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Wed, 09 Sep 2020 07:21:28 -0000

On Sep  8 17:16, Takashi Yano via Cygwin-patches wrote:
> On Mon, 7 Sep 2020 23:17:36 +0200 (CEST)
> Johannes Schindelin wrote:
> > Hi Takashi,
> > 
> > On Sat, 5 Sep 2020, Takashi Yano wrote:
> > 
> > > On Fri, 4 Sep 2020 08:23:42 +0200 (CEST)
> > > Johannes Schindelin wrote:
> > > >
> > > > On Fri, 4 Sep 2020, Takashi Yano via Cygwin-patches wrote:
> > > >
> > > > > On Tue, 1 Sep 2020 18:19:16 +0200 (CEST)
> > > > > Johannes Schindelin wrote:
> > > > > [...]
> > `LANG=en_US.UTF-8` (meaning your patches force their console applications'
> > output to be interpreted with code page 437) and therefore for those
> > users, things looked fine before, and now they don't.
> > 
> > Note that I am not talking about developers who develop said console
> > applications. I am talking about users who use those console applications.
> > In other words, I am talking about a vastly larger group of affected
> > people.
> > 
> > All of those people (or at least a substantial majority) will now have to
> > be told to please disable Pseudo Console support in v3.2.0 because they
> > would have to patch and rebuild those console applications that don't call
> > `SetConsoleOutputCP()`, and that is certainly unreasonable to expect of
> > the majority of users. Not even the `cmd /c chcp 65001` work-around (that
> > helps with v3.1.7) will work with v3.2.0 when Pseudo Console support is
> > enabled.
> 
> In the case where pseudo console is disabled, the patch I proposed in
> https://cygwin.com/pipermail/cygwin-patches/2020q3/010548.html
> will solve the issue. I mean apps which work correctly in cygwin 3.0.7
> work in cygwin 3.2.0 as well with that patch.
> 
> OTOH, in the case where pseudo console is enabled, non-cygwin apps which
> work correctly in command prompt, work in cygwin 3.2.0 as well.
> 
> It is enough for all, isn't it?
> 
> You may think that all non-cygwin apps which work in cygwin 3.0.7 must
> work in cygwin 3.2.0 even when pseudo console is enabled, but it is
> against the purpose of the pseudo console support. The goal of pseudo
> console support is to make non-cygwin apps work as if it is executed in
> command prompt.
> 
> By the way, you complained regarding garbled output of the program which
> outputs UTF-8 string regardless of locale.
> https://cygwin.com/pipermail/cygwin-developers/2020-August/011951.html
> However, many Japanese programmers, for example, make programs which
> output SJIS (CP932) string regardless of locale.
> 
> Why do you think the former must work while the latter deos not have to?
> Is there any reasonable reason other than backward compatibility?

Is that still a concern with the latest from master?  There's
a snapshot for testing, Johannes.

Takashi, does the patch from
https://cygwin.com/pipermail/cygwin-developers/2020-August/011951.html
still apply to the latest from master?  Question is, shouldn't the
Windows calls setting the codepage be only called if started from
child_info_spawn::worker for non-Cygwin executables?


Corinna
