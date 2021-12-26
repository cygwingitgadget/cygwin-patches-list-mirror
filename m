Return-Path: <kbrown@cornell.edu>
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2096.outbound.protection.outlook.com [40.107.223.96])
 by sourceware.org (Postfix) with ESMTPS id 013843858404
 for <cygwin-patches@cygwin.com>; Sun, 26 Dec 2021 03:04:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 013843858404
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGqwgZaSGqH3d67jOyYg5shjPCvMYfXx8xL9IuxQSwgA4KhLvnIm/6fys48Rq90jk1/f5K5RtT++X3bdSGrrdAuRtyOnM4u95Mjg6pqqLots92YQI/GuE+GZDFrq6AmsRAo881776/7+8N9gHpJPgvgIByx89IDJLTL5VXCBxpPcaebRnGrFWDglArOe08GHE+d+paZw6ZYJKkLktfDVkZ/Mw1vl/I+hS9wy2jj7E7NldFFpg+JWAWP9OWTCqpCp5WpTgNcQEizW7eeHpC5PtGwdjRQ9N30ap977RxBlhD1sa+0EJJk2n5oHuLDj/XwjvMOoKP3eLigfGqJCrEX85w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2q/GPx50N08yvZHYapL+DuoEJqc9pXPPvwUUTszD88=;
 b=HBFnLNW5NnUGuNhrILv5efwoRKbxvI3i03NKH6upt3L0m+thj/8gs2VbPYqdNbPkPwGw4ensBMkuv1w64ACn9SRoU54ZXODGobpbd7IiK3mq6p87KSi+6zfrpVn1cjqdD3JqQN/ZKBBb79w4bcGgYkIPONPA4h25xwVoruJzo0OCuqAOoopV8O4IywOAVGYx15vHYKdywm5OFPxjNk3R9Qtm2/mINmS90hW1WTMwro9AuG6i64q98APYWJ3qdVplSDBJeisdwjRYvsQ2oAizXJdcS2CcPfaA0I95FL8L+YrpIPewqcOqaT6jrAz/H6532uZBs1TeFIK68uVKYFODpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2q/GPx50N08yvZHYapL+DuoEJqc9pXPPvwUUTszD88=;
 b=crG8HISbO+BEJ++Ws5uYZ9W4mbZ8NbN9BRDH3f7oz9Tn5mn4ogtNizxYbz7ECZoM+WYyijqyNTTZo64fH8ogdgtz7b8qEodk/9+DlXgsAJp1LU6rbWX5lSqGkwNyQbmDD8dcxoLwZmuKTrRqSbTJQd1yb1lqRrV0Oql/OBI/UF8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN7PR04MB3841.namprd04.prod.outlook.com (2603:10b6:406:cd::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Sun, 26 Dec
 2021 03:04:04 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::e53a:dc46:9edd:9142]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::e53a:dc46:9edd:9142%6]) with mapi id 15.20.4823.022; Sun, 26 Dec 2021
 03:04:03 +0000
Message-ID: <8172019c-e048-4fe2-79c9-0b3262057d3e@cornell.edu>
Date: Sat, 25 Dec 2021 22:04:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] fhandler_pipe: add sanity limit to handle loops
Content-Language: en-US
To: Jeremy Drake <cygwin@jdrake.com>, Takashi Yano <takashi.yano@nifty.ne.jp>
Cc: cygwin-patches@cygwin.com
References: <alpine.BSO.2.21.2112231503400.11760@resin.csoft.net>
 <f97bba17-16ab-d7be-01f6-1c057fb5f1a5@cornell.edu>
 <alpine.BSO.2.21.2112231623490.11760@resin.csoft.net>
 <c5115e9b-6475-d30e-04d3-cb84cfa92b3a@cornell.edu>
 <alpine.BSO.2.21.2112241136160.11760@resin.csoft.net>
 <622d3ac6-fa5d-965c-52da-db7a4463fffd@cornell.edu>
 <alpine.BSO.2.21.2112241638280.11760@resin.csoft.net>
 <20211225121902.54b82f1bb0d4f958d34a8bb7@nifty.ne.jp>
 <alpine.BSO.2.21.2112241945060.11760@resin.csoft.net>
 <20211225131242.adef568db53d561a6b134612@nifty.ne.jp>
 <alpine.BSO.2.21.2112242101520.11760@resin.csoft.net>
 <20211226021010.a2b2ad28f12df9ffb25b6584@nifty.ne.jp>
 <alpine.BSO.2.21.2112251111580.11760@resin.csoft.net>
 <alpine.BSO.2.21.2112251457480.11760@resin.csoft.net>
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <alpine.BSO.2.21.2112251457480.11760@resin.csoft.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0333.namprd03.prod.outlook.com
 (2603:10b6:610:11a::7) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6727fcf-412a-4796-4d22-08d9c81c5f87
