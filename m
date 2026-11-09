Return-Path: <SRS0=MMaU=I6=outlook.com=luca.bacci@sourceware.org>
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazolkn190130003.outbound.protection.outlook.com [IPv6:2a01:111:f403:d201::3])
	by sourceware.org (Postfix) with ESMTPS id 037EB4B920E7
	for <cygwin-patches@cygwin.com>; Mon,  9 Nov 2026 18:03:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 037EB4B920E7
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=outlook.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 037EB4B920E7
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:d201::3
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1794247423; cv=pass;
	b=F3Cd6HI3AxCT5RNhf4NmqpsJKUiiplhDxbzmgZn65b/BFXYhWSocXAXRXlHVpu/3Dfh6+kjaYXHyVyNrz73xtqPaX8GFlYSdVsXCmJNarwcDf/MzeVPGjrBtX+UtKTXD03yZ3EqSrULrOGuguOXEbUv6nKW4LmYABogCgzKhzzg=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1794247423; c=relaxed/simple;
	bh=001rE3+sTikDRQvRrRN6Jl7qzn4JarczHbJW4385Bg8=;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version; b=NFnsYWddHiT/FLDAgdyXrEAPfNdZ/NjWv6zaupj0DylTSkoYyUbqppW+VmVCHSjsDAPxDZFj6Url2eE5K/mEWkp25f2yv+L/e/5HmJTJubvAgRz14jLicKvSWnmKbJWuYWSkbf3X+1UNcz6xbCbB+NVJCdmwZ9kKnSR+uUMisk0=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=DcEkq+OY
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 037EB4B920E7
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=DcEkq+OY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJkyhs5EdQBA7ia8A/IJpQFmxldEzRl+xLtPTZQzuuwwyOatbG6Gf0+3x7k7NH2v/iWXu7AipfG979lkwD+Myr92rAuNy0pg5rBuZxsQCiCYQCJ4RNL03EUEd/3YNm0beS+hWsFRznCQSKzLpsKjm/43QQ/Cheu4gnWL1bHtuyV6JiU1/GMeiQBSntzbSB+MkOpP/K/Ax8TaLDYoymVN2/+XSLc+K/qFG1myczS75sz/EzMrP6dfCX1iOuRHoKcWzHolZcEP9+sOR1ou6km4rjbxuQ2LPaPNTxLiYxaFV43PovFH/V6Hl2ObBAfvIKxgx/FHUyz7VwaJRA/Gj88Zew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDwc6+AYJxvZf647r4nHOBYIns3k7MaYJDoSdIZRno0=;
 b=nRDGPLnhPIzlkmCanzB/FV9NpkTBQriq02+Fdk3BqYplKY34E/MKmDBYdXQXFYpwz4hDPPXISwr+1lbfMlsyVTvrnXtxsrVjpznAPmSNTXSYg8otxQNjgWgBl4DXJu1nCK9ZP3W5OEA5c4vEcEtBPEz304yEY2nfFeQkNN+Q/VHZnGspa6pufdMfKAl5HMMV0MffYUF0d/oHDxH2w29zWQ6tDPZyahicpSosVcN0uCbjSuL6lMcO8sxwnBB1cG2raA3pFrRk6TxO0HGAQUt54MIDRLffvbjwootBnmo2SCdphQH30gyuZNxJF74qse8wFVcAKbDUW3D7DeBpNc9LFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDwc6+AYJxvZf647r4nHOBYIns3k7MaYJDoSdIZRno0=;
 b=DcEkq+OYTBGPOJdqIzbqMoAVCkKRyq9ntfo0ZSSXQXNBQeS/8fwGy7Hs4MznDuqw7b6ho7hMXbVkQ09k5c0TtI4CE83j5Qq9vB16pWv1eZ6d/ooqchTdtyw5SscIfzBtGV1CMtxzJqRX4/1RkSe1maS9igeb2vXmuKXxtmELX3D6b6q+dXH0669mPPnB/kEaylLFovjOQZ6XFQ8vBhFhe1JdldDzWjRdV2CH7tJC2gYFIhigdChoONOnNce/cX2wiUmvyEKXC0c4l2pYSXGlOvCiTAl00W+WTgoGS7ekbzF37G1gssnM5srlIIoCQJ/3OwH8wTqrQsWm1Z/ngF7OWg==
