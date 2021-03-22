Return-Path: <kbrown@cornell.edu>
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2115.outbound.protection.outlook.com [40.107.101.115])
 by sourceware.org (Postfix) with ESMTPS id 29F883858D29
 for <cygwin-patches@cygwin.com>; Mon, 22 Mar 2021 17:02:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 29F883858D29
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjAZqbZpzLaEsk4Cw4rFu50I5RK9ngg7IItzFQ0y5M/wbPEIFKTdhAYSzjxfe5Gfi5JYZUCr/GbLOC7gbSrWlEhqpf+v6QsF6FKEFXASF6C3QbmzXj4h46u21CL8fksE+THjPmY9zlsNBCaRSgWTQe42r53TCnyHQ3+tIrAi//FkRjhOMDNgAdbrx94mUNrotYAp1jf0ez8Eqb8VPjTqT0eTaKQIghluI1mBdWDvih9zxfozhW42+hirSMg1WYsRVKR37FYd3WbRKpgKSf51449jYCglcHOPV3/G9svrqQzrPQB472zpbn5Sl4RfXuXa2y/KUERO/ZJMyDSzEk9XRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjDHnFYbxi9s2usxGzoqgKBbs2ZBxtvEDvB1kFXlyGE=;
 b=Zj1wcN+/FB89tV4P8tUwHLYwoyi/YeOvF/+oOktjBW33r+mQv087P4HjphoKnoGrFi7yraG8HfQuciINpnDaeDQyShbaQZfQ3qi3NCD6D3dTGDRBTc50ZuHjZttxDlehcmjs2bJgoRwxSdIiIhoVnjOKkx1wmGN1UcWgPS4J8xTOGm1VX4KeKgXtWEQ+vk5aLpjMkSMqTmiFau+AEIo9S+T23TU9t1yUFCunDGEWQn3LzhnMwEVFrgonZajoV41qjLgcYU5rtncLhKTSt9kXvlJgLL0tNH2MGHFIJn/Qs3O77mdx7tYwp7kOmexl/5i+fh8BHjhE9eSbxaGr3/GIew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN8PR04MB5716.namprd04.prod.outlook.com (2603:10b6:408:a0::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 17:02:49 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::59f8:fcc4:f07e:9a89]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::59f8:fcc4:f07e:9a89%4]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 17:02:49 +0000
Subject: Re: [PATCH 0/2] Return appropriate handle by _get_osfhandle() and
 GetStdHandle().
To: cygwin-patches@cygwin.com
References: <20210321040126.1720-1-takashi.yano@nifty.ne.jp>
 <20210321174427.cf79e39deeea896583caa48c@nifty.ne.jp>
 <20210322080738.6841d7f2a1e09290a929ad90@nifty.ne.jp>
 <YFiC6FXrnGeW8v1M@calimero.vinschen.de>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <58c7be6c-42db-cc09-9f89-461ac7c87747@cornell.edu>
