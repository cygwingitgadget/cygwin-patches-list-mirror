Return-Path: <SRS0=bLhR=UJ=cornell.edu=kbrown@sourceware.org>
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azlp170110002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c110::2])
	by sourceware.org (Postfix) with ESMTPS id 59DF83858423
	for <cygwin-patches@cygwin.com>; Fri, 17 Jan 2025 23:22:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 59DF83858423
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 59DF83858423
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c110::2
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1737156165; cv=pass;
	b=OAHUuByn8/M4L65XbXQRh2ey0l3PmHDCJgAlyBum5mWPf4B/CdlfoZ8TqMlU1SAQZL+dn1YMro37r4Uw4y7Q+RLP5htH3eIRulXaq014hqaC4laUM2ZRHBPRJr8upBQXYfw9Z1Xdb/VXstknA9dd5sPmyDNvhxuYKzrdQ8cr2SI=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737156165; c=relaxed/simple;
	bh=m0f8gMVdpqfqTpcfiWPk2KJVHmcMgg5+nV8+2JTzGMw=;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version; b=PAPinCXrDvU8U5e0Fu+SoP3+6w8txY5ioM6CE15qcDpT2qBmzPs7wWMXfqPccSBtzdEb+9+N7WXLStx3gY4q1vtHT3yRMlgF7CM6f/TspTIfXDbDaiUDncNjzCszcOZOx6q5lqV9cHDid479HlorpF76dvs7XfgsMle0g2xqFrU=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 59DF83858423
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=cornell.edu header.i=@cornell.edu header.a=rsa-sha256 header.s=selector2 header.b=ItVN6EJ+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eD9zrNknBlPIwq7IETAYvo5HL//Y05ObSK7ccU/Hp6MFacj4uI7Is2jpI3sb9gJtNPOS+mViW6iP90IGx8DImiKvOA7vXoBhxxd8gtcp/gNxDZqkJH11My601Ls845kBXjxDEZbwwgf7vJCI9W9+rOaXVJXDCVk2LPmr2dWgJToBtXNyIy4iDF4MmkVPYxLsava6p6Ys4TDjRhZjDR/mFSBhe28ottUe0EtOh9MfGyFl5cZdX4WtJgH9G9lk3O2PZibRAuzdCp7PMU9Gsct4vNrPc8ZbK7bTcYzc6078G+L5h8YfjaUTcIHVwb16rq0catzyBXUhex/NWLFbM7sDmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvjVQa2kAHlsX6OQFiv3lW3AsljJUMAYd+HjJFnzm1w=;
 b=Fc7dNQ81KwGf0BqFM9P/biTppKg216EPmH1vRRRsBWiagW0xSvgzrIosyQywqBc6MBN0NaEzibQttZb6pK8GH4JWg0GkU3Hp5ADfsyLAVtTezWvYLf03622Li2sP8bMe+PEZo994MoaBZj22GlxzuChuohwtYVO7/m6f8gDrcrjnGGxRJL8ppi1ViBpqcGCjf+ke2WyQaHMKmXRkLgN1wZVejW0rB+Sj82NifnHpkthE4L6M4fNjHZ7YyXNXkedQicQMFFfs5jFVkB4prU3QKVMyOc+fgIFy0XyGixjDb8ZkAOVXf5aFdvVcbSW9tRPcghby91aYYTOF1ALMOoscdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvjVQa2kAHlsX6OQFiv3lW3AsljJUMAYd+HjJFnzm1w=;
 b=ItVN6EJ+CJ71Ri1IukILyMDl5bPjRtFLek6UJybm/7lOBdUR5v+t0UqDHNl6oDo33SVeIOEZ28OOn91tc0ERfMB9xmnrYgaB4FuWcyuBzr+lDrJaCiwDx6HXqpOCEaExQl04N9RGxvmUQioefoA7cRXaH6jj7rIbkEOMrtLs4Qc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from SN6PR04MB5151.namprd04.prod.outlook.com (2603:10b6:805:90::25)
 by BY5PR04MB6280.namprd04.prod.outlook.com (2603:10b6:a03:1e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 23:22:42 +0000
Received: from SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd]) by SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd%6]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 23:22:41 +0000
Message-ID: <67b40edb-6719-474c-bf05-a3fffc8b782e@cornell.edu>
Date: Fri, 17 Jan 2025 18:22:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: mmap: use 64K pages for bookkeeping
To: cygwin-patches@cygwin.com
References: <92eb753b-055a-4171-a1d0-56bc8572d174@cornell.edu>
 <Z4TzRLHGdvcxfT_y@calimero.vinschen.de>
 <20250115221730.4b1ce8becbd1060ffb0373da@nifty.ne.jp>
 <8f026ac1-d628-4723-983f-953275ea4329@cornell.edu>
 <Z4fpeXlmjOVu-u1A@calimero.vinschen.de>
 <Z4fw48L9OmD9eMr1@calimero.vinschen.de>
