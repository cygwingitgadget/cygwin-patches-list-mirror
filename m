Return-Path: <SRS0=5o3q=UM=cornell.edu=kbrown@sourceware.org>
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazlp170120002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c001::2])
	by sourceware.org (Postfix) with ESMTPS id 7D19F3858023
	for <cygwin-patches@cygwin.com>; Mon, 20 Jan 2025 15:37:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7D19F3858023
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7D19F3858023
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c001::2
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1737387424; cv=pass;
	b=fJXiPCNPFRqro3f/qHwbZ34Ga/OQct3dpBGKyBlPWa0iXXH+vdR7456MGiPME8oVb4OS0Bd7Rq97obBR4V0NpA7Nc7OapQ+o5Oyg5NI+4zFLh51d/b59eAqrXnoVAHWpZJwXkt1t/SEnR6o1Cp4WrSXoIGxkzBEpeDF+wDbfnGY=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737387424; c=relaxed/simple;
	bh=ijDIBa1bgC8j4UIRrYUSf8XlPsd31YRmyVs5S5eJhiQ=;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version; b=IJwt4D+R/1cCp5MoEfLFpTUQCbIK6HxIuFy12agdcZITlwTmAuNhFxDrF3gmdiaYRgagr7uL9fjJ73uDztUCNFJGmnnThxD2hQdCi6Zo07j60KNMoWE3ZKSkXjzY20vsWalCvRmjPD6L5WBZvSLmLrzTG7LHoHzU/YBANaZZ2oM=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7D19F3858023
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=cornell.edu header.i=@cornell.edu header.a=rsa-sha256 header.s=selector2 header.b=esTbz57W
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yuvq7dBoq4tEBVls3wPbobDi0Gt+nuQTC0b72Str3S4icdL9VqrTJ0eKt5TdQH79HqEAufAbS4K+PyDUVDugHJ0SwW+LbeIXh+ShXC49DCxzzn75GNlxZG8GNDpJsIAwQC1vx22KGVhVvU9JeA1XPkf/ASSBKftLEEfQOyZMOmMG5msu1wvAgrQomtlKorRqzUM2X0kQFsUT64naiFqiyBu3YYUx5GT6514cjySYs+MUdSakApw7Lu6dMiFpdCMXaUXi/zAkncXWe0LByH6abcPTgULWk2YFh2IBY3gI5qFjy0KSHWHYTUjn7LS36zHbpoYAGs6PNoE4ua6/itiC8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2LCaTkyyS+PjaPZO9dbDFjFmq7GfThYYC80r9xfndE=;
 b=HSToicfczxA8bvS4x3ZwxbICnhJalFplceOb0janqS1q5x3GLMmD1Sckvfmz2ogcyDzyxzwOiyk4UvRrFSe9OwBh0VlBf1iBBQ1UnBZ7j/LYBmNMptopTk/M7oY4vE4gaJj+yuTNnsMyIsnYjAonZVSHXG/wVHWRt2rtqEHs2vq12gCZOUDEmZSvqY3IqUfMwRqP6Z8t2B3LjcqRXznpCAN5K2eh9zJYpq2PVEEVFRvRGKfeqyws6uUR/cqTqj/6zjLJt1y3YYOCrKzhTjW927UM/dW8tdFuQrn4XjRIFmJG0zh2S2QjXVRwcGqTWMWdx5+LgQh/kzHmDC7mJn6byQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2LCaTkyyS+PjaPZO9dbDFjFmq7GfThYYC80r9xfndE=;
 b=esTbz57WP3OzU7Chk8xhLax8xrOb57ns2fqdcx83Fxu7uWnwWe9etfXRTTA/TDY8fiswE0c6wQ25TyFqkGyjRR4cd5UAPPTVnR+VwRNs3/A8zh/oaOX9dRmAjHv8pdv7qZAB7ii5/bTtMNUQcmY07oKmBZrzcn0s6Nl8MIgqu6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from SN6PR04MB5151.namprd04.prod.outlook.com (2603:10b6:805:90::25)
 by CH2PR04MB6997.namprd04.prod.outlook.com (2603:10b6:610:9d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Mon, 20 Jan
 2025 15:37:02 +0000
Received: from SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd]) by SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd%6]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 15:37:01 +0000
Message-ID: <b9d17873-d3c3-496e-b1f4-f2ace2054414@cornell.edu>
Date: Mon, 20 Jan 2025 10:36:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: mmap: use 64K pages for bookkeeping
To: cygwin-patches@cygwin.com
References: <92eb753b-055a-4171-a1d0-56bc8572d174@cornell.edu>
 <Z4TzRLHGdvcxfT_y@calimero.vinschen.de>
 <20250115221730.4b1ce8becbd1060ffb0373da@nifty.ne.jp>
 <8f026ac1-d628-4723-983f-953275ea4329@cornell.edu>
 <Z4fpeXlmjOVu-u1A@calimero.vinschen.de>
 <Z4fw48L9OmD9eMr1@calimero.vinschen.de>
 <67b40edb-6719-474c-bf05-a3fffc8b782e@cornell.edu>
 <Z444U3s1KgpspGd2@calimero.vinschen.de>
