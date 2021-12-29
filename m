Return-Path: <kbrown@cornell.edu>
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2118.outbound.protection.outlook.com [40.107.93.118])
 by sourceware.org (Postfix) with ESMTPS id 940BC3858400
 for <cygwin-patches@cygwin.com>; Wed, 29 Dec 2021 21:59:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 940BC3858400
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4LBRlVsHl5B5Eh/YTZYc55TzcAyzuS2XfNSPMSAZf3Ar/wF6Y0ueNFZJbquvtdiIhpf6AfHI9CJ8EmTApOT5Tv5UxeV6TbZRwEXzJbPcdYi2QTIY1F8e3IEmd7220ip+IDBn3xz404evgzgqxmbujB85tOz7Zgk/j+YuAQrufCYusfXfJYch9jE4No80bewqPo3TJwzZ8NbVdetApLCN4SM+jquYsNRfhwFkpkI7u/Dd16jq0uHRwA4nU8EbBh0cq47m7+DroUUJ0yZbEbbn0S+amuNjd4FA4EFruR2QhkXsIh/vz2UjfpIud1MpMnsWfRbjhmf1J1aaMxLv2/lAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zgUkSMO0UHpY05y72TDjN+IMZxBsaMZKHaz/mbSvj0=;
 b=YF6sl5jKs32NyimxK/pVlx4SLKElg9iKwOaMfPcuXFBIyGBRwLeCBXGmkunQpRRppjlvdKd9H/U/SrBAz2UGvW+xohOBotk+9qBMjHBSVVsS26QooQOtpIfGk5rdkz7mrhl1JPxLdywbN61Z5wB46YyjtfdCU3L2YExS3BNxMsfclu1BylfWeg6b1ck2rWjAymE8Pkptkl6pB+xiIZhWPzeCjO7HzWQgX84CtPYVXJNWEPoDvoubC2tsdArrnXCizW7hVpf5B6WOB7G9xCFApf2sT550Qv85fRuiyDS0ry+HR4aVfi0XUNzi9MJH0Ez9ue27ruwficeFedy/vuMNJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zgUkSMO0UHpY05y72TDjN+IMZxBsaMZKHaz/mbSvj0=;
 b=Lnuh1uj7ZS4jDR2Nde+R1GfLRgZ/+AKHIAk6aSEc/+GnMRRpO+Do7Q7WUzjlIeGtE7x3avpLA8G/vf04r/E9RLOq1JaOE65Ck2/0iFInEby4LgbHw5p+iRLMB6cVjBO5chmjbCajudjvX3decC4x9kL+peotRQjLBuCAxP8Mk8E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN3PR04MB2177.namprd04.prod.outlook.com (2a01:111:e400:7bb1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Wed, 29 Dec
 2021 21:59:06 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::e53a:dc46:9edd:9142]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::e53a:dc46:9edd:9142%7]) with mapi id 15.20.4844.014; Wed, 29 Dec 2021
 21:59:06 +0000
Message-ID: <104c6a5c-a480-5087-89c5-d3737d8b7a2d@cornell.edu>
Date: Wed, 29 Dec 2021 16:59:04 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] fhandler_pipe: add sanity limit to handle loops
Content-Language: en-US
From: Ken Brown <kbrown@cornell.edu>
To: Jeremy Drake <cygwin@jdrake.com>
Cc: cygwin-patches@cygwin.com
References: <alpine.BSO.2.21.2112231503400.11760@resin.csoft.net>
 <alpine.BSO.2.21.2112241638280.11760@resin.csoft.net>
 <20211225121902.54b82f1bb0d4f958d34a8bb7@nifty.ne.jp>
 <alpine.BSO.2.21.2112241945060.11760@resin.csoft.net>
 <20211225131242.adef568db53d561a6b134612@nifty.ne.jp>
 <alpine.BSO.2.21.2112242101520.11760@resin.csoft.net>
 <20211226021010.a2b2ad28f12df9ffb25b6584@nifty.ne.jp>
 <alpine.BSO.2.21.2112251111580.11760@resin.csoft.net>
 <alpine.BSO.2.21.2112251457480.11760@resin.csoft.net>
 <8172019c-e048-4fe2-79c9-0b3262057d3e@cornell.edu>
 <alpine.BSO.2.21.2112252054310.11760@resin.csoft.net>
 <c7664703-0ec2-388f-64e3-8c46d4590b3e@cornell.edu>
 <d2af0b22-666a-b820-acb0-afc835836372@cornell.edu>
 <317dc73a-fb9d-3937-7354-c79492c1c64c@cornell.edu>
 <alpine.BSO.2.21.2112261331090.11760@resin.csoft.net>
 <b278775d-03d9-6683-ec43-62729bb0054c@cornell.edu>
 <alpine.BSO.2.21.2112261432360.11760@resin.csoft.net>
 <7781155f-d4a1-2e9d-a5c7-2ecc2250a5cf@cornell.edu>
