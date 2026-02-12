Return-Path: <SRS0=yPnT=AQ=arm.com=Igor.Podgainoi@sourceware.org>
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	by sourceware.org (Postfix) with ESMTPS id 5696C4BA23FE
	for <cygwin-patches@cygwin.com>; Thu, 12 Feb 2026 16:59:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5696C4BA23FE
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=arm.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5696C4BA23FE
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c200::1
ARC-Seal: i=3; a=rsa-sha256; d=sourceware.org; s=key; t=1770915543; cv=pass;
	b=YxocdKBwqmXd8OUve/Iq0oagyewN6urKZ5ZKjSLGbo6ieoyBf7txLJQCwao94+/E39/EYwSD8whX8Q3kKMMVpLaUqw8ZiGEMwM3tBcddOAiYPPB7Bf1DWQYyYEvxNH5l2Oat2vOl7dBntC9We06lseNWHA7wJOlD6tvMqqYvMmk=
ARC-Message-Signature: i=3; a=rsa-sha256; d=sourceware.org; s=key;
	t=1770915543; c=relaxed/simple;
	bh=6qaJHRdM+i0HA5P7ld3otY2bPdjeXqmzCpQ0qgAnwy4=;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version; b=i2UpVmSS2KROzlTm/Oi/p9FL9TK46NG2us5xuLioQkYN8D5WUf0je2mAMh/SpRxVwXU0l9QsPLjtYzMxxGz4hNe37hGMPeKoa29bhzSkJkwkTluEEdgqaDpUko+DBQd63tmq3x1EGoY9D/TvYX965pnXnvflDBeXrtUkmKKFC2I=
ARC-Authentication-Results: i=3; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5696C4BA23FE
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=qO+G/n6d;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=qO+G/n6d
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=qRm8Gx+opwfAzo+woouoXUJhMjmuP4VBFkU2T3v3mOvL6jTvCnKRPIcZQPmgjQbfADJKqa3LmBBEavacEeR6C6WO+oJdabSe0oxQaP/MvVWTrPrgeeIcNTbssY5LoJArDV4knGI3VlYlRr6QWolITKtkQny34//GiYw85msYzwkQnqJN9bx41bIA4M8JxjoCHL0zEWXi97U1cwqRG+YpSWtNkghE4S3KS5ecEQilO7mfO8dHyq3mrGNlwrw24D58J667LaywIOSgDhF3gpjT/HjF5qBCy62v4rx471wTUlmeBZfsipDSV8IH38Pkg/ZtdXg0nv+tbzq4/YxR+IDrPw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qaJHRdM+i0HA5P7ld3otY2bPdjeXqmzCpQ0qgAnwy4=;
 b=s0653SDFvbgZ2EuHm9DsYfPCuS2XjuMKOf4k/rZnELeS9ky7Hz9wEhwaQHB5/LyrIzYs54qiTCLxk4afx4Cv4GUFAaV2/68nYTeShzj3+2kdhPNbszUzBExwQQ4oiLPBwqWgZ4r84OU7eBpBJtbIPpjF22vEkxTdDdJjSo2I3F5gS+j57xMXP9X6+/+xfyCV8gIIu+P/QSMfP5DzokcQLlVevrqiHV24DkCjeRQ71EdeGchT8VEIMFegfqPY8kWC/u0zTOZhSATL4tMC2X1ArEyhrYagwZCRDfR8X5tfqua6AXElcim7YJCjs0jZSvebmxx8ze9s3Cyub8nPO6r0vA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=cygwin.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qaJHRdM+i0HA5P7ld3otY2bPdjeXqmzCpQ0qgAnwy4=;
 b=qO+G/n6dlnKRrZgaEdqQOj3Z8e4mnOa5RfRy3B2gupr3napFUK7hAwRSyKbTsqnVU4tXz5lFKhniPmocJijSsGq7jYxjcCoAlqA3dQIR64FvsVGNH/Pjpw68OPSqtw5TPHGSZrXhnZN5D5k976PcH0QZNg36dqYStmi3N2KQj/M=
