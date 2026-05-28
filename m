Return-Path: <SRS0=+fqX=DZ=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by sourceware.org (Postfix) with ESMTPS id 040814BA2E15
	for <cygwin-patches@cygwin.com>; Thu, 28 May 2026 13:48:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 040814BA2E15
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 040814BA2E15
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1779976114; cv=none;
	b=oRMC2AGr1gMsvIFMML/VT79bCAeSAfem9xmAOsXXGCmNKnrHg1JPEKkjujAYXXt3CwdTxkZ5R6AHlZZcY3mEv4SkTCokAWgMwsHEMxxa9tEvoAxJdfdFp49nzqIU8BGez6ICJFo8cDCVSmP42K3YDnitPPBwzJ+CF5zkFI4nhTU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1779976114; c=relaxed/simple;
	bh=ChE/5NtE9lYRPCeP4iZimZ1x+mSXarpM6xAHoZZBPB8=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=SENc2yHlHWm8CYVTTCn4aFPbjzCFL8FTHq02caLulRLgJc/M5Jq3QVwL+1VKB44GonmGYcrO2PvPME7uPJ0kTl6fwRCKBs2lkoippnHa6zf8dZ+ueFUlcAwh8ovExAOszO7PYQRKOGhRzkBj38mEHxT7+PrI3lAGRYzIBLTnuy0=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=JxDHl9eX
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 040814BA2E15
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=JxDHl9eX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779976106; x=1780580906;
	i=johannes.schindelin@gmx.de;
	bh=8VVOweWxDq9ObkshQph8p99p20s7BgJ32FQL/N5kaA8=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JxDHl9eXVoljM1X8WryNj4ziYceqSZF6UrUbDFvFVIXqs+kMJTeVsJsoiLuYh8Wa
	 uh3skKw2BOotzhLk4QUzowTXKjYCZzZS5Is9LasGstmT7rpSfgEdc7+aGBNkmyurp
	 Z8EoaeekUEMWukJ7LaGb8ys1tq3ZgLwZhLgxmbmcVtqPenKCClLNYLpdO6XREAg/f
	 gF7hDF/6JsY2lWFXsM9V70p7fy+XyqOU3GUAghh9PqGrKdMuXQ8cU3VLE4Zp4BZrp
	 VBxMSMTHFSgn+NNgj+3axt0ufB2h/4l1tcnxbeY9rVEUg5DvdbbhUgX+QhdX5Zlyu
	 jMDukdO21lV500IROA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7K3Y-1wN7SA0hpM-001Ycf; Thu, 28
 May 2026 15:48:26 +0200
Date: Thu, 28 May 2026 15:48:24 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: detect pcon-backed pty for non-Cygwin-spawned
 children
In-Reply-To: <20260505212503.fdf6b912b76c5cae97a1372c@nifty.ne.jp>
Message-ID: <b11ddb3b-52c1-984d-6879-5257a2952b02@gmx.de>
References: <pull.7.cygwin.1777561444611.gitgitgadget@gmail.com> <20260505212503.fdf6b912b76c5cae97a1372c@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1cdWiSIwRdWWiVyFpWnShxcXPcrwI5T414JUeFiyU49lx1MO9yC
 aXytY9o/h1FJCxlsO9BrDNLEuaXbBfn2R1K+xMD+ifKh4Q442/GojaqecGWD6UV8Qnwk5Nu
 8zLXLDrXZ9ch5CxUOpdMowvPFi8pn0svUsQjxCVTQ9ift1aFkIzcgUWCRqakxthh8mwe+CE
 u+7OKB/WFfttOAfsD2+tg==
UI-OutboundReport: notjunk:1;M01:P0:uyq+r5qtexY=;x5GDPfKimwq7IGLHVAi3m80j8qP
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Tue, 5 May 2026, Takashi Yano wrote:

> On Thu, 30 Apr 2026 15:04:04 +0000
> "Johannes Schindelin via GitGitGadget" wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >=20
> > diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
> > index 7303f7eac..ce29f4608 100644
> > --- a/winsup/cygwin/dtable.cc
> > +++ b/winsup/cygwin/dtable.cc
> > @@ -327,7 +327,17 @@ dtable::init_std_file_from_handle (int fd, HANDLE=
 handle)
> >  	dev.parse (myself->ctty);
> >        else
> >  	{
> > -	  dev.parse (FH_CONSOLE);
> > +	  /* Check whether the inherited console is actually a pseudo
> > +	     console bridging a pty.  This happens when our non-Cygwin
> > +	     parent was itself spawned by a Cygwin process from a pty
> > +	     (e.g. bash spawning git.exe which then spawns vim).  In
> > +	     that case, connect to the pty slave instead of treating
> > +	     the handle as a real console. */
> > +	  int pcon_minor =3D cygwin_shared->tty.find_pcon_pty ();
> > +	  if (pcon_minor >=3D 0)
> > +	    dev.parse (FHDEV (DEV_PTYS_MAJOR, pcon_minor));
> > +	  else
> > +	    dev.parse (FH_CONSOLE);
> >  	  CloseHandle (handle);
> >  	  handle =3D INVALID_HANDLE_VALUE;
>=20
> The lines:
> CloseHandle (handle);
> handle =3D INVALID_HANDLE_VALUE;
> are dropped in master branch. Do you think that these two lines
> are necessary for this patch when applying this patch to cygwin
> master branch?

Those two lines are not necessary, all added code ignores the handle
entirely.

Thanks,
Johannes
