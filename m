Return-Path: <kbrown@cornell.edu>
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2132.outbound.protection.outlook.com [40.107.93.132])
 by sourceware.org (Postfix) with ESMTPS id 5C0BC3858D39
 for <cygwin-patches@cygwin.com>; Fri,  1 Jul 2022 01:16:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 5C0BC3858D39
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gy58+NLmEY3M4W8uOy/D3iC2wUbthgkxjOUF2KFyH7i2qzYvIcXtw2PyTnvsQyPO115GrKLazpCj/tiEz4PIlsLleNhBLyUVj6SrAL/lZLZM9HYjvFv8KANYkQSWhZfg1qmZiw/uj4liubCI3S7vLyejQYT79bLaByLgB4trnYgouP5tloWMx8pR8O4KsOSnmuYNBGTrjzSxpIR1QUsHe/HsanFYlB1CTlMibkZseiDzF/vOJ2MZbH4LsIBNK6uB2GNnHWFDq4L9r8SzWNfQNzYxC9IbCXOiKAed+0H7tuVG/Wb4N/Do/dK4PxicwXcUolvI+MWC8oRaxAFmKICf5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dcb9L4sh59WyjyLw9dEt7qoSKo3dfMecIzmlluoi79o=;
 b=NA+koeDoWLl89LtMzSrCBirqk4L59W6/lT2/MO/xaRqGp8ItG4BVS6WzxzZQHEE2PYGatzmgftc0pQfeRy8597unNXVGDYcwDHhZuVCyx0bCv9I/27d6TIKyeuJKs9wp8hvvgolmJrZXDyAi6IhMVkN9lG9o4gvOJtr3TLVLB3ifxrJv23JDegBAWtMhxC3s+pKQQnENgVoMg75sbGUWIVU5xjBr/jkzJea0/ds+zLUkxi3lF4Qaj1xxzbTJ7v8jCQA9DVMZ/pYXZM9NdUrwFYUjgqAym6lWJeMQycwSJ9VdmLmcxa9ralUWskLwMWN/4IbHo5ooAQAYPFOD9apXVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dcb9L4sh59WyjyLw9dEt7qoSKo3dfMecIzmlluoi79o=;
 b=Nodi1g3lLw1HGQud2fW+te0tHfdRZHMCEnz4rZOQMWLND3srcsaEEf9xEnBkMAZcI94nTFgpGpWYlz/DdQo5XjHDdouhWGv0bFb+RmY8itswr7przUgwwajZ4018ccw/u40ncVX4+H9utDbj08sFbA2aZWDJXPDCJpV9bLcOZ2E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by DM6PR04MB6713.namprd04.prod.outlook.com (2603:10b6:5:22b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Fri, 1 Jul
 2022 01:16:37 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::901f:a758:30f5:309d]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::901f:a758:30f5:309d%2]) with mapi id 15.20.5395.014; Fri, 1 Jul 2022
 01:16:37 +0000
Message-ID: <376762b9-6ef2-4415-b3e6-fbc9be48f183@cornell.edu>
Date: Thu, 30 Jun 2022 21:16:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] Cygwin: spawn: Treat empty path as the current directory.
Content-Language: en-US
To: cygwin-patches@cygwin.com
References: <20220627124427.184-1-takashi.yano@nifty.ne.jp>
 <c4a8d150-4d16-2af5-a7ac-26e42f9befb8@cornell.edu>
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <c4a8d150-4d16-2af5-a7ac-26e42f9befb8@cornell.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR18CA0027.namprd18.prod.outlook.com
 (2603:10b6:208:23c::32) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c83d0139-bd02-42bf-75bd-08da5aff5842
