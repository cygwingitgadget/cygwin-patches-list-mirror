Return-Path: <SRS0=+JKb=UA=cornell.edu=kbrown@sourceware.org>
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072c.outbound.protection.outlook.com [IPv6:2a01:111:f403:2413::72c])
	by sourceware.org (Postfix) with ESMTPS id 7F5333858D35
	for <cygwin-patches@cygwin.com>; Wed,  8 Jan 2025 02:28:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7F5333858D35
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7F5333858D35
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2413::72c
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1736303283; cv=pass;
	b=rSqccA0owDcU43cw0pCt6bbKM5dLjbKFOHzKAeIolAKYzsWpOH5/77U5jhALPBUehVyyjTjE/5E6aw0lpViqWFtZhZhs0m92JAUMkgF7P7ZGI7Ye7fUjvuoQoUUeA1/3Wrn7u6Xj4r8Nv7N3J9qdC6fM1CnKAMoECFJS1YJqVGY=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736303283; c=relaxed/simple;
	bh=F1aZ/aCm78zwxbAn9vRq2csfjqCuhD+2teMHzQe92EE=;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version; b=nXSstKPpMIMkcUvjtXTO4SKaT5wSEKvzZlYxIya5gMUl1caQtyGSBXAycqdzHErFJZLRQ9Lju51yoiOQHVJps44idf3wKA3WbCoj48z6qJzXOtWv/tuR37aVHFuCCjHb9s9CUmeqBLQiqX0rWIlcKD1kBcqatIQpIPFdUjVR9wE=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7F5333858D35
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=cornell.edu header.i=@cornell.edu header.a=rsa-sha256 header.s=selector2 header.b=MGsJYjou
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fav1kuUYalaFKP70FNgnjh4oUN7APJvPlR7sLq50b3s2GpvykKbuI+HwqVnvjIbkiWj7KphHsnMiyg3aSjsZXFb2J0dlmGfkuexQMD+r3U1iHyNUUJQHBgB13OHZ6cL95jZs30XibkqnmZvKorvWpZ9H8D35GSQiIxb+gqvls2pGEjDQQVoyPDWgCod29F63g/B2nYBS0d3hUnYJruOk5A8UOqe3+8h+vH54KOkyfCQaSixjutgKW9aaXqcZfnobhLNuNYAtoM3wmuSb4WkXdeLszbADl4jSElxNdyiZ7/T+A97oV47T2BSyA4JyvPHSzMVEk/vg9V0G2DyypsckxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhMoOYltiLTl7xhDYdskT5X56ZYX+R/Ev5ngpFcwCQw=;
 b=LpEv5dubY9JihW3KTGFrlyJcBZFIbhoDgWEXyoNEG4dXT2YExc+GVHy3QSHVYJgtWevMwOeW/8vtTc8pPH7RripcQJJ3k2qLIDxGRKSlmpjTVI3IXLaC85cNCdXAnMzAI9/Flwup8r554QCsbEJqFME1csNx8ti5RBONGB4OrqJB50ISbWLmhqhl1EhAcepzbFFLKTRewpNNOMvSxeZWIYoNpkk9+ZJY+D1FN6QJxF2smXHeVz8HHQnVNCmLK1x0QUu12pMGzXP4psb5li2NiFcJu2ibNHL7y7KameYTfK04oiUDwfy7ujTfWlb4ZPMnzmGwaFQTwNtb8Ycbl9C0ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhMoOYltiLTl7xhDYdskT5X56ZYX+R/Ev5ngpFcwCQw=;
 b=MGsJYjouZ2DcXUb+KqGppt+xzSU/qT7zVBlNEs9R0u0HnMrF5UyQlu6+b0zY8x22DcCBXv2I1YKQITOUPsI0bLXCnfk6qim1mmIYLyYVQHUxJQ8xrj21RO+sqLKv40/In1MS6s+Th4uGDaMK1+H996PpTNB3T9sfOqD1YKCOEw4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from SN6PR04MB5151.namprd04.prod.outlook.com (2603:10b6:805:90::25)
 by SA0PR04MB7146.namprd04.prod.outlook.com (2603:10b6:806:e3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 02:28:01 +0000
Received: from SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd]) by SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd%6]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 02:28:01 +0000
Message-ID: <de64c367-6695-4109-bbcb-591356a7470e@cornell.edu>
Date: Tue, 7 Jan 2025 21:27:59 -0500
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
X-ClientProxiedBy: BN9PR03CA0346.namprd03.prod.outlook.com
 (2603:10b6:408:f6::21) To SN6PR04MB5151.namprd04.prod.outlook.com
 (2603:10b6:805:90::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB5151:EE_|SA0PR04MB7146:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f94a1f1-4bf2-4937-3e3e-08dd2f8c129a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUd3MWFWTURpUTczSDBUSjVtQzgwamkrZWdEeUJ5Z1dXQkVST1lkTVJoYytI?=
 =?utf-8?B?YzRLbm10dFlUUnFXcGZXUEZhZWNSM1JkWXNDbnowRkQxMm96amdyTjAvYkRy?=
 =?utf-8?B?Z2NhWXVNaWQySldBRzByT045ZWdNTzdZeU9zUUVSMVRFcExYS3Y4QjMyL3p1?=
 =?utf-8?B?eHltNC9tMHZDWUhqWDRvZXJhL0p1eFJoSE5pRUJoUjFSM0h0K3YrM1lCNW5u?=
 =?utf-8?B?NVhWaGxZaUUzaDRNalJLZk80eHdJK0FhVC83U0QxMVh2TWtucnQ5N2lQa0Zt?=
 =?utf-8?B?d0xkMUhCNUoxbVMrSUNuRW1YN2JKUjRvYUcxWmtVRGlBaTdXU0czSDJpc1Fy?=
 =?utf-8?B?V1orWlpLdHpGdk9ld3VJZUVXVU11d2NzUFlSeUVrTTZyWExUVnY4Z25vcTQ5?=
 =?utf-8?B?NVJ5cjlHSXVVa05ZN3RGR0xmcW1taVpkQ3VncDkyeUFLNVBTOVJLbnZITC93?=
 =?utf-8?B?T2ZCM2FZRi82YW8yVDhKQmRVVVJlMk1tWjZaaWsxb2pqell3ZzF2eEJydWRh?=
 =?utf-8?B?cXNLdmcxcDVxUVpFeVdUQkp6bVBWaHJEMzRwYVpCN2MrRlRzQjZYQlBFMTJW?=
 =?utf-8?B?NjdLYmRUTzJuRkprd3o5Q3MyYVZyalhVRjA3TzVlQ1oxQmtqQ0JrRUt0Q2E4?=
 =?utf-8?B?MDA4dUNpbzF1d1BVODV0K25pUGFqcUhNdFdodStLd1lPOFpsWFdFSE5xRk5K?=
 =?utf-8?B?QXpIQkNUcCtkbW5jb2Yzek1JcDNsVW1QWHRrNExkcHlRMzgrd3ZKcXJSZnhM?=
 =?utf-8?B?RnNRMWZPYk1lQXdjMWNNYWhJY2podFUveHIvSlJ3RDZjSzVCWXh0TS9WZzJn?=
 =?utf-8?B?Zk1PNUVMOTBQYWNCdUIrSWl5eVovZ2J0OFkxMCtRN3FoZXVkSzNqS3kwOS9v?=
 =?utf-8?B?SXBMSVZVcVV2c0NBdFFBUUp0ekFOc25WOU14eTlPUDVyVWFQNmEyYjB5Mndu?=
 =?utf-8?B?Um55VTZWV2dMWEt3T0FWWkdJMXhxMHBwVGRsOFNBZkU1VG1JSjYrOHhlcWtq?=
 =?utf-8?B?NlU0aWp6Yk1TMFRYeEo4V1ZPSERubU5Ib25RdGk0OUZOU0loclhlQjlZenBG?=
 =?utf-8?B?eWMwVXc4RkxOZStSZmw0bFhzVGVISm5jejdLaFBPWlpMdXdxbzVGalYwNEtO?=
 =?utf-8?B?Znh0T3E4N2hRczBXSU5QSlVLVUVMSyt6SjJjcWR3YW5pOEVuSW84NXgwZHhZ?=
 =?utf-8?B?eFhrQXoxcVNwTndDOWJROGtWT2hjbDFPUnE3cFh2MkdkNWZ4ZkltUEVXNHZZ?=
 =?utf-8?B?enFydCtNSUJzckQ3QU9JRTBkNHVDM2gvSmNIZnNHRmxDKzN3Q2hpeWhwcm1u?=
 =?utf-8?B?L3BxNE9KYzNMQzJOdEFZNGN4Q0poQkdHemVjd2FPTjVIdjNnYnFrMnNsRmVK?=
 =?utf-8?B?NWpVL2hMQUhlWEJBU2g5MlFpM2wwVTF4dXRqREVwalNqRmVuNTV6WmF2SkNG?=
 =?utf-8?B?bStYdldoVzRqVTdFVFJUNkVWMzlsU1pEOGZUWm1FUmhBYnczZ2s5Ti9lcUZx?=
 =?utf-8?B?LzdHKzFSTkpkMkVaRUt3RnhtUlYyb0JrbG1EbmJ3N3VVK084L010aDY1eUYz?=
 =?utf-8?B?dlJIWjZWSDVZNS95Wk16SjhndlhsLyt4OXdBaEVaWTQvNVBpcGNnS2hKUXA4?=
 =?utf-8?B?YVdXcXRPd2s4NmtQNXhoZ3VnS01Od3Jwajl5dkxST0FEQzIwQW1oVGFtL3VM?=
 =?utf-8?B?Q2lGRi9CWVVhbkxxQ1ZXcEl6aSszRXNsRWsvaGxBRWFremZKaHRqVCs2QlFl?=
 =?utf-8?B?UVpQVDdvajhWdTVvZS9Fd201WFZhQXEyVnNrSE02VkFocFY4YVo2UWFRWWND?=
 =?utf-8?B?bE9HMTlDamhRc1VpRWJTN042RWYyVlZMWDUzSExrcWZhcGdhbU5QQ0ZldzlT?=
 =?utf-8?Q?ZFOxCPwgl55tQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB5151.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmpDRldFaGd3OUhQT3llcXdNOUJJeXZ5SVpwb0NsWVdDUS9EZDlFby9uSHRE?=
 =?utf-8?B?UEQ3T3pudm0vRjlOSHVNRVI0K1VlL2Fvc211cnhDalN0NU41R3p5WlQ3c3d5?=
 =?utf-8?B?dzE0R3Q3dTNaWHVYZTZ3YnlldUVSZUdRNWpweG5Cd1NERmpwWlJBQ0Y1blN3?=
 =?utf-8?B?bG5BUHNEdVhiQU53ajBhZW8vR2dwRXluS1dNME9jT1c0MUxLc3JIYkl0b1Jy?=
 =?utf-8?B?ZE1Rcklic213VG12MnVqbnZCTnNyaExGeVB0UysrZmNYdlNscVMvYVVHNXFZ?=
 =?utf-8?B?SWZMQzkzNC9CdHN1Ymt3UmdpZnFoeEk3Nm44VFg2bFJnUFMzdjVQSFRHSFZW?=
 =?utf-8?B?bE91ZFBNOWtDOHUzRllmUURnTzlxTGxxZFZVRFV1SWpHbDl6V2ljOEtOTXAz?=
 =?utf-8?B?R3YvOEVFYTMxR1ZyYjFjZnVvMHQra1lWbW0yYkNPeHhHZURyRjBHeXBrRWI5?=
 =?utf-8?B?T1NyR0swQVJzdU9JZUxDdUdGUXp1U0tZd0NGeDBZQ3BPbkNrbWFtTi8wMkZr?=
 =?utf-8?B?NEFPTjF5ajVIdS9lUzI0NDVWUTdNT0ZLaW1TWDlyVHV1eTRpL3JKS2tuaUxD?=
 =?utf-8?B?c2k5V3BObUw1TWwwaGVoRmlmaWI1SHpFZllKcGd4K09haXFKcVNmNVdVb3Rt?=
 =?utf-8?B?RnJTQjAvMXpGMEZNZTA2cjBKTEMrVHdub2FOa1Uzb1QrbHRPL1NrenAwekF6?=
 =?utf-8?B?VGxHK0F4ajZWOWdDMlZwWG1yOHE4OXZ0MG41bDhyN3NZYkxqSkFQR3R6T1Nw?=
 =?utf-8?B?ZzB4aEwwUUZNYTk5TzRmNGdXTlBCbC9XVDBGNnUwZVpxb2JaemR3djhMbit2?=
 =?utf-8?B?cUQyckFjVlZwdWQzMGVUUUMxNHBXWFpTWGc1UnRIbkppRmlQcEl6SE00NXBR?=
 =?utf-8?B?dGxvVENDSm1JNHZXMjhoS2pIZ095TVVuZXlzQjh1bk1qaCt6QlVCYktnQnl3?=
 =?utf-8?B?eHYvU0RRMTYzTjI2WjcrVXBXSHJpWi9weEhUa2huak5lMmgrR3djZmxXd0FU?=
 =?utf-8?B?aEQ2c0pvYVUyR3I1Q3pDeWsvaWdLTk8rbm9NZnhJV2tkc1Q0Z0pMbDVmU3A5?=
 =?utf-8?B?akVxMWJlaWs2OCtVZ1BTbGZJU0g4eFM5WlVpUkg3T3FxQ2tOL2pjUTdrWmlB?=
 =?utf-8?B?Z1ZhUmJPOVRmR3VBeWpwZTdNbktoSVh4d3JaNXlweGtid0U3aWFyN2IvOFE0?=
 =?utf-8?B?OGh3YzRIZWJQQXY1QzNmUFlUY0k4S2UrSnBLd2xxSko0V1dmK3I3dWl2RHdM?=
 =?utf-8?B?dXY3dVFPay9QK0lEWkxibjFyRVBNZDBYZU9IQ0VpR0M2Zkg2UmthdW1QMUdO?=
 =?utf-8?B?RGtkWUdPZGcxWXdmbXVoSHNNay85cWx2SEcvKzdadUFqSnNSMnFHVW1HZkEw?=
 =?utf-8?B?QkdXU3h0TzJGZXVKaHgwdWplbnBLVTcrQkxURFhBcitMRERNaU5hNG56aXht?=
 =?utf-8?B?L3RRU2VuYzBqd0V3cVpOZzhDcktRNVJVLzNKWkVjbkVrM2IvcnUvaXZ0a0lC?=
 =?utf-8?B?MktxV2RVeE5Jc3VBZjFxQzNqVGpra21TeEtjZzFUbGpqRjFyakx2ckRKSitZ?=
 =?utf-8?B?SWpZalk2bUFzQlNZNzJGM2N0OG9FbWdiVnpqM1A1ME5tQ1dDQ003dkxSaEtL?=
 =?utf-8?B?T0JLRzZ0RDVzVndad0gzV1ltbjR0VmFudEJzZXZSb0tPTnBEdVp0b3JPLzVX?=
 =?utf-8?B?UTcwTkFqdkpqTFZ2ZGFKMzc5ZVVJb0h1Qy9CRkc0M3lTRFE4RVEwOUhjUDRQ?=
 =?utf-8?B?MkxIVmsyMkdEZlB1S0orTnROVEVFMXVEdUlJaEN0b3p6cGdFNXlNQ3o5UTBj?=
 =?utf-8?B?LzNFWUJpR0RVdHZoSjk0bkpnVDBCUHg5MkFRMFU5Y1N0RHFKL2ZkeXltOFR1?=
 =?utf-8?B?VzFYNUl2RXhubFhGU2JwQUhWbWczbTlma3pSVWNIVURLL0R5bDlmYVVkWmNq?=
 =?utf-8?B?b2JTRWNrYlZGeDNPKzArY2NRMjF6M2hnNktzL29WY3VTNVJtT096OEcvVHhH?=
 =?utf-8?B?SlBrSmphdzVobWhOOW5JeGlrSzRqTWlSd0ZLVW9ONy9xUENoZXk4TWpmT2Vp?=
 =?utf-8?B?RzFhdEFXUk1meTZXRHR5OWMxSGI1TmtjOHBrQWtJOHMwSFFTVmJvdzAvQkgw?=
 =?utf-8?Q?0R0zE7F7LiA4ug3+sD1dQ/XsU?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f94a1f1-4bf2-4937-3e3e-08dd2f8c129a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB5151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 02:28:01.2349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9L2p83EO1bHPWJtnpWLITZxoDK349LZxQ44QSOmSUVVAovc23eORTnBHnVqOdIjmukbhwGdbfLymfZmrwp7x8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7146
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,JMQ_SPF_NEUTRAL,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 1/7/2025 3:18 PM, Corinna Vinschen wrote:
> - mmap_record::prot flag, should be an array of protection bits per page
>    (POSIX page i e., 64K, not Windows page).

Question: Since it only takes 3 bits to store all possible protections, 
do you think it's worth the trouble to pack the protections, so that 
each byte stores the protection bits for 2 pages?  Or should I just use 
an array of unsigned char, with 1 byte for each page?  Or did you have 
something else in mind?

Ken
