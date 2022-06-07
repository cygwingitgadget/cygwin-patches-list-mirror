Return-Path: <kbrown@cornell.edu>
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::70f])
 by sourceware.org (Postfix) with ESMTPS id 2CC17385782D
 for <cygwin-patches@cygwin.com>; Tue,  7 Jun 2022 18:00:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 2CC17385782D
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWNxlrSqXvP7BF6zZv2J0JexuwmCt5BZKMb0MIm87CTm7oG0CsZ4QhfDcwKwe4JT/CNdEeBl2U4ASL7apc79dNhpMlQgFQ6eaGGgP5Oj5eWPAPTzv+BhEGsCSGMCSpzrhHgTBJWbvsy8daQGGayyhH+lVfnsA37yCRicSJ+cGzHyxhSCqQKTm5rXI4YBLvVgz7TnCmlCdSiU8HmAcNe9uH5sy9BsOF+VvasBPnByl10BiUjStbjppQUL831whSdC+oFo8hD9lYocvVzD29h6AKzFnRNEtt/g6t2uUsu7wySDqhp0mxaY1alojCPVxJiWPr6xQPtIb4KedXsXhXbY2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxAt1IiwiS5V7j6ZGCNTAgIlJnQ+l+saSv3KC+zBBCY=;
 b=GSTf8R9HvR1ahEqAYQDZIOucrIZRnj2CeKKq3fUZ7MbZM0TDQiFmOqHeDlJ13n90tNmjB8POecEQu6Tg83bG61ft0SfqQh3GjYIsc6CvxvXPDZz8rZZ8n6XRVJ3uYCDc6INxmOnS8OF9DvTIJSiVNB1la6c52xFZjYsWwlvyTV249cZF/Z1asRnYga8Ju4xndhua9zNa/l/6BNynJGDG2D4P87/7aG38frUTYq8Sc49PqAPT8UsmTQBH1Wcx+EPU4JT21oI8t0zWIUk2pmcKDzy+kzLiOX9IXf86MjIQMwtb+Mj2lSqfteiJyuHlPcfm9EW5nkdyd4SACAKb/dg9FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxAt1IiwiS5V7j6ZGCNTAgIlJnQ+l+saSv3KC+zBBCY=;
 b=E14Qwmp6Adc7HIeCRiD9jwMLG65RAPJ3Lnsb6FsG0M1mm3vW+yvYbhBC+ls+zXcsgqtzYfwTu5Xuv5tDqkK6UXvvHPKzGk1+iytCMhed05hKOAytNgrhtQVgwrUiTRv3PGnAggjWF7PpVVEU5zQwPP0sbh6CpBNASVVlcY8H3Kg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by SN6PR04MB4861.namprd04.prod.outlook.com (2603:10b6:805:94::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 18:00:22 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::e48c:b440:3098:a050]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::e48c:b440:3098:a050%6]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 18:00:22 +0000
Message-ID: <5908d277-7ebf-70f6-1f92-573872b61e7b@cornell.edu>
Date: Tue, 7 Jun 2022 14:00:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] Cygwin: remove most occurrences of __stdcall, WINAPI,
 and, __cdecl
