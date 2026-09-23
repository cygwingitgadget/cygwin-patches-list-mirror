Return-Path: <SRS0=1tMQ=HP=arm.com=Mate.Dimand@sourceware.org>
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	by sourceware.org (Postfix) with ESMTPS id 8EDA44BB24DF
	for <cygwin-patches@cygwin.com>; Wed, 23 Sep 2026 08:16:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8EDA44BB24DF
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=arm.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8EDA44BB24DF
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c200::1
ARC-Seal: i=3; a=rsa-sha256; d=sourceware.org; s=key; t=1790151415; cv=pass;
	b=nG1G7xvqnvsU3dn/vdWqUBmqk0Rz5X1MSUODbf+Ki9O+z87SIzcQZ9hvs/ofF0dg4bNZEkAQPN9FTVq97ZdpRdnh9ZikQuwNNP0lTGDat2hR9p4OfUa67Z2wh9K4gfj9Jepkx63kSUA+q8VC2b7vZa7QXUpWj72oQm3eP7oqM0I=
ARC-Message-Signature: i=3; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790151415; c=relaxed/simple;
	bh=xUzWQOsGLL/JTX283lA9GVAdSTVzgYpIY/Aud7P+sPo=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Date:To:From:Subject:
	 MIME-Version; b=BjQD62qoY7h7egXY+LxR/K4cpOgMCQCcQnpUbWMSDBEQ58xDjhX8HHbad/N0XkNnqcFEICPrrJiFIh/nTsFqNuxSSnunveaRWfaiS0CfLPnKxN//QtbJnLeIE1hBoK+jBezYGMLLZ21sgLPTs9p2ShPqmTGkruOJ2uOjDY/KCk0=
ARC-Authentication-Results: i=3; sourceware.org; dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=A9D1tBXp; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=A9D1tBXp
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8EDA44BB24DF
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=A9D1tBXp;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=A9D1tBXp
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=JcwK8CWfXYLork1IDwD7XF9WIHx9i0NBic6gg8u8W01jHSf2dX9Og9ogYuLi/Ik9viwmLYt+OjhzjTJZSZrx2lGeo/5S9SfQmk3Yksgaz+ej9wPdAtuBhQ0Pyzz28A03VtCwC6XdvX4DOd7rIvhkc/EAXQKhCaDSl+oUL0+omrQpRnydybIdKHfM6AKQSqM/CXXij6y6z79zBuAQMUbOgbWFd1KZnowP8e7UBOeC+jtcvzTfZHyXBLNOPr1pN06SGoD4Hukf6gj1BbaauzNPO9Z/W/CtEnii/B5hRaSKtVtgwXn5wIXvWpm11pu+iPMdeZPbJRK+hzTW8NKPvp4Tqw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUzWQOsGLL/JTX283lA9GVAdSTVzgYpIY/Aud7P+sPo=;
 b=JzVDe0duzRUqzZhlUSHWnIhdw5YKtxDSKafJ3lL8D6d/lNkwuoQ++A+d6j/yj/0BWyJC7tUHVxSVM/VieY16uR6NO3UbEN/G+ludJ8ZtPGiIi9unj959dUKcYAo7kCoN4603hxLxfkVRdukNp5OhjjmFzZMA84YVh22Erbo+NaH9xksln+Blxf0pzBmAypeYJi+6CieQI2ioDnC2efxECv7zQsuO8wTRiLfvXcCFHUIRciGx6mRsG8NbVF5bZLRNLkf4jcvf9BUvjwCmL4L2uAd7vMT6s7L+rQ0gWD8KlJeMyLi3ElHEXGsGmIDabbfYyH2Pgjx4e+yzyPA0+Q42qQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=cygwin.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUzWQOsGLL/JTX283lA9GVAdSTVzgYpIY/Aud7P+sPo=;
 b=A9D1tBXpRkjBQwm0thU9IPmxyS1GpzqzQFx2mr90X9hRNnEtLQipm3BghD0stgWJJJPwzMUy+p/pC+D5oVKsU/8W3W4UrxgrRS+EM8JZNMnlh3WO7+yl4HUkDIqVoTqiLANXZXa1p+COYUIQMDiW/AZPBKTcgNDZgmSNHGCLbEE=
