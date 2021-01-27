Return-Path: <kbrown@cornell.edu>
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2127.outbound.protection.outlook.com [40.107.243.127])
 by sourceware.org (Postfix) with ESMTPS id 2F2EF3858022
 for <cygwin-patches@cygwin.com>; Wed, 27 Jan 2021 13:22:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 2F2EF3858022
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bqa0rU/4XgpPLcqyFCydfsBEZ7KxlUFm4PP2+17opaww+nZm7gUYg5stcyuaSbWYqq2h6mJNbshep2nr4UqQdmPsWGQw3m5ETcShPya+S4W4dxayoAwU5zWUx3dzcwt3AycvQfEC0NMB87xszcoT5c2EJeNHU0kCIqd77qTL5ibW57Xz+qCcglXLlfZ7/NtOvLoczsWmSCEdFz9pJt4hrqhsVQ+ss60FHkTG6/1RNe+WHyrnqf2GXnSkCyzebThanu6Dh60obLmbsw3L/V8wfsLl4zE5lkeVfsXs8WR8lIWwUcYhS9HZ+JnCcVixT3xrp/LEX4nRZ1r+kv5cLJ79/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgmL8GbmoYd/PBUoL76F58teOL2TEnmNzGp1WpIsxyI=;
 b=IsesGuGEDl5jla4aPWkT+RMlSRycIWaSgrTp5XoUNFi5V6qOgCDVyxXgdduoRjZP03DI1NV569R65ftnBD9O24UMTejzaOvlPipuP06vk/TWT8/V4Y1RF0FZquhtaJ5ILGgu54anf8Cc5uJ50D6SQfWjtvnxJE7kjZli64glOUjwS5kKQVkDT2Bh5U72GeaKJvzeaEH1GEByPiq95B0fr7tHeflcJbK8UKZA1ijyTEg2HNOQxkjwLY4vxHk0N0EFPdf+54oKHf3qrTH3mBmDZDLLs7zP18w1n54sJ4HuNeHAuwKbjlQMxfFPse8kmNx+iBriuADtIhOlo7/1L5GuBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN6PR04MB0660.namprd04.prod.outlook.com (2603:10b6:404:d9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Wed, 27 Jan
 2021 13:22:55 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%6]) with mapi id 15.20.3784.017; Wed, 27 Jan 2021
 13:22:55 +0000
Subject: Re: [PATCH] Cygwin: fchmodat: add limited support for
 AT_SYMLINK_NOFOLLOW
To: cygwin-patches@cygwin.com
References: <20210126213050.41241-1-kbrown@cornell.edu>
 <20210127124054.GT4393@calimero.vinschen.de>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <5b3fbee6-b80f-1a46-4574-059b9b0c951f@cornell.edu>
