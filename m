Return-Path: <kbrown@cornell.edu>
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2108.outbound.protection.outlook.com [40.107.236.108])
 by sourceware.org (Postfix) with ESMTPS id 552CF385800F
 for <cygwin-patches@cygwin.com>; Thu, 28 Jan 2021 13:42:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 552CF385800F
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/QSIU850Ptiq4HpbLKAhY4SecxlzERgFFtl8kpD2IXCvMCC0ijXKFNwvqV0JvoBjHKyaNlstdm5H63USZcklKCGgDqw5rZL9ZnJDfVy9dAqwIebgAN68cFi7DInxLfi1BD00AIsr3Tv7gjACqVIlQwBGrPXrTmjA7lFRextTdbJ2HxqekMzHGvYFXzrP2Qk6A7+gw9ZaScH+DJozp7xRcNHHYmbp3j36D5Y1JwiXEtcEPz4Zn7Bz/yKN7Hyxhu3azwVO0ZL/ebuD87Vdz0Oi86a9bHO5oZraMAKd9okXYjTM3DPPQiLA4jFTPjll7c0/+FjMmyHp2FqxgnyqQKtcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8rfjT7MtdMaXZFX7IJQRfmwc1C8D88pwd/BVEoCXrE=;
 b=LACMTw8vGpNUyLB4kKGFcvqNp91Z2fw/NSOJiXN1sn9k8H0CElOzOOctSbAT3xZ5OsrORRrU9xiEMklZXhdms2F+xfubI+AUsuCDr9ofuljA+dInTPEUJAzYfW5QOnZeBjL7LfhrYzf7we3muRxKmeuxWxmof/08B63qzE0r5LV43vWmLsOgJnYPZtgudqV2fMmXt0Qe5UlymTAkDwoQJ1C34ta0zziJ0tKamJqZiCa4ycZ/OAl5OdGSFUgp+GIirqpTPZvEMIaH5mFCKK1pOyzfgM1nKv/kQoA8wARFIbFWEV2voGfPBy6W5LM9uhLpb/gL1j7v5I2yKA1Gl7dGKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN6PR04MB0866.namprd04.prod.outlook.com (2603:10b6:405:44::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Thu, 28 Jan
 2021 13:42:40 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%6]) with mapi id 15.20.3784.017; Thu, 28 Jan 2021
 13:42:40 +0000
Subject: Re: [PATCH] Cygwin: getdtablesize: always return OPEN_MAX_MAX
To: cygwin-patches@cygwin.com
References: <20210128025150.46708-1-kbrown@cornell.edu>
 <20210128102029.GY4393@calimero.vinschen.de>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <151a4199-92f2-43aa-dd91-5d86c2e1d3c6@cornell.edu>
