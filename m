Return-Path: <kbrown@cornell.edu>
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2130.outbound.protection.outlook.com [40.107.236.130])
 by sourceware.org (Postfix) with ESMTPS id A6E4A3851C03
 for <cygwin-patches@cygwin.com>; Mon, 18 May 2020 17:42:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A6E4A3851C03
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDbcJ1aNfK6KzTvCRmInFNoGVe9CFplcerVxnBeyCbPHTVmCl2227p35Lqosxhn4A79C+pg//ZLSTxw6Zn6F9jNOZppHci+b9Z4tWObwU45lWl5JXbKeyTnQE3AUouqL+/nxdE8ztstt64aZHjz7m+n+1efqE1MbVRUEojscuFHuKQ86ltTPqFbsN4K2xK9QabU/FSUgfHcSc3xZgV3vvea4j4kF2EDp1krv7tM8CxMbVdQ8OJe4CvY+wogEhpAEicC37/A7NIV2rUXWNII2m4/jkmyPiJc/J2qTgZnScUHVUsZJ7UCrl2TCMC6Hjz0qlPFYgVGgvKKPrUHRtZpjaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YF5UndTZR7khcFT54ybk4+4F92yeK7Uf0jguBJ8mUY=;
 b=TtTFLZ6+Vymj6noUBCiZTMqhBtb7+/zz6M2uQ/XKpbp3RU4cpYGr6Ini5pAeFgGBRdlMpw00eAo7cM+PICqG1g/BcgD3Eo3BTlHc6qo+pYGN5hgo5/rJRnyugPzOxvxqDhCPlKQgivCT/HhuxUYO9ufbt2kqFiald+Yrx2+ZX69oZfoatNDHwAVO25nGNnI4qxosh3nQwJ6E3nAf5wXYqlajOJNhukMOwck0Zij3R0YUN6U3is2K++uCJX+mgLBDausToqXEAcF9qpAiifsUfkXFTuK0LGVl7ZcAvgLM9xs4M9I2N7xqSWjkv9+53Rg8km/2FYEQFqGZibeV2AYrUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from DM6PR04MB6075.namprd04.prod.outlook.com (2603:10b6:5:127::31)
 by DM6PR04MB4825.namprd04.prod.outlook.com (2603:10b6:5:1f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Mon, 18 May
 2020 17:42:21 +0000
Received: from DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4]) by DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4%4]) with mapi id 15.20.3000.022; Mon, 18 May 2020
 17:42:21 +0000
Subject: Re: [PATCH 00/21] FIFO: Support multiple readers
References: <20200507202124.1463-1-kbrown@cornell.edu>
 <20200518142519.cb6d805fa92afe4dcb017b02@nifty.ne.jp>
 <20200518143657.4e9f732f5456174348688f69@nifty.ne.jp>
 <912d46fc-3138-f3ec-f4d1-612433d9f128@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <cd2e382e-1c32-864a-31a4-8a6b7cfffc08@cornell.edu>