Content-Language: en-US
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <Z4fw48L9OmD9eMr1@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0303.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::8) To SN6PR04MB5151.namprd04.prod.outlook.com
 (2603:10b6:805:90::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB5151:EE_|BY5PR04MB6280:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b568f66-437d-433c-3d5c-08dd374dd66e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3VzMXMvTkdsQzlDQldnazRtZlBDZTZrUFRvZnN2V0FGYVN4UGNuaTBKQ3Zn?=
 =?utf-8?B?TWQ3Zi9Ic2JVTmR2YkVwb2hZYmJqMzJOajZzLzNLcXI3Ulo3d05EbFJhbksw?=
 =?utf-8?B?eHZHUDkwNXZqWVQvcm1nZ3pIWEgrRlBNM1ZGTTJ0c2EzaXNFaStKZ2dQN01C?=
 =?utf-8?B?Zy9kcUdXOThPazdpSVJGbllseUJtZ3V0ekNxNXh0OTNkNGg3dENjY0dtbGls?=
 =?utf-8?B?cHVMOXV6UTdMRjZUT1l3WDVMbVpGOUVLNExyRU12MUlYa3NxT0JmMCtoMnNZ?=
 =?utf-8?B?SEpkVU9YV0hRUFpqNk9qRE5mcmtoUEJDY2E1ZWNiLzBiYS8rNlBZTlNSQUVp?=
 =?utf-8?B?QVhJQWkwQ3ZTK25IYlBRS3N2VXJ4TnZYcUNPb2gwM2twSXh4TEYwVE93eXBw?=
 =?utf-8?B?OWcvNUEzUmx6L3dYV2NUZEdWTGJXb3B1NW5Bd3lLWXpld1dDMzMyUHVOZDJw?=
 =?utf-8?B?WVNDSk1UaERNNWg5OVFacHl0bjlqeTFkM1MyWHI1UXJHVzFtbnRwZ2RaYng3?=
 =?utf-8?B?eUl3OWM3MkVkUlZpZWZxQWVxV2ZCUloxbHdEaThIczN6djI1aFJnbWZqbkZy?=
 =?utf-8?B?Z1BELzhNVm5FSEg1NEdtRVUrdkM4YTh3TDNLZWZpNDV3TjNwVGlFeUpvSWVM?=
 =?utf-8?B?VUpkeHovWW5nNDM5OVEzcUdaZnpWQjNVRUlIY005K1dWYlBmd1NyancwSGlj?=
 =?utf-8?B?aGs5eWVDL2R4NGZQeGhwenRaR2FJbmhENWF0eHZTaURBSEgyc3NqTFJ5RDI2?=
 =?utf-8?B?Wi8rZ1V6OEpMakd3TDEwVXNvWCsxbWVqMGZWTC9Ea2trc3FXVjlKSG5PaXhx?=
 =?utf-8?B?L2pxdWUzMDBhMllJTE0vVGk3N2xLY2pGMjhZUytaRlI3WDIvZHZUbi9qODBG?=
 =?utf-8?B?N05tTmozaEk2d29tWnhJczVHUzVjb2FvZWhWUThFZ3JaMnFESlpmRlQ2Vmsv?=
 =?utf-8?B?ZVMxQlVLZWdOSkk3d3AzSUwvNWFxeFgzaUlFQWFleUxWL3ZmTE45M0xPNGdK?=
 =?utf-8?B?SFEzaFdCZHdkVHB5U0MzU3RFc2pTYTRxcXpWQ2ZiSlBjQVNUOEE4Y0NKMi9U?=
 =?utf-8?B?bjZsS1F1a2pUL2FBRHc2OWVaUURwejBPVkN2OS95dFE2OFFZK2htaVQvcHY0?=
 =?utf-8?B?N3VxRkQ3b281Q0lXdkVRcG9hSHdNTXBENm9YcTR1R0J3OEd6ODhLbkpad2ZK?=
 =?utf-8?B?SFVUQ0FIeGVRUXV4WE41MHc5S2ZUOUh0cHdoRTBSVkRuUE5WNENuWTdRUk0v?=
 =?utf-8?B?RVQ3RXd6SGJnYW9EcGFTa2NIdGZIYlpBa2RMeFFDaTBsbXhlUVhjdkRuZzkz?=
 =?utf-8?B?cVAwbjN6RGFYWFhnTmc0VUFFSCtqR01pclJhV0hzNnVXUU9ML0JZWTh1S0dy?=
 =?utf-8?B?Z3dwOHBZZ09SQ0pxQ3FwVHp6RWxGWlNSOE5QcDZnSDZ3RWRXQ3lVZW1VSUNE?=
 =?utf-8?B?dnJMSnNPaVk0M252eXZsZ3ZHOXFiWFhodXpKY3B0aGI4d0toVTg1Y0hYSXFz?=
 =?utf-8?B?M1NxUC9XNkFhbnZ5djdEeUh0a1d4UGJNSkQzSnpNZWp2eVRKckxRV0dWTHB2?=
 =?utf-8?B?dkRVYWFPdUczYm9WMHVTeXNCQW9PSVI0WHpvT3g5bWd1Qktha2RMbVVBNEkz?=
 =?utf-8?B?QjN0QXNxM1pnKzFpQWRQaDJ4UkZ2Vi9MV055bExIVjQ2YzRUbFZOU1R0Ym5y?=
 =?utf-8?B?cW9tZDlTbm1JTmRoU3RoUlpnY0Zra0sySFhwNy9RQVFZNGRxZ3MybkhUd09O?=
 =?utf-8?B?L3FGcENNckcxbUgxMGZuWGZWaTdHYmMwZlpYVXl1N012Q1hyU0lQSCtMUm1E?=
 =?utf-8?B?MElSTGxMbTVaVC9uWmhMdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB5151.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NS8xcGhmOTlaT2NZMVFmUXJ2anoyV1o3YVZKTjM4R3VIZnd6aU9LaUhwOFFj?=
 =?utf-8?B?VEU4dzVmWjBUcTVUb3VDa3VFcE00M1cyQ3JSMS9SUHRrR09nZ2dYWkhvNnF0?=
 =?utf-8?B?WmJjREpSUEkvaDBPYnByeUZ3cTFkdTVZbEptUGYzb1hFK1JxdVlQN3lBTlJa?=
 =?utf-8?B?bnM5QnkzWkxONm5WQktSNkp1S2tlbS9iVUZLaEJXSmdXNTluVktFWUV5VGZs?=
 =?utf-8?B?dUF2UzdocFdqSlI0SHpVMjQ0VEZQbHcvRzcvbWdBc0lML2NjVEx4b1FiSWs2?=
 =?utf-8?B?bDlYb1JGUG4vUHk5bHFXZjd5cGVlVllBZUt6WERid01zMWliY2JrdW1hbGp4?=
 =?utf-8?B?Sk1QT3lLUFAyeGFlcWE5UFA2SUNJeXhGYjBGZ2ljR2RraXpjRWl5aGJydzJ1?=
 =?utf-8?B?Mmc4R2p0eWgxVmgzemNkVlhaWkJzN0lFQWhkVTJReDd6Y2hiUmgxclhzR0lj?=
 =?utf-8?B?Vy9SL2ZOOGhrVFY0WXF2MGtFcTBudjk0RkMxTjc2UTVNcEZGNmYzR1NLQ0lm?=
 =?utf-8?B?SmoyQXhreTI0TTQ1V3hPOCt0WHNwZGZEN3R5ZDJURHhoMnQzalFwNzdmd1Y3?=
 =?utf-8?B?S09nTUw1OVJCR1FUL2F4cTY1dkJMOFVReGk5WE50SjBVWWF3eDk2ZEU2V3U2?=
 =?utf-8?B?WFE3SHBJUmw3cmtLUFBQT3NYRlk3bUFlYmo3MVg1MVRTUzN3U1pGQ0FjSU9r?=
 =?utf-8?B?KzRIYzBKYWw2U256U1lGbnNlQXh0V3dnTGUrTlY3NHFVaVczS2s5ZFBQUjcv?=
 =?utf-8?B?NEZyVkRZNTJobHRVTSt2c2lsYkM1R1BTMTVpWHVJQ0VDVHREQU5KVGwvMmNM?=
 =?utf-8?B?UEZZSHVpMjRYRzBtQ0hQZXRTa3hvSFdCbGVpaDhDTFE0a2wwTk9XaTlDUTQz?=
 =?utf-8?B?WTUxa0NPVXBXNFVyYU9kLzBMRXkzUGlmSWZoQmlGbXlicU5qOUl1LytSSisx?=
 =?utf-8?B?dklkNTdzV2RkYlpUS0M4dW96WUcrWXVnc0craGVJUk9lWUtCc2tGTHpJMll2?=
 =?utf-8?B?U0JuUGFwSDJVTVAwSTg3V1hmKzBzWXdVZEtVQmt2T1ppTWFkOTNmZ01LcE51?=
 =?utf-8?B?cnhOZ2VBL0tmVlFUdzZOQ3pscFo2ME5iWmlwRjJkakYxaW1NZmpkeXZSdEti?=
 =?utf-8?B?S3pMU00vUFZ3SkFBaWpza0lPSk9GMXZkQXVOUVBhTUxvVVR3dzNGN0I0Qnhq?=
 =?utf-8?B?d2tCNng3YkFoUjkyMndsZEtlV05JNG56U0ROVWtGa2pzU3QxZy91MlVGc3R1?=
 =?utf-8?B?c2ZaK00xc3JNNDlUUEpBS3p0bWJ5RUZKSTJSUU5hSXNoVFo0c1RQbVBKMGpp?=
 =?utf-8?B?MnV5NVNsaE5uaVpyZVNvR2piNXNZWEEvM01BUlArejI3VE9ETUZyaGo1NFZw?=
 =?utf-8?B?YllNeVppYXFoQktSVURXb1RRcTNIOXhqVkcwK1JLeUx3dW1peGdJZjk1b3JP?=
 =?utf-8?B?R01XZUtxQ2w2S2tzSDR4MFdYTVZTU2p2TGFFSHNxMWEzUGc4eXpXWWxoaURy?=
 =?utf-8?B?YzFOaXpkQkNRT05LOHdhcnZFamxFOFJ6WDE5aDk1dk5Ud2lwcjFoKzZRTmR1?=
 =?utf-8?B?SU84bXFlWHFQWDN0OUhXWlRqWmZlSURlQ1I3bVY0VjlFZzZwc3I3a2lTM3Ry?=
 =?utf-8?B?Ui8wMWJJL2JlQmp1c0ZxcDM3NEhxcEppdGxKUFd1ell6Lzc3Rzl4V3dhZEJG?=
 =?utf-8?B?dndya2JraksyRW41NU04SU5uRDY3aEJIUFlDVUU4c0RLeC9tbTF4S2NxSXlO?=
 =?utf-8?B?TGNiRmFBVys5bEhJb2lWbW1TYXJxcEZrRW9KZ2RqMnJkc2hNWThHNzhuRGsr?=
 =?utf-8?B?UXdGT2pWNVNEVTZGWGlnS2pnOVdweElHbCtTZG5LTFNxcEhCWXBHbkhsd2p4?=
 =?utf-8?B?Y1BkVy83MTZ6Nm0weWlJcjl5bnJKTkF0MVBHT3NIMHd0NXQ3aTdIOUJrVEI1?=
 =?utf-8?B?VW5pRXJZeC9yT3Q5UU5ISjNub2JidVBXbmFWM08yMWxJU21VMFJMcFBka01W?=
 =?utf-8?B?YkYwNWVzMi9RdHE4L3RUWlN0SDNpbXdQSEpTbENOUkpEalNKUnIvUGdNdTcx?=
 =?utf-8?B?VkR2WVFuQUVrSmxEYjVTNTk0MFN2enNxVW9rNXFkZmlZT0o2NjNmL0Y0a2M5?=
 =?utf-8?Q?1CfvuQdwfKWu/xw4F4ead/8Eb?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b568f66-437d-433c-3d5c-08dd374dd66e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB5151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 23:22:41.8536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rh232zZysJMMBL7cGR3a1Zf24PhUcQQyODjdUsCHOy6k/pdGYrhH8abrwwZ2TSnBRP477gtYfkSO4vVu3lG74w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6280
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,JMQ_SPF_NEUTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 1/15/2025 12:31 PM, Corinna Vinschen wrote:
>> Ouch.  It looks like we can't go to 64K bookkeeping.  Windows files are
>> not length-aligned to 64K allocation granularity, but to 4K pagesize.
>> Thus, if we align the length to 64K in mprotect or
>> mmap_record::unmap_pages, it tries to access the unallocatd area from
>> the EOF page to the last page in the 64K area, which, obviously fails.
> 
> Alternatively it has to be faked in the affected functions, which then
> stealthily only access the pages up to EOF under the hood...
It's possible that the following simple patch (on top of the previous 
patch) solves the problem:

--- a/winsup/cygwin/mm/mmap.cc
+++ b/winsup/cygwin/mm/mmap.cc
@@ -409,16 +409,28 @@ mmap_record::find_unused_pages (SIZE_T pages) const

  /* Return true if the interval I from addr to addr + len intersects
     the interval J of this mmap_record.  The endpoint of the latter is
-   first rounded up to a page boundary.  If there is an intersection,
-   then it is the interval from m_addr to m_addr + m_len.  The
-   variable 'contains' is set to true if J contains I.
+   first rounded up to a Windows page boundary.  If there is an
+   intersection, then it is the interval from m_addr to
+   m_addr + m_len.  The variable 'contains' is set to true if J contains I.
+
+   It is necessary to use a 4K Windows page boundary above because
+   Windows files are length-aligned to 4K pages, not to the 64K
+   allocation granularity.  If we were to align the record length to
+   64K, then callers of this function might try to access the
+   unallocated memory from the EOF page to the last page in the 64K
+   area.  See
+
+     https://cygwin.com/pipermail/cygwin-patches/2025q1/013240.html
+
+   for an example in which mprotect and mmap_record::unmap_pages both
+   fail when we align the record length to 64K.
  */
  bool
  mmap_record::match (caddr_t addr, SIZE_T len, caddr_t &m_addr, SIZE_T 
&m_len,
                     bool &contains)
  {
    contains = false;
-  SIZE_T rec_len = PAGE_CNT (get_len ()) * 
wincap.allocation_granularity ();
+  SIZE_T rec_len = roundup2 (get_len (), wincap.page_size ());
    caddr_t low = MAX (addr, get_address ());
    caddr_t high = MIN (addr + len, get_address () + rec_len);
    if (low < high)

I've checked that gdb functions normally after this patch, but I can't 
claim to have thought through all possible situations where an 
mmap-related function might fail as a result of switching to 64K 
bookkeeping.

Ken
