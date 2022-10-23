Return-Path: <Johannes.Schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id DAEC33857342
	for <cygwin-patches@cygwin.com>; Sun, 23 Oct 2022 21:04:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org DAEC33857342
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1666559049;
	bh=2o76C2HiXPEttB//Ww0cqIO4UnupB9NAZ63gtu7jZPU=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
	b=bV0G9T/c0133dvA/YUATPxMNlXflGUwVwKdsdIqHZM7URKzCdxrIcuCGre43iL9Nn
	 yHAkx8oehYkVumQOf31vrBjfiS2vuiNcGoAkJJmYJsgoSRZzSzGgkg5664neatywoH
	 ao9+322IcL1LmPtzW5YA/5oKnImic22qlIHZhyZU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.182.144] ([213.196.212.100]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N95iH-1p7nXa2usJ-0168PT for
 <cygwin-patches@cygwin.com>; Sun, 23 Oct 2022 23:04:09 +0200
Date: Sun, 23 Oct 2022 23:04:08 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/2] Allow deriving the current user's home directory
 via the HOME variable
In-Reply-To: <Y07cOhhwu4ExRDzb@calimero.vinschen.de>
Message-ID: <0q096627-r8pr-rno5-0863-s6n90psosq07@tzk.qr>
References: <0Lg1Tn-1YnzUw0ScN-00pcgi@mail.gmx.com> <cover.1450375424.git.johannes.schindelin@gmx.de> <047fe1d78c365afca7edfdf169fff5e1940c3837.1450375424.git.johannes.schindelin@gmx.de> <20151217202023.GA3507@calimero.vinschen.de> <1r1pq0r7-o3s3-so08-o426-296542797q94@tzk.qr>
 <Y07cOhhwu4ExRDzb@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:vWDPesvoBzacWxs+gfQCIfzssuAVCeeqgpR1gTbLW0pXokBmX4h
 WLxQmLwLToTQIJ6pFmnKhCwLkRtxEQW4yhlelWv8mTZIez/KYw8isXAm78lvtX9u5vxNzfS
 9sC8Ak+pcZdmj0tSAx2lCCXdNxVf+Kcnn96dfQ/Ub8sr8M2mJay2ZcUStsKzKYsMeJ8DAhQ
 e27RVWdWhgdua4pVFwJQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QajLWHw3KG8=:lxrw/1F4roM7SB9mUzH+p7
 XReFb7c6QgldrTvpgJjXuiDRNV89/QBa3zrVdeXmhq+Yw5aDYeRYgcP0p6Yr0yiugRUFlClkz
 Gc/nPedi67/j/yHBMX1f7NtHPTb/m6NyJ8ZDb+vfOtA8ZIxgJ0ImoBc1ASjtSFCQchjWoocEY
 O2yHxx+jzMwq68yVCq95cyoiUC2KAXJ7b3yBTM/GVjOjbZa6rNVewxysIlE0aH4tREL2ey3ql
 2eHqhwwmxODAqL/TvBR/BQqBjuqzvXHPxdIYvsBfG/DDVJlm2zVRKr3i7s1A2ZlkGhaXVpau4
 29QKoGz8EcZbrjfZVow7ecT5jIeTOl6aa1ekYnJQsImvY1Xh+d3BCAP8Wj84oNgmAM5gMS4G2
 O1FZWUg/iG6zd4Z5HwHokmNwOD/pFcJwAcV7x4g6N2IJwAI2qou6TCnBZKmbGCOc9IEmiIWyW
 LOIN/vOUdYEHDgC3vrxRzxiLxwyJvRHSLPcZxqH8YZ/NGIEKYmH3XqytjAkojui/tVMM+xOI2
 GA+dEY3EX+EK0QN1ztScSi7Xf0xSHBBzRtfLhfrl/6kaVL0dnuJbX9iuY601fpkLV6DjtBsZo
 V938jvUKgaC1BmnqceT/BYqGsN3s5kJOWKIwIRQPBjjHo58UxSjPsqPyoWUrFsjxFfgG92mF7
 ettWhiZRJw8xj5WSxppVoda43UDDD5qLcy5QU/tcfIWudtArsA3K6695hZqLxDwyB+iyHbg0L
 7Rdmxk+pzy1RkTpBGoPJUaxKnOqQol7nRDgcma2lyykOBJpcaKWK088yG6uMyCkrqMcXE5/PN
 olLmUtkJpEJ2PpXltfO3fy1DHWxknh/H9cGrQ+G6+zWH9S5S877y6YTG2oOmDUHmjSYhIVnKV
 h56OK/w5nDulKO371JsP3MXcQRwujfBOFIEaFylcS8YQ8csUDE0z6cfgFBLKHGXCeceUzXhEr
 iWb3TgfOxZ1iYIDxl+48IEUdl89UredzmtU/KXkMQMDZ9I1hga7RHL0ruSCvrjxZ9OrwPqZZG
 8yNbHYpRNTCktsEYrRu+asixJqw1ZhxPSuwyReTLLrM+u4YpHoWskd4UdMcsoMfwbSK+ScpGh
 N8pE5u5z1n78KwyjPjt5U9hzBYB0n0dGnJzR676sqfRdNrXPtq6p2q4gcHKfnN9PtFpU1nAqE
 kHssnr83JpL6662sps0z4m3xkDqcf1NQ/27bqALqwl43PMB0KCY/5A5eqfbUDlDq6Oba0leZe
 hxcHTbL1+gRWrfSRnWRoD40pSYwp/2voLUctvetRa9NKg/UbhKSA8CMYetMNPvAZJz1RV7Er2
 Lyyhx0AUFhxdSds30mNaNScobb5ztnp2pTXgR8oGck1tfMlr+cHfuKIZhSBcgG3ly3Vb2mo3U
 kq/gX6VWx9edAT/akA2m6p2xvnOAnxzTVv0I7gtjuU7B/MScKRmsaoh1rJun0DiFbrxEL3yr+
 x5stVX/IROGLwj63FFXspjEvw0IdietqtLRMhkuJ/XPY7PjgIE9nd8RjILQ5emQiMC4938RAM
 t6fSq36QFHK5AqHpP3qq3/MouxaWYkl4qmVOHHNr93ICei9biPMa+vCKaX7u918rtTQ==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On Tue, 18 Oct 2022, Corinna Vinschen wrote:

> On Sep 21 13:58, Johannes Schindelin wrote:
> > Hi Corinna,
> >
> > sorry for the blast from the past, but I am renewing my efforts to
> > upstream Git for Windows' patches that can be upstreamed.
> >
> > On Thu, 17 Dec 2015, Corinna Vinschen wrote:
>
> Well, not even 7 years, so what? :)

True :-)

> > > On Dec 17 19:05, Johannes Schindelin wrote:
> > > > +  DWORD max =3D sizeof wbuf / sizeof *wbuf;
> > > > +  DWORD len =3D GetEnvironmentVariableW (key, wbuf, max);
> > >
> > > This call to GetEnvironmentVariableW looks gratuitous to me.  Why do=
n't
> > > you simply call getenv?  It did the entire job already, it avoids th=
e
> > > requirement for a local buffer, and in case of $HOME it even did the
> > > Win32->POSIX path conversion.  If there's a really good reason for u=
sing
> > > GetEnvironmentVariableW it begs at least for a longish comment.
> >
> > My only worry is that `getenv("HOME")` might receive a "Cygwin-ified"
> > version of the value. That is, `getenv("HOME")` might return something
> > like `/cygdrive/c/Users/corinna` when we expect it to return
> > `C:\Users\corinna` instead.
>
> Haha, yeah, that's exactly what it does.  Look at environ.cc, search for
> conv_envvars.  There's a list of env vars which are converted
> automatically.  So getenv ("HOME") already does what you need, you just
> have to adapt the code accordingly, i. e.
>
>   if ((home =3D getenv ("HOME")))
>     return strdup (home);
>   if (((home_drive =3D getenv ("HOMEDRIVE")
>            [...]
>     return (char *) cygwin_create_path (CCP_WIN_A_TO_POSIX, home);
>
> However, on second thought, I wonder if the HOMEDRIVE/HOMEPATH/USERPROFI=
LE
> code is really required.  AFAICS, it's just a duplication of the effort
> already done in fetch_windows_home(), isn't it?

You mean the case where _both_ `pldap` and `ui` are `NULL`, i.e. where
`get_user_profile_directory()` is called?

Correct me if I'm wrong, but that does not at all look at the environment
variables, but instead queries the registry.

And _if_ we want to do that (which I would rather want to avoid, for
simplicity and speed), shouldn't we call the
`get_user_profile_directory()` function directly instead of going through
`fetch_windows_home()`?

But if you meant to still have a non-`NULL` `pldap`, the results are
definitely not the same, not only because users can easily modify their
environment variables while they cannot easily modify what is retrieved
from the DB: [see below].

> HOMEDRIVE/HOMEPATH are generated from the DB data returned in
> USER_INFO_3 or via ldap anyway, and fetch_windows_home() also falls back
> to fetching the user profile path, albeit from the registry.

The big difference of using ldap is that retrieving the environment
variable is instantaneous whereas there is a multi-second delay if the
domain controller is temporarily unreachable.

> That means, the results from the "env" method is equivalent to the
> "windows" method, just after checking $HOME.  That's a bit of a downer.
>
> Assuming the "env" method would *only* check for $HOME, the user would
> have the same result by simply setting nsswitch.conf accordingly:
>
>   home: env windows

Except when the domain controller is (temporarily) unreachable, e.g. when
sitting in a train with poor or no internet connection. Then that latter
approach would have the "benefit" of having to wait 10-15 seconds before
the network call says "nope".

This particular issue has hit enough Git for Windows users that I found
myself being forced to implement these patches and run with them for the
past seven years.

Given the scenario of an unreachable domain controller, I hope you agree
that the `env` support added in the proposed patches _has_ merit.

Ciao,
Dscho
