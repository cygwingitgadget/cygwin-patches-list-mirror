Return-Path: <SRS0=YdQT=AX=arm.com=Igor.Podgainoi@sourceware.org>
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	by sourceware.org (Postfix) with ESMTPS id 492D94BA23CE
	for <cygwin-patches@cygwin.com>; Thu, 19 Feb 2026 08:43:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 492D94BA23CE
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=arm.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 492D94BA23CE
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c200::3
ARC-Seal: i=3; a=rsa-sha256; d=sourceware.org; s=key; t=1771490625; cv=pass;
	b=uewnCpPi6uX//HlcEe03ryCpfYvR+S/3lbbY43f47keKZTZOwHqIanWqQkdVbbEna0dZ+uttwrwG5Ou9YSmr7oS+k6Tdcd0iN3xs8D9ZLqnYImeWVcKMyX3sAq++66HEsSFoIw6JsnwvWO+egFPC8ai/ZHRDuQij/BL0VRNqBOw=
ARC-Message-Signature: i=3; a=rsa-sha256; d=sourceware.org; s=key;
	t=1771490625; c=relaxed/simple;
	bh=Tjt2sK80DfuGyd7X0QiXtGGfLpEXGqs7Tw22Q3GbGV0=;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version; b=ei0VZqbQBSPsgS/UC0XqTtcoyL+wog10+vatcnj2PwmjOW81qkapf8m7OqksD5NeFy/RINUxBLrj3z+DXPKvCsRKE4TeFbx61ZLCYsFChX003kROJ/3MxKMuHTogjPrEx9EjoIyqJ8iWWpRtfr4c7nSe8En1STz91TqbetgViNs=
ARC-Authentication-Results: i=3; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 492D94BA23CE
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=XGwHwP+u;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=XGwHwP+u
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=LIjks9s78zwhxgkySeQgGnPcYCEqKM7aea+Siz5MgCsueaWfTvXpWBHloUCHuu4DydnxziF4EfYa5zVCwKqJGXXCSAjz+k8v5qOtZMTx/yDf4Xiqvzis+eEXGSFGVghi6lWomGfpnQ84laFKOAzTFF+rJ9MvSUxwJQRsa8JQxA3uYdZTe/JRo+Rdf05ZpmDpwbSieLxNYVblNTqsgFf3gAsYvpIOWsHL3e2VnKsw0OXr+Ruh98BtfrtqPhJP9sANZoxHZP8BVfb4v4nsGAILi1O8zvL+TJmjJjVrfi6fyBLmnbPOxEoH3k0Z86tiddcOFqlB22xNLIjfBdna53h7kw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tjt2sK80DfuGyd7X0QiXtGGfLpEXGqs7Tw22Q3GbGV0=;
 b=FYxueX+JbhT3Um37qzh8rW9m1U0KOVOGwmvP9/s82BQmVG3A5rc1mkmb4OJFQzdr5+g/c4lIH9xduJUPkSLWIZ93FCswKj/Pkch+iO7je86Y1shW/8NQdouPUGH+G9Kny+sm8FcpzXWAd48EAXTMSkKqUz6NsGWSNHmu14qq1uBhqM+iWNTB5s1LKa7PKTr4WURSDbyRHk5dQmtucb0obR9ygvuSu1Q2QRtgqljMtxuIQK2cTz2zQ5BrjjhErLVb1bJH2GfPt6NMlATFhr9kGmSVyZTdOOm7JpEmDe8G5TzIAkf9kQFKtMTRKselobr4akTvfsb07Q8Pd0YwXtJimQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=cygwin.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tjt2sK80DfuGyd7X0QiXtGGfLpEXGqs7Tw22Q3GbGV0=;
 b=XGwHwP+uEULqAoSZx8bzHXM3wvRQCqckhgR5OAy70gTtBW/6ccLAza/gMqX3Dm7FWWZHYjc34WQs2X+3gJtvftRT69kc54ZVVEvcVFsdO95Z5bng3qraPYB4BbNLPi1OMZfx3IUF0qBrAGfJrjANZdwnemy+KXrOWXMUHEI14NE=
