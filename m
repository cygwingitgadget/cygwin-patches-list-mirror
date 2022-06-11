Return-Path: <kbrown@cornell.edu>
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::70d])
 by sourceware.org (Postfix) with ESMTPS id C321538A9CA3
 for <cygwin-patches@cygwin.com>; Sat, 11 Jun 2022 12:58:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org C321538A9CA3
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBFw6i89LkNS8a5IMp/mRKVRmLG+nHPsel13WRo/MjHCauAxCTocJN5tuUCmDfAzGqAj/EP1bkIAB6vLhkbzmxR+9tnOAQGu/2ju0gq1iSPcr1uCE7SGq/RdQVKDPYvzCFd9o7NYluQSMER/Smuaik8icRzSNMd1x+wUHZO1Dn9T0OjsKihR8WXsRPkPNpYZVRkUgwdx6u99hfeuXWS82r0tmS0n5WU5lH95nwv+o+qMnCruXTSpcKqXZy8X5ZTnPUr/894A2x78VDi+MGvCQK+llpcE7VqyS5TF2UmIZd0x3ndncOWGXnLhmBNpEFL7DRSNsOww/3rwi/jXPxxuPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53fkb4Bb9W2XwxOSXenUotM3onX8GM5/DQlGbBqJ/nk=;
 b=i50kXJ6yuijkE8vVycdBX2orOEZRGur5foB/6wewIvs2QqkR/kD5Zw2TJw/g/mTTrKKDSvvq98vb3iLg1Qh7450JUbisz8rsepl8/GTM+neMhaT6UX/bDq4xYvBdQ/0e/tAbZU7eSp7fmyCkQV8sQtz1UGYWEXo280ul0V1PqiKz1xpACf88gAbGC4tuJ5LSKmPciuIjaLzSfIxZv7kD+RisP9uEtrgpVvMucovDh0AFasplsK6Xzypv83nGD68gfEynZ8eHQ0sGRDnyMAbXwmiQZKv9zhi+4uPzk2V7DE0/PVCyy87wfVjocvtX/41j990WekRJKnORr3GNuytiRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53fkb4Bb9W2XwxOSXenUotM3onX8GM5/DQlGbBqJ/nk=;
 b=AwQu40iD/JXD+c+Z8lI3NQKmdBleWJaHxI6vOxe3oHJGWazE+idd37tzVtRcOT/EwlRrRZ0p1dSwovugJAx/x0ejdDH2sLRQoZYOps+lJQixlgNkKRrWN6M3Cx1tykuqIvjj7yyzcZcAzBrvly8pH1Py2/9xiW20aPb/G1HN1dM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by CH2PR04MB6587.namprd04.prod.outlook.com (2603:10b6:610:64::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Sat, 11 Jun
 2022 12:58:25 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::9db9:737b:d7ae:d913]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::9db9:737b:d7ae:d913%5]) with mapi id 15.20.5332.015; Sat, 11 Jun 2022
 12:58:24 +0000
Message-ID: <23cf860f-078c-fc94-0e9a-9841a2be627d@cornell.edu>
Date: Sat, 11 Jun 2022 08:58:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 7/7] Cygwin: remove miscellaneous 32-bit code
Content-Language: en-US
To: cygwin-patches@cygwin.com
References: <2de3539b-efc2-b6f1-b9e3-8429ecb24c0b@cornell.edu>
 <ce7de251-14d1-e54d-e2ef-5b67ad256a64@dronecode.org.uk>
 <c5bec956-6e71-083e-f3bf-f6b52726b218@cornell.edu>
 <YqIQX4HJ8lXveQdx@calimero.vinschen.de>
 <d4c98759c0e3d7fcc72e13566d7c00d71a52bb52.camel@cygwin.com>
 <97cc06bf-913b-864f-673d-71dc8dfbc64c@cornell.edu>
 <20220611212950.2fdc71e56243330266c4fc76@nifty.ne.jp>
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <20220611212950.2fdc71e56243330266c4fc76@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR10CA0035.namprd10.prod.outlook.com
 (2603:10b6:208:120::48) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c212ebb9-5f31-46c8-3684-08da4baa11de
