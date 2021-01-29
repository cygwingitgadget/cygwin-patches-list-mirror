Return-Path: <kbrown@cornell.edu>
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2137.outbound.protection.outlook.com [40.107.243.137])
 by sourceware.org (Postfix) with ESMTPS id BD6E338708C5
 for <cygwin-patches@cygwin.com>; Fri, 29 Jan 2021 19:23:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org BD6E338708C5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUGj/sPGTNZ51d4s/geSVAdiB5Iu02BQf0nRGBWT61QbC8TkpFcMlYnuG0h85CDrHRzPwitJDAuupP1xNq/LOVrWvWqc/iH6DDhxnQiH5Gwlho3Nj3QzI18W6fXaN/RqJgdOgdNVR4vsAwng6kawcRaqGOmtpc8BlYYLiwg9oj9OBDZcRwXdR//LXc/+tyR94wUjs+ShGnil2wVVfbF1YJ7s2nswSeopqHr60j+BGLS7eQl5m8IR0XmHSLeQ4+bY8bS6a00WCW8SCJsKVxdnbGEK63tSu1/o7F38qIAzVM6vGgY3R1+LZOZTHMBQmcbD6PROF0VNtSPW+rqSkki8Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8xHemYS+D3KX/8+CZeeUEWVxplCOuZyeaNCgl8r1BI=;
 b=KwyawijWjcvJc7zKAL4VZP6fy/SMK0Wzp6FRKX25F0wOW8ukp+0nL0eqXfkg5xRg4JVPhLWxK8RcS3MbvWFgHOfTCnMtXe8pW7JQCRLWuH+UJwB9W0JF7qXF8Yw3Fvzvf7OSaeUXMgwroapoUPaWKZonBG5sJQykq08MHnh8qid/a5JDqHxuTBTtpY5dPQHflIwKSNBnivTPhmWACRXLuINPgnPzgq18JGBnl+O4+UbhtYXu+vi0ja2rddKe8qDqDGj+QkLBRMV1FcY+Aq3QMBNeU3pwYas3pzE3et85TBaQf/w3/yI155/a/c3knOlKjeCW23a6JSbGmrpn/pYyIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN8PR04MB5715.namprd04.prod.outlook.com (2603:10b6:408:74::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Fri, 29 Jan
 2021 19:23:24 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%6]) with mapi id 15.20.3784.017; Fri, 29 Jan 2021
 19:23:24 +0000
Subject: Re: [PATCH] Cygwin: getdtablesize: always return OPEN_MAX_MAX
To: cygwin-patches@cygwin.com
References: <20210128025150.46708-1-kbrown@cornell.edu>
 <20210128102029.GY4393@calimero.vinschen.de>
 <151a4199-92f2-43aa-dd91-5d86c2e1d3c6@cornell.edu>
 <20210128160749.GB4393@calimero.vinschen.de>
 <20210128161304.GC4393@calimero.vinschen.de>
 <a4cd3c3f-d217-026a-3cce-b29187ecd1e9@cornell.edu>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <36a6753f-9aaa-f2ce-f71f-40385b3214c3@cornell.edu>
