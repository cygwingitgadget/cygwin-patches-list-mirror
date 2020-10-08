Return-Path: <kbrown@cornell.edu>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770123.outbound.protection.outlook.com [40.107.77.123])
 by sourceware.org (Postfix) with ESMTPS id E7C7C387087B
 for <cygwin-patches@cygwin.com>; Thu,  8 Oct 2020 21:36:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E7C7C387087B
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mA6m/JW0+BOc+3JY8+D2ls1hwOYIoBS9u70qwa/sLoaGjFjg18ee9AhfkQYW2X6jYKfL0xzW93LJD4cBEEVrA8gPTyvHeSnZytg9fGOsS3n4YWa6Gk/qw87s/ZmAYAq0CqA3SXokrhK2ViP6UtC4I4g+08+O8oy+hR8VOBgn5JV4Zdfnj9XzhqRqFixw0yDuvWAFG/5CHU6J7utKkF7rqPN2c8t7d/jLxCGOtUGep33svY2H8fLp+5OFcxrf83lQBKME6gQUoPfyG65EospbiU26oIj0tjJgq+Q0xvdAJCH/PaNB1RlAxWPiLz3qZVB3EkPHv9AU/lDrX1MLE4xdZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e72xl1WRo3DFwpPOOu5U/5baZPROsaaLVNV/S80Ydx0=;
 b=X8TBFZj3HSd6QNUptVESStLwA6E8Vh6M1a+vDekg8pEZKcpD8aW8gsSM6pYpJxDOps2tYCldCt9FyKV/beR2p/nLEs/AcWDW2yc1lxTlNOds8BRiGjmjMqS6zrQul+ua2vdEfSv4IPVRT7NzVx0kXQLlz9RahGo7IozOMu6wkryiTjh0lIMtoyzW26X2BojR2iGcbsdpU2LTK3VEgTgWhMrps8zx0qPjOCGH3geG5HelnPJEh1HQojmWjsPaWtfoFBIq1dn0UHg0NPB7Q8UFCkE1IYIv2t4+jxKXjQNPbw+xju2LxSFOUdVepMPb7LAvf5fR1532ALEWdXHwTjn9Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5760.namprd04.prod.outlook.com (2603:10b6:208:3e::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Thu, 8 Oct
 2020 21:36:18 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44%7]) with mapi id 15.20.3433.044; Thu, 8 Oct 2020
 21:36:18 +0000
