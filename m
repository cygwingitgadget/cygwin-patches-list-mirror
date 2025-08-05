Return-Path: <SRS0=/fsN=2R=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c408::3])
	by sourceware.org (Postfix) with ESMTPS id B28A5385AC35
	for <cygwin-patches@cygwin.com>; Tue,  5 Aug 2025 19:05:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B28A5385AC35
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B28A5385AC35
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c408::3
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1754420756; cv=pass;
	b=RShe+He7EkqAJervggQ0kjus2YN1oavZqr7eYBr/6VqTmdga2J55jUgav0/TuqPMkWX+TtB7J9kylcE1OAqc+KIL0VYBCJn5xGmiZDyR12NT6+aWDyUTbkv0jHY7SyEeTjT7/btjyS+fTzNoMOBHJuBq14Ar4gYYtoQcqPsi6m0=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1754420756; c=relaxed/simple;
	bh=taKHn0QQx3dlIRCyZkwzD/TyVkTz1JwOq6Zjivb5Atg=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=fq4wHU1pisHWzYwsbzVeoDksI4sM73orohjtdQPpxwXqlBlV2YZ8ASVn43/NrjiCmooyUxpBN7jiq2Y3TZeFXf1hDvHy9CwuM2OKXmOv/bjlu6c+pfuCm1rYdo9lVmhhPxr1TeJxAYUBQSa75QWGt9nG60Pvg11pf0KaYFjlNTE=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B28A5385AC35
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=BPRtcmvN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HKpyJjfRrs3BTiUL6I1umn1XjOq+yBuyLRuD1w1NhoYN9YSkiZZjtzxmlLDRwlEmBy1JwWIGT1P+QkfgFYRa9H5FPzIZETEYemQ6xSBAKJltNTUNZ/4Y5s1YD7GNtnnsQsVwhWOD4eIqwwtB3O+Z1FfFnbjs74G+sdOMtyHPQl4YH9ukxHLWjA0/nnnNr9QuBOpi11d/IGInPCZuh/GrAHgJ6bGx/OnP5HtawPRN5HIk4NUiFuJEvC3u3r1IV0XvuzfOXiCEfk4fOHxhMhD9nKCyuI64Zicg5AiZPEcaRNhEe7v2hbZ0xm8v7XIFlE84oT/U159Vb7rM+3IjrzrPhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQc0wdpx4vcIC+nbYoYIpT5strTdnWZTB9AYJRJsNM4=;
 b=GCKnymsmn53IXDVrxp52mQV74VidKG10t50BFDySfufsS20UWpMliE8wE/KvnSTiDaWCGOFotZD/PZlT80ItiE4qMl9GxLMShG55SUfDe+A1G1VS/une3XkBMixWXRDn09PVnoH2Efi7BzISbdAaVTrMTcZ+DCB6iQQNTf+gG2/7aDSzdWB8MwG3v7p9Iqd9Dvi8c0EFZqwpgdQNdoON/2Z1szZIXx4sPlEzvHBnc4w9+CL0DqE4mTxpZ6mejvtZfYvOOcPmT128xN8gimiadmQMsgGhMTLFxb2d3c5YJX2b+enIgNZpihT9DZaw5siLSt0H5AlcAt8lFIuGxdDCMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQc0wdpx4vcIC+nbYoYIpT5strTdnWZTB9AYJRJsNM4=;
 b=BPRtcmvNA1AXwWNAc/k1CZAtW5U9bkY5Pm6YxPTy5IyGxSuIl2nhNOS1J1eefg98+W+AiMjLlrrsWGrPIUQVlMmFdfq+Gsi+Hbqhhenee1cLQYey7V10b/h6yKwSfC9iCj3uKdvV8caq4ZV/PN0+IK7PFruzfsDEo8lPYt6E1OdNTrKnL78XE9S5a7MrcXmUMegciDAXquypFy0foAoJ4Z56KWCJgZbK6Kbn3xWH7GEeR8XzyYH81ajdq+T7uaDvqx0NSBQmldzbOSuX4rC9qPUDJ2XKc2CEv0mXAyQzzpXwI14EuRfmUY0m5w5gA8hYoyozZ2Baas7+9e/m9GKwpw==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by PN0P287MB1047.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:143::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Tue, 5 Aug
 2025 19:05:51 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362%7]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 19:05:51 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: math: Add AArch64 support for sqrt()
