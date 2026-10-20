Return-Path: <SRS0=dZds=IK=outlook.com=luca.bacci@sourceware.org>
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazolkn190110001.outbound.protection.outlook.com [IPv6:2a01:111:f403:d207::1])
	by sourceware.org (Postfix) with ESMTPS id CFBFA4AA29BD
	for <cygwin-patches@cygwin.com>; Tue, 20 Oct 2026 09:14:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CFBFA4AA29BD
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=outlook.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CFBFA4AA29BD
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:d207::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1792487697; cv=pass;
	b=P/u5BBV03VkvCf9t8w5fuy2C7sBTt4aKaAGelthbvSSXFQA99vP8EY1GfikTHA+vI4BN389c/DbIkPi7+n0KicdYajLqYn/EQ38v9QHx/X/K4pbIxnYax5dGGCXjjbJA3VyzxLFJnVi1cwK9Bsxih1F1aG/pH3RPf2QH6bisca8=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792487697; c=relaxed/simple;
	bh=GYX+/sxqCwYafgZ+6DauBdr7dWliL+UkTBo/QPwauDs=;
	h=DKIM-Signature:Message-ID:Date:To:From:Subject:MIME-Version; b=LNQ6MnCabUovpn5k+8wTLPImpoXip7fRqBb4gmnVGymUPzQbhDnrUI82yY3GlhJaayZm1Ne9DAmPhHu4J/3SdY8YNXlU1UJ+kmLD44ZkvHpgr9RTM2v94aihEaBdNJH9CNVvAMLSCvEEQAvhLZPIROQI1rQkzxQ+0wdW/wKJGms=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=SsfJ29l1
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CFBFA4AA29BD
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=SsfJ29l1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQT5pO3DCOUTHdSNAftSSC38WL0i8Hww0rKe81Ah4KUqgAXa+5rMaSI3hCrjNo4YohDmZ+skspRSsJvkrJw2/JXb+M+PFIUs7y3Ns278vvk2O2VXxKChjvQPiF0bMFhjxnWW+wW9gElnddcoQ8Uf6p7oUQxfkEzZh/dERZ245H9ZQ5zNnNrOGXZ5C4Pldg+Csh3NQwoYY27bZqKSyW2e0NBekp4d3NpkOrHYS8iOZEJLNNm6LCEzm4ixGF3XR/LQz1vDarpy09/euXkA7+FuEKc8ptgYWs9rQ/T7EgdMKOqvsGK6Wvg4Wh0XkJORWpoL8iTVN29TzMJQ3RRYKPElfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnBukxu3oYD3TlX09owCH0+XWjqiXGlRj0vsAG5BduQ=;
 b=HkRNmIEyghl2xIDFqSSLGfqkyig5pmPeOlMBbjqGX5Lkc2ot6+qTV9cXkl+Ea0k5n3sfsQNm2xt8hw4mIgRu9FiZzaETn3F7BanvHwiqD9oq1InrBAIJ5uVsbY8IAMVSAwmfhEoBODLunEPhBTViu6Qr2kCvPzPAN+M/k/C5QBPBcFe5lvts6SOKIuDzcnZiWY5dlRPal+0KKuHWrlD5Q47BM0G4Y84i8qde3ur+loRHjMS4xphXy2wEFF5SUU1+sROw5lFNj591sgK0mx4bRv63aLPj5az9NbjuL3lXPK0qEVZ7rEuxtznB/FgJ/lA7iwfiIcQdJCj3uLq/gNOB9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnBukxu3oYD3TlX09owCH0+XWjqiXGlRj0vsAG5BduQ=;
 b=SsfJ29l1rSu9x87pNA3ZrkAv93XQuYMRrsMC2+rdx/ln8zSjcSAuWREWpjXQPtSNQawB50EvlX9mgRCWH+2wbbWFAev7lESVtYixdQx27yQxeRKEhZmXQ0sJBo8wbWNhWrsTbnKO2OFYFQz8edsP98sSmf4dTBGfXu9+7GkThPDruEyO0MxEwjGP5XM2EsDRnVnsrnCOaTBcqhUI6Dxx+30iSLOCwhhDn4POI2yL/6EvagvXd3UtICUV6iq5Qildlc2WVC5qbP2n2trH4aP1TmNTT7VEuWrqiMws4o91wos7Fh94Vk4dsapavBoGFzlQYLmX3BB2STG+KVyhQjTq9w==
