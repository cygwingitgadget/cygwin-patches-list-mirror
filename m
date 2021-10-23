Return-Path: <kbrown@cornell.edu>
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::70a])
 by sourceware.org (Postfix) with ESMTPS id DF2A43858D28
 for <cygwin-patches@cygwin.com>; Sat, 23 Oct 2021 20:32:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org DF2A43858D28
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7d4klXNG/yUH4yCqBmzU9IUSHLT/C+av+Yi1FwofKwQhmOMzvm72n7rWy6OAG3TDZdkO95VlZEE8WF+BUdj8b73O/e1jljgRnxn8tJxKZ/9HbOVQjbtONopHWPWgrhg5CkFa8NYB5VuLACFdOCU6cd2lKCT9h0VwftSEYuI5bAR6JVxKDldnhKytSsIr1Fgmj7XZdnlkx+vjDSYK9/EMYMhuFcYsR/M7mUSPDohh6qDbijSTMKjBsckQ7Rbjt3yLsUHoJiHrszpSSwelllrQvRpuiOggT8bSt0dkguUi8ngjqk5o2OlYnFMBZTpag9NjM2w5X/1wVO774xWdWwZow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubbsCSa9WeU4heaBk3LUQcjXCFxzEFF78/PQdE4I9IE=;
 b=Rm3czp/o3b6JNf7gvbQs1rR1LuKT/ZN/OhLB8nzmew6xbRlFp5C0ciCVfqDN6IkuS7u4QBw47GDeSUPhIfUQcAjzKkNSja4OkcipHMelntO8IvvaLCKW7xj3CN6nguWrr8EDkchd8seKdpH/xQ5PrSt56HnBBjWUTRNF/TiR8fMt9wMKn7clsfztgNBsfT+JE29h/yKvX8jf2AtsPq85GNoTB4ALJbizKFVbojSEeySRm8RLyABuivT7FjU8hg7E5UfKCa5TubK3Eb7cqoS9x8XochH7A3vKgrycL9uyytFVlYt1b4dWNSJlO8Jrf+GrnKaiGmNV1toFJhW0qSJqhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubbsCSa9WeU4heaBk3LUQcjXCFxzEFF78/PQdE4I9IE=;
 b=R7iK4wB89+6YUM7L2aYEa+KZ3oUFIL9zODXAux6o246amFnZhctIpkReun0r5OowjsSHgYyALvyS6BJVF7xk/rpOyuqz0dYKoe9FA8FG+9FXu4od73yzzeEkHIYKba2t5+C+sPnUFx4qm8s09FM94u0wqmU0pCk8oel0KHxJ+9I=
Authentication-Results: cygwin.com; dkim=none (message not signed)
 header.d=none;cygwin.com; dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN8PR04MB5476.namprd04.prod.outlook.com (2603:10b6:408:58::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Sat, 23 Oct
 2021 20:32:46 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::d1a8:b6b3:dfd1:b093]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::d1a8:b6b3:dfd1:b093%6]) with mapi id 15.20.4628.020; Sat, 23 Oct 2021
 20:32:46 +0000
Message-ID: <0cdc8601-fd90-226a-d486-7204bbe604c6@cornell.edu>
Date: Sat, 23 Oct 2021 16:32:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] Cygwin: Make native clipboard layout same for 32- and
 64-bit
