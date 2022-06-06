Return-Path: <kbrown@cornell.edu>
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::70b])
 by sourceware.org (Postfix) with ESMTPS id 2780E3857351
 for <cygwin-patches@cygwin.com>; Mon,  6 Jun 2022 16:24:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 2780E3857351
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoJXO+z0W24VfMGOgfNpGrBDXCLD9yrEnU6QgeQlaSJoYXhVGTEuEq55WvWGSB2+OTr5J7xWbQwiHvL8SDRxwl8E5rEUR78YZSSy8Q9eGl9ariXcjggy7hcQXv9x26bE+2b1SFoJ1/Fon4awN+6+M2LFIViz7NGlD02i9+8nIiAp6KOdcOO8/uutl3PYmIqsBpcqpKI0+YfBs0Vz85hiTyDdGYSKMtK0V5Zm30Mn3fDwnVOY3Xg/XSxzI/LaCsVHZpxNjpRdNew801GtBqo0Vc4ZMplIGDbnQYrBxaxUe4RlQuwwngQZOyS2Rf3JVrMSCrDXXCcCjwHr08xSCsbD9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oT2RmOexDWCXWNHsc27OzJehgzaWtlC+0aW3vUtuYB4=;
 b=OZfOYNHBqKz5LNMZ0JCJpY4V2xClKSXwbuwB12424aj82tqDpc7l10NRHt5DVQFBdUxBGRWuqwQ6Aa7hUaEDGBU0IQg03E4QSh5MsbtbrtL+9ImXQlpBha3ZG6m2Rz3PSno0j4QBBFRy3vv2furljD2HUrgw5/09FbpSBBACgBlvwPq4i3y3Sz7Y1ZSGlgJF/jHft3HwG/PZi0ciVrnK7xL9dxIpz1PtBW6TfaSN8cN7isAqNzn88T4AAD4ZU/xzQhwBfrwKcV6A8RDAnjLtpCHR4C3TkKGqjSCFLJ9ydE1HxciK6Tqwj9qLitUmFTWZBqPcWuSYZOtlcPOjf9I6Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oT2RmOexDWCXWNHsc27OzJehgzaWtlC+0aW3vUtuYB4=;
 b=Vrxav+O7qOo2ZfyGhLr7Rpfz8nq9p9kQhtiLTMz/2fAyY3OKffsgSxSzGurK9btAHArwQ0HEgxak5+KX9DDyLBg6jNrr08/QvEVjBViq75fOKYqnM1W+v/qi2R19Og9NVq4BzxymPfsloGznKJN0LkGC1O7P2qra90Mqv2k2psA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by DM6PR04MB6251.namprd04.prod.outlook.com (2603:10b6:5:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Mon, 6 Jun
 2022 16:24:18 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::e48c:b440:3098:a050]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::e48c:b440:3098:a050%6]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 16:24:18 +0000
Message-ID: <b5f56fb5-48eb-8596-5855-35a35dcb8a55@cornell.edu>
Date: Mon, 6 Jun 2022 12:24:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] Cygwin: remove most occurrences of __stdcall, WINAPI,
 and, __cdecl
Content-Language: en-US
To: Jon Turney <jon.turney@dronecode.org.uk>,
 Cygwin Patches <cygwin-patches@cygwin.com>
References: <2d54f846-365f-848f-4fdb-1c22d4c1bfa0@cornell.edu>
 <c9c7e7fe-adc6-c845-2720-06bc40591255@dronecode.org.uk>
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <c9c7e7fe-adc6-c845-2720-06bc40591255@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR05CA0010.namprd05.prod.outlook.com (2603:10b6:610::23)
 To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2022731-51fb-426f-750f-08da47d9011a
