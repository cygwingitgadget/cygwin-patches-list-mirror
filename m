Return-Path: <kbrown@cornell.edu>
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20702.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::702])
 by sourceware.org (Postfix) with ESMTPS id E66883857BAB
 for <cygwin-patches@cygwin.com>; Thu,  9 Jun 2022 19:04:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org E66883857BAB
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkRZQVf5EJ0GD4rviS6ljJk12WZVnH0prRRvwc37QwoZiUIllYFlJV5QdyU30GMBRbIvo6S890+bHACShoM8s95OdmXRgU4zhBJfM4MlnTUXSdwKpI38eHvRqs8u+Ga+UcBLrejANQxzPw70EAoESwjAqtFX7xz5+0k7q9oPhnETY9O7QzdqW77JYs+sc3mOyKnmvMVlBz4H+RpDuC0i5DVEpTZ0tFB+FlFASD31dfG7XJsPVwwRTCrVCX5QriA/2WBWb2ddNLhcf324jaiKorU+sz2rveIDVeopAMqxR+6QgpEFqzhwM7qK0HTXdU3m3F0Sflb6HqcG6KJcCdeyrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJV4U5s/Z2+7mV+MLQUjoRQ6WKo7VMrXvy27+cV5wTo=;
 b=Z92VGLgyPEyvUWJalSnN9NdUdIs3TeL4J1RaXyuznPf5pl1j5WPPI94RA22TGthogbrdzBDaBoQgKy3QLpBwabr+KOmx98KiykqndMwkIIbUx9d8kBRWy/cY6jJwIaaQ6JhpBKAF7encAYMFtZKw+RVRXfak8v1Z8ZnLzteTMOd8X1hmUqSks+p4zt64mxrJxBryvXsuERatqsCu1nrWPYcGiZzgCLroxxXGQ1IW6DxLIQmNQ46nFlg5TdWT0dE2W6C/RfBzQnx1vWS2Vl92MaQ1oyVoGPcNHnoKMlU3xiKRXKhV40RMj9UpJ4ToU1FypPdaSO0tClz/PZvVXSAMxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJV4U5s/Z2+7mV+MLQUjoRQ6WKo7VMrXvy27+cV5wTo=;
 b=YjUKRmQJllB/y26RNdHSq05jaE6YwxoCcvFQjRwI3tfEsJSGTo2pA9iaw3msKOER04Rxq2RZLoFSqEAaNU7GCm3cFvMLBGj5lUnYPgrxD0Oae0zqgsa/xFe/lE9kLOc4Fp5W3XZsCjvNuBHvUnJV95vIWiKmtSgCbFxNVoNrhi8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BL0PR04MB4852.namprd04.prod.outlook.com (2603:10b6:208:59::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 9 Jun
 2022 19:04:32 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::e48c:b440:3098:a050]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::e48c:b440:3098:a050%6]) with mapi id 15.20.5314.020; Thu, 9 Jun 2022
 19:04:31 +0000
