Return-Path: <SRS0=w9Aq=UH=cornell.edu=kbrown@sourceware.org>
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on20724.outbound.protection.outlook.com [IPv6:2a01:111:f403:2407::724])
	by sourceware.org (Postfix) with ESMTPS id 70F5F3851C03
	for <cygwin-patches@cygwin.com>; Wed, 15 Jan 2025 16:36:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 70F5F3851C03
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 70F5F3851C03
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2407::724
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1736959008; cv=pass;
	b=hTzR+bi3ahIIUvhWFHOwfBd/OyngS5rCgDHD7Ryyg37chkb/bj2S7x/1I6t/t2cJZb02bbgX9sAACg5twX+YAE+xdJVg2qjzvxov3qg58qzCDzVQQXmcB7wQ9oAMKKoU/T28ZbktcKbYr/soLnSUQ6LObBGVSp4EALzihi3u83s=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736959008; c=relaxed/simple;
	bh=kn2Lw0oKMAe6xAcUA2+mn1Y303vA7hgTVU25WUQAfm0=;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version; b=eKhcgdlzbSrmiQBEMfLVQEHXcaX75yYM7AApDvBooLCqnV2J7GpjYh7kf/qYq4YqCg8Cdaz2dfG0Q34KFC1euKr1BGyWPE9HQwAxlg3PbeYQq6JNxXjck+e1rUxXn/sMcV+z9gNuTrp4KCjyeZwgktQGqzZqcjRItBhOJwa/xz0=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 70F5F3851C03
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=cornell.edu header.i=@cornell.edu header.a=rsa-sha256 header.s=selector2 header.b=IdHAKVuD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZf7yGrnFkzujatYrlekokmetI7X0u6MkFVOHxgt+Gb4XS6JjVBJA4DmoTGzoPIZeS0zgWow7nUTn4c9uXB8RqARJlctzxoAnCGXy+qCG1VijNEuWUiNWL78PhIYEoBGukFY0Sbw5jYjRBL+HeggaUmBh4PlzkwsuiClVBwwBJMuhzjIdbJa0irOngaLzCIxIA7scswO3F02VsxbWGypoANzpdcQQTMzuW4hdgSUN5D4EJrVAHDEfNhr4/uK1xahZ9ZwkYY5c7J72xlDyZx3I9n8Oot3b/Gca5cgnVe9t3qiVQDJhFwtZyd16Ct4Nk4DqfBb7LeJF1IB2XLMCExDjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GtbIXSAqfTZM7Jm8E5+gah0sRsHAwXec38gnyGlcl+A=;
 b=RLOcP81vqxRs7IlS0NS3eXkQG9CVZAbEXKmOeXHvG3EbFbbMZZvWJQWsJi6bFxr/J51DwOvRbWlBrSkmcbN/rn07YtsJYLkt5A2oMScY/2UKnEk2xSiQr5E+BYff2fWW2wS0d2egEHzu/RwkSnRfM/UVm8+ySWIyfCu8ZmlUfAFwl0YpcEm1sCp2AlZk0mlrysxYUMxYhAKyHsV+Z6zUeit34elG8afv+wgFvA8LkZuSSPR6gg/keYNOkWMXxZwKxCGvTxIVLd6cYMtD67D/5T10nySNyD7xyPTM8G0XXHcaqE+0wPGi2Ko2GTydPO3AroBDJpMdvCISvsTwkJTjXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtbIXSAqfTZM7Jm8E5+gah0sRsHAwXec38gnyGlcl+A=;
 b=IdHAKVuDJ+/f4BQONor/x2r8S/8S5K6edvqwoa519RPdhJaTxoQ31j3dR1MgQ1WOHffvW5AaVKvSeV6tGsHl5dIaO3c+kzM+whOK/K+flbV+ydj/qJHIkElXiHfAl+SVqDcWAt6y4Fmz7eJ48OvpWm0VxtZzwCUARYxFq2j9RDI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from SN6PR04MB5151.namprd04.prod.outlook.com (2603:10b6:805:90::25)
 by SJ0PR04MB7341.namprd04.prod.outlook.com (2603:10b6:a03:29e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 16:36:45 +0000
Received: from SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd]) by SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd%6]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 16:36:44 +0000
Message-ID: <8f026ac1-d628-4723-983f-953275ea4329@cornell.edu>
Date: Wed, 15 Jan 2025 11:36:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: mmap: use 64K pages for bookkeeping
To: cygwin-patches@cygwin.com
References: <92eb753b-055a-4171-a1d0-56bc8572d174@cornell.edu>
 <Z4TzRLHGdvcxfT_y@calimero.vinschen.de>
 <20250115221730.4b1ce8becbd1060ffb0373da@nifty.ne.jp>