X-MS-TrafficTypeDiagnostic: DM6PR04MB6713:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NQL795G9k3gxVQHRcjGeRvXOkR9MF7OWjIE15+wNOLABXBJD/n5mDxv9+IoLucmGiX0O1ypati5PLXQBVsY41H4nLr4WyelASZdQ5s8e8vvBUfQa0i2biqIyRSTvlfc6jzKQ0OoaQywYKo3cIcqRp1zItL0/p0xkXkq+Yhn8zJaXsmCtzZjWToJh48Fr/yLNglYpjfqMpV3ZVsm/wzC/zBF6s9bzc2ntixN49Th4vwI15FiPd1g0EkeL2irmhi9Fjp2Y7lkEEiyYDzrifRJWIUyNNTZ6MOZXNk/rk85oqw4/zPxc5ncPXXKX12a5xvKsznPiwHfIat+aaHTzy+pD+LFbhDLyvW20k3l2GDavrfNnAtZ2onERnC7Fj35r5eWteBuaP01XL5kPJ0IF/x7Zk4yunwFatUd73QESfjNq3jxRGiZQePfYU/0pv5oGXfXVDtcSP8HylBdk38qVZTGMWGdAG2w4Bvyu4Q8mReCBQlX5dvnYRGETUnVYPZ531+n0AvcETZlW+RLMnBEnbE2/2cefNLI9g+yl1sSRpEifbn4hSOP2tB8RLeH7wcSszyENd7RSdkUscdJEFdzbuFkyrWc76e9DrKTvP0lut531cZWXGrIhcUjMZeavs8JPMlJId52D5t0hr1TbQCkZov1OF7WrFgv7JRRNwOHb0kdspDNB0mLE3mYfThbwiyAWLYOPpHSYZwJ86MzCim0B3Nhw+0b2sKStiQ4+Mnk3wS3cFY0+qpjOBejkPPU9c9+RaDtoyt8Nx1aRP+ZcrJAHtJRl8jE1Cdakezrw4RhHjGVR6dNfjOjEzLt0c+vzAvqb2nu6+xC8Z1MEaosUeTgflNFimXQGSu9i7Q4KfR//m0eda1YUTqKP5CEcgQcFcE2Oi/sDOh/k9XIYOe8n8PL9i9cBez5zLVM/a70BEnY53A5dva0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(38100700002)(31686004)(41320700001)(316002)(786003)(186003)(83380400001)(478600001)(2906002)(66946007)(75432002)(66476007)(36756003)(8676002)(66556008)(966005)(2616005)(41300700001)(31696002)(53546011)(6512007)(6916009)(6486002)(5660300002)(8936002)(86362001)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGhoMHZHM0pqQVNEd0g1WGVONnhzQVBSYk9wVFhBVHowcmIraEZjRndlaDkx?=
 =?utf-8?B?aW5BUHd2Q1QwQ3B0aVBMbkRPaEV3ZnZLc2FOanFIaVA0YzFkb2cxVm56ekg4?=
 =?utf-8?B?UHNWcHQwRjFHbjdRZ2ZLZGJCNG14VmxKY3NvM0RGU000TUlDczNnNjI3VDU1?=
 =?utf-8?B?elh0K0MxYkpoeTExempSRFhQdmpMbGw0TW9jK09reTBWM2ptcUZ6ZEdJQVVK?=
 =?utf-8?B?LytzYWhWeFBNc1diZzBtMUdGbW5jNkZUWHc3MjZDUDV0VDRnejJaYkZyUnZB?=
 =?utf-8?B?V3hMOElLeHVmdjJjeVdiSCtrcUtRcHFnWDdNRlJhSFlTSGZ5eU9hK1B6SXZt?=
 =?utf-8?B?TmJNNWRRWUhaVHVJc09BeXZFa0NHV0FSWW0rWE9yamNTTzAzSi9YemljMWRJ?=
 =?utf-8?B?b3BFNmxYcjhNQ29ZczBzZ3QwY0luODlGRHo1cjRyNFdQbTE5SzhqblE5amNQ?=
 =?utf-8?B?QTl1elhxaUdxRlRPS3JVZlFkbGhhOUYveTdKZ2Fya25Xc09xN3JlZnc2Z1Fr?=
 =?utf-8?B?UllyUDhEc2RkYlBscU55QzZFSVp5d0JwWlVWckt0eE1VSGxaUXFuUmVwZm5i?=
 =?utf-8?B?TldLWnpRcmNTemJubXRJK0pLaFo1ODJLU1dxenhDVlBsR013UDk4cVg5R3p5?=
 =?utf-8?B?YnQ0RU0rTEpyV0U3V2RIWjVsSWcxY2tFUGVYZU1vLzhYRStKdC8zR1VVRkRP?=
 =?utf-8?B?VEVQemphZmtKR1lyRGNzeHdBQU1YWkVWYVArZ29sbzZ3RE52YUxLSjA2M3hX?=
 =?utf-8?B?bGFud0UzYTFJRFBzeGxzN3RnZ0NteW1wbnN6UEZMeWhnSS8wNjhnQXFHNHJu?=
 =?utf-8?B?S2h0aTVyUHdMdDgwQjVkQ1NQd1RBcTV1ZmJma2pkQ09zazBOS3VaTWN3ZTZD?=
 =?utf-8?B?dlZvNXRmMGMxYWRrOFp0ZXJQT1duVEoyTnN4VFhJZVRqWXF4K2tkaVQwY1NU?=
 =?utf-8?B?V0lWVllrU1dJTHd3Uk1Hd2xWSkZMZmcxVnJiZXJMWUhDcjRyZ3k5YVBGT2xk?=
 =?utf-8?B?MHc0UTJDM3FiUHBSNThOZEdnN1ZkRTJkMDR5c0xJNjlMcjNnRUI5aGhqMFpM?=
 =?utf-8?B?R3YzUGdLTGhaaHdPelJ4MHJVdFM3U00yeWxka05QcW9iRGhVWWNpdUZ2WlBt?=
 =?utf-8?B?YU1QRFVsZFAxOXNoaW1tdUtJUEhXWlR1UDZSWDBIMmNVQTIwSXZpS0R3VGNH?=
 =?utf-8?B?NXhRbHJHaDdmQWJUMHBGVmlLV3NHSFpIY093ZmpHRmVFbUs0NzhHb2RNQ0xr?=
 =?utf-8?B?K0tjZDJrRnJLWFRsdFNBUDRQVmY0dkV6QnJNUFNGMFZscHltK2RzMHg0QXh5?=
 =?utf-8?B?amRpZXpOaHRGMWxEU1o2bkNESk9DQXNMYXJhQ2tNVE91cENyLzFTNnVJVEFC?=
 =?utf-8?B?VS9KanlidFFOc3ZoaFQ1NldVQUowZ1Zvd3dOKytQaWEvdjFsSEZNbU04VkVn?=
 =?utf-8?B?SEQ4M0RvZVZCTmNPbWZIQ29sSWt0YmhxQ3FiSnl3UGJ1cHhTZGkvUkRaZmxh?=
 =?utf-8?B?RW1rcmhhemVaZm5vUEpFQ2U2MENSMDJsT2Ewa1VxalFRcVkrZy81SFdseFkz?=
 =?utf-8?B?N0xVS1QzYW1OYUthYTFRODAwNk54ZVZBNTBVbnNTV0ZqdTd6NlEvdEVCSEdk?=
 =?utf-8?B?VFdpM2lTSTBHMzBtM3JORmZGcWxCT0l3b2huSlladjFZSUE4VDRCbG0rZDQ1?=
 =?utf-8?B?M3RtR1I2blpxOHh5eGVWTVlPQkFNZ3VuVHRZU2lTL0FjTXBibWh4blhJenBj?=
 =?utf-8?B?OXhFc0FiMmg5YWtNSFJGQk00SXY2eEVPVGFpc25Fa3liUFJlNU9UWWVMYlZp?=
 =?utf-8?B?R2dLaExkdDN0SCtjMTZ0dE8rejBiREVXeU1sTmovNTd0c041ZnFsYUFGTGJn?=
 =?utf-8?B?d2UrZjhueElQSFI4RmFXc1BTemI2OUd4alhXaWdVT3UyNGZwTUpyaG56VjVu?=
 =?utf-8?B?L1pTa1d6VXlPSHN4QlROeVdiaW1odGpkVUx1K1hrR2pyaG1mWEM0M0pQcHNv?=
 =?utf-8?B?VXJnSVoyZ1JKZVZvNFJIQUpFeTFWU25DVlFOcm1xVDNJYnplaWtRaDB2R2pF?=
 =?utf-8?B?VlE5NnArbmFOMFRHcjVnUzV0OURYdTBLVDZ0TVlqRDNTd2xrOHNCL2JkcG1r?=
 =?utf-8?B?MnV6VCtYM2FmdkNhQlFvcGVmb2dsOXpoTnVWQjBnWlhvRmdhdUxVU3JCdDRa?=
 =?utf-8?Q?rOaOKJrP/wJbNr8WqLNux+jrJCFK1PMxpxj3YtDeZ4iF?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: c83d0139-bd02-42bf-75bd-08da5aff5842
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 01:16:37.1507 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nhBXFDaExdC6H9SzaHmUaxDu8KUw0rXBhzKQ4Ch0jMA0KjPLVSbQI0PLrQlyobS8B4M5fh0rcVC+c9HIB+F5sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6713
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00, BODY_8BITS,
 DKIM_SIGNED, DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, JMQ_SPF_NEUTRAL,
 KAM_SHORT, NICE_REPLY_A, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS,
 SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Fri, 01 Jul 2022 01:16:41 -0000

