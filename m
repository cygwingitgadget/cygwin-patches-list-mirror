Return-Path: <kbrown@cornell.edu>
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700097.outbound.protection.outlook.com [40.107.70.97])
 by sourceware.org (Postfix) with ESMTPS id 47E5E3851C04
 for <cygwin-patches@cygwin.com>; Tue, 19 May 2020 12:51:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 47E5E3851C04
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcwG/xhVGRYxSMR7G6qy3IQTEhWSntX7Vme37CHWvE3eJi/VRqFEdIzN+SAChKCDjr1RMuRsnxi/0UopHpcutrhzm4J+pVCOD31KtDCIgC6A1x2Iy4UvEkthpKwltKYDBKS9mMmy9eMh+4/nDoX24O5yegBhmSnXoQvV7xR+9qix+vSzlAFiFMF88Q9y1+0+06PfrfETySzgBMPwlddYYmv6aBbxB6sTT+sy9H7RUyOIX1Y3wNqn4nphV5rsWDjWPCVbYgVHBuDtb4c2ymikFS5JTsrezJ1Gw0OmuVvFWOoKvFurBr7j2H6UtC92s8eC0764ije9ZCh/75HrAWHPzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJ3AmsRenX2XCbfVakslnYkqmYlhOKH8UW84N71GYxM=;
 b=gpE/yb5lmhE+YroOnfyRSQIhhQzIo0o8uwev5qFz6VxFj9tDBNtnF5lOm0/jvGNEV02JdIldUVOPJiwi8BSxUgnNl/uOt0M3Nz+KQ1DJ7zC53lYPciz/5zU+AskbFhMP2CUbO7rdG+6ncdleiTt2FoUu/FDy8fr+dTnzMWLOGcjZrA9kWt6nE04BnMxKGBH9PU8xBJtuLvtyaYUHoCV1ACuS0H0H9JAQsQHg4QwZtL1c8R2V7urWAxk0nuXEipwWh3XQBGMfCADU7lXSI4Uoz+EKNC8Mb1d1ZYhM2BxhJWGZ4qqc5iXldSVbsmt48E+0ARuD/st16f+V88GEYiJoIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from DM6PR04MB6075.namprd04.prod.outlook.com (2603:10b6:5:127::31)
 by DM6PR04MB5308.namprd04.prod.outlook.com (2603:10b6:5:111::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.31; Tue, 19 May
 2020 12:51:07 +0000
Received: from DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4]) by DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4%4]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 12:51:07 +0000
Subject: Re: [PATCH 00/21] FIFO: Support multiple readers
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <20200507202124.1463-1-kbrown@cornell.edu>
 <20200518142519.cb6d805fa92afe4dcb017b02@nifty.ne.jp>
 <20200518143657.4e9f732f5456174348688f69@nifty.ne.jp>
 <912d46fc-3138-f3ec-f4d1-612433d9f128@cornell.edu>
 <cd2e382e-1c32-864a-31a4-8a6b7cfffc08@cornell.edu>
 <20200519102609.a3c2faa4f19ac655126c0680@nifty.ne.jp>
 <20200519151535.b4a97a0173f4d2ad4590d4c1@nifty.ne.jp>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <21fa9885-0405-10b7-982e-9fa19058070d@cornell.edu>