Content-Language: en-US
To: cygwin-patches@cygwin.com
References: <2d54f846-365f-848f-4fdb-1c22d4c1bfa0@cornell.edu>
 <c9c7e7fe-adc6-c845-2720-06bc40591255@dronecode.org.uk>
 <b5f56fb5-48eb-8596-5855-35a35dcb8a55@cornell.edu>
 <20220608014916.df0275787115d55138757a3c@nifty.ne.jp>
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <20220608014916.df0275787115d55138757a3c@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAP220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::22) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b900ab5-5a3b-4da0-03ee-08da48af970b
X-MS-TrafficTypeDiagnostic: SN6PR04MB4861:EE_
X-Microsoft-Antispam-PRVS: <SN6PR04MB4861846F2B9A9C89C8A5EBD4D8A59@SN6PR04MB4861.namprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VlAoyoYdy0mEr0QQ8ldYXtw8hp8KsxhUcKW9/iHJNUVK3fNx1zr9/QCANx0r/+frVKntVo/aNWBYK+I8zGDjk5zhXsKKc0Le2LbPSsKDY+uwfN7B3L2VKNGc7Y27SJQ5/AGjoHZpvfh7L0+Z16kG4UW2jYfw4bBWq/kNOBU5sZw0T6ENvgsYA5170eGZ92wtGg3fHYKihaZD7Zl9wcelLphKZT3MjNlFnsNphzl1PvSoCr1gYAzAhxA2WWSjI1h58ZTJV/rkPpuLKbrAfD4aDmXJSrt03jMBPA9odfdaO4K+V/0wHZKdCjoPRXCvoaehaAld5sZKxE0etwRYBPm1tFs/TYIJWV53HVSdktp3+557A0Oq/oNWkb97qLt+nq1An7+otc9Dv83cRbMRnazOXDibzZPzyYSAnu/FOOOYauMBctGCnpZsPiZWpZo3/J9f+vdxHTA3otBIYddMJzCVcieVuJwohiLX/QMUd2d0EZqUnfSnuPJr4osYTE9e4C3g9AmCogJTYgSxIddyfP3j2yCrHWNmR5VEKI+uqO/R+YJykYmQJjEEhc6m9rSW8az4SetGo+g4NvRw9sA5uZ/2ZEkB0ZC3IHY8inm8MzbV9jMIxWVGyWU/AK6j+8tRfTQu/0nXI/WOsnrjUVHO4pk6d9WdKRWvyurEAQ5SpAL3ea555jtC0p9OHDy+5tHRDZL2fSSLmW3d3XonkqKiIngWhiKFqdttSbItzZsK6t0GFY4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(2616005)(508600001)(8936002)(66556008)(75432002)(5660300002)(186003)(316002)(8676002)(786003)(31686004)(6916009)(6512007)(36756003)(38100700002)(31696002)(66946007)(66476007)(4744005)(6506007)(53546011)(6486002)(86362001)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDJSMzN5Si9Lb3ZOSzFBNmpudjFqWU5NeSt3NDR1WEZRM1V0ZGs0UGRPb1Bk?=
 =?utf-8?B?eVRLaE9oTmt5WHk0ajY3TUhSbmFxNytBbHpJYWlJV3F0NHNUWmorNXBzQjdo?=
 =?utf-8?B?RUZ5YjY2MXJtVXRrTFpyOGdobnNCVmwwcGV3cmN4azhRM2FuaDFCdjlNejdn?=
 =?utf-8?B?QXVNanVQK2dRcnVpQlFVOEU2Y0tRa2R0WUpXbFpSZnJoQngrQWhiczY5NjJF?=
 =?utf-8?B?K3ljUkIxc2lIeGlRbUd4VStuQVdRaXJUQ3BqSm80YWxKY1RLN1JHTGV3NC9N?=
 =?utf-8?B?VlhwbnlMREdScHJjNmpJbkl4OGNEK3lpTFNMVTVZVHhEVHQ4bnk0bWErZFF4?=
 =?utf-8?B?VUtza0ZaYm00Q3k4WjNmb2lOMWRNcG1vYTB5d1FPUnNHeXhIWHdUcW5MRW9T?=
 =?utf-8?B?dXhBTXZRbHd6Z3JVeDhYcWtXS3Y5RFQ4NUc1RWd5dHpKZnpPcXVublVGY3pz?=
 =?utf-8?B?Ny9jSCsrdU5NT1VxaG1KUzhsYnduc2k1TzR2U3ZoV00yT3BpaHdacWlFZEEw?=
 =?utf-8?B?dmw5dlpVY21FZFE5RjZwSEV2bEdpRngrSkorWHBQQWRXSjk5QmF3THA1aXpr?=
 =?utf-8?B?U3A4bHdVdjgzMHpMSG1YYTRWeUJ6N2JIZTNNZThXbjJIaG5RWmtIMVRmQXlv?=
 =?utf-8?B?TEdPZlVSOXYwalYraFNjeFB5TXNIRFFCSjdCaE9tQmp3dHdQN3M0VGdFVHFW?=
 =?utf-8?B?Q0d0S3ZwalJzand5aGJOQmlIdzE0WGU5eDl6dFBEUTg4dm92S0lsaFA5VmtM?=
 =?utf-8?B?M3NSclJxWE1EdnlOcTNsNzd3TTFWYmg0QVdQYzJsM0E4cElzbFc5TysvNzgx?=
 =?utf-8?B?V0FHVTg2SzhDQTAwUmhPQTZPSjZwdmhHTlk4VEhRTk4raVVEM2lOc2VJZTFw?=
 =?utf-8?B?WTlGZ3FDQWsxVTU4NjFnN1J0V0dVYVlYbFRxSU5iRWhBU3daV3IzNStnUmc0?=
 =?utf-8?B?bVRDNXlxeS90MExhTVBYOVVaUlNQU3BVZUZ1cTRHTUlyVzEzaW5ObzY1bXVE?=
 =?utf-8?B?SXZOYzRsSEtFODh6MUcvbktqSjBvV0xMK1Z2NnM2ejV2cGR2RVZzbWlYaFRN?=
 =?utf-8?B?N3ZEMmVtQmE4azhrSUJCZlR0dUZiWVVEcjZkSFUwRmdMaTZPdkd6eXYzY2NC?=
 =?utf-8?B?cVNYUEpKblJmVnFiMWJZZUVTaW41L3JSRFZTdjdSM3UxejFoeTlLTklLRnNv?=
 =?utf-8?B?KzV2K010Unh1aWszVVVITlhzQ0RUYzhCTjNOaUc2czlwck1CWVNHNGZZTWRq?=
 =?utf-8?B?blB2dG5NUnZKMHlPVWJ1NjM2MnBsclZBSkZTRk50TmhmRUx6d1QyYW9kOTEx?=
 =?utf-8?B?NGVMYUNPTm52czdnM25WZkVkNzVZb0NBMDhmbW14WjQwaXFOOHFvblBqdGla?=
 =?utf-8?B?bzVyREtkYUdUK0p4MkoyOGlzL3BmdDhtUXVJay9yVzJGdldnSStlY1psTjNE?=
 =?utf-8?B?SG5iVjBJMmZHR1ZjQlVRK0xHaHE2Zmd4Ulo3RS9LTm51QTRPK0VzRXducjEw?=
 =?utf-8?B?S2IvVyt0YzBpNm15OSs0Q0FrcUFlbnkwZXF1RzVlZ04yNmozUnoxYkZvMGhD?=
 =?utf-8?B?Zi9iREJYd0JDN29yS2NDcmQ1K3VuUUE4ZG4xNmZVY1A2ejg3RkIrazJ4cUh4?=
 =?utf-8?B?T2NLd3RvVzRZU0VxZThOVXJRNWFtU0xKY3BYZmhaemNSVUI1Zzh2N0lQWSts?=
 =?utf-8?B?aWFHR3hmVGtyNWt2VCtwQW9BRk5ZMDhweGJaVFR1dXBvd3dlVWNOTVFoMkJE?=
 =?utf-8?B?NGd4eld0RERHOGc2aU5SRmxoK1BoN1hGUU55ME5IUFBKK1VWVnhMYzlXVHlV?=
 =?utf-8?B?TGIrbE41Yzl2c0pnck91bGVBcFQrWHd3OTJwY1hYQS9KeE9hZysrQVRaMVRE?=
 =?utf-8?B?QlpnSTZRTTJBdWxMUVhyVDdSMnljU0d1Z0srcHlUWnE2T0twWVdSVFBmbElI?=
 =?utf-8?B?MnlUaEZFVzRnZTdyVW5Id1BXYlVNZHdvbWU2blFnSTI3NGRHak5iVjY3emxM?=
 =?utf-8?B?UjhIYTNXSzhTbURqTDNDeHFqSjI3Zkh2YkdkZmMvY2d5czR0UTBuRDhSVTZT?=
 =?utf-8?B?ZVBxTnVVaEUwL1htdXd6SEZZaFZmSVlHREg0d1FGSGp4enQ0ZVdtYWIwZHh1?=
 =?utf-8?B?Qkg1T3BaemNyS3V1N3RRWGd6czJrN2FUcjdpMUc1WjViOWxRZjhuOHJSU2Fk?=
 =?utf-8?B?R3Bza2JqZGlKbmhOa3hKZzRzOFhBSmZBZzlZQWhzSDViYVZVU21WT3RwUkM1?=
 =?utf-8?B?MjVFQy84UDY2TXg3WElrL0hNR0NVMDZGN3VQeUtNUEc3QzhFMmJMY21Xbi9i?=
 =?utf-8?B?VjNyTkVrbnNROUZMTGNhR0Q2akNRZzNDMFEyR3ZlZXIvNjh0RGJzbGhtNkpz?=
 =?utf-8?Q?aAjvVOdbXlj9VIxjezKB1Aq2dac+0wQmkX834Q+l7SbYw?=
X-MS-Exchange-AntiSpam-MessageData-1: 5mYlk3grPVszOw==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b900ab5-5a3b-4da0-03ee-08da48af970b
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 18:00:21.9716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DLJYcFpCX+beWm2D/0HL7WfiV40g4iu3GBmMQA9hjGlBMO9/R2d5mHCL1J4M5i1//fvxphZCdWASqNaV6x/htQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4861
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
X-List-Received-Date: Tue, 07 Jun 2022 18:00:27 -0000

On 6/7/2022 12:49 PM, Takashi Yano wrote:
> _dll_crt0() is declared as
> extern void __stdcall _dll_crt0 ()
>    __declspec (dllimport) __attribute__ ((noreturn));
> in winsup/cygwin/lib/cygwin_crt0.c, however, this patch
> removes __stdcall from winsup.h and dcrt0.cc as follows.
[...]

> To be consistent these, shouldn't _dll_crt0() retain __stdcall?
> 
> Changing cygwin_crt0.c is a bit weird because it looks as if
> it might affect binary compatibility, even if it really doesn't.

Thanks for catching this.  It was actually an accident that I didn't remove 
__stdcall from cygwin_crt0.c, but I agree that it's better to retain it in the 
other two places.  I've fixed this.

Ken
