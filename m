Return-Path: <SRS0=YgYo=UC=cornell.edu=kbrown@sourceware.org>
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azlp170110002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c110::2])
	by sourceware.org (Postfix) with ESMTPS id 8D0703858294
	for <cygwin-patches@cygwin.com>; Fri, 10 Jan 2025 21:18:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8D0703858294
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8D0703858294
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c110::2
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1736543890; cv=pass;
	b=WkJ9wKbFuSFcZ9Dq3yik+Esv4ouorVUmozTQ5tScTAh/1N7BJgZB2G0AtY1Fg0T1+kxvH2v8XXJerqO80Ymk+yJRfF+8LGeHfX8ZyvGl3gXeogpGs4redLDFQ12uA1lzn+PdHW3u8X0ritvBrXt6pwrjXpZVmIsIHPTusJsWfrs=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736543890; c=relaxed/simple;
	bh=hSDh/5c964vR9QgDububTlMdQdebz1gcbkGc6A/pIN4=;
	h=DKIM-Signature:Message-ID:Date:To:From:Subject:MIME-Version; b=UjNaVYXzQSpYO3OVgxcYOn8Y5Zdo6/6TaagPCSbvSXVXICzuYboNy4/h91J+JTC1s0GgG4255lTTZlgcrWddZuQO9wNgSdBlLJIMOgerLZw+VkIMiSZOdTAA7v5RFjSbWYgWCtl+zGC41Jpxq5dJTcnvByei9dm3qBJpRTo2Yac=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8D0703858294
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=cornell.edu header.i=@cornell.edu header.a=rsa-sha256 header.s=selector2 header.b=ba0dNK78
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7FjfaXRZbrFMpLaV+nMOFtqn09wz9N0kngu3ymmsAKvyg7igwxIcLbYewlY9rZe95T+EChZw1hMPLMXnuiVEQwXOJMaZ2C+/NxcICUZGfKP8VzKwAPrvDPKijpon7z6ujP2fkXroA1KPEfHTjxgCCZoMuHXulvT9mPw6PRfMcMYSjDGd8swJ/uj4k02w1Q20la9pM00lv0/vlW+CjzY6YfRvsQp5mL2BJpUA8qVAEcavF0he2EuKqyMscucGjKC/UU6WTcy0wC28PmcYuUDmwI5eB9TS8Dzdf9IGU3/dO61qTP+UxSFyfXL2HxR2B/1fPQWbBRCrpxNDDQAtaLGiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Pfpk/WeYTgZouHfagqYi2+lHfy6029G6vCMiOusf88=;
 b=GF9cPecHTdb2s6s53H251Z+PRV9FjEXvRvJEy1/NW/V0HL6uFi1wlrdKrlzJ6ERTQQ7QVpfl+/H9kLO9GKdRRMdLdgCqiZagPZHNrRQSY1I28V6spSaCqkHzpNgN7Wa/rPwdeWsMq9VQCpL8DJ7zeGLPOisxzQAUGU3r29zMNXJ0e8GT7SB+8mqA/CEvfVAMSk46P9OjhQEnUXD6zN9Fp3ejeky7z9+zCOpqEDXz9ffQwHFKFkMDLJJK2+cGje1jmzxa1GNlbqL16UBNPjuKBhtC2ynAn9gkKPDIcMwYMFiKMGwAPzpteEOSjZ5Ul0HYlaAECxlx3I+L3tUyQ4CEkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Pfpk/WeYTgZouHfagqYi2+lHfy6029G6vCMiOusf88=;
 b=ba0dNK78QXPW+/SiHFOchgEWtsUJ21bn014GCV1gdv6w5DBJUS4Xf/CoPWYV+jntwO4Jlv9GmboGrIYGNqYTWYIceiCcr+WBT9i00JiKu7aKs6OtATsMRb/TzMB7B1fEQ7YSn1ziXD4ODbpLTgFocl+aZX+BxKqxZRRtQmPGfNY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from SN6PR04MB5151.namprd04.prod.outlook.com (2603:10b6:805:90::25)
 by PH0PR04MB7756.namprd04.prod.outlook.com (2603:10b6:510:ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 21:18:08 +0000
Received: from SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd]) by SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd%6]) with mapi id 15.20.8335.010; Fri, 10 Jan 2025
 21:18:08 +0000
