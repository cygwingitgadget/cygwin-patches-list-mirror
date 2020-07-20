Return-Path: <kbrown@cornell.edu>
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2136.outbound.protection.outlook.com [40.107.244.136])
 by sourceware.org (Postfix) with ESMTPS id 0C9B33861031
 for <cygwin-patches@cygwin.com>; Mon, 20 Jul 2020 14:58:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 0C9B33861031
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRE/jMqjyJAk5V3gK8Wiww197rjsovsjUEQsVVy9tdaPkK42ddLvZa2VOR6Qa5yeYM6Yw/7U/uHvQtC4JqaxOdbMXhGACp1LmTnQRh/sXKf/GI+P5g6puX7Bl54FG1X8oEkfF9TxZcRaGxf4jERRtT5yGeVTZLyNyp9JWgPP+QqRxFnHKPxCPp8wZsA0xOUJ89TqDJXuxSW+p6zIPaXOzjgTo/vxJMXtUhqJpgwqVOPs4RGUdfUepc5wfiss2mhiOvrWfxWze3ohEVCIfdSY254V/QyiWsJNRXvcC9VQt5A2CH2pJGVvMBMXsw/WCXve0Sop69H24bCAhOX2C2LA+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2GjSSx3AiS0eDZuRfzSskx2jojafUlYo82Zn/ZIpeg=;
 b=MZhDoZuXxrKQbkoYgEpouPlT5E1TxnWAQXVOzQKSyJFfWzdqKXtd9xu3ULIRalCNAzzkXWrRfSN2adLWX7aFpQReB68KExtJD8slYKyNI5AuA7R45qgZ/zXa7qxfJuoFGOi/8fh00NsgDNYcwV7ZcWDT20Y8cVeGXkm8YWMNZyMfA98u6LLtNdTVFxSnhizEe/0r70T+8GkLSvG5Tug7lsh/fmyzmjFKKlKMdOf+KNbBJk33nCiYN/OGhWQFh34pwyJA4QDwp85XTD6KEiGEjWFfB/QK8PIXzNdr2BFrj4h2FQhQ9hZTkLM2oJsPemdIQxrd68IQzw5fJ/Lr/aCdNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB6189.namprd04.prod.outlook.com (2603:10b6:208:d9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.24; Mon, 20 Jul
 2020 14:58:41 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a%7]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 14:58:41 +0000
Subject: Re: [PATCH] Cygwin: mmap: fix mapping beyond EOF on 64 bit
To: cygwin-patches@cygwin.com
References: <20200720133442.11432-1-kbrown@cornell.edu>
 <20200720142303.GJ16360@calimero.vinschen.de>
 <ceb31948-ec43-3bf1-a164-53b54828535f@cornell.edu>
 <3d3597af-7bb8-bc83-2522-9282566f80b8@cornell.edu>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <d1ac7543-34a2-90c6-07b4-96d90142df34@cornell.edu>