Date: Mon, 22 Mar 2021 13:02:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <YFiC6FXrnGeW8v1M@calimero.vinschen.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [24.194.34.31]
X-ClientProxiedBy: BL1PR13CA0315.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::20) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.17] (24.194.34.31) by
 BL1PR13CA0315.namprd13.prod.outlook.com (2603:10b6:208:2c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.9 via Frontend
 Transport; Mon, 22 Mar 2021 17:02:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8687fc00-c643-4548-370e-08d8ed54527f
X-MS-TrafficTypeDiagnostic: BN8PR04MB5716:
X-Microsoft-Antispam-PRVS: <BN8PR04MB5716E7E09108D397F8F50658D8659@BN8PR04MB5716.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CoNcdza4YSgdO7ZlnhhRZFpnS/WiVZwTRjFF97fBgfKNlmdAZwQKkt4b0T5M6AaKwg7t6Fsxd/yp4+6mtehLN+oLPM6/zKI7i/SKb2afoKdPBEcPxMAuQn0PgQzqyGFkXVf9JhL2GRMviITRxHABovYWDE0EvKKwiq8qt+GIRVsb43qTM+ytY1GpHuWN4wVPQS/g3l3cPDTR0wROtjMIfDr6DI2m1gB/ws0hzrPto2+2gNs5BY9meK4qZi8P7hQqU5Zxl0oizA6SBr7J6tteVVsU0llVx0bWlhUZa+sF6rRRBWIKFzQ7oldJgW+xPenK89IrRtCzK/GuE0F13MCLQAiXGfVjqKLGOCuWoJ+E2vmmzFrrRihIQhiyN97wKxPVTsSDYWKZ4SEkw/FDYSKRKNIsAE8Glt/Kj1H0ifeMWPv/w6fpm7cGD841e+1xp0pA1/UGjGB4BJpxQgfvrmzGbc8QwEB2Gi7+H66zRuuAA5y5px89oapFQLwvZtAdhpUDPa0YaG2FIH+sSh7d/0h6QMgxoEw4jR8z54hIwFXsJsqko34fcBiRRhBS2E+x3EdHHwDn7KY726IAvxxQM9L2m2VrIPY/77y+ncArYKWhHhrk/Y3aCmgMZpR5t++jWqR6X1WCCpfRLa5s9BSKKo0IEnwPdvJERzgwqJSe7wDTBqN9H/PaWBRHfm5nCV/DfhLf7JXiQ5ObyH6NLFD5qNccI/U0imVg3p4EQmADUzKzb7x6ASclD2dkUuMWcTQLlAqJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(5660300002)(2906002)(75432002)(26005)(16526019)(38100700001)(8676002)(186003)(36756003)(6916009)(66476007)(16576012)(316002)(31696002)(956004)(66946007)(86362001)(478600001)(31686004)(6486002)(8936002)(786003)(2616005)(83380400001)(53546011)(66556008)(52116002)(45980500001)(43740500002)(460985005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?BpMdP4Q/4+vDEqQR3Yp9SjADIJyyAU1voOx0rBzMZ62t+TTwE7acj+uP?=
 =?Windows-1252?Q?mAMal7aVT3spzM4QJd89ynDgFBflFQWBb4n0+pkHalbRE+z+MUZ2qGQh?=
 =?Windows-1252?Q?frssgg54WuUQTWMRcMU9j75wXLBX6l32MYOatTpAnZUj5UN9CMQLj/Of?=
 =?Windows-1252?Q?yASbo7PmD18eYU0symR2zZ1PWNer8Y0sV3OJInYiDmDxeiboUKcP4TEG?=
 =?Windows-1252?Q?/7DEVv/U9b21OmZYBkx1rWrhfmHzb1hmhFC7pJRyb8TZb6qRiIlk02lC?=
 =?Windows-1252?Q?lDBnZUYzaFp7bd3PM3AvsURA+zBLjVde37+pZRAQcxbSJkdLi9pU6Nqe?=
 =?Windows-1252?Q?Fwh+3jlmZFnI7AnwAk/03su4cDJ1obj4aA9LsiD1K4Ej+nw4jGeZp+TR?=
 =?Windows-1252?Q?57tP+Gx36s0Q8Oi95i5cf/RABhwQzj6IQsKP43d4yjZJBNiC2wD5JrBx?=
 =?Windows-1252?Q?Hc71DhuZ2FiBB0eKS7RqWxFsHnEUQQZx2B+CRrrclxOJKTCJTAy9iqOt?=
 =?Windows-1252?Q?lhJRuAJj2g8/l+8CmSWcCsEvLsvXK6OiSuYMHKNNkSVpMHOlQDm7dwj+?=
 =?Windows-1252?Q?mG8tAFgdfNgbDjvfJdNIEegkeWiCUAqbJb1OO6UlnCNmfaz44ed0EoHs?=
 =?Windows-1252?Q?Lw3ehw/AzUXWG1bgVeobpEPrnIeuu+2H+Qoe8e8dyjdxl94zLi/fpVZX?=
 =?Windows-1252?Q?Q2V3ubgoOAkooXoP9IxGmDUTehUyKE4msSoxkrbjHbTu8+1rcd9kPkSw?=
 =?Windows-1252?Q?3WxqaG6YAhWc5tjYzPRS8EJ1IU8bD5lUIv6hbiopUlAGbNR7i7GMuxOn?=
 =?Windows-1252?Q?x3dGRc92cNHYmdXkHugpeKeiuSVL6tPfY+YVtelJ3fwo4KJsNPXJhb+i?=
 =?Windows-1252?Q?tUKmv5TlE6vsZpqKc7IWf/u2uvRVittPRHoS3bMSTOJ33LHM8pp2uD18?=
 =?Windows-1252?Q?nWCNjaw4h2MEk8VIyzmajyyEi7tNMkfwq9b9BKjHyv6/MgIIxEsgkVkb?=
 =?Windows-1252?Q?YoN0CSy8+/bhHkEDv+1L14XcPJnr2AXJ3y8EJqW5I36/jhwWih83dsXZ?=
 =?Windows-1252?Q?xSB20ohArDmK0VkdGM2ZZHTPwu27NNL3TqgMR8yQTAh5OV4i6v8BAR33?=
 =?Windows-1252?Q?9O73vAK4LnBzpyXLpiVfUpoT7NYapVkghGXGhIf+54qrHZCLbNBqMc9o?=
 =?Windows-1252?Q?6MnmyoyooEafS+0UAsL9yQVusG1aBNqYhFTlNL0eWqOa28HoVt7zDwcI?=
 =?Windows-1252?Q?TxHgyU+dss0J5iHrSbO6AueJj0yiVIU7rRxnOSKKTS5Dir8ddS924GKM?=
 =?Windows-1252?Q?psXzUKlX1WvC0Aa448qr8ZlDZNvNGBWc7JTrcbkwMwtgBwVFJIYIXik9?=
 =?Windows-1252?Q?uHP2s4nrHP0cRDD9dvN4zG3yK4prEEe5g4Tk/QQQCmHb6k2iWNEx0rWX?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8687fc00-c643-4548-370e-08d8ed54527f
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 17:02:49.2108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XR0LiUydgyX7sehGyAWDGpYxtHozRJkxFpCGlKcnPeSdhsZVnyyBbCqcaTE92xh+BFZoGhDkE1DWU4d07QCytw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5716
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, JMQ_SPF_NEUTRAL,
 MSGID_FROM_MTA_HEADER, NICE_REPLY_A, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Mon, 22 Mar 2021 17:02:53 -0000

[Still CC Marco]

On 3/22/2021 7:43 AM, Corinna Vinschen via Cygwin-patches wrote:
> [CC Marco]
> 
> On Mar 22 08:07, Takashi Yano via Cygwin-patches wrote:
>> On Sun, 21 Mar 2021 17:44:27 +0900
>> Takashi Yano wrote:
>>> On Sun, 21 Mar 2021 13:01:24 +0900
>>> Takashi Yano wrote:
>>>> Takashi Yano (2):
>>>>    Cygwin: syscalls.cc: Make _get_osfhandle() return appropriate handle.
>>>>    Cygwin: pty: Add hook for GetStdHandle() to return appropriate handle.
>>>>
>>>>   winsup/cygwin/fhandler_tty.cc | 19 +++++++++++++++++++
>>>>   winsup/cygwin/syscalls.cc     | 13 ++++++++++++-
>>>>   2 files changed, 31 insertions(+), 1 deletion(-)
>>>
>>> I submitted these patches, however, I still wonder if we really
>>> need these patches. I cannot imagine the situation where handle
>>> itself is needed rather than file descriptor.
>>>
>>> However, following cygwin apps/dlls call _get_osfhandle():
>>> ccmake.exe
>>> cmake.exe
>>> cpack.exe
>>> ctest.exe
>>> ddrescue.exe
>>>
>>> And also, following cygwin apps/dlls call GetStdHandle():
>>> ccmake.exe
>>> cmake.exe
>>> cpack.exe
>>> ctest.exe
>>> run.exe
>>> cygusb0.dll
>>> tk86.dll
>>>
>>> in my installation.
>>>
>>> Therefore, some of these apps/dlls may need these patches...
>>
>> I looked into cmake source and found the patch exactly for
>> this issue. Therefore, it seems better to fix this.
>>
>> /* Get the Windows handle for a FILE stream.  */
>> static HANDLE kwsysTerminalGetStreamHandle(FILE* stream)
>> {
>>    /* Get the C-library file descriptor from the stream.  */
>>    int fd = fileno(stream);
>>
>> #  if defined(__CYGWIN__)
>>    /* Cygwin seems to have an extra pipe level.  If the file descriptor
>>       corresponds to stdout or stderr then obtain the matching windows
>>       handle directly.  */
>>    if (fd == fileno(stdout)) {
>>      return GetStdHandle(STD_OUTPUT_HANDLE);
>>    } else if (fd == fileno(stderr)) {
>>      return GetStdHandle(STD_ERROR_HANDLE);
>>    }
>> #  endif
>>
>>    /* Get the underlying Windows handle for the descriptor.  */
>>    return (HANDLE)_get_osfhandle(fd);
>> }
> 
> Why on earth is cmake using Windows functions on Cygwin at all???
> It's not as if it actually requires Windows functionality on our
> platform.

Out of curiosity, I took a quick glance at the cmake code.  It appears that this 
code is designed to support running cmake in a Console.  I don't think that 
should be needed any more, if it ever was.

> Marco, any input?  Any chance to drop this Windows stuff from the Cygwin
> code path in cmake?

I think the following might suffice (untested):

--- a/Source/kwsys/Terminal.c
+++ b/Source/kwsys/Terminal.c
@@ -10,7 +10,7 @@
  #endif

  /* Configure support for this platform.  */
-#if defined(_WIN32) || defined(__CYGWIN__)
+#if defined(_WIN32)
  #  define KWSYS_TERMINAL_SUPPORT_CONSOLE
  #endif
  #if !defined(_WIN32)

Ken
