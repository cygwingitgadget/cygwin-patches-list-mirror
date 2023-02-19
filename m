Return-Path: <SRS0=LP93=6P=hotmail.com=topmanufacturer17@sourceware.org>
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn20813.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::813])
	by sourceware.org (Postfix) with ESMTPS id 7A3E13858D32
	for <cygwin-patches@cygwin.com>; Sun, 19 Feb 2023 01:32:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7A3E13858D32
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGhghDXGDZVb+3dmkay7vj9deWhSemH5RjZDN35VXWrFa6KcBu9nXcwkAiOrrbNSdhm905+BPKDqXemoU3laCuLh6/YEgZj0sFtf+srxLgwmvAowrf+JvZsJMj/jBJcS+tz+R8KtgztqrZRD8ciGjL97HC36+XS9A05PWjLgI7FFD5S6IY5VB+GzmByIaPUFeICD1RHRTMDnmYe+K6AhCUTnuqxo8ZkulaEcCoA528Yt+B23b4lKygSh4tbGFsebSFmVukCRq+axeMV8gAZvbtPI0Im0scqLYYckQuyfw9AgdUM0tBOPa3i0xciTbKmS5jckJLLrXuqvZmk0m11OGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnyAt+B4Xq2SzNiWGeP6KgWys2S81hLGpRbTIuIsyPA=;
 b=FNjJa765709fRdA1nx3ah3jmg//bGOiI9WFQxpukQWTr3vWjhdorAGU2w5BVQfGJYTG/x8TO5VVzpPWD94oyhGynncnzoXiO4ZfSdNMEjo7xt3ISFNbsTUktKT/juG5mMA3VJCxWIyrxUyegbaSEvt5m6agZyA8JKDUMJAQeGWitibdHBf+BbDpNFvSU8Zv9KxMu2mugLGx7gNrMAlQmEo8lVd6pWcwlaeAKbadfHV4EYpLuYgGzFdvIiDtyurFsbkHMogejz9Bb477N41/D3pIl6zIGkE3JkLcDSzW9i2or091JJu256Efs5U2z6RIOWwrLrckwMPnXHm/bfQEdFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnyAt+B4Xq2SzNiWGeP6KgWys2S81hLGpRbTIuIsyPA=;
 b=B4rwMcB49O0EB0K0JN8sGJzohC5CVLwZrV11EYDqKOTfGc+s7zh0yL+aAWgp/shfmT87aJE+/ZmHhqv9BJ0dNZIfoKo05MpSCsX7GlhQnhJQGCvQpFLfuU76q0NHI4fia5/pKrX25u2DwYJX8oPRkHkxgmeoSPWzmUe+OITUDFbN3cKu8/HksJ7eM3sxNGIi4rrpFyVbxFPqfehVSrBdkhQ4oiZy/Bq2OeQZyXwBAMU9Ae322okIYfWiWtvHhocuvSRje5hxAcFfjUemFP7nigKhMnQqBDu+/Sboo/xMb4/RxbB2ztN/NlPG3OGqsN2T9ZnXtcxb35DrHOW8Jo+OdQ==
