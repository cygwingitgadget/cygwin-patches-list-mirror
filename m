Return-Path: <SRS0=mZdz=3G=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c408::1])
	by sourceware.org (Postfix) with ESMTPS id B0C77385C6FF
	for <cygwin-patches@cygwin.com>; Tue, 26 Aug 2025 20:14:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B0C77385C6FF
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B0C77385C6FF
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c408::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1756239265; cv=pass;
	b=jPndm/0e/qYT9BuwYuNekWl8b0fMosu5NsDPR0ma6R33BQ3BWne2TroBhGgpa2KqqnfJKzIPMzX2nLkzcOCph18E4EeCYLbbJHV1IGcZ+NQNYdlc2oEt+ojYSJ6J90BsOBZAtCj1j8viBv43Urje5XHd/h9/+ofPCi1NQbUfB1s=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1756239265; c=relaxed/simple;
	bh=Y5HnPvdzAkYEUkKLsQ2ZkbjNs6fwFKMm6hipbofgPtY=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=M1W/1ze0aqxCe8Aw+nyUkob3pchk2a+aDw8pspGdg+70a3grpWzFhpYULFYG+0J+mGc6VBxf9VryRV1tLNqa9hFv+WuqHyQTU3DF0M/QWmAehcCSkyPc56ILJ6tJIkdmnOTCcKnHKIEeJchW2cEUPTJE66FcBgOjCS6MNkNB3M0=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B0C77385C6FF
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=11Hkygu0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1Hhxb6na7EfmoA2GwMfwNaE3K3eQkWIjh9TFjUWTfQrJ7Y+iSc09U6twCr5RNSVmBNv1rjosXEg8Y1tmMPLEDjFEUY2fdzX9quaFOzkL/38L+4aYx2yExr82E0+fzHcleX05ndgKn3t0KVl7eC6+BGoyKOesWO9VJpwYwF7k2rds0zKPQFis3Mu/DLyOeUqTiMemlYRRcoOViHzOChX3H/W7ocdM7GwIfXLEv3r/mQQ2v8Ret8jvw+RQb8B7Ca4ssKe8N2OIrj0E/KWL+dCurqWYwSAl5HKwYAbxkn2PAN+GUGRnzpK+fGjJHMm/A8aw4kN8mHPwxIEKB5tNztnrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLyC2k6d+HQfTA790srFQf09atNk7OuxyWIe3IKCxXA=;
 b=aXO16bLIIKHMyKAA8M0epfCCoggNAzvsIRSbg3iA+Vqz8uQdMv3U02eDQbiBbNj8i47M/8ugwmWlDk/7RzMIe7R0tCi1jJwEzx/5xRBRQ60XQetM8OBXpFL2VtTL1CbKVkxN3zqWzEWl0rKh12/1ZWbM9qvVNVwUyj6+2/jrDkPCkS2kigWm7mtCr3IwbD4d1uhgAJ1Uw/kDPUcAF4NJvL9LX2Gyk0E12/5WcMhyy+vZRA3ZPCzvxhCwx+rwkINxDOAUuz+vURN/diMrGqGARXlYMfvyeG51BiwnQ6j9nx2oIoNJIHh656jfrOLO4qUCQ4espxLz7OQdkXomhtgTPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLyC2k6d+HQfTA790srFQf09atNk7OuxyWIe3IKCxXA=;
 b=11Hkygu0B3d01vtRvu1j0a6wrRCMidR/HuP7olPokXUh4d5kaJe6TSbVa8SfbTA1zbjzwl9wQmZgZ5sO8X5w1FfkTkjZyQQH6wryGGLURkhVLjBGao+tIMgw2RZ2fGwM2M1MKy8PcOxz3WqJN2HaapSOZWuqEdADGFw4qt6Ts3fjUJ578CL9t4dJO8zOOJsZXTlcJu2Z7wngLWdHCcwLCFjsdu6QCgacuUfskxdAiTu35hrl6vtOkk1hxWiit5wXNIA/UbiT4Cbdir/OG0YjXX7tBAcMjHVNlVt1NnzuYn/3l+uY6ww6C9QM9hcbbCtmGxNcwFO7pVypxLxujbtbTQ==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by MA0P287MB1806.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:f5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.24; Tue, 26 Aug
 2025 20:14:14 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362%7]) with mapi id 15.20.9073.014; Tue, 26 Aug 2025
 20:14:14 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: Jeremy Drake <cygwin@jdrake.com>
