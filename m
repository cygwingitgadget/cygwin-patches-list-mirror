Return-Path: <kbrown@cornell.edu>
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2131.outbound.protection.outlook.com [40.107.223.131])
 by sourceware.org (Postfix) with ESMTPS id A4B113840C3E
 for <cygwin-patches@cygwin.com>; Thu, 21 May 2020 18:51:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A4B113840C3E
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnL4l7TOvq52xDDH/i6kFm1aVdx0y08AmAkhPNKkNfYiH2gmKkk7MWrpPqAFKQoreKxld+B0cG+D9DC75FAc7oybDwqjay8rcZuK12EGyqpgUIARgxSNVdGLCt1n4nB0x61KzVL90+MimA84hdYSu9Ulvax5+97u990RskY9AHfLJt96ffw3TcxCUhNUKAFuGvpup1deiZFXhGjLrCBUlTwxxvtPg+ri2NYKe6XzNlIUNI0Uy9CYsk02PnFcaBxibyBEdx+22fC8DepA9lVD5ebE6B1OPJ9roSAFRgTquMfOvDImDts7OtIWwafFIIkIv0HzP47EfNsHHWjHMJ5aVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bk2oAqVHqvrHrHHRl5LOQ7tQdGpxwjBZEaxzwPVMRiE=;
 b=WDhdidOtAEOUB5xLTNJA3c+LXUVtQfJqsRfoC5odu2Yr5JaFhKBsF23sC/phIl8HHaHu/cbws2I1VtiUwVzSTX6MjgeYSbWhvfULu9+0A8w2zeBUUhiVk/q1z/dpwq807QKdeAiCmoHFSOrLQFilZvwL0flwoMxZO/2So6bXJWorjPlzsUx2mlI3i+OjehjJiJwtZTw3eIhnHe9r9o4RH0PigTguBcZ7tgIqgMQyfEDQQqIgctqK0rl6A1SM/44qUash/oWXRUN0q5eSirl6NBa7i63cJDacw/Bn9dWzrn7CZaAct+/MbQ2UWume5Ns3cyM4+HSRzbj3MgYkN/TrRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from DM6PR04MB6075.namprd04.prod.outlook.com (2603:10b6:5:127::31)
 by DM6PR04MB6075.namprd04.prod.outlook.com (2603:10b6:5:127::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Thu, 21 May
 2020 18:50:58 +0000
Received: from DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4]) by DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4%4]) with mapi id 15.20.3000.034; Thu, 21 May 2020
 18:50:58 +0000
Subject: Re: [PATCH] Cygwin: pty: Revise code to make system_printf() work
 after close.
To: cygwin-patches@cygwin.com
References: <20200521082501.1324-1-takashi.yano@nifty.ne.jp>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <b6a0b5c3-2a79-7346-99bf-2b3e2fb76e4c@cornell.edu>
Date: Thu, 21 May 2020 14:50:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200521082501.1324-1-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0048.namprd02.prod.outlook.com
 (2603:10b6:207:3d::25) To DM6PR04MB6075.namprd04.prod.outlook.com
 (2603:10b6:5:127::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.17] (68.175.129.7) by
 BL0PR02CA0048.namprd02.prod.outlook.com (2603:10b6:207:3d::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23 via Frontend Transport; Thu, 21 May 2020 18:50:57 +0000
X-Originating-IP: [68.175.129.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95cea3a5-8ddb-450a-1682-08d7fdb7e648
X-MS-TrafficTypeDiagnostic: DM6PR04MB6075:
X-Microsoft-Antispam-PRVS: <DM6PR04MB6075B7A33D2B738154703437D8B70@DM6PR04MB6075.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:256;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mqX1qJRpCGcHRyDqlWtxH/G2ceThiAF6CHB7ko6EHw0IeaLiRSyKIVxCrLFElnzYh7bMh79OeyffinwEpNd7DTtA1lCINRPHvh/1Kh0VEGo6e3zP7TAC+taHBLuHN5Q1ng9vcA7vadwd3a3GfGHRgeeElLp4oQlAvrLYoF2cs7b9SPC0vESafSDIDDKRXQtAWin4wMCOKQIo0gUOdbAu6eN/a4JfrJSL/Y+KDT/RPhW6Du7s/O2tgu8vVY3FjrRl0NO+NjuNTeOsJ8OKAM3uqXMyZh0vtV6s3ayNhuwgaCqujAeoooijzzfTZ2Nm+mrTVZKdCk+0F/3coon8q3iuqizajSE8GlO6DdTQRlVH0VxX//7k2o4Nja8kZ9lWON0AS3CtoTEENUJLGZkrNvd0CXxdIb1UNvA8k3KQCJ3phe/e70+AHXSkKd01glfCil7kEh2JQGNNgl91ogO5IhhTjxWOGlB+wxGtGQA5uf6arUKwd5oiodow+s3sz8hPjZJVCYv8Z5DkrVJP6lPsbt+/MuRerQ032fSugGuconRNhkPOiNpEFpgj/dEmMmZbhkW9KpbPfKjUiFqHamV3Ev08SQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6075.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(6916009)(2906002)(66946007)(66476007)(66556008)(75432002)(86362001)(956004)(6486002)(31696002)(31686004)(2616005)(558084003)(478600001)(316002)(26005)(52116002)(8936002)(786003)(8676002)(966005)(5660300002)(186003)(53546011)(36756003)(16576012)(16526019)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: XUkkUEly9umSF5nOARgGO3B1VjlW7apKQR4veht3/uD8buBO06WboJL5tMu0zHhG9FlOv7HjGj5t7Hm8Yu7td3/Y46MEhbfcJVqT/zkiuOCxNRuvhSxbYogt16zQAl6utW1md9DO5lpIpcrN+fIvLM5hfuDWsgHYvoh4eulqOrYdW8w2Hlp4YHZtsN0HDx67ySOkI6m8rtG+d/UzlHILb6Zfg7UhlBGg6TThzTJQcAWPYVkyVDA5A7f7HJ01Vl+ZJXUHydGRskIhH+5EtlEWAV0sGbidXmzJaWkZfkG4BfKeDNGvBzAmhvfSp2xhqC72O5p56vvZz7ff/+z8lx0es0Jx6VzXpAuKB/rOzXztFJ7kIHjENvDtaPc5YSUfviJg4EDetZA9z/PGkCCWogU2wvgaBhoSSJfJO1L/tYpwA07M3WvanUkyBvu/Ak0K3oF0qfmZUrRpX1lcRukmaIXmoNTjN5D81v0LYKxEM1IWOoA=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 95cea3a5-8ddb-450a-1682-08d7fdb7e648
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 18:50:58.2499 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h3p05k7XKWw+Js9X+9xaqAo/MrbvV3xOU5eEwAYhgs+U91ucAdZdbmElk8O2xXMaCIltbWL1T8LQYwh0v0wftw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6075
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, MSGID_FROM_MTA_HEADER,
 RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
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
X-List-Received-Date: Thu, 21 May 2020 18:51:02 -0000

On 5/21/2020 4:25 AM, Takashi Yano via Cygwin-patches wrote:
> - After commit 0365031ce1347600d854a23f30f1355745a1765c, the issue
>    https://cygwin.com/pipermail/cygwin-patches/2020q2/010259.html
>    occurs. This patch fixes the issue.

Thanks.  I can confirm that it's fixed.

Ken
