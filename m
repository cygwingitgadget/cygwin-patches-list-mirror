Return-Path: <kbrown@cornell.edu>
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2099.outbound.protection.outlook.com [40.107.93.99])
 by sourceware.org (Postfix) with ESMTPS id D1945385703B
 for <cygwin-patches@cygwin.com>; Fri, 18 Sep 2020 21:17:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D1945385703B
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIf6H/xSa2HTAfbp2pXnbBFe5eVJpi2gnId94YfIo2S1XvMWkWM7vcT32IGFIwwL7gWF47wAb+Cyc/JuoTeXuWg1jMbzFPjVq0KhcjF9v1uU1EUuT7ZCwJwKiRm+YkjwWmolMYRWtLHzy1fIhdbJEArCr1r6B/V0ZGbnBRQArR2cPHO7WA1CxV8MfzV80fnX+fbvXwsnDY8k82l4XzhlO/GGUoMOh5rZ5P7osq2TAuNx8VQVmvXJsXGGH5faQgbkB4iB/3jqbPEhJACLSC+VDbS1tVJ0XxCQmAFElrftlwagSM2E99hZCJpLVoUhbiCbanMssq83WdHS+4dQ+b27rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GN1DHzlpPHTStIqiFYRQgZ0EoZE1WJ5ggNwV6GfQnSw=;
 b=lH9Gkh5Oz7FKSbUxwyBpkQP/+R5OItEupyTrgExt9o//9eQ6kTIJ5fW0hnZKlDZdakZ6vpopfai2NJbWZXPlWkk33HNy9VapHI+NmHcsVM/WnQ866D8ioKkuKCN1vKz08EIR/hLoxgdaaABBAenlizliX68bYpvs7c8gaxsEF5bZMZmrEvbr/ivCxcdaCPVDj/tZwdwqATJwIU/47NBKztW4AHqtGN9dZ/pyJ3qJidHhCbCXRwI7kMHybwsvoNqyvGhRfPbRx4G8FXMfEURinE7E9fTQq7eVAvIHWEq1YdSD+O5BHNIt3xgQveVjZ9Ntoqxd0Uk2XcFbTPebLnrlQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5488.namprd04.prod.outlook.com (2603:10b6:208:df::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Fri, 18 Sep
 2020 21:17:36 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44%7]) with mapi id 15.20.3348.019; Fri, 18 Sep 2020
 21:17:36 +0000
Subject: Re: [PATCH v2] winsup/doc/faq-what.xml: FAQ 1.2 Windows versions
 supported
To: cygwin-patches@cygwin.com
References: <20200918025335.43795-1-Brian.Inglis@SystematicSW.ab.ca>
 <ea6c7db5-5c8c-6e5c-d9be-6ffa50f2d236@cornell.edu>
 <b347ae40-0eaf-8fd6-9698-f3a04f5640ff@SystematicSw.ab.ca>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <83715369-327e-9159-9bf9-3de5e27b47a8@cornell.edu>