Received: from AM0P309CA0012.EURP309.PROD.OUTLOOK.COM (2603:10a6:20b:28f::19)
 by PA4PR08MB6286.eurprd08.prod.outlook.com (2603:10a6:102:f2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Thu, 19 Feb
 2026 08:43:38 +0000
Received: from AMS0EPF000001B3.eurprd05.prod.outlook.com
 (2603:10a6:20b:28f:cafe::bf) by AM0P309CA0012.outlook.office365.com
 (2603:10a6:20b:28f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.0 via Frontend Transport; Thu,
 19 Feb 2026 08:43:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001B3.mail.protection.outlook.com (10.167.16.167) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Thu, 19 Feb 2026 08:43:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eW8YJME58aJHE9H5KR5wThIq3YGKtkLU1OZaRoKeAh49RxoFPQmgk/wnCPYzoQFB2bhQ5fAJRDadgEBKwLlp7w2jDPo2DEuDtv9sUld6E4rHIIuj42SFA/i3amcwpgTNyj8/9VOB7wHcndDQRbr+o4/XHA7ekRn6LtcnO8vT5ftlgYbWGmSw5VlmmsYvu+MyeUE29EhjvCQ6C5UiigWGzlPg3vQrT8Xq3wbeftQrae/O2pyNAJZ2uup5Iiz0F6I4NuRUU6WWUdRqzccKa49rakBvCu/hl1DA/a8zGkVRkhCbvkpmJ17O5ztvvh5UhDMf0Gdd+uEJz7EOMfIQinRZGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tjt2sK80DfuGyd7X0QiXtGGfLpEXGqs7Tw22Q3GbGV0=;
 b=DTU4J3YtKPzo7zdgnT0E14qD1EVZKi+kz8AtV97+ojNPTXGNM5/rmpfkatyPCvx3v+P3bMe9tGPcXB2XOOHtnv5TSzF4aTW5xgRKejjfl6Wy0aOydvcxRucT+0YPKP5/ok4nMcz6jpcN0U5I8Q9HJ8pRTaL52AbwjO7BTMiOYwtfS+uKz9FQMPYC6KUAbCRTuxcWyTihV8BYpfwbRH13zOP6RrU/HMDdb2l5w+I6yUX4JgphyNXdzGUlcQDPHKEfAileMVoMqv1bC74ntWLskBqdc3m2ENd7VRp9gUb+ADFQ5Q3UeCrUka4wuomWm56+8iq4VWmNUWAgoaJFaNdidw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tjt2sK80DfuGyd7X0QiXtGGfLpEXGqs7Tw22Q3GbGV0=;
 b=XGwHwP+uEULqAoSZx8bzHXM3wvRQCqckhgR5OAy70gTtBW/6ccLAza/gMqX3Dm7FWWZHYjc34WQs2X+3gJtvftRT69kc54ZVVEvcVFsdO95Z5bng3qraPYB4BbNLPi1OMZfx3IUF0qBrAGfJrjANZdwnemy+KXrOWXMUHEI14NE=
Received: from PAXPR08MB7247.eurprd08.prod.outlook.com (2603:10a6:102:212::7)
 by AS2PR08MB9101.eurprd08.prod.outlook.com (2603:10a6:20b:5fd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Thu, 19 Feb
 2026 08:42:34 +0000
Received: from PAXPR08MB7247.eurprd08.prod.outlook.com
 ([fe80::e2f7:f38e:3321:44fe]) by PAXPR08MB7247.eurprd08.prod.outlook.com
 ([fe80::e2f7:f38e:3321:44fe%5]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 08:42:34 +0000
From: Igor Podgainoi <Igor.Podgainoi@arm.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: nd <nd@arm.com>
Subject: [PATCH 0/1] Cygwin: signal: Fix stabilize_sig_stack/setjmp/longjmp on
 AArch64
Thread-Topic: [PATCH 0/1] Cygwin: signal: Fix
 stabilize_sig_stack/setjmp/longjmp on AArch64
Thread-Index: AQHcoXux8GHwP43C2kCTVr+ixo7Bww==
Date: Thu, 19 Feb 2026 08:42:34 +0000
Message-ID: <cover.1771489560.git.igor.podgainoi@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	PAXPR08MB7247:EE_|AS2PR08MB9101:EE_|AMS0EPF000001B3:EE_|PA4PR08MB6286:EE_
X-MS-Office365-Filtering-Correlation-Id: 1975f9a7-5b13-43f2-a832-08de6f92fa1f
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?MlZ6S3Fwc0FWZURac09lemNsbUJLeXN4TXdrbkNxQVJZcUg0RmNOSzJ3dlYz?=
 =?utf-8?B?MkFvbURkekZnMjNWTm96SW12TEcvMnFRNDVSSGFEUnFTUUNMS3lpbEFYTUtx?=
 =?utf-8?B?TkRCNlhtVVpUK3FKQ0ZSSjhYL3BGMVVhSVpURUlMWU9VZEQ1N3U2TE1rSitL?=
 =?utf-8?B?czZzYnFZQkQ5UjQ4b3ZYVlpWa3dvTXVYcW1wdWNuUmR4RnpWRzJ4dFpwVFg4?=
 =?utf-8?B?bmh2K2ZkUlgwNTcycE1YQVRNZ1BNcWF1ZlU4bnA3cVlzTHpmRTE5RlpaQ3pW?=
 =?utf-8?B?OGRNN2d4ZkZhRjhwcUJMZVJPK2hNS1lvektLazlvblJwczhjTFlPMkwrL1Ru?=
 =?utf-8?B?SFMzZU5QakNEUmJ6U2V1bkd1YWgvVmY0TFRVRDdjU0IySmJObDJWa0ppcDVr?=
 =?utf-8?B?a3A5RlRQSzlyOEV3TnZ4M1BUVEtFcTNUeXk4cUk3WUZpdUFid3QvOFZ1aStk?=
 =?utf-8?B?S0QwVExlWUl5UmVMUTl6Z2VtRDZXcjh3UlJJRUc4TWtrMk8xYXNwSzF0QW5N?=
 =?utf-8?B?dUpObUhBMWJLcXJndmZiNXVHZTVhTEFqU2Q1d1RsWWs4ZjZ3M1NyVjVIb1VF?=
 =?utf-8?B?djVncUxGNlhyVXpKVXErY0FqeFVGQlNSMXJ1Z2JQNCtueExDZ0F6UitJdHBM?=
 =?utf-8?B?aGxJbnJHUGVTOUpZVlFoNFV6NFp1WFlqdVBkVm10QmhjbkFKNG9OQ25rbVkx?=
 =?utf-8?B?UUZFSGlucndoc3g2Wm1hMy9XWklEbGtXUU5tRHdxNXpJakY0aFl5a2VMOW12?=
 =?utf-8?B?a1IraS9BWHZ6amlvanJTSmhrRjRmUHZ3a0lGamZha2VDTjVwYXBuV1ZXN2dJ?=
 =?utf-8?B?N0Q3L29yRUtwbkhXNm5aM0dRUkllYUdxbHN0eDdBTGlnZkx2MXBRWVBTTjFn?=
 =?utf-8?B?TDZxSmNTeUgwakhMSDAreml0L0FVdE45SXlldEdoZCtZV1hCV3JvTlNZNUUx?=
 =?utf-8?B?cDJOUGUzRDBrYjZmM054bTF0S2tvUnpBbHIvUjhQbTlwSlRKZThTVENzbEVM?=
 =?utf-8?B?Z3BMQzBUTkl2aVhEWk14NXpTdENQYXZTQUU2VnBmY0M2L2Zva1FxZElESlpz?=
 =?utf-8?B?dE8veE5wYzZYVXZBVXF5cFVJWlg1RDJvbzBPT1k2NDlQMHZiUjY0V0RST0Z3?=
 =?utf-8?B?cC9xcmI1S0M1alJ1SUhFZmtmZVAxQTVMRzBUYXRFWVhPRnNXR3NzdXg5Y3Q5?=
 =?utf-8?B?K0NqN2hJa3BwUGVJejc2NE5pbVdtOVJzVkFNOFRlOGpoZlpQckh3M3NTSTA3?=
 =?utf-8?B?blRNZGVQVy9oM2t5ekozV1U4M3hyWkV1ckhDL1QvSDBnRXhTenp2enJmTmdD?=
 =?utf-8?B?cERWcklTYnRxYXk4djZtTDk2TVNJdnQ2K2paVjMrVGhaRkYyWDBzT1VKdThH?=
 =?utf-8?B?bW13K3EzcXc0Q2NTMjhBQXZBSFFndkh2SDliek52bnR5Y1cwcUpmUXVzUndE?=
 =?utf-8?B?YWpJNVVrVUl0T1N2d212VXBjc0UwOFJlS1RwL3J4cHU4UUdlK2p0QVkrallh?=
 =?utf-8?B?STc3UFo4R2ZieFlSa3pWNFpmRnhmSUhMSjc4RThYeVdSK1hLTnl5OUdrZjNO?=
 =?utf-8?B?UXd1ZXZkWkxpd0ZSazdnWE9YakJkSDBxcUJ0eExhZWxjQnhCNEZLY0ptT09Z?=
 =?utf-8?B?emVrNDhFbXNTeUQxUlh6bjY0c085eDd4UzIxSnBrRnNMZkF4bThLNHl0bSsy?=
 =?utf-8?B?c0ZVU2pqeFU3ajNYbjRlK3dweUMwMUROUWJMZXFOdFFkeENwcytqZm1XNUM3?=
 =?utf-8?B?cWp0RXlWMHl0TllidnNRbG9PNnJpYXJweEVtRVpOVlN0MGRNcmM4RmdZYjc5?=
 =?utf-8?B?VUdBQ1FVUzBlcW5vaUU3bmJpaUtKSVZUdTVTYnNrdnErRkJTWmQ4OXVHalhl?=
 =?utf-8?B?alVSVGl1TjBZNVEyNXJlOWFGVS9CSm51WTVpblcreHExdVZ3VlA3TS9IU1Yr?=
 =?utf-8?B?R0drdC9uNUhRNVBrWmdUenpZakFNSnE1MlJTcWE3dThSUzFQS0pJS2IwWEJ5?=
 =?utf-8?B?UXVRdXlKVW8zejNZRHdOQ2VPZnQ1T1pnTHVNbFBCY0xobGRrZ3VlSjEwa1ho?=
 =?utf-8?B?UlgyUlY5cGliUHJEWDlCcjBLa1ZUdmVqVmxTYmthUnNpYnlHLzdIMHpZWnJ3?=
 =?utf-8?B?UGlWV29JbDcvTXozVmY1NGsvODV2U3JxUW5RbXBmZEdxdWt1SlJiaHFlK2FR?=
 =?utf-8?Q?lyH9EWrvNI1pmF9+ML/rDXE=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB7247.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <604122927802FB4FBD7F89A6D3ED43A8@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9101
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B3.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7184b2ce-54aa-4143-415f-08de6f92d408
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|14060799003|1800799024|35042699022|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkNPSmxGbko5MDJPZHpIQTh3ckgzUE1hM2hmMmxTOTJTS1pzaWZuU3ppVXdD?=
 =?utf-8?B?U3lIZTNDL2U3bkhqNk9Wb3U2Mjd4NGRPNndNdXgzY3NySWFEYmx2ZnNCNkNY?=
 =?utf-8?B?RXJnUGJJcm9wR21wWG9HRENQYi9vSjZGMTVCMytiMm91QklQNWxqWlJCZHFU?=
 =?utf-8?B?RDg5cjhRaE9vU1Y2dnBidFY3bzBSQXc0ZGtqMmtiem1nWmJoRGZkUlJYYzFx?=
 =?utf-8?B?UXZ0OERuL3FocExSQ0JpY21Kci9nV0ZzeTdrU1cwTGNFVXNFNDZPWmxiZXN1?=
 =?utf-8?B?OTEyVjZSdWp0MTlMd3FIdjNwTHZtMzU2ei9uQUZIeWpsSGU4MjRIditVanZt?=
 =?utf-8?B?N05QdWt6aUtxZk9YYzhrZlp2eVhTTDdybHJub1V4c1cydWl4c0Z2NnNEWDIv?=
 =?utf-8?B?bEFIYTd5alRpdnI0NWkvTnlJQkltYjJCdGpNVUJWSnc5NmhENHdrZTY2dTBa?=
 =?utf-8?B?Y1hibSs5SVRmSk0wdXNiQTdSY2dGWFlJZGx4MWlWQkovT2JlRjBmQnRPeUtZ?=
 =?utf-8?B?Um5URDN0THJaTS82cW53dEg0VHQrMFhSTEVZcTlvemt3YWNhMVlEZVdNMWFp?=
 =?utf-8?B?Q0Uzdkt0UGVnaXVSOFloT01GK1Mxc3FVenhER0Rzd0lmRkJYSTROQm9vK1FP?=
 =?utf-8?B?UUpDVzduS245VFF4ckoyQW4zTFFDUHRMOTJrclZCSVNZUUo4OHVKcWZLbGVY?=
 =?utf-8?B?WUVvLy8zSE9WUnpEUDMvRXlwZm0vcDgrOFU0bW9mb3JTcWdqdXJudGZmR1JT?=
 =?utf-8?B?eG5mMWgwQ3JwU2VZZ2JMRndkR3p4cnR6NkdJV3JzenF0d2ErSDk1dW9xckhp?=
 =?utf-8?B?bXMySDYvYmY1QkJsY1lZYXo0TnJybHRBS2lpb2djc3BVa0drZXlMVWdYeUdD?=
 =?utf-8?B?aVIwUm5sY1dnUjdpUFhGbFNIMXZoRDl5OGVPZUNqY2l4K2NKWjA4YUFjdW11?=
 =?utf-8?B?amdYQ0lKd3lMUXFVYkJwNmJkQVl3Ry81aFcwWC85b0pPNHFnTnNyT21OZCs4?=
 =?utf-8?B?TTAxSVVhaS9nRG9oZEJlNFBteFlyRGxjdENmT2gycWJueXdnMUhCSW1CZjRE?=
 =?utf-8?B?M3dMc2VwN3hXMkpBSXFuN09hNVFhNkFwZ1REV2tCL0RUT0xlZlVXaHF1UmNT?=
 =?utf-8?B?QUxESE9vSFBsblVSNnJtTW1IZStVa2ZIUXBnZkZUdElzQTAwNUUwcXVEMnI0?=
 =?utf-8?B?cEhFWVpSWks4RVVOeWVJcTk0cER1ZFhjL2Y4TnF6WWg0dEdoeTNBTkhjTUxp?=
 =?utf-8?B?ZWtmSnl2T1hpYkpqQU5UN1laVDQ1bUJEQjRqOGMrMkxuSm1Va1JRS0ZxWklq?=
 =?utf-8?B?czJseDcxeUJFWC9qR2pTblQxZTYyNDFRWUFuQ2ZMWklPVVJiaGhIeGJMcWIv?=
 =?utf-8?B?Z1VmdG85c3h0MTZVWVJCVjZyZkQvWXV5bk1kbG92NkViTFVFNjF6Y0UwWmFj?=
 =?utf-8?B?SDJFNHY1b0FOcVJseDYvdUhxcHdnaG14RTRmVDdKdS9EZzl2cVZGVzh4c0VE?=
 =?utf-8?B?WjhtL1l0RzFBaERlSnBNLy9reEJYZjhhbEwzb3YvUElzdDI1bW9qQjVhdlds?=
 =?utf-8?B?RDFOSEJVelNKbDdkS2gzZjJjSTdxQTFCYTIvZUhtYTRJTXpTL2JKSFBxLy8w?=
 =?utf-8?B?S1VCSkdaWlRERnEwbGhHWExWVUhuU0R6OUU3RGRCZXZhd2FxQVdvN1NrV2F4?=
 =?utf-8?B?WGl0WVVEOUZpNjYrY2l3QTdZYkFrd1hnVXRnOW1IVXJnQmlUeWYrMytlUGNi?=
 =?utf-8?B?MDZQdlc5bzFxVzgza0ZuTUo0djVpR2FKMHVsYWpNWmswMUxxZDd6bXgrRDZx?=
 =?utf-8?B?TGMyWHZPSXZBNnZNSFhzVWJ5cWJlM3RkNmZNTzhSNGlHRWlIVy94V3pXUXBW?=
 =?utf-8?B?Q2pKVGVZWThFdFVKajgxdjVkdXhjdHl5WkJRaEZXbkVZbWtkY1p2d2RlU1Q0?=
 =?utf-8?B?QmVpdktBK3lIYVhZd00rVkx3MmdlUUxPNUR6L1dxM2lpbmF6UEl0b2k0c2Jo?=
 =?utf-8?B?ZS9aTitDTm9YSTNhRmRSUG9RTlpWSXBGK0Y4ampaL1VlSUJIUGd4T2pNNTdr?=
 =?utf-8?B?REdmK1NoVk1FUFF0V240c2VXOW5RNVFiR2xCbDU5Zmhpek1uUEhmRnZ6R3Fn?=
 =?utf-8?B?aFgzaU90L3pnVmtOUGo4YmxyTStSNGFUSVNrdXd0aGdkeGFJM3IzQ1M1WHND?=
 =?utf-8?B?RzVMcDdFeVB1TmtNeFBDSkRmNDNnMWF4cVBkdnBtZkVjUkhYZ3JiWFI2Z1Zx?=
 =?utf-8?B?SjNuRW1jMUZ2UG90VmFJWUFzNVNBPT0=?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(14060799003)(1800799024)(35042699022)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dNjM8NxAVLDe0wsy9Qzzl4U9Lg3NzDuXLDShy7/HwjE2lTsemq2x1b5BwDaYj2bcp6xi3Un3ZE6AZbljb1tYbPo0HmDTlG4x7LNZWnAk516nQ+h/LDmcswjI5sY4GZLUoc6L8azamAb2uk2Xq8ezxkCcjAdsmT6KQ4EDCpY8NnsudsJAqtyeMXPso6ZYLpbWMn2gIBXqq4b51jFLiFW6BJCsNDtwx5HV5emo/B1vmKZurjoPaDewsROGRxvkGWbhziDckPL9n1jI4LSObK9xEb7o42ElqeVPY0HfTpsuQWWqW6fToZJuaSsPCyeQPBOUs/ouJnm16zCNfL7fmOa0QQrVE7Jyg86K7ZUUOB0sCnizyrT1hhaiGG6X85BlAAAjHJzRAfB20SG2ah4yMD4dFtj8r8uZpySoZHOjCjOYDbtt+7jJxCPA+RqZMtMinNM0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 08:43:38.5185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1975f9a7-5b13-43f2-a832-08de6f92fa1f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6286
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,TXREP,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

SGVsbG8sDQoNClRoaXMgcGF0Y2ggdXBkYXRlcyB0aGUgaW1wbGVtZW50YXRpb25zIG9mIHN0YWJp
bGl6ZV9zaWdfc3RhY2ssIHNldGptcA0KYW5kIGxvbmdqbXAgb24gQUFyY2g2NC4gSXQgZGVwZW5k
cyBvbiB0aGUgaW5pdGlhbCB2ZXJzaW9ucyB0aGF0IHdlcmUNCnBvc3RlZCBlYXJsaWVyIGJ5DQpU
aGlydW1hbGFpIE5hZ2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJl
aW5jLmNvbT46DQoNCiAgaHR0cHM6Ly9jeWd3aW4uY29tL3BpcGVybWFpbC9jeWd3aW4tcGF0Y2hl
cy8yMDI2cTEvMDE0NTg2Lmh0bWwNCiAgaHR0cHM6Ly9jeWd3aW4uY29tL3BpcGVybWFpbC9jeWd3
aW4tcGF0Y2hlcy8yMDI2cTEvMDE0NTg3Lmh0bWwNCiAgaHR0cHM6Ly9jeWd3aW4uY29tL3BpcGVy
bWFpbC9jeWd3aW4tcGF0Y2hlcy8yMDI2cTEvMDE0NTg4Lmh0bWwNCg0KSSBhbSBzZW5kaW5nIHRo
aXMgaW4gYSBzZXBhcmF0ZSB0aHJlYWQgc2luY2UgdGhlIGNoYW5nZXMgYXJlIGNvbWJpbmVkLg0K
SSB3aWxsIHJlcGx5IHRvIHRoZSB0aHJlYWRzIGFib3ZlIHdpdGggYSBsaW5rIHRvIHRoaXMgbWVz
c2FnZS4NCg0KRm9yIHRoaXMgQUFyY2g2NCBpbXBsZW1lbnRhdGlvbiwgdGhlIHg4Nl82NCB2ZXJz
aW9ucyB3ZXJlIHVzZWQgYXMgYQ0KcmVmZXJlbmNlIGZvciBmdW5jdGlvbmFsIHBhcml0eS4gVGhl
IHJlc3VsdGluZyBwYXRjaCB3YXMgdGVzdGVkIGFuZA0KY29uZmlybWVkIHRvIHBhc3MgdGhlIGV4
aXN0aW5nIHVuaXQgdGVzdHMuDQoNCkhvd2V2ZXIsIHdoaWxlIHJldmlld2luZyB0aGUgeDg2XzY0
IGltcGxlbWVudGF0aW9uLCBJIG5vdGljZWQgc29tZQ0KZGlmZmVyZW5jZXMgaW4gaG93IHRoZSBz
dGFja2xvY2sgdmFyaWFibGUgaXMgaGFuZGxlZC4NCkluIHN0YWJpbGl6ZV9zaWdfc3RhY2ssIHNl
dGptcCwgYW5kIGxvbmdqbXAsIHRoZSBsb2NrIHZhcmlhYmxlIGlzDQpkZWNyZW1lbnRlZCwgYnV0
IGluIHNpZ2RlbGF5ZWQsIGl0IGlzIGV4cGxpY2l0bHkgc2V0IHRvIDAuDQoNCkkgd291bGQgbGlr
ZSB0byBjbGFyaWZ5IHRoZSBpbnRlbmRlZCBzZW1hbnRpY3M6DQoNCjEuIElzIHRoZXJlIGEgZnVu
Y3Rpb25hbCBkaWZmZXJlbmNlIGJldHdlZW4gZGVjcmVtZW50aW5nIHN0YWNrbG9jaw0KICAgYW5k
IHNldHRpbmcgaXQgdG8gemVybz8NCjIuIElzIHN0YWNrbG9jayBldmVyIHVzZWQgYXMgYSByZWZl
cmVuY2UgY291bnRlciAoaS5lLiwgY2FuIGl0IGJlDQogICBncmVhdGVyIHRoYW4gMSk/DQozLiBJ
IHNlZSBpdCBiZWluZyBkZWNyZW1lbnRlZCBpbiBzZXRqbXAgYW5kIGxvbmdqbXAsIGJ1dCBJIGhh
dmUNCiAgIG5vdCB5ZXQgZm91bmQgd2hlcmUgaXQgaXMgaW5jcmVtZW50ZWQgaW4gdGhhdCBjb250
ZXh0LiBDb3VsZCB5b3UNCiAgIHBsZWFzZSBwb2ludCBtZSB0byB3aGVyZSB0aGF0IG9jY3Vycz8N
Cg0KVGhhbmsgeW91LA0KSWdvciBQb2RnYWlub2kNCg0KSWdvciBQb2RnYWlub2kgKDEpOg0KICBD
eWd3aW46IHNpZ25hbDogRml4IHN0YWJpbGl6ZV9zaWdfc3RhY2svc2V0am1wL2xvbmdqbXAgb24g
QUFyY2g2NA0KDQogd2luc3VwL2N5Z3dpbi9zY3JpcHRzL2dlbmRlZiB8IDI3NyArKysrKysrKysr
KysrKysrKystLS0tLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxNDIgaW5zZXJ0aW9u
cygrKSwgMTM1IGRlbGV0aW9ucygtKQ0KDQotLSANCjIuNDMuMA0K
