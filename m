Return-Path: <kbrown@cornell.edu>
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2110.outbound.protection.outlook.com [40.107.93.110])
 by sourceware.org (Postfix) with ESMTPS id 97FBA385043A
 for <cygwin-patches@cygwin.com>; Mon, 20 Jul 2020 16:11:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 97FBA385043A
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oer+/94GpaBko03KUcKPVvCJdvX+GvTIdHPLuHV97+ob9A4qZDAJqiGvQhG9kUqGr5HDIQQeS7ryRLtlD/NKo+qwb4/Tr+Pz4s4ZpThJInKvpvMhU0qKmrmzI++oPN2IsUNwKrvUO4GnwrQ8oCpA5UEsaLpyUxydZ8Kd99Itz3/NLawSSiMKpa6p0ul/A6sqLTvG/0FWSL6w0+g/5jNI+lfzn0+Z8wFaNKB7fXdEL4TOYsX1yuQv+uJwvPKuMFeZeJmHBiCZMKilFT3JOrhht7aZZ9hbDZ9G+bGsKfv2K4YxccaxoiWUs3RoPHFH29+Oy3VkAlffd2WDUKzhrPPBPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObIP+3Tg0vfkz7u4MzpVuUn5TRBHZ9D9YcB1gYn7eQ4=;
 b=RQ6yF5DD3gV4K5PClO6+GfuGKkBAeB78BRcLmEBFix+CIgaLdVWFrTVhbftVUkw8f3x10G9ypzNECDqMeTVRGLVjXaBauSUMb4I+9IDwm8hPA1zw5RgVj0e1b8IxYN2CEv74Gs6gdSXZccFGgwKV9JcDfsuJI6KbuHPZcdiWeLZgj580S+dSraXmNkEvQwQ+b+aKu6sNr4VQLVPgE0NSSqj/OUhGC8SQ3JdLB70ReFCILvLAaWKVxFyUAUEzB+dDKtttHcfNEQBXRsQ0VF905l05fBjGRP0mbzYsl4cmlc1miLwWn/KciPbm5Rnb+xTty9ibFnhVcKyBBRNwzpgrCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5616.namprd04.prod.outlook.com (2603:10b6:208:a0::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Mon, 20 Jul
 2020 16:11:07 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a%7]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 16:11:07 +0000
Subject: Re: [PATCH] Cygwin: mmap: fix mapping beyond EOF on 64 bit
To: cygwin-patches@cygwin.com
References: <20200720133442.11432-1-kbrown@cornell.edu>
 <20200720142303.GJ16360@calimero.vinschen.de>
 <ceb31948-ec43-3bf1-a164-53b54828535f@cornell.edu>
 <3d3597af-7bb8-bc83-2522-9282566f80b8@cornell.edu>
 <d1ac7543-34a2-90c6-07b4-96d90142df34@cornell.edu>
 <20200720154139.GL16360@calimero.vinschen.de>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <26f08cc5-5a0c-c291-da1e-71029f3a12b6@cornell.edu>