In-Reply-To: <7781155f-d4a1-2e9d-a5c7-2ecc2250a5cf@cornell.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:208:2d::24) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d08c25e-0a40-4a38-115f-08d9cb166ecc
X-MS-TrafficTypeDiagnostic: BN3PR04MB2177:EE_
X-Microsoft-Antispam-PRVS: <BN3PR04MB2177A02FF4F8AD72701D6A06D8449@BN3PR04MB2177.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CSNaj308GFRqdebxY9Oy89R9oYdYgU+bkT4S+AmjuAJ+eUEwgwmrZp13uPbdb7CtD2VExWYP4+Suw2p2+z+WAqwM58t3w5wc0h3/Am8HQXgKA4+auAkuERRyPmHXf5l1QHZJVtazVHhRGBCCyvX3t+RvbMhGYWKeCA7u64EBY4fGhe/bHM0HSIlVz+OBw7SpHRg9KTDNM0K1t8aa122tb1SLZZltlntKLJ70wqj5WqajWJFAWrrpjBmcNE24x3xzfWbl4LCwD30RhOCZldNU+A4wgODryYQnKSbXHKWnKK6/Puy7zGCcFcj+I49wLdY2Vhn21pOgJ30BVGSY441l6tbtQb3LkptYAtHZQcTgCk2liwkk1Vg2qcQg0u48lgDgJZvNDJ7ek4CCgZl3r2DnNTP81WAr/WMbjh3gUYeEGHcNPIU6/hxIAsekREkvWN7GxLIpJCeWRdx/ilOSaGP0l7DewM41fuc3mI+5xT+105/KE+H+iRmULKOufk3JYAS/0ocmBaySSzF6Rv81HakUZpwwbzc5UQquin1vNh8ks/fAfR8w8iRw9e7R4ab2K5MzRMdBGFZnhOBjSGrjwYQnnXZwQpPWVJ/xWa2y57DNgLrRxL13edZugmjCZuQVSyQ02NrNc+2FcvT6HL7LezpNu+F19ov/Hnbp/FDBBQZbFBmfbRAjxnkS2pjjJCw0Qfb/MYnOBi1zVl+2ayZjYNSzkcZEaIrGki3mKv71BMA6D+o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(66556008)(31686004)(6486002)(66476007)(66946007)(8676002)(38100700002)(316002)(786003)(558084003)(2906002)(36756003)(75432002)(5660300002)(31696002)(508600001)(6916009)(6512007)(8936002)(4326008)(86362001)(6506007)(186003)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHlVZWgvMDZwM1duOWlvcURad2tRK2lkNDU3ai9VcUhJWUwxOW03SStFVWc5?=
 =?utf-8?B?MGFyWldyS25lUnhLTERxMUtqM1pGMHd0K04xOEx1dTk0Nk02VjJNd3dDMmpT?=
 =?utf-8?B?SmwwamZ5MkVmSUI3Y1RnUUFvTi9xRytSV3dYUk0wV0dMWjB2bXdCUUVCc0Uz?=
 =?utf-8?B?Z2tiT0hiNnpBKzgvNjJHSzJjdnVQSUdSUVhpYXo5Vy9JYk9Qa0cwbjBSbk92?=
 =?utf-8?B?R1g3Zld0elZFUzIrNWZIUUREb3p2NjkzT2h5eTBmVTRPWk1RZmJwd1NYdm03?=
 =?utf-8?B?SkJuZzUwMDZCRldITDJMa01velJoWmROYXlmOVl4d0pqa0dUaUZpbjlPU1Uw?=
 =?utf-8?B?RFFGY0NGT0E0ZEVySDBoNzVkRHJKVmJ1bmh3UHlmMHNhek5keTVMMzFMTDdK?=
 =?utf-8?B?Z0p1azZKdTU0K24xbUxSc2pwaHVQOTdHNmtFQUdqQ0tIK1l5TVhmaFVTYVB2?=
 =?utf-8?B?TGxlRXF0QUpqYXpKeVJVRXpud21oMkZiVklMS25iVjR4eW1OS2NPKzRIbXB4?=
 =?utf-8?B?STE0Y29OLzc4ZjYzU25wSHVyNURYaWhoSExoVWtubldMa2g1SC9WTkF6THA3?=
 =?utf-8?B?cmUzRjdOK2YxRGcrZC9rVWQvZ20xbkk0V2x2T3ArbXFZNzErNVdCQjBjQWoz?=
 =?utf-8?B?M0poSXBYMzFXMTNCblR3ZHFsTFFRL1o1MGk1c3QvSm1tamtCMFBST1l6ckZB?=
 =?utf-8?B?L3RDSFpFRHZpa0NwNEdLNm1rMld4a2VOQk9RME9yTnMvZXNoVjBINlY1OGdM?=
 =?utf-8?B?c0VwVFIrSkNWQnZZVXBkQ0RCMzVGWlVSb0Z3UUJNUmZSVDExM2pqTG0zNWRI?=
 =?utf-8?B?MnJ1dHdPTXVwN0hnM09yWXV4enRwdjR5Q01JZDdmRTU5TDVPSGNVTEs3YitT?=
 =?utf-8?B?ODdUSDh1WnBnSFlRQTVnSXZFTW8xUU9HellUUFVETGtTcGlKU25YaEljRE5v?=
 =?utf-8?B?d2t4bTFzUjJ4K211b08wNTNXZlgwd0FpY1A0QlFNRGwzL2FUUHFabDdvc2ZM?=
 =?utf-8?B?Uy9YbFg0T0VrMER0T0FaOHN2WnpWL1V5cUc3YmxVU0JUM0RlVXhXUVlFdUw2?=
 =?utf-8?B?SU9ZL0lxbTJQZ1RES0lEbnZuaDZUaFhTcE1IMDRFcXBPTlBMNnROZkt1VmhH?=
 =?utf-8?B?MVFNVXNaamNvNEFIZnB1ZVI0ZENndGFZTnk1U3BiRlQ0K2Fwd3ZZVnJHRkxM?=
 =?utf-8?B?MjVGYnR6OHpCN3c3K1REZXRwWDFUNTNseTMvV2piRUhUV2pSWjA0MWRqK3FY?=
 =?utf-8?B?ZThlTW4rcG5pc1h1VGZTbWRVOEV6YlJuUUZmNUcwNlZ4ditMQnJIeDZkQ1Zn?=
 =?utf-8?B?OHhQUU43MHBEc015L0VFS3BoeDcwejVoK3FhS1RMVmhBNW1wQkM0L25VeFQ0?=
 =?utf-8?B?U2s3b01KV0k4cHRoS1BRQ2x2R0Rza1ViN011NDJ6bVo0YnVwdldEc3JmalFt?=
 =?utf-8?B?OGNvcy85SEx0TFlKM25DeU1Hekp0SHBSc0FIWjE5VCt0dmlwdkxuOWNGUzd1?=
 =?utf-8?B?VDVBaUJSbC9YTjR6eGpsc0FaRmc0ZHZRQXk5SXc2MU9qTEhLa0RhNExWOFpr?=
 =?utf-8?B?TVhKRDFrWVBrL1J2UXRXQWEyTGxmaUpacGxDQno2QmhWb0tlMWN0TGVmVUp3?=
 =?utf-8?B?Vy9KMmtsNXFXNVVFTVc0clM1SVZCNExXSHYyWEtxYU9EWi9uMElkTUxqdVBF?=
 =?utf-8?B?VzBYYm9qYURxTFpqQVhqWU5IMGVoa2ZrZFZxdEJMSlJhV0tZNk5saFY3M0Js?=
 =?utf-8?B?dW9TQ0lGMEV6WmtwdXppb2syaGUvQWNoZFVMaHB5RjdTR0F3NUdCckxZOWcy?=
 =?utf-8?B?UEpxWE1UR1JBSnRzeDJlcFMzY055L0Z5QnA4ZkxScW9ReG9OSExxNVM4T2o2?=
 =?utf-8?B?V2lxejdzMWNZNXRITWE0SmRoZERrM0UrOUZZT2xLZkkxMFIxVWxRbFplMTA1?=
 =?utf-8?B?VjZKOTNrVjdleXR5NlVoVW83RmM2R0ZlUUkyRlAyUFdBV2N1R2duWWw0Z3hv?=
 =?utf-8?B?THp5UW1ZVnJlU3pZdE85eVhyU1VISzJ4SitoV0F2QlQ4aGFhclYrMzZRQUFY?=
 =?utf-8?B?bUUrenFEVjZ0ajB4ZndZNUFLNTJuTWNlWlVab0VmaktMMHNXZXJUTHA1S0Nx?=
 =?utf-8?B?c3FXa0pyeSsxUnB6ellVd0RWKzFXSDBlT1ZCTythYUY1MnRGTVN6eUgxOGNn?=
 =?utf-8?B?MXNjajZUR1cyU1FwNXZqNFQ1Qi84TkZMVmhkeE9KelpSOGJiUzkrckEzRUFs?=
 =?utf-8?Q?ekkDE5l6OTJaUGY3BcjBq/tgSUtLPIGFPv1Irq8Rwg=3D?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d08c25e-0a40-4a38-115f-08d9cb166ecc
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2021 21:59:06.0409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9vglbR/Xj5Z4C2zEozFRdKu9X9pWTBGJQy9hhdQPogCaN6Z0pWQNegHyu0AEb50CvI1AlG5c2LHNV25yl0gi8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR04MB2177
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Wed, 29 Dec 2021 21:59:09 -0000

On 12/26/2021 6:12 PM, Ken Brown wrote:
> There are some fixes (though not pipe-related) pending for 3.3.4, so I'll push 
> it to the 3.3 branch after I've heard from Takashi and/or Corinna.

Takashi must be unavailable also, but it's a simple enough fix that I decided to 
go ahead and push it.

Ken
