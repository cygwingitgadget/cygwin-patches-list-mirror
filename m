Return-Path: <SRS0=Z/EC=6Y=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by sourceware.org (Postfix) with ESMTPS id 206AB4BA2E05
	for <cygwin-patches@cygwin.com>; Thu, 18 Dec 2025 07:45:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 206AB4BA2E05
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 206AB4BA2E05
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766043915; cv=none;
	b=xeJmMV1vj/+CNLwEooo7r7sjaqWTvOQU343EKsBnJS0L9zOHCAAuOTztHh2g6Lvw80MVAtuN2ySQWMeA5FIaeoyNShm7KQgPnJBn0u9iM6UlODO5wFVLmrdGafcV0+vs5HYyWb3RrYVTOyCOI1+WoMLVhOBZZsHbmbRvcn/m4qc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766043915; c=relaxed/simple;
	bh=SuTHPLBviOebtiSRjac/04MxrO0BbWoN+MzpX8CL76A=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=R3bA1XeAAXuNJuDfLSMJs5yC872jIf4gEIWP9mUNFEXTWa+AkVYv4vcFe3j9QFFErHSAQ9yxGCtffFh0AH5kB/C1JvTrFYbwxHgaoMAmaehM24ZyQ5FeMLv8QzD6BN9+HGoUxVx7vWJSF4+N8OXEV7jT1T4GJow+0q3nd+PQORY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 206AB4BA2E05
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=JeOzSDX1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1766043914; x=1766648714;
	i=johannes.schindelin@gmx.de;
	bh=SuTHPLBviOebtiSRjac/04MxrO0BbWoN+MzpX8CL76A=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JeOzSDX1HvRhgmsWNIhZ3s0nRiREoMKp17YNkRkndQe5qSdUwYERcNMoTYXjWixp
	 SQtqnJP20MF5ea4mnOXNSIuyvyKH/+lnx4ScF9TfkSk1fC1P6KIg06w9KO8wnnh80
	 FvvUvOcMca6UFPBgBtAWTgsMzF4EjogOOLEk1uSt1iQikP77Y9axC5yy90Yr2oxL4
	 9a8iEIFuszrk6AAsUfTH3m28CahbF0uw2+gTBql+ZzaYpPppimGi+xSuA+AkFs1A8
	 Y4QKbCkgEjC62ZrtnarxMqnxLhB+qlCfJaueLYClgRK3kQ8iX+5LADUP2xObbjur3
	 GgVd9rWwr7DsaxscJg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.212]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MK3Rm-1vHNGZ3QSs-00Hbmg; Thu, 18
 Dec 2025 08:45:13 +0100
Date: Thu, 18 Dec 2025 08:45:12 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Set ENABLE_PROCESSED_INPUT when
 disable_master_thread
In-Reply-To: <20250715162741.bd33f1249f088ba6947fbd32@nifty.ne.jp>
Message-ID: <2ad7299d-9561-fcd9-9fec-8b492c48caee@gmx.de>
References: <20250701083742.1963-1-takashi.yano@nifty.ne.jp> <9a404679-40b5-1d55-db07-eb0dacf53dc7@gmx.de> <20250703154710.f7f35d0839a09f9141c63b1c@nifty.ne.jp> <259d8a20-46d5-c8cb-1efb-7d60d9391214@gmx.de> <20250703195336.2d5900b4988a6918ad397582@nifty.ne.jp>
 <5be83d7c-a19f-a733-7d8f-1d41daa6b9f8@gmx.de> <20250715162741.bd33f1249f088ba6947fbd32@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:RGp7b+JbJ7aJSgv83KodthdubfBjRceTVE7wW0Ez6yhFNqusbtO
 z2oRNZhOShG9JEzrPXeQB1XzMmAznEbym1a6it8HfZGs8ZIYDxgHJD5QSElGH/ChOdIL4zK
 6m8SXgWADCtlLnXaKfaLwON03D93rTbwgtRhfJ5TUZWcaXT/Q3/xucrFzzYU4Cl2y/RjOhS
 LuQKlZLRVzh0Z/maGoDlw==
UI-OutboundReport: notjunk:1;M01:P0:4jhVU1RfKC4=;YR77w7OBc9aJBCFPfZIwzehEClf
 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
 jzypOvr8=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,POISEN_SPAM_PILL,POISEN_SPAM_PILL_1,POISEN_SPAM_PILL_3,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Tue, 15 Jul 2025, Takashi Yano wrote:

> On Mon, 7 Jul 2025 12:50:24 +0200 (CEST)
> Johannes Schindelin wrote:
> >=20
> > On Thu, 3 Jul 2025, Takashi Yano wrote:
> >=20
> > > On Thu, 3 Jul 2025 11:15:44 +0200 (CEST)
> > > Johannes Schindelin wrote:
> > > >=20
> > > > On Thu, 3 Jul 2025, Takashi Yano wrote:
> > > >=20
> > > > > I noticed this patch needs additional fix. Please apply also
> > > > > https://cygwin.com/pipermail/cygwin-patches/2025q3/014053.html
> > > >=20
> > > > Thank you for the update!
> > > >=20
> > > > I am curious, though: Under what circumstances does this patch mak=
e a
> > > > difference? I tried to deduce this from the diff and the commit
> > > > message but was unable to figure it out.
> > >=20
> > > In my environment, the command cat | /cygdrive/c/windows/system32/pi=
ng
> > > -t localhost in Command Prompt cannt stop with single Ctrl-C. ping i=
s
> > > stopped, but cat remains without the sencond patch, IIRC.
> >=20
> > I have added this as an (AutoHotKey-based) integration test to
> > https://github.com/git-for-windows/msys2-runtime/pull/105 and was able=
 to
> > verify that your fix is necessary to let that test pass.
> >=20
> > Speaking of tests: Have you had any time to consider how to accompany =
your
> > fix by a regression test in `winsup/testsuite/`?
> >=20
> > For several days, I tried to find a way to reproduce a way to reproduc=
e
> > the SSH hang using combinations of Cygwin programs and MINGW
> > programs/Node.JS scripts and did not find any. FWIW I don't think that
> > MINGW programs or Node.JS scripts would be allowed in the test suite,
> > anyway, but I wanted to see whether I could replicate the conditions
> > necessary for the hang without resorting to SSH and `git.exe` _at all_=
.
> >=20
> > I deem it crucial to start including tests with your fixes that can be=
 run
> > automatically, and that catch regressions in the CI builds.
>=20
> To be honest, I already have local test suites that check the behavior
> of special keys for both pty and console. However, I currently have no
> clear idea how to integrate them into winsup/testsuite...

If Cygwin were merely a personal project of yours, I would understand and
probably agree.

However, Cygwin is used (via the MSYS2 runtime) in Git for Windows, and by
extension millions of users rely on it.

Therefore, it would be good to at least publish those local tests.
Ideally, a good deal of thought should be spent on figuring out a way to
integrate the tests into the CI builds.

You mentioned winsup/testsuite, and I do agree that it sounds more than
just tricky to integrate the tests there. Essentially, you would probably
end up reimplementing AutoHotKey's fundamental functionality: sending
keystrokes and inspecting the results.

Now, to be sure, running AutoHotKey-based tests is a lot more finicky than
running winsup/testsuite. In the absence of any better idea, though, I
would take the confidence from having tests over not having tests, any
day. After all, you and I are both fully aware of the unfortunate pattern
in the code under discussion where on multiple occasions, bug fixes
introduced new bugs whose fixes introduced yet other bugs, etc ad nauseam.
If AutoHotKey-based tests can help break that pattern, let's integrate
them.

Ciao,
Johannes