Content-Type: multipart/mixed; boundary="------------z5MffjTrKipnKiv3pvMfm10y"
Message-ID: <92eb753b-055a-4171-a1d0-56bc8572d174@cornell.edu>
Date: Fri, 10 Jan 2025 16:18:06 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: cygwin-patches@cygwin.com
From: Ken Brown <kbrown@cornell.edu>
Subject: [PATCH] Cygwin: mmap: use 64K pages for bookkeeping
X-ClientProxiedBy: BL0PR01CA0032.prod.exchangelabs.com (2603:10b6:208:71::45)
 To SN6PR04MB5151.namprd04.prod.outlook.com (2603:10b6:805:90::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB5151:EE_|PH0PR04MB7756:EE_
X-MS-Office365-Filtering-Correlation-Id: a5b5fa58-067d-46d1-6b7e-08dd31bc478d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDkwT3pFSllXV0xKWUJLaXNRbGxQb0huWDl2Z2xGWVJPNnAzS2RkdVVWNU1F?=
 =?utf-8?B?Q3VkL3JZeEJJNndWT1lrSUtBbGFIU3pRTnd5TzlMZGNBSmhCTFB2SW5mOGNJ?=
 =?utf-8?B?cE1uSGU2Qm9tV2Q5SWgxeEh1cnhYZWxNcGZpeCtFWkx3eUh0MFMvbGtsWmlY?=
 =?utf-8?B?cTdGMXNsWmNUeEgrSW1FWURIeWpiM2hldXVxZXZHaXo0ckdSanR2NG9ybDZ4?=
 =?utf-8?B?emkxN0hJdlQyUmMyYWZReUJpV2VqL2tFMC9vQnFLbmpyTFlZa2hiWWhLcVZm?=
 =?utf-8?B?cjBUbTJ4NW9yOUpKRC9xSUErakNpOFczdTY2VzdTMWh3bXpvdzlKTm0wNmEy?=
 =?utf-8?B?TlBoVzdIa3JhTW0yMjhiamRDUlJDRFhkUXB2WXg3Mko5MXpoNU0rMm8rK0Rs?=
 =?utf-8?B?UEExNFFiZSsyOExFU3pRMGJvejF1enRTT1lZSXV4UDZUNFBQNXBjS0lhcTZy?=
 =?utf-8?B?TzBJcjNtZml2N3lpbjB6cWM5a3p3MFd1Mjk2aWw2WjhhbEVqM2tqUGVLMnJK?=
 =?utf-8?B?QS9XL3ZESVhaRmdmc1doaTBnS3JHZFBicEFCUitVT3pONGxCb05NNFA0Z3Ix?=
 =?utf-8?B?MDRHaWVTcTdDWkFpclpiZ1FOWDRXdTYxOHZHbDJPTVZISXJzOEtWdFBweGo4?=
 =?utf-8?B?WXluaC9TeXVYUGZ0Zm52azBlMS9DY0JFWUdVd1d1UjBRc21odVVySUw4QytS?=
 =?utf-8?B?SXZPVWMxbGhJNUs2azlMZjlVRFhBQk45dS9heTh3b2Q3UDlkQktQdGdCNzl6?=
 =?utf-8?B?dEUxR2tDYzJZOUY3aDhNR2RRZDJha1V1b3Y1ZE1GeWtqWU5GdE85MkZwSWNa?=
 =?utf-8?B?R1FrSWIxQ0JYWWNJaEF3M3FGK0VzRDR5YU91cUF3RVNuN0tnd1Qrd0xVQlBz?=
 =?utf-8?B?ZGszb2FPN1NRdlBMU21DenhCZU5NWitCOVdxTW9mQzFrdzBHQldVRngvUGxx?=
 =?utf-8?B?aUptZ2JCS24yQkVsNDY0cncvTFIzeDF1M1k2V2E4Y254c2pLbHJqb3NQT1NN?=
 =?utf-8?B?bHMzY1grVXMyc2E3dnQ0cENSRzlJY2Uxb2hka3pxRmpJaC9ZNkI3SVpkN1Mv?=
 =?utf-8?B?cy9Gd2VLcHZyWFozcndUN3JWTk9kWm5FKys3a3A2K1pKamVPU1M5bnNtYS9j?=
 =?utf-8?B?d2s1YmJsdWtqRVBjaUt5YmVES0FTaDFsaVZkM0pEdmMzdGNORjgvREhDVkpm?=
 =?utf-8?B?Y0Z2TFB6UkNQQ1QxRHpKaUpZNUprNkNPL0oxa3VhY0ZkQ1NvZFhzUDA2V21U?=
 =?utf-8?B?cmswREZLOStLdE5MbWNaYk1TSTBIakg3YmdxRlJna0pNY0FMbytJTGlVbTFO?=
 =?utf-8?B?Mi8zK2VUMmpiUkU3UW1pdWp0ME0vcFJaWUVjNFFKUVMyWWNiZmZNK0ZUeDZF?=
 =?utf-8?B?dWJJMEpLYTVCZnRLMnpiQ3lWL1FXK2x1cVByMHF0bzcvNlJUdHA0ZmlrSkpM?=
 =?utf-8?B?c1BZSzBGeXk2YVh3VVJXcjVZL2dZSC9VQ2MzNUFCajBMS3pYZkhxMUFQbFND?=
 =?utf-8?B?eCtxVFpVRHdQaDFxaFB6cGFWaDUxemJHWWdReUdmWngzU0ZFUHRHVXd5b2Y2?=
 =?utf-8?B?VDMrN3d1Y1YxOVh3UjNrUGxrdkRUaHNuMVQ5am5NQStCM3hwRElYeGRYSVk1?=
 =?utf-8?B?TUQrV0xySVRvc1BMaWZNcnhuWS91RkZQY2krNEVpblhGZVRLQi9nNCtuZXFU?=
 =?utf-8?B?T1BhNkJvTGRUVk84VDZZcGczQmZqTm04VjZjWStIcW9NY1dRYllWMFNobStM?=
 =?utf-8?B?UDcxQXJid0Z0VU5hRnA0bUJBU1B6ZnVTR0RTQmowRnAvbW11VzYyK2xzN084?=
 =?utf-8?B?YktrUWpGNlY1VUNTNnFId3kyRnhZTlkwTGdWeXJoUWlBSXEzbEZUdFBqeXhI?=
 =?utf-8?Q?/fkkgUFcGxkoT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB5151.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THV0M01KYnVJUlJYR0dxZXRnMlJWYm1NR1pCeXRMZ1I1a3BrVURiMTZWTDZj?=
 =?utf-8?B?WWwzdkQ1eVJCeWM5bWlPMFR0YVFSUTFFeTYyT1lGWUpjUWR5a3h5STJpTVps?=
 =?utf-8?B?bW5JSkZQMmQyeTl4dUxwYmY1ekVla1hYWE9DTWgyYXRkWnJEclh4cUxyWldx?=
 =?utf-8?B?N0kvbU52d1BXWC9UOThVVWdtSlVaZlpMSTR6d085NUxxVk1GN1FRVDhxYkF2?=
 =?utf-8?B?SWYvcldLZzEybzBJYy9XTTZSVG03Sk9vQUFjSWlDaG92MCtEMzFIMW12Y1R5?=
 =?utf-8?B?VVdOQyt4djB1OHdCaEt5TTF2ZzNvSGJhZEJ6Q1hMbUhQdEMxYXFxSmNTZm5Y?=
 =?utf-8?B?cEcydXhBN1BwVGVDd1Voa2NNWGZPb05TN1MzU09WQUl6d2ExbmpFWlEwMlNE?=
 =?utf-8?B?TWxodWoxVkZ2dmJLRDdkNy9BVGpLUnRnbUNGK3dadkJqcEI3VHJkWUthRG9i?=
 =?utf-8?B?Q241SzR3bzE0OVFTN3F1VGNlc0RiNGc1c3NkMmhBQkdPSnNrWHJsSHdCdzZr?=
 =?utf-8?B?Vk5Mb0RiTithdWhpSGZ5M2tIUGpYK25iQU42UVZvYlQ5RWQyUm1FaFZvSUFy?=
 =?utf-8?B?cnNWcDZkWDlaZ1A4ZXZWbk1RU01iSDZ4ZDZwRUlhMDQrSWlwdmo5YzY1dE5B?=
 =?utf-8?B?QTVNeEVjNGFYb0NEZmdlR1Y4RCtIcUcyMnN1WEkzU3o2SlMwOTF5cDRFZWFz?=
 =?utf-8?B?WjFnbVkvdC9TMWEraTdtL3huUUdRcnlyb21JeGRwS0VUS1FZNU9qajg1dWFZ?=
 =?utf-8?B?MHBSRFN2SjcvSE9JTXorcURnNlFDR0lzUHdjb2kzWmhZLzROSFZyVE5nNmlO?=
 =?utf-8?B?QjR1VCtMbVc1Z3JmNTQ1Z3FaT3UvYittcy9sdi9KNzJrWlNDZmFnZHJTcXJD?=
 =?utf-8?B?Q20rT2U1bnhhNm9tVjVBS0h5SzUwRmtSN1VlZlhQMldZNU9HV3FNVU1LOHNE?=
 =?utf-8?B?cmtzRUhTRHUzdGt6N3dQZnpNeGcvTE90S2VvTVpWNFU4eFVOZ09ZSDlQdktV?=
 =?utf-8?B?TU9sVzRCWFlMdmR5endQaExreXBsUVo1WFNrYi9RakdZTUk0S0JhZVgxWFh3?=
 =?utf-8?B?VGxWZnJxNFd5aUlUeTdqVm93S0l0YUFkMjNyR1E0b1FUdjdWT1VwVFd5aUZX?=
 =?utf-8?B?UXEvYUgzVFkvRlBNWGRUbi9xaHZkV2dlU1E1MVh6N3RQdjZYN010cFdHWWZr?=
 =?utf-8?B?dnVFVVBmNk5jUnFDTzUrc1Q2SldVK3QrOWhUZlZLVjErNFJSNWdWY1N0bnFt?=
 =?utf-8?B?aDAzN0dXSDdwZ2YrZGxHa3Izb3c3SlFZaWlzSUtNMGx6UVlqNFhRYjB0WEJU?=
 =?utf-8?B?ZUxoMjVvSWg4MFh1c2xXUmFubU5xVk53OU1ZdGlLZTIzSU5BS1FuWDNHby90?=
 =?utf-8?B?YVFiWUVpd21QQlJCOW1IanRqZmNoSkMxQm1yK25qb0pxVnFnbDlMWmlXb2Zy?=
 =?utf-8?B?V3JjdWJTbnN0cDNweG9JSURjN0xrb1NQSEZScVFvQm5vZWVXRUY3aGNkaG5E?=
 =?utf-8?B?N2lvaVZ2WFBlM0prTVhseVptRTZFT2t6QVJHM1NiZ1ZWYlZRYnIyQzQyRXJZ?=
 =?utf-8?B?WWhyV3VzMGRtdlZIZnZCcU5QNXNYUjhOWjROSVJHN0lidlFuakZzUFEzWTVD?=
 =?utf-8?B?L0liY0NpTnhZRFFHYnhPVjBHcDRHQ0pwOEY2ZGJVOHd5bHFDc3l4c2ltNDAw?=
 =?utf-8?B?NXVZeG1DSlk3ZnJhbUhlbE1oVW90L1YyUzNwMkw0Z3VFeDhGb2k5SjJkZDlB?=
 =?utf-8?B?cU9wclYyRGJqNGJLTmxIUEMrMXVUei81TUEzM0ZpSnNPblRDVitPRCswckpn?=
 =?utf-8?B?NG96VUQwZTRmZTEyS0Zpb2FPbjJIdGRpTWFLTWNlZDY2aFVjaFBtbjVpS0dQ?=
 =?utf-8?B?MUs5U3lpdS9PcU5GUWx1TjdYNGlzUHRvSFBTRnZvUG9Vem1FTXpyT2dpMFNk?=
 =?utf-8?B?ZCt1OXFuZTZIekJhcGRrY0g4bmtMb0JyZXBwb09YUTg2cWxpcmFMZldPR2JJ?=
 =?utf-8?B?VnUxUG9NK0paVmlkTmhlaG1zUFM5Wnk5cHAzSUR3aHhCK3lNamFaT2RDSUV0?=
 =?utf-8?B?cGtlRjIxWXdzaTJZK3BhQ1NUZENlVi9tSUlMTU01ZzBSNG1neE5VeW5VRzd5?=
 =?utf-8?Q?q4pVWNM79yLwuErqOUUHoWHIB?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b5fa58-067d-46d1-6b7e-08dd31bc478d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB5151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 21:18:08.3261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qEViP7Dewaj/wGjF3aki85iAWSvwtxwXbCIyg2AC74WWXJg8RBrL/nReUW7tnCOHLxCTSgR54WvyuM4aGsDoEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7756
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,JMQ_SPF_NEUTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--------------z5MffjTrKipnKiv3pvMfm10y
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Patch attached.

This turned out to be completely trivial, unless I'm missing something. 
I tested it with several programs that use mmap, and it seems OK.

Ken
--------------z5MffjTrKipnKiv3pvMfm10y
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-mmap-use-64K-pages-for-bookkeeping.patch"
Content-Disposition: attachment;
 filename="0001-Cygwin-mmap-use-64K-pages-for-bookkeeping.patch"
Content-Transfer-Encoding: base64

RnJvbSA2NTRlNWM4M2RhMDc3YjY3NjgzYTFhZWZkNzlhNDE0ZWQ2MDY3ZTUxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLZW4gQnJvd24gPGticm93bkBjb3JuZWxsLmVkdT4KRGF0ZTog
RnJpLCAxMCBKYW4gMjAyNSAxNDozOTo0NiAtMDUwMApTdWJqZWN0OiBbUEFUQ0hdIEN5Z3dpbjog
bW1hcDogdXNlIDY0SyBwYWdlcyBmb3IgYm9va2tlZXBpbmcKCkl0IHdhcyBjb252ZW5pZW50IHRv
IHVzZSBwYWdlcyBvZiBzaXplIDRLIChXaW5kb3dzIHBhZ2Ugc2l6ZSkgZm9yCmJvb2trZWVwaW5n
IHdoZW4gd2Ugd2VyZSB1c2luZyBmaWxsZXIgcGFnZXMuICBCdXQgYWxsIHJlZmVyZW5jZXMgdG8K
ZmlsbGVyIHBhZ2VzIHdlcmUgcmVtb3ZlZCBpbiBjb21taXQgY2VkYTI2YzlkMzViICgiQ3lnd2lu
OiBtbWFwOgpyZW1vdmUgX19QUk9UX0ZJTExFUiBhbmQgdGhlIGFzc29jaWF0ZWQgbWV0aG9kcyIp
LCBzbyB0aGlzIGlzIG5vCmxvbmdlciBuZWNlc3NhcnkuICBTd2l0Y2ggdG8gdXNpbmcgcGFnZXMg
b2Ygc2l6ZSA2NEsgKFdpbmRvd3MKYWxsb2NhdGlvbiBncmFudWxhcml0eSkgZm9yIGV2ZXJ5dGhp
bmcuCgpTaWduZWQtb2ZmLWJ5OiBLZW4gQnJvd24gPGticm93bkBjb3JuZWxsLmVkdT4KLS0tCiB3
aW5zdXAvY3lnd2luL21tL21tYXAuY2MgfCAyOSArKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LQogMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vbW0vbW1hcC5jYyBiL3dpbnN1cC9jeWd3aW4vbW0vbW1h
cC5jYwppbmRleCA1MDFkMzdiYjJlNjAuLjljMTBkNWUyYTE2OSAxMDA2NDQKLS0tIGEvd2luc3Vw
L2N5Z3dpbi9tbS9tbWFwLmNjCisrKyBiL3dpbnN1cC9jeWd3aW4vbW0vbW1hcC5jYwpAQCAtMjgs
OCArMjgsOCBAQCBkZXRhaWxzLiAqLwogICAgdG8gbWFwcGluZyBsZW5ndGggKFBPU0lYIHNlbWFu
dGljcykuICovCiAjZGVmaW5lIF9fUFJPVF9BVFRBQ0ggICAweDgwMDAwMDAKIAotLyogU3RpY2sg
d2l0aCA0SyBwYWdlcyBmb3IgYm9va2tlZXBpbmcuICovCi0jZGVmaW5lIFBBR0VfQ05UKGJ5dGVz
KSBob3dtYW55KChieXRlcyksIHdpbmNhcC5wYWdlX3NpemUoKSkKKy8qIFVzZSA2NEsgcGFnZXMg
dGhyb3VnaG91dC4gKi8KKyNkZWZpbmUgUEFHRV9DTlQoYnl0ZXMpIGhvd21hbnkoKGJ5dGVzKSwg
d2luY2FwLmFsbG9jYXRpb25fZ3JhbnVsYXJpdHkoKSkKIAogI2RlZmluZSBQR0JJVFMJCShzaXpl
b2YgKERXT1JEKSo4KQogI2RlZmluZSBNQVBTSVpFKHBhZ2VzKQlob3dtYW55ICgocGFnZXMpLCBQ
R0JJVFMpCkBAIC00MTgsNyArNDE4LDcgQEAgbW1hcF9yZWNvcmQ6Om1hdGNoIChjYWRkcl90IGFk
ZHIsIFNJWkVfVCBsZW4sIGNhZGRyX3QgJm1fYWRkciwgU0laRV9UICZtX2xlbiwKIAkJICAgIGJv
b2wgJmNvbnRhaW5zKQogewogICBjb250YWlucyA9IGZhbHNlOwotICBTSVpFX1QgcmVjX2xlbiA9
IFBBR0VfQ05UIChnZXRfbGVuICgpKSAqIHdpbmNhcC5wYWdlX3NpemUgKCk7CisgIFNJWkVfVCBy
ZWNfbGVuID0gUEFHRV9DTlQgKGdldF9sZW4gKCkpICogd2luY2FwLmFsbG9jYXRpb25fZ3JhbnVs
YXJpdHkgKCk7CiAgIGNhZGRyX3QgbG93ID0gTUFYIChhZGRyLCBnZXRfYWRkcmVzcyAoKSk7CiAg
IGNhZGRyX3QgaGlnaCA9IE1JTiAoYWRkciArIGxlbiwgZ2V0X2FkZHJlc3MgKCkgKyByZWNfbGVu
KTsKICAgaWYgKGxvdyA8IGhpZ2gpCkBAIC00NzAsOCArNDcwLDkgQEAgbW1hcF9yZWNvcmQ6Om1h
cF9wYWdlcyAoU0laRV9UIGxlbiwgaW50IG5ld19wcm90LCBvZmZfdCBvZmYpCiAgIGxlbiA9IFBB
R0VfQ05UIChsZW4pOwogCiAgIGlmICghbm9yZXNlcnZlICgpCi0gICAgICAmJiAhVmlydHVhbFBy
b3RlY3QgKGdldF9hZGRyZXNzICgpICsgb2ZmICogd2luY2FwLnBhZ2Vfc2l6ZSAoKSwKLQkJCSAg
bGVuICogd2luY2FwLnBhZ2Vfc2l6ZSAoKSwKKyAgICAgICYmICFWaXJ0dWFsUHJvdGVjdCAoZ2V0
X2FkZHJlc3MgKCkKKwkJCSAgKyBvZmYgKiB3aW5jYXAuYWxsb2NhdGlvbl9ncmFudWxhcml0eSAo
KSwKKwkJCSAgbGVuICogd2luY2FwLmFsbG9jYXRpb25fZ3JhbnVsYXJpdHkgKCksCiAJCQkgIDo6
Z2VuX3Byb3RlY3QgKG5ld19wcm90LCBnZXRfZmxhZ3MgKCkpLAogCQkJICAmb2xkX3Byb3QpKQog
ICAgIHsKQEAgLTQ5MSw3ICs0OTIsNyBAQCBtbWFwX3JlY29yZDo6bWFwX3BhZ2VzIChjYWRkcl90
IGFkZHIsIFNJWkVfVCBsZW4sIGludCBuZXdfcHJvdCkKIAkJbmV3X3Byb3QpOwogICBEV09SRCBv
bGRfcHJvdDsKICAgb2ZmX3Qgb2ZmID0gYWRkciAtIGdldF9hZGRyZXNzICgpOwotICBvZmYgLz0g
d2luY2FwLnBhZ2Vfc2l6ZSAoKTsKKyAgb2ZmIC89IHdpbmNhcC5hbGxvY2F0aW9uX2dyYW51bGFy
aXR5ICgpOwogICBsZW4gPSBQQUdFX0NOVCAobGVuKTsKICAgLyogVmlydHVhbFByb3RlY3QgY2Fu
IG9ubHkgYmUgY2FsbGVkIG9uIGNvbW1pdHRlZCBwYWdlcywgc28gaXQncyBub3QKICAgICAgY2xl
YXIgaG93IHRvIGNoYW5nZSBwcm90ZWN0aW9uIGluIHRoZSBub3Jlc2VydmUgY2FzZS4gIEluIHRo
aXMKQEAgLTUwNyw4ICs1MDgsOSBAQCBtbWFwX3JlY29yZDo6bWFwX3BhZ2VzIChjYWRkcl90IGFk
ZHIsIFNJWkVfVCBsZW4sIGludCBuZXdfcHJvdCkKIAkgICAgcmV0dXJuIGZhbHNlOwogCSAgfQog
ICAgIH0KLSAgZWxzZSBpZiAoIVZpcnR1YWxQcm90ZWN0IChnZXRfYWRkcmVzcyAoKSArIG9mZiAq
IHdpbmNhcC5wYWdlX3NpemUgKCksCi0JCQkgICAgbGVuICogd2luY2FwLnBhZ2Vfc2l6ZSAoKSwK
KyAgZWxzZSBpZiAoIVZpcnR1YWxQcm90ZWN0IChnZXRfYWRkcmVzcyAoKQorCQkJICAgICsgb2Zm
ICogd2luY2FwLmFsbG9jYXRpb25fZ3JhbnVsYXJpdHkgKCksCisJCQkgICAgbGVuICogd2luY2Fw
LmFsbG9jYXRpb25fZ3JhbnVsYXJpdHkgKCksCiAJCQkgICAgOjpnZW5fcHJvdGVjdCAobmV3X3By
b3QsIGdldF9mbGFncyAoKSksCiAJCQkgICAgJm9sZF9wcm90KSkKICAgICB7CkBAIC01MzIsNyAr
NTM0LDcgQEAgbW1hcF9yZWNvcmQ6OnVubWFwX3BhZ2VzIChjYWRkcl90IGFkZHIsIFNJWkVfVCBs
ZW4pCiAJCQkgICAgJm9sZF9wcm90KSkKICAgICBkZWJ1Z19wcmludGYgKCJWaXJ0dWFsUHJvdGVj
dCBpbiB1bm1hcF9wYWdlcyAoKSBmYWlsZWQsICVFIik7CiAKLSAgb2ZmIC89IHdpbmNhcC5wYWdl
X3NpemUgKCk7CisgIG9mZiAvPSB3aW5jYXAuYWxsb2NhdGlvbl9ncmFudWxhcml0eSAoKTsKICAg
bGVuID0gUEFHRV9DTlQgKGxlbik7CiAgIGZvciAoOyBsZW4tLSA+IDA7ICsrb2ZmKQogICAgIE1B
UF9DTFIgKG9mZik7CkBAIC01NDksNyArNTUxLDcgQEAgbW1hcF9yZWNvcmQ6OmFjY2VzcyAoY2Fk
ZHJfdCBhZGRyZXNzKQogewogICBpZiAoYWRkcmVzcyA8IGdldF9hZGRyZXNzICgpIHx8IGFkZHJl
c3MgPj0gZ2V0X2FkZHJlc3MgKCkgKyBnZXRfbGVuICgpKQogICAgIHJldHVybiAwOwotICBTSVpF
X1Qgb2ZmID0gKGFkZHJlc3MgLSBnZXRfYWRkcmVzcyAoKSkgLyB3aW5jYXAucGFnZV9zaXplICgp
OworICBTSVpFX1Qgb2ZmID0gKGFkZHJlc3MgLSBnZXRfYWRkcmVzcyAoKSkgLyB3aW5jYXAuYWxs
b2NhdGlvbl9ncmFudWxhcml0eSAoKTsKICAgcmV0dXJuIE1BUF9JU1NFVCAob2ZmKTsKIH0KIApA
QCAtNjQyLDcgKzY0NCw4IEBAIG1tYXBfbGlzdDo6dHJ5X21hcCAodm9pZCAqYWRkciwgc2l6ZV90
IGxlbiwgaW50IG5ld19wcm90LCBpbnQgZmxhZ3MsIG9mZl90IG9mZikKIAl7CiAJICBpZiAoIXJl
Yy0+bWFwX3BhZ2VzIChsZW4sIG5ld19wcm90LCBvZmYpKQogCSAgICByZXR1cm4gKGNhZGRyX3Qp
IE1BUF9GQUlMRUQ7Ci0JICByZXR1cm4gKGNhZGRyX3QpIHJlYy0+Z2V0X2FkZHJlc3MgKCkgKyBv
ZmYgKiB3aW5jYXAucGFnZV9zaXplICgpOworCSAgcmV0dXJuIChjYWRkcl90KSByZWMtPmdldF9h
ZGRyZXNzICgpCisJICAgICsgb2ZmICogd2luY2FwLmFsbG9jYXRpb25fZ3JhbnVsYXJpdHkgKCk7
CiAJfQogICAgIH0KICAgZWxzZSBpZiAoZml4ZWQgKGZsYWdzKSkKQEAgLTg3OSw4ICs4ODIsOCBA
QCBtbWFwICh2b2lkICphZGRyLCBzaXplX3QgbGVuLCBpbnQgcHJvdCwgaW50IGZsYWdzLCBpbnQg
ZmQsIG9mZl90IG9mZikKICAgICAgIC8qIFRoZSBhdXRvY29uZiBtbWFwIHRlc3QgbWFwcyBhIGZp
bGUgb2Ygc2l6ZSAxIGJ5dGUuICBJdCB0aGVuIHRlc3RzCiAJIGV2ZXJ5IGJ5dGUgb2YgdGhlIGVu
dGlyZSBtYXBwZWQgcGFnZSBvZiA2NEsgZm9yIDAtYnl0ZXMgc2luY2UgdGhhdCdzCiAJIHdoYXQg
UE9TSVggcmVxdWlyZXMuICBUaGUgcHJvYmxlbSBpcywgd2UgY2FuJ3QgY3JlYXRlIHRoYXQgbWFw
cGluZy4KLQkgVGhlIGZpbGUgbWFwcGluZyB3aWxsIGJlIG9ubHkgYSBzaW5nbGUgcGFnZSwgNEss
IGFuZCB0aGUgcmVtYWluZGVyCi0JIG9mIHRoZSA2NEsgc2xvdCB3aWxsIHJlc3VsdCBpbiBhIFNF
R1Ygd2hlbiBhY2Nlc3NlZC4KKwkgVGhlIGZpbGUgbWFwcGluZyB3aWxsIGJlIG9ubHkgYSBzaW5n
bGUgV2luZG93cyBwYWdlLCA0SywgYW5kIHRoZQorCSByZW1haW5kZXIgb2YgdGhlIDY0SyBzbG90
IHdpbGwgcmVzdWx0IGluIGEgU0VHViB3aGVuIGFjY2Vzc2VkLgogCiAJIFNvLCB3aGF0IHdlIGRv
IGhlcmUgaXMgY2hlYXRpbmcgZm9yIHRoZSBzYWtlIG9mIHRoZSBhdXRvY29uZiB0ZXN0LgogCSBU
aGUganVzdGlmaWNhdGlvbiBpcyB0aGF0IHRoZXJlJ3MgdmVyeSBsaWtlbHkgbm8gYXBwbGljYXRp
b24gYWN0dWFsbHkKLS0gCjIuNDUuMQoK

--------------z5MffjTrKipnKiv3pvMfm10y--
