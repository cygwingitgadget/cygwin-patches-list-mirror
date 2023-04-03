Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	by sourceware.org (Postfix) with ESMTPS id CDFC03858D39
	for <cygwin-patches@cygwin.com>; Mon,  3 Apr 2023 19:23:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CDFC03858D39
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MmkfQ-1qASXn21qQ-00jqjM; Mon, 03 Apr 2023 21:23:53 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id E7FF6A80CED; Mon,  3 Apr 2023 21:23:52 +0200 (CEST)
Date: Mon, 3 Apr 2023 21:23:52 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 3/3] Respect `db_home: env` even when no uid can be
 determined
Message-ID: <ZCsnyGMLSGY1nHbe@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	cygwin-patches@cygwin.com
References: <cover.1663761086.git.johannes.schindelin@gmx.de>
 <cover.1679991274.git.johannes.schindelin@gmx.de>
 <4cd6ae73074f327064b54a08392906dbc140714a.1679991274.git.johannes.schindelin@gmx.de>
 <ZCK+v7yBxRBft3UK@calimero.vinschen.de>
 <97e5226e-60c6-9d03-0c71-72e3192abe59@gmx.de>
 <8b84ada5-ae6c-febf-e412-365fe2f919fe@gmx.de>
 <ZCrUq1P4kOr7D44O@calimero.vinschen.de>
 <f6abb639-8120-fdb1-86ae-103565730789@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f6abb639-8120-fdb1-86ae-103565730789@gmx.de>
X-Provags-ID: V03:K1:SkjE0M5wxbwJuY9NhPiKdQ4Xj7JVkLsAhSKS5nnNf5sVtsBIoXq
 h/+QVPFWqQHaewhIWMBcxSR8dX0+TXJUnuI4x9Za9DC9H+lNrNZJCSKV3OQGD6dRgTpFJ8a
 Q2d2ga4pDQ8BjpYybggmBIUru6Jr7mD+Q8kpVBmUfJTgeseQeDnUaukonjZHCz6/gIDof5n
 sRI4qg2+aS2uq2E+8Mobg==
UI-OutboundReport: notjunk:1;M01:P0:tshS56KdPHY=;qpu1cEJYmvS3w6nlPQtEUd1lXhH
 0fHemCq/5UmJOmY959VLUU4+PM25NGUAWzoUZPBm5NYBsMh95nkSUcDt4IVFs1MOOQWhfg/l3
 hSRtr1DbF+a8O0n9GxqDvTF1NRN7ElltEHEX2DkWjwsASW0ATZGONcMqYrCflsnvMZglLRUoc
 4wntuuY31KehghMs1VXcJrPhAiNah2VFy4adm4P3Sc7rYakBM0nopoP653Z9guM2G22rhYXGx
 v/ymOUkSuaTo1kzIOeMPU38cyhOhSdEyvpVTkf23EKMZRe44Orp5GTeXeUEVT/wvYJrzPAUj9
 6Il8WRg4GsDOTmOvdlrc9TEN4DqPTAqJMHbP9ns95EA7YAjV6Aw3y9sCt0uw86WFhuBL0bHRj
 PIx4Wxds+B6t5ArPjIjtdVuDyt6GNWmI6RJ9ifLvyY4EnYa2iR9OK8oqwBjWxc8UCLUri/1ot
 je4H8UHY/yu7uALo9YxxHQEUmbdKSFRSef0LZxWTnlnpUfOi7qtA0iLM6AXmYdUW5k2RIQcqN
 u7hhnqcdIyIklIn/zEkNRqnBFI8snyk/NA6alyevouTgSjTS8l9n0n6x9pakuHymgksPqtHX3
 dO7Odi9EY3vB9dsYhdVeNXdhjkJh9b0++ToFUxnUIbqYr5uVrgLLGR0aUSe2JvMUyrGdVJDio
 6cU1maPmYp4v02JgM7WUDGpipEmVnFrqsCaDBuZ2iA==
X-Spam-Status: No, score=-97.7 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_NONE,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Apr  3 15:57, Johannes Schindelin wrote:
> On Mon, 3 Apr 2023, Corinna Vinschen wrote:
> > > So here is what is going on:
> > >
> > > - The domain is 'IIS APPPOOL'
> >
> > There's a domain, so why not pass it to the called function?>
> 
> Sorry, I was unclear. This domain _is_ used when looking for the uid, but
> then we run into a code path where the UID cannot be determined (because
> the domain of the account is not the machine name and the machine is no
> domain member). The clause in question is here:
> https://github.com/cygwin/cygwin/blob/cygwin-3.4.6/winsup/cygwin/uinfo.cc#L2303-L2310.
> The Cygwin runtime then returns -1 as UID.
> 
> The _subsequent_ call to `getpwuid(-1)` is the one where we need to teach
> Cygwin to respect `db_home: env`. This is the code path taken by OpenSSH.
> And that code path only has an `arg.id` to work with (the `type` is
> `ID_arg`), and that `arg.id` is invalid. There is no domain in that code
> path that we could possibly pass to the `get_home()` method.

That makes a lot of sense.  However, wouldn't it be better to return
some kind of valid uid, rather than working around uid -1?

> > > - The name is the name of the Azure Web App
> > >
> > > - The sid is 'S-1-5-82-3932326390-3052311582-2886778547-4123178866-1852425102'
> >
> > Oh well. These are basically the same thing as 1-5-80 service accounts.
> > It would be great if we could handle them gracefully instead of
> > special-case them in a piece of code we just reach because we don't
> > handle them yet.
> 
> True, but I don't really understand how they could be handled.

We do something along these lines already for the AzureAD SIDs of type
S-1-12-1-what-the-heck.  If we do the same for the S-1-5-82 IIS AppPool
accounts, we may be able to handle this more sanely.  Just search for
AzureAD in uinfo.cc.

What do you think?


Corinna

> > Btw., one easy way out would be if we default to /home/<name> or
> > /home/<SID> rather than "/", isn't it?
> 
> The default does not really matter, as the bug fix is about respecting
> whatever the user has configured via the `HOME` variable, i.e. it's all
> about the case when the default needs to be overridden, whatever that
> default is.

Right, that wouldn't help then.


Corinna