Subject: Re: [PATCH v2 0/6] Some AF_UNIX fixes
To: cygwin-patches@cygwin.com
References: <20201004164948.48649-1-kbrown@cornell.edu>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <87bd83c6-5333-6287-01ce-d91ffec83244@cornell.edu>
Date: Thu, 8 Oct 2020 17:36:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <20201004164948.48649-1-kbrown@cornell.edu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2604:6000:b407:7f00:946b:663a:1a3:dfd2]
X-ClientProxiedBy: CH2PR18CA0023.namprd18.prod.outlook.com
 (2603:10b6:610:4f::33) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2604:6000:b407:7f00:946b:663a:1a3:dfd2]
 (2604:6000:b407:7f00:946b:663a:1a3:dfd2) by
 CH2PR18CA0023.namprd18.prod.outlook.com (2603:10b6:610:4f::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.23 via Frontend Transport; Thu, 8 Oct 2020 21:36:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 003cb7ce-a351-4048-2b95-08d86bd23136
X-MS-TrafficTypeDiagnostic: MN2PR04MB5760:
X-Microsoft-Antispam-PRVS: <MN2PR04MB5760F2D017845BE4F1FA55A4D80B0@MN2PR04MB5760.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B1Ec42QKRtm8cdJouWoxYYpWG9y+ZqJQksbB5tiE3mlS7kKoVQYMEr7r5s4/A3B3y7SY+CMGLx5HZpVkeGFnSza/O4SZQtHCKLtDmYX2PgvfnvfxL3JpoIZnF/VEUy9EYki7RtUFkLRZbZzVaEXYkEvmO0FPUGhDdKK7Hw2+xGQJR99TTorolxOIepT0AlSkkoNemGyVTouOCGYG86ihLO7SsFJzlYCOSIJVVAI56GGc3ijV5DmXDv6vjA1rBGBbkXi1jgsqFQ+TfpfvS3GiP7srHQmMrzWSVsHDgx4INMnQrAh3yJG3+asA++H5ItYiu77gS6ZKisAlimhCin9spL+ARShAK/Qkqk3pbOKvQU7CfTa0tcwWFea6krNwyNNd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(8676002)(16526019)(53546011)(786003)(5660300002)(66946007)(66556008)(4744005)(316002)(66476007)(186003)(478600001)(83380400001)(52116002)(75432002)(2616005)(6486002)(8936002)(36756003)(31686004)(6916009)(2906002)(86362001)(31696002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: myoLm30ZVZWHJ2N0EOJl0bYDuvhf1bIB6U1gOJS/Yx8TNY6iqSPErookSAajxwGOW263yZLUUj/s4JHfkP/9tRhnw+iFcqRFWbGxh/RlX5Qtcex6qjaPEGbus0oWsZvxbWmSalJrn1Q3zS724cx0qbq86kSOtf8YGJE2FeBB60ly9k5bn7izz+ZkRnPXc2mHHrQzwa/kP3N0yniA+b89nK1H2HwB6PP94qPrC2KQv2yktXOepGSoiSg50i0XMKQiWLvIe5ua3nruMIU6CqciFQpl2chQW4eJz1VrosmEIbJLCvxQTs8hp5vsw6ysrnn5rioBqGNJJyyfVg8wB1ZD1gb3OGbEAmqTcLZ2nB0XqNtZrVpzb8stJ3H8LxGe4lgqO/zZH9DIsW1SaVjZG4wW56BoSmOXjYcdCJsPM2OObrXiZ70Op38tnCZwJS64F/lw5Dv6nra8aRuXSEtDjU/xs8AnXRfqaMagXgO4rJRq5S2fxZOaX63klDS3dzMjdaVYMfIZ9zybuqQOfNcDmvumQHoIFHe8oVZYHlbMEHtp+pgjcYoVS/UBz9MDEBa67kF3qc+NXzZ/gi5PLGvjZw52BzJn9BzVdBlgw53iZvogsZot09sWeoRhc/CRewM+aBsydKuMOJNE3vSfza8uf0U288IIZoRPVsGu0OCn+3FByAyiJQFrSr5lNaArYLGjPIvGazjfGlaGGiJLWif4UPRBEQ==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 003cb7ce-a351-4048-2b95-08d86bd23136
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2020 21:36:18.8481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nw5VIo96NuGJ1PBQOKJdYYpKiSfuGR8AtOnj3XhdNOOOT6v3MqTI3/dVXI1Du44CxJBlvchO5fXICfYjPsHR/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5760
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, JMQ_SPF_NEUTRAL,
 MSGID_FROM_MTA_HEADER, NICE_REPLY_A, RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H2,
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
X-List-Received-Date: Thu, 08 Oct 2020 21:36:23 -0000

On 10/4/2020 12:49 PM, Ken Brown via Cygwin-patches wrote:
> I'm about to push these.  Corinna, please check them when you return.
> The only difference between v2 and v1 is that there are a few more
> fixes.
> 
> I'm trying to help get the AF_UNIX development going again.  I'm
> mostly working on the topic/af_unix branch.  But when I find bugs that
> exist on master, I'll push those to master and then merge master to
> topic/af_unix.

FYI to Corinna and anyone else interested in AF_UNIX development.  After pushing 
a few patches to the topic/af_unix branch I did some cleanup (locally) and 
merged master into the topic branch.  I don't want to do a forced push and risk 
messing up the branch, so I've created a new branch, topic/af_unix_new, and will 
do all further work there until Corinna returns and decides how we should proceed.

Ken
