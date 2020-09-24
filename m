Return-Path: <kbrown@cornell.edu>
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2139.outbound.protection.outlook.com [40.107.243.139])
 by sourceware.org (Postfix) with ESMTPS id 83E6C3857C52
 for <cygwin-patches@cygwin.com>; Thu, 24 Sep 2020 16:37:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 83E6C3857C52
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MG6DNnUGwe1kQ6tiX8xX6f45A5yX7nAHfJ9s8HBMgL7jMAWNU/JGrM6zxprCjav4ZCgyMm4djz7aDvcdp73hyVxTF4UV82SQ51DRoJ1yM/prPFZzrrvco3I7J/m0809uFWguZqu40x4KMb91yVTD6oPL5EXFj/RwNmH00OVhIM8nyIXJvEHxshHtNWGB596ulyXkZVYfaw64dLPZkPtOBFmouqPy20qZt1E0By1v/+J4Dwl6QRP1k9vB3ZSp0lNdX0Dk/6VuovSWXnPfCygA2naPiKfoyMFWfuSTE1lerLVDrw4NCIsNgglzmEiFkVgNSCRJBYEF7cCtfMXDhbqv/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/S/Dut15JzYNQAnkskNVQGJMo21R5ILlDnOvoj7Syec=;
 b=oBafwe4Ix791jfW0gIjsT7ppKAowIysr/m7AGLZQngiyRLIJa0C0S/5JVr12t2uiDFldcBOTEB4sDmCXpNU5I2uEo2UFxQngs4cW/DeTHUujVPJTB4eWRMB67/d9wsndEILg5saz8Mrfvik/qTlP4NwqtbIhI67sj54fLvxWKtpMMOQ5KqPjJfWfEuwzb5WMZudc4XhtDeqi6UPGO2Fgv7q+PRbgqIQCI+btqbf5x6SeujhSIhaIxZM4Jo09IauE0GhAUZrm7mBKGLr7G67qH6CKKdMWBkPVg1ncNXJDbMdCW1mGcWFKAPYHxiG1rvzKDwbQ5MgRPHJVSnsDdyoXAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5486.namprd04.prod.outlook.com (2603:10b6:208:e4::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Thu, 24 Sep
 2020 16:36:53 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44%7]) with mapi id 15.20.3412.020; Thu, 24 Sep 2020
 16:36:53 +0000
Subject: Re: [PATCH] Cygwin: winlean.h: remove most of extended memory API
To: Jon Turney <jon.turney@dronecode.org.uk>,
 Cygwin Patches <cygwin-patches@cygwin.com>
References: <20200923235225.46299-1-kbrown@cornell.edu>
 <ddeace5b-33a2-ed1f-5b30-0d33bfe61ca3@dronecode.org.uk>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <5c0bf066-a052-b9fd-36d3-0b6805ab0257@cornell.edu>
