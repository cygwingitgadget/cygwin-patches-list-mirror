Return-Path: <SRS0=yPnT=AQ=arm.com=Igor.Podgainoi@sourceware.org>
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	by sourceware.org (Postfix) with ESMTPS id A4E134BA2E0F
	for <cygwin-patches@cygwin.com>; Thu, 12 Feb 2026 16:27:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A4E134BA2E0F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=arm.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A4E134BA2E0F
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c201::1
ARC-Seal: i=3; a=rsa-sha256; d=sourceware.org; s=key; t=1770913674; cv=pass;
	b=Q3zzM1bmGTXXWG/XkalhqBA55/egNvFckN/udr128OR8cv1768dilWcRNPMnDkOqL8QE2Upj3k6+wccdl4ayXqlaF7glq8eKOphyHbncUK6WQcJy0VFV+1dbQW6RMe0CPanTBv22OH4JY/Z8JudVjaxlI9eQI9P0SIgIJik8ef4=
ARC-Message-Signature: i=3; a=rsa-sha256; d=sourceware.org; s=key;
	t=1770913674; c=relaxed/simple;
	bh=xBrjzz83+pfIDPuliCS1DH8Bv3hyeStq94/GzjDzzJM=;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version; b=g4ljpr/l4AUXwMd7qQpaP3s6DHkz/zhCHNnCXugiogs9J2EWg9p21BzktfJ3r0Ar6sHEffl8LOlyfq69ov79GuKqAfEqMajsv4wCryZ1TqAn1Ttcfp8TvFHPR3XMXXFaiGIfXhA3n/ZfQWlqc0MZWAJC/BNWwpLG4liiNTfhG9E=
ARC-Authentication-Results: i=3; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A4E134BA2E0F
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=g/i+I1FQ;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=g/i+I1FQ
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Xso9gRvw8ZQdYNLNIgCG5P/VCtOKuLdzNCHaWRGqPFecVaWZAv1alYjcTi1VGLMVxf6C5ASh31++bRMsacR4WCRUKjotqM7RDPsgWjGwd9nZ3ZPzx3xG5otdwI9X17RBPF+2ItYYMVR6gyeuYCMf2WO7gLIgu4bgmpUdnhAy7m18RGQWR1+vnKb3CyffTiZxpJuInf/ayWxrVhsllsaEatDzzANdavzOsIbIXpPanUQ15SND1Soj3G7xXiDkn4wClVHGVUoQ5kmzAL1R7RkK5+EFgnIpzSogLuOpJXzWaJAtNnv4DRmGDtAKRSRvTkAiJMJVebUmUelvBE8I3+jAhw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBrjzz83+pfIDPuliCS1DH8Bv3hyeStq94/GzjDzzJM=;
 b=bwqT2CGVD6qNm1Pti6ibsCPY91QDrkYtY7+Jdo4UdoL0a6vIZHcMLtLLDcsn6XTsv6jmjfmlBRWkngWkcKgHxALmFnG7kQlmMnLjjC1G/1D/NtgYqHUfgySK+znpjyuq8vaiP8hdouJJMW/rhQ05bYhkLur2gWGZidqH4yrUFbNtZJ1Q8pF6DyqA1kTDk5qdLBQBHTxlPDfRHPmlCFJhAh+wiCu3w1zDaMhOIZ8j46PkWs40wEcPA38+RAVqGDL5sKxmScopGtHrKpBAV0asHTiK3beeqmMdXc+HpWjWDLrTxf7OFxo2BzKensKi2f49VPOslnAZiJsXKB0t/LDuUQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=cygwin.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBrjzz83+pfIDPuliCS1DH8Bv3hyeStq94/GzjDzzJM=;
 b=g/i+I1FQ3xzLIgnVOOxMRC6hhZflABUWk5bd/EQltkvvoftZKSLRenUPP2LjRowd32K98NzEp86FxdX21hjG22XUu+KOIhiT11wCSJUmRlBxlK9ASevdlWmRyg4hs9rlGhddo+a4MAMIL1eq+C7PHJrQXmVrL3VYqAD++0jjtO4=