Received: from DUZPR01CA0150.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::7) by AS8PR08MB10004.eurprd08.prod.outlook.com
 (2603:10a6:20b:63d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 08:16:47 +0000
Received: from MAD0EPF000008A9.eurprd04.prod.outlook.com
 (2603:10a6:10:4bd:cafe::a7) by DUZPR01CA0150.outlook.office365.com
 (2603:10a6:10:4bd::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 08:16:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MAD0EPF000008A9.mail.protection.outlook.com (10.167.241.181) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Wed, 23 Sep 2026 08:16:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EDmiV13TFkmLd0eAuBVo6abaeWbuuRBxU1euJswKhI+f3csM6zOKm1U6yovAHQoZUmPAmpnQDGlUxbbLV9Y+yQ11zVDkeweFaF2vdZbOdgvGAU759rSEvDwKNitcaInq2YanG8XHVeOCjgspYnVPhHJPckSVxlMSsgQ+5d2WK7340i6Fvsc2C7o9SBy2MVT5q++BTFeC0Rg3nQczG+g2RebI3OBcO+/3EFkGVUs4+A+Nfo5xTobP1xgHTv6AJPzlyniln9DDXD/2LkL1vrPG0sf9eaf29i0rWXspQX3IxtTdM0y/QmAb+5dIoOrhEgg4oUfLUvh94FC1yetkZAYH5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUzWQOsGLL/JTX283lA9GVAdSTVzgYpIY/Aud7P+sPo=;
 b=le/9LXRgpnEHrDBv+1CPx3OnZDayHvW1jzo7a9fJHKTwrMHQKsSTWf8tmPJY1ef5R6coCkA++ij2UqN4U/ZAMGxSIeiz9KE592dazeetxSw/6md94nAlX1T1VBaIkJceXW9NWEoeF5KWSXmE5mlQMWlxStj89dxB7xJZgnNcaT/qWONq+J+UEjyvVzltZxLzXciQ393Q7dz9xBMMb4sTRZQfSOaellJ8FZEZ3g0gmqYP79orUy5PdrlqJo/aPZiidn/KZIg92H+9EvN9ZPfw6I5DZC7aHtxVFe/vCfOf+cN9Xqze8lhT1/mga/KKmFHW09ovuoelYJHRwk91KEH/cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUzWQOsGLL/JTX283lA9GVAdSTVzgYpIY/Aud7P+sPo=;
 b=A9D1tBXpRkjBQwm0thU9IPmxyS1GpzqzQFx2mr90X9hRNnEtLQipm3BghD0stgWJJJPwzMUy+p/pC+D5oVKsU/8W3W4UrxgrRS+EM8JZNMnlh3WO7+yl4HUkDIqVoTqiLANXZXa1p+COYUIQMDiW/AZPBKTcgNDZgmSNHGCLbEE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB4PR08MB9310.eurprd08.prod.outlook.com (2603:10a6:10:3f6::22)
 by AM8PR08MB5843.eurprd08.prod.outlook.com (2603:10a6:20b:1df::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 08:16:11 +0000
Received: from DB4PR08MB9310.eurprd08.prod.outlook.com
 ([fe80::73e6:2715:9ac4:e576]) by DB4PR08MB9310.eurprd08.prod.outlook.com
 ([fe80::73e6:2715:9ac4:e576%7]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 08:16:10 +0000
Content-Type: multipart/mixed; boundary="------------AY0OLSNcR800LhpMUZUC9O69"
Message-ID: <9eed0ee5-428c-420a-9788-67d14368f3b1@arm.com>
Date: Wed, 23 Sep 2026 10:16:06 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: cygwin-patches@cygwin.com
Cc: nd@arm.com
From: =?UTF-8?B?TcOhdMOpIERpbWFuZA==?= <mate.dimand@arm.com>
Subject: [PATCH] gendef: fix SEH directives in AArch64 sigdelayed
X-ClientProxiedBy: LO4P123CA0617.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::18) To DB4PR08MB9310.eurprd08.prod.outlook.com
 (2603:10a6:10:3f6::22)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB4PR08MB9310:EE_|AM8PR08MB5843:EE_|MAD0EPF000008A9:EE_|AS8PR08MB10004:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cfe432b-15a4-4e70-4a87-08df194b0201
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|6049299003|366016|4053099003|11063799006|5023799004|10067099003|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info-Original:
 afKeA0N5tZwNzlwIVf5z5sXEbKrWdow1pjkgpR8ckEO08myUQKlltmyL43xQ7M1yczqp+om08a7DYL83KpQYLRNmmiwFbeE6xSYKZwGy8aFZUIHwpNcgsnxad2nS5pZMdXfU7GCYjYMVV7M96ul304XO2PB/Z7cXsLEtU4c5JNBx3rCWex7z4jHvn12omCDT9ro8AoqRP2L+PkbXh+fK8pJa/sHS8NqiUJiYY0RUNBX/ripL5lrRqBycIk7g29CAMEZltCrKYLE9D62pFfdAGPzwlquFzdLYhraJ1K2RSBnMi2wrjRSEODQujL+edFxF0EfEG+ExEzWkjsHn9ZSlT/LONnZN3QM7l4O48VJIMJQ4Uks1a3MQXzS9TbyBWErXNJDHIpyZIYrXDwRpzQboS5SyqmkTz2bPueRyQC+gKaI=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB4PR08MB9310.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(6049299003)(366016)(4053099003)(11063799006)(5023799004)(10067099003)(56012099006)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 UEwPfGb7Y4tseFyj8U6P6cmN+ix8uw0T1N91WeQ0lVotJe62LNL09gzQXjJz3F/cplMcNJMHAA1T1Q0HHpP73z72GkQB8HU1oHQoC+vBAJiuSRfgCIcxjjxOpkIXz+Oj5b7dS6rQfHrF7UmjNNsT/G5DCm4uWuNDKcxlTtylEOwLiZA1zeqIfzwsC82xGNLUy8YRtJUwN54tOVChmV8HUR92VVgZev2hf3264FarJVGniJqQufROP8ttFRNLQIQQrXbYGOK0Jbp7ZlgxFCKH3qASpiM/HAvqJkj08EMOVwZLutrsmnsXnrwOOMRkyKbYNyw9g+pRachLm0oFWxShRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5843
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 MAD0EPF000008A9.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	759b872b-ae56-471d-3a7e-08df194aecfc
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|14060799003|376014|23010399003|6049299003|35042699022|4053099003|3023799007|10067099003|11063799006|56012099006|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info:
	X3AqiqkYAUpW+8IRqypFbSlkpzyf4VRqAOo8D195b865Jc+ZodmgKoDsB4dUso8RL5XF6YdAFEqDuGiE6nQ3mpWtgWXI7g2nnRPpSS3ocsXiWOQc0Y21s9eHfs8AqjmukkXikVXy/KwLpM5l6D91Fy1+ovdgleSWPsW+AeeKYNWUIqgyCiC1eYasbyfwJKQbdYmGhQaB/Qus+WLDTcZ9u7fdtSutTrSIdYy09j7VOVOehtu7diRNJGpYg2llTQYV9BOkAH+A+orD1IOQmgda/1yjVJQ18ED3k5Tq/DhRKwYu39ut4DAOUgRe/RJ77NOH4g+O4mTK8jj+tNKJRoiXu9DsHZaNhOt0EHsiKgUiaUhMSVX04maQPaLsJxxZwbpe4FJBU92UZhMlVbogtOs7zL57pCJC+5n+IGLMiCa+dvo8m3ga/BRTfAd9sO6tnj62
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(14060799003)(376014)(23010399003)(6049299003)(35042699022)(4053099003)(3023799007)(10067099003)(11063799006)(56012099006)(5023799004)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PUClznBTNa7reIucWmzEmpXYg+lTArW5nmhcDZNnKmfPMGeB2uU0r45Wb6HhF5LGJwv9stZIff/S+D7/mSB+HsAYHeF5e3QJsikg36rBUjGA2vbYZwl/O8DodUA1TkvnNj6EqVYeT3oyhAlFR3vs8D2yrA2ADnIzXIGX+TscsrA2rn07YQKrDAV6dol+Iu6oiDQpjMgGetsaSzGOqXYbhYvfU3kPSNSDPyVKNy/DuCCd68FrL+goyCu9gehRYStWXs6MJFXXDgHlGrYjeKFXYDRODCRuBZMDKeS4Z7HhiBtBacEV3NiFXjFS04jfgBR9UCAUEb9jCYlc0A1yNlY68+/hyk0GuPHYuZO/cjNWR+fegfbLX9mam26gooIT/G4+ocOzr0R05XDDea9GPJXc2vzDZKiwLQYgA6WDHAxptd796GdWHyovHEGRTYJu8iQz
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 08:16:45.6063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cfe432b-15a4-4e70-4a87-08df194b0201
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008A9.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10004
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--------------AY0OLSNcR800LhpMUZUC9O69
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


--------------AY0OLSNcR800LhpMUZUC9O69
Content-Type: text/plain; charset=UTF-8;
 name="0001-gendef-fix-SEH-directives-in-AArch64-sigdelayed.patch"
Content-Disposition: attachment;
 filename*0="0001-gendef-fix-SEH-directives-in-AArch64-sigdelayed.patch"
Content-Transfer-Encoding: base64

RnJvbSA5YzE0Yjk4Mzg5NGM0NzlmMjkwZWZkYzVkYjMwNjViMTQ5M2QyYWYyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/TT1DMz1BMXQ9QzM9QTk9MjBEaW1hbmQ/PSA8
bWF0ZS5kaW1hbmRAYXJtLmNvbT4KRGF0ZTogV2VkLCAxNiBTZXAgMjAyNiAxNTo1MjoxNiArMDIw
MApTdWJqZWN0OiBbUEFUQ0hdIGdlbmRlZjogZml4IFNFSCBkaXJlY3RpdmVzIGluIEFBcmNoNjQg
c2lnZGVsYXllZApNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IHRleHQvcGxhaW47IGNo
YXJzZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdAoKVGhlIGRpcmVjdGl2
ZSAuc2VoX3NhdmVfcmVncF94IHNob3VsZCBub3QgYmUgdXNlZCB3aXRoIHgxNiBvcgp4MTcgcmVn
aXN0ZXJzLiBUaGUgbmV3bHkgYWRkZWQgeDI5IGFuZCB4MzAgcHVzaCArIHRoZSBzYXZlX2ZwbHIK
ZGlyZWN0aXZlIGVuYWJsZXMgZnVsbCBzdGFjayB1bndpbmRpbmcuCgpDby1hdXRob3JlZCBieTog
RXZnZW55IEthcnBvdiA8ZXZnZW55LmthcnBvdkBhcm0uY29tPgpTaWduZWQtb2ZmLWJ5OiBNw6F0
w6kgRGltYW5kIDxtYXRlLmRpbWFuZEBhcm0uY29tPgotLS0KIHdpbnN1cC9jeWd3aW4vZXhjZXB0
aW9ucy5jYyAgfCAgNCArKy0tCiB3aW5zdXAvY3lnd2luL3NjcmlwdHMvZ2VuZGVmIHwgMTggKysr
KysrKysrKy0tLS0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDEwIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vZXhjZXB0aW9ucy5jYyBiL3dp
bnN1cC9jeWd3aW4vZXhjZXB0aW9ucy5jYwppbmRleCA0YzNmMjBjMTIuLjI5M2M0YzQ1YyAxMDA2
NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9leGNlcHRpb25zLmNjCisrKyBiL3dpbnN1cC9jeWd3aW4v
ZXhjZXB0aW9ucy5jYwpAQCAtOTkwLDcgKzk5MCw3IEBAIHNpZ2RlbGF5ZWRfaW5pdChQQ09OVEVY
VCBjdHgpCiAgIGNvbnN0IERXT1JENjQgc3RhY2tfeDE2ID0gc3BbMF07CiAgIGNvbnN0IERXT1JE
NjQgc3RhY2tfeDE3ID0gc3BbMV07CiAgIGNvbnN0IERXT1JENjQgc3RhY2tfeDAgPSBzcFsyXTsK
LSAgY29uc3QgRFdPUkQ2NCBzdGFja19sciA9IHNwWzNdOworICBjb25zdCBEV09SRDY0IHN0YWNr
X2xyID0gc3BbNV07CiAKICAgY3R4LT5YMTYgPSBzdGFja194MTY7IC8vIHgxNiBjbG9iYmVyZWQg
YnkgUnRsQ2FwdHVyZUNvbnRleHQKICAgY3R4LT5YMTcgPSBzdGFja194MTc7CkBAIC0xMDAyLDcg
KzEwMDIsNyBAQCBzaWdkZWxheWVkX2luaXQoUENPTlRFWFQgY3R4KQogICAgICBoYXBwZW5lZCB0
byBjaGFuZ2UuICovCiAgIHN0YXRpY19hc3NlcnQoc2l6ZW9mKENPTlRFWFQpID09IDB4MzkwKTsK
IAotICBjdHgtPlNwICs9IHNpemVvZihDT05URVhUKSArIDMyOyAvLyB1bmRvIHN0YWNrIHB1c2hl
cyBmcm9tIHNpZ2RlbGF5ZWQKKyAgY3R4LT5TcCArPSBzaXplb2YoQ09OVEVYVCkgKyA0ODsgLy8g
dW5kbyBzdGFjayBwdXNoZXMgZnJvbSBzaWdkZWxheWVkCiAKICAgX215X3Rscy5zaWdkZWxheWVk
X2ltcGwoY3R4KTsKIH0KZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vc2NyaXB0cy9nZW5kZWYg
Yi93aW5zdXAvY3lnd2luL3NjcmlwdHMvZ2VuZGVmCmluZGV4IDIzMzg0N2UxYS4uNzE1ODBjOWE3
IDEwMDc1NQotLS0gYS93aW5zdXAvY3lnd2luL3NjcmlwdHMvZ2VuZGVmCisrKyBiL3dpbnN1cC9j
eWd3aW4vc2NyaXB0cy9nZW5kZWYKQEAgLTQ2MSwyMyArNDYxLDI1IEBAIF9zaWdiZToKIAkuZ2xv
YmFsCXNpZ2RlbGF5ZWQKIAkuc2VoX3Byb2Mgc2lnZGVsYXllZAogc2lnZGVsYXllZDoKLQlzdWIJ
c3AsCXNwLAkweDM5MCAJLy8gc2l6ZW9mKEFSTTY0X05UX0NPTlRFWFQpCi0JLnNlaF9zdGFja2Fs
bG9jIDB4MzkwCi0Jc3RwCXgwLAl4MzAsCVtzcCwgIy0xNl0hCisJc3ViCXNwLAlzcCwJMHgzQzAg
CS8vIHNpemVvZihBUk02NF9OVF9DT05URVhUKSArIDQ4CisJLnNlaF9zdGFja2FsbG9jIDB4M0Mw
CisJc3RwCXgyOSwJeDMwLAlbc3AsICMzMl0KKwkuc2VoX3NhdmVfZnBscl94IDMyCisJLnNlaF9l
bmRwcm9sb2d1ZQorCisJc3RyCXgwLAlbc3AsICMxNl0KIAogCS8vIHgxNiBnZXRzIGNsb2JiZXJl
ZCBhZnRlciBjYWxsaW5nIFJ0bENhcHR1cmVDb250ZXh0LgogCS8vIEJvdGggeDE2IGFuZCB4MTcg
YXJlIGNvbnNpZGVyZWQgdm9sYXRpbGUgcmVnaXN0ZXJzLCBzbyB3ZSBwcmVzZXJ2ZSBib3RoLgot
CXN0cAl4MTYsCXgxNywJW3NwLCAjLTE2XSEKLQkuc2VoX3NhdmVfcmVncF94IHgxNiwgMTYKLQku
c2VoX2VuZHByb2xvZ3VlCisJc3RwCXgxNiwJeDE3LAlbc3BdCiAKIAkvLyBSdGxDYXB0dXJlQ29u
dGV4dCBjYXB0dXJlcyB0aGUgY3VycmVudCBDUFUgc3RhdGUKIAkvLyBhdCB0aGUgdGltZSBvZiBj
YWxsaW5nIGl0LCBsZXR0aW5nIHVzIHJlc3RvcmUgaXQKIAkvLyBsYXRlciB3aXRoIGFkanVzdGVk
IHJlZ2lzdGVycyBpbiBzaWdkZWxheWVkX2ltcGwuCi0JYWRkCXgwLAlzcCwJMzIJCS8vIHNldCB4
MCB0byB0aGUgc3RhY2sgc3BhY2UgYWxsb2NhdGVkIGZvciB0aGUgY29udGV4dAorCWFkZAl4MCwJ
c3AsCTQ4CQkvLyBzZXQgeDAgdG8gdGhlIHN0YWNrIHNwYWNlIGFsbG9jYXRlZCBmb3IgdGhlIGNv
bnRleHQKIAlibCBSdGxDYXB0dXJlQ29udGV4dAogCi0JYWRkCXgwLAlzcCwJMzIJCS8vIHJlc2V0
IHgwIGluIGNhc2UgaXQgZ290IGNsb2JiZXJlZAorCWFkZAl4MCwJc3AsCTQ4CQkvLyByZXNldCB4
MCBpbiBjYXNlIGl0IGdvdCBjbG9iYmVyZWQKIAlibCBzaWdkZWxheWVkX2luaXQKIAogCS8vIHVu
cmVhY2hhYmxlCi0tIAoyLjU0LjAgKEFwcGxlIEdpdC0xNTcpCgo=

--------------AY0OLSNcR800LhpMUZUC9O69--