Received: from AS4PR02MB7902.eurprd02.prod.outlook.com (2603:10a6:20b:4b2::9)
 by DU0PR02MB9145.eurprd02.prod.outlook.com (2603:10a6:10:464::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Mon, 9 Nov
 2026 18:03:37 +0000
Received: from AS4PR02MB7902.eurprd02.prod.outlook.com
 ([fe80::2a24:bc25:8b55:3de8]) by AS4PR02MB7902.eurprd02.prod.outlook.com
 ([fe80::2a24:bc25:8b55:3de8%5]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 18:03:36 +0000
Message-ID:
 <AS4PR02MB79028BE3080D8BF92F94261483732@AS4PR02MB7902.eurprd02.prod.outlook.com>
Date: Mon, 9 Nov 2026 19:03:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] pthread_once: Use acquire semantics to load state
To: Jon Turney <jon.turney@dronecode.org.uk>
Cc: cygwin-patches@cygwin.com
References: <40aee3ba-beea-48b2-8408-db28b9cc6770@maxrnd.com>
 <AS4PR02MB7902F8DEBCC6972D8C6BF34183672@AS4PR02MB7902.eurprd02.prod.outlook.com>
 <ea4baf13-8720-4125-b7b3-0d7f589f1162@dronecode.org.uk>
Content-Language: en-US
From: Luca Bacci <luca.bacci@outlook.com>
In-Reply-To: <ea4baf13-8720-4125-b7b3-0d7f589f1162@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI1PEPF00000D5A.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::491) To AS4PR02MB7902.eurprd02.prod.outlook.com
 (2603:10a6:20b:4b2::9)
X-Microsoft-Original-Message-ID:
 <c64d0809-61e2-4526-95cb-c64cd0649963@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR02MB7902:EE_|DU0PR02MB9145:EE_
