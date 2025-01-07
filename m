Return-Path: <SRS0=Fz1a=T7=cornell.edu=kbrown@sourceware.org>
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazlp170110000.outbound.protection.outlook.com [IPv6:2a01:111:f403:c102::])
	by sourceware.org (Postfix) with ESMTPS id 0AB313858D26
	for <cygwin-patches@cygwin.com>; Tue,  7 Jan 2025 20:59:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0AB313858D26
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0AB313858D26
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c102::
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1736283583; cv=pass;
	b=C/2VVUW3awAlteQDwbu+e1iYTZt9a5P2jlBr8r0bVWaEolzlvc+51QhK8RuOJx7wQlWKpuF4bORIztvUee1GgDbLCsDjQ8A3TjbO+GITAlWE2ZHrtgVNVZRR5yW6zn4aPtiHClkyScVLzMrgqwc/KwV9m1uj0abCVK8eqzlLuLo=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736283583; c=relaxed/simple;
	bh=mjMC8kD1YqBHQelLYoefVV3DRgzOIOt6lAq10jrJQhc=;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version; b=rDy80zOFyHJZHlp+ukKINrus0SWw5DEXpPM4E1Ku3b5BOAeUs96svWGeZmHNOYikUIted9X1hqg1/e2IL/2d1S6hWz/kWLLsdNxxgr5puT18zskMAa50qcODesZntbKmHczNjFRZz7yP/lo4WIBXa83LBlrFXrEBWjH9M03vy+4=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0AB313858D26
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=cornell.edu header.i=@cornell.edu header.a=rsa-sha256 header.s=selector2 header.b=bpP6Wg2I
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWFTtFQLXBlz84KkH49868lsR5aK1c4wudXpDcVHY41z37k7y/M5T7HJMw1tNI+1CVLnBYFzoMQw8lSHeaASZDA5vXBr9Ss/HuUNwDQsDitaiBUSzJBOK8UhI340w/Fi3gbQMwvyAfP/gohngUj6hW7s5frTbJYv6aBPdAFu2pXNpuf/hJ8idSSanp1qZVOZqqR6fg8kWOr6WfyrHeovuMmiNe2L8r9Ekhz6YSa8SuN3t8/J6UXr7pVQd6uJjHCh0oV5YAjoTs6EUWKNpPpOWAVHJRsPuZ90aP40KmZOyIIQZ3/icgJW1YZI++FON0pKfINTyOCTKlw+vaEhMFe/6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKJZaRLPbEuHUCeEz/JDNTEL/np54lgfxD+9u1I3qnM=;
 b=rwZ1K641F/8FvzV2AOLl+zymAzRg6cDNtBCpEd6mr/3CvYj1LM2xlmZJe5yT6JjiZp/gEh9e2LLnAEfS5DSq//GdqSF4FQBUgjg8qFzlGdSkenlw9Hs56k/LPW9qXUAD4SV7SUaLu1NQOjjyp18sV5xq6/1v0Fb/l5Hq/QERtNBpbkyjooyagaDy1woYtZ+zAq5rhbQDFLIDDkbG62ZbZARr/gfmXanINizfrb4rnTE/foi9lVcwZ/nLefYBtTMYK8IJb6vostOIOjDwnAbh/SuAQwiMSzzr4sAWhDqu9rPyHWLZBrBLSCq1peiHtk8Q+lEKLfCsWxPozB1HJRfuAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKJZaRLPbEuHUCeEz/JDNTEL/np54lgfxD+9u1I3qnM=;
 b=bpP6Wg2ItB5U9fj5bEdYnLpuL1I6OCr72RhenVacVc7dvUWnqgkqoqz/awIMA7dRf+bE8VJxegXVA6JTmHe5VdNpH6IZl86dt66DyzdNGhEpcLCpaQ5AvP77OGyWSOAW/xCK7cYQuT0EZUbNOe7geb3UmFru64SoiSK/JMsGlnY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from SN6PR04MB5151.namprd04.prod.outlook.com (2603:10b6:805:90::25)
 by BY5PR04MB6439.namprd04.prod.outlook.com (2603:10b6:a03:1e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 20:59:36 +0000
Received: from SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd]) by SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd%6]) with mapi id 15.20.8335.010; Tue, 7 Jan 2025
 20:59:36 +0000
Message-ID: <79affce9-2a25-46fb-ba50-49dfe7cdb58d@cornell.edu>
Date: Tue, 7 Jan 2025 15:59:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Cygwin: mmap: fix mmap_is_attached_or_noreserve
To: cygwin-patches@cygwin.com
References: <c1839ef1-b250-4316-8e00-a8e2d73fdcca@cornell.edu>
 <Z319WIrQbXPsOakT@calimero.vinschen.de>
