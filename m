Return-Path: <SRS0=y6DA=FD=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by sourceware.org (Postfix) with ESMTPS id B19D54BA5439
	for <cygwin-patches@cygwin.com>; Thu,  9 Jul 2026 07:59:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B19D54BA5439
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B19D54BA5439
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1783583995; cv=none;
	b=w77YJxnXav4JgEZyv5fNsx6rXhW63qgAeBqg+QMO494TeuuUk/P3N0zvKfXEESTPvINq821TVIXy23Q3P6ijptyvfksP4iB6g4PKwu3V1Rqcm1mwD8SoxM7B2SoQlTS9HWDuFenAhixoPL8CxofSKk+DXzj0kpP/yGJnpKAV+0s=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783583995; c=relaxed/simple;
	bh=/seeNHNC0BjQ8HhEX8qgDOH3BUJuXMo3M2oK5F28kck=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=q/0QoqpDDuyDsQyi2ZhrTAJ07FBEfZsu0Rvgp37xA+qXf3f3WpOz+VEAuJswHVn/YxnfQVXXHm+nmEoC+PnhVeXM/8N/4+4bzPDHr/5lf4kYVCGOhp5wMk4clkZ9FwuFOH59xQ23wgZqGZuo4PtUU/jnrO2O53YneEoTSBTKf8M=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=J/rgKDSp
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B19D54BA5439
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=J/rgKDSp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783583993; x=1784188793;
	i=johannes.schindelin@gmx.de;
	bh=/seeNHNC0BjQ8HhEX8qgDOH3BUJuXMo3M2oK5F28kck=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=J/rgKDSpL6O/rZcqBdHInYqd4jfqgVikF9ZkSNxj2l3t58mG/blq9WTQCYekqbE/
	 9Sww24FBQIVsGDHHUfswOftSN1Kgwvgp6Hnc2P6doAcCSkQKb27fytHCVq0zQtAc1
	 a7u7D09ih7TrRkW77KrQL9fnhF/ZzyZFk0Omrvp9ZDz6a577riOyv2cOHg3yhwv94
	 ANyaGCddrxdwslZIdWT3JgS3wkQJo+9WFd9LWo+pzMIe7/xkQp9sbLITUawktLBQ0
	 QBVoPIwyzSqj3+S9fMXoWcc1xnI/Z+0KdqsjnGVo8poFmxwilpTbZH374/CgIhTNZ
	 FuCy49w7sMEwRYq+vQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MowKc-1xQRXT0qGE-00imFF; Thu, 09
 Jul 2026 09:59:53 +0200
Date: Thu, 9 Jul 2026 09:59:53 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4] Cygwin: pty: Do not transfer input to nat-pipe while
 masked
In-Reply-To: <20260709021507.b2aa10a8ed01dd5bfa7d2d8d@nifty.ne.jp>
Message-ID: <b5f75587-2d0c-d508-179a-6f1a3b44d345@gmx.de>
References: <20260708045412.945-1-takashi.yano@nifty.ne.jp> <b55b9478-261d-a63f-de53-c2618295c5b7@gmx.de> <20260709021507.b2aa10a8ed01dd5bfa7d2d8d@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:MZoBiFVlo6lStJf8hPwUFd5lCudE+D7IrL5kN3+9yL/svA40Aco
 Uxu+ppwa6Z7mMs7CfLAW13faWzPYODqhW54s+dNAgHP/5vLB91h2Y/iO7ktdaZvomxX8ChH
 HCVs7bQce6eoYImnON3mEkI5MZs6wMpPtDR4+z8HEju3DiwKvj1NCg5aG/b9vtXX02/ICNH
 Yf5/O7yfXQ33sBdMENGmg==
UI-OutboundReport: notjunk:1;M01:P0:ViTYA5r/JPg=;zGEk7WHkBkO5d4iw6RwDi1KYjmD
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_W,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Thu, 9 Jul 2026, Takashi Yano wrote:

> On Wed, 8 Jul 2026 17:01:47 +0200 (CEST)
> Johannes Schindelin wrote:
> >=20
> > On Wed, 8 Jul 2026, Takashi Yano wrote:
> >=20
> > > On the command "cat | non-cygwin-app", `cat` sometimes fails to read
> > > key input. This happens when `cat` starts to read input before `non-
> > > cygwin-app` configures pseudo console. This is because pipe state is
> > > switched to nat-pipe when pseudo console is configured.
> > >=20
> > > This patch prevent the pipe state from changing to nat-pipe state if
> > > some cygwin process is reading input from the cyg-pipe.
> > >=20
> > > Fixes: f20641789427 ("Cygwin: pty: Reduce unecessary input transfer.=
")
> > > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > > Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > > ---
> > > v2: Release all masks owned by myself on cleanup()
> > > v3: Reverts the change that made num_reader and slave_reading shared
> > > v4: Correct what mutex shoud be acquired in mask_switch_to_nat_pipe(=
)
> >=20
> > v4 is the right shape. Taking `input_mutex` at the top matches the
> > ordering used elsewhere in the file, and because it is a named mutex t=
he
> > race is closed across processes attaching to the same tty, not just ac=
ross
> > threads.
> >=20
> > One non-blocking suggestion: As far as I can tell, the new guard is
> > correct only because every caller holds `input_mutex`. That is a non-l=
ocal
> > invariant, and a short comment above the guard would help future refac=
tors
> > preserve it.
>=20
> Thanks!
>=20
> I'll add the comment you suggested and push this patch to master and
> cygwin-3_6-branch.

Sounds good to me!

Thank you,
Johannes