Date: Mon, 20 Jul 2020 12:11:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200720154139.GL16360@calimero.vinschen.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:207:3c::22) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2604:6000:b407:7f00:b097:c784:8595:264e]
 (2604:6000:b407:7f00:b097:c784:8595:264e) by
 BL0PR02CA0009.namprd02.prod.outlook.com (2603:10b6:207:3c::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17 via Frontend Transport; Mon, 20 Jul 2020 16:11:06 +0000
X-Originating-IP: [2604:6000:b407:7f00:b097:c784:8595:264e]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1010e56-d09a-4a72-7b8c-08d82cc78253
X-MS-TrafficTypeDiagnostic: MN2PR04MB5616:
X-Microsoft-Antispam-PRVS: <MN2PR04MB5616B70BCD15E9942D3AD080D87B0@MN2PR04MB5616.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fo/3Iivjd/+RPy92O29crEjv3Z6XetM00oXhvU+UNRIC6Xv+suD0Ih5SRs7kwyQU7CKVLNgz/t9+1DNuv2S+FutDNg3J6N/IZS7IasBIqMIvPwevrc8hm0y3BsBLLGAG2TYGCyoLyiLBJ3bBJwIRdKXQvhvQ3YoTscPkrADEetYkoFMyTL5xojLFh2gHWgecaNq0syTkoyjC93/++dCheo5xq1USUmsI/mFimFrl3vYGbmSwhXhAvMVYFUUGHM0ranOQA7XqMZD8POTRkColXttjJLq/8fE4wr9MHceMIygPMxDeIrYopfRiFiMGFyRZR2Js7vnQJgr0dzCswEb9AZn82CFt+nJJVj92QVCO4h1uCCHLMQynoa8Rg9C0GQP9/3tJ1p9+2I5dyyFz3jSK54TU4jGbVBF5P/paJFmFsy+1rWa0IBkY3ZvAJ9/SupHk0ZiwtxY/CphmzWbO5/qrOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(2616005)(53546011)(86362001)(6916009)(83380400001)(31686004)(75432002)(8936002)(316002)(6486002)(8676002)(5660300002)(36756003)(16526019)(31696002)(2906002)(52116002)(478600001)(66556008)(786003)(186003)(966005)(66946007)(66476007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: wuaEByoHESOYkhs300RC0oyETuR4SFwCIlGj6rErHKCBe5HWlsbN0HwJRkpmeqMEPNny3frt+nkPQAxFpW+yffC74KXFYlOrSiA8MD4RNjvTrLrVTFS6gpoEMtTVOhPxo8fqP3MdunFBd6jI89zsyx20SMqC3XV8SJoiOgZ5Mpl58Jyc4B0lOCd5xTiDAaHVgQvShPcC3QGERff6KZpgYs20q/QrH83836DRcvrkEX8U0PwhO3pX8bLzG4ak2MtQHesWEquaAqTyZBlnfFP4tDgKC5cnM9+06C1AJ9jldRxX3fJej9UMcyYJeQelFAAUaiAWJtmRK5/9qZTz9z8poK1L3xIX7dr8U+bky6P2B3LAKNoQTLyxFftEW9eXFH99ko4AiaLYLghXgfXMSlUjxJiL0YfRSEh1fGFfWyAGSrDACGx3EBSb+QRXmsNl3V7r7IOXOVUmpDUSHUCZj5oyqHBPmR3fZUXnTHTWkNapNAJQOv1tLihP8khOWQ7jB5/X9BBVKf+XuWzOthqKyImQrP25mwe4UEC6NXu4T8wEl9E=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: c1010e56-d09a-4a72-7b8c-08d82cc78253
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 16:11:07.2166 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W0xGbANG81rppIe6WTNcEPvqzoCYV/cwVMzSfDt77Gf5I11fGppt+k3dewMbsLRILyrbA2VZ3v5R26gLrvH8qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5616
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00, DKIM_INVALID,
 DKIM_SIGNED, GIT_PATCH_0, KAM_DMARC_STATUS, MSGID_FROM_MTA_HEADER,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 20 Jul 2020 16:11:11 -0000

On 7/20/2020 11:41 AM, Corinna Vinschen wrote:
> On Jul 20 10:58, Ken Brown via Cygwin-patches wrote:
>> On 7/20/2020 10:49 AM, Ken Brown via Cygwin-patches wrote:
>>> On 7/20/2020 10:43 AM, Ken Brown via Cygwin-patches wrote:
>>>> On 7/20/2020 10:23 AM, Corinna Vinschen wrote:
>>>>> On Jul 20 09:34, Ken Brown via Cygwin-patches wrote:
>>>>>> Commit 605bdcd410384dda6db66b9b8cd19e863702e1bb enabled mapping beyond
>>>>>> EOF in 64 bit environments.  But the variable 'orig_len' did not get
>>>>>> rounded up to a multiple of 64K.  This rounding was done on 32 bit
>>>>>> only.  Fix this by rounding up orig_len on 64 bit, in the same place
>>>>>> where 'len' is rounded up.
>>>>>>
>>>>>> One consequence of this bug is that orig_len could be slightly smaller
>>>>>> than len.  Since these are both unsigned values, the statement
>>>>>> 'orig_len -= len' would then cause orig_len to be huge, and mmap would
>>>>>> fail with errno EFBIG.
>>>>>>
>>>>>> I observed this failure while debugging the problem reported in
>>>>>>
>>>>>>     https://sourceware.org/pipermail/cygwin/2020-July/245557.html.
>>>>>>
>>>>>> The failure can be seen by running the test case in that report under
>>>>>> gdb or strace.
>>>>>> ---
>>>>>>    winsup/cygwin/mmap.cc | 1 +
>>>>>>    1 file changed, 1 insertion(+)
>>>>>>
>>>>>> diff --git a/winsup/cygwin/mmap.cc b/winsup/cygwin/mmap.cc
>>>>>> index feb9e5d0e..a08d00f83 100644
>>>>>> --- a/winsup/cygwin/mmap.cc
>>>>>> +++ b/winsup/cygwin/mmap.cc
>>>>>> @@ -1144,6 +1144,7 @@ go_ahead:
>>>>>>         ends in, but there's nothing at all we can do about that. */
>>>>>>    #ifdef __x86_64__
>>>>>>          len = roundup2 (len, wincap.allocation_granularity ());
>>>>>> +      orig_len = roundup2 (orig_len, wincap.allocation_granularity ());
>>>>>
>>>>> Wouldn't it be simpler to just check for
>>>>>
>>>>> -      if (orig_len - len)
>>>>> +      if (orig_len > len)
>>>>>
>>>>> in the code following this #if/#else/#endif snippet?
>>>>
>>>> I don't think so, because we also want to use the rounded-up value
>>>> of orig_len further down when we set sigbus_page_len
>>>
>>> Actually we first modify orig_len in 'orig_len -= len;' and then use it
>>> to set sigbus_page_len.  In any case, I think it needs to be rounded up
>>> before being used.
> 
> Oh, right.  Now I see what you mean.  At this point orig_len is still
> the actual exact size of the file.  We only can create the SIGBUS
> pages starting the next allocation granularity, so, yeah, it makes
> sense to align orig_size to allocation granularity here.
> 
>> If you agree, maybe I should modify the commit message to make this point clear.
> 
> Might make sense, yeah.
> 
> While looking into this, I found another bug.  The valid_page_len
> is wrong on 32 bit systems as well.  That was supposed to be the
> remainder of the allocation granularity sized block the file's EOF
> is part of, but
> 
>    valid_page_len = orig_len % pagesize;
> 
> is the size of the file's map within that 64K block, not the size of the
> remainder.  That should have been
> 
>    valid_page_len = pagesize - orig_len % pagesize;
> 
> so this didn't work correctly either.
> 
> Ultimately, I wonder if we really should keep all the 32 bit OS stuff
> in.  The number of real 32 bit systems (not WOW64) is dwindling fast.
> Keeping all the AT_ROUND_TO_PAGE stuff in just for what? 2%? of the
> systems is really not worth it, I guess.

I agree.  It complicates the code with very little benefit.

Ken
