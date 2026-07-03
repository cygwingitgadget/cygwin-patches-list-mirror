Return-Path: <SRS0=7IrX=E5=arm.com=Mate.Dimand@sourceware.org>
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	by sourceware.org (Postfix) with ESMTPS id 1C9FA4BA23C9
	for <cygwin-patches@cygwin.com>; Fri,  3 Jul 2026 10:34:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1C9FA4BA23C9
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=arm.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1C9FA4BA23C9
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c20a::7
ARC-Seal: i=3; a=rsa-sha256; d=sourceware.org; s=key; t=1783074854; cv=pass;
	b=R9pXccMVWITJbqMcOF4gacbJc3OH4V/b/m6juj3ITJFWua5QmZNLrPsd2avpiI4bu70AZ14qxALde2ExpeAblk2K9Y3nn7M1vjiY8B0UmPIbWyovdArEgsaKcKPKwTyX1XPjnrpwzZ4fKqOvGvfqs/9QRS8IM2hYg0DlJU+Yjms=
ARC-Message-Signature: i=3; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783074854; c=relaxed/simple;
	bh=b77OaYcLYSW5onxAgu7pi8CiE+Yph/+RQnW8BCZIzjA=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Date:To:From:Subject:
	 MIME-Version; b=V8ZPonx2Z8pqCVQv5mBAPDrpD5Y4HDhc1ZhYy5ai7Mb6b1HnOuoW7SpHHLiKbMFaNHB+NTkKUFemit4TDadqhMJjTusHOGTFXrdDLpBEV1/ewA3Pt4xrE2F1MAGh6X//00MRwxj7r4UPj3lDAusbKDOsOBviPhWRKS/0uBI77E8=
ARC-Authentication-Results: i=3; sourceware.org; dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=JEO7FUl7; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=JEO7FUl7
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1C9FA4BA23C9
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=JEO7FUl7;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=JEO7FUl7
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=XnPuX6FQTzSbIODJnVmaLDTZWpzNrCLeoQZELtf7Y++n5MoVIQs01EipNdTI3Nm7nt7zLRrLSCbNAQwesadZCRb5wizmzdnPEwxSOChuWaz6RU8nA4BI7K7lLFfHKtrXwQaMDMRhoYx1wSAb2yZJNPw/MLaLOgw9YJ/Sf0AsUIMQrRB4B0EwtSDouXf5KXBkDqCnehPmJU2ld4zkrhVJlIeawb4RL2GsEHG2lHkSMBr7OCRpRovwQeOa3fjhu7PSHlUWs5FsBuxE0B7wyFVU6qKt4+QcNdWu+SvmZZ1DnZ2URJatLgS76I36KbW4smqJjUXEyt6ClzLfG11E26lVvQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nemfEM4Ef2QyxszzkiD/vXFWKLiXGwfW/OCRzFJhFLI=;
 b=UarR9gDWmzm2lTY353arhGKo5OruJ4OQvsAoReo8Vlovm1bsmGFTTQDVvk2U+AzAe3DF16HOj4/qzf6YrZssUprS1+O4clOK5xakuWpvX0IjXzFsmJkub0MZVa7vKBZUtwYCu72h0kBOT/l2ckeYECryHnIwnTw5K5ssBBzOemF/xXXVgGc1uKWYGD58oNccEMr6qSVvLSwKpQTnv/b6fuUl0/Jp2z/cz8CaUgUe/JuFbM4vJV0j8fHDeBC95g0h3/bSxgZrqox41mA8ntcLjFkWw98wPvkjZtRVWqOjod6SASV7O5bNt4iuHl4dv04g3SmGf9iA+oqsc1dFD0rHsg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=cygwin.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nemfEM4Ef2QyxszzkiD/vXFWKLiXGwfW/OCRzFJhFLI=;
 b=JEO7FUl7j2JM0Fsq/54Xikf1Y57Esy8EMDpevGBgPXvP2094OLTQ5zQeuQpNWxXcQkTv3yexM7ADJhc8D2QOYYmz6aAl32JymShwD3V39pK7vJ0fA317QSp0DCp/bd5cH4M+vHOGZjYKWz2fZx2eugju3xpF1wNHL0nHYiKaoEI=
