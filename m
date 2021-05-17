Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by sourceware.org (Postfix) with ESMTPS id 816053835835
 for <cygwin-patches@cygwin.com>; Mon, 17 May 2021 11:03:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 816053835835
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M3lgL-1liK3S3zH9-000qsg; Mon, 17 May 2021 13:03:49 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 7B01CA80EF3; Mon, 17 May 2021 13:03:49 +0200 (CEST)
Date: Mon, 17 May 2021 13:03:49 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Mingye Wang <arthur2e5@aosc.io>, cygwin-patches@cygwin.com
Subject: Re: [PATCH v6] Cygwin: rewrite cmdline parser
Message-ID: <YKJNlWSPUjihmoF1@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Mingye Wang <arthur2e5@aosc.io>, cygwin-patches@cygwin.com
References: <20201107121221.6668-1-arthur2e5@aosc.io>
 <20210513131527.14904-1-arthur2e5@aosc.io>
 <nycvar.QRO.7.76.6.2105142124390.57@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2105142124390.57@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:UZWKQtBj84TMwSL7DUvP7nRWl7KHBgUjG8YFRzvJWdoimiGPNOR
 CqsV5/5UMbTMhP6orduFcYoqS6kGPepJPJz/ztmzObNnJDbLlNCmMbIW3J2ewt1qZhLCYj1
 zB4x6Bz6113N0Ja5/0cy9ABPq2KwjYQIh7n/iUFpPyxK4+GfG6y7V31mnY1JhTW9IwOksFu
 Kn1KJmSwCt0AEhi/2vn1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HoQBCiy2fCk=:xr1OAbjh6hs8ZtlGzdlKDM
 hVEBmnvEfqFk/zlpNzAUsef1Z2e2m1irhQtoeaIaCYC74RuLOQpcXER0MZ9Xouuk/Ma/u8WSm
 Lx5VYFJbtQpbpZ3AiLgns06j//MjfoOmCN9I68+kwgcBlEMRGiEpxQ16cdjLVFfTxf2fpDn+6
 ypKeEeHE5Uh1/BEL8B7ts0VL7ZzfDWh4dBHoCEI1M6+4+74IwZ5JLDs/2W2udMd/XFZkr2CUz
 bGdmR0hjlUPTpcTrjvWVGeHMO9fpLIi06Y+dZwjsUNWDDA3kZCQlJKj+7t2m/YHxC3euXq/bp
 TFB97GjXao4aovq+8RzmzVj30PGoyulWuHP6MX8nGSlRQo0LcVp9ZjL7whxvqHbZAfoaHHGSh
 7JtLa8efeYqynIZLt8ctApEZPthGdj0McVZeym3islNebEfVlhk1+IfmREvaZ7/uGyY8pK1dc
 eU1t7B8AHP20y05rv2TqxujURYzGFT0B7TeysvfrUy1jQwy+2z1aROKcIk192wZeezyo2jvYK
 L6gFm+xA23UQb7BLRxOXtSr+wB3tWKwXyYx19Z3ArTJ
X-Spam-Status: No, score=-100.1 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Mon, 17 May 2021 11:04:04 -0000

On May 14 21:38, Johannes Schindelin wrote:
> Hi,
> 
> first of all: thank you for working on this. I have run afoul of the
> (de-)quoting differences between MSVCRT and Cygwin on more than one
> occasion.
> [...]
> > * MSVCRT compatibility. Except for the single-quote handling (an
> >   extension for compatibility with old Cygwin), the parser now
> >   interprets option boundaries exactly like MSVCR since 2008. This fixes
> >   the issue where our escaping does not work with our own parsing.
> 
> When I read this, I immediately think: This is probably going to break
> backwards-compatibility, OMG this is making my life so much harder than it
> already is.
> [...]
> I ask because as maintainer of Git for Windows (which bundles an MSYS2
> runtime which is based on the Cygwin runtime), it is my responsibility to
> take care of backwards-compatibility on behalf of the millions of users
> out there.

Did you try it?  AFAIU, the patch actually fixes up a Cygwin weirdness,
which already results in broken behaviour, rather than breaking backward
compat.  IIRC we discussed this already a while back, you should find it
in the archives.

> > * A memory leak in the @file expansion is removed by rewriting it to use
> >   a stack of buffers. This also simplifies the code since we no longer
> >   have to move stuff. The "downside" is that tokens can no longer cross
> >   file boundaries.
> 
> This bullet point sounds as if it cries out loud to be put into a separate
> patch, accompanied by the corresponding refactored part of the diff.
> I would like to encourage you to disentangle these separate concerns:
> 
> - moving code (`git diff --color-moved` should tell the reader that
>   nothing was edited)
> 
> - clarifying documentation
> 
> - removing GLOB_NOCHECK
> 
> - introducing an MSVCRT-compatible mode (and make it opt-in!)

What?  No.  There's no point in doing that.  We want a single way of
handling the CLI when called natively.  

> - whatever else I missed in the 304 deleted and 367 inserted lines (which
>   is a tough read, and I have to admit that my attention faded after about
>   a sixth of the patch)
> 
> In essence, pretend that you are a reviewer who wants to help by ensuring
> that this patch (series) does not break anything, and that it does
> everything as intended (i.e. no subtle bugs are lurking in there). Now,
> how would you like the series to be presented (and I keep referring to it
> as a _series_ because that's what it should be, for readability). Ideally
> it would be a series of patches that tell an interesting story, in a
> manner of speaking.

I concur that it would be rather nice to see this patch converted into a
series with patches handling one problem at a time.


Thanks,
Corinna
