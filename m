Return-Path: <kbrown@cornell.edu>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760098.outbound.protection.outlook.com [40.107.76.98])
 by sourceware.org (Postfix) with ESMTPS id E9B073861031
 for <cygwin-patches@cygwin.com>; Mon, 20 Jul 2020 14:44:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E9B073861031
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ib76WXmBDrT/f05jBQ8Mb1HZIX9lNRNBbRk6QbaM89hjNdd1pHGCeRSbWPa0VhMMKCnL9EY8qSc+oYktFh12BWCwwtmscMFbbaprqGfkQc6VRC0ENqi/D6VTrjDx12nl7TeC6rvlRJWF4HvzfwmabbI2+ikokZLNEpWCHFyi6vVMm3z1N/9L3RGn6De503kCLL2RNQEcNctAONxldQ9ZNp0NJoYqYder7h2zErvlOYGs/4pxIxoNh6RhoxB78gUIMIDgQFi1TragniJbbVnScwrSAEsWZZi7yvYiUruIp9xcl9Qw/CQTT66H/8A+mYi8mBIQOzRnv8a/cmzPFyrA7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkNBXkP5CKiaoBp5vREuHKii8wOtb1HMY7gT1iyV8z8=;
 b=kI89O0xnvLlfDTgdTevNE631e0ZZxQiBouoGTpEdrNv1VjWsGe3zfOAI4bHHFzIx2Od6p04YLPMy2JydqYk5suQCQesb1EoTbG9b+1zXfPc2qhnOjgvZNVIg1OwEhyBpEoOPICsW9U6BoWN4sTcQSDPZLzLXCFH1PQQIDQbJjD/ewiaSABw57h06qSgZn0ymuP0SXvHgAP272c5KK7XdV+eteg0rN+m/qfSGjhDhD0ecPi3y4R0uHmR9GT+sduXeSDlG4ynD+B71l8XH5XsI8w7nBfttIMYqXpmek1eOVUWHWvyCMlwaBPfPv8pJdx4zPLvshZI1WGwUjzlrjWiFKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5645.namprd04.prod.outlook.com (2603:10b6:208:3c::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Mon, 20 Jul
 2020 14:43:56 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a%7]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 14:43:56 +0000
Subject: Re: [PATCH] Cygwin: mmap: fix mapping beyond EOF on 64 bit
To: cygwin-patches@cygwin.com
References: <20200720133442.11432-1-kbrown@cornell.edu>
 <20200720142303.GJ16360@calimero.vinschen.de>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <ceb31948-ec43-3bf1-a164-53b54828535f@cornell.edu>