Received: from AM6P191CA0002.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8b::15)
 by PAVPR08MB9770.eurprd08.prod.outlook.com (2603:10a6:102:31e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 16:27:47 +0000
Received: from AM3PEPF0000A78F.eurprd04.prod.outlook.com (2603:10a6:209:8b::4)
 by AM6P191CA0002.outlook.office365.com (2603:10a6:209:8b::15) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.10
 via Frontend Transport; Thu, 12 Feb 2026 16:27:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A78F.mail.protection.outlook.com (10.167.16.118) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8
 via Frontend Transport; Thu, 12 Feb 2026 16:27:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A6iroLGPmrlMr6E4qAw6jYLH8f+ZLDUEI+XtVfAiViXr/8ZS4/Qd3FHizwPS+mSN5QYQ9Ht9MhP7fVkoqVt8MjkMCxRJi50uYfAFAVhV9eKEbcJWw8yEVkgrSQ5wWR+GdpJ61iCviSQvPKkWJhqQ8Qk5cRpZIqEI3XBakTsUhuV77AZgjRJu2nUiTaDI0ACk5oFlSNyZFgOtMvpyj/MzdJkCM8Qq3bOCwSPJ0zmcVA4hJU7/SrZU9bblMT7Xcmi9FIdxPtTOUv84p8XstH5g5QM1x9WCReAlpSpTlufINh/zPXWi17maGptPmS3a1pJbZICALMbvwi8gUMOPZM+nfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBrjzz83+pfIDPuliCS1DH8Bv3hyeStq94/GzjDzzJM=;
 b=Lb9Qfw1S8MWZen6Y2B3WkT4irLWMjK0N1NgLuzTQOZGdrRO0MCySqO+FbzOc8O/G3Jsz77d76WUIFKHzQwMiUy07L/o8ZSfYQ1mjlZhyJwyU+pKcgNgnMlqCrOodDuYURGokZG0CXSnGWuTZu9wb7dFsoUFfBcPt54wdyR6yXcOSLSavQdut6I63DtPLp4+pQxRvDk7F2CQ+si6DJca7Yq3d40BtzKmy3NM7BEx1ikSERf2f0ptf7yRDsa7A8nwV87YgRi80JoDQRh84kvwucrCqwhVMw882VnjPL3CR0x7K5+ibZYmWlfaD5QyycG9ArzjbEO98Qu6/ZuJC5IX0KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBrjzz83+pfIDPuliCS1DH8Bv3hyeStq94/GzjDzzJM=;
 b=g/i+I1FQ3xzLIgnVOOxMRC6hhZflABUWk5bd/EQltkvvoftZKSLRenUPP2LjRowd32K98NzEp86FxdX21hjG22XUu+KOIhiT11wCSJUmRlBxlK9ASevdlWmRyg4hs9rlGhddo+a4MAMIL1eq+C7PHJrQXmVrL3VYqAD++0jjtO4=
Received: from PAXPR08MB7247.eurprd08.prod.outlook.com (2603:10a6:102:212::7)
 by DB9PR08MB9947.eurprd08.prod.outlook.com (2603:10a6:10:3d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Thu, 12 Feb
 2026 16:26:44 +0000
Received: from PAXPR08MB7247.eurprd08.prod.outlook.com
 ([fe80::e2f7:f38e:3321:44fe]) by PAXPR08MB7247.eurprd08.prod.outlook.com
 ([fe80::e2f7:f38e:3321:44fe%5]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 16:26:44 +0000
From: Igor Podgainoi <Igor.Podgainoi@arm.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: nd <nd@arm.com>
Subject: [PATCH] Cygwin: configure: disable High Entropy VA (64-bit ASLR) on
 AArch64
Thread-Topic: [PATCH] Cygwin: configure: disable High Entropy VA (64-bit ASLR)
 on AArch64
Thread-Index: AQHcnDxgZiKDVx/wu06MNi+K7oeOMw==
Date: Thu, 12 Feb 2026 16:26:43 +0000
Message-ID: <aY3_QASxmA5tGa7u@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	PAXPR08MB7247:EE_|DB9PR08MB9947:EE_|AM3PEPF0000A78F:EE_|PAVPR08MB9770:EE_
X-MS-Office365-Filtering-Correlation-Id: d1ba320a-3470-4aa2-b5f8-08de6a53a892
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?dURDWDVSb2pVUXRnVTdFSWdjdm1ZRlRiZ3dDYkZRa3VlL1ExRUhiVmdWU0c3?=
 =?utf-8?B?ZUxBSm9Wb0x5MWRxVDd1V3d6eERPNENHTmRsQnZHTmRZa3JJb3hoSXFycUJC?=
 =?utf-8?B?TEJhamo3QVdLbG4yVjdodnc0TDE1d1pUbmJvdW1sa05heWNWdDNwUmduRE9i?=
 =?utf-8?B?TmJsMU81YS83Tm05RmZoR2o2VDc3LzVSenQ1emJVT0k0WWZPWmhzK3M2THBO?=
 =?utf-8?B?eEFqMER2RXpidnNORk9BbjdZK1Z4bXdXVm1tZ1pzUXBzVW9Yekc4SGJIUmVi?=
 =?utf-8?B?V01hV0pjMVdVMm1EdVdMWUlXY0FUQTNJZFRlK3l5T01SM1R0cnVzT2NLdUFH?=
 =?utf-8?B?bDVVaHN1Ymc2bDU1THJoR0dyenorRnRXVTcxT0dQRVVYQ3RWS0dzVzdzTW8x?=
 =?utf-8?B?cjVqd3R6QnA3RmRaYjdTR1pteWNQOFJpY1NJeHdSOE5ocW00VFpNN292UkhS?=
 =?utf-8?B?QTQyWGNVSC8wNlhad3h1WTloZWNpUkFzZmthak0yMlVZRkVzOElJc0pUQXBp?=
 =?utf-8?B?N2oyNWxVK3BMeVkrSHM1bWo4RjVqcEhSYk9hK1E1ajVYcURmZ0ZEZ0xXYlVi?=
 =?utf-8?B?YkI1cGdVaXo4c1FXM25PRE0zeCtYdWlsQXU1K1lyb1dnd3N2U1F0MG41RWF6?=
 =?utf-8?B?SlRLS3NocWNIVWIrWHUxUUdvVzJOM0pCenBpUXdwMFNrbmJkZE5rSWNYVGtK?=
 =?utf-8?B?R2Evek1JckhKTXU1dmQ0T201Q211NkFuR1hOVVpudkNLRFJqeFBpR1pqUExW?=
 =?utf-8?B?UUVHTnVOTUZZVVQwUk5sZWpaY3BUVGMwU3YyMUlGTGtFKzREZGJNRW5xbkdP?=
 =?utf-8?B?bW5RbnRvOHRPUTltYVUveTRxRUhveWlMbDVwWlRSZTByY3RYd2xpRHhBVjNO?=
 =?utf-8?B?djhDVjY0RWw1MGE4cjg2RmhHUU50ajFha2hjVEhienhDUVFOZ0tIbEVIWXo2?=
 =?utf-8?B?MkQrdU5EeHFMSW40a2FPVHU3aDRPUDRoRlZzZEJwVEVrNnB4Q3NNRGIzRGkw?=
 =?utf-8?B?QkRkSjlpOEI2Z0RqMjZGTURVOGY2MlJlOWUxeWI3cXpvRWt0NkxVVlVPempi?=
 =?utf-8?B?KytlanA2cjUzTXhOS3VmS2NHdUl0d0NFdURiZzd6OW1UTUdUcktIYnAvZWg4?=
 =?utf-8?B?MlNZT1hmb3RvNGMxT3pMeEFnTzkwMXNMMTJzRzUyVE5jTU1uK0VHVkZqZXFi?=
 =?utf-8?B?WkVPb3lhTHR4Y1p3eldabFVKUjBoMWFiZi9lWWZIVjBtb1pDRjNRaEdsbW41?=
 =?utf-8?B?cTIrUnd0OEZGTWVqTkdaSHE2dkIya1BWUFNobXorNVdBZ1BKOS9CK3BmbnA0?=
 =?utf-8?B?cTgxbFlkNCs0dUxyZDRuTmczWDBmZExmVGNZVy94UlVTeXE4enhjeEM3d3dZ?=
 =?utf-8?B?T0grNkJPRGhpMkUxVWpYSDJRaG0zUjNLU0VIa09jK3U0ZmZhZlp3SFlDM3Fx?=
 =?utf-8?B?ZWU2Zlo4Nlo1SUtWWTdPdklmY3FQbzlyL2MzTXAwMEpoRjB0cnAzajUvTU1I?=
 =?utf-8?B?YmR1b3o3RjN5bFJqNjhLaXRPb2FlaHZ3ZUM4Wk9YMjVxMWRIeFROdTVvblhB?=
 =?utf-8?B?dCtTQ0U3Q3dkMEw3SjFpOGRHT05DZjF3dHZNUVFudHY1dUU4UVU2SUJPRkhs?=
 =?utf-8?B?UmhNZ1FDU2RoUFFvS2hIVzZRSzk4RFFQTHd1bStLYVdkR21oVEd6OFFNKzlk?=
 =?utf-8?B?dlZvejBJeXdxcU9NTTl4WmtnR1JLQlJoMTJzNnMweHNaWmVCYVNRYjl6R3Z4?=
 =?utf-8?B?VFR0WGtjWFBTZzJCTUlVY1EvK0RXR0FGbnNNMytVTVhnb2hxblVNV2tOeHZR?=
 =?utf-8?B?aWJyRUdKNEEwUWxaNFZORHdlY2Fvc1dBRnk1TnVuK054T0kzVUZWcTE4SjNv?=
 =?utf-8?B?ai93TmhuR3ZBcWNPZlFMU0UzR1VERFF6ZUdTZmZ6ZzZPT1VHUkxrbUdJRjVE?=
 =?utf-8?B?blo5bi9TS1ExRUVYRmZHUUw2dzc2ZkpCTDh1U0ljdkxPTkV2MmtNMmEvb0Jp?=
 =?utf-8?B?QjFIRlMxT2VOLzZwcWFmaG5pQVR0ay9BZzJ2V0w1SnpXMSttTUNrUTVKT1B6?=
 =?utf-8?B?K1R5YmE4Z2FPdzh0Z3BHVzUzMFl4ZVp5Q3pYb28xZitqNllnOHZwSEM2OFhV?=
 =?utf-8?Q?8NbeUPa9OvWUEsQ9fSrdIPND5?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB7247.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <05C4A88B47C18B4A8D365BF646833B8B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9947
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A78F.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	31018688-edb9-4f6b-510a-08de6a5382a7
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|35042699022|14060799003|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dEo4RWNXY1hYKzhhaDlZbTZGV0VWVnpvRk5XdVNEVEd4WitVTytmZGZDNUYz?=
 =?utf-8?B?eGo4c1YvQTM0N25ySWsvdWZhVUJVUUloS2RLbVB2SjVIUnA4SDVZVHgrcktW?=
 =?utf-8?B?Yi9TOU84L0hmRFV3Tm12dU5nc2IzSkNUeVkzVDJ4Vmo5V2MrNjh1OWh0cFpV?=
 =?utf-8?B?QVlsckQ0ZW9ucFg0dm9pT3QzR1EvQVNmMEFLUm55OGE1L095TlFGRHNFU29V?=
 =?utf-8?B?SmdtcUEvMlpzM0xsQW1FMzlTcHBKRzkrSDlZZ1FyYnI1elBROE51WjZWUVRE?=
 =?utf-8?B?bXJRRytlQVF6bVhtZEZ4VkxTbmZvZFhYSW5LMW1mYUxaOVBtNlZPRnE1c2Qv?=
 =?utf-8?B?ckRIdGM4MEpxUnR3ZFpJdTZ2UkZyZ21NbGh3TVE0ZnVuVzdWRGh1eFZBSlFi?=
 =?utf-8?B?R09xa1ErWVV1WTdtNFhtN0s0Vy9saUhTQ3BmRXpTeGl5YTU5RHVQNmhyY2xE?=
 =?utf-8?B?ZHFCRlZ2bFFpVjk1QVFtWGdzY2I2WTNaNWdHQzVVakRIL0x0TGRCdXZ2ZVJv?=
 =?utf-8?B?YXBrbFVWNVlhTWppWjVMZGRDMXZIODNMZHJTalk3VW1wVkpjWmltTytQQldU?=
 =?utf-8?B?dlNGNURKNzN0a24zQmxKNzlwRjk0TW5lMW5xYnVjc0UvNzdHRUtXTVlEYkcx?=
 =?utf-8?B?bnFCSzZPOGg5OTFocnR0YThBOEpTdmtoQ3lpZ1pLWGtYbTVubmFKRm5mWFll?=
 =?utf-8?B?MXVEeGxRU1VvV1dENXpvT2tlT0psQTNpV1drOXRDUElzcVpiekNnSVBJSVZN?=
 =?utf-8?B?UHVKbExRVDNaRjYyVWZtR1BRYzBPWjZUbURGWWNmZUx5QXVCNi9ZNlFRbG14?=
 =?utf-8?B?UkRrcUczZXRaRDMzV3FkWE8zUlR5Mnk0SW5Wa3NMY0xZTlcxMUNzN2lXeGVz?=
 =?utf-8?B?cElDb0grc1Q0aHVndzM3SGg1QkFTVi9iaGh4Z1JYSVFCaFVsU21WRXJKbzNJ?=
 =?utf-8?B?T0xsaGQ1ZDQ2eWpyUXJWeFNEZkszTHgzUUNEeWhRL3lYUTJXeTBMMWJwZlBs?=
 =?utf-8?B?bWNZVHBybi84WDU4YVUxcVZDUXc1UXlzM1EwSnJkUHlQcURLNXR3dEt2Y0l1?=
 =?utf-8?B?Q3pTcnRxVGNIS1BrajZsd3dQYVZ3WkZrM1NaTHFDV0JCeDRQVTJuSllzN2Vo?=
 =?utf-8?B?SXR0RW11eXZBaTFGRnUreW5vL2xFeU10Kyt0Z2dUR0RFQUo5dUFiUzU0REda?=
 =?utf-8?B?M3FMZUgzNGNEdFduYXNodkNqbTRVSkJjc01CcHlDVzhkdXVKRVg3MG9RNG9P?=
 =?utf-8?B?UE5ad2NFLy9Fa3A0TUJjLzJvblVwcGlqOS9yTU5hVzI1M2s0MUZyQnpmT0lj?=
 =?utf-8?B?YWJFS05OSnF3MEIrTkkvT1JXeU9yS1RTaUltYVNqdTB6cGNmRHpSMTQ2MEtu?=
 =?utf-8?B?MkFTTkV5S3pnZnFJeEZ5VGtMSzMrMVBtT1lJREd6UnkvRDBtaTVLekhIbEth?=
 =?utf-8?B?VXFlcmc3RW1INnJzcDI0NExJcjlVNkgzNXJ6bDljcDRvZTFhdGdEV2dUQ2dz?=
 =?utf-8?B?WE41bURjZFVxYnFvVGVnUFlwaXR3ZW1PNEl0TWswWlZUWThYbXpNTGNxdFJi?=
 =?utf-8?B?aWhhdGdWYytJOUQrRW1CVnhDNGppdlpTWFJRa1hlZHNoRkNzK25kT1llK2Va?=
 =?utf-8?B?Q01GRS8ySEczRHdtMFVLY01GSkpxQjl4dDVLOHlBRlpUdEc0WW1XY2pmWElO?=
 =?utf-8?B?azVkOGdtbmdvREJWY2EybXRzSjBrSW56UU12N0dXUHpNMmMxMmRlMlZxTm5N?=
 =?utf-8?B?aFZ0aC82Yndnb0xrNFU5MDVMR2ViVDUzOGJQZjdxaks1WTdRcWU5V3lUYlJZ?=
 =?utf-8?B?MlJFZFdnOURTTlQxTHEvMXd3QjdYR1ZEZlA1Y0x6YkduVE84MW9sZ1JBMGNL?=
 =?utf-8?B?S2pVWmU0UTVhN0Y2NmpRSW1hU29YN3hyQ3NsOFFLTWl1eDRRZHFaRE1rSGxF?=
 =?utf-8?B?RVA2cXFnalZUTzJRREhKZk9MRUxqYmtVVTlBTW9YL1draTVLUDF2bXVSb01N?=
 =?utf-8?B?UXo1QWUveVhUM0VHaDFIaFBRMC85YW5Ka0hCaWtpTDNNYzZEcEhIYjJVMlBp?=
 =?utf-8?B?cUlrRGNteDNCVktmZXcxSTMwRUhhOU1mYVBqeTBJSzFscnBGQ3RJalA4bXZx?=
 =?utf-8?B?TGRsVEtQN0N2MTBHWlpRRXJwdGhTdDVXMStaUWRmV2JGY1UrTjdYMmZ6dU9q?=
 =?utf-8?Q?ElrDjwmaRsJsDfE3wJHnELw=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(35042699022)(14060799003)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	G4zGqvS9sBBgPlELOcmYg/6sx8piVi7u6UvGlO6wBkzSCdQE/BejtIgYZXO2oxASAW44HcB14ED4C8UWwiqj3QPcCpomriBm9iYvrBtIR+q9NTpKA9GeLOKvZ2AGalJ1CLj106tUhswpPYNB92oJixVz6yZUTzW7a2Td228ntRj7LzvMWNzo13Krw7ALp9FCEO6LtxfnAjjg4kX4pOxyOThJd0O8R7pAdgMnGJHUtyumGWpR/pb/bp8mrgCjVXlAYFmUk29zQJkhoy2Q/a1pdKXGumgkw6FSr6fuzuOEE7zVWBzhGRWRAaq5GNQ7YHsvok5zbJAxx/PA5mBJKs/5irpap9tQFrVrurM3JEGbW1bQS/ipx9IpCATtZESV3jnPE/XMFDzQh7OL0evd9pcvF0iZCUJCMAR2+5156ZmfQCt+UE6ks5lORJY680v5EFTE
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 16:27:47.5870
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ba320a-3470-4aa2-b5f8-08de6a53a892
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A78F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9770
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Q3VycmVudGx5IEN5Z3dpbiBkb2VzIG5vdCBzdXBwb3J0IHRoZSBIaWdoIEVudHJvcHkgVmlydHVh
bCBBZGRyZXNzaW5nDQpmZWF0dXJlLCBhbHNvIGtub3duIGFzIElNQUdFX0RMTF9DSEFSQUNURVJJ
U1RJQ1NfSElHSF9FTlRST1BZX1ZBIGFuZA0KNjQtYml0IEFkZHJlc3MgU3BhY2UgTGF5b3V0IFJh
bmRvbWl6YXRpb24gaW4gV2luZG93cy4NCg0KV2hlcmVhcyBvbiBzeXN0ZW1zIHJ1bm5pbmcgb24g
dGhlIHg4Nl82NCBhcmNoaXRlY3R1cmUgdGhpcyBmZWF0dXJlIGlzDQphbHJlYWR5IGRpc2FibGVk
IGJ5IGRlZmF1bHQgaW4gdGhlIHRvb2xjaGFpbiBkdXJpbmcgdGhlIGJ1aWxkIHByb2Nlc3MsDQp0
aGUgQUFyY2g2NCB2ZXJzaW9uIG9mIHRoZSB0b29sY2hhaW4gbGVhdmVzIGl0IGVuYWJsZWQsIGV2
ZW4gdGhvdWdoIGl0DQppcyBub3QgbWFuZGF0b3J5IHRvIHVzZSBpdCBvbiBXaW5kb3dzIG9uIEFy
bS4gT25seSB0aGUgbm9ybWFsIEFTTFIgZmxhZw0KSU1BR0VfRExMQ0hBUkFDVEVSSVNUSUNTX0RZ
TkFNSUNfQkFTRSBpcyBtYW5kYXRvcnksIHdoaWNoIHRoaXMgcGF0Y2gNCmRvZXMgbm90IGFkZHJl
c3MuDQoNClRoZXJlZm9yZSwgdGhpcyBwYXRjaCBtYW51YWxseSBpbnRyb2R1Y2VzIHRoZSBhZGRp
dGlvbiBvZiBIaWdoIEVudHJvcHkNClZBIGRpc2FibGluZyBmbGFncyBpbnRvIHNldmVyYWwgcGxh
Y2VzIGluIHZhcmlvdXMgTWFrZWZpbGUuYW0gZmlsZXMuDQpUaGlzIHNob3VsZCBwcmV2ZW50IG1l
bW9yeSBvdmVybGFwIGJ1Z3Mgb24gQUFyY2g2NC4NCg0KVGVzdHMgZml4ZWQgb24gQUFyY2g2NDoN
CndpbnN1cC5hcGkvbHRwL2ZvcmswNi5leGUNCndpbnN1cC5hcGkvbHRwL2ZvcmswNy5leGUNCndp
bnN1cC5hcGkvbHRwL2ZvcmsxMS5leGUNCg0KU2lnbmVkLW9mZi1ieTogSWdvciBQb2RnYWlub2kg
PGlnb3IucG9kZ2Fpbm9pQGFybS5jb20+DQotLS0NCiB3aW5zdXAvY3lnc2VydmVyL01ha2VmaWxl
LmFtIHwgMiArLQ0KIHdpbnN1cC9jeWd3aW4vTWFrZWZpbGUuYW0gICAgfCAyICstDQogd2luc3Vw
L3Rlc3RzdWl0ZS9NYWtlZmlsZS5hbSB8IDIgKy0NCiB3aW5zdXAvdXRpbHMvTWFrZWZpbGUuYW0g
ICAgIHwgNCArKy0tDQogNCBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRp
b25zKC0pDQoNCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnc2VydmVyL01ha2VmaWxlLmFtIGIvd2lu
c3VwL2N5Z3NlcnZlci9NYWtlZmlsZS5hbQ0KaW5kZXggZWZiNTc4ZTUzLi45OTU0ZWJlNWQgMTAw
NjQ0DQotLS0gYS93aW5zdXAvY3lnc2VydmVyL01ha2VmaWxlLmFtDQorKysgYi93aW5zdXAvY3ln
c2VydmVyL01ha2VmaWxlLmFtDQpAQCAtMzgsNyArMzgsNyBAQCBjeWdzZXJ2ZXJfU09VUkNFUyA9
IFwNCiANCiBjeWdzZXJ2ZXJfQ1hYRkxBR1MgPSAkKGN5Z3NlcnZlcl9mbGFncykgLURfX09VVFNJ
REVfQ1lHV0lOX18NCiBjeWdzZXJ2ZXJfTERBREQgPSAtbG50ZGxsDQotY3lnc2VydmVyX0xERkxB
R1MgPSAtc3RhdGljIC1zdGF0aWMtbGliZ2NjDQorY3lnc2VydmVyX0xERkxBR1MgPSAtc3RhdGlj
IC1zdGF0aWMtbGliZ2NjIC1XbCwtLWRpc2FibGUtaGlnaC1lbnRyb3B5LXZhDQogDQogIyBOb3Rl
OiB0aGUgb2JqZWN0cyBpbiBsaWJjeWdzZXJ2ZXIgYXJlIGJ1aWx0IHdpdGhvdXQgLURfX09VVFNJ
REVfQ1lHV0lOX18sDQogIyB1bmxpa2UgY3lnc2VydmVyLmV4ZQ0KZGlmZiAtLWdpdCBhL3dpbnN1
cC9jeWd3aW4vTWFrZWZpbGUuYW0gYi93aW5zdXAvY3lnd2luL01ha2VmaWxlLmFtDQppbmRleCA5
MGE3MzMyYTguLjVmNWZkYzVhYiAxMDA2NDQNCi0tLSBhL3dpbnN1cC9jeWd3aW4vTWFrZWZpbGUu
YW0NCisrKyBiL3dpbnN1cC9jeWd3aW4vTWFrZWZpbGUuYW0NCkBAIC02MjAsNyArNjIwLDcgQEAg
JChORVdfRExMX05BTUUpOiAkKExEU0NSSVBUKSBsaWJkbGwuYSAkKFZFUlNJT05fT0ZJTEVTKSAk
KExJQlNFUlZFUilcDQogCSQoQU1fVl9DWFhMRCkkKENYWCkgJChDWFhGTEFHUykgXA0KIAktbW5v
LXVzZS1saWJzdGRjLXdyYXBwZXJzIFwNCiAJLVdsLC0tZ2Mtc2VjdGlvbnMgLW5vc3RkbGliIC1X
bCwtVCQoTERTQ1JJUFQpIFwNCi0JLVdsLC0tZHluYW1pY2Jhc2UgLXN0YXRpYyBcDQorCS1XbCwt
LWR5bmFtaWNiYXNlIC1XbCwtLWRpc2FibGUtaGlnaC1lbnRyb3B5LXZhIC1zdGF0aWMgXA0KIAkk
JHtTT1VSQ0VfREFURV9FUE9DSDorLVdsLC0tbm8taW5zZXJ0LXRpbWVzdGFtcH0gXA0KIAktV2ws
LS1oZWFwPTAgLVdsLC0tb3V0LWltcGxpYixjeWdkbGwuYSAtc2hhcmVkIC1vICRAIFwNCiAJLWUg
QERMTF9FTlRSWUAgJChERUZfRklMRSkgXA0KZGlmZiAtLWdpdCBhL3dpbnN1cC90ZXN0c3VpdGUv
TWFrZWZpbGUuYW0gYi93aW5zdXAvdGVzdHN1aXRlL01ha2VmaWxlLmFtDQppbmRleCAwZmYyM2Qw
NDEuLjUyOTg1Mzg0OSAxMDA2NDQNCi0tLSBhL3dpbnN1cC90ZXN0c3VpdGUvTWFrZWZpbGUuYW0N
CisrKyBiL3dpbnN1cC90ZXN0c3VpdGUvTWFrZWZpbGUuYW0NCkBAIC0zMjgsNyArMzI4LDcgQEAg
TERBRERfRk9SX1RFU1RETEwgPSAkKGJ1aWxkZGlyKS8uLi9jeWd3aW4vbGliY3lnd2luLmEgLWxn
Y2MgLWxrZXJuZWwzMiAtbHVzZXIzMg0KIA0KICMgZmxhZ3MgZm9yIHRlc3QgZXhlY3V0YWJsZXMN
CiBBTV9DUFBGTEFHUyA9IC1JJChzcmNkaXIpL2xpYmx0cC9pbmNsdWRlDQotQU1fTERGTEFHUyA9
ICQoTERGTEFHU19GT1JfVEVTVERMTCkNCitBTV9MREZMQUdTID0gJChMREZMQUdTX0ZPUl9URVNU
RExMKSAtV2wsLS1kaXNhYmxlLWhpZ2gtZW50cm9weS12YQ0KIExEQUREID0gJChidWlsZGRpcikv
bGlibHRwLmEgJChidWlsZGRpcikvLi4vY3lnd2luL2Jpbm1vZGUubyAkKExEQUREX0ZPUl9URVNU
RExMKQ0KIA0KICMgYWRkaXRpb25hbCBmbGFncyBmb3Igc3BlY2lmaWMgdGVzdCBleGVjdXRhYmxl
cw0KZGlmZiAtLWdpdCBhL3dpbnN1cC91dGlscy9NYWtlZmlsZS5hbSBiL3dpbnN1cC91dGlscy9N
YWtlZmlsZS5hbQ0KaW5kZXggNGE3OTM2YTZlLi5lNDQwNzlhNDEgMTAwNjQ0DQotLS0gYS93aW5z
dXAvdXRpbHMvTWFrZWZpbGUuYW0NCisrKyBiL3dpbnN1cC91dGlscy9NYWtlZmlsZS5hbQ0KQEAg
LTczLDE0ICs3MywxNCBAQCB0em1hcC5oOg0KIA0KIEJVSUxUX1NPVVJDRVMgPSB0em1hcC5oDQog
DQotQU1fTERGTEFHUyA9IC1zdGF0aWMgLVdsLC0tZW5hYmxlLWF1dG8taW1wb3J0DQorQU1fTERG
TEFHUyA9IC1zdGF0aWMgLVdsLC0tZW5hYmxlLWF1dG8taW1wb3J0IC1XbCwtLWRpc2FibGUtaGln
aC1lbnRyb3B5LXZhDQogTERBREQgPSAtbG5ldGFwaTMyDQogDQogY3lncGF0aF9DWFhGTEFHUyA9
IC1mbm8tdGhyZWFkc2FmZS1zdGF0aWNzICQoQU1fQ1hYRkxBR1MpDQogY3lncGF0aF9MREFERCA9
ICQoTERBREQpIC1sdXNlcmVudiAtbG50ZGxsDQogZHVtcGVyX0NYWEZMQUdTID0gLUkkKHRvcF9z
cmNkaXIpLy4uL2luY2x1ZGUgJChBTV9DWFhGTEFHUykNCiBkdW1wZXJfTERBREQgPSAkKExEQURE
KSAtbHBzYXBpIC1sbnRkbGwgLWxiZmQgQEJGRF9MSUJTQA0KLWR1bXBlcl9MREZMQUdTID0NCitk
dW1wZXJfTERGTEFHUyA9IC1XbCwtLWRpc2FibGUtaGlnaC1lbnRyb3B5LXZhDQogbGRkX0xEQURE
ID0gJChMREFERCkgLWxwc2FwaSAtbG50ZGxsDQogbW91bnRfQ1hYRkxBR1MgPSAtREZTVEFCX09O
TFkgJChBTV9DWFhGTEFHUykNCiBtaW5pZHVtcGVyX0xEQUREID0gJChMREFERCkgLWxkYmdoZWxw
DQotLSANCjIuNDMuMA0K
