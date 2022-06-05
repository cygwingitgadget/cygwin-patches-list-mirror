Return-Path: <kbrown@cornell.edu>
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20721.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::721])
 by sourceware.org (Postfix) with ESMTPS id 6E307384B834
 for <cygwin-patches@cygwin.com>; Sun,  5 Jun 2022 22:23:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 6E307384B834
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g48ySUCDXSw2A3nUtwpZw4x7cMUxtzzXABVmEo+g5GCQ6pFYlx095D2WUpGVdKEKa3CeRomrHZN+4A5P+7zmE+avQ86hgzsNr73BInp+t3jgHCJ/L86kt+w+p5NILlwkfRj5suAKVaUjiSryycqKqcTo7FD0/FXP77ZqaYjP5UjmB+L8eJDekq23zwG0RUtJkT9flyfDmF/AjYs26xxR5lOQZUpnH2+0f800sD0IR7focfYktHqUbRA9UZ4wBkE9qG83cSidfaDTBukMf/fhMP8M1P9hCsIthz6w1XXGKCM7byhoylmz53hrRSLtwhbkR5H1yYPmzvUmmIy43yMEWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tttyYDD1Is3yunbYFopif5ikEiZCg+r+TTw/8WgtpDU=;
 b=iQg5OnKOi1Eo1Bx10dkmZ9vyJOhjf8G8F1wHDKxxM9WUSPoTSngAgkeQn6eZMjnsDRLs7pA27WMHWBGz860bHiiTqZUkxMnz7wTuJEmLg/ht+LlZLvhCVye4jF9yRNYSQa/Yvz2PkmSMlmR71JNe+55zgtRSNrmsQmFztH60JWG3Wk+3hfR6mCAAYJKyoKGzo/KORdLc0YQBZLVLc76iyPS/uB1pjw/H53zwYCZkR50vAE/KImnR63ErgJrAWeivDPf24/GBIGTz+QMy9WS+iTnPxZoJN8gPJwFB9g72paiK4WkgifbaNBv3F7czqaUT+qVG4oyrttRdtIkNPtHqbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tttyYDD1Is3yunbYFopif5ikEiZCg+r+TTw/8WgtpDU=;
 b=ETfyh0jvyHMVQv8MPIbxBvuNR5uBKXxQ+h/5viNP3+nxs2uAJDxABkHR/012VTZiD2ZVUQGvaBnkxLUqf+Ufgg0dg5lbAk4CsukW1ETJxxaH4ZmEDuHDOQfrV3LOFIPBQGWugrmMKzemU657bGWrVlzXJ/zu4AFye1lHX+7UTW0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by DM6PR04MB6810.namprd04.prod.outlook.com (2603:10b6:5:245::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Sun, 5 Jun
 2022 22:23:18 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::e48c:b440:3098:a050]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::e48c:b440:3098:a050%6]) with mapi id 15.20.5314.019; Sun, 5 Jun 2022
 22:23:18 +0000