X-MS-TrafficTypeDiagnostic: CH2PR04MB6587:EE_
X-Microsoft-Antispam-PRVS: <CH2PR04MB6587F186624A75F536417602D8A99@CH2PR04MB6587.namprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KvD0ZfkXEeZFhcaztgK7AAWZhPJifl0+ZcDDxWQGkPwVuzdM6G/LRsRKSEGbITHZN+f9zelpGIzfndMc3+LdmnB/0SfAYFWeqwfGFfNyq6ozXC1Sa1CezetcIXjr6tMvYo0ArARDCjRSVIOj7ZT1PfPtQsU+viSWgVRbhoUao/rFpQDQwW0yPzxFxJKv4yXD1fWlfBgcOYvNZIvZ3k5C7SNylgeKwfRN1UdtJCdhEuEcQIQ1Xae4fIPK2XgsiDLOy6VVj1NOKtISggckNA5QXSI3fdDzO6zjYohkYGFZR8prJY78Germ2/kRc7S0XNPUGG7+eZsmUHeGVtiZwAdTXUYk8yJiSyITWkgo/dwPhxyjRfDn+/2+ARM9Css1H7VzXYPUDCopEFi+LJUJpBNO4Y5bMTBIxFsxU/CsT3flCxn6gyUwVZ/zedlRJgjQBBY6H4HzW8x56Lia1IvyxM4Zg+DEPunzgXnFqMBdVXmKhdgss2Plmznxj5Addp5VDlQi9BFROeBnhB8Slo8UnR8xVebWqxBsGiYAA3k2gfKL/36XlarkJJFqhlNR0gUxP0Pup6oJg46B3lRV4c6OxewrebhOgSKmbzcCln5Vkbw7khyIvLHQJVfQQu5CYZZTGxYV7kt2RSUUs91yYdjPzFG9UO+JmYE6cwWeaaMKSfSbE2CO/CNYFnnQlWssO9WgoHGX/1u1lYKWbLAQurluRdLYsmVziulmfhwRegttXZMI0U0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(66556008)(66476007)(8676002)(53546011)(31696002)(6512007)(5660300002)(6506007)(558084003)(508600001)(6486002)(8936002)(2906002)(75432002)(86362001)(66946007)(6916009)(2616005)(186003)(316002)(786003)(31686004)(38100700002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUFWdDQzOHJDdjhhZEVJM3Zwc2hEWGJFT2hMZnV1amJSY3pCc2MvYWd5ZWUy?=
 =?utf-8?B?VkJaTnZ6UHpmWWtsMkJ6UDlVQXRMdmM5NFNpa25YWmtPdU94azFXS2RTZGdX?=
 =?utf-8?B?L1hiOE1RY0I2N0EvOGhRL08wRm5UY05VV3IySkVXUHE0VWdpVUs1QVJ6a0FR?=
 =?utf-8?B?bytEYWV6K1ErRWZsWElNN29ldmQ3aXp3ZCs4aEVHVGhHYVpmd3p6RzloYzAr?=
 =?utf-8?B?bVJjOFFrdjMvQkw1YkhZNEVZSnNjaGE4ZG56blZTRUxSZ2RiSmhtT2wyb2tq?=
 =?utf-8?B?OWQ2bHVxQ1hTdUs2emVETlp1R1BnTmxNeWFhWlVGQnQ4cTl1cEo3bVhjMFU1?=
 =?utf-8?B?T2pzS0hWWDRqeXVYSnhIelFQS0xrY21sc0p1YUpmSXRHMDhMaytUcDlCcDZm?=
 =?utf-8?B?VXpGSkRSMENBWElSMUcxQTlvNHEvZkZYZ054cHk4N056TDhWakxUb3d2TVM2?=
 =?utf-8?B?Nk15c29pVFZjNmFsQW9XN2pmcmE2bldCMFhnd0svK0tMRDM4NnRJc2ROekJ0?=
 =?utf-8?B?RFJwaDFLWGFBckwrOVpsQTR3R3RTRU0ySGFEYzRMdGN6dVoyTzRtN0lPNWg1?=
 =?utf-8?B?NituaDJTNmUrYjA2alpDWThMMWJJd09yeDFLN016ZmtlSmU2R3RjajdLMmxn?=
 =?utf-8?B?MEJyU2kycTRzeXhQMXJZVUFLVndxcE9ud2l6SVU0ckJIbE9tMWViNkRWZHVp?=
 =?utf-8?B?M0hlSlBYNG1zdmxsYlp3ZFQ2MldTZTEzUlg1WWJ3VGtyY2c1bSttZFJjZFZL?=
 =?utf-8?B?ek9kSmFqNGZKK1ZjTU5sOHRqQkoreHZrNUNMeWdzSFgweHlOSlBrbHQvN0hL?=
 =?utf-8?B?VkY5Zm0veXc0YmNUbVcxakkzWWZYOGFpR3ZWYWs4cEJKQVdneldzZy9MV1dm?=
 =?utf-8?B?TXVoTmtuaDNMZ3M3T3gzMVdRdzYvZ1lCUmFaall2UzRlWUQ1MkJMaStVNTRK?=
 =?utf-8?B?SURiK21OR2tLS1dRRjQvbE9DcXZpVzZjV29sVlhTeXN1M2Q4ZDVScXBWeVVW?=
 =?utf-8?B?OGlIT2dSaU9ockNXZTZRT1JhN1krSU9Vbnp4S3QxSU00M2dXVjcrMUtoOUhV?=
 =?utf-8?B?STMwWmRFRkhJSGVzM1pCcmIzdXc4R3UwME1KUmg3bEpQc0NxOU4rNFVVaTRj?=
 =?utf-8?B?K1pPUE5RUTRpaE9xV1ZGdDJNczhpYjQzRmZNZFQ0THByTFI5bWpXeTRWN3Bu?=
 =?utf-8?B?T0JPd1p6VGYySzIzcmxVU091dlFIbDFJVXF4N1l3TE9BRGJ5YklXdzA4WHM4?=
 =?utf-8?B?TWR2RURXV2JFNnFvY1JHeVZielUrYkRXSU4vWXM4WnFRK2lod0VoVHByZHZZ?=
 =?utf-8?B?Q0J2eXNlWEJDcklGWUsxcmlPRndPaFg1MG1nc2lEVlN1RklKVGhuUE9wZ1JQ?=
 =?utf-8?B?ZGlkVDhTREp4bVBFZWs4MElqU0hjT2JJUzVDKzNYOEFiOUxxZDd6NHkrVUNJ?=
 =?utf-8?B?U1c1dTRpZ2tRL3hLRmdKSjVIUUF4ZWQ2eEVQemtxL0JIdk44SkRZS3lHc1Zp?=
 =?utf-8?B?aWFTNzh1b2NLNk5jamZWQVNSL041alpYM1E4eitua05LMk41REFKTndGYmR4?=
 =?utf-8?B?Yk8wcGliU0hPemNyc2FHQzhqR2VGYjRpODgrYnBpNjZXU21aL3RjaXkyNVVU?=
 =?utf-8?B?NCs5WncxaGZPVHVTOUJlQjBYWVF4VGdNYnhhMnlxOHFtaTY0NytXVTB4TlM1?=
 =?utf-8?B?NFJoOERzZTc0NlRZaHRUVDJSU3NXendZU3lzUDNWbzB2WGI3N2NWL09nOFB2?=
 =?utf-8?B?QXNCT3FxOG85amlQeGlJRjdrVzJGdTZ3NnF6WUFmcFprRWZ4MkhQdFNqL0FE?=
 =?utf-8?B?ZHRIZlduM2d6MjBiWjdkR0tFbGtOblg4cFBIUVdEdklsS1M2UGJwczZPOGpH?=
 =?utf-8?B?TTV4WWM5VVFHKzZIS3FqK2JPZmp3TnhIS1JSMkJTanJSZEJ1ekFVV1Q2U1dM?=
 =?utf-8?B?OWltbDF4eUVsbllxWGt4c1V0UE4yTm5jZzdaMmJnTEg4bWpUSHloeDcydDR6?=
 =?utf-8?B?ckNxVE1sWHVINGw1RTRxQ3lGK2dWQ2xtdzdoYXVUUEZ2WkFkd3hEMEt1Qytz?=
 =?utf-8?B?TG5vRUVERnBXdzlqZUpqVDJVUFI3MEhpL0M2SEJyVnR2a2g0RTdhT0pWczZu?=
 =?utf-8?B?ejlCZnJkZTlHOVoyeGlwQlArTWdJdHpRUlBuZnRma2R2WDRRYTRjNmhTRjJP?=
 =?utf-8?B?UnM2OVAzQUxMSlp1d2pkaVVnM3VaT0dLRlVuTkJJaktkRmRHbVk2M1U2c0cz?=
 =?utf-8?B?MFFQLzhxWlBXelRCL25LZEVkd2pUZTEvZzVWR05DUmI3OWxLZlBKd25Iemd1?=
 =?utf-8?B?WG91RzBUc3kyK1RhS2d3cDFLMjRra1JvUEk5Z2VkbzRBL3l0Y3lrUGFUdG53?=
 =?utf-8?Q?VjX6fGoGGjVt/4gkRB3cm5U9qnlw5yv795Qd78pBsgLUr?=
X-MS-Exchange-AntiSpam-MessageData-1: HALPuEtNoX90/w==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: c212ebb9-5f31-46c8-3684-08da4baa11de
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2022 12:58:24.5770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kVgO2RugrmgMctS+QjOboPisYgeteXQbETuaMXz5bug1y6jSm+e4ugzKax6K9VQOASh/vJeElSDqcl1Aui/FDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6587
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, JMQ_SPF_NEUTRAL, NICE_REPLY_A,
 SPF_HELO_PASS, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sat, 11 Jun 2022 12:58:30 -0000

On 6/11/2022 8:29 AM, Takashi Yano wrote:
> On Thu, 9 Jun 2022 15:04:29 -0400
> Ken Brown wrote:
>> OK, I'll make that change.
> 
> Isn't the _dll_crt0() code in dcrt0.cc also x86_64 specific?

Thanks for catching that.  Should be fixed now.

Ken
