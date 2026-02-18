Return-Path: <SRS0=jALY=AW=arm.com=Igor.Podgainoi@sourceware.org>
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	by sourceware.org (Postfix) with ESMTPS id C39934BA2E1B
	for <cygwin-patches@cygwin.com>; Wed, 18 Feb 2026 09:44:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C39934BA2E1B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=arm.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C39934BA2E1B
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c200::1
ARC-Seal: i=3; a=rsa-sha256; d=sourceware.org; s=key; t=1771407894; cv=pass;
	b=qo1ynZkQ3AiXkuW3meksZgrbKkZ/umx/mU7U08H1VzfuztfD7XbUDnYDGEyy50sNLrDd0hNGF3kyA3+cAgH1Zyut4Y/ewJ78om8DTPv05lnJnp5y728oq0YMY/hi44z2E9M/D8jLaEg3Owd8QicHWdNTGqCq26wMXkzmCgE9zRQ=
ARC-Message-Signature: i=3; a=rsa-sha256; d=sourceware.org; s=key;
	t=1771407894; c=relaxed/simple;
	bh=XNBJ/LGuDDGt5d0DEZvV6IdfqgCos0ozz4G1kt+NInw=;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version; b=Wts7KvJS8S1lgHECaQIPgdFQgztAHB0WJXjghaVMA0L+ehl0XU06QNekjm1Y/4iwHjGACEJWPuIYf4SXsNyJXXAFv3Ftc0qqdrGkuaPsmHWX0ZN4gnaThJCrZ4l03ZKVcHoSnKDhosPXbMRbApW/S4ttN70Axv8qAqksaxEMzgA=
ARC-Authentication-Results: i=3; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C39934BA2E1B
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=ULJFmR+2;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=ULJFmR+2
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=L8n0fWMZ3bAIQ5hABG9Yklx4CnzoeuOfl6DRhq0O4vXnKQIQS2m59AN1Q5kbyO7NLKRLwH5CwKbW7rxOH4oycgO+GXrPpLVovhdV4bYGFZTEKrNqtpcD5kutjCe32uffEtWU/drN/+qoXShVgxnVthIvHzxcCkS7WHZCUd/pjj22laf3K9HclPfOcXT6BS04BUJaV9EdwuIzSW8MkXRKhEf9p4zkUsbbkM1Zt2IUqSArI8Di0n+fPI5GNX/UOWoLdUA1mm5S9W+HvPNvQJ/9YslVDbW3EIQKWgrzbIDQgfHKDt/ifvUdyo1lAkLqt+ldMzRjo3sHUuOXKY2/N2+GgQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNBJ/LGuDDGt5d0DEZvV6IdfqgCos0ozz4G1kt+NInw=;
 b=Znu6Dnvt1q42Q0Bj9csnxLg/8/6l4NtwZ3TOQ8H4O9JCsfxJsmqG9hB+hNomQA+8r/cTtv9JJ1lxVSpMswVQSarDOpNWJqIlg4lr4++2LXBas6+9ZBUjhf6ychKD4sn1603kWWT0XCf1VDDmoYLmW6EA04nGcBokERa4u+y/4DqPP7TG4tGHgr5P217w89rjewpnKcR0NojHalsGLLyp8MZpSHPRlpG3j+pOV2CrC2mBOBuWOVFU06VHRiOxk3V4BRHzRpp+LPBz0YBzrDm3/iZh1liQ2fhEaRXozJ0074oAPsMyALExVfB9yeDZPWitD8LdNP4N6Dl5Ojbb7vfKFg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=cygwin.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNBJ/LGuDDGt5d0DEZvV6IdfqgCos0ozz4G1kt+NInw=;
 b=ULJFmR+2TprNfDgUYLGoGk/xSTvEMSiEQQHUNI3vbvTOki2VRz6ZlqyRhaE9WYkejDq/Xga46Q2lWoOmodZ1Y6wJ5aNJAJsMLHfD2Qwyg09wnAHqsm79LOtKL9LVeK7Qk8TgwmC1LJi344gniHSZ8P1UhPyrPhe0NAjD83SsBzk=
