Return-Path: <SRS0=rAGI=UB=cornell.edu=kbrown@sourceware.org>
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazlp170120001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10d::1])
	by sourceware.org (Postfix) with ESMTPS id 789443858D34
	for <cygwin-patches@cygwin.com>; Thu,  9 Jan 2025 20:23:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 789443858D34
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 789443858D34
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c10d::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1736454210; cv=pass;
	b=kVtJSjmi8RB+7glyXad4fxA1p7vo4Uk8HFTw3qYvHo4ezrf+/EZHN2gNFC/cRH1Z7P5IVvtTBllPgNkQVfDTxJpEI3YAwApQwlKBsJQr8xjy5FzcFHzxGNRsmirWFfgv3r+oJzG6kd2YQNnyOax2g4W4qWveYCMYLqQxhPcSHUE=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736454210; c=relaxed/simple;
	bh=JuWgml9YRDfKKCSl7W/oSSJop4Soi8Caz5GdK3mVq7M=;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version; b=q24AvhHYN0YuoZ+jKK/9xQtf525/P+u+kUzv05Zp8sXRIyzR73IyXn7Y8C0hf762ESn3KKCLBsobHiLBLag/xNm9cLJNBq2n7r2Pk/9Ae6uFUV6A4jzzvfwm+URYf3hq4E/n4riPxmgnr/qXbxRIca2fSCHkhM+w9DDga9w4NJo=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 789443858D34
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=cornell.edu header.i=@cornell.edu header.a=rsa-sha256 header.s=selector2 header.b=Fa9hWNwF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/4bWMrTNaWiAxBvQ1mhCQADGmKnxE7jixYw47MPoANUq7buItn7R8FDrZw9tvHIetOsggjHQdclNSDX0mrzGfJlzvZ2GV2x6mucnTAYgvM/l/GmbUj4gBhGb6e48W1Hj/KaXoQfXxl8/EKB+mqjujeoXjnIO9reJVOOMTpY3Q50vn5leb1kqjKXBkJ41LEiQ5mfP4nRuFOotLN5Al21o65LNxW8FJoo7oShLinMKm4JMhzMv+0ZcvK/HLuPb2rQxYVkuD2e+/1IhxEwUZ1qIhPzWiFNOae93rmnpZvNxgo5j6/uexHecT6ERJGTwwoV5BKFHReBbjZXlqb4vqgDFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBy94Se4om0fmAY2J0bz9gtpL2GkWXducUiGjLNy+fI=;
 b=AQoKmzknE8U9W7WYI4HsR3VSESGg8s6j0NO8qhVV0pNKlSz2A/3mGsSoDsdOjjsoJqwz6D3LNLgVngoVDDIUEt23jDJCOR/LETwMacEtiu2YgYUiwgiVFLiP24EmZx8cBEOj3bd1Dtky3K/3Df9EwEGbm9xaIAqu5FpHIYLDKFYeCcZtvWOaarjlPWMyoSlSMrJdImRrnj6jtPC8nBkheaPo+CbgNl7LunVvsiy3aPbfmqfgVdA6vyb0DavWmO6FZa1BaEOLB0moLbxGrOM/OK+3O6//EmLF0QIEjJYlxh6xKjd+GW4/6L+xTbXQxiNQqS08BrW3g5TitKAhVSBuWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBy94Se4om0fmAY2J0bz9gtpL2GkWXducUiGjLNy+fI=;
 b=Fa9hWNwF4KFd+MJA1H0pWYey1Kk/gBh+eebOxDgxHJeahcWQXeXohD52d7uRL8vCCTNM8xKpTRaa0EikuVZilKZgEGUD6u6M+Zy1PGEenh9Ie9EQ7mZTb45m1sBGvFm2FArYMx4kUA7O/8ig4ZmDalAxpgXcnSPuSgqr4Td6Yow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from SN6PR04MB5151.namprd04.prod.outlook.com (2603:10b6:805:90::25)
 by SJ0PR04MB7487.namprd04.prod.outlook.com (2603:10b6:a03:321::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Thu, 9 Jan
 2025 20:23:28 +0000
Received: from SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd]) by SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd%6]) with mapi id 15.20.8335.010; Thu, 9 Jan 2025
 20:23:28 +0000
Message-ID: <0c23a6a8-4b9e-4b7d-b4c5-70450558ec20@cornell.edu>
Date: Thu, 9 Jan 2025 15:23:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] Cygwin: mmap: refactor mmap_record::match
To: cygwin-patches@cygwin.com
References: <9d64113d-0355-4df3-b477-952c4f315292@cornell.edu>
 <Z4AEv4Sen6VqT-pz@calimero.vinschen.de>
