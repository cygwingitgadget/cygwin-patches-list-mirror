Return-Path: <kbrown@cornell.edu>
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on20709.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::709])
 by sourceware.org (Postfix) with ESMTPS id 897D8382F98F
 for <cygwin-patches@cygwin.com>; Wed, 25 May 2022 17:32:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 897D8382F98F
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVoGe1jWCQidSqacShQ2GVLM04QSJ48+sy92TiDEcReFOk3SH/CdA1yP4wxuTI1t1meIz5613D0NpYYvmyip7UCg3xxrCAEPFQsDdiuJH0MyVhOfABEFqfdAPNEmBRnBrW437pzgOVdMvhRJZl1vz+reCvOHHr4D5DjGBF0pYTox0DRSkZTmzYRE8+lXntxR0SijFoaX2gIlvy4jrDKS0h9972/g49SCXRet+2T6tYBcJPsMRG+2p4UxuClRRVJMR/9P6we1DQR7dfiRVtkPMMSbIIBIxsWHmZoC3U7E7q4sSf4g0EzlFavS21ifWL7L9SQIz7JbR7Q9+5uQXUjtkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Kk66+J4Hmy5XqJ2mNORVtKpn5tWcjTmtlmeecD4Iro=;
 b=aybtqqd0eB5k3Tdasb+DSlWncE5RjVAjXCgWdufAEjIctFGvg+jh8K4Tp8S7wscR+AnIAtpt1cwfHQcScqP9EkPQL8J7wzoRByVAdGhAqEp8Y0kigo7nqqm9MB0xLMNdGSwXRoJHK1KJrLj5ctlk/Y58RjE4qNtVqwfrOM658EJP1pF4bG96uaNvt/MOlFvJD4LX/s7PPWWGJPhmu3NLtRt4QFVW88FvOIhxha8Fr2o1uH0tKyPQJCP/AmpDaSyoSZWkTgYc/n/C5I9Rm3oVQBp+VbDJW6uWhsy5XFBttT1gdY0TJgK/MYsjwmT8UBL16W679aW6aDiWlylhbnfrfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Kk66+J4Hmy5XqJ2mNORVtKpn5tWcjTmtlmeecD4Iro=;
 b=FqHb+ptTJ8U1zOfdgYr2uVfYVyiJqAe1zcsw5+vWIywYdcg+ow1uK9WYaFwCXKulSQ+QgLZO0vux7MyO6c+H9/BVsJryiJsuxGioJXHHtcACB1fQQSJZtofTekmCJYMnphcWOzQJfaB9eAGlRaMs9czWwJksMUN1eayjTWAXdhg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by SN6PR04MB4733.namprd04.prod.outlook.com (2603:10b6:805:a5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19; Wed, 25 May
 2022 17:32:11 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::ed45:6a5d:b109:673e]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::ed45:6a5d:b109:673e%6]) with mapi id 15.20.5273.023; Wed, 25 May 2022
 17:32:11 +0000
Message-ID: <3c6a7890-1735-f256-e4c1-493790c74ded@cornell.edu>
Date: Wed, 25 May 2022 13:32:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] fhandler_proc.cc(format_proc_cpuinfo): add Linux 5.18
 cpuinfo flags
Content-Language: en-US
To: cygwin-patches@cygwin.com
References: <20220525123045.8880-1-Brian.Inglis@SystematicSW.ab.ca>
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <20220525123045.8880-1-Brian.Inglis@SystematicSW.ab.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0105.namprd02.prod.outlook.com
 (2603:10b6:208:51::46) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84dc4292-5883-44ee-5b16-08da3e747fd6
