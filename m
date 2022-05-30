Return-Path: <kbrown@cornell.edu>
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20702.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::702])
 by sourceware.org (Postfix) with ESMTPS id 1090B384F024
 for <cygwin-patches@cygwin.com>; Mon, 30 May 2022 15:37:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 1090B384F024
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhSyhaYq7vhB7LXD1Uhv/P95xWLBZooO46WVZaTCTIIderW1+52w6zWGJQY0veFTolcVTodP6t8UMOf47xRLr/8qvDXLTq18gtULuX1vutevivMf/khyl8Qu7kcwGlYxCsqjfFfh0hv3FGDULWb+ICmVYUUU0QXGcZr3RGnse5s0SEb4AVT04NJ3i3pRQw6hOkPh/g+LJeR/fH1fti4lT4HR2XXvNwnU/doir2qvf3ZS6oSN8Jyd4xN/pqy3GEJcgPxYhrJ1ur3EXxNBAiOJK0XOB2jd05ondm4bizNeEoOz7bUgLHwH1MtS0Ex2c6G2b5M03oQBH3LOqgFTAXNm3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSU3J54r7dgAdI/2PQHvUM1mPddvIXRwT7fnScAQq7g=;
 b=Tqrrtub/gghkYJu/99hPcUc57EnbGGVVv1o9Utt8L6HEeXQpC/cM4b+wLKfVLdKUtRtzPRBjuEgXhtKzC8u6ZCKrhuMUl8+7+ot8y4twCNSqGjseNP1rWmOrPuDvg+baeaVfgRYsCBaLZ372Ky8iJQeK0/dyzxzTyYq3TajrLtCfallZSdY7XP9xyQL9Sko0ZqHP8TfVRx4npsaiYdumOlNMlxyQmnmojMtYEtAfQNO/4eGDOs9heUqTKXXJm3mR+kg2oFx7zvxaD6QAtnkySmd3sJAG6vmDPR5JuxDm7SfYrh9qw+NBVX6EeZ+F1HIyMPOSN4yFnbeUqvl6jOCDMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSU3J54r7dgAdI/2PQHvUM1mPddvIXRwT7fnScAQq7g=;
 b=bDO1MQPU0q0W9FCBFaXNk3ED4WqkUe5Z2896/RDGsw59J1e7avha0YbGTQGVcAWvDoXNG6yuZby5V3VKBW+14K4LI+nEVU+NdJMCe0ygInLxcXMy3FVRhx6g8Jkx1VT66XrFnSbBNLdP6SOEiZfNEY1BVg79tL3IjlM7cPhyUlo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BYAPR04MB5383.namprd04.prod.outlook.com (2603:10b6:a03:cc::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Mon, 30 May
 2022 15:37:46 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::e48c:b440:3098:a050]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::e48c:b440:3098:a050%6]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 15:37:46 +0000
Message-ID: <b0d41109-f306-f896-03bc-468e87982450@cornell.edu>
Date: Mon, 30 May 2022 11:37:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] Cygwin: Set threadnames with SetThreadDescription()
Content-Language: en-US
To: cygwin-patches@cygwin.com
References: <20220529140315.18306-1-jon.turney@dronecode.org.uk>
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <20220529140315.18306-1-jon.turney@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR13CA0032.namprd13.prod.outlook.com
 (2603:10b6:208:160::45) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a65bea6d-5425-4a8e-095d-08da42525880
