Return-Path: <SRS0=+N2H=HJ=arm.com=Mate.Dimand@sourceware.org>
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	by sourceware.org (Postfix) with ESMTPS id 0FC9C4BA798F
	for <cygwin-patches@cygwin.com>; Thu, 17 Sep 2026 10:59:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0FC9C4BA798F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=arm.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0FC9C4BA798F
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c207::3
ARC-Seal: i=3; a=rsa-sha256; d=sourceware.org; s=key; t=1789642793; cv=pass;
	b=mh0gdJPIzfok/w7zbVTSDf086oyAcGBaBs8DkMkjvOUhPrPkRU6WF4FC+cLrTE3oIuHtcDFf0Ub0x6bBfAZa6CNL2aS26i30i+oU7qoJMLgHUqlHXoLuixUpYb23B6skcdGdfxsimUwsTmEgNgkhq/GMzitOOJjV4hXXYIFaMOc=
ARC-Message-Signature: i=3; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789642793; c=relaxed/simple;
	bh=qatlNBgeyZSSk5D4qkKOA5CMyrmOLxnbRR2wHf6cXRc=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Date:Subject:To:From:
	 MIME-Version; b=R/uHo+j4SEOY947Mvkh/sntqOyiQCE4aLxbC/3qPFnpdrGwyU0ApFQ+KVpfLPdNqR9OFLLO02DTxlR4wRtLgmEDLrqtT2SA7C/dFaKoXY+fW1gBs87OjWqap0YnoS76Zj5mAulcPgipyBPYsWIY5rlSkjfI/tXt+1tXsU8qeico=
ARC-Authentication-Results: i=3; sourceware.org; dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Edf8rbvV; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Edf8rbvV
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0FC9C4BA798F
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Edf8rbvV;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Edf8rbvV
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=h91WMRMsDatQM3aQ4pUNQBPl/YKiEAUGxNWwCVTEdi5yT6n8X20utsWW0yt8uuELgYBglg3xS6kDogyH1caxY2cH905thTY4ClJp4x/pE3zXUExXsdR11QwrIJNQ86zk3X57JOzFaiJRoiV7Q6c6Uz2reka2aVyFATaNS7i0a0rVClmU4uMng44he6sQaZnfu2rh5AOHcWwvTqB+wbY2LcMBDT8UYRvJPDiRLY6yrN9ytvkNjKTD8bEYO+Y4zYk4PMu6mocdMMr9xTSPKVWBWH1pgkVQ3kPvXMBJHXvO/fKmBt3QkmSebayecfBQxDqu0nGiOgp41Xg7ZAPliqCNqg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qatlNBgeyZSSk5D4qkKOA5CMyrmOLxnbRR2wHf6cXRc=;
 b=Ey75Z6qpPxviHM9ufBdKcLZBem2UYT3nrN+7ei8zY6j6ez59rvJzHO/Zjc4g3FAX0HhiGM6/3BTnxZz+Hk+C7fvYqsnNku8JXinK3i3rn/XNZlCRWHwZBvBgwzI1VW70pOYRG9SvhZtNfzrxcz82uyr6lzFgofA+lE0uALKX1tw0kU/MX39LdYl9QJwclRfgDgwqjNAY6Vt+VATg22so5QBKJ669mAVuNoHW8VTih6SpHgQvPIAc1ZJUAHxpdwn/vzfbeUj7N0+E+xsFkPPIkzEcWhOMHEIOwsn3SoTsankmtgZxfhSqZHMgpyfQ05SCzS+hVoJWzBUFaAnCLIuspg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=dronecode.org.uk smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qatlNBgeyZSSk5D4qkKOA5CMyrmOLxnbRR2wHf6cXRc=;
 b=Edf8rbvVkXBREzTUW0ltx12EDt923PhoI8iWgy71yS3OVNxE9rrPm603I+0JTweISZKLMJ0TrDCz3pK8gvwQIofjsRODuN2XWR28LQBG/3m0foKk8gdKuh6LtC/gJUW3KcNzwuHSXQpLDQtwunmDpXSCp6NJT8Q6yX3X4J8N0dM=