Date: Fri, 18 Sep 2020 17:17:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <b347ae40-0eaf-8fd6-9698-f3a04f5640ff@SystematicSw.ab.ca>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR20CA0021.namprd20.prod.outlook.com
 (2603:10b6:208:e8::34) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.17] (68.175.129.7) by
 MN2PR20CA0021.namprd20.prod.outlook.com (2603:10b6:208:e8::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.13 via Frontend Transport; Fri, 18 Sep 2020 21:17:35 +0000
X-Originating-IP: [68.175.129.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3c6600f-fbe1-4547-e86b-08d85c1843c9
X-MS-TrafficTypeDiagnostic: MN2PR04MB5488:
X-Microsoft-Antispam-PRVS: <MN2PR04MB548856863205728209B6FC26D83F0@MN2PR04MB5488.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 95AgOyaZ13ebkRtWwtmri88bimVB3lPnyvWv1SGwyW67mrmEWCKeVhg3ciKIk/7beQ1SEXxaIfzjaWp/e0jTFYJq0yC0NFkWzRvMFxyeqBiw1X5J4FRgj0Lkk5foTeOJp+wu3qx/cQZC7SamtitDcZC5Qy3nalGnwYMmSlKfiFGJI37L03FsQD+lc+Nf+KiEmtLBFP6gtIlENyFVOckLiKFiAW/BSRPlzHTN+IL1+jHa4vu8g2Uj3liLb/Pz8Bzl6yNAY4J7Yy5yBKEBAx8O3+UWodlvfqs07FMbzNvJQhMyCNlg2X0POQBn54iuqCDXqptcPGdgqYvOKxsYSbexKuerR79OoLqu+K7BJ8yYLilmjZdNzG159X4qG5tl51t8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(86362001)(26005)(66476007)(53546011)(31686004)(2616005)(956004)(186003)(2906002)(66556008)(8936002)(5660300002)(36756003)(16526019)(16576012)(66946007)(31696002)(6486002)(75432002)(786003)(8676002)(316002)(52116002)(6916009)(478600001)(83380400001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 7gtBIQzSX6a0zZqWZOw+hg9FgfFI4Q1N9fKz6jFJ9nb9TYyxkvwXq8jUxAVsjW+xJswtpppkETLDogX5egmiow+6J6f0RUL4icicDMb16lUFkVjJwmJeKOAiB8dSl+g/M3gqAQwoxrRtwfvlB0fL0iUBL7eX6VO43FqOG7l07q+2xDNrHI4z/OM0wLHvCQuA8AnLgkVXOH99ZmIEbQnz/BRPQNR03a04/ZeRgisZMZU0RgfH1tpGSWtfyPRxj9tGBlaQ58IOrEIaJsYUxDlCUdOsrWKHWudtP6e0BJLKpBUFCYt4x2ZM6KgWgJFHpBHYBh0ufI+vuSSQFNgDNzrbwusZGlQAo5j6aECe7jNmFFz94Bsw3iSnvpASYiQ9zRPfTeluRrSdCRONniK3++UBOW3DYiT9bWbeDxFr2CgRIf6ldkjHqPbNaZtSb25Wl7/HR5nH8d3cfMqNTT4iX3PsHV+NE91Ocg9pkchTa28pnI5bWTB95KaeEhnNO+hxbuVes+wlEZRyVN0EHbLy0pq6y0zzZu3q5QkGeRnt91BnoQCIiO/XlFDZPIFTccxNOHDgvsW6kj/QeK9oPQAGWCnVpJMM5FKfNY53H4s8JcfzduUpApY9cTZ8BNpZRSUstc99iI8BwrntDJgr/dPEaAVGnA==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c6600f-fbe1-4547-e86b-08d85c1843c9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 21:17:36.1490 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uSvqIC1LtRTDpOIEz8Yov/rgZg9XQcdYNI6LeSJi3HLeaPrv4X0YOw/n43zNpmkrEOX8IIH3nn6FEsEO9dGLgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5488
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00, DKIM_INVALID,
 DKIM_SIGNED, GIT_PATCH_0, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
 MSGID_FROM_MTA_HEADER, NICE_REPLY_A, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2,
 SPF_HELO_PASS, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Fri, 18 Sep 2020 21:17:39 -0000

On 9/18/2020 11:29 AM, Brian Inglis wrote:
> On 2020-09-18 05:59, Ken Brown via Cygwin-patches wrote:
>> On 9/17/2020 10:53 PM, Brian Inglis wrote:
>>> enumerate Vista, 7, 8, 10 progression to be clear, and earliest server 2008;
>>> add 8.1, exclude S mode, add Cygwin32 on ARM, specify 64 bit only AMD/Intel
>>> ---
>>>    winsup/doc/faq-what.xml | 10 +++++-----
>>>    1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/winsup/doc/faq-what.xml b/winsup/doc/faq-what.xml
>>> index ea8496ccbc65..77ba1c5fdd9c 100644
>>> --- a/winsup/doc/faq-what.xml
>>> +++ b/winsup/doc/faq-what.xml
>>> @@ -30,12 +30,12 @@ They can be used from one of the provided Unix shells like
>>> bash, tcsh or zsh.
>>>    <question><para>What versions of Windows are supported?</para></question>
>>>    <answer>
>>>    -<para>Cygwin can be expected to run on all modern, released versions of
>>> Windows.
>>> -State January 2016 this includes Windows Vista, Windows Server 2008 and all
>>> -later versions of Windows up to Windows 10 and Windows Server 2016.
>>> +<para>Cygwin can be expected to run on all modern, released versions of Windows,
>>> +from Windows Vista, 7, 8, 8.1, 10, Windows Server 2008 and all
>>> +later versions of Windows, except Windows S mode due to its limitations.
>>>    The 32 bit version of Cygwin also runs in the WOW64 32 bit environment on
>>> -released 64 bit versions of Windows, the 64 bit version of course only on
>>> -64 bit Windows.
>>> +released 64 bit versions of Windows including ARM PCs,
>>> +the 64 bit version of course only on 64 bit AMD/Intel compatible PCs.
>>>    </para>
>>>    <para>Keep in mind that Cygwin can only do as much as the underlying OS
>>>    supports.  Because of this, Cygwin will behave differently, and
>>
>> Pushed.  Thanks.
>>
>> Ken
> 
> Thanks Ken,
> Do you have to run something to regen the docs, FAQ.html, and push to the web
> site, or does it run periodically, so I can follow up to the OP and get feed
> back from the responder?

No, sorry.  I don't know how/when that's done.

Ken