X-MS-TrafficTypeDiagnostic: BYAPR04MB5383:EE_
X-Microsoft-Antispam-PRVS: <BYAPR04MB5383AD6A05CFB69962C73957D8DD9@BYAPR04MB5383.namprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FwlSYL+bKIhl0CmRir0garrJKRj0YWrdp8U5/fMLmm66Eyr97OVxRTmPW6MmmemFQvbW3EVEm5LZcB1gC0lg/JeGqhuLm43thpUnloZb66dQpdiGtoqPT8VvSXafSKX+lzQEXKFMwLySlivZ657Wtmb3sed760kP7BK6/nq5P6ApI8Lc/Fo6kSPmi+7FcetJw3YDmBvDDdV+d3KJQL26ZMGAIH/ol2eDPnVoQHnDPNIJuTp4fHmnpSsBhTQDve1Lq/eaxqkWs0uw0nbE+ATGvZ/2wUMNjhVb2A8ZlzJ6ktmNClhLrKaD614K1j2PTBg0cYkj5gv+nezvzYWpWipp+dlH9uhCaI7k7S+qN3olj4Xzscctu6+dgudCI8zHwRCggTcnaiqb4hkGHSXvPQtc4GllTlylSJ6E9knB2/GPkgpphyL8ybNazJ9Qylc/Gnu9rR9wUCYMdFYDvhSo1ZXgzspnOwjpNUptIx+lkT/U18RQ5uJRPF8WWbq9nAfP2AiA2B7Id8kTUq4M4DkSr7s1VcKq33Zb/qFzZp2+0rwpMglotfO6vIx82GVoCq5Ya3Ykzob1cbnLT1jzobsR/d8EufH5ys9+Utg+syp5qdu3VADj1CmkVolaVJNafRJYBbEL5cUdLWjcywmja99XhH9I6JYg4yK+PGtOKxWA/fF354fJyqt6G1eH3amscGqhcqZIS2AJSM3v5ODO3Ky1Zl+3HMFCJiVVYMGdIdAJJ4VRMZ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(6512007)(6486002)(53546011)(2906002)(83380400001)(186003)(2616005)(66556008)(66946007)(8936002)(75432002)(66476007)(8676002)(5660300002)(316002)(38100700002)(36756003)(31686004)(786003)(6916009)(508600001)(86362001)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHhqeUJIQ0o2RFcwZlJtUy9NVDdUTnJjNmptNDZPRkVDRVpLOGtrbkJBOFIy?=
 =?utf-8?B?T0xhbithUHZzNVBadEg1bmF1ZTNXS2Ztb2FYNnJXQkorOU5xeE85MGFDd1Y1?=
 =?utf-8?B?Y0l0UUpSc3h5MUJhdE9tSVIveUdGeEdhWjVWQWRUZExXUEltcld6WVRYdTFR?=
 =?utf-8?B?SkthYWxCVUlPQ1h3TG4yVjVueTVFWlFEYmtqRXppdklSQWRyd2J3Q3E4MTcx?=
 =?utf-8?B?S1kzZlZ5QnhCdXBZRVdPb3NPOXh6WDFQbFhVZ2h4SGQwKzk4RHNDOWhUdHhv?=
 =?utf-8?B?eXZwemJLOUZBcGZrMVlXOTNGdnNNdFhtRVFQb1BMU1JVN2ZXV1ZjdHdNeVMx?=
 =?utf-8?B?b0ExSDhCTzJoeHZpVlg4bHFTQ0ZyT0JVTEZnNUgzcERzZjQwOUIwdDFVM3Mv?=
 =?utf-8?B?RGUrekFhOTVzdCtVTWhtUFhpS3g3dkxPUzJUNTczREdVY1E4ZkJZbEorUGl4?=
 =?utf-8?B?QkZIN0VKeEFvbWM0Y0RBbWZmeFNiTk1velcwMjF5Mld6bytuQnN5TlRlK2g1?=
 =?utf-8?B?d0NjN2FZNk9OemZxWWpsMVIyYWh1TzhkNDBQMHlhQkcvZmlsTHpyUTR1b0w3?=
 =?utf-8?B?TE5NTEtINTh4Z1hnSHVkSkZ2Q3FwR1lvWndpdVVKVkZQUWxxRy8xRVpUV0o5?=
 =?utf-8?B?VWZLL0M4aCszVnNPRHRvRW5IWGJENGVhR0s1YW9ZZitta2RZNW1PTkVpZHNj?=
 =?utf-8?B?akNBKzY4eHlIdXBnSC9hZUtmWk1HRFM5aERjMG12VDJQSEFWZis4VnE1aTJV?=
 =?utf-8?B?dzdjQ0VGQlNEQTA5SnRkVzVDRHVFcFJ1OFNqVW1lVFREZ2JTSmMrcmVVUE5U?=
 =?utf-8?B?Q01Wa0Q4aHUvOGZIUHZCMEJja1FWNE9NQzhjbCt0ZFBxaW5IeE1iaW55anBi?=
 =?utf-8?B?Q2o2b2JDdjlDNUdvRFlwWmViZHRaOG9vMm1ndXZiUE4zdFFYNS9XNktwQUpI?=
 =?utf-8?B?R1Rxc01WL29UNkhBSm90RzVrOEVtOHd2R0J3Y1hkK3ZnZDdBUFdUSnB3NFhH?=
 =?utf-8?B?L2VUNURPMUtOSSt0aHFaYnlVeVZXTkVIdDczUlNiQnJ4eFpNbmFZOExsSDBK?=
 =?utf-8?B?WkM5dlNzTFY5Ulh6bFByNjM4eUxkdEZaVmdZeWs2NW42ZnZONmxReGkwQWg4?=
 =?utf-8?B?OVlCVm12dmlweWkrMDJkTVJsb25jNENjOUpMUlgzT1NSVmhoZU93NjhtZ1dp?=
 =?utf-8?B?RHFWc3MwMEtEWjVFUEV4QVpDTlpQYUcxdzJEeEw4NzdMYzJQMm92b2pCMkx5?=
 =?utf-8?B?NjJiMlZXZHN0dTdXRExJVUpNaFQ3UHQ4NXp2NytISU9Ma1kwWm03NWFtSGFT?=
 =?utf-8?B?UmI4a0IyUlU0SjliWE82VEUyMVFTUUdBRUFuVk5IK1NNcTVrcWlzQmJONVhq?=
 =?utf-8?B?Q3oyRFVSYzd5MVRHOHRQR1lkaG5DU2U4a1I1YzRPcDZZSW5KM1BEaHNRcGNJ?=
 =?utf-8?B?VVZFRXNBcWFBeEJqTlM1MEhSN1R2NTlGNVNGdVFNYmhHNm85VVI5Zlg1alla?=
 =?utf-8?B?T1FBcWp4M2ZSTUlSY3hHNzRqaCs2bndteGlkOThwdFVLZmRQbmY5MlB1QjJs?=
 =?utf-8?B?RmFFUk9wcS9PRVRmYnB0TFAzRkgxR0dFcGZpUE01aVhJWkt5YnljczZjd1Js?=
 =?utf-8?B?bUJzdmRwNjdacExDTWgvSUxjUXFKd0hIM25XeTErR2dEc29hSmJVbVVJQUlq?=
 =?utf-8?B?M3RXVFNnRDZwdGdIUnhxRnI0UkdoUDlpOWVCelB3bjhsTGVmYlJxOVgya201?=
 =?utf-8?B?aFJZZ0J6Um9oMENUcnN4bWlqZVI3TFBjbW9zeThENXFVeEh6MmdPY1N2a0hF?=
 =?utf-8?B?M0J3Q01sRDJ3RDM1K3NYTVAxZzVqVjZOY2ppRENVc2k3VVBNRHFMNmh4aFVL?=
 =?utf-8?B?YURONDhRTlJibSt0NUxlWjRFRjFZMHFyMWR1Y0ZCSWpDMlRldFRyekVXNW0r?=
 =?utf-8?B?dThNUWRjR3FPTVdjNkRVbDAxOEVnS2FrUURWdTNIdCtDYWFmNWVacGZubEk2?=
 =?utf-8?B?YlN1QkVhUmpOYldsTVMyajdabDloZlFNZjlJQUdtUUNmVGQvdDZhaDVGaHF4?=
 =?utf-8?B?SnFYcXZXL3ZrSnNNMDRwWTcwQkswOEhPMUY0ZjZNYmxpL1BpQmEzRkpnTk1p?=
 =?utf-8?B?NENuVGFvZjVQclU2b25jbldUMXVGNEJGS0pFWmE0MFhiUTJnZ0xMa2g5bjhX?=
 =?utf-8?B?TDM0Z1UvenUvZktHeWNnYjlFdjdKZUYrdjcwdmFrWTFkTDVhZGxrbHlXZXdv?=
 =?utf-8?B?UHR1Y1F4ZkVnNE5aRE9OcFZGcGZmQUpzSkZYWGV5ZlZXenowMHVjd0o3VE1p?=
 =?utf-8?B?akM0WXp3cTZYckNpSjFWY2tFc013MVZxNU95YUJkSXNNQXdTWnQ5RTJBRjFK?=
 =?utf-8?Q?yHk381ls+gbWhrM/Mh2ws+XkhziwjkzRnP+K64URFjDgj?=