X-MS-TrafficTypeDiagnostic: BN7PR04MB3841:EE_
X-Microsoft-Antispam-PRVS: <BN7PR04MB3841FAECF4070F70329F9238D8419@BN7PR04MB3841.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yb7qfHKTGCr42sncISkuftlvRKd63hXW2e/JQAXtaYCcm1sYekgZa1eER/t4FXZzc1RqT8rHTexHMaukwj24HhWEBaIRirxuSMBXzlE4fhNYNvHX8q8ninr3qaeau/qC5DmT7p7FTSkFwXa3ycwubQvmQQL5g1FNrnqv32OjPV9B3V8BI8T/ca9vbK8M0iL3NaAZ2VxqOv4SLbsTDjx2/skWK+P2ReF8M3u2zcLbsdwUrcCIvqcmIq5YzMoS46Wph0QJF7XxtIpdyYNf7/IwwVTKuKUfOljBkPBybN5wmCSJPgu6UYBFmUF0A+r7dr/WQTQOclyO4xdzcLyNS92XhYL0nM0GSItSG9lsl9TTjmwllnZMzZGDIskeVa+kfyEICVs2RnHRxHc8lmjOXWwSeVAO/5zi+tFzDt5cv01lG4SPG7fC2diAvO2pI3WQJHMb8o3Id84sSY9ceANGEuK4pqJSfA3G3yKvrR+rnw6QUg/+oIDc2FQbhthbjqHu4zpatkkb3R7Jvd7KneU90E6/iDZfaBGDvS5mj+UhCr+hxx18cTsTUSz6+cAWMclqYNbdo3J6SsJSZLfAU1lAomM4RJVOvrooZtEVsFJQif2NPzlT4OXtoV2KmA+cJgk7FEXjzTbsOTXNeTIukEX/o24C7ehZx8QBGdae+0z37mf+Lmt5dq6M4Y1/v9ObeZ+QC7M8rIMD98k8wrGD0B2wnj0lbLKHErTMa6nuTo1tPtmVgwrx1wUduPwaSNl+V1kP5h4B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(786003)(316002)(4326008)(8936002)(2616005)(2906002)(31686004)(86362001)(75432002)(19627235002)(38100700002)(53546011)(6506007)(36756003)(66946007)(6512007)(66556008)(508600001)(66476007)(31696002)(110136005)(8676002)(6486002)(5660300002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REhNUGlKdDNLWEFXelpCOEVpd04xeTVOWVR6cnYzY21vVnh6d3R1d3MrUFJp?=
 =?utf-8?B?R0ZsbWtPOENSQXdkM1pVSzVGMUFLS2Y2YTlNdlRiK3JWcU83SmFMdDZraGV3?=
 =?utf-8?B?dlRZdTRVSUNJNXdaa3QzdVhHUHZaWjAvSHMvUSs2aXBkSTc0bGtXWW0rRFMx?=
 =?utf-8?B?cWhiMWQrRnh2K3VFNFA0MTVMNlMxakZMZHdXT0h3WkFneGpNbGltb3JTdC84?=
 =?utf-8?B?YU1HeVl5NEU5dlpZQVM0bndlbUNsaHViOWZiQktBNVh3N0JxTUxJaElSWDQ0?=
 =?utf-8?B?Rys2YWR2V2xjZldPWndDV0FJTkNyM1lQQk40T0ZDR0tNSE93Uyt5aDFPMlpo?=
 =?utf-8?B?Z2VlV3hiazNSRWp4NVBjcTZLRVpZODRHSnd0bm9mU1NpOWR3U0NtSWNsWGlW?=
 =?utf-8?B?MGxXOEh2S2R4Q0EwcXRhSjN2TitxWVBVQmpITDFGNUVaVmJnckVVVWtObDRq?=
 =?utf-8?B?WjNGdW9jdzM3SXBoU1FtQi9Hd00wajVQMnBaeFVmZ1hqNEJKNTlXc2M2cHdN?=
 =?utf-8?B?ZlNpdnY1LzVVYitrR1h4cVFnd3g5ZjYyQlJGQUlBdG5EOVRYSEM5NXJCNjlG?=
 =?utf-8?B?ZG5Vb0JvVy9WMVg0YWI2RWpESXRMN0dKS3hkbkZpZXFHaTJqWERQR1lIUVBR?=
 =?utf-8?B?WG1ENGF4WlYzN0x5UEt0WXF1ZTczaTlNMlpyK2ovWHZRU0xQa0tsby9IbzBK?=
 =?utf-8?B?S3hMZGJOUmRSOFlrbUdXZksyM3pjVm1yT1NBL2FOZ3FMZzRvTTVLcHlYSmR6?=
 =?utf-8?B?UTdYeEZaU0UyRVJkU2ZlVnVWbkpLV0dIOWVFVU1oNDhUQy9MSWFDNmh2Z2Zv?=
 =?utf-8?B?STU0bHlTVk9DMkFJQXhIdVRaZWtYR2xJR1JxQkdVY1NhSExrSldNckdSUC9U?=
 =?utf-8?B?UzFsNjJXSDFabVppQ254Tlg0aFUxL0lNMm8rY1kvVnYyKzYwVk03aWdqS3Np?=
 =?utf-8?B?dXZ5blBqVUNVbFRSK1hQdW1EVU8wQWk4N3JBb1JRRkpka2IzKzU2Mm1qNmF2?=
 =?utf-8?B?bm1ZYnVmVUxkMXI0dEUxV1h0eU1yc1RHSHlEc0o0eHlEa0RneDZsMGljekVY?=
 =?utf-8?B?ODByYnNmcUJuYTRUeTlhYjEwZnBaSVRzcW9JUHovVmtaWHRvazFGMXJHSnpz?=
 =?utf-8?B?RjVlb1lSSW1XVklvc1pNSkhaSjVSN1hPdVA5U2pSMlB3cXY0ODlWUU5Ia3NE?=
 =?utf-8?B?L1k1dkZCbnZnTm5BZVNVb0U4NzZoSFZWODgrOEEvQmZPdWpjLzhlS1Q4cEc4?=
 =?utf-8?B?WHQ3cUsyZGxmVWlQNnhzYm9kcEdwb3FiRmk1Ni9xc28rYTVjNlM0cHdMNUMz?=
 =?utf-8?B?ckJYNGRMNld2QmMwOUJ1ZmxpQUtMTUkrbmNCNHcwb29hZWVKaHVLTzFIakJq?=
 =?utf-8?B?L3FVemNHbjhEdjJlRlU5a2NKUjRDTncrMUtxU2d0QXg4NHBpNjdLaDRLWjlx?=
 =?utf-8?B?VG9JelJ4UWxUNFdiWm5pRDJQUThZTTdIN3ZOZ2dGaUNkZ2swZFEzakdyMmNG?=
 =?utf-8?B?U2IxOFZLZ2dCRXFkQmlJUWt5Y01tZUQxMTd0amFqSmFxTnQ3Y2dlZkw4VjNs?=
 =?utf-8?B?T0ZQL2gzS2p0ZHo2N3dtbWx2TEEveHlDaERxeHhaUWNVNzVLOU5Ib2lITjRt?=
 =?utf-8?B?M1F6ODRSbkxOcnhSTHBpUUhrSXFjS25GR3ZBamhzK2dEd3VPZHVlQ0hBUTV6?=
 =?utf-8?B?ZnBWZjZ2Tk5DSUJrRE1GS0Y4YjNxSjJlQzhTYkV3ejQvOExTLzlZUkFtQ0JT?=
 =?utf-8?B?cGJ5OUtjME9nSXFIYUJGR2xMcnBhVFY1OGxsbEFTYklrMjMxZHhkaXBUMmMz?=
 =?utf-8?B?bmNIdXV5TmxUcElKajZ2czdMVjZZcG0weldXNlV1UjkzUmRVUHFxNlRDYlpL?=
 =?utf-8?B?NWk5RjRld3J0Tm9DNExlNmdKVnAyMjBCVkV5cFJCUU8yRndpc1pLaE1VdWhZ?=
 =?utf-8?B?enBhT2VjYW43VGdvMjRSOXU3RmlraS9jNzdEVnRPWURodGVJQmk3U2xFUE12?=
 =?utf-8?B?cnNwTjd4bzJmeGRqMStuMW1HV0IvdDZUZTEvMHBEUW5QWGJuL1FlQThYS2k2?=
 =?utf-8?B?K21oa1R1ZnNBMEMxM25jWVBqM2o0S2NxN296cmtXMXZ0YVpzVWhWYmpUNHNM?=
 =?utf-8?B?ME1OSVRvWHJOeEZqc1V2TjV0dms5Qk1FcThKamZsaUtualdvZDY2c0tuQ0xa?=
 =?utf-8?B?YThhTHRKdHlXQUtLWGg4di9ZVjRTbEVzWXB0TktvVzJCZWVlU3BkZXVkR0xl?=
 =?utf-8?Q?SUh9nHSj6v3y2S5ihpXSav3gzIHbmr0UuHCeJG1Z5g=3D?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: a6727fcf-412a-4796-4d22-08d9c81c5f87
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2021 03:04:03.8227 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MdEo7hUBoFyw9TCMNs33csQpqq0WCKG59oTwbX/JpEgVy9fnWO+wpULN4UXFK7YeQeUiC63jgT9jP4mJlhUCJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB3841
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sun, 26 Dec 2021 03:04:08 -0000

On 12/25/2021 6:00 PM, Jeremy Drake via Cygwin-patches wrote:
> On Sat, 25 Dec 2021, Jeremy Drake via Cygwin-patches wrote:
> 
>> On Sun, 26 Dec 2021, Takashi Yano wrote:
>>
>>> Could you please check the result of the following test case
>>> in that ARM64 platform?
>>>
>>
> 
> OK, on Windows 11 ARM64 (same machine as I was testing the assert on):
> per_process: n_handle=52, NumberOfHandles=52
> per_system: n_handle=65536, NumberOfHandles=35331
> 
> On GitHub "windows-2022" runner:
> per_process: n_handle=63, NumberOfHandles=63
> per_system: n_handle=65536, NumberOfHandles=34077
> 
> On Windows 10 x86_64 (can't remember if it was 21H1 or 21H2):
> per_process: n_handle=37, NumberOfHandles=37
> per_system: n_handle=131072, NumberOfHandles=76069

This completely shoots down the speculation in my last email.  Nevertheless, the 
results you posted earlier do indicate that *sometimes* 
NtQueryInformationProcess(ProcessHandleInformation) returns STATUS_SUCCESS even 
if the buffer it's passed is too small.  I hope Takashi has an idea what's going on.

Ken
