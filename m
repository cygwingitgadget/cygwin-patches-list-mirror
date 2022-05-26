Return-Path: <kbrown@cornell.edu>
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20729.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::729])
 by sourceware.org (Postfix) with ESMTPS id 00D423834F11
 for <cygwin-patches@cygwin.com>; Thu, 26 May 2022 19:17:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 00D423834F11
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2fdmPPEUO6I3HPYpXIy15qe9vBFw8vISuFx2Q55NMJ5cq4SpdE7zapHdtHSFlcXp0oWVFzPMc1JOhA3ZavqrKt6p6QDg3Wew6g9tgvG1qqkMnkC/MuLoF2a7Ez1ILt/qMDZYR6oKJgQFLPlFKrYVuY5KaPgeIi7b5PRdqd9NpvLHrcCmBajWBaz9t9cxUlr+nc63s7H7aivwYZN+BzZANdO/EHx9mAdJTBASHP34TRVUrP3y3HSJdUWwZN+Vs58WeVYbPa105xOZcoR6YQEnznif+yKM3DwC3/oqfbiKJApEEPJIlW77xoM8zsBkmjRj7EitH5MWr3XfR8QPIivxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=XvvpKZOxLZjHRiNgcPh1Q95jhMnIIDo5l01Za9MUVBHqC2xznP2jWGAJZGkd80YOerMBq4Xm/xmMH0hhzXkkUaRlmBljupnPecDAqa7zYMfT6J8fTmp2loNaVD/9xykkVCwfdU8AHgm928+PaZ3cvyF4yPa/9fH1i1mkCy5+GRpBRa6NqH2vvYprCkLNakqg3EbMl+WS0QuE5lhpb8jTkotrfWJN3nXa0W0DJWdVllW7YKjJ2MovJJ9jTDiREHwLGvyyGaeeAQSTk1TLPt0eSZn0pJhK6Hzj4TQLYVpOb/Jxqv2jpUASUWZAGrs7uxNHWLoPVvSl8Od+j6bGvHVOeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=Kh3HnBl8d0VwWTkp0a23xTWh8SHOxJIDHyxxk410T0DaTgSSi2pmcafdGGPpM9//VrqcI2U2m6GiEwUvyWiqzS5ZT3riQmCLuVt1gFTOwfYeu8eZ5nhjYwYLuRUi3vQR/x4bZj39vRZXEiEYT2oLBqaPl44vNDvfmIcMBW0l8AU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by MN2PR04MB6461.namprd04.prod.outlook.com (2603:10b6:208:1a8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 19:17:28 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::ed45:6a5d:b109:673e]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::ed45:6a5d:b109:673e%6]) with mapi id 15.20.5273.023; Thu, 26 May 2022
 19:17:28 +0000