Thread-Topic: [PATCH] Cygwin: math: Add AArch64 support for sqrt()
Thread-Index: AdwGO9GU5J7yKW8lTTmp+dxkBwCoIA==
Date: Tue, 5 Aug 2025 19:05:51 +0000
Message-ID:
 <MA0P287MB308276F1ACA00942D9BEAE6D9F22A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|PN0P287MB1047:EE_
x-ms-office365-filtering-correlation-id: 0a2cc814-6483-496c-0e92-08ddd4531898
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|8096899003|38070700018|4053099003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?q/vVe3OwTYU80dAemuR1lmQcX52YURW5nO/tJpYNmuPpl7YcutaonQJOznqH?=
 =?us-ascii?Q?nmRpDbsoJN97ZDhcsd7ToODODwk0JA9O416+OFflI3nyvkzSPDZ15t7WecuZ?=
 =?us-ascii?Q?8jyQFtWJSbe1trPA5QtXWcOHyZRXgdhQhiq2S4EM7wXAuWWLM2PTf7/1c1NL?=
 =?us-ascii?Q?9oMuPGY2UXn62tee4wb+m9zrYCyX9F57l+KXBH1sihX6ZsFpqQT0Zx15TlIP?=
 =?us-ascii?Q?lLRFKKCcrgw8QFMO21jkdnMWO7F/pRYAMHcUujuZkZxm/9f5B3FXbxFrhBtQ?=
 =?us-ascii?Q?57yQ0OdFleJEUFKBaxVW5Cr86NpCDb/LLJL38dJk8qRo0cCmHmZN5fYbwlKd?=
 =?us-ascii?Q?uMloSq7wrXKcWyQpfA2olO8YrNDeQ+COOxL14LQa+EsUchYs7/6X5CEZpa1m?=
 =?us-ascii?Q?/RRqtH7Ygt9IbYNkIE7BYBdkhMlLmmhy2jTM6djH4q69HvQmGPfRhgvdfiNr?=
 =?us-ascii?Q?x0/ejzD6jUmMCDltgdpYfXHtNwBFaAmD+EIpqfe2lYEYaBXxzp0N+VbLvHyq?=
 =?us-ascii?Q?XpsWzlAeeMfhsTuzN6NywsYCYRrbv7vddlhvLodxxqaXQ9QiVpI/5wZWowRK?=
 =?us-ascii?Q?clj/b0H5cNs1vps5TRHZbTTByO+b2bPPXcFjbc4/+Mv2jN4MmM49qF+/M/q8?=
 =?us-ascii?Q?WFMIbGpym4STufciFTHTCfD2RhrvQLOgsGAcvhBnHO++zwNlFrd+Yui4VvWC?=
 =?us-ascii?Q?Y2vey+GJwTmeh9ouWRQVrRXAywE0UqZewgJ7ohNaFmdBJrOS3OSO5cbMpB/9?=
 =?us-ascii?Q?R/dkYo3C/GcxPzSVVcLGMya6jBAIzuN5aeDh5yxbzfp2jAJXS9yYopDi2Kxl?=
 =?us-ascii?Q?XaClel4EmBu9A+FhgplSdu1RXA/JjZf/qjuGPJVfU7XXU94GEr2wVa+yGxMf?=
 =?us-ascii?Q?EutydKHlBcJX04xpOPo+cbFZ5zt3ycQmAbbv2OFZu0rtUpx7GZt1Qp5NWUZ8?=
 =?us-ascii?Q?oJSgYf0jbKl7NfK9WR8ZMGjyqUWFggv8trQ6V9xIHIieYhyX8CJW88cM8ayB?=
 =?us-ascii?Q?d7HJtl4QBJmmd/izKS7aQ04v6x37SmLW9kDmWSjrZX+yNBkZbpgyuyWH3vLC?=
 =?us-ascii?Q?aK8KyqRTtCpIEcH9kt1wunV5Fer/GSutBiX2i2bzp4HjdUUtlyUkKsv1MfrM?=
 =?us-ascii?Q?+iNrL/bbIwEx+S1msqtGfTWc2ZeD+qgFWEtwU4YxvEHIrCeR2bL2yzgqI3N9?=
 =?us-ascii?Q?adCH3B9/ox5M9w//7TOcsNygW4C+lpA0gqwe8NEsf8q8byQ0SXhOPQCmvJdZ?=
 =?us-ascii?Q?yc44uPP0Z3UMk5N+bQIPwV84rpGXx9NwSWbhasn0jDIPX3dT7Hq9KxvfYwxj?=
 =?us-ascii?Q?VDHtpCJgKPaUsWgwzE/daSsor8Y+szE9ZmHkfbR10jnkNNaX6+IoVgqSeifA?=
 =?us-ascii?Q?D3BjxTIsPyjzuyzvMcjsyD2cdQGjm5KFVPMkvebK43IalYgGMJoGZkUer9yT?=
 =?us-ascii?Q?oRLOfWnQDV9mSvKbfmJUeeq5cdI5CcJB+Juszkm5YxSSsXOo52vrmQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(38070700018)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Z/G0aXbSzLt7WZ/0Ez8S3te7eisgeZB45Avq2VJqBWR86/JLnJSC1z4RAkAe?=
 =?us-ascii?Q?IuCybc0cYvn1vfKYeOtQfH/zWun1BKRoFy3uwYwgbBvPwRqTv8YvBHRqFsyC?=
 =?us-ascii?Q?DL030EUoS7vtXbZLqRCQB+WIHRqkrx2OGxqP2loyapnHMivJqtTCCFG4J+X7?=
 =?us-ascii?Q?BnzFxnbId5mlTF0KkidnQgIxn5c03nDaRs8GBEZ2aGynTzh5RIHbnvquuXd7?=
 =?us-ascii?Q?7JJ3vcbX3dpw73fD7CFsSShlXHfkfKlFIZmXwigIGLT4NjnTjcxTWDNJ3qEr?=
 =?us-ascii?Q?v1B6UQBXoLJWCZ1JvW0TGb3Dl8PmmCtv5Zmq4f/HPGGY93nC3saK4pYiC74j?=
 =?us-ascii?Q?inbO2Y/IqsU2+LBOdHhvHbRtm5SSC2ZYSFfg1P5qLN5AqWnPD/DgRqWQ1U6W?=
 =?us-ascii?Q?wMZXngWVYaKDGp/QrUojn0PPJIGHqZFgStvL7jcPcE95U9Yk+b4wWNIOaIns?=
 =?us-ascii?Q?YHAqHoBLI/NeYolSdvkF3CzZhc0PuR/idmB+i0NiY/D3f2ylcxcvfRuz6it/?=
 =?us-ascii?Q?noCHC72xJHfXEyUSuZTr6E7GVoWv2nPvAk2wk49QMr13GZC1O/jG4MPx39Ub?=
 =?us-ascii?Q?xOs1sTMyAqTLVceWKKpX7WhQxGQcIJh+k3QS1r3gyG8ZM7TMwsXTTGKKdAX5?=
 =?us-ascii?Q?PJjnT7erngzt0YMjGdfOBc7iW6NICoe8sRspX9usb41s9mQwMQfTt9zP/QQ6?=
 =?us-ascii?Q?Ufg7PhvXq2nYph92hBxks82oC6+KFQsR7RMSz1dDfGc3mLOeabOUQagQ9Iia?=
 =?us-ascii?Q?u11vICHgEbN0k8um+PtCF1GL4m/u4QunJ3Qd8wmXWjZsArYPvXTs+of+nacn?=
 =?us-ascii?Q?7CUPRkJjNCv7ReP4w7RFp8qIo3CybqJxBMD3R7+8Hqqjh1FBNhlzygOdVKKF?=
 =?us-ascii?Q?ISmQWJz/ZU1Vnq1Eanb1FhPGn2w3AD/hpv/PlM55uWubfZR2wVAG7TP1i3iA?=
 =?us-ascii?Q?cMd3WsCt61AYv7M6IOYPAiTllw+XIvmMCVybqiOqr4HWEIkPPhju84Tg1txU?=
 =?us-ascii?Q?u/frzx9phGi3zGnzKOjPMqF3F5iQoslIU8hk8QDG4Iimxda7VlWwOd+a5dCQ?=
 =?us-ascii?Q?YPv2Jk1RLJJTLYizE2sVECJc3LgtsBEhdS5L3mmZOXcGATiE1yLQ59/Aid68?=
 =?us-ascii?Q?h8ULnWwi7CmlIZvGihrAozWzqZ90xDpDyCfHsli7wRsGs2I/GjJpgnUwbCTj?=
 =?us-ascii?Q?aERkjqqlk2Wccc1VCP7rQwdFY1mv0SZGcHSOgPmmJ06R2l7599KhWPl/IEAa?=
 =?us-ascii?Q?6+o+che82QcKYjLL0dH0NeWirQQen0eOCvMKXFwUmri/wcLpTf5bupz6Vw3t?=
 =?us-ascii?Q?vyCIb7ttvrLnQeVtWThl8CgufcoCnoRezE9UoqFHGtFio+SaujbRTj2jgSHb?=
 =?us-ascii?Q?UhIKBjsWhbDYBzMmAReSYD9RrGxEiU8ACsIWVq0JNUksF4dZ5TRlzcouKm3s?=
 =?us-ascii?Q?P5HQutcDTYNnhHX2A37eJ3PW1DWAHhy/TrN/06ccv6YmAI6WyqjjanKlaj+2?=
 =?us-ascii?Q?sdglUINQ1U3nTV44uAhauXspnDt0sLASD4k4yenhxKbDpXPS5AO/QHg00up7?=
 =?us-ascii?Q?IaQXVtKbeLFmGJQoeiXk10uL2Bb4deRkAHC55jGcn0/Ymj+VStvKziu4HOQ0?=
 =?us-ascii?Q?0hwQh1ej2SoMJlEiO4VxFQ8mVMN1WcyWleIKhh/HJX/w?=
