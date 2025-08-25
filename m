Return-Path: <SRS0=xBtD=3F=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazlp170110002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c409::2])
	by sourceware.org (Postfix) with ESMTPS id A25F9385771D
	for <cygwin-patches@cygwin.com>; Mon, 25 Aug 2025 17:57:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A25F9385771D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A25F9385771D
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c409::2
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1756144677; cv=pass;
	b=l/KfWPBBRnk/XL5lMl863CACOaKytUrl/yQ4uoJQzZOfLElcxnbZ34VO7bYi7sad+jC18zMgDWZePbGTImM5tRs6q/fPPDmERMLzhOFTx2YHEiwrQxTnRjUa2YNN4mXhvLp+Of33jaeI8DtPS7csC/xqth+h13nVdBKMXm1Vhug=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1756144677; c=relaxed/simple;
	bh=9rogP5eeNjZh0c0BQT6sqHoRz56vnZyz4I0Y/jdDvE4=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=Rngk1tInyRmqAUUoOWJhV32MUmUHl775j3QsIdUuXjiEis5s0jipEoMP9UJbZSBJyaUz83/helSKibkNDfI6UpecO8u5db5FU2jUeI1DhWc1N92G7819QeKG0shiJGwswZKhHxLkbCS+s1yX6V5n/esGgr3KwxmFy9nTbFhON58=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A25F9385771D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=H7eLXBDr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OAwv0a30sk2dKlrcWYSIBSESVKR9jGyXjcSqurnLQiDh5WnPte13KzzX8dV0Ljt6GgaoXTPzzRYtmzpuc9/W8YGh6IynYQSQ5IleyGt0ePr1twGAXAkEiq6zs9grpxh4oCRnOwKlC53HmBUUOQWiNKfqAE12B8PB8TsQuGuOExhZPpgdKvLowkamEhNKJ4mFK7djKiTfmOkEaAdY7eMq082Y52DdtkGYxw8V2bGJIIUUqoTQ/AaFxT3kAwiUS76p+0Epv3RvqBcs8RsoIjgH0Fq7qoXfkoj21SgaAIQuVK4UIPVmdOY667kBPTZK3xbhGsAYrMM0vKNzfaIh9womtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IczQp782ekarGGZeLcciMlDpq+CcGpUswV69Bj6DT5A=;
 b=IMFpRxeNGg+dRKKnECAubS+bxoJC1EfUsY6Bdbr02/zo/UdFVfB8tegDl48zjqCbM4Zl5oZB1TDCi0HowfJhn5otdieqbBKmfJbEnB2BF0rHNux7ip06VrDUm34+3IzMa2jBo7HEiIX9Hg1smQ/PGZevemAD7FEWZ1TTY/tAeZjN/rGZvW/QnhzAzRgBDXxYv0RTwEzPTxJa1DgcfSnJyHJMDLcdwiKpZWAecBfYGlnWknJxSByN3jbOh7L9kpidEsY8hCgR34sEsSP986oU82fjOi3SleRuK7QKCAYDjIELmNjRa+DgZHlH4I+e5ESY2QOw/cXjEQ0a/ntc9K2o0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IczQp782ekarGGZeLcciMlDpq+CcGpUswV69Bj6DT5A=;
 b=H7eLXBDr2CKTYuq0Hhqigpb3x+3neayZ8b8EaJRQpo2kOtdtm958EdPrGDzlI4XSA9TjhGauus6rGwLnk8xAkbcQlVFBGEOgglIh5FjJ7Emrd4/P/2daNJ9+VlfiUhHTHpJAb56QjeeVQub1RT688HPjQ8sAHdHCjhItAEmChjyskFMMRX5GKIjf6nnErROMB/ea71AiTeCPvrmalBZ2ZSeoybDMdcD64WTDFHfKO7v8UKm4KnnnqQmf+TflpBdnojJidarf4qgfDjypMMBoT2vRb5AmuWnQfBw5eGimRxLrDLJ/RwhD0IKaKq+r/l3TVnZnB29c37ZyHES+qCtESA==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by PN6P287MB5082.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:2ff::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 17:57:52 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362%7]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 17:57:52 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: Jeremy Drake <cygwin@jdrake.com>
CC: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: RE: [PATCH] Cygwin: math: Add AArch64 support for sqrt()
Thread-Topic: [PATCH] Cygwin: math: Add AArch64 support for sqrt()
Thread-Index: AdwGO9GU5J7yKW8lTTmp+dxkBwCoIAGPKIOAAlw4W/A=
Date: Mon, 25 Aug 2025 17:57:52 +0000
Message-ID:
 <MA0P287MB30824DEB5F7F550A558C30109F3EA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
References:
 <MA0P287MB308276F1ACA00942D9BEAE6D9F22A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
 <4335043f-7b4c-4147-65e6-de0199da413f@jdrake.com>