Received: from DUZPR01CA0262.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::24) by AS8PR08MB9316.eurprd08.prod.outlook.com
 (2603:10a6:20b:5a7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Thu, 17 Sep
 2026 10:59:48 +0000
Received: from DB1PEPF000509F6.eurprd02.prod.outlook.com
 (2603:10a6:10:4b9:cafe::5b) by DUZPR01CA0262.outlook.office365.com
 (2603:10a6:10:4b9::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 10:59:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F6.mail.protection.outlook.com (10.167.242.152) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Thu, 17 Sep 2026 10:59:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKanAUfgNynf7wK5dFnB/AehDPjBWVGb068XjZirQb1yN6LXOyeR14x9tgQHlnfGtuIcUjpgaqhkmGdoR0djHMih5PjMsGAdanO/vCHOyH1NjvS5bhjPVvT9xiFhBbn3l7SvL3HvlQVgsfRzMBpcVlNgfF90B7MFjuU9KTpUsUSk2KCEDeLDODUvNC9+qlMyV7gSilWxHBK0jajndWZFrlR/j9PmSvc1SZ90OvaUN6pYgrwTICSAUduAs1/XkSsH0XItiscPpi8gqQem83nB1CpRDCrPFY3Dmz9vejMWjLVYbTqgYqYr7fFnF4pPJgPlRMuZaYWj7qrfJn9doHdLoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qatlNBgeyZSSk5D4qkKOA5CMyrmOLxnbRR2wHf6cXRc=;
 b=LbsPZCaX161SYTzfHoA2T7fMUcElIBP/1X3sB1KjyDnN89N7eJ7z/1+cH+NhypIjwQhB62J4muhKoEVsUJsvCd168nccHC5GiD1qgAwBFYfSkwhOU0pCjCtiWDF2z6rpOK7HjN2QpBv6kNOfJrrFkL8R4s+V8RYtRSsvlZJP2/e8J6VUp9piPXJDGcs3FxWhTz25HQUcZIlePN/Ca61c0bgV5ho+WF/P4iTa7eun/UGT3gOuHmbDpCg5DaBv2V1RLbgfUfZYrWw86S/NVYYHqC88s7iBj7Y66uKubcOc3QH8FVQeNYAe9a1/RkAuyUFrgfA2fXjW1YIB41umds+vcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qatlNBgeyZSSk5D4qkKOA5CMyrmOLxnbRR2wHf6cXRc=;
 b=Edf8rbvVkXBREzTUW0ltx12EDt923PhoI8iWgy71yS3OVNxE9rrPm603I+0JTweISZKLMJ0TrDCz3pK8gvwQIofjsRODuN2XWR28LQBG/3m0foKk8gdKuh6LtC/gJUW3KcNzwuHSXQpLDQtwunmDpXSCp6NJT8Q6yX3X4J8N0dM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB4PR08MB9310.eurprd08.prod.outlook.com (2603:10a6:10:3f6::22)
 by AMBPR08MB11937.eurprd08.prod.outlook.com (2603:10a6:20b:761::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Thu, 17 Sep
 2026 10:59:15 +0000
Received: from DB4PR08MB9310.eurprd08.prod.outlook.com
 ([fe80::73e6:2715:9ac4:e576]) by DB4PR08MB9310.eurprd08.prod.outlook.com
 ([fe80::73e6:2715:9ac4:e576%7]) with mapi id 15.21.0406.005; Thu, 17 Sep 2026
 10:59:14 +0000
Message-ID: <5216eeb2-8399-4deb-a5a8-56d798a836ed@arm.com>
Date: Thu, 17 Sep 2026 12:59:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: gendef: fixed AArch64 setjmp storing incorrect
 frame pointer in jmpbuf
To: Jon Turney <jon.turney@dronecode.org.uk>
Cc: cygwin-patches@cygwin.com, nd@arm.com
References: <4635aed1-eceb-4540-9071-2a4cd257b27c@arm.com>
 <80308c9d-127d-4f12-bf91-aac8e3124cc7@arm.com>
 <6dc5f7a1-859a-4cdc-a7e0-f73fba804016@dronecode.org.uk>
Content-Language: en-US
From: =?UTF-8?B?TcOhdMOpIERpbWFuZA==?= <mate.dimand@arm.com>
In-Reply-To: <6dc5f7a1-859a-4cdc-a7e0-f73fba804016@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0136.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::15) To DB4PR08MB9310.eurprd08.prod.outlook.com
 (2603:10a6:10:3f6::22)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB4PR08MB9310:EE_|AMBPR08MB11937:EE_|DB1PEPF000509F6:EE_|AS8PR08MB9316:EE_
X-MS-Office365-Filtering-Correlation-Id: c08d79ab-ebf9-410e-4f79-08df14aaca44
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|10067099003|4143699003|18002099003|11063799006|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info-Original:
 ev13nzC5Zv/83GK0mXSf1p1HLtnB4B3MfGNeHGhr6wsyuMdOKy2f85rMbTPkZpI6k56uIqUAU7TnhoHnwjpR105eX99YqCWAwcxccpA1ed5D48IN1UIqAmRc8O3MIP+4aTWetaL6/VuDalBpQrt8Hy7kaKMpv/h9SIy3dgniGK47LJ5REFtbdkDee2I6by+zvb/zUaiXVik8S+2Fe7shdhuWgHsc624qyIjqarTQAOYF4Do3y6M3Poa+iI59LWFqzh7kBkPlJG1tFhcqLCSCAmLy9/eW+7lQxumd3WAGWDUe0B8K3JgTKONLBvuv8u898Yr4jpwyJbAD/XO4xlp6ciAZWHmyFPO7kLp1HwhysueB45hOkGrucFaGngU58kMkdOAQZkE6GxakrS/JxMcbpmc6vRZ4jzY/qv7/OafUgSQSfTzd4bL+lZkq/q8isutmu5udCP2CT5kiEremX8SXIGDvQIrPUl7rpg7B7MsHCZosTHrd4ehtS/eTQby+OQ9PJtSkQcHCy2eLavTSSiHcR1Cno9bqSIiJnnnwrzpbsjQTA45ZbEpcgJ/g/q7CZxQ8KlMc9OQ58L5xsEASav61TvCsQlUgGwGvvweLc1J7hs5tQf0vq87z/PFatcduxSUN97nKhUsFaGds2yBlParPW/rJS7NmLpcSBoShNKSq+V4=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB4PR08MB9310.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(4143699003)(18002099003)(11063799006)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 NdAfljTpA1R7RUq1vkiC+UiYFajorfLmZFYzJClVG4m4GRYkv2ifNaRJsVzGGncCyXBbBX+PWCzVY4N9rijLXDlW214RwTN2EYObgakCi+atZmdAP4YzQ5waCAUPZXzpQSCMZeOpvuJ2tdLKNX0XIf9MRBMQzHZ/2QmKw9l41Z4rzA0kDmNto+b6w0JWfo0vHVhCab03L9ouqOwtA+dO3jrdCUc91uJnQ6hqHuzuzySGVcsUwzRF8UujdRN7aqjeUuQZ8ZiZwd15Mv8thMTRqgFpAz6+d/dFXxJlRIIKMZW0UHVXvXsX0k21npN9fNCPvwAawmem7bjBBwtq0yvKUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR08MB11937
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F6.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	27eeb919-733b-429e-132e-08df14aab661
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|35042699022|23010399003|14060799003|10067099003|4143699003|11063799006|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZN1omMGl1Z51GW2gmEWyQFgglxT3ZrdaAxUX64Z00iwlJzsXDBvH1qyWBjnqFhqTvTSIw7Sfu8/WbFnC5uqeyZlIgw2cW8FbnKZHcXUCXbDTEWUu5Y2jrroqTiqQGaF8cD2hQ64K05dEISTPYOTZGQZj6QtWQi2W4G0YJr5p2mgDuCvJoM61gURoMufo0sTxKrqQKmOVGg4E9mUAgeM7oupYvq1xjaJ7CkVIspv4stHTGjtHXp8Xujc73vx7WN/TMny9a6MoS/IoeS2nCUyE5rsKucKwTe1E/LVTh594o7RrWpTIvwqSIvIqKX6oBv1T4uBdAcCOJFNJ2FltwF0E888+bqD3h+HMeUUeNyWhFgl3T/wDYqywGomIsnXVG2uI0TyBs0t9Cj5kymccBDEIIRsimstC7o9sNFP93EoKhNoIwTDZh0oBC53av/p8KI0y4Vn6EWreFhi0RjO5LkVssJ/hx6uWQI3dpKelSJV5a95ip4vSW4Uqs+YZTiL/VNF1z8js/Os6fh32r9n3lmc4coOJ/T++Rt9XBf8qNGqCF1YPugSiLsEKTyBKRGGUDI3W2dqK22lt+xWpGfyS87eAjR6rl6fLNtPA/nWxNS2biCZ5T3PM0zZGfzZB+8NfFx5vY8dadfoE0hkmum1R0ex4aOnt7dpceQrOXWlurqnShZD4+FXRR52fki1sxTTUJFld/xHvUx9w6rGdcLGDpV/K5g==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(35042699022)(23010399003)(14060799003)(10067099003)(4143699003)(11063799006)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6vmzyrWDw2m0FOFUC7zMdKSPkmi/TI9rKXtkuGel1yQlpA/Xrd6DA6V4X/IkNc6keEiII5G6nRvwsWvkYOIezf7/MRQuoS01mE/tmN3hkBGJZcpq2DbjmJ6WOfHjyj+V9Tte/zjt8YKjcls/ui7VTNQ4Ui9w9my/eYvycBUY/Yrlnq218/d/73WymZpaEkXQOt4shT9KltimJJXFYUWQYGvt89S0lWEV/u0UzXBmmWumQSgGnVkruUqmrmtZ5bDz2VVJChxjaBDuqhIsvs3Ja3K3kOxTwCmReUR3ZyHto08APzN+GfjEk42BQvaq+HSrODWc3qlDu300AognqD1djq+t7yohz/kfsxihA7n6S8aQ8zd2L9gzrkXchRuuk8/V5dCRsCwG0HJ9AB/bam6CkBMJZJokKgQhAZhf4qurYKgaosSriO1AH0hfZp2ZziDe
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 10:59:47.9582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c08d79ab-ebf9-410e-4f79-08df14aaca44
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F6.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9316
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,SPF_NONE,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 9/16/2026 9:03 PM, Jon Turney wrote:
> Oops! Sorry about forgetting about this one.
>
> Applied, thanks!
No problem, thank you!