Content-Type: multipart/mixed;
	boundary="_004_MA0P287MB308276F1ACA00942D9BEAE6D9F22AMA0P287MB3082INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2cc814-6483-496c-0e92-08ddd4531898
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 19:05:51.6381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S5ZzGUe2wUW2V5LXyHZOb4VuCJtqgq2AE1YcaeHZRV4d3C+naOIn7c2Fp9gmEWe4gKRv+TJdz9ptzb58T5phFKYpzOM1G61W/qhbzxV8wFVqGlmrf44XNtXvKiF+rHyvPiBlwNG6J5UZ53ECeu3tEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1047
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_MA0P287MB308276F1ACA00942D9BEAE6D9F22AMA0P287MB3082INDP_
Content-Type: multipart/alternative;
	boundary="_000_MA0P287MB308276F1ACA00942D9BEAE6D9F22AMA0P287MB3082INDP_"

--_000_MA0P287MB308276F1ACA00942D9BEAE6D9F22AMA0P287MB3082INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

This patch adds support for the `fsqrt` instruction on AArch64 platforms in=
 the `__FLT_ABI(sqrt)` implementation.

In-lined Patch:

=46rom aee895b4b7c4045dea64d1206731dc01d29c155c Mon Sep 17 00:00:00 2001
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
Date: Wed, 23 Jul 2025 00:37:09 -0700
Subject: [PATCH] Cygwin: math: Add AArch64 support for sqrt()

