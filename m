Return-Path: <SRS0=NVwk=QK=cornell.edu=kbrown@sourceware.org>
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c000::1])
	by sourceware.org (Postfix) with ESMTPS id D69303858D26
	for <cygwin-patches@cygwin.com>; Thu, 12 Sep 2024 21:36:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D69303858D26
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D69303858D26
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c000::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1726176980; cv=pass;
	b=cuhiNEwEL+yVUmBKErPUjFyToF6N9mJULHM3escg32DbeNtiQyFPrUCIpqdhq0fGyuXhrdqFKo2b6ZEy1RAdjaBRngQPmLREwgXrVLJSa9Nsb2xPi+a3zlKAhasowEFhxLlog7YJbJfiot1aeeiya/HIfpUflSs9W0kPAAk115A=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1726176980; c=relaxed/simple;
	bh=Yo3qjm7NDpIlVsrvRLOdYahiSmKrQyTB97PpAdFi0oE=;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version; b=LoHyfca7boGqSVIxExxJmV0sgPO2FUC0edWFKyRtPwoAq0zqr3Qd+j8dbwD53WLUuXGhEas6ynzebEL73iSf2R0Q7Eugc5CZ3SnaBukPjcBmFnyyusyLVoewA8RHvCnaMpPKKm9WVTx0Tk53d1zYoI4l71WASRZ4mUFlOxsMpSA=
ARC-Authentication-Results: i=2; server2.sourceware.org
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCj/wfSJuU2wnWaOLIWVusBeLK3UzT7dRlT0DSsMT5Ejbq83h6fPRfVLqvkP4dXj7GZ60KJIaQnajn5IpBn7VWFe3TcU/m0exSqw0EbaThWDmI3g05LbpEIm+6eAGjG0tKSiFNOOwXea0R43QznkhUmxlLV4QAGw777OIkSlo0R5tQGVwnH3sEi3DaKjB+ImkCLwY8nWw+3pmVbyFib6eiDNzJVxJ2BMSqk2BYnOkeYlmh95qJL3keY7Csgd/2comLF3PBd7Y7hQnUIBui/T9kF0p8n8F56KbmG+IPYGq9sTyir7ZXNpTplYi8HAGTrBKZkGNoaILhCRU+pstP8QnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lu8d6N3ajOA6RDVP6+lZUipANIY59o9E/hk5shTkyVE=;
 b=dclIC6Hbp0xoh6lNMcinMXSRN5s77SyywrlJDz0VEoDKdgzTUCEzA0MH06NSLkwFdw9YHtivevb1uz1xaa1KUpRNZWJ1JCDAtHgGLB9sgf+ezBBlRsCHeZIJyXNx71nWd9zGn26tJMyGcfyuEQ+V2J2oUciy0GHB8hyetrvqzx51OPWuwqm7AGhMrAeIJpwHD3pKp/dVGu24ajTtHayGgZ2ykHNvVkmkjZR/q0OiNvvhbR26CzK5KsLTP27se8cqwpi3+eeCRnTSKlmy66x8RuBGRklFAqHtBInU9ZILKT06lvq06Lt9xgpucs/E59Pq4psTL5ILnwXJTzEyHK9Ytg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lu8d6N3ajOA6RDVP6+lZUipANIY59o9E/hk5shTkyVE=;
 b=E4C+iP2zgTKMhxCrpN+CNiaXln3n7bqTeqkMPUm0/cpJdakFRbmjWrBmHLhBfvBS6XqauWDFR6T4yPwvhkpV8gIHGgBBnIyE73lejcyrXOO34MMHkH1kVp8qNuDGbJbTS995ag+tNG9Pe3YK+puk0K+MJRE2S9aQiWfGEsDrFUA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from SN6PR04MB5151.namprd04.prod.outlook.com (2603:10b6:805:90::25)
 by DS1PR04MB9276.namprd04.prod.outlook.com (2603:10b6:8:1ed::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Thu, 12 Sep
 2024 21:35:55 +0000
Received: from SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd]) by SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd%4]) with mapi id 15.20.7939.022; Thu, 12 Sep 2024
 21:35:55 +0000
Message-ID: <1748f37a-89d2-4245-a3f7-74d0a627a58e@cornell.edu>
Date: Thu, 12 Sep 2024 17:35:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Cygwin: pipe: Restore blocking mode of read pipe on
 close()