Message-ID: <a2eaefc1-153c-0fb5-bd3f-2e02452f2903@cornell.edu>
Date: Sun, 5 Jun 2022 18:23:13 -0400
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
X-ClientProxiedBy: MN2PR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::19) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 351544a3-bacc-4abc-ff4d-08da4741fcd7
X-MS-TrafficTypeDiagnostic: DM6PR04MB6810:EE_
X-Microsoft-Antispam-PRVS: <DM6PR04MB68109DCBDDC2E1A92E6425CCD8A39@DM6PR04MB6810.namprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pxgkJmS5EvXmRg0Vl8WV5r5UocHTQfDVGp++Smpzm0TqPWj1xBHc4Lg05p2ZKUd1sPQaClZCrs+EWiD56y7a/sMxHHtTbVPgt2m3hHPqvxM+2qiaRM2l7+oos02hakDt9elPjJcIdluBjbappLjAlqWs/PwXMWYEPZr+Fagw8MsgjDZMFqiG9a0zAw35/N1XUQuUf7QOBveG++/jKCRxXLgbrmsG9NxOsMWYjUtvgquHg8sQQqoDhG3/xkGRV5Nr7iICYSMAD00i7ioiq4vBAauMIbSeTpT6m1RSXs0PfsL6v5pVkT3wID1MmM88Xx/1OzusGTBpCYDwhL7PoJCz8e/9fEW0Mv+INyOoWRPTSshT7Kp5YVALbkWKtp472Eu9dp6lzIa1j30aHtHWNl7ar9DTJC9BsyVylsRxpy3jiLfJCm9GEWq3rYHtbeH9662ZLgpf/DIsJf78CqRiGgu6JEEMOwJ6KoPaHg8E3Y7CvCQLUUsWl5MQ4x8PSVyLn0ehsUYGhvoltUx92/On4Qagb+afTEXLZBj/8nkG7l/FvDwo1+eH1JtnrZKYRzLqhZbNcS4s/WxfEDtQmRODBWuSdYrp1rSgxhoyrMrdltkc+YaYhmD/F5HJULgSQypJBalQbYML4Ye8eSVptN4rWHeNY6NYT3IJm6UDLfUDOHDsIPQOZMeNvdm9UFFBL/Mm9odjOU1v8g4Se50G/E+9++3b1h6kNYXL1t6pKT1BCNWohZI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(4744005)(38100700002)(6666004)(53546011)(6506007)(83380400001)(6512007)(786003)(316002)(36756003)(86362001)(31696002)(2616005)(110136005)(8676002)(66476007)(75432002)(6486002)(66946007)(31686004)(66556008)(5660300002)(186003)(508600001)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnBnWjEyK21KdHBQUXRNcXgweDVJeE5ockJUZVlPUTZSQUlFT1ZtNXlzS2F4?=
 =?utf-8?B?RnFSQ0FwNGpCWXljVDJEWitTYmdGcUlHTVRIaWZEWkxPQnpYbVJkYzZTUzJx?=
 =?utf-8?B?UUlsWUM0VTNMQ3YzaENtN0ErMHVIbFVpeWtQL3U3emx1czJGeVdyNTc4UU8x?=
 =?utf-8?B?d3hrWnQ1QnVzR0NvMzJlQ1gyYUVwb3lGOXIxblhlRXUvUmtWTk1Wc2tseU54?=
 =?utf-8?B?RkZkSkJ2KzgrL29DekZQaDdCM3N1ZHBOS1RJMGhSUmZtLzNXSVBKL1crQzlW?=
 =?utf-8?B?UndTUzA4L2JYR2FwWWFQQXpiTmdXZHpqdGNtY1Y1dmNDMUVHQ2g2RHNzTWlr?=
 =?utf-8?B?eXhobmVJRlRhcHJXVDdJNU5WdjRIeWNMSHM5aHpGdEpBandXa0ZIVk5HQjlv?=
 =?utf-8?B?VHA4cytvb28xL0RHNy9qZ3kvTDF0dXg2VU5uNzE2L3lCb3Zqdjh5YVF0Q3pQ?=
 =?utf-8?B?TFFjc0E0b2Fsc3hkTFoxcHdOSjlCZzhGQVhYRG9UektzMWIvSXFrRWQvNUpl?=
 =?utf-8?B?dnZXblN5OVdpeUVtNVdrR2dVc3kzWWNMVksxeDduak80bUhvSzNHSktuQlFh?=
 =?utf-8?B?RlNzLzY2dThyeUNNTE1WSGxxN2hwVTJmakVMTUdVUWE3M21oNlRYRVdUSnhC?=
 =?utf-8?B?dkNUUnh2bnR4dW1HR0gvRWxjb3hMaHA3d2dWLzFESHlwVkJCalA5T3J2QUFI?=
 =?utf-8?B?ODZWdFlJVnZlRThScmRFbFZuUzZCcnVJL3U3YzRxNmxmbllVKzJIUEtOVmQ3?=
 =?utf-8?B?RXlndFR3dEJSL0l3TXdvSEtGTVViZndQN3pkVHFSRW1zOXlEQkRmeDNCaWls?=
 =?utf-8?B?UnU3ZFQ3dDlEYkF3TXZHYVBmUWI5Q1l0WUxEUnR2blFjNjFqMmVIL2taVFBo?=
 =?utf-8?B?NmtPVnR1QUFKZ25aRjdCQXY5WE03b0ZhN1U4RVBYL2s2MmhCQXBwSE4wVFVX?=
 =?utf-8?B?UDFpU1ByMWY1anEvWDZSdjhibCtGMUtHQWdTNUM1M0tuTlNqRUt2Z0dFSmd5?=
 =?utf-8?B?V0ZVZnpscFZQTlBNV3ZkbllndzdaWEZSaVUzL2F1NDFWbkh5R2pNOFlJMUpt?=
 =?utf-8?B?RFBaekRXdHBrcmpyQXJoZjFzdzUxMzYrU2NzM29ITHpOYUs2VlZ0ZlVoeGpi?=
 =?utf-8?B?MEZvVzFjMStMY2krekl5aXlZRXF3OG8vdFRrOW1WMm9STXlMUGV0MGdnQmw4?=
 =?utf-8?B?WHdBaEFEMTl3M3JxNlN4eFZIWmlJeElyeUM2M01KNEhVQmtuMytRVzhzWGxp?=
 =?utf-8?B?TmNsK0J3WmZPa0drbGlTeUdMUTVpS3hkZTdUbGVYM2haYzRPZEVnTUZGRE8v?=
 =?utf-8?B?L2tkOGM3OUM4UlhPM1EvbE1wZlplWWxVakt4Mk1qWS9VMTBZSkFkZk83Rnhy?=
 =?utf-8?B?RVliSStZNjhBdWswaWRRTU05UXlsWXQwbEx4NGh2b0Fndnh2NU9mbk81Y1Vv?=
 =?utf-8?B?UHpUSFpjUWp2ZUlPemp3L3krUS9nOFU1cVE4UDdST0tBR3AyZ3JzR1lnMEVS?=
 =?utf-8?B?dmtudTUwajUzejZkRU83enVZTDR1bkhCWmtqVjlYSUhhVWJRZkVYM1RiVWox?=
 =?utf-8?B?b0NBK0dtNTZJU1hzMll3Z0RMdTFqQVdGNWxaYWlXbUFsaFBUL1JOWTRFZ29i?=
 =?utf-8?B?eUtrMlNqTVpvYTBXOXlsdmhrb2VobnRWbHBKTURVcGJXMXRGbU1BdVF2TEJk?=
 =?utf-8?B?Tlh1NERqRFhiRlJlZit0L3FUVlo0aGdsaWtMYzRXRWNkQUVsMTI1NmtMSTJX?=
 =?utf-8?B?by9iWm9wNDhGZ2dFSE5LejNuaCtGeUxyWi9NM0xSSjA3c1lEc01PTGdHeXhY?=
 =?utf-8?B?TVMvUXBpMFZEWDlUM0NiTDNGWEtmZ3hOUUFDSjVDaUk0ZjlNVkNUcG8rSytM?=
 =?utf-8?B?cGpuRm9SVjVmdTNQQnhvQy94ZHhHYkYwc0p5b0V4YzF2ZU01V1VWQ2wrV3Q0?=
 =?utf-8?B?Z2QrcW53SXVLOTVmbXFvYVZKb3M4SVZ0RnlHME5uSVY5MVdkTitqWjBxeGJF?=
 =?utf-8?B?ZDBYSktXSWgyNFFZanFFMEtJWWd5Z3M2SXdVdUVMWkkyVncybC85TDZ3NlNa?=
 =?utf-8?B?bHlhS0s4UHA1QllCTkw4Zk5Gd3A0Q0tmZm83bXYxdGR2Z0w3ZjlqY1g0a2lo?=
 =?utf-8?B?VmcxUTNxdDNHaEs4V2NGTEFlOUxRTTdZMXcrVzZ6RkJNS3lhTTlBekgwbndN?=
 =?utf-8?B?Qkc3OHlOaURRWHJwcHVNSVFVTWlPYkVYbVNPYjBuZ281WWk5cHFFRjJCc2xJ?=
 =?utf-8?B?MjlDZU5ZeEt1SzlxdGE2bi9GWkN1YVRqb20vOGFoWGkrN3FNMjdqSStSL09U?=
 =?utf-8?B?bndPT1ZqVWhLZG9nL2RIamhYaDRMeC8rYUdnK3BrZGM0WEg1UE4rN1N0c1Yr?=
 =?utf-8?Q?XFcdYhSiAnoqI/zzlHbcbV8LSToJF58mj8F7kqgCmjYeg?=
X-MS-Exchange-AntiSpam-MessageData-1: TZYE8LMa98Jl/w==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 351544a3-bacc-4abc-ff4d-08da4741fcd7
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2022 22:23:17.2119 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YnW6zjV6y6rUC/H546b6wFXX4ijZW5mSAtlzXcjiTEGzCcbxO5mgJbgDT1f3x7sbA0jwOIqzOWAkp80wv+LE9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6810
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sun, 05 Jun 2022 22:23:23 -0000

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

I agree.  I just mindlessly deleted all of them.  I'll submit a revised patch.

Ken
