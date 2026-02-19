Return-Path: <SRS0=YdQT=AX=arm.com=Igor.Podgainoi@sourceware.org>
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	by sourceware.org (Postfix) with ESMTPS id 97F1E4BA23E1
	for <cygwin-patches@cygwin.com>; Thu, 19 Feb 2026 08:04:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 97F1E4BA23E1
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=arm.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 97F1E4BA23E1
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c201::1
ARC-Seal: i=3; a=rsa-sha256; d=sourceware.org; s=key; t=1771488246; cv=pass;
	b=dMPjVQ9/Wh0LIy8cUqRujsqlH6SLX1zk5bSBpFYRt1ibEEjGZvRS7nEEatx5LIUcNjgJnxbHRw1U6Vt6XiB/H322b2RphGVH3AJU9OczZFu1d+I8Mu5mxl0eTUrmF8cyaB3hqkz65QU9I/U/TEwpkr75Cga+VM6WZuTTNOCLu84=
ARC-Message-Signature: i=3; a=rsa-sha256; d=sourceware.org; s=key;
	t=1771488246; c=relaxed/simple;
	bh=4asAhT/d8lAQv1bn0HYdyKbzTMnN2UkFGAaoz6O2RoU=;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version; b=tVuNcV+5duNQ2yqvkYfm5xkkAifOIfb2AnJXNcviBQy/x7n1Z5Zqzxx659MHUJOEXtihIiCkJDFQ8XKnQ/0Y0oiS5wcF9B3BmANzMfL0A4ZNze4eYTvWxVf8Uyg4CLfv/OIZmbZZTl6FtM7SiEzXXOA/3CsR/BI92WfWo6OPnQY=
ARC-Authentication-Results: i=3; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 97F1E4BA23E1
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Hnpel4cU;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Hnpel4cU
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=LK4iwjROp15ntPQvQztBlkGHqqzDqGVMkiPPhzTa9AmwdMtnOOBUzUVIcv6JnxCKMt+oue59BRbUEHpW42u2EH9nfg62cQHxjAnLTg9IEMVYL8/uEjX7Af5SQPgVZCoWBH2Q5zh18SYTiZGnMqcj75dzC+8xnxZ2Kx9s5rkjiv1AvzjUf4KNJEk56XlLRBidJz8taU5UZmdgG5EXMRJajH91Oi50NOewF4bxguKXtT//j0CR8gyqHvU47A0Fvhr8rsoge3j9R7Clw0aB1NKkf7+uBHT/bkFncfzfMBXSN6TxUsXVj/JXPtCGfr9NOb7y16Y17tWGJSCyMAZfajzFtQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4asAhT/d8lAQv1bn0HYdyKbzTMnN2UkFGAaoz6O2RoU=;
 b=YfuegFqA06nvPNc4BhS/zF++ig4hWZ7P/z7o+nzcxJgfIrKgH5u3S+q1SanZN06VUjeGx6nHPiNEZ6MrRTx4p79n4a4RFxhkPjwzF13XP1xfymPFvK5PqMSUIIEyjOVzJnvGYRq+Rui2/pVx+U8uC7actbL58bg/VJmLVmQrMqnAWaQR5t4eHrh9+Iy0vppzq/UgQavIZCwFr02BMF3qiHwBLW1npGkfeLJ1QW16KmmHYNN7EYUQIo6sVrnaR0l1k7dOwbmtCIaK206ZsHYqG0H/EKDBkoUa0WnOon8kpTB6SxztagzpBNtkgYoTwQh/W/7jJGd8JmUO+YnIvOPzdQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=cygwin.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4asAhT/d8lAQv1bn0HYdyKbzTMnN2UkFGAaoz6O2RoU=;
 b=Hnpel4cU7yI8/2SYwDLax8KlFcVxsHqMto75RuQA8wG6GhywMM0YlcsohukoCVsjEw6OPJwxy+BarN+Fh5Y5/hUwlAvJFlTkT8TyYk8hMME9MBVEYGEafLP3sPp9+vBW7TadSpaMtWo/aOZRsR99sUkulnIb/uasV5BtM6Xger0=
