Return-Path: <bT.geahot2u20=hfbeiiwm8iyo=a99fa32ozk@return.smtpservice.net>
Received: from e2i495.smtp2go.com (e2i495.smtp2go.com [103.2.141.239])
 by sourceware.org (Postfix) with ESMTPS id 752FC3858003
 for <cygwin-patches@cygwin.com>; Wed, 21 Jul 2021 16:02:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 752FC3858003
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cl.cam.ac.uk
Authentication-Results: sourceware.org;
 spf=pass smtp.mailfrom=return.smtpservice.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=smtpservice.net; s=md6hz0.a1-4.dyn; x=1626884233; h=Feedback-ID:
 X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
 List-Unsubscribe; bh=lokConJzZQugGpaGebZ/O/xm75YerHmrrND12CxAE6M=; b=3FvTKNYj
 hT4anGg3YjM02mifnIYWM+xx9zdiMHWC4R3h3gFt2TzuVUFaSpVICqa9o6a/gstzryWvzBz80uTUD
 OyOLdqRUUt6rHFRAQQUqa0h3cLBVMNjZQi0gA8RoRJg3o993pVOf1UwCzIp69uLroBhFrT/26nqTV
 uYkcPZydznDblfGXvnxM39TvbrcOGgoHKYhkLne0SzjXY0z42uqAVeCf+n+Gw/P+kzXFWhLCeLPwe
 /Y1H+SuJ8wb3zK+7zzpvt6Fo9oDYDzi1RHVICChK9UOHJs6cUN+rVq6Knk36Wm3TNeAnjeaG8u5Rv
 XU8BWlNvrcJ8mSXADH9GaQ2mWA==;
Received: from [10.176.58.103] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <David.Allsopp@cl.cam.ac.uk>)
 id 1m6Efj-TRk0eV-LJ
 for cygwin-patches@cygwin.com; Wed, 21 Jul 2021 16:02:11 +0000
Received: from [10.62.31.23] (helo=romulus.metastack.com)
 by smtpcorp.com with esmtpsa (TLS1.0:DHE_RSA_2038__AES_256_CBC__SHA1:256)
 (Exim 4.94.2-S2G) (envelope-from <David.Allsopp@cl.cam.ac.uk>)
 id 1m6Efj-9EFQ5T-7x
 for cygwin-patches@cygwin.com; Wed, 21 Jul 2021 16:02:11 +0000
Received: from remus.metastack.local (usr233-bra.static.cable.virginmedia.com
 [62.31.23.243] (may be forged))
 by romulus.metastack.com (8.14.2/8.14.2) with ESMTP id 16LG287e022821
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
 for <cygwin-patches@cygwin.com>; Wed, 21 Jul 2021 17:02:08 +0100
Received: from Hermes.metastack.local (172.16.0.8) by Hermes.metastack.local
 (172.16.0.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 21 Jul
 2021 17:02:29 +0100
Received: from Hermes.metastack.local ([fe80::210d:d258:cd04:7b5a]) by
 Hermes.metastack.local ([fe80::210d:d258:cd04:7b5a%3]) with mapi id
 15.01.2242.012; Wed, 21 Jul 2021 17:02:29 +0100
From: David Allsopp <David.Allsopp@cl.cam.ac.uk>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: RE: Fix nanosleep returning negative rem
Thread-Topic: Fix nanosleep returning negative rem
Thread-Index: Add9eS/VixoQahcVTP2uK87XyOsdjgAil/GAAALsEVD///bsAIAAAKGA//+OBdA=
Date: Wed, 21 Jul 2021 16:02:29 +0000
Message-ID: <2271051beb734ce984ed71eab4180746@metastack.com>
References: <000201d77d7a$2faae510$8f00af30$@cl.cam.ac.uk>
 <YPfdSyPTCdSWhRv/@calimero.vinschen.de>
 <0189b5495b2149c5a690de0431b7695c@metastack.com>
 <YPfpSgbZbr+bnOWE@calimero.vinschen.de>
 <YPfp0WgZUVo0nap7@calimero.vinschen.de>
In-Reply-To: <YPfp0WgZUVo0nap7@calimero.vinschen.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.0.125]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.65 on 62.31.23.242
X-Smtpcorp-Track: 1X6EfM9EFQ5T7x.AelC8SckKLp3Q
Feedback-ID: 614951m:614951apMmpqs:614951spYkYyw7C3
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00, DKIMWL_WL_MED,
 DKIM_SIGNED, DKIM_VALID, DKIM_VALID_EF, HEADER_FROM_DIFFERENT_DOMAINS,
 SPF_HELO_PASS, SPF_PASS, TXREP autolearn=no autolearn_force=no version=3.4.4
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
X-List-Received-Date: Wed, 21 Jul 2021 16:02:14 -0000

Corinna Vinschen wrote:
> Sent: 21 July 2021 10:33
> To: cygwin-patches@cygwin.com
> Subject: Re: Fix nanosleep returning negative rem
>=20
> On Jul 21 11:30, Corinna Vinschen wrote:
> > I wrote a quick STC using the NT API calls and I can't reproduce the
> > problem with this code either.  The output is either
> >
> >   SignalState: 1 TimeRemaining: -5354077459183
> >
> > or
> >
> >   SignalState: 0 TimeRemaining: 653
> >
> > I never get a small negative value in the latter case.  Can you
> > reproduce your problem with this testcase or tweak it to reproduce it?
>=20
> Now I actually attached the code :}

:) Yes, I can reproduce - I didn't even need a loop! Third time:

  dra@Thor /cygdrive/c/Scratch/nanosleep
  $ ./timer
  SignalState: 0 TimeRemaining: -1151

That said, I can get it easily get this on my desktop (AMD Ryzen Threadripp=
er 3990X) but not at all on my laptop (Intel Core i7-8650U). On the laptop,=
 ignoring the couple of signalled cases, 747 runs of timer.c give values be=
tween 131597-149947 with a very narrow SD (~4000) whereas on the AMD chip, =
738 runs gives a range of -2722 to 149896 with a relatively wider SD of ~23=
000.

The CI system where this was first seen is an virtualised Intel system so i=
t doesn't appear to be as simple as CPU manufacturer or even core count. Th=
at said, I'm not at all familiar with the details of how this works, but I =
expect the timer for these things is part of the chipset, not the CPU?!

Best,


D
