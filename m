Return-Path: <kbrown@cornell.edu>
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2123.outbound.protection.outlook.com [40.107.92.123])
 by sourceware.org (Postfix) with ESMTPS id 7649F385783D
 for <cygwin-patches@cygwin.com>; Thu, 28 Jan 2021 20:33:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 7649F385783D
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8h+Vwaj39XAh9Uo2BAH6L6trMwNc9L1AVAsdSfBs/I/SozHNbnieZxL6fluWQUvUMSkYxvWx+HqIgNPORfDCa4X4NNqak3eahbAkkJDEA3nK8YDugWiEf2sJXv/WCjm2Pkj5famCASVGaeuoMizLK5S14zPj8oF3H1fwbkAfCnPjKIooIk27G7BpdmeOsk+cF0QpPZaYrdubQ3bFoxlmJ4ss2ExyUWVa9EJT4hsOi4yoIWqfYlqvYxg32dIE9uwSWu6DqaF7iOuBteRbzLbVNnYtPuFnbDNTTZMOo5gtpfkVbu08i6iJXS53R4phx5lTxPRm4Liry6Q9UEeroNfVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvjF/jfsak1Z32RyWfHGOqlhrXfkCzgnwrMv9lUel/c=;
 b=T3uS/MJxOdU9dF1d5v7Q6SDggAFapoSbddr0LEd2Cjy+9BOZNNKFQT8kPsE/E/DowgmPPHkt2O3cSgm3KOz33dGFg1W8AsQYeXznbGjCp4LCJSuc669uYg4e6mCMyF3b9YuAO3DGirNR74RgrzjaiihZA7L2ZjBUmdHGgnWrFLgej8HemjOPpWpby6T81CtE2QK14S34MZMDtT0ioZXFJ5TLrHtJZAsmpETWhNuL7i0IYJZxp/7xOvKd/FbOu0PmgxzKOWH1bz4vuPzPiIK1LTTPZ55NMHULCNP4h9CUslbQTLDhY2R5zV+hzXgFsn08rfLqdNBYo8cwdxnTWHyJsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN6PR04MB0435.namprd04.prod.outlook.com (2603:10b6:404:92::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Thu, 28 Jan
 2021 20:33:42 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%6]) with mapi id 15.20.3784.017; Thu, 28 Jan 2021
 20:33:41 +0000
Subject: Re: [PATCH] Cygwin: getdtablesize: always return OPEN_MAX_MAX
To: cygwin-patches@cygwin.com
References: <20210128025150.46708-1-kbrown@cornell.edu>
 <20210128102029.GY4393@calimero.vinschen.de>
 <151a4199-92f2-43aa-dd91-5d86c2e1d3c6@cornell.edu>
 <20210128160749.GB4393@calimero.vinschen.de>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <9b430aa5-1033-ebef-b002-b1523355271c@cornell.edu>
