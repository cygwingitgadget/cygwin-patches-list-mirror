Return-Path: <SRS0=Fz1a=T7=cornell.edu=kbrown@sourceware.org>
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazlp170100000.outbound.protection.outlook.com [IPv6:2a01:111:f403:c112::])
	by sourceware.org (Postfix) with ESMTPS id 635E53858D34
	for <cygwin-patches@cygwin.com>; Tue,  7 Jan 2025 21:09:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 635E53858D34
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 635E53858D34
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c112::
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1736284190; cv=pass;
	b=lAz3CAWING8A2QBO6fPx/BG7IsU2TgSb2IJDYBBSCYtYxOYLhGvFARdtFnqu1a1PmL6FHP41Ci7Drk3apQG3aQr+tRxO3v/HTo5sdhmg70BFnqTfafFoskfeTo1UQgP0/qZ7GCRRQM9ICT1m405j2gTvSu5it6kM8Zu1F6Wiwrk=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736284190; c=relaxed/simple;
	bh=yxzH5x4MZuunAdL3/l+nMVmWKkmn876/hp0UotSRvTc=;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version; b=PC3mJYPK4WbS2RUxTAr7r10QTxQ5Nx+uPVO2adf48kqRpVKnhx1jXtySuwXpBGE9xSvqkl2AQdOvuUfEWLkWyrtiMCjjwf22M7iT42ANI1VP1V3mI7WPuYjGYQRN5rh6jBqv/6Y7YrgdTNUKzEtMcMAR3YI7ZVQT7zrh9vf9KIs=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 635E53858D34
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=cornell.edu header.i=@cornell.edu header.a=rsa-sha256 header.s=selector2 header.b=ixDJ3kBt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hIFSnpRrNj6ePmWIWgiBdcnwzG//X4RpZBVQDXDG52pRGxCXO7AFZ9llnOl2xBaBF6L0GfsBjdVL30qS4eTQ1Aph+MicM5yQU1pe+kUya13pm2teVFIb17jPsWZCsGxMNibz5lyh0hC+KgjDKCzj710zfaTkgVQdBY3eWsSwK/iG7EQOFaWWawXVZqHheZnQLDxljuqomjGy9HVmePdRp/5VxSpuQs1V3kXgmaA8dgot35sxXS/iZ+3bwDQyEfI4ZrwP5c2KMK53QMcC327HrMqP9tZ01AwXc6igzSChp86615Xt4+mmRzai2eckkHAWZnBhnBr1i/igW4teJcw6rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xa1XEEz2wFiKlkT3zGWIRMV1pFFEvMzCjxEYTMwKjxw=;
 b=tB2CewlC7NgPu9E0nrAGijVyk7szceM58C1I5Hzs1el/P5yAp7yR7Cc8rzcl9F9isLRyhdywE3YvA9Q1ho4CGXa1pYaMUZnQCBcDwOJMS1jTrxuJy2XIwxkbPPXRUTTfZGTHbvqZr4ZmEosyE6Vpy5cfmPfpdORcxSusgrYD7baStSM0kpF9Ty6CNOgWUC/FapvDeCATrTNnhflAu7LiYwnjPMJg5rn5seVcxaav/63ce0oYfbRldLR8Pz3p+bZ4i7IWwWr/vGp/xZaT7Y2TRfPMoqqajUUgE8zsQP8gqGS58TRiLO/5pAaFXjgFJG5aXWpGHwI1AZDsfkVQV2p7Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xa1XEEz2wFiKlkT3zGWIRMV1pFFEvMzCjxEYTMwKjxw=;
 b=ixDJ3kBt4DY5uMLBEm8iEeJrJmYee43peDvosIYV7xNppUAGc12K6i0yvUzTA1LJxWQdLeeQrViPxX6pehEEJ6qFcZnoyD2zeLFwPmNTUYh/5a632ebZUv2LstNh9tubls/mFFbVS56aEuW/CCPgjdIA70mWZYjd5Ugvwm/b51Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from SN6PR04MB5151.namprd04.prod.outlook.com (2603:10b6:805:90::25)
 by PH7PR04MB8998.namprd04.prod.outlook.com (2603:10b6:510:2ef::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 21:09:48 +0000
Received: from SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd]) by SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd%6]) with mapi id 15.20.8335.010; Tue, 7 Jan 2025
 21:09:48 +0000