Date: Thu, 28 Jan 2021 08:42:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20210128102029.GY4393@calimero.vinschen.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [65.112.130.200]
X-ClientProxiedBy: BN0PR04CA0105.namprd04.prod.outlook.com
 (2603:10b6:408:ec::20) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.13.22.4] (65.112.130.200) by
 BN0PR04CA0105.namprd04.prod.outlook.com (2603:10b6:408:ec::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.17 via Frontend Transport; Thu, 28 Jan 2021 13:42:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10fc8b5e-2851-4e4a-21ad-08d8c3929476
X-MS-TrafficTypeDiagnostic: BN6PR04MB0866:
X-Microsoft-Antispam-PRVS: <BN6PR04MB086656483F6A2ECD7506DB5BD8BA9@BN6PR04MB0866.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cmzn6SiVGR/ndE+cISVg93JeZNq2mGy0BSRP8p4A2lIVHy69Y6dgUoqLupYNRSANeB3qpyvQNLp/SXTHf99noOE9XCasVzzNAVRyg9rkSzedfBktNyJNohnzhRFDoqOimuvnmG4IsbsrWmjOmsaGSCY07e9Lm5FcrC/l/djbt9KLbn+lt1BgtfP0DEODQX//hTXENpYQRlBuIDK+WCEn9kg9w6BLv9lL0VC3Elmnrj7lqY3ARzCeGb5OACJTIu22AQbwCxJNBXdkq9cf0Upl1JyIMfwwPHYmhjOxQ5mzGXtfvRDDnj1423pBQuY68Ddrd57eRCOSZ75VK4ogKVWWAR7SI73Bwl7ytl+nFZJ1g8maaHwUwZFju+f6M38dFr/NN/X3OLX6cSp5SulvLq9VPmEftMhNYul/6M2dGuOnY6IGuDQtNgWVP822AIqyBsryU91BTwtPbQoFmY94Pl2DcOka+6wm5tP4NoIwKO8uFnY4k4Na0ptPUMQ5S1QyBfr5QhFPeJgpksrlkp8Ayf7ZlVB25m7J1h1+fihqSSB+da1+4m2GszV+7woxzuG5RU9kJ8Sj5do43wCPudDU4JoIiTga8yAAzIx+9ejJwz/d+ZM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(956004)(786003)(66556008)(2616005)(26005)(66476007)(16576012)(86362001)(53546011)(52116002)(66946007)(31686004)(186003)(316002)(16526019)(5660300002)(478600001)(83380400001)(31696002)(8676002)(6916009)(8936002)(6486002)(36756003)(2906002)(75432002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?HujG2Mu0phtVGF1ohD9KI3ls/aObzztTzhZ0hLXemsMJJw+JY3Mdw6BN?=
 =?Windows-1252?Q?Ae4PEhf9meCWtVKEalugsYU2DdsBu3yrFQPV956ppy5XGBV/oWzgm6O0?=
 =?Windows-1252?Q?/8NX1IoWnp0r/JPrAIw/U8QTCDb4/7V9y566mtBFmGBN0HOjKBIo+xC0?=
 =?Windows-1252?Q?5Nx1QrmCPLP8hKy+hzpLegldftBBKSNJTpvG3TPM9vZhqLQ0zDeOuZW5?=
 =?Windows-1252?Q?Rd0PmSNopx0IstBcN98hr9elTPkz1PCBrlTLR0NUXYv9MDiKOYZBrTM0?=
 =?Windows-1252?Q?6wx0ho71JrSe21PLChOPAz8uFTRmQuGHepBTQJTgNV5Wvaad/sik8IwH?=
 =?Windows-1252?Q?SSht4k4kLos927U7lAkDfq42sJ5twXYHE50mULv35UWOMRXy0PK6s6vV?=
 =?Windows-1252?Q?I68spstx0m7gz3QWicwVrvvXzVvoSuHNYpIUSPkruaMe3CtfdT7VlJTk?=
 =?Windows-1252?Q?rpyqkNX6yJeT76kmFxeT0CPS8klblnKDW5Sc8v7CLtZHWRk1CUwtXGJV?=
 =?Windows-1252?Q?RZ2XS6Ji6iAXjAMYs/YRXOJf1AEIZ+eHCUrCZY+W1GNBWFF+xo+mhtfH?=
 =?Windows-1252?Q?YdGlxz1/+9npRpd+PfYBEngrkmTwjqWIs9/F2PepkRz4KBFoboM6pf7G?=
 =?Windows-1252?Q?sHNgMFjzMwI9KE3wDNa0ROwS31gtofpbOoXN5IcCfqlQ7mXSuOm3kdjR?=
 =?Windows-1252?Q?CCT1JzE3nFM0DvDSSyr2q8gv4zQ3oIsqkM9Dplsj84P4GRdj5p7hRHxZ?=
 =?Windows-1252?Q?fLvpffU+6KQ4zJvDxn5GHorPJuRnLPktTrNFesTEDPmn2VE0RcJgtcYn?=
 =?Windows-1252?Q?qEYsb9vKFn8H/7oHvSGbWcMqZHDQF43fY4jhSmmIGMwIBZjvcfF7UkPF?=
 =?Windows-1252?Q?k2Zd3tMKuQ2EZYkMaBrsehxlScL6crzu+xWh/Jyh4DzLQukSSXxSHjvB?=
 =?Windows-1252?Q?uRPWWYt1q2GbW8rQLFVd0cmyEnvW5pM9Z0pMYINfazBNlG7jnJsdnhyg?=
 =?Windows-1252?Q?rY3dWynwBTt5P1moyShNQeWCTyQ5SYA26Sc8kYRQEM9Ai0ft+b1D34QA?=
 =?Windows-1252?Q?a5jgwT5TNDzNljnoosjDvXQhoPR3TAc1k7/z8z0UBGlBpEhTIs6vudPc?=
 =?Windows-1252?Q?4V6ywgpVg3ED2KzWVEEgNj3S?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 10fc8b5e-2851-4e4a-21ad-08d8c3929476
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2021 13:42:40.1623 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iv8YZ/WC4VSLXDKpj/FX7PTJGkJMWceY6/RKChvjlHgyIAfIqjpszlJZw0NtKemIDa85sodYVEtTOro/1XRobg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0866
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, MSGID_FROM_MTA_HEADER,
 NICE_REPLY_A, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Thu, 28 Jan 2021 13:42:46 -0000

On 1/28/2021 5:20 AM, Corinna Vinschen via Cygwin-patches wrote:
> On Jan 27 21:51, Ken Brown via Cygwin-patches wrote:
>> According to the Linux man page for getdtablesize(3), the latter is
>> supposed to return "the maximum number of files a process can have
>> open, one more than the largest possible value for a file descriptor."
>> The constant OPEN_MAX_MAX is the only limit enforced by Cygwin, so we
>> now return that.
>>
>> Previously getdtablesize returned the current size of cygheap->fdtab,
>> Cygwin's internal file descriptor table.  But this is a dynamically
>> growing table, and its current size does not reflect an actual limit
>> on the number of open files.
>>
>> With this change, gnulib now reports that getdtablesize and
>> fcntl(F_DUPFD) work on Cygwin.  Packages like GNU tar that use the
>> corresponding gnulib modules will no longer use gnulib replacements on
>> Cygwin.
>> ---
>>   winsup/cygwin/syscalls.cc | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
>> index 5da05b18a..1f16d54b9 100644
>> --- a/winsup/cygwin/syscalls.cc
>> +++ b/winsup/cygwin/syscalls.cc
>> @@ -2887,7 +2887,7 @@ setdtablesize (int size)
>>   extern "C" int
>>   getdtablesize ()
>>   {
>> -  return cygheap->fdtab.size;
>> +  return OPEN_MAX_MAX;
>>   }
> 
> getdtablesize is used internally, too.  After this change, the values
> returned by sysconf and getrlimit should be revisited as well.

They will now return OPEN_MAX_MAX, as I think they should.  The only question in 
my mind is whether to simplify the code by removing the calls to getdtablesize, 
something like this (untested):

diff --git a/winsup/cygwin/resource.cc b/winsup/cygwin/resource.cc
index 9e39d3a04..ac56acf8c 100644
--- a/winsup/cygwin/resource.cc
+++ b/winsup/cygwin/resource.cc
@@ -182,10 +182,7 @@ getrlimit (int resource, struct rlimit *rlp)
           __get_rlimit_stack (rlp);
           break;
         case RLIMIT_NOFILE:
-         rlp->rlim_cur = getdtablesize ();
-         if (rlp->rlim_cur < OPEN_MAX)
-           rlp->rlim_cur = OPEN_MAX;
-         rlp->rlim_max = OPEN_MAX_MAX;
+         rlp->rlim_cur = rlp->rlim_max = OPEN_MAX_MAX;
           break;
         case RLIMIT_CORE:
           rlp->rlim_cur = cygheap->rlim_core;
diff --git a/winsup/cygwin/sysconf.cc b/winsup/cygwin/sysconf.cc
index 001da96ad..d5d82bb4a 100644
--- a/winsup/cygwin/sysconf.cc
+++ b/winsup/cygwin/sysconf.cc
@@ -21,15 +21,6 @@ details. */
  #include "cpuid.h"
  #include "clock.h"

-static long
-get_open_max (int in)
-{
-  long max = getdtablesize ();
-  if (max < OPEN_MAX)
-    max = OPEN_MAX;
-  return max;
-}
-
  static long
  get_page_size (int in)
  {
@@ -520,7 +511,7 @@ static struct
    {cons, {c:CHILD_MAX}},               /*   1, _SC_CHILD_MAX */
    {cons, {c:CLOCKS_PER_SEC}},          /*   2, _SC_CLK_TCK */
    {cons, {c:NGROUPS_MAX}},             /*   3, _SC_NGROUPS_MAX */
-  {func, {f:get_open_max}},            /*   4, _SC_OPEN_MAX */
+  {cons, {c:OPEN_MAX_MAX}},            /*   4, _SC_OPEN_MAX */
    {cons, {c:_POSIX_JOB_CONTROL}},      /*   5, _SC_JOB_CONTROL */
    {cons, {c:_POSIX_SAVED_IDS}},                /*   6, _SC_SAVED_IDS */
    {cons, {c:_POSIX_VERSION}},          /*   7, _SC_VERSION */

WDYT?

Ken