Date: Wed, 27 Jan 2021 08:22:53 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20210127124054.GT4393@calimero.vinschen.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [65.112.130.200]
X-ClientProxiedBy: BN6PR03CA0112.namprd03.prod.outlook.com
 (2603:10b6:404:10::26) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.13.22.4] (65.112.130.200) by
 BN6PR03CA0112.namprd03.prod.outlook.com (2603:10b6:404:10::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.16 via Frontend Transport; Wed, 27 Jan 2021 13:22:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31b14842-66af-4e6f-b508-08d8c2c6a83b
X-MS-TrafficTypeDiagnostic: BN6PR04MB0660:
X-Microsoft-Antispam-PRVS: <BN6PR04MB0660284C33795D3391594AEED8BB9@BN6PR04MB0660.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TZUMHvLYu/TkUFg/dqj7WU/z+0QUxrR3RCjR7gOj+XOUA2MGO66yKvSZ/AP2rH0swfFVqHIuYNDyBcVxEMVZCl7fTB2w5QnCrRSbkTMGKONXCkNTW8PH3BcW+kB0ZajD/RG9PFdhhDv4Ya8LJwKw9ixEUPipQpY1Lv2f/Q5SWK+WHTFNGeLTXMa5VLWrQFZCaOZrYtzudPoXo7JyuLuWRO138VlNaUuQBYYc2K4rmVhHxs4Bd8NQHFDSANms75lRwuQH4lWQecErTYvkrplZqlHwirF79o3+QFBRFg9ZSUwvKsnPrXEnmqJbMudS8aMCvXfkIVrYDDyjEubnNKGznPf1E4vRfWegAe2ihk1qEcJQOWKLYVPml42QEbfK01gxQuhN89slkpVbz1SVqQpueENYHPO4mZeGH4Ik6lGzdlRnQly79xsLMcSICxBAiSpiOFTDDarNuCyLvbonJCwK7nkPx+qxmrz8pqSIS3K76ADsnlhUs+zB29HgmzIp9KTE5f/uU6bsnkmX0jmcmvAb9tCp45G2JTngVaxs4S7DuLGt6TuTWe8LwYSubwP71jStYsMa/6ba+90W1f8fmx+B8dmcTXZh7gYj4xwi6IKLxLM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(31686004)(2616005)(6916009)(6486002)(786003)(31696002)(316002)(86362001)(956004)(5660300002)(52116002)(75432002)(53546011)(16576012)(8936002)(66476007)(36756003)(66946007)(66556008)(8676002)(478600001)(2906002)(186003)(26005)(16526019)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?spt5GWTERychSOZRcXHhCLR0DpXBc/xnkXq8Uqr0z62HSvlqAi5qDLgX?=
 =?Windows-1252?Q?NNBL2bbomLKyvKH8zWCnUEnww2EaxWYMU7OnXgoQWAvC8iD2ANZ5J44S?=
 =?Windows-1252?Q?7PzFwR5iig/rqpWZwFpdql6NX8IoZTL55/Zwu/EAltFD4mTjHSlZWXq4?=
 =?Windows-1252?Q?Q9aKKXEgKX3+7O0IwEmnnTIn5TDDhBEI3AyMvl0JZcA67QWeME/p5RZe?=
 =?Windows-1252?Q?ncLB2RMDKYB9k/Cf8NMQ9IrVguicwTkXDj3YWFVsY32rAg29PgYvCIJo?=
 =?Windows-1252?Q?fQS76y/Ea/8oJ2jb0Y1ha7DEY9qk0CzAGtNePdhGivcBGKK9lBQymTWJ?=
 =?Windows-1252?Q?UW1kRvug6z29Lfg4SJuiJ0B2n3mexEMTf6fGVkeN5+ncu4fZ/5eyjHKy?=
 =?Windows-1252?Q?jsPUcIppje/Xg/2Xt7MGAzAVrJoB1//fxnjsky6nBtGSu/kOOMdvXZpU?=
 =?Windows-1252?Q?eMlCVLMInVumzeOBw/H/YEzTaUjIDuiNAnWDq3YBp8Uh4q67A2zGXM4Q?=
 =?Windows-1252?Q?T3bZ2uFF7IBjXxDxt5C6K9yhZGYmbk0yWnT2ZYsKvOkh6AmI0VmUjPCT?=
 =?Windows-1252?Q?9yS/tW4wOEKPHbs/c9jgi5RQoTU4SNPeaTuVAxTWNfZZ3kzJ5o6wnXES?=
 =?Windows-1252?Q?q5/YCN/IOU3Q2bOUmupCknbrEpCBSX8Sq6ug48Z4MeX4qGLC1ApG5/CY?=
 =?Windows-1252?Q?TZdHZ+ZTmxuHfByJk5F2yWeYoQHU92HSZxMmlzJguMbG/hK3jbEBxuHB?=
 =?Windows-1252?Q?f6xSGk/a4jlEdqaftr+NsIFYJ769JmpL0W2Q4iq0JWMuOMzPiO+TGgex?=
 =?Windows-1252?Q?9ZFx86Ls54a7GYwSg2GbyBJFEyNyVHbRd4Fc/F2MQ8BKPxA5LFKzyCo9?=
 =?Windows-1252?Q?fTRpyNCEorUUp3gqeC3K/y0V2BkdEftAZZ/hE7vvdiV9W1c0kXM4gPtK?=
 =?Windows-1252?Q?8sfEIq1Bua81nhf/frY/ihL99B3v4VZAGJaQbKW/4R9l9t/EklC9w4ns?=
 =?Windows-1252?Q?kVhfNbAjnWal1C39OpxBmteq6moMc/ZFodvMqxxwYoahYXXehl3CDWZL?=
 =?Windows-1252?Q?WD97P9lXg1+0lviIDpuuo/14fuxWvr2SBxGMlmdeJU3gqAJgDH42WePF?=
 =?Windows-1252?Q?TsalrEa94N3YoONtCv5VEXzB?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b14842-66af-4e6f-b508-08d8c2c6a83b
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 13:22:55.5742 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0OwBYT+Qp2G0MGGcu1kLJ7cJAVIqSIiJDkrorAQsJ+BImQ4WikEopBjQMJ/ZW4CbCHgr0IP8qYPdqFEzKI+J/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0660
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, MSGID_FROM_MTA_HEADER, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
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
X-List-Received-Date: Wed, 27 Jan 2021 13:22:58 -0000

On 1/27/2021 7:40 AM, Corinna Vinschen via Cygwin-patches wrote:
> On Jan 26 16:30, Ken Brown via Cygwin-patches wrote:
>> Allow fchmodat with the AT_SYMLINK_NOFOLLOW flag to succeed on
>> non-symlinks.  Previously it always failed, as it does on Linux.  But
>> POSIX permits it to succeed on non-symlinks even if it fails on
>> symlinks.
>>
>> The reason for following POSIX rather than Linux is to make gnulib
>> report that fchmodat works on Cygwin.  This improves the efficiency of
>> packages like GNU tar that use gnulib's fchmodat module.  Previously
>> such packages would use a gnulib replacement for fchmodat on Cygwin.
> 
> Wait, what?  So if Cygwin behaves like Linux, gnulib treats fchmodat
> as non-working?  So what does gnulib do on a Linux system?  Does it
> use its own fchmodat there, too?

Apparently so.  Here's a comment from gnulib's test program for fchmodat:

               /* Test whether fchmodat+AT_SYMLINK_NOFOLLOW works on non-symlinks.
                  This test fails on GNU/Linux with glibc 2.31 (but not on
                  GNU/kFreeBSD nor GNU/Hurd) and Cygwin 2.9.  */

I agree that it's strange.

Ken