X-MS-Exchange-AntiSpam-MessageData-1: Aa1yI9J85k70Lw==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: a65bea6d-5425-4a8e-095d-08da42525880
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 15:37:46.8071 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m8Xh/nD3FArl8xqMho7jUpUS6jkL8LvOnBtWOKq8ahH0ud/ww71VUvILPygj4XKr1RnxgTY/hslT5umYYxXSBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5383
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Mon, 30 May 2022 15:37:51 -0000

On 5/29/2022 10:03 AM, Jon Turney wrote:
> gdb master recently learnt how to use GetThreadDescription() [1], so set
> threadnames using SetThreadDescription() [available since Windows
> 101607] as well.
> 
> This is superior to using a special exception to indicate the thread
> name to the debugger, because the thread name isn't missed if you don't
> have a debugger attached at the time it's set.
> 
> It's not clear what the encoding of a thread name string is, we assume
> UTF8 for the moment.
> 
> For the moment, continue to use the old method as well, for the benefit
> of older gdb versions etc.

LGTM, except for a few missing spaces (see below), although maybe you did that 
deliberately since the existing code was already like that.

> --- a/winsup/cygwin/miscfuncs.cc
> +++ b/winsup/cygwin/miscfuncs.cc
> @@ -18,6 +18,9 @@ details. */
>   #include "tls_pbuf.h"
>   #include "mmap_alloc.h"
>   
> +/* not yet prototyped in w32api */
> +extern "C" HRESULT WINAPI SetThreadDescription(HANDLE hThread, PCWSTR lpThreadDescription);
                                                  ^
> @@ -993,8 +996,8 @@ wmempcpy:								\n\
>   
>   #define MS_VC_EXCEPTION 0x406D1388
>   
> -void
> -SetThreadName(DWORD dwThreadID, const char* threadName)
                ^
> +static void
> +SetThreadNameExc(DWORD dwThreadID, const char* threadName)
                   ^
> @@ -1025,6 +1028,32 @@ SetThreadName(DWORD dwThreadID, const char* threadName)
>     __endtry
>   }
>   
> +void
> +SetThreadName(DWORD dwThreadID, const char* threadName)
                ^
[...]
> +  SetThreadNameExc(dwThreadID, threadName);
                     ^

Ken