Content-Language: en-US
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <Z444U3s1KgpspGd2@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0914.namprd03.prod.outlook.com
 (2603:10b6:408:107::19) To SN6PR04MB5151.namprd04.prod.outlook.com
 (2603:10b6:805:90::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB5151:EE_|CH2PR04MB6997:EE_
X-MS-Office365-Filtering-Correlation-Id: c15a7ca3-7d9b-4ce0-912c-08dd396848cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmFic1RXdGZ2ZmZKZlJUa3ovajZlWGZwMERkUTBwQ0Nrb1UyUlNtK1NWSnJt?=
 =?utf-8?B?LzN4TWZaQWtqM2dHaCtybXhWZjJhSDQ2NkhUTmFzOVRoalRKbEZ3czNEd3kw?=
 =?utf-8?B?Z3FXMnBLTjErRUdtN3g5YWwxTFRIQTFHcVowcDhUa00zdlRnWHd1cW9FL1Yr?=
 =?utf-8?B?WDNvWDBYdzhqcUJjZ001bUlwcURBc2RNUkRZMFhGWGdSMmR2S3BQZDN6MzBD?=
 =?utf-8?B?dzNiNXA3TjliSE9hMTlJTEZUTENNNUJuR3E2Z0FYK2ZWUG8wU21sckx0Q2xx?=
 =?utf-8?B?VTRVYzZ5VjVqUjlUeUM4c3prV0N5ZGJzdlNlMi9LejZSWCsxRHBnY1dJUE1P?=
 =?utf-8?B?aXFra2FSblAwQ1FMbm1PYWZhUlVLSVV0eThBZWtTdFliQXkybXkrSDUzT2o5?=
 =?utf-8?B?R0ZpNEhoZGRrMGZnK25UeFFhTTN1dkxnbnN6VGtzcVo1UFhoeXVmOCtNYzVM?=
 =?utf-8?B?aTU4R250cmRPSkZEMHBPMitEZ0d5dEZnSVZobVZKQWpDU3YvU21FdkJmWjJa?=
 =?utf-8?B?U3M3clVmTHJFSjFzUzBnSndzTW5yemZtYmRUMDhpMUdPVktkcjdLb1FjdFY0?=
 =?utf-8?B?SktTNjZNR1R6UWJkTWE1dDM3TGtKTDZhd2hTVVlrTTJFMTdyajZheGlwZFJr?=
 =?utf-8?B?VVNxNjhvMVRWKzQzUFFRbEhOemxoV3o4bDNkejd0SjUvQzJCdEVXZEFSMFdJ?=
 =?utf-8?B?Ri9VUjZYMEE4YlZ5Y2JXZ3pjSEcyV1lEeFA5LzhhWlVCVnYxaEtWRG5mU3lv?=
 =?utf-8?B?aWdFTnBXWGhJb05ubDFtWVAzMkdwcUZsWkxmUHNvWjdqNkx1cHJOMkJvK0VW?=
 =?utf-8?B?WHdCTDhNZWJ4b2o3a2lWSU9NOUxtVmcrM0lCLzFSQXBxaUh4cGFPa0hBWlRl?=
 =?utf-8?B?MllUQk9kbEV4am91b0VJTjU0QkZpSHJZZGl2QW4ySjRpRzc2K2sxYmxyL0Np?=
 =?utf-8?B?eXhxclZTRG5XMkoyaEVib2I0Sm8xV0RobnFJRWFNdHlaUFVEcmcrd2txVHho?=
 =?utf-8?B?ZkVxWFR6bkpid01kTENrN01YbDNReDRIVkNWeUVqM3M2VlNNa0JJZGttaHU0?=
 =?utf-8?B?Z3ByMTZJUHl1U0VMMDFQYkxQTGVZRzk4VlBQY2tLK05NZzlpYkZIQWp6bEFn?=
 =?utf-8?B?VU5Rc3I1MEZyT1V4SEUyb1pPckdTcE9RTWZWS2YvckxFTjdPMk53Yk9SZjJp?=
 =?utf-8?B?V3hnZ3d5T1BmV3JpQmlsTUtoTmgwTTN1eHR6KzczeGNNRk9laFZLRnp1WjBu?=
 =?utf-8?B?ckVjRCtlRFpPQmFmSzNNb3NyZFZVNXdoUmZaSm9jbDlxcGhBK3c1WXZJSjNQ?=
 =?utf-8?B?czNtY2xualNiNDlFd0FHbUJ0SFhEOUFVbWhPaEZROTNsNTY1dDhYYWh2c1Fr?=
 =?utf-8?B?ejF0TXNJdHJyMkxjYWhsUEpyV0JsWVVlNFJLaERGNVBiRXRsRS9idWNMdkUy?=
 =?utf-8?B?NEFOQmoyUkZpSDZRUGY5ZzZYZVVuRXhMSjZNRXpRc2p3KzFpOHdsdm9qa2ky?=
 =?utf-8?B?MjRtYkRqOUI3L1ZJa29uaXhHNFdjVTc1ODhJaTdhdjVzVU5nck5SN3lLcklq?=
 =?utf-8?B?c1dVN1plVkJvaE9EN0JZNkI0TlNyWlZranBzNmJwUkJPTEcrK05iaGVlYmhm?=
 =?utf-8?B?UUI1WGJhMzhPdGExMUR1RGlaSm9wckRwZENEWnFzZDQ4aDZxSGllVW4xcDFp?=
 =?utf-8?B?RHcwcXU3TlhEY3pqSUtXSm5oQVZzbWJ4WW1OQWdNTzJ6anhRTUR1R3JyY0FJ?=
 =?utf-8?Q?63Jre7YE1fafVAJ9psasGibfXFn+X7kDbTMmsWh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB5151.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3RRQVgrdVBEcDArQXdhQ2pYaWkrOEk5WEhmSGNwSVdacGZ5MmFzTTZNNTlT?=
 =?utf-8?B?elRBaVpqVnpJZDRNY1JvNGRLbjhnck5KRTkrQ1k0UFhiaTI1NUhRZHlkdXZM?=
 =?utf-8?B?Y0xSeVNIYVhORldRYUEzdGQ4Y29xbHVBQXJzUW1FK1lxcmdVcXhSTG1oZ293?=
 =?utf-8?B?MGlaVnFGaE8wYXN2a0VrK2RlU3l2V1RyRFl5TCttc2pBVTZ5cFAzVitmT09q?=
 =?utf-8?B?NVN2QXY2TStBR0xRcExZTUpjY2QrZXgyTWFTdHZZNmx0cTZiTFMrZU9yeXdH?=
 =?utf-8?B?U2dFRGxxenQrVk8wVnY3L25SaitySTFKMHFPNVJnakVsVmhtS01iOGxBdVc4?=
 =?utf-8?B?U001eGR2UXN6S1lLNXM3ZGZaR0o3d3hKVUgwMmZwSk16elQ5ekpmNnJ0WWNr?=
 =?utf-8?B?RVpRZmJsNDMxbXFOUU1XUDZ5TWFvZFBmZXgrWFBYQ3ZBcVpOa28rRERvVzZx?=
 =?utf-8?B?Zkt0aGNLRGtzYUxORHF0SjROaElmZmxnWTRWUXdsR3ZPRXE0NW5rRThZN2RL?=
 =?utf-8?B?NUg1VHNyNGk0Z2dBRzZvNm9uZzJJaEZQNkxwQ1hRd2lCTHhQaW9pUUNiUi9F?=
 =?utf-8?B?dmtwbkcxTmNMM0pXVEhHL3hnZHUyb1RXTm1ZNk9veVZIM3lBcGNMclBITmhE?=
 =?utf-8?B?a252dzRMZEdGc1B6NFdSTEtZUEllUDNBUmptSTBrUGJIMGJxWDFIc2xlR3o4?=
 =?utf-8?B?VVNhd0hUQm1rVXljL0IxZEVjSWRybVZCNnViTStXdm5USDc0bW5KRWNXaUE4?=
 =?utf-8?B?Q292RXBoelNNUkx1UVZiU1Zkck9JRXExdXZZY1NkZ0psb1Exd3FCcnFWTUpn?=
 =?utf-8?B?aUdvY3hDdHFiV1J2SG9QQ1RyMXdYU2dreENsT0hFbSs0c2xtalJCdnVsM3p3?=
 =?utf-8?B?bllxU2IvamQyc0tuam1lbkc5b0NRTFBBbzdHV2hjdlB3azZSQUlhOEFBVGNq?=
 =?utf-8?B?VWExQ25PMjFpZnMzMzVrQzRLSXFLdG5CWUFTQ3ZCemhZWXZ4ZzJ1L0xEOWdX?=
 =?utf-8?B?UUZOTHRYcnV3NVZ2K09UUE8yd3p0ZmRMRjUwdDV2M3RPVU1HRkM2bXlXN0dQ?=
 =?utf-8?B?Z1IwT2EyZW9obmZWK3k3eFR5SHl4Y3dTVElqV2lNcFJ0bUhzWHRCSnRKbnBw?=
 =?utf-8?B?UU83ZFhoNkdrWDNhYzY4Zk5YaFcxTTlSS1FKdUxMT05pbGQxaUhxczBXWG8x?=
 =?utf-8?B?N1BWRFhGYUxIeDg0SnZWZTJGc1V5eG5wdnBPMyt2TGhyWXBURlUwbVZJUDlX?=
 =?utf-8?B?VXBhVkxzdHpIM1UvR2JNbUtlWGY1Q1FMRC9TQTMwZXgyL3BodEtOTzcwVkdq?=
 =?utf-8?B?RzYxOUNTNmhsaXl3bUhVZmZ1Y3BTQWN1N0dZcDdhTVRRWEFXb2JMZW1ueVdv?=
 =?utf-8?B?MiszeitmcythNUc4eFNVd1A5ZkhVc08vMGU4S0dxVTBFMUNYbmRPNUxRR1NP?=
 =?utf-8?B?R1pQUzJSUVBLT2JJcE5XMzVTSmNwY2hpcTRoanc0Qjd3OHRRMGlVNndGci9h?=
 =?utf-8?B?TURxK05qNXdpOVBCa0MzVmdlZkkvQXlpNVJNZ2JlRWFhNDFOTFFXbk5SQndU?=
 =?utf-8?B?MjVpRXJ6UWUxL0RQeTZRVHRIMUlpdUZmYzkxcXlUWloxRGVzcHlQWWYzWTZ4?=
 =?utf-8?B?bGtCWjVRdmRqWGVBcWFwWDVSNDhSZGQ3dURXTU1oWk5aRnFzYm4vQVRHUjRD?=
 =?utf-8?B?Q09Dd0xHeWh5NXJSTlpBNlNzd3JSSHVJb3RVR0xtb1RsY0VZK2k4MnloSFBU?=
 =?utf-8?B?UjFEbE8xWGlmVTVxWWlqWnl3NXNGZWpnczIraVdld0VSbVRTU2RjY0FFTDRL?=
 =?utf-8?B?YWhJTEt1cnlTNUdwdEd3bWhJYVRmbEJaa01OZlRUaFRMWEdraVlKQTJnNVBQ?=
 =?utf-8?B?L1RqWDdxN3VPWFQyVUo0ZFhpMTliakRHVU9YU0xDQUt3SVFxRW1CSTVVeXBx?=
 =?utf-8?B?YW93Zy9GTlRqNUhTcmw0bHRjbGpML0RlTVdoY0hLZWk4bWxacVVJMHRLbXJk?=
 =?utf-8?B?WjdvTkYxaFlQM1h0cmJ1THZNQStCbFdnRVNKZVlyQjVnbFc3a1Avc3YvNldQ?=
 =?utf-8?B?dlFtV1JrOXhNeEJRYm1pV2lqczM0Qm5wWUhRN2NGRmpYNFc0TWVxUklMVktw?=
 =?utf-8?Q?gX0xLrKCxd66PfW5MSRwyAWc0?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: c15a7ca3-7d9b-4ce0-912c-08dd396848cb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB5151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 15:37:01.8981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +/dLW4IqpFYf50ar416Bk16LIQQk//gNwbs2jKEQm4fH2WGPYMd/9pjLLApOS3t0fjf6622xQPpgsnh2Bua1pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6997
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,JMQ_SPF_NEUTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 1/20/2025 6:49 AM, Corinna Vinschen wrote:
> Nice idea, but this may not do what is expected if the mapping is an
> anonymous mapping, leaving the protection or mapping of trailing pages
> in a wrong state, isn't it?
> 
> Can we easily make sure the type of mapping (file vs anon) is known
> at the time of rounding, so the rounding is performed differently?
I hadn't thought of that.  Actually, I *think* the record length is 
already a multiple of 64K for an anonymous mapping.  But to play it safe 
we could condition the rounding on whether or not fd == -1, like this:

--- a/winsup/cygwin/mm/mmap.cc
+++ b/winsup/cygwin/mm/mmap.cc
@@ -409,16 +409,32 @@ mmap_record::find_unused_pages (SIZE_T pages) const

  /* Return true if the interval I from addr to addr + len intersects
     the interval J of this mmap_record.  The endpoint of the latter is
-   first rounded up to a page boundary.  If there is an intersection,
-   then it is the interval from m_addr to m_addr + m_len.  The
-   variable 'contains' is set to true if J contains I.
+   first rounded up to a Windows page boundary for a file mapping or
+   to a Windows allocation granularity boundary for an anonymous
+   mapping.  If there is an intersection, then it is the interval from
+   m_addr to m_addr+m_len.  The variable 'contains' is set to true
+   if J contains I.
+
+   It is necessary to use a 4K Windows page boundary above for file
+   mappings because Windows files are length-aligned to 4K pages, not
+   to the 64K allocation granularity.  If we were to align the record
+   length to 64K, then callers of this function might try to access
+   the unallocated memory from the EOF page to the last page in the
+   64K area.  See
+
+     https://cygwin.com/pipermail/cygwin-patches/2025q1/013240.html
+
+   for an example in which mprotect and mmap_record::unmap_pages both
+   fail when we align the record length to 64K.
  */
  bool
  mmap_record::match (caddr_t addr, SIZE_T len, caddr_t &m_addr, SIZE_T 
&m_len,
                     bool &contains)
  {
    contains = false;
-  SIZE_T rec_len = PAGE_CNT (get_len ()) * 
wincap.allocation_granularity ();
+  SIZE_T pagesize = get_fd () == -1 ? wincap.allocation_granularity ()
+    : wincap.page_size ();
+  SIZE_T rec_len = roundup2 (get_len (), pagesize);
    caddr_t low = MAX (addr, get_address ());
    caddr_t high = MIN (addr + len, get_address () + rec_len);
    if (low < high)

Ken
