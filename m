Return-Path: <SRS0=rAGI=UB=cornell.edu=kbrown@sourceware.org>
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c105::7])
	by sourceware.org (Postfix) with ESMTPS id 3D13C3858D34
	for <cygwin-patches@cygwin.com>; Thu,  9 Jan 2025 20:25:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3D13C3858D34
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3D13C3858D34
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c105::7
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1736454343; cv=pass;
	b=c3MOaRTnaXrie+wHMqZxIeGfq3VPivpgq7mwauRONsJ4DS+8Fhvh1+RHvmt+oe1xW93/Z69QjLPex7JidUDGW0QGNUvEFaSiv0/g7C7s5wr/vtPsB6xXvdQKygtZCsQnF6FkxAiNjGIr2ta9gRQJJYRZa0hlOLO25TqOVF3QbGg=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736454343; c=relaxed/simple;
	bh=u0KNuloeVlby0bJxrr+ACZ8xm4oc2NHFib/vjWO9ubw=;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version; b=CBEwMFGRSlu+EZ8lUsJ7Ps23sWhdsA/XPDsKrYN7GASmYZHAEV2VwCFdZORl4Fuon2i9td8R1pwY5ysJhHuXWQ72PPROCSOqySSb/0H8oyStrsdl3noTxO//4yE604H2WLEkaPVDGjxGPtKBHjNu5gBEtB26P52A6iSPjHH92vI=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3D13C3858D34
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=cornell.edu header.i=@cornell.edu header.a=rsa-sha256 header.s=selector2 header.b=MPwUYUGf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZanBxQvoWgNw6IhXDAi3zQuz9Ihx+mEiwSXKzPw5jSD4S+eO/wA7P4MVelmydz5oERIAIKI2syXJBDFZPzk/Am71ZRcjIlmken51Kay4NmLWDjOJ0E+nMFOimmQZSJN4+L8H4d+2LQEZfl8gqeB+lXrbCEdUun8mHBwn9Qgn/123irAToYgeC3ala2drJGaBqdNe16apUrxZVYKS0RecJVwXa0Gax12fHNYkC5Fn96GiUO5m5HPkvffaQzUxi3qTtOUqwvREpuYj/1drOoUpUCjjCVJ1JbdfCSx362ikBSQid5ufrTdzmmfWq4bUnFMePW9xOlDKgLVF5qgExCSaSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GtAaLUCaEk/CQ5+CS/wXeiKFMiEfDRBdXf5CMRu+KFA=;
 b=wynYKv9TJkyQvZBaO1REkv3NQ6pd0r+ajBaDzVcNL+DmRtD8vmSuigiEIaxiSrvUPYt57G5AxA02XgYkleL7X5nBLTqCUFtbsAOyejqMmF0CqAW0ZORskaJDgZHer472t8ILBhuYmNAVAviUhToEPXWS3xgrWA5sfi7iPhMFHK+N5TCOqM4Nwck7Vc8zz7ufE94KS7V8f9VVYvtfwUsaSuGgiw4WA1NVbshnmkBy6kvsDDMO4PSbHhSWyfY0756DxKBTpBO1FpzvC2sdMJkNg5dmwFfyZKolHCPz8KRYx8xwkiYa8s+tZP8VDc4C5SBBYDokTRNV4fV3YyZGwLwjog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtAaLUCaEk/CQ5+CS/wXeiKFMiEfDRBdXf5CMRu+KFA=;
 b=MPwUYUGfMfz4PSr7DLeMejkuTMsJkyYqj4JcrRdr4JwcXC5XiYYfBfEpLZ7KXlebqeXbNp87+DL3EPmOXpY6UVYLXZtz81EHx6VaoQrsX3D+mde918yMgXhob1HVyAOo0BUQ1tqinoOSqMvUX1PFMGaCa21Tytp/BKTbOoFa5KE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from SN6PR04MB5151.namprd04.prod.outlook.com (2603:10b6:805:90::25)
 by SA6PR04MB9144.namprd04.prod.outlook.com (2603:10b6:806:415::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 20:25:41 +0000
Received: from SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd]) by SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd%6]) with mapi id 15.20.8335.010; Thu, 9 Jan 2025
 20:25:41 +0000
Message-ID: <b80e5b71-9656-4b11-a95d-89c54be1c657@cornell.edu>
Date: Thu, 9 Jan 2025 15:25:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] Cygwin: mmap: remove __PROT_FILLER and the associated
 methods
