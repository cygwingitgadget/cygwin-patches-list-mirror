Return-Path: <SRS0=mDB5=AN=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c408::1])
	by sourceware.org (Postfix) with ESMTPS id B8A4B4B9DB5E
	for <cygwin-patches@cygwin.com>; Mon,  9 Feb 2026 20:00:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B8A4B4B9DB5E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B8A4B4B9DB5E
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c408::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1770667224; cv=pass;
	b=beAY466RvnXyFIsKFN2xXYsb0ytRdB7fmpv0P0pup1yiyUHfdPae26IbpwvaFQoao80Oy0cmFdtvvZBJHKJjWN76eu2eL61NUK/mUEkt6DY58Z7AvfQGfkUivUA1hRmUo361jSotUnoEc1Srhpb2Oay20I6Xlqx6NLl2PczWoLE=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1770667224; c=relaxed/simple;
	bh=Ko39ZqYehCnlofUyEc4Zd5rsgWkenL48zlNgdGCO0l8=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=e1qRo384jfsOrniaiyJL8RYhoeB+Dst8e4TzJFqWAwqXCBLT6Ot2zuBIOfeVvY1UceF3fFHLYHTQ0X6bfiEwYlh/SLyJ5bMQStR+RuvbxwgpzoRBjDW9oSmy36zZD3rvg5ilWav0BjE5qGsFqPPWL89182nqaGRoW+F8+3u8H9w=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B8A4B4B9DB5E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=hX2Ro8Hd
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6kp+vSWMxspuJ+gRvZL4oTpuqI1vZksvMt6L4+lgtp8G1674PBea8IeXMlXL0TXQiBn+hjxZBPf7O5/GQfExeZvYuV6Sh/0vuzKvMFgjaZvJhlMZbsLkTL4AjU9xI9TzqBP1leXmU0/hSkUhlS+/++bXYZALXAzuBQs9uakX2dO8dvv2PvWoR0MW5rJfE2LCGsi1Cjayx9ztakNFMWjYoqksQXvZa0BuKlCQGvJ8Px47uuJ/GnsNxRoeLlkz8s2+uC49xaDivAOTTSvKj9T4zTa4eMQBGf7C35y5EgoBc5pA6w2wnWW+c10To+7PJXc/kWXGLKkStIFfNXWAaUKpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oHgIBJ4ZeR2ju5qkIJsa9qwLgI0+g0SpTnR/fj8gOY=;
 b=WwqVAOTkQ91lUDH4Z/PNzgtXBml2x2qHxNYEPGcIE+BGoPE2nrIr1Ff7/M+m1Zrcasrtx5vCGtqdFEEXorz0TZUrzLd+X0iSefro8Y8W8n2bQEAYmEG6IH8Vjj/4LPBgUIh7mYbrKlS9cUdLZQAIjiLaIOF/RPUkano0KoyVkEIdW4xjYGbVG2sYjslwj+Rd+TjtsLGfSId/iszz5BkmkaTx0xSpOEqPBOb90uZLe6//IDfSwWQbHEW9PLbzxmFQIU3pt5xZA2OKf5+AkdV3mSjwi9aVrqJbnwiLTa2nH+biEhu4x/IhiJIUks95m33rxp8epKkQWoKFq0wxG2ugXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oHgIBJ4ZeR2ju5qkIJsa9qwLgI0+g0SpTnR/fj8gOY=;
 b=hX2Ro8HdkULP2Nck4T7MqYu0cA581nHj+2W4xnSQvei6ERQ8fNis5MGAKvi6jNBZ51928gx8bOpEvx5BuwyCyPBXIa5mEUWC9ZXPh3flqRsukqOvSVwygBJ7Yc5S7SiyiriPuPYZ9zEbn8jOtStNyPfOqjNyPxIwNyvgCu2SpbXRiBcY8H3wd9F4lJyW+BhwF+mYaOZFPQdjRvo1C2ukUDjr63+1XEIq7qyeBcgbDGzmGlSYzy0mgWqikouwKaYf+K+Aqn9dT+GVit813O/rn765piRJ4GdfcRfD7KICxAEB08x7JcV+nWzTZhmFmWrljmSsBUKbz1IYvhgm93nwiw==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by PN3P287MB0164.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:d2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Mon, 9 Feb
 2026 20:00:19 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::f574:2c10:ce6:4682]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::f574:2c10:ce6:4682%4]) with mapi id 15.20.9611.006; Mon, 9 Feb 2026
 20:00:19 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 2/2] Cygwin: gendef: export _alloca only on x86_64