Message-ID: <8438562e-6a98-3677-a976-092d75a2b43b@cornell.edu>
Date: Thu, 26 May 2022 15:17:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
From: Ken Brown <kbrown@cornell.edu>
Subject: [PATCH 5/7] Cygwin: remove some 32-bit only environment code
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:208:120::22) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a293ef0-97d6-4627-2702-08da3f4c5f98
X-MS-TrafficTypeDiagnostic: MN2PR04MB6461:EE_
X-Microsoft-Antispam-PRVS: <MN2PR04MB6461B4574787CCE407748626D8D99@MN2PR04MB6461.namprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L9bSi24JkvGImzOJMDYXrLDgdTNaMDtTA9bjshoiWGBxcf2TxnwvHqZ6AoxMqmoBIr+h8tu16feJ+KW6sFj5iWB00RCYkha99d36g+boSrG+DQIaLxoASEpU81v1m3fsxa2ECgCXiG5peZ9sulS9YTiDCWYlqOeD6J40HInkJSr2FzKrFH6N7ZxCo7TlGGn1bChPoQhYoUq1smlFP99ytHQvauzCKmIblsnKZaFmWmyBx6uU2cnWrzpF4pKmQeYTZ5TpX15eEAEPP6lOfvxaEdNMsVycrXnGHjP7bZuddkUOePSgwsaMlxyjhsugBRx61t9Paux8dcViZ62s1wDokTjDiC25zPoHvt3hSk4lKkQbVEjCZ51hsLCSM2wciUWpa2finvbG9z3KGRsCAuOS3lHFZHOxzpjEJMH7+W1eM5lsHEvlq5mrrIypsnpVLKyejT3A6ONHMwHFnWJPV5R7/6Izqkjo++VEtC3Oy84hC3w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(186003)(31696002)(508600001)(86362001)(4270600006)(6486002)(2906002)(6506007)(2616005)(6512007)(8936002)(786003)(316002)(36756003)(66946007)(66476007)(66556008)(8676002)(6916009)(31686004)(75432002)(73894004)(621065003)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEhSaXVZV2RWY2ZvWmNyVE41ZE5JdmZYdmczVkdDclVUdkRQNVQyU0p1N1JF?=
 =?utf-8?B?SlVRR3JBUVhMMmRTbmhYRmQwaTIySmc0eWVNWnhRTkVKREN2OFMxVm9OYzlu?=
 =?utf-8?B?bnpZbDltV2lFLzBpbGFxQS9KSzZEMzVNSEc5ay9JUGFieWY5Rmd1TWdIWE5m?=
 =?utf-8?B?REU1cVZ5TU4xWEtoTWhNUGNIMEFxZEhwLzRIelRhVzZ3Um1seG9XVnluQS9y?=
 =?utf-8?B?dlIySERqNHdRSW5pdllQYjJpTzRucXhCSitDM1VXc2dyaTF2cUo2d3lZckZO?=
 =?utf-8?B?cVQ1WVQ2Mjl5VGFMZTVhbnZUMUU5Z0gyQ1NkZFowYVFvQWtSSlpSWG5aVkp4?=
 =?utf-8?B?Qy9HdG1kdFkrdXlwbHdwZzFpb1AwYVZOanpLQUNPZXBVSWZrRi90V1BxUlps?=
 =?utf-8?B?cUZDWVBOSG5PSUVMZUtqeE1zMXlZL3FNbkgwcEx5ZXZ1Yi9QaXUvYml1YURP?=
 =?utf-8?B?QTg4M0VQZGp0Y1FLNjdyZTBaZ3ZOcEY2di9qeWtjTUozcTJwc3JaYnJOcFpk?=
 =?utf-8?B?VFJwTlU0a3piYjlCQk12R3o5UTN3NFd1bGZEdmxiL1JGcFNxNU50VDM1SDlu?=
 =?utf-8?B?ZFFCWjg2Z1BlQzlrd1NvWDBZaUJmZS9iSlk3RU94c2U5bGd3K3hMU3dJeEVl?=
 =?utf-8?B?MFptdDlrUkMwdkNjODlmS1J6bm9jbEVVbHNKYk8wWTJuSDRLVU10Wk02TUlR?=
 =?utf-8?B?VkJmSWd2N3kvL0ZwREFNbXBYLzRLQVZXMzJmQjFacldheHRhL1ZZZnVtSUVq?=
 =?utf-8?B?RmxvNjFvalFhRDdXSUhWY3IwRjJLajdkTFFpQXhhTnNWUmh1L2dMeVFQSWZi?=
 =?utf-8?B?ZEFxZ0QzZTVRRk1UZk84eUlaRFNLZkUwcWRxcDZIb0NieUtnaE9Obi93elcv?=
 =?utf-8?B?aldPWlJIQVhXYXNsVS9OeS9LekhIcEljQTgyVWNQN2FhTldkOE9UYUdjWm1L?=
 =?utf-8?B?QXpJc0pHOUcyNGY5ZWNFd1JITjNRNlRGMGFqc3BuZ2c3RFZWMTFCeHZHdnhI?=
 =?utf-8?B?Z1RHLzRIY1BsWFJZUWozY0d5TXpEcWRpclhMTFRVNG9uTG43MTlTRC8rUGxI?=
 =?utf-8?B?aWRUZjJLbWx0QkcvaDVteEpiV3hsNjBHZVFxcWxZRlFUV0xodENPU0F0M2Nj?=
 =?utf-8?B?V3oydDFBR1Z4WXdHVHRIeTIremtqRGVPUmExa0htZmhwbWxjTEdQZm9jMHY1?=
 =?utf-8?B?VDlKUDFVWnBUcHpiM25GS040ZWdrWklvRGVxb2tkbHg0Q1c4bkJaYlZwd0hv?=
 =?utf-8?B?Vjk1WEZsODhFSzZYQzcxc0t3WnBhTjdpM2dhTjBFVWpTR09WOGNUR1ZMdnZz?=
 =?utf-8?B?VWxQbU4xTUorNXVPdGluTk9iT09pYmlSaHc4N2ZjYldvOWtiOEJSMzltd3Va?=
 =?utf-8?B?ZXBPSjFGcmYzYnN0T29waEE1TkxYYjNoTXNGV2JXUEhIVmZIZUJlMS9aMVRn?=
 =?utf-8?B?bk03T0U0OExhRTBlWkU3SlUzVTViRm0vN2ZjYmpoa0t3WnN6K2NTWXViVFIz?=
 =?utf-8?B?R1FrT09NdGtNTlpVa0NWT3pkK1JvRHp6dFFtWEFVaG9oRlVMOFJuWUoreVNu?=
 =?utf-8?B?TWs5aGlWbzRDNFZtdmlSRzNSYXdGaFFyNS9rRTN6ZWVIWEFPR2VhZ1dxYUhZ?=
 =?utf-8?B?d3lRZGplM0FWMk95bG5zcTBXM0RHREVyNHhERTVHcCtRT21TNVYxM0FrNXo3?=
 =?utf-8?B?VlhHT1pYamh5MmE1TkpIYitwTEVvUnZZMmp4aFNTd1dnenc2ZEJoRFV3dkx6?=
 =?utf-8?B?STI2dzRxYWdjNWpkYlBvN21YaG9ZOUFpVjRzcWJKSDlqdXQvOUU5bXltVngv?=
 =?utf-8?B?TDVjR3BIZGMreVptTVRsYkdCbk90QmZTdGtxTFV0MXBnS2Fxb0haREl4MlNF?=
 =?utf-8?B?VEYxWHdqOW8xZWlHVm9qNnpSMSsvdVNpU3Jzdmg5TDZmOHV4WDBKK2FLQThK?=
 =?utf-8?B?ZzJWUUxmeEV2dGw3QnN0YzhoTGhOb2xlUHJYUzdrb2czQ3ZjK0pZSkZUVlhy?=
 =?utf-8?B?R1cyMStZbTdjL2FVSmdSTEFiSDJ5Y1MyWGtmUmZCU1pSNzBTV1g5SUluWFJI?=
 =?utf-8?B?TUFzVmFPM2hrZStjUnJTTzdJNUxGamhYZERYTHViRi9UQi9jaFNyWVBIK2pp?=
 =?utf-8?B?UVdYOVZ1L3FXYVc4bmV6QjNUeFhqZ0I4eWRmY3FULytNSFU2SWZmUkY4QlZ6?=
 =?utf-8?B?cW9tV0JVMlh4aWtKVURDTDd0dTg0Rk9BMSsvMEwxS2lkY0ovOFJQVnVWQ3hv?=
 =?utf-8?B?Q3V1ZzhOQVJ3YUZKYmJFUENWYjd0Vm1qQm9XanBLcHpteTRtNU04RTFsSjJz?=
 =?utf-8?B?U0NMWE1hZzdCcHRlN2VyYVBkOGg2cElUdHd0Y3lpM2ZVeEJxMXZtUG9Jc1ZH?=
 =?utf-8?Q?b2TZnLoMlC6cabebDMOzMokXfrhSLmtisrvjM2oHwEi5F?=
X-MS-Exchange-AntiSpam-MessageData-1: Q9nBH5+uyNZPGQ==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a293ef0-97d6-4627-2702-08da3f4c5f98
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 19:17:28.1467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 524yCWGuuuH4EkLIBrhJhR3EnA+IXHjuE7XV8Yr07JfXOQNhopxk3rDF4XqrWeEkO21qnOCTnbYjO6DiKOS7Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6461
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, JMQ_SPF_NEUTRAL, PYZOR_CHECK,
 SPF_HELO_PASS, SPF_PASS, TXREP autolearn=no autolearn_force=no version=3.4.6
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
X-List-Received-Date: Thu, 26 May 2022 19:17:31 -0000