Message-ID: <97cc06bf-913b-864f-673d-71dc8dfbc64c@cornell.edu>
Date: Thu, 9 Jun 2022 15:04:29 -0400
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
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <d4c98759c0e3d7fcc72e13566d7c00d71a52bb52.camel@cygwin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0075.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::20) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32711754-7c82-4653-b677-08da4a4ae2a8
X-MS-TrafficTypeDiagnostic: BL0PR04MB4852:EE_
X-Microsoft-Antispam-PRVS: <BL0PR04MB4852E3116F7DD390EE5FBD59D8A79@BL0PR04MB4852.namprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p8LO+ofQ76QZ/aLxwT5jrAh2qbmPQJJM9Burg9wyUhAZ9/nHhGzDfbrbjwiZnyQbLjEU73GjvZ9JhRFZQ6FSV65vKVEMW5wjquex+xe1TweULpIF9XyXU95jYXX7Fo1CBT2CuHCG9mXftjx+OAmHcIGmeLjh52il14E5nmFLOo3MN8l92rdUU4kg4EYqM9yyGt0TVPdIdLd+LeCqYmPYAeyPNJ+RuunIsOCGpNPMsPhATFJQZURmDTNuhhOqD97QlZfsKsa3PIVyk4XfYkaB6vRw+SKFSykDCwGwPw+sTFhL6pn6CNaDtZBEeH6hwLg9WhjRaAovKHUXfmWdHiOmaLLyqsiJVtzOFdG+f0+BE8b75RphwBfcgJmaaFBqWOGy3iedIuGb0LG9fyc3HMBsisRkouOV3mwjRf4SuNDOZLwD6Ec8uOSM7VftDtqh1A1twFmJk408QqinGAMrLouk/GUBWTQgF2VuSTmXerTa5NVV3Yw/3ESGUpIy9AxhT2l5jK7HAt9XgUh15XvPZs2y16fyUvRP+GjRHs7ESFJOr3UijApS8S8Z9qCNsOHOlYawz2WBFEuuUjNPVU801DKau6P1ENGW8MtPG5IxaLCuDOm688EVw/atdskZvTmXWcchCrpdN1ulEGbcllVmTHKHVApsZ2GWoNrZKiDMTcw8nbgrdKiMeaHcjFE+QQfoHQSPcKyZx7jzYl5px/FSVQvMuqqiV7uzuyglpUedeKYN4uY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6916009)(8936002)(36756003)(86362001)(2616005)(786003)(6486002)(316002)(6512007)(53546011)(83380400001)(75432002)(6506007)(31686004)(31696002)(8676002)(186003)(66476007)(38100700002)(66556008)(5660300002)(508600001)(2906002)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnVzcDJwb3ZXYi9Dalh6YWcyTU9CRmtkNys4b1ZEWHBvSUJPdTBXK3dYVWxZ?=
 =?utf-8?B?QXg2bUl2VGtFMmptUVd4SVphQjc1SkVacTNUWTZDVExNOW4yYTJKZnRGcTlO?=
 =?utf-8?B?YS9ZcWlPMVRwcnh6WVo0MXhCY0lrZ3VISHZOWXNBYjk1MGdFaklJSjdJS3lI?=
 =?utf-8?B?aEV0TTlNbXFEd2dGR3RCTlZndktBZ0RjZ1crUlhZTm9WQlFhSisxOHBFdGpn?=
 =?utf-8?B?RGdXQVd6aWplQ0p2QlVha3BRdFBRQjRZbUtqL3o3ZGRSaEhCL2huU3REcVpU?=
 =?utf-8?B?YnZoV2hzcDJZTVdDUXpPd1l0VktHSkRIZ2lvZUdHdkt5Q3ZpUXE5R3dqanNF?=
 =?utf-8?B?a3U4UzNzU2JScnRnYnN5VTg4UEx6RFlhdlpYUFNDeU9GQ1BpNFF6bzlrTDcr?=
 =?utf-8?B?b0VrRGVPbk9hM0FPZmhXbkJDT3JiTjcrMGdFdFdrMmR3TGp3NmlMYmlpejlQ?=
 =?utf-8?B?SURJbmN4WEdLeFFVM2ZTWGhPNldlOGQyQzdWbFBXT2VIRldLblR2RWNUVy9X?=
 =?utf-8?B?RU1ZRWVjcFNqYy9yOXY2UHJ6RVVhYlB5UWY0c0FXcWVDQXdQR1hyNWZSak5v?=
 =?utf-8?B?Si9Uay9yVFZqUzBtOG1uTkRJU096eGlpK01nNVJlRTB4OWppWWExeDJ0eTNm?=
 =?utf-8?B?Q1BCOGQwbjRNZlpkWDgzb1V0UmxTVlZSNzdxZ0FDV3lLcGtQQ0NzZFZqY25V?=
 =?utf-8?B?SXZYRDN6Y3o0VHpad1J3bDBpQ0V1ajk0QUJONjVSSG1qUlBFRkZldVdranhE?=
 =?utf-8?B?R2ZsWXl5UUI2U1ZaUmFhWm90S3Zmb29MUFUxMTBLUjd6blhtR3FrTVN6bkVN?=
 =?utf-8?B?VUltVzgxM3JoRHhSNU1STVN0UlR5WDZGQ1U2YytkbDF1dlNVRlBhYUNxdjhk?=
 =?utf-8?B?b3N4aElTL1JkcklOdjlIY2JDQ0d3bXBoU3BScHorRjhwZzlpSmlLZ2RaR1Fv?=
 =?utf-8?B?Wk5QbmJVZEg2VG9GYVdwSnNjNnZvRWEzSzZKYkxkd0tnT1lJL01nT01QREtk?=
 =?utf-8?B?Y0JtT0hwRThkOVgxaGdUZVNScEFiSFFrNFJHZ0tCNnFFaHZBeldvMDRPTW9V?=
 =?utf-8?B?TTVMMFlSK1hxN3RCN3pQc3dSYWJQMEFqZ3B4L3FhMklWbk9LekFrNFU3UXc5?=
 =?utf-8?B?UURnb1Y4UmVpNDlzSnlMY2F1UUsxNWd4aEw2cGdjaXFIREJGd2NqS3kzRkU1?=
 =?utf-8?B?QmZRQlNUUlJsZVUrOGd2Z0VxTkxhWDFTZFB0Q2NxRDh2K3FVTkxiRTdZbGVG?=
 =?utf-8?B?OWlRNmRnL2lkai9UM01YaTJqUWdLRWhDRkYwaFU0K2ZDWWJyL09PWDBpMXJw?=
 =?utf-8?B?RGRBNmVCK3E2d3ZnZ2VhOU1XeG91RlZtT0JSTU5YZVdoS2ppSmdnNGJBM1Bj?=
 =?utf-8?B?UmJqa3hQeGY1RTJmTk9KZ1BtbEJlZEFDMlR1VHp4RmZHMTZQUmlLdkxZUjNT?=
 =?utf-8?B?TDFkVmxXMGs2TitPei8yTi8wZDV4bHVFdnE2NWVUSXVLODMyM24zeDRNUTZz?=
 =?utf-8?B?c1REblU1Qnh3Vi84RkpmWWVoMXdteUxBVHlxaXlJYlBjZWU4UlZDcnA3SWI3?=
 =?utf-8?B?Q1JNMDhseTlVMlBwTk1jQUpRbzBFUXJWUUQ0M0hjMGY3VzFZREFoV2NSbWNI?=
 =?utf-8?B?NXgwbGpNNko2eXg4bzlKWWp2cG5lOWpjZXlQTVFwUTJGc3plcjFNak8wbXc5?=
 =?utf-8?B?ekZPUmNlRkxYbVU0TytRUDRhTzVJQ1gwTkpZV1gwV25zRkM3M0tIM1d4T1Nz?=
 =?utf-8?B?WVZIaldLK1Y3NTlKRE5Ub2NtSkpqMkJ5K05udjY5TnMyNUxnWlk2SGo4Y2oz?=
 =?utf-8?B?VzVMc2dQVzFWN0JZZ0NBZFJJSjAyd1lsNEs2VzNKUldiZDAyNEU3T25HOWFS?=
 =?utf-8?B?d29iSmtYdHFnUzJmQVUwSE1vWjlnbGxvTTdmYUl0TnRCNVc0bGV3b2JVUk53?=
 =?utf-8?B?VStGdE5hT0paMm9GNGJxeThTVjZRQ2Y5YTFwUzk0Ni8rcGsrVVRScHhGclFT?=
 =?utf-8?B?SDN2aFJmcm9wN2g0OHZacTNzRDQ0azBLRkxwY1p3c2VBajVOYlBBYU1Eei9O?=
 =?utf-8?B?NHNiZExzL01YaU84ZVpWeGQ3VUJwNThPOXVUbzZqSXBJTld0cFlSNFJ5ck5o?=
 =?utf-8?B?VjJLYmhZMm02bThmWVYyVVlKQmF5WEpjTlFVWE1paFZPN0pzT09COS9uVmdv?=
 =?utf-8?B?OHBuUDNTZHJ2WE91MGNkQnJxcGtFOHBUZ1owSVNaSnV2dmV5Y2tneTlsa3dW?=
 =?utf-8?B?RWZEZkg2UzF0VnNNMXFDRkNlZTVSM25yTmcydVBDMUh6dFRVNHhMdzVNVmtO?=
 =?utf-8?B?bjFBa2UzVzNybXlkbmh4YmlFUTJtUGlSeHMyeHM4RUgrUllWZTBxeTAxcG8x?=
 =?utf-8?Q?kzWJUkN/dT7k45U0+Xe7RelJcUFNr4Mt3ati0cRlTjb/M?=
