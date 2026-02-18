Return-Path: <SRS0=jALY=AW=arm.com=Igor.Podgainoi@sourceware.org>
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	by sourceware.org (Postfix) with ESMTPS id 3A8A04BA2E1B
	for <cygwin-patches@cygwin.com>; Wed, 18 Feb 2026 11:34:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3A8A04BA2E1B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=arm.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3A8A04BA2E1B
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c200::1
ARC-Seal: i=3; a=rsa-sha256; d=sourceware.org; s=key; t=1771414456; cv=pass;
	b=xtyJoX1fRbvb/MF8cQzCTYFmi0qj9ANmK+FGmIRUzoh/U6SQ/bdYN9q1SEq6jui07Va+mJQdWiDlZu2FP/5rL6sI6WTDb8ovf24XYXNDzXi8S6k8T7yIX8ZNTVBH8CGTqqMbw8lWYVQoWPeBi8+szIVkvIz1ylQXmiBp2jcOtzs=
ARC-Message-Signature: i=3; a=rsa-sha256; d=sourceware.org; s=key;
	t=1771414456; c=relaxed/simple;
	bh=o9MFRDobePTg0vtpfKLVI3FXGyIT5Wi9OXIPK+Qt0x8=;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version; b=qFladtM9fVbrX1+U3+1ZlGIhOyzAX6kHxQkCTi0s9aE00KleWyYaeHHjfRoVZvmoSx0BDDhT9uqDg/15OOS57K1slq5DMbBiuG85ZvPjf9gTenBezBgo3wWHcfXA+9SiC3deM60k6GlsWyROCBjr0HjUd/bIIPH5jqKN2eokeN0=
ARC-Authentication-Results: i=3; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3A8A04BA2E1B
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=DeMVKu3g;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=DeMVKu3g
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=rvyEXc/VuvPwXstQiIAtNcgZ4OnPUbecjAf4M5dxxjdJ8paC5ezTZi0qYUqH+jwdz5Wm8MEIe0f5CJVXivDKP+s3qdYAnDhLDiQzNjsI1ye+XjAB7SPIcK/RNBCow0eI2+Hzhq+dv9N/RsJ1y59PkyKbrqm+2HNALdsBNSnX+nWRL/TsMCfw4a3EqhMvJ3y3I3CpwLONgpcjEbPJqjUJOV5UvXfUsvn/2W5uHIdyRt5LWjQYz9msDjqkS3BoVFmxJwDyXx9zF0BxQPAO1LUaIdbJiFoBJEdv2uj8e8OVKtyQrcLCyVdjim1qBCdhP5/gJV6XCuvWySfEL9Dv/0j79A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9MFRDobePTg0vtpfKLVI3FXGyIT5Wi9OXIPK+Qt0x8=;
 b=vxa2coM2JNmHG5K5H4AiOkl1FDSmiZzAzuRsUs1e0o/ETyvFB9cyYCMrUOzJDlfqEpUyaRA1OXPgoL7C0VWd2Ufzzlyr7YcPg4a35Wqf4rXSQ2SPqhAuAAlHbg9P1rVORKyG2f/Sp1mlHbeedz7e5adzKN8i95pfrdw4F80aHXiL4wfv9arpyGcEZqD1iiloYXLIasX86Yee7hl9yDH+oNNvmSsDap4++ydkL5X89GSKZ1SCkyx5IdHPAH3TsepvTyeDGO0hl5EzgGCOrX9tfqfC0atUXq0P5DUHcvPpWlhaGs30Zr49W3dpiL+avOFrvXj2rT1vgF8GMg1bL8Aa5w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=cygwin.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9MFRDobePTg0vtpfKLVI3FXGyIT5Wi9OXIPK+Qt0x8=;
 b=DeMVKu3gKGiK1jDJ6ZyZRv+8AE80LsyP/eB/AW1PK5EIBF60U9LwtvxCqHI82QmYCLdPVKoYMPBSIWg2oQ7rhBHNoyts6j7T80UlS92aFROH7WLq9w093FRFmHPqMSmw2REPSmfbELOmFlvSTTZuSSBQ+s6/UekaF2j3q+PptA4=