Content-Language: en-US
To: cygwin-patches@cygwin.com
References: <20211007052237.7139-1-mark@maxrnd.com>
 <20211008185210.cac713f28dea727a1467cf94@nifty.ne.jp>
 <29514de9-0d19-0d22-b8e1-3bfbce11589b@cornell.edu>
 <7dd31f61-43a1-4e4d-2e1a-dc79606263d5@dronecode.org.uk>
 <037a8027-8969-df1e-ccb5-6a736578cec5@cornell.edu>
 <6de24f8c-bd21-cd4f-18ff-ece3fef85b89@maxrnd.com>
 <ee8b46bd-f8f4-85da-be25-233c3cb60c71@cornell.edu>
 <YXLUkU6Nc3qAXLyp@calimero.vinschen.de>
 <12fea3e3-92ae-2a33-81ea-808bdcc20f2a@maxrnd.com>
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <12fea3e3-92ae-2a33-81ea-808bdcc20f2a@maxrnd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0287.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::22) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
Received: from [10.13.22.5] (65.112.130.200) by
 BL1PR13CA0287.namprd13.prod.outlook.com (2603:10b6:208:2bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.11 via Frontend
 Transport; Sat, 23 Oct 2021 20:32:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d845aaa-cedf-4f8e-8bd9-08d996644589
X-MS-TrafficTypeDiagnostic: BN8PR04MB5476:
X-Microsoft-Antispam-PRVS: <BN8PR04MB547632BF252B190D3FA0C95FD8819@BN8PR04MB5476.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p1g/ohcwb5RjkN8O40SwhG0Et7lU/VLIuYGrBT7vuuVCx78gyRrYcOIUBdtPhfAcArfHY3BEWW34By6BrWWRAI/d19sXoXk2eECee1Yizt4qp+BVYwyFRgrqyA+RdjWUB2CIzundzeDF7K63gdzGC7VhFgmsHi6HJ0zYqF4CRlU2unonXBAbls6euyzbj1ZNOJw2vSvfe53wxnzs3ZYpemW94n1T7yO5LJ78tgJo5uYhiXBtMzGkCL8kVMm9aFGYxTDYD364YQf+mC7sOR+UoU68cctFDUNmVQoIGsmXQ07/CgKj4G5Ods4bZ00Hy55Pl90XlhU0sV/MuePAdFb7uZV1M9iYgFJSVgdW73lX1HC9qvoSAyuV/oTKwnyuLFiIp9Dyx/GPP3BffRa5QRNBRNNNJvgtnl8qwyKPjrPZianmhnwDBnBvVES0P3bG6hKMMmw+Cj1r74LpPg1u8e6bi9XRRXAZ8A0XNy1ueeq2B+JHzXEMU+de8PU44pXv7kcxOBvv/in8zUfQKhl1/14OCrDJKJ2wj6gleC53LbjicySUeJrVMKOsuxVALQ07EC7P5hdlHTQQAPKmQ64BB38OYhvxgrjw1tgz1VuxMKHaQxZbvasbmNnN9nJIIl19ay3aCEqsiLONuqIsArCgxvYE32nEci2UcbrGPbpodw0H2Qhl9f2sEEMAtVqOR0WawoXPPYxRKKgerTKAIfB0isbloUg71xxhe4KW1iEYmHoi4I0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(8936002)(26005)(31686004)(86362001)(16576012)(956004)(5660300002)(36756003)(508600001)(786003)(75432002)(6916009)(83380400001)(316002)(2616005)(53546011)(66946007)(66556008)(66476007)(2906002)(31696002)(38100700002)(8676002)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkdJdFBkTVRQOHl5a28vaDVhOUh1eGpSdXBYaEFkQ3BaQ3F4cEk4bUR1eGNU?=
 =?utf-8?B?cVpuTXNIeWlqZXB0TTdFK0t1U2dJb3B6dHJOakdwM0Z5M1BhMFRPeCtnaXFl?=
 =?utf-8?B?ZXJ5dHBWdmYrVjRZNmRjazQ3MHVzZDA5WmQ1NEZkSGtxTmJtYkxjRFI2YWNt?=
 =?utf-8?B?eDlLS1hkWEhQZ0U0VFBpMlQ5b2ZGZzFWSXVjc3U0QVNDbkJxN3h3MFFBVzZp?=
 =?utf-8?B?Y3hIL3NKQ3VsTjFmcmd5VVBDQmhBN1JqUEE4ZGgzUzlVRnVRWnk3WG9aSFE2?=
 =?utf-8?B?RTlteXFKQitJbGs1S3Q5REVwWUQrSDM5NEVyYkxwNWRremdjTTljMTNVK2ZR?=
 =?utf-8?B?QTZLUFJBZFFjWU5Cd3o2R1Z5bDlvQUltK21jNTBrL1V0TWdZZzlDZks5RHNU?=
 =?utf-8?B?UC9zQTJKbEZ3WTNQRVZoNVhhSjRoaVJ3Wi9WL0dlWk1tS3crOFFXcEZSc2xW?=
 =?utf-8?B?SEZTRFBueEY0SVFINCtaTUM2MkRLUDJ4VDJnRFJTbmhMVHlCYVlPMGI4U3Nk?=
 =?utf-8?B?d2xFL3JwWG9vc0xwQVZRT20xa1NBSHptS2I2SUhmVGhCcUN0aFN1Y0dvQ1o4?=
 =?utf-8?B?UlE4eDRnTENNMjZvMzJKaXlUM29GUENiTGswcHpyQ1pjTVJ6cWVlZG94cFRq?=
 =?utf-8?B?OXlrbzdwTTN0Z1FEYVFLa3M4NldwMjFzeEFFWVhURk1uTDJBaUlEbWVSYkJ5?=
 =?utf-8?B?bUJJTG4vQzQyVzBNeHZFNVI1WHRBc2ZZc0tOMHljbWJpKzBpcndUUVhGTkdE?=
 =?utf-8?B?YXNTOVdkZDI2emdaY2I4ZVVHMTFKV0w5NG9Zd0h6akMySXVRRkVNTUloL2Rz?=
 =?utf-8?B?V1pFNERxL1RtY25SeFhGUlZZdFhXMDRxNjZjYk9YT1NYei93NEVoVnZGNjZD?=
 =?utf-8?B?aFhkNFBhdGpzNDZMR3dXTXBWeC84WG1TOVJlV2k3Ti9RVmJYcE4vdnpvVzhs?=
 =?utf-8?B?dmtEbTM5ZXNocHk4UXVuNlRvNVhZYVlmdFdCNmRoV0ZkRmFTU1ZJSGxjaGNT?=
 =?utf-8?B?R1ZwNitIS0VvRzVzM0FPSDRlblF1cmpDZk1tcStVQW5tcmpTUDZYSGhWVUFi?=
 =?utf-8?B?MVhNdk8wU251WlR0akpnbnBzUzRFVmVoemVCVE02K1Ewd3FYYTgxa2xBbVVa?=
 =?utf-8?B?RFRsQnVFT2NmQ1JxTmY5OVd2VVY3Q0xaRTBJMUo4Z1Z2d2NMbUxmTm5TV3VO?=
 =?utf-8?B?UVJJaXRqOW1IQjlrZk1wdEo4dzc0K1BLRkRJY055ekxNL005QXJUdE5sL1pm?=
 =?utf-8?B?M3VFZktrdnA2SjdHREtqWmFyNGZzN3FPSXFNdUYvUUR6bUlhNmpPbHlwS2ZK?=
 =?utf-8?B?NUY5VzBJTFlxY3hYUGtkbFdwQ2hVTERqZlNLVzVFUDE4MDVKM2tPVmpHS0NE?=
 =?utf-8?B?eXF3SlBUS1Y5SXBqQXIvZXlVaGRJWGUvTGNyUWtzbzNyNTc4NmFRWWhlOE9i?=
 =?utf-8?B?QUozb3lSQlk5WitJVHBEV3VRNGFFOTFVazZSakRGUjJQdzNTbUtvM3Baelh2?=
 =?utf-8?B?eDN5MHFFRUlLTml1dE1sZllUOG1DYm8rc1FzUmNIcTZEbGxrYUF6YlgyYlhk?=
 =?utf-8?B?NENEWUgrTkVYLzZRQlpkY1d0c09KekhINktsdkRLdmhIVEZSNXI4MlZxUG9Q?=
 =?utf-8?B?MFlkMEdtSGJ5WGxrWmV6cVpNZFJVbk1iaVpBM0VPdWFPZTR0OHBHcy9vTTFU?=
 =?utf-8?B?OHhKWHlPMGkzdjhwbkRjNTUxTEtMOUc3ZWZMTVJMYnNUaG5aMDBiS2hYbUJ2?=
 =?utf-8?B?OVNYL2lEK2pWMkVOK1pJRCtSYjNiVytqQm53NjMxUEpZSEw1VlVTNWFrMXBV?=
 =?utf-8?B?a2N1QVh0eVJTU0hGVkxZUVNhaW5MM1JCT0ZGdllkSDU3SEtHSVJ0UkV6WWYz?=
 =?utf-8?B?ZXZJeGYvZHc3VWJteW1pWkVqQXdwSDNBcXdKV1RKV3JaTGJ1QU82MFJna3pj?=
 =?utf-8?B?MytUMS9sd0VnUnpxaUQyS01ZT3BFaFRmeUQvT1UxU2pSTFE4VkYyRGIzb2Zy?=
 =?utf-8?B?SEhDTlFjVmpoV0xzWkYreEM1Wm1tejVHR0ZESWYyOWt6aURrUmNwampja2Yw?=
 =?utf-8?B?bU1HdlQyNS9OVHRHM0ZpdFVtMHVGSzl5N3BTNkxGUjNwVk9CMjZmRU8wYXE0?=
 =?utf-8?B?NUVoUEJXbFVpOWg2c2R0UkVSTEpOWkxIZHcwclY5ZE53ZmJHcEwvS09jQ3pp?=
 =?utf-8?Q?+Wvnuo4Hlc+rl3tYZUcBqhU=3D?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d845aaa-cedf-4f8e-8bd9-08d996644589
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2021 20:32:45.9782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PWUDAM2iRvZrJJLwOSsWAD73vqKyRW2WIxv2qphSeSLx2kKD7S2nXBni1y3qh4ak/SEmjzLtsYcy4X3xPBTHIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5476
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, JMQ_SPF_NEUTRAL,
 MSGID_FROM_MTA_HEADER, NICE_REPLY_A, RCVD_IN_DNSWL_NONE, SPF_HELO_PASS,
 SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Sat, 23 Oct 2021 20:32:50 -0000

On 10/23/2021 1:35 AM, Mark Geisert wrote:
> Corinna Vinschen wrote:
>> Just to close this up prior to the 3.3.0 release...
>>
>> Given we never actually strived for 32<->64 bit interoperability, it's
>> hard to argue why this should be different for the clipboard stuff.
>>
>> Running 32 and 64 bit Cygwin versions in parallel doesn't actually make
>> much sense for most people anyway, unless they explicitely develop for
>> 32 and 64 bit systems under Cygwin.  From a productivity point of view
>> there's no good reason to run more than one arch.
>>
>> So I agree with Ken here.  It's probably not worth the trouble.
> 
> Sorry, I've been sidetracked for a bit.  I can agree with Ken too.  The only 
> circumstance I could think of where multiple internal format support might be 
> useful (to non-developers) was some user hanging on to an older Cygwin because 
> it was needed to support something else (s/w or h/w) old and non-upgradeable. 
> Doesn't seem very likely at this point.
> 
> I'll try to get the v2 patch out over this weekend.  Same end-result for same 
> environments as the v1 patch, but incorporating all the comments I received.

I think Corinna was saying that the whole idea of making the 32-bit and 64-bit 
clipboards interoperable is not worth the trouble.

> To that end, does Jon's suggestion of /usr/include/sys/cygwin.h seem like the 
> best location to define struct cygcb_t for use by both Cygwin and cygutils package?
> Thanks much,
> 
> ..mark