Content-Language: en-US
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <20250115221730.4b1ce8becbd1060ffb0373da@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0339.namprd03.prod.outlook.com
 (2603:10b6:408:f6::14) To SN6PR04MB5151.namprd04.prod.outlook.com
 (2603:10b6:805:90::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB5151:EE_|SJ0PR04MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: 910f0e91-163e-45c5-929c-08dd3582cc5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUt1ZjViZVB5SGtvQmlqdWtlci9jeFVsdUJzb2dVc2pPYXlBVVRXNUNJTi9w?=
 =?utf-8?B?c2VKa081S09GWXd2RDVLTWlUMXdWU3R0b09rL0FKd0pqNDRKcjJCZTNXbDhL?=
 =?utf-8?B?OFFvcVdlZTVkd0Vxam4yMFJLRWRDVlJDTCtNaHBJcE1UdnI5NDI2VmQ3eUdR?=
 =?utf-8?B?cUsyOG1CdXlhYys1eWxZY2MwaVE1b2NpRHcxcDhiYWlGYS9ySjZMRTU5RW9G?=
 =?utf-8?B?amVvWGsyRzhXMUJiMXNVV09PTHdMQnkwZ1puZVNsYWRYZGE3S2krSlFuVDdq?=
 =?utf-8?B?Y2NSekwyYncraklHUDQ5Wk1Rbkkza0laU3BrTVBlckRBUzFpc3k2NXBWOTlT?=
 =?utf-8?B?TGVSaVNuQ2V4dXd3WWQzQ2JUc1BFa3I2Nk9SaUFXV0tnbmhUbFIxL2VsVDVQ?=
 =?utf-8?B?dDBmUUdjNGYzMFl4ZlA1aGd2L2ZpWlBndnhpZ1RQRldNTVFqaXpmN0pFMzlJ?=
 =?utf-8?B?ZUV6eHh6OFNsdVUwaHNONENzK1Bsb0YrTjNNcHJXZDVxcGFTbmF1aFAvUDYw?=
 =?utf-8?B?aFdTZTJPYS9UVlJ5dUZOaTMvSFZXcUc3U2lnRUlTb2RYZFNRVmxBK0hRaDRP?=
 =?utf-8?B?ajhoam1HOXFyM1RsaFF0TGU5aTRuNmdhVXRGNi9VWlIrWDFkVlNFK3Qvd0xv?=
 =?utf-8?B?WVBDaHFDdkNXQUZmTys5Ti9HY3poc1BON0IxZTMraEVBODh1L2ppTzNhZmxa?=
 =?utf-8?B?RGZSNlNwVzNEVEdJV1NmcEc1M0dPd3RhdjVnZkIxYjMyZitrK2pGR3drUzBq?=
 =?utf-8?B?bW56c1JvL1p3emlqaXFsSDZlazBrS2hFZW5HcURWTzZuZGJ4enFuK001TmhQ?=
 =?utf-8?B?T2V1bzdULzJPOUFwaDAvd2RFdDJQREduRkhxNXAwVkZWcUxyYUZiOGRRSmFJ?=
 =?utf-8?B?a2RYSlJKVnlrMXdwWlFkTHNMZi95WlJGdHE0WTFhd1ZmRFhhdHdDa0k0cHJH?=
 =?utf-8?B?YXVJdnJEVldUNjhmVW5mYnFiQzdjNHBYQ2FvdUg5STBPSkdYaVR6SXh4N3ZK?=
 =?utf-8?B?QjBOUHMyYWt2YU9EenJrck1VK2pwbU1pcTJ6ajgwNUZJQ3hkWnd5c3VubUJu?=
 =?utf-8?B?RWJmMDVYcC83aW0xUkFrdFdpZkVleTNSdzA3Ri8vRlNDUWRvOTdYOVN6SnhN?=
 =?utf-8?B?YmxWblRENysya3dMTkN4eGFCdUxkaHNhNnRpS3M1cStaaWpleGt4SGlzRDM5?=
 =?utf-8?B?Zmh3dWQ5MWlPaktUMUlFS2p3N0srZUNQYXVrQnBEd0p5OFV2d1IrMWk3c0dr?=
 =?utf-8?B?bzdzM3lOVnhHUGdjdXMrZERWN2hESHdQdXpVbG9XK2xoVVdkZU9jT21zQXN2?=
 =?utf-8?B?VVYxZzFEdmJ4RWVDWVR6U1hrT2JvcTI5WkxPKzBRMGloYUtGVHkxRzFBc0hF?=
 =?utf-8?B?bkpxSXNnZHZiYTRYSGpJa1RraW4wdnU2NDV4R0RsZzBTdmswUmcxK1d0anpD?=
 =?utf-8?B?SzVPU3JLeDZTZHhJVFFXTXl1dHA4OWZwbXpTdVBxSUdFYlZjdUhOSTZrSUVn?=
 =?utf-8?B?M3VINUlodnRxcVN1bSt3RHVRZkI1R3pVYmNScHpkRkgxM1N6NC9ScGUzODV3?=
 =?utf-8?B?U1lRTEM3dFRrK2NKVklEbFd0L3I5a2g1MzdDV2F6aUJQSlFzcnhGcnY4dFJU?=
 =?utf-8?B?R1VuUkgvMGYrWlNINmdKODVDNi96ZlB4Y0tNcUFzRm1CNHk3VDYxQ2NpcTlJ?=
 =?utf-8?B?dVZvdTZSZUliVTE5RmVMSWNMSFNRV3E5UEFMRStlTllTak9PVGwxUU45SGJn?=
 =?utf-8?B?a2MvUW1qZi9odGxmcHJpWUM4alNDTFF6b2oweVJaL242L0lkeHlPWHV2bFBB?=
 =?utf-8?B?R2NuVCtTS20yckNSbmRBZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB5151.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUdFWVVnNTBCTDFmdGhHNGxtNEUrVys0bHAvUE9lZDA2V05sU2tGRCt3ek9s?=
 =?utf-8?B?UkFxazZWYXpqQzNFK1ZINHROcTVOY0liOXBjTXRVUS9JSzNHb2Z6NXBHcU1m?=
 =?utf-8?B?WXo4ZjIwZkRqamo0cXdIYkV2eWlLaTVTT3QyTXZpbnJIU1ZMSHYrT3N6MHRW?=
 =?utf-8?B?QitrdTNJS2Nvb2FydjNmMkc4dTNRRjRNSXhialNldmJ0dGRieklJSjA4azlH?=
 =?utf-8?B?aEtZRXVRczNMYU9KVytTVkZEUEZaVDZGak1zTUk0SUhiU0NFb2Fkb3ZMRFRQ?=
 =?utf-8?B?aUZITWJZVVppQ1JJNzFFUTZDODdnOTFtQ0JvWVFJemxuT21MelFuT0MzYU1V?=
 =?utf-8?B?QThSYTRtalRwL1JTM0V6SExMaEdjRUNoVU9PUEpuQ3hxVXY1UzUybnhaT2Ex?=
 =?utf-8?B?T01SdlZhQ1kzVjNoTzdvMlFFMCtTeFhybWxxVmViWGtSbGdVdEtFMXoxZ0t3?=
 =?utf-8?B?czZuaEtvbGRiSjJCVkhFVWlMNTJ5aitaU2JQazU2MmpYdmhwbkhoQW5aT09l?=
 =?utf-8?B?c1g1M3pYdXJsYUtybkJIdDhVeDJtU1ovcVZGLzJ6M3Vnb0NmbEtaWmhya0pN?=
 =?utf-8?B?ODBEd3lSOFRNUVJENEdrVDFZV2Fuc1pUQnJ1UlRmcGpNWEd6MFFncks5UU56?=
 =?utf-8?B?NWtXclYxZmRZazNJRjRPT1dYS2xRaHRuQkwxUXQ4aUxMMkNQcTVybVdXZ1lU?=
 =?utf-8?B?bkVCb2hBUXhWaGx2Zkp6bWRKYUVCcERha25PQWF3UjIzUnAveEhOQnpZVTJB?=
 =?utf-8?B?NDNOdjV4dlNuZm83MWlhN2pKNDVYSE9qeTZsMjFWT1FYZEIzOFpIdFFjd3ln?=
 =?utf-8?B?WWJCRkFYZEM3V1NCdzNyM0pDekswNW5waVREM1RHT3JvWDNLMFQrLzM5MERQ?=
 =?utf-8?B?bDJoUmVYNE5XLzVsM25GWVFYSXgveGcxakFYNVZhbjdST0xiZUlrUWw3eDFC?=
 =?utf-8?B?K2V2VDQyNWk1L3RMcFFLMGt4UkR0Nnh2bDRFVkF6T0tsQi9UM0x0MHJtOFgx?=
 =?utf-8?B?aDBGUlVTeTdOYW9NRUdOTmVld1lCeC93Q3NOcWhybzNyZDVpWjdWQW9tMkFZ?=
 =?utf-8?B?eHdJUUY2QUkrdVpIVG5ka3Y0Q1A3TXhFeWdodVJLQXBVeFByOWpYbWE2MTdP?=
 =?utf-8?B?ZSs1N0JnTXlOSTBnc3BkTm0vMXhTUjRqY0o1dkVkUCtUejl5WlFuRVpxY2kz?=
 =?utf-8?B?dS9XQVJrSFJCSU01SkQvODlnV3hVNE9hZkFNcHZCREk5ZWlYNVlXMnkrTHJ3?=
 =?utf-8?B?UTQ1LzFzdE54Sklzc3VRTEwrVjNVSGdmRUhTMnlHZ2xmK2d2ZWFyNndCS0dJ?=
 =?utf-8?B?ZW5hNHorQjRlZmgyZlEva0pVQlI2emFHN0hjVXRLWFc0K05zK2NoeFkvemdS?=
 =?utf-8?B?WDJaVlJXajgyS1JOMXJhRURGdVhIUjBGSnR0RTFMT2pSYkVmdUs1TE1lRHJF?=
 =?utf-8?B?VnNBSXZoUFhlSDVrUEZ3QlJlbGJ0c05CdEJWLzh0WGhCR2c2V1NZUEdSdE4w?=
 =?utf-8?B?OGJjelFoejJEeGlmaWxsbExTZ0Z3b2phaG9ySm42bjdTU3F4ZFZjRE5YZEcr?=
 =?utf-8?B?R045VWc3UThRN0lJTXNRSEt1UU9zWDFNeWRnWWh6RDBIdEZkYUZRWkptMjFw?=
 =?utf-8?B?ejh0dUpoUGg1YTNoZHJzaFRWK3ZDY212WWZ1ajlzUldiZnltSVhTczBtUXVG?=
 =?utf-8?B?cVNFUDFEUmVCbGlqMVk2c0JEVGF1RTVSdEJRSXNtZWpBM1pNT0RaeVphWlNS?=
 =?utf-8?B?TU9BZEkxVlJtUjhTeW5NQ3B6clZFbFdkMUI5MU9IYlF3Zm50WjUzM242WUpC?=
 =?utf-8?B?aU1Oa1Ntc1Z6RENzSktZK1Q4SEpYOEQrWFVkZUptcDdjOGdPdWxpSjRUQlYw?=
 =?utf-8?B?K1ZBSmI5eVp0dnAzeHVWdXZhZEV3MW5WZWx4S1RVa1lvWVpYbGtrRFJjWnVh?=
 =?utf-8?B?bzVnWFRKbW5xVkJpQ2dUNjY3Q1h6cTY4QmZ0azhFL1ZWMWJHWmN0a1llT1lT?=
 =?utf-8?B?amdySzg5Q084NGJabFpkYm1wNXVFWFExRXJQcng2cGk0N0M1NStQZzIwb2Vx?=
 =?utf-8?B?dkpBaisweXAvZDliRGYwNVRPbmRkWjMzcEhuZktEOFdQM1pGT0RQek9HRHZW?=
 =?utf-8?Q?HfruDaBaMc+F4GIxLriG4dshx?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 910f0e91-163e-45c5-929c-08dd3582cc5f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB5151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 16:36:44.9023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VFYLcD55nSjiVXHhDguu+uImppXlOMPrLJpkqbinm3v7jSWSGZkkFUb+WqtXbo5tu0h9SmZcehrbQNI7U1cfbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7341
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,JMQ_SPF_NEUTRAL,KAM_SHORT,SPF_HELO_PASS,SPF_PASS,TXREP,WEIRD_PORT autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 1/15/2025 8:17 AM, Takashi Yano wrote:
> With this patch, gdb no longer works in my environment:
> 
> $ gdb
> Pre-boot error; key: system-error, args: ("load-thunk-from-memory" "~A" ("Invalid argument") (22))
> 
> Fatal signal: Aborted
> ----- Backtrace -----
> ---------------------
> A fatal error internal to GDB has been detected, further
> debugging is not possible.  GDB will now terminate.
> 
> This is a bug, please report it.  For instructions, see:
> <https://www.gnu.org/software/gdb/bugs/>.
> 
> Abort
> $
> 
> Any idea?

I ran gdb under strace and saw the following:


   125 6200747 [main] gdb 25844 mprotect: mprotect (addr: 
0x6FFFFFA50000, len 7584, prot 0x3)
   122 6200869 [main] gdb 25844 seterrno_from_win_error: 
../../../../winsup/cygwin/mm/mmap.cc:1290 windows error 487
   141 6201010 [main] gdb 25844 geterrno_from_win_error: windows error 
487 == errno 22
   133 6201143 [main] gdb 25844 mprotect: -1 = mprotect (), errno 22
[...]
    65 6237537 [main] gdb 25844 mmap_record::unmap_pages: VirtualProtect 
in unmap_pages () failed, Win32 error 487

Windows error 487 is ERROR_INVALID_ADDRESS.

I'll try to figure out what's going on.  In the meantime, I've reverted 
the commit.

Thanks for reporting this, and sorry for the inconvenience.

Ken