Extend `__FLT_ABI(sqrt)` implementation to support AArch64 using the
`fsqrt` instruction for double-precision floating point values.
This addition enables square root computation on 64-bit ARM platforms
improving compatibility and performance.

Signed-off-by: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewarein=
c.com>
---
 winsup/cygwin/math/sqrt.def.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/winsup/cygwin/math/sqrt.def.h b/winsup/cygwin/math/sqrt.def.h
index 3d1a00908..598614d3a 100644
--- a/winsup/cygwin/math/sqrt.def.h
+++ b/winsup/cygwin/math/sqrt.def.h
@@ -89,6 +89,8 @@ __FLT_ABI (sqrt) (__FLT_TYPE x)
   __fsqrt_internal(x);
 #elif defined(_X86_) || defined(__i386__) || defined(_AMD64_) || defined(_=
_x86_64__)
   asm volatile ("fsqrt" : "=3Dt" (res) : "0" (x));
+#elif defined(__aarch64__)
+  asm volatile ("fsqrt %d0, %d1" : "=3Dw"(res) : "w"(x));
 #else
 #error Not supported on your platform yet
 #endif
--
2.49.0.windows.1

Thanks,
Thirumalai Nagalingam



--_000_MA0P287MB308276F1ACA00942D9BEAE6D9F22AMA0P287MB3082INDP_--

