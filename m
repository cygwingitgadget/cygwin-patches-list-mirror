Return-Path: <SRS0=luqi=QM=cornell.edu=kbrown@sourceware.org>
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c000::1])
	by sourceware.org (Postfix) with ESMTPS id 92AA73858D20
	for <cygwin-patches@cygwin.com>; Sat, 14 Sep 2024 20:09:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 92AA73858D20
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 92AA73858D20
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c000::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1726344572; cv=pass;
	b=uUd1NKwl2W+mU1zHPZWnPUUKwLgb0vsCfEuts/V/22c6z2N3I4Np3g0A3AVcqTmpYF3VWINmHCEAzRvflC2ly85BE/usaWQl0JQQ+bW7De7WzsSY4gCIkYceFWevUsEvt8B6KnKLbYXgSorDfOMB5yTWnmOr6koZt/YBhmFH5Xw=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1726344572; c=relaxed/simple;
	bh=sesBWxkDskHZf+x3fFinIPA09JTO6OtxQE6uUJGTpBA=;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version; b=L2L7DIIW0nVxQmCICILRhBOfVm7EMUYIU3m9khwfM9fHDCGrOFerklWJIiiERk8ZxnxrzZYA742dp7P7i9QRvAi3a5PesmYvVU4QaJpDzHkJd10ORnVqTpoHYsc+B2u1al0QzKMFBCyZJ/Mq0gOGsquqwPyku7KCc0HTHgT4lk8=
ARC-Authentication-Results: i=2; server2.sourceware.org
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZfdXGdeaeEPMyPhWHXkthNa6UdpeypwRIvi3PTWmI5PtfCV4ElLPjDQMzBLm0bi+3t6nRbY/iGz4sX734pDXXnpXyMtfEoT79Id/hNLJDlsNA23gu+8AtOIVC+y4hnJ225ApS0mcwe8UEzYcszaRygAT1hRVw9IsWEZ2VHJYxnl6dswTOFq1ja569RhGlTBLWo2uY7AX+RR17fYzs1rEvIoZyF87NzpTEOWqFBOMni3tai5evUVfwgfjxoD3903E2IXf75S/GelroGYPHXdAhEaU760bpJeCL5Z9JD2jJ8tjFUUKjuTZsQ1m+ZQ25Fl4eCr5R0uXKj/vXzw4g/9xvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1sv/hzVpXa0bb6uXQA8FwjNbyChb+tqLwQPSnt8fS3A=;
 b=q4RryDdiyQfBIhg5hfNGOGA5RchP0V7tgzKrwEgwuGRrlTFUJajU294sTKOKXTJkR7dEnp6Vm+67uhNZS+Dic+F1AOwjUbg1eV/pAUEpCdz3+5WB+c/wbvxpXFj8wVldOKo25KXjP9nQzjSh1ZMxRwWg4Sc7gDeXApYBfh+gchOWH2U+xHa+mS9n3NAxs/9rPSa1/p9zhs5SsRGpKt1+DpwfsewZ6S06bAMX3EfRfMm73/FsbAog2fBt/ZOSwizoOt2JuMC9XZRYcwb4GAL9NwvkkiiMYLPgDHZpAMz4cVIe0GheyP/ovlZys+VU5hmhtmIzBpdd6LMDP5e/X5F0sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sv/hzVpXa0bb6uXQA8FwjNbyChb+tqLwQPSnt8fS3A=;
 b=dJo/5xU8QSHLrZlNAhf9lvOX3oNHf9O1ZqIxzjNdaoOQTMTm0hpah13w2rJdi7OsVoJ2Rpz6pCyTn3LAS1r6+yGYvmhm0sDZPWty+CSGUHnbWm3ALDdPrTw1749/k0Vp05QqQfA0z2PuEQirh3FHM6587HI/hwXJelWGg6BlS2o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from SN6PR04MB5151.namprd04.prod.outlook.com (2603:10b6:805:90::25)
 by DM6PR04MB6987.namprd04.prod.outlook.com (2603:10b6:5:240::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.22; Sat, 14 Sep
 2024 20:09:26 +0000
Received: from SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd]) by SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd%6]) with mapi id 15.20.7962.021; Sat, 14 Sep 2024
 20:09:24 +0000