To: cygwin-patches@cygwin.com
References: <dc8fa635-bc5e-4ef4-824a-0d2a73e838bc@cornell.edu>
 <Z4AcJx4KSdyMZ60i@calimero.vinschen.de>
Content-Language: en-US
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <Z4AcJx4KSdyMZ60i@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0121.namprd04.prod.outlook.com
 (2603:10b6:408:ed::6) To SN6PR04MB5151.namprd04.prod.outlook.com
 (2603:10b6:805:90::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB5151:EE_|SA6PR04MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: a161bc65-9a6c-4b62-5503-08dd30ebc995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ri9yZHB4VGJ4WXNGNEtPZWRHb3ByTUl1clZCRHlFK1hzZ3MySmZxTjdNZ2pG?=
 =?utf-8?B?SXo5Tjg5dDFoNU00bkdSOTVTU0F0T0lFaVlWMXFhc0FhamJRb2RWUWw4SS9C?=
 =?utf-8?B?QVVzNGljVDUxNURFcmVkY0ZydzVYSTlNN2hYcldKYnhhR1Ywd3QyQ0dsQjVG?=
 =?utf-8?B?QjRWZ0RTMm5lT3V4WjZCN0gzTDRWSktBTTZxV0I3aUZTWjdDZWp3QTg5VmpD?=
 =?utf-8?B?RHRTMkd0Y004ajB6RmlKdzJMOUM0bnFEZ1ZQb1RaOVhNbmJoQStydm9hNTU5?=
 =?utf-8?B?YzNmUUpybmliWTl0TUttelBzQ3pISHFKT2hlaFAzWDNHSUh6YU51TnBFWWhF?=
 =?utf-8?B?czhjY1hTMmJlclhpNDJCTTU2S2FZanNmZnJvMk1GZmQ0bmdseFRJbFVqd0JC?=
 =?utf-8?B?MWc2Mkp0eDhOeG1SbWZmYzRsd2JyODBhWVFlc0dWNFJHRTF3NjEwREpJeGlR?=
 =?utf-8?B?L0ZHcTZYdjNCOTAwN1dKVktncWpEd2MrMzN0ZWFlTEVnOXI2cjVvdDg5dU9t?=
 =?utf-8?B?bVFqZXhCUk1kcFlFMmc2MTYvenRVcnZkQjh0OThISmNNaG1VdVNmbWoxMGxP?=
 =?utf-8?B?clFnbU5MSHIrNHpnVVlyTEhYTHB5aTlJOWJFREFCRThVUDg2NysrbmJ5N2NT?=
 =?utf-8?B?R1NiRkNyejlzZ1BmaDJjMiszVTY1dmhsQUpJNFdSSld6TVFqb3l3M24vbE5l?=
 =?utf-8?B?M05ZSVhMbnJmSHplelhJQkh0bWZwMHFPVDl2Y1ZHL0ZNR3VBYmlKY1h0dEY5?=
 =?utf-8?B?UWU3bHZkQ2c5c2xvajVSY0NiUkRTdVZ3NUF0RndoejV4RDQzWG5KYUVNK1RV?=
 =?utf-8?B?U0F2NFdPZzE4WDVxdkxVSTJqV0xBSzk3WXBEWi9ZRHJmQnJoeVhtTXFVdXli?=
 =?utf-8?B?a3RvSDNPOTNaSVJxNGw2OTVZa0xHTXVSZ2hKZ2l5YUwxdGZDR3FTVXpWVjZl?=
 =?utf-8?B?dDdPQ2hlSXFKeXhkejFyQjRUKzRTSVR6UmNHb0Vlb3NqWmFEWUk1bkJRakln?=
 =?utf-8?B?OWJWSXVvb2tyQXkvdVhydXFZSW01QXBuNmdvMlhIUUZ3VVl6OEFRd2h4ellG?=
 =?utf-8?B?R1FmWmFkTnRjMWxtaFAzNjMvQnRHTWg5ZTFoT0FKYWJpaG5LZlZmWDVkOVMy?=
 =?utf-8?B?cmxTYnBvVGNtRis4YWhwQ01LYXZoVmEvcW82Q010SmtQekkzZWt5U1lxajR4?=
 =?utf-8?B?VEV3cXZDa3dKUGpkM0ZkV0MrV3QyZk5oZ0piVVJxQVgrNFBhY01kOTkwbmY5?=
 =?utf-8?B?V3hOSmw3NWhDVndmRTk0bnJKOXZIYjZHYlRSWHFRUVlhazk1MEkrVzNud1k0?=
 =?utf-8?B?c2hvMDJrOXdnRWFUWlFnMGpwa2xiQ3M3WC92aEh2VGZVeStJUVJ4V0FSOStr?=
 =?utf-8?B?bS9iWVdQQkFRcENWUWt2WWdLS3p4emREZFBTOHJPWHBqMnB4MmtFWGZ0QTFV?=
 =?utf-8?B?cXdGZVRhRkNsT21WczQ2SHgyUVh6L0tYNnN5cktHUVVYT3R3aTVXM2pHMmw4?=
 =?utf-8?B?cjM2MjV2RWk2MFhBZElGWHhXM25CVHlLb1REYXM3QWoybE55MmxDZlRISXlx?=
 =?utf-8?B?N2RaS1ZFQVpYOWMzWnpyMlY4UzZ3cHdQRFp5MmFjb1JNNkR0TUFZemNqY3Fq?=
 =?utf-8?B?dXpHemZ2aFVCbzF1U1lyeDJTVHk5ZFdseXRxZFlsc3BhaUpvaUNLRUVHYlVk?=
 =?utf-8?B?dDEwNTJORkVQQnEvaU0wWHBTYnh5OURkMElla1RTMCtUL203YWJVUVJ1bGlT?=
 =?utf-8?B?c2ExSUQrUXB1R3lsRXB5MkViSVBYUFN1VkNFdERVeDl5czBYeEtod3ZsM3FK?=
 =?utf-8?B?TTRyMnJ5dGdpVFhkdDlKRXVmYkh0Sk92MEZNS2JpL0xqTGh5MVhxZENaUnVL?=
 =?utf-8?Q?IZOqzI00OqqOO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB5151.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHFMU0JkM0FWRElERU4zeXp4S0ZJNTFSNFRlb1lJYmF2bStNSFloL2tpN3g3?=
 =?utf-8?B?OUtRMVpsR0JKSkdoNmFaWXBSRDFjM3I4Vmt5WGR4WitFMnkzdmk5UnpzUmo4?=
 =?utf-8?B?MHpNRGVQUTFRRGprbGZISUkyQVpNOXhXRGN1UTM1ZTZZYktSaithREkwNTkr?=
 =?utf-8?B?L2dEUFZiY01QV213ZWRVb0xaOEQ5M2xWRWVRUmliUnQ3Z2dvVXN4SElMTk15?=
 =?utf-8?B?N0UxSzNUVzBkQXlTM0NONWhGWnREZzNpMjNXUGw2emJSSWhNWGpZcG1aMVBP?=
 =?utf-8?B?TTM2OXZYUXJxYWw5dWpYcUNTV0RhcTBMcldhcms0eW93WElpbkR5UTFJajg3?=
 =?utf-8?B?dERkOGlBWU9YQmlEYUFBU2JYM0xYVjE5ZE5lVnoxYWQvV1daMHhaYjRqZUpZ?=
 =?utf-8?B?RVRtVExndy9wOUxaM1JXUFFlSHlLaG5LckdabUFyellldGk3TjlSV1k5Q0Qy?=
 =?utf-8?B?cTUwZFdqc1g5b3FMN25lTUo2dFZtS0pyYnhZSWFIRmZzb3ZXSmptdU00bjQ5?=
 =?utf-8?B?KzRVTUxBL24zUVJiT2FBK3R4OEpxUXJuYmh3UVY1aUxETmtnbVdIWFBXc3h5?=
 =?utf-8?B?UWw1WjVsMGg5NzRhcDd5ZFdCbElzdG5mQ21UVGNsWnpaMnBDRWhTWXpFMUxC?=
 =?utf-8?B?ZFZtU3JkdCtkclZrZkE1bGRBS2lKTCticVNBKzNvV0lMMDU0SkJiNVFBbisv?=
 =?utf-8?B?cVJvV2ZqU3Y1UFRqQ0t4RWNKcmxudDVkb3ZOYXpxdDJSaWRLRWE5V2trMXNu?=
 =?utf-8?B?YUtSWGNiY3FzWWhzemk3UGJqS3BFSmV4Q1FPRTJFQi9waHVwUm9mRDlONjZR?=
 =?utf-8?B?Mi9TSXdMeWNTVFFhd2xWTlBpN1BEdmRqNmFhSG9QSDF0UDJaQm1nR3Y5N1E2?=
 =?utf-8?B?TTZxcFJ3cWlNRFpMQWRzQVdHRTYwZmV0MW0xWVkweFZjbmdoVUVHVmhoem01?=
 =?utf-8?B?SStia3FFTnFYMWkvMkt4MlNVcDBESHJnUXRoQkJkajE0VVhaMTQzQlpXMWFy?=
 =?utf-8?B?WWk2aTQ5YS85Zk1va0VXUkZtekl2SEpnVjVsTUdPWVJ1Y1ZTTnpCTytsN3Bo?=
 =?utf-8?B?TXBuU3BHeFcyUno2M2FQaGYza1U1U0wzTUxiaWl3c042QTNOOXphdGJ0VlRq?=
 =?utf-8?B?UjNGQnNKV0hrOFE1K1cxdFVHcG02S2NIM01qbzJydTg0QlptaklwcnNSRXI4?=
 =?utf-8?B?ZVlMVkQ3aWpWMldKN3pBVGFvOW5KZTZra1E4WGNlWFJhWEk2UDIrTUV5aFZR?=
 =?utf-8?B?UlNkQmdpbFMvZG1GbjR4M1g4Tzh0QU1sejd0bDVWVXpMREVGcThYZlphdG0z?=
 =?utf-8?B?cHNuTXdZc0wvV3pUNHNvSm43c254NXRnZm1Hd2I2UUNTb25NaEdlTDVFbVYy?=
 =?utf-8?B?eG14NnZxYWVoY0xObkllelhPYnh1MUZxZERhZnp2cTlrZmU3aVN1dnJ4Ri9r?=
 =?utf-8?B?ZVQ2VmRTTDRDVnc0TkYrRW0rUFZZcmJ6bmJ5M2xZZUU5TUI5Wm53aXNNa2xa?=
 =?utf-8?B?dFJxYm43V0hhRnZycVpwdVB4b1RBWEExWk9yblFYUVVPdHh6emlRclNLODBV?=
 =?utf-8?B?UUdHTDc2bDNwQ3FvREJBeWJOSTh2VzZnei9xVi91R3pNd3FYbCt5TEZMclly?=
 =?utf-8?B?cHZodnh2eUp2UHdJRnd2VG0rMWpwZ3hQWmJodlU3eDlWWjNMdEFBLzFpeGF3?=
 =?utf-8?B?UVl5djlSU3N5N2h6U0RnQVhaRXJ1UHVicWdLV3NyK2JMaFZTRExKUVBSM3FM?=
 =?utf-8?B?V1lDNGdEeHNnc2U1WGVOY0s5UlkvSEJ0S1hZbnlhUTkyNThaeCsyUENVU1lW?=
 =?utf-8?B?dUlDWG0rdGtLQ2RMS2poRHNmd1FwSlBsbUhBeUhYNTRnYnBTR2lJZVQ4UURO?=
 =?utf-8?B?WU9kT0FjOFRxTnphRi84MUZaUE9IdHNKZ04zUG05YkVEOWVDQzlPZWlWRC80?=
 =?utf-8?B?WlFVTllXRkkzUlU0OHpVZDM3QXhmSWZQNEM4N09TSzJ1dkVxQnJLbXVINlJw?=
 =?utf-8?B?OE1hbUVnSXB0UTRFT3l0d0VabHgzODBDY1lmK3grVVRRWDVQRkdzUFBabThD?=
 =?utf-8?B?dEpQelJZbE1OOEJSQXlnME1EdGh4YzRocThyblJaLy9PRWNhMk5RczVuSFo1?=
 =?utf-8?Q?vMvTuIKBZziDPsgh67BSAtL9w?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: a161bc65-9a6c-4b62-5503-08dd30ebc995
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB5151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 20:25:41.5579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XHpjTAnYjAKvUSrFko1fXLSw8kbJn9GjmlVjGEqrmwH3LtDqSXxNgO0TS3SMof5kuTUmJ9AAuFKGMIhXCp0Arw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9144
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,JMQ_SPF_NEUTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 1/9/2025 1:57 PM, Corinna Vinschen wrote:
> Given we don't do filler pages because Windows doesn't let us anyway, we
> could switch to 64K allocation_granularity() bookkeeping now, too.
I'll take a look at doing that before I try to implement your suggestion 
about maintaining per page protection in an array.  I've got a lot going 
on at the moment, so this might take some time.

Ken