Received: from AS9PR06CA0043.eurprd06.prod.outlook.com (2603:10a6:20b:463::19)
 by PAXPR08MB6400.eurprd08.prod.outlook.com (2603:10a6:102:150::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Thu, 19 Feb
 2026 08:04:02 +0000
Received: from AM3PEPF00009BA2.eurprd04.prod.outlook.com
 (2603:10a6:20b:463:cafe::af) by AS9PR06CA0043.outlook.office365.com
 (2603:10a6:20b:463::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Thu,
 19 Feb 2026 08:04:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF00009BA2.mail.protection.outlook.com (10.167.16.27) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Thu, 19 Feb 2026 08:04:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RPCkMqt+jwW9AALoW6izbc0aHQW8hN/kP0ZdtXmIldplt53KbenwHFUbaAAtb0U/rmHfk3aiyqcHA/Z8EPryhwyffdh/cRj/TvdPHyJm/S2KHJ55z2+/UAowDkJ+VpcyU6r71essnzGVfsIj6Fv+pPU9FGtOTNS2nXOBQKstxOoa0vmrZy7dzEOCuOej9R6gurCZ6P/ifW/rqjk6e+SRx+m1j8hMs8/tKVuI8V+4fB2iqm0RL/khSivqvmt8QWJHLEQFEnNpat6H0+jAC82A1JsWQy8LxZbttlJL/uObzzpAc2nOZE6s8qu0MgTyYYoPMv87VmducC9zBO/+kfIVCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4asAhT/d8lAQv1bn0HYdyKbzTMnN2UkFGAaoz6O2RoU=;
 b=BqzP3UJObSXohSt4JRxMdV9s/GCT3sS2of2PZbGG1Zfp5yVhyYKfuwNnWbsXO+cadMZTvN24g/U7PXVvW8lLvK3+Vu/0VR1DfzM6jiuAO2CYE6LJMjkDM4dYxTBjOzvyxlQCWnQCRdrnJOx8DvpwwEnaGY/TAgmfVNAbWH1GMa93fGbSRQNttnu0J5fihvhIFkrdrpcihWG/GetWcF17xDW0/ErQ5ujmmsfrgcoBBPNG5yD4oJl0Ina6sHXsUoBy4XTkcFvq/mVGPX7jbP0Q27dnB9QJnHjdDvBTD1sD9gu+fJaBrPBmHgHWo/Gdv6bj3jhjB86Uwtim5veWi5veBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4asAhT/d8lAQv1bn0HYdyKbzTMnN2UkFGAaoz6O2RoU=;
 b=Hnpel4cU7yI8/2SYwDLax8KlFcVxsHqMto75RuQA8wG6GhywMM0YlcsohukoCVsjEw6OPJwxy+BarN+Fh5Y5/hUwlAvJFlTkT8TyYk8hMME9MBVEYGEafLP3sPp9+vBW7TadSpaMtWo/aOZRsR99sUkulnIb/uasV5BtM6Xger0=
Received: from PAXPR08MB7247.eurprd08.prod.outlook.com (2603:10a6:102:212::7)
 by DU0PR08MB9025.eurprd08.prod.outlook.com (2603:10a6:10:471::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 08:02:55 +0000
Received: from PAXPR08MB7247.eurprd08.prod.outlook.com
 ([fe80::e2f7:f38e:3321:44fe]) by PAXPR08MB7247.eurprd08.prod.outlook.com
 ([fe80::e2f7:f38e:3321:44fe%5]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 08:02:54 +0000
From: Igor Podgainoi <Igor.Podgainoi@arm.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: nd <nd@arm.com>
Subject: [PATCH] Cygwin: signal: Implement sigdelayed assembly function for
 AArch64
Thread-Topic: [PATCH] Cygwin: signal: Implement sigdelayed assembly function
 for AArch64
Thread-Index: AQHcoXYmqRrTtgytq0iOWURFLC7Hag==
Date: Thu, 19 Feb 2026 08:02:54 +0000
Message-ID: <aZbDndyBRw1ZmRvh@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	PAXPR08MB7247:EE_|DU0PR08MB9025:EE_|AM3PEPF00009BA2:EE_|PAXPR08MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: c6d2a32b-2443-4221-bacd-08de6f8d713b
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?UjV4WUlYNkttTHRUeFZ1OEEwWjVYQkszcmlmUmhlVTBrVzlxb1RsbFRBbVJ5?=
 =?utf-8?B?WG4zTzNlOU4yTDdoOHlCUEpQb1IzSmJJVE4yVDdtaksyeHhPTEMyNUppV2tG?=
 =?utf-8?B?ZUcxS1UwSWxLMW9rWlpqSWlHMmJQdEVpc3lxZDRvODBZYWdNaUhBeklVTk45?=
 =?utf-8?B?MUR6NUR0YjU5NHMxZXhlWGpITUxMbG0rcXVmTmF2VXFCaUhWa1Z2aVB3dzdX?=
 =?utf-8?B?cVBhTTlDQzBYc2hCZUJNc0dlTWt3L2VNK2g3SnN4YXBpWlBpS0d1U3BocHZD?=
 =?utf-8?B?ZFJxL0RDZEhFM1N1VEZ1eHV0ZW50dFYrc3JranJ0d2hZeitrb0JyMWRSWGNw?=
 =?utf-8?B?UHNwSHViUEpEeCtSaWlIRnhNZXZmRnJRcUgyeFpRSG5ybElzSU1Ob2Y2NFNT?=
 =?utf-8?B?QktZeEJLVXRmRzFCdEowMUpwQlFzci9Yd1BndGVWc1I2MjJibE1KR0RSMDE0?=
 =?utf-8?B?WSsyNU9jb20xdHNzMUhvTmV4K0xKVlVsQUk3V1MvRXBaUHE2azFXbW4yQzJm?=
 =?utf-8?B?NnhpSlppVytJS1RWbGNmbWZhRmlxbDhPdUtFM3U0RlVlMkNNQlFaT3ptbktC?=
 =?utf-8?B?bkdyMElGSEE5bkNMUWYrbzN5QkJzQ3daalcxMDdncHZTbS9rUUJadk1pTzBz?=
 =?utf-8?B?UnZEcUFZQURNNTUxOGh6ZDFlUllPVHk4RTI1ZW9yMUl3U2U4Q3JPNGpieUdN?=
 =?utf-8?B?UkZ0aW45aEJzbWluZnBCZkF4M0JYR3BNUHBDdlhFNTVTQlFrL2VVd2NqWE0w?=
 =?utf-8?B?VnN5UjFQb0dUbVpCVEMvNGIxRCtKTUtzQUVIZ0lrR3BnNDdXMUswZW5ZTUNu?=
 =?utf-8?B?ZnQyTVRMNjEwdkVVclFFK0hzY2FXK0xVMk4yUENIY0VvN3BJd3BxODlJSFBY?=
 =?utf-8?B?dzZQaDl0KzJrVEloZkdRZ0l0VkZHT1pLRHVlVDZnU0F0WiszVk1hajBqU1M5?=
 =?utf-8?B?dEZtNVpBVTlFUWQ0clBabVBld2lUb3pNOWFxemtqNkN6d1lrbStHbG0rakpo?=
 =?utf-8?B?UDNrdkZNQ1IrU1F5L0NiWFVZNjhKOGFWUHVQRnhUR0JHSTA1MGxnd2pGZndh?=
 =?utf-8?B?VU5DTzJwZk45dEgrbWdXQTVsWEMwejZqZE5uc0p2bnNSVjhPWldRdDNlZTNp?=
 =?utf-8?B?b210emJYSEtsWHFNMy8rYm9nM3Q0T0hyVTBGNjVEbFNmNElqd3kyWkxMYXVF?=
 =?utf-8?B?anR1MkI5Rk5SY0c1Q1o0cnFvbVRjWXVPVm1aR0tScmpyMjFJeDRCUDBac0pT?=
 =?utf-8?B?YmQwSkRFK29RbmJBb0k2V21jeW1udkpUbG9KaGF0bElISUF5aGFqaXR1OEls?=
 =?utf-8?B?OVVCRnJWUDhnQjY4YUdjdWRxbFY5S1pBTWwrUHhjcHVqWHZOSGFoUlJIYzJn?=
 =?utf-8?B?UHBaNFY1WXAxUWNsY2NxWjQwd0laR1BUSm5USXQ2QzFCZGtXckt3SHFCb0Js?=
 =?utf-8?B?Y3FNRmtodm5INUJpZ1MvQnkrREh3M3FPQm55UURjTGNPMVdOWGhjYVV3QzZD?=
 =?utf-8?B?NjRYNmNVc1hQL3NGNHhOV05BOE41eGNHVld0WGFYWG9jYnBWdkF3N2EzYWsv?=
 =?utf-8?B?Q09yR0ovaUc2VE1iclpJcEF5dWdXY0FlbkIxRVpNVFVkcHZzUmVTYTdWL3o2?=
 =?utf-8?B?ZjVMc3gyUjlGMzVHSzJNNUU4L2VSOERFT2swdEtDeWtnM0R3YkxIaENDQXB6?=
 =?utf-8?B?MUY1bURNeUhVeFpRQjVTUENrR2VNdE81MFppLzdNcUk5U3BqVS9lWXVpTUVU?=
 =?utf-8?B?YmloS3k4RVordUZIL2w4TEdRcDFxUVVDZkRlMVNSZVFMWnUxb01OVEg1SXRh?=
 =?utf-8?B?ZWJ4c3NjZFJXMlNVcW9pcjN0SEFmMzNaZ0Nma0hGUEtZZkt1QnhVVlpvc0Nt?=
 =?utf-8?B?NFk4S282Tnp5YmswWUlKbXpWV2lsb1RLd0ZhVXVLS2ZMUmRMd1c4U0xRdHR3?=
 =?utf-8?B?Vm55cGg5QWt3ai9scURDeitkT0t3TFJyMEkzNWxBbzRiTHlsZUQwUnRYc2tv?=
 =?utf-8?B?N0x3NmhkVkV3UEs5NHJ4MzlMbGZQS2R1V0Z1SkdEUTZuRlJFOTFINDNUZnZY?=
 =?utf-8?B?b0RsU3A0UktXeTVMS045RzJBZnhBeE4xRE9UaFlMaHlJNUpqa25KaDJzdW9M?=
 =?utf-8?Q?pIGIvAsg2XhFDnGi8HEbV19lR?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB7247.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <D905FE8A269265478B793DE5909B1633@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9025
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009BA2.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	05feaaca-7eee-43b0-8d20-08de6f8d493d
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|1800799024|36860700013|14060799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MDdhaDlBVnhPY29oM3RxS1A0cStick53RStGMTNxTWxJMWhLM1FFOWI4T3BD?=
 =?utf-8?B?YWZWS2dhd21ZQzRGTGRRcEdOZGs5NVByOVFEVFlIRWJ1VHJuWXdGWkYyeDVC?=
 =?utf-8?B?ZTVmZnk0dmxrUVFnTEVoQmZPa0JsZEZCK3NSK0hCQnB1cEFxOVo3VmJoRCt5?=
 =?utf-8?B?VktMZ3JHcUZhY1V3a3VCZVJkZGI2ek9kcUtFYWVucEdIMjhlOTNVUGZXS3pt?=
 =?utf-8?B?V0QrRUtBR2NFblRvQjV5azZ5RUoxcjdZOGdlU3IwOHA3ck1vYVh0SUpVcFRS?=
 =?utf-8?B?emhCMUFKS3Z1eVU0eUxhVVVMWTNkNVVLOEZaYnE1R3NLalpQb1RGYmh1MXNu?=
 =?utf-8?B?U0tFRVd4d3ZlK1poLzRUSjVnQnAxQ3RSeEJMWEdURW9wOXRYVUVXMk8xS1NK?=
 =?utf-8?B?M1RtdU5JV2pUQktOSWRYcTl0UjdwK1EvZHN5UHlTbG95a0hRbGZrSjNPUUQy?=
 =?utf-8?B?UjRQVWRKRFVIYWh4SU4rNHlpblhhbVloNUE3MHVJNlZ1UHRXVFU1Tm5oU05L?=
 =?utf-8?B?VmFTSVlOUnhNL25ScW1ZNzI5RjhyTFhyTGxMMll5blp0aGZmakZ6UWRGTktL?=
 =?utf-8?B?d1RMV2V2eFlkdVR1Q20rcEZJV1E1ZW0xNDFmcHdCY0x4RG1nVzBrOG84TjdP?=
 =?utf-8?B?UTFZOWdUd053VHI0aVFoZzZrMm12b0ZZQmo3eHlrY1M3bXJPZnhla0NTcG5D?=
 =?utf-8?B?Y2dwSVEyUW0yY05rLzZ3QlptbmNyN3Y2MmlUWURRK1pJM21TZTZsdzZlM3RW?=
 =?utf-8?B?cEYxckgzY0RrR1I1QktoNWlPWVVKQjRFcWgrU3VSQTNPTXNuTkxEYnBrcGU4?=
 =?utf-8?B?eGhEcjNBb3Mvb0FJN21GWk5mdVJ4aE0rdk05TTJBNGsvLzkxRG91WGJsWlh4?=
 =?utf-8?B?UXI2c1UzWEN6NGRrdTBoS3ByNzR5OTNyYlZDNTYvOTlIOTl4bStneG5sUTB6?=
 =?utf-8?B?SE9Bb2ExUzRjRDFxMlVwbHVHN3NrNUM4cXZJN2FvbFFOdGFTaSsxaW1PQU81?=
 =?utf-8?B?bVd5LzFGQzRVWVRDcjYzL1RWNHFkNnpSak5hSEdFaDB5MzdXNDRWeHhqeUtl?=
 =?utf-8?B?ak54Qm5FWkgzOXliSUNkL1QvM0puejMzVWIycklTeTBnVTlMay9abVBkYzUy?=
 =?utf-8?B?MS9XbE1SNnpIRW12YVFQeUtXb0F0VHNBS2hDaEZhcDBrZVE1Wi9oRHl3ZGFU?=
 =?utf-8?B?WWppUS9NNWZwa0pGdjJsNTlXcWtoeVd3cUZ4bCtUR3NxdlN2ZjRFWXdrRGtX?=
 =?utf-8?B?OUhIbW9FZU41M1k3TXZySUdRc1Eyd0E2aThmTURjdnJ3V080S012Q2FiN0cx?=
 =?utf-8?B?SUlTbzR2NHpDemY5U1Jma1d1N3NrVDB4bGFhVkp2M0ZOYUNmdkJQa1duRVM3?=
 =?utf-8?B?NnFiUnE2V2pQTDFkVmQyNXMyYUFiUkZSRGJOY3E2bFFPVHJKZXdPV0w0enZY?=
 =?utf-8?B?bzRubWx0MUxscEJVdWtxOFFVdElycHJDMGhSM29kRVJCdHo4ci91ZDJmK2xZ?=
 =?utf-8?B?aWx0SUQ2TWxVdVc4emk5WXZFTnJYTXZENUFXZGphSkQyU1ZnNjVuZ0ozclhX?=
 =?utf-8?B?cW14MzlaOEUzeGFqb2taTkZucTduUUc1YlFmZkdmVU1Dbmw3Sjloc3VOUGlT?=
 =?utf-8?B?SEFGcm9GRTB3Y09xQlU5bk9EZEZZaWNOQnVYODJ1Ny9neVdjejNHdnF4WU91?=
 =?utf-8?B?VjZsZXFnMUVVRVNkM24vMkUwT0Z3RnhYYUN1ZlMwc0Q1NFJmSStHVmxnNXZH?=
 =?utf-8?B?Z3diWERWODlYaW1EUVhCYktMbDIwYzJPdi9LM1V6Q1VTZTE4YXg2M1VmdWwv?=
 =?utf-8?B?YkFiblptU3N0akNhOVE5ZTgrVlNIL0kvSmNkcU83RW9yWVltcDlTTU11OFMr?=
 =?utf-8?B?dzdaM1c0dzRzRlFMWDZNVWtRbWE1YmlLTjFUU0pKRlZYeXlyUUhLWE1KMXBu?=
 =?utf-8?B?NUxIVkdUc0g3dWxHdDRGVGdDUUVqdTJDbzJlM3Z3ZDM5SGE2TmdpTE1EZ24r?=
 =?utf-8?B?d0d0UUNTQTVJZWVPRFlnYVJ1Nll4NWZ5QXR2RysrYy9uenFlOGpUMXUzMWhz?=
 =?utf-8?B?ME1iaVl3ZTNvaW11TlpkWS9RWG1QQkk4T3Z2dFcrNDV5ZjRRdWNOY0VPVFZO?=
 =?utf-8?B?ejJVdFo4bGRPZTl5Q2tuMUlKSkpiOTl1c1NhbXZUK0E5SmtqWUF4NmxJRS9R?=
 =?utf-8?Q?LIVPmVvbRMvt5Vmj78xkpYs=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(1800799024)(36860700013)(14060799003)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RTClKcv37MO9jitV3PkZuHxSB2dahpTV5xrFtfBgSKaZmVZ3/0oTMhSi95p0Z7cAXNXNk2Ar4RCdKJcquaj7/MznPK11lsZ1sN0WFTfrTrQT7o3qouXbrXxgFM7eTywi7MsRkkxfEGkgGYW5Ad8AHnjNIWhp/9nlHpKSTr22/fhNudnfh52cftt1t8aUszsh39Ev3o9YXyBgR1N9NPlP+FNtBQgpO2ZLW58xSFrLCRedYSqcw743um2tUh3TdCVFI8n75Sgb/flltkb0hXd3D0aGNc1Ri4SopEHNxMmn26LIiarDSb9VJXOABRQhf9iSZNvZQ5NHTS4Zb7yEo0lTdeo35KMt4nRyvM3akgg6MomiYTBQcJ1DayigqbmPeWW+7c1HbMunLJrSuBo0TiXj4kNTe8TvvGEh9Om4lwypHRHjPgPdHRpxdChrv2cxCJft
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 08:04:01.3680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d2a32b-2443-4221-bacd-08de6f8d713b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA2.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6400
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SCC_10_SHORT_WORD_LINES,SCC_5_SHORT_WORD_LINES,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

VGhpcyBwYXRjaCBhZGRzIGFuIEFBcmNoNjQgaW1wbGVtZW50YXRpb24gb2YgdGhlIHNpZ2RlbGF5
ZWQgYXNzZW1ibHkNCmZ1bmN0aW9uIHRvIEN5Z3dpbi4NCg0KVGVzdHMgZml4ZWQgb24gQUFyY2g2
NDoNCndpbnN1cC5hcGkvbXNndGVzdC5leGUgKHBhcnRpYWxseSkNCndpbnN1cC5hcGkvc2lnY2hs
ZC5leGUNCndpbnN1cC5hcGkvbHRwL2FsYXJtMDcuZXhlDQp3aW5zdXAuYXBpL2x0cC9raWxsMDEu
ZXhlDQp3aW5zdXAuYXBpL2x0cC9raWxsMDIuZXhlDQp3aW5zdXAuYXBpL2x0cC9raWxsMDMuZXhl
DQp3aW5zdXAuYXBpL2x0cC9raWxsMDQuZXhlDQp3aW5zdXAuYXBpL2x0cC9wYXVzZTAxLmV4ZQ0K
d2luc3VwLmFwaS9sdHAvc2lnbmFsMDMuZXhlDQoNClNpZ25lZC1vZmYtYnk6IElnb3IgUG9kZ2Fp
bm9pIDxpZ29yLnBvZGdhaW5vaUBhcm0uY29tPg0KLS0tDQogd2luc3VwL2N5Z3dpbi9zY3JpcHRz
L2dlbmRlZiB8IDE1OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KIDEgZmls
ZSBjaGFuZ2VkLCAxNTggaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dp
bi9zY3JpcHRzL2dlbmRlZiBiL3dpbnN1cC9jeWd3aW4vc2NyaXB0cy9nZW5kZWYNCmluZGV4IGZm
MTNmMWRhYS4uN2ZmMjZlNDk4IDEwMDc1NQ0KLS0tIGEvd2luc3VwL2N5Z3dpbi9zY3JpcHRzL2dl
bmRlZg0KKysrIGIvd2luc3VwL2N5Z3dpbi9zY3JpcHRzL2dlbmRlZg0KQEAgLTQ2MSw3ICs0NjEs
MTY1IEBAIF9zaWdiZToNCiAgICAgLnNlaF9lbmRwcm9jDQogDQogCS5nbG9iYWwJc2lnZGVsYXll
ZA0KKwkuc2VoX3Byb2Mgc2lnZGVsYXllZA0KIHNpZ2RlbGF5ZWQ6DQorCXN0cAl4MCwgIHgxLCAg
W3NwLCAjLTE2XSENCisJc3RwCXgyLCAgeDMsICBbc3AsICMtMTZdIQ0KKwlzdHAJeDQsICB4NSwg
IFtzcCwgIy0xNl0hDQorCXN0cAl4NiwgIHg3LCAgW3NwLCAjLTE2XSENCisJc3RwCXg4LCAgeDks
ICBbc3AsICMtMTZdIQ0KKwlzdHAJeDEwLCB4MTEsIFtzcCwgIy0xNl0hDQorCXN0cAl4MTIsIHgx
MywgW3NwLCAjLTE2XSENCisJc3RwCXgxNCwgeDE1LCBbc3AsICMtMTZdIQ0KKwlzdHAJeDE2LCB4
MTcsIFtzcCwgIy0xNl0hDQorCXN0cAl4MTgsIHgxOSwgW3NwLCAjLTE2XSENCisJLnNlaF9zdGFj
a2FsbG9jIDE2MA0KKwkuc2VoX3NhdmVfcmVnIHgxOSwgMTUyDQorCXN0cAl4MjAsIHgyMSwgW3Nw
LCAjLTE2XSENCisJLnNlaF9zYXZlX3JlZ3BfeCB4MjAsIDE2DQorCXN0cAl4MjIsIHgyMywgW3Nw
LCAjLTE2XSENCisJLnNlaF9zYXZlX3JlZ3BfeCB4MjIsIDE2DQorCXN0cAl4MjQsIHgyNSwgW3Nw
LCAjLTE2XSENCisJLnNlaF9zYXZlX3JlZ3BfeCB4MjQsIDE2DQorCXN0cAl4MjYsIHgyNywgW3Nw
LCAjLTE2XSENCisJLnNlaF9zYXZlX3JlZ3BfeCB4MjYsIDE2DQorCXN0cAl4MjgsIHgyOSwgW3Nw
LCAjLTE2XSENCisJLnNlaF9zYXZlX3JlZ3BfeCB4MjgsIDE2DQorDQorCW1vdgl4MSwgc3ANCisJ
c3RyCXgxLCBbc3AsICMtMTZdIQ0KKw0KKwlzdHAJcTAsICBxMSwgIFtzcCwgIy0zMl0hDQorCXN0
cAlxMiwgIHEzLCAgW3NwLCAjLTMyXSENCisJc3RwCXE0LCAgcTUsICBbc3AsICMtMzJdIQ0KKwlz
dHAJcTYsICBxNywgIFtzcCwgIy0zMl0hDQorCXN0cAlxOCwgIHE5LCAgW3NwLCAjLTMyXSENCisJ
c3RwCXExMCwgcTExLCBbc3AsICMtMzJdIQ0KKwlzdHAJcTEyLCBxMTMsIFtzcCwgIy0zMl0hDQor
CXN0cAlxMTQsIHExNSwgW3NwLCAjLTMyXSENCisJc3RwCXExNiwgcTE3LCBbc3AsICMtMzJdIQ0K
KwlzdHAJcTE4LCBxMTksIFtzcCwgIy0zMl0hDQorCXN0cAlxMjAsIHEyMSwgW3NwLCAjLTMyXSEN
CisJc3RwCXEyMiwgcTIzLCBbc3AsICMtMzJdIQ0KKwlzdHAJcTI0LCBxMjUsIFtzcCwgIy0zMl0h
DQorCXN0cAlxMjYsIHEyNywgW3NwLCAjLTMyXSENCisJc3RwCXEyOCwgcTI5LCBbc3AsICMtMzJd
IQ0KKwlzdHAJcTMwLCBxMzEsIFtzcCwgIy0zMl0hDQorDQorCW1ycwl4MSwgZnBjcg0KKwltcnMJ
eDIsIGZwc3INCisJc3RwCXgxLCB4MiwgW3NwLCAjLTE2XSENCisNCisJLnNlaF9zdGFja2FsbG9j
IDU0NA0KKw0KKwkuc2VoX2VuZHByb2xvZ3VlDQorDQorCWxkcgl4MTIsIFt4MTgsICM4XQkJCS8v
IGdldCBUTFMgcG9pbnRlcg0KKwlsZHIJeDEzLCA9X2N5Z3Rscy5zYXZlZF9lcnJubwkvLyBnZXQg
b2Zmc2V0IHRvIHNhdmVkX2Vycm5vDQorCWFkZAl4MTMsIHgxMiwgeDEzCQkJLy8gc2V0IHgxMyB0
byAmVExTLnNhdmVkX2Vycm5vDQorCWxkcgl3MTksIFt4MTNdCQkJLy8gcHJlc2VydmUgc2F2ZWRf
ZXJybm8gaW4gdzE5DQorDQorCWxkcgl4MTMsID1fY3lndGxzLnN0YXJ0X29mZnNldAkvLyBnZXQg
b2Zmc2V0IHRvIGJlZ2lubmluZyBvZiBUTFMgYmxvY2sNCisJYWRkCXgwLCB4MTIsIHgxMwkJCS8v
IHN0b3JlIG9mZnNldCBhcyBmaXJzdCBhcmcgdG8gbWV0aG9kDQorCWJsCV9aTjdfY3lndGxzMTlj
YWxsX3NpZ25hbF9oYW5kbGVyRXYJLy8gY2FsbCBoYW5kbGVyDQorCWxkcgl4MTIsIFt4MTgsICM4
XQkJCS8vIHJlc3RvcmUgY2xvYmJlcmVkIFRMUyBwb2ludGVyDQorDQorCW1vdgl3MTEsICMxCQkJ
CS8vIHNldCB3MTEgdG8gMSAobG9ja2VkKQ0KKwlsZHIJeDEzLCA9X2N5Z3Rscy5zdGFja2xvY2sJ
CS8vIGdldCBvZmZzZXQgdG8gc3RhY2tsb2NrDQorCWFkZAl4MTMsIHgxMiwgeDEzCQkJLy8gc2V0
IHgxMyB0byAmVExTLnN0YWNrbG9jaw0KKzE6DQorCWxkYXhyCXcxNCwgW3gxM10JCQkvLyByZWFk
IGxvY2sgdmFsdWUgd2l0aCBhY3F1aXJlDQorCWNibnoJdzE0LCAyZgkJCQkvLyB3YWl0IGlmIGFs
cmVhZHkgbG9ja2VkDQorCXN0eHIJdzE0LCB3MTEsIFt4MTNdCQkJLy8gYXR0ZW1wdCB0byBzdG9y
ZSAxDQorCWNibnoJdzE0LCAxYgkJCQkvLyByZXRyeSBpZiBsb2NraW5nIG5vdCBzdWNjZWVkZWQN
CisJYgkzZgkJCQkvLyBjb250aW51ZSB0byBjcml0aWNhbCByZWdpb24NCisyOg0KKwl5aWVsZAkJ
CQkJLy8gaGludCB0byBDUFUgKHNwaW4td2FpdCkNCisJYgkxYgkJCQkvLyB0cnkgYWdhaW4NCisN
CiszOg0KKwl0c3QJdzE5LCB3MTkJCQkvLyB3YXMgc2F2ZWRfZXJybm8gPCAwDQorCWJsdAk0ZgkJ
CQkvLyBpZiB5ZXMsIGlnbm9yZSBpdA0KKwlsZHIJeDEzLCA9X2N5Z3Rscy5lcnJub19hZGRyCS8v
IGdldCBvZmZzZXQgdG8gZXJybm9fYWRkcg0KKwlhZGQJeDEzLCB4MTIsIHgxMwkJCS8vIHNldCB4
MTMgdG8gJlRMUy5lcnJub19hZGRyDQorCWxkcgl4MTEsIFt4MTNdCQkJLy8gc2V0IHgxMSB0byBU
TFMtPmVycm5vX2FkZHINCisJc3RyCXcxOSwgW3gxMV0JCQkvLyBzdG9yZSBzYXZlZF9lcnJubyB0
byBlcnJub19hZGRyDQorDQorNDoNCisJbGRyCXgxMywgPV9jeWd0bHMuc3RhY2twdHIJCS8vIGdl
dCBvZmZzZXQgdG8gc3RhY2twdHINCisJYWRkCXgxMywgeDEyLCB4MTMJCQkvLyBzZXQgeDEzIHRv
ICZUTFMuc3RhY2twdHINCis1Og0KKwlsZHhyCXgxMSwgW3gxM10JCQkvLyBnZXQgYXV4IHN0YWNr
IGFkZHJlc3MNCisJc3ViCXgxMSwgeDExLCAjOAkJCS8vIGRlY3JlbWVudCBhdXggc3RhY2sgYWRk
cmVzcw0KKwlzdHhyCXcxNCwgeDExLCBbeDEzXQkJCS8vIGF0dGVtcHQgdG8gc3RvcmUgZGVjcmVt
ZW50ZWQgdmFsdWUNCisJY2Juegl3MTQsIDViCQkJCS8vIHJldHJ5IGlmIG5vdCBzdWNjZWVkZWQN
CisNCis2Og0KKwlsZHhyCXgzMCwgW3gxMV0JCQkvLyBnZXQgcmV0dXJuIGFkZHJlc3MgZnJvbSBz
aWduYWwgc3RhY2sNCisJc3R4cgl3MTQsIHh6ciwgW3gxMV0JCQkvLyBhdHRlbXB0IHRvIGNsZWFy
IHJldHVybiBhZGRyZXNzDQorCWNibnoJdzE0LCA2YgkJCQkvLyByZXRyeSBpZiBub3Qgc3VjY2Vl
ZGVkDQorDQorCWxkcgl4MTMsID1fY3lndGxzLmluY3lnCQkvLyBnZXQgb2Zmc2V0IHRvIGluY3ln
DQorCWFkZAl4MTMsIHgxMiwgeDEzCQkJLy8gc2V0IHgxMyB0byAmVExTLmluY3lnDQorCXN0cgl3
enIsIFt4MTNdCQkJLy8gc2V0IFRMUy5pbmN5ZyB0byAwIChub3QgaW4gY3lnd2luKQ0KKwlsZHIJ
eDEzLCA9X2N5Z3Rscy5zdGFja2xvY2sJCS8vIGdldCBvZmZzZXQgdG8gc3RhY2tsb2NrDQorCWFk
ZAl4MTMsIHgxMiwgeDEzCQkJLy8gc2V0IHgxMyB0byAmVExTLnN0YWNrbG9jaw0KKwlzdGxyCXd6
ciwgW3gxM10JCQkvLyByZWxlYXNlIGxvY2sNCisNCisJLnNlaF9zdGFydGVwaWxvZ3VlDQorDQor
CS5zZWhfc3RhY2thbGxvYyA1NDQNCisNCisJbGRwCXgxLCB4MiwgW3NwXSwgIzE2DQorCW1zcglm
cGNyLCB4MQ0KKwltc3IJZnBzciwgeDINCisNCisJbGRwCXEzMCwgcTMxLCBbc3BdLCAjMzINCisJ
bGRwCXEyOCwgcTI5LCBbc3BdLCAjMzINCisJbGRwCXEyNiwgcTI3LCBbc3BdLCAjMzINCisJbGRw
CXEyNCwgcTI1LCBbc3BdLCAjMzINCisJbGRwCXEyMiwgcTIzLCBbc3BdLCAjMzINCisJbGRwCXEy
MCwgcTIxLCBbc3BdLCAjMzINCisJbGRwCXExOCwgcTE5LCBbc3BdLCAjMzINCisJbGRwCXExNiwg
cTE3LCBbc3BdLCAjMzINCisJbGRwCXExNCwgcTE1LCBbc3BdLCAjMzINCisJbGRwCXExMiwgcTEz
LCBbc3BdLCAjMzINCisJbGRwCXExMCwgcTExLCBbc3BdLCAjMzINCisJbGRwCXE4LCAgcTksICBb
c3BdLCAjMzINCisJbGRwCXE2LCAgcTcsICBbc3BdLCAjMzINCisJbGRwCXE0LCAgcTUsICBbc3Bd
LCAjMzINCisJbGRwCXEyLCAgcTMsICBbc3BdLCAjMzINCisJbGRwCXEwLCAgcTEsICBbc3BdLCAj
MzINCisNCisJbGRyCXgxLCBbc3BdLCAjMTYNCisJbW92CXNwLCB4MQ0KKw0KKwlsZHAJeDI4LCB4
MjksIFtzcF0sICMxNg0KKwkuc2VoX3NhdmVfcmVncF94IHgyOCwgMTYNCisJbGRwCXgyNiwgeDI3
LCBbc3BdLCAjMTYNCisJLnNlaF9zYXZlX3JlZ3BfeCB4MjYsIDE2DQorCWxkcAl4MjQsIHgyNSwg
W3NwXSwgIzE2DQorCS5zZWhfc2F2ZV9yZWdwX3ggeDI0LCAxNg0KKwlsZHAJeDIyLCB4MjMsIFtz
cF0sICMxNg0KKwkuc2VoX3NhdmVfcmVncF94IHgyMiwgMTYNCisJbGRwCXgyMCwgeDIxLCBbc3Bd
LCAjMTYNCisJLnNlaF9zYXZlX3JlZ3BfeCB4MjAsIDE2DQorCWxkcAl4MTgsIHgxOSwgW3NwXSwg
IzE2DQorCS5zZWhfc2F2ZV9yZWcgeDE5LCAxNTINCisJLnNlaF9zdGFja2FsbG9jIDE2MA0KKwls
ZHAJeDE2LCB4MTcsIFtzcF0sICMxNg0KKwlsZHAJeDE0LCB4MTUsIFtzcF0sICMxNg0KKwlsZHAJ
eDEyLCB4MTMsIFtzcF0sICMxNg0KKwlsZHAJeDEwLCB4MTEsIFtzcF0sICMxNg0KKwlsZHAJeDgs
ICB4OSwgIFtzcF0sICMxNg0KKwlsZHAJeDYsICB4NywgIFtzcF0sICMxNg0KKwlsZHAJeDQsICB4
NSwgIFtzcF0sICMxNg0KKwlsZHAJeDIsICB4MywgIFtzcF0sICMxNg0KKwlsZHAJeDAsICB4MSwg
IFtzcF0sICMxNg0KKw0KKwkuc2VoX2VuZGVwaWxvZ3VlDQorCXJldA0KKwkuc2VoX2VuZHByb2MN
CiBfc2lnZGVsYXllZF9lbmQ6DQogCS5nbG9iYWwgX3NpZ2RlbGF5ZWRfZW5kDQogc3RhYmlsaXpl
X3NpZ19zdGFjazoNCi0tIA0KMi40My4wDQo=
