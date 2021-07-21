Return-Path: <bT.iw45jr2u20=i220zp3eegy4=lb8rp0558s@return.smtpservice.net>
Received: from e2i495.smtp2go.com (e2i495.smtp2go.com [103.2.141.239])
 by sourceware.org (Postfix) with ESMTPS id 5DBA13857022
 for <cygwin-patches@cygwin.com>; Wed, 21 Jul 2021 09:07:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 5DBA13857022
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cl.cam.ac.uk
Authentication-Results: sourceware.org;
 spf=pass smtp.mailfrom=return.smtpservice.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=smtpservice.net; s=md6hz0.a1-4.dyn; x=1626859328; h=Feedback-ID:
 X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
 List-Unsubscribe; bh=aUy9vkkGXngGxgXAj/fP0W6nUq0qhp/qa3CiRyfFO5Q=; b=NxF0eC/k
 xOviLcSSVXvUA4U7aUdANQShKkbCnGfhabCFtnHZjN3uqrV8zOqKS4+1e7NCVLMwGBz1hz6gND1W7
 TOouYNKS0J54QI1f34VEzI+7/zs5UVmhdx/gM0/5K0U0UvUjD3puuJRL4i+XKcHFUOI7wKAtgNLUa
 1TYBPFYvfGCImwh5mB+neywL0oH9WH3Q77oOXfuXU0Lg5K8emh6GhqbvT1lOZssk2fW3nxIUdsrAS
 fDA/9t8MDWdQJ9smJEIZIZj4gmhi4i4Dp+6hw0oLPQ5BDjju3AnYOKIy3MCg3IMolH0+gsdm3bd+o
 GogRtbFCIZNjpy4WYmXuP46Xag==;
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <David.Allsopp@cl.cam.ac.uk>)
 id 1m68C2-TRk3GY-EQ
 for cygwin-patches@cygwin.com; Wed, 21 Jul 2021 09:07:06 +0000
Received: from [10.62.31.23] (helo=romulus.metastack.com)
 by smtpcorp.com with esmtpsa (TLS1.0:DHE_RSA_2038__AES_256_CBC__SHA1:256)
 (Exim 4.94.2-S2G) (envelope-from <David.Allsopp@cl.cam.ac.uk>)
 id 1m68C1-4Xa93I-V4
 for cygwin-patches@cygwin.com; Wed, 21 Jul 2021 09:07:06 +0000
Received: from remus.metastack.local (usr233-bra.static.cable.virginmedia.com
 [62.31.23.243] (may be forged))
 by romulus.metastack.com (8.14.2/8.14.2) with ESMTP id 16L973H2015903
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
 for <cygwin-patches@cygwin.com>; Wed, 21 Jul 2021 10:07:03 +0100
Received: from Hermes.metastack.local (172.16.0.8) by Hermes.metastack.local
 (172.16.0.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 21 Jul
 2021 10:07:24 +0100
Received: from Hermes.metastack.local ([fe80::210d:d258:cd04:7b5a]) by
 Hermes.metastack.local ([fe80::210d:d258:cd04:7b5a%3]) with mapi id
 15.01.2242.012; Wed, 21 Jul 2021 10:07:24 +0100
From: David Allsopp <David.Allsopp@cl.cam.ac.uk>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: RE: Fix nanosleep returning negative rem
Thread-Topic: Fix nanosleep returning negative rem
Thread-Index: Add9eS/VixoQahcVTP2uK87XyOsdjgAil/GAAALsEVA=
Date: Wed, 21 Jul 2021 09:07:24 +0000
Message-ID: <0189b5495b2149c5a690de0431b7695c@metastack.com>
References: <000201d77d7a$2faae510$8f00af30$@cl.cam.ac.uk>
 <YPfdSyPTCdSWhRv/@calimero.vinschen.de>
In-Reply-To: <YPfdSyPTCdSWhRv/@calimero.vinschen.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.0.125]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.65 on 62.31.23.242
X-Smtpcorp-Track: 1X68C14ba93mV4.91O4BoG-OUgo7
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
X-List-Received-Date: Wed, 21 Jul 2021 09:07:10 -0000

> On Jul 20 16:16, David Allsopp wrote:
> > I've pushed a repro case for this to
> > https://github.com/dra27/cygwin-nanosleep-bug.git
> >
> > Originally noticed as the main CI system for OCaml has been failing
> > sporadically for the signal.ml test mentioned in that repo. This
> > morning I tried hammering that test on my dev machine and discovered
> > that it fails very frequently. No idea if that's drivers, Windows 10
> > updates, number of cores or what, but it was definitely happening, and
> > easily.
> >
> > Drilling further, it appears that NtQueryTimer is able to return a
> > negative value in the TimeRemaining field even when SignalState is
> > false. The values I've seen have always been < 15ms - i.e. less than
> > the timer resolution, so I wonder if there is a point at which the
> > timer has elapsed but has not been signalled, but WaitForMultipleObject=
s
> returns because of the EINTR signal.
> > Mildly surprising that it seems to be so reproducible.
> >
> > Anyway, a patch is attached which simply guards a negative return
> > value. The test on tbi.SignalState is in theory unnecessary.
>=20
> Thanks for the patch, I think your patch is fine.  However, I'd like to
> dig a bit into this to see what exactly happens.  Do you have a very
> simple testcase in plain C, by any chance?

https://github.com/dra27/cygwin-nanosleep-bug/blob/main/signal.c was as sim=
ple as I'd gone at this stage (eliminating OCaml from the equation!). It mi=
ght be possible to get it to happen without all the pthreads stuff: having =
confirmed it definitely wasn't OCaml and been able to put the appropriate s=
ystem_printf's into cygwait to see that NtQueryTimer really was returning t=
his small negative value, I stopped simplifying.

Does that repro case trigger on your system too?

Best,


D