X-MS-Office365-Filtering-Correlation-Id: 17829abb-1733-4174-c23a-08df3e8bc689
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|24021099003|51005399006|8060799015|19110799012|15080799012|25010399006|5072599009|6090799003|3412199025|440099028|4302099013|10035399007|40105399003|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFZId1VEd0tEL244OHFqcVUwUnR5T2tLZkN6alBFUXB1cmNOYW5TZTVBT3gx?=
 =?utf-8?B?MEMwZE9sTHl2R1ljM2RNZm1TaGZPU2twcFZHZi9NbkhWVW1hWE9Zc1FuTFRH?=
 =?utf-8?B?cXViQUJQK291ZnVrZGFPYVNkZlhIbHB1MUhNcGwwbFpnc2pzbTJiKzRCZGF4?=
 =?utf-8?B?VEd5dEdoSm9IemxqZGRXVERyQ0s5Tzlaa0tLSk9IVzIvTjB5QzJ6Tnc5VCs3?=
 =?utf-8?B?QmZoYTQyaHUxWXNIK1RTWEZ0ZUFmM3YvZ2wxeXdaSlNOYmxzZXJzaGx6cHps?=
 =?utf-8?B?b0hia3RHSDlXN1QxYUN0L096Yy8vRjkyYlRBUGtqZGJTRGtrQzNseVlSalhy?=
 =?utf-8?B?MWFJNDZ0d29ENWJ0R1lyUmdJcldwcVhBNzI0RDZvNm9oQVdiRUU4UVFMbmJO?=
 =?utf-8?B?cXZHNHlnbmxqSkg0c1g3N25XeFVXbFRKS0dGb2RiRUFFUE1XWkh6RFI0MVR1?=
 =?utf-8?B?MWNpbmUvdEVoZVFLSmtlb2ZRdHFYNU5zaTdtQ3ZOeUxWdUZsd2dVSForYWZ6?=
 =?utf-8?B?ZFJrQW5DL25pMVNmVkhqRDhyNE9CLzViWklnT2dwY3hSZ3pLVlBkb3RxSDlo?=
 =?utf-8?B?WG9IaWpuUW1UVGRPcHYvamphS0o3SFFCcVhwQlU5Z3RrN3FkSElOeHhsOGw0?=
 =?utf-8?B?eGtId3MvbmN5S25oV0pBbS9YYTlpZTNQcGpwUk9mVFNudkYwbC9VeXFBWjRo?=
 =?utf-8?B?bUVoY0xkMHYvRTFRN1dRdE51Y0o4dFprRzZCWUx5TFJEUWMwa0NPL3pnclJD?=
 =?utf-8?B?MHlYcTNET0w1aXF0c01Pb2NpWTR6UFEzUE5yQ1JmL25SV1JJQ1Q4aGhxTWNZ?=
 =?utf-8?B?dkcvSk9pYUFZdHk4UEt3RHlIQldNTXIvSVhySkE4cHBoNDdETERQZXdHMysw?=
 =?utf-8?B?YVN4aTZYeG0reGFlZXRlQkp4eFp0WWoxVHFKT3BQMUlkOG1vN1M0MTkrdVo2?=
 =?utf-8?B?RisrZVhydWFJblVPQ3RTUFpLRmU0UDZFNEhRQ29GcUk0YlBva0Z3a1drNmtU?=
 =?utf-8?B?Rzd0Sk5HUjg4MUh5VHJOSDhYQTluZ2U1N0lXWnlCUk44QWJ4YjZOQ0VLMkl6?=
 =?utf-8?B?OGd6Q2VObTQ1cnNjcG12WkZuYzU2TExhSUczK0RTQktXOVVJUjZZdENleG1J?=
 =?utf-8?B?Y0hDZmdTZHFndzBoTCtNRVAyZUpKNWFZQkxlL0dMZVVXeGdVMGdyd211UU5J?=
 =?utf-8?B?S1dlL25GSG9HZlpSeTJqeWVlRlBZSHpROEJoYnJGYXd5TjBJZ3Nsdk1Cd29W?=
 =?utf-8?B?cW5XMmZmWTVvY0hGK1ZzUU00WWY5L1lSSU9qZVJlRHNURGIvYlpIZ1Z3T2VH?=
 =?utf-8?Q?N928S5RgAP63ogomjtpBaBVeAMFp8RFD4s?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3lTNlhvRlJ2V1BJaHY1REdWZFFRcjhGRmtrWnR6cnB3d094Z29GN3pYVlcy?=
 =?utf-8?B?cy81UWc4NUs4TUtSREpmU3RrSkd0ZnRVcVlDUGJYdXZBYk1jd1pvbG0ydjhk?=
 =?utf-8?B?L3ZVU056ZjFRa29BbUJGM1lkYUZxV2tVK0lVeUlia2sxcjB6UnE2eHVnVlFO?=
 =?utf-8?B?T1czelJYSGVNRVlBdnVHUWR1TmRZR0h3aWFVNmtIRnRmYzNoRzFLYWs3YzlQ?=
 =?utf-8?B?cnpSZ1EyVWxLWFJ4WGtaVTNWOW83VWRyTXF2Q3pUS1pwQ1BNQVRUUWdGeklL?=
 =?utf-8?B?MWM1ZXIraFVHYlozNE9yRDJ2a08zdlRqcmVOV0FBS3U0QVduYit6citQeXFN?=
 =?utf-8?B?dUdVY0VESkc1N2twbUIvYkJYYUFTS0NuN0JROVBzejFTSEZSaWNiM3VCdW9C?=
 =?utf-8?B?ZEFjY09UT0FQQ0JkdmduRVhaNkFMTFJxblNWajZKV1cvMTVYSVRPZytSZTls?=
 =?utf-8?B?V2RYWTBQVUNMaEpDdDgwcSs4bFUvNlJEYmFxMkljZy9WRVdlVWZqR2FOcFRP?=
 =?utf-8?B?L0FlZlAwSHdLQ3NOS2s2TkJubjBac21ZV2hYSzZCZ2xZa2ovVVRTMWRQMEtT?=
 =?utf-8?B?TXR6ajBwQnZ5OElyWHNHelAybVVCaGpoeHF1RFpPbWtIZEk4VG94T0Npb2Rq?=
 =?utf-8?B?MXQwN3l2Tk9PUzVUcTZRWGloZElRSnZIS1kvaWlIbjMvbndoR25TR2lvQnM5?=
 =?utf-8?B?dXYzeTZpaHNwZExZdmg0elNkMURDeEVpeWxjVnRNRUJXZFBVcXprSC94YzBz?=
 =?utf-8?B?UVJ5ZWRjL2ZHaDdWZXlBekszekt0aDh6V28valZ3Q1p3NHJUV0x0TWY2VnEv?=
 =?utf-8?B?TjRDYldEenhDVU8rNXg2eU5lQ2kyNWo5ajlJamhoNFFKc3hGVC8wVjNTNTlE?=
 =?utf-8?B?ampoRE4rZ3NCcmxyQ09SejJERm12clM4TXVrZkR3Y3lFR3haNWx5bXRaVTRn?=
 =?utf-8?B?TzEwdnZLdi9OUUxPaUx0Wm4yekk0d25mS1pVc1Z1Uno1WGlla0NKSGFJalF0?=
 =?utf-8?B?ZlMrNXJRSGJsVkY5WG1OUWtEbUlSWEkyOHM3ZkN1TVhjMHd3R25aUVk1dWpK?=
 =?utf-8?B?VEVDNlZSVUNtSk5TN1I5YmZZOUg3L2F6TmdKaGZYR0RjZkJlWXpva2QyTmRa?=
 =?utf-8?B?WWMvWHkwTUgyMkFxSVZ2bjhsb3NqRG5JeVJSRTFmZ1lpQkt6bW5TeE5wck5K?=
 =?utf-8?B?eVlYbEtmTjk1YWlGc25vYmpnOUg5YXdTSUpSTGtVNzBJKzlCbkVqMkJBdDBt?=
 =?utf-8?B?bWJDQTY0cUVuT2tWWXZIdG9TWXd5RkJRN3RQUmtTY3lqMU1ZS0tNRm8xTlpV?=
 =?utf-8?B?VnBmeGg0UTY0Z3dEUzlZaGk3NUVCbmRwWWZmZ1ZYSllDTU5YR1JCQVp6UWxM?=
 =?utf-8?B?VmpaNjdSY095NXB6dWM5dnpZZ29BRFk4aXhhcm50SklGUW1qNmE0K241aW5i?=
 =?utf-8?B?MEtyV0FxUnlLN1E5WFVWR0tMa3h1MEtJMkd0QUVnNnBIWERRbWQ0cGplTklN?=
 =?utf-8?B?TEx1RTF4Q2xuaE1lSk9kSEVGTkFGZklaU254c2VDTm1hTjBzZUhPeEs4aktT?=
 =?utf-8?B?ckVDZXNzQk5oVU9RVGQ2WW5lRUdNNXVRQUcraWErRXAyZ204aDFzZ2JGRnBG?=
 =?utf-8?B?RVJvVGtWUHoyWWdocWFoYURjK2tQRk16WnhQZnlIRkpLaHh6R2hHZjN1N09L?=
 =?utf-8?B?Q0p5Q0x1M2FtaUFCeHJJOWg2eGc4dGR4WklJNkxIQkdicU5IWlVSMmhoejZT?=
 =?utf-8?B?YWZIOEF2SlJab0huTnV2dEJUNFl5aUhQSU5HRTZMYXhzcTQvZ3IxYzk4OUJ5?=
 =?utf-8?B?Y1ZVV1Z0SXlEU1JOMEVTTFVYYjg3L004Skx0RVROQyttQ2h1SVlBcjNXV0Vv?=
 =?utf-8?Q?+khVDIjNPgYX7?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17829abb-1733-4174-c23a-08df3e8bc689
