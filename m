Return-Path: <SRS0=jALY=AW=arm.com=Igor.Podgainoi@sourceware.org>
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	by sourceware.org (Postfix) with ESMTPS id 9CA784BA23C0
	for <cygwin-patches@cygwin.com>; Wed, 18 Feb 2026 12:07:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9CA784BA23C0
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=arm.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9CA784BA23C0
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c20a::7
ARC-Seal: i=3; a=rsa-sha256; d=sourceware.org; s=key; t=1771416431; cv=pass;
	b=pBch8lmCXNV8t3ue9Rqf53nIFJyFoksXvd58Isbyag4bX3iJnG77K8QOIqpSRdbKAAsbySkTOnVmMshK/fsHRcpeWn6VoMQtOTU/LkcVF7Dag0PZLvFHqnWcGCbxItebuACzIn896ECuDkEpCmd62z4HnSx9JRhz6OQDv1QmjsU=
ARC-Message-Signature: i=3; a=rsa-sha256; d=sourceware.org; s=key;
	t=1771416431; c=relaxed/simple;
	bh=7F7hjZpyhsr31ErVujZZDwSGN0RQY/dGtSt1kD6gu80=;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version; b=x9FZfG+hgHy7uz+wM0BKwpeL7RKAkuYhNwTY46IuwKwnOhMSf4slXjYez/Yg2O7aWqI4pLvH8CrZ0xLXnX+nQfd86wBBmSixP1O2woFvPW1ve5TbbvuxJQzpNYNymH8SIphZ3/EAgbsJa2jaEBcCmfgvOxnI1S+ojIDhUvIplkg=
ARC-Authentication-Results: i=3; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9CA784BA23C0
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=FDBAOolW;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=FDBAOolW
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=QkNTXi26MVpKwXUUSHBXn7dhe004Kc15QmxptD0llK/XFE03PUYM8KNL1MQhgah9tjmphQ5bO4pz16q3YY+zAxHW8S1isWPevV1ZbGwaxcAbAGPfH22DxgEIzApVtzFOfYOeKR6nWNAQHSVjZAJVvpUE2FeDuCF3vr7TTE4MDzRrVHCKtL/GxYRmox55YNwJpjKa1ppkqBeMTJ2pi+0tbbGRtKWcz/HLZXa+3hqc87fwSLTCb6BcElw6RPYuaQ0mqtAWXEGlB29Ghj/F5f56K/xPJxHLMPRhjvoDBLevufEnGyx+FICtC48IGIPc4vEAQWJTYhU3ZrrIX8sRCAqHhg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7F7hjZpyhsr31ErVujZZDwSGN0RQY/dGtSt1kD6gu80=;
 b=iYIVf4re634z9ec9n51WT9wBdWdEcQU+koosG7zTrO4byS+DPm2tAEojoK+6BKnlZiwgu5OQ8+VGYS3l0McMetpQpJ9rIQbruk1XZaGKj0/TAnxDBVTsPiVqaMa2q4Uibj1N+WJtLgQVRpj4FrosJbhbeOGdEtZB9SdFBXYVdmcdHe3PgxLLaXctIJ5pTlgNRS9IC2BwPnYjDsOEEzKc6jRQoZhAK+r70ZKHASCSIc+juw2H8ziaXfk0IplEDcJbkpHwHn3pv1tQzXlrhHnI7XPDAtSQMTw0qgvOZcwJhsVSU7OpsN+rNJ83DX2nZWyB23E0+/c+LBjNEghcPT/6uw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=cygwin.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7F7hjZpyhsr31ErVujZZDwSGN0RQY/dGtSt1kD6gu80=;
 b=FDBAOolWqAK2yfN8N04Vnt76STLs2LzL/kIMWoOpirNU/2E83v+WDv8pWm1aRLn7FHj6JFsQlZeZgkSRr3IQzPr3EQLlUdQP4KQb7ajwO1lYs3ZFb8/1W2hYV1F8pcMH0HWVkkrRjWiYUDvYEhfzmRKykflVvxsYpMLywWW8w+Y=