Content-Language: en-US
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <Z4AEv4Sen6VqT-pz@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR03CA0059.namprd03.prod.outlook.com
 (2603:10b6:408:e7::34) To SN6PR04MB5151.namprd04.prod.outlook.com
 (2603:10b6:805:90::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB5151:EE_|SJ0PR04MB7487:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a95e6d8-d65a-4b26-367b-08dd30eb7a05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1doM0p0NUxTeU9sczBFUjd1SzI0SU9KOERmUmhDanF6M1BCcVNUK3ZNZEJx?=
 =?utf-8?B?SE1GQk9SV3ZZeVRtdkwyVnZwZy9BY01BTHUvUG5YazYyYTZTamx4c3hjdCsr?=
 =?utf-8?B?MkxWRE0wWG9qaU5xT1FnY3NvS2ttd1E4d3N1VmthTTR5LzNBS2NJMktSek04?=
 =?utf-8?B?WTdJcExMT05rVmhvejZ4MDVpOGpKZWdGYWhqbW44bGFiREhaQXgyQU5Sb3N3?=
 =?utf-8?B?OWxjQ1VETEo3ODBKaEV1UkFaaWJCcDY3ZURuNlF1NkRsbk5VS096VG1ET2Fk?=
 =?utf-8?B?dWlmZ1dPM1czOWtXZGovZ1Z5THJ1bWNaNGw2cENnbWg2ZjBSQXkwS2M3c2VP?=
 =?utf-8?B?bE1IajFFTFpXQlhJd3pjREQxVWVFemdpTTBKUkVPckczemdxWjIySDdTOWxR?=
 =?utf-8?B?VHRJNmU5U00xQURBVWU5NlN5UUhxejduNHZQR3drdW1QcG1yNnpZN0tQOE0x?=
 =?utf-8?B?WkZ1QWJLUWpFd2NDR2VhLzdLUlRaOTFvZlZsd1I1MjRiUFpYYVRDYXl3ektk?=
 =?utf-8?B?NHNBMUdGSEJBUVBib0pBZWk5b0w5THNHNzlWSHEzbHY2ZmlwS3B4bXNCN0w3?=
 =?utf-8?B?bEwvZVd2cXIwMzJ0eEN5RUp1Y2o5UTlNSE9DdjhlZlNoVVBDNWVoUzUrdGM2?=
 =?utf-8?B?RWpMckxKR1MybUZsRk1ZdGdkbFBwdVN0UTZPZEo3MlhsR21FdHVKM3pWdGlZ?=
 =?utf-8?B?dWhLQjdqL0FzNEUzSU1Cd0dCNVZ4WjNwOVU4OGwzdGo3VnM5MmhXNk14QWlp?=
 =?utf-8?B?ZE9iOCtPNlZJdEV0TVRYVUxxZUYxNmI0MUVJRlZ4aXoyL1FuYzZJSWZ6RW1Y?=
 =?utf-8?B?K2xVNzdrMzlBdlRoSEJrTjRLVTR5NE5RU1liYlJMdkRPcXVtR3pXbDNpcWgv?=
 =?utf-8?B?aVZwS2F5UVluWTFmY09sdGxkR0hoalZ5UGtyZk1lT1M2S0kvQU9weWcyTkZ2?=
 =?utf-8?B?cHg3d2ZkL0sxcGhrdmR4Tjdac1JKYzVzd1p2MlI4UUhPVWVmYlk0L3MrVTAr?=
 =?utf-8?B?aDFFRUcrb0ZxWk5NTnhBOEp0eEx2dXI0c0xrWU8xQXBmcks5RjBpTXROQkNM?=
 =?utf-8?B?ejFzTHd5bnFjb0ZkSlRudVFHSUlhM0x1WFU5V1NZZEh2N09WQnJPazlLUHNk?=
 =?utf-8?B?U0hRKytGckJ3SVlYbzUyUlREMkRhNWxIa1IxNTlldFNzUTg4Y1hhUEVrSllw?=
 =?utf-8?B?dWxaQzhPMlorbXBiRVgyUVhvYmtLdzFaNUhITDZJUlQ0WlZweG5IK1VpQmlr?=
 =?utf-8?B?UjZ6cU55VVZyL2hsM1Zrd1QwYU1ESHZaVmp0L3FiUHBsMWlucXk1cTJJcGFL?=
 =?utf-8?B?VEthblNuQTVRN0JlV0lCQkk0SkhZeWtvTGxWdVpIY2hCRXhoTDJZVTBRYkZa?=
 =?utf-8?B?b0JCSXpuUzdtNmJ1WmpJUkMrRU9ZZWE0MlgrMjJnbG5hUkVnWTNoSDM1c29M?=
 =?utf-8?B?cDl2U0FkWUZ2WkkvMk5UU3pLWFBrenBBaWJjMWtmVkVzYkFXQitobWRNTFNt?=
 =?utf-8?B?YkMzeUtUNnExaDZwWXVBN2lVc3crVTVKN0ZiZXR5ZmhVV0tMcE9TRjF1VThP?=
 =?utf-8?B?TUJoTm81RDZhRkV0bTJUeTVubTBnTmFEMEROczJLRDlaTCtkcmd1aDh0V1do?=
 =?utf-8?B?Rk84N0ZhRlBpRTE4MnNMWjZrUkVrZkthRW5BQ2xZWDBpNm9lRG03aFFQVkpk?=
 =?utf-8?B?MFlDbUNKUVd3U25HNFJMSGhFeHJ6UkY5ckc5UHFmYnhia2tEL1YzZ093bURO?=
 =?utf-8?B?SndYUjVhMWQ2UWs1Lzg4UEQ1dWp6MGVZYlZYRkRlTUtWVUhUU1RGSXFQU2Jp?=
 =?utf-8?B?bEo4eWxKcjhGT0RZK2gzSEZ5bWd6VXR2amg3R1psYWM3dksybmdldHFyNkFl?=
 =?utf-8?Q?6her7wLy8kEYP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB5151.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXNPTTNKVFprNTM2dTJQdXd6TjNBWWIxa29LQk9DcnpDRytQOTViQTBIakJU?=
 =?utf-8?B?ems4U0o0ZW15bXhLYWFEcVBWTmtTT1JwQXBMd2J2a2MxcDgvWTVCUEtuYlN4?=
 =?utf-8?B?VEVTVkIvbGhEV20yR2F4am90RlVsQUdVUjJKaDJ5WGM0TGNIWm5aOTZDbFBv?=
 =?utf-8?B?ME0xZlRTYlVORTlrc2k1QTFJMTF1czE5L0g3ZXNDVWhCWU5naStIREI4YUVI?=
 =?utf-8?B?QWNHN00xRE5HbUNmMDRWUmtVdkQxVnNsQmNaV2pDSzBZQUdqMVZnelcyZXF5?=
 =?utf-8?B?Q3NXSWdMdFFjMDYzUzRZK0E0VVplMWx4dHhPQ0xsckovVDVUOFMxTXljNmJ6?=
 =?utf-8?B?Mml1b256U2hOVDN3TllwWDZXL2VTUFQvVUhwK2dqM1NZb2cxUyt6ZVFiWXFW?=
 =?utf-8?B?SWI5dTFCMUR4OTAyMG42cUxKamNOYnpjQjBwemc4YjlSOXZnMFl6cjVjY1g2?=
 =?utf-8?B?VDFLTkNKTnJJUzZQOWYxc2ppLy9GeHNkenlZY0tYQUNLSERxblUvaXBpeWp5?=
 =?utf-8?B?TGk5L0lHWnhhU1FLcGl3YlhOOUFPSUQwVVcyMU9tTnhIUVFnZ1BQLy9FSmhl?=
 =?utf-8?B?UlVJVWFUTGhoUWV5Uk9mTFFMUGJJS281RzBtRThHemt1WWsyZzBRYkJYMGxE?=
 =?utf-8?B?Y09jNTQ0U0toRkg2K2RzdlUxWFB5REw2R3R0b1IwaHF3NFArWTQ1Ym03QU42?=
 =?utf-8?B?VTJzVmVEbERnWGdRQmVQb3RaYkRGZzE1OFBZRUd1S3J0VlZrd0NsS3FlYjNR?=
 =?utf-8?B?UDg0VFBaMkM2c1VaSFhmclZiUEJDL3hueGgwYjB1MTBtb1dYeUVsSWtPMGRy?=
 =?utf-8?B?S0JqVzJ3bStodkcxQXZSak9KL3NHenJJbEdpbjJtUWZ0bUdZL1doK0FMajlN?=
 =?utf-8?B?QkZNTXBZakt2eXJBemc0TmUxZE1GZlhMQjByVGYvMkxSN2hWN3d6b1Bza0Y0?=
 =?utf-8?B?S2VuZmxFLzE4dnMvbFJYUDBvQVZuZmd6N05aMFVWUXUxb0FVeWVXRU5NUk1C?=
 =?utf-8?B?QlU1ZGdEdk9rVlhlQVoyMUY1UVFKZlpKQUlJZjQvMnBtaDJuSlpKT3NCd0Vt?=
 =?utf-8?B?N0NKcEdGYWJ0UmpXYkl0SFdpcEtuQWpaMlZTOFJ5T29LTHQyUmkvdkhOaC91?=
 =?utf-8?B?NVgwYkZXL1lBV2V0cHNSVTBob0JwMXJjSnk2cysyNVQ5YTRHUVJBSUZQSjFr?=
 =?utf-8?B?VUpNWTRVSURVd2VKZVNUQW92K1hUYTlvSWYzSW1MWkIzUmIwWWJaK0hLRVlY?=
 =?utf-8?B?L1JIeDE3Uyt6bk13UTA5bjJWVncxSnVRZWF4U1pSSGhLR0w0RE1zbVRwaE51?=
 =?utf-8?B?RE1ZMWY5aUlWQ1FNNTZ5aml0MlBHOXVRelkwMnduMTYyRHdRUWFpdmlQVk1s?=
 =?utf-8?B?ekt4K2k5VmJjVDlKNmN0S240ampJNzlLSlFZbkNLUEx5OEpRYy9jbmFtaXNP?=
 =?utf-8?B?K1pNaDFGM0pJN2h1Rmc1ck11T1RLUGxPOHpWNnp3R1BFdmZPRHJpd3llb2F6?=
 =?utf-8?B?bk9YZHFDMnI1TklzNWkwUWphaDg0OVUxSDE4MWhFTTBlSGFDbS95NnNtYXJP?=
 =?utf-8?B?dTh0SEtaUnR1cjNMNEpJWDJKUC9qQ0pHMFUrbHlTUElpL3pmc0RWR2JoYmo3?=
 =?utf-8?B?aVc3eXhsQjhscXpZdUVQUW9sMjBXSnplSFNFa0w5N3BjazFwbWFGemdmUnE2?=
 =?utf-8?B?L2VZaWlrbzZYdXNKVk91dXdKYXNvMHJiS0V6SFZMUW9JWVdybEdiQXVZSnIz?=
 =?utf-8?B?Zm9lVEtsMmowaUpEMmtFNWd4MkltbWFQbml6NTFQOFNMNkZmc0gzcUJkSHNh?=
 =?utf-8?B?Rk1kQzRkU1VXNXhEbDFkTmY1SDZmNGVNeml1clZvNmE2Mmh0YnB3RE4xNUxt?=
 =?utf-8?B?NDd6NzVsVXNUOThJUVBadGw5cVVrMnFURXlBSjdlUFhkbjFKTllpNzFGQ0FT?=
 =?utf-8?B?eHZSRDM4azcxZWhZWmd6STJWSm5WQU1IcFJlQkNkWi9OaUV2WW5LUWwrTnF5?=
 =?utf-8?B?VDNqd1E4dDFkREcxSlVUTmY0WS9TY01tZFBncmQydU11U29tbHZZcjZlaUpt?=
 =?utf-8?B?UjBZZklqWkxqRkdoVG8vSTNKTGlSYXN5UWY4eEo0b2xONXd5VHpaZjZvUTQy?=
 =?utf-8?Q?HvkQTjHU49err6xXB9CnSyXLU?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a95e6d8-d65a-4b26-367b-08dd30eb7a05
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB5151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 20:23:28.1317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D3FZlRoIezsxc5A3NLKv5FKulVNdkW3O6AZrF7tpdDIU7iV2i3M+XoCZCGDG3e9zs9gTrMGaG4jlEwbx3x2ykA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7487
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,JMQ_SPF_NEUTRAL,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 1/9/2025 12:17 PM, Corinna Vinschen wrote:
> What about keeping
> 
>    bool match (caddr_t addr, SIZE_T len, caddr_t &m_addr, SIZE_T &m_len);
> 
> available as inline method just calling the new match() method with
> a local "contains" variable?  This way, you don't have to define dummy
> "contains" where the value is unused...
Good idea.  I was annoyed at having to define those dummy variables but 
didn't think about how to avoid it.

Thanks.

Ken