Date: Mon, 20 Jul 2020 10:43:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200720142303.GJ16360@calimero.vinschen.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR08CA0025.namprd08.prod.outlook.com
 (2603:10b6:208:239::30) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2604:6000:b407:7f00:b097:c784:8595:264e]
 (2604:6000:b407:7f00:b097:c784:8595:264e) by
 MN2PR08CA0025.namprd08.prod.outlook.com (2603:10b6:208:239::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.19 via Frontend
 Transport; Mon, 20 Jul 2020 14:43:55 +0000
X-Originating-IP: [2604:6000:b407:7f00:b097:c784:8595:264e]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f96edd7-822d-44b7-074d-08d82cbb5463
X-MS-TrafficTypeDiagnostic: MN2PR04MB5645:
X-Microsoft-Antispam-PRVS: <MN2PR04MB5645BBC32AC1DCA25637A76AD87B0@MN2PR04MB5645.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7sU/c8flXQm0FZWWzihyNWQQZV3SghHv3OIBxLVVdXrxg1T40itYKCzBpNgBgvNWpm0LfGvOWHW4YSB0nmmIHvS2U9WKfdEOCBxpPB2Df9cN9+YXabJTVz272mU4gQbgwE/y3OsBDjm/lm1oGx4e+5gu9gxaDbRBWN9BNEtmu3+HOosoU3KUIfIchwedXIiNuIql1r9eMtXokHcQRgPKK23RT7yxyrYfEm6+qz1IAsMyNNo2cFE8cAiaNc9RANxcMyR536WANY6Q7+O4YHo3qLDVe8C+o37oyKs56kg4bCjoUJckNv2tuTFqFlL9NWOSduSilnBWohgTfJWob8raOVtKTdl0M0odos/POKW8bb/OqmurY1M70vROb6Jxp/zMMXtp+8PT05F7hSVNKWOG/Wt2zaVMWXjLzhe3jqN4Ux+CkyIqBcg5iU5IloO5dvjWmtNQZGDHjysUS478BIrnqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(53546011)(31686004)(186003)(8936002)(8676002)(5660300002)(966005)(478600001)(75432002)(16526019)(316002)(2616005)(786003)(66556008)(36756003)(86362001)(52116002)(6486002)(83380400001)(6916009)(2906002)(66946007)(66476007)(31696002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: cOgXQAW+IiFlwYCXBmdRuoQ8I8b2KWuuaaXEiqp8UjiHDJyv99EtkEm4lzcDOHWKD3r4FF4JRzYmWkB40f5IPr96WSlFve2WVDd4w3uFNW4SDxqZJsu+mORuTGVO/9aOSJuccnhNnZolUog3ltm8E3x0hBQgpbYJrmQdRw/bXtdHRd/KvQXR0umJXdkW1TucYI9teVgE0C2Sa/rjett1I4KSbpdcYvTpn4VsUe9p36BRSCCWyuLMq+Vv3LDwjwH6snDDfxnl7sY/Z/w/JXNG03Tesy38o0ZzeFhDmIBeMyb7NgAcWcTJZIyNw6mEcZkompgbi7tg9uniERVVPMqbXmwrWqkWVTFp0pHje0bbbNtGBdRsgQca7bokxByRrPtUVljBOWllINLlY9cALT5q9Ef1VsJ2HwiBk/LofrHnOqnfkUgOUOTpmBsajzlZgCpSZaTc7VnhisHGrghbmoFSLO5NaTv78HGWVpsNhoWOap7vJCN1nmxSnkHujyxMFgYY42fIrL/iq4I92ogiixfRcJe9y4IzKMuVnFC9pRCyZhU=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f96edd7-822d-44b7-074d-08d82cbb5463
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 14:43:56.1686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vYsI8tH/HjeXnFbAksLmpcD0p/f7KFWaHiFLcQ6B7ns0GCfN/GJrV7ecPhudPSWsRFaE9q7v6YUMDbvCxa2RWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5645
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, MSGID_FROM_MTA_HEADER,
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
X-List-Received-Date: Mon, 20 Jul 2020 14:44:05 -0000

On 7/20/2020 10:23 AM, Corinna Vinschen wrote:
> On Jul 20 09:34, Ken Brown via Cygwin-patches wrote:
>> Commit 605bdcd410384dda6db66b9b8cd19e863702e1bb enabled mapping beyond
>> EOF in 64 bit environments.  But the variable 'orig_len' did not get
>> rounded up to a multiple of 64K.  This rounding was done on 32 bit
>> only.  Fix this by rounding up orig_len on 64 bit, in the same place
>> where 'len' is rounded up.
>>
>> One consequence of this bug is that orig_len could be slightly smaller
>> than len.  Since these are both unsigned values, the statement
>> 'orig_len -= len' would then cause orig_len to be huge, and mmap would
>> fail with errno EFBIG.
>>
>> I observed this failure while debugging the problem reported in
>>
>>    https://sourceware.org/pipermail/cygwin/2020-July/245557.html.
>>
>> The failure can be seen by running the test case in that report under
>> gdb or strace.
>> ---
>>   winsup/cygwin/mmap.cc | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/winsup/cygwin/mmap.cc b/winsup/cygwin/mmap.cc
>> index feb9e5d0e..a08d00f83 100644
>> --- a/winsup/cygwin/mmap.cc
>> +++ b/winsup/cygwin/mmap.cc
>> @@ -1144,6 +1144,7 @@ go_ahead:
>>   	 ends in, but there's nothing at all we can do about that. */
>>   #ifdef __x86_64__
>>         len = roundup2 (len, wincap.allocation_granularity ());
>> +      orig_len = roundup2 (orig_len, wincap.allocation_granularity ());
> 
> Wouldn't it be simpler to just check for
> 
> -      if (orig_len - len)
> +      if (orig_len > len)
> 
> in the code following this #if/#else/#endif snippet?

I don't think so, because we also want to use the rounded-up value of orig_len 
further down when we set sigbus_page_len.

Ken
