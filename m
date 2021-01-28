Return-Path: <kbrown@cornell.edu>
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2116.outbound.protection.outlook.com [40.107.244.116])
 by sourceware.org (Postfix) with ESMTPS id 252223857C7A
 for <cygwin-patches@cygwin.com>; Thu, 28 Jan 2021 22:28:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 252223857C7A
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/xH1pBOKFEgBYxmC+kRx/U1k+9xh1eMXF9wZodN7rYVkYO4hfYQPdx8ufA5azbU9G0hL49LVimeIEpD1TvFQbu33G44EfxOe7Rp6BHkVnJSNzoX4MwzCd6czSAusnS/+JfiTSEo5ryijuzyatb61Bq98vcKgGjkmw8V577msUAgMrysSVhwz+AjmCVLghOnLXr6yBl2PDHiBzp5mmDS8jxDYsnArNzDDf/mDmhzITax5oHPW73HQ+sv5aZO0ucSzEDe9mlMvvjjTsLsjl5v1F3N2Qm5fPfhhDuj6Kit/yOyTHYiUD6Srer9OkVk9MtSPo7vikgzNi0u2J1njaCIcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4us4Hz2mqchmJ4sxNWl9eYaj+bIvXu57Xp7911M5jE=;
 b=jt60HXdOGUBRtYrE0mKjilgsMTPK44ciQSi3E2Y211+uFEFIy/aZnIq6OgM+RCWAMcG6OV/1m4L3L7m8qKsAhUtFJm1n7HNYETh89I3U4yRkzzZNrjsr+sFltb2zxwPgusscIWercESpgRbTh0bEUq45wmB+Ev+ym1P/LedUVeFC53sXcSP7FM8QnT6VR+BH1aH8Ju3nHTtWzEk0XNDjhbYMAv/9S8fmkIiwTc4kqnVYbPY9FhP3gIuB9vjm3dlHybIl/JN6qIIhqtiyNKB+h17SvIIHdL2aPAjLNU8WTE0i5LA810LayrwY4AkHdWrLLJk4GCb8TxrdjbxEa3a1fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN6PR04MB1029.namprd04.prod.outlook.com (2603:10b6:405:3c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.13; Thu, 28 Jan
 2021 22:28:57 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%6]) with mapi id 15.20.3784.017; Thu, 28 Jan 2021
 22:28:57 +0000
Subject: Re: [PATCH] Cygwin: getdtablesize: always return OPEN_MAX_MAX
To: cygwin-patches@cygwin.com
References: <20210128025150.46708-1-kbrown@cornell.edu>
 <20210128102029.GY4393@calimero.vinschen.de>
 <151a4199-92f2-43aa-dd91-5d86c2e1d3c6@cornell.edu>
 <20210128160749.GB4393@calimero.vinschen.de>
 <20210128161304.GC4393@calimero.vinschen.de>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <a4cd3c3f-d217-026a-3cce-b29187ecd1e9@cornell.edu>
