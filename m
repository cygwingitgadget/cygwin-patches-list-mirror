Return-Path: <kbrown@cornell.edu>
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2120.outbound.protection.outlook.com [40.107.100.120])
 by sourceware.org (Postfix) with ESMTPS id C32C73944424
 for <cygwin-patches@cygwin.com>; Thu, 17 Sep 2020 22:22:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C32C73944424
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAskkgIOYLaAXZrJKFm2skfnuPU2NrpYTJyiOycNcVUonsHBBVUWexrF5SNR7bgIaG+aPOA9NQkXZw//9RXKifKpPc/p6STlCVz/L4dA2gm9RiYBO6AciYEwHgG86CFheL9nxlDsdIUQDwIHYaGLQB3dfak45roLuA5nAvFApSLm+t22iIPCb6Qgl7BkNkrofszq50EtzuGrnAnqPGDiKZFpC5eDiq9ot/ynx8uiQFNp79EpfeMrztucSSsLkl4Qx+VhdN5rP9gLtQJWV/3SBte494Pn8ygjQbV/seJKqhpuedv/KYJWE0ODseF/I+9t5UuiyRirybSQ/7SyGP3oOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izn/liYEflHqz9cbx4ca95mXQCMMT2MdJWYNVSVd2tk=;
 b=n4UaatJa1ethV+Jjo//We/QvxEtK5RnzmjAn6+mp3Uqdva7ag7dl86JlKF0g1zrjhsqotp3u27Q5N3SjFljWmE+M79lu2z1L9rXiQga92RlJqog7GBlJyGiB1odCMqZRU6zEgJzhnU3JupwBRwEakbRz+2pxjpLNYdhbKWenwMWUvYge8mGggN9PJg/L3fDVgs6ulC/NrqPTUKhwmiy4zo5qkaL/0jEs/IWOqHR4bmtKGGWGRKUwsr5qKrrwZ99dFP4isPcdAIuRXBBowOid6Ng12tnHUHQZ7KUoed9i8DtbEMXbrV3flRUPwCV0ZQo/D3Z9CAUpPOB2pCIvSS2p/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5565.namprd04.prod.outlook.com (2603:10b6:208:d8::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Thu, 17 Sep
 2020 22:22:13 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44%7]) with mapi id 15.20.3348.019; Thu, 17 Sep 2020
 22:22:13 +0000
Subject: Re: [PATCH] winsup/doc/faq-what.xml: FAQ 1.2 Windows versions
 supported