On 6/30/2022 11:45 AM, Ken Brown wrote:
> On 6/27/2022 8:44 AM, Takashi Yano wrote:
>> - With this patch, the empty path (empty element in PATH or PATH is
>>    absent) is treated as the current directory as Linux does.
>> Addresses: https://cygwin.com/pipermail/cygwin/2022-June/251730.html
> 
> It might be a good idea to include a comment in the code and the commit message 
> that this feature is being added for Linux compatibility but that it is 
> deprecated.  According to https://man7.org/linux/man-pages/man7/environ.7.html,
> 
>                As a legacy feature, a zero-length prefix (specified as
>                two adjacent colons, or an initial or terminating colon)
>                is interpreted to mean the current working directory.
>                However, use of this feature is deprecated, and POSIX
>                notes that a conforming application shall use an explicit
>                pathname (e.g., .)  to specify the current working
>                directory.
> 
> Alternatively, maybe this is a case where we should prefer POSIX compliance to 
> Linux compatibility.  Corinna, WDYT?

I withdraw my suggestion.  There's already a comment in the code saying, "An 
empty path or '.' means the current directory", so it's clear that the intention 
was to support that feature, and the code was simply buggy.

I've now read through the patch, and it looks good to me.  This was pretty 
tricky to get right.

Ken