Date: Mon, 18 May 2020 13:42:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <912d46fc-3138-f3ec-f4d1-612433d9f128@cornell.edu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR18CA0002.namprd18.prod.outlook.com
 (2603:10b6:610:4f::12) To DM6PR04MB6075.namprd04.prod.outlook.com
 (2603:10b6:5:127::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2604:6000:b407:7f00:650a:68f2:73c8:4345]
 (2604:6000:b407:7f00:650a:68f2:73c8:4345) by
 CH2PR18CA0002.namprd18.prod.outlook.com (2603:10b6:610:4f::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Mon, 18 May 2020 17:42:21 +0000
X-Originating-IP: [2604:6000:b407:7f00:650a:68f2:73c8:4345]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b046f71-d750-4439-f5a4-08d7fb52d156
X-MS-TrafficTypeDiagnostic: DM6PR04MB4825:
X-Microsoft-Antispam-PRVS: <DM6PR04MB4825E58D3467B88D6A1F3643D8B80@DM6PR04MB4825.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 04073E895A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZyWmGR0LbYzr65tqg4a40NVnVhi5qJL0ntK2+Xlbw309PUeJf9ETqIq/F1HUpR3Wps3VzhzzUDB5lOJu3gYVg6o7MA7LD4GwSZqmx/bn3Yh/BvPvDKNKuRLEAune/2pnmW3W9G95SmXEMDzrOxREzERC70FaEL2Lk1soIYE6tvIFmgfXgTpwvvx6IMhb1e6MuBD4148AJUjsJ6QibtHi3GQ3sY67J7Rxdc3RG+J1w39sxI7Qujb1Vq0aVFy3stxQvLsFbB8LZZJzynlwBS5Lw2f8u9BvwQx3wwDhPgzREGPYtpNrnIEdFVlIOVPIs6XatHUpHcjJ46Q6AVZddsgauP4rXEN9fwS6ncb8GZPNij3NdchRECXlf76h0Bxkp/pEUMCvxsjQUQmnuHU2h2bErJ48hiWJdvk9C5+sIfR+cwqyoUg7NEMYZaHIqC0SYbfSN3VmpNmqiJCUfmjK5Sr0qVoF0YNosBXMJiJZaMR2aGpPYU8XXAUCj/jAq/Uoh0ZG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6075.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(8936002)(16526019)(186003)(8676002)(5660300002)(2906002)(86362001)(66946007)(31696002)(6486002)(6916009)(2616005)(66556008)(31686004)(66476007)(53546011)(786003)(316002)(478600001)(75432002)(52116002)(36756003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 5D6QM/7ce3fYUoZUD+eC9H9eiCYTLhcqFhffrDoIx5Cs5iq4yHsqYYhz3T2Dt3tcsVY1Ur4FXDc/0aEoYiS9nRWW98XfpXOIbS1xPO/6Fk44Xl/6aS1AzQX1CLT3yvh+hyhAuzoGcmEIePepkz9JYsRhaADp5xnppCVrlD91lASjmJNMlE9KSyYeTHI1RCpTUwPaa1Dm/8HhYd29++NaTafblG81n1MILk0KwhxgasrAsxvowBFKyK6tAM4/ICZqUGdu6K2KNg2bp2S9cgw/IgyLTQjy3W6xlTu4oD+hp7uciqiTR80wLJ/+HoIZbc1Y7wDDPvp6oZcL6H56CqX19LU2UE+jkHoxrDynp5dOIUMPCNw3TPA3Xv/CMIYeq3MOLeFINlx9HE6G+qJYoxBla+igzhcSHucubzNW2UizErssH+2BRlKqysF6pHucJN5pwixgXEAFbWhnSQT2daJimRYBEGqYkXMTrxso0hdMRe8pktAh36hl287kPYJCAm7hTDqCa+iqF0Ur18aPmKOGRud4DLUVIpdQ/eEQgI6wLVk=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b046f71-d750-4439-f5a4-08d7fb52d156
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2020 17:42:21.5870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HEUaf0PUz9WrXpVlUFimMwn2pjqMnXxa4uUY2oIoFyDTsqnpAGeH1lQq/O4AX2JicsPvht9PAkk/dtwUyaSF/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4825
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00, DKIM_INVALID,
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
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 18 May 2020 17:42:26 -0000

Hi Takashi,

On 5/18/2020 12:03 PM, Ken Brown via Cygwin-patches wrote:
> On 5/18/2020 1:36 AM, Takashi Yano via Cygwin-patches wrote:
>> On Mon, 18 May 2020 14:25:19 +0900
>> Takashi Yano via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
>>> However, mc hangs by several operations.
>>>
>>> To reproduce this:
>>> 1. Start mc with 'env SHELL=tcsh mc -a'
>>
>> I mean 'env SHELL=/bin/tcsh mc -a'
>>
>>> 2. Select a file using up/down cursor keys.
>>> 3. Press F3 (View) key.
> 
> Thanks for the report.  I can reproduce the problem and will look into it.

I'm not convinced that this is a FIFO bug.  I tried two things.

1. I attached gdb to mc while it was hanging and got the following backtrace 
(abbreviated):

#1  0x00007ff901638037 in WaitForMultipleObjectsEx ()
#2  0x00007ff901637f1e in WaitForMultipleObjects ()
#3  0x0000000180048df5 in cygwait () at ...winsup/cygwin/cygwait.cc:75
#4  0x000000018019b1c0 in wait4 () at ...winsup/cygwin/wait.cc:80
#5  0x000000018019afea in waitpid () at ...winsup/cygwin/wait.cc:28
#6  0x000000018017d2d8 in pclose () at ...winsup/cygwin/syscalls.cc:4627
#7  0x000000018015943b in _sigfe () at sigfe.s:35
#8  0x000000010040d002 in get_popen_information () at filemanager/ext.c:561
[...]

So pclose is blocking after calling waitpid.  As far as I can tell from looking 
at backtraces of all threads, there are no FIFOs open.

2. I ran mc under strace (after exporting SHELL=/bin/tcsh), and I didn't see 
anything suspicious involving FIFOs.  But I saw many EBADF errors from fstat and 
close that don't appear to be related to FIFOs.

So my best guess at this point is that the FIFO changes just exposed some 
unrelated bug(s).

Prior to the FIFO changes, mc would get an error when it tried to open tcsh_fifo 
the second time, and it would then set

   mc_global.tty.use_subshell = FALSE;

see the mc source file subshell/common.c:1087.

Ken
