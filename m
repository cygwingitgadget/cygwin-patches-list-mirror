Return-Path: <SRS0=YyD5=3S=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id BB4ED386187E;
	Fri, 18 Nov 2022 08:18:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org BB4ED386187E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1668759499; bh=CnjK28yFKGMxvfKjO68BEpcFYqnTC3nFu4z48wOm5Kg=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
	b=Z93G3fJ4waDZXxbYCWPMYbQi0OQVMrt/SYZqq2PvS9r/d5YOmweiEYxZ6h6nGiDN9
	 9BJ+PWKsal6m0tgK66tDL82cyte8k1hiGkhvdWv/fE16hryDiU+q0iTl3e8OTAG4FQ
	 tlGk0qlaWFnxHTPos6jQLmeaMarxYaFGdHw+R1lWM4e+IWYlEsXWwEK0ThpdErC9nb
	 3J9VdYbvSqjkc93nJUdJL9zeN1LQ58f1nM8DP9v7OkKYkK3Vjm1qExqTnLPWQoeP+0
	 3Avtyb+4Sky65dZA7kLYBT50NYYqpzRyLu8XxBLeLAQD9cQZYG7yRcGC+s6m6LG9yS
	 Unh30itzF2pYg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.29.212.27] ([89.1.212.70]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mk0JW-1pOdUp0aXQ-00kP4r; Fri, 18
 Nov 2022 09:18:19 +0100
Date: Fri, 18 Nov 2022 09:18:17 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Corinna Vinschen <corinna-cygwin@cygwin.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/2] Allow deriving the current user's home directory
 via the HOME variable
In-Reply-To: <Y20XK4VybCriMmn/@calimero.vinschen.de>
Message-ID: <qn135110-43r6-o86o-887o-1rn29574s263@tzk.qr>
References: <0Lg1Tn-1YnzUw0ScN-00pcgi@mail.gmx.com> <cover.1450375424.git.johannes.schindelin@gmx.de> <047fe1d78c365afca7edfdf169fff5e1940c3837.1450375424.git.johannes.schindelin@gmx.de> <20151217202023.GA3507@calimero.vinschen.de> <1r1pq0r7-o3s3-so08-o426-296542797q94@tzk.qr>
 <Y07cOhhwu4ExRDzb@calimero.vinschen.de> <0q096627-r8pr-rno5-0863-s6n90psosq07@tzk.qr> <Y1Z48Mdk79/Qtwc9@calimero.vinschen.de> <66o0nq89-4599-np26-625n-2n8oon6p558q@tzk.qr> <Y20XK4VybCriMmn/@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:uVOBHbIGGdBr71AvM5FQFQHgrrALX5DWNXwbn4CAeAU63MqIPbZ
 mJVCwZGD8a37oqzaHKCFrAY89GAP1POfAQTGNPTO1Bo9lSIaCOsKTOYKuJLk0/Bn+RN+r3I
 kRruDOMJU8cntyeMqYAnJ3wVB0tV+P9w2ponn1R19aImGSp8xlowmQAk6nlGuwC6+sV/2zb
 pxw2AwTsFgyMn/T1e0eEQ==
UI-OutboundReport: notjunk:1;M01:P0:tX6W0wD48YA=;6O6wTzV2icDeq9PG1PEicHOfWNZ
 uxr+YAONqxpJ/wOYNicAY3VaWeEu9W3fSXtxMLTJKna83tRriI5ivfDkFzF/u17jOGOFCMemA
 bQALbexiUAyPbsMkICuQDB5eeWoX71zFrS5ZETx6dXznNgLVJ04rbXzXc7PqBLrx1BBEt2a04
 tZ9hF49qyPEg3TZSdb0YoXyP9tyzegKLL9i8z6Jweh4ncQC7TgTCypKwp+vzFTQW2LZ5CwDyO
 pReGJyH+aj4cKhBf2jzArZeWyHx3ffxD5lBJMoFUeIxAG95IxJM6Rg9eyaiJPiPLRs2u71bT9
 KXXxEM3fbo+wEpvGQJc9gdiimuple1z4YGjqR759AyCI3joCqy39LEXHiaUtAVVbhceXoMaso
 TQ3YF29z8I7HZsmUJb9fIeiR6ts+B1swBT25mQkgN/MY4ssmLAG/b/6ZhBmJGmqtAvklGLEXj
 YN00DXbwwCXZULdbiZ4JaJfh43sg8sUftvF4NG/rSTEWUpZvKWgNvs0frTmgUDDLjeOR8RMq4
 9O8XDFO6qw5TdF2kZEV635dGUyml3bMr/3BSopmLEbP1gXVPBpp2CzclzUfTaoIx9pkEykTJf
 auSZUaQthCqzSiYIPsQzpe/wP3X+zmd5O30LnliKTU+avzZvD3MnyvliPaMqPNlpaPxmMV0YA
 jVc7mPH+P+YvHJBQ++UN6GHRP+xidpZpbdqPCrseBGOOiVT3CKojI8zx9CBavX4udj8YPYy/Y
 r6jNLiCp5zx7m0xe+ZIu0/UxHXUCpMuu1PtwOM5XwG/bhVBsWTiRjmzea8ghe4fWhP+35VrRE
 bs4d+PvxoUIMDhjF5JUvVI7pRu5BxvSVH7YsQARo4zVhUwFarmQge0N7B9eJAeKaY5cDrTMNp
 2/M4KeXpSMd6xI5XnbXYaQq0s6rhMIN359l2zFlVFhfmZBfsKXH3h0cVmOxiQoFy21+0BE3xe
 9Y5tXA==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On Thu, 10 Nov 2022, Corinna Vinschen wrote:

> On Nov 10 16:16, Johannes Schindelin wrote:
>
> > On Mon, 24 Oct 2022, Corinna Vinschen wrote:
> >
> > > On Oct 23 23:04, Johannes Schindelin wrote:
> > > > On Tue, 18 Oct 2022, Corinna Vinschen wrote:
> > > > [...]
> > > > > That means, the results from the "env" method is equivalent to t=
he
> > > > > "windows" method, just after checking $HOME.  That's a bit of a =
downer.
> > > > >
> > > > > Assuming the "env" method would *only* check for $HOME, the user=
 would
> > > > > have the same result by simply setting nsswitch.conf accordingly=
:
> > > > >
> > > > >   home: env windows
> > > >
> > > > Except when the domain controller is (temporarily) unreachable, e.=
g. when
> > > > sitting in a train with poor or no internet connection. Then that =
latter
> > > > approach would have the "benefit" of having to wait 10-15 seconds =
before
> > > > the network call says "nope".
> > > >
> > > > This particular issue has hit enough Git for Windows users that I =
found
> > > > myself being forced to implement these patches and run with them f=
or the
> > > > past seven years.
> > > >
> > > > Given the scenario of an unreachable domain controller, I hope you=
 agree
> > > > that the `env` support added in the proposed patches _has_ merit.
> > >
> > > Yes, I don't doubt an `env' method checking for $HOME even a bit.
> >
> > Cool!
> >
> > > I'm just not sure as far as HOMEDRIVE/HOMEPATH/USERPROFILE are
> > > concerned.  Those vars should be left alone, but we can't control th=
at,
> > > so reading them from genuine sources is preferred.
> >
> > I do not recall the exact reasons because it has been a good while sin=
ce I
> > worked on these patches. But I do remember that we had to have a fall-=
back
> > for the many scenarios in Git for Windows where `HOME` is not even set=
,
> > and we specifically had to add HOMEDRIVE/HOMEPATH handling because
> > USERPROFILE alone would lead to problems (IIRC there were plenty of
> > corporate setups where USERPROFILE pointed to a potentially-disconnect=
ed
> > network drive).
> >
> > > Sure, the downside in terms of the LDAP server is clear to me
> > >
> > > So I guess it's ok to allow the env method to read the values of tho=
se
> > > vars from the env.  I would just feel better if we urge the
> > > user to set $HOME and read that exclusively.
> >
> > I would feel better about that, too, if it was practical.
> >
> > But I cannot ask millions of Git for Windows users to please go ahead =
and
> > first configure their `HOME` variable correctly, it took much less tim=
e to
> > implement the patch we're discussing than asking all users individuall=
y
> > ;-)
> >
> > And since there is nothing specific about Git for Windows here, I expe=
ct
> > Cygwin users to benefit from this feature, too.
> >
> > With this context in mind, I would like to ask to integrate the patch
> > as-is, including the HOMEDRIVE/HOMEPATH and USERPROFILE fall-backs.
>
> Can't do that, sorry.  Two replies before I sent a necessary change,
> which needs inclusion first.

I am a bit confused. Do you need anything from me to move this along, i.e.
are those two replies you mention some emails I failed to address yet?

Thanks,
Dscho