Received: from DU2PR04CA0261.eurprd04.prod.outlook.com (2603:10a6:10:28e::26)
 by DB4PR08MB8103.eurprd08.prod.outlook.com (2603:10a6:10:385::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 12 Feb
 2026 16:58:51 +0000
Received: from DB1PEPF000509FC.eurprd03.prod.outlook.com
 (2603:10a6:10:28e:cafe::b) by DU2PR04CA0261.outlook.office365.com
 (2603:10a6:10:28e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.11 via Frontend Transport; Thu,
 12 Feb 2026 16:58:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509FC.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Thu, 12 Feb 2026 16:58:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6QqUD5G6IbygVa9ifBsc2DN12d3b3U7RxWn8kOcRS/Brb7QX9QB8SArQl0KQXm663zrjkwPlIKAq/FHNvl74Ws0pFVl/mj4J1XFyg2VuMK0YsvG/V4bz1CJ4UlxjjRCLgBfdGSQDRGQuWbw+qgyaMSykhqKMDzSDdysNeFbj5zvWHgDZXUeNcVKxM549IBdhNo90/rdDtLXI2u8naSTZCt0tu4uvmO36VnLRS9DK5kRkSn/jfvrZ6x1bfpFJkmstFLnV11YFVuRv5dtXP4uvadQu22uBiqyndDL5AMyq53P6fVSq+UqBnVfh3vLcUPBBNd5PvgaG0OyIHmSa5KISg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qaJHRdM+i0HA5P7ld3otY2bPdjeXqmzCpQ0qgAnwy4=;
 b=sniy4FGuIqwejrJIYIapVxH6WndI9UTBeUtn6PK2EAC9XZ/nnBAY5kALFmalXOYeIhglg9kS9dW5BL7URvnU4ZZK3Pda7Hnl4H242UyJKhp9l7k4VsvRmPaKwOTmdE4mkhR4XCPtLs9P1SE6A/8Yqyyf6/asehWw40DXcVCx/9JEP2HrMY+nm68GTz6baiju73h3tadJyavt6sU6jaxzP7kqiJcP46Bxb3NeQ3BRiwUoPvf1GeR05HkQTBF7HvYOAOf7oQUVRDDhQciT6COEbheHUh0K3cjLUuweid9PyBNOimXqrQKOhMFHSi8kgrlqs4Nw7BIqKFcCs7b7kIUtJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qaJHRdM+i0HA5P7ld3otY2bPdjeXqmzCpQ0qgAnwy4=;
 b=qO+G/n6dlnKRrZgaEdqQOj3Z8e4mnOa5RfRy3B2gupr3napFUK7hAwRSyKbTsqnVU4tXz5lFKhniPmocJijSsGq7jYxjcCoAlqA3dQIR64FvsVGNH/Pjpw68OPSqtw5TPHGSZrXhnZN5D5k976PcH0QZNg36dqYStmi3N2KQj/M=
Received: from PAXPR08MB7247.eurprd08.prod.outlook.com (2603:10a6:102:212::7)
 by DU2PR08MB10280.eurprd08.prod.outlook.com (2603:10a6:10:491::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Thu, 12 Feb
 2026 16:57:48 +0000
Received: from PAXPR08MB7247.eurprd08.prod.outlook.com
 ([fe80::e2f7:f38e:3321:44fe]) by PAXPR08MB7247.eurprd08.prod.outlook.com
 ([fe80::e2f7:f38e:3321:44fe%5]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 16:57:48 +0000
From: Igor Podgainoi <Igor.Podgainoi@arm.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: nd <nd@arm.com>
Subject: [PATCH] Cygwin: hookapi.cc: Fix some handles not being inherited when
 spawning
Thread-Topic: [PATCH] Cygwin: hookapi.cc: Fix some handles not being inherited
 when spawning
Thread-Index: AQHcnEC3G/TVpsYU0kO2leeVcLb1PA==
Date: Thu, 12 Feb 2026 16:57:48 +0000
Message-ID: <aY4Gibum9Q1gj9lp@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	PAXPR08MB7247:EE_|DU2PR08MB10280:EE_|DB1PEPF000509FC:EE_|DB4PR08MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: 865d6eb1-d22d-4d13-4396-08de6a57ffb4
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?dTh0blpBY2NKWXFIUFBZdUNZYWtGZW03UGwvN1oyMDUvTkZiaEI2TXFwK0JL?=
 =?utf-8?B?Q0hTQURFd24xcyt1TDhWM1BIZmJLSXlFcEpvT3Nreis4Q053L3JwV2E3dWRM?=
 =?utf-8?B?VVJnOExpQ0F1aUkwd0Y4SS9TUk5acE1sOU5RQWdoK0lTVm9mWkZHU1ZndHN6?=
 =?utf-8?B?Tjl5bGJvUWN3d2pOVkhuOEVycENWNElUSVVKcVc5NlNJSUlDK25MWXN0a3Zr?=
 =?utf-8?B?U0FhYmx4L2dxQks1bEtJZDNHaW8wb2ZuVzNPYkN4R3htcjdSWDE2MUQ5bm5K?=
 =?utf-8?B?Y3RQY2h4UndzcUh1d2JjRVY3aHNaNWF2RC9QQzZ4eUVLc28yMzBRUW12N0Rq?=
 =?utf-8?B?TTkwWGRLanAxdDliTnlxdk5HdjU0d1Q0Sjg2aCs4b1I2dEkrRFc2UVdKYzNZ?=
 =?utf-8?B?N1B3d212aEZzL1p5ZlA1bUVZL2xYWHV5eFlJeHJHcDM2dVo1QWx4U1hWSnlU?=
 =?utf-8?B?MzJtWG5NbG1qaWtFL0lUMHovZms4RG5JN1ZUeVEzQUR6VXdvTVpYY2VieGhE?=
 =?utf-8?B?YklGYTBVTHBnaHFFQWRrK1l1akFpd09GS2FYOFVQM3MwZTNlUkRYdTJPQW9v?=
 =?utf-8?B?ZklVYmVMT0lzbmFhSnZpOXFMdXY4NXkvZHhSWnVqUk1pUzJvQTQrNE5UbU0v?=
 =?utf-8?B?RHdFSi9LaFJJYmdDZkRRelozTEFEM2xYVWxSYURwMjZieFQyeEJ2WFlSa1lz?=
 =?utf-8?B?VzNWVHYzRHpBV2U4ZmxsVGU4T0VPWmhBVCs2djRsK1kwUmJCV1F2TFRSNy9p?=
 =?utf-8?B?dDRmY01NTUxLUmRxZ3hYUnU0S2RrZWVnK3pVajhDWFY0WWFGZEhqUi9NMXBC?=
 =?utf-8?B?R1BONWVhWTh4UGYzK1ljLytzb1ZDRStpcDlNZlUrVEYwdytDZEhnTHh1TzVF?=
 =?utf-8?B?Q1I5eEVab0pFQjRZSFFQMWV2b3d5TjhLTW5MdnFQTlV1U09QbzhMcUNmck5h?=
 =?utf-8?B?bEczMk93eTNDU3FhZDlDcW53V2VxMUNnd015My9xY1d5SWpGVVVXY0JzcHhF?=
 =?utf-8?B?OE1kOUgvajg5MWN3a1FZR0t5WE9JZEpJcERkOTlNZGhZVE15S1pXejhBUVlr?=
 =?utf-8?B?SmUwMjRnUGlxdmcvM24yclgwaE04WXFHSWZPNTdQWjJWT3M4cTJrOS9FOUZs?=
 =?utf-8?B?U1lLTVJETlAwVzdMOHFXc3padjU3d1cvbW9JeTA5cGxPdDV6Mnk0N0wyZ2RY?=
 =?utf-8?B?dkY4UFlyNXIvQmFmcFZQbmQrRUwvWC8vNEZuMUpNMys4U0didk9YOWIvYW93?=
 =?utf-8?B?STFjUHNBTWlONW9iSGpmQU1sOTIwZ09kUkNCbDBJbGxXWU51QTdIY09yK2kx?=
 =?utf-8?B?Y25BLzkwM0VxVkxMb09ONEdpRDZZUTk1dkdwVmI0S2ZKSDIxYmZ6TnNrVE44?=
 =?utf-8?B?MVgrUDBaV2c2WlZOaXB2cW43WUptejF6V3JoWGNaSWgyYUZVQnlTWjNzVlUr?=
 =?utf-8?B?NHZnY0ZSQmo2c2YxOTh5blNvMEc4MkJRTHh0amtJb0NSSUoyNUZ6dFU1V3dh?=
 =?utf-8?B?aEhFaUZhZEo1eXpXN3RSZG85NlpRelpyVG50NzVwZnZZTk1KdC9xRW1CVDRH?=
 =?utf-8?B?ZFRpTnROUFFXMlZYZ2FQNEJkbEduRFNMcDRsczluWnpRU0FuUG10emVhSmxQ?=
 =?utf-8?B?RlR5YUlPUmtHWVpSNHR5NWdEZTFMaUN1NFFXZ0VVc0lzM1lNaG5FM1Y5bk5L?=
 =?utf-8?B?eVdkNTZhdU53MndMdlBDSHgzYTdFbHJxZVRnV3ZWSWlJL0lvc2oyUys3Y0lB?=
 =?utf-8?B?UWJwNUhJcnhiQXpTNVptdFhPZ2RsME5HcURZakNsbHRhMU54eUFpOUcxZTNK?=
 =?utf-8?B?VzhId3gwTWkrRjBOQmhINlc1SHdRWDBDSUx0Zlkyb0RBMVBMK05LTnIrWnVB?=
 =?utf-8?B?T0xPZnhyQ0tzekFOMHd4T01yNkxua0xKZW1tMHRHa1VqUzJPbjVDbXRhakFG?=
 =?utf-8?B?NjVUcUhwWTJFSWxOK2ZRRVRreFQ2a0dwc2ljOGpFWWxhTG5TVTB0dGx6SDdk?=
 =?utf-8?B?R3NrTDZWbjNLZTIxaGh3djh0emdjTG9lVlh4dlZidkkxQng4YmlSaEVhaXEv?=
 =?utf-8?B?SlVVOVkrdVVxRFFJODBGOUhlWU92SnFGVmd0Ukh5UjdjaGIvdUcwdW9Dc2VL?=
 =?utf-8?Q?BqLpcvJguQI1LZ54wDx+sYRKm?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB7247.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <69C740AB1D2E204AA09A3ADD24C66383@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10280
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509FC.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8e278933-1996-449a-1ae1-08de6a57d9d1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|35042699022|82310400026|36860700013|14060799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTRoVmh3WXVVWDdXVjR3eDQvNHl6a2ZUVVBENytBbXdCZVJPeG12eTBtajFC?=
 =?utf-8?B?NXh0L1hHOUludERZb1BOVzRraElzZkpCT3FOSGNpWmQ2bmJJSzhDa0JqZWtH?=
 =?utf-8?B?b0FYN2dqWEZqeTlBNCtrM2ZIcHRIY3pWVi9ROGVQSXdSZlFaL2ptQzVqeUhq?=
 =?utf-8?B?VDNDbEpXWm4raGhiWnFDcmd3R2had3NycktkemhFdG1aM3hLbmRIdHBmZWZV?=
 =?utf-8?B?RTBiOFZNKytVMTM5emRpUXFSSXRIdEY4UHNnTElKRFFyYlZ3VUQvelEwOGVn?=
 =?utf-8?B?aTV0dVpuMTU0K01odnRQQkt0a3Y4Sy95ZmJIS2ZFR2dIRWVYT1lTQWxPR2hQ?=
 =?utf-8?B?WHo4WHlDbFBqUjlzeVZNVVhkQWw2UHpGYTNOR2VWeFNrM3cvVDhoUEFxRVpm?=
 =?utf-8?B?a01WWXNJL2xYa3NETWFNK1NGUHdiM25zQUdxVnF5Y1FQUU5OdS9wNHIyMHlY?=
 =?utf-8?B?U3UxRmRHMkc4M3p0RW42a1hVd2crMkRzcnhudnlaRmNZdTQzVlZRVnhlb2wr?=
 =?utf-8?B?Sm9La0J0eVNqdnozcTZHRC8vVlpJUnZLaEIwVUV4c3N4amFZaHdyUlNmbUhG?=
 =?utf-8?B?OHRaQndjZElsRk85TTZtVFhoeDBBV0pwaHhvUXA5R2taU1U0OTFtZm1UNVI1?=
 =?utf-8?B?WDUvWXhkMzNNdmVRcTF2TGFnK0lOdEhlQU9ZYWwxVElhWVNBeDMxZHpDUHpV?=
 =?utf-8?B?MFJPQ1FGTDkrSXhmVXlnRXFuVnJnWUtPR0RCK2JOZFBRanAyZm9hMmpSa2F5?=
 =?utf-8?B?ajhqN21lWVI0OENIajJaNitPZXRiRURzM1E5cGM2VkVRZFFyNDllMlo3Um4y?=
 =?utf-8?B?TU5mWnZDQWdSd3JEelNvbEp4RmlNMitQOWVwaDZvd3RwalB2bDI0VkpXeUFB?=
 =?utf-8?B?ck9zVFJpVVU1WkdFc01Tc1F6Nm9PQTJSdGF1NDAvaFBIMFgwMi9wcFowclN5?=
 =?utf-8?B?cngyQ0RsVWlkR1J2Yys2ejlYb0RFQzlkWEtLSXowQ0N1Umt5YjBRS1N2UFdT?=
 =?utf-8?B?all6UlVuYU9oOW8zcVJlcmJSVTNSUU5teDZWYlZ1djFRVEt0WHBxeE83SjJz?=
 =?utf-8?B?WnU3ejUrdjlnTndVdjFWdnlrZzZJK1ZTQUNCYkwvTE0xSmVnUXY4Vy9JVDVh?=
 =?utf-8?B?L3c5UGRjM3hxdGhhSDZUcDNvaUNYaktpK0pxNW5reVQxa201Vkc2cmxoRTgw?=
 =?utf-8?B?YXlHR01hOFIzNDNZL3NSOGd6WVBHSWVjUDM3bTFEbVUzSUpEZklEWlhKc01R?=
 =?utf-8?B?VEc3YXVReFJ1aGFSSWdlMjR3UDIyaTR4Nm15OFV4eENBN0VUdHpHTXNHUXcy?=
 =?utf-8?B?Z25uTFBxTm12eGxwMGhLRzlmdkZSZVhDWjRXVExTYWxSdzlWSFFXdnhjVTZW?=
 =?utf-8?B?TU1xYURaT0JqS1YvcXNWcFpIVndHOFcrS2xKL2VGOWFoS3ZOdzR6NHBLency?=
 =?utf-8?B?R05raVEvQndGN29PdUV0NU4zbjFGWkoyY0VBa2JsWFpmdkZQYWlhdWpweHhz?=
 =?utf-8?B?WUcrSTFHb2ZLc0g0NWR0S1BPZWdFa2F1eTNxYVNyNUwxZ055ZGVGTFFvUlUz?=
 =?utf-8?B?VnJ6dURFYW1ZUzZjaXp5dFZsUzVpSmFUWXhaUFUxekw4YktlcmlIeTE4bmpt?=
 =?utf-8?B?Rnl6OVUyUXgxcy9rL1ozMGlnNllYZ2lYNFpIam5iamwxd3ppK0dIekVQa3VU?=
 =?utf-8?B?K3pVdDNHSzZlT2NOVjVsMXhHZ0FOT2QyKzRnemJRazdheG9ibUlNbXRKSVVq?=
 =?utf-8?B?ZGlScjAvNS83bERHdUVMeEs1UjVrOUJPKzhGOTVlOUw1elJPM2krd1JOZGtu?=
 =?utf-8?B?VTN2Y3Q5SzJ3d3FJeXlJRTcyNm9wRG9kRVlLdFRFLzZTZEc2MDR1R05VV3VQ?=
 =?utf-8?B?bjJFc0pDTm5oK3cyckpKMjJ5Y252L3NUbitPR0FmdUd0VG1SVktVd2wzWTEw?=
 =?utf-8?B?cTRvU29kaThkbW9DQWFuMVh5MUNVclpqbVI4WlJXMFBOVVdlVXZyM0wrVXRz?=
 =?utf-8?B?Ylc4T3N0eWMyUGFzWlVPelJEaUw3QloxYi82U0J5VWZDZHFvYjhJVmFHTklD?=
 =?utf-8?B?K1AwcVFOVVZ4ZWt3cnlydDBpcXdIL3J5RzlhWTRiMXJqLzQyZTV3UWxEaVZJ?=
 =?utf-8?B?VGFPb0V0My83d1c1TklqRjBqR1QwYWpwVzVJRENJYS9qN3hVSzJsc1V0bUZB?=
 =?utf-8?Q?wilf0HK56WchkmVX7Pk86yg=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(35042699022)(82310400026)(36860700013)(14060799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VeHwasyL1FIZ7Y5t3ZxhL/lOdejNTPLnqa6KWtIWMbdC73OhslC88CYMxOvWkQmL71uwCUQjE3ZL/Xw/NTT2gsEt1i9K2HpJ6sduV//3ugqEBgWCaf+9rJSz9bxxgtbln5FwZVH2bL7RRiNlKMl7bmZ6d2gm+/mU/CDy3yqmCLONH37w+K4DnA1RxCxuSHL3XzU4XUUAlhpnvA9OMLWI2zp6DJKFiSRmWZ2ryGi6qQFp63CIxaJ9XbYv2Y3oVerUJ1TCNDHbPkQwka10F01UQ7imE0wAUYb4+5ZELDsOMZ5N6oEx3JxkRwlfODNDSX+7Sgbiz7Rokwz6uNL0ircb/0RlwhumoNWAb3PvK48iZz2h1oNUyovRdMJTmn2hwyjpTMSzEsrZpb+h5eSpn+q/7W2rMCUVnNMWsnoGaig1Gh+v51soAThT5gmxD3ubRuJM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 16:58:51.7551
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 865d6eb1-d22d-4d13-4396-08de6a57ffb4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8103
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

VW5kZXIgV2luZG93cyBvbiBBcm0gKEFBcmNoNjQpLCB0aGUgZnVuY3Rpb24gaG9va19vcl9kZXRl
Y3RfY3lnd2luIHdpbGwNCnJldHVybiBOVUxMIGVhcmx5LCB3aGljaCB3aWxsIGNhdXNlIHRoZSBj
YWxsIHRvIHJlYWxfcGF0aC5zZXRfY3lnZXhlYw0KaW4gYXY6OnNldHVwIHRvIGFjY2VwdCBmYWxz
ZSBhcyBhIHBhcmFtZXRlciBpbnN0ZWFkIG9mIHRydWUuDQoNCkFmdGVyd2FyZHMsIGluIGNoaWxk
X2luZm9fc3Bhd246OndvcmtlciB0aGUgY2FsbCB0bw0KY2hpbGRfaW5mb19zcGF3bjo6c2V0IHdv
dWxkIGV2ZW50dWFsbHkgcGFzcyB0aGF0IGZhbHNlIHJlc3VsdCBvZg0KcmVhbF9wYXRoLmlzY3ln
ZXhlYygpIHRvIHRoZSBjaGlsZF9pbmZvIGNvbnN0cnVjdG9yIGFzIHRoZSBib29sZWFuDQp2YXJp
YWJsZSBuZWVkX3N1YnByb2NfcmVhZHksIHdoZXJlIHRoZSBmbGFnIF9DSV9JU0NZR1dJTiB3aWxs
IGJlDQplcnJvbmVvdXNseSBub3Qgc2V0Lg0KDQpMYXRlciBpbiBjaGlsZF9pbmZvX3NwYXduOjp3
b3JrZXIgdGhlIGZhaWxlZCBpc2N5Z3dpbigpIGZsYWcgY2hlY2sgd2lsbA0KY2F1c2UgdGhlICJw
YXJlbnQiIHByb2Nlc3MgaGFuZGxlIHRvIGJlY29tZSBub24taW5oZXJpdGFibGUuIFRoaXMgcGF0
Y2gNCmZpeGVzIHRoZSBub24taW5oZXJpdGFiaWxpdHkgaXNzdWUgYnkgaW50cm9kdWNpbmcgYSBu
ZXcgY2hlY2sgZm9yIHRoZQ0KSU1BR0VfRklMRV9NQUNISU5FX0FSTTY0IGNvbnN0YW50IGluIHRo
ZSBmdW5jdGlvbiBQRUhlYWRlckZyb21ITW9kdWxlLg0KDQpUZXN0cyBmaXhlZCBvbiBBQXJjaDY0
Og0Kd2luc3VwLmFwaS9zaWduYWwtaW50by13aW4zMi1hcGkuZXhlDQp3aW5zdXAuYXBpL2x0cC9m
Y250bDA3LmV4ZQ0Kd2luc3VwLmFwaS9sdHAvZmNudGwwN0IuZXhlDQp3aW5zdXAuYXBpL3Bvc2l4
X3NwYXduL2NoZGlyLmV4ZQ0Kd2luc3VwLmFwaS9wb3NpeF9zcGF3bi9mZHMuZXhlDQp3aW5zdXAu
YXBpL3Bvc2l4X3NwYXduL3NpZ25hbHMuZXhlDQoNClNpZ25lZC1vZmYtYnk6IElnb3IgUG9kZ2Fp
bm9pIDxpZ29yLnBvZGdhaW5vaUBhcm0uY29tPg0KLS0tDQogd2luc3VwL2N5Z3dpbi9ob29rYXBp
LmNjIHwgMiArKw0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdp
dCBhL3dpbnN1cC9jeWd3aW4vaG9va2FwaS5jYyBiL3dpbnN1cC9jeWd3aW4vaG9va2FwaS5jYw0K
aW5kZXggZWUyZWRiYWZlLi5iMDEyNmFjMDQgMTAwNjQ0DQotLS0gYS93aW5zdXAvY3lnd2luL2hv
b2thcGkuY2MNCisrKyBiL3dpbnN1cC9jeWd3aW4vaG9va2FwaS5jYw0KQEAgLTQ1LDYgKzQ1LDgg
QEAgUEVIZWFkZXJGcm9tSE1vZHVsZSAoSE1PRFVMRSBoTW9kdWxlKQ0KICAgICB7DQogICAgIGNh
c2UgSU1BR0VfRklMRV9NQUNISU5FX0FNRDY0Og0KICAgICAgIGJyZWFrOw0KKyAgICBjYXNlIElN
QUdFX0ZJTEVfTUFDSElORV9BUk02NDoNCisgICAgICBicmVhazsNCiAgICAgZGVmYXVsdDoNCiAg
ICAgICByZXR1cm4gTlVMTDsNCiAgICAgfQ0KLS0gDQoyLjQzLjANCg==