To: Takashi Yano <takashi.yano@nifty.ne.jp>, cygwin-patches@cygwin.com
Cc: isaacag@sourceware.org
References: <20240906080850.14853-1-takashi.yano@nifty.ne.jp>
Content-Language: en-US
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <20240906080850.14853-1-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0033.namprd16.prod.outlook.com
 (2603:10b6:208:134::46) To SN6PR04MB5151.namprd04.prod.outlook.com
 (2603:10b6:805:90::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB5151:EE_|DS1PR04MB9276:EE_
X-MS-Office365-Filtering-Correlation-Id: ff34b6cb-44ed-485f-d22b-08dcd372e1da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2Q4aVNvZkk0bGx2Wks3Z0kzcU9IQ000TWdqZ3N0UWRWOEZ6elBZSFhLRmFp?=
 =?utf-8?B?Qm9xaktXekZma1dRQjRJOERGeVZyMHlHdHBTMEJwQUNIbVVRbVFXQlRHOGdz?=
 =?utf-8?B?QUJpQ0hZZzh6L0FYVnBnRWZvK3ZPNExpMDVqZ0dLVU9BZmZSNzVuRFpFdjk4?=
 =?utf-8?B?SVAyRUcwYnZab2psRlJjRk1FQzVucWx1TW9UVnI2YUlIMnhBMUhrUWJSdUIw?=
 =?utf-8?B?L21rT3JpYUJ0U3UxeHBUQUJqM0pFYWoyNkUrd0dHaUlTN3VpZTlCV25RTTJG?=
 =?utf-8?B?eXc4SDE4MFFHRVVxVzZTZEp1T0wxVXJRSVpXUXFtRlB4eUluOGxjcG9lblA1?=
 =?utf-8?B?Z0NGbnRTU3NoNnQyVDNubmRxZTVrcE8xTkg1Z1JLVmIyTXZrY2o1Z2hTZ3Zn?=
 =?utf-8?B?L1dkY25HVzMrNG9VcngvMVlqWDc5TmFJN2Q2dFYwUitSZ2pBK2UxWkh1WitG?=
 =?utf-8?B?YkxQZzJrNWozTWRpYnltSEtuejNTeSsrSjFacmVsRTVtYmdCekJ0WFZNQmVk?=
 =?utf-8?B?cWcrTDZ1TlQ3b2ttc01ScGFHNk02VTNCdnN3cE91cFM4QzhnK3RXQlNzajVM?=
 =?utf-8?B?bVZubnZtNjNLanVZdkI5SnZ2cTMxQVNMVHA4bVdkamlKWVlyU1REQTdpMkNP?=
 =?utf-8?B?b01tVFdabGFQODA1ZVZJUTFUd0xaQmlKNGNpOUhwcXRnS1ZVejNSRmpvZlFJ?=
 =?utf-8?B?VDBZMWlSQzVWcTlTcmdIUmR0NGp1OVhiV0NELzNhR2t1THlVUnRNczM0YkhZ?=
 =?utf-8?B?Zi9seXlVSStNbUp1SDBKd3JjeXdOMHp6SXlIQ1lTNm5IUmkwZUZIa0d1bVdK?=
 =?utf-8?B?VFNlY1E4MmZZK3M4anJkWFBUWExySDlnSmVKNEFOcVA1SEZKVUU1SlBpSXF0?=
 =?utf-8?B?OXZGdEozRDZZZXhVK3MzKzBvWFZUU1JRdGxYQit2aFgxOVdYRGUvV21iSjZQ?=
 =?utf-8?B?aW5rQ1h2cmd5Y2FUeEpkQzVkVmN0ZG5teGZ5aExJZUtzTWpKd2hsZ2RkL0o0?=
 =?utf-8?B?aTlMdlNadDhLYy9YSlpwWUo4T2ZRSDByMkxreC9vSXRUQlU4bXJER1Z0cjhR?=
 =?utf-8?B?SzZZam5VZW1jRmdaekE2SU1tWmFiZ3NLTUhJNzhFWUwyY28wQlVCMVkreWlm?=
 =?utf-8?B?eFBmOVBTQ25pNU9LNEFVMURPaEdIbnVDRDRFSW9qN0FTWURSZEdUMWxPcm1Z?=
 =?utf-8?B?cW9aMXNjeERnYjdHa0taUDM3Q3JQRm1vZzVSVnNUZ01kTGQwK2RFOFQrYnpS?=
 =?utf-8?B?UXRMalJLWEhhZ3pSa2tWcVNUYkVkNXBjVzh3cGVjMFNnYVY1UmdoeC9YMUlS?=
 =?utf-8?B?aUZlMXh4MFFqUTNRbnQvMTJvS0x2TVR4bHJvbWhLajNSWkdoaWxPY1FKbEVG?=
 =?utf-8?B?M0w4T1BhcHkwSDd2L3p2cWp1M2cvWXhwNkE0OTBsUkJjRzVtRWUxRS9WMWlQ?=
 =?utf-8?B?OWNIcFZRV2NFOWwyT2lldkhXMWM3Tk5rbVppR2FqaEYwYkdsN2txZFFpL2lO?=
 =?utf-8?B?cW1UZzlUR3FvN3Y3d2ZqY3V3Y0JvM1haTmJITWtkdkt6UDRZVmwyNWwrNEJk?=
 =?utf-8?B?bm9LKyt6VE0wZWJFMjFEcjZpQ1luTGl0eS9Lc1U0Y09kQlRrWkdIYnltdmZS?=
 =?utf-8?B?aFk4OTRRQXh0Z0F5M3RDRFpTS3V5SndjNDgrZzVkdThHYVo2UDFmNmpqS1Yx?=
 =?utf-8?B?SjV5S3Uvbm5IUllBUDU5WVBvVlh0VG5BK1cvR0FmWDlmZlBjN3U0Qy9hWGFC?=
 =?utf-8?B?d2ZDTDZBZnQ5ZlBpZkZVUktXSmJrdENNcGJydHdHNjdrajBlTnRQbElvZ0Mw?=
 =?utf-8?Q?g1MHnLo7EiCrNyPttGoCH+L1NOYAKY2SFBKVM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB5151.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUpIZElWcm15WGdiQjJsaGs3dmtaZXlhRWtmWVZaNkF3VTNDQ29FSVV5bEUz?=
 =?utf-8?B?QmFKNm02UnpxZnNjei83NVBxSGZYQ2xVRXh2ODF1K2tqb3lkdkh4ZFRxK3Jn?=
 =?utf-8?B?WjJzWjF4RW1sT3ZzM2pNMGtkejFPUHRJeGRYdll0MHNudTkwL2cwaDRpUWdm?=
 =?utf-8?B?U05FOHROSSswMXQxNmR3RGN3YWR2UXpvZUVaTkdjdUplKzk4cVhJenorRVg0?=
 =?utf-8?B?R2VFSGJ3RHUxQnVERTFnYit5N2pzRlBFZzlFcS9iY0xQcHVDdVFnYk9qN21a?=
 =?utf-8?B?RldDY0lHWFc5RkRseDE3QlJ6UXVSOG9jKzNPSjg2dFRmckg4cXlJT1BJSnJO?=
 =?utf-8?B?eDBTKytYUXpXR1NMMTFhMysxUkgxSFZ2Tkhhd3hIdldZdXAzK2g5U1l6NExE?=
 =?utf-8?B?Z0J0TTRFSGxyYjk0OS9KenJLNzQzY25CR0VIbHVsdXgyNUszRmdXa0ZDU1pP?=
 =?utf-8?B?WW9yczJYNWRxS21zWTQwd3ZVVkVOc3JzdWZuMWE3Wmc0VUJ2RFBVbFpXTmpK?=
 =?utf-8?B?ZjJjejc5dDFMdVIyeVdWYzBrN3I3Q0k0OVkxQ3pkeEt0T1dVVk1VUnFkcHls?=
 =?utf-8?B?TnVVQ1NFajJuOFlWUC93ck93Nm9KNTF4U0FMeTFZK0xQTjgvU2tBWGkrVHdS?=
 =?utf-8?B?cmlYc1pLZ3JBbUMvbnJrWTMrS0ZUTHpWcWdjbTl4UWNYTFhPTlF1ZUVZUC9q?=
 =?utf-8?B?RENYQlVXaDZUbnVOVTd1UkhiMWM1N2JhS2pwaXVKT2FaenhmQ1pqMEwvR2l3?=
 =?utf-8?B?Y2tzNWoreGYxa2FNRURHdUpHZGZlOHlJcU4wZXBtelRPdG1Nei9Va3habEU5?=
 =?utf-8?B?ZEEyUEhGcHpKdzFkN2E3Z0lLTGFkb2xIbzFBYzhhTTZ5TWRwK3FZcjB0ZFhU?=
 =?utf-8?B?Zm1vL3U3Q0dQN0R4THZxdjFZT2xvd01Ybk5XcUxaa0lHSjVEUGRYOGxYbXdQ?=
 =?utf-8?B?NWd3ei9LT0NKU1VoK0R6NUpXNHN5cTJCbWNxcVdpeDFqUFFTMzBRN3RpQnc5?=
 =?utf-8?B?VndpdkhWTHlpOWxaU3U4SVU3aFhoOHhPMnRiTFJwbndtaExlV25Da3hRalZ1?=
 =?utf-8?B?WDRqUTlYYWFGMDRGNnRMdXhMUENVTlNhTmNmYVh4SjV3RVYzaEtsU1FFTzBM?=
 =?utf-8?B?TG85a3E5MHMwZS9CbTM5aHFIY2tJRVhTT0FmeGZQUTd3U3laUmR5R2NRdDdj?=
 =?utf-8?B?OURZaGU1d3V3ekl6bFRhUWNQZzdodmFIN3dRdFBIL1FBd1BEY1RwOXlsOHFB?=
 =?utf-8?B?eW5ranZBWjJRVnlkUEtKMVBJOVV6WndnZVVlc1pVYUVDNmVHeHhNSjdvY2JU?=
 =?utf-8?B?S3hXV2tkVjZISWVEU0ZsdDFZOWdTYWp1NDZHWDloY1JrNk9sR1hLVUcydGdR?=
 =?utf-8?B?NzZZdmxWREIrZC9WSGtEejMwWm9pbmFxQ3lSak8wUkxvYlZ6L0c1RDZTWUU2?=
 =?utf-8?B?L3pXTHpjcXJadXgwa2hxMUo2Z2hORDJqeWs5dm0wU1RlUGRvbVRCNTlqcXlV?=
 =?utf-8?B?ZGg2NE1ZVWtXK0R1TzNIWFJZNVJXcHA4dWZrdWRCMktBMW05bEk2ZGpaVkx3?=
 =?utf-8?B?bStUUGZWV1FSQyt1ejBaUmxhazFnU2ZoODZFMXR2NVF4ZW0vZ2xrUEVqNGJK?=
 =?utf-8?B?UENXeTNrd2xnZmlvQXk1Y25kYnRtYXhEWjNOQ1RwQXA3eGN0S05Nd3dDN3cz?=
 =?utf-8?B?QUZ1VW5pNUdWRTBIRmo2VVMza25uN0Z2dkVKMXo1M0VkeGttRUFhOVZ3LzBW?=
 =?utf-8?B?MzhnV0d4ejFIUkQxeU1PWFg1YjlvWW9OcFFxK3hzZzhWNmNjR1Y1STZ2djRZ?=
 =?utf-8?B?VGhPTFVON2t4RjBkSVVocFpWVCtGV21lU1VIWnhrUklLY1RzVjNWQ3cycFNQ?=
 =?utf-8?B?T2xEVnFkQXJBTk93TVFYVng0TUtwbmlHR2lLTzgrQWZzc1lHbzRHNVBDb3hj?=
 =?utf-8?B?akJ5MmhFMjYxaXg1MDhlZ0pxdTl6cUpMcjBBNFdQNUxrQW44MTFiT3ZTbC9J?=
 =?utf-8?B?OGxDLzBqaXZIK2dnWUNlOXByN2FsKzBHUldSTzlUcGExaFVKeWhxQWVLNE4x?=
 =?utf-8?B?cFVYRkkwcGhvNFRBRS9JemtnTXNXWUhZN0tHUkRJakhRYU1GUXJ2Q3lGVng5?=
 =?utf-8?Q?xWWFHklznye/QZe2BqVa2ybPh?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: ff34b6cb-44ed-485f-d22b-08dcd372e1da
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB5151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 21:35:55.3303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CqNyVBxjlMDrJnPofyKZUshgvNt3OfcKj7xCuyLktd9vK7jEOhgwqeWIEiw6bzoWfK4NNov6KbEnxWjXkQMT/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR04MB9276
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,JMQ_SPF_NEUTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 9/6/2024 4:08 AM, Takashi Yano wrote:
> If a cygwin app is executed from a non-cygwin app and the cygwin
> app exits, the read pipe remains in the non-blocking mode because
> of the commit fc691d0246b9. Due to this behaviour, the non-cygwin
> app cannot read the pipe correctly after that. Similarly, if a
> non-cygwin app is executed from a cygwin app and the non-cygwin
> app exits, the read pipe remains in the blocking mode. With this
> patch, the blocking mode of the read pipe is stored into a variable
> was_blocking_read_pipe on set_pipe_non_blocking() when the cygwin
> app starts and restored on close(). In addition, the pipe mode is
> set to non-blocking mode in raw_read() if the mode is blocking
> mode as well.
> 
> Addresses: https://github.com/git-for-windows/git/issues/5115
> Fixes: fc691d0246b9 ("Cygwin: pipe: Make sure to set read pipe non-blocking for cygwin apps.");
> Reported-by: isaacag, Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>   winsup/cygwin/fhandler/pipe.cc          | 41 +++++++++++++++++++++++++
>   winsup/cygwin/local_includes/fhandler.h |  3 ++
>   winsup/cygwin/sigproc.cc                |  9 +-----
>   3 files changed, 45 insertions(+), 8 deletions(-)

LGTM, but I haven't tried to test it (except to make sure that the 
branch still builds).  I assume you've tested it.  My only question is 
whether you want to mention the variable is_blocking_read_pipe in the 
commit message.

Ken