Date: Thu, 28 Jan 2021 17:28:54 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <20210128161304.GC4393@calimero.vinschen.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [65.112.130.200]
X-ClientProxiedBy: BN6PR11CA0048.namprd11.prod.outlook.com
 (2603:10b6:404:4b::34) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.13.22.4] (65.112.130.200) by
 BN6PR11CA0048.namprd11.prod.outlook.com (2603:10b6:404:4b::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.16 via Frontend Transport; Thu, 28 Jan 2021 22:28:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ef42071-a092-4758-4f04-08d8c3dc19f4
X-MS-TrafficTypeDiagnostic: BN6PR04MB1029:
X-Microsoft-Antispam-PRVS: <BN6PR04MB10297B5599A4847C84275753D8BA9@BN6PR04MB1029.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uavXk0frtcvsos7kBbCDtY5M3VejRAX1vmQmpJ4LKjL6Z0IWQ/K7IsUJkfx2lylZ9e274stt44RNp/HFX5jWQBIZoESDWBG8KG8BPGHnSkhROSkGxH4k6bKJk2LvA8NcMjCwmBzFy0wdwACblY2ux8f1A27oHcW7+EcYwD6OoP2EgyMjbSbNurR/pyZNgEwOZSGgA0H6UZxnYQoyMjzqypzftgx4YV20e3blElAI1vKEczWN8V4Di4lriQbi5aN3ltLtupevyWa430Fvfc9BjgkG5LIzOpz85Z8dQcqnsMlYX9YMechoP8/pwHdHMxlQAQJ/0QNCWQsCq004N/pjMqiN/OWQFMUXlxqgSUNzKR+7DaxLY7zh727Ig+qV+wME1D8EZ5cDBwv33Xebuiq/NGaeyW8UhZyC/0fR9h/H8QcW7s917JNpXH9JXxrfFvCM5nFraWEv0N+RcZj/G7tpWNLU4zqjsqD2F8ILfBZEZ4K/OAwnpqpOCfOSJg9kG7X1ILA1IDwEKu8/TIK4oQyX0/zhKfBHijtHB6Z8JDj53wiJnWHOGtJ9S0SSSkA4c+cUyngLJsS3IUaS1pE06Eg2vY1Nwn6pRwUZm57yZg1JinE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(16526019)(52116002)(66946007)(2906002)(6916009)(8676002)(66476007)(31686004)(786003)(6486002)(75432002)(2616005)(53546011)(66556008)(86362001)(16576012)(316002)(5660300002)(186003)(956004)(36756003)(8936002)(31696002)(478600001)(26005)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?Y6JYaB7VWYGcsPBR1ipg2/GykOEpbP0gye8yzIDL2fItUFvs/z5mcvJw?=
 =?Windows-1252?Q?Cw9QYgTua/unep0GtnO3o9sPTn3C+hAzMUCO8FEDqeBJVfpYnKhaU83B?=
 =?Windows-1252?Q?sjyI05RZLowq9/QDH7O5weJ4b8xra3BWpDS/ZsBlz3hwcHAjzhVdR4SK?=
 =?Windows-1252?Q?8u8Jta+7P5fwxvpWAaUqSZTNuLugLCMxI6UowmStGFYoB6uarBrTM7AR?=
 =?Windows-1252?Q?GGuidBxii6RTOe8LxneAz3ubGi/fIpOk0LACthtVTNxGRhA6hx4+s+DH?=
 =?Windows-1252?Q?We6JJYDcW7+Up+i4g4PCsg654D/1VCMSGbFAdbv9AT2eiyUYgT/32KUE?=
 =?Windows-1252?Q?tdaG2hsvgsK+5rG99+N1NFYBnI7IHSODiRZHcPMFzyunJ/WMhEkxXwRc?=
 =?Windows-1252?Q?e90YOecFizbiX9mO42h0GwGcsAcAb+8F47cwIfM4ZUDHxlYsv047wUcJ?=
 =?Windows-1252?Q?ZDvi4c9uEQhJA6eOzvclFQLYu0P6vQvZuU0BUaVInUcOC6gwBJX8M4dN?=
 =?Windows-1252?Q?NjGFey3JZyTR+Sjl5rvIWCNhlO3E53LTFhJ7Ju/J+8vQ4yvZj+EZa+Pm?=
 =?Windows-1252?Q?oiu+l5/OEtEEmFTrFdSa734unk4MWFWbVzw7bHxhMB6Hq6PpgBH8sDEl?=
 =?Windows-1252?Q?DokUo31RtRYvQK+MeR9U1YkTnOj1HzSdldGkzh5VaHnvQj+oxFKpHkRP?=
 =?Windows-1252?Q?2a5Vi8u8wdS2y/SpG13CBcJ0qx/0kvYzKpBbJGdl3rdR/zZf+VavVKva?=
 =?Windows-1252?Q?8hpW7hjr16XN381JCcPdACEDyhiRwp0OC9ZT2RQHAnbMelwaYKv74MJM?=
 =?Windows-1252?Q?ADRASgAvyRt1xdnVbhSSHbjE+AamfXpFqaBnkJHdClB1Z1kT+ola5ekM?=
 =?Windows-1252?Q?YneMH/vo0+HsJbkumZwLzNf/1j+z/2Kzx+jjNyRjlDVQdwuvWmDdwb3+?=
 =?Windows-1252?Q?ylYb47faPI6i33cVSlIG8mMYU8cQW9bTHs5F7QbQbf3N/6xWIqTFG2q6?=
 =?Windows-1252?Q?zEWk9KBowCailhKDw3Iuf/Gno05s1R+yzVQBk2CmXAlPhRsqRG0lu0ti?=
 =?Windows-1252?Q?G7leleiZ8y5lJa/3lrr1CDam89usVHMuUm5fmGql+tAWm5J+ZokMoH3n?=
 =?Windows-1252?Q?1rkzzuy6l4ABe94wsW1GVWNy?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef42071-a092-4758-4f04-08d8c3dc19f4
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2021 22:28:57.1836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vhrtdkf3bs+aYsVyv+arbNrqIjlwstvSowQvybV31Ugzf85hJLkLZ5YNO15UmwefWdVfFAhfdPgRYSv92kbjEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB1029
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, MSGID_FROM_MTA_HEADER,
 NICE_REPLY_A, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Thu, 28 Jan 2021 22:29:00 -0000

On 1/28/2021 11:13 AM, Corinna Vinschen via Cygwin-patches wrote:
> On Jan 28 17:07, Corinna Vinschen via Cygwin-patches wrote:
>> On Jan 28 08:42, Ken Brown via Cygwin-patches wrote:
>>> On 1/28/2021 5:20 AM, Corinna Vinschen via Cygwin-patches wrote:
>>>> On Jan 27 21:51, Ken Brown via Cygwin-patches wrote:
>>>>> According to the Linux man page for getdtablesize(3), the latter is
>>>>> supposed to return "the maximum number of files a process can have
>>>>> open, one more than the largest possible value for a file descriptor."
>>>>> The constant OPEN_MAX_MAX is the only limit enforced by Cygwin, so we
>>>>> now return that.
>>>>>
>>>>> Previously getdtablesize returned the current size of cygheap->fdtab,
>>>>> Cygwin's internal file descriptor table.  But this is a dynamically
>>>>> growing table, and its current size does not reflect an actual limit
>>>>> on the number of open files.
>>>>>
>>>>> With this change, gnulib now reports that getdtablesize and
>>>>> fcntl(F_DUPFD) work on Cygwin.  Packages like GNU tar that use the
>>>>> corresponding gnulib modules will no longer use gnulib replacements on
>>>>> Cygwin.
>>>>> ---
>>>>>    winsup/cygwin/syscalls.cc | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
>>>>> index 5da05b18a..1f16d54b9 100644
>>>>> --- a/winsup/cygwin/syscalls.cc
>>>>> +++ b/winsup/cygwin/syscalls.cc
>>>>> @@ -2887,7 +2887,7 @@ setdtablesize (int size)
>>>>>    extern "C" int
>>>>>    getdtablesize ()
>>>>>    {
>>>>> -  return cygheap->fdtab.size;
>>>>> +  return OPEN_MAX_MAX;
>>>>>    }
>>>>
>>>> getdtablesize is used internally, too.  After this change, the values
>>>> returned by sysconf and getrlimit should be revisited as well.
>>>
>>> They will now return OPEN_MAX_MAX, as I think they should.  The only
>>> question in my mind is whether to simplify the code by removing the calls to
>>> getdtablesize, something like this (untested):
>>
>> But then again, what happens with OPEN_MAX in limits.h?  Linux removed
>> it entirely.  Given we have such a limit and it's not flexible as on
>> Linux, should we go ahead, drop OPEN_MAX_MAX entirely and define
>> OPEN_MAX as 3200?
> 
> ...ideally by adding a file include/cygwin/limits.h included by
> include/limits.h, which defines __OPEN_MAX et al, as required.

I'm not completely sure I follow.  Do you mean include/cygwin/limits.h should 
contain

   #define __OPEN_MAX 3200

and include/limits.h should contain

   #define OPEN_MAX __OPEN_MAX ?

For the sake of my education, could you explain the reason for this?

Thanks.

Ken
