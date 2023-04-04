Return-Path: <SRS0=8BlN=73=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by sourceware.org (Postfix) with ESMTPS id 98BFC3858C54
	for <cygwin-patches@cygwin.com>; Tue,  4 Apr 2023 15:12:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 98BFC3858C54
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1680621131; i=johannes.schindelin@gmx.de;
	bh=el3dtAqNFTNepwamORtBpHkKKB9s/LlpVqiPbqqJdvY=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
	b=KQqaYCJZv6GETmWGFJAhTpaBdMsncCS8fo7Ox3KWxcv6eqs/piy80bTVNfxGG4kzA
	 /USV6SVme9u9FQfNE2g3l1weecNl5NosEOqTESHCPx5mwCsKALgPfGR5IBE0FuCXvx
	 fQWGjAMnsCGhFL7cZSs14oFlL3MCMXtH+P0hDgOEIhyra4ifCqwSbmovdfC4GD3MYv
	 763vCNQH/jURe+9QHco/NXvcQJ4luvqZa5lOh5xSjhlftV8DJAv3pBGL7C0L1hY209
	 Q+ZJdAvuMmsJAU9AIArCIgAPNXdPCOzUthCSR4RaZwatntx6MYmocPMa+Ca7JKXcTx
	 vgh+LgULDOSYw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.182]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MqaxU-1qEbBD0X0i-00mZAN for
 <cygwin-patches@cygwin.com>; Tue, 04 Apr 2023 17:12:11 +0200
Date: Tue, 4 Apr 2023 17:12:09 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5 1/3] Allow deriving the current user's home directory
 via the HOME variable
In-Reply-To: <ZCscsuGjXqL8W803@calimero.vinschen.de>
Message-ID: <12fa1c55-af0f-3fad-f03a-9179ab5dd598@gmx.de>
References: <cover.1679991274.git.johannes.schindelin@gmx.de> <cover.1680532960.git.johannes.schindelin@gmx.de> <e26cae9439b01c8a958eb19072c88e9db3abd36e.1680532960.git.johannes.schindelin@gmx.de> <ZCscsuGjXqL8W803@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:alIiyQNNdMhckjr12jbEhmdSj8EpIPwL27yiGndyrSnH0EHM2DM
 hIMdrvi6AVAo/YQC2a6wWD8Paqi1YUe1gCbakdsavVoSkGdm2bMf2PN4/ekZ5smEQ4j8gSE
 PMoz+LRe3o5GMurBEL8zm8Gm/8vWNInm9oHlWDM6crmsOllvA79WAfNJdKJc84AcBWnR8Sw
 I/ppA8EI8ZOkqzSxamQGg==
UI-OutboundReport: notjunk:1;M01:P0:K0+4fsRDEdw=;ZtElxRwwLT264d1GYrU5ZTiyGdj
 ry0iuBdS0+PMUTvGcwROtRHpsjDMouNtnUHwIP3Vy40DTBmRcvWUM+i5nJHEOcCv4mXo6d8fu
 /9zCOs5gioam7B9ST0leflY+EglJ95R6bRdbBjlTtwVo9dAlWJTDV1Spm8iBA8uLg0Qrl8p0j
 EmHBB6XfaXARbSg4mgfdf15QyxLoqEKTO0OjJMtJX1AqoQ6HaOUja5mrxcRU1hcNbwDeyZKr5
 pSE87Qd/KQRENOYzt86KZw2zU/h2dEjLKudBFq9fll1K4IO5b7/yDRv4Xg5sjwtXeioafdV6v
 8zb3ne4BvVXEb0Ir0xfFRLhWwgJaGeTkP/sOYZtDw4cO1cjrmd22hXdeqK7Q03SIKu4qe5u8Q
 0qAJ8qSSBFucOH8ZUNgVSy0nCYiQehKWHiV+6teU5lF3gGs4iYqYIPbWe5GpMQ/HCoaP+dPUJ
 uBQ3uTz76j96rLdmBRNxt9XNrUsivma6hCoidJUC/AvYdhqO4exjBPcgFxULb6yj8UAVsGehE
 71/fxGRCA/Sge+OD3oNtg5CRodjHbAqZLfc2AherH4XWnUaXa4M2HjSGYZG6CN87c0IFtnLmF
 4UjH+Nb60fArWLlBGN1H3TSime6djuObwMb2LJoj2Dqh34zYVh8voN3r/Te05Y9lyFP1xoHx1
 cJ67F2eYwA1CWoTpK4kdawh+q8kSVO6UWvFo+sAu6PZl4Qfjn9CfuM6eadTMouKJ8RRuKPWfD
 zpNWDaG1/PCHPdir5A9IzDxfgBFgJlsGXpG/rw0wdGyeB3Lx56BhjPMS4bCzvDmkVH3m1DSzA
 BG0XKrd00caY3r3gSuY+HFdtDyHp8HpuaogphlT30mPfTKrm3vq6XOn+wC9y0Et3qKna0YHOH
 0aD8wJwhzwwa2KAUlRo85db0r5DqhXQigGofE0t6rO43crTxz5qYrEE6knpF6aSN7isY5/cyh
 WOorxQ==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On Mon, 3 Apr 2023, Corinna Vinschen wrote:

> On Apr  3 16:44, Johannes Schindelin wrote:
> > This patch hails from Git for Windows (where the Cygwin runtime is use=
d
> > in the form of a slightly modified MSYS2 runtime), where it is a
> > well-established technique to let the `$HOME` variable define where th=
e
> > current user's home directory is, falling back to `$HOMEDRIVE$HOMEPATH=
`
> > and `$USERPROFILE`.
>
> This patch is already merged.

Yes, I am sorry, I wanted to keep this in the patch series for
completeness' sake and also to make backporting to Git for Windows' MSYS2
runtime easier. That's why it is a part of v6, too.

Ciao,
Johannes
