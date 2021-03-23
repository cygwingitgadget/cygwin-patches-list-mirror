Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by sourceware.org (Postfix) with ESMTPS id BE11B385BF9E
 for <cygwin-patches@cygwin.com>; Tue, 23 Mar 2021 13:32:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org BE11B385BF9E
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MmQUL-1m6F9y33B3-00iQtF for <cygwin-patches@cygwin.com>; Tue, 23 Mar 2021
 14:32:39 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 2E30FA80DBA; Tue, 23 Mar 2021 14:32:39 +0100 (CET)
Date: Tue, 23 Mar 2021 14:32:39 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Return appropriate handle by _get_osfhandle() and
 GetStdHandle().
Message-ID: <YFnt95aAHnuu7NCC@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210321174427.cf79e39deeea896583caa48c@nifty.ne.jp>
 <20210322080738.6841d7f2a1e09290a929ad90@nifty.ne.jp>
 <YFiC6FXrnGeW8v1M@calimero.vinschen.de>
 <58c7be6c-42db-cc09-9f89-461ac7c87747@cornell.edu>
 <YFm+fEONY3wLq3Sp@calimero.vinschen.de>
 <20210323205717.bf5c3a41695871ec70bf1229@nifty.ne.jp>
 <YFncTItWHhMlNH5Y@calimero.vinschen.de>
 <20210323213212.d2c5a9e7db7a508260693998@nifty.ne.jp>
 <20210323214206.ebb5b1cb80a8b71ead4e8cda@nifty.ne.jp>
 <20210323215227.eda395caff35c4d5aa9b9007@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210323215227.eda395caff35c4d5aa9b9007@nifty.ne.jp>
X-Provags-ID: V03:K1:GJ89U1kna8l8XxgobfiG322f2BkNaE16vPvWq1DPaWH7hU5JZqB
 Q7ZoZCxC6WP1tO2aKJS1gC+NMxaZ0n5x0CkBSXCk3VcrKgXciUc2RweptPgZLS5/e9CfB5w
 ZrBMoM7BQQSZnXMQfE1abwrrlR35ulio8W/1+LKLBHMO9V6GXfh+VM5fma1eQOMulKIQoJN
 2qg4N68BYqopn8iWFHw8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/FFR4EpCw8s=:ZAgJHRS7i8qxfy56LR/g1R
 5HKemikVyaWjK9BA9p9grq+gii0zwb/nMF07F5jaRs+oacnIw0KLu9V9L6ZHhNCBnfLQRNMv7
 hGjI/ogGqiawDZwCRdhpRWUNJtqxxW1AiKK79tONKpVpmby/akvDUENstKhv0QBvlT9PLzo9C
 QFLtgWgnuD8IjCVeN7YrdeGTpKGNEcOmE/Ri4QilSM0IGR/SBUcWxXPbSbfo7weLIVNuyAPYQ
 oMrR8qhyP+DVh1eI+FVQ3BSlT9BTfnPE7b+SgHxfz2+DwZUsg5kP36/ODaXadMCCUi0NRLNdE
 TnhEs1lWoNol9oNcHExkAdqY7bKYwJ9Ifl+hx0jhGtBQNJGexCUFQxDgzQxDoiMMFYdTNuFHE
 loIKvdfgUaNX+lyO/UVF1FP8jzGoKLHMKmt0KItgTJ7i4E3j6KizWwhORfrFcaAstrngTeg86
 QFu37m5Xrg==
X-Spam-Status: No, score=-101.0 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Tue, 23 Mar 2021 13:32:43 -0000

On Mar 23 21:52, Takashi Yano via Cygwin-patches wrote:
> On Tue, 23 Mar 2021 21:42:06 +0900
> Takashi Yano wrote:
> > On Tue, 23 Mar 2021 21:32:12 +0900
> > Takashi Yano wrote:
> > > I try to check run.exe behaviour and noticed that
> > > run cmd.exe
> > > and
> > > run cat.exe
> > > does not work with cygwin 3.0.7 and 3.2.0 (TEST) while these
> > > work in 3.1.7.
> > 
> > In obove cases, cmd.exe and cat.exe is running in *hidden* console,
> > therefore nothing is shown. Right?
> 
> In what situation are
>   psi->cb = sizeof (STARTUPINFO);
>   psi->hStdInput  = GetStdHandle (STD_INPUT_HANDLE);
>   psi->hStdOutput = GetStdHandle (STD_OUTPUT_HANDLE);
>   psi->hStdError  = GetStdHandle (STD_ERROR_HANDLE);
> these handles used?

Hmm, trying to make sense from the code, I'd say, these handles are used
by default, unless run.exe is already attached to a console.  In  the
latter case, it calls CreateFile( "CONIN$") etc. to attach the new
process to that console.

As Jon wrote a few minutes ago, I'm not sure what this gymnastics are
good for either...


Corinna
