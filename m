Return-Path: <SRS0=LRyU=TM=cornell.edu=kbrown@sourceware.org>
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c105::1])
	by sourceware.org (Postfix) with ESMTPS id 519923858D20
	for <cygwin-patches@cygwin.com>; Thu, 19 Dec 2024 14:59:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 519923858D20
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 519923858D20
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c105::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1734620353; cv=pass;
	b=ikMKphowp3ib1rZ3xVob73STN9KRzaLjk0vECEqyZ7WDsDwCTjGIu/CZK3bnktCnjEeudrX8uBIh8UcQJXhSfwHsunU/Ky8S/m4OqBpa+Db3aBhrLbrdrgbRgcSjhuDzMqM/7AUO2nGUPNgXVktvtVcVoGvVJoVHTjzM/amL23I=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1734620353; c=relaxed/simple;
	bh=3DPVrfig2BMGDpIkplmih3hopYi9NOcv9R1PQ7zxQ7M=;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version; b=VX89X81Yg0xqMvlTEKY95qYPL4pPnJqh1XNa5aSzXaJwbfhAN/EHKB2GjCoojEhJU7F6AEwZJTMtRFbJtN0Q3tGfqvX5vM+Z0JvE1prVsIjdJDWL6vrfwjY2lRuwZXYMHgtNRJ4RJfTme8tQxCy0he0iJevij7KduEfVtT3qzuE=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 519923858D20
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=cornell.edu header.i=@cornell.edu header.a=rsa-sha256 header.s=selector2 header.b=QNPRPIXz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LljMgWe6hKv7nr9u63jKBjKziehgrNZbe0AfHVDKFd4YD8sAWrxFTuhlqgsyEt1jZDP822j61XfAiGDsSB2msP6V2QOj7aVBo6ZksHew9OhrwGudJIqYwglrXcyxCrvTBGB0zzV8XBXavqCsPfE4XiT0oO6oEHDFQ1sgw/EG74htq/1gpuV7MsWo0gz1YHnuy8w4yw3MavRDTBEt9HmKU2XiVBQGA4de6Gxijp1gEF5Awk1ACRQUD/EbtZp87KL8fQQ6emLz+3gL/uC4YEvwN7l2/JO3/BXQky2/fhZ7lFoyX+ywE4nWCvogJGSDcwLm9It6V1+XrNsbqM7HzKcFCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucHCOd8NaUbrVNX7aIoEUKSiaJ8L7oVSpq0x5uMKJy8=;
 b=AQuLeP51C02U64g6+fy+RPIrZTDjApsEEzQzSfMqd91PMqKxwNlWF+wV70Uc+INLtvSG8PRtpAA6gPUzQeJmJwFWigqG5bqgqCQeRwDgiq0239nxxnje/4N+wmElknTBtuNrLsKHRimz+TsWl0qTLP3ISr3nMbrxeUT9ZZjNPY4LxsiHdZprB2GCyqqkiBnJR5gs6oR6rbfuFxfyFn6qiiW09j6esyFdk56CWXeCxIITUIGIvmXYFdx642iKhTOxPuEZNfhq4SkiOrtA5tPZy+iLH07Gb2cunH5eRSVsz9/IltlJRUsC56l7+NG9asm7GEIr0OtFNqbPaEWswdBIHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucHCOd8NaUbrVNX7aIoEUKSiaJ8L7oVSpq0x5uMKJy8=;
 b=QNPRPIXzU9zCK80YANmjJKEtLipHi0TFtwqr/CJ0TOaHHQBT+jbh0tho5L5n6iDZAY/x/Ai8RK/NCCQ8L/roen47EH1HHLco77P+L1chc5/t1ZIQMpZKK86h/eTxqtrZrrCD18fQtB2Db8nBUb6nWvCMPU2PgGNIH1rVrGvLNcA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from SN6PR04MB5151.namprd04.prod.outlook.com (2603:10b6:805:90::25)
 by SJ0PR04MB7664.namprd04.prod.outlook.com (2603:10b6:a03:32c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Thu, 19 Dec
 2024 14:59:11 +0000
Received: from SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd]) by SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd%6]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 14:59:10 +0000
Message-ID: <c2b2c0ee-e848-4b1d-b41d-7568671b77e4@cornell.edu>
Date: Thu, 19 Dec 2024 09:59:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: mmap fixes
To: cygwin-patches@cygwin.com
References: <3c4f732a-52de-42d3-a6d3-7fea99a343ff@cornell.edu>
 <Z2PyzRoS2QeOrNem@calimero.vinschen.de>
