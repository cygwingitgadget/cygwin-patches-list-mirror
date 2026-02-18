Return-Path: <SRS0=jALY=AW=arm.com=Igor.Podgainoi@sourceware.org>
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	by sourceware.org (Postfix) with ESMTPS id 8C7D64BA2E1B
	for <cygwin-patches@cygwin.com>; Wed, 18 Feb 2026 11:35:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8C7D64BA2E1B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=arm.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8C7D64BA2E1B
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c200::3
ARC-Seal: i=3; a=rsa-sha256; d=sourceware.org; s=key; t=1771414500; cv=pass;
	b=XwmuYeEt9r5bJh8wuBuufyGCdzDgO50gPEDWGkBUHLp+pqYNc3870k+aTC23F4egjsajFYnXyfA0Qs9ykgN8ZjNfttFn/b7b+5Zq2iOOLgV5zncJeQx2LNCku5ew2CEgfw3YdDh7M7TY2hElCvmomLbegoZk64b6gaIY3aoXQmw=
ARC-Message-Signature: i=3; a=rsa-sha256; d=sourceware.org; s=key;
	t=1771414500; c=relaxed/simple;
	bh=vEWuG24JKl+1hDE06bkyj3gTLGGIRyaD3SZAAIInids=;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version; b=RGxaINZLpWilWVov9fmc0rH3m0Bfs2zjIaC1KE6S5ZT3NQgHG1LAr1o8EY5IIw1JeyZk0+Or6E3MRJBjyqxDTgffvDaT40O9oQKl0ROgPJaPc3kQQCK4CTNaEH+0r9p/Ml1zXKQK64lrYNnElDyfc8dAqDPTQQDjCj22djazJBk=
ARC-Authentication-Results: i=3; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8C7D64BA2E1B
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=XhwFo9SW;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=XhwFo9SW
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=exKKGdlxJaTuTpc9FROIaD1AF7rwQFeYtohPsHfz0LpE0bs0p391g+2BGRuopaKxS34MRcHrXeXcaJnUCR8hqFBmsAgfrdWMTpj7GgmmVdXZFlLiLDHbllqbUIiBJu8hrULXKrTV43NZuzUMAeN+jxsF0WGnmqGkDOn6OIYdsmtnHlUPLUb8ptkI3ng4IljAVxMepBC5Z08IKeiVWZCmdNYIAJleq2vdDAdtNK8anq7ndok67topTp/KrcTsYlSz+h0rNGbkKUe/ATw2rvORrBaCtGDsjP2hphZ5hPOkpgZWp6VSvEsf1IeUfw6j8SGKHnunJAWqAAE5q1XjtwO5yQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEWuG24JKl+1hDE06bkyj3gTLGGIRyaD3SZAAIInids=;
 b=VkFas1/1y1UopKIM9NOjzogGx3HZCRTKk7HwB4PJGXgNGoWqg+voGdscajMqxu6XladUIUlAoYeXNkKd76VEqRoX9F2dnb9VDPlitIHi46kvjD/Dt/ZhZdLRfF2OWTlmHbmgqPy1vQhQrwkXVgoIzH4Yd1J4XD6YkK2Qc3T3tV3/Lg92bB4rn0UwncS3a5XdKNYp+x3X6OyUTty1gOc6/axP2JcrQTbSKl9aa1dLcCischaHq/uayBVwHckSkksXGr/PlvE/u+lS6jDd9Zb1IUU+s2UIuRHMrcSlbVwZEt0fnUoE+JY8UL+3RQsp34QFEs+g2QVxa1ke6LWp3tUJDA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=cygwin.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEWuG24JKl+1hDE06bkyj3gTLGGIRyaD3SZAAIInids=;
 b=XhwFo9SWe0F+NhhJZyDnU2o8YDn3vb4U8EGCy3+PoEyhxdmESaQhRh8ZhHwXjpCOljD0Rc3pvsoarZIjcdbwWzTSzNarTS1WghbK9MxDkP3XveiX0YDfumdCZjhQ7nakAo0iSG/v3L4geg4EC1E/aA/pGmh3MAZTB/pP75dS23A=
