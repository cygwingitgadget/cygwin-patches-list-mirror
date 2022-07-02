Return-Path: <kbrown@cornell.edu>
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2116.outbound.protection.outlook.com [40.107.93.116])
 by sourceware.org (Postfix) with ESMTPS id 9CE3D3857830
 for <cygwin-patches@cygwin.com>; Sat,  2 Jul 2022 01:32:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 9CE3D3857830
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOqlo7465Ei8GZPzqOLr22E+O/6Q+9dVxw5M6zCZslxrJXYHHPF7zW1XcxXpZCEUfhkr4F7/iwwF6CArB2yYhAFz8Y2choyxLgA4n5++Tl1kQsRyNkpj3WgiLJER1tpMKzpTbSlTO8rrtq1w0Rru00/8IySV/WCWt6eEHZjDCaR/KkKAAd6zBfKTVnx/qoVd6o9P89RTlw36zYEy+WRhtRmcW0Asrarj/HZWSg2LNRApLgwScX4acmD0if0x31gBDFV8DD1d7TY4W+ZNaMne6VjDGieKvv425OQ+XcZO3JTUUOfqQSP05I6/gBAJDLjNth9ZuR4GTFWHPqUSg8hZ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1329r/EFd9pYxQsnyYvQEj2zPw5yeF5NskFaREavHgM=;
 b=crX3Ctco6Ixd71GzrlI1f8VZ6VYcq/W7DOao1BDrU2QTDg/mtlpsFKdqNYn5PKBoOepRhxJ1r+/S5CtHgJByK5rYvyneXFsYn01DdMqWg6hK9ccBeJ0rzpi7ZTq2ZyzN8IR75LH17ZnqJw5GneDSllptCN0CiqVSDhi7M9AmvF/xYO0j8+/94yCT5deYgTMrh5I5MOy+WqTdu3fm0DJwPmXkBG9ChypBk5s0E21oywaTNb/UGCMbR3OWTFPt03SsM+7A87qd6f52k4rdgV9RlVUUMvMCu+pkQVsf6jTZV5E9BVJxabFdwmKEF1nJFpyezjHs4VRl6eTq1cLSzksZoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1329r/EFd9pYxQsnyYvQEj2zPw5yeF5NskFaREavHgM=;
 b=OGNmBeyNI4uK77GtlacJnQCKZSSD6LVdzgnTdhPozWL042vvgtWQ4Hwd/J6OdSrittBRqqS/6Eq3MaEFv7FKIZ+QkDW+V3WPQqhcvUJKJn+UwDmRTJAnEYuBjRNhqkQqOhG16bpkB3DybkeCDr3qmhCV+csxEIFv0TXRwrsjwIE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BYAPR04MB5432.namprd04.prod.outlook.com (2603:10b6:a03:d0::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Sat, 2 Jul
 2022 01:32:21 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::901f:a758:30f5:309d]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::901f:a758:30f5:309d%2]) with mapi id 15.20.5395.014; Sat, 2 Jul 2022
 01:32:21 +0000
Message-ID: <ab1226ff-1236-67a0-a140-0f6826fd1778@cornell.edu>
Date: Fri, 1 Jul 2022 21:32:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] Cygwin: spawn: Treat empty path as the current directory.
Content-Language: en-US
To: cygwin-patches@cygwin.com
References: <20220627124427.184-1-takashi.yano@nifty.ne.jp>
 <c4a8d150-4d16-2af5-a7ac-26e42f9befb8@cornell.edu>
 <376762b9-6ef2-4415-b3e6-fbc9be48f183@cornell.edu>
 <20220702083107.8aa64b1046484ab41911d8dc@nifty.ne.jp>
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <20220702083107.8aa64b1046484ab41911d8dc@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0046.namprd02.prod.outlook.com
 (2603:10b6:207:3d::23) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34cfe64a-7774-48b0-b18d-08da5bcab55a
