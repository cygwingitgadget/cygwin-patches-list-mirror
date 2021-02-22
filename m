Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by sourceware.org (Postfix) with ESMTPS id 2C297389682E
 for <cygwin-patches@cygwin.com>; Mon, 22 Feb 2021 13:57:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 2C297389682E
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MNccf-1lSo9d3X7z-00P6DY for <cygwin-patches@cygwin.com>; Mon, 22 Feb 2021
 14:57:42 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 4679CA80D43; Mon, 22 Feb 2021 14:57:42 +0100 (CET)
Date: Mon, 22 Feb 2021 14:57:42 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Fix segfault caused when tcflush() is called.
Message-ID: <YDO4VrAr822OFerD@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210220224516.1740-1-takashi.yano@nifty.ne.jp>
 <YDN+lx5V2I3W3bbw@calimero.vinschen.de>
 <20210222204100.698efc916f1eacacb89b9ab8@nifty.ne.jp>
 <20210222222816.90c09a753de37dbc12d993e5@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210222222816.90c09a753de37dbc12d993e5@nifty.ne.jp>
X-Provags-ID: V03:K1:T5Udh/m2iJSQSz3XRBWlzwSy6JMfqt1ejhymnlUsYmACwFIP14O
 hGrPkrVqxmGN7l0uuC2RKFpXrav+OXHIqylD+23ipZEt7si2Bhtz8HF1DzsCf1TQAkLA9vK
 3lgj/6p00XFJP6Jr3K0eJOaPrpqsGr2JQfjeZLM5LbGj7ZBSZaV5bKhaEg4TCi3vWcVt/rg
 uKrmvjUWmPb3uVp5H535A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E9duokhHfUs=:7V/71mriSBsEL54nBW4iqL
 mKFUZ67veIYeTBC3T2unWvmfUIuNrrPTA8Z0oWOAFM1y3jRGl7i6FB86gB8VSYvM4+62RaO3c
 hysd+pA19NdIaI3wpM7pF8AzKbAC965KUj1o4qKpuum5ltCw8QwkYHQ4vrzIcun6aF4+GcDe9
 NlRsfKCuVSdvVKBK1C8Jm77WFmoqFYnQox1TZW0JYNv3EfcFUkQP+nviKZkGl7I9u+F9cgf4U
 BMs+r2zcrPNPmOPTvqBVAzX1bX5UVj6UpkjRePr4qrL+wE7crEomCGJjoCrzOMGFIAOdgdwgS
 xg6OzC76WGxZ2YfOkeBrxqOq0G66OmMt541ChsIHcQMXqto/tJ/qJLcwOJt9I4gJLl4hw7ZYr
 6r9wqBDsGRebiiOwwRDUHOuT6Z6UW/yc3hGd4k6A2yNZ0ixVETHFpRutKl10lKSs8fNehd80q
 afi5NWqyeQ==
X-Spam-Status: No, score=-101.4 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
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
X-List-Received-Date: Mon, 22 Feb 2021 13:57:45 -0000

On Feb 22 22:28, Takashi Yano via Cygwin-patches wrote:
> On Mon, 22 Feb 2021 20:41:00 +0900
> Takashi Yano wrote:
> > On Mon, 22 Feb 2021 10:51:19 +0100
> > Corinna Vinschen wrote:
> > > So, what do you think is the state of the console code, Takashi?
> > > Shall we start a release cycle next week?
> > 
> > I think all the fixes and improvements that come to mind at this
> > point have been completed. As for releasing, I believe I've done
> > enough testing, but honestly I'm not without anxiety because total
> > amount of changes for pty and console code is relatively large
> > since the beginning of this year.
> 
> Sure enough, I found a problem in the console code...

:)

> I will submit a patch for that.

No worries,
Corinna
