Return-Path: <SRS0=a31X=UD=cornell.edu=kbrown@sourceware.org>
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c110::1])
	by sourceware.org (Postfix) with ESMTPS id 14AA6385829B
	for <cygwin-patches@cygwin.com>; Sat, 11 Jan 2025 23:43:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 14AA6385829B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 14AA6385829B
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c110::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1736639016; cv=pass;
	b=MXcj2AaKTZ3w/n63L5a7J5KzAzRc8epxy3VZzaFW0nV3pUbjUYIfy8ULZFcMcgL6p1cXUkrl4PGAjk0/Nup1l+ziJjBjKpaPP/1gAr9BJAauo67tJS/FL84BUdcaqXNRm9Lb39XXXtbjYDXfkVtzo5YW15WHPAs5jjxDuHeYdmU=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736639016; c=relaxed/simple;
	bh=2nwp5KB+jlUKmGvJADO4aPFs3g0sO8RJhbOyk+ntT/Y=;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version; b=YgZ61fG4IMDJe+CM6FYu8sX/iI388WVDrYa1JwZQKNkMt+2Opwluc4F9/KSeLrth572ySzvrLmzE2zi72AtE4YQS+ehLsY66CDvZ45Cpli0zTN5vJh91ROquMv6QtbVCpiKVdOjQI2+zb6Ca+L5Je464WbA9uQ00X6l1/Jl2Pq4=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 14AA6385829B
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=cornell.edu header.i=@cornell.edu header.a=rsa-sha256 header.s=selector2 header.b=GEuLacCM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nk/XVQf9iWnWsFWdHVgafxdb5RjqXM5AmYQ01sFB+00Y2VLK5Z+2FIrLwit+PAu3FtPpew88/uq1WBsdve/Ir1jF8cA5NDC9dEWJii7IwfYh0HwXK321KN/iLJZtmCJAyqhCxi7yM5SzREbh/RIb/iFVrouleEwibDPEt177w8ky2nOWa8buHTpZs1dDKaaMfk/fKCHsfpYi9vVG7kK/Dk/VbPGboZD6pvpYTA2mxluI+NQScw2OkRawGPlnfuP+BLLv5Hpfi14ctVXEYqwVqvOZWoQMX+GGTD3d0xHxy0qeCo0tAo+RLw6jUc/XPT+ReRXGZQ/e6bIRYRPrwKew8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLnEzeGkoiqB3E193stjPCENfYxrs9RxUwTyoQhzsWM=;
 b=dYFF9byaL9jT2bgg+g6rs3BBoARNO5PKyCTWt+UrWTqq/5fmJe6Qdowc6BvmtsCclg8+ol/9xYnymRSz9AbUwCbqBY8p1RfOtDXmg8b+f99zJzV9CWg/ROAtsSLFACiUo5/hkDt0Zv0rHO9HSstv4806i1BSbKIq5ZIvRh1ZVHqbu0EwpP5kONRGPntuTaZ0XzebTmX4EAkreJYiyiP9q9Lr5Hck1TfEt4S2r8OxpTBzx+IrUnAIAAHubWUPh4BcfafLnGs5jTi5DJ8WIyXEo87DcoI/G6DDk3R6wX1Qu8QNKEI7mEsWPFw7L8u3yNG59mWV1B13syZ2EHRiUyzbVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLnEzeGkoiqB3E193stjPCENfYxrs9RxUwTyoQhzsWM=;
 b=GEuLacCMvpv6Wtxv19+TpWh1AGT9urEeZUNbKqaCDUbwLGucev/uphNr1D1tTr53MmFJs28HIiBtP/lTLOty/4xy3LeL+5rT2SDDvK6nm647KXA4fBsB8E6vEJ735JqxrgY9+2whuxhkJzHkfcHKMLstMWke1p4YsS4rilTh0J4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from SN6PR04MB5151.namprd04.prod.outlook.com (2603:10b6:805:90::25)
 by CO6PR04MB7794.namprd04.prod.outlook.com (2603:10b6:303:13f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Sat, 11 Jan
 2025 23:43:32 +0000
Received: from SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd]) by SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd%6]) with mapi id 15.20.8335.015; Sat, 11 Jan 2025
 23:43:31 +0000
Message-ID: <05430d18-35fd-4957-8277-5ae3077b3bf3@cornell.edu>
Date: Sat, 11 Jan 2025 18:43:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: mmap: allow remapping part of an existing
 anonymous, mapping
To: cygwin-patches@cygwin.com
References: <a9ebb720-13a9-4903-adfb-ca0ff9a4d82d@cornell.edu>
 <9b717926-06fb-4d34-a473-a709316de429@cornell.edu>
 <Z32MB5VR4vCszv9J@calimero.vinschen.de>
 <de64c367-6695-4109-bbcb-591356a7470e@cornell.edu>
 <Z36Yr7cdOFXrWt2h@calimero.vinschen.de>