Date: Fri, 29 Jan 2021 14:23:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <a4cd3c3f-d217-026a-3cce-b29187ecd1e9@cornell.edu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [65.112.130.200]
X-ClientProxiedBy: BN9PR03CA0295.namprd03.prod.outlook.com
 (2603:10b6:408:f5::30) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.13.22.4] (65.112.130.200) by
 BN9PR03CA0295.namprd03.prod.outlook.com (2603:10b6:408:f5::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.16 via Frontend Transport; Fri, 29 Jan 2021 19:23:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8df6c80-a0a2-4ad9-469d-08d8c48b5899
X-MS-TrafficTypeDiagnostic: BN8PR04MB5715:
X-Microsoft-Antispam-PRVS: <BN8PR04MB571599B8C7F6E7B01DE0C013D8B99@BN8PR04MB5715.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sOXzLjjP8XCmZDiH/4LdgNFXWaR9P2/ByzWMzZHNgEsxtGEN2EaHVbuDG8FsvajUM5AiXZCFwlLLBlr9m13W2sCELWHvE3HgbNBoNok+Vbdvr+/QNeI0lzoD0L4pcYVXvnBmwSxRXB8ILcWmSXwoEI1s5wYyQ6W6P+u+sYLVPPZfldNDv67qC0qPB5bmY4p9XSjJAWjp6vzgUjnsSApRz/JZB7hQUKDnQmtf1fQPMGzJzxXEdGmHQS7kE+quq1FAIe6ClZJc+5g8Rcgs3ESykackSwg9XzCz6VBvwDQlrPWOCoEBTQdva9u2ouXRQdgdAUQxJ5qi4xqUsS1PvXwe3Uxyw4W69dYV9XtfHJP4pZIIGHTxpZ6E1uw2QnUvlJvG0cZ5qdCd8pRSag6yC5w1J2r0g69aqV7D7MQMgM3qprr/9I0+5htoAwMvEryw/CFNYldyLckGmyggt2XC0y6Z1eQ5wskYMegwU62ZWxP43XMHf7zftaSqf0ew8zLoK1lIhQeLMNrdTH0UUMv3Zw9hUPUMJvXeEhUzGjNQdWvT+oO5Kx+l1PLB8X+3LwcVeftbKp/e7wJwul8DJ3bVPpiwr5paPgfnZk3zIZOtadovMPM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(31686004)(6916009)(16526019)(186003)(36756003)(8936002)(66946007)(26005)(6486002)(2616005)(956004)(31696002)(66476007)(52116002)(83380400001)(8676002)(786003)(316002)(16576012)(2906002)(75432002)(5660300002)(478600001)(86362001)(53546011)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?i5Z4ZUA/NYkazEwJOCWN8GUwVzbcDeCCu4GEIkWjBUNNShcoxCMg300b?=
 =?Windows-1252?Q?9E6+5aL4kkKy2qvzPUFEEDUlRT+gIL28ZB+ZRB6QUpGp/jyfS/1eMdZ8?=
 =?Windows-1252?Q?7yjSTbZbeeqHEjtiLTjYfQ3HKVoHn8s8uuXx0XfTGbVBCFF3oyVKf6ie?=
 =?Windows-1252?Q?7kxSuHwGBFbD5Vx2pYi6lliSF4OxqdIYWxlfmZ36PNE7vJsaWr4B4xGB?=
 =?Windows-1252?Q?iKrPbkScanEmgAjTnIHVJFQWJN4vVYPVWijsfniYVftRlTZcsUx0ezS4?=
 =?Windows-1252?Q?uAfN6pJF1cyHgDV4pHCfUZcXOxR5NLuZes0GCLslAGzIFNuxrCHkJ1Vo?=
 =?Windows-1252?Q?Woy/4+YX2ocFEc9ArFS4GPNU+DnC1xPQ0Gl4Pynwfe+yfK5HKpXIJ1CO?=
 =?Windows-1252?Q?eXNyOZLseqd1pDQkq5vigKky2Nldm3vF76XqjxZkHQ/BxeFnMScRAOS8?=
 =?Windows-1252?Q?1MkKMfRSw7HwNPZb1ThnibM22kFpkygnkp/GhdRFvveap/z3Pocpjhxp?=
 =?Windows-1252?Q?8G4W5EeslCK5cDp9VDRCECPr2YoD35kSn9/hgCvqM7GVbQHCk6gjhxrY?=
 =?Windows-1252?Q?H33f4j3bNfozkzXUQE6xvMNp/yxs7BslvQQUXYXJ51BAIH9CiKBXR7AK?=
 =?Windows-1252?Q?NwMTTD5jk9fpWbcuRSegkMsftWyRshHRKa/nvBXbv9gw/DcMx76cRNK9?=
 =?Windows-1252?Q?wCDgd3r5Ng2DBpzpJKGlkWgPDAH2RUXWcxfat765gclRF8zbjrFKu9M5?=
 =?Windows-1252?Q?mtntvuxst6byoG1vYM7CC2aCwoZr7rW+P/NrGJr81KhYOxNikXIugTWW?=
 =?Windows-1252?Q?XNDvHT8/TnIEPOwsMVl6uW18PNOlrp6DfUJZIQkRu5kzjrRued93SjdO?=
 =?Windows-1252?Q?pbvCvZjF61EhmWf28vyMeD+RtAeQ6fhA1wb+F2bPnWoofSV//10XaRmF?=
 =?Windows-1252?Q?BoSyr+UtQzmzTbIb6twK/DHm88VegpEJtLP5TdXGWqgJSU9g5S127HZc?=
 =?Windows-1252?Q?nPeT+LgvonOU4DMGwNbchtxqnFnLkb6LV9XvrdtgZ4SLX6CThl/zlc3T?=
 =?Windows-1252?Q?4Xe2IMWO1sz4ifAzkIUD0M1vRGeHNNFOlvidxcauAFfOMwWo9Fo8ri6O?=
 =?Windows-1252?Q?QI3BpwauaaciYJEb99TjkirA?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: d8df6c80-a0a2-4ad9-469d-08d8c48b5899
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 19:23:24.0562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bf32/RG2g6BH2c8Dg3d0S8FGrYJ060t7Q6hQaxgmbqWxogP+1g6Kn0DJL3E5eXuTQAQklNKr90SCArDab0jgOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5715
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00, DKIM_INVALID,
 DKIM_SIGNED, GIT_PATCH_0, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
 MSGID_FROM_MTA_HEADER, NICE_REPLY_A, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2,
 SPF_HELO_PASS, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Fri, 29 Jan 2021 19:23:32 -0000

On 1/28/2021 5:28 PM, Ken Brown via Cygwin-patches wrote:
> On 1/28/2021 11:13 AM, Corinna Vinschen via Cygwin-patches wrote:
>> On Jan 28 17:07, Corinna Vinschen via Cygwin-patches wrote:
>>> On Jan 28 08:42, Ken Brown via Cygwin-patches wrote:
>>>> On 1/28/2021 5:20 AM, Corinna Vinschen via Cygwin-patches wrote:
>>>>> On Jan 27 21:51, Ken Brown via Cygwin-patches wrote:
>>>>>> According to the Linux man page for getdtablesize(3), the latter is
>>>>>> supposed to return "the maximum number of files a process can have
>>>>>> open, one more than the largest possible value for a file descriptor."
>>>>>> The constant OPEN_MAX_MAX is the only limit enforced by Cygwin, so we
>>>>>> now return that.
>>>>>>
>>>>>> Previously getdtablesize returned the current size of cygheap->fdtab,
>>>>>> Cygwin's internal file descriptor table.  But this is a dynamically
>>>>>> growing table, and its current size does not reflect an actual limit
>>>>>> on the number of open files.
>>>>>>
>>>>>> With this change, gnulib now reports that getdtablesize and
>>>>>> fcntl(F_DUPFD) work on Cygwin.  Packages like GNU tar that use the
>>>>>> corresponding gnulib modules will no longer use gnulib replacements on
>>>>>> Cygwin.
>>>>>> ---
>>>>>>    winsup/cygwin/syscalls.cc | 2 +-
>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
>>>>>> index 5da05b18a..1f16d54b9 100644
>>>>>> --- a/winsup/cygwin/syscalls.cc
>>>>>> +++ b/winsup/cygwin/syscalls.cc
>>>>>> @@ -2887,7 +2887,7 @@ setdtablesize (int size)
>>>>>>    extern "C" int
>>>>>>    getdtablesize ()
>>>>>>    {
>>>>>> -  return cygheap->fdtab.size;
>>>>>> +  return OPEN_MAX_MAX;
>>>>>>    }
>>>>>
>>>>> getdtablesize is used internally, too.  After this change, the values
>>>>> returned by sysconf and getrlimit should be revisited as well.
>>>>
>>>> They will now return OPEN_MAX_MAX, as I think they should.  The only
>>>> question in my mind is whether to simplify the code by removing the calls to
>>>> getdtablesize, something like this (untested):
>>>
>>> But then again, what happens with OPEN_MAX in limits.h?  Linux removed
>>> it entirely.  Given we have such a limit and it's not flexible as on
>>> Linux, should we go ahead, drop OPEN_MAX_MAX entirely and define
>>> OPEN_MAX as 3200?
>>
>> ...ideally by adding a file include/cygwin/limits.h included by
>> include/limits.h, which defines __OPEN_MAX et al, as required.
> 
> I'm not completely sure I follow.  Do you mean include/cygwin/limits.h should 
> contain
> 
>    #define __OPEN_MAX 3200
> 
> and include/limits.h should contain
> 
>    #define OPEN_MAX __OPEN_MAX ?
> 
> For the sake of my education, could you explain the reason for this?

Trying to answer my own question, I guess the idea is to hide implementation 
details from viewers of limits.h.  Is that right?  I took a stab at this and am 
about to send a patchset.  I'm not sure whether I made a reasonable choice of 
"et al" in "__OPEN_MAX et al".

Ken
