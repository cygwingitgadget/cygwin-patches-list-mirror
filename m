Return-Path: <SRS0=7Fjc=72=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by sourceware.org (Postfix) with ESMTPS id ADF7D3858D37;
	Mon,  3 Apr 2023 13:58:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org ADF7D3858D37
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1680530279; i=johannes.schindelin@gmx.de;
	bh=r/OsMN/AFlDgjF6MjwRxwjp6fkv1vrOWT3718kDbof8=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
	b=iO3vLqiCvr0TR589gg76Fq6QIfCLIdb/M+siOorQaOLdC4XvPNR54TShikpsns+rj
	 nLTRz33gUOxlNPLYjEg+yJ+vJNPQf2BJn29m1GiLkc0sEFvILepeoL/L0DPSxNBgGg
	 JQQy8m9rplVFzHj5lBLbizdtgwwmaHYLHbONDJTsHcQLVYjlly4rphKZlg+W5eyTR5
	 wpGnmc9lZeH7AvCmt+a0VVg2n3v9W96KY1Q8mvX+/B3CdcERM/738zQPoKqjzg+LOx
	 QZ1/oCwSfDFQDgEhItlbX7LpBxn0LnlkV+9pA+mkqfd5L/bxzCkJWYZqWSVgjiDXJ0
	 sGLq9OQymrnrg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.182]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWAOW-1ptifd1t6o-00Xedg; Mon, 03
 Apr 2023 15:57:59 +0200
Date: Mon, 3 Apr 2023 15:57:58 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Corinna Vinschen <corinna-cygwin@cygwin.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 3/3] Respect `db_home: env` even when no uid can be
 determined
In-Reply-To: <ZCrUq1P4kOr7D44O@calimero.vinschen.de>
Message-ID: <f6abb639-8120-fdb1-86ae-103565730789@gmx.de>
References: <cover.1663761086.git.johannes.schindelin@gmx.de> <cover.1679991274.git.johannes.schindelin@gmx.de> <4cd6ae73074f327064b54a08392906dbc140714a.1679991274.git.johannes.schindelin@gmx.de> <ZCK+v7yBxRBft3UK@calimero.vinschen.de>
 <97e5226e-60c6-9d03-0c71-72e3192abe59@gmx.de> <8b84ada5-ae6c-febf-e412-365fe2f919fe@gmx.de> <ZCrUq1P4kOr7D44O@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2DtdtkS3ulNAvNqxgu2TEwSERHF2PQ4x85Vy5ZwnvLsWLxwy12k
 onAdtQHYQx4AeH5zhSjAcunsnfSb8E+rfpumu8K7FA8XNb+T5magV3PmmSsJpQfSy4zEOxr
 gqhSxxPq317lwsc2MdJa+56+Jq/JdzkbAcpvxf9r80sR99yqPzMmIrtm8Auw197C1DubmaD
 caqtxLH20Rj39/1WiXtYA==
UI-OutboundReport: notjunk:1;M01:P0:QdAqe6i64Ro=;HrlncQm81fKC8M73QI2zEY7RVGi
 Py6YQ0junxys8Hs8yfCsQzMbRjRKXLmiwpCtKPdUvUvdmEhztQ0Pk13CGP3H4y/DguKqwKJB8
 4nqd9R1SlP+I6riW2AjfQmOe2goxRFfYsKKGIwl36QhJOLY7ZIiooOtk1woavJanOrY87hm82
 JMvTjUIYyNj4IRB20CY8IU0BgBJFXqvDniReIYwiLe7gpzFHPob03GQLbLocg9+D/AJgXQRpQ
 dxBkHkhFd7du72qZv621JUaa5DssL2j4EmA5ByuJDyvlUN8S+9WTzu6ucEk8e8M1feU6f6qrh
 0wNBsgZk1NVQGCRgmWXlPnGKN2D6epO/xiYHzUswHuqVZJSu7Ww+C5LuduNe2Iw6L01fkUSJ1
 lDLKQnAUWrnnf23eBtj5DepLFpHMQmgRlmGsBvmcg6YchPy2WH20O+hFSBd901W5L665esT6Q
 4GPn7rVzkttJ+Klu67Ewgj+NttWvMMw9F+/AACEZPxuCrC6bVwBm85fn00/6sD1OI2ufcP0H1
 zbC/msFSevPuRzHf/zoBD6PDl/FAA79Lv7rZJdYB8RwMUIWEiOtPNWLQVUcoZ+v4ji/k8ENhC
 itD36gJD/KRQihY8iyIWeyHSpKzNFV/4+nCygFlx6VP3nfh96KMlwKGTftmdD0tn16C3y0RAj
 wjeMdiMr4D/4vtej0TGwJ5Cy0KMhVXZ3v8oi9iamco6FVUvFJeReghNpbzy810LcvFTirpaFH
 jG1IGCClcr8gCQzgUolFPVKVHgg7ZrbOfbijQavsXwgRKtkW70zDxgqVgSlkYJbM4FPW8FTY/
 XJDvT6h9B+K5J52Yv5HlRI2TEGuIW0fWPeFEVhP7KAx7mSrjk3JkHPbDd5nlNYikyUm8rLvv/
 JLexbXV/fryhk36qRU/49ZKljPaBWR5SgIR/cnwGX5APiIYNupi3hms+60wIwZwTsCH2+tDZs
 5y2a9oEv3O3RNXr48UO7ApWosRY=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On Mon, 3 Apr 2023, Corinna Vinschen wrote:

> On Apr  3 15:12, Johannes Schindelin wrote:
>
> > On Mon, 3 Apr 2023, Johannes Schindelin wrote:
> >
> > > On Tue, 28 Mar 2023, Corinna Vinschen wrote:
> > >
> > > > On Mar 28 10:17, Johannes Schindelin wrote:
> > > > > In particular when we cannot figure out a uid for the current us=
er, we
> > > > > should still respect the `db_home: env` setting. Such a situatio=
n occurs
> > > > > for example when the domain returned by `LookupAccountSid()` is =
not our
> > > > > machine name and at the same time our machine is no domain membe=
r: In
> > > > > that case, we have nobody to ask for the POSIX offset necessary =
to come
> > > > > up with the uid.
> > > > >
> > > > > It is important that even in such cases, the `HOME` environment =
variable
> > > > > can be used to override the home directory, e.g. when Git for Wi=
ndows is
> > > > > used by an account that was generated on the fly, e.g. for trans=
ient use
> > > > > in a cloud scenario.
> > > >
> > > > How does this kind of account look like?  I'd like to see the cont=
ants
> > > > of name, domain, and the SID.  Isn't that just an account closely
> > > > resembling Micorosft Accounts or AzureAD accounts?  Can't we someh=
ow
> > > > handle them alike?
> > >
> > > [...]
> > >
> > > What I _can_ do is try to recreate the problem (the report said that=
 this
> > > happens in a Kudu console of an Azure Web App, see
> > > https://github.com/projectkudu/kudu/wiki/Kudu-console) by creating a=
 new
> > > Azure Web App and opening that console and run Cygwin within it, whi=
ch is
> > > what I am going to do now.
> >
> > So here is what is going on:
> >
> > - The domain is 'IIS APPPOOL'
>
> There's a domain, so why not pass it to the called function?>

Sorry, I was unclear. This domain _is_ used when looking for the uid, but
then we run into a code path where the UID cannot be determined (because
the domain of the account is not the machine name and the machine is no
domain member). The clause in question is here:
https://github.com/cygwin/cygwin/blob/cygwin-3.4.6/winsup/cygwin/uinfo.cc#=
L2303-L2310.
The Cygwin runtime then returns -1 as UID.

The _subsequent_ call to `getpwuid(-1)` is the one where we need to teach
Cygwin to respect `db_home: env`. This is the code path taken by OpenSSH.
And that code path only has an `arg.id` to work with (the `type` is
`ID_arg`), and that `arg.id` is invalid. There is no domain in that code
path that we could possibly pass to the `get_home()` method.

> > - The name is the name of the Azure Web App
> >
> > - The sid is 'S-1-5-82-3932326390-3052311582-2886778547-4123178866-185=
2425102'
>
> Oh well. These are basically the same thing as 1-5-80 service accounts.
> It would be great if we could handle them gracefully instead of
> special-case them in a piece of code we just reach because we don't
> handle them yet.

True, but I don't really understand how they could be handled.

> Btw., one easy way out would be if we default to /home/<name> or
> /home/<SID> rather than "/", isn't it?

The default does not really matter, as the bug fix is about respecting
whatever the user has configured via the `HOME` variable, i.e. it's all
about the case when the default needs to be overridden, whatever that
default is.

Ciao,
Johannes