Received: from DU2PR04CA0201.eurprd04.prod.outlook.com (2603:10a6:10:28d::26)
 by AS8PR08MB6151.eurprd08.prod.outlook.com (2603:10a6:20b:290::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 09:44:47 +0000
Received: from DU2PEPF0001E9C6.eurprd03.prod.outlook.com
 (2603:10a6:10:28d:cafe::34) by DU2PR04CA0201.outlook.office365.com
 (2603:10a6:10:28d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.17 via Frontend Transport; Wed,
 18 Feb 2026 09:44:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF0001E9C6.mail.protection.outlook.com (10.167.8.75) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12 via
 Frontend Transport; Wed, 18 Feb 2026 09:44:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfIxEpW3K2WO/CWS+FAJFCks/+444uk9R6XrVbJX8SHHFcrOXdzX/b0Xu5bHu1f9Xe1AybL1/w9hxvkcpdNETT7pMA/90GQjWJwxexk3xnnqTRdg/Ixms34FVnrCYnR3Domoc3E5zigm+Q4Gv+61Bh0d4C4PjcISd450U3em1BzYxuUeuwjOOvfAh1gkgDiAfURfGd8FjPGiJ7zewMJRgsXkPsvs9oC0pe3ZJd6v4nFAozMgwPTXJT71zDbNIS5zoSDCg1u8qWa8fuOVFO0vv0eXXMm4xb/3fv6Zr/06dmgHOhAQn+uY1DnWEiFyi81fK84sTfERgQz2EeWUKHaTmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNBJ/LGuDDGt5d0DEZvV6IdfqgCos0ozz4G1kt+NInw=;
 b=IhqiQnQyMgFkuPd95FSZTJUbLqh7YgOHHMFSZ0mmYwn2VbAZAsmYRAoTFU2GqDZ2D+eej3OhRYHrYCtVgfUs4xzCJoHjFdow3YNWglgudz9o0mTHmCNZ7eTtCIpniYr0722JeNt/vx/QViYxLLdaNVbaJEuHJpuR/q/z8Cu/bjQF05T/pozWEx4zv25RbSWt+07PbEiqXPd0nPoA4uC9Z8gkAbo4TW0rDY114jgUf488XL5IDTqDp4kx+S4e16X0E5zDosCiK+/dSP/S6hj1pnrN7TyMJPPdvfYmHxU+9T+YOPztgVsVXWr0ZDvNZvwELhSpfDowmBG50smLojhsFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNBJ/LGuDDGt5d0DEZvV6IdfqgCos0ozz4G1kt+NInw=;
 b=ULJFmR+2TprNfDgUYLGoGk/xSTvEMSiEQQHUNI3vbvTOki2VRz6ZlqyRhaE9WYkejDq/Xga46Q2lWoOmodZ1Y6wJ5aNJAJsMLHfD2Qwyg09wnAHqsm79LOtKL9LVeK7Qk8TgwmC1LJi344gniHSZ8P1UhPyrPhe0NAjD83SsBzk=
Received: from PAXPR08MB7247.eurprd08.prod.outlook.com (2603:10a6:102:212::7)
 by AS8PR08MB10246.eurprd08.prod.outlook.com (2603:10a6:20b:63c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 09:43:41 +0000
Received: from PAXPR08MB7247.eurprd08.prod.outlook.com
 ([fe80::e2f7:f38e:3321:44fe]) by PAXPR08MB7247.eurprd08.prod.outlook.com
 ([fe80::e2f7:f38e:3321:44fe%5]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 09:43:41 +0000
From: Igor Podgainoi <Igor.Podgainoi@arm.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: nd <nd@arm.com>
Subject: [PATCH] Cygwin: open: Fix Windows resource leak after fd exhaustion
Thread-Topic: [PATCH] Cygwin: open: Fix Windows resource leak after fd
 exhaustion
Thread-Index: AQHcoLsQ/Xmi5UEvYU6Kb6dKMERetQ==
Date: Wed, 18 Feb 2026 09:43:41 +0000
Message-ID: <aZWJymeR-iwCYR1p@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	PAXPR08MB7247:EE_|AS8PR08MB10246:EE_|DU2PEPF0001E9C6:EE_|AS8PR08MB6151:EE_
X-MS-Office365-Filtering-Correlation-Id: ae4be644-67b6-46ce-695c-08de6ed25a95
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?b3BPRGFMOEVoQkRBSU13d1J6VjdJRytPd0lzUmo1U2xTNUtLWlBVaU5QdEp0?=
 =?utf-8?B?elJPZDI1emFRYnIzY1Jrb1hOck11WFY2L2E4YmdSVHFYMnExaDl2a29meUdE?=
 =?utf-8?B?ekl2Rkw2S1ZobS9WUFNleUh6QVo5cWV0YUpHVnpLbWRkRmY2RmVhY1lTcFpT?=
 =?utf-8?B?UHQ3SklSeGtZYS82TXlONnZlZXBNYnJESmp2ZXpUNmpmWUhSRi90QXl1VjJO?=
 =?utf-8?B?OXhhV3cwRUlZQ0pjZVNyR2hpcUdDcmFkZGQ0SVpTZUxiM2NHWGV3VWlZOG9p?=
 =?utf-8?B?Q1VpSk9JZmx0OVY0L3g5UWs2R1h3aEU5am81T3dzRVpwV2hDcTh1VUZuUGh1?=
 =?utf-8?B?eHRrakVLd3BLTjVZMU9FYkkwd1RHYkhiSTdwVS9ZbEFQOXMvZXVqK0xEMFFN?=
 =?utf-8?B?RG5zZ29GckZTQ0pVNUxyMWEwTjdzbmtmem5yUkRrSlJPdHk3MEczUGlQTzR2?=
 =?utf-8?B?MW1KdURBRHprRTRqdkJLNlYvd2NPVFl3VTA2R2dmZEtqOUJaQVZidXdTNmxu?=
 =?utf-8?B?L1pzMVdkUE9lSXhDUGpjUXZ1NXJzaWtub0VJTFBOQTF3YTJuMk4wU2tmdGI4?=
 =?utf-8?B?MU1wSHlUQUlnNG95akVpMUxnbWJ5UnNTMHp0QmsvNGdBVkM2T1JNbFNKa1Bu?=
 =?utf-8?B?ekErdWxsclk5VFBGaUt0VUlaYW1lWVNEbWs2dGxYQVdqTmpWemRUcjgyOE9H?=
 =?utf-8?B?dVdMeExtUXJYbTJSblRxRUhod0d2aEMxelBWcm43THZPcFJ2azF3eFgwSHZW?=
 =?utf-8?B?czFudlVyWlZDK3hnTlVsUXUwdFlNZ2dpOFJMRGJVbS9hRWNuaUpENVJXdnBE?=
 =?utf-8?B?cVFJTXBHWU11S011ZmpWZEo1Q1RqZTBwTEJ4bXdkUGRvL3lpM0VOVHZ1cElx?=
 =?utf-8?B?OGtHcW1CUWlTR0ZHblplc3NrSkVUTVRFUExnYTI4S21KQTg4dXBmTXM5ME9N?=
 =?utf-8?B?d0g2SFgxU0Q4azBOWWQ4Y1hHaEJZMkRFZk9iSlNCc0tMR25wdjVxd3FwNmRV?=
 =?utf-8?B?WUJVdTRBd2RyNHoyVUlFUDJ1VW05REpaTXp6U1hlc1E0cWY4d1p1ZFZYK3dL?=
 =?utf-8?B?UzM4MzI0ZysxYWF4UGw5bXRrSUpFckhQTTZrWkRKSUc3RzJ2aWc4eUFLQXAz?=
 =?utf-8?B?UVNsdlBrQlQ3bkg0UVFrbG5DNmNRRUt1VjF0Rmg1bDhhcjVPTVRJMXdZMFJy?=
 =?utf-8?B?cVB4RUczNDhORVRPKzZMSzBMQno2K2V6WEVTRlVGS3BBcHBwT3VOYlh3Wnkr?=
 =?utf-8?B?dWFHNHFSaXlJZUlGVkNXVUpBNGhISWRPazdheGQrWUNCQjZGMExhSWphVHNK?=
 =?utf-8?B?OE12NHhlYnIxYU5EOVliTjE2QzZkYVFLZTBaUk9WWjBaNnBmai9ZMWtRK3ZY?=
 =?utf-8?B?YUdUNkhBWVRtU3U0Z1JNOGMySFdNdnUyVWF0QUMvbks4MVNlRzVqenRJUU5I?=
 =?utf-8?B?eTJhMHJCbVNadDQ2bFFsT3BFT2prTlltbUhidlBlamF4OEhyeUQzdHFaS1Z6?=
 =?utf-8?B?OGlGVWRGMnZuZUszNkUvc3FHVXY2M2xjYm05YXhZd3gxMGRMdHRMMFNCZXFT?=
 =?utf-8?B?SUpobndIb0wrYlptcHlPYm53MmtHVlVycFhWZmNRSTd1K3AwUVhFQXJFbjZq?=
 =?utf-8?B?dzhmbTBhdWxLOTcrZUhwZ1pHcmhHVjlqT0h3UkhWTGpEVGk1WTAvSjU4ZkRq?=
 =?utf-8?B?OUpDNW9oaWw3elI5QXJVRkVWRC9LVFVoYTNzZG5LQUdYMXFBb2FrQXRBWStw?=
 =?utf-8?B?NTBGSEFWemdCdXF1SWxEY0o0d3ROekpzZUNrTlgyUkx0SHNuaXFJN2hxQjVs?=
 =?utf-8?B?NVdkMzN4ZFhRdFBqRUxkd1pOdExPV1IxRmFKdnNROGgrb1lINWY3NS9sNE1P?=
 =?utf-8?B?bnVNUm5BV2U4cUJyNjZrcVpmcjNUY1c3V2pGZkNTR0pEWTVoOEs2UU52aU5W?=
 =?utf-8?B?MUtkbFdqd1g1NHhmaThjK3RUL1dxWElOeE9hZGxOb1V0VnNNTWRJV0hkVGRQ?=
 =?utf-8?B?ajRXVEdQYnZYTjkzNWNiV1EwRldWWmVQeElvaWlBLzRXbnBSaGxzZWU5RUFD?=
 =?utf-8?B?b3NQVEFNYzRnUnY0aVU3Uk5HSFlOaHVaSFFXOUtFdEs0YjFreEU2U2FRakwr?=
 =?utf-8?Q?7uxr9nxxmazRWTmzSnhCdqf9t?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB7247.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B8FC51E86D63D4E9943F05A1A61D5D7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10246
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9C6.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ba0d6a65-15fa-422e-cf3a-08de6ed23340
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|35042699022|82310400026|14060799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVNIMlJLeUNkdmJQMjN5LzFjbTN3NWdoUjUwWUdpbmRtQkJGdG1qZlhib2JH?=
 =?utf-8?B?RkFMZ0lyVkVRWFpmWTdiRXpFVGFveU9DRjlVMWVsV2xndnlSYitvaFN5L1Bk?=
 =?utf-8?B?WG5yVEF5V2ZKampxVkFNbFFHaFgvTFcwL1haTlZvdXF1ZHJkMkF3bmZqK3Vj?=
 =?utf-8?B?S01qa095Y3cxM3lieVpsaTZVN1ZwZnZZeGVUcWNUWnYzd1cxcW44Z2VETDB0?=
 =?utf-8?B?QUZlcUgyMW4vQldzK2g3Vnhnb2ZEaTF2bUdreTBaeG5UaGpZYW55dnlucjBw?=
 =?utf-8?B?OU1kNjRsdzhOeHRsOGlzb1hlQktvM1FwK3hNcTI3dm40ck1zRnc4UHpVVmN3?=
 =?utf-8?B?UkFSSU5KcUZQdTg0MzBYWmM0ZDRVdEF6QTY0MmRvTmowYTZUTUdRc2wwaFpr?=
 =?utf-8?B?Q1VNYVc1MXErc0pNSHptQmVVM01PV1NFNk9qTzZhQk1NdVFuR0NWQWpTakRx?=
 =?utf-8?B?Z3NRUVZoNEpselV4dTIxa0E5ei9lTGM4UjRtSldDcTZKZS9wRjFabDFsL2xG?=
 =?utf-8?B?ak1rWEttc2xQUmNuQkZYcEFCelR2WjkrTEFTdTB0K1NIcE4zTE11KzJnTVY2?=
 =?utf-8?B?Z1JFd0VFbUJ5d2FDcjJoR3ZsVHIySy9TVms0V1RwZERaQjUwMXFhdEVSbmVM?=
 =?utf-8?B?bkx0V3hIZ2NtZGV0NVlGbkVVTGlwTlhta0NUNGRhbFJPdGxsc1oyL2dTdkR1?=
 =?utf-8?B?VzFOWTY2OXRMQkQ2aVdmcHJzbWtYd0UzakVMVUVIUWUrUHNVWFIzMXI0RitG?=
 =?utf-8?B?bmsvUzlQcXd3TnV3YjhuaGhXKzk1SGVuWWt2d3JVeTRwWVdMYmxrd2lWYjRs?=
 =?utf-8?B?RmUrVmNKMFpOT0ZzQkZHdXVzTDhBMDZ0bk4rM0tkQ0tMdHlqWFg0endNT1NC?=
 =?utf-8?B?MHQrYUFMUmRCdzN0YXdZY3V0SFNaQ0sycGF1SElrZHdMNGlER2tqOS9LcnhE?=
 =?utf-8?B?MkRRZFBHTEJ5LzZ4RmZQSkkvTTBSQjk2WDFFQWdFUGowcW5XcE5CdUhlNDln?=
 =?utf-8?B?SVhIMXVSNEd6RkRhY3pNS1ptOXZwcDVZVmc2cVJqTkNQb0dVcisvTTVESEkw?=
 =?utf-8?B?cUMrbEFOVThPdVJQaGN1b05KQm9OZm5vb3JzUm53NE1iU210a2ZSMkVrNWQy?=
 =?utf-8?B?WFVQMTlPLzRmUks4RnZrOFVuK3lkUUd1UVdJZmpZcjhtcld0aFQ2cmhyMU1I?=
 =?utf-8?B?aitSMFJuejBjQVUveTZsY2h0VEpveXhjOUhIMkJWOWRScGsxa3U2RmFOSDM0?=
 =?utf-8?B?YW44TzJrS1hRWEpUbk5BdVg1dlJUd21xVHd0VEh5dXQ2ZTFZUmszeStvU2di?=
 =?utf-8?B?R25CMHJQS2VaRmZYUVprc0pnaFh3RTIxcndiTEFpdW1BYTVSTjdZRm9FUnVy?=
 =?utf-8?B?YmlGcDFKUTQ4dmFVTCsxb3pQdUh1L08zSmZtcGJlUnluQjhYVk5hV3diMlZY?=
 =?utf-8?B?VnNkNnlidkYxQ1Z1M0Q1NFBDdVI1MDNPUnNNM1hDZ0VTak0vVlZZall4WHZN?=
 =?utf-8?B?N0ZXd2ZXbm5JeFFwOGc3cEcwOHNkUC94bzZvQmlZdmhGaUgxdlJneW50aUh0?=
 =?utf-8?B?M0h5bUpGMUNrWk10UUlrNEZMdzNXak0vUWQ4ekQxbzMvYk95ZUxlaGZaTGRT?=
 =?utf-8?B?ZEtIM2JXQXdCTDZWNnBlQmlkVnFxWHZzU1lscnd1a1dCNGJNb0QxbjRMT0c0?=
 =?utf-8?B?K1JRSmdqc29jZlRsQjNuUkxzUEdNdG9LdFFkTjUyQmljT1NINWhBMlNYRTgy?=
 =?utf-8?B?dU04Sk1jL3FWNE15ZTFCRUxnbkp2d3BYZDVqQjZ5MlFHNDZHcjk3QzZrT0N6?=
 =?utf-8?B?UU84cVlDSloxR3VUU3IzZVoweEVCTU16UG9aNndHbVZBOEFwclNJRDJsUWVS?=
 =?utf-8?B?VU43QVh2ZFRmVitFNHE1YStTQVBSU1FIcFRMendNVE8rcHpYektpajE4S0ZP?=
 =?utf-8?B?ZWlvWXlpSnh5TDQ3YmVsbEp3ZFh1dnVvZEc3VWtOQzdKV29QYmQzeDZDZERk?=
 =?utf-8?B?TXJ5TWxVdnR4TysyV0p5SjlySVRuK3BsQldnYUZiL0hrMTZYMEZjVEFxRGsr?=
 =?utf-8?B?U1dvUjZ2VEo5czUzM0M5Q2NjMldvVDlGUlM4djlIYTJPVlRnMnpieEpDR1Fo?=
 =?utf-8?B?UzFueUdZUWw1TUVtMUx0a0QwNm5Tdi82U0RnNkt0QmdHVHNBNGdleGg3ejVZ?=
 =?utf-8?Q?FJi9BxxZ8KUc1FICEIJpi1A=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(35042699022)(82310400026)(14060799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hmHPUSUXi1k4IFa9uU1tsoq/iZ9f4k8vyQOh25B9/D7Xav/p+QQQZ+/zPL97IlOKx/VSn1NZ47bN/JWaU9abiEZIk50pBSgMnpTSR6zia4jD4MGoeUtzdcTKQAT+tAcPOZ/0IFIE99J547uBug7aF7/j9LP5u3w26UaTZM5sk4iCXPsw4RCoQ2fyO9YSUifsXtEyrbtuIEKEdzuXek1AVVT5i/0/OP5LfES5QfwHBzTnJw4d9RGwXHfR15PNXUqNqVe5Qd+VNtRGprhNkpPAhl16Sa60Ue5G4QsrZzPn/ojyh2qYYWfu3kiAFjMugcoO/WQURv3jL3SW7UPP9hv6EubySCiVHEKQk9W8ThbmVLZ0VIhYCspwW/A/SGIcaAEYxbvUwwdGnIZAA/vdQ4tEmqxRAfSupJ6XhCbBtLRi1kOHNqMhTI0cBjAjB1cXS9fT
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 09:44:47.4761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae4be644-67b6-46ce-695c-08de6ed25a95
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C6.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6151
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

SW4gYSBzcGVjaWZpYyByYXJlIGNhc2Ugd2hlbiBhIEN5Z3dpbiBwcm9jZXNzIHJ1bnMgb3V0IG9m
IGF2YWlsYWJsZQ0KZmlsZSBkZXNjcmlwdG9yIG51bWJlcnMgKGVycm5vIHNldCB0byBFTUZJTEUp
LCB0aGUgdW5kZXJseWluZyBXaW5kb3dzDQpIQU5ETEUgaXMgbm90IGJlaW5nIGNsb3NlZC4gVGhp
cyBpcyBwYXJ0bHkgYmVjYXVzZSBjdXJyZW50bHkgdGhlIGdpdmVuDQpmaWxlIGlzIGZpcnN0IG9w
ZW5lZCBuYXRpdmVseSBiZWZvcmUgYSBuZXcgQ3lnd2luIGZpbGUgZGVzY3JpcHRvciBoYXMNCmJl
ZW4gYXNzaWduZWQgLSB0aGUgbG9naWMgb3Zlcmxvb2tzIHRoZSBmYWN0IHRoYXQgaXQgaXMgcG9z
c2libGUgZm9yDQp0aGUgV2luZG93cyBIQU5ETEUgdG8gYmUgdmFsaWQsIGJ1dCBub3QgdGhlIGlu
dGVybmFsIGZkLg0KDQpFdmVuIHRob3VnaCB0aGUgb2JqZWN0IGlzIGV4cGxpY2l0bHkgZnJlZWQg
ZnJvbSBtZW1vcnkgbGF0ZXIgdXNpbmcNCm9wZXJhdG9yIGRlbGV0ZSwgdGhlIGZoYW5kbGVyX2Rp
c2tfZmlsZSBjbGFzcyBoYXMgbm8gZGVzdHJ1Y3Rvcg0KZGVmaW5lZCB0byBtaXRpZ2F0ZSB0aGUg
bGVhay4NCg0KVGhpcyBwYXRjaCBpbnRyb2R1Y2VzIGEgbWFudWFsIGNhbGwgdG8gZmgtPmNsb3Nl
KCkgaWYgdGhlIGFzc2lnbmVkIGZkDQp2YWx1ZSByZXR1cm5lZCBieSB0aGUgb3BlcmF0b3IgaW50
ICYoKSBmdW5jdGlvbiBpbiB0aGUgY3lnaGVhcF9mZG5ldw0KY2xhc3MgaXMgbGVzcyB0aGFuIDAu
DQoNClRlc3QgZml4ZWQgb24gQUFyY2g2NCBhbmQgeDg2XzY0Og0Kd2luc3VwLmFwaS9sdHAvZHVw
MDMuZXhlDQoNClNpZ25lZC1vZmYtYnk6IElnb3IgUG9kZ2Fpbm9pIDxJZ29yLlBvZGdhaW5vaUBh
cm0uY29tPg0KLS0tDQogd2luc3VwL2N5Z3dpbi9zeXNjYWxscy5jYyB8IDUgKysrKy0NCiAxIGZp
bGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQg
YS93aW5zdXAvY3lnd2luL3N5c2NhbGxzLmNjIGIvd2luc3VwL2N5Z3dpbi9zeXNjYWxscy5jYw0K
aW5kZXggMWIxZmYxN2IwLi43YThlNWQ0ZmQgMTAwNjQ0DQotLS0gYS93aW5zdXAvY3lnd2luL3N5
c2NhbGxzLmNjDQorKysgYi93aW5zdXAvY3lnd2luL3N5c2NhbGxzLmNjDQpAQCAtMTU3Niw3ICsx
NTc2LDEwIEBAIG9wZW4gKGNvbnN0IGNoYXIgKnVuaXhfcGF0aCwgaW50IGZsYWdzLCAuLi4pDQog
ICAgICAgY3lnaGVhcF9mZG5ldyBmZDsNCiANCiAgICAgICBpZiAoZmQgPCAwKQ0KLQlfX2xlYXZl
OwkJLyogZXJybm8gYWxyZWFkeSBzZXQgKi8NCisJew0KKwkgIGZoLT5jbG9zZSgpOw0KKwkgIF9f
bGVhdmU7CQkvKiBlcnJubyBhbHJlYWR5IHNldCAqLw0KKwl9DQogDQogICAgICAgZmQgPSBmaDsN
CiAgICAgICBpZiAoZmQgPD0gMikNCi0tIA0KMi40My4wDQo=