Content-Language: en-US
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <Z36Yr7cdOFXrWt2h@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN7PR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:408:20::29) To SN6PR04MB5151.namprd04.prod.outlook.com
 (2603:10b6:805:90::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB5151:EE_|CO6PR04MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: 2783eb50-7619-4155-7365-08dd3299c16f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXNBU3FZQko0Q0ozUVFDUGxpekJHTzhUbmJCbWVuNXFiU0M2M3FrL2kvckNE?=
 =?utf-8?B?ZWJ5RzcwVGFoRXg4L3NjbGZveTY5clRIcWRKbjdQK1FIU1YzdEdoY01tOS9q?=
 =?utf-8?B?V2pFMHJ1Z0N0ekY1S2dDbkt6aFEzTTVTNlBjWm8yMHdzME9tZzUzSjV2MmxN?=
 =?utf-8?B?SERPcE1Tcy9pcHNJbjVFNjJDTmdDTGNVaURaaVFiSWswMS9WU3ZMczRsbjFK?=
 =?utf-8?B?Vm8vcE43cjUwNGQ2QkZhS2JCVnl0QTV6aHRtYzdyZTIvQ0E4N0lPa2lGYWpt?=
 =?utf-8?B?b3drb2FoNVFIb1dzako5QmQ0MHYrK2pOcGtWUGhlMEtVMzYxL21nWTRFS1Rs?=
 =?utf-8?B?Si9YOWJhQzcyOHlIZWdTeFQ3Wmp5aEhGdk1nbjlZdDhKNTZwM0pwUjJYOEt5?=
 =?utf-8?B?bHh6Sy85WE9id3VKaytlU3pPNG90bUZtaURUY1pMTW44Tk9xRFJnb1k3Q25K?=
 =?utf-8?B?S0orUzBoOVJNc2R5bFVuOHBYemhxQW1IS0cySjgySVEwUStvNVRITUJhb2FZ?=
 =?utf-8?B?RkxZeWxZUkowdjVuUTBEYVR3T1M0bDgwblVXWldhZjV3NnhINTd2dExydXg5?=
 =?utf-8?B?V05haU5TQzFQQUgweDNHUXo0WDFPNExIVCtqTDExRWlYL1haeWJheHVjcjha?=
 =?utf-8?B?TmFNelZnU3hUYStVWEFOYmJHRm40Rll0NWRnQnl2aDVvUlRESlVJQkMxZjBx?=
 =?utf-8?B?em53ZHVUL2F0YWNmSDJpSWVNRTFqK1prUlZtd1ZLRkx4U3ZPK3AyTnZ0TjR2?=
 =?utf-8?B?WXhYTGxyVXRHNWJuNWo4NzZxak92WnNwUFlhcE1abjlnOHg3WkFMOW5NUmxs?=
 =?utf-8?B?bDRIYTlJR2JUQm10eUNNWmdwVFBBZURCRFhZMmlCYXl2SzlXcnZ1QWw3ckg0?=
 =?utf-8?B?Rk5UV0I0bllkR3d4bnNjRkhWazBZdEZnQkU5RHBQbTBwaERERkpqRkRMRjd4?=
 =?utf-8?B?ZzVFYndiaXZGRFZBK2UzZWVRaThWUmozWWdRZW5wRnRjK2dteHB4WFRENUZk?=
 =?utf-8?B?NmNjeTgyWFA5WVZObHpSU0ZFZjRPNDZYZSszYm02OXZKZStCT0pVajErV0lw?=
 =?utf-8?B?Z3BFdUJSd1FjSitaZ1YzcDRxQytaalRWaWliMHRPUFFsLytlbFRPUm1ZYTZp?=
 =?utf-8?B?Z2x0R3RsWFlyMjRlN2dHS04zTlY4a0JWZ0txd29rY0ZhYmNUcDExUG1xeDN4?=
 =?utf-8?B?TFlVMGhvK0NRWXpWMlByVGtvNFRrc2trc3FpQUhCYTlUeWJtd2VQUUlxQVMv?=
 =?utf-8?B?am9oWnI2OXovQkk0TGtYTWlNbXJZbHJVaDZiZjFaS2kzdDZ6c2RTSVIrcE5R?=
 =?utf-8?B?cjZwRWV4SDFYL3lZMksyWlFnK2lBL005d3MyYXY0cFkwTkJwSk9MelRSNUpp?=
 =?utf-8?B?aUdZemphVWViR3VPbzBLVndFRjJnRVlCV0orWnpEMWtpbkx0VEhkQlJNSnVN?=
 =?utf-8?B?MXZIdWFZN1dCdmJMMC9VVHd3TjFWcnpQVjhWVERxQWpGakMrb3VwOEhEVVZM?=
 =?utf-8?B?di8yb25vcWErUkxqMlJZa2JvYkxlcHY4eWpFOXpTSVZPRU91K2I5dmxPM05j?=
 =?utf-8?B?dFRNdk45NkVIQU5OUnkzdmZjZXFKMTEvMGlEZUhJS3JhLzBjUHdNSC85am80?=
 =?utf-8?B?a24yeGdzSGlFVGdrWGJRVi9Wb001ZjJxTVE5cU5iQXpxYWtsN1FwamJ0bjdR?=
 =?utf-8?B?T21PK2g1Z3RYR0ozV2s3MDRmYmsvMGJROS9tOWUzRlNrOUw2REJWVzFndDJU?=
 =?utf-8?B?bmx6SFpoaHFOSGZXTmtXNGJ3M3U0V0p2R2JTb25jaDFCSjRqUXRzRWFXUjdk?=
 =?utf-8?B?aHp3Zm0vYXZPTWVKNUdlVjIrdUtyRGh4Vmx6YUppUnFkUXRMK3h4b3dIZGxs?=
 =?utf-8?Q?OkJS8zAG6OblA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB5151.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVR3T1kwdTBlc1ZjVDhIam5yeWx3eklaaHZuOGhaZFhkNnJpd3UzWDdib0Ri?=
 =?utf-8?B?TkFEY0VrQWt0YWJzcHhjTTIweUN2K3ZRRUh3N1F1Yjl1UWFWQlhKSlVTSFp0?=
 =?utf-8?B?VVd1NHBGVUlHWUZDWklDUkRIOW5NQVoyQTY1S0lkZEpTbzg0WGdxOHV0RW95?=
 =?utf-8?B?Z2NmQ1ZpMEJtZnVFRTZRLzgrc2hUQjBZOTAvYko5TGRoMi9ZLzRpMGswbTBT?=
 =?utf-8?B?OXJIRTBaN2VtQUxoZXVaVUgrZVkxdWorT2sySnJGOVo3VTNyL0xLMThQZ2o0?=
 =?utf-8?B?L0ZhdXFBMEoyVDJzeWplWDJyQ0RJZVJXTjZhZXdtOVR2RHp6YitoY3Ayd285?=
 =?utf-8?B?U2c3VFkvUTVLMW1lOVdtTzFUUXNnbDhyRVZrZ1hjV09JekFyZjh5eDZUNDVQ?=
 =?utf-8?B?N0tBdU1OWWdta055d1VMVjI3K2lDeGdlUXZBK1VBZ2RoQWlhYU40bFNxT3pM?=
 =?utf-8?B?YUphT1R0YzZ3RUtGdSsreUo0RFQycHo3Y3grUjZFUnQrMytlaEVTZFJaVjR4?=
 =?utf-8?B?STFzWTd1OUEzVFlQZm9EMnBzMFdXaTdSR0dQR1kvRnpFNmk0bUlUZ0czNzJy?=
 =?utf-8?B?SnNtclpiZGRmTlpLdStlQjlJVXoyQ1lWdjZ0dm14REJYTW5FdTBHOXRQYXk5?=
 =?utf-8?B?ejl5ZXVVaTkwL0c0SzBieWVudkRaY252aTc3WUFyVHpQVEZSMUQ4S2ROUmEw?=
 =?utf-8?B?WDZqWHkvQjg1OVQ4cnIzRkQxZGpLQmxlUE11QTFNbm90MDdmc3NBem1lQnE0?=
 =?utf-8?B?Ni9sdm52MVl6VGxXKy93NXBEYy9kbnlXRlpIblVabG5LMU9KYis5TlhZVEtu?=
 =?utf-8?B?VXZDMDVVTjUrQ2xQek5uOU0rRGNtcU1lMjV6dDJHMUROWVFBRFRjdHBVMTJK?=
 =?utf-8?B?a2hGenFwbFhFRnAxMlFEdlJtYzRPQjhFZjNJZndDazlyVDltOFpUVWlTSC81?=
 =?utf-8?B?ZEhjc1k1aHJCZ1NHWVVzcG1iT0hjOHJQOVFnc0hiOFRYWk9KVkZaL1NralJy?=
 =?utf-8?B?cDFIQUR4VXZuZUJ1VEdlMC9FVnNHY3cyRWhzMmVZZ0xuYVZBa3lJVlZaQTh5?=
 =?utf-8?B?dFkyTWVaZmREbzVUKzRkdGFFNXNRa1RDZUs3dDJyai8xZ0h1TEpWT0pNZDZQ?=
 =?utf-8?B?WThqR3dmWUkvTEc3c09lRWExTGpKTXVlRUQ5VHNqaGkxVVY0WHBJTkRmYVM1?=
 =?utf-8?B?aDVQTnVYK3lmTk00d3gxTHhuYlZrTkdRZlpJRlk4ZW1JNzNvcW0zOUNDeEg2?=
 =?utf-8?B?azVTaGhVWE05ZC9leUxaQVRWM2RzbUQzRHRreDFSdFNwckJBcUJieDdXS2tN?=
 =?utf-8?B?QTI5YWlEd0NNZFhrWEpJQnNrOSt5QVZ4RlBiOTR2R3Z5ZWk4NGZDb3pDTTY1?=
 =?utf-8?B?KzU3dXpkM2NZNFhwT1dLYnpzc3oxUzlreFkxbkt3bm1Wa0VSZmlKc1cvUTNG?=
 =?utf-8?B?MmJ2Z3U5TUROcXB2NnJ3bnEya2o5WmwwaWNaMW5PYVdXbHJsTlYxL1hHQ2ZL?=
 =?utf-8?B?a2d2OVNxZTdKZ0c0aVBacnpCRU1lTkFCQTlRRnhvd2IxcUsvVERVQWhkQ1k2?=
 =?utf-8?B?YlY3ZHhQcCt3SFgvQWN5bXZESUV5Mnc0ZjhMQi83RGxOVVh4WS8yRHZ5bENR?=
 =?utf-8?B?S0NXRFV1ZmRTR2hUVmozN0RRSXJnQW5qWFBGbTFkY1JnblFhZzlSV1lWNHhx?=
 =?utf-8?B?aFA1eHl6Ry9SVVJUNTFBSjd2ZFF1ZEtJL2RaRzBMRjROUlNYNitsMUdtaG1y?=
 =?utf-8?B?YUpRbGpybXl5Ync2VnlOTk9hL3VtelhaU2kxVzFUdUpzd1NnNGtGQ1NaYmpj?=
 =?utf-8?B?UTlBcVhMNTB2MDZTRWtkbXZwT0UvN3dWOVZWL1dtTVNpdnh6RGJ2WnVvNHVt?=
 =?utf-8?B?ZS9XM211NlkzWW5KSG1RZlpwSHJBQzBwZkFqUDlyaDdTbGZVeE5mWkFKMDdI?=
 =?utf-8?B?alpYOWVlby8wdy9BVTZPTTVTSW5HZHBwMDR1Z29oQlNVbHkrTDIvekN4K3M2?=
 =?utf-8?B?eE4zU2UxdGdjd2p2Ymp5QS9zMWEwVVZvdkpoMEc1Sk1nVGhFRkVUQ2pwYmM4?=
 =?utf-8?B?eFMvOHdDakc2RE05dG85MDkyWWtKQzZBWCtRamFheTF5Tkx6V2Z5aFRva1Bu?=
 =?utf-8?Q?fPPlPC91fvQPTHmFvZBieXDN1?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2783eb50-7619-4155-7365-08dd3299c16f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB5151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2025 23:43:31.5259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0wZFTE5Fl5ZZ7Cv63PyhMQpYHbtU5LZQNRslissdbfm1WfcDg3yHlWIKplq1wTBxSH0IN8ibYm8XUe+fVo4wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7794
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,JMQ_SPF_NEUTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 1/8/2025 10:24 AM, Corinna Vinschen wrote:
> On Jan  7 21:27, Ken Brown wrote:
>> On 1/7/2025 3:18 PM, Corinna Vinschen wrote:
>>> - mmap_record::prot flag, should be an array of protection bits per page
>>>     (POSIX page i e., 64K, not Windows page).
>>
>> Question: Since it only takes 3 bits to store all possible protections, do
>> you think it's worth the trouble to pack the protections, so that each byte
>> stores the protection bits for 2 pages?  Or should I just use an array of
>> unsigned char, with 1 byte for each page?  Or did you have something else in
>> mind?
> 
> I hadn't thought deeply about this.  I had a vague notion of a ULONG
> array to match windows protection bits, but, as you note above, we
> really only need 3 bits.
> 
> I don't think we have to define this as a bit field array, given this
> isn't readily available in C and you would have to add bitfield
> arithmetic by yourself.  So, yeah, a char or maybe better uint8_t
> might be the best matching type here.
Another question: Adding this array to mmap_record, we have two flexible 
arrays in the class: one for page_map and one for the protection array. 
My understanding is that a class or struct can have only one flexible 
array member, and it has to be at the end.  What's the best way to deal 
with that?  The only thing I can think of is to use a pointer instead of 
an array for the protections, and then allocate memory for it separately 
when an mmap_record is created.  Or is there a better way?

Thanks.

Ken
