Return-Path: <SRS0=OqEs=BU=arm.com=Igor.Podgainoi@sourceware.org>
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	by sourceware.org (Postfix) with ESMTPS id 7C4A94C3182B
	for <cygwin-patches@cygwin.com>; Fri, 20 Mar 2026 14:55:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7C4A94C3182B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=arm.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7C4A94C3182B
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c201::6
ARC-Seal: i=3; a=rsa-sha256; d=sourceware.org; s=key; t=1774018552; cv=pass;
	b=nvXeNAIgJIApvIQ8h9o4CDYwoDIe/45cXmADAHiOUyDB3YyZJ9DB7GB4xTYkhLTfj8uh1Qm5knHi7m8Nu4zBKubJ0p93pYKhONFc3y50YLW5lsdVEksD6M/EsgzJ1gNjzCYGY9t8AcvJXpYvKGZeGSYFrFf6F2TgUStaTGGGzlk=
ARC-Message-Signature: i=3; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774018552; c=relaxed/simple;
	bh=m0rld/UCAlMAEIpl9a/VmUZkidRm5Lbgvu3z3zn9vBo=;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version; b=UqC05agIIcCpcgMK2QaMQn4Q1z6uICaq99CqWikiAgGExE4XJXdbFJOYRUTaqjRH9ZyBSZXsUt3Qd81BHgm6yP9Y2JnCvhMI/Sw29NaFSjOI15JQ41yHtcGrM2kcEq9thXg9kv/YCaDULCn5F5n/XpeIxRjOnmHDwdviCPJscgw=
ARC-Authentication-Results: i=3; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7C4A94C3182B
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Dg2xxGOI;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Dg2xxGOI
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=EbxWNvYc81vK2t4pV6KS0BG996Kv4/wpJimKL96L2iGSyP6caYsoPCKiRpwWclfdFZKMVUdJ4DVVA8p1ST3T4ODawvsJE+/yb6NcanTubEdMcrL04AFyb35IfDqH7gophbegiFaBHSxhlbLNSkm1DjLwwtvISXNe8qHXo7W+Uz23tjq27NESxa9K1R7YnBB0qUxrzoOrXm7udDU0n7Ibs9ClhP3Tg4SLi2/6VWua3MXFOQCLBVlMgJaWqdglUbmCEUB9pWBXUxopBZ84HWidMBROBJE+qnGKMgBfJy1sVISmwsT8sbQsEWNmyWJ9fmY82ZjixrkSJEbZNQgQQLlJjg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0rld/UCAlMAEIpl9a/VmUZkidRm5Lbgvu3z3zn9vBo=;
 b=UlT7jXZPfK6QHQQIjt8txtMKH/5doRz2HmVw2daXr5LR90U7/2/vX0NKhanJoOZzoOhaL0JhYaS8ZWW4Q1tW6MTNtlLqyhMKL9O+5OyDGmR93AEHM25+MKvDk/gZQ8gPlR7bdujsP85SRPdL7Z5QYbGvJRu7SJygaWxkMp6eimO0JrzQSDi7lxA7CFfIi5PXdiXyqKnhbZjTkXw5QViUsDWOYTxyfIFfsoPPLO1DaEK8h2BQwo2FYWpoiJoTpgxZutjlzKtjXpjaj3Xf1RD2fydw7O7Tq5BmuvMK5Qk3XfHvImMtZDCrHs1SNzvrtY5rh+RyB3UOeosfT2uA7Ua9kg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=cygwin.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0rld/UCAlMAEIpl9a/VmUZkidRm5Lbgvu3z3zn9vBo=;
 b=Dg2xxGOIZr9WpQ8a9CowFpYof/URALle+hlQ4osbAYcNpHaxrMHKGu+alAf4jfpDpHZdBPHmlS1qY5ytfpGigBhd83oGurWzEXzYjbLMbwMsN6WI9bDiXLJuOQmpjNcZgBahFQlpbBi/0MIEyC6FzIWcaHfSg8iQWeh9/cvUQgo=