Date: Thu, 24 Sep 2020 12:36:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <ddeace5b-33a2-ed1f-5b30-0d33bfe61ca3@dronecode.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [68.175.129.7]
X-ClientProxiedBy: CH2PR14CA0008.namprd14.prod.outlook.com
 (2603:10b6:610:60::18) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.17] (68.175.129.7) by
 CH2PR14CA0008.namprd14.prod.outlook.com (2603:10b6:610:60::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.23 via Frontend Transport; Thu, 24 Sep 2020 16:36:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c59ae139-265f-40e7-b5d5-08d860a80b21
X-MS-TrafficTypeDiagnostic: MN2PR04MB5486:
X-Microsoft-Antispam-PRVS: <MN2PR04MB54865FD9E7917861DC80837ED8390@MN2PR04MB5486.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pa3/i8bV57tjRQNMcdne6HWCfuQQvRRvutLJ76DtzAkqdQq0Y93ggOS2DUjqbm/08J+QOoH71GdNchDgIiS4MEP9+TWBlelVIP/GJ8ULBObhGW/m7x21gTXVG5Uc40B/J6pevTPFI3aqig3J6NiY/NKHmTsV4Nnu3RuW4cxYQB8SjFBkyt4anmZ2mEl+MoFUq7MJkbl82ugkoDhI6KpDv3DEn4lcKQ1+wEphaDhQ+ScBHiZWrFU3IU1SlSC9AcVxzVORAgceixwL/S0StjWIrk18tDNUkL0nf434zx6ubaMiLFc9xKYSI3b9KXDzPT6EJdqSIQFUBV9CnpLEtN2M5kHe02ugXBVbKMqvVjv5gPOXRKD4/dE+T9GbJ9noxbER
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(31686004)(2906002)(52116002)(16576012)(786003)(53546011)(110136005)(75432002)(8676002)(8936002)(31696002)(86362001)(316002)(16526019)(186003)(5660300002)(66556008)(956004)(2616005)(478600001)(6486002)(26005)(66476007)(66946007)(36756003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: kQbD0T/R52kBJz9LBPAnXzbzogVuuB7Wn7RGx1l8eu00MZHTHkFkrnfvF/Pa1rNL/c4BplVwoxF7SzYcDhBMMLW/XV+lMFlC3uCoeeYcptZzpMwpixuv3eWE7FCKfA6uH7INlOVah6z59d6xzmbgGU7LTRQDQN8gcJiMj3UxI/nyQIW0MLabfZzohh+aDpmOMGorNZWvif8lYIrHijyxUpE1nxO3tCgrpPSpO4ndswcQKMIS8kBRbknL5nqdrsAex3Wop8kve7qSNUTsDxNqLF5JseElPAJ8RSFyIvZJ9C1bM91uSiJgBd+NP3kpywcHiVIlacvZOMRD4RLTbn8JdtjuUsSvn5kmgHkPALt9WO/N9UOeaEdfFjEhnfxSGdd59omzylFoiByPzfTimnCE9Mmi/UBIrGxcXZQI6nAtRPKDcf3lh/Mk9HBCrBb4JtyxUu2dR2KSXXLWG67khR9+nIKOPi9e1sxl1uT23BbzavqJmAXRbXniYananvNskaELAQGTGdU5K4IdWcq+2BSQvOdfgluC9V2KuFvxFMNltlBsuncSf0YfIHPERPLZLCxYgQlSr9Pm0h+TTjfiaXmMFJI11eT7M0DSec7B5SLYtvlKC6qCgmogjeVn38FXnmG+OtN9e0yIQL3uJm9iXYOqww==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: c59ae139-265f-40e7-b5d5-08d860a80b21
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 16:36:53.1565 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pfTFXPid5pqFGUho3SAjm2ImiLLc9iIvWQcwvKp4h/GJ6+g3Z43jRJcRZxNtOty4MMqp56CylCJIL/D2RlVXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5486
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00, DKIM_INVALID,
 DKIM_SIGNED, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS, MSGID_FROM_MTA_HEADER,
 NICE_REPLY_A, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
 TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Thu, 24 Sep 2020 16:37:02 -0000

On 9/24/2020 10:04 AM, Jon Turney wrote:
> On 24/09/2020 00:52, Ken Brown via Cygwin-patches wrote:
>> This was added as a temporary measure in commit e18f7f99 because it
>> wasn't yet in the mingw-w64 headers.  With one exception, it is now in
>> the current release of the headers (version 8.0.0), so we don't need
>> it in winlean.h.  The exception is that VirtualAlloc2 is only declared
>> conditionally in <w32api/memoryapi.h>, so retain it in winlean.h.  Add
> 
> I assume it's conditional on the windows version targetted, but it might help to 
> mention that in a comment.

Done.

>> "WINAPI" to its declaration for consistency with the delaration in
>> memoryapi.h.
>>
>> Also revert commit 3d136011, which was a related temporary workaround.
> 
> Looks good to me.
> 
> I think this isn't going work any more with older win32api, but we probably 
> don't care about that.  It would perhaps be nice to explicitly complain about 
> that (checking __MINGW64_VERSION_MAJOR somehow), rather than exploding 
> incomprehensibly if the w32api is too old?

We probably don't care much, since anyone building Cygwin should have the latest 
tools installed.  On the other hand, it's simple to add that check, so I've done it.

>> In particular, I'd like to know if my handling of the declaration of 
>> VirtualAlloc2 seems reasonable.  Among other things, I'm puzzled by the 
>> apparent need to add WINAPI.  If it's really needed, I don't know how the 
>> calls of that function could have worked before.  Can anyone enlighten me?
> 
> I believe that WINAPI only does something (stdcall) on x86, so it might well be 
> that it's never worked on Windows 10 =>1803 x86?

OK, I feel better now.

Thanks for the review.

Ken