To: cygwin-patches@cygwin.com
References: <20200917182917.6116-1-Brian.Inglis@SystematicSW.ab.ca>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <f5cadd54-84dc-9511-3cd0-c18ee94c9ebb@cornell.edu>
Date: Thu, 17 Sep 2020 18:22:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200917182917.6116-1-Brian.Inglis@SystematicSW.ab.ca>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0064.prod.exchangelabs.com (2603:10b6:208:23f::33)
 To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.17] (68.175.129.7) by
 MN2PR01CA0064.prod.exchangelabs.com (2603:10b6:208:23f::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.13 via Frontend Transport; Thu, 17 Sep 2020 22:22:13 +0000
X-Originating-IP: [68.175.129.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da10fac6-db08-4690-4d33-08d85b58206a
X-MS-TrafficTypeDiagnostic: MN2PR04MB5565:
X-Microsoft-Antispam-PRVS: <MN2PR04MB5565AAE5FA2A9F3BEA053800D83E0@MN2PR04MB5565.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iIO33+boYOsBj5XTA3dSITjsF95oabHza1Hh8t/FzB1qOSEk3BRn58Z9QlaSk1yd2tTDtWKJvDadpaJowDlylTh8s53SKqqLLTJ5wOPP3NE6o0otn41UCjIn+brjMzsX4FMY0jXzE7AhqjaQom9SZgYy4bGP+0BQJwqRnB6rQPH+KeTRZ31NPs4pFxn3BT38jZl3wcTNntX7ypAsG971Ne3UMtv86cTjnOAOegNJU5qbl7WRktNunDIgrN0d7i36ZSWnOe/N6ULNULN12DJgWFoW1+gEv5JKCdyR7uwX2q2Sn9Evo7ZG8NsiP655ztQc/0DJEv9j0teZdstcal5MHiAVJWO/R4GxHXUCAkPuGlVzhgxPK7aZkAF1jn4I4tG98jRdoAUqECOqXNpFAkn+IlBmfghhBlhxhWnfIxn54N59MwrmWBJWpkKCv7ce0a+me8pJMKynEK+X/N34k6/eCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(66946007)(6486002)(8936002)(36756003)(966005)(31696002)(86362001)(956004)(478600001)(52116002)(2616005)(83380400001)(26005)(186003)(2906002)(6916009)(16526019)(66556008)(316002)(66476007)(786003)(75432002)(16576012)(53546011)(5660300002)(31686004)(8676002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: L58wJ29rH//IBzuVuvPNS7iN8aY1Sb3rsO+hq9+7qGi7lI6ye7bGX8KBainYWu5m88DjAwbwWfMNSo8BEgtM0jykb/JCsrUp1ByvrMfgkRwftpqsf/NeRS7yT6rQm27hcszXD/RPiC0AI5e9RkJ7FAHKEJcDD2/3yIT1tjME82UVxXFtZRiZGUODMzWiZ8fbssKjhXvEC3E+UOilnZObGJw222YmehNxdKXao+4XH2Q5nNHg9l+fMg5lAGRZFHFiqfy0gpjVk8tA9dUqRrKP6fGF8wkU8Yvd3FyWfXHtN93wrqhDLboxt7q9JQNRt9Qf5gHnJdzvY5wSbmGvMPIq1SCgOMb/6FLz6pELXg0PqMblqO0pvuZwPcaY/Gb2JxAySu5UqCdWmrxslpWdzUJ+uE7o5yEDQzobMCKKTwBevmMFxVGBYzXeTjRHm5R/knGD0rWfrPusEGuyWC65ciksKhHkhF5r+jbfpgDmqsl8Av90FxgsOvYrTE/LTXzR3qz43WLAjfTKmc/mmFVRTtMduCiRTmyh67NVUjcKDx0QxUG+D58B7S23tYI0KLdU1KXaDVFcSlyBfssxge9QYTySgFng0WKKmUZNHEvaGyvhjDOK9H0zIRtAa5STpRIMTbbEzqG01is/VPjJTrXaJrJ9RA==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: da10fac6-db08-4690-4d33-08d85b58206a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 22:22:13.4231 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ucXNS6Xi3R5n9+d9jV0BPZpTmPIMvjEtFh1b382mxjK9N1Hiez2YFXSSJC9kCBhp+lINQVeOB7A3VVsppgNqWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5565
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, JMQ_SPF_NEUTRAL,
 MSGID_FROM_MTA_HEADER, NICE_REPLY_A, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Thu, 17 Sep 2020 22:22:16 -0000

On 9/17/2020 2:29 PM, Brian Inglis wrote:
> Based on thread https://cygwin.com/pipermail/cygwin/2020-September/246318.html
> enumerate Vista, 7, 8, 10 progression to be clear, and earliest server 2008
> ---
>   winsup/doc/faq-what.xml | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/winsup/doc/faq-what.xml b/winsup/doc/faq-what.xml
> index ea8496ccbc65..09747532c2e8 100644
> --- a/winsup/doc/faq-what.xml
> +++ b/winsup/doc/faq-what.xml
> @@ -30,9 +30,9 @@ They can be used from one of the provided Unix shells like bash, tcsh or zsh.
>   <question><para>What versions of Windows are supported?</para></question>
>   <answer>
>   
> -<para>Cygwin can be expected to run on all modern, released versions of Windows.
> -State January 2016 this includes Windows Vista, Windows Server 2008 and all
> -later versions of Windows up to Windows 10 and Windows Server 2016.
> +<para>Cygwin can be expected to run on all modern, released versions of Windows,
> +from Windows Vista, 7, 8, 10, Windows Server 2008, and all
> +later versions of Windows.
>   The 32 bit version of Cygwin also runs in the WOW64 32 bit environment on
>   released 64 bit versions of Windows, the 64 bit version of course only on
>   64 bit Windows.

Since this is something that changes over time, I don't think you should drop 
the date completely, though I see no reason to retain "January 2016".  What 
would you think of revising your patch so that the text says something like this:

"Cygwin can be expected to run on all modern, released versions of Windows.  As 
of September 2020 this includes Windows Vista, 7, 8, 8.1, and 10, Windows Server 
2008, and all later versions of Windows Server."

Ken
