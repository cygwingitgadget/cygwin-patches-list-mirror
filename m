Return-Path: <kbrown@cornell.edu>
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2110.outbound.protection.outlook.com [40.107.101.110])
 by sourceware.org (Postfix) with ESMTPS id 5CB0B385840A
 for <cygwin-patches@cygwin.com>; Sat,  9 Oct 2021 14:43:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 5CB0B385840A
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsofMNXwEaJWjGvX7IzXumjn8mm1Kt/suFUzxSAISXHTbAH2T88epRkgy+JGc23q8IBYFWrnNEXjnYISmfuR+o6gNEtd/qRGRwapm/XtbIIPF7mvqII6drSfu8lyN1wpJ1hlPRloPvjJavGDg7+NqzNfYD9SlF+z3pq+Fzm4+3ZalPMjp8VVKrxDAXyyx/werVmBt3INwoC6vAgg4QeaHcaSnNbWGBsYQaC1/6Ld+sTaP223TvsnLuREXs6Hx3TGGz3HnLRuV2vHe56u2W8t30UuG4aNiPEoQ02a6Nq475PFghFLEODaaVZZA43vB/j/jvxPYoEogz+iJLl3idfg3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5j7xjO4sBzv8ZlsYTsMzsFJP2MRjWPDAeI2XK/7V0yk=;
 b=Xh47OEEoEISRRSxUiWVH6P0czTURJjl+dK6Qr8v4GX0kBPOd0Q8rooxvIjgtHYNnHUJHqxePlxAoWPQfvWn9mmwu8m845AlIHZI+oBV5ZQQNzu7XerlFysuaUA5ai4W3H+YTaEuF8Vs5Ixi2/mF7H5pz9Fqu4LdX4ghhzfl9VZqgIpnnvrrZ/PfasCaC7N9S7spUo+8jNcjoTwgGXaSjRT7hdHmhpzsgwVBfZwP9v/QvMpVrNMJvzeIoHwevgGtK6ictI6/FxCpBQ/1ehe/OyQ9zP01E3r7wAcieEznEebmp2rBLOi+JayxKbrRTTB8t2wq9H5/qCJmwQQ6v/nQCSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5j7xjO4sBzv8ZlsYTsMzsFJP2MRjWPDAeI2XK/7V0yk=;
 b=BHIuAE2a4gR7FKziRBq1S6WQfWobbvNKSJOJ7IrhoxQm2acw0Ev4dtzTNNcfRsBVzIAohZpsBsFkmpH02hUmjSpQT3jLIl93Kn7P7+EA4qqf9glqBoP/k6DNH89RWVYP3L4MF+b92iWcqo7A9f3k8BvZWPReMKpoO+lhU4g0z/M=
Authentication-Results: cygwin.com; dkim=none (message not signed)
 header.d=none;cygwin.com; dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN8PR04MB5619.namprd04.prod.outlook.com (2603:10b6:408:a2::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Sat, 9 Oct
 2021 14:43:47 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::d1a8:b6b3:dfd1:b093]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::d1a8:b6b3:dfd1:b093%6]) with mapi id 15.20.4566.026; Sat, 9 Oct 2021
 14:43:47 +0000
Subject: Re: [PATCH] Cygwin: Make native clipboard layout same for 32- and
 64-bit
To: cygwin-patches@cygwin.com
References: <20211007052237.7139-1-mark@maxrnd.com>
 <20211008185210.cac713f28dea727a1467cf94@nifty.ne.jp>
 <29514de9-0d19-0d22-b8e1-3bfbce11589b@cornell.edu>
 <7dd31f61-43a1-4e4d-2e1a-dc79606263d5@dronecode.org.uk>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <037a8027-8969-df1e-ccb5-6a736578cec5@cornell.edu>
Date: Sat, 9 Oct 2021 10:43:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <7dd31f61-43a1-4e4d-2e1a-dc79606263d5@dronecode.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR13CA0037.namprd13.prod.outlook.com
 (2603:10b6:610:b2::12) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
