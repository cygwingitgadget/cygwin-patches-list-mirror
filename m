Return-Path: <kbrown@cornell.edu>
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2119.outbound.protection.outlook.com [40.107.220.119])
 by sourceware.org (Postfix) with ESMTPS id 74B493850419
 for <cygwin-patches@cygwin.com>; Mon, 20 Jul 2020 14:49:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 74B493850419
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dardF0DKeNbnLc7un4BeYb6hRovxchHMpMtAwQPZxzXZKDPRMNujaEXVs57/9TwX+CEzY+wh6/zpMZgys5bGGYP8X++bmRTSwyQ9vA5pvaLba4XAufMx3nxqp7NGUM5JLLb9H9yrcIPCVtTlwY3L6NOqzuYJc8JrYZTlQddubzrm/0SHl6JO4YHq41cfFiceU+5UcqAgs4G43zZ7O9Hid4OQ4Mivc/1PbD3EPxa8hZiT4DF8Y8a9GUR83adg4pYOmxolfHya8RMb3jNNsurbbG/yR5eClDMXJUrlsjdtVAmMtrniYYUgRbk0IFZslwojd5nwIB0mtqpdR/tMAqlmoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXKofb6W/qxGm1SFWcW4Ip/5qE1RaeUZ7cD6/zjSp7Y=;
 b=JupBtjc/JIWWy/esS4Mb4sSBJh1syQafp5TKEObarN9WBAD5aMQc75Epc1dM59phmaSYXysDhB7EsbhUKZj8iJFw+p34+MeJXHlz0NPIH6Q3VNOhMCvk+uts1DdkVzmoGi5aUyD6Ump5FuXQNDD1iiU9OKnfuiHLgudjAfQHFNUZAIsqQdxN93siVxANw8a3bgo+ptgXBIxN4OKtoAVV+lhmP4IcatRwsB0FO+q95K2MMeqV8tQILAjOdVf+Xm9GmtYM5Ss2jvuSMDNloxkse9iwIYlq+CB0haAI2w2T1j72tFGassGW8u1LhZvXz1kk30Za2em/mRjyue6mnbG9GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5904.namprd04.prod.outlook.com (2603:10b6:208:a6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Mon, 20 Jul
 2020 14:49:29 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a%7]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 14:49:29 +0000
Subject: Re: [PATCH] Cygwin: mmap: fix mapping beyond EOF on 64 bit
To: cygwin-patches@cygwin.com
References: <20200720133442.11432-1-kbrown@cornell.edu>
 <20200720142303.GJ16360@calimero.vinschen.de>
 <ceb31948-ec43-3bf1-a164-53b54828535f@cornell.edu>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <3d3597af-7bb8-bc83-2522-9282566f80b8@cornell.edu>