In-Reply-To: <4335043f-7b4c-4147-65e6-de0199da413f@jdrake.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-Mentions: cygwin@jdrake.com
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|PN6P287MB5082:EE_
x-ms-office365-filtering-correlation-id: 06902217-8b15-4f71-e1d0-08dde400e99d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?vNEg9Fs8xymMGg4OoEugUuWGz2Hqg0s1+bN2ymiGE5ZrWpsGjoQtmEBfrk?=
 =?iso-8859-1?Q?WlsyJJAI69p2p3KQZSf7oliA/Jxw5xLDxghVa98oNrp8bgLyHNdGbVOOAO?=
 =?iso-8859-1?Q?yTIqtK2z+Z0zE9kq4sby4iIRqqxBybdkJbCW+nBA3Z/qejHCJYQrJmIeIi?=
 =?iso-8859-1?Q?YP4t3HfImuNjl/CHuN48KR/naW0/1SO9HPBD9+gJB9Nom9Y/L1Bon3T3MY?=
 =?iso-8859-1?Q?trvZZ1oIPdp5qG8lmTKud1/Kic75k+ppnIjN5mZsfTMxc3RRiSl3vv2fiD?=
 =?iso-8859-1?Q?z1abaaVGlUjZk2aa2zumhwqvuQoNXSdIcPhv2GrciZokZh9D4UWQ7O169r?=
 =?iso-8859-1?Q?qGA+/HVf4fHIn8JUmBJHUymO1ar8bdDKVSzx67G0gcwHQL3u6T76qfrxwF?=
 =?iso-8859-1?Q?jDwCe7X5ybzO/PMiOCftJLp9GsJtk2fTj3V2AcD8hlGaneyrLtHdIVUFT/?=
 =?iso-8859-1?Q?1OB5o+loRce/bTsm9AOvWix7oR5kZSpd2BrDYlezMxbpKTvsWa7N14KzZ4?=
 =?iso-8859-1?Q?HcS+r+/HYWnUV6ANCdqskfyzP6g0N9QRsVfihLl7nGx+yerWEzX9sKcu7s?=
 =?iso-8859-1?Q?WjLfNPETcMyLICl07RO6YiRy15xQWBOQkKfeyh01O6EgGf0w7IPJGglrzS?=
 =?iso-8859-1?Q?Rfe1DkhKbqiZ6OE0NHKyIMoDMDys5sXdUw0zhT6lE5x2JgnRrcDodmwbSS?=
 =?iso-8859-1?Q?18ii8SMUN3uJmnazusJ6kgl0LnmXXV9D6AsZaW9W5fGyNcYejXdHLo6R4u?=
 =?iso-8859-1?Q?+uu1adgo9PV3IqwtWLFPZkDhfkU3iDKcl4HRGqLN4wWI2uDIrtisJDUjxM?=
 =?iso-8859-1?Q?U1ivlhjTBgBwEPF+V4Wyo+xOq4EmaxM/O66qoc895uuxQIejtPkGxnGfa3?=
 =?iso-8859-1?Q?DfSlJ5ziod2PMLXGFN0PtAtOgoTB0beAfFtHtBbkacmVOhAGTA3kmVGLEM?=
 =?iso-8859-1?Q?jROqdbo3KEsBMTB1XCa21ZNSNpn3c0WLf8mb2FWp8QkbXp7dRe20s/krrA?=
 =?iso-8859-1?Q?EXTwvJz8EZhfUdZZs6uB9U9cWJk+1xpylbjq5sFU6kpC7W1By3OYLmK+2g?=
 =?iso-8859-1?Q?JshCck9mwLFcRu6JC6qyzJbjTzGDlbUSntNPJEPyaci2+HErWD8jvm8DvD?=
 =?iso-8859-1?Q?HIfv5S619HX7VyUZU7liEJFVpGX6cPLPzF9ZrGpo5X9TJ0paBKG5iTjxyK?=
 =?iso-8859-1?Q?TS1PWBn/RgJb5HH30CEua3ksTnvxVjg8J/RzrP2PFXZJKitIpdhfekQW0S?=
 =?iso-8859-1?Q?oycMkY0/T342XCKjW/rNUAvjS787oQJKLxGMkC3o/l9L6E8yK3BPQTeMqI?=
 =?iso-8859-1?Q?DLtIKBXboen3lpC0P1bV6TB0M5xmUgSTP/mY3naRbq0flMWsGmBNkF+fe7?=
 =?iso-8859-1?Q?u+/rh4wa+Xblx09ArtT/iKhOIOogJ968j9ChvhBRp/Z+xOFxp5fWNsdtIe?=
 =?iso-8859-1?Q?pk66QI/RmZOwrp4eGys/wQXyhzXVmbIp8aT2ONQ6Ie7rcLcE47qpJbActg?=
 =?iso-8859-1?Q?mQZ14Zk5LjLFyJRd7ya38xpvp2k5YSAXt8u3jDlQ4WJg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?eBhnOm+J8X1ZqrXMGS9DKtW2gDRYOr9vyHjE0IXFcipCLP43lczDqRbnSj?=
 =?iso-8859-1?Q?FxXEYa94o4sh6oVw0ZTIVBgmUSAuLH/xBVpR7n5UPeAPTvohWo0Bc9rvA3?=
 =?iso-8859-1?Q?zHgAsRsDS+xoSehOmUSV8anOw4c84Op7XQh1Fas67A1nVR9kb1K2owQvLZ?=
 =?iso-8859-1?Q?Zn10ypMBTWPU00rmDWgO7KEaMqTp36xRDR77KgnkKYhRWmJQeY+zeiIfVO?=
 =?iso-8859-1?Q?d27zeXzufJrGB9COs9UQWPEJO/yxHt0tF/YtKJNnlG4VFB9v+dmJmQdsVa?=
 =?iso-8859-1?Q?Ule5KAD8z/mhecI0GOnjDCx37vHGf2hjnTLeIIs/CZ5h9iSjAcE88O0+gk?=
 =?iso-8859-1?Q?9CnoJbA2XPeYz05pGDAdgU7hPktuAEBk6pxNc47zRnWl+wkEJXCtG/NThk?=
 =?iso-8859-1?Q?qbP2Zldj9vz3glTYX2YIm3q9zYR+PgbO+sYgJLjP/TrKVT6E6GzA3dZlgT?=
 =?iso-8859-1?Q?IyVU7iVopPD+qjq5UHBWXst06gmOmLVE1SBTtww0NOEiXdpZY33zBTId11?=
 =?iso-8859-1?Q?+dinaEFxxZOIsFkX09zlDENC9a/+AFI1S4j7sPpkhC9fRMRr8ZyBQigatu?=
 =?iso-8859-1?Q?kiaU4yOH7rizqCmO0tFyaDt3CKif5up1LJ+EM/L8I7W0Fpjwg/xpa61c3u?=
 =?iso-8859-1?Q?q2ZEMCMZ8PAFoWJLmYfXraLbyzyvBJS2ztvZrxJxDapZdiWGJlAddoeY2M?=
 =?iso-8859-1?Q?36jZ5tHiZ8bwIzcLI8SrnXsLm+fUkX+WxMMrJqLZpyl7TFDPnX+ASpzJFR?=
 =?iso-8859-1?Q?c1SXH3b/NQKVMVsBEPubGwAOjCZridfDXL8eDaLLObHW2IHaBNIdTa4FMF?=
 =?iso-8859-1?Q?MxSh43FgVwQqE5n9Nzt8PgIP+GIzNzMSmr/Q++PHgdm1HoWn8pSnDnhtu7?=
 =?iso-8859-1?Q?+rw0qGSz+mgsJNjpnT0MDQ8j04ggygkKvQhlgj84urNHuUfkIEaadGInZp?=
 =?iso-8859-1?Q?OmiwAyiWel7vSLBT6lhsgh5YxsQZo2FoOCxn0EgzfuemsiE8ACW6sRxKng?=
 =?iso-8859-1?Q?DtHhk/ZVdK8ZXKjln6uq8KNxkoWGQgBIBb9tZgVHiPlOS8vLKtU61I2v+d?=
 =?iso-8859-1?Q?U9GigiNWsj8n/9jzvYqI0JKEtBPjdjCoAx9qETtV48s6qXheat/njC5Vh3?=
 =?iso-8859-1?Q?2P+WSwjM2d7hh9t5fV+03RAYM7NAmMlxm60jnBumEV5xtPsexR1HpOvJHQ?=
 =?iso-8859-1?Q?wp5ufKIynMMCUDQ+/mSB5vg79XkQv1Za8pLwe2UI0W4RznlQOdt1lSjWkY?=
 =?iso-8859-1?Q?khjqnEoHl+xo0tBxhh7amMPq+/J4F2i2EtRjraff+g84HLoyPEcgDwVGif?=
 =?iso-8859-1?Q?jkVIv5OGUw2Xq5fif/LTlXXvl7GuzCLbRxEqkCxPPIvg+aKn/afIHlgmTN?=
 =?iso-8859-1?Q?Yu5fU2UaXTxi5ETuQUhqwcMsIWqEhTXQyjwkr8IszSqTkegLlidxleTXjU?=
 =?iso-8859-1?Q?ouIDMuLBi9pnYYk9RtI1NeMVobyIZ/koj7TbruhHDetft83PZwkfW9JbJP?=
 =?iso-8859-1?Q?Yxozx27eyKxrNLB1JxHAHpDb49ZL1BDeqjQmTf5BdV+SO1KNgqoOskQOI0?=
 =?iso-8859-1?Q?Bx3ID6a7YLgilOjyoxHbBTIQ7BxT7X9TFW5WaYQf1XL5sUxciRMuHHuSsT?=
 =?iso-8859-1?Q?9Mb/SdQxn64go8vuV6PRMO+SFHCR+7Kye940G5aojqdmcpSzmH+d8wUXDl?=
 =?iso-8859-1?Q?Abh6ESxa7+31YVubvQ0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 06902217-8b15-4f71-e1d0-08dde400e99d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 17:57:52.6828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AgFzGKBDRTTOKe1wLPBAgmGzbbxc5JbsPigKflC1dkTpHyiyzdbZ2UOmBjjfQ2IZlbnPr1Y6A3t/2RHY/P+gRd5pKruer4+azrjikUCGmoUgRS2ZQOlf5m8bKJwysq41qNhknz2CK3sCNlUgDOpwFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN6P287MB5082
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Thanks for the review. @Jeremy