X-MS-TrafficTypeDiagnostic: DM6PR04MB6251:EE_
X-Microsoft-Antispam-PRVS: <DM6PR04MB625170716E902E4CBB99426DD8A29@DM6PR04MB6251.namprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +oQ90h9yuLgDjueQ6VncCE4VDJ0xCesWfyODy37sBtqSGqMUnoXIR6uMEHko2zIlmVy/PGlLf8m4xin1o8yffmk5ISHReO1zkl4RyINzN0/eD/3kuvXS7OZYKPrgjwwD/Q3LgxQRvKDA6adCx7RMcapbc2Nv4z4bLFp+OMi5O5gSdivssUD05l7faRzySm+g5qpzYn6VCy1ht2CP6ECQXaqGXECLyKBSMCzAAHCPHli81cgHQuz91c80PkaZs8+ZtwaJXdIUd6YrDWjcCE1X7kt3Qmn+zspyXX4giwDEPRvZONdUKo7vVkv00Rb5l7CPCujqzlKszOg9Ct0T3xjyaN5OMcd2tebkTTMNKCstJFm2BXLD9byAfbWTBMQ91wvV1KnuyNA5R7XrQ1Rw5f28i0ZHeSeDGNVmWKIbY4e/DbU2KJ3iQBJzLemb0w+iNXZVWMNi2JWZPKEe9bJlgvpkGGfHxfB+nB3wk61Z5pxqJ5xRK86e2833HFD9u+ulQ+iarXTn8gQAumx5X5QXP5iUQkYRmu2LJGapFYzlWIea5Stt1lgXb42FB1koJZ0NyyAJzBYtVZQEFHWwKLxd3VwNa2tFrDRDYjL1HGv1U8GfbfuCLBVsBRhlt/OmI3bMgA18Luwgd061bVi/+YgxBhUN6x+/9uvAShLbrodte9708vUez5zYup35YBCb7bnyitGo0Y0zpAR9Vnsc+W6svLna77vKLfHzbThpVBPOYijaovA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(6666004)(2906002)(4744005)(38100700002)(786003)(53546011)(36756003)(316002)(6512007)(86362001)(83380400001)(31696002)(2616005)(110136005)(75432002)(8676002)(66946007)(66476007)(6486002)(31686004)(5660300002)(66556008)(186003)(508600001)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1JIWlZRbDlTNUo1U25PanJoSzJCNUhwUnYxTWF1ZnZnZGNoLzBLc0UzL0lk?=
 =?utf-8?B?WGNWRXMxL3UzNDlGcjZXdnJRc255VVhyaDZ6YTBUTDNhSDNSR1N3Z0o3eEw0?=
 =?utf-8?B?MU9JMGhHbWhmVGpPTGUyc2d4OWM4amd5bDlPN0ZoN1lDZGY4TktqYzB3N054?=
 =?utf-8?B?aGNLUUpvWTBiVFRJRUplRS82MExIQ1VDcUdkWm1BNjJUZ0lTY1VadWFrVjZZ?=
 =?utf-8?B?REpHR1E2QzZtbmt3aFRGMkhVQ2FwbDd0cE5oTHNsTjAyZnhHeUlmSEhnS2Fq?=
 =?utf-8?B?Y3JqdHVGVG82V21vQi8zUkgzdXRXTmVKZEpJdndaa1laVFptcEJ1Q1RTMWty?=
 =?utf-8?B?MkRXSHRHbGtEOC90V1d0bFBLLzFlRUpiZXRsL0lwNDRFTDZMTitBSk5zL3VG?=
 =?utf-8?B?M3JOUTAwa0pIZS84R2xCTGY2N3dtTVEvTzdVai81L3NnMkM5T2Z6dnMyc202?=
 =?utf-8?B?dW52WEdLR3c0VWZaQ3cxMWpNdGNaN05ERGtUQTN2VHpObW5Bc3c0clVBSG9X?=
 =?utf-8?B?bXMxMUVRS0oyVm5nTDFsekh1WjRPUmFpa1VxWk5uWHZHbzRuTm5VbjY2NitQ?=
 =?utf-8?B?anhvU3RoUlQxd0ErTGhRVkF0cGkrRWxidWFURWlPYzlndTRrZEhNa0UvVjRj?=
 =?utf-8?B?M203d2NMRmNYcGJ3RTMrK1dJTGozWjFzUEJHOG1SMUJ0RWlxdFArc0tjN3Ey?=
 =?utf-8?B?U0dDd1ZISUxINm1VWkFlYlkrc0Z3MjBiS0RZMEx6dC83RVdUMExvcDhLUUVn?=
 =?utf-8?B?c1J4R2wyb21HeFQ3V2V5ZVc2UHRpTVBFcDlYYVhyS21HdTg2MHh6b255Mkd0?=
 =?utf-8?B?Q25OMUJyNjB0cnZ1M1lmWWtaa3hJK2RCamJudmdFbnpIaisyd0dVcVZIdmpC?=
 =?utf-8?B?elVkVVV1VVRhRTNsNjJuWkpzUTBCckxoQ1M5c3MzS0hwdjdTWnJEY1hqWnFP?=
 =?utf-8?B?OUNEYlZXVFFFZUEvbU1TSG5WZGtCMGdUWmREeVBVc05xMjErcDZDTjcweG5R?=
 =?utf-8?B?eWxWL2dwSkVsZFFSR1ppd1NISDNaTnljYXpXY1RiLytyNW52bWJLdURaZ0dw?=
 =?utf-8?B?TVh0Tmh6TmNpWGlteXBVblRMcUpNOFNvRSt3eXJHWUZROXVMalEvTGxwTHRQ?=
 =?utf-8?B?Y1NsTEwyNHh0Wkxpbitkd2oybmdMdFdvdWxlYXdPV3RQaDFmemY2TVJBZTFp?=
 =?utf-8?B?NmdqOGlmaktyNHJoVUhzWGRRUEFnd0xSL0t4SjJRQytjbnNGZGJLUHloM0ZE?=
 =?utf-8?B?YWRwNGJnR0plNUk5RC9nV2Y2QVhhVnVJYXpkUzVacG8vZGJzbXpQOHZoaWdD?=
 =?utf-8?B?bllGaGtJTXNwT0tka1FLMUMyYkZUcks5NVlHODFsS1J2eklPUG41dnJXUllm?=
 =?utf-8?B?UzJpTkpuWVVlamVFR1dnZ2tDeXA2NHB0NUxBZjRUYXNaU29vcHZCR3Rwc3lO?=
 =?utf-8?B?bjI0Y3pzOHBLZjAxVk5hRkpEd3JTTDV4RzlsSVJ4UnFScU5HQnJGQzlTd0pl?=
 =?utf-8?B?SkdHeDZJQUpLMWZrUGFzck8zaE50MWNDaVh2eFBLZHk5ZUR0a0tydlRhb3A0?=
 =?utf-8?B?UndKaFczUWQrb1dER1cxM2toR1NjUEphSHFvWU5RSGR5V2xBc2tlRVRDYUw2?=
 =?utf-8?B?YzBLVnZOQmtyUHFlN3MyM0lEcmVRV1pOQmpYM1lOMmR3UlRDeFNwRjVhRXls?=
 =?utf-8?B?Ri9RSTZUZnUxdkNnblBjUVorYThmTE5Ca0IvQytycVVnUWxFeXFQcUtuVHY1?=
 =?utf-8?B?NFRkZU12Wk5aZkgxdkNRKzc4RXRVRmRrOXU2aG41QlB4aWZUOWcybFIvTzVS?=
 =?utf-8?B?NWVSbUowT09JcXpSWVRqZlJWSTU4ckUvRGdwSTVCWFVNOVFRZUVUVkFjV3Vi?=
 =?utf-8?B?MFNQRXhkbEg5Uk9NZXAwSVlYVzdCM1pxL3ZVT2RVQXdINWhPdEc4ZWJ3Rm94?=
 =?utf-8?B?OEZzcGN5c3hnaXlHUk4wUGJyYTNZSTVobUlXUW9JMkYrTVBLb0lRbXZkYnRM?=
 =?utf-8?B?b3haMC91THFsSld3c3JUbEtBK0pmeEhNbzRjWUR6MHI5Q2prWGtQaGJUZysx?=
 =?utf-8?B?by9CRU0zRFYyUW14bnovbDJSK2V6QmhsYkpEZDBTZWZxQ01raGxSaUYrVE9n?=
 =?utf-8?B?OU5Vc0M0aVIyOVUyZU45UnZSRGt5RG1TSTlvenFlMkEzYWRVNEtMZDk1R1FH?=
 =?utf-8?B?K3JBSDYvZ0pCNmNDSWtyL0UyQU1xd2lMOFhsUE1HMndnZVRHdytQYUl5cmFo?=
 =?utf-8?B?NnJCRVlaWGpTODNiMUU1Q0M5MTlSa0RlSmNhdE9VS1hudlk0MGJHQ0UxWUhF?=
 =?utf-8?B?aXF6dCt1Wm1sL08zWmJpSDgrSnpUS2dYc0R6YWVURTlUeFJjaUlaYzd1UzhU?=
 =?utf-8?Q?cv3JRN3IhIvU1W4ePwTXYZxI2xgq9ZR8aXdQ1efvhp3Xf?=
X-MS-Exchange-AntiSpam-MessageData-1: 4AUSLXy+bOup6Q==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: a2022731-51fb-426f-750f-08da47d9011a
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 16:24:18.0676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/YJIrcbY4W4PyKlDAzoxBNAUvF//990B8s6MOpbJzzWqzNra5htPv1bt5Bg/3Hd5l0C0ioywuorVACZqY4Esw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6251
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Mon, 06 Jun 2022 16:24:21 -0000

On 6/5/2022 4:24 PM, Jon Turney wrote:
> On 03/06/2022 15:00, Ken Brown wrote:
>> remove most occurrences of __stdcall, WINAPI, and __cdecl
>>
>> These have no effect on x86_64.  Retain only a few occurrences of
>> __cdecl in files imported from other sources.
> 
> While you are correct that it has no effect on x86_64, I'd incline towards 
> retaining WINAPI on Windows API functions, because it's part of the function 
> signature.  But other people might have other opinions on that...

I ended up retaining all occurrences of WINAPI.  Those that don't directly occur 
in Windows API functions are mostly used for thread functions passed to 
CreateThread, and the latter expects a WINAPI function.

Ken