X-MS-Exchange-AntiSpam-MessageData-1: LHN1uQBZ/VN8xg==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 32711754-7c82-4653-b677-08da4a4ae2a8
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 19:04:31.8808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+WhTyTKNZjyJtZNpx+v/jW8Mo0NabTWGKUZX3SmjLp5a4p9JaLisn+f4lZS8sFj3ns5y+KJ/cSeZPbOJUd+0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4852
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00, BODY_8BITS,
 DKIM_SIGNED, DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, JMQ_SPF_NEUTRAL,
 NICE_REPLY_A, SPF_HELO_PASS, SPF_PASS, TXREP,
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
X-List-Received-Date: Thu, 09 Jun 2022 19:04:36 -0000

On 6/9/2022 12:00 PM, Yaakov Selkowitz wrote:
> On Thu, 2022-06-09 at 17:23 +0200, Corinna Vinschen wrote:
>> On May 29 17:26, Ken Brown wrote:
>>> On 5/29/2022 9:39 AM, Jon Turney wrote:
>>>> On 26/05/2022 20:17, Ken Brown wrote:
>>>>>    winsup/cygwin/autoload.cc                | 136 ---------------------
>>>>> --
>>>>
>>>> Looks good.
>>>>
>>>> I think that perhaps the stdcall decoration number n is unused on
>>>> x86_64, so can be removed also in a followup?
>>>
>>> Thanks, I missed that.
>>>
>>> Also, I guess most or all of the uses of __stdcall and __cdecl can be
>>> removed from the code.
>>
>> Yes, that's right, given there's only one calling convention on 64 bit.
>>
>> I have a minor objection in terms of this patch.
>>
>> When implementing support for AMD64, there were basically 2 problems to
>> solve. One of them was to support 64 bit systems, the other one was to
>> support AMD64.  At that time, only IA-64 and AMD64 64 bit systems
>> existed, and since we never considered IA-64 to run Cygwin on, we
>> subsumed all 64 bit code paths under the __x86_64__ macro.
>>
>> But should we *ever* support ARM64, as unlikely as it is, we have to
>> make sure to find all the places where the code is specificially AMD64.
>> That goes, for instance, for all places calling assembler code, or
>> for exception handling accessing CPU registers, etc.
>>
>> I'm open to discussion, but I think the code being CPU-specific
>> should still be enclosed into #ifdef __x86_64__ brackets, with an
>> #else #error alternative.
>>
>> Right?  Wrong?  Useless complication?
> 
> Highly recommended.

OK, I'll make that change.

Ken
