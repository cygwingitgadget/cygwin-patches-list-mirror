Return-Path: <SRS0=7Fjc=72=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by sourceware.org (Postfix) with ESMTPS id 1E02C3858D37
	for <cygwin-patches@cygwin.com>; Mon,  3 Apr 2023 13:32:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1E02C3858D37
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1680528750; i=johannes.schindelin@gmx.de;
	bh=y9n3Xqk8+SKvsjO/ImYBZfgi3JJiUUvVpFxwhN2N0rI=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
	b=W+DkD9P7TcO97Scqhfq+tM4/Z1ZueVAXUhe9rl0NGuAJTZeJzRDAEtSL/7ndqyzVn
	 VCy3JRIB1nVvN2sxKVsluyQ1EZFDdHvV9PHkM8wJeBhov3i7pDsCwwlpM7k+eMHSLz
	 lifEul/0f1c9cS8SCOPKhJ3mXezzHisBtira9YVmL4FAipEAtNCFUCdBDe0KXDseMC
	 DRCtPRd78oCSy9a3Fcc6Em+kw5pMNF7xbJ8XWSeudmmMiYsxczaePStbWouhd4bsCR
	 QAv4LG/CyGP1azXbDpgFGzb5c8FlR3+4GtYSRxFDdmbq9vczjnwa0H4RSJJxQWYPFl
	 50tX9B/DXNhjQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.182]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7sHy-1pnA3L3npC-004yeU for
 <cygwin-patches@cygwin.com>; Mon, 03 Apr 2023 15:32:29 +0200
Date: Mon, 3 Apr 2023 15:32:28 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 2/3] Respect `db_home` setting even for SYSTEM/Microsoft
 accounts
In-Reply-To: <ZCqxj6PWp0d0dikW@calimero.vinschen.de>
Message-ID: <815afbec-2f4a-0604-226d-b9e160e6204f@gmx.de>
References: <cover.1663761086.git.johannes.schindelin@gmx.de> <cover.1679991274.git.johannes.schindelin@gmx.de> <a70c77dc8f0d8417537557ea8e3a38f85bc582dd.1679991274.git.johannes.schindelin@gmx.de> <ZCK+mOdyaAQnLBwF@calimero.vinschen.de>
 <f14da2f0-2e7d-73c4-e6d9-e2516b8966f2@gmx.de> <ZCqxj6PWp0d0dikW@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ezRKGaQ/HjXHfaimaHCFZPTxq5PioLR+UkN37ssbxcbf6g/P/AG
 UD9+THiBtngGADph4O934+bOQbM2ad+Zzv1BBV8u5ZOOLcDhQ2WJWjCgIt13cuc+p6L3ziU
 H2wPm7hQhf5RzgVAlpdCJ4Oe1WJXPfQR7eMI5XuvUVFE3EdbOlFl56GOyVIpvpoeB2ZCZZi
 QY/qZKS1YTvZHD46UuvaQ==
UI-OutboundReport: notjunk:1;M01:P0:2riIGofibRs=;PGOCaO4mLOiBRmKNbglJzGVEgpH
 llK38inetTQYf8EZOygVmM+F8qmPh/7N2mW54hVQX5tkyS+eYiIydy8QKn5ftPa5wpAJ9hoQy
 0ycJquGi2woGgHyUVINKbx7oFCcCGv4MN4I3cl/oZaviuFE4thXGUY984JXZf0/AlxkLS0v9J
 Fk3V4inoSd9c93Os7ANRBCAjEQmm78MnfHAzEqTvIUn8rxC9lreuwM4UqW1EptDQifUtBw++4
 YQPOeWaxP2F3hT1T6rPTChLxQQMJGKrphakFb2sqaoMyrd1335C2weMkroD5G6u9LDHsqZF/u
 pphxXGcwyAvEQ/YGKXBAWGNHyIBXN8CTpG0NEFXqN57i5A9xK0UEUTfTN/KxxrojwQ/aF77dd
 qp9Ef+JSi8ykr4mWbAfXINzhetsfyzyIY2+RsvHAtzrCxf4KU4UnRk13CCK50vdvmTAofraJN
 dta+H24MTTg34FdZhneunEuJOzKjrgZKHWrgVehZRSzwprNJ65gsdQBnpXTyPp3bmbZaY+FZP
 jY875q/Sxwf4ShJSSX93NugrjK77H4KZ2ZJC8Dzh5SPYSarrCIYGVkzJwL/sXybV3LA8u5j5y
 OO80ljjt9eCdUYwIDA5yc9qPg8emGEQz5nynB3UiRswrSk5QmlIIBT72uqL5qxl/w8TPZKPqI
 SyZGb22hv1TD5V19ud/UvgksXKNayCQsSoMmqH8HywZ2bM9hF9RJ7GFu1m2Xmq2Q/5hKDebxu
 UQY8cpwC7ksctvmp/ERo9cJZhbIzqclFveML35pSQRfWj/qyANPfKyPwFCPnzESOthnM2RRnY
 GdPjJea2sUbuF1EG+j5NJdqjn7sd9KwWcG6UFL1Ww032XNLYywHilXHZMXALtVqmWzd0wq/Ua
 EzudlmFaR3Dsr06x4iaz+z6ZwEyRh91JFFfAcQfJMLJEgfaYLyGdMWgeeTcfMJRHlP8uplDeJ
 eq/DEBUjQaqGmT522qxnQ6iwPjk=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On Mon, 3 Apr 2023, Corinna Vinschen wrote:

> On Apr  3 08:36, Johannes Schindelin wrote:
> > Hi Corinna,
> >
> > On Tue, 28 Mar 2023, Corinna Vinschen wrote:
> >
> > > On Mar 28 10:17, Johannes Schindelin wrote:
> > > > We should not blindly set the home directory of the SYSTEM account=
 (or
> > > > of Microsoft accounts) to /home/SYSTEM, especially not when that v=
alue
> > >                                   ^^^^^^
> > > That should probably better be <username>, no?
> >
> > No, this is the actual name of the home directory when you start
> > `Cygwin.bat` using the SYSTEM account.
>
> I know, but that doesn't match the beginning of your sentence:
>
>   We should not blindly set the home directory of the SYSTEM account
>   (or of Microsoft accounts)
>    ^^^^^^^^^^^^^^^^^^^^^^^^

Ah. I totally focused on the wrong aspect. Will fix the commit message.

Ciao,
Johannes