Received: from AS4PR02MB7902.eurprd02.prod.outlook.com (2603:10a6:20b:4b2::9)
 by PR3PR02MB6363.eurprd02.prod.outlook.com (2603:10a6:102:5f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 09:14:50 +0000
Received: from AS4PR02MB7902.eurprd02.prod.outlook.com
 ([fe80::2a24:bc25:8b55:3de8]) by AS4PR02MB7902.eurprd02.prod.outlook.com
 ([fe80::2a24:bc25:8b55:3de8%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 09:14:50 +0000
Content-Type: multipart/alternative;
 boundary="------------A20wDwSKOmcQoBdgawhni4L5"
Message-ID:
 <AS4PR02MB7902F8DEBCC6972D8C6BF34183672@AS4PR02MB7902.eurprd02.prod.outlook.com>
Date: Tue, 20 Oct 2026 11:14:49 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
In-Reply-To: <40aee3ba-beea-48b2-8408-db28b9cc6770@maxrnd.com>
References: <40aee3ba-beea-48b2-8408-db28b9cc6770@maxrnd.com>
To: cygwin-patches@cygwin.com
From: Luca Bacci <luca.bacci@outlook.com>
Subject: Re: [PATCH 1/2] pthread_once: Use acquire semantics to load state
X-ClientProxiedBy: MI1P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::18) To AS4PR02MB7902.eurprd02.prod.outlook.com
 (2603:10a6:20b:4b2::9)
X-Microsoft-Original-Message-ID:
 <b78f5584-13ef-441c-96da-6d7b6fab795c@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR02MB7902:EE_|PR3PR02MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: 08fe4475-99a7-40a9-2bd7-08df2e8a97ac
X-MS-Exchange-SLBlob-MailProps:
	UDhyqGRoB4YC/Bm0ar2YLgHnqEpaZWwKO5DQ+65gyFmY0JxRvrANmF1Ug7uAbrC0eiveeHChfCZw5GJCir0ZW7HrTZxiSLyJwB24/mdD4AnIOK8guqcLA+nzBdquImR+tZWR1tRpqQLuseRdsGxgqlfYZKFZ+1SCUrq7GBO+buudySi2G37aVSi3Q5KJAfYBfn8XZgDOtm0muF9K9IR5MG8flvsqT+HvMMuZw0XeobI7S96UFR8UapH04g3HKPb/xT+kVLFF1x9LR+Sv+Ii8zq756EdnyLdlddobADdZiwILSczaKbJ3ShsLj+TPcgeJMCAJdWhwfhQIOLmfF1rSkw+oLOdyjoeePZtc6ZH+Q84VWPgZdU51Y7g/PhA5MC5Kw0cGFv4Rb1sSIgusfGOQwvYA62ByeOxDN+Dl00KirkLxMNB8rgQE07lfai4gsEHimcNdf7UVPdH2lAKv6oittcroG8O5Dm8zv/+Q3ACjh0Tdkx28cAzhOc3mefPK82U9OGh8b9HhTkTXjDKu8gKCEgnOFsydBCcsE1u1IjcUy5RtQtP9JA0Od5QURIFMOYyr/z0V+qxAYFF1I/1bSx+mEMcntjM88/VilgH0kNMYugkWYdyD1uFidzIz0myHGTs1L/NvJvmIKVkG448D09tefRE+UHLlgvBVNduCJqNmLvm11NNuAICQ7A==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|15080799012|23021999003|24021099003|51005399006|19110799012|8060799015|12121999013|25010399006|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Und1cmNjZU5ZVlBJVHBvdGt5MmJQUU9kSlRBeGczTkR6UFo2OTJMT0liUmg5?=
 =?utf-8?B?c2ZCTnZRWTF3TDZSYWZmYWgxQWg3ZlcySTk5OUllSytJSXJoQnIvOXdQNGQ4?=
 =?utf-8?B?VHpVKzQrTnphdlFFdUgzYlJ5TnY1Kzl6MkRaUlkzbFJJeHBNWHIwK1JDSXd4?=
 =?utf-8?B?NzA3LzBZdkF4UkxOMFZlSVVtQ3Q5anNGTW5LQmc0M1ZISkhXbzQvNFpPWnhC?=
 =?utf-8?B?R29lbjNWSkdZRXZHSWNOTTA3ZjJxamFjOExUSWgzZEFuTUl2Yk1mNDc2QnFx?=
 =?utf-8?B?eUFiZHRWc1BOb0JDQzlOUlNvZlJ2MUhObXllOHllc2Rkajhla3d5SHdaN1Fv?=
 =?utf-8?B?bWF4WXNFN1QrSXFoc2cxNWhMc2xNMXdrdzdhejgzZFp2OFVlZTRJSTVCOHZm?=
 =?utf-8?B?a3JsQlF2emVRb1RSRXRwdjZNUmg4YVdUTW80VkkyZy96UWxyeTErUmhMWDlq?=
 =?utf-8?B?UGdxajFrb1p4YWFPa0hzSFdOMjB0SW1Eb3psSVcrN0VnN0Z4QUo5MmtxSzdo?=
 =?utf-8?B?YlNvTDN6c2NJOG0zVU52aUFib1RTYURTSjdKaEdEb1hKRmtQYjlpT2pXcnhL?=
 =?utf-8?B?Yyt5T044OTZ3ZEhOelNGdEwxQWRVbTdtYStpN21jYkQvTUFqR2ZZREJ4dVNO?=
 =?utf-8?B?TS84dUZXb1dINzBzV0R2eEhKWnQ0R3psQ1lidGhnN2JmZElyZm1lbXNZQnd3?=
 =?utf-8?B?MVVlRWZBcHkrVjkzOVhTdVFIcXNMeWFucHJpYWwzUDRqcmJmMSt5dUZuenM2?=
 =?utf-8?B?dVFaMlJrd0Q0blduQS9JQUtDcThFMHFuWktUbGRjaWZLbFY2SVZPT256QzJG?=
 =?utf-8?B?RXhKOEdDTVh0b3BMc2lhNis1cXJ4OXF3NlBSTFZOTXpCd0o0d29ISzNQb0Rw?=
 =?utf-8?B?dUk0Q3B3NzZCaFZNUXZrZ1MwMEJDOHFGTjl0RDRyeHh2MGtteloyOVdBbktH?=
 =?utf-8?B?Nm5qaGpneC9zejRITkxOWm1SSEJWSEF5RFlBamRNUFNDb2dpekp5TXBQOVVs?=
 =?utf-8?B?ak12NFZOOFVUQ2VsOGVtZ2FPZUJTRml3T29VUDU0enNPUTJoUXAzVFJER0Fs?=
 =?utf-8?B?Q3pMZW11eWZZaW9MSUV0UGVDVTY3UmYxU3hyL1ZyR0xVaUF4QVBCWjZsNC9V?=
 =?utf-8?B?QW5zUTFzc2Ftc09FR3pkT3pLMEkzVEo2cTY1THhFbnVkVW12SkhkWFVWRTIy?=
 =?utf-8?B?RjN3R2psaWtQV1l4a29ic2JIVjVtSzZ3aExyWE54NU1CR0RsM0Z2Y3dmSlZI?=
 =?utf-8?B?bEhPN3V5cXlEa2ptb3JZTjdyUjJwcGlzbVhwOU9pcno0NUFMa1NsWnhPdm5N?=
 =?utf-8?Q?TfsXoyv+sfbnM=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2orWFBReDlhUmxVV1RwclJONkkwbW5pNmZmMHFyTjRWYUZDbUdoeDV2QVNI?=
 =?utf-8?B?WWZqMnF5UlV2RGtjcVYvczY5b3VOZ0cvNlFOa3JiZGZkOEk0SDVtZ1lISWN1?=
 =?utf-8?B?UDlQY3V5RWFlYjFtVEh2OGZGSnZmMzVXZTVFdVRQdVJlZnJpbEFsRFl5MFE3?=
 =?utf-8?B?clp1eG9DSU5IM3lVdFZXWXVlSWFqVEhrS2RVcmVtNElKVEhWSitnL0tXSlk3?=
 =?utf-8?B?RFlhSnQ3VU84MWZBTEJ4QUFqUjh2NTQyUzRFTHFJMnNQZVVQT1VKRGVQYVVh?=
 =?utf-8?B?Tmt1eWRuYmRoc2Y4c201QVlwWWRGTW9ibkdibGJPS3U1STFDNDNpaTB6NGFj?=
 =?utf-8?B?cENpZ3BUL3J3cW13N01WL3BhYXoxdHdSK0lhVmtzZUZCWGwwOVhkZmQ2VUpY?=
 =?utf-8?B?TFRPNkZRMGMzeDgzUmtaekhBRWJoamFrSUpFazJKTVQzTnlPS3Jvd0RuRTNt?=
 =?utf-8?B?ZG5scVdLb1B2Z21uc1lUSitZdEtGeStBR0VLVk9jWC91T0lkOHk4Zy91VGY1?=
 =?utf-8?B?VmVVTW5JbXR3VmRmZFhNOVJPRXdTaWVXZWtVc2dkSytWSHhzRThwb1o3OURO?=
 =?utf-8?B?eEpIMXVBNkF3M0xzOTdqdkFRVENoWHVnVkhiWTJrTm92eXJXNWx4elZJV3Ry?=
 =?utf-8?B?Y3JUT01VSStSU3hlWVBjR1lCOGttWGNCVkNQa1lGWVJWdHZvN2VtZ1I5eGFt?=
 =?utf-8?B?bkNWT1BaYTAzVUFMSDlSV0Zxc2p3Q3paOTZ4WFlLdDhtbDh1T3VNZ2lxV2xF?=
 =?utf-8?B?N1hNT3ZqN1p0RFZZY21ncDVEOUhkRzduMlYzZUR3UzM5cnJsRTVJV1JpeXIw?=
 =?utf-8?B?djZMTXpIcTBVRGVRUTRXaEQwZXUxd3pNbTZ1dHRtZTJwUmV5WlJlbGRjZzcv?=
 =?utf-8?B?d2tORFZ5a0p4NG1tVlQ2VXlyazRCN2lMR0llOUtyYWdhdVJ2TDVDNit4SjNG?=
 =?utf-8?B?eVNvWEpJZ2l0Z1JPSVc0aUIxa2YrNDR2MnhFdUhrNTlDVUNtTnkvSjhSN1VR?=
 =?utf-8?B?ZVEzdGZuNHBNMFhuYnQ2eDFIUHh3bVlzVUNneTErNHFsOXZuRDVnMHAwaks1?=
 =?utf-8?B?UHNTaTNWSm00OWRWbDN2TGxralZNREp1VE9iQUQ2RmVtTVk3WlZzVGNYMC9M?=
 =?utf-8?B?N3ZlQ2JsejV6b3BuVXQxcGJ5TzRYUFFFMXJ1OEN2WE1zeG5DWkdtbXd3eHgz?=
 =?utf-8?B?Uk50eS9QNDRJL1AxcTF3RmpEampPaDRvbDdGOHVrbVo0VEp6QUdpSXhCelRl?=
 =?utf-8?B?YzJpQ0tiRmszMDdueE1qUlFkc1RyWlYwdWtkdnZzbEFEeDRucWtKRUJtOTVk?=
 =?utf-8?B?cXdVYW9pVmd5L0NiNGQxNTdDNTJWTG53VGxHNlJSODVJU0V3Z2VyWmZUb3ZX?=
 =?utf-8?B?ZzVwTUt3S3lqdStxNDNnWHFvWURYMzVuY0UyZVJRVUpoM3gwQktRd044ZjN2?=
 =?utf-8?B?SlZlUkxxZlVqTkNOOWRxdkprWUhvSnRESUI0OTMzQnIrNExKbEFFdmp4WUh3?=
 =?utf-8?B?TGR6TDRLLzN0ZUl0VVJYTFRpaWtkdUkxc0MrQWw1UkczTEo4bktyZGFmSzFS?=
 =?utf-8?B?UlRoUmZHQlhJQkRpaGFjWFFKNmNBcUNQaU5sRkJZblVuZlNGbC9Wa1VFSGRK?=
 =?utf-8?B?b2VJUFdOTW05OFJVM1BRb1VlUi9VSnNEdi9nVDQwRjNDaDE2WGtyYXRhcDVi?=
 =?utf-8?B?NE9FbmFtamhLanRwM0RXTnlNM21nWWdrS3pGeldTVnRDNjFrTmpUTXMzMWtH?=
 =?utf-8?B?RStYb0JlYmY4cUt1Y2lCOEpSemhxcm5qUDdQMksxYjFyVm9mL3E4Y3lNRXVn?=
 =?utf-8?B?cFpJdEx6Um52ektacGVobUJmZlN5S0RTWGJKSENRUm5HQWp6aGRZMHBSQVBp?=
 =?utf-8?Q?3o3hNfC3xPg4T?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08fe4475-99a7-40a9-2bd7-08df2e8a97ac
X-MS-Exchange-CrossTenant-AuthSource: AS4PR02MB7902.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 09:14:49.9295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR02MB6363
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GB_MSAUTHSOURCE_EUROPE,HTML_MESSAGE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--------------A20wDwSKOmcQoBdgawhni4L5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Mark,

> Thanks for the patch.  Is this to solve a particular error that you've
> run into, or is it the result of code inspection?  Either is OK, but the
> answer helps us decide what priority to give the report, and whether
> more code needs to be audited to find similar issues.

This was found by visual inspection while reviewing the PThreads implementation.

Best Regards!
Luca

--------------A20wDwSKOmcQoBdgawhni4L5--