Message-ID: <d197495e-b91e-4cfb-bc5e-84fbea62e6cb@cornell.edu>
Date: Sat, 14 Sep 2024 16:09:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4.2] Cygwin: pipe: Switch pipe mode to blocking mode by
 defaut
To: Takashi Yano <takashi.yano@nifty.ne.jp>, cygwin-patches@cygwin.com
References: <20240907024725.123-1-takashi.yano@nifty.ne.jp>
Content-Language: en-US
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <20240907024725.123-1-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR07CA0022.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::32) To SN6PR04MB5151.namprd04.prod.outlook.com
 (2603:10b6:805:90::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB5151:EE_|DM6PR04MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: 43e395c3-bdef-4848-734d-08dcd4f920c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHZvODJmaDR6a2hKVWJ1SUZpSm9QVVJsdmZzU0VlMEk5WVlxSytWVXlWUXBE?=
 =?utf-8?B?YkxrUGY1ZHMxQjhTQjhTc0VTbWk4c3hyY0JLMkhEVXFFU3M3Vll5d09LaDFY?=
 =?utf-8?B?YVdoQnlqVWZvR2VTcCtES09ydTJsakRMNGlnL013dkpqOHU4S215bWJLUCti?=
 =?utf-8?B?dlZrby9iYXhFQ29Ed3NPL2hDaTNZMnRwWEE0SnYyRllXTXhvbXVkcU5WUzNF?=
 =?utf-8?B?RjAvMHlSU0d1VGxMMGxzSWRpSWMyM3JlNUhSajlZeHYwTCtVWmI2TDlPU1g1?=
 =?utf-8?B?akZmbEdpbTZxbVhOQ056OVRNTmxIWCttZWI1QnZsV2w5SWkwUUNhVkN3Mmda?=
 =?utf-8?B?eUJJUXQ4TlF6WnU4cmR4UVN4U01VTE5tSjlNTVI4dGY0b1B5V1FxaG1jTEs3?=
 =?utf-8?B?dEZ1OWx4YVlpOXhvNUIrNWlLbXBuR0Q1bU5mY0U2VUZXTVJ0TGtYd2ZjVDlk?=
 =?utf-8?B?ckJMaFo3bkxURHcvQ3ZWeXA4Z3RYd0ZIWTY0Y1FVaUpzaURNcUZySW9aTUFH?=
 =?utf-8?B?YklqenFLUG50ZlpQYnQ1NTVXR0EzYkRENjBEYms2OGpXR25Fa3lFOFk4aGEv?=
 =?utf-8?B?dGQvWjU4QmdsQ0t6Y2I2Z0hJUStTREZ3UmZHUU04S2hOZ2FYU05XbG42dFFZ?=
 =?utf-8?B?Y1pBN2s2UUgycGNWZ0NGcTJrME9zVGlEWEVseXY4emY5S2FiUDhWR1lTWXkz?=
 =?utf-8?B?Wm8vNnlHL2xjZW05L1UzeDFWKzZJOFI3cDJ4YW5MVG1rQXFENkVlWVV3eXZr?=
 =?utf-8?B?aFFGakRXMnpCQWY2Unl3aTYzTmxvUHNJamlXT01Sejc4cWN4Q2VpK2gvaFBw?=
 =?utf-8?B?Tm0xcE14MS9pZFRIcnhqQUtmcWdPV0hyTERHVTBydHZoVW5ORnFHM3RoWVRy?=
 =?utf-8?B?TFhFbFMzTDF1NzV0cXVnVjZ1bTQ1N0tWbnFHMnpIcjA4aFM4bmNqeDlIWEll?=
 =?utf-8?B?SVkrV0hWbEovcjg0WE10SmptTzF5Tmk3YWR0ZXZHYWYwTUkvR2xmYnR5MzVL?=
 =?utf-8?B?d3hsMk9aZEU5VENpeUNxa2JZQ0VzNHh1RDZSZk45UVVicTdwSDBRZVRKOU9T?=
 =?utf-8?B?N2pWbjFjYkpyNUdVWUhwUEZ5NFVNaGg0OCtWdW9BYVVYVFoxeWJ6THlYN2FI?=
 =?utf-8?B?WUl6R3UxZU9zMUN6Q1dzbWlFV0YzQTJ3ZmNPbi9LT1AvelQwa1A1MVFSMzRW?=
 =?utf-8?B?bjVhRHN4L0pSWUlsOXVEQThPZ0NQUk10OWl1WmZIcVhoM1l3bXIrWk9iVXZk?=
 =?utf-8?B?aTlNOHQ3RWRiMXJTcG9wV3Q0NEd5R1NtVWlFaGtZbHpSWmhnVEQvZFkxL1BT?=
 =?utf-8?B?MlpBTEQyMEl3WUI2amsxdXROVlZpZFBKS013RU5BRFIwRTY0UWlpcmlOd2xT?=
 =?utf-8?B?TEtjak9VYURqNk1JWFRhTmtLWW5lSjBPUXdJbXR6dHNXNFpZNEdpKzhpZHhK?=
 =?utf-8?B?Kzl3L3dhcVd4aUhIa3liclN4b2RpR2ErTkk0RUs2Q0RBbWxXZEFhbGJMOTJX?=
 =?utf-8?B?SUd4VFV1czloaUFwMlpJZVJ0VFJLRGxhWldOTmtQR3haNExSbituZDVFY3o3?=
 =?utf-8?B?MkVxQ0E2MFVvZllmeWdvQi9leXpUdW5sR0NqMXc2SUJMVjROUzV5bUZTcnR1?=
 =?utf-8?B?dWpDcDJxUjZFVWhnbS9zT3JIVFpFcWhqK1gwczRvMWdTT2czd3cyV0g4ODdk?=
 =?utf-8?B?VEtwNmU1Znk0MXlROFN5aVhySTgwWEtiTzhTYUMrOFI0TTVKaENEME5CKzJ4?=
 =?utf-8?B?QWRpM0Y1WklSdDBJSzdaWHE0SGJzbkFDbHVSeEhHYkFiMUhPZldVZE5uaDZm?=
 =?utf-8?Q?ELFNvdHDqrlrobUd42eO6pgBclj2AOhDXK4HQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB5151.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2dSRjByQktqd1ZrTjFNY1Z0TWxBTC9QbVhXZU1HQXBOallxcmJUWjFESUtJ?=
 =?utf-8?B?UnluZERoL0dKVWZvckdtOTRCQXRzeVpiOWZUclQ0TTNhWndFMzJvcGsxWUJM?=
 =?utf-8?B?ZDd1ZTMzd1VLQVFhVE4vZ2l2cEtBdGpjUTJTQzdvcXdLSCtGTUJVUHMzbTli?=
 =?utf-8?B?Smlpay9maHV3bWNTaWE1cnIzVFdBYWc0NWtIc3IrT0gzU2xadkw1NzVCcDZM?=
 =?utf-8?B?aVRFWDNicVhRLzlBWmEwdTl4WGVJeXRoTkppb2hKQVN3VVorYTl0elBuT3ZG?=
 =?utf-8?B?SHJHSHFtKzYxV3JsUlJjTmNoOXZmWUY3T3dJOXR6cFlLQmU5RTR6d080dldS?=
 =?utf-8?B?U2VsY3VublFKYU1IWnl4ajNVSjkyNXR6THl1Q2Zydy9nNGdtaTZ5QlcwUkFi?=
 =?utf-8?B?Yy9pTER3ZEdyNFMvQm56RktXRVhzaktYNW5MdTZYNEUvQTBkbnByNGtIR0wz?=
 =?utf-8?B?S1RTWWdKMnVhaFFuNWRHdW5RNkluZVZUaWJJTkRXSm9mWUZORlpLUFFmVFNO?=
 =?utf-8?B?YXpnY2dOa09TVlpaTHVoWUhhYmxZbWd3MzU3M1J5cnRNOEg5eTBCTm5JaWZo?=
 =?utf-8?B?ekZBSlV2am8ybUVBeGtseGVNTGhKRXhpczFWdDd0SXpQMHF2R2ZFeTBwcWRs?=
 =?utf-8?B?SU0xb2ZQT3p5MVpJbTF4M1lnRENBeUFBcm5OelIyTlZqTXU2eXYzNjJsTjhG?=
 =?utf-8?B?cGZ4c0wvTjhJYjVwb08wUHplb0w4TGhydXBxNHhTVG8vNW1UdDdKWGlmREly?=
 =?utf-8?B?ckVONHlnbE80a01JalBlNzQ4WCt3bVZDTWdPOUx4L1NkVW00MnFXdkt1Ukdz?=
 =?utf-8?B?Yk1UOVFBUGh5VWVraXFQR1FGUmsvdVlqQ2FnZDRNbjZiUGdoZXUwWTRySjUx?=
 =?utf-8?B?aGduME1Ba0ZuUGhmUjV2b2pyZDRvcDBJbytJTkVsamJ6d1g2V2VRS0xTbDZT?=
 =?utf-8?B?OHloKzgrY0JmNjJVdFg2ZGhHV2NVNTRucGZNcGQ5a3VlTFhodlQrTmIvMzR6?=
 =?utf-8?B?bG10NTNQSjBQM202ZjRrMyt3UVU4VkNza2h4emZuTEgwR3JGMUtVMGZxMjVy?=
 =?utf-8?B?Tyt4ZTNFOS9Nd1kyV0poUFBZa1ZUVllRSW0wNHVFTUcxUWNDV2FYalpLSDdY?=
 =?utf-8?B?amxVZjRKWVo2VC9PUjJxZXV4YWV3RlBXWkZ2YzJhQmRQRWNVQTVua3IrU2JI?=
 =?utf-8?B?SFNSd09ucXp0a0R6NDJhL0Vuc09pV0hJY2dUWE5oeGI3L0IybmxnbnUvSTJm?=
 =?utf-8?B?N3pFdFlTMm9vQm4yVUUvQVFKRW8yQzRxWkd1Z2xlWFJzb24zMFltVEZBbWRZ?=
 =?utf-8?B?RGRMQXd2WUtRNkVoYkpqLzFsQ1RJZkszTERUTmJlRUZYWmg0cXlSWURiMnNB?=
 =?utf-8?B?Wk9JUDRIYmpxSXVKSWtOMnhEQzhTQjBYT2t4T1FPUDFWNDY5bktoVWZhZ1l2?=
 =?utf-8?B?K0IreEhDTnNJRytvNENjME8rNGgxUW5ZRTFQR0ZQN3MxUmlVc29kYVZ0MFYx?=
 =?utf-8?B?dkJRNytaN2RjbFUxRDNjd2FEbHRMNmFrd01Sc2pKYWdQcklRUDlCMXp3bDNL?=
 =?utf-8?B?TG0reDdVVzErS01zQ3dzQUxyNDdZTzFIVmtpemdFV0FqcmV6aXEydlgyNklj?=
 =?utf-8?B?RGR6ZjhINGJBdDBNMmo0RVFkNnp6U295dUpRWWErWVIzSUlvMFpzZlZ3MVhx?=
 =?utf-8?B?NkVRN1lyRHlVWm1WcnljeE9VUXY0ODdCaXhaVnM0aVVndGtZZk1GZGVOeDhu?=
 =?utf-8?B?TkdxcFl6ZUEzUFVHdjBSYzN6YVU1TVovMmt0NmZaTjgrQm9hRHEzNlhITzQ3?=
 =?utf-8?B?Mk5Ed0dvMC9pcU9wWm1tT21wQVhUTndlRDI4QUNFV1J1cFNEbWo5ZXc4ZXVH?=
 =?utf-8?B?NUV4a2EwSXZjYVVnenp6d0xUbWhCK0NweVQ4L3FvMkx2dHlmVnNJVm1uZGZX?=
 =?utf-8?B?K2lrOVlOUitadWxtc3FlQjJpY09IZURsYWhqR0gvbnhOWUFEVlNXd0xUb2lZ?=
 =?utf-8?B?cHQxbU5uMllZM2I5R2lmaXUzU1lUMllKRWl6cng1VlVZVlUycEpTOE1CbVc0?=
 =?utf-8?B?YmwvN3F2WGE0VDhkcGQ4YUd4L09iWUM3TFF6SWNhWlhRdVRXdzR5ZW1OT2hs?=
 =?utf-8?Q?49B5oiZE/zU5FHV6w0w096TME?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e395c3-bdef-4848-734d-08dcd4f920c0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB5151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2024 20:09:24.2821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YXSVpe/7UtbvvLOIYryxMH85KEk7lT6VzT05Q7nZsTduYaS5hyYdP/8anB0xSovhC7fnO4Q4PqnWFH3OyFmyDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6987
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,JMQ_SPF_NEUTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 9/6/2024 10:47 PM, Takashi Yano wrote:

defaut should be default in the subject.

> Previously, cygwin read pipe used non-blocking mode althogh non-
                                                       although

> cygwin app uses blocking-mode by default. Despite this requirement,
> if a cygwin app is executed from a non-cygwwin app and the cygwin
                                           cygwin

> app exits, read pipe remains on non-blocking mode because of the
> commit fc691d0246b9. Due to this behaviour, the non-cygwin app
> cannot read the pipe correctly after that. Similarly, if a non-
> cygwin app is executed from a cygwin app and the non-cygwin app
> exits, the read pipe mode remains on blocking mode although cygwin
> read pipe should be non-blocking mode.
> 
> These bugs were provoked by pipe mode toggling between cygwin and
> non-cygwin apps. To make management of pipe mode simpler, this
> patch has re-designed the pipe implementation. In this new
> implementation, both read and wrie pipe basically use only blocking
                                write

> mode and the behaviour corresponding to the pipe mode is simulated
> in raw_read() and raw_write(). Only when NtQueryInformationFile(
                                           put the ( on the next line

> FilePipeLocalInformation) fails for some reasons, the raw_write()
> cannot simulate non-blocking access. Therefore, the pipe mode is
> temporarily changed to non-blocking mode.
> 
> Moreover, because the fact that NtSetInformationFile() in
> set_pipe_non_blocking(true) fails with STATUS_PIPE_BUSY if the pipe
> is not empty has been founhd, query handle is not necessary anymore.
                         found

> This allows the implementation much simpler than before.

Yes.  Great work!

> 
> Addresses: https://github.com/git-for-windows/git/issues/5115
> Fixes: fc691d0246b9 ("Cygwin: pipe: Make sure to set read pipe non-blocking for cygwin apps.");
> Reported-by: isaacag, Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>   winsup/cygwin/dtable.cc                 |   5 +-
>   winsup/cygwin/fhandler/pipe.cc          | 482 ++++--------------------
>   winsup/cygwin/local_includes/fhandler.h |  42 +--
>   winsup/cygwin/local_includes/sigproc.h  |   1 -
>   winsup/cygwin/select.cc                 |  25 +-
>   winsup/cygwin/sigproc.cc                |  10 -
>   winsup/cygwin/spawn.cc                  |   4 -
>   7 files changed, 95 insertions(+), 474 deletions(-)

[...]

> diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pipe.cc
> index c686df650..f99cbbc56 100644
> --- a/winsup/cygwin/fhandler/pipe.cc
> +++ b/winsup/cygwin/fhandler/pipe.cc

[...]

> @@ -339,37 +306,11 @@ fhandler_pipe::raw_read (void *ptr, size_t& len)
>   				       FilePipeLocalInformation);
>         if (NT_SUCCESS (status))
>   	{
> -	  if (fpli.ReadDataAvailable == 0 && nbytes != 0)
> -	    break;
> -	}
> -      else if (nbytes != 0)
> -	break;
> -      status = NtReadFile (get_handle (), NULL, NULL, NULL, &io, ptr,
> -			   len1, NULL, NULL);
> -      if (isclosed ())  /* A signal handler might have closed the fd. */
> -	{
> -	  set_errno (EBADF);
> -	  nbytes = (size_t) -1;
> -	}
> -      else if (NT_SUCCESS (status) || status == STATUS_BUFFER_OVERFLOW)
> -	{
> -	  nbytes_now = io.Information;
> -	  ptr = ((char *) ptr) + nbytes_now;
> -	  nbytes += nbytes_now;
> -	  if (select_sem && nbytes_now > 0)
> -	    release_select_sem ("raw_read");
> -	}
> -      else
> -	{
> -	  /* Some errors are not really errors.  Detect such cases here.  */
> -	  switch (status)
> +	  if (fpli.ReadDataAvailable == 0)
>   	    {
> -	    case STATUS_END_OF_FILE:
> -	    case STATUS_PIPE_BROKEN:
> -	      /* This is really EOF.  */
> -	      break;
> -	    case STATUS_PIPE_LISTENING:
> -	    case STATUS_PIPE_EMPTY:
> +	      if (fpli.NamedPipeState == FILE_PIPE_CLOSING_STATE)
> +		/* Broken pipe ? */

Doesn't "broken pipe" only make sense for writers?  For a reader, 
wouldn't this be EOF?

> +		break;
>   	      if (nbytes != 0)
>   		break;
>   	      if (is_nonblocking ())
> @@ -399,6 +340,34 @@ fhandler_pipe::raw_read (void *ptr, size_t& len)
>   		  break;
>   		}
>   	      continue;
> +	    }
> +	}
> +      else if (nbytes != 0)
> +	break;

