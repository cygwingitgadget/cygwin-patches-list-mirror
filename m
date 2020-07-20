Return-Path: <kbrown@cornell.edu>
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2138.outbound.protection.outlook.com [40.107.237.138])
 by sourceware.org (Postfix) with ESMTPS id AD73B387085F
 for <cygwin-patches@cygwin.com>; Mon, 20 Jul 2020 21:08:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org AD73B387085F
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTT81Z+EoNcH3+v2/v16k0wbYmD8oEhFm+Wq+ShzMoPu52YKqBKGyNqtSumKcsTy5TeOwWa1If5LiMfPCcTdIcArSsWUmZdaATMGOABYSKGBKoAOUF/gXhy1bR8iM06LF6bVNw12jNmZgwFukkR7ebQJSMEUp7lemjfwLIAb3v4njjUrRXmQ3ulgE4AWOJ24HzWes7tFFqqYzRP0E2ffCpbJVyd5CYiD0behPiXgJrVNTv5mOF3/OEVHhSB0nBRcs8XdQLezC2mxUaZ+UmZMVNy5eRetSrHnOfco0H5LCvxMWosnWNklqi7mzFu3ZPS5UI+XgZRUaFMGOPVSljy6jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8vAmz3RTwEoziDb+eQXwZnstj1GcIT4eBGjIUgbMwU=;
 b=EsFt4zeg7RKRSB3oxvRu8mK77ry++ZI8ntQI8FsREKq47dgtam7fWoXapAdMWM1LwYjOeDL/xHuAS6/1eQRyIYX3zlWZgb0mw3BxDFKts7Nox9RCCKyQJoIy/Dr93HEBKs0SCYuJvdqwg3iaX/cZmvpRtnQsZyTj7jbmE7eefcZkgx7J5+E1WqNIr4TeXjzgizCd0A5JgGa2dAO9uYGBelLZ+Bvy7YRoTW9dwMKNE9jCbVGb1TzQREpuCzjY+CnEqyA69fazF26GGp821IC367Bt7yNn6l322+aQp8co+cmBiB0hSUZF1L0lG+sDnaa0IpAtotB6QpPaDjdvD9B9Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5536.namprd04.prod.outlook.com (2603:10b6:208:d6::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Mon, 20 Jul
 2020 21:08:45 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a%7]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 21:08:45 +0000
Subject: Re: [PATCH] Cygwin: mmap: fix mapping beyond EOF on 64 bit
To: cygwin-patches@cygwin.com
References: <20200720133442.11432-1-kbrown@cornell.edu>
 <20200720142303.GJ16360@calimero.vinschen.de>
 <ceb31948-ec43-3bf1-a164-53b54828535f@cornell.edu>
 <3d3597af-7bb8-bc83-2522-9282566f80b8@cornell.edu>
 <d1ac7543-34a2-90c6-07b4-96d90142df34@cornell.edu>
 <20200720154139.GL16360@calimero.vinschen.de>
 <c0269ad1-515e-dbf5-aae1-8d57b7ef39b2@SystematicSw.ab.ca>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <f85c42c6-18ce-720d-328a-352ca7cb78fe@cornell.edu>
Date: Mon, 20 Jul 2020 17:08:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <c0269ad1-515e-dbf5-aae1-8d57b7ef39b2@SystematicSw.ab.ca>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0015.namprd05.prod.outlook.com (2603:10b6:610::28)
 To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.17] (68.175.129.7) by
 CH2PR05CA0015.namprd05.prod.outlook.com (2603:10b6:610::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.15 via Frontend Transport; Mon, 20 Jul 2020 21:08:45 +0000
X-Originating-IP: [68.175.129.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f176ff3-8a7e-4d0a-8b4e-08d82cf116bf
X-MS-TrafficTypeDiagnostic: MN2PR04MB5536:
X-Microsoft-Antispam-PRVS: <MN2PR04MB553642AA4988E94CA71DEC10D87B0@MN2PR04MB5536.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hXwKrC3Xz4fIl0ZICxQyBvzJAoIxkqdwzbxyWPcd0GAGtXa0/KuIFGJW5HFs0Wmvp6niedZlcIqu6XKndwko/541OjBkbtQVfSFVcslcpkYbou5iyhyYDz5q/7/kh+PAMdVe5mboh5mMR6grJARIcM7a1mY2Pb/hx9getCmM1QH4q5q3p3CYCAfWVIJVBIwru45Kyc31VOJYspOtbhqEAlKDfoyMSKO2u4NsHaFyedKA5cVE4V7QiNAT4FpbqFDcqI/8uIbiO+o7u3VykWwNHm6JMcdypL6hn5Oh8FjbMh3eYDFB2C/NJD4jl3XnCNLDJb8Hwd2txx8xdW8w6R39zD8mElI9ocrueXNRBnXSPfQ78tRj2kNASS/0sHwRhS3A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(786003)(5660300002)(316002)(4744005)(6486002)(36756003)(956004)(6666004)(16526019)(31686004)(186003)(2616005)(2906002)(16576012)(6916009)(478600001)(31696002)(66556008)(86362001)(66476007)(66946007)(8676002)(8936002)(53546011)(26005)(52116002)(75432002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: cryQe7WCSTPCMZuXr36+j9GDvka/yQGW3acIUAtVzVwhekvt6qLJaq7ESMVc5UvvmZy660CsNNMDgOS1OJKkyK6rXcO0Vn5CwER4tgctWsuPjcIoHxxWzstRs/TE+s176SIP3UgsiBP0GFMhyeuIGanLx7sVQZZ11GnxFo9EN/Z9KBwIQPB8NYeF0qgbi5VujwIZxI2kBzlqgQWZGRnA+uvMC/U5OjK8D+jCIDZkd0EVzKhW84bLNagcVUSq0kOPUhmmzhgKavg8bRpUyG7dmSvR8U9EnSdca+nxY+ieYkPF3z1/0CYG92w4X+9TVJBCCXBnJ3MR6UZe4FSKa1qkdrmge4rwbv4taizlYCyahOSi4X8oFWXnexIR7yIsTgwuA9tFsNZu4IpizuQtBih7qzYma3aYkRYL8hbqU7fa2XlFQdE2nyvVMbMoNlskKXPg3MgvfYIokRDACUzKlXZmv0u/xJlqqLHxyePDbA4LT9o=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f176ff3-8a7e-4d0a-8b4e-08d82cf116bf
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 21:08:45.4926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJAJPBr62VJcBJhtsNwC+yExaalOsMqGPFx1yABs/2b8rYLrCIioRVqrxti0D8d947dACLKACUbIXQbdAOekyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5536
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, MSGID_FROM_MTA_HEADER,
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
X-List-Received-Date: Mon, 20 Jul 2020 21:08:47 -0000

On 7/20/2020 4:29 PM, Brian Inglis wrote:
> On 2020-07-20 09:41, Corinna Vinschen wrote:
>> Ultimately, I wonder if we really should keep all the 32 bit OS stuff
>> in.  The number of real 32 bit systems (not WOW64) is dwindling fast.
>> Keeping all the AT_ROUND_TO_PAGE stuff in just for what? 2%? of the
>> systems is really not worth it, I guess.
[...]
> If you don't want to ask and perhaps reconsider the impact of your approach,
> maybe give folks a heads up on the mailing list that the current release will be
> the last to support 32 bit Windows?

Corinna didn't propose dropping support for 32 bit Windows.  She proposed 
dropping a feature that works *only* on 32 bit Windows.

Ken