Date: Mon, 20 Jul 2020 10:58:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <3d3597af-7bb8-bc83-2522-9282566f80b8@cornell.edu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:610:59::14) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2604:6000:b407:7f00:b097:c784:8595:264e]
 (2604:6000:b407:7f00:b097:c784:8595:264e) by
 CH2PR03CA0004.namprd03.prod.outlook.com (2603:10b6:610:59::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17 via Frontend Transport; Mon, 20 Jul 2020 14:58:40 +0000
X-Originating-IP: [2604:6000:b407:7f00:b097:c784:8595:264e]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 742cdd2e-f057-45d0-4024-08d82cbd63ac
X-MS-TrafficTypeDiagnostic: MN2PR04MB6189:
X-Microsoft-Antispam-PRVS: <MN2PR04MB618914379C9E1B63A189568CD87B0@MN2PR04MB6189.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PY0sbTEKUnFrQjS9Rm4BQdKajpAgKdSDW9cFZ5sLX3yqHaYSyicSr1mpYVsZnH8Hg3frTG0akQKcTS6x2dPP9j0fgrpUDfTIz0As6/WvgKmTInAqsTbjNJcG51MTbdXcM6IcQheUqPbD1SdBBoJ34fScxr0wcO2ROb9f9WA2F4tvIC58+3Spy6Sw3f9YlwD/wgTzkw2fr8ySIkY8tPKlDVFcb0sWzS8/oNnD+LCjEQPNGf58EpoCDiQRHszZPDW0uEyyBC1xsh+uyx1FoKZN1SP5mELALBDey12aZK3iE/CM7sTsaSIQ0H0oHvShNSSbtU2B7CY0zbnE+JmVDQHntqUykxBXZBESdMgjNyDUBSVMpkQESDIm2U/JJmv7HSxKHiBAv5uqqO+t5s8MF2NIkaqMuLLIVJ4vqQ4W/xc1SLZQrT8dFtPxKLVyLCGcynfj/Jx4aOs95fqNR74+kPSeEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(83380400001)(6916009)(75432002)(16526019)(66556008)(5660300002)(36756003)(31696002)(86362001)(6666004)(478600001)(52116002)(966005)(786003)(8936002)(6486002)(2906002)(66476007)(53546011)(31686004)(186003)(316002)(66946007)(2616005)(8676002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: rGPwk2liwLx9bAWXHqHGsYrj0HyjRcVu8De2uW/ISxIwjjVKUhkMOFn0BOF6yQlU6F3xELqy3c8XYED6jWfRsw/q6TvwjZCtFgQ8esWHN7bOZNwIwVLO2sjXisk/gVpZL1D/nN7kwW3E1NkmoNulZaKdZXUngXhN3oL96EkqxpNGiuMvvWeZST67jurZxuwg5e7OOfwqP9r4DXB0KtxpRAV+B+brn3t4adkdawAMcLjKUjBkuMiWAks7WIn0uc3nQegup9EaHHmwMn5UkVb0YpddgS9MChfjP05C37fjb/ld28Zb60qSVACfxWSwO8zrXeevD2mOBYHvslgBCRwJlmZH01txuHR/Rh5w7cXuHLqRFexBI9Qh0gRibyu8uIpHNUaZMGR350TYm9tG0w+Dg/VuIZsZ3OJaiTaAyhsGYi1ntoWH7kbpdAkzBAI2zMdHLZmXvV3s1mDJc8W8UMogBpwrqwAirc++9Ve5cs72w/8NSScyUIBtdTpsgAomDrgw+j0V/JnGpNljiObffQj/+B7ZqgW9f9YDR24lj75QF+g=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 742cdd2e-f057-45d0-4024-08d82cbd63ac
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 14:58:40.7987 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xtT1/3I+M1x+XRUgfjgdLlacwD8Nz7f87FPkDbcmZiw4JbE634vJW+ijSugsV9FFDqEkBPzWRwZpbnrPUilLIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6189
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00, DKIM_INVALID,
 DKIM_SIGNED, GIT_PATCH_0, KAM_DMARC_STATUS, MSGID_FROM_MTA_HEADER,
 RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
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
X-List-Received-Date: Mon, 20 Jul 2020 14:58:45 -0000

On 7/20/2020 10:49 AM, Ken Brown via Cygwin-patches wrote:
> On 7/20/2020 10:43 AM, Ken Brown via Cygwin-patches wrote:
>> On 7/20/2020 10:23 AM, Corinna Vinschen wrote:
>>> On Jul 20 09:34, Ken Brown via Cygwin-patches wrote:
>>>> Commit 605bdcd410384dda6db66b9b8cd19e863702e1bb enabled mapping beyond
>>>> EOF in 64 bit environments.  But the variable 'orig_len' did not get
>>>> rounded up to a multiple of 64K.  This rounding was done on 32 bit
>>>> only.  Fix this by rounding up orig_len on 64 bit, in the same place
>>>> where 'len' is rounded up.
>>>>
>>>> One consequence of this bug is that orig_len could be slightly smaller
>>>> than len.  Since these are both unsigned values, the statement
>>>> 'orig_len -= len' would then cause orig_len to be huge, and mmap would
>>>> fail with errno EFBIG.
>>>>
>>>> I observed this failure while debugging the problem reported in
>>>>
>>>>    https://sourceware.org/pipermail/cygwin/2020-July/245557.html.
>>>>
>>>> The failure can be seen by running the test case in that report under
>>>> gdb or strace.
>>>> ---
>>>>   winsup/cygwin/mmap.cc | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/winsup/cygwin/mmap.cc b/winsup/cygwin/mmap.cc
>>>> index feb9e5d0e..a08d00f83 100644
>>>> --- a/winsup/cygwin/mmap.cc
>>>> +++ b/winsup/cygwin/mmap.cc
>>>> @@ -1144,6 +1144,7 @@ go_ahead:
>>>>        ends in, but there's nothing at all we can do about that. */
>>>>   #ifdef __x86_64__
>>>>         len = roundup2 (len, wincap.allocation_granularity ());
>>>> +      orig_len = roundup2 (orig_len, wincap.allocation_granularity ());
>>>
>>> Wouldn't it be simpler to just check for
>>>
>>> -      if (orig_len - len)
>>> +      if (orig_len > len)
>>>
>>> in the code following this #if/#else/#endif snippet?
>>
>> I don't think so, because we also want to use the rounded-up value of orig_len 
>> further down when we set sigbus_page_len
> 
> Actually we first modify orig_len in 'orig_len -= len;' and then use it to set 
> sigbus_page_len.  In any case, I think it needs to be rounded up before being used.

If you agree, maybe I should modify the commit message to make this point clear.

Ken