You're right, since `long double` is the same as `double` on AArch64,
adding a separate inline-asm implementation here does duplicate.
Aliasing the long double entry points to the double ones in `cygwin.din`
would be good as you suggested.

I can look at extending `gendef` to allow either preprocessor support
or a minimal arch-conditional syntax so that we can express something like:

```
  #if defined(__aarch64__)
  sqrtl =3D sqrt NOSIGFE
  #else
  sqrtl NOSIGFE
  #endif
```
Will submit a revised patch shortly..

Thanks & regards=A0
Thirumalai Nagalingam

-----Original Message-----
From: Jeremy Drake <cygwin@jdrake.com>=20
Sent: 13 August 2025 23:04
To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: math: Add AArch64 support for sqrt()

On Tue, 5 Aug 2025, Thirumalai Nagalingam wrote:

> Hi all,
>
> This patch adds support for the `fsqrt` instruction on AArch64=20
> platforms in the `__FLT_ABI(sqrt)` implementation.

This looks OK as far as it goes, but I have a few thoughts.

From the comments, it appears this code originally came from mingw-w64.
Their current version of this code has aarch64 implementations.  The differ=
ence with this one is they have a version for float as well as double.  The=
 versions here seem to only be used for long double (which on
aarch64 is the same as double).

Given that long double is the same as double on aarch64, might it make sens=
e to redirect/alias the long double names to the double implementations in =
the def file (cygwin.din) on aarch64, rather than providing two different i=
mplementations (one in newlib for double and one in this cygwin/math direct=
ory for long double)?  It seems like that's asking for subtle discrepancies=
 between the implementations.  I'm not seeing any obvious preprocesor-like =
