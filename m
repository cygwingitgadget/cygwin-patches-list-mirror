Return-Path: <SRS0=+JKb=UA=cornell.edu=kbrown@sourceware.org>
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072b.outbound.protection.outlook.com [IPv6:2a01:111:f403:2412::72b])
	by sourceware.org (Postfix) with ESMTPS id 2873D3858C31
	for <cygwin-patches@cygwin.com>; Wed,  8 Jan 2025 23:03:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2873D3858C31
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2873D3858C31
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2412::72b
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1736377412; cv=pass;
	b=VtjrypSxDEuz8PByNZbGZWAblC1+beTENfRJ5GkfVXRj5px9t7PzQGiyA0oM8KOrAg2edDIhEh3Dp/TPhEBfvo061ssCYe0v2kkPIsyjw7QAstWPX9Ncy8OoBrDj42xLpVymXewUxFZLzsz7rlVcjCHnNZsqHU98teYwa8eqVIw=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736377412; c=relaxed/simple;
	bh=lqsA+POuoRTNPP3XTS0g5aPFEWxKc9rDHP288ppxgM0=;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version; b=uI+w1NdsY0yTgYAYX8t9UEzKBX4uG9EjPyj4gF7Vzek3FDXZPHO1Ok4kQxJa8bTcsZtBz6lLNBtz/TYsN3bfuWTqd/DcfIQ5qP8XWhmKlyfwuJBcBETwpTNLf8iQJbd22r58J8Cc70vK+KsIA/9AyOwC+fOkHvc7QDsMtyNDkoM=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2873D3858C31
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=cornell.edu header.i=@cornell.edu header.a=rsa-sha256 header.s=selector2 header.b=MMgA5552
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5H9U6XIAJeVAD2TEtWkR1JmSFGL9JMWgO9yfJvtnggPXTkJ+iqWWcqSKBH+ApLDkepXdbnHghOcQUItSnABy+0Rpk9WlZrL9eXj8zddWzvf5djcaZQ3XqQHBQ3IXiIpwrDwB6rC7cshbZl1Ivu6D7COowtKwbfzlcYdebZIJ6jdlz5ymI+Hugd1OEbIGoLQGBL1aOCBGfNFdpiQ9HRjE34f8YTAaQnIFSV52g96j0Uie8oRh4HyszxSzyVDestGqsytfKx3iNtLysmOnxncHR+654nWabhxaT4Ws7ppy+njSlf3josoeb5k1flull83FjG44t6eD7DxliVH6sWCXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfrtzlm8GyS6BqjseJcwyVaWDKSBXkSFXvTtvII48so=;
 b=QPZcimt/EPXEEgUr4Sd2AxbPyo6OPtGrP4XLoWvX6Fhcr6JEFNfHzOz4n5Vgg/537Nj0y3qMjlCN/vBaqNXs5iy8sCguC36UUH4QcxvX/gkly0abflP7Fjo0Fdv8u59BkgjaMSDslK02DIuRWsg7dl8DM1oUGQnZHDTlnA2wxxo+4hHAISNd5FFDfWxtMVsRfFGI+hXYPhFkos3DBwP1c41WMdvq9hdpackOWALinXBD+pw/tHjpNlePob8VUlWU8bTz08X+eqcP+Y+3iVCNtfuoyH9dp15bVGzuApbtqnDEHXVmHRAjDlVeauN59E9DxYzom6MGRKa4w1WiP74/Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfrtzlm8GyS6BqjseJcwyVaWDKSBXkSFXvTtvII48so=;
 b=MMgA5552BbwavdsmEVFDEHoqIzushrGCFI1VWH1IUZRcRFzijjGetfo+6StObXIAHR/RIfRfhmDIzJeGH5vYCMufQnfhLvCY6OVIZdY2E6ADmnqNt5KY16BOY3d8pAOpxSLCt6iJndzEUsfQoiF/eku8+ext3N/jOOqD1JHFK8o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from SN6PR04MB5151.namprd04.prod.outlook.com (2603:10b6:805:90::25)
 by DS1PR04MB9654.namprd04.prod.outlook.com (2603:10b6:8:21d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Wed, 8 Jan
 2025 23:03:29 +0000
Received: from SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd]) by SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd%6]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 23:03:29 +0000
Message-ID: <b818e851-43af-484c-ab74-cf3eeb3377f9@cornell.edu>
Date: Wed, 8 Jan 2025 18:03:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Some mmap code cleanup
To: cygwin-patches@cygwin.com
References: <934687ad-4ad9-4b41-a252-005033cd2e65@cornell.edu>
 <Z36a7hMUUE3qKQEb@calimero.vinschen.de>
