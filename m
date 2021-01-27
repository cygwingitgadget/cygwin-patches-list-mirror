Return-Path: <kbrown@cornell.edu>
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2112.outbound.protection.outlook.com [40.107.243.112])
 by sourceware.org (Postfix) with ESMTPS id ECB86386F404
 for <cygwin-patches@cygwin.com>; Wed, 27 Jan 2021 17:26:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org ECB86386F404
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUnXf+2kAKMQ7+jM3OtEjN5Ev1Y63BOOSUprhLEYjNuYBbuapuwcUiV/J1ZD4aoMgaCC7g0kYGSrQnUY+3PgbR+T195DnR5KW/yWNdPOJJbmAAZYtCwNuNcxLr69Bs3KIpH+cr20bRn4DNPuDiI4rcZmG5uDe4rBFJRzEPaf7fLscy/YNn0nLDRw0BSdc9qXFepHa3+LyspEOWrDHaQXKlEUtCICHpu91fSNNFtdgH/PmF9doHqXOkRZ5Q+CKt05kAXDDcMzmHWIW5nbKk12WD3olhaeXNKx2wMq3I6b5MBwIb74LqcNyimBcZuMhgVvdgBRFTm+6V9O8h+lURem6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBo6zBIKYcFL6ScDb7pUsD0AT5f48mmc2Yu3eeEG5Hk=;
 b=ZQuAbTTIXBhlsy7/XIB/MZLnHEgLKqYw1jMlM525FZkRKCks4omTtve79tTMMphOGayCqKi1dmvpThV7CryNJw/1Us8lI+JtnNOwqEBgS+AGri2W6gCwwEWdBdAQ0uoRIKD6GUhXkvXQe6HIFjLI42vd3WvdbdJfzUrsnpYlqztLrEXbC+cEsRywGEPi7snF5qDYrFXZ6sE2tKHFeQWvuHDU/ebTxvlzIRcs6TA3mDhMAShqrxPeQwIZIPr1fAwl2BaIMNyMxV0l5EBzXaHJhh4M/mItXHY8X3kPa3OUtdpa1IFKJk3j+c+riwTpf7/e5OOqYZ3UDqGP/Fdq5t0t/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN8PR04MB6386.namprd04.prod.outlook.com (2603:10b6:408:d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Wed, 27 Jan
 2021 17:26:18 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%6]) with mapi id 15.20.3784.017; Wed, 27 Jan 2021
 17:26:18 +0000
Subject: Re: [PATCH] Cygwin: fchmodat: add limited support for
 AT_SYMLINK_NOFOLLOW
To: cygwin-patches@cygwin.com
References: <20210126213050.41241-1-kbrown@cornell.edu>
 <20210127124054.GT4393@calimero.vinschen.de>
 <5b3fbee6-b80f-1a46-4574-059b9b0c951f@cornell.edu>
 <20210127132716.GU4393@calimero.vinschen.de>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <6aa2a33d-8cbc-a811-f37b-850620ab47f8@cornell.edu>
