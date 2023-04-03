Return-Path: <SRS0=7Fjc=72=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id 9C4CD3858C50;
	Mon,  3 Apr 2023 06:39:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9C4CD3858C50
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1680503970; i=johannes.schindelin@gmx.de;
	bh=OY/ArA+oKh3T6Rr4j+xa9j/r2AugRIwM7elvi5U3vek=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
	b=r4D0fvEGV1MUltqf92SXtV1LVpFad41KrjwpNVzOWCW0y2MPdBQlOUyZvTP7l/xwJ
	 j+IoQbBdjg49u3xUjCsEKb6Edf5zy8I4dUqKzogNrPWhBxONpPmJ/kd0rFmDl9O+po
	 vzJcaO2UXDY2QzKZG1gllLWHpcAl7sC5X6ZzstmQ2rICHNDWiZFNFqaD6kfLS1/8Ak
	 5eZLKCVcCmqk1LDXfQjm2yT1saWgwVFTIiQlINJHWZE6Nm5Vt+vmyPRgFPKjnijFHI
	 C/uYWfyS5GJlIg5cWqJdHshwRMk9J54QkV8Wa1qhMvI1ejrfLqakQJmyfE2qpqeAsU
	 xLMlGgc6IjmLQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.182]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFKKh-1pcr7r0XBB-00FhQ0; Mon, 03
 Apr 2023 08:39:30 +0200
Date: Mon, 3 Apr 2023 08:39:29 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Corinna Vinschen <corinna-cygwin@cygwin.com>
cc: Jon Turney <jon.turney@dronecode.org.uk>, cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 1/3] Allow deriving the current user's home directory
 via the HOME variable
In-Reply-To: <ZCP4h7fDkj+60DEh@calimero.vinschen.de>
Message-ID: <4903e63c-8e54-e341-72ca-a083f9f5d77a@gmx.de>
References: <cover.1663761086.git.johannes.schindelin@gmx.de> <cover.1679991274.git.johannes.schindelin@gmx.de> <7a074997ea64d9f9d6dab766d1c49627e762cbed.1679991274.git.johannes.schindelin@gmx.de> <ZCLC1kvfb5Gdk+Cd@calimero.vinschen.de>
 <2ef9176e-9282-d0d1-b047-d8555d4434da@dronecode.org.uk> <ZCLsFCguNjGi5Ga9@calimero.vinschen.de> <ZCP4h7fDkj+60DEh@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:JiTr6SdilnWCOzTtG6WvNFtZ6v0OTtvjGvswFsnQAr7sE2j6VYE
 Brd0e/GCxot2+tw6/MBs3blVKgZqKWDCV91IyZkRsQMMbVI8DQ2FsevvF3VnvIUT+BBCIZd
 H90egB7RMtEXca/fdGG1pVlcjHyTgcEnu3b/yXl1v2SOluoV2S/unblAGS41dzO8gHBp2cw
 PbWwwheXEBtic4Jr5+pzQ==
UI-OutboundReport: notjunk:1;M01:P0:Ucl2RkXC8q0=;jOzytygbPucGlMfL7fgXTJ/MTdF
 hh0C1dOZ8oZHWnc6llLPe4c/xLwahq+LzTZ+ZseQ9oLPjq+DMYmPhTW5FI7dw1XiVUaztrfWQ
 UulO7b8j/P2q3DBG+gXfT9tbtdek8Nc1D4Bcy1BNFPaaYNHsY7bVM9LuVj2du/rPZdkidZfoV
 X5XRt3XuxsGDVB9wdK9ws6p7eF3lCWZVA0IZIpcLc+hNLY7X7ZZsN+7tOnJfzTbpyHv3qdiSb
 arfUoalxxZ4R7mkhLR+ex8nLZGFZLwVk3hDK8tAdjwGIeo1/x82Ds70xnXIv+Co+ykKK17zRt
 H/8yWxeQAxg7twPtzY2wzX9+CXJgKVe3tOEe3vIB9+FF9Ks/rQ5LOZCyWc7OxI+gT50/RNdrg
 LuPTyurB3dgY1gYVGzXCrbaUDUoIOkdVLvzT1UiSNvTx2KXaBGuXWnKN0ESIwIfRGOymdWTEA
 2p0vvnM4PovCH6vHi/jLChMellmpNRxc4FVToOnHxbS3XqkCAveNrd3n4hpgE8skGWygpbmRM
 G2ATPmExWPzovLeGlkSUO35/yMLqPzWlMaDYgBopS4ISe7SEthgFObrhViI0Fk8Jg+d7fQUTG
 278FEni1EWn1QVfGQRIARUyV+Nme+J7jLl3HKmseptkdVluCcWMBMHcUAL51Ro7dTgMANM6fV
 LK6UPSuzsJmuPoMBnGAL2yxdqsQtpY5d0Z62r/Y8CHATXx49Uut5NTS/mPD2JzMLuPYKzNI45
 +ABGhHh/JgLgPFGyIpEtPwl54DgvTUFERUkX3KJG2mLGTW6pxvw6Jr94dZ9kX1Qzi1av2Q4m4
 Hm4wJp55tSTMSsIdbYFxlKK9ME2s2yvanbpH86M5d7NaODg9nOvkc6KWjUZt59hEBu6vNyq3D
 PMzhRYpY9sj71sG99L694QKF3ckRIED0b2xIDUSkjzIEOxY1Gz6klEIyvTMIh/ew/qBDs3CXn
 r2g1jw==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna & Jon,

On Wed, 29 Mar 2023, Corinna Vinschen wrote:

> On Mar 28 15:31, Corinna Vinschen wrote:
> > On Mar 28 13:34, Jon Turney wrote:
> > > On 28/03/2023 11:35, Corinna Vinschen wrote:
> > > > Apart from the doc change, the patch is ok now.
> > >
> > > The preceding text says "Four schema are predefined, two schemata ar=
e
> > > variable", then we add "env" to both lists? That doesn't make much s=
ense to
> > > me.  Surely it's just a "predefined schema"?  In any case that text =
should
> > > be updated.
> >
> > Ouch, yeah, I missed that.  Thanks for catching!
>
> I accidentally already pushed this patch, so I took it on me to fix up
> the documentation.

Thank you for fixing my mistake! 93b05a87c2 (Cygwin: doc: fix description
of new "env" schema for /etc/nsswitch.conf, 2023-03-29) looks good to me.

Ciao,
Johannes