CC: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: RE: [PATCH V2 1/3] Cygwin: math: Add AArch64 support for sqrt()
Thread-Topic: [PATCH V2 1/3] Cygwin: math: Add AArch64 support for sqrt()
Thread-Index: AQHcFsX+HbOEtIxMDkmBBnlieQpVTA==
Date: Tue, 26 Aug 2025 20:14:14 +0000
Message-ID:
 <MA0P287MB308289247CFC3384C1B048509F39A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
References:
 <MA0P287MB308276F1ACA00942D9BEAE6D9F22A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
 <4335043f-7b4c-4147-65e6-de0199da413f@jdrake.com>
 <MA0P287MB30824DEB5F7F550A558C30109F3EA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
In-Reply-To:
 <MA0P287MB30824DEB5F7F550A558C30109F3EA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|MA0P287MB1806:EE_
x-ms-office365-filtering-correlation-id: 02aea748-8ed2-48f8-64ee-08dde4dd20d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?jYsHuCDXrpGZBwdiNtzoEBHQIcP+kqatphB5y/rQ3vt0Kw43mfkzmlGIBZ?=
 =?iso-8859-1?Q?5Cuoh7l+kl32ujLUxyVsqzM9y85ntAakOgiF5PD5no/pO+2mQMDQWJWvx+?=
 =?iso-8859-1?Q?TQsgipUuahNPWgR2HvjPYNHlGcdxVZLmg7NoHPogVjhEJ5wMiee1yR4jZN?=
 =?iso-8859-1?Q?lTvrjUgS0pfkSYKNfTA40IACE07nSaSJXPEopmbBB7gH58adZ/36h6tusZ?=
 =?iso-8859-1?Q?cm4IxUHmaCfPNPhmnXdSlaPyZN16bEFQy1dfO2rwWk5Fq/D9QPxnAp1FBt?=
 =?iso-8859-1?Q?J0/eCt7LPmVgTcPe8X2FrrBf/gwwK/YBdCd21BHlGojaZsxcNIdzP0/jin?=
 =?iso-8859-1?Q?Jao6kh2sDQ4YPacnB7V1R+/KNKUI0ILlE2fh5SDt+HF9OYAi1OuT6yaY+K?=
 =?iso-8859-1?Q?Gq4D8gCluG6PGLCcOaFdZLQIA4W0rnkGJOubdkRrcUSur9At/XTA/DPsCx?=
 =?iso-8859-1?Q?O7Z465i2lBgvXq6DcIjTugriVrM7zL49BPPgvC3Rx/bcobE1uR5WfSETht?=
 =?iso-8859-1?Q?6fDcSSCx6pu1frHFamCJcz8MHYmFD7LDDG3Y4i6WYZPDD1k067TqXVndGd?=
 =?iso-8859-1?Q?XfU/NfBrzCeSsHZrDjyCmSlmd4xQQbKnX+Ezjh2s5jjbPK+1lj9sett415?=
 =?iso-8859-1?Q?dAHaqH8ROBIn0kXazALlddVQiimCZbwrJmP5HeIvh1UDU91mRzdIpXxUGL?=
 =?iso-8859-1?Q?HU24BSXQwgi7NNrexxvv/4QT6CXmD1+0xNrNyPVb0KV+UdRlN11MCqxRhe?=
 =?iso-8859-1?Q?DoXOtrFY07akr0Cv3ByvUa6Kyedn+MMGlGJyQ/E3icWdi18lBfs1HTWOtc?=
 =?iso-8859-1?Q?AGTfA/YC3t/NRXOfj0JqpxLcT9ZVglj6hs8Ei3/GjtBVxU+6MuDC+irewX?=
 =?iso-8859-1?Q?lXK6Ho1KuojJmaRiFkdm37M8NM2PuR9v4LU1gNfVC/wLGp5Rgwan8K/9nE?=
 =?iso-8859-1?Q?0lLvkKfqa/J+VXrw8EbuEeb4Xr+Ph/ZcP8etmnFV7kCzaMvvEd74Kk2klY?=
 =?iso-8859-1?Q?wZyG4s2hkJXhK0xzHOhxSf0BzmEPHW7tivvMg5bmUYe6E5yiWULeMTIvd0?=
 =?iso-8859-1?Q?H+XwadFALuPLN4xqCRiJSPHPi7zGqJUtsYuzRbPvfjJWRAtm8vlpIAZfx0?=
 =?iso-8859-1?Q?ZwcvXaTyDB5XGTmPss6qlxMeAuIkU8N46vTA4XOC3SuN+gWYUzIwXGqpBV?=
 =?iso-8859-1?Q?x0Y8EV1sNzMIPbeHDzi+6sMThIz4/+HqEiy5c+hJ2RXeQJEI3ekEQYWQlx?=
 =?iso-8859-1?Q?Cahmds9nwSf5YEaOh0bjNsHO9XI58/PxlfalyXwrUKJmTMA5g3Atin0uw/?=
 =?iso-8859-1?Q?ReWvvOFJogZMZFaOv71cpYBCflJ+AwG7mXph6fYEBZ17CNAy+8oKDqhgQ6?=
 =?iso-8859-1?Q?VXxr1ovenoNVbY3k1UVSmf0vUh3vcHlzhZvWlqwLrVqx0lNrf2IFO6wZfs?=
 =?iso-8859-1?Q?lpwjJe7vAAeeUxj5X58wg69CRfe1g+sSCW3vPU71AEhSq8mwO+xurEf6W1?=
 =?iso-8859-1?Q?cr4AT/d03Vm2W9LfpqGPhEOtI8TVzpNdmA0xbAwx1uGw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?MKOHyBMfTiHZQbVDCrkRLJYJuPcniN31oqAjkcwTD16bX8fvguFNG76bY9?=
 =?iso-8859-1?Q?EbyN9qPPLo7qucSqlPp4mlQ1ut//oULBWaOPeAAWfke9YPS8qs+8RtJf+u?=
 =?iso-8859-1?Q?8g6nvFb4HakXNJWMn8MVKH3Ub8yA0KtOyCEA5umGW0MbhKd3Ku0MCmVG4/?=
 =?iso-8859-1?Q?c8mw1cFhhBIvdfg5xK44ZBwXu9OGWMEByPj/M65N/7PI6RxdbGYIxTH9nx?=
 =?iso-8859-1?Q?Gy9JTwP1djdgC24D3tCrsverfTfP8888LcON745Nrq50oI0LHS0/vdc6Q8?=
 =?iso-8859-1?Q?5hFOX1leEhzIyCMcf4Ud1p7tmENRRgC+ardBFmI1xtw4Xm5DZUm3vdTqih?=
 =?iso-8859-1?Q?0HUNTpsWeRa4a4nwXIAjtx6M3KDmed7vG58vWXcNq1ZABKu9Gs1MrGfebB?=
 =?iso-8859-1?Q?mj7aZLIjjFbHqEP8J4DWXmnh6jo7dWdNychlSjC8MZhEoR/mOGkgAFw0RJ?=
 =?iso-8859-1?Q?gxmyiV2AjF9GvIyEeIYDLGvFlGCa8RxPsmDCxHKLCfTkDJ9UxCakiXK1s2?=
 =?iso-8859-1?Q?HpfmuRZ/EkiY22x+MAQiLmFWk5tAtQSsA5uaqO3GyMGziZ8hnb06PaK4Tw?=
 =?iso-8859-1?Q?tKx2ztUsRzkFO/HnnSwlyUebcL6sYusTCtL/y4y8JyteEzrpEiY9e1AuLY?=
 =?iso-8859-1?Q?mHyWX3fPXn1d/zW4dddzYBmSxFQUcPokzS84zoNwjna0ShsS+HxKT9TMIY?=
 =?iso-8859-1?Q?ysq35PqV2m+EjwXACF9bpgxoSCW2Cthnd883T65BE4nJ6wbv3zz5wPBcC6?=
 =?iso-8859-1?Q?rIHftEksz4+L6xtfXUYjkcwhG0N5tFmNdudykPa5PYas9B2xg+Vo9A6huO?=
 =?iso-8859-1?Q?5jI1Fn4NWzo/C3eh43jvmJvCxApfDl2MvU+dTSSmftdwojnStAcA3d9EHN?=
 =?iso-8859-1?Q?GCZ6p2r6g4NxT+/jRtU+Dc3iCXvjKa/XnH7akrNHW54JMCrKUuQA5dZ8Th?=
 =?iso-8859-1?Q?S8BOxJJSEqlxB3k9hgW9Ci54ZxkQqt02KsuD8yBMtgXrPW5OTZVcGvZIch?=
 =?iso-8859-1?Q?bRxkTIxshYkXXrnmQnD7kC9bP6QZurKMhjbzAnJf8FRKMv9t4zWelk1o4I?=
 =?iso-8859-1?Q?KC8G09NIFaO4CN1Ice+QgojEeMO2b7LlfeLvGWci5pAuqa0HYZCvPcjhvf?=
 =?iso-8859-1?Q?7stXrW23POBP7j9bdEqhtYzdKNQwt0cqyQT31aiY9jb7hFsU85jozr+YCQ?=
 =?iso-8859-1?Q?BlpOyOb+1Qg1QyVq4eIhA91/3J4SoOntwbDKtJ5UPO7xL9CoxQofR9uOMO?=
 =?iso-8859-1?Q?+4SQMoycjZL+4vtByOkvVGj8htD1GFC0wZUpOB/AkrC2cYiC7TPVljmEX2?=
 =?iso-8859-1?Q?89/kKXnPV1tM+7cURRa5mrM9GVftQvj4nRl3v1eP2uOp97pNvRniCFlfgS?=
 =?iso-8859-1?Q?8SABkSa2QYU48xp+mG0TxoFTK70AWmU3B5D8smRQpWl9ZO8If9Mc/8fq++?=
 =?iso-8859-1?Q?YyI4Bt0ZZ3KCK2lAbTJNPKTb6jdCNH5Q/QvYYAe2/8904URzdPi/4kNLf4?=
 =?iso-8859-1?Q?Z2nw6eJEdBO6EBsB2nBfp+VysKDePmu+qVDr+MmH4k8iMFcfOZZiRHBLV4?=
 =?iso-8859-1?Q?EdW9dKLRx98cbqRujUCEv5wc5bJRnRsFyrYbo3cJW213eYaB2fUGLtWGul?=
 =?iso-8859-1?Q?+ZP1rNUT+QfmonOWPKP1D8lyBYwMYL+dbETTp7yUrbhw8d28B63aPSoe7s?=
 =?iso-8859-1?Q?EZCA6H4GOi5YqBmbHbp8t9SpZuVHnT2Sxx2ffrTV?=
