Return-Path: <SRS0=8BWJ=WW=gmx.de=johannes.schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id 67B54384A887
	for <cygwin-patches@cygwin.com>; Fri,  4 Apr 2025 05:27:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 67B54384A887
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 67B54384A887
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743744441; cv=none;
	b=mwHfnEHVY6TP+j1B4xdI6fjigdB4wphTIgQ+v6OkoBiJvdrFO3ym+THZUK43fB4TCTKPxoPjNx+di5OP0+xup8yBWkIZ9NG906c15tQW4urquzoWWFTGDlB5C0XZq/ESaQBr1Wf4fLC5X/NYT1PPE7m6j8niijTC+KbJOE3tmVg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743744441; c=relaxed/simple;
	bh=EK4C8m5XRcTozsp21SepYYStzSxeeiKQU4FAzbit9vM=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=I4DO87ZFe8k2xlbOaxktTbEmf5GzNhcNfxlBZOJOd56vIKOcurQlKOgwPmk+U+4ZwRIHgy9emmiN121o5Cpuv5yirzLcQdtHX3Q3ZY25oG6YlEJKUsepCIMBcf9b9O2mh9uBlwOorQxD0Mky8cJ+6j/FeawzhSp9qHVBU4f8s0A=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 67B54384A887
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=idOJTJvb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1743744435; x=1744349235;
	i=johannes.schindelin@gmx.de;
	bh=EK4C8m5XRcTozsp21SepYYStzSxeeiKQU4FAzbit9vM=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=idOJTJvbWfI5zgJbBjv9DdfiBjJ5/47Qlw3rasGJQ9mlNHZyK1cdhXWdtsxoq24Q
	 BJd2EubRnkcvHpegI8ErfDWy6KF4wxfg2BBl9d8YhnnhUo5dqnQH3oAm4h0b1HUZ2
	 cQnr2tmXGfe20PAJTluv2Ud5/VijVczjutzOYs9Xmx3kxMOOfWHAzgvxvXwDMi09j
	 5VxEU1nTUj/W/MHNVjMJ8jFrt8cWzF70F+JCOlpeNQcC76dpyZt8RhOiCIllzrxf4
	 0zQ1Bh6T7N95Rc3thNmcOx5el2mbFyco8c0Pk/yrfieiX1sPHVavpY9pM+ei1OwQd
	 eC1R6dmAyJzYyeW4oQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([213.196.213.156]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMXUD-1tgyfN2zl1-00Tn3j; Fri, 04
 Apr 2025 07:27:14 +0200
Date: Fri, 04 Apr 2025 07:27:09 +0200
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com, Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_Cygwin=3A_fork=3A_Call_pthread=3A=3Aa?=
 =?US-ASCII?Q?tforkchild_=28=29_after_other_initializations?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250404105839.6652c8849bfb169d669f3799@nifty.ne.jp>
References: <20250403083756.31122-1-takashi.yano@nifty.ne.jp> <969eeb56-fb62-b279-f8d0-02dc7f679859@gmx.de> <ec45497d-a248-1056-4993-da137267b7c5@jdrake.com> <20250404105839.6652c8849bfb169d669f3799@nifty.ne.jp>
Message-ID: <C262E1A5-1B14-4D38-AE47-2EC7709DB6D1@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uWriITMKMaWFNZbSfP9eMUsQrLCokHsdlwpvJLA4SFjazuf+Mpe
 JGu+aDzhSgx7GIPQH9sYuJs6khrPFBvlvPQ4yFKYqHuzXbfF1M2o7hfbWRC/n5PPaiYsMZN
 ZfruOX/DU7BNkiBBdtVaaeb6zA98m5CNlnAH5hkHc/eapLV8cRQ9H14dR7SS32ihMPuLnpt
 dc+rNqK+zU7t6uCFD8mOA==
UI-OutboundReport: notjunk:1;M01:P0:ajxZUtNqFrg=;N/uVHHmfESPSEZoEbWWmN5Rt15m
 Uv70OGmdc8Le9R/roiUCd1OT5C0QWG1uSvuuqvQpf0YmFD5kUCrxsylF1zn5KqS1XqxQIm0Uq
 0vdqDfDgtGpoLlls9amdpafydBhPmMEiIbD6UIzJXRx0PoV8MAWAaFyfi6P2GdALTmd+yF+EE
 z2vLBkSVgjt7eqxJBpX/RhBhHgWGT8GlKhZY2LsVtXVu1FpN3LCImGgAXY+bUXPu37mGcqqgf
 qI8gRynFlpKDW1hgob1Yhv2YB85RADCpfvbIQFSYK6vWLh6ftPAbBmm1V9k3jn3Pk/ThC8jhE
 o5HXpoMmubk9VHFqvjRgjb5nlnTg6o3KQ457ZFrI8OxdYqOoK1hmiCmMsUBXzuy1cH/32bo/5
 eC2l3Kczc+o5RtFom7Vf6vyat85FGENJC/M3lH+cj5W2eGtY3au9YpP2TtX13d0klM1d6UU8K
 Rs5+AUh+PLhkT0Cca3NH0D458X21F4jfXrSN4f/PptaM6znMnxdy/0ppBfz2xbXQgI8trdelf
 zjTdnwDw5M0jOHMRC+t4Dv3WMG2W6lkEocB8XxmioE8ZpSpayBSEIFhMzHj3Z43GDDn6shCb6
 q2w4gMY73Pzj4VNNuKaW7/V7Rvj6cjDt1ADx+lo0UYaEIWVdjwGT11A1jT9vNfOlmNdHv5dB3
 osJTJOOD9uHWvGYGt9brgccXHjvZfVkaxu3fhy3ICFrFqJxCdLWr4uwgqS68Y39Qcl42hfu86
 v7wy4ZlLTRFj46Lz4Bv+pive1N6wa/GyyvekuvbKV/MwK3hCpU3b8lgDdcifxr0lf7gvLJXA1
 T+1LskkhciGQRv5InhU1RSvxkZ8qtTbNs1iHtLjjuvnxUiNPLAlIzYuW7+Rb0s60QNQbbcpUq
 NOknDARmaBQpw9/9SY6sb8+LU+74ycM9W8IVrbaY2aNhcXZE2S9LaSWwYs1vDqQXARu0AFX5O
 9T8FDULRpOUC+bC3sebbuvY7shEsHEIkn+Ja4535m3r1/Q1VEzwfUxw8tbLX1X4i2dF7qG169
 LlYI4YDRpZUl+jbsd9q3Ofcc4ZQ3zEAqnF5GeUdMcLp+rUykuUyWSOegzryN2HRHC1TTg1san
 CCWgzrwy25jqG07sOs1l6g0iSbpDAMhQrBZ/Z/fLDgAntaGp4/xY/15YUVnieCi4AzaZ8rQXx
 hUGJoUgRLxaDYd+X231AIIUQtUjirzpE0zP6jm+Vg7e2K7L/0ymD7467psTU2ZgijdsxrYfJp
 ZG/f7B4GHwFoKg4cbUovFIXl9XwR/vn893nfTkb4lN9YPTNy83nXY0trDwTcAMAuDqnbwgrs4
 CqCYeqGBlUD4US1QD8RaRXYAqMygiAwE04RnleuqAau/MOk4ijhhfBkv559v8SV9yD3NrAhrz
 JbpvRaprgIT/6ooDq8604BSLCIdvJU4iKR9YwSxoZhc3odvnQEmyEzipZ0LZJcwcurjfrETPh
 Hm9E2UxBPvx8IvHvsXn1aclpyGCQ144ZADmYE3yQcTksZB+uEY8miWlZFcd9fqBeuXH1m1E8n
 X19LeHrhaWEuijfMZFw=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

the commit message you proposed at <https://github=2Ecom/msys2/msys2-runti=
me/issues/272#issuecomment-2777433637> looks better=2E

Is Jeremy's guess "if raw_write doesn't need to wait (ie, there's room in =
the
pipe for the write) it doesn't hit the signal stuff" correct? If so, it wo=
uld be good to add that part to the commit message because the commit would=
 otherwise still be incomplete=2E

Also: referring to 7ed9adb356df may be technically correct, but human read=
ers have a much easier time when that shortened commit OID is accompanied b=
y some human-readable information, such as the string obtained via `git sho=
w --format=3Dreference` (see <https://git-scm=2Ecom/docs/git-show#_pretty_f=
ormats>)=2E

In general, I would like to encourage you to err on the verbose side in co=
mmit messages: whenever something seems so obvious to you that you do not w=
ant to bother with writing it down, do first ask yourself if this would hav=
e been obvious to you even if you had _not_ stared at the code for days and=
 even if you had not authored the commits you referenced=2E Or if you would=
 remember those details in six months if you were having the most delightfu=
l no-internet vacation of your life during those six months=2E If there is =
_any_ doubt, then write it down=2E As the saying goes: If you don't write i=
t down, it never happened=2E (And that goes for analyzing bugs, and figurin=
g out code flows, too=2E)

Ciao,
Johannes

P=2ES=2E: Sorry for top-posting, I'm sending this from a phone=2E



-------- Original Message --------
From: Takashi Yano <takashi=2Eyano@nifty=2Ene=2Ejp>
Sent: April 4, 2025 3:58:39 AM GMT+02:00
To: cygwin-patches@cygwin=2Ecom
Subject: Re: [PATCH] Cygwin: fork: Call pthread::atforkchild () after othe=
r initializations

On Thu, 3 Apr 2025 10:01:07 -0700 (PDT)
Jeremy Drake wrote:
> On Thu, 3 Apr 2025, Johannes Schindelin wrote:
>=20
> > I still have a question that I would like to be answered in the commit
> > message, too:
> >
> > If `signal_arrived` is only initialized in `fixup_after_fork()` but us=
er
> > callbacks that use this are called by `atforkchild()`, why did this no=
t
> > trigger _all the time_ before your reordering of the calls?
>=20
> Based on my recollections, Takashi probably knows better
>=20
> 1) there has to be a pthread_atfork child callback registered
> 2) this callback has to call raw_write
> 3) raw_write now calls cygwait (which is now reenterancy-safe due to oth=
er
> fallout from this)
> 4) cygwait allows signals to be processed, so needs the signal-handling
> stuff to be properly initialized=2E
>=20
> I'm guessing, if raw_write doesn't need to wait (ie, there's room in the
> pipe for the write) it doesn't hit the signal stuff=2E

Thanks for the explanation=2E Actually, cygwait() waits for a mutex at the
beginning of raw_write()=2E This is introduced by the commit 7ed9adb356df,
so the bug does not affect before that commit=2E

> But I get your request for explaining the scenario in the commit message=
=2E

I'll add the descriptions requested by Johannes before push=2E Thanks!