Received: from DU7P195CA0011.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::14)
 by AS8PR08MB7920.eurprd08.prod.outlook.com (2603:10a6:20b:53b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 11:34:08 +0000
Received: from DB1PEPF000509EF.eurprd03.prod.outlook.com
 (2603:10a6:10:54d:cafe::dd) by DU7P195CA0011.outlook.office365.com
 (2603:10a6:10:54d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Wed,
 18 Feb 2026 11:34:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509EF.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8
 via Frontend Transport; Wed, 18 Feb 2026 11:34:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgVK2xeQ2IN9p60Ooxd74WMUM8D9VwHAjVDP6HtpZirmAR+0GX57h6BBZPJY0pmMbc5ruA0YSNyl6grYRnVx+Rw5i3lMK/IjeAzHFT60VtgTgdd+cc3iqIOJsHCFKUbNp3DWqVllmguDpZDZuXJI4j5nlD9mRTzKmotwLoaziVGx/aX07UUUYFuQYqapj2z+xFaIMRkS5m/3bNo43QnWo9u+l7DbMPtZQfCLb75U6mPWFr4uTCuQj9PBQDEWDORUCt00U+fzk+CsN59rzdKvvoJ4Iirmclxd4Nffcxypg9rLnHVFCwwHgok0dtUq1l7HbI2RcqnzvKQdJjn7QhUJNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9MFRDobePTg0vtpfKLVI3FXGyIT5Wi9OXIPK+Qt0x8=;
 b=Tnbm78sHr03tgmv37qaNN2c1AGWA47f3KPukp2YL7pZEFrJe41+ce3RkJR7FWKtTbJ8UlwTsZvbOUQg6SXU5CZvCpvv7+4Lxj+6JGGzxcasoSpY9kv2Vnfyznr9yZpjhpKTTX4Gwbz4DR+q0iMhu3+GAJn2l+Ykh0WJ1wfk2/YCvs35zRBz8ZTqFq0enXXiXTyERAnV+lJioQajkR1offMrdb/Ygp7OnHfzxGLmVQzY0IHt9DPGtUHQy2bqHgeTwKfOIdiQe2n5kO8KY4xGFqlQBFGUDLftY8YDqUbGsQRNLJqyaQwHrS99hCHSstWSWia3bx97M4PSYQxhX7RyujQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9MFRDobePTg0vtpfKLVI3FXGyIT5Wi9OXIPK+Qt0x8=;
 b=DeMVKu3gKGiK1jDJ6ZyZRv+8AE80LsyP/eB/AW1PK5EIBF60U9LwtvxCqHI82QmYCLdPVKoYMPBSIWg2oQ7rhBHNoyts6j7T80UlS92aFROH7WLq9w093FRFmHPqMSmw2REPSmfbELOmFlvSTTZuSSBQ+s6/UekaF2j3q+PptA4=
Received: from PAXPR08MB7247.eurprd08.prod.outlook.com (2603:10a6:102:212::7)
 by PAWPR08MB9831.eurprd08.prod.outlook.com (2603:10a6:102:2ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Wed, 18 Feb
 2026 11:33:00 +0000
Received: from PAXPR08MB7247.eurprd08.prod.outlook.com
 ([fe80::e2f7:f38e:3321:44fe]) by PAXPR08MB7247.eurprd08.prod.outlook.com
 ([fe80::e2f7:f38e:3321:44fe%5]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 11:33:00 +0000
From: Igor Podgainoi <Igor.Podgainoi@arm.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: nd <nd@arm.com>
Subject: [PATCH 0/1] Cygwin: SEH: Fix crash and handle second unwind phase on
 AArch64
Thread-Topic: [PATCH 0/1] Cygwin: SEH: Fix crash and handle second unwind
 phase on AArch64
Thread-Index: AQHcoMpWXCmKrO8VGEiCVs/Ac/QgKg==
Date: Wed, 18 Feb 2026 11:33:00 +0000
Message-ID: <cover.1771414249.git.igor.podgainoi@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	PAXPR08MB7247:EE_|PAWPR08MB9831:EE_|DB1PEPF000509EF:EE_|AS8PR08MB7920:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a070703-5759-4763-3dfb-08de6ee1a100
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?N1p1azNCVnd0NnoraFQrNnVvMEwva2JpeTA3MWtOTFJVZnFkQUpRUG9IYzla?=
 =?utf-8?B?WFE1ZFlreU5IcHkwVEJNanc0cW9GVEwvNWl0Y0ZUd0pidGJsV2ZaRTExb1kr?=
 =?utf-8?B?LzVVVEFkS01JYXlwOEJXM0FTendPdmxLeTBYejZsU1dCbzkxY3VLR1IzVmlW?=
 =?utf-8?B?YjFzQi9LeFVHMEhoSjVsWnVWSjFGWFdBRGgvZkgzZGt3SzUzSUh3OWFXWFpt?=
 =?utf-8?B?d0RHY2k5SG41Ym9wU3FQYnkyWExhQVZNOWw1aVRGRGJOYmlNSU5FMXlhZXhz?=
 =?utf-8?B?dWFzcmMxY3FmY1lDcktJOVduMXNNUWYrZzlVVy9reU5WUDQ0U21IazRUSkkr?=
 =?utf-8?B?ZnRJZWxSWDh6RHVJQ3V1S2I3cTZvRkRjSngybVFDNi8zNUcrRDhweUlUMW9o?=
 =?utf-8?B?Y2dtaVl1WE5oL0xxTVlMdzN3NkpPYjByRXVVOHlXbkJGRENjbW9ZZkVSblo4?=
 =?utf-8?B?TUVPSnNDeHRXUGF0VHNIUUViK0NyR1NiWkRYdDdnQkRYR0gwRXZHN2hNcktT?=
 =?utf-8?B?UGk5RjNSM29OYS9MYzgwRXpYdFFoYnQyUEJDaTFlWU5TclVVcnREbGFvNFpV?=
 =?utf-8?B?bUtocVdFZGhNSWVjSnd6emVIUlBxWnVTUnhkZE01NWV3NXVkZ0UrNGx3ZUpa?=
 =?utf-8?B?ZWhzRlBlbWg4SzFtU2o5SUhPVFJ1YTBrZDFMYjd6NTNuYThtRXhTTUVDaEhZ?=
 =?utf-8?B?NldYV0hKMUNzaU0yRHUzNWlmVGRNNStsaWUxZ1R3MmtIR01tY3g1TmpLOW43?=
 =?utf-8?B?Z2RIZXNreWcySnQvcTlmY1M1VVVhTU9CMmVPRjVtWTROSjl3dFVPdmNURWJC?=
 =?utf-8?B?clJzNCs4aDQwRVhLNFF1UEhzeExlNUlSYytPNzB0VG5uaWE0azRYM3RLSDlm?=
 =?utf-8?B?eTFnRm55RzA2S0ppQ1B2RFdUQlpYZEFQTi95RklKSkFQNFI3T2tEMVBScWpE?=
 =?utf-8?B?YTFVMXFSQWVvSW53am1VWTFnbFdpTjR0MEZpZXZialRnd01Kb2pVMWt2MzQr?=
 =?utf-8?B?bU51aDZXYnRSZDZjVHlXay8yY3c0cnhUNVMvK0cxbktiZEtzQ2JzZW9sdFVH?=
 =?utf-8?B?SlpJaytvMHZvZW00UzlGOEV0UkhuY2RvZkdFUnFVQ21ub1BtTUN6cVNVMmhu?=
 =?utf-8?B?a2drUFU1dmlsWG00YXVncEkwNHp5a1dtSE5WTHh3N2ZFMDhkN2kxVVpiYk9o?=
 =?utf-8?B?bHVqSG5CenVvNlF1YU81c0tVUlVvaUdBR0hBSGFjNDNIbmhONXRLb3BjT1BP?=
 =?utf-8?B?bEZ2enBmOWpGV0lmSXEzaThHWmpBejR6aHgrT0ZWN2dNMEJjWUtpQ2lYVHlF?=
 =?utf-8?B?TUJYNldIYUtPMTlBU296QTY2TjNpa3d0WWxUMHFkdWdrWjlSUEhieUNDVGww?=
 =?utf-8?B?VkhySzZhNGpyUnZTZklUbkF6NzNkZHlYRzdGUjl6cDFTQlVsVllUL1pyRENn?=
 =?utf-8?B?NWR3UzBZZWc0SEowdkhwMWZoQzRUdVFiK2p6cHkvSG5INndMSmNDUnBpZWdB?=
 =?utf-8?B?MGtKNUdPZ0xBQ0V4d0QrblJrRFVwZVU4d2xReWMzeXNEVkVYM09wTWJqT0xx?=
 =?utf-8?B?UDMyRDN1clBYU0pUcFA1dEJJOWhkbS90TmMxMmhURWdNcEhXK2JETnZiNE9z?=
 =?utf-8?B?SmZKbUFRQzFlYUwwWGx4aTJzYVl0TlJOcCtlcW1wR1hua2dhcUZkaHZOV24x?=
 =?utf-8?B?K2pjQ09KRFUvQUw0MGdIUFU4ZnZSc1k5T1Nuc1JZSktJa3RlN05sS2V2T2dM?=
 =?utf-8?B?bVdHcS85WWN2ZitMNEZTMUNlK3RIcDJCeC9pN1g1Sk51NGV3Q2NLaUJlUG5i?=
 =?utf-8?B?WTJPeEZqd2NhZXdRemRaNUhqUTRSazA1WkxnQVU2V3RXUTdBdWIvYjVkT3gr?=
 =?utf-8?B?QWRWMVNFWG8rZEVwZUxtbGF3MUFCNzJlb05YVENNNXdkc1ZDdjY4NHdrSUMy?=
 =?utf-8?B?QnM4QTNpWXcremVmcHZzUDRKOGVPQU1wUGRvMmJLdkRPKzU3N1lPdlVucmla?=
 =?utf-8?B?WWp5ekpzMVBTVURJbmtIU1hUdUJZRkk3UHVXdGNRTldwNGZtdFlsUHFPOEpD?=
 =?utf-8?B?LzlQeGtpU0tCYXhxUmNoV3RlalpCVWlHL1FSOGE5Kzg4UjU2NzAxOHJmWWVl?=
 =?utf-8?B?czBmZWthZUNqQS94dFhIRE5XU0F3cHZzT1JieHV6RitRMEI4WkkzelJZeDJY?=
 =?utf-8?Q?XTAqrbV39yIGYK4qvBQPVkI=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB7247.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B6F78063EE7B641A0865B490791252C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9831
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509EF.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	9eee4e57-2c35-4fbc-984e-08de6ee178be
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|36860700013|14060799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUZvV3JCOVhJUnBib3MwYzZEY2V1VGdXSUVuQi9QRlhJVnhsRE9lQ0dtTlZl?=
 =?utf-8?B?NXh3dTlrdERtd2VkSU9VaEE0d0c0djY4MDI5bm5KaStBVWRzTllGVE9MbzJS?=
 =?utf-8?B?d0t1R29TRE5PYjFxald5cUpPYnVtZUpHMEh6VmFmOW1WZnN2RVpJYnJ6N3dt?=
 =?utf-8?B?bGNHaXM4bDRFYVh4M09TakFyRTZBblRzUzZ4TjdhcjhvZ2ZYYkNTTWREcWIv?=
 =?utf-8?B?U3licTc3OWo1UWttTSsvdUJwS1JvaGZaY2xtaXhhaDRkbE1OUC9uZEovcDZZ?=
 =?utf-8?B?UFhYOFl3cDJCSEd2WTVkNjBFVlpKYlQ0RThrMmQ4eFU1d3FIS25CYWgwbDBw?=
 =?utf-8?B?SHppUGVyVGtFcDVDZVZWZmt1VWJkbHJVbnVHT2V0eVhOR2gwVFEyWU81S1lJ?=
 =?utf-8?B?bjRqdlFYRGhnS1FQTkdNRk5IaEVUY0k1aVp3RlUrVnQvellSY0NHUWE3M1FJ?=
 =?utf-8?B?NHZpekhXL0lSejVNVkhDV0dCbG9PTlFYWEVSTm01bTVlek9YVVpHTng1NUp6?=
 =?utf-8?B?bVphTmx6ZEIxOXdBc3lhbFRWS00yaFJySVV2T1NTbzhZdXlPQ1VpWUp3bE5G?=
 =?utf-8?B?SUR6WGxzVW50VittaTIxWnZtY1NSTFAzdG1OWk5DQy85RWVTL1BUVkl0WDJo?=
 =?utf-8?B?RmZTeHIwQWNyTlFGajdCWC9jMU9JMUFEdGtWMFZIVnNlU1FMcXNRTjNPNlZO?=
 =?utf-8?B?SXVlcER1bU5HSXM2OThiWjUxOGErWWRHWHZBSVFteGd6YU12KzJvS1BpTDhI?=
 =?utf-8?B?RnJTNXJ2MFVNYUVsYVVaNklFZi9MUEdobjlTN3dpblZCeFNzOVlUUVJUaTMz?=
 =?utf-8?B?dDhueTRUUmNoYjVhemlrTkNrbnZEejNSNGUzYUhHYnNOaWtQNXhNeW4rM2lG?=
 =?utf-8?B?cjFLc2s2aDBDZSsyRnN5dzl1dFBOV2VTWHI2ZW1YZTl6dkg0VURjSXV5dVJN?=
 =?utf-8?B?QjFaQktqOFhxQUdkWU5wZkdvbmMrZGNUOGtLS3hjVWVtL1VnNXIzV3FVMFdF?=
 =?utf-8?B?d1hRc2oxbndGZmJTRHFRSVBZb3FHZ1NmcDZsaVFzNmYweVgxSUJYVHpSSDBH?=
 =?utf-8?B?UGVnNys5QnVEeFI0QTJqU3pqVXN3SXpVSGdwd2dkNWRzcmZEL3dLUmpJMldB?=
 =?utf-8?B?UUtPZ2cvaUxrWUcydWx4SDdLS2FjMDA5SVNRWlFXT0ZGWEVQNW8xaWVBVFlr?=
 =?utf-8?B?dUtlaGtQSEhhb2VlVFFpZmhiRUlDaUNDWUtGekpnMzdXbVllMTkrUHovTW0r?=
 =?utf-8?B?TVJMVFJsWFNmc2EzUFJuM3pnUG9rOTh4NXhzblJBaGlVaDBNMWtBVjI2RlRI?=
 =?utf-8?B?cElVQUx3K1R2NnhrWlBOT1ptOS9rOWNVT3VaTHNkVkVVMnc4YXZPTUdTcE8v?=
 =?utf-8?B?RlNEc2FKczIrSUs5WlJXV0ZrWFZ0ZGk0YVE3ZnV5Y1Q5RDBFMmxmcXNOMGlJ?=
 =?utf-8?B?QUtnMklOKzVwaWVQdEVqclJOQXV4b0pBQ2FjQjJrWlJOUWF1S0tLbUQ4N1hi?=
 =?utf-8?B?aTJ2SVBySVhtbnI4OEhpNkdsNllKNjgzWFgzNTZTR0xWcVlBTjhhREdYTXBo?=
 =?utf-8?B?dmxuZ2NaWEZ2Y0VOaXk5L05MSklSWk1aZmxVTTA1dTA4aXdMYjhLUUwwVExn?=
 =?utf-8?B?SzlvdjNoMjhZSk93WXNDM1Rkb3ZRc2V3bmlCOFgrdjBkZnEzaXlSeHRBMzNT?=
 =?utf-8?B?YWhnNE52alVlWERVSVI3TzU5NmxRSldXc1BId1hXcjV0THplSkZ4andoRWZ6?=
 =?utf-8?B?M2pqczNNOUlGMmwzeWFjSHdMbnBXNkh5Q29TeEt3TDhVUk1xQVZ1VEdzb0VV?=
 =?utf-8?B?eFpMcmNCNVJDd1M1UkttcTBaK1R1Z3RjY1ZQWFJ0VDBSNmJuc3c2NFpBTFRN?=
 =?utf-8?B?a3l1aEtuL2VwekJkallUc2VHUG5JL2hiR1hpQXRpWW5USmgxOHYyQW11d3dp?=
 =?utf-8?B?R1c4RDB1c0MzL3J3UmdRbzhTSnpRRU5TV3FsWmUwODliMjRSYlZaQnVPZEhv?=
 =?utf-8?B?QTRUVXRYQXVqTFRSWXN0a2NycWNZV3FCY2gxVU5nK09jc1RBT21ubTc2bUt4?=
 =?utf-8?B?dzZSejBnVjVENzFzeW0veStHVzFidzl1Q2k1TG1vd3pJOEtlbU1SZXJPK2lw?=
 =?utf-8?B?Nmszd2RNYXB6aTErZmgyVSsvK0tvZjdHRHEvdzExaFdKWHFka3BGY0tqLy90?=
 =?utf-8?B?NURMVXpQWDcycVc0TDJ6WUpGbWFlVFBoamtxOHJjUUdTRTd5ZnRQdG82Qm9B?=
 =?utf-8?B?YkNyMWx2bDlNYm40RklienQ4dGFBPT0=?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(36860700013)(14060799003)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Dg9ESQyen+DRZ6pJKx8O7X7YbGCP3eV9B0V3OcI6uWiKw4TwakoE5e4wfebwA6hb4UdYrrCg+kdweB1xm6TxAENvk/83f2Vt0Y7BcJp/WqIl3LixsZP8Ezd2VFpewjwzidF3CtZ5Vm5UDyYK81ry5y/jZVu7/nHsfMDagUBjlW7AJBKARFYVOKQJwc9Pi2XMiPdc7zGpekUPM2mX3IsKLSThLDjPuXiAYfRreEoHDeuzhKNNHfvfR2mKGtGXsZrTC+AlJax2E7XnajOX5Vj2TbmFIX5Kxx2NboG3DeCMWHiWfO0pvcj+N1jIH0KFIRVwBZ7Z4SvqA8H43ZUgarC2ZNQsHVgTPCwX6ApNsVI7JZyHXRwvwDwdmoG51lhQ+xrSvs/b0s3SL+7lsvARBtWLV58Ry++jv+9WV4iFT1cuoNMP9uXFxjCEfqH8VTDOZbkj
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 11:34:08.0591
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a070703-5759-4763-3dfb-08de6ee1a100
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7920
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,TXREP,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

SGVsbG8sDQoNClRoYW5rIHlvdSBmb3IgdGhlIHJldmlldyBhbmQgZmVlZGJhY2sgb24gbXkgZWFy
bGllciBzdWJtaXNzaW9ucy4NCg0KSW4gdGhlIGZvbGxvd2luZyBlbWFpbCBJIGFtIGluY2x1ZGlu
ZyBhIHBhdGNoIHdoaWNoIGRlcGVuZHMgb24gdGhlDQpmb2xsb3dpbmcgcGF0Y2hlcyBieSBFdmdl
bnkgS2FycG92IDxFdmdlbnkuS2FycG92QG1pY3Jvc29mdC5jb20+DQphbmQgVGhpcnVtYWxhaSBO
YWdhbGluZ2FtIDx0aGlydW1hbGFpLm5hZ2FsaW5nYW1AbXVsdGljb3Jld2FyZWluYy5jb20+DQp0
aGF0IGhhdmUgbm90IHlldCBiZWVuIG1lcmdlZDoNCg0KICBbUEFUQ0ggMDEvMjhdIEN5Z3dpbjog
QWRkIEFSTTY0IHN1cHBvcnQgZm9yIFNFSCBoYW5kbGVyIHN5bWJvbCByZWZlcmVuY2VzDQogIFtQ
QVRDSCAwNC8yOF0gQ3lnd2luOiBBZGQgU0VIIHdvcmthcm91bmQgZm9yIGFhcmNoNjQgY29tcGls
YXRpb24NCg0KVGhlIHBhdGNoZXMgY2FuIGJlIGZvdW5kIGluIHRoZSBzZXJpZXMgaGVyZToNCmh0
dHBzOi8vY3lnd2luLmNvbS9waXBlcm1haWwvY3lnd2luLXBhdGNoZXMvMjAyNXE0LzAxNDM5Ni5o
dG1sDQoNCk15IHBhdGNoIGFwcGxpZXMgY2xlYW5seSBvbiB0b3Agb2YgdGhvc2UgcGF0Y2hlcyBh
bmQgY3VycmVudCBtYWluIGFzIG9mDQpGZWJydWFyeSAxOHRoLCAyMDI2Lg0KDQpCZXN0IHJlZ2Fy
ZHMsDQpJZ29yIFBvZGdhaW5vaQ0KDQpJZ29yIFBvZGdhaW5vaSAoMSk6DQogIEN5Z3dpbjogU0VI
OiBGaXggY3Jhc2ggYW5kIGhhbmRsZSBzZWNvbmQgdW53aW5kIHBoYXNlIG9uIEFBcmNoNjQNCg0K
IHdpbnN1cC9jeWd3aW4vZXhjZXB0aW9ucy5jYyAgICAgICAgICAgfCAxMSArKysrKysrKy0tLQ0K
IHdpbnN1cC9jeWd3aW4vbG9jYWxfaW5jbHVkZXMvY3lndGxzLmggfCAgOSArKysrKysrKy0NCiAy
IGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCi0tIA0K
Mi40My4wDQo=