Received: from CWLP123CA0187.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19c::6)
 by AS8PR08MB8109.eurprd08.prod.outlook.com (2603:10a6:20b:54b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 11:34:53 +0000
Received: from AMS1EPF00000046.eurprd04.prod.outlook.com
 (2603:10a6:400:19c:cafe::24) by CWLP123CA0187.outlook.office365.com
 (2603:10a6:400:19c::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.14 via Frontend Transport; Wed,
 18 Feb 2026 11:34:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000046.mail.protection.outlook.com (10.167.16.43) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Wed, 18 Feb 2026 11:34:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M1QCEb8HMfkmwvCAc1Zj8mx9VqH7ed3+IhKrSWWQwkBUuwTHUV4uEsUiveIc0tgNMQN97TioC7j1PqBUqasgGTABITCV5OgN/AI20Gq84ZX5OoU538ZTCVD5VdBnz9RNzQ4oHh5fKrn7pdRQiYwF88WY+hZ01zFvkolPj3aWBBgDoh9RD3WoUOIJJkiM3kBtcn4nIqUy5cKWz9VGnnqRjRXQSrKaC7EsY+7/+WjtG6BPC1COdyCH6PlF3PM33G0I+72IRpWYK+I9Q/6a8eazCID0BPqF66GNAMs1zwn9JLcopattvN4OLiNaq9X2FOt78yfYBNlss6vdHDQihlUJgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEWuG24JKl+1hDE06bkyj3gTLGGIRyaD3SZAAIInids=;
 b=vxWjkIl2kZhTZx8KXsXqkm4qWG63leMWMnqc+sS+jgRPhZwQuFum5/5sdThWXkSx6Qjyw9940I4gd8wymqsmo8L9GfiLvJvydcdvbU0Nhr5rB5yndt7SMrgMxqWlbS6JvwDCVOmHb/pu8K8n4C1Jr6ocoWl5hvoP0DfMpQ/dAKFYTUtAGhOCmAdWBc8XHQWzugVFkzDP+tFhlJkVwxIWIjr1LF2Np+AcmPBhy82o6qvMYIFQtu46KvDonhyH+7z6mgufGeq82zdv3skqvx9d9NJmMC17XAu53ReqWdpvBnuE+mbOz6f7VuRENmvfp7AFNjzJb5+dSgBWLNJFctnwnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEWuG24JKl+1hDE06bkyj3gTLGGIRyaD3SZAAIInids=;
 b=XhwFo9SWe0F+NhhJZyDnU2o8YDn3vb4U8EGCy3+PoEyhxdmESaQhRh8ZhHwXjpCOljD0Rc3pvsoarZIjcdbwWzTSzNarTS1WghbK9MxDkP3XveiX0YDfumdCZjhQ7nakAo0iSG/v3L4geg4EC1E/aA/pGmh3MAZTB/pP75dS23A=
Received: from PAXPR08MB7247.eurprd08.prod.outlook.com (2603:10a6:102:212::7)
 by PAWPR08MB9831.eurprd08.prod.outlook.com (2603:10a6:102:2ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Wed, 18 Feb
 2026 11:33:49 +0000
Received: from PAXPR08MB7247.eurprd08.prod.outlook.com
 ([fe80::e2f7:f38e:3321:44fe]) by PAXPR08MB7247.eurprd08.prod.outlook.com
 ([fe80::e2f7:f38e:3321:44fe%5]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 11:33:49 +0000
From: Igor Podgainoi <Igor.Podgainoi@arm.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: nd <nd@arm.com>
Subject: [PATCH 1/1] Cygwin: SEH: Fix crash and handle second unwind phase on
 AArch64
Thread-Topic: [PATCH 1/1] Cygwin: SEH: Fix crash and handle second unwind
 phase on AArch64
Thread-Index: AQHcoMpzhjMSDB9fMEqUe1lQK3oy1g==
Date: Wed, 18 Feb 2026 11:33:49 +0000
Message-ID:
 <c4f8c7507e38602ef2935a8dbafe7409a63377ad.1771414249.git.igor.podgainoi@arm.com>
References: <cover.1771414249.git.igor.podgainoi@arm.com>
In-Reply-To: <cover.1771414249.git.igor.podgainoi@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	PAXPR08MB7247:EE_|PAWPR08MB9831:EE_|AMS1EPF00000046:EE_|AS8PR08MB8109:EE_
X-MS-Office365-Filtering-Correlation-Id: 79fcbd6d-bf4d-46b2-20d3-08de6ee1bbc0
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?U2ZzQUJWVzBGRFlSMmNSSWFuYVNRem1tcXA1YmphN092RE9NeUduZ0dGN2NY?=
 =?utf-8?B?NndSNnJWQVhYNTN5VDVtMXdmUXpjdVYySmNYdnFRRC9YaTFFY3llemwzQmhk?=
 =?utf-8?B?MkN0a0RwVW93blNMNEM2azNLZnpPWkFCc2tEK1diN29qMXAvM09pYWJRYURQ?=
 =?utf-8?B?aEVJdGhzOXNzNWo0SGo1ejFOL1Bacm9tNFlLdGtlUnQzUkdVZ1F5a3Ezb2NW?=
 =?utf-8?B?a0d6aWdFUHhBK2dMT2VTbTFubzQ4NFlTUjdUUHArbURNeHkvVG5lV3ZGR1B2?=
 =?utf-8?B?c2l5eENVbUd5QUJuTUNyV0lOY3BVMjNSVkhBSXhWcUhha285aC9vMEkwbjFH?=
 =?utf-8?B?UFZvVG8veGlTcHZ1NXAwcyswU25sQ2lSMmZuVXlGdEhuRjljZGFwRTdEQ09M?=
 =?utf-8?B?aXFQQk5ScG9BMWNLMkx0Qk9ZKzFaM2ZnYXNZamhUN1FUMjJEbFlKNDVCc0Zu?=
 =?utf-8?B?QTJVdlNKYkNWeUUrK0VocHQxcVZLRG15MlJOb29QZklzUUpmS0NHRUdIUU5v?=
 =?utf-8?B?WmxlL1Y2ZE9DL28waUJ5eE4zdk1TRFBNbUtlZWZzYmhiaEtHN0dMTk1vQmdn?=
 =?utf-8?B?WXR4NzBIbWxiMGI0V0g3dlhtUndqajNZZ21XNDlTTHJmYU5qR0Y4WUlxZGhB?=
 =?utf-8?B?TG5GSnRJNTJNL3FPRkxEOUFwbW9TN1J1c2NQQnpJcjM0SzNRT0R4QzF4RFFw?=
 =?utf-8?B?a2dmZzhBNWROYTVaSHRBQUYrN3FnTkg5eUZwU1BkTEtUVXpSMENyYkM2eVFO?=
 =?utf-8?B?bVg2cFZLbzROZkd5TUhZQzNBK2V0OG9wckdibFpQWDBYamoyTm5vdWFkakF0?=
 =?utf-8?B?MkUvVlEvSEs0V085cmw0STdqaWo0NU1SeWZFK015UkJKVEg3TFV2bGdoNDFr?=
 =?utf-8?B?WTNoaGtTdXV1ODJXRjdRUmFsS0RpZjV0a1gvY2krNkR1RldIbWRFWW9PbU41?=
 =?utf-8?B?N1p4S0g3aUg1NndJcEdOcURoNUVhS2xQYndqZXZKOUcyc0ZUM1FzQnJnSU8r?=
 =?utf-8?B?RUx0SVc0R2xBb1F0cFNsek94Q3VUNFIzTnlOYVYxK0tvZk9KUG5JMmN4UFE5?=
 =?utf-8?B?aGZZei9Jb2piU0duaElUdFJHSzhGUHpOTmVFR0VCZlhyWWVJZjhPc2dkaUZ4?=
 =?utf-8?B?Sm1SU2tVRzJWUVdPd1hhTzl1WjlWeDNlZ1gydGQxL0JNZXhrUjM3d3VwcHZZ?=
 =?utf-8?B?V2xNcVlYWUxvdlh5d3lXVEh4djJHNHFHTXFmMXh4cHJUOHFNR3lhdEhWM3Fa?=
 =?utf-8?B?QnNUbkg0NkR6L1lIdjdXdWFTQ1M2REIvOGdheG5oV1lLTnZvTU94ZVVZS051?=
 =?utf-8?B?UHM4aDZHS1dhd0wyeEt1YVVBZ0dQRnZORlQ0RGFXcUZMcnFJRnZ6blVuOElO?=
 =?utf-8?B?bjFjVW9IUHNJWU9BNTA0Tm8vUXljeHNzV0ZnQTB0Mlc1NUljTEllaXdBdGlM?=
 =?utf-8?B?LzdvMG1WUVBodjR5M0M4R0w5ZTUrM0Y3YVdRL3VZTnI4RWdFdnNtT0JnOFZy?=
 =?utf-8?B?VFNnRHV3a0tHQnFwL1I5WklGN0t4K2dEQTNLS3loV0tlUTkxUHVzSUo1Z21T?=
 =?utf-8?B?L043bVNGZ0NwN2RsTm1iUFdsYWFOdDI0NWhBaHhJNFRTMThPMGppcmQxSU5k?=
 =?utf-8?B?elZhU3pqNXd3R082NDVIbEJyNk9VNUsxUitNdUl1L3BUYmVabjBXWldBYnY0?=
 =?utf-8?B?dGJWWS81M0ZxUEttVHNFZE1qcEpIRi94UUxVS205cXV6NjcwSEZGbUdJODNE?=
 =?utf-8?B?bXNpRkZPZGtqdXpiMlkzS0VmNE5keU1Qbld5Nm1kWHpYM2ZhUVJxQmlLZEtL?=
 =?utf-8?B?SlRJa2hBRXIzSlBjOEFTZmpjajhBME45THAzMG90WjhUOVQ1b25sY21Sdkx3?=
 =?utf-8?B?dUkvQkFZN3hVdmR0TThYVkx4WjBWTWM2V3dVZUdFSjIyY2J2eDdqREU1UXBB?=
 =?utf-8?B?cC96eVl1NWpZTHBYNHpjTWNFVGFkU1paUll1cHhsU0p4TDRuTXo5a0pwZnFm?=
 =?utf-8?B?UGNQcWRNQnpwbGRFV1lQcVVlSk1NRGlweExGb2wwL1BLaUdjVU1XZzYxMWZk?=
 =?utf-8?B?SmRKZjNUVmNmMkZjRHNLV0N0ZWhiTExkYXBJMmlQVkM1ZlJhWk1Xa3BYVXds?=
 =?utf-8?Q?+ptDI5Rlt0Zxm0wekxqlhbXmW?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB7247.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <37F26E1FDD10814DB13AA3222826CD2C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9831
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000046.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	522ed8d3-d5d4-44f8-9b84-08de6ee19611
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|14060799003|36860700013|35042699022|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEVLckVJUklCaVphenU3cUVIWTR4ZzBJWThmd1o2dUhvay93K29rMjgzRThD?=
 =?utf-8?B?ejhEVWNpVjVDM0FuU1ZoN0NmT1Eyd0VLUWZaUFF0Y0doTXdvODUzY3lJL2ND?=
 =?utf-8?B?OVV3cGlmTjRJdmxnemJaVTJkcVUrOU1SamlOTFQraWs4bDNkYlFSOWxKWjdT?=
 =?utf-8?B?YU11SUF4dmJINHpkUDNxdmJNNmVhZWNPN2tIcUp5cG5YSEpENVFOdlJtUXl5?=
 =?utf-8?B?UHdEWkNzYTZlSTJrOVczZkh1S0EvejE4U2hkT1V6RnNCNDVpSzhwMVlyTkpj?=
 =?utf-8?B?ajVWb3NuckZTSFE3a1dCWFJuVzVNZnY3a21mKzQzazFOdzMyTWlXdVdQdkxG?=
 =?utf-8?B?cnFPdFhnUkp3WWlPcmIzdGVCdWFHSnF4U09RQ2Fvd3E1M1FaTXRodDNYN2x2?=
 =?utf-8?B?WWppUlYzSG56c25iNEVadmpaVDQvbzVzaHc2ZS9aWGhYNGVBQmxHcjFmbGdp?=
 =?utf-8?B?REZnTEVtWk9qVVliZnNuaGhQeDFOR211bURwbi91Qlp4NDNlWkg1bC91aktK?=
 =?utf-8?B?dGFsOVdqbVpUaHpEcXkyVkhuYWRMS2VCSDQxbUIvVXlkRi9LR05veW05dXpi?=
 =?utf-8?B?QmFRWkdHaHRoUy9za29ydFdSOXVwWjdtb1BpUG1nWU8rakFPUlRMT0laamZ2?=
 =?utf-8?B?eEhHVUt5cWVrMnpmTk1aTXNVTDdoelI0NDJPY016UFVSK09FS1VHbzRIMGpo?=
 =?utf-8?B?Y1lHTUZRQTJuaExnOXJ6eS9lWXVQZUtjQXFKby9uY1NBa015ZmVNSXhHWldJ?=
 =?utf-8?B?NVl2d20yR0M4anRjUzlXaExTRzhjTytjSkpQaWdZVDVIK1BqT3A1V2tvbUhR?=
 =?utf-8?B?TXRYQy8xV2JvbUZkb2NPRWJrTFViN013bHkyTHNqR2pjekRBKzE3NGd6MDhF?=
 =?utf-8?B?TWpRT2g5MWZ4RkRNNTVPcmhHUm9aZmFsNzVGcHNTRENCaW1ILzVyZWxkdUVp?=
 =?utf-8?B?R2t2QktKaFBna0l2ZkF5WFhMWU1MRU9XQlg2S0xXOE1reDNqN3VpOURqek56?=
 =?utf-8?B?T2wwOWtKOEhtYi9JUHpVQ1dBNHNSSnducjdSemUvYU4xcnNLdldXVmM4NDQv?=
 =?utf-8?B?SkNyajFYUnRTL0ZSRGxEdHo5c2h0OE9mMnRIYzl0L1VocS9MdWwyNW1mSVpD?=
 =?utf-8?B?SjRVblR4OFBKaldTNmdUNVJLd2VpQ3NvK2gxRmxxV1NBQlBQenNCbm9KV1lh?=
 =?utf-8?B?QXlCdnRiTjcrRzd2SW1ObHVwTWNEYWNqaG5pYkxtUUsxYW52OGRybFZuN2xS?=
 =?utf-8?B?OXZLdFY4cWh5VnpDSWt6L0VWVk5mdUZWWHZ2czVGK0swZFN2ajZhaVZWSVk1?=
 =?utf-8?B?OXlXUTIyVzl5a1JWNWFpOG9FWFRUL2JVUyt3ZmROaHlzblhWcnlQZTc3S3lj?=
 =?utf-8?B?L3lMZ1RZQ0J0UmFiY0oveUtGaGJTeTZNZjRPcUN1dSs5TXlvb29GNTV6V09J?=
 =?utf-8?B?R3lsd29LYUdHZFZNQy9hN1IvWTdtcEQvSzJscFFxWGFEZDJqL2VZQmpBWFJS?=
 =?utf-8?B?bDJJRXN6RmkyUWJRMFNHSDd1WkRSRjF0a1IvOU1lTmdYTkQ3cEVYanVNK0V3?=
 =?utf-8?B?TUFHelZ3WUpSRHVVR21nSHdsa01POFdzSWdZN0Vrd05Qd0xLOVZveng4cHBj?=
 =?utf-8?B?OTFPUzJTcjJ3aHlDYkd0aFdmT1crNlRMeTYwa2FNR05TWlpwTEpERDdZa21J?=
 =?utf-8?B?SjNsSTJDWnVrdGpvNlBDMzVyc2Y0OUQ3MFdBWEdOTE55ZmRwcTZOOVgvQVZD?=
 =?utf-8?B?TmFDQlZXenNQbi9tbDNxMFFnOVNpOUZSU2pzVHN2ZHpaTkZwY3RqeDlIT3Nm?=
 =?utf-8?B?V2hhclNiNWNCcDJUeGZnRWgrdmJJWGtyUzZ4Wk8xRnBXYkpqQUpUNzVXazdW?=
 =?utf-8?B?WUl3dzdUOVBwbndqODBBRVJ6bWdxNXYwbkxIRFkrUE4wcXBqdUMxY3ZYS0dM?=
 =?utf-8?B?dDFzOTlWSmZOazdLRG1GZ2lEZ3V0czFCK0owTHhvcGhoLzBSTHVlcDh3UE5o?=
 =?utf-8?B?Q0pBczFrbDJGbi9jUklJMFFwZHBnRy9sRkhDdG03Rmx1NjJ3Q1c3ejdTMkdI?=
 =?utf-8?B?c2w3cFRHOTJZUXNUeFhWeDdjUkROaE1DTDBXc0VZb3FlYWZTUDRNRm9zdHUr?=
 =?utf-8?B?MEp6N2lRdVIvOGgxS29XYjFSa2Q5RmQ4ajROWWhGTVhMZHhXUlZndHdtZFlm?=
 =?utf-8?Q?8+9g5bDpsQ7I/rXrOQH9d3M=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(14060799003)(36860700013)(35042699022)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	P9zK6KwPAcK3oJLycbmxiciJO+gRkT3CAY88ZiEEieK7XRdF6RaBzUl63qcEnsWpIICntt3RiUiJhlVBzTXonJCbgTWCHIYn7tV/xskKoiRPF6HnRlA7X+vgFRQl4pfTikp9249VhZQP6iXC/hQxGSt2kT7fdxjmD2K7Lih8b16E73r8UeXwPqnRLjKUv2d6Yzf7Vt2kKqZOlj4QH/EwKkxIjGWPYNhBfAEx4euJYBN2eoyGq/ezhBsduuOrAv433AqqGDSbkpZlzKr7BdQs132Xq7HSgaNSZu4U5KpHqEOShw3vMIu1gkj43hsRdXbKVr7XCzJSNwXD0QgPIUasnKZGZ+Bpa312279F4bIleMmh3aAlfSKrpnlc9vI2EAwSOqI16P4fm8vfaDh/EFU/HaiWGBXxt9074au7/idUE15dNA5nESkV7Cfwtug+1quX
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 11:34:52.9335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79fcbd6d-bf4d-46b2-20d3-08de6ee1bbc0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8109
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

VGhpcyBwYXRjaCBhZGRzIHRoZSBkZWZpbml0aW9uIG9mIHRoZSBUUllfSEFORExFUl9EQVRBIG1h
Y3JvIGZvcg0KdGhlIEFBcmNoNjQgYXJjaGl0ZWN0dXJlLCBhcyB3ZWxsIGFzIG1ha2VzIG1vZGlm
aWNhdGlvbnMgdG8gdGhlDQpleGNlcHRpb24gaGFuZGxlciByZXNwb25zaWJsZSBmb3IgdGhlIF9f
dHJ5L19fZXhjZXB0IGJsb2Nrcy4NCg0KVGhlIGZpcnN0IGNoYW5nZSBmaXhlcyBhIGJ1ZyB3aGVy
ZSB0aGUgZXhpc3RpbmcgZXhjZXB0aW9uIGNvbnRleHQNCnJlY29yZCBpcyByZXVzZWQgYXMgYW4g
dW53aW5kIGNvbnRleHQgcmVjb3JkLCB3aGljaCBmYWlscyB3aXRoIGENCmNyYXNoIG9uIFdpbmRv
d3Mgb24gQXJtIChBQXJjaDY0KS4gVGhlIGZpeCBpcyB0byBjcmVhdGUgYSBuZXcNCnJlY29yZCBp
bnN0ZWFkLCB3aGlsZSBsZWF2aW5nIHRoZSBvcmlnaW5hbCBvbmUgaW50YWN0Lg0KDQpUaGUgc2Vj
b25kIGNoYW5nZSBhZGRzIGFuIGFkZGl0aW9uYWwgY29uZGl0aW9uIGZvciBjYXNlcyB3aGVuIHRo
ZQ0KaGFuZGxlciBpcyBjYWxsZWQgYWdhaW4gaW4gdGhlIHNlY29uZCBwaGFzZSBvZiB1bndpbmRp
bmcgb24gY2VydGFpbg0KcGxhdGZvcm1zIHN1Y2ggYXMgV2luZG93cyBvbiBBcm0gKEFBcmNoNjQp
LiBJbiB0aGlzIGNhc2UsIHRoZSB2YWx1ZQ0KRXhjZXB0aW9uQ29udGludWVTZWFyY2ggaXMgc2lt
cGx5IHJldHVybmVkIHdpdGhvdXQgbWFraW5nIGFueSBjaGFuZ2VzLg0KDQpUZXN0cyBmaXhlZCBv
biBBQXJjaDY0Og0Kd2luc3VwLmFwaS9sdHAvYWNjZXNzMDMuZXhlDQp3aW5zdXAuYXBpL2x0cC9h
Y2Nlc3MwNS5leGUNCndpbnN1cC5hcGkvbHRwL2NoZGlyMDQuZXhlDQp3aW5zdXAuYXBpL2x0cC9t
a2RpcjAxLmV4ZQ0Kd2luc3VwLmFwaS9sdHAvcmVuYW1lMDguZXhlDQp3aW5zdXAuYXBpL2x0cC9y
bWRpcjA1LmV4ZQ0Kd2luc3VwLmFwaS9sdHAvc3RhdDAzLmV4ZQ0Kd2luc3VwLmFwaS9sdHAvc3Rh
dDA2LmV4ZQ0Kd2luc3VwLmFwaS9sdHAvc3ltbGluazAxLmV4ZQ0Kd2luc3VwLmFwaS9sdHAvc3lt
bGluazAzLmV4ZQ0Kd2luc3VwLmFwaS9sdHAvdGltZXMwMi5leGUNCndpbnN1cC5hcGkvbHRwL3Vu
bGluazA3LmV4ZQ0KDQpTaWduZWQtb2ZmLWJ5OiBJZ29yIFBvZGdhaW5vaSA8aWdvci5wb2RnYWlu
b2lAYXJtLmNvbT4NCkNoYW5nZS1JZDogSTg5YTJmNjFkYzhjNzQ0ODM3MmE5YTdhM2NiZDc4NThl
MGVjOTUyMDkNCi0tLQ0KIHdpbnN1cC9jeWd3aW4vZXhjZXB0aW9ucy5jYyAgICAgICAgICAgfCAx
MSArKysrKysrKy0tLQ0KIHdpbnN1cC9jeWd3aW4vbG9jYWxfaW5jbHVkZXMvY3lndGxzLmggfCAg
OSArKysrKysrKy0NCiAyIGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDQgZGVsZXRp
b25zKC0pDQoNCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL2V4Y2VwdGlvbnMuY2MgYi93aW5z
dXAvY3lnd2luL2V4Y2VwdGlvbnMuY2MNCmluZGV4IGQ0YjlmZTllZi4uNGJiN2Y3NzA1IDEwMDY0
NA0KLS0tIGEvd2luc3VwL2N5Z3dpbi9leGNlcHRpb25zLmNjDQorKysgYi93aW5zdXAvY3lnd2lu
L2V4Y2VwdGlvbnMuY2MNCkBAIC02MTgsMTAgKzYxOCwxNSBAQCBFWENFUFRJT05fRElTUE9TSVRJ
T04NCiBleGNlcHRpb246Om15ZmF1bHQgKEVYQ0VQVElPTl9SRUNPUkQgKmUsIGV4Y2VwdGlvbl9s
aXN0ICpmcmFtZSwgQ09OVEVYVCAqaW4sDQogCQkgICAgUERJU1BBVENIRVJfQ09OVEVYVCBkaXNw
YXRjaCkNCiB7DQorICBpZiAoSVNfVU5XSU5ESU5HKGUtPkV4Y2VwdGlvbkZsYWdzKSkgew0KKyAg
ICByZXR1cm4gRXhjZXB0aW9uQ29udGludWVTZWFyY2g7DQorICB9DQorDQogICBQU0NPUEVfVEFC
TEUgdGFibGUgPSAoUFNDT1BFX1RBQkxFKSBkaXNwYXRjaC0+SGFuZGxlckRhdGE7DQotICBSdGxV
bndpbmRFeCAoZnJhbWUsDQotCSAgICAgICAoY2hhciAqKSBkaXNwYXRjaC0+SW1hZ2VCYXNlICsg
dGFibGUtPlNjb3BlUmVjb3JkWzBdLkp1bXBUYXJnZXQsDQotCSAgICAgICBlLCAwLCBpbiwgZGlz
cGF0Y2gtPkhpc3RvcnlUYWJsZSk7DQorICB2b2lkICpqdW1wX3RhcmdldCA9ICgoY2hhciAqKSBk
aXNwYXRjaC0+SW1hZ2VCYXNlKSArIHRhYmxlLT5TY29wZVJlY29yZFswXS5KdW1wVGFyZ2V0Ow0K
Kw0KKyAgQ09OVEVYVCBjOw0KKyAgUnRsVW53aW5kRXggKGZyYW1lLCBqdW1wX3RhcmdldCwgZSwg
MCwgJmMsIGRpc3BhdGNoLT5IaXN0b3J5VGFibGUpOw0KICAgLyogTk9UUkVBQ0hFRCwgbWFrZSBn
Y2MgaGFwcHkuICovDQogICByZXR1cm4gRXhjZXB0aW9uQ29udGludWVTZWFyY2g7DQogfQ0KZGlm
ZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vbG9jYWxfaW5jbHVkZXMvY3lndGxzLmggYi93aW5zdXAv
Y3lnd2luL2xvY2FsX2luY2x1ZGVzL2N5Z3Rscy5oDQppbmRleCBhMDdlMTQzYzcuLmM0ZWYyNzg4
ZiAxMDA2NDQNCi0tLSBhL3dpbnN1cC9jeWd3aW4vbG9jYWxfaW5jbHVkZXMvY3lndGxzLmgNCisr
KyBiL3dpbnN1cC9jeWd3aW4vbG9jYWxfaW5jbHVkZXMvY3lndGxzLmgNCkBAIC0zNDYsNyArMzQ2
LDE0IEBAIHB1YmxpYzoNCiANCiAjaWYgZGVmaW5lZCAoX19hYXJjaDY0X18pDQogI2RlZmluZSBF
WENFUFRJT05fTVlGQVVMVF9SRUYgIl9aTjlleGNlcHRpb243bXlmYXVsdEVQMTdfRVhDRVBUSU9O
X1JFQ09SRFB2UDhfQ09OVEVYVFAyNV9ESVNQQVRDSEVSX0NPTlRFWFRfQVJNNjQiDQotI2RlZmlu
ZSBUUllfSEFORExFUl9EQVRBICh2b2lkKSAmJl9fbF90cnk7DQorI2RlZmluZSBUUllfSEFORExF
Ul9EQVRBIFwNCisgIF9fYXNtX18gZ290byAoIlxuIiBcDQorICAiICAuc2VoX2hhbmRsZXIgIiBF
WENFUFRJT05fTVlGQVVMVF9SRUYgIiwgQGV4Y2VwdAkJCQkJCVxuIiBcDQorICAiICAuc2VoX2hh
bmRsZXJkYXRhCQkJCQkJXG4iIFwNCisgICIgIC5sb25nIDEJCQkJCQkJXG4iIFwNCisgICIgIC5y
dmEgJWxbX19sX3RyeV0sJWxbX19sX2VuZHRyeV0sJWxbX19sX2V4Y2VwdF0sJWxbX19sX2V4Y2Vw
dF0JXG4iIFwNCisgICIgIC50ZXh0CQkJCQkJCVxuIiBcDQorICA6IDogOiA6IF9fbF90cnksIF9f
bF9lbmR0cnksIF9fbF9leGNlcHQpDQogI2Vsc2UNCiAjZGVmaW5lIEVYQ0VQVElPTl9NWUZBVUxU
X1JFRiAiX1pOOWV4Y2VwdGlvbjdteWZhdWx0RVAxN19FWENFUFRJT05fUkVDT1JEUHZQOF9DT05U
RVhUUDE5X0RJU1BBVENIRVJfQ09OVEVYVCINCiAjZGVmaW5lIFRSWV9IQU5ETEVSX0RBVEEgXA0K
LS0gDQoyLjQzLjANCg==