Received: from DUZPR01CA0334.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::25) by AS8PR08MB7840.eurprd08.prod.outlook.com
 (2603:10a6:20b:52f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 12:07:03 +0000
Received: from DU2PEPF00028D05.eurprd03.prod.outlook.com
 (2603:10a6:10:4b8:cafe::c1) by DUZPR01CA0334.outlook.office365.com
 (2603:10a6:10:4b8::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.14 via Frontend Transport; Wed,
 18 Feb 2026 12:07:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D05.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Wed, 18 Feb 2026 12:07:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipeyvCHNHXWQIXePCA8gj8CpUsfsaCpcFGelLbqm00GR3CU1lNAWnob5znDApluzkBmdh7hNFrwz4oTJCDZQ7tVzY0KfbPa5T84Lup2A3JIEuTlhb9OYwTkLwmMjSNQwfrvb5noJ6QDSW4RzDbZXA03Qm6MWrlNL1cKkWxqXkCVkSeWeJRg0nOucTLA5vEqsF1YQKWdRbgWMJIvHxC0felsrXCbXsjj9IEPvbgxsdY5amW09UZ5XVIm+swqfiwZY0Wd0Pf0BjpV0WQ+r8YeXEw2gzv3jKfk7NXlmxBF+QwdTPoGiD2qInMggHdP2/Agox+lSZiToxjW4pZtZzwfr+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7F7hjZpyhsr31ErVujZZDwSGN0RQY/dGtSt1kD6gu80=;
 b=uyGK59LQH9+Mq2FiI9PQlTVuP1WWRSFmI1UbaTuu+mAynzH63JqyFKMKD9ReJkEhLJxaGaU+5+2RLI1cnOTcONpqHldgd/dctoJGFKAqV7PW/uozNk8L5c0a1oFrJdFkHMFAY1+C7ZtA35HC4P/etLQ/KnmZHbTTiGAof17qC9IBObJIwIeNQRwcic7QNCQGz44CEzk2mVE6lNNAH888VphvaaztNeElA420DUhGi1S1srRzUyY49E4e8fbAvbxd2S/C+8UsVi69JWU0V2yBfbPuqyPzsJTuZn8dp+XbJhHd46zo7KV2c9K2nkHandCYqxUWoIUZn5nlQeuynyTOlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7F7hjZpyhsr31ErVujZZDwSGN0RQY/dGtSt1kD6gu80=;
 b=FDBAOolWqAK2yfN8N04Vnt76STLs2LzL/kIMWoOpirNU/2E83v+WDv8pWm1aRLn7FHj6JFsQlZeZgkSRr3IQzPr3EQLlUdQP4KQb7ajwO1lYs3ZFb8/1W2hYV1F8pcMH0HWVkkrRjWiYUDvYEhfzmRKykflVvxsYpMLywWW8w+Y=
Received: from PAXPR08MB7247.eurprd08.prod.outlook.com (2603:10a6:102:212::7)
 by GV1PR08MB7852.eurprd08.prod.outlook.com (2603:10a6:150:5f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 12:05:58 +0000
Received: from PAXPR08MB7247.eurprd08.prod.outlook.com
 ([fe80::e2f7:f38e:3321:44fe]) by PAXPR08MB7247.eurprd08.prod.outlook.com
 ([fe80::e2f7:f38e:3321:44fe%5]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 12:05:57 +0000
From: Igor Podgainoi <Igor.Podgainoi@arm.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: nd <nd@arm.com>
Subject: [PATCH v2 1/1] Cygwin: SEH: Fix crash and handle second unwind phase
 on AArch64
Thread-Topic: [PATCH v2 1/1] Cygwin: SEH: Fix crash and handle second unwind
 phase on AArch64
Thread-Index: AQHcoM7wwt3RmlVTk0GjLgpwgpysRw==
Date: Wed, 18 Feb 2026 12:05:57 +0000
Message-ID: <aZWrI3WPFRqj7P_j@arm.com>
References: <cover.1771414249.git.igor.podgainoi@arm.com>
 <c4f8c7507e38602ef2935a8dbafe7409a63377ad.1771414249.git.igor.podgainoi@arm.com>
In-Reply-To:
 <c4f8c7507e38602ef2935a8dbafe7409a63377ad.1771414249.git.igor.podgainoi@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	PAXPR08MB7247:EE_|GV1PR08MB7852:EE_|DU2PEPF00028D05:EE_|AS8PR08MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: 608562ca-abf5-47c7-37da-08de6ee63a79
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?MzV5bjI2aEhiUm93NVlIKzJUVzkyNGhXNVN0YTlTZDFaNUxuVHRhTXUrK0Yz?=
 =?utf-8?B?aUNkSXVUaXFNQnFwTWlhNG9vNk5jUXRRdmJPSm5YWW9ncE4zTnc3VHJpbTdj?=
 =?utf-8?B?NWZzdzZ3akowazh5MEIyY05SdlVoWjZoQmVjSVl5NGpvLytoYXZ1RmtUVklw?=
 =?utf-8?B?NW44bmFaUjUzdHd1dzJCQkgrSzJKTG92Ri85OHlCZ1NLVm9YMDh4UmVRYXNr?=
 =?utf-8?B?em5od0pBZGthVEF6Z2RiMlpUeE54akhwL1hpREVrM2I2Tjh2YmM3Ti85OTlF?=
 =?utf-8?B?alljQ0dYdkpzNm81dlprb0ZQRXJaS1ZvVkl2UTg2NWpYYStRNmhMakpia0Zp?=
 =?utf-8?B?Z3JBNTk5OXNkL0dBdWlxRTkyRVIwWGo1bDJ2NWRaMHMySStVTktWWnhnWnFF?=
 =?utf-8?B?SlNhZStyemRzL1hwNlgraWh2a3ltdk5tUVpuZmpQODVKcW9nVHplY3FrNnRS?=
 =?utf-8?B?dU9mcHREc003Y3VJQXVOdHBMMkRyaG1nbGp6VTVvcFFlSnRmZlNHSHd6UHdB?=
 =?utf-8?B?dmhidDBNT1BuVys2UVR3TS90OHNtc0JWRWRkSEkvZmxBc3J6YUFoOVZrRmVu?=
 =?utf-8?B?Qk1sblJtS2IwN3FwTW1lZTBpU21XRjh0aDQwZUQ5amRrVnJ4Qjd5UlY0WXU3?=
 =?utf-8?B?UkIvc2N2UDFXeHc0M05ESU1pNFBsVzJZN1NNWnBtQW1GZER4OFlDZE02NXFs?=
 =?utf-8?B?VW5EeFg0S0QzT1FIS0JMR3czd2pqdkE1ZWpTWG1IbUdFdEpkbWFoNHorMDBt?=
 =?utf-8?B?U0RsTmp4OUdyaGI2Q3FsdlgrYmE1Umt1MEhWRzgrb3FmL0VLYzYyY2VlRklU?=
 =?utf-8?B?QlhxUVBUZHJLTE5aOFpUUytrSzFTNE42WFZMazJiUFgvdTBqdUdCSlBqWU9k?=
 =?utf-8?B?cUtIc2hBaUpuYXA2bGdQeGF1LzVNb2o3L3hNL1k2d0N2UW1rY25XSEQveHpk?=
 =?utf-8?B?MDFaN1lMVmhlTnJRTWtubGRkc1RLYkFTOW0rQXlHeFRFOEFUaHRXS0YreTVp?=
 =?utf-8?B?ZkpvZ2JpUkZCMG0yRnBvRVlpTWU1WnJ3T0JKZy95TURIc1c3MVh5U2RuRFQx?=
 =?utf-8?B?bFdoRnRQckxERUgrNitKQXVzWUllTTEvQXpDMmtxN2dSUDB4OUxxdVBzSzkr?=
 =?utf-8?B?bS8xWjlDcTRJbnYxSUpTTTdDZHQyZkFJd2FQaG9aSURnMTg3MDl4ZTFKYmQ0?=
 =?utf-8?B?YW1yTDdNWVFYa2R5VUFMUGx0ZnArUFpjLzF5Vy83ZUljOFhhZi9ZOXIzNkdQ?=
 =?utf-8?B?YlZEQlNuN3ZCR0w0cmtvZGdaeEdZWXcxeGswU3B0ak1pN3FWaGtENTFNKzhH?=
 =?utf-8?B?R3Jxb2J4aFQzSlpXOUlLU0xWNUUyOFJvMm42amFIZEdLKzJYb0VOY05YS2ZH?=
 =?utf-8?B?Mll1bmk0T2k4R09FV3ptK05jQVNxN1N1cDk3MlBHVEw4WU4yY1lJc2hkaDd3?=
 =?utf-8?B?VUJkZTZuSE0rYmI5NnRjL2hCOURDelFobTBmeHF1cG1lRktjOGVkOFhweFZW?=
 =?utf-8?B?NDFURjArSzN5VktoU3BVWmdEQVdTYk9Bb0ZETWhTRFhBMis4cVMzMWRLTjhZ?=
 =?utf-8?B?Q0dKb2RFZEFsMTdmc3dDZG5VdmhyemtyRHpLcm1TeEV4NWJrNVczRTREeXBp?=
 =?utf-8?B?OC9sbmFBbis4eG9WdXVXeGtOVHIwWUZNcDVKN2thbjYyaGlISWV2RVBCZ2ZB?=
 =?utf-8?B?amtLaitMVlg5cGpybEVmWDJHNkNWYWw1YWF2UDhKSEhRS1BJMlNyaUJaVlAx?=
 =?utf-8?B?NE4rL1dsaFB1dnlEWkVKZDFnRThkUTFHL3MvRm1ON1k0WFhJK3JXRlpuL1BF?=
 =?utf-8?B?WjMyLzVERUNYcmFNdU5CSVdoTjBNMC9yaUYwMDNiUGRCRnJuNFJsVnlvRDVr?=
 =?utf-8?B?UFNnZlFsZnIxdVYvOWxVemxEM0dUUXVpZW0xNUx2UHNSWHlYdU5SejdrK2ZO?=
 =?utf-8?B?enNNWWlEcnNkWVRGZ05MZGM4VDlLMWRKaE5BNEh3Wng3anFZbHFoOXNrSGpP?=
 =?utf-8?B?aUtCNEprZ3haSGNxU2xnRnlUbVc5UStTbTg4bVBNbW4rQWF4SW1nRFpZZ1Bn?=
 =?utf-8?B?bzlHTkJkVkRDWktSNmcrYlNjWGpsd29TUlZRdGw1Mi9UeDdsUzhZeW5lMFF4?=
 =?utf-8?Q?kSxm3MJIQu4tbmpkVqWS7998o?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB7247.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <708E71176891984391B0BB54CFBBB2E9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7852
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D05.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f88f54a1-a683-4a29-962d-08de6ee61331
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|14060799003|1800799024|36860700013|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RnlDMEtLRG9CTzhuVDVKTE9uMU9UMDUxOGFJUmoxa3BsYk9iMk16eUpNamJ0?=
 =?utf-8?B?T25DeGNkcE9EQnNYZk5zN3VyUUE2SDFnMVNlSDEwaDgzQVZ0Rm5qMEtqSnhZ?=
 =?utf-8?B?cXQzOWlQMFhxQWRWd0VFY2ZtR091R1dCcHNpTFFzenAwYTRiRnI5Z0NXa21Y?=
 =?utf-8?B?Y3pmNWRHb3U0VVcvUXFLeU8vK0VWSFhjTU1NWEFNb25TVmpGU2daOSs4dkMr?=
 =?utf-8?B?SG5uLzFuWllDbVo2eUVJbmp0NnQ0V2tqMnVSM29YVi9pTUl0K1ZuRU82d2tI?=
 =?utf-8?B?UXRBejhZcUhWdEdwTWRvTElSalRzK1kzV2srVGtXanpsUUVKc2QzWG5LdGpP?=
 =?utf-8?B?YWlkRDV1Rmd2VlFZYmVYL3JqM1RmUWwrS3RBNnJ6bGRSUGJPblJtTnpPdVJp?=
 =?utf-8?B?ZWpYN3hZdVVsdWlrSnRsMnhPU1A5MkNTR0pIWUFHS0ZYcU1lR2JHTjJ0TFo5?=
 =?utf-8?B?c2dUUjdLTGhaWkhGa3F4UDY3dVVXYUZqVVlkcWNNRlhkU0pPS01jYTFiRWp2?=
 =?utf-8?B?UC9jV2lwSVVOdG4rTHBpZTJ5RDJxMmJqOHZFODExM0dHTlVVRTZOU3M4Sm8x?=
 =?utf-8?B?eC9jSUNjMzVwSVFPazlVcHVwdmlLcERGME4zejhzMTlpZ2dxN29tR3V5WkpG?=
 =?utf-8?B?NGxFUmN5S2hxcjIrUVprcHdrMmQvaWVNS0dId2l6OGE4YVRuTVNad2h3UTNW?=
 =?utf-8?B?SWE4TUlMeS8zczNiRW43SEhvcWVIcU9Pb0gxRkQxMFBQSnlOc2EvM0NaVlV0?=
 =?utf-8?B?RzBqZnFVWGRIbHA0VXIwdWtnVWlKbXgrRWR6Rmh5clZyZDZQSzVGTFZvYkJX?=
 =?utf-8?B?c2FRVk5LMXlYR0J2Wnk1S3UyNFZjUjc5NkRNd3BlVmhETU4wQURBSFlkVDJZ?=
 =?utf-8?B?QzN0WEY4WXdZZ3pjRjFSQmZHSEh5NDQycWV5YW1FZ29TRm5nbnF5T0dkanly?=
 =?utf-8?B?d3hGb1FhVW01Wkc0OVF6emVZTjM0SEpZbkM5ZE9MVWVKQThBb0pqNy92a2Nq?=
 =?utf-8?B?aWVTbGNFZ0oxMXp3ZFlBLzN6dXV6UTFnNmdYRytQZlF4WFRoL0d1eVpzKzJ3?=
 =?utf-8?B?U3dhcTZiZmliQ0l5NDJnZzVYa28wOEhYTkd2WDhnMHh2Y0VoQmx0WjFPTmFk?=
 =?utf-8?B?eDkzUTkrVGxlN0JhRTc5TUx1aFVkSUNKSmgrL0ZIWi9FS05yY05ja0ZxdWtO?=
 =?utf-8?B?d0l5UVRDai91MFl4Q0V2RHEzMUlGVHd2dlVVMFNtYTdaS3A0dWI1UUFrWVpH?=
 =?utf-8?B?Skp4ZnU0QjMrYjVkN3pFcDJyWWFrWUxGVkU2MmpLNmVlRUpOamNyLzQ3cjNu?=
 =?utf-8?B?T05ScDI1SW52elc3M0tKWHdiUDRXZXh1UFFDWElvRlJpTXUyTE9vOWRmZ2Jm?=
 =?utf-8?B?N2l0ZWhKQkhuS1hPQWExc3RLNmp6eU5UbWZmMTZZaFlxUVJvYTJaZEM5VlBj?=
 =?utf-8?B?Yng1QzNzSVF1V0dxRUdZTkdMSld5VXNsUXdJQ28zeFk1eUsyRk9YNVZUM0Yv?=
 =?utf-8?B?SmUrWUZjcGpnRk40UE5POVZ4WU1RWkI3VFRkd2ZIditIdm1Zamp0dUpOYXc0?=
 =?utf-8?B?Wkp1WWlMSGtUdkdSN1ZCeEQzL2R4RXBhVlRxSnh3ZVJhM3Z5S3lFZHlGbG9w?=
 =?utf-8?B?aUhCWEZQSEpWNVlpcXY1YTlJam1sbWpvOVgwcllKeUIzaitteFVoelFKVXVW?=
 =?utf-8?B?MVFqOUJuamdPdGFqK2V5cFU3d0kxeVhvYXJaMXZqUnN5dFBmZGprTUlhWGgx?=
 =?utf-8?B?WUZoZnAwbDFXOFU1MGo3QTBPODRCVUFDRWMvcGU4YXNGZzdrbG5aa1JGOHpF?=
 =?utf-8?B?U3ZFYmVramVNdk1zYktYNHFFZlNNall2K2V2U0tTVS9ndVlUU3hsbVl5TEE0?=
 =?utf-8?B?S3ppZ2pPMXJPN2tvU29uWFdVRWgwMXM2UkQyOU5Vc1dUU1V3blVHbHRhbUtU?=
 =?utf-8?B?OWQ2Vkc4aXpiTW9qWk1CMHFaS3JXR3J4UERyNG1yQWhSOXJUMHFXTTZZamFR?=
 =?utf-8?B?Nk1FS29mU0dYZ1lJNFQxa0Z0cVVVWmtQMk9IRFBCck53R3pzVmdBR1REMTh5?=
 =?utf-8?B?S25jalg2ekIzeXpVVW92UGxROE9MZC90RzlSaVVOTWk1YlpiSWQ5K2NucENR?=
 =?utf-8?B?aVNLT21lUXJESWgrQzVseXlXcXlPeVBvMTBFSnBSUkIzZnBFQS9xTDBBMzV5?=
 =?utf-8?Q?sAFNQgp5a7ke3Xu+DGgVoOU=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(14060799003)(1800799024)(36860700013)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jR1o5yocijnetVBmQADi/wmgzsIPAXB8ubJvtgN4fnz2HOUfIUYVO23qr0psCkEsvzMe//scJgyVFr/b4aRuAUGmMaAwTQ+bRvlwnBqJLKBWM6J5EYvi4zy+1Bq2d7MFOrGYYCWHOpckILi5bhH+WHJdB/gzBkwASEPG+PONcZFOB18VRk+EEmqG0RDHbyrB3fFsOG83y6KGj3eLzX5eEG6I/fg2QYVBKBzrxfjN4TheDTIHn2Toia69QX/mNe3OhRDiEe4ZyXfxZw7IC8a4BRJha0rTPnfm1FWPBmhNUHbeCcFMN+RYKeuAR1TPu+4qtNFP7mQ/Xz7gJwCHCMq83rU2IMu3c7L2FE98ZMmCooe1sdYmz1/zKcdF61Fa2ZwCEsF1Br2tPo44dHR3Sd3hGglU5v0Yqyphw4X5FXNn0hX9aNBngM5u5cjBanCV85VB
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 12:07:03.5301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 608562ca-abf5-47c7-37da-08de6ee63a79
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D05.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7840
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

RnJvbSAzYjVkZmYxOWUxMzUwNGM1YzRkMGU1ODY3ODMwYTk5YWMyOWMwYzdkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogSWdvciBQb2RnYWlub2kgPGlnb3IucG9kZ2Fpbm9pQGFybS5j
b20+DQpEYXRlOiBGcmksIDUgRGVjIDIwMjUgMTY6NDU6NTIgKzAxMDANClN1YmplY3Q6IFtQQVRD
SCB2MiAxLzFdIEN5Z3dpbjogU0VIOiBGaXggY3Jhc2ggYW5kIGhhbmRsZSBzZWNvbmQgdW53aW5k
IHBoYXNlDQogb24gQUFyY2g2NA0KDQpUaGlzIHBhdGNoIGFkZHMgdGhlIGRlZmluaXRpb24gb2Yg
dGhlIFRSWV9IQU5ETEVSX0RBVEEgbWFjcm8gZm9yDQp0aGUgQUFyY2g2NCBhcmNoaXRlY3R1cmUs
IGFzIHdlbGwgYXMgbWFrZXMgbW9kaWZpY2F0aW9ucyB0byB0aGUNCmV4Y2VwdGlvbiBoYW5kbGVy
IHJlc3BvbnNpYmxlIGZvciB0aGUgX190cnkvX19leGNlcHQgYmxvY2tzLg0KDQpUaGUgZmlyc3Qg
Y2hhbmdlIGZpeGVzIGEgYnVnIHdoZXJlIHRoZSBleGlzdGluZyBleGNlcHRpb24gY29udGV4dA0K
cmVjb3JkIGlzIHJldXNlZCBhcyBhbiB1bndpbmQgY29udGV4dCByZWNvcmQsIHdoaWNoIGZhaWxz
IHdpdGggYQ0KY3Jhc2ggb24gV2luZG93cyBvbiBBcm0gKEFBcmNoNjQpLiBUaGUgZml4IGlzIHRv
IGNyZWF0ZSBhIG5ldw0KcmVjb3JkIGluc3RlYWQsIHdoaWxlIGxlYXZpbmcgdGhlIG9yaWdpbmFs
IG9uZSBpbnRhY3QuDQoNClRoZSBzZWNvbmQgY2hhbmdlIGFkZHMgYW4gYWRkaXRpb25hbCBjb25k
aXRpb24gZm9yIGNhc2VzIHdoZW4gdGhlDQpoYW5kbGVyIGlzIGNhbGxlZCBhZ2FpbiBpbiB0aGUg
c2Vjb25kIHBoYXNlIG9mIHVud2luZGluZyBvbiBjZXJ0YWluDQpwbGF0Zm9ybXMgc3VjaCBhcyBX
aW5kb3dzIG9uIEFybSAoQUFyY2g2NCkuIEluIHRoaXMgY2FzZSwgdGhlIHZhbHVlDQpFeGNlcHRp
b25Db250aW51ZVNlYXJjaCBpcyBzaW1wbHkgcmV0dXJuZWQgd2l0aG91dCBtYWtpbmcgYW55IGNo
YW5nZXMuDQoNClRlc3RzIGZpeGVkIG9uIEFBcmNoNjQ6DQp3aW5zdXAuYXBpL2x0cC9hY2Nlc3Mw
My5leGUNCndpbnN1cC5hcGkvbHRwL2FjY2VzczA1LmV4ZQ0Kd2luc3VwLmFwaS9sdHAvY2hkaXIw
NC5leGUNCndpbnN1cC5hcGkvbHRwL21rZGlyMDEuZXhlDQp3aW5zdXAuYXBpL2x0cC9yZW5hbWUw
OC5leGUNCndpbnN1cC5hcGkvbHRwL3JtZGlyMDUuZXhlDQp3aW5zdXAuYXBpL2x0cC9zdGF0MDMu
ZXhlDQp3aW5zdXAuYXBpL2x0cC9zdGF0MDYuZXhlDQp3aW5zdXAuYXBpL2x0cC9zeW1saW5rMDEu
ZXhlDQp3aW5zdXAuYXBpL2x0cC9zeW1saW5rMDMuZXhlDQp3aW5zdXAuYXBpL2x0cC90aW1lczAy
LmV4ZQ0Kd2luc3VwLmFwaS9sdHAvdW5saW5rMDcuZXhlDQoNClNpZ25lZC1vZmYtYnk6IElnb3Ig
UG9kZ2Fpbm9pIDxpZ29yLnBvZGdhaW5vaUBhcm0uY29tPg0KLS0tDQp2MjoNCiAtIFByb3Blcmx5
IHJlYmFzZSBvbiB0b3Agb2YgY3VycmVudCBtYWluIGFuZCBTRUggQVJNNjQgc2VyaWVzDQogLSBS
ZW1vdmUgdW5pbnRlbmRlZCBDaGFuZ2UtSWQgaGVhZGVyIGZyb20gY29tbWl0IG1lc3NhZ2UNCg0K
IHdpbnN1cC9jeWd3aW4vZXhjZXB0aW9ucy5jYyAgICAgICAgICAgfCAxMSArKysrKysrKy0tLQ0K
IHdpbnN1cC9jeWd3aW4vbG9jYWxfaW5jbHVkZXMvY3lndGxzLmggfCAgOSArKysrKysrKy0NCiAy
IGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCmRpZmYg
LS1naXQgYS93aW5zdXAvY3lnd2luL2V4Y2VwdGlvbnMuY2MgYi93aW5zdXAvY3lnd2luL2V4Y2Vw
dGlvbnMuY2MNCmluZGV4IDgzMDllNDZhZi4uODVjYTU1MjhhIDEwMDY0NA0KLS0tIGEvd2luc3Vw
L2N5Z3dpbi9leGNlcHRpb25zLmNjDQorKysgYi93aW5zdXAvY3lnd2luL2V4Y2VwdGlvbnMuY2MN
CkBAIC02MTgsMTAgKzYxOCwxNSBAQCBFWENFUFRJT05fRElTUE9TSVRJT04NCiBleGNlcHRpb246
Om15ZmF1bHQgKEVYQ0VQVElPTl9SRUNPUkQgKmUsIGV4Y2VwdGlvbl9saXN0ICpmcmFtZSwgQ09O
VEVYVCAqaW4sDQogCQkgICAgUERJU1BBVENIRVJfQ09OVEVYVCBkaXNwYXRjaCkNCiB7DQorICBp
ZiAoSVNfVU5XSU5ESU5HKGUtPkV4Y2VwdGlvbkZsYWdzKSkgew0KKyAgICByZXR1cm4gRXhjZXB0
aW9uQ29udGludWVTZWFyY2g7DQorICB9DQorDQogICBQU0NPUEVfVEFCTEUgdGFibGUgPSAoUFND
T1BFX1RBQkxFKSBkaXNwYXRjaC0+SGFuZGxlckRhdGE7DQotICBSdGxVbndpbmRFeCAoZnJhbWUs
DQotCSAgICAgICAoY2hhciAqKSBkaXNwYXRjaC0+SW1hZ2VCYXNlICsgdGFibGUtPlNjb3BlUmVj
b3JkWzBdLkp1bXBUYXJnZXQsDQotCSAgICAgICBlLCAwLCBpbiwgZGlzcGF0Y2gtPkhpc3RvcnlU
YWJsZSk7DQorICB2b2lkICpqdW1wX3RhcmdldCA9ICgoY2hhciAqKSBkaXNwYXRjaC0+SW1hZ2VC
YXNlKSArIHRhYmxlLT5TY29wZVJlY29yZFswXS5KdW1wVGFyZ2V0Ow0KKw0KKyAgQ09OVEVYVCBj
Ow0KKyAgUnRsVW53aW5kRXggKGZyYW1lLCBqdW1wX3RhcmdldCwgZSwgMCwgJmMsIGRpc3BhdGNo
LT5IaXN0b3J5VGFibGUpOw0KICAgLyogTk9UUkVBQ0hFRCwgbWFrZSBnY2MgaGFwcHkuICovDQog
ICByZXR1cm4gRXhjZXB0aW9uQ29udGludWVTZWFyY2g7DQogfQ0KZGlmZiAtLWdpdCBhL3dpbnN1
cC9jeWd3aW4vbG9jYWxfaW5jbHVkZXMvY3lndGxzLmggYi93aW5zdXAvY3lnd2luL2xvY2FsX2lu
Y2x1ZGVzL2N5Z3Rscy5oDQppbmRleCBhMDdlMTQzYzcuLmM0ZWYyNzg4ZiAxMDA2NDQNCi0tLSBh
L3dpbnN1cC9jeWd3aW4vbG9jYWxfaW5jbHVkZXMvY3lndGxzLmgNCisrKyBiL3dpbnN1cC9jeWd3
aW4vbG9jYWxfaW5jbHVkZXMvY3lndGxzLmgNCkBAIC0zNDYsNyArMzQ2LDE0IEBAIHB1YmxpYzoN
CiANCiAjaWYgZGVmaW5lZCAoX19hYXJjaDY0X18pDQogI2RlZmluZSBFWENFUFRJT05fTVlGQVVM
VF9SRUYgIl9aTjlleGNlcHRpb243bXlmYXVsdEVQMTdfRVhDRVBUSU9OX1JFQ09SRFB2UDhfQ09O
VEVYVFAyNV9ESVNQQVRDSEVSX0NPTlRFWFRfQVJNNjQiDQotI2RlZmluZSBUUllfSEFORExFUl9E
QVRBICh2b2lkKSAmJl9fbF90cnk7DQorI2RlZmluZSBUUllfSEFORExFUl9EQVRBIFwNCisgIF9f
YXNtX18gZ290byAoIlxuIiBcDQorICAiICAuc2VoX2hhbmRsZXIgIiBFWENFUFRJT05fTVlGQVVM
VF9SRUYgIiwgQGV4Y2VwdAkJCQkJCVxuIiBcDQorICAiICAuc2VoX2hhbmRsZXJkYXRhCQkJCQkJ
XG4iIFwNCisgICIgIC5sb25nIDEJCQkJCQkJXG4iIFwNCisgICIgIC5ydmEgJWxbX19sX3RyeV0s
JWxbX19sX2VuZHRyeV0sJWxbX19sX2V4Y2VwdF0sJWxbX19sX2V4Y2VwdF0JXG4iIFwNCisgICIg
IC50ZXh0CQkJCQkJCVxuIiBcDQorICA6IDogOiA6IF9fbF90cnksIF9fbF9lbmR0cnksIF9fbF9l
eGNlcHQpDQogI2Vsc2UNCiAjZGVmaW5lIEVYQ0VQVElPTl9NWUZBVUxUX1JFRiAiX1pOOWV4Y2Vw
dGlvbjdteWZhdWx0RVAxN19FWENFUFRJT05fUkVDT1JEUHZQOF9DT05URVhUUDE5X0RJU1BBVENI
RVJfQ09OVEVYVCINCiAjZGVmaW5lIFRSWV9IQU5ETEVSX0RBVEEgXA0KLS0gDQoyLjQzLjANCg==