X-MS-Exchange-CrossTenant-AuthSource: AS4PR02MB7902.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 18:03:36.8172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB9145
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GB_MSAUTHSOURCE_EUROPE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Jon,

Yes, looking back I should have added better explanations :)

The change fixes a correctness issue on weakly-ordered architectures. 
Considering the target platforms of Windows / Cygwin, that's ARM32 & 
ARM64 [*]. The pthread_once implementation uses the famous 
double-checked locking pattern (DCLP). The DCLP requires that the first 
read uses acquire semantics and the write (publishing the "done" value) 
uses release semantics. You can read more about it in several guides:

* https://preshing.com/20130930/double-checked-locking-is-fixed-in-cpp11/
* https://en.wikipedia.org/wiki/Double-checked_locking
* https://www.aristeia.com/Papers/DDJ_Jul_Aug_2004_revised.pdf

Currently the pthread_once implementation correctly writes with release 
semantics, it's just lacking the corresponding acquire-read. 
Incidentally I fixed an analogous issue in Wine some time ago: 
https://gitlab.winehq.org/wine/wine/-/merge_requests/9178.

[*] Technically could be an issue also on Intel architectures due to 
compiler reorderings, but in practice the generated code is OK there.

Best Regards!
Luca

On 11/9/2026 6:42 PM, Jon Turney wrote:
> On 20/10/2026 10:14, Luca Bacci wrote:
>> Hello Mark,
>>
>>> Thanks for the patch.  Is this to solve a particular error that you've
>>> run into, or is it the result of code inspection?  Either is OK, but 
>>> the
>>> answer helps us decide what priority to give the report, and whether
>>> more code needs to be audited to find similar issues.
>>
>> This was found by visual inspection while reviewing the PThreads 
>> implementation.
>>
> I'm sorry, but I find this patch very difficult to evaluate.
>
> At the moment the claim is "this is better", but the explanation as to 
> how and why is very brief.
>
> It doesn't sound like you've built and run it and verified the code 
> still works as expected afterwards. Assuming that... uh, has it's 
> downsides.
>
> A microbenchmark that shows a performance improvement would be a 
> convincing argument for this change.
>
> At this level, maybe you could show the generated code before and 
> after, and explain why the change is an improvement.