Content-Type: multipart/mixed;
	boundary="_002_MA0P287MB308289247CFC3384C1B048509F39AMA0P287MB3082INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 02aea748-8ed2-48f8-64ee-08dde4dd20d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 20:14:14.6202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nW8M9NdIjk549hXRZqIvIogZNjTCDbjbNDQRssLtjO58HO3zOHLwg/vSg08Dw7rEOGkCYghWB0KzDFlHo/4Mjzs0AIyDXHBfXDfqj4+OZ0JlVq35T2nf7UQn+fRzSHfODeu+hkWzpeIy+zSpyHRk0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1806
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_MA0P287MB308289247CFC3384C1B048509F39AMA0P287MB3082INDP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

Please disregard my earlier patch which added a `sqrtl` implementation unde=
r `cygwin/math`. After the review comments, I've reworked the changes into =
cleaner 3-patch series:

- [PATCH V2 1/3] - Cygwin: gendef: add support for conditional arch entries=
 in .din files
- [PATCH V2 2/3] - Cygwin: math: split math sources into 2 groups
- [PATCH V2 3/3] - Cygwin: export sqrtl as alias to sqrt on AArch64

In-lined patch 1/3:

From 6881f6485a135bd554d221c60b5288a1489d63b4 Mon Sep 17 00:00:00 2001
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
Date: Wed, 27 Aug 2025 01:23:22 +0530
Subject: [PATCH 1/3] Cygwin: gendef: add support for conditional arch entri=
es
 in .din files

