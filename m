Return-Path: <kbrown@cornell.edu>
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20705.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::705])
 by sourceware.org (Postfix) with ESMTPS id 81BD73857026
 for <cygwin-patches@cygwin.com>; Mon, 21 Sep 2020 22:39:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 81BD73857026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrXRrmZ7B8TOd9NXCN2fCtsaIp4mNASf/0KNKTtGnpvBJT7vVLDreH1LpWiyTKHYYn7/y4aKqmpk6Mo3KqdLLaXO90MK71rL9UUo63+mjH0qyCqlq4G7HgqxpKYQfa2dLCmWfmFxE1dxZZLkMFxl0MDn97Utb+4Eb1YLbkiRHxDHmYbK5K9UvYtq0XRo4/S2dD7qEjL9at4xgEGiN+xRcSs1z6E6oKaAqvJVfy1jqeVInyzZ04idFMBSKxk/krjA9RyGWhzuHolmKI7F1WwWR+AzYrii77HoTyoIIuWMkoIZ9qVo+gCZDACiZtA6muK7ZB6mpUu4QgycqRNIrTjmBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCHeWGmpTw+5OBd/8yU1tsORkSf1Yz8ylSoqBtgDrgg=;
 b=EsW2B2JwMa0PnbiFW9Pzxx2fMsmNrogjb7doX0fyijtbm+mho8I4mILBhFf6v+9BIy5J2kvtRBsXQbXVWijTuySyO1gSMWN0y9tCG1c+YCsyPy9TKukNZe/pD7j/gswTTpzFLix+O13hbJNRwjUshClVtbbJByrG7w9PB37zx6BwFC8zUj8qyeUB+iHRVMrGtL4bxQ9xBepUyLzr1FbD77rjEfHG6zSj2qlvt8dIlqETGWZ2c7yPMcsBnUIfKKFm618+gNkg3ResuXaY+AwHK6WrkS2AiL4EqeunmYMsY6DWNDFA7jYFM1cy+hExqyxfmPnq15tf9bvjMK+zYG5v5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5661.namprd04.prod.outlook.com (2603:10b6:208:a0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Mon, 21 Sep
 2020 22:39:32 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44%7]) with mapi id 15.20.3391.026; Mon, 21 Sep 2020
 22:39:32 +0000
Subject: Re: [PATCH 0/3] Warning fixes for gcc 10.2
To: cygwin-patches@cygwin.com
References: <20200921192526.36773-1-jon.turney@dronecode.org.uk>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <1425a69b-d1a9-1479-4083-3839910352ee@cornell.edu>
Date: Mon, 21 Sep 2020 18:39:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200921192526.36773-1-jon.turney@dronecode.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0018.namprd18.prod.outlook.com
 (2603:10b6:610:4f::28) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.17] (68.175.129.7) by
 CH2PR18CA0018.namprd18.prod.outlook.com (2603:10b6:610:4f::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14 via Frontend Transport; Mon, 21 Sep 2020 22:39:31 +0000
X-Originating-IP: [68.175.129.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97cd4278-bbdf-432c-552f-08d85e7f3552
X-MS-TrafficTypeDiagnostic: MN2PR04MB5661:
X-Microsoft-Antispam-PRVS: <MN2PR04MB5661508169EA11CA4188C4DED83A0@MN2PR04MB5661.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fl7cB7thL7f+cgLUIkIIahIijEBzFYICOm3/hHD4BSg8y5jiUdi24dxokDKgBti/0kiFLVecQ6KxCINI4ULo92rwIeLgstRS/dkM3JlNbz3H5GW5iOMv3VIcRGg1vVj5mPtOabAYDyhuXZLn0y6NtQ1VKHz9oZgyrbHNi+Un2WQwAuw+uOVv8Wvt8y5tpiEld+bkZeuw6zeulqri9Kfa8eN9VPqk5YSUVi5hCwDMkSwMPp3JMmkAGLqeOrURErDPSBOuygnhJgssSvSSRTwBQq9QzoGCKXkYnvxKtjbWN5to4bYBsbAWXmwzN90GvPBPe26de1zhOLlpD416SXW+oHpiwvm8/zcVXWhX9fNtpExen8fq9CPO6lPxMlG5xVQU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(66946007)(86362001)(31686004)(8936002)(66476007)(2906002)(6916009)(26005)(186003)(8676002)(66556008)(31696002)(5660300002)(83380400001)(478600001)(75432002)(6486002)(16526019)(786003)(52116002)(956004)(2616005)(4744005)(36756003)(53546011)(16576012)(316002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: jiAYKEXhN4A5pLFaMJDCeDlCQ5RThcwz9umE4pcdb/rlz6jfI4JKENk9nkSlmaWTqzlNrKKyAhI2KCn/rFCJCVG7x7B5P9m+s9vdJ8as7pJaKgLx27zYOd0panQVHRxgUSAT2Jle5n5OZIuNYAB9wr+zDA+OS5J2lbAyOM1esdxcAas/0zVv11cJJycR9zFwtj3I0gr7k/1A4nIhgNYxadlT8IQdeurchS71LKQ7loZ0oWzSnIiPdWOI6GHCLvpHZxjo1rKjLDiQRo3Q26FKGInbr9DUyx+bs0YZ7B+4efTKf1t417OUZ7+U7SfMiYl1FofZdGzNsTQv4DJVhUFBYMiAfsd7uZ3z7QMScnU5AOXQYEpVUogqU5KnM2N0yvWM+7S79K4N///2MjNlqBa8CdCUFqMnCOVJ8sgq6E+Ebr9BzG0DJgIEAOkILTNdXA8o2ZuQQxrhxKSxYM6qIjvLUKba/8XYGrqYFxx3ceUl4tBLQVW8OfyUUDr7nns7ROsdYqjsGUJWtTV/e//taWGG3DK97nawVoU8lK+82thzRCHu9ir7NAzzUf35c6aDyKAXbtyGCkMYfUcm5GdTvpF7ovZXL+C4fQanpunNJZ+q29+bIQny5m0PE5Xh3JFuuAoAYPrjOdhHtU2aX5j7ZjdehQ==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 97cd4278-bbdf-432c-552f-08d85e7f3552
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 22:39:32.4739 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iIRlbr1A+ctzUSZo134FD9HmckLilmLoBMpnBCtDgftNQtY24t6wFU3rX2xSnsvHbeRN1y9Cpe6iZkajCdwKtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5661
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, JMQ_SPF_NEUTRAL, KAM_NUMSUBJECT,
 MSGID_FROM_MTA_HEADER, NICE_REPLY_A, SPF_HELO_PASS, SPF_PASS,
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
X-List-Received-Date: Mon, 21 Sep 2020 22:39:36 -0000

On 9/21/2020 3:25 PM, Jon Turney wrote:
> Jon Turney (3):
>    Cygwin: avoid GCC 10 error with -Werror=parentheses
>    Cygwin: avoid GCC 10 error with -Werror=narrowing
>    Cygwin: avoid GCC 10 error with -Werror=narrowing
> 
>   winsup/cygwin/fhandler_console.cc     | 4 ++--
>   winsup/cygwin/fhandler_socket_inet.cc | 2 +-
>   winsup/cygwin/ntdll.h                 | 2 +-
>   winsup/cygwin/pseudo-reloc.cc         | 2 --
>   4 files changed, 4 insertions(+), 6 deletions(-)

LGTM.

Ken