What if the call to NtQueryInformationFile failed and nbytes == 0?  In 
the non-blocking case, I think you need to temporarily set the pipe to 
be non-blocking before calling NtReadFile.

> +      status = NtReadFile (get_handle (), NULL, NULL, NULL, &io, ptr,
> +			   len1, NULL, NULL);
> +      if (isclosed ())  /* A signal handler might have closed the fd. */
> +	{
> +	  set_errno (EBADF);
> +	  nbytes = (size_t) -1;
> +	}
> +      else if (NT_SUCCESS (status) || status == STATUS_BUFFER_OVERFLOW)
> +	{
> +	  nbytes_now = io.Information;
> +	  ptr = ((char *) ptr) + nbytes_now;
> +	  nbytes += nbytes_now;
> +	  if (select_sem && nbytes_now > 0)
> +	    release_select_sem ("raw_read");
> +	}
> +      else
> +	{
> +	  /* Some errors are not really errors.  Detect such cases here.  */
> +	  switch (status)
> +	    {
> +	    case STATUS_END_OF_FILE:
> +	    case STATUS_PIPE_BROKEN:
> +	      /* This is really EOF.  */
> +	      break;
>   	    default:
>   	      __seterrno_from_nt_status (status);
>   	      nbytes = (size_t) -1 > @@ -414,18 +383,6 @@ fhandler_pipe::raw_read (void *ptr, size_t& len)
>     len = nbytes;
>   }
>   
> -bool
> -fhandler_pipe::reader_closed ()
> -{
> -  if (!query_hdl)
> -    return false;
> -  WaitForSingleObject (hdl_cnt_mtx, INFINITE);
> -  int n_reader = get_obj_handle_count (query_hdl);
> -  int n_writer = get_obj_handle_count (get_handle ());
> -  ReleaseMutex (hdl_cnt_mtx);
> -  return n_reader == n_writer;
> -}
> -

Some of the changes below only make sense for pipes, not fifos.  Maybe 
we need separate fhandler_pipe::raw_write and fhandle_fifo::raw_write?

>   ssize_t
>   fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
>   {
> @@ -439,19 +396,45 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
>     if (!len)
>       return 0;
>   
> -  if (reader_closed ())
> +  ssize_t avail = pipe_buf_size;
> +  bool real_non_blocking_mode = false;
> +  if (is_nonblocking ())
>       {
> -      set_errno (EPIPE);
> -      raise (SIGPIPE);
> -      return -1;
> +      FILE_PIPE_LOCAL_INFORMATION fpli;
> +      status = NtQueryInformationFile (get_handle (), &io, &fpli, sizeof fpli,
> +				       FilePipeLocalInformation);
> +      if (NT_SUCCESS (status))
> +	{
> +	  if (fpli.WriteQuotaAvailable != 0)
> +	    avail = fpli.WriteQuotaAvailable;
> +	  else /* WriteQuotaAvailable == 0 */
> +	    { /* Refer to the comment in select.cc: pipe_data_available(). */
> +	      /* NtSetInformationFile() in set_pipe_non_blocking(true) seems
> +		 to fail with STATUS_PIPE_BUSY if the pipe is not empty.
> +		 In this case, the pipe is really full if WriteQuotaAvailable
> +		 is zero. Otherwise, the pipe is empty. */
> +	      if (!((fhandler_pipe *)this)->set_pipe_non_blocking (true))
> +		{
> +		  /* Full */
> +		  set_errno (EAGAIN);
> +		  return -1;
> +		}
> +	      /* Restore the pipe mode to blocking. */
> +	      ((fhandler_pipe *)this)->set_pipe_non_blocking (false);
> +	      /* Pipe should be empty because reader is waiting the data. */
> +	    }
> +	}
> +      else if (((fhandler_pipe *)this)->set_pipe_non_blocking (true))
> +	/* The pipe space is unknown. */
> +	real_non_blocking_mode = true;

What if set_pipe_non_blocking (true) fails.  Do we really want to 
continue, in which case we'll do a blocking write below?

>       }
>   
> -  if (len <= pipe_buf_size || pipe_buf_size == 0)
> +  if (len <= (size_t) avail || pipe_buf_size == 0)
>       chunk = len;
>     else if (is_nonblocking ())
> -    chunk = len = pipe_buf_size;
> +    chunk = len = avail;
>     else
> -    chunk = pipe_buf_size;
> +    chunk = avail;
>   
>     if (!(evt = CreateEvent (NULL, false, false, NULL)))
>       {

[...]

> diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
> index bc02c3f9d..9d47ff3b0 100644
> --- a/winsup/cygwin/select.cc
> +++ b/winsup/cygwin/select.cc
> @@ -642,7 +642,7 @@ pipe_data_available (int fd, fhandler_base *fh, HANDLE h, int flags)
>           Consequentially, the only reliable information is available on the
>           read side, so fetch info from the read side via the pipe-specific
>           query handle.  Use fpli.WriteQuotaAvailable as storage for the actual
> -        interesting value, which is the InboundQuote on the write side,
> +        interesting value, which is the InboundQuota on the write side,
>           decremented by the number of bytes of data in that buffer. */
>         /* Note: Do not use NtQueryInformationFile() for query_hdl because
>   	 NtQueryInformationFile() seems to interfere with reading pipes

The whole comment needs to be rewritten to reflect the fact that there's 
no longer a query handle.

Ken