Extend `gendef` to recognize and process conditional export
directives in `.din` files:
- `[arch]` means the export is included only if the target CPU
  matches `arch`.
- `[!arch]` means the export is included for all CPUs except `arch`.

This allows `.din` files to express conditional exports directly,
removing the need for manual duplication.

Signed-off-by: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewarein=
c.com>
---
 winsup/cygwin/scripts/gendef | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/winsup/cygwin/scripts/gendef b/winsup/cygwin/scripts/gendef
index d60d45431..2d9fced5c 100755
--- a/winsup/cygwin/scripts/gendef
+++ b/winsup/cygwin/scripts/gendef
@@ -39,6 +39,13 @@ my @nosigfuncs =3D ();
 my @text =3D ();
 for (@in) {
     chomp;
+	    if (/^\[(\!?)(\w+)\]\s+(.*)$/) {
+        my ($neg, $arch, $rest) =3D ($1, $2, $3);
+        my $match =3D ($cpu eq $arch);=09
+        $match =3D !$match if $neg;      	# check if negated [!arch]
+        next unless $match;            	# skip if not for this cpu
+        $_ =3D $rest;                    	# process others normally
+    }=09
     s/\s+DATA$//o and do {
 	push @data, $_;
 	next;
--=20
2.50.1.windows.1

Thanks & regards=A0
Thirumalai N



--_002_MA0P287MB308289247CFC3384C1B048509F39AMA0P287MB3082INDP_
Content-Type: application/octet-stream;
	name="0001-Cygwin-gendef-add-support-for-conditional-arch-entri.patch"
Content-Description:
 0001-Cygwin-gendef-add-support-for-conditional-arch-entri.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-gendef-add-support-for-conditional-arch-entri.patch";
	size=1458; creation-date="Tue, 26 Aug 2025 20:01:04 GMT";
	modification-date="Tue, 26 Aug 2025 20:14:14 GMT"
Content-Transfer-Encoding: base64

RnJvbSA2ODgxZjY0ODVhMTM1YmQ1NTRkMjIxYzYwYjUyODhhMTQ4OWQ2M2I0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5hZ2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFn
YWxpbmdhbUBtdWx0aWNvcmV3YXJlaW5jLmNvbT4KRGF0ZTogV2VkLCAyNyBBdWcgMjAyNSAwMToy
MzoyMiArMDUzMApTdWJqZWN0OiBbUEFUQ0ggMS8zXSBDeWd3aW46IGdlbmRlZjogYWRkIHN1cHBv
cnQgZm9yIGNvbmRpdGlvbmFsIGFyY2ggZW50cmllcwogaW4gLmRpbiBmaWxlcwoKRXh0ZW5kIGBn
ZW5kZWZgIHRvIHJlY29nbml6ZSBhbmQgcHJvY2VzcyBjb25kaXRpb25hbCBleHBvcnQKZGlyZWN0
aXZlcyBpbiBgLmRpbmAgZmlsZXM6Ci0gYFthcmNoXWAgbWVhbnMgdGhlIGV4cG9ydCBpcyBpbmNs
dWRlZCBvbmx5IGlmIHRoZSB0YXJnZXQgQ1BVCiAgbWF0Y2hlcyBgYXJjaGAuCi0gYFshYXJjaF1g
IG1lYW5zIHRoZSBleHBvcnQgaXMgaW5jbHVkZWQgZm9yIGFsbCBDUFVzIGV4Y2VwdCBgYXJjaGAu
CgpUaGlzIGFsbG93cyBgLmRpbmAgZmlsZXMgdG8gZXhwcmVzcyBjb25kaXRpb25hbCBleHBvcnRz
IGRpcmVjdGx5LApyZW1vdmluZyB0aGUgbmVlZCBmb3IgbWFudWFsIGR1cGxpY2F0aW9uLgoKU2ln
bmVkLW9mZi1ieTogVGhpcnVtYWxhaSBOYWdhbGluZ2FtIDx0aGlydW1hbGFpLm5hZ2FsaW5nYW1A
bXVsdGljb3Jld2FyZWluYy5jb20+Ci0tLQogd2luc3VwL2N5Z3dpbi9zY3JpcHRzL2dlbmRlZiB8
IDcgKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBh
L3dpbnN1cC9jeWd3aW4vc2NyaXB0cy9nZW5kZWYgYi93aW5zdXAvY3lnd2luL3NjcmlwdHMvZ2Vu
ZGVmCmluZGV4IGQ2MGQ0NTQzMS4uMmQ5ZmNlZDVjIDEwMDc1NQotLS0gYS93aW5zdXAvY3lnd2lu
L3NjcmlwdHMvZ2VuZGVmCisrKyBiL3dpbnN1cC9jeWd3aW4vc2NyaXB0cy9nZW5kZWYKQEAgLTM5
LDYgKzM5LDEzIEBAIG15IEBub3NpZ2Z1bmNzID0gKCk7CiBteSBAdGV4dCA9ICgpOwogZm9yIChA
aW4pIHsKICAgICBjaG9tcDsKKwkgICAgaWYgKC9eXFsoXCE/KShcdyspXF1ccysoLiopJC8pIHsK
KyAgICAgICAgbXkgKCRuZWcsICRhcmNoLCAkcmVzdCkgPSAoJDEsICQyLCAkMyk7CisgICAgICAg
IG15ICRtYXRjaCA9ICgkY3B1IGVxICRhcmNoKTsJCisgICAgICAgICRtYXRjaCA9ICEkbWF0Y2gg
aWYgJG5lZzsgICAgICAJIyBjaGVjayBpZiBuZWdhdGVkIFshYXJjaF0KKyAgICAgICAgbmV4dCB1
bmxlc3MgJG1hdGNoOyAgICAgICAgICAgIAkjIHNraXAgaWYgbm90IGZvciB0aGlzIGNwdQorICAg
ICAgICAkXyA9ICRyZXN0OyAgICAgICAgICAgICAgICAgICAgCSMgcHJvY2VzcyBvdGhlcnMgbm9y
bWFsbHkKKyAgICB9CQogICAgIHMvXHMrREFUQSQvL28gYW5kIGRvIHsKIAlwdXNoIEBkYXRhLCAk
XzsKIAluZXh0OwotLSAKMi41MC4xLndpbmRvd3MuMQoK

--_002_MA0P287MB308289247CFC3384C1B048509F39AMA0P287MB3082INDP_--