Date: Tue, 19 May 2020 08:51:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200519151535.b4a97a0173f4d2ad4590d4c1@nifty.ne.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR22CA0019.namprd22.prod.outlook.com
 (2603:10b6:208:238::24) To DM6PR04MB6075.namprd04.prod.outlook.com
 (2603:10b6:5:127::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2604:6000:b407:7f00:650a:68f2:73c8:4345]
 (2604:6000:b407:7f00:650a:68f2:73c8:4345) by
 MN2PR22CA0019.namprd22.prod.outlook.com (2603:10b6:208:238::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend
 Transport; Tue, 19 May 2020 12:51:06 +0000
X-Originating-IP: [2604:6000:b407:7f00:650a:68f2:73c8:4345]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29d0a5e1-ea20-4bda-5939-08d7fbf34be5
X-MS-TrafficTypeDiagnostic: DM6PR04MB5308:
X-Microsoft-Antispam-PRVS: <DM6PR04MB5308DFF294CC4E9C41D5A301D8B90@DM6PR04MB5308.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zugYf53+90AFUjvmOee2C0VExGoIIr9B9vXfJ2EARpZRxFWnBxAzPh3mACUeLRjf+oYrePYxQwFtL3x1MmAgnIkabx52vofXqxCdyaakrwYUd2M1/SLWDAcNoAzPJAK5g/kIpaXEEil67m+WAvJdNhhgJQW3YVejL57hqas+J+ZW4ikF/TphLXwQc/ooca43D4lOEEN5+GGb8mnPW472ULuELd3YbiHn2GXcRYXgWcg1ivRkvAUpDmpMtycq8VY3kF0AtYNW1HDZt46vOe/FlrEH7qLlL2Vlva+GMYukZEUNlBBc2nb7yxQuJzHDSx8lbbCE640Skk5Brfhm9jcG5PpazbMKMYuuqq+bk+JQR7p81gami4ndNhFi7S6Bw/1R6TXxdz+djdalvD/bCIezZ2zcVV9AxgYbrEkGm0GgGwf6UimWKUimrUcFGV3r1stpPdZqccvbuLZ6cezc84MK/RkaExWoovsBDokeOaMj1DIo17HvxLdKYlLjGqcHffiR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6075.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(66556008)(36756003)(316002)(66476007)(786003)(31696002)(6916009)(53546011)(66946007)(6486002)(6666004)(31686004)(2616005)(2906002)(52116002)(5660300002)(16526019)(478600001)(186003)(75432002)(8676002)(86362001)(8936002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: GNQO2EhxBUBMEmQ8o9AU/hjfU7nkNnzKvija9kco9a2ZqnyG/gK52zSU3VStZnfWkHtNE5R5oM1bh+j1i9+bvttQIyZHUWKVEsdW4gxPj2tN4P35/O4CNvVn+SNFrhUPaK6e3lS2EBa67xK/pYQ0ZdSep9Qf4ovKEVm2/Xx3vA2KEnbHGXIKDQ+TPcexGyz4K3981cDMibXIvJbVFrzlfT+sw2ncLSvg1G+pEbyRiHnAO/5aDQKy8mnamlrHaMie0B8RFP/kLqbtsLTrQNscLis1/drB90/M7nrkD4pZG1lbyEB4bT1er+ilrjwgjFHqjV4/xeaeeMTNinSlXka2NlJYSCbb5yxEXnIylhruzPiZc8eikoTPVVJyc6iMivivht0jnmcXBVQySObxL64u5UJEUoTcXb/UwD37EBorwwIxGR/xuqfzbXU4eW6y8rp257UY7j5Tf7FUXowAhzjsoV/qjCtAZ42s60oK6nwqSQnjffr26uEgUrLztJ1uAyGUzpnXS26LzGgec+L/VCP2xxCDMVIxyHQa1qlzMJjimVE=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d0a5e1-ea20-4bda-5939-08d7fbf34be5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 12:51:06.8269 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5lgROImr6ZjdN4KPka+c6c0NHHJiVcz+9eLMKmtAACHNMemqqukumtztVOCbGUp1YAf6QIdKSKxgrEX6PqevNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5308
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00, DKIM_INVALID,
 DKIM_SIGNED, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS, MSGID_FROM_MTA_HEADER,
 RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
 TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Tue, 19 May 2020 12:51:10 -0000

On 5/19/2020 2:15 AM, Takashi Yano via Cygwin-patches wrote:
> On Tue, 19 May 2020 10:26:09 +0900
> Takashi Yano via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
>> Hi Ken,
>>
>> On Mon, 18 May 2020 13:42:19 -0400
>> Ken Brown via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
>>> Hi Takashi,
>>>
>>> On 5/18/2020 12:03 PM, Ken Brown via Cygwin-patches wrote:
>>>> On 5/18/2020 1:36 AM, Takashi Yano via Cygwin-patches wrote:
>>>>> On Mon, 18 May 2020 14:25:19 +0900
>>>>> Takashi Yano via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
>>>>>> However, mc hangs by several operations.
>>>>>>
>>>>>> To reproduce this:
>>>>>> 1. Start mc with 'env SHELL=tcsh mc -a'
>>>>>
>>>>> I mean 'env SHELL=/bin/tcsh mc -a'
>>>>>
>>>>>> 2. Select a file using up/down cursor keys.
>>>>>> 3. Press F3 (View) key.
>>>>
>>>> Thanks for the report.  I can reproduce the problem and will look into it.
>>>
>>> I'm not convinced that this is a FIFO bug.  I tried two things.
>>>
>>> 1. I attached gdb to mc while it was hanging and got the following backtrace
>>> (abbreviated):
>>>
>>> #1  0x00007ff901638037 in WaitForMultipleObjectsEx ()
>>> #2  0x00007ff901637f1e in WaitForMultipleObjects ()
>>> #3  0x0000000180048df5 in cygwait () at ...winsup/cygwin/cygwait.cc:75
>>> #4  0x000000018019b1c0 in wait4 () at ...winsup/cygwin/wait.cc:80
>>> #5  0x000000018019afea in waitpid () at ...winsup/cygwin/wait.cc:28
>>> #6  0x000000018017d2d8 in pclose () at ...winsup/cygwin/syscalls.cc:4627
>>> #7  0x000000018015943b in _sigfe () at sigfe.s:35
>>> #8  0x000000010040d002 in get_popen_information () at filemanager/ext.c:561
>>> [...]
>>>
>>> So pclose is blocking after calling waitpid.  As far as I can tell from looking
>>> at backtraces of all threads, there are no FIFOs open.
>>>
>>> 2. I ran mc under strace (after exporting SHELL=/bin/tcsh), and I didn't see
>>> anything suspicious involving FIFOs.  But I saw many EBADF errors from fstat and
>>> close that don't appear to be related to FIFOs.
>>>
>>> So my best guess at this point is that the FIFO changes just exposed some
>>> unrelated bug(s).
>>>
>>> Prior to the FIFO changes, mc would get an error when it tried to open tcsh_fifo
>>> the second time, and it would then set
>>>
>>>     mc_global.tty.use_subshell = FALSE;
>>>
>>> see the mc source file subshell/common.c:1087.
>>
>> I looked into this problem and found pclose() stucks if FIFO
>> is opened.
>>
>> Attached is a simple test case. It works under cygwin 3.1.4,
>> but stucks at pclose() under cygwin git head.
>>
>> Isn't this a FIFO related issue?
> 
> In the test case, fhandler_fifo::close() called from /bin/true
> seems to get into infinite loop at:
> 
> do
> ...
> while (inc_nreaders () > 0 && !found);

Thank you!  I see the problem.  After the popen call, the original 
fhandler_fifo's fifo_reader_thread was no longer running, so it was unable to 
take ownership.

It might take a little while for me to figure out how to fix this.

Thanks for your persistence and, especially, for the test case.

Ken