Date: Wed, 27 Jan 2021 12:26:15 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20210127132716.GU4393@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [65.112.130.200]
X-ClientProxiedBy: BN6PR19CA0082.namprd19.prod.outlook.com
 (2603:10b6:404:133::20) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.13.22.4] (65.112.130.200) by
 BN6PR19CA0082.namprd19.prod.outlook.com (2603:10b6:404:133::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend
 Transport; Wed, 27 Jan 2021 17:26:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4954adde-0b4e-45f3-3380-08d8c2e8a823
X-MS-TrafficTypeDiagnostic: BN8PR04MB6386:
X-Microsoft-Antispam-PRVS: <BN8PR04MB6386D54F47386F32D6D33978D8BB9@BN8PR04MB6386.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TESfsYt7ge6jQmsJ/pVuS/AF90gJsi7Za6A4y8XSh69FLbvl+HZt5Ea1dY+U/02SSNkDoyXuEZPyVUfpwVTJHjpA82GBT5qtdAqN44P4RFCduNlji/zgCGmuBUEjkYS9hfHxJIviV5R62+nH96uXgoXwp/8aUiIJLm7EJVd7gQO3MoaAcJ5YU5JiiIjNuEUySfENhnzYHF8X2mel4u/CS9d0sUyrPwTvd7PnFhNp6rntvbEdvaW7W4jTrQTR81iddsOQUv/eCa/6MYYugniBni6zZzhebeNua6Q2dhClc922ltT9BK8Xl9gI4S9sPnrPEo2hKa/leZg/hsqipTQMEdXjvBcZeMgaEgoH1636W0BAUwQl7YGTMT3eLyauyPvV2IzWu7Dfsn3loQuK6dBx/4agjfXmlwW9bPaeCve1cO+kWgwL8p9Ic8Y6qqvfonYnepuOBlNGhYV98WVa3uuRXQ+jMJtL4/gBhO+wVzwn8mU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(75432002)(2906002)(16576012)(36756003)(53546011)(786003)(2616005)(52116002)(86362001)(478600001)(8676002)(6666004)(316002)(6486002)(6916009)(16526019)(8936002)(66946007)(31696002)(26005)(186003)(31686004)(66476007)(66556008)(5660300002)(956004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Zk9ZWFJVYlU2cjhIMllSRm4wazU0ZVFZd3RtWm5wRzVHU2s1Q2N1VjFEbUxR?=
 =?utf-8?B?N2dtaFdxUU12OGplMWlwWDZlMDdQRmxWMnJUMmd6OHZWNlg3WkdIMm04ZmxH?=
 =?utf-8?B?QmwwOTVKemhoYmhpTFd1OG5LNmEyNGczSGduZFlpZi9zbHp5a2t0SmljYUdW?=
 =?utf-8?B?ODVCaTNyejUwK2srcEMyOUNaWnk3MHNtZzAzMFVFSmpmaW1OUHdnQTE2T3FI?=
 =?utf-8?B?VG1saWxYUXVCL2YwMDhVQy9HY0dDbUlaZTdHaDdZUkVrdXdmUUtQSkZWV2VO?=
 =?utf-8?B?ZFFNWksxYU1iMW1Sd21JdjRXQkthaE1CSUN3dlNLOFl0bVJkSWY0d0xVT2cz?=
 =?utf-8?B?cklUc1pQVUUyV1daNE1wL2tUc0Q2Z1NGNDVUcy90QXJYYkU5c3dLMFZ5cWdL?=
 =?utf-8?B?QXJ6TVJnaVFyV01SLzVkOTlwQ1RCZUFjV2F6R0JYUk1NenpCM1lrTXk1WTF2?=
 =?utf-8?B?Uzg3SmFNb0M4QlFTbm95MldaV28xWElxZmIwbXoyQ1N5K2k3aS9HSEN0Unhu?=
 =?utf-8?B?Q3pSdEdiajRDb0VYdElKMTZGNVFmUW15SGlpVU1nS0ZDdXdkVURuY254VkVT?=
 =?utf-8?B?MmQxL2VhL1ZpT25zYURGb2l2ZnVSUlg0YXNKKzVWQTN5TVlFZ2o5OWZMMk00?=
 =?utf-8?B?RE91S2hFMkY2M2Vnai9UQXRUeFg0a1RIOGExQzNzRXhDb1FaTFdsQUZoN1pC?=
 =?utf-8?B?SVFqRVRDYjJlcmw1ZWswZ3BVWkRiTk04YUFvc2V5THB6Q0hWQ25pQzU1OWg5?=
 =?utf-8?B?NXFhejNhbktnTlk5c0dOK1B6S014UlZpTGFVV0N4blJFejhHeC9xQ0xqSW5C?=
 =?utf-8?B?WU5WZGt0czBOaGlSSmt0SjBOeDBQZkl1Mk9tVVY0bWUvaFJrNFhUV2VQaS9y?=
 =?utf-8?B?bG1qVmVpdFp1YUdmT1BuV0FQMmhtTTFsci95YTRLcFZoMzIzVUYzZS9jcUk3?=
 =?utf-8?B?a1RDdWVuOGtVSm94dFJrZC9yNFliR2lQWDdUbDBZYzZGbnlNTHVreWZkM0lO?=
 =?utf-8?B?TEVrWFppRGVjOHhLVnhrRmxhSDlwNHhuYTZwLy90QXJhS0dhbG16alhIM2ZT?=
 =?utf-8?B?K0lWU1FBMEhCMG5ra1V0a0VnOUUvRm9hdFpwa3c3TjU2QjBsN1dJMDEzalcy?=
 =?utf-8?B?RHNCTnM2a0xlVVJLV25GTitRZDVVeVZWVnJoMEJ1Y3BTVUovNlJRZ2lzYnZj?=
 =?utf-8?B?VS9iUks3SmtFRHBYdGE4ajNxcFZKWk42UlBzSGN0RFVoWlJ0VGRWTGZXcTNy?=
 =?utf-8?B?SXNRQVdxM2JTSWsrQXVaamd4NUhKMDBxKzROM2YxM3ZINTltZW5PdG80RUg1?=
 =?utf-8?B?R052MkpxYmE3QWxQM0lWQ2ZySzFaRnRvV1FMYXFIQTZnbmdxdFBmV2IybHdS?=
 =?utf-8?B?NXNodXlySzZjZU1Mdm1tUGlVR3g1MS85V1VPRlIvNkcyN0x2VDQ4TzkwK3FP?=
 =?utf-8?Q?1oxTM56S?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4954adde-0b4e-45f3-3380-08d8c2e8a823
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 17:26:18.3374 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bYSMW4N49CzcRvB4wc833HbBXcQBOsS58M4LCroVR83jXdfKmtPIc1TDt9wgin+pld+qvm5WVVvrAFOC8Tdprg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6386
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, JMQ_SPF_NEUTRAL,
 MSGID_FROM_MTA_HEADER, NICE_REPLY_A, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2,
 SPF_HELO_PASS, SPF_PASS, TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Wed, 27 Jan 2021 17:26:22 -0000

On 1/27/2021 8:27 AM, Corinna Vinschen via Cygwin-patches wrote:
> On Jan 27 08:22, Ken Brown via Cygwin-patches wrote:
>> On 1/27/2021 7:40 AM, Corinna Vinschen via Cygwin-patches wrote:
>>> On Jan 26 16:30, Ken Brown via Cygwin-patches wrote:
>>>> Allow fchmodat with the AT_SYMLINK_NOFOLLOW flag to succeed on
>>>> non-symlinks.  Previously it always failed, as it does on Linux.  But
>>>> POSIX permits it to succeed on non-symlinks even if it fails on
>>>> symlinks.
>>>>
>>>> The reason for following POSIX rather than Linux is to make gnulib
>>>> report that fchmodat works on Cygwin.  This improves the efficiency of
>>>> packages like GNU tar that use gnulib's fchmodat module.  Previously
>>>> such packages would use a gnulib replacement for fchmodat on Cygwin.
>>>
>>> Wait, what?  So if Cygwin behaves like Linux, gnulib treats fchmodat
>>> as non-working?  So what does gnulib do on a Linux system?  Does it
>>> use its own fchmodat there, too?
>>
>> Apparently so.  Here's a comment from gnulib's test program for fchmodat:
>>
>>                /* Test whether fchmodat+AT_SYMLINK_NOFOLLOW works on non-symlinks.
>>                   This test fails on GNU/Linux with glibc 2.31 (but not on
>>                   GNU/kFreeBSD nor GNU/Hurd) and Cygwin 2.9.  */
>>
>> I agree that it's strange.
> 
> ¯\_(ツ)_/¯

I'll go ahead and submit a revised patch for the record, and you can decide 
whether you want to deviate from Linux.  My own opinion is that it can't be bad 
to support a flag that Linux doesn't support, but I don't feel strongly about it.

BTW, the mistake in the first version of the patch is that I forgot to specify 
PC_SYM_NOFOLLOW in the path_conv constructor.

Ken
