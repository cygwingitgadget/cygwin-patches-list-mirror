Return-Path: <kbrown@cornell.edu>
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2130.outbound.protection.outlook.com [40.107.92.130])
 by sourceware.org (Postfix) with ESMTPS id 15356386F471
 for <cygwin-patches@cygwin.com>; Fri, 22 May 2020 14:40:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 15356386F471
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TW3omweqD90hAi5OUv1mybDZLdVLkQruoJVrhlCNcxn3LUUyGKpTk04P4ip6fkqL2oBPS/Ns7YwO8RXe3W2WNnQZ10uB2jhcPAMcA0o+eC5BOIafNkt3SVQfmB66sATSYnlUwUY6Db0Iej5jvLX8lnA5rQJesbiK6sbP0lr5+oWHDxHNcZuXDjrjR0fXhCb3p6m4rX8Y06G/1bEJb3gPYHOPYIqs8Us20mrnb6NZ+1vDDLsUpBKp8z15wzYAT1WoDEBHLahGCXn0TQRWXJ9PDwjttuVXxJVZ4IcvoFDOsAmQ3Tu4HsSZ7xA1XnhRSaxmJEAllku3SJfGsqR+/8kj0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zBHmAwfn1HoX6/AkcCkOIBYLx83T5NGWzdjrJnHcaM=;
 b=RrQpKOll/jUnITofrhoeAEQ9GkZOqIQiGsTAwe66LM3C7hmkzIf9weAt0nidoPz/v/vEu4dwQ2a0/RIfMOcJwJPrTK7w7ZuTPNCBRxv2dbtRL50F7aeH2uGkliMJVQ1QGdVjc+eQAbOQ98mwbtlf7YVwNRHDlDhkkRA7ZefSqf41J0DTZIA2scTTytDHHKr09CsTrhRCbPDmvwF3Zm1S/93uTmmErglSAu2ipVXGF5UtA+9WcsicG0ZkIGR1Ya1GBnYJu04hg1iU645lQtAvwxoZpAiwmvTcrd0FsHnmqp7rty9k/BWsuNsseSr1eiLWHSc0PGYUWlGYm5FxSRFJ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from DM6PR04MB6075.namprd04.prod.outlook.com (2603:10b6:5:127::31)
 by DM6PR04MB3833.namprd04.prod.outlook.com (2603:10b6:5:b5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Fri, 22 May
 2020 14:40:22 +0000
Received: from DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4]) by DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4%4]) with mapi id 15.20.3000.034; Fri, 22 May 2020
 14:40:22 +0000
Subject: Re: [PATCH 00/21] FIFO: Support multiple readers
To: Takashi Yano <takashi.yano@nifty.ne.jp>, cygwin-patches@cygwin.com
References: <20200507202124.1463-1-kbrown@cornell.edu>
 <20200518142519.cb6d805fa92afe4dcb017b02@nifty.ne.jp>
 <20200518143657.4e9f732f5456174348688f69@nifty.ne.jp>
 <912d46fc-3138-f3ec-f4d1-612433d9f128@cornell.edu>
 <cd2e382e-1c32-864a-31a4-8a6b7cfffc08@cornell.edu>
 <20200519102609.a3c2faa4f19ac655126c0680@nifty.ne.jp>
 <20200519151535.b4a97a0173f4d2ad4590d4c1@nifty.ne.jp>
 <21fa9885-0405-10b7-982e-9fa19058070d@cornell.edu>
 <48b29425-61fa-34c2-4b4a-afaf3c4a1c03@cornell.edu>
 <20200519230717.d84c2bfbb10cf5f89c698e3e@nifty.ne.jp>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <7dd29185-47e5-eb31-71eb-9a4bf2f857a2@cornell.edu>