Content-Language: en-US
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <Z319WIrQbXPsOakT@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR07CA0013.namprd07.prod.outlook.com
 (2603:10b6:408:ac::26) To SN6PR04MB5151.namprd04.prod.outlook.com
 (2603:10b6:805:90::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB5151:EE_|BY5PR04MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: ddb382e2-f0aa-479c-873b-08dd2f5e3195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzJ5ZnovaXJybFV5MC84SkNOSHZnakF2Z2pES21wbnZVVjlnQmhIeEU3Tnhl?=
 =?utf-8?B?eVNxZTBRVm1yYktFTFl4bWZLY1hsNXlxRTg2QmVKTEI2ZTdaQnJCRXIyNU9W?=
 =?utf-8?B?SDFsSUtRQW8xc3AvUkRxUFB5WjFKNVpOWXBIKzV2NXBUSG1YSnhLQVFDaG5n?=
 =?utf-8?B?dUQ0R3FMYWk0ZWVQTnIwVUJ1NmtrdkpYMVdOK0pib0d3ckVBS2tGRjNvaHls?=
 =?utf-8?B?WnZ3YWM1S1BsSkRDeDZIY1FOaXFaL3ZNeHE0d1E5Uzl0U0xBM2FkT3lCOWMr?=
 =?utf-8?B?K0o1WFMyU2wyeFkrNVFoeEd2MUxHZ3BsbUZSUUVFNENvZjU2TENUb2VBVGpw?=
 =?utf-8?B?VXBKVUUrS2hsbHRySGpEdjlRQmJ5Y1NyTlkvY0RJOU1vakxHZXZkZEM4RmJJ?=
 =?utf-8?B?WmlCWjVFSllBRm5lUnU1Y2FNMXFtRE5UdlpDSVQ1SlYrbkI1OGFoeWpsNkdO?=
 =?utf-8?B?YTcyRTk4K2NrRHlIanJYREVYbFh4NlZsV3pNbDFmdllqb2d4ZzhsRXhEQUZF?=
 =?utf-8?B?QnBNY0dSYWRiZUJqL0RDTWxjdUV6eGo4SFRibUJWdzFqOUVoRmg5bW45OWFU?=
 =?utf-8?B?bERJbXRqWmt5aFhXRjh0UDdsZitXZDZIYXlCZlJmV1BsVXdiaXRUaGlmcVAx?=
 =?utf-8?B?SnRYVXhodW1zT1FZMjhnUEM2bWNkY1Zib2svYjZwa0pISGR3SC9FMndGc3dR?=
 =?utf-8?B?UzJpUVVuRXN4bFZVOHZDNnhLU0lOWjYxT3JHWmVDd09mR3E4YnN2ZzlKTEpC?=
 =?utf-8?B?WFhmRkpHY1lMU0ZCcWVlSlJRMFVpZXI3NldOUVpIQ0dyR2pmcDU5M3ZuanZP?=
 =?utf-8?B?Sm5iaEFVQmxwRnlBOFA5YnVha000RzVWUlRlaDZhRU1BQSthU0NHekdrdHVm?=
 =?utf-8?B?d1N5MGhzc0pKSEJOY1llbS9HRElpQjRMSVNYM0F5WHhnaHBtVWdEdDRoQXRO?=
 =?utf-8?B?cURTb2huU0JiYUVMYVUyZTNzY0VCQ2g5RktsRXZ4OG1MdjVYdmNSQnRLMTVv?=
 =?utf-8?B?YzJubE5KQzlmdVB5Y2JwMEpvaDhESTRDdWJRbEJWTDE4SDI5MmpGbEtuWHhL?=
 =?utf-8?B?eDg4KytRYnppdHVhUjBLQSsrK1dwSHVYVFlHU3dlaUczVFRxbXpwWHVhRzJR?=
 =?utf-8?B?QUp2dDlNeFByQVNMSHdDM01KSWdoSjhlWERRMWYydHVLK3UxNjVMb0M2SUNq?=
 =?utf-8?B?bngxYmwyRGR6a3dqN0JoNHpzVFIyV3pwRHdJOHpTWTBJQ2dQWm1GMEtLMm5E?=
 =?utf-8?B?VkU5Zk1VQmUvMXh6Q3M2QVFESHc3L3RiSXpKNUVrLzVEUlJWdGs5aUU5Q3U1?=
 =?utf-8?B?UGtpM3lCenBwWEdVTDhaLzdiRU9POTFjMWs3SlZrSUx6M1Mycml4aENWczA2?=
 =?utf-8?B?UWRrUkFlMnAxRjlHMzdlRFhLYzhJZzFENWd5bnhIN2w1d3NmenZUMUtBcnF3?=
 =?utf-8?B?QmNKMktyamFuaFBZT3NaTkVLOEEwc1pkT0FWWXAyekdEWnB5Tkw2TFhmcmxS?=
 =?utf-8?B?Zm9LbUxYQ09TZC92a2RnRk9FSldxWDk0TDNZVlRqM29rS1pkVUdDU1FiSVR0?=
 =?utf-8?B?ZE9DSzBzdVpMMTU3a25DbTNoVnJVS29xWlJRNjdDSHBFdWZ1a3UvRFEvREJk?=
 =?utf-8?B?U1dRc1hjb3h5Y3kxTzFNYWx1VXlWdUFVbkRpZW9IeUVVdG9wWm9GdWFvUnJI?=
 =?utf-8?B?YXhXWTd0ZFM3UmE2SjFjSjNsa1Rsb3BreHZkWFVoeElVTmt3WURnMm9iTEVo?=
 =?utf-8?B?eWZGNnR3YlRQNkUxRVF3QitzRmFhejM5YlRMa1R0eUk3UHI3VEZ6aDRJWnlw?=
 =?utf-8?B?S1ZLdWdHMTd1QW0zR2YyajROZVM5d3FHTDdhRFZTKzd2ekJUTmlaRWthZXlE?=
 =?utf-8?Q?d95Woi8SKrV4P?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB5151.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWtlbDBERE56YjV3eklLeHFtcnprNnJGRUZyL2tTUmdkV0R1bWMxYTJZYzdy?=
 =?utf-8?B?YVhUM2V4c0JSQk9JN3FKKzhKb2VBdTZuK3JEb1FaZDBxZTFCTlhCQ20rYXV3?=
 =?utf-8?B?OEp4Y3V2Z2NhM0JvVWc5S0IrWGV5Ynljcy9oWXFwR2hMS2hpNnF4WVYzeHk3?=
 =?utf-8?B?UkVXNVNkSG5qaVYyanNaSWV5Yi9XbzdocHltNXNwNlFwVVFxcjVYbENUd294?=
 =?utf-8?B?bmZBZHR5cmdzZmhkNkZQbWRiclRjS1YxSVZIbmthTmYzeXBTYkRGRDU4Mlh1?=
 =?utf-8?B?L2YzYjF3NGtDc1VPN3oyR0tTR0xMRFZhODM5ZVBLbk1OdWNtZmttYUdwSUh5?=
 =?utf-8?B?d29QRmFKWGFKTitCeXNZVWtQV2lpdllwSmNScjlDRXNBSnhkUm5GUG1XRTdE?=
 =?utf-8?B?Lys0TkgwbWloNWxnR2xxLzZHMWJ3aEt2Qzl6TkJVQ09TTHlKL05OT3ZzS0Np?=
 =?utf-8?B?Um9pNmNtc1lXb0RUMEZBczZDT2NCYjdTWS9SY3R4SzdNK2R4dU1ORFE5dGs3?=
 =?utf-8?B?TlJDL0ZGQnM0RktiSW9qVUpBN0I4cE1UWHdOVUx2dXJoWW90VU1nekp2eThx?=
 =?utf-8?B?V3l4WVVhR3UzYjgyS29jekVqNnMxMXBYZE0ydmhESjlPOVZwZmlpUmdSYnNU?=
 =?utf-8?B?OEx1OGd4elAwK0p2MkdSRXpwL3YvaW9XL0dtRXVFbG8yWTRXMFJaWmlZalpL?=
 =?utf-8?B?SUxCV3doUGt4STJCSGFiUDZYVU4rZHozcXprNmlSVEd0UExXNWtST1cxM3NU?=
 =?utf-8?B?OHhOV0d1UENOL25TUE51SGkwL1ljcDFoUU9UNEpOeCtaQUNTUFRnTmxxekwy?=
 =?utf-8?B?eG9ZMmg5ZUJCZ1NUNElySlcwenlnYk9XZkR1ME5ucHRSTlZ5OUc4TzR0SVN6?=
 =?utf-8?B?Y24xMGVRM0FmMU5mNmMrS2RDOWFPbjBoRFZZbjVNYXJxa0w1WlRrQUhMbWRZ?=
 =?utf-8?B?VGN1N0s5aHl4NGRvajZJcnp1SXRYQTB0VVVxWVYwZ1BZeTM2cEVXK0xUVE0x?=
 =?utf-8?B?dFg1WU1XQ05LQWJ1c2Z6WDlBUllaVUNUNURDV2FNZVoxdmh1VzlESXBpMmJn?=
 =?utf-8?B?OWVzWDFwc3pyeFVZYTBqLzJveFF6SnlPWU43TE9Cc2NzblRVOW9zd09KVUhF?=
 =?utf-8?B?SmV3Q1Q2WXMrRFlRakwvZVlVUnA4Y2dIMnk2SFg2ZVFFTW1HYUhmU3kyYmRY?=
 =?utf-8?B?b1VGYWh5bzJHM1ozOEpUVzJDL2tvUHhqTEY1N0dIV1YyZ0VuQkk0QzRwcnpk?=
 =?utf-8?B?WjB4V3ROZ1p4N3BUTlhTMEoxZEFqZjJjMS82S3lkTGhaWUFmRUdYb2IxS1hP?=
 =?utf-8?B?cDZjZkVvRjZ3UEZ2Tnc4R1pwNHlSa3pybkRqY2hJajVPb1ZwWGl5eUpwU1da?=
 =?utf-8?B?ak1BNkVCdE55ZUpkVXAxaC9HUTFRMjBwWEtyS0hKSjhvbXB1NEFFSnZyOGtN?=
 =?utf-8?B?VUNFaEdJMC84YXNZeWRlL0ZXanZ1RXpYQkNTNnhCeDJvZDY2WUNpMWZwRy9m?=
 =?utf-8?B?d3NFTTJsNnFTQW0zYjZqZVBNaml1Z2g2NU14azNBM2N2VlY3ckdPNUhoUGwr?=
 =?utf-8?B?K2I3VE5FdlppS3ZyU1dLK1dnMURZNWk5UnBxVEtManNQbXppUXZyRGlIT052?=
 =?utf-8?B?Vk90b2VkeHFtbW1aYm4yRUxNbllqS3EyUE9DbEtRb0xaL05WaHBnSkpNaElo?=
 =?utf-8?B?Zll6ZjlGTUhMeUk0ZW5sSktFeDNyQ2ZuenpVTVJzUlJvcDNMT2xZWHl1Z3R3?=
 =?utf-8?B?MDBvakhKQUxWWlF5V2hLWEtJNXJ2eGFIMHdwdFFvc0YzeTZ6VC91Ny8zSlgw?=
 =?utf-8?B?QmtoeHF2NVVFSWJzOEZPUmcxU3JqblZSVHJyQU91Zk8xS3FkMFp0Yzh3M2g5?=
 =?utf-8?B?c1lTOUdKRldTNU84NEE3L01zMHQ3YUdseWhoclpja2VoQnkrWmpia3IxMm1i?=
 =?utf-8?B?ZnZHY2FobytPY1VONXE2WXFRY2RCM2NwTTd6dXRYKzlMNFNtOVN2UkF2VTBm?=
 =?utf-8?B?cDFxMk1ZU0hENjUwdnBDNk03QXNsUDNSU1UvZVZFaUk2eFo5Y3ozSDZmMUp5?=
 =?utf-8?B?aXdVbHZzdlJUNlQ5YkZLUmpvajROS2I0RS9vSEEzbmJaaG1KU3NOYzcxRGpk?=
 =?utf-8?Q?CfMaeakN8rVDIYGCK4spQM6i8?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb382e2-f0aa-479c-873b-08dd2f5e3195
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB5151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 20:59:36.3554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o3bQiyxy+RCZfasYaSl923kr9BwkUscTkbCSJmzQScePjaWZ9HmXJE4IV1SHd8rSRyc5naBOsDG606DBUb8lhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6439
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,JMQ_SPF_NEUTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

Happy New Year to you too!

On 1/7/2025 2:15 PM, Corinna Vinschen wrote:
> On Dec 27 11:46, Ken Brown wrote:
> Your patch looks good, only...
> 
>> @@ -784,23 +788,27 @@ mmap_is_attached_or_noreserve (void *addr, size_t len)
>>   	  ret = MMAP_RAISE_SIGBUS;
>>   	  break;
>>   	}
>> -      if (!rec->noreserve ())
>> -	break;
>> +      if (nocover)
>> +	/* We need to continue in case we encounter an attached mmap
>> +	   later in the list. */
>> +	continue;
>>   
>> -      size_t commit_len = u_len - (start_addr - u_addr);
>> -      if (commit_len > len)
>> -	commit_len = len;
>> +      if (!rec->noreserve ())
>> +	{
>> +	  nocover = true;
>> +	  continue;
>> +	}
> 
> What about merging the two conditionals into one?  E. g.
> 
>    if (nocover || !rec->noreserve ())
>      {
>        nocover = true;
>        continue;
>      }
> 
> It's a minor style issue, if you like your version better, go for it.
I like your version better.  I'll fix it and push.

Thanks.

Ken
