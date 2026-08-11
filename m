Return-Path: <SRS0=Wi/b=GE=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by sourceware.org (Postfix) with ESMTPS id EE68F4BA23F6
	for <cygwin-patches@cygwin.com>; Tue, 11 Aug 2026 10:34:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EE68F4BA23F6
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EE68F4BA23F6
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1786444463; cv=none;
	b=jxePonzoxZ9/46kqcHgTSUQgpul33kwmmWsWr2Dan6rxZG2dJlJ7PV7OoAgatnqMgJDYN9U91/UOwNKj5wVAoXyAmvTWC00YIAxIwYrSt27cCqeApszymuNCaEUkhJk4dsdvsGEYkxTs6F+YLYr5AL8zfzS4mcIG0Y7sFmgedCc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1786444463; c=relaxed/simple;
	bh=Gt9SUJ0+wBNXP51zTKbvcOUaEoD6aQeWsQO+9FpRddE=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=HGc8fNIvFBWP6czQI8g6hL3XusD+ifPtZjcu6ijANuT6tHfX1CXhiFJroPiBm0ByimVYC6AWGuRdaUF2TfksH01pTiivb4A5BnoExn4Z77YHK79xw0IOj7cfGX/7cJoK13Tbzdvl7FkdGGfCEzIC1zCr3Tkrl4xBNGLh5RXXPM4=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=hMqKTkn1
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EE68F4BA23F6
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=hMqKTkn1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786444461; x=1787049261;
	i=johannes.schindelin@gmx.de;
	bh=Humjw3zNfLLw2M1m2bvmL1UnuqMRsSEdGLyxT/dRBfE=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hMqKTkn143Q//3h64zob7Jw+7Q45ET/Gw0pxOZfDCvS+9sPOpi8gkjzlVzl1wK09
	 sGjPxtNM5RN3k+/dVCS931fLTSImmYsHj8rie3tBBUKjrDeyz2XqJyqcEVORVhKYA
	 9GN8AgIyAsLcl4/lsCDx8OwiiDBB2HkQCy/CFA/IZ/7KOke49gSSnkWTSTJBq9fbo
	 VnHSWcJanySYae+biPlQ3h4AHjIY4zK6O+yA19qtunOvIRLMVW3zC2oQGr4JCO63w
	 Xhxn9zd0Ci17Wna72W6+ca65NU4Xj9kxfvOBu6XMhrdtBuIGGA+4jAYhSMw7+tYS9
	 9radIlZuRWUp8YbjdQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUowb-1wTVqW2P8T-00OLT4; Tue, 11
 Aug 2026 12:34:21 +0200
Date: Tue, 11 Aug 2026 12:34:19 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Fix regression in console input
In-Reply-To: <20260807013620.678c7579ce2846ec0e658d6f@nifty.ne.jp>
Message-ID: <4550afe5-7728-80a4-87b3-1565eec5609c@gmx.de>
References: <20260803025011.5289-1-takashi.yano@nifty.ne.jp> <9a1a2379-361e-86b4-b310-d162af82a417@gmx.de> <20260807012551.c176e66e6288f13ad597d9a2@nifty.ne.jp> <20260807013620.678c7579ce2846ec0e658d6f@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=8323329103285793117864444611628651
X-Provags-ID: V03:K1:8MQytb3IdmCXZtgftPkfagHFhg/rmbiW8gQWaVkwo5lT2Gi9dPV
 BQY6B6n/kUWrQM+3fvfr5Z4VWSHU6NA9N/fsAfoOvp7a/eIQGYObAAKvXH5LaM4TQmjhwFI
 +Qx5K2we2SXnP+YjHx37CvK06cBchhqiEhP/3fIxyh3Jqt6SVFX6uLgPgFy5/55J3TlrULM
 pcQjJtMwVmYFsH96cTgzA==
UI-OutboundReport: notjunk:1;M01:P0:Xe9yucgCgnk=;aHI025srVt9CIt8nP7wdea+M0UB
 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
 X2zw4hA==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329103285793117864444611628651
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Fri, 7 Aug 2026, Takashi Yano wrote:

> On Fri, 7 Aug 2026 01:25:51 +0900 Takashi Yano wrote:
> >=20
> > On Thu, 6 Aug 2026 16:21:49 +0200 (CEST) Johannes Schindelin wrote:
> > >=20
> > > On Mon, 3 Aug 2026, Takashi Yano wrote:
> > > [...]
> > > > +
> > > >    for (i =3D 0; i < total_read; i ++)
> > > >      {
> > > >        DWORD nread =3D 1;
> > > > @@ -1794,7 +1797,6 @@ fhandler_console::process_input_message (siz=
e_t len)
> > > >  	}
> > > > =20
> > > >        num_input_events_processed =3D i + 1;
> > > > -      num_chars +=3D nread;
> > > >        if (toadd)
> > > >  	{
> > > >  	  ssize_t ret;
> > > > @@ -1813,21 +1815,17 @@ fhandler_console::process_input_message (s=
ize_t len)
> > > >  	    }
> > > >  	}
> > > >        /* len =3D=3D 0 if called from select.cc:peek_console() */
> > > > -      if (len && num_chars >=3D len)
> > > > +      if (input_ready && (len =3D=3D 0 || con_ra.ralen >=3D len))
> > >=20
> > > Something GPT 5.6 Sol stumbled over, before noticing that this is a
> > > pre-existing issue: the raw multi-pass caller passes full `buflen`
> > > (not `buflen - copied_chars`). That was already there before this
> > > patch (and both GPT and Opus think that this is incorrect, I haven't
> > > had time to wrap my head around it), and the new `ralen`-based check
> > > is actually neutral-to-better; and `tcflush(TCIFLUSH)` doesn't flush
> > > `con_ra`.
> > >=20
> > > I'm fairly certain that this is out of scope for this here bug fix,
> > > if it is an issue at all (what do you think? Is this `buflen` issue
> > > real? Should `tcflush()` also flush `con_ra`?).
> >=20
> > Thanks for finding this. I rechecked here and concluded passing
> > `buflen` for process_input_message() is correct. This is because, the
> > length check in the process_input_message is:
> >=20
> >       if (input_ready && (len =3D=3D 0 || con_ra.ralen >=3D len))
> >         goto out;
> >=20
> > After the `while` loop, the chars in readahead data of length `con_ra.=
ralen`
> > will be copied into buffer of `buflen`. So the `len` should be total b=
uffer
> > size here.
>=20
> `copied_chars` is always 0 here in the first place, isn't it?

Not necessarily. The total-buffer-size explanation overlooks the
`read_more` path. In non-canonical mode, `read()` jumps back there when
fewer than `VMIN` bytes were copied, so a subsequent
`process_input_message(buflen)` can run with `copied_chars` already
greater than zero.

For example, with `buflen =3D=3D VMIN =3D=3D 10`, the first pass may copy =
6 bytes.
On the second pass only 4 bytes of the caller=E2=80=99s buffer remain, but=
 passing
10 can consume up to 10 more bytes into `con_ra`, leaving 6 in this
process=E2=80=99s private readahead. Passing `buflen - copied_chars` would=
 stop
after filling the remaining 4 bytes and leave later typeahead in the
console buffer.

The exact batching depends on `line_edit()`, but `copied_chars` is
therefore not always zero at that call.

Ciao,
Johannes

--8323329103285793117864444611628651--
