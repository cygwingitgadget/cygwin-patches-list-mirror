Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by sourceware.org (Postfix) with ESMTPS id 6FA693896C03
 for <cygwin-patches@cygwin.com>; Tue, 18 May 2021 07:59:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 6FA693896C03
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MQdI8-1m5NQu3XOQ-00Nmgz; Tue, 18 May 2021 09:59:10 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id E4448A80F9B; Tue, 18 May 2021 09:59:09 +0200 (CEST)
Date: Tue, 18 May 2021 09:59:09 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Jeremy Drake <cygwin@jdrake.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add support for high-entropy-va flag to peflags.
Message-ID: <YKNzzQdISarbXz0b@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Jeremy Drake <cygwin@jdrake.com>, cygwin-patches@cygwin.com
References: <alpine.WNT.2.22.394.2105151214260.7536@persephone>
 <YKJLZE/QFQotdkQw@calimero.vinschen.de>
 <alpine.BSO.2.21.2105171213390.14962@resin.csoft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.BSO.2.21.2105171213390.14962@resin.csoft.net>
X-Provags-ID: V03:K1:0cKGF4PSjgllqbmUGAdfMdo4j7CLM5Hq6TorgSmaq0bWEaO9Ts6
 6a5160Rm1cBkokCnhs3J0d4kpRd90mKuWUUFL24f2I1nGAOBN1200zfCTwXy4sLwWCa2vDV
 /Q3B+PUYfvPuCD+MilnoWJvQtJqNvd+D/HKc4az0XGt/FUoDUKIlzPIOfSr6Dbsn5IWrk+n
 erzQAyjSCoxLEHmdY6T9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Fw+RNTY0Y5I=:/dbqyW2tBq7+qsQdzk92Lx
 mJQTDRhnbJpe58T8bDktgsdb78E2THvZMUUqh5i+80PTNInRtTBbUSSKKduokq08mPx57KgJI
 +8Catt+fVXsrQ73U7Mf8SkH7ptCT1Nu7UCllmpRdykKo8hTIA6gVTrfnyMJPfcHl+WoYqZa6D
 zcQlOCPEr2GIUxa5n3SKGYKB22Sdmd1JPhcX76KcA52/6Crj/zVWZnadQmAcC5HyEVMnppy3w
 2e/z1/LcQOIpuoYZF7hPJAoXDJiZuDdunpwEMPMCbN8G7Rn8R2wGAl6mb9omaFT4hoyRw46FL
 RFYFN9Srx48Vy2bujyDbp2c7TjgbDICo7XY2AShjkVPFAS12e5Q5Zr2MgzyRb2r/A2mV6LUwX
 OtjNV6JO6/c1LETQh/9Yam0OuPZ2jifbV+CD9HNlxMHiMoKhnezEubMzWpeEPBQujzL7WvOKM
 zKY3n0sfHFoITSO9y2IoKGI/W2zqDqZSQv3/vEKQuiKPMOtiLC4Kc2tp2/+gHuVSdR/IbgFQd
 Q5WL4x4YRZlYcDG3oL03Mc=
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
X-List-Received-Date: Tue, 18 May 2021 07:59:15 -0000

On May 17 12:15, Jeremy Drake via Cygwin-patches wrote:
> On Mon, 17 May 2021, Corinna Vinschen wrote:
> 
> > Hi Jeremy,
> >
> > Thanks for the patch, but I have two nits:
> >
> > - The patch doesn't apply cleanly with `git am'.  Please check again.
> 
> Probably got mangled in the mail.  Attached this time.
> 
> >
> > - I would prefer a massively reduced patch size, by *not* changing
> >   indentation on otherwise unaffected lines.
> >
> 
> Done

Thank you.  Pushed.  I'll upload a rebase 4.5.0 release to the Cygwin
distro today.


Thanks,
Corinna