X-MS-TrafficTypeDiagnostic: BYAPR04MB5432:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sJHT/fbxti44X/FX0e5IgThf6g9PB2DHNZu29CsezJqh7Hqc7yOTyFTZhvRqE/m9S6X3tai7orNo1+flqS+0tSa4A734odrk4GlF4PKD6rddbM9tHwXpdzgb3g788wlkBLQfn2UJOwnkHtye0KD9Ud99sklbQ0MvAj8kSF7TuW1FCblT3XfjQ10w0fc/aGLjCxJugArCKIbs9bT3kSl94EAt49V8US2imk61n2owexDXVu4j+A/0Wqc1T0M9KPaUezYGHvvA9iydVogr2gLyaArSvmcWlEjPJp0dJ13d3fbYEzmPlhgtJoSktQuGB1u9R4dNR5sRfJZrazZYP+m0Njz+krSpU2kzUIyPHhXMaVXY2qxa/a8BV22F7ELCx87UgALuZBLv0RGUMhYUTsggTxbgOsJG5VfMuvnNwgVryPhPQTCniakjm5MLwcqYDY4i3cycOG47emMtKnbpNyNOLQunzGkYWL6sLKCyfWzLdLVs6M7igJZVZYbOobul7wUUMjmLLr85YSjzRVVy/wee70RoSea9CVWcFEFBf9awZuhm3VOk/pT/tbJIl42vo0yAWUc+nWRqGK/1NxwtENXqKNDCXAoaUzQ+PDQE7LazHK9ayHobtPAp/Pr3csaDgPOHEdVrm8tAQhJZ0gCnjsyiFEdx7ENHcGG0wVPWdRVTX+UM6FX07FQRH56upPXo5aZiKAk+rP+Oqyzld4K9bTAA9wagJt+/zvwZ3Pd0g0Sow0sw3S+Lx0HYF7FgNEFUIOAHNZJQD/blat/RUDAeGaYGa8msxh+OdhVT5OLGrNbJXNprTEKyWbIDwehzx2Zz3mpsQskI0TLHKb7kxrDw7vdW1P9l0GjFv2cbucrecyPbVHMBcuyY/wrwLPeWsIr2SLpJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(41300700001)(66476007)(8676002)(966005)(786003)(66946007)(53546011)(478600001)(2616005)(38100700002)(316002)(31696002)(6512007)(2906002)(6506007)(186003)(41320700001)(75432002)(31686004)(5660300002)(83380400001)(6916009)(86362001)(36756003)(66556008)(6486002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk9PRmlQZ2xLalFrSFhEWHVxR1M0c1NNL1JFTEJqaUI2ZCs1c3ppTGxCYzZM?=
 =?utf-8?B?b2YvN3pvNHJOc0dCRnBjT3VybExObmNsTWtVNnIxSXVmaW5QaksrbjhWejgz?=
 =?utf-8?B?K1Y2bHo2aTh4SFJmZys4RFdWK1g2VU1taGNyWkxxRmo2T2Q4QW5JN1ZNc3Z4?=
 =?utf-8?B?bW5JTnVtR05ORkxMdCsvY3hBQnl6alVsS2pJTXpyQ3V3U01pWWRZRDYrMnR0?=
 =?utf-8?B?RjhWL3NCNDQwSkE0MEJXYzJLQzF3NzAyQ01pd0FLMkUvVWgvNVRUS0tUbSsy?=
 =?utf-8?B?VFc1em5QTDhQUFE0UEJWcmZtSnkrdGlNNHhZTVBBRVIyS00rRnJERFB3bmVL?=
 =?utf-8?B?UkFlSWpnY09mTXVnVXVNdWwwZjdPdm5NNHN4S3dhdHFMbWJmUWRpVGJvN0hr?=
 =?utf-8?B?S2pueHJkMm1nY01TWjJReE5LamgxMmFidXFqL0QzNnAvUjVQNEZhYkYrd0VL?=
 =?utf-8?B?a29heXh2dEZyQ2k4VS9vRUJtWGdSUnZLS3NsVmRGaVBOM3c2Z2dsaTR2L1hq?=
 =?utf-8?B?czg1VFUva2pUU01VUDJYcXlGUFN4N1J6SlpSWWIzalc0NW0wTjNldXc2akUr?=
 =?utf-8?B?cGRNQUhoU2VpeWlQYjFjNkpIaHByeXduS1J2Nmd5anIySnVIaGZiWklpWnY2?=
 =?utf-8?B?blFnazRPaGxyUmdtTTBUQ2kxaGdzN2JCQmJFTXA4K2ZCRVZMbnY1cmZKZitU?=
 =?utf-8?B?cEVZRE40bk5jSEFNdTl3Y1VwRmJ0akdCYUJ4SHB4Y1dPMTI0RGltZ1pBcGoz?=
 =?utf-8?B?UWJLVXdmaU9vd2ltUlFFYlY1WFFHSXZPM2k5V1p0YU9QT3dpcGRRaU9GS0V0?=
 =?utf-8?B?Y1N5MXI1THpLeUxIL2p1bWtuQ1g1ZFFmSitqZXFqWkJ3YnVWclNVVmxGam1E?=
 =?utf-8?B?MkZwRDZKTGJQZzJKczFEdDBiSENTSDBqZFhQRE9OcEh5aThxRTJDc1VYWkRV?=
 =?utf-8?B?eW1maGdGb0liK1hqZTFnNWNGUndGbkRwTmRUQnFPNEhCcS9XVFJ6WUF6NFc1?=
 =?utf-8?B?MkErV1VlblZ2WVJWWm9Ha2R5UlBMZnlpL3ArV1RQVnNqN2IrWmRvbXkxSVhH?=
 =?utf-8?B?Qk5JUFdJR1JZWEFJOTYvdjJRZ2o4a0dBcVJkL21NcENMRDNHN3hrdVlWaGJV?=
 =?utf-8?B?Y0k5cnZ6ZnB2dko1U2JxRmtadHhTeE15M1QxY1FSMGY3STRTYTI1SFBPT1VQ?=
 =?utf-8?B?eUEvNFJ3cUUvS0prRDZwT2V0RytSbkJYb20xVEpsOXlObVFYL0QrVTNsa1lq?=
 =?utf-8?B?UU5sa0JKeFlsRndsYjQreDRPSU9HWmFicFlWQjZEN2w1OEhCN0xUakVNMkk4?=
 =?utf-8?B?Q05yVlFoZlpBMkhpS2EwL2x2OE1UOUZCQnZFck1xemwxMGR3a3FRYy9haVli?=
 =?utf-8?B?OVhZZm9qWFZaQ0RhekxJeU83K3dSZ1hpMEE3V0hrbEJHUjdDMkQ5dTEwY3Ba?=
 =?utf-8?B?aGl0azg2Y2NNVncxSEMzdzJrdkI4THpRZVcyT2JsUmY0SENvSEFsUW00NGFq?=
 =?utf-8?B?V0trWlBwOFgyVWhmZU1Nb3lJNVNsQ3luRTR2MlpWQTA4R2dxcS9CYVRieHNI?=
 =?utf-8?B?ZUNhN2kxSXVTdmFpOTQrL0NzTEdteno5bC9RRjBrZWtucUFDWGZGUlR2Zll0?=
 =?utf-8?B?clNXTEZsZXNGUnM1bGRuUlVxRUM5QnNFdFJzcXJJekhEbGNOQ2tsWE9PMGh6?=
 =?utf-8?B?dUR1RUJYWHU5ZjNZRkoxcTZMR2ROSmhLeGFvMXZ4c1I3YkxLZnlwZlZ3VlJt?=
 =?utf-8?B?WERmN2ttcmthYXpETjZPMXBqTVpkQ1M2ZUk3bHNkVjYva2ZuWi9zdm5pbzVu?=
 =?utf-8?B?cnJ6Z0pXUDJlWXZxNU4xczZ1SUhWVGI0R3FLSHhuZlR2VnFZYjgrNUp5N1Aw?=
 =?utf-8?B?V1hBaGNTdHNkNjc2VnFUWTUyVC9hS1ljYXRBMDEzRjlCa2wyY0kyYUhzZXM1?=
 =?utf-8?B?WFk1Y1UyL0d2QldZaGxYVHgzZDcxR1BUVXYzTTl6SmV1WmlvU2NaTWFFYVZi?=
 =?utf-8?B?dnZzZDNocVRaYVpsL0pVd3lBYmFybzB5TXJSdytEVTdGc3ZpL3dYZFQ4RVhy?=
 =?utf-8?B?Y2RaNzNRV09jN2NMKzJBY0lydzdaSXpwNHhSOEdwUHFxTVJkVnZlbFhtQ3N0?=
 =?utf-8?B?bTdCY3R1dTFvNWV5cGozNHZveitNNDFJdFlNeGEwdlBFQjVuUVg4c0t1ODNp?=
 =?utf-8?Q?jA2e7IdiAoNqOwtQRhNd6m6Nm3Zew1HLh2iD4155tDrz?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 34cfe64a-7774-48b0-b18d-08da5bcab55a
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2022 01:32:21.2050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1pHfwl7+2P0SRy/I6s+rjAt2PKphPo+5PNXdzczuULN3s9JRhvJwozLM20wVVjYGXkoHKsxk0mE3mc2iPXpO/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5432
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00, BODY_8BITS,
 DKIM_SIGNED, DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, JMQ_SPF_NEUTRAL,
 KAM_SHORT, NICE_REPLY_A, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS,
 SPF_PASS, TXREP,
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
X-List-Received-Date: Sat, 02 Jul 2022 01:32:26 -0000

On 7/1/2022 7:31 PM, Takashi Yano wrote:
> On Thu, 30 Jun 2022 21:16:35 -0400
> Ken Brown wrote:
>> On 6/30/2022 11:45 AM, Ken Brown wrote:
>>> On 6/27/2022 8:44 AM, Takashi Yano wrote:
>>>> - With this patch, the empty path (empty element in PATH or PATH is
>>>>     absent) is treated as the current directory as Linux does.
>>>> Addresses: https://cygwin.com/pipermail/cygwin/2022-June/251730.html
>>>
>>> It might be a good idea to include a comment in the code and the commit message
>>> that this feature is being added for Linux compatibility but that it is
>>> deprecated.  According to https://man7.org/linux/man-pages/man7/environ.7.html,
>>>
>>>                 As a legacy feature, a zero-length prefix (specified as
>>>                 two adjacent colons, or an initial or terminating colon)
>>>                 is interpreted to mean the current working directory.
>>>                 However, use of this feature is deprecated, and POSIX
>>>                 notes that a conforming application shall use an explicit
>>>                 pathname (e.g., .)  to specify the current working
>>>                 directory.
>>>
>>> Alternatively, maybe this is a case where we should prefer POSIX compliance to
>>> Linux compatibility.  Corinna, WDYT?
>>
>> I withdraw my suggestion.  There's already a comment in the code saying, "An
>> empty path or '.' means the current directory", so it's clear that the intention
>> was to support that feature, and the code was simply buggy.
>>
>> I've now read through the patch, and it looks good to me.  This was pretty
>> tricky to get right.
> 
> We still need to discuss whether it is better to align Linux
> behavior or just keeping POSIX compliance, don't we?

I interpreted the existing comment as meaning that a decision was already made 
at some point to align with Linux.  But it can't hurt to wait for Corinna to 
weigh in.

Ken