Date: Mon, 20 Jul 2020 10:49:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <ceb31948-ec43-3bf1-a164-53b54828535f@cornell.edu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR22CA0013.namprd22.prod.outlook.com
 (2603:10b6:208:238::18) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2604:6000:b407:7f00:b097:c784:8595:264e]
 (2604:6000:b407:7f00:b097:c784:8595:264e) by
 MN2PR22CA0013.namprd22.prod.outlook.com (2603:10b6:208:238::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend
 Transport; Mon, 20 Jul 2020 14:49:28 +0000
X-Originating-IP: [2604:6000:b407:7f00:b097:c784:8595:264e]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbc191f9-ae89-4516-11b7-08d82cbc1ad2
X-MS-TrafficTypeDiagnostic: MN2PR04MB5904:
X-Microsoft-Antispam-PRVS: <MN2PR04MB590499CA8180A654D7153DEDD87B0@MN2PR04MB5904.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xRCIRC8R2Mnlha25wsBG5F8OpmEl/spseOlXcqRccaSI7FRZEcR794SCYm2F9MWaZ6kfrh54gLbButJp645VhZveMDLQDW5U9TMmwL4nzYUcf3DAOjIJ9tAgaMNteHxzM+v7rpua7Q/Ve6nhXZpJ7G/tdpWH/d4wwHXbBry27onSlEgAfMB55v2pD80tc2wUYKG7xnbWCsJkf5A07a1LpJWOyXwKgn0Ml4tBbcJq8AGBwHiweBuRHKN1DVGaAUtNtcAjpPC37cm0LB6opk6rYzIOCAwiNXiIaWruARoo1/2Clk6AuwoL1XB+AZWD5I966xzKEq6ael0fPPwgTnxEvQNjzGWoHban0AvG64AHfulWqs1imzODHMvTwP4WTUiMyCHrCQUPsPRCKkzHunvArjy8ggY/CtV9ovrX3gvKgrdyXPlx10JZfCPlzFWZfeJELOV6tGnPA1UtnkVQ/bcreg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(966005)(83380400001)(5660300002)(75432002)(8676002)(52116002)(8936002)(6486002)(53546011)(86362001)(478600001)(31696002)(786003)(31686004)(316002)(186003)(6916009)(66946007)(66556008)(2616005)(2906002)(66476007)(16526019)(36756003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: THP+iYgUCK+GKXidE668aMYG7fCzxlHFjF5ZQjrQHG3IDgQRf4hD0Nu6mIUibMvTq1IkVNKc46Fm3c5xVskyT7I2qPgS2yngbOgwrPPNilmxgPYtD91CAjGk/xlmKrpUT5Nl3vhqC+k/h56oRb4+O+lRPkjoCpz2NXR+0izPm4O7blpjhLmCmDyC2DnT1iJXN9qKol2AsUTokMvIfrltL7rBIUTsGDnEA4T4cNLR2OISqKz5U13ywdCUcT1CuqrJPbrOrHlF+tA469fniCAMeOlZ8cQtM7mF3MH5Urc8VIHEGiNj45CuJKgsYcK+W6yuaU3e6DSm3DeLtfwA0rIoDTSA/PyovWwgCaL5qBiOXuCtDFTzZ6cemYXwoRhJT5PPnqKG907Pl7H2t465xoKcY6sVcPONAZRhTvCLySQtW3hzcoxY5e4LOgHQIN+YwNhbdgnQstuFuSbmWFy9coarZPvGLIOsUslu+4XmkPK8/mwFzxSvl0zV6edzA2aqD/XT65EH0mZYFdGgd8crU0XZd4UGv6VanoLZC983mvqa2fw=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc191f9-ae89-4516-11b7-08d82cbc1ad2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 14:49:29.0552 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Asa7NCoCmSrNSiMS55q2LQfxb5hLfkEpOUrff3ImFSRwDrKQ0veMxgv5+AdSBZYKWZqihQjWlOKUAzbFCVYqUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5904
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00, DKIM_INVALID,
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
X-List-Received-Date: Mon, 20 Jul 2020 14:49:33 -0000

On 7/20/2020 10:43 AM, Ken Brown via Cygwin-patches wrote:
> On 7/20/2020 10:23 AM, Corinna Vinschen wrote:
>> On Jul 20 09:34, Ken Brown via Cygwin-patches wrote:
>>> Commit 605bdcd410384dda6db66b9b8cd19e863702e1bb enabled mapping beyond
>>> EOF in 64 bit environments.  But the variable 'orig_len' did not get
>>> rounded up to a multiple of 64K.  This rounding was done on 32 bit
>>> only.  Fix this by rounding up orig_len on 64 bit, in the same place
>>> where 'len' is rounded up.
>>>
>>> One consequence of this bug is that orig_len could be slightly smaller
>>> than len.  Since these are both unsigned values, the statement
>>> 'orig_len -= len' would then cause orig_len to be huge, and mmap would
>>> fail with errno EFBIG.
>>>
>>> I observed this failure while debugging the problem reported in
>>>
>>>    https://sourceware.org/pipermail/cygwin/2020-July/245557.html.
>>>
>>> The failure can be seen by running the test case in that report under
>>> gdb or strace.
>>> ---
>>>   winsup/cygwin/mmap.cc | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/winsup/cygwin/mmap.cc b/winsup/cygwin/mmap.cc
>>> index feb9e5d0e..a08d00f83 100644
>>> --- a/winsup/cygwin/mmap.cc
>>> +++ b/winsup/cygwin/mmap.cc
>>> @@ -1144,6 +1144,7 @@ go_ahead:
>>>        ends in, but there's nothing at all we can do about that. */
>>>   #ifdef __x86_64__
>>>         len = roundup2 (len, wincap.allocation_granularity ());
>>> +      orig_len = roundup2 (orig_len, wincap.allocation_granularity ());
>>
>> Wouldn't it be simpler to just check for
>>
>> -      if (orig_len - len)
>> +      if (orig_len > len)
>>
>> in the code following this #if/#else/#endif snippet?
> 
> I don't think so, because we also want to use the rounded-up value of orig_len 
> further down when we set sigbus_page_len

Actually we first modify orig_len in 'orig_len -= len;' and then use it to set 
sigbus_page_len.  In any case, I think it needs to be rounded up before being used.

Ken
