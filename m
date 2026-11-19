Return-Path: <SRS0=osWK=JI=gmx.de=johannes.schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by sourceware.org (Postfix) with ESMTPS id 1B5AA4BA2E1A
	for <cygwin-patches@cygwin.com>; Thu, 19 Nov 2026 02:56:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1B5AA4BA2E1A
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1B5AA4BA2E1A
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1795056988; cv=none;
	b=lA0PsfdoVpIptxFx5IaVjaalKY8EzCcskZWi/Hd8nhMtpK4L23jebCSo/wAVI12wKAmQ8JZNSrP0jY8AQTZqI5+7jE7erquoILbxan+qc68jJzmShSq7SiHf/l5LOxfDKBe71HBdTUjc9pThiHfy0H9rzif60JNCQ1XyTmsfxQc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1795056988; c=relaxed/simple;
	bh=ZZZWC7/i8qXYnwtWU4fsEKaxq0TbkqBS5jU+zHB3hDQ=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=Hc75f7WIWgY7J+8bciuOWB9G/3N3lI+B1oYunD6Fizvm60hluuYvMsdFk06F9Yc11pv4V7KrfP07Nl/h3/ZOVMcSCEyV33naWMVkJWpdu/fFRnbi/BPFk9JUbJZeEpIDkBBZppEQmb3MJvs+iQScCjApTHxg+vHv5SYgTcpiNMw=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Gsk18hCn
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1B5AA4BA2E1A
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Gsk18hCn
DKIM2-Signature:  i=1; m=1; t=1795056986;
 mf=PGpvaGFubmVzLnNjaGluZGVsaW5AZ214LmRlPg==;
 rt=PGN5Z3dpbi1wYXRjaGVzQGN5Z3dpbi5jb20+;
 d=gmx.de;
 s=s31663417:rsa-sha256:adzL2bP0oJsZQYzTG7reLKPt8SOn
   1ol5HLOXMOzMYwwCv3YPh/EtJe8mF8c0FqLVkzR5O9FZCEnXjHa1sBcMmvkOOLmrsgh6ann3aNC
   d3ICsAO2LRSJw+nIOONruoXmrMgRHrj/emDHuVQs4pwnRIkucHdnXnUhGn0eMWjp5YXQXBpe+DZ
   pl1kzUAM+KkNE/3veD/6xRgQpW1SA9SJA+vKJi3gKEE2XRc9dSqmxUKyWSXuYUdEY2P5VmKXS5q
   V9WaJXK9Q82IFVrg4EvIGWwB51E4yIqqGI1iu8xLFn0qSWT7HrEZGTXzuzJI+9yIjqhaj4L0Acq
   SJLd61jzq9C7Tw==;
Message-Instance:  m=1;
 h=sha256:
   5zni4MDFHUYnSIJNPyfr/lHK6yqoxFRhgttP0vpMPd4=:
   ZZZWC7/i8qXYnwtWU4fsEKaxq0TbkqBS5jU+zHB3hDQ=,
  sha512:
   XDYv1gPlB5Dk86Cu1VmAsXzN3KfK9qgWy65NjYe6g5Wm8P1FNsjUcrSto1BwAfZG38mFdWh/KgMkT+pyHRKByA==:
   4jvJUpv9n/zoSk/C7bnDm6zwfkxDvXh9Y7Bakep7PMPnuWR2D0nNNURzfu/QvuJrWyhqvjtQtXGeBJsdGae3Mg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1795056980; x=1795661780;
	i=johannes.schindelin@gmx.de;
	bh=pqmtlP/e329ohwrnDpSpwNKcC1GsbzA6FF5QizB5WnQ=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Gsk18hCnAjxy9gQjqqtdhdNxz7S2jbF9wa255Ci5X9b5u04KgCYSsamFG71v2xNg
	 AXwqiWIYVpGAT2q6CIFudqA1D9y6ul6Dk0wk5bvi+NNKisyECeyhpXCEwmRGtTTJz
	 os+2sRxzoZHxgLDr1EAAkDqSDGDAsU3oVj2igtaDquPSAqsEvL2DsOynPdP8M7e4K
	 IyF3T38ycT1uqCIWoQoYzcoidjC1NvHsycE6rQqhBdJBiNT9xRA54s1fFGqdiaaoF
	 CwPYldQAxmwNXSfAX0U26uW+XsV4aBf4SaMZ6rq1Yk6tBQRbKnYmaDqgKyYrgIs5H
	 rZrZOpzgba+QiPlAcQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWRRT-1wwWfH2F9X-00Ytj2; Thu, 19
 Nov 2026 03:56:20 +0100