operations in gendef (mingw-w64 uses cpp to preprocess .def.in =3D> .def fi=
les for arch-specific #ifdefs) so maybe this would be more complicated.


>
> In-lined Patch:
>
> From aee895b4b7c4045dea64d1206731dc01d29c155c Mon Sep 17 00:00:00 2001
> From: Thirumalai Nagalingam=20
> <thirumalai.nagalingam@multicorewareinc.com>
> Date: Wed, 23 Jul 2025 00:37:09 -0700
> Subject: [PATCH] Cygwin: math: Add AArch64 support for sqrt()
>
> Extend `__FLT_ABI(sqrt)` implementation to support AArch64 using the=20
> `fsqrt` instruction for double-precision floating point values.
> This addition enables square root computation on 64-bit ARM platforms=20
> improving compatibility and performance.
>
> Signed-off-by: Thirumalai Nagalingam=20
> <thirumalai.nagalingam@multicorewareinc.com>
> ---
>  winsup/cygwin/math/sqrt.def.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/winsup/cygwin/math/sqrt.def.h=20
> b/winsup/cygwin/math/sqrt.def.h index 3d1a00908..598614d3a 100644
> --- a/winsup/cygwin/math/sqrt.def.h
> +++ b/winsup/cygwin/math/sqrt.def.h
> @@ -89,6 +89,8 @@ __FLT_ABI (sqrt) (__FLT_TYPE x)
>    __fsqrt_internal(x);
>  #elif defined(_X86_) || defined(__i386__) || defined(_AMD64_) || defined=
(__x86_64__)
>    asm volatile ("fsqrt" : "=3Dt" (res) : "0" (x));
> +#elif defined(__aarch64__)
> +  asm volatile ("fsqrt %d0, %d1" : "=3Dw"(res) : "w"(x));
>  #else
>  #error Not supported on your platform yet  #endif
> --
> 2.49.0.windows.1
>
> Thanks,
> Thirumalai Nagalingam
>
>
>