Received: from [192.168.1.211] (74.69.128.111) by
 CH0PR13CA0037.namprd13.prod.outlook.com (2603:10b6:610:b2::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.5 via Frontend Transport; Sat, 9 Oct 2021 14:43:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41d4b769-7c6c-4071-afa4-08d98b333372
X-MS-TrafficTypeDiagnostic: BN8PR04MB5619:
X-Microsoft-Antispam-PRVS: <BN8PR04MB561977CC400E88F79B51A1BBD8B39@BN8PR04MB5619.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: njxN6MH9Gfh5tmYFPcrJokwCeHQCKbxKaNYllbzPlTZlaE6bUfn1E/k2tWCljtGC6W4FCWoY93S5YG/tEuqTisY3bWSSVMGOBJRxr4uTJRW8DUIonn54n4RGoQD+2TT7IwHGBSOJVtJY5f4MTfLTUYOUk3JgIPfBa0cLA5Fh+05iP8eG+24iqphjHJfH2wN/O8br33Wp7lzB08zLKY5j8sHolT8ZeoecfGoIN8XR6ReqeC0Bit49nn4rwRuOUJW6ZCOaC6uEV86Mrjrg4NTKWkQ9wpXgIx7RMuRBP583zDeez7i8ypx0zWwV5GSuYav/WFkLQuQmy+pTXzGur9W+1yuQJKf4+ybLDU2E+fQThwK9+8N+b3sC48NUrM6FmokvgCrMW/bXDgMZgjWxNxeNzgWqZlMIrvgGz9/+y8HKZK2ZduuwCLFgLAx43t1NlynmDkqqL8jPbHXJxiJvttuvfL7lYyLPZYZwKWtXR3j3emoXSzG5KztFeralHb0OidY7KIMkff4j7GUAMKhoTqcjZYUs5dzQ8p6UU56RSxUAXZi5PYEeD6cAWNdfPVbmcYphPBO53Wi3AlvqYLQkyDYdERXdHZZ2iDxQgmX1Ag9MNr/s2/Xz/9shul4quSLGxqyK4hkWsbukB+3jRS4mTY40zDIJf1hXqcbJl7t4MOwQcsrz23eIY/YB26KF/s+J8sfNYKB89kMhZIJCaZnx+fCkAU+VRPHeRJaDaFZd18nKrR58nRaAsb3ibZDet2Wd4e6W
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(53546011)(6486002)(5660300002)(31686004)(66556008)(66476007)(66946007)(26005)(75432002)(86362001)(31696002)(2906002)(16576012)(316002)(786003)(36756003)(508600001)(6916009)(186003)(2616005)(956004)(8676002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?40hTATjyCBnkuJbz+BUs/JI7ubMC8CwLDXVho+QytAGelBHYtgoTXVFb?=
 =?Windows-1252?Q?YgOl6Xp1M0qMn4C9gwdDhhTgB6AKML3SLuX1KyXlFOWawATFGCepIwml?=
 =?Windows-1252?Q?dHXKfaG5uTDcpzBP9MVVBv3tbWDkb2haVGxdaHoUkV8B8dckOBr6ME11?=
 =?Windows-1252?Q?m0rvRVOhFLKbtsL4A9sHLufFzOfJqTRIDyeXX9M+vWq3tHuk1GF8UqbF?=
 =?Windows-1252?Q?KJ6nRXjRLWnE+fKGhtgQBSyuPlj4fEnPR4o60nipM/Cq+/UvND3dlYkH?=
 =?Windows-1252?Q?ZQQrkRd50Zi+BuZPnPce+W/gVeEWPyFPwFx3BewCio7q3V3JGGDqCC6O?=
 =?Windows-1252?Q?D+IuBVcael+2EL5Gd/lkQ9Hm2t0YADS8KtFw5NwOzS6sofwgFchW7FHy?=
 =?Windows-1252?Q?zO6g4LMlBFWmve1iASqdAf3wWeualZdjHqZix7eznk3M2qnqHd4oXN1l?=
 =?Windows-1252?Q?dBoYqkukQYMcg2fzCcG5rABkVtkcSFlg78NFhI0BINMEgzDoTHTWzevR?=
 =?Windows-1252?Q?6Ekd+SPfHmclyKji6H9kaAQYYx3TFe8k39VZgYcYDYOEiFAy+wWVOuox?=
 =?Windows-1252?Q?6rL/z8W5r2rNdwGk6H0Fq+vn7sAFo6fn34iSZEVU+Yz03zmiMOqdBOrJ?=
 =?Windows-1252?Q?+86PLXf6I5XDYCLlJ6Ch6OFrX5I80dmcbbOuYCsUQG4vkQLUk8hmC3aN?=
 =?Windows-1252?Q?L1ur6y5W081fBYxu9AjubcEL3ql2waWR0CpcVUYMLTYLCiTG4ZPSmvAf?=
 =?Windows-1252?Q?25MIxxNO6HmzbIfMhIU3OBEADTxVo3UDSIHyxpNXLLqE41RuQ4mug575?=
 =?Windows-1252?Q?NoZQSbyjcS/Bl6vLwBOdO76EjaiFCiRDcR5WJYFlnf/N8CDaOlzRvpJp?=
 =?Windows-1252?Q?B+ZVC6LHsX3QwYtlqs1SMIncgL6IDfM7VFzLf1WngjqF9KIy9QCWoDfY?=
 =?Windows-1252?Q?lyY774NFgQ+1lT0aLIE+cDJf/YRu/3hb+WWX9SrwDk0WR3dO3c4IEfSe?=
 =?Windows-1252?Q?AjEwQ/tBseewJZCyZHxou7GgGqM4IvRt0X04QeuU7VCYDqR8w5cfwZrG?=
 =?Windows-1252?Q?FC0fG7K4BSpY7ms0ruLIyT51TbxU/x7sGTEX1SBf9pM4iF/PlDxKYVZK?=
 =?Windows-1252?Q?I5cSvNzp3jCholM28eMGbJw3ycGUjCfIMryDJNhx93rYZL2AwBL5Q39U?=
 =?Windows-1252?Q?rdbuQwvx0sA66sRN1kBYpm4MqriMEIfGtwC51wnX3FU/fFfbjzUSW+rN?=
 =?Windows-1252?Q?IHIOlJM44nddHPMBO22Als2lr9nj0caavGifBEr3cJn1+Rik9gyuJTmu?=
 =?Windows-1252?Q?cUHMBts4g0bvIN7BtRY0R7Wvi7WpYEicP301+a2CgP1OcN0EKqqZnSW5?=
 =?Windows-1252?Q?ePK1nOPAEaIc7XyjxlF7lEVWCM/YXXb6CfoKULT7xq0colhp523vFxoY?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d4b769-7c6c-4071-afa4-08d98b333372
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2021 14:43:47.3702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 249nK4TQFwxWnhPsQ8JevFQxtjA4CwKUHf30y2iKgxSeCSPNyPFf9xWweCDq7Dk0bMEBAUosx+KMNk5QqbPCdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5619
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00, DKIM_INVALID,
 DKIM_SIGNED, GIT_PATCH_0, KAM_DMARC_STATUS, MSGID_FROM_MTA_HEADER,
 NICE_REPLY_A, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
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
X-List-Received-Date: Sat, 09 Oct 2021 14:43:50 -0000

On 10/9/2021 10:29 AM, Jon Turney wrote:
> On 07/10/2021 06:22, Mark Geisert wrote:
>  > The cygutils package has two programs, putclip and getclip, that also
>  > depend on the layout of the cygcb_t.  At present they have duplicate
>  > defs of struct cygcb_t defined here as no Cygwin header provides it.
> 
> This struct should maybe be in sys/cygwin.h or similar, if it's expected to be 
> used in user-space as well.

Good idea.

> On 09/10/2021 15:19, Ken Brown wrote:
>> On 10/8/2021 5:52 AM, Takashi Yano wrote:
>>> How about simply just:
>>>
>>> diff --git a/winsup/cygwin/fhandler_clipboard.cc 
>>> b/winsup/cygwin/fhandler_clipboard.cc
>>> index ccdb295f3..d822f4fc4 100644
>>> --- a/winsup/cygwin/fhandler_clipboard.cc
>>> +++ b/winsup/cygwin/fhandler_clipboard.cc
>>> @@ -28,9 +28,10 @@ static const WCHAR *CYGWIN_NATIVE = 
>>> L"CYGWIN_NATIVE_CLIPBOARD";
>>>   typedef struct
>>>   {
>>> -  timestruc_t    timestamp;
>>> -  size_t    len;
>>> -  char        data[1];
>>> +  uint64_t tv_sec;
>>> +  uint64_t tv_nsec;
>>> +  uint64_t len;
>>> +  char data[1];
>>>   } cygcb_t;
>>
>> The only problem with this is that it might leave readers scratching their 
>> heads unless they look at the commit that introduced this.  What 
> 
> I think the solution to that is a "comment" like "we don't use 'struct timespec' 
> here as it's different size on different arches and that causes problem XYZ".

And the same for size_t.

Ken
