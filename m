Return-Path: <Johannes.Schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id 9AB95385702C
	for <cygwin-patches@cygwin.com>; Sun, 23 Oct 2022 20:42:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 9AB95385702C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1666557729;
	bh=V/PbKQ9l+cUlraYYRsGZyzMO6XCaUOq0sjmpjEHnSZk=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
	b=huaAg/hLVL73evHPK6aDHjMIyRubiVTDts/SBkjttJwaeGLb+G7H4Dz0WznnBUnwR
	 V5CNSwlGtH+/VOMdvYNXrzpqVjfm3cLDD0m166JJF2VV2cWeNuMBLdVH/V273LGQ8n
	 GFKRquqGP/bRdNJK1rDMrmG6dhKT14ge2247vPFw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.182.144] ([213.196.212.100]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4z6k-1pBtg5223o-010vjM; Sun, 23
 Oct 2022 22:42:09 +0200
Date: Sun, 23 Oct 2022 22:42:07 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Fix 'Bad address' error when running 'cmd.exe
 /c dir'
In-Reply-To: <20221022151247.1b1cf1e3fc13d4c3dabc2191@nifty.ne.jp>
Message-ID: <n4on0p20-970q-8693-7n50-4q22370s7rr5@tzk.qr>
References: <20221022053420.1842-1-takashi.yano@nifty.ne.jp> <6EED0655-71E5-43B4-988D-B5935AED8EC0@gmx.de> <20221022151247.1b1cf1e3fc13d4c3dabc2191@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:f0WgfY/yaF8SWoU7JfNGuHmOar3jG9OZotImtpXNCMZKmdfK0If
 yj10vZL+CONM9AtwoWD8iF6I6heChOpxz5jBI02gBI6hw37MFJyunDGfAdxvGgvDuTCQ/JP
 NJaUd0rwixbEWI9th4e027SGrg0xnW7Atzr6BhY0CIbmxw3y3N5Ana0BFipMRB/WNSj9Nvq
 /dSRWcIE95G4g5cd2FSmA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7csQeQjnq/0=:oPisplgZA6c300Brx0kzmp
 TBky6F1s3pIYKplSozd46lgnM5Iuy0vIHPgVBPyXjgxutMqR5zRWJ76ELcqpIblzFKPy7Y+cI
 tBga8omRy2IBQvUJI61ko4o2ONTODecvwLkKlRhjpLsRDXQeD4ItxSEs2v+e6B5RV1ov7rJ3m
 /M5ewlYzkOtnaqHQLG5vM7cbK3NUYqDBTctMjuANu0NjDV3tjfLEbrtNeLMkJgNnJ/lPI/txD
 NAooesF0F9q9AFeFevWJnU806LYU2pw/ZHB6EJDpSQveg0fMOztG5uwMih1DJ/RDeIdVQ6EdH
 D2j+7YCBok9yeXfTQv6pTRBBRc7MbGpSWmcT86haXLpU+N+WxMX6pfNy7c8e+Iwbxj/54UB60
 Hmc9i8GirgBnfSk2LYE2o8GC/rMPLf8JCI+9kxhB4ZhU1YjwW+4xg8yUOzDk7f6q2ezxGJU7y
 dnaJ7+tHRvuiP6XhGcOc1FJm/bskcM6LjrsI9ZsKHiygghCLIGyNsriaSfEndm882e+8gWBvZ
 aUgSMJbiRBQg460CxSahyItWRxWKdhlcMcn4kTYkUISszj7cKTVtYyhjYLk58gqq7fHJQZkaL
 QGEDtEPaps8BsqYikeDx+q60ZeO+Fn60VOWwNudXiT8yM5CHe3JcK+cSvjkk0K76XDYwW6jgk
 qJ3RJ7uIkSqVN9M3kCyvBKX254fGlj+r2lZeIADJz4UOGAm4yNEuIz+xUg7Z6dqmXgI7WU95b
 IJjyIcuxdNQLHPwOY+Uddv9X/AJG3Bawsf9VFk678bqaaSF79BhRdKmfgXMsi9J2K28tBjcQ4
 LNAM+qHKsWZIAFw5Ef6z/iQ6sK18fJm+fWQfVOUQaeQFeoPHEatV8jr3k6MqTNRdZosQEjbOL
 6gym2o+EL3k0VmsSyVLg86AVedgP6tX++1asB4UJFBtbNmSs4sX4UYrc11aSplyayfUE0tC7t
 r5QpjCeHuqnLm9gJHIOQS0SZFLCkjxJ7Rx2erhG4SObXkqgmpjQcdpE4iyTMPQygd0giNB9vX
 x9uzlb/c/Uwsr7+mJrE8P/uSrFiN5bd8PqHKJ3in4CZXbx1D2Kx+jzWV6mKMgD/dFzgFuv0ou
 5bSCyfapKw5yuYdVypkRtPyEddsaL8wBPsmVKuJ2UgASf8k1k08Gz5URRNnw4U21gD0Wu/LEC
 eNyIqc0dE/6p3JXcHGt3zlecUvRVgQ1nuyKLJFczvBYSDXvyyZpEwZ+96mGqM6jCP3IQyXEu6
 HusT3Mx1Oo1OCgfq2BnqiyahTzb3c/kDAr0eA/lAzBjzyaMq6qR4ENoBQPuKiFiZrbVYQ5hKc
 y12aww98OJ0DGG2KBfrcldqEk1o9m/MnWeI1RN+5ovBW7quWvSc0znLRnuZgED7OhGO6HxB/A
 ML1LKdvccm7pNcpSehs6knsXT4djmF27DD79691mjkEpDXWsiWwDNHIFbuKL1aDyqDEI/4rrp
 qOe5AeT/tqsbHfwiD85xuO827SoQy3yJw6PCTnn59Hs3onEtmpacvWaWMq1kuf0TqVK1yd2N3
 HG8qqlSmWruqXzPlhRmhANcUaPkHrt5Yd1qXYXD1BmWIUsnJZYIm3LbB49zp9QN/Y0Q==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Sat, 22 Oct 2022, Takashi Yano wrote:

> On Sat, 22 Oct 2022 07:58:37 +0200
> Johannes Schindelin wrote:
> > On October 22, 2022 7:34:20 AM GMT+02:00, Takashi Yano <takashi.yano@n=
ifty.ne.jp> wrote:
> > >- If the command executed is 'cmd.exe /c [...]', runpath in spawn.cc
> > >  will be NULL. In this case, is_console_app(runpath) check causes
> > >  access violation. This case also the command executed is obviously
> > >  console app., therefore, treat it as console app to fix this issue.
> > >
> > >  Addresses: https://github.com/msys2/msys2-runtime/issues/108
> > >---
> > > winsup/cygwin/spawn.cc | 2 ++
> > > 1 file changed, 2 insertions(+)
> > >
> > >diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
> > >index 5aa52ab1e..4fc842a2b 100644
> > >--- a/winsup/cygwin/spawn.cc
> > >+++ b/winsup/cygwin/spawn.cc
> > >@@ -215,6 +215,8 @@ handle (int fd, bool writing)
> > > static bool
> > > is_console_app (WCHAR *filename)
> > > {
> > >+  if (filename =3D=3D NULL)
> > >+    return true; /* The command executed is command.com or cmd.exe. =
*/
> > >   HANDLE h;
> > >   const int id_offset =3D 92;
> > >   h =3D CreateFileW (filename, GENERIC_READ, FILE_SHARE_READ,
> >
> > The commit message of the original patch was substantially clearer and=
 offered a thorough analysis. This patch lost that.
>
> The reason which I did not apply your patch as-is is:
> is_console_app() returns false for 'cmd.exe /c [...]' case
> with your patch, while it should return true.

Sure. And a simple "can you please modify the patch to return `true` in
the `cmd /c <command>` case" feedback would have avoided all the
contention.

Having said that, I fear that you completely misread what I wrote, as I
did not comment on your diff but on your quite improvable commit message.

Ciao,
Johannes