--_004_MA0P287MB308276F1ACA00942D9BEAE6D9F22AMA0P287MB3082INDP_
Content-Type: application/octet-stream;
	name="0001-Cygwin-math-Add-AArch64-support-for-sqrt.patch"
Content-Description: 0001-Cygwin-math-Add-AArch64-support-for-sqrt.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-math-Add-AArch64-support-for-sqrt.patch"; size=1204;
	creation-date="Tue, 05 Aug 2025 18:58:41 GMT";
	modification-date="Tue, 05 Aug 2025 19:05:51 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhZWU4OTViNGI3YzQwNDVkZWE2NGQxMjA2NzMxZGMwMWQyOWMxNTVj
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5h
Z2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJl
aW5jLmNvbT4KRGF0ZTogV2VkLCAyMyBKdWwgMjAyNSAwMDozNzowOSAtMDcw
MApTdWJqZWN0OiBbUEFUQ0hdIEN5Z3dpbjogbWF0aDogQWRkIEFBcmNoNjQg
c3VwcG9ydCBmb3Igc3FydCgpCgpFeHRlbmQgYF9fRkxUX0FCSShzcXJ0KWAg
aW1wbGVtZW50YXRpb24gdG8gc3VwcG9ydCBBQXJjaDY0IHVzaW5nIHRoZQpg
ZnNxcnRgIGluc3RydWN0aW9uIGZvciBkb3VibGUtcHJlY2lzaW9uIGZsb2F0
aW5nIHBvaW50IHZhbHVlcy4KVGhpcyBhZGRpdGlvbiBlbmFibGVzIHNxdWFy
ZSByb290IGNvbXB1dGF0aW9uIG9uIDY0LWJpdCBBUk0gcGxhdGZvcm1zCmlt
cHJvdmluZyBjb21wYXRpYmlsaXR5IGFuZCBwZXJmb3JtYW5jZS4KClNpZ25l
ZC1vZmYtYnk6IFRoaXJ1bWFsYWkgTmFnYWxpbmdhbSA8dGhpcnVtYWxhaS5u
YWdhbGluZ2FtQG11bHRpY29yZXdhcmVpbmMuY29tPgotLS0KIHdpbnN1cC9j
eWd3aW4vbWF0aC9zcXJ0LmRlZi5oIHwgMiArKwogMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4v
bWF0aC9zcXJ0LmRlZi5oIGIvd2luc3VwL2N5Z3dpbi9tYXRoL3NxcnQuZGVm
LmgKaW5kZXggM2QxYTAwOTA4Li41OTg2MTRkM2EgMTAwNjQ0Ci0tLSBhL3dp
bnN1cC9jeWd3aW4vbWF0aC9zcXJ0LmRlZi5oCisrKyBiL3dpbnN1cC9jeWd3
aW4vbWF0aC9zcXJ0LmRlZi5oCkBAIC04OSw2ICs4OSw4IEBAIF9fRkxUX0FC
SSAoc3FydCkgKF9fRkxUX1RZUEUgeCkKICAgX19mc3FydF9pbnRlcm5hbCh4
KTsKICNlbGlmIGRlZmluZWQoX1g4Nl8pIHx8IGRlZmluZWQoX19pMzg2X18p
IHx8IGRlZmluZWQoX0FNRDY0XykgfHwgZGVmaW5lZChfX3g4Nl82NF9fKQog
ICBhc20gdm9sYXRpbGUgKCJmc3FydCIgOiAiPXQiIChyZXMpIDogIjAiICh4
KSk7CisjZWxpZiBkZWZpbmVkKF9fYWFyY2g2NF9fKQorICBhc20gdm9sYXRp
bGUgKCJmc3FydCAlZDAsICVkMSIgOiAiPXciKHJlcykgOiAidyIoeCkpOwog
I2Vsc2UKICNlcnJvciBOb3Qgc3VwcG9ydGVkIG9uIHlvdXIgcGxhdGZvcm0g
eWV0CiAjZW5kaWYKLS0gCjIuNDkuMC53aW5kb3dzLjEKCg==

--_004_MA0P287MB308276F1ACA00942D9BEAE6D9F22AMA0P287MB3082INDP_--