Date: Thu, 28 Jan 2021 15:33:39 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20210128160749.GB4393@calimero.vinschen.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [65.112.130.200]
X-ClientProxiedBy: BN6PR11CA0056.namprd11.prod.outlook.com
 (2603:10b6:404:f7::18) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.13.22.4] (65.112.130.200) by
 BN6PR11CA0056.namprd11.prod.outlook.com (2603:10b6:404:f7::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.17 via Frontend Transport; Thu, 28 Jan 2021 20:33:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad16ac5a-1599-4d7f-10b1-08d8c3cc0010
X-MS-TrafficTypeDiagnostic: BN6PR04MB0435:
X-Microsoft-Antispam-PRVS: <BN6PR04MB043524492C8244F21F982503D8BA9@BN6PR04MB0435.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WuOgRWFIT6BJX4XNHz200Mmo26Z6PxrAaumGoddCGDiSAWhcLvf1uZswiWILjqdMSWgNkoxH87ehD7mLwekxg3lJ7JiTwsYc2wSYnPri7YQWhLDcnQD4Jtk9/OHYEmGVi7AUhDPKGXdVDiyC04EjSabaP1L95spX9NmY9PK2YKgWt1N3/vFjwk9N2ztKd1dhy/6VN1nD/MZRvuzoFYcwTHZAJBdblF+VgK3tCpKQ/zeQPwoGjfkJSN8c8AAbQo2y+9aM926IyTlrDWXgYXZ6aWvzxqF6QNQT36fpMwS4ko9SVIqBTQVq8VAYi2CIBevf5eRCEAlrndTh8m7Di2srdUESlk5ykj4W4mweI0V0Na5Jfu5aM05XIFixi0kAFSc6xGTanHcIctfaECBBIMHdcR1YeInOiclHC/JCpADgFGwvFpuE+GCyXRakIAM0jA57P3giRpo2+zofZC7TPLqLRAhm6P4i5R1Eb7ShYG1xNuZ2/2es84ra2tc9xS26qs3bdeBt23z6BB0HXUMnOje7ljtg+vvVw/Gsm9OoZdK6b6gXp6fEyCVtT/gdqw7U03nLEXyiB2TdZnd1XKYAQCbyFCXtbZA1qwFzI/5IgRASYzs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(8676002)(83380400001)(31696002)(6916009)(2906002)(6486002)(8936002)(36756003)(16576012)(66946007)(26005)(86362001)(52116002)(956004)(786003)(66476007)(66556008)(2616005)(316002)(478600001)(186003)(75432002)(16526019)(5660300002)(53546011)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?B33JVI7ki/8cIcIbxi+Pnq3p5NQJPOn0CW81v+fPV+oqesMNXdY0Ff0/?=
 =?Windows-1252?Q?OqddGNAF7KTS/qeERYgpUCS/P6+ejg/+79orvQVNq/DwpMYYNo/LzZVI?=
 =?Windows-1252?Q?BI0ZCTn4sq5SO0CKKgpEpSVFZIyB0HDCQa43fG5iHAfV19Ec8dREHKZP?=
 =?Windows-1252?Q?+0/WQeUvOFOSXtt9UqR2o8FkJtA9WDcoR3IVQJzp+9Fni7olY6v1GGiz?=
 =?Windows-1252?Q?TIAOCnb02h8FA3kEB9pkR3gCQ3M5Lj3yl5qVDS7GPutZe6nGhPmr9ibA?=
 =?Windows-1252?Q?kZiRfUOHU81Rki6cYCiEARI94xczORObjmmJ0RRzaqjuZG6l/EPv7VdV?=
 =?Windows-1252?Q?wPRg2IpCBjYruGjD2zka7zA8Wd8YyqI3hltJCHgvoFrmKqnulozMH7ZE?=
 =?Windows-1252?Q?KJQdPOzAZorq7Iy6/Lvc0zhD9+ORlATaMkldPKUPtQeY87TIzW/LpS/c?=
 =?Windows-1252?Q?wQnLi8CzUDNwDfWqa3VBuRF1nbHNXR/nNtlmZY0DJMtyt5LvukCUVuC1?=
 =?Windows-1252?Q?T8jlr0kJwPmauwiFHU651AogoSbVePF9rGLNRN1XROyGbV5WmUJfkZJB?=
 =?Windows-1252?Q?ARTiyqcBplgKQW8aB1xY61KsfXUdSch/4V7hijrgSzAnovLcmLUZGbS/?=
 =?Windows-1252?Q?1WqOhoIUNb9mBDeNBoepwk9LnC6GzEPTewJ0VtNDm5o9x1l22/U7WQnW?=
 =?Windows-1252?Q?QQDppDci9Tcqmv9owsyQughIoiPbVgJsW7BKBnOdo4e/ld0vIVoYrHsH?=
 =?Windows-1252?Q?/4klC5seE3ndQsxerAsAV8c/Yo0GYX/huBJ+GDERoD140wOXptEXhfW9?=
 =?Windows-1252?Q?GYBSIDTkBUI1YjBYgdftb5cNI4NPn9sBZ+ykZ4INfYKD+AyMpFekGsZS?=
 =?Windows-1252?Q?k/6ZfcMzO4IUqrCq8TQ78LNWXxX4whxu/b8tcTqq3g25vE7nuzKT4HDV?=
 =?Windows-1252?Q?N/Hb2J7MM5YCs1O0fZ3/2KKqvnE86nyBNfPqsfWcj6xhw9pZYCHUkU/Y?=
 =?Windows-1252?Q?FSXlC1i0x+e9EGKRFp6/+6ju/9uIjuu89zuEK9WJUcgw9jr/TsTdn97B?=
 =?Windows-1252?Q?QgHi1KL1qHkCBK+h/cBXZWeOJbKyc0SHx4jYv/Z2h+OhucU1Gy5u9eJ5?=
 =?Windows-1252?Q?6FYqHB+L/pASvUrzgL8jqK80?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: ad16ac5a-1599-4d7f-10b1-08d8c3cc0010
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2021 20:33:41.6651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8PfADPTnXxCWQuXohsD4uJImOCNTQHV6awTVE64cvu4Enr2t8p9EWe04uHExSfbaNhrE7C/r/7RKhzB8Srlbng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0435
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 28 Jan 2021 20:33:45 -0000

On 1/28/2021 11:07 AM, Corinna Vinschen via Cygwin-patches wrote:
> On Jan 28 08:42, Ken Brown via Cygwin-patches wrote:
>> On 1/28/2021 5:20 AM, Corinna Vinschen via Cygwin-patches wrote:
>>> On Jan 27 21:51, Ken Brown via Cygwin-patches wrote:
>>>> According to the Linux man page for getdtablesize(3), the latter is
>>>> supposed to return "the maximum number of files a process can have
>>>> open, one more than the largest possible value for a file descriptor."
>>>> The constant OPEN_MAX_MAX is the only limit enforced by Cygwin, so we
>>>> now return that.
>>>>
>>>> Previously getdtablesize returned the current size of cygheap->fdtab,
>>>> Cygwin's internal file descriptor table.  But this is a dynamically
>>>> growing table, and its current size does not reflect an actual limit
>>>> on the number of open files.
>>>>
>>>> With this change, gnulib now reports that getdtablesize and
>>>> fcntl(F_DUPFD) work on Cygwin.  Packages like GNU tar that use the
>>>> corresponding gnulib modules will no longer use gnulib replacements on
>>>> Cygwin.
>>>> ---
>>>>    winsup/cygwin/syscalls.cc | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
>>>> index 5da05b18a..1f16d54b9 100644
>>>> --- a/winsup/cygwin/syscalls.cc
>>>> +++ b/winsup/cygwin/syscalls.cc
>>>> @@ -2887,7 +2887,7 @@ setdtablesize (int size)
>>>>    extern "C" int
>>>>    getdtablesize ()
>>>>    {
>>>> -  return cygheap->fdtab.size;
>>>> +  return OPEN_MAX_MAX;
>>>>    }
>>>
>>> getdtablesize is used internally, too.  After this change, the values
>>> returned by sysconf and getrlimit should be revisited as well.
>>
>> They will now return OPEN_MAX_MAX, as I think they should.  The only
>> question in my mind is whether to simplify the code by removing the calls to
>> getdtablesize, something like this (untested):
> 
> But then again, what happens with OPEN_MAX in limits.h?  Linux removed
> it entirely.  Given we have such a limit and it's not flexible as on
> Linux, should we go ahead, drop OPEN_MAX_MAX entirely and define
> OPEN_MAX as 3200?

Makes sense to me.

> One problem is that there are some applications in the wild which run
> loops up to either sysconf(_SC_OPEN_MAX) or OPEN_MAX to handle open
> descriptors.  tcsh is one of them.  It may slow done tcsh quite a bit
> if the loop runs to 3200 now every time.

I don't use tcsh.  Is it easy to test this?

Ken