Received: from DUZPR01CA0304.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::6) by FRZPR08MB11866.eurprd08.prod.outlook.com
 (2603:10a6:d10:1c8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20; Fri, 20 Mar
 2026 14:55:37 +0000
Received: from DB3PEPF0000885F.eurprd02.prod.outlook.com
 (2603:10a6:10:4b7:cafe::ff) by DUZPR01CA0304.outlook.office365.com
 (2603:10a6:10:4b7::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.22 via Frontend Transport; Fri,
 20 Mar 2026 14:55:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB3PEPF0000885F.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19
 via Frontend Transport; Fri, 20 Mar 2026 14:55:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYf9NemNi9CkKmuZGtIMzj1HnwR7+2kFmHgcSfZx1gfbNE4g4cvz5IoexoeEv/U5DWnBD1E+u9JMzaQc/KaaoZ3Bdd3+2e6Yaa0WXyogo7LjSNLbBouzeTEswEtabD7Xv7Gv3G1H8Cu2zuOS3D17fD6ZBHCwwS7J8AV2qvc8JXfifDGgCYwtYK8QU64pYjFvU00s1nn00DfvysbfK5a4OcupFsVp+OJtZPAgnjUjXCMYLcHch4pDERQWWedJyJCZo6fYb69i/pu1x3/Ia7HhavTjW0UkyQmdg76CUqRsay09rICuX03IXnDzRVlRig5ZVc64dNqjPvK+d6oMs6KX3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0rld/UCAlMAEIpl9a/VmUZkidRm5Lbgvu3z3zn9vBo=;
 b=qAVdGK2Cb/VRsKQ9LNL7NhPstBb6Ho5HCbs70ksmy/jKK3f2Cj+mMamtoLzUmtvgz1iJCysifUTd8dWGHKcldNrqqgDXRACvDomDDP07hLt++g3kWTEu6nEUbYvyFoFR+swPP9o1bp1JRwOW35Uxp+FMr2efBAXBWsZ7CKG/i4EH64hxL20o7QHzmQQ5bOXyVnRpLlaRBW1kS+0fKGy6mysbRikNR2WLa98gQ2SctNie7GCThUzAgvGIqZUPQU2I5uPw/vKwotu497PsmtvaqPLRkCm5IZ9gNa/I5MM60xcY1CvseW5YpIDww3k42rO7rCxXTnccXTYB/DaHhhDT1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0rld/UCAlMAEIpl9a/VmUZkidRm5Lbgvu3z3zn9vBo=;
 b=Dg2xxGOIZr9WpQ8a9CowFpYof/URALle+hlQ4osbAYcNpHaxrMHKGu+alAf4jfpDpHZdBPHmlS1qY5ytfpGigBhd83oGurWzEXzYjbLMbwMsN6WI9bDiXLJuOQmpjNcZgBahFQlpbBi/0MIEyC6FzIWcaHfSg8iQWeh9/cvUQgo=
Received: from AM9PR08MB7243.eurprd08.prod.outlook.com (2603:10a6:20b:432::24)
 by PAVPR08MB9259.eurprd08.prod.outlook.com (2603:10a6:102:307::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 14:54:31 +0000
Received: from AM9PR08MB7243.eurprd08.prod.outlook.com
 ([fe80::7e76:281b:4715:ba46]) by AM9PR08MB7243.eurprd08.prod.outlook.com
 ([fe80::7e76:281b:4715:ba46%6]) with mapi id 15.20.9723.018; Fri, 20 Mar 2026
 14:54:31 +0000
From: Igor Podgainoi <Igor.Podgainoi@arm.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: nd <nd@arm.com>
Subject: Re: [PATCH v2 1/1] Cygwin: SEH: Fix crash and handle second unwind
 phase on AArch64
Thread-Topic: [PATCH v2 1/1] Cygwin: SEH: Fix crash and handle second unwind
 phase on AArch64
Thread-Index: AQHcoM7wwt3RmlVTk0GjLgpwgpysR7Wpid8AgA4naQA=
Date: Fri, 20 Mar 2026 14:54:31 +0000
Message-ID: <ab1fpH4XEFR8FEEU@arm.com>
References: <cover.1771414249.git.igor.podgainoi@arm.com>
 <c4f8c7507e38602ef2935a8dbafe7409a63377ad.1771414249.git.igor.podgainoi@arm.com>
 <aZWrI3WPFRqj7P_j@arm.com> <abGAGofEMp7sikvK@calimero.vinschen.de>
In-Reply-To: <abGAGofEMp7sikvK@calimero.vinschen.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	AM9PR08MB7243:EE_|PAVPR08MB9259:EE_|DB3PEPF0000885F:EE_|FRZPR08MB11866:EE_
X-MS-Office365-Filtering-Correlation-Id: bf2306b4-7520-42e9-8c10-08de8690bf1d
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 7ZOsRcLT8D4d9p8psPTWhwW7OV4yjdz9NjWbbw7vHP4u+Z80GRltaQVYwW1CSKEF/4ahUedrXpwnIx3XeZ4JKoAOgIb/VXWFipFjFwpQZ3qHu065b0BpxBGYZmAdusXD6pZQHr2Al2Euwv3uyIJox0t8ocBp+KcgVUacYgO4rWnVhoIqQzd8aKT4nj3JrcEyX1LrdmJqCcoOdpMemp8IoG3h5cxTq9lKpz00t4yUWNblb5yqs2GEOFGLli4gM4FIm8pgA4JInK2D8fmuUm5ULo+te2W5cETaxUAJSFk0FSqTG8N8ubOfZa0l//Rx0AgiROUVNfLT2r0oJYV1FsqORDS7OzxLM406uRUOTiUGhmR3q4LyV7h2S/Mm0bHKFHrMV5DQq73TTadCsUz8/fOMrVX1oOBxe7HxNVntkdv96ySpvkX6vobltCH8gC59vxO7elOYC1Y/4hJ6fGy5B/AulHjts09bkt56jqkgjk+cs/aQfgYF+pyKM+TQVLIaIR3L7McO2CNE+SDQ8aW2ACPKI4vdh0CUo5aexyS5uPzVt0u7XZlW+DUCsMnoCnjZTjwOimDhnUsOVEGyvCHI8iUxH+83f+u5oIrY+Dmpv67jOhg5XrbLiFljNFW+6L7hp3b6s0tDvRI1B62brv6wFm17fuzA9TXcOBRqtjG1sWIu0KNrYGnLINWwpi+lUzkfIkxgwe4rHHdN9AZbYKSvqOLfTSvKcH5/gB83ER06zTZa0XP9Mg73TpxaQQoTkmnmoz7NIlu1SvafLCT7gK/N/p5n1L0C5tN+/kvV5Um33sqPMaU=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7243.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <CBEA4FA80893764E81509127E8D98D15@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
 oitEGO8KpNY7Rqo5mvOjtkJTONxC2Y6c7bTR63q2FTd1+aHsUxkzTBi99KFWfTvPcEyLEMHOOz+pk7r5vGKg9eUEIFyCPpBpS2S2vBT1hxBexjxVrPHfQ1/YRUL0sb+rcjhVIat+EDkYo2JHJYSzFNWeZHxw8Bj3xL9X+kwHGL4zkF51uvgSCAaU+/BWUhxcTmR3d9/iZxt6SiMTiVFsuukQ4gNnPIXpLdeWCSEL3ri8qpzSa4GQJXa1joE2NCNzrvXOHBVXSdeTZoOXfj9AyF7Ip9k6AVY+7FkfATufhsrKYxGbu28xawNMfM3fF0YXnCMSoWGlWBRWuhl5tnoNrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9259
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF0000885F.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	aa7c9153-afef-4b4a-bc03-08de869097f5
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|14060799003|36860700016|376014|35042699022|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4IPujbgn1qFGZM4A4s/fY0WXZZyQe52CCBvjb/jBofxqO5Ar/lm4pgYPE126zAigZ53I4sLRzANKf/BsH+9FXviPVrB5g66z0tnQuCVIxzJg5buSVYBl6wo+8Az66VWuxA1LtuSfo3hsGJqfLrl3gdhqoRus8wmbGNPfSH3QPDn23fpQa8tdbzklNrcSIq1oF6MPAS5H+DsTq/8jT5+pi+8HGqemc6AvMpQ3XT9QVjIYclkWoMWHMKEdcphrYNTC1FOQHsIuEyw9zo88ii+QLTwj3C0glNG4pc80p4am5/35hcUyRbQQ8nJJarqXiI0KjycLbVz1j8UQmsm8rWe8VTPzWk2zxI6vjJEKcUi5rnC6r/MIk+e3HZeN13dnmnQDwXv/il49qL73ne9kLgA4VLUqbIQnSeGTLOuA/X1ZKbOu5tf8IIvyXh0WqXci+7gidmo1LTKlwOCMJL12/2sjgDIjV2QJrb9hbUYbeToSbUtuGOGJUoDmGV3HZSfY1kV+NBw4Ug6cL4Y+2/XuAes0Cm5HgqqwwdVP+7S5xQoKb3GsnPjb7QB7Jp87m//+X1y3ubYxypBI3eHoS33naf5yeGb61x5eCPDvs5H2AdDwJGGqZpqAM3NzVopuPeB47cusj7ZVSJi17f8LMVvVAyXWxpgR7QLKXREVhvEqecADkt55ina5gIi26Ttup+VzR1ceQsDsSchFCbusekhdYnPhMLcLCth9ngxjGU2Zx5/7YZxyFuqf9gkZDFFKUJmLZVnT9O2Lsnq7f4VB/pb4Y508Hg==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(14060799003)(36860700016)(376014)(35042699022)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	j7TaNfvMYgYkAe+UrwJyXMn5a7MqOoZjWJvh5HNGrsI+FVQlSVUH+0D2yPm/BatkXT2VzR2cWMZ01RDf/b2Sf36RYST0VksYdysF9/AtXmbt1l9UQGeYRM1JHUTkfcOLajQXjCbFVQzmEa9ER9tsF3JjPG/CS0AhW5RxXdNNz2K6QcxVJRkPN4/nA+/5CnnE4p0f4x7I4MfWJUO0+cN+EHwbF3nBpd0/Z/llcGuq/9lJpHBHPJvTq286ocmIOC47JjInkZ9s22fJTpNGDcQw0ljDprmcRaZTss2lZzlclyMZKVc+h8qmUMRizhlm8euPsC84XS415dAh8IqnRQ5GnlRyDB3rIUD98J9A5SgxqbNbjnw2Klo5pZ4H7zWW3qI2HRs+X/rVIlGnun6vhpxo0SMDtnNkWOxIURwFvQqnKvaJ2WY9NNEVgGQZRmUb1A7M
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 14:55:37.2557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2306b4-7520-42e9-8c10-08de8690bf1d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB11866
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,TXREP,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

SGVsbG8gQ29yaW5uYSwNCg0KT24gTWFyIDExIDE0OjQ1LCBDb3Jpbm5hIFZpbnNjaGVuIHdyb3Rl
Og0KPiBPbiBGZWIgMTggMTI6MDUsIElnb3IgUG9kZ2Fpbm9pIHdyb3RlOg0KPiA+IFN1YmplY3Q6
IFtQQVRDSCB2MiAxLzFdIEN5Z3dpbjogU0VIOiBGaXggY3Jhc2ggYW5kIGhhbmRsZSBzZWNvbmQg
dW53aW5kIHBoYXNlDQo+ID4gIG9uIEFBcmNoNjQNCj4gPiANCj4gPiBUaGlzIHBhdGNoIGFkZHMg
dGhlIGRlZmluaXRpb24gb2YgdGhlIFRSWV9IQU5ETEVSX0RBVEEgbWFjcm8gZm9yDQo+ID4gdGhl
IEFBcmNoNjQgYXJjaGl0ZWN0dXJlLCBhcyB3ZWxsIGFzIG1ha2VzIG1vZGlmaWNhdGlvbnMgdG8g
dGhlDQo+ID4gZXhjZXB0aW9uIGhhbmRsZXIgcmVzcG9uc2libGUgZm9yIHRoZSBfX3RyeS9fX2V4
Y2VwdCBibG9ja3MuDQo+IA0KPiBUaGlzIHBhdGNoIGlzIHB1enplbGluZyBtZS4gIFdlIGRvbid0
IGhhdmUgYSBUUllfSEFORExFUl9EQVRBIG1hY3JvDQo+IGZvciB4ODZfNjQsIGFuZCB3aGF0IHlv
dSdyZSBhZGRpbmcgYmVsb3cgbG9va3MgbGlrZSB0aGUgX190cnkgbWFjcm8uDQoNClRoYW5rcyBm
b3IgdGFraW5nIGEgbG9vay4NCg0KSW4gdGhlIGNvdmVyIGxldHRlciBJIG1lbnRpb25lZCB0d28g
ZGVwZW5kZW50IHBhdGNoZXM7IG9uZSBvZiB0aGVtDQppbnRyb2R1Y2VzIFRSWV9IQU5ETEVSX0RB
VEEsIHdoaWNoIHRoaXMgY2hhbmdlIHJlbGllcyBvbi4NCg0KQmVzdCByZWdhcmRzLA0KSWdvciBQ
b2RnYWlub2kNCkFybQ==