X-MS-TrafficTypeDiagnostic: SN6PR04MB4733:EE_
X-Microsoft-Antispam-PRVS: <SN6PR04MB47334C1367F1E97A7128DAF6D8D69@SN6PR04MB4733.namprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mkXFFJ2WCoxAgRxOhWdLJFesgrW/nqqpaikPZpeI1NZ/JXA8aYA5Wn51xAeHagEUJxGI0/e728PvZc1i3gJwjmwMFjuftuEtFVoc0PtJ8pmOE30KZGpxOQCCdrJlpmdG5XrCNuu2FPdLurxl8SzH7DCY/X87hNubZE5ZvCjjhQQgK0JsKZ3nWizSjYV3NAS0A6K43YpU3gty0MtXF1B6QQCPaQHxrgkYUhCXm8Y0kiTTwwC0DQwmyzgpdAI//fxLf/J+w+vYh7yJWSfw+CGcd7KDkbglZK5O6+wZ9Td/NBIrfIhXXLU8iDo3+u9l97yEKxaj2/gmwPaKU9iXbpO5w/LYlS+t2D6Y3RHHDDy4AFVWgYH+MYHqr60MzTzlLEkDpDBMZehA8ZF/swz7Cu5ZW+AaSAGLYhMMhIRYp/jEnE+Af13JwwucetImDhTjWqox7vuyENvGbkqtzeSEifYOWlKJnXccpZQh9uMJZSkSIiL7C0UQRDyhOZ3ywlmMJ8jRpci/mSbus5kCDCIfLJybLLppo5o/IoKdP/zHnteT1ux4N02/4Xg3DBXsVYkapqPJANoz8rQdZ5Fauef2bbKPl/WqaEfIkw+98y3zETbhr6ZtPHgTluAR+rQ5FaOYgfATV1ai7M8PDns+sRLTXdIWmTk4yMF2sogVkwPLEYGPZ/IyFN9Byfs7VsLMpoqX5z1aOqT1gNYdjgqHy9L5tVaAVhut+JZeZZgkB3UXY2Vewt38RLxC2B+3IVJ3yD8ncHqDgepMF7PI4Fpup9DSmLF/OQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(53546011)(6512007)(6506007)(36756003)(38100700002)(6916009)(4744005)(75432002)(8676002)(5660300002)(31696002)(786003)(316002)(508600001)(86362001)(186003)(66946007)(2616005)(66476007)(31686004)(2906002)(6486002)(83380400001)(8936002)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnE2bThkSitRNi9NSWFVU2V3V1pESmduTjBzN2FJTXdaSUFPYldjKytwY09h?=
 =?utf-8?B?TTN4MTZLeHB0S2hmR2s1OEFwTWQzcTdrbXpCYlB4S2VoUTJ0eDZWNC8wbFNw?=
 =?utf-8?B?VjhrYWxsQ25jeFoyK2lvcUJQMWIveW5PbTNZa2JyNVJHMUJrYS80NkhzeHMr?=
 =?utf-8?B?NzRINk5QVFpJKzF1YlhIMjNnYkx4MUMydEpWTVV4Nm9xM1E3SDFTTjdaMXdF?=
 =?utf-8?B?UjlRcndsbWVtZVBITHdqMFJzMzl6Y0pEVFFMQVovUFo4dmpFamdubVZBem85?=
 =?utf-8?B?VlRCZzVsbEdlNFloWGxIMnVGa0JzNXJLc1IzdlBDWEZHV2Q2eWpHTmgxZHE3?=
 =?utf-8?B?S2tCMUpvSDlGWDJZeURYZU95Q2tUM1dhYUw1aXZCekdQcUlVK0Z1a0dlN09s?=
 =?utf-8?B?T2ZoUW1rSXg3Ri8rK2J5cDJDSElwc3h3Rkd4N290VFh6a3ZTbmJFeitLUS9T?=
 =?utf-8?B?ZDBRR1pnN3drRC8za1luTjl3SzBGTTRxbC9HcFBvOEZRWUI4emx4bDJBaGZI?=
 =?utf-8?B?cDlYOC9FZU1QSDJBd2NjVERoTk9DMUpyVGdJY05ZWlM3VjV6cUpuK0hBYjUv?=
 =?utf-8?B?WmlSSUwxcDVObkl0dytxcm5kaGhZNGkvUDI0U2pzV0ZnZ1VRVkxHdHRkTlJv?=
 =?utf-8?B?aHVMWTdReXVLYjk1bFZhV01QOWxnc1QvTHpjbGFjTVBKMFJpa2lLL0tEcUM4?=
 =?utf-8?B?V1VSRXRBMmR2WDNiTm5xSGJISVMvSFVHU1FNMU9Id3FYQ0Rwd3YyeksyNmcy?=
 =?utf-8?B?MllTamFYSjhZUE5YajJzYnlNdnR1SVU2ejk3TnJVN0pxcHFZWlp3NVdYdldj?=
 =?utf-8?B?c0FwYnBpL1RjYlBvdEZkT2JwVXlsR0NXais4WTdqMGh6NXFZTWhqVkFlSWh4?=
 =?utf-8?B?ZWRNeFFIWUh0bmVsa3ErU29FYjM4VlRqR2hlRjVpb091MjU3amV1S0R2QWpC?=
 =?utf-8?B?c09ZOEpnbWRxbGpnam1Db08zZFRxeERCdDI5NUxZRTZtdGRVa1I4QWF3VjlP?=
 =?utf-8?B?OGJvTWFvRk1ia2VmZlNrVm9RM3pjVW5vcWdzVW5OeHQvK2ozWVBzUzhRVHNw?=
 =?utf-8?B?TkxzVmk4eFlFVCt2cnJkZGZpb0dIa0wxVmk1aHZkYzVyTjdXN3I0cTBualQ0?=
 =?utf-8?B?MzVFdTFPaVkyUjcxaUszZk5vdWZpT3R5QjdIMFl3a1Z6am4wTForKzJrSnFk?=
 =?utf-8?B?QW9uR1ExSkZvVDV0YU5yN28zQ3dhN0laYkdVV3ZwSTJqck5abmduemNCbUVm?=
 =?utf-8?B?RkVuSThIR1dsWHMwUHA4eVNIeUJhcGU0aGJTclJPTUZ4T0g4bmo5Y3hacFUv?=
 =?utf-8?B?aHRPM0VRVFZQUE5NZjJyYXhkLytXaFRHK1hMSTdpbUt3RUN5YklWNUc3THRO?=
 =?utf-8?B?clNQSDE0dmc3ZTFDdjN5czBQek9HM0dkdlZOeHE5UTNvanRkcU91SmJqblY0?=
 =?utf-8?B?djRlRVdldFY3eWQ1d0UyenFVZjZGZ1FKMGYrcGFGQkdmMTR0emNHM2IvclBx?=
 =?utf-8?B?aGo0ZG02aVlObG5GQ2MwV3hOTU9GNk94WElXVTlzSGIrc3kxMkNMNWNGOTRy?=
 =?utf-8?B?eDZpZGFqNEEvOE1wMUR0OURnNDFmWUxUR0JvRUt1NjJ4QnZyK0hMblR5VEtj?=
 =?utf-8?B?TTR5aGxuM3Y0S3B6Q01qekIrV0NmMCswNDEvaDQ5SmZWWlpNaFZLVkFrbXJ4?=
 =?utf-8?B?d1ZHSHNzUDI2V0dJdTJjRUJRenBRZnNBK0t1TmtwNEIvd1JGZGpycUVaYTY0?=
 =?utf-8?B?T2tYdnlpWmkzTGJUclJvanc1K3I4MVdsOGJ1TVNiTm9uaU1nTWdoeGpRNFFX?=
 =?utf-8?B?T2VYeWZaVWJub21HRVR3YVM4elFpdGlUdnREdkxmRkJVUXBoTldpeGg0Y29M?=
 =?utf-8?B?Sml1Q1dBUVQrTG93bDVaOTVTUjhOZUJZWS93OE9aejliOXkzSERzNmo3WTJw?=
 =?utf-8?B?OXdNZ2FtcVZVRmxoTmU2QWZzclJCSkZrNmVtdGliVkwwdjBjS2hsL0lqTEF5?=
 =?utf-8?B?SER0TFJ2d2hJTUhqb3EzVUlrSmpsYUdKMWg2UVF2STlpVExHOWdOa2dNdGY4?=
 =?utf-8?B?T2dRME14TjF6MldGOXdLY2RxeS9pQ2pPd3J5bTN1WnhnZG9FZ1gyYm1uNzVI?=
 =?utf-8?B?SDRGaE5tZTY4YjQweEQ5NGhsTmFMR2NZZDJLa0dzQkp6SnkwcVlUclk2TDRj?=
 =?utf-8?B?Rm5uTUpsTjVvMGpWUWYyZ3daeXM0Zk5IZlI5end1RWpiVDVQTDc0Um1yUXZZ?=
 =?utf-8?B?YjVYUlFCV0FLY2h3UXo1N1pjR3Q4RTRha000Tm5pOVFDNk1ZWDhYUGEvUFVY?=
 =?utf-8?B?WjVsN2RnbEd4c0tIdlZDdGdoZDJkTXZwZkJQR01MMTFGZE1jZU5SS1NPVG1l?=
 =?utf-8?Q?t87u75bT1kHZK/oV827aRqQ56i7s37hcNH5GC5NeEr01c?=
X-MS-Exchange-AntiSpam-MessageData-1: xlv+xNzPczlpbA==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 84dc4292-5883-44ee-5b16-08da3e747fd6
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 17:32:11.0104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +9FRlzRJ2crp9DVWWKM6R4L8wXvXfAHwxl/TyAImIhGXLz+qTuFL0Xk2OCP6WFAfj2T6J3N2x7AVLL/gOTjyOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4733
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, JMQ_SPF_NEUTRAL, NICE_REPLY_A,
 SPF_HELO_PASS, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
X-List-Received-Date: Wed, 25 May 2022 17:32:17 -0000

On 5/25/2022 8:30 AM, Brian Inglis wrote:
> 
> 0x80000008:0 EBX:31 brs		AMD Branch Sampling available
> 0x80000022:0 EAX:0  perfmon_v2	AMD ExtPerfMonAndDbg Performance Monitoring Version 2
> 0x00000021:0 EBX|EDX|ECX=="IntelTDX    " tdx_guest Intel Trust Domain Extensions- Guest Support
> ---
>   winsup/cygwin/fhandler_proc.cc | 22 ++++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)

Pushed.  Thanks.

Ken