Message-ID: <58ad00e5-8082-46ca-8f4a-d07c83476e91@cornell.edu>
Date: Tue, 7 Jan 2025 16:09:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: mmap: allow remapping part of an existing
 anonymous, mapping
To: cygwin-patches@cygwin.com
References: <a9ebb720-13a9-4903-adfb-ca0ff9a4d82d@cornell.edu>
 <9b717926-06fb-4d34-a473-a709316de429@cornell.edu>
 <Z32MB5VR4vCszv9J@calimero.vinschen.de>
Content-Language: en-US
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <Z32MB5VR4vCszv9J@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9P221CA0029.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::27) To SN6PR04MB5151.namprd04.prod.outlook.com
 (2603:10b6:805:90::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB5151:EE_|PH7PR04MB8998:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b778c45-6281-47d0-76b4-08dd2f5f9e99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3JuS3NYYTJ1R2ZEVytCYVNUV1VZNVVOWUdTNG02LzVHZ1pQVHEzMTBNSHdQ?=
 =?utf-8?B?WXBPa2JCNkRjeGViL3ZNdU9rQTYvZDdkeGk4NTY5cEZPdUpDenlLZGQ5TEUw?=
 =?utf-8?B?MVkxSzdPank2ajQyNHpWMG1OQlpoZ1dGYk45dzVUT28rbzh6L0lUUnJVaUF2?=
 =?utf-8?B?VlZ0V3QyaldyeTBidkxCdGtOODFzWnIxOXFZUGFXcEQ2U2ZOWHM4eWl1OU5B?=
 =?utf-8?B?aytNVW5vd3RKNjlId2QwMFFPRWdxeWFmRG0vTzNvZGU0SHJmeUxvYndLbisy?=
 =?utf-8?B?bW9oVGtTdExmTzBxRjl1TVIxc3NhbXQxeXZBK051QzJ1cCtqVkp4eW1sRjAx?=
 =?utf-8?B?bFYvNjB5N1BqMW51UWFrWXRzdzAxS05EKzlQUjhYNmJ4dUN6RlljMjl6eGcr?=
 =?utf-8?B?bzRWdDgyMEQ1aFZqTXZNT2w5UEMrdVo1Nmk0MmpmOUVEY0grNE5mZS9GQ2cw?=
 =?utf-8?B?dzl3Ynl6L0FRM3ZSbjZBZHJFdzI4T0N0OS81QTR3WXhQZHJYNnJIbU9PR1ZR?=
 =?utf-8?B?RUcrSUFjK1JhUU1iaVc1cW5MaElGUThvc3pZa1BQRzkweTh4d2NYNkxMY1d4?=
 =?utf-8?B?b1E0a2xuV1ZydWNiSXV1MmU0dmVBRjJzc0Zta002YnVyVCtxekZVMzFyRkNo?=
 =?utf-8?B?Y29xaVFDTXFQVTUxQ2g2aWxCWGNRc2F0L1o3Wi8wdHdHSHNmUkUybFNWM0NW?=
 =?utf-8?B?MU5XTGRwZC9CUll4TWM0OHMyWnFmMGl2MUdFV1piL0RBSC94dXh2dk1qdGhT?=
 =?utf-8?B?eFNwT3R1aTJQSSs2YkQ4RnFlcjNPTU01bThhTlRycEdVQmpYeWJnME5nZFdW?=
 =?utf-8?B?enU3QW5OeFJLWEVpK1VFakgzQzl4dzUrZUt2VythMTMzYXl5TFo2c3VRUTdX?=
 =?utf-8?B?WG9yakFoMk5majByV0ZZa0JoNUVuUzg3VEVxWVpxejEvU0wzQXlRYmxQVmdz?=
 =?utf-8?B?Vkx3ekRCRzNGd0pDLzBockx4ZGhiYmw2ZzRDSE9UcG9NdENhTENLTm9SMU5C?=
 =?utf-8?B?OGRrR010R1pDTGNZcXJaeFdPbXVpRXpwQ0R5bjVpM2lhMzFzcy9zMGVrRlVG?=
 =?utf-8?B?TmhsUmJWbEozZmJVZFFiVkxWU1pVSTBYbERqUWRLTHhnbGovYWJtbXNjUUtn?=
 =?utf-8?B?QmZGNXVmOFFpZWdaaWJ0eUJzdzgxV0JlTGlXT0JObTdTRmphVTN1YyttcHIy?=
 =?utf-8?B?LzN0MDFSMmNZVlFwMkdBTVBYSWtXRDZNNVFRVXpCMXN2ckdBQkExTjU1eTVJ?=
 =?utf-8?B?TFlmRzdMVDhpZW5GS3VqL2w4c0tPa0E3Z1I4ZzQwVXJROXNHY3pMUVBwS2dl?=
 =?utf-8?B?Vkx5Q1FMSGRCaGYybVNac2JtUlJRemJvaXZzSno3Q0M1OHk1NnpBOUp6WWhz?=
 =?utf-8?B?blMrMFo4bUZVTjRVQTdzdDVrYS9RbWNRQXE3NG00Q2U0RkJpcG5tVVNFMjAv?=
 =?utf-8?B?SVVqZkpldGF4T0dYZGZKK01Ldll6Y3crTDRUTndGOUNpREFQa2x6OWlDOXM4?=
 =?utf-8?B?UWZvVmtLeVdwbGt4Q3RpWFAvMzM2RHBHTFhMUGhqVW0vdG84MjNLQ05jdUJC?=
 =?utf-8?B?MzIxWEJxWFRYTStqVnpXRXZHbmFER2R1MzQ2Y2pRbUcwUTlzMyt6T1VCbHJZ?=
 =?utf-8?B?eFl4M3dOazF2bWxkcDlmWXhwMitkY21DVlhWUHVRT25wVW8wMHZaZUxlVXR0?=
 =?utf-8?B?WnBJeUp5T2hnOENFODdCT1lzazR3SmRHbEY2bFUwa2RoVjJnRmJVUHNnUXdu?=
 =?utf-8?B?SXc4d0lRQUt6OUF4Wi9FN1VuWmp5VlVsajlVcFJxYVlZSkFKS2hCV2FIaVd6?=
 =?utf-8?B?TGFzRmdOWGNYb0pVNGJtQ1dPaDN1NGdIYzh3SGpTdU1FZ1lwdjF2bHUrN1Bw?=
 =?utf-8?Q?xPr1rDFJjT7/C?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB5151.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TS9DRmh2SzJYeWlkZmo2elpZQnpGY0JBTk0ySnovcElZOS9Ob29NT0NPbXU4?=
 =?utf-8?B?TVUzaEhvOXFmb3VNZXE1Y09KOUNXdHFQdWJFczNVK0NwT05rSDFGR0xmUGQ0?=
 =?utf-8?B?bnN3T3VzaWpLb1ZrVlNXZGtPQ1VSdTZ3dDdKb21vcXZYbExBT1M3OVozdlMx?=
 =?utf-8?B?d3lRVkxvcEgzamt5TTQzSGZhcjBRdjNZTnZnTlBsVFdBUHk2Z25uU1pmWno2?=
 =?utf-8?B?dzg5KzZvM1NBWDN4OWFzT0R2MndxaTJoQ1luSnFxMGE2QkY3ZDAzL3BTTisz?=
 =?utf-8?B?dzVMZlF6TFFGUCtPelhIdVd1b2RjM3NqVHhNSVhTcjBvbDBKOS9iU3dyRmFx?=
 =?utf-8?B?WFl4dmw2azI4bVpYSmlmaGZEOHc3aTZEb3VYOFJxVFN0bk1ITjM3QTVQditx?=
 =?utf-8?B?SXBjMldqU3R6WnRjeU5hK3N3NlRiU0RaYXR0NU5WM0FCTHdjVGZwTFRUV3Vm?=
 =?utf-8?B?QWV2NWY4VG5RTXRPc3pmNmVWNVZrZFBOaXl2UDVERzFzSHRwNUNWN1hHbE50?=
 =?utf-8?B?WkxwZFZRQWhrQUhLYkJ4a0dQYlRNd2RxWTVoMS9TTnM3WXYxUUJKYVpkNXd6?=
 =?utf-8?B?YmFtQUJWMGVWbXQzSUFHOVpoL2JsMVkrdTRqQXJENXd5WGoxQ2FyNXBsMmlR?=
 =?utf-8?B?MEJHVlpJS3FmKyt1dWRlaTg1bGg3bzFLTzdIenltc0plVmFZWjAwcm1IV1RQ?=
 =?utf-8?B?dHVlRW9DZWNpbk0zbmJRMWV2Vnk2aCtsYmpmeUp4ZUI2aERrM1ZuNjRScGhI?=
 =?utf-8?B?cEdmenl0Y2RKME1QTy9ONDZuQUtsNElSeGJ4aDk3c1dNcFRZQldIbmpIenRw?=
 =?utf-8?B?b3dzYWR6R3dkSWlCN04xWlZUNWVQd2dLcVFlTzVZenpLLzljTW9wN2pPUDhY?=
 =?utf-8?B?YjlCWVMwTVFLNFpWYTE0VzdHYzBDeENyMFk0VGN2d29jaVFGSDVUOGhoYlJZ?=
 =?utf-8?B?OGdmZkNzRTJ6eUN3aHhmVUtpZmRRdG45aGtEdTE2MnhITXV5NGNBT1NRckxm?=
 =?utf-8?B?Vyt5NnUvWEphN28zVHZzUUdrWGxQaENoOE5zN3FFdS9aWGdqK1B5RGNLTkQz?=
 =?utf-8?B?NTZ1NmRGZ0gzbloxb2U2b0NZMmMrNkYvUlVlU3dEZ0FGelVqbkJvTnB5ZVVB?=
 =?utf-8?B?Wno0cFJyVHB0RzVBUllFT1pBdUVuK1BvU1lnMGxicVNLUGdBQkR3V0lsRzFF?=
 =?utf-8?B?b1Qzb3JVVmpmaWRmWjlUUDhaY0RrR011UUhVMU0yajltU0pYSDJmZk4waDdC?=
 =?utf-8?B?dUhtOTRZLzQ0N0MzRFZzTDJUbTR3YldJdlNJTnkrZ2h5REpTSVRRa25lbE9n?=
 =?utf-8?B?NU9KQ3FrOG8wYmNEKzdwd1RXZEtuaURFM0NybHZBUXhnMnZxSi9lSmZ4UlFt?=
 =?utf-8?B?Q0x1RDdYUUtMLzNnRHU4UTBCaXlITXU5dUsxL1h5ZFBPOExQMGVQOGZ2d3Fh?=
 =?utf-8?B?NmRFNnpldDNKSGMxeXNMV0Y1aEI5ellpSFZUQnFLNCs5MmE0UHdmQzZCa3pV?=
 =?utf-8?B?NXRTWlNhK2Z0SlNRbHA3NFBNdG9mTlprdDBqM0o5aE9kOXlnS2x5OGlqVTQw?=
 =?utf-8?B?N1psemFtRDhPbEFRR2xSckV0ajJGSHJNRmZjL05aMVRuTVNPdGhmRFZsN1FR?=
 =?utf-8?B?VnBTMUdjNm54WWtsT1I2SFArSUlFd1h5T09FSnlwZ1ZCVnhZS3R5b01NZjAx?=
 =?utf-8?B?ZytoRU1RKzBQUmhxZ00yNTdFTDBKVVNKZkczTHBYNDlCQnBOZVU1OEZwR2Jv?=
 =?utf-8?B?V2xxa1YyeWlENXJqMllKQ1hiVzMrZHp2bWk3UzJjbEhiZUdydlo0bExYYVFK?=
 =?utf-8?B?RW1tK01FUHg4NE1oYk51b2tnTXUwSHZTUHIxNFJibTd0LzNpZ2p1TVFZMTl2?=
 =?utf-8?B?dVVBd1RFY0IrNWNlTDZkYkpjUXVKZlR4MXlEbUkxNWpXL25Nc09jaDRBbkdX?=
 =?utf-8?B?RVAxUlFaTkdZaitYM3V4SDlveExKRGswZDQ4Mk1kbEFlTWE5M3dDRTcxR0dM?=
 =?utf-8?B?TjFhQXBlV1NqZnFyaXYreW83NzkwaXRiTWtNQ1AveWt4RVB6UFVJU1NzTDRk?=
 =?utf-8?B?YmhOQnlsRDRIRC9aVGtQcWdiWW1VemIrZlgvbWpJcHVJVnFqVjZEQXhLazRi?=
 =?utf-8?Q?ybaRIgSoWTCGKOfECNK+/OsYO?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b778c45-6281-47d0-76b4-08dd2f5f9e99
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB5151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 21:09:48.6708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xuNnRw3KUz+oMaezooQlbqFJ/ySMl275JcZLzbnGrq3h+vKRPAfwsq0u69zcbUFow7xYY3GIF8i7IL06hXVUPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8998
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,JMQ_SPF_NEUTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On 1/7/2025 3:18 PM, Corinna Vinschen wrote:
> On Jan  2 16:42, Ken Brown wrote:
>> diff --git a/winsup/cygwin/mm/mmap.cc b/winsup/cygwin/mm/mmap.cc
>> index fc126a87072a..0224779458ef 100644
>> --- a/winsup/cygwin/mm/mmap.cc
>> +++ b/winsup/cygwin/mm/mmap.cc
>> @@ -494,18 +494,24 @@ mmap_record::map_pages (caddr_t addr, SIZE_T len, int new_prot)
>>     off_t off = addr - get_address ();
>>     off /= wincap.page_size ();
>>     len = PAGE_CNT (len);
>> -  /* First check if the area is unused right now. */
>> -  for (SIZE_T l = 0; l < len; ++l)
>> -    if (MAP_ISSET (off + l))
>> -      {
>> -	set_errno (EINVAL);
>> -	return false;
>> -      }
>> -  if (!noreserve ()
>> -      && !VirtualProtect (get_address () + off * wincap.page_size (),
>> -			  len * wincap.page_size (),
>> -			  ::gen_protect (new_prot, get_flags ()),
>> -			  &old_prot))
>> +  /* VirtualProtect can only be called on committed pages, so it's not
>> +     clear how to change protection in the noreserve case.  In this
>> +     case we will therefore require that the pages are unmapped, in
>> +     order to keep the behavior the same as it was before new_prot was
>> +     introduced.  FIXME: Is there a better way to handle this? */
>> +  if (noreserve ())
>> +    {
>> +      for (SIZE_T l = 0; l < len; ++l)
>> +	if (MAP_ISSET (off + l))
>> +	  {
>> +	    set_errno (EINVAL);
>> +	    return false;
>> +	  }
>> +    }
> 
> I think this is ok for the time being.  But since you're asking...

OK, I'll go ahead and push this, and then...

> When we talked about this last month, I already felt that the
> implementation is lacking.  Actually, it's missing two things which
> would improve MAP_NORESERVE mappings considerably:
> 
> 
> - mmap_record::prot flag, should be an array of protection bits per page
>    (POSIX page i e., 64K, not Windows page).  Right now we only store the
>    first protection set at mmap time for the entire map, rather than the
>    requested protection of every single page.  Consider this scenario:
> 
>      addr = mmap (NULL, 4 * PAGESIZE, PROT_READ | PROT_WRITE,
> 		 MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE, -1, 0L);
> 
>      /* At this point, mmap_record::prot is PROT_READ | PROT_WRITE */
> 
>      mprotect (addr + 2 * PAGESIZE, PAGESIZE, PROT_READ);
> 
>      /* At this point, mmap_record::prot *still* is PROT_READ | PROT_WRITE */
> 
>      /* This write to the memory region will commit page 3... */
>      addr[2 * PAGE_SIZE + 42] = 1;
> 
>      /* ...but should have raised a SIGSEGV because the page is supposedly
>         non-writable! */
> 
>    The reason is obvious: We only store the start protection PROT_READ |
>    PROT_WRITE.  So if we access the page, mmap_is_attached_or_noreserve()
>    calls VirtualAlloc() with the start protection bits.
>    If we store the protection per page, mmap_is_attached_or_noreserve()
>    can call VirtualAlloc with the correct page protection and we receive
>    the deserved SIGSEGV.
> 
> 
> - For mprotect() it doesn't in fact matter if a page is MAP_NORESERVE or
>    not.  It only matters if the page has been written to (that is, it has
>    been committed) or not (that is, it's still reserved).
> 
>    If the page is still only reserved map_pages() can just change the
>    protection bits in mmap_record::prot[page].  If the page was already
>    commited, it can additionally call VirtualProtect() with the new
>    per-page protection.
> 
>    We don't even need to keep track of reserved vs. commited, because
>    VirtualQuery() already does that for us.
I'll try to implement this idea.  Thanks for the suggestion.

Ken