Date: Fri, 22 May 2020 10:40:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200519230717.d84c2bfbb10cf5f89c698e3e@nifty.ne.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR14CA0018.namprd14.prod.outlook.com
 (2603:10b6:208:23e::23) To DM6PR04MB6075.namprd04.prod.outlook.com
 (2603:10b6:5:127::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.17] (68.175.129.7) by
 MN2PR14CA0018.namprd14.prod.outlook.com (2603:10b6:208:23e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Fri, 22 May 2020 14:40:21 +0000
X-Originating-IP: [68.175.129.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef351de4-192c-4405-be04-08d7fe5e0e96
X-MS-TrafficTypeDiagnostic: DM6PR04MB3833:
X-Microsoft-Antispam-PRVS: <DM6PR04MB3833EFD6E52001B287B2D119D8B40@DM6PR04MB3833.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dJl83TkDocBMbnKx4N0h7lXLu3wtS59V/7+GoGgWIfRw5w6lzN4GNQFtvcteUUV5LMQhfDwxcaUze/ctyGYc5B94YpyfcJ1u0Unc3YJ4JwNfzH92ZaMOazs3N0g6T+QAFEJSsjQDobeHY9+Zm7EBKX3LqgDXyZ0j2OplWR12JvsT5We0U8lE1jtpFv7D8zCIpAAKyoUoz7Evbska5qGcskJ9AZypOPH/1D2w3isc8ai58iZC+sYpEiPOyUZDWGK62XCSgvj0b6w/RMjGTdDnUHJvv6DrGYIL1BuPIChBbr3BBZa0yyo/lollhmoZBKEzx2VwNmpmInZvVowRgIRAUmuk7y29L/xlQUL0WjuKA/DQmcmWmKOtm2iFIh08dxsn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6075.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(316002)(75432002)(2616005)(956004)(36756003)(478600001)(31686004)(31696002)(2906002)(86362001)(8676002)(8936002)(66476007)(66556008)(66946007)(5660300002)(786003)(52116002)(16576012)(6486002)(26005)(53546011)(186003)(16526019)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: T6dP3Ehf9bZPli0+D5o+6oSy4ivK0ksBNSX/mOkWroMrkwjtJnITirmmBPs5LUxjkcA8DI3YG58Ih1L6gzdCnnhBYDAcLA3CVD9umxhTCf3iYeQBo/sLSlyBBLfVDYTHI6saqX6nicCiadDh5lme+P+UOXd5D6o/AxsnxDCI44QEA6369oPzh87UuQFCkwSD3zFcRmPqUewBi5+lu51l+/5wiSr5ZDV9QyGW7YDJxnOPpbRe2J7i14plQnhxK5Aic1/uAWRq8Kj6x1RUVqmAfhoVQI5To7DjrA8DiuGcGtuCKWOWk59XAO2GTdifl4WZpz/eWqeqB/nGgdxx4DjEhzp6I/ENrfC8TRr8+M38vk3RJOb2/oM8iFlOwx5Yn9zrWHDnWLxZoRHBZpE+9a8HiETxO9ZwZ+r4IUzFGjK/qYmwsVKubw2MqX1bhVtd+ZbQnQbVlIqD+tPmKuD+hzuxh2Sgjpn9yFwVL2M51DEFOhg=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: ef351de4-192c-4405-be04-08d7fe5e0e96
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 14:40:22.3404 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SK/1Sjw6uYdsLLCesXUG6CwK8dMb8rp7R6ngkuZ/zWvAMUgUOAsvvbE2W8SUR7MzfmkjDWobkXjYoLf0HTTapA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB3833
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00, DKIM_INVALID,
 DKIM_SIGNED, KAM_DMARC_STATUS, MSGID_FROM_MTA_HEADER, RCVD_IN_DNSWL_LOW,
 RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
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
X-List-Received-Date: Fri, 22 May 2020 14:40:26 -0000

On 5/19/2020 10:07 AM, Takashi Yano wrote:
> On Tue, 19 May 2020 09:37:17 -0400
> Ken Brown via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
>> On 5/19/2020 8:51 AM, Ken Brown via Cygwin-patches wrote:
>>> On 5/19/2020 2:15 AM, Takashi Yano via Cygwin-patches wrote:
>>>> On Tue, 19 May 2020 10:26:09 +0900
>>>> Takashi Yano via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
>>>>> Hi Ken,
>>>>>
>>>>> On Mon, 18 May 2020 13:42:19 -0400
>>>>> Ken Brown via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
>>>>>> Hi Takashi,
>>>>>>
>>>>>> On 5/18/2020 12:03 PM, Ken Brown via Cygwin-patches wrote:
>>>>>>> On 5/18/2020 1:36 AM, Takashi Yano via Cygwin-patches wrote:
>>>>>>>> On Mon, 18 May 2020 14:25:19 +0900
>>>>>>>> Takashi Yano via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
>>>>>>>>> However, mc hangs by several operations.
>>>>>>>>>
>>>>>>>>> To reproduce this:
>>>>>>>>> 1. Start mc with 'env SHELL=tcsh mc -a'
>>>>>>>>
>>>>>>>> I mean 'env SHELL=/bin/tcsh mc -a'
>>>>>>>>
>>>>>>>>> 2. Select a file using up/down cursor keys.
>>>>>>>>> 3. Press F3 (View) key.
>>>>>>>
>>>>>>> Thanks for the report.  I can reproduce the problem and will look into it.
>>>>>>
>>>>>> I'm not convinced that this is a FIFO bug.  I tried two things.
>>>>>>
>>>>>> 1. I attached gdb to mc while it was hanging and got the following backtrace
>>>>>> (abbreviated):
>>>>>>
>>>>>> #1  0x00007ff901638037 in WaitForMultipleObjectsEx ()
>>>>>> #2  0x00007ff901637f1e in WaitForMultipleObjects ()
>>>>>> #3  0x0000000180048df5 in cygwait () at ...winsup/cygwin/cygwait.cc:75
>>>>>> #4  0x000000018019b1c0 in wait4 () at ...winsup/cygwin/wait.cc:80
>>>>>> #5  0x000000018019afea in waitpid () at ...winsup/cygwin/wait.cc:28
>>>>>> #6  0x000000018017d2d8 in pclose () at ...winsup/cygwin/syscalls.cc:4627
>>>>>> #7  0x000000018015943b in _sigfe () at sigfe.s:35
>>>>>> #8  0x000000010040d002 in get_popen_information () at filemanager/ext.c:561
>>>>>> [...]
>>>>>>
>>>>>> So pclose is blocking after calling waitpid.  As far as I can tell from looking
>>>>>> at backtraces of all threads, there are no FIFOs open.
>>>>>>
>>>>>> 2. I ran mc under strace (after exporting SHELL=/bin/tcsh), and I didn't see
>>>>>> anything suspicious involving FIFOs.  But I saw many EBADF errors from fstat
>>>>>> and
>>>>>> close that don't appear to be related to FIFOs.
>>>>>>
>>>>>> So my best guess at this point is that the FIFO changes just exposed some
>>>>>> unrelated bug(s).
>>>>>>
>>>>>> Prior to the FIFO changes, mc would get an error when it tried to open
>>>>>> tcsh_fifo
>>>>>> the second time, and it would then set
>>>>>>
>>>>>>      mc_global.tty.use_subshell = FALSE;
>>>>>>
>>>>>> see the mc source file subshell/common.c:1087.
>>>>>
>>>>> I looked into this problem and found pclose() stucks if FIFO
>>>>> is opened.
>>>>>
>>>>> Attached is a simple test case. It works under cygwin 3.1.4,
>>>>> but stucks at pclose() under cygwin git head.
>>>>>
>>>>> Isn't this a FIFO related issue?
>>>>
>>>> In the test case, fhandler_fifo::close() called from /bin/true
>>>> seems to get into infinite loop at:
>>>>
>>>> do
>>>> ...
>>>> while (inc_nreaders () > 0 && !found);
>>>
>>> Thank you!  I see the problem.  After the popen call, the original
>>> fhandler_fifo's fifo_reader_thread was no longer running, so it was unable to
>>> take ownership.
>>>
>>> It might take a little while for me to figure out how to fix this.
>>
>> Actually, I think it's easy.  Please try the two attached patches.  The second
>> one is the crucial one for the mc problem, but the first is something I noticed
>> while working on this.
>>
>> I just did a quick and dirty patch for testing purposes.  I still have to do a
>> lot of cleanup and make sure the fix doesn't break something else.
> 
> For a shor time, I tested these patches, and confirmed
> that this fixes the problem.
> 
> Thanks for the quick response.

I've just pushed cleaned-up versions of the patches.

Ken