Thread-Topic: [PATCH 2/2] Cygwin: gendef: export _alloca only on x86_64
Thread-Index: AQHcmfQ7P2Qs3TXJzEG34LQtrmzpzA==
Date: Mon, 9 Feb 2026 20:00:00 +0000
Message-ID:
 <MA0P287MB3082B2BA4E9D476168C4DB919F65A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|PN3P287MB0164:EE_
x-ms-office365-filtering-correlation-id: 8bd41961-6243-49ed-ad29-08de6815da3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|6049299003|10070799003|376014|4053099003|8096899003|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?cu2MoXZjW1LaEwc6FLWH91eGt/e8cBNzYoeUCdJxZ4mPnhPbQtT3NEWiNj?=
 =?iso-8859-1?Q?ZqZTV3dj41z5umq8XM1l+IjCSLkcRC4TFHxrMpI6rEmXhOchJct4jAsG6q?=
 =?iso-8859-1?Q?eFkTipfnputcJHsFX06Y9aIfy5xuNs54DmeUs2/Tci1bWSX66O6Bi30czI?=
 =?iso-8859-1?Q?v8mxh1jjRUSY9f4rj+Ve0F7G1LMB1oUzp/5NDG4ygGLQcN7Et7npjfTeHr?=
 =?iso-8859-1?Q?FE4Fkgm8zX6Yp1vsP6WO0/5etWkRFDINtWn8OS8He0V1tjfNiCTCkANBBi?=
 =?iso-8859-1?Q?tPUs6BsBEqR+zVLiJC7l5LzfA6ohUeUtKebBh8HdG8W2/AF3vszDspoOUZ?=
 =?iso-8859-1?Q?hWKvv+0t9o5wZpwaOGyDtWmrJfovTYzgC5O6cuzHGMrg4cuM2suxIvj2Z0?=
 =?iso-8859-1?Q?Wxzkp3YgvItoAG+Jn49dWxmm2cXThda7+okp1wJ6H7Km0UfequNGkNliLk?=
 =?iso-8859-1?Q?KTwKOAxNMlgVcK884WI9MRJZVfB08ePMbLywM0uQeL6MOeL0aHsLHd7Ui8?=
 =?iso-8859-1?Q?Yiy5Qe0fbQIff/oeXKvFbZbQiAVgDhcVEB7lKlxovNVVAwE1JPjtZ1y1Nf?=
 =?iso-8859-1?Q?S88dhH7c8FwnaoFlyRLtamUV+oclgaofwHt1ZtAjQVyezzC5MJm6Y1EfgX?=
 =?iso-8859-1?Q?o9IRvIx75/9izFeRWDcXlKHmFwMNhHwxbwJPUdYtzExtIx3wKiQcUKHH9u?=
 =?iso-8859-1?Q?QZ4fzLuu85Dl9EMp4TTmTtR7XdgXH96oH6yf9uy4PWlJWJlBy+VrIeNJ/O?=
 =?iso-8859-1?Q?8pk+vBxq4HwzoSeD+F0pZqZvYGPdv8woDELYD1i77VpTxFy59R9WHQLuMl?=
 =?iso-8859-1?Q?YytSsD4cKPzplkg5rXtnqtYe4etLjB6F5DXbROFRYPOfTV2f0PsnuFv8b5?=
 =?iso-8859-1?Q?l2i8Q1l01/2tRvRHM/O3Q5gpQsXx3WuEIa59pCrHFYzu+mW/TWwd0Qd3/f?=
 =?iso-8859-1?Q?sDFe6ra6k8jVf9k5EaK2HhdFOu1Zm26XAATl74iMP+nNS8jKDbGw+mx7Q3?=
 =?iso-8859-1?Q?WjwMk6h5iUKtczVPzuLna1io/2OvOcVO/nOV7FVBUnArjOgRII7/DPTceF?=
 =?iso-8859-1?Q?k6wah5KIrzkfnu7CdZeETsIPm5K3dakk49txOeXgvs/4TTfFkuSsHOrZ47?=
 =?iso-8859-1?Q?a98CmEe+l5loHZZ75eJqMmAjMg0uCzTGzvd5KO+niIGdO79B8bx8TrdimI?=
 =?iso-8859-1?Q?4mBg8+8IZoBPVt3MfD7m7kxjMpJ/93Z2D7KIaGlN+fXUCzqBfupItZrnin?=
 =?iso-8859-1?Q?S2tUy0DJ0IBoXuHuY7s1sLiOWiLca4BR/OieBZl+Mm7VM0ku3XDwtC8e83?=
 =?iso-8859-1?Q?cyGDsJ+caRW4dYipzdrQKnJbRiMdPeSyzxQW5gZiXJU1rIlzB0iTvqB887?=
 =?iso-8859-1?Q?Qe5iwxesyI+xw32nJqU6lJFC+eDt/l/qVcMiONpG/TOjuCVthFNlTiGepO?=
 =?iso-8859-1?Q?jmlM0J7W9UjsX02dXcIkPA1w+W6KW3q9K3Ofc1QVGbMveCPxAfIviIWBng?=
 =?iso-8859-1?Q?YGXCk0GeMf2QxhejltkNHN76h1j+kXmUUvdTOtsHBIZStKpAkU9ftPTxV4?=
 =?iso-8859-1?Q?hRQI3Te30dktkzrXNxJoMjJ2PtoFCiFQdQiquAhoyz6dBL8E4ZEUZ4/9op?=
 =?iso-8859-1?Q?Sy4UqhyuW2vq/tL20Zf0lcGuKZ+7CDaxmnNeC2+SJg0OxUDop4Y+PADUR7?=
 =?iso-8859-1?Q?gCP6UbW5TU2goq04W6U=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(6049299003)(10070799003)(376014)(4053099003)(8096899003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?0Hw5PMql5GxZl5IZF+G3727tcsjH64qFVbj6An2AIOVUTG6YdtfOvLQbw9?=
 =?iso-8859-1?Q?ON6zmZN2fvHosFiM6+ZN80vGR4lPV1khtwElgmudowYY0pGDP6b5LA/Lik?=
 =?iso-8859-1?Q?X6ibbbihQnNI8izudydaxch0qT0sa6GrR+EXKIeEQReoMozX70czKP4M8H?=
 =?iso-8859-1?Q?DNNgKRklN6f3EMioAs+ktnUlfVvTbyICyBwoabrkSZRUpeLf1z7UsoWRzE?=
 =?iso-8859-1?Q?hjtbDws/FtEf+QauckRZ7tQumTKLN1E6Yf4vg7kHiKwJ2XZr8BBaQswEg0?=
 =?iso-8859-1?Q?+/Z9h7AzbggjTn+oHWNZXF7UYl2NfR2HfddMF5qyGpZ7urfuCwfeulBnMY?=
 =?iso-8859-1?Q?t3XrHbqlsppFLvo8Tpy+eETIqGXWMUnTNBXafN6BxSnuj0ZnbgpO08n+lr?=
 =?iso-8859-1?Q?Qr6tvEdMW9eHFlwb3f0SjngTQfNlmO8QpPUITIJoO0A8Iotfzqz3qKE9Ho?=
 =?iso-8859-1?Q?5GJqvNaKKBzt6MTVxqPOevLfviNW+nHv7/lso43cTdAsIvXPwUAGMuA6v9?=
 =?iso-8859-1?Q?8WnW+2cgBu0pqN17RRyFzCW11E/oE9HjyoDUt15CEGknfxlTnNqbIxJz74?=
 =?iso-8859-1?Q?VT++0DwCuhn6oXQ8j5XouXMdNLsxNg2mtk5ixpe1Ys9VgdlllSf6r2NXqo?=
 =?iso-8859-1?Q?aFEoymm9+leWVQh7iUg/WSwE8nA3fDbRw/GmbbT+a/RCxPSh/55BEkCjPA?=
 =?iso-8859-1?Q?AvTYKr4FDG5QiNroGuGSQJm5wYkzP30I87eceX5VMmIwuwX40uBC34yxn6?=
 =?iso-8859-1?Q?BbCyXAprOMPo3DrD3czc4GEkeFit3w3xanXRWVFon53OS5BhMhW+5Rbj6C?=
 =?iso-8859-1?Q?bH/okz40AwlR9FWiLuA0ej+ovKmRQ4iL31/SlGn4X6un6pxJt5Y3SAImbj?=
 =?iso-8859-1?Q?SoTXGCcvFa6iVonqYNbSlm3VrHBP/oe6wItCBRLl+xeuU/m4vAWKrzv8SM?=
 =?iso-8859-1?Q?aj56W999im7orqeYFXe7ylaZM77wDpSPqW30TAe7PMIJvayGX3G6ETaLOb?=
 =?iso-8859-1?Q?W2KG7UExYLxGtGU0Jhj7ZIfin6NFom0F7UEBQp7mVPDCYy7XvAAA78jKD+?=
 =?iso-8859-1?Q?K+QibNZ6B+WB5mBI9kpKV5NjlCgUtBCCS308GG5VFBXSAmBFVPJ2BOJsrz?=
 =?iso-8859-1?Q?SQ8+UduAmqAKmJAIXiw0P9hBpAd3FZeT/H8LlYQu6Uwg70DCHvBMJnXDaA?=
 =?iso-8859-1?Q?1XaiOsYwXiMgGhaoByVjw073EG2rU0TlMkCmHCYnrpEmewMUhMv9dLV2C8?=
 =?iso-8859-1?Q?jC3vbwfGpK8oQYJzP4dOVirJUGmgBVHmROA1J4v2AguNecGsLF2qU0joAF?=
 =?iso-8859-1?Q?4M2x34vE89k4kqji8mynN2S6WjCQ4yoXE36nr8h3pLmrsqxFP/Rf7KVIC1?=
 =?iso-8859-1?Q?gLfKTAlO08uOueb4h28UlY6wM01T9zbdPI5uzNg3ldfLKzfkge0xFlp9r6?=
 =?iso-8859-1?Q?B4v3oz9lIzxG89URFnIufMZC/zbywqXkW+CXn/enQLTtHB7UeRCzPAe8Do?=
 =?iso-8859-1?Q?3vMyaID5GiMOb8ODu3IJS6wq7jtWNMci1C2gGgjwNmA7KEALEq+qqU7BNS?=
 =?iso-8859-1?Q?JLvzKSAMRpwk4sqSKZ6ptxhLgfB9GMVTjk3ZHP4bKZ/QX/sH/3HbaZPnti?=
 =?iso-8859-1?Q?9Vul0g6cELiQUcTgRRkw/nEvrqgGHQdQ/O1QF2AZuGLlki9TJJ6HwhYbhQ?=
 =?iso-8859-1?Q?r5XF5iNa9BGo5jbmr/3uDLiCknl6+4fdK69JQMFKQrMmR+o8dIIJ95x7eO?=
 =?iso-8859-1?Q?qmphST4K+6Nyyqk7VLp4AW+ssBmnzQ4iC1vqB2xbfjy/vkO+on2qJ7gQdR?=
 =?iso-8859-1?Q?GAJaSraDCQcXO/d5kAOwx1j6UrAKIzVPRKYLXcmcFrBeXiynHWhWGmBn/N?=
 =?iso-8859-1?Q?Wq?=
x-ms-exchange-antispam-messagedata-1:
 D/w0+MKwuQ6Ra+C8eu0XiJFVrRESrVtW0oNhXeAkTfErLe4q1Qb5rxcJqH1upJQBCaEnQKuPNN8Hhg==
Content-Type: multipart/mixed;
	boundary="_004_MA0P287MB3082B2BA4E9D476168C4DB919F65AMA0P287MB3082INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd41961-6243-49ed-ad29-08de6815da3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 20:00:19.1468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xv8efELzyMJ/mw0OhHoEiewcltgvkxxapbZgccnQp6uCyi2p4MfyZCqMB0W2qHlfT2V+ueT7MB91PvGm4AgCvx0nZw1V4b/VvVRze+GcxCVYNtBfQ88tHCwvmRRevGJHUVeVBMnOMLdSvYBIRM0paA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB0164
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_MA0P287MB3082B2BA4E9D476168C4DB919F65AMA0P287MB3082INDP_
Content-Type: multipart/alternative;
	boundary="_000_MA0P287MB3082B2BA4E9D476168C4DB919F65AMA0P287MB3082INDP_"

--_000_MA0P287MB3082B2BA4E9D476168C4DB919F65AMA0P287MB3082INDP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

This patch restricts the export of the _alloca symbol to x86_64 and
intentionally omits it on AArch64.

On AArch64, attempting to export it results in a link-time failure
when building cygwin1.dll. Limiting the export to x86_64 avoids this
error and reflects the architecture-specific availability of _alloca.

Thanks & regards
Thirumalai Nagalingam

In-lined patch:

diff --git a/winsup/cygwin/x86_64/cygwin.din b/winsup/cygwin/x86_64/cygwin.=
din
index 228894623..dfd50a4c3 100644
--- a/winsup/cygwin/x86_64/cygwin.din
+++ b/winsup/cygwin/x86_64/cygwin.din
@@ -1,2 +1,4 @@
 # x86_64-specific exports
 # These symbols are only available on x86/x64 architectures
+
+_alloca =3D __alloca NOSIGFE
--



--_000_MA0P287MB3082B2BA4E9D476168C4DB919F65AMA0P287MB3082INDP_--

--_004_MA0P287MB3082B2BA4E9D476168C4DB919F65AMA0P287MB3082INDP_
Content-Type: application/octet-stream;
	name="0002-Cygwin-gendef-export-_alloca-only-on-x86_64.patch"
Content-Description: 0002-Cygwin-gendef-export-_alloca-only-on-x86_64.patch
Content-Disposition: attachment;
	filename="0002-Cygwin-gendef-export-_alloca-only-on-x86_64.patch"; size=870;
	creation-date="Mon, 09 Feb 2026 18:48:04 GMT";
	modification-date="Mon, 09 Feb 2026 18:48:11 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5M2ZkNDc5MzMxZTY5ODQ0ODFkMWQyNDRiMzI0ODkxNjcxMmM3ZTYz
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5h
Z2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJl
aW5jLmNvbT4KRGF0ZTogU3VuLCA4IEZlYiAyMDI2IDE3OjUzOjAxICswNTMw
ClN1YmplY3Q6IFtQQVRDSCAyLzJdIEN5Z3dpbjogZ2VuZGVmOiBleHBvcnQg
X2FsbG9jYSBvbmx5IG9uIHg4Nl82NAoKVGhlIF9hbGxvY2Egc3ltYm9sIGlz
IGV4cG9ydGVkIG9ubHkgb24geDg2XzY0IGFuZCBpcyBpbnRlbnRpb25hbGx5
Cm9taXR0ZWQgb24gQUFyY2g2NCB0byBwcmV2ZW50IGxpbmstdGltZSBlcnJv
cnMuCgpTaWduZWQtb2ZmLWJ5OiBUaGlydW1hbGFpIE5hZ2FsaW5nYW0gPHRo
aXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJlaW5jLmNvbT4KLS0t
CiB3aW5zdXAvY3lnd2luL3g4Nl82NC9jeWd3aW4uZGluIHwgMiArKwogMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3dp
bnN1cC9jeWd3aW4veDg2XzY0L2N5Z3dpbi5kaW4gYi93aW5zdXAvY3lnd2lu
L3g4Nl82NC9jeWd3aW4uZGluCmluZGV4IDIyODg5NDYyMy4uZGZkNTBhNGMz
IDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL3g4Nl82NC9jeWd3aW4uZGlu
CisrKyBiL3dpbnN1cC9jeWd3aW4veDg2XzY0L2N5Z3dpbi5kaW4KQEAgLTEs
MiArMSw0IEBACiAjIHg4Nl82NC1zcGVjaWZpYyBleHBvcnRzCiAjIFRoZXNl
IHN5bWJvbHMgYXJlIG9ubHkgYXZhaWxhYmxlIG9uIHg4Ni94NjQgYXJjaGl0
ZWN0dXJlcworCitfYWxsb2NhID0gX19hbGxvY2EgTk9TSUdGRQotLSAKMi41
My4wLndpbmRvd3MuMQoK

--_004_MA0P287MB3082B2BA4E9D476168C4DB919F65AMA0P287MB3082INDP_--