Content-Language: en-US
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <Z36a7hMUUE3qKQEb@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0050.namprd03.prod.outlook.com
 (2603:10b6:408:fb::25) To SN6PR04MB5151.namprd04.prod.outlook.com
 (2603:10b6:805:90::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB5151:EE_|DS1PR04MB9654:EE_
X-MS-Office365-Filtering-Correlation-Id: ed738ed0-0079-4308-ca7d-08dd3038aa96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2tITnh4c3FFOW8zVjRVY3JXaSsvc3c5QVh3Y29maHF1VkpOQTk4Zm1VeS9G?=
 =?utf-8?B?NDZMQjNzOWxuWlBUYnBpVmVXU1lJZ3FwY1NrNVlGa29Pb1lsUCtzckNMeFNS?=
 =?utf-8?B?dUdKZVpSTU1HQ0RhYU5XdzFBZmJlVENtN2dKYitIQi9pV2FISnJBY1dIKzZU?=
 =?utf-8?B?SUNKTHkrR2RrTzY0a2hiUldBYTE5dVI2NWY0ZGV5M0txNmp3Y0dUeTZQSERI?=
 =?utf-8?B?ditDVzlxcEV0ekY0OGZFMXhsVnZWZVdpYWJtOUdhUUh4QTQ0b0VpTkJjazF2?=
 =?utf-8?B?OWlDV2o2TkVtWHpnTThkOHlrNy9mcmc1YVRGUEJWM1lPeDcwaGkxVUZxbytk?=
 =?utf-8?B?NHFLbGNNS1NUN3FlUU0yU2hzUEtCcWc1ZVNJaThvRkRpR2J0YVo5bDVFN3dL?=
 =?utf-8?B?OVBwMU1sYXpzVThFbnEraUw1VkNKTmxTZThkV2RVSXRRUGdzRUZxTndnSTZS?=
 =?utf-8?B?Q3dCOGg3YkxWRWZFQ0xwYWovRVJHVDVFWXQvTFBVNytaRkZDMVBwclNJVDRM?=
 =?utf-8?B?NDFNa0FYZnVGTlVncElkL1psRWtLZjl4Vm1WRWdUdURvbk9OTW1EWGVNWVJH?=
 =?utf-8?B?RHhyam5uUkZNV1cwTDRyMlM2MWVvUEVDc1lFS1VIZ0draWhYOTVZVFRFdmpN?=
 =?utf-8?B?VkZaTE1oQVlYR1FKOS9PZFJWalZOU0tLd1JHMFREekpPWEtiekdYM3BKUGs3?=
 =?utf-8?B?dU9ic1NJVVZXU1JWbkx1a2JNdkFhNG1Nb2NxcCtaVEx0Mzl0YWxqM3lUcVlI?=
 =?utf-8?B?RmZmTEplUDI5RkhtVWl4YXNaMWdiZ2FOclJ6dXZLdXlqQUx4U3Vwbk95SWJv?=
 =?utf-8?B?Q0hyd0lRaGFYNWdodlRTci9TTW1JUFcrK3padFEraTNWdHFWTnoxWEUvMWRn?=
 =?utf-8?B?UGZhYVpWYzRyZE1Nb1R4N1NnY20xT0JIV0oxcVI1SmFjbFF0UnhQbHBOdVVp?=
 =?utf-8?B?ejEzZ1ZML292ZzR0TVdoY2p5M3lhaU4wenRBUkZJMUVIcXdjYjRNSG1rYU9O?=
 =?utf-8?B?eE1MVnhmSmEvUjlUZFMwMlBKa2tLYkgxWG9jVnBuMlZGSVRBZ1E4b2xneGkz?=
 =?utf-8?B?bWxCQXQ3K2lPSVpTS1lSaW5DUGdVZDUwUlY4c1dXbVhvNWh3eUp6cU50MG5a?=
 =?utf-8?B?NENpUVAxdWFZNGViMXQzR2o1S1BRSG9YcVByeVFSUFpsVUhPZEhuT0FPczlB?=
 =?utf-8?B?U2hSaUlRN2lRN29yY0NyVGREQ2gzcFZNWWFzYkVDOWM2NUlwckY2dW52dzRN?=
 =?utf-8?B?UlN3KzdoeEllNFkxcWNaS3JmV282MjNTLzc1YW1kZ2NvYkZ4QnpaRmNVczFD?=
 =?utf-8?B?R1pEWjJ1Zm5NVlRCOVJIUTdGSUpuR2czcUZNUHl5TGllU2JydFAwU0RlOE80?=
 =?utf-8?B?VDM4KzBGOVpBZ2Z6Zi9qNG5xdzhzNnBFNmZWVVBac05EWDhpRjVScCt5UXRi?=
 =?utf-8?B?eXB5RHNqSnRCaHcyeE1wODZjeFRnMVBYeEtzZnR0QTJjbWlxQVFRV3dPUzhH?=
 =?utf-8?B?Qmp0MGlMSHI0OFZVdjY3djdzUytSY3hQVWJESEIxYjczSVhnb2Rzb0dMT1Jn?=
 =?utf-8?B?UzJsZk9SQ0V0UW9sbDMrcUIrZlB5VEJQK1lKeDJuaVN1aWJ5N3BtQnFKS3lm?=
 =?utf-8?B?SVVnYTZJMDNsK2J2SXFZam54ZXJLODBsWTFjR09lTVA3Q0NEUzVXZHBYL3Iw?=
 =?utf-8?B?YmlaWndZWEx2NGRidnJnUG1lTnJ5NEtka00zTmVCTmI2M1FUcyt4UmgwZVlE?=
 =?utf-8?B?OHo1RzR4RStkSEtiYllCbE1ETG1uSXRBaHpBditmSUVheEJYSGNFZjVDQUcw?=
 =?utf-8?B?OXI5cGZvWUdLTlM0UE9XZDFpdU5oM1hxL3pLM0pabHlHUWlSZHMxQndDcWFL?=
 =?utf-8?Q?hYkQkl2FOrsLT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB5151.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzJhVEZCbzJlMDU0K1ZuWDlLcFdRVk12S1ZYUWdLbFFSUC9uenRCdWJ6bVV2?=
 =?utf-8?B?WVJOVTRaQWdpcEVNZHJvQXN0N2tSa1BpZUZsSmY1ODliNVJQRUVzKzREMi9l?=
 =?utf-8?B?ZWFLTDB5bTdqWS95VWN3bTMvVnhCWWhRTVZMUmlOMVROSFd2Z1M4OFg1eGJV?=
 =?utf-8?B?SXVtQUJaam1yL1Q4ZEtXOUo0S3FvOWNmOTdWV3pnYUlHR0swa0hZWDdwMWg3?=
 =?utf-8?B?WWN0RkwvM2Q1eEhwRVRTc0lCOFA2R3llMFArVGJMVnd1dGVCeWwrVVR5VlZ3?=
 =?utf-8?B?M1lmdEhTRlpnMm5qRWRiaHRHRmIwUnhlZnBOYklxdUJUNDNMOXN2QVdqcWNE?=
 =?utf-8?B?WmwzNDFsZkxwOFZLSmNQczZzamVBektLRG5RRERwZHhUM3JMTGMvaXNGNHEv?=
 =?utf-8?B?bjB2S1IwdUl1TGxjVjUwaWRRVEJueEllanpGUlVvRkU1YUdMbXQ0ckdyRC9L?=
 =?utf-8?B?emZlem5VZEhJSE1SUVVPY3Y1NGUzRnoyZEViN1BZWFJBVU01a2RuS3ErZlF5?=
 =?utf-8?B?U0lOYjE0OTNlK2FVUE9qY011L1E1bk1SN0dqdDlscWFOc0lDK3pqMUR5OUE2?=
 =?utf-8?B?U1BjR2Rhbk9uMnlmQ1JmRFYxNC9Db2EyMzBHZ0tPVnBFZE9venZtSVBNdVlX?=
 =?utf-8?B?NlZvWEY0Vm80cnU2WGlpQTMyditPMzN5TTBIS084TUpjbFlwem90SVVLQitZ?=
 =?utf-8?B?OC9DZ3ZwM2psd040SlJYMk9DOHdCdFVrOFliUEdqUjdzWGI0a3YvalhOWUx2?=
 =?utf-8?B?MW1YT0lGakJnVi9HZldSeE1YUTV2cC96eHpKUld1OEw0RTJRV0tNZjZQSXJt?=
 =?utf-8?B?eWJlckVjNG5teTQ0bHBGbHFSMUl5RTdTRXpqRDFveEgwUEZ5L2ZEcFpRTW1X?=
 =?utf-8?B?eGZIK0Z5S0lvUml0bDFUa0F3bGJNUE9DUkhZSXhtek9pdURITWk0a09TY2VI?=
 =?utf-8?B?VHhjalF5b2FsMERVYTdhVmY2M3g2ZFVySVYxemh6dDEzOERiRHRjdTNicWVv?=
 =?utf-8?B?RzhZQ0dIbkVkZmdRY3V5dXlwT0dNQ2xJUEhLakRKQjByTmJoVllId1JvcmMx?=
 =?utf-8?B?Y3JSa1hIM1piMzdYQzVBVWxWQ2JQTDRxNEhXcnoveE82a3NuWUNqR1VmUDNO?=
 =?utf-8?B?aXoyN1ZSSzFqSWtUMEpwcUhkT1ZxbW93OSt1QVdaL1Y1SUNoREJrNHNudThF?=
 =?utf-8?B?cFlDdlRyczB5QTd4cC9kelpLU1NadnZGSHZvdllyOHFsdTBaSFRKQWJPc2Nh?=
 =?utf-8?B?MjdUekJxNjROSWI3dmhGdmRNQUxsY1IzWTNNYlRGOEFuRnM4TTlNeUwxLzR5?=
 =?utf-8?B?ZWplamd5OG5XY3dOWGxrcXA4QmQvbjVJMUliUEsyampHMzNqY0lua3M3TFpW?=
 =?utf-8?B?RExmM2QyR1g0SHp1VjBtODRFbFkyME9TQ25rd2N0bzNNK0V1Mzh1WExBeURj?=
 =?utf-8?B?Vm9LMU1xOGNac25yTldwMEVtV0dBYXdzU21QUkUzUGRCNmhoY2prMHkxYTdW?=
 =?utf-8?B?VGRwTTU4UkNHRmF6N21wSmZicytZdGJQY0FRR3RmQ1pJcU80bnZBQnlJWWxB?=
 =?utf-8?B?K1ovU1c2TlZDQ0M4MGRyUUFlcC9wWGNUYXcwVzl6YnNHL3Z0aXZld1VrKzFL?=
 =?utf-8?B?bTBtYmpEL21IR0RoL3FHRXhQYnU3R1BocjBzeUN6c0VLb2lNMWtGOU8zR3p5?=
 =?utf-8?B?eFRuNUVuWW1mbksvdk1TWnZwY3dmNXMwR2lwRUZib1BzVDNVcWk3eit4U3pZ?=
 =?utf-8?B?RGtPYjQwM09hV2RCWXpSODViOTlIR01Xc2xPT250N1hkK25ONU5HbGFaSDMv?=
 =?utf-8?B?eTU5NWFBZWE5QkdNTytlbVBsaitmQXpwZjRNMlpRQi9VQlN3UjNpTTA0eXVM?=
 =?utf-8?B?WnBUb3cxd2VTSVBJS0ovQjRhOXZiMG80WXR2UVg5aVFMQ3ZRd0hsUHdMSlhz?=
 =?utf-8?B?OW50M0s3VjdOcmIxbnFmRTdaL3ZQWjZvWVBQL2R4Mi9RcTdoRjdvMzRDakg1?=
 =?utf-8?B?cjB1TjA5dFRWRENNeUdzZ1lpN0VDN2tESEZtZm1uczVGWDVlQXR5dnVFT1Mr?=
 =?utf-8?B?aGRVMHFlZ3E1bThHbytXUDFyaW44VGV4Z0pNd2hRTlJzRXMxWHlnRS9iQ3Rt?=
 =?utf-8?Q?v0DNnz7+VNwVfcbYayQOTWYC3?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: ed738ed0-0079-4308-ca7d-08dd3038aa96
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB5151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 23:03:29.7084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gTYgVpHP0Pz1FD60UlEPDUzcZ2akYkuSi+v12I4nWloHeot1NHmw/B2iL5zJ9AM1/0h3sqreWbJ+JLUPaykNtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR04MB9654
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,JMQ_SPF_NEUTRAL,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 1/8/2025 10:34 AM, Corinna Vinschen wrote:
> Hi Ken,
> 
> any chance you could resend the patches as a patch series with a single
> patch per email?  It would be nice if we could review and, if necessary,
> discuss the patches independently of each other.  git send-email usually
> does that for you.
Sorry, I wasn't thinking.  Unfortunately, git send-email isn't 
compatible with my MSP, so I have to use attachments.  But I can still 
send one per email, each with appropriate subject.

Ken