Received: from SG2PR04MB5745.apcprd04.prod.outlook.com (2603:1096:4:1d2::12)
 by SEZPR04MB6971.apcprd04.prod.outlook.com (2603:1096:101:e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Sun, 19 Feb
 2023 01:32:03 +0000
Received: from SG2PR04MB5745.apcprd04.prod.outlook.com
 ([fe80::4d17:624b:7785:557e]) by SG2PR04MB5745.apcprd04.prod.outlook.com
 ([fe80::4d17:624b:7785:557e%7]) with mapi id 15.20.6111.018; Sun, 19 Feb 2023
 01:32:03 +0000
From: top top <topmanufacturer17@hotmail.com>
Subject: Scales-Sales,
Thread-Topic: Scales-Sales,
Thread-Index: AQHZRAH4rl14bM93NUygug5qKpcsyg==
Date: Sun, 19 Feb 2023 01:32:03 +0000
Message-ID:
 <SG2PR04MB57450A6500CEE98101689B5BB5A79@SG2PR04MB5745.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-tmn: [5ZCnHoH+F+m2D1aFGMMXol3GXBOuxNmA]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR04MB5745:EE_|SEZPR04MB6971:EE_
x-ms-office365-filtering-correlation-id: 61883767-8e86-404f-a536-08db12191a9f
x-ms-exchange-slblob-mailprops:
 a0PI8jSoHUrsUJIeIUBuePO+h3yY3jpINAKK6dEIsBhIYWwnCZiowwWnl/d21DtKv14enCCryO3Hi5ROVP7c96HPkfsnuemfTTUpUdIlIh5qcyI9h0+u+LYX06v3usksefUWmGEA8sqVYYxQc6nMyfaogmHxLqwgR/Kb3qO+t27wHcGUHFVLm0nEbeHJIGnGgx/7kM3RRonIv4EnN98QAD2C82KXgm6eM46YuhFjQ5RTlSh3izQFIr50ZetY8RbDs7djpmxLwo/Qtx1wWPuomYkTZYjMTe9QEfTo7VqeuWQ4D8BrT929xkdaSAoaNOGiZ+p5W6mnxVz9LWT0eUSWA5lrK5Y9Ghhpr9r54ePj4xfGH5tbszA31+ptUwI7SHsgUZRm0UDlknLP5kfXM4qwAOJqY8zEfPTLW8k6/nAlcPoCec5baE9H7hx44jsB6DeLGTyi/O37BMAa8hq/LBo5+dqirRYkNYwdkesktIsbSzMXP7ofwm67Kh2s6t2gK0PeD0yBkMUoSi7wslTdlEpPYSS879NeDj5eV+JFd+Ag4cosxjulkVnMl2uMUNzcd8n2JlCHU7NE/X/OgU6FqThljA==
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ZLMXJRwdnuAzWJCUicRxkBmXx5edqMahkZ6syoClZ4GYU1tTjwgbiJw3prUVdb4JxDPFTHmtOM+QeeR1hWH7hR4qW/+Gu7kCgPSMJJ7dKUn/IbW2qqk8Gm02XM1Q1swhFl8ekStlWuMYxK1nU2uVPMPS2PKVTHC+UR9n8Q8eNMBW3l6gEYs5wQFzssnUKdhd3KkU4dSF5xZ+IfYWypHKI+yOMja+Encnma2eVCNOoJYfa/j3FnwRlXy685a37h6NMEYACj8z4gD8HSK/WGrvQzTc9WKj5dg/PIYtvtxtHN8i868zt5Kaf6yQrE6KNAcrSKal46Bxf42fbkq8Utd3WU3XdtXv2jpQh4Kov7WUUW7FH7asjcX1dnXcASmgAyzi9He7C5oWzEnKawt8vFJwsLSt/xjASML/c8ZdZq7HSwIC90vVG36RS+gOP2/wY2pCIjWzB5jCDWGEuSp0lGrG6UiJQFGSI8qJsDn2RO6vuB/94slY9VKft9W4id1hrVcwfjkHxFrt1SkE+Z4MY+zd+NTJFHthOu2NYmuozopLfeoPQ9U6U151BrXuM7zRsCBaSk+HRtfC8071AelTcbYLitpuBgInHfNYiYZ+nUKspxA=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?azhQMjU1d1NtWkVwd1NOcnFWMG4xbzAzSGtQNFM4MGxaV0Q0UnRqbCs4d1Jq?=
 =?gb2312?B?Zyt6QmhjQkJEbjdjd2hzN2IrRFFrUjBUTVRBU05qdnF0Wnl4SVR2SW1pWE14?=
 =?gb2312?B?NVQ5SmdmUjVnNWdrOVJST0NqWkI1Zzl5OUhDVWZCVUp1L1krYkpzdWJHczB2?=
 =?gb2312?B?L3hyTWl3dWVtMDFGMjB6SDBRbzN3amNZVHRBa2xJL2Z2cTVGcWlWSjV3ejU4?=
 =?gb2312?B?SFpzYXZsNEg1bHVMTGxrRnZNMnhzb2RSYTVDbzFFOE5UQ0J6ZWJDZTVBUkZG?=
 =?gb2312?B?MEZWZitpR253WHNIdUxaa0tveHdESGlpNzhqSzlzRWFTMzZBQWNDS2ZaU2tp?=
 =?gb2312?B?QTZSSTZKMGZ4R0pONzZPOWVUcy8yWHpJWFhBR1JQS3dEbVdVNHlBMHBZbDk2?=
 =?gb2312?B?ODBOSWREdkhzd3lIdkxWQzRqc3cxcXFqSUIrSnNJUW9BQUQ4RTk0eUxpQkpj?=
 =?gb2312?B?SGhQbG9nZDhwSUxoby9YNy84V1lVb0taaGJicHJhQ3hXM3NDVmoxYWIzL2px?=
 =?gb2312?B?ekdkWjBFcFF3bjlpQkx2NldjbmRrUXJUaTVIQnYrU1ZGV3UvajN0NC9IZ2VL?=
 =?gb2312?B?SHU0NU8yN3p2Z2tuUFBJVkVNaHgzYjJPV0s5YmxvT2pjWVVFdFJWNVJmMmtn?=
 =?gb2312?B?S2VvMk55SG5WbkY1a0gyQW1tK0FZdE9NUG9pR3JzWWNXWjhUVzVXVCtBSXla?=
 =?gb2312?B?eDZGS1FEV0M2V1V3Q09SOEpKUWNlYlhQZG1PQWwxSDJrdEh4WG9nUnN5SFBZ?=
 =?gb2312?B?em9nVGI4S2l2YjFKRTNQZm9RM0JVS2haejRkandCdHc2eUJUYXBtL0dHNHcy?=
 =?gb2312?B?dGc5L0RNS1NscVh5UEIwbjV3S0w4YnY4eWxHajBEcUQxT1lWMVJhV2tzY2tJ?=
 =?gb2312?B?RTBWaXFXckdqamZ2dStKMDNWWnJ6MzUzYk5YMHlEQ2UrOG55WXpXTzYyZGhi?=
 =?gb2312?B?TVY4S1BUU2htblZkci9PamdLWXRjODY2VlJMMGtxSjJhYVI2Uk56Tmo4Smww?=
 =?gb2312?B?eHcwaEFqdzNNRm9XQW9DZGc2S25PZjVlNXZ5eGl1dUlvM2hHZ2VQNFU2WUg4?=
 =?gb2312?B?TXVPRFU1SXE3YjdmUGlRWU55K0NsODR5M2hqQzNZNnB5dkdENFE4b09VODZo?=
 =?gb2312?B?b2VFNVQxa1NGT1Q0LzFVcnNUMmpXdVNpVkRkL1FmcUFaWE9EOGZWbnZpZjAx?=
 =?gb2312?B?NDlGaTJVTXhGWWVxR2ZuZG1zS2N4LzdkNlZkWHNRRzhPM1h3MlJ2OTJEbEh1?=
 =?gb2312?B?S2ZIKzNnemVKa2dVbWRCVHVVTTBCVHhQOXArMktMUjk5N2RTMS9HZHpzZWxN?=
 =?gb2312?B?SXpGa1k2SW1FMlQyTE1jeWxkdFRrdnVINUNmb2t0alFYOGZUMW0rQWFkRldP?=
 =?gb2312?B?RlFaOWI1c0ZoWjV1bVJTVnpvTXdHWDhaYkJKbUt2QlZLUDBUa3FsZTlnRGZF?=
 =?gb2312?B?dERLY2hTL2pkRUREcnhBV1BUZExrcnNPOU8waG9iUVk1Y2VaendhMjJtSFJY?=
 =?gb2312?B?aWRha2lkV2t3emFVSmFNL1pDUEhMTFlxOVdINmllWDdwbDdxYjZaQVN4OXF6?=
 =?gb2312?B?amxyWC9KMDE2d0VwUFF0aUNFZVBRR2NBclQ0ZzI0TndXeWlRYzFMd1N1YWpV?=
 =?gb2312?B?aStZazJSUmxSZ2s1V3pES3ROdXgzRmNZNW9ISkVUUlRJek9ESWVmenVuUXZM?=
 =?gb2312?B?MDlmbDBXSVQ4WU94TWdhTmxOWm9JaGFtbWt0SzRrTXQ1UFNvUkJHYjVRPT0=?=
Content-Type: multipart/alternative;
	boundary="_000_SG2PR04MB57450A6500CEE98101689B5BB5A79SG2PR04MB5745apcp_"
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6ea25.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR04MB5745.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 61883767-8e86-404f-a536-08db12191a9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2023 01:32:03.2573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6971
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HTML_MESSAGE,MALFORMED_FREEMAIL,MISSING_HEADERS,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_000_SG2PR04MB57450A6500CEE98101689B5BB5A79SG2PR04MB5745apcp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SGkgVGhlcmUsDQpHb29kIGRheSENClRoaXMgaXMgQW5keSBmcm9tIENoaW5h
LCBhIFNjYWxlcyBtYW51ZmFjdHVyZXIgaW4gQ2hpbmEsDQpBYm91dCB5b3Ug
YXJlIGluIHRoZSBzYW1lIG1hcmtldCwgSSB0aG91Z2h0IHRoZXJlIG1pZ2h0
IGJlIGEgZ29vZCBmaXQgZm9yIHlvdXIgYnVzaW5lc3MuDQpXZSBoYXZlIHRo
ZSBnb29kIHF1YWxpdHkgcHJvZHVjdHMgc2VsbGluZyBtZWdhIHByb21vdGlv
biBwcmljZS4NCg0KV2VsY29tZSB0byBlbnF1aXJ5LiBJIHdpbGwgYWZ0ZXIg
Z2V0dGluZyB0aGUgaW5mb3JtYXRpb24sIHNlbmQgeW91IGEgYmVzdCBwcmlj
ZS4NCg0KV2l0aCBteSBiZXN0IHJlZ2FyZHMsDQpBbmR5DQo=

--_000_SG2PR04MB57450A6500CEE98101689B5BB5A79SG2PR04MB5745apcp_--