Content-Language: en-US
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <Z2PyzRoS2QeOrNem@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0044.namprd16.prod.outlook.com
 (2603:10b6:208:234::13) To SN6PR04MB5151.namprd04.prod.outlook.com
 (2603:10b6:805:90::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB5151:EE_|SJ0PR04MB7664:EE_
X-MS-Office365-Filtering-Correlation-Id: 641f3a0e-804e-448b-884e-08dd203db1e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0RDMmxoVnU2YUdUdE80LytvSVdUVGl1MG9Ka2luSFp4MTJObUg2NEd4SDFy?=
 =?utf-8?B?SS93ZmRTdFZPUWdMSHNEMExuNjF3K2J6QWxNNTNhaHpIMlV5L2JBS3B1MUor?=
 =?utf-8?B?TjlmVzlIcFR1YmNPMTV0TnJ5bVcyV1ZpeFFLQkZpR1NnUDhaNjdITnAwM29t?=
 =?utf-8?B?ME12M1hBSU1WN2xCMTdOcWlaVHNveEU4N0JPQ01yU2NvajA2aVlvUzJuUHZE?=
 =?utf-8?B?QzJzNmhoVjl6TWxTQjlNYVNuaHRVTHRIK2NveXhHbkVzRkYyc2xsNjBXUTV4?=
 =?utf-8?B?NVNYK0NnWG9jOElTQ3lhck5JckcxdkFUTHJ0OGhCN2ttZ01xZWkzU0RNUHNR?=
 =?utf-8?B?bkZxdC96aTM4T0YrYTRrS0xnWmdVMXVwNEJXeVZLR0N3M25FYit0dm4xMGpH?=
 =?utf-8?B?UmU5MFluL0wrdUdrcEc5WGdRaGNUa3c0YWw2NFMvWmtET29lUEJWZHlwTmxP?=
 =?utf-8?B?dkRyWndzd3p0VmRJMnR0TTIrMXdEa3grMXMrRTFuZmVkd3Z4L29PNi9xM0VQ?=
 =?utf-8?B?Rkx5TG5vOFgybUZ1Szl5QzBVTEljTVZsLzdCT2hFM00wY2grRXR2TEFFZkVC?=
 =?utf-8?B?Y01aMHBuN2pXYW1iQ1h0UFNFTnVHdlozTURPNGpERjN5cjRrY0REWnZWNlJw?=
 =?utf-8?B?Yy90emdrWXR5bGN3SFVsVkN5TUdIK2JXemEzWDB0Y05GRDVYazRRRENWcFl2?=
 =?utf-8?B?MWRVZmRVbDRBSTkwbnk5b1Y4QjdBazlDYm1yR1hnNVNTR29aRGtjS2sybDE1?=
 =?utf-8?B?WmdxSEZoZnhUL21YTTRlTFQza1ZHak13cXU1MDdNNkZZNjlRMUJUOC9FSVVv?=
 =?utf-8?B?Y2g1UkE0N2FubUxmdlNoenRmZzVPdTUyWVU4MWozNHZ5OHlRQ2dmQkw1Z2tQ?=
 =?utf-8?B?bXR6K3lVZDRlSFVhVXJkV3NrWFVMNzdWRE5jOStGdnpsdVpyeFNpYkNLaWJM?=
 =?utf-8?B?YkJ1MGpaeUw2RGYxQ080Z0ZSeWtka3VCdVl4UnJxYVZUSHRpc1dGVnFUOGxD?=
 =?utf-8?B?MnZrQ2VIL2JzMXI5VXk0UHAySWxTWEpZSUx4YWpMQmIwZ3hOYXdDbHdvdXFU?=
 =?utf-8?B?THk0aFhRNWxxUW82YkU1OHFaME4xN08raWtVeHhyRUp2U3pxa3haZHUrS0Vu?=
 =?utf-8?B?WEhSaDJjUFlObnNzekpOMnNjcUx6d2VIQ1Jha1dwQkJXQ0lhNTBEVlJIeFZw?=
 =?utf-8?B?bmt0MytxWnluL0FmKzBFaDRJTTFVOWw1L0tYLy8yOE15Tno1a1kzbHBtZmpU?=
 =?utf-8?B?MkNMOEUrWHQ3Tkd0bTc1T1VwUGg1UjFxTHVKV01FRTE3MWlWNG43N0JaejEw?=
 =?utf-8?B?K0JLaW9YYmtHMjlyVDAwY2R6cXBaa2NKSUxzNmRRYktLL29HalFkYTRDVWMz?=
 =?utf-8?B?RGRCdm8yNmpnZFlrSU1VVkRzRjEwM0RWeUI3TGo0cC9KWVBueDRneHVyb05u?=
 =?utf-8?B?TFVjcGpVRlA0UnM4WjdhY0ZocVlkbGdMaVVSaFcxeEtDaGFvRmVoTS9mb1Y4?=
 =?utf-8?B?TFBxSFQwcFJwR3BJL1dIYVZmOE51TzVLTWF0MEc5VytocDZ1UFFIUGZRVDJs?=
 =?utf-8?B?M0EvZHBaQm1IMVo4V0RnQjhnQ05xTDZIS0Z5dnl6cS9pM01rVE0yQWVPRVJD?=
 =?utf-8?B?dXY3MXhjdlVGWjlMTUNHa0U5Q1c5cUM5OFZVR21KdFpBSDMweGgvOGJxR01G?=
 =?utf-8?B?cE91ZFNHRGxCaXZwY3hYVldSQm4zSXJmUjJnZ0VId3A5b3AvdStkcW5YKzAx?=
 =?utf-8?B?R1FvbW9UbFZlZzF5NUpNRkg0RnNJbzY1VDczR0tZUGQ1cEdrUmRZTm1CNW5s?=
 =?utf-8?B?Tkl6ZURjOEowT29SeEJDeTZYNEhQZjNVVTJBSjhmVTVRV2xlZGdSREdhampy?=
 =?utf-8?Q?QSFRiPxM4KOG6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB5151.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEQrYmFsVkoyN2ZxbHdHcWZ2aG9JM09HNW9KRzF5aFhWUXd2SVkyaUx0dWx6?=
 =?utf-8?B?MnJoV2creGlyUmQvTmVrbkwvcVNtRzV6aEtwc29Wa2gyZ3ZQR1ExQksrUjA1?=
 =?utf-8?B?UEw0aERsaWpMSnFyMy9GMnV4WXcyNDlteThvaDM4TmdmQkJDWEE3T0dDZHRx?=
 =?utf-8?B?UW1Fb2JWOWtUVEk5WTFEM21UNk4wbEtWNFkyYnRDVnA5ZHc3UVhnZVRXSitJ?=
 =?utf-8?B?YXI1UEZCckNhV2JVV2NYNGFSVnlJOFVlVEpuMzFFL0Y0WHFCWUxTalhsbEwx?=
 =?utf-8?B?aEtiM3RiTFdQcnJXdEFCRDgzazFMZGlXZk5STFQ0Tm5SZ2xtK3dHeXpVTWdO?=
 =?utf-8?B?cjBVMnJGdnE5YlJPK2t2dmY5dkZEeldJTXdIaFJPTHRzUEM3QXJvTXowME5a?=
 =?utf-8?B?ZmJPR3hLcURSa09iY1Q5Zm1CeHg1a01UanppMWYwRSsyQ3N4U0Uwb0MzSHJF?=
 =?utf-8?B?TENxVVIzZU5XaWdDeWp0MG5WMnJWU3A1TjQzSERtYUd6ZnU5dWJncmlJdWkz?=
 =?utf-8?B?NWRTWTNJSmkxUTQwejNhMTRrWUNIVk9ybEtzYVBnMXhSQ0Ewc0ZGRGFJd1dQ?=
 =?utf-8?B?aDhmYWo1U0ppdThJQUpidzdpTHdYWm8wMWZMc1FWTjhpOXcvMEJsWk9IdDg3?=
 =?utf-8?B?Z2Rsd28yUGRLK3dMcTFueXlMaExPejRHMUErd0NvU1ZDeEo4azRwNndScS9U?=
 =?utf-8?B?MHZKcnIxMmlDTUoxSHZwUFZ0bmtwNnNnOGdBdjRmMW4vOVZsbXl5eXk1ejVl?=
 =?utf-8?B?TTlVRWw5Z2ZJSUhRaXZjcndnU09jQzZTZ3ZPNGUxRENXVy9YK2VNNzlXcFla?=
 =?utf-8?B?NnpENXJvZ0NwVkROOG1KK2xtbTVEN3NnYmlwcHl1alJDSDNWaHh3WW9hSEdT?=
 =?utf-8?B?cVpmWlp3ZXU0emVBemYrZnRuMERXMW1Oek90WmV0dC9aY2tMbG1EeDBneGo2?=
 =?utf-8?B?NmJiWWovYW1oQWZDRXZXRzZlWDMyUGNrN0x3SE9PZktKRVE1UXJwbm5FSEpE?=
 =?utf-8?B?c3lwUlNTT2JhdDl4WGZ6KzhzanFFYTU2VWwwNXlRbEtzVFhMM3BGM3dWTHdI?=
 =?utf-8?B?a2V6NHBVV1E1WnlHT0x5RGVyYmN4Y3R2TC9FUkNWenhiakhtazViMytzR2JZ?=
 =?utf-8?B?OEUvQnhRUmM5SmtGRkgvLzFKMDlzSjVacDJMUEJvNXRtY3dzMWx6REh4VTFL?=
 =?utf-8?B?OHFOQXVQeHRzdU0vcGZQdFlsemRIcTRNNWR2Z0hPOTBKOGlFWjFLYkpTTHhl?=
 =?utf-8?B?NWVSS3hnUkJLbnE2SDQ0UTdVUUVDTFE2QTNTZXJMeGlOTnAzcjR5dVlFL3No?=
 =?utf-8?B?djYwb28yYUpFY29GZDkxRHljNVpHRTFuZ3ovRDRpdHFLRisvRmFaUXlUbzNq?=
 =?utf-8?B?eXBqNDFmMzJBTEZjREtWQk9SMkhFTGlGMnQwcDF2cGZ3VnRORVNRRkcycmEy?=
 =?utf-8?B?OVM2ei9MR0JBV0dkUUNaTDQvSEJXdlVyY0wwYy9QQ2sxb2F1SHdXamRkRXlu?=
 =?utf-8?B?OGpXR2NSbGc2bmVrc1lBM2dNTVJ5WmFoWHF5MTU4RUpkcjlIQ3IvK3dtZHlx?=
 =?utf-8?B?ZlRaYzNTZ1ZLc2RhS2ZQWVZadm5zSFM0a0tGb3Mvcm5JNlRsVWZ2cmhmcExp?=
 =?utf-8?B?MFVETUgvY0VuK290SG9wTzJiRVJCTzNia0lpS1FHK2w4c3JMOTJ3SnIxK1Iw?=
 =?utf-8?B?T1Y4dGNiL2cwREdpRmNpcHFWemFSb2NyVzdsUFJZaDNENC9pSWdTa3pFU3pV?=
 =?utf-8?B?LzZ6ajYxaHBYaTdtazNlL01LaXpIcjl2Q1ljeXNVdkdUQ1AwNWcwQjN5RVNP?=
 =?utf-8?B?WkNVUWtGZ204K2M0WUI3b2pNQVRGcXpwTjFHalU5T0p2a050RlNGcWQ4N1ln?=
 =?utf-8?B?bHIzT2V5ZDlHcjRpdTVFL1F3a3RJN08rcEZjNjJSQk13eUNiWU5WTW5YQ2FZ?=
 =?utf-8?B?N0xITEJJY2tOd003MGdkV3NCU3Q4dUNOTlhjT3Z0UU8xZ0FtWitFdm9YUFRE?=
 =?utf-8?B?L3NmY1hVcS9IU3BuRlFvMjg3WitsVjJWUndSQXFIVUZIY0FoRVdpMWZYRlRG?=
 =?utf-8?B?ZnJlUlRzazE2bE9relJGWW9RZ0xxdVR1MmVMaE1WdUdrbDBaWmdieGdvRTkx?=
 =?utf-8?Q?gv+R/f3TH2C1CaZ+/lxOmfZ1t?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 641f3a0e-804e-448b-884e-08dd203db1e1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB5151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 14:59:10.8023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j2vRu1P7q0qDTfelpIoO9LgGUsNuTps6fDIueP8r1RS2IX9MjJzVu0SSAsaT0r8xQwBf4mvfgH2oj9AgzCtlAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7664
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,JMQ_SPF_NEUTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On 12/19/2024 5:17 AM, Corinna Vinschen wrote:
>> Fixes: ??
> 
> Fixes: f90e23f2714cb ("*autoload.cc (NtCreateSection): Define.")
> 
> Darn the old CVS entries...

Thanks.  I don't know how you found that.

> The patch looks good.  I just wonder if the new argument should be
> called "new_prot" or "req_prot" to say a bit stronger that this
> overrides the old prot...

Good idea.  I think I like "new_prot" better, since readers might not 
guess that "req" stands for "requested".

> Anyway, LGTM.

OK, I'll push it with those changes.

> I'm not quite sure with the second patch, though...

>> Fixes: ?
> 
> Fixes: c68de3a262fe5 ("* mmap.cc (class mmap_record): Declare new map_pages method with address parameter.")

Again thanks.  Some time you'll have to tell me how to find those commits.

>> -	  if (u_addr > (caddr_t) addr || u_addr + len < (caddr_t) addr + len
>> +	  if (u_addr > (caddr_t) addr || u_len < len
>>   	      || !rec->compatible_flags (flags))
> 
> While this is strictly correct, I wonder if this shouldn't be
> 
>    if (u_addr > (caddr_t) addr || u_addr + u_len < (caddr_t) addr + len ...
> 
> for plain readability.  The problem is, you can't see what match()
> really returns, an intersection or the entire free region.  That's
> what I stumbled over in the cygwin ML.
> 
> This way, the code immediately tells the reader that we want to make
> sure that [addr,addr+len] is a region completely inside the region
> [u_addr,u_addr+u_len], without needing to know what exactly match()
> returns.  And it would still be correct, even if we redefine match().
> 
> What do you think?
I agree.  I'll make that change and push.  At some point it might be 
helpful to add a reference parameter "contains" to match(), so that 
match() can return the information about whether the mmap_record region 
contains [addr,addr+len].  That way the relevant tests can be done right 
where the reader can see what's going on.  But I'm not going to try to 
do that immediately.

Thanks for the review.

Ken