Date: Thu, 19 Nov 2026 03:56:18 +0100
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com, Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: Re: [PATCH v2] Modify atomic_wchar_t reference to use __wchar_t
User-Agent: K-9 Mail for Android
In-Reply-To: <20261119085040.bf372ecdc870471e428b8826@nifty.ne.jp>
References: <pull.16.cygwin.1793616235364.gitgitgadget@gmail.com> <pull.16.v2.cygwin.1794999354705.gitgitgadget@gmail.com> <20261119085040.bf372ecdc870471e428b8826@nifty.ne.jp>
Message-ID: <34318506-3527-458B-B7E4-6CAE9F57931A@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FBCqF9t5l7tejb3nlMLHCPORJdmxIqXExyijwq952U/6ojQCE4a
 S8gNRMgLbEI2ZqrkEAz8fmEfLsM3TFOu7jQ+IB/Tl6/gs5qGXtkQTr2rYMhXTtv0uX7I7pP
 IT7rYwbIKmDFkPqLXJDmW2wP3Y1uvRf/6TcViZMy/oafvz3aUb3K0s6NgdjiMASk3QV/8d+
 nLM0X1StxSCmDgjQDpBqQ==
UI-OutboundReport: notjunk:1;M01:P0:etgnRIEtG/Y=;GwCboJEE7bbMCAC6deYek20qFod
 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
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

of course! That's all this patch is, really: a backport, a cherry-pick=2E=
=2E=2E

Thank you,
Johannes



-------- Original Message --------
From: Takashi Yano <takashi=2Eyano@nifty=2Ene=2Ejp>
Sent: November 19, 2026 12:50:40 AM GMT+01:00
To: cygwin-patches@cygwin=2Ecom
Subject: Re: [PATCH v2] Modify atomic_wchar_t reference to use __wchar_t

Hi Johannes,

On Wed, 18 Nov 2026 10:55:54 +0000
"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail=2Ecom> wrote:

> From: Jeff Johnston <jjohnstn@redhat=2Ecom>
>=20
> This is a backport of 209858c89d (Modify atomic_wchar_t reference to use
> __wchar_t, 2026-06-09) to the `cygwin-3_6-branch`=2E
>=20
> Fixes: https://github=2Ecom/msys2/msys2-runtime/issues/399
> Signed-off-by: Johannes Schindelin <johannes=2Eschindelin@gmx=2Ede>
> ---
>     stdatomic=2Eh: fix the type used for atomic_wchar_t
>    =20
>     Including <stdatomic=2Eh> currently fails because atomic_wchar_t ref=
ers to
>     the undefined type ___wchar_t (note the triple underscore)=2E This
>     spelling was introduced by the update to the FreeBSD header, which t=
ried
>     to avoid conflicts with clang in
>     https://cgit=2Efreebsd=2Eorg/src/commit/sys/sys/stdatomic=2Eh?id=3D0=
a4c54d6060ab057c86d65be24cf6032e7436670
>     (Rename __wchar_t so it no longer conflicts with __wchar_t from clan=
g
>     3=2E4, 2014-04-01) by using the triple underscore=2E
>    =20
>     The intended internal wide-character type in Cygwin is __wchar_t (no=
te
>     the double underscore, not triple), which is already available throu=
gh
>     <sys/_types=2Eh>=2E Backport 209858c89d4feb342857255be8c10862c1ad9d8=
b that
>     is already on main to use that existing type so applications can inc=
lude
>     the header again=2E
>    =20
>     Changes since v1:
>    =20
>      * Clarified that this is actually a straight backport of a commit f=
rom
>        main onto the cygwin-3_6-branch, and therefore no re-route via th=
e
>        newlib mailing list is needed at all=2E
>=20
> Published-As: https://github=2Ecom/cygwingitgadget/cygwin/releases/tag/p=
r-16%2Fdscho%2Ffix-stdatomic-header-v2
> Fetch-It-Via: git fetch https://github=2Ecom/cygwingitgadget/cygwin pr-1=
6/dscho/fix-stdatomic-header-v2
> Pull-Request: https://github=2Ecom/cygwingitgadget/cygwin/pull/16
>=20
> Range-diff vs v1:
>=20
>  1:  cf2b7f207 ! 1:  5b85515fe stdatomic=2Eh: fix the type used for atom=
ic_wchar_t
>      @@
>        ## Metadata ##
>      -Author: Johannes Schindelin <johannes=2Eschindelin@gmx=2Ede>
>      +Author: Jeff Johnston <jjohnstn@redhat=2Ecom>
>      =20
>        ## Commit message ##
>      -    stdatomic=2Eh: fix the type used for atomic_wchar_t
>      +    Modify atomic_wchar_t reference to use __wchar_t
>      =20
>      -    Including <stdatomic=2Eh> fails because atomic_wchar_t refers =
to the undefined
>      -    type `___wchar_t` (note the triple underscore)=2E This spellin=
g was introduced by
>      -    the update to the FreeBSD header, which tried to avoid conflic=
ts with clang in
>      -    https://cgit=2Efreebsd=2Eorg/src/commit/sys/sys/stdatomic=2Eh?=
id=3D0a4c54d6060ab057c86d65be24cf6032e7436670
>      -    (Rename __wchar_t so it no longer conflicts with __wchar_t fro=
m clang 3=2E4,
>      -    2014-04-01) by using the triple underscore=2E
>      +    This is a backport of 209858c89d (Modify atomic_wchar_t refere=
nce to use
>      +    __wchar_t, 2026-06-09) to the `cygwin-3_6-branch`=2E
>      =20
>      -    The intended internal wide-character type in Cygwin is `__wcha=
r_t` (note the
>      -    double underscore, not triple), which is already available thr=
ough
>      -    `<sys/_types=2Eh>`=2E Use that existing type so applications c=
an include the header
>      -    again=2E
>      -
>      -    This was reported in https://github=2Ecom/msys2/msys2-runtime/=
issues/399=2E
>      -
>      -    Assisted-by: GPT-6=2E1 Sol
>      -    Fixes: af393fdf89a7 ("stdatomic=2Eh: use latest FreeBSD file v=
erbatim")
>      +    Fixes: https://github=2Ecom/msys2/msys2-runtime/issues/399
>           Signed-off-by: Johannes Schindelin <johannes=2Eschindelin@gmx=
=2Ede>
>      =20
>        ## newlib/libc/include/stdatomic=2Eh ##
>=20
>=20
>  newlib/libc/include/stdatomic=2Eh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/newlib/libc/include/stdatomic=2Eh b/newlib/libc/include/std=
atomic=2Eh
> index 67107f47e=2E=2E40f2d269c 100644
> --- a/newlib/libc/include/stdatomic=2Eh
> +++ b/newlib/libc/include/stdatomic=2Eh
> @@ -207,7 +207,7 @@ typedef _Atomic(unsigned char)		atomic_char8_t;
>  #endif
>  typedef _Atomic(__char16_t)		atomic_char16_t;
>  typedef _Atomic(__char32_t)		atomic_char32_t;
> -typedef _Atomic(___wchar_t)		atomic_wchar_t;
> +typedef _Atomic(__wchar_t)		atomic_wchar_t;
>  typedef _Atomic(__int_least8_t)		atomic_int_least8_t;
>  typedef _Atomic(__uint_least8_t)	atomic_uint_least8_t;
>  typedef _Atomic(__int_least16_t)	atomic_int_least16_t;
>=20
> base-commit: af6327c35c85a7c5376a47d980bbade5f40eb5bc
> --=20
> cygwingitgadget

Would it be okay with you if I cherry-pick commit 209858c89d?