Received: from AS4P190CA0014.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5de::18)
 by DU2PR08MB7343.eurprd08.prod.outlook.com (2603:10a6:10:2f2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 10:34:06 +0000
Received: from AM3PEPF0000A792.eurprd04.prod.outlook.com
 (2603:10a6:20b:5de:cafe::1) by AS4P190CA0014.outlook.office365.com
 (2603:10a6:20b:5de::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 10:34:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A792.mail.protection.outlook.com (10.167.16.121) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Fri, 3 Jul 2026 10:34:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqTsAvBQqcXoC1HwJF2o5Qs1iuBaVqZv3GCrerKkBYExzl2dvpCEybdsGUsCC4gf9m75N9m3nUgXJiZoEwwoYhuotxFz6y+g3KomfO4KfpPPQbNwqgxRcBvJlmYJpqHjUCddoJHWSlplnG6n4prm+y4+x5Oo87p9pP8Jb2Kew9ROhtq/mdiSM/SuXig4oJLJn5I58vJwTUUGLtvTc9sgpHEV2EXcPXYWdr3yy47iajfw5SjBxdOxVsojYOylZAwy202yck/FHyVueJgpPatkXq0i0vB2UcL5JHyWg8qXXYfDw1TClMXVa4tYxgWLX/eNHVs8ZgRBlDZ+svh0yADUdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nemfEM4Ef2QyxszzkiD/vXFWKLiXGwfW/OCRzFJhFLI=;
 b=rGhUUoFczKSGIe2TedeAsCHxdjA28e9f2qNZDxU1RL9bW2femVF9/Nj7qT+QdDkd/3qdYIqKQqgSWg4ZZ4OMlA0GwrgQSeiWK23IJN5chTw3T3F/wZuSo39+F3slI15idzC0k6OYAtNyYk/yaCy0lwL+Vn3wimcZKKjkqdf9hkNmYckFOMVP9bjPPFW/AhI7we9S8CWO20fMhksrl9OPDoXtmvYoiqRnJy/Sa9tLrkpJCYbpdeuzQCtRorVj10Tccia/swYO8qsoAxvt0n0X2LKmXgi5dSq1kaiBtHXcRNaWfa7Zxws1tdQktHw6oSbuUWVDvPAxV3PJvfg5C9EVeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nemfEM4Ef2QyxszzkiD/vXFWKLiXGwfW/OCRzFJhFLI=;
 b=JEO7FUl7j2JM0Fsq/54Xikf1Y57Esy8EMDpevGBgPXvP2094OLTQ5zQeuQpNWxXcQkTv3yexM7ADJhc8D2QOYYmz6aAl32JymShwD3V39pK7vJ0fA317QSp0DCp/bd5cH4M+vHOGZjYKWz2fZx2eugju3xpF1wNHL0nHYiKaoEI=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB4PR08MB9310.eurprd08.prod.outlook.com (2603:10a6:10:3f6::22)
 by DU0PR08MB8397.eurprd08.prod.outlook.com (2603:10a6:10:407::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 10:33:03 +0000
Received: from DB4PR08MB9310.eurprd08.prod.outlook.com
 ([fe80::73e6:2715:9ac4:e576]) by DB4PR08MB9310.eurprd08.prod.outlook.com
 ([fe80::73e6:2715:9ac4:e576%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 10:33:03 +0000
Content-Type: multipart/mixed; boundary="------------w7t3ugrWFcb3q4lao01HrkVg"
Message-ID: <4635aed1-eceb-4540-9071-2a4cd257b27c@arm.com>
Date: Fri, 3 Jul 2026 12:33:03 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: cygwin-patches@cygwin.com
Cc: nd@arm.com
From: =?UTF-8?Q?M=C3=A1te_Dimand?= <mate.dimand@arm.com>
Subject: [PATCH] Cygwin: gendef: fixed AArch64 setjmp storing incorrect frame
 pointer in jmpbuf
X-ClientProxiedBy: LO6P123CA0009.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::12) To DB4PR08MB9310.eurprd08.prod.outlook.com
 (2603:10a6:10:3f6::22)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB4PR08MB9310:EE_|DU0PR08MB8397:EE_|AM3PEPF0000A792:EE_|DU2PR08MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: 311a4491-0c39-441d-b00d-08ded8ee9b78
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|1800799024|6049299003|23010399003|11063799006|56012099006|18002099003|4053099003;
X-Microsoft-Antispam-Message-Info-Original:
 sp0ewQS6iZnrITDQQ0rPHpECWwtTqREJJ37jAlT2oSOnS/X0LunwObs39pgsWiuQzrQgG5Ck/3OnMletOAZmbGk+wVd/iyHcqFpC+4pFbRhVsRfNYya63FfS2D99jiMaiWlrEI0bs2J1v1fYJU3D2vQ7zicNBWFj01t5IWFsELjqmX05L6eBdD04QzQcx+hO0C3qpgh6z9HR7MBvaIVIN0OElR3yXqPfL/iB9pOH9SgcpFY9Tj6EeAgYfdRRzIm4mbhfxX2mIJyAPGhSRe07XdqOGm3/fxhT2mnf07huNHrOq1jph5PoDQXb4jEgIflS8V9gA+ltegZVyNOYtK9/wiyeBZP915f0inwyV/tSZa0m/5Qq/J7OTUsqD9RbZGbNWbOssd0oRN3aYfBYeyWWwEAoF98/pGyxP9KM8A1kC36T49VDraFbdVk2V4wfh3xyi8TZpccvr8X3d286aaBEDOklrxhyB7++MNxQuuCMybYBc/4iLOcVayLux+oMgY3YQH8OkdRq/N2oNS8KAHpIIa3+M0+Oqck1UtvnZGiZ/AELx+aHY57IVnH9lNl1vbxYZfluR94yTiOARKTdPkYiKwSy0pdYAeCGde5JKQog2Z+C7UGASRAKHu/vOSDSqCE2Wmfbp5zfUcaR7x852zj8sg8y3RRsVzdMqWFSp1QOHb0=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB4PR08MB9310.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(6049299003)(23010399003)(11063799006)(56012099006)(18002099003)(4053099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 qqN63HXl6UMxrvf6Zz7LnJ1HtAPXcsNnPK7DzJl+NC4+3dMhyu9xziGZHccfJdP01ICjZndSQJh7qfyOV/NkEYwE7CaFfltZDION37/ziy0yy5sKNhD32xeLSIJp+fwfBVSRN+GiVQvqtBryDo5sAD7nUlMEzjjnj+1bgMmlXdL15k6MqtxH9RHKfs+v7X7qeo0LK6DGDU43hxMYcpnyYrigARnOOZkruB3cCLJVzn8nyqjGr0fMGH4dbSo8v/gj6eRk63fcLjvw+Etzsre0W253hFjf90htU5N8Iz47PjvAZUVSgJA6YAc9fom/z/mob4Nqc10kaYDZ0xY7tztXJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8397
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A792.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4f188652-f4b5-4914-4587-08ded8ee7616
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|376014|6049299003|1800799024|14060799003|35042699022|36860700016|4053099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	ew1dDwW0dGnAcHU1OyubyW7s8Vj14qTViwv4Sz0dxkj65MbYB3slQ6hJ9tVyC8xB4m33GTAZm8vsfz/pdVsHlrgsfPQYjGF/d89EwbJT4tkd6H2VYw/AUvKhcTdXYWuPpNPZoR3/UnBzMbyrmkgJH24FvDBfSGcQO6r5h7UjWRFLWzYmppVKpE1rSNlq6UVqLGzTusfB34Ml0Kat0Zlke7/TNE9jF4w+xPtYMPqu7BBfcDR46c4rDIljj4GihrkUlx+sS5R7xssUSTmOxP614lrbHqMuKAMBi8F4m0k35y9N5g/zwQqinHXfaZrgyEJWFmRGvwa14TD9uXaZdh/psFQQYCRtHpVHqhq8FziB+NvjR49yIYh76cc1AolYljmBQ5i3V4qwIys3N0gNvUcnt38D8pwxn53q2pCkNgyYOafH/CFedgl6wIt221arGoFY3O165+NPOSdzys+DLZZmbSwjGt2LrcD6AV7fP0Y0Bt87rK+CeZdrIEb6q9SsU5DUz1u5sdIGk1I26ynfWWeRVdkCuovmszaKl8lP21jznvXvk1kg7jGYrQ4O5D7Nq5SdfpxDUYizGKkWhGbeQj+81axcUwLcvRdOai6INjOI3n92Dwk2jY8c5TFqQkJ/lvKnSE2v2L4mC7AC/VtPDgFt4f0hqOHP2DFFrgA4LLdzA33r9GERt7RlUJSpHNWHDr5YJKO9mkR60+Or9Rx2FJg5Ng==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(376014)(6049299003)(1800799024)(14060799003)(35042699022)(36860700016)(4053099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BS9CC5yjM7tcXAfp6M6ji8H9yX8PeYei6kVb4ued9TClH1R0EPUUvVwO17PlwUtQtUlS3pniIztxSzYkEfCTNxXuS76eydAT2XPrzzNicbd/2YW4er3SFtlFvPkrbQXnkuK9wHnowmLqncHCDWI4VuhGXnQjD53++OWp9QQXbeIpgMo/Y8tjY5f2aGmLJeIers9YtmuC3uy1qE0S72MzA7tx7L26n+JuiHXF/8DzqBZd0KSWUTsZDMdkasi4L+sbGhuohTIOA2thpHBTRbqQNzQGFxWfx875eKQVvdx5ZE6BkGFLPGqgKHV8cWbGBqVArU+6hzYXAkGuTEGVIT27Q69OIWaHqe/XcphmoCr+Sq8KZQoaRbsd3H4+bsVnMocBfP6OM8uiVtS5O6N6mGkpChn3OQZpl6gJS8NwkEfkkpaVlp4l8+RCnxe+7Tv6bkIQ
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:34:05.5055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 311a4491-0c39-441d-b00d-08ded8ee9b78
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A792.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB7343
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--------------w7t3ugrWFcb3q4lao01HrkVg
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

This bug caused testcase "mmaptest02" to not run properly, because of the
exception handler not being ran at the last access violation, presumably
due to the frame pointer being incorrect. Fixing this allows the process
to end gracefully.

Signed-off-by: Máté Dimand <mate.dimand@arm.com>
---
  winsup/cygwin/scripts/gendef | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/scripts/gendef b/winsup/cygwin/scripts/gendef
index 7097da2e6..1c3218d18 100755
--- a/winsup/cygwin/scripts/gendef
+++ b/winsup/cygwin/scripts/gendef
@@ -881,7 +881,8 @@ setjmp:
      stp    x23, x24, [x0, #0x28]        // save x23, x24
      stp    x25, x26, [x0, #0x38]        // save x25, x26
      stp    x27, x28, [x0, #0x48]        // save x27, x28
-    stp    x29, x30, [x0, #0x58]        // save x29 (FP) and x30 (LR)
+    ldr    x1, [sp]            // load the previous FP from the stack
+    stp    x1, x30, [x0, #0x58]        // save previous FP and x30 (LR)

      add    x1, sp, #0x10            // get the old stack pointer
      str    x1, [x0, #0x68]            // save SP
-- 
2.50.1 (Apple Git-155)

--------------w7t3ugrWFcb3q4lao01HrkVg
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-gendef-fixed-AArch64-setjmp-storing-incorrect.patch"
Content-Disposition: attachment;
 filename*0="0001-Cygwin-gendef-fixed-AArch64-setjmp-storing-incorrect.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAxMzhlZTA1ZWJiODNiNmM5MDhiNGUzZWZiZmM2NzFlZjY2YTcwZTNlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/TT1DMz1BMXQ9QzM9QTk9MjBEaW1hbmQ/PSA8
bWF0ZS5kaW1hbmRAYXJtLmNvbT4KRGF0ZTogTW9uLCAyOSBKdW4gMjAyNiAxNDo0Nzo1OSArMDIw
MApTdWJqZWN0OiBbUEFUQ0hdIEN5Z3dpbjogZ2VuZGVmOiBmaXhlZCBBQXJjaDY0IHNldGptcCBz
dG9yaW5nIGluY29ycmVjdCBmcmFtZQogcG9pbnRlciBpbiBqbXBidWYKTUlNRS1WZXJzaW9uOiAx
LjAKQ29udGVudC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PVVURi04CkNvbnRlbnQtVHJhbnNm
ZXItRW5jb2Rpbmc6IDhiaXQKClRoaXMgYnVnIGNhdXNlZCB0ZXN0Y2FzZSAibW1hcHRlc3QwMiIg
dG8gbm90IHJ1biBwcm9wZXJseSwgYmVjYXVzZSBvZiB0aGUKZXhjZXB0aW9uIGhhbmRsZXIgbm90
IGJlaW5nIHJhbiBhdCB0aGUgbGFzdCBhY2Nlc3MgdmlvbGF0aW9uLCBwcmVzdW1hYmx5CmR1ZSB0
byB0aGUgZnJhbWUgcG9pbnRlciBiZWluZyBpbmNvcnJlY3QuIEZpeGluZyB0aGlzIGFsbG93cyB0
aGUgcHJvY2Vzcwp0byBlbmQgZ3JhY2VmdWxseS4KClNpZ25lZC1vZmYtYnk6IE3DoXTDqSBEaW1h
bmQgPG1hdGUuZGltYW5kQGFybS5jb20+Ci0tLQogd2luc3VwL2N5Z3dpbi9zY3JpcHRzL2dlbmRl
ZiB8IDMgKystCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
CgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9zY3JpcHRzL2dlbmRlZiBiL3dpbnN1cC9jeWd3
aW4vc2NyaXB0cy9nZW5kZWYKaW5kZXggNzA5N2RhMmU2Li4xYzMyMThkMTggMTAwNzU1Ci0tLSBh
L3dpbnN1cC9jeWd3aW4vc2NyaXB0cy9nZW5kZWYKKysrIGIvd2luc3VwL2N5Z3dpbi9zY3JpcHRz
L2dlbmRlZgpAQCAtODgxLDcgKzg4MSw4IEBAIHNldGptcDoKIAlzdHAJeDIzLCB4MjQsIFt4MCwg
IzB4MjhdCQkvLyBzYXZlIHgyMywgeDI0CiAJc3RwCXgyNSwgeDI2LCBbeDAsICMweDM4XQkJLy8g
c2F2ZSB4MjUsIHgyNgogCXN0cAl4MjcsIHgyOCwgW3gwLCAjMHg0OF0JCS8vIHNhdmUgeDI3LCB4
MjgKLQlzdHAJeDI5LCB4MzAsIFt4MCwgIzB4NThdCQkvLyBzYXZlIHgyOSAoRlApIGFuZCB4MzAg
KExSKQorCWxkcgl4MSwgW3NwXQkJCS8vIGxvYWQgdGhlIHByZXZpb3VzIEZQIGZyb20gdGhlIHN0
YWNrCisJc3RwCXgxLCB4MzAsIFt4MCwgIzB4NThdCQkvLyBzYXZlIHByZXZpb3VzIEZQIGFuZCB4
MzAgKExSKQogCiAJYWRkCXgxLCBzcCwgIzB4MTAJCQkvLyBnZXQgdGhlIG9sZCBzdGFjayBwb2lu
dGVyCiAJc3RyCXgxLCBbeDAsICMweDY4XQkJCS8vIHNhdmUgU1AKLS0gCjIuNTAuMSAoQXBwbGUg
R2l0LTE1NSkKCg==

--------------w7t3ugrWFcb3q4lao01HrkVg--
