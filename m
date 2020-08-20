Return-Path: <kbrown@cornell.edu>
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2110.outbound.protection.outlook.com [40.107.243.110])
 by sourceware.org (Postfix) with ESMTPS id 3C1BC3851C3B
 for <cygwin-patches@cygwin.com>; Thu, 20 Aug 2020 14:53:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 3C1BC3851C3B
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZgSIZslMX/YXvXgMoadJk6Mr8FJCi02RGw2m1/nBJ3VuhlF4/Lo5B0f0/c+OKFuLlRDQOowMbRKTwHWH5ipU43jv3hhRs3w2w5ef4Tq8gVQV18jR01sEwoOYL1hw9HhXSeKxuIYcXz1N6M8ym6SYrkuPz/QV7pA0IJDOnFa21RFc6qV+z4RLsPaVMjkE7QTzccd7WGircgivGMshrHCKrbmzUxgVBCMKTCtnOolPp2a3zVNhf4AlYqizh11j8p4rJPgqVnT5BRzFKcIHAp7jVzb+sEd3er9F8/rV/TdCDSe3nNKRpNy4xfSYSFMA33a6ZZGL3iU/mOed72COnGt5cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euV+73mkpTkg/luy8dfpsS2HU0mEIJ+zx5KXyeFd7i0=;
 b=QvjklyWUrPOmC1VFv1UpjTdNpJjuvVEKLh+yu+5hsFwnTUCwhZr1yJDeDhddG7jbEGmh1TVcnRjVhyJomLgr9w2ck3nM0LVWUf9hIsJ11m3BZg1Gzdjf0Jb/WK4WqRCpFHnYv0GpjJT8gR01ErHUR5flTdH/KJ1BZHvMIwCbgfKqwUmuPIz2RG0MeWDgYIrXmonx0ECQD7JOYaT1+TqPJ4nvqYciVcPA80oXgqCN4QjnPiLUU/4G4s1Lt6JKGXcYhJj7i148Ikkb1UO14Zm7A4buAGS1/WmQjxLug++xuSbPBIE6Zvu2PSIufFjRHtloFBpAtBywjZLDyvhqRF4ekg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5647.namprd04.prod.outlook.com (2603:10b6:208:3f::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Thu, 20 Aug
 2020 14:53:18 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a%7]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 14:53:18 +0000
Subject: Re: [PATCH] Cygwin: strace: ignore GCC exceptions
To: cygwin-patches@cygwin.com
References: <20200820135433.19279-1-kbrown@cornell.edu>
 <20200820140639.GS3272@calimero.vinschen.de>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <8efa2cab-ee8e-759b-536d-a56301a9b7bd@cornell.edu>
Date: Thu, 20 Aug 2020 10:52:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200820140639.GS3272@calimero.vinschen.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:610:59::32) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 CH2PR03CA0022.namprd03.prod.outlook.com (2603:10b6:610:59::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25 via Frontend Transport; Thu, 20 Aug 2020 14:53:17 +0000
X-Originating-IP: [68.175.129.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f7aac5d-e240-4145-62ec-08d84518c63d
X-MS-TrafficTypeDiagnostic: MN2PR04MB5647:
X-Microsoft-Antispam-PRVS: <MN2PR04MB5647E0032172E8888054871FD85A0@MN2PR04MB5647.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z6yODW13limdwUkd2uhfJyLVc61uK9WmlkFyap+55D/t71IuBtD7e4GxZ8jb3jZnOX6lDJa5FIq6cmznFUFUrTCM/VQ0kf0nj3yx/L5T9Kz58ezIsnE5BfApmfqMBqv8VGe9fN7SiOz0PXJfUPD+tCHckwsEL5eixtEP0lu+y2NhamxhZMcD1Es9ZdFED5i/PQCUd9myRrG5nruYHviHi0rmwBrEeJw5nNiZASa0abLv0kN6PVeL/zevBYc8LNHB3YPUlXIRBJ0As2HyWVLPwaEo7oVXIlFg3V39vOI4uitTL7y8vxfwNxIjZthoyKiBmk8JN0J+V+9HQSScJ3ITmm+cDS3m0y+ZGidpto+bb9RAQBWZihjWViQc8Gfbl2b3yCU1K9cCo2EbfUbDP9g9QL2MNaoH9hKB1/1YJmYKhfM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(36756003)(5660300002)(6916009)(31696002)(16576012)(786003)(316002)(6486002)(110011004)(66556008)(53546011)(52116002)(478600001)(6666004)(2906002)(75432002)(86362001)(8676002)(26005)(4744005)(66946007)(8936002)(956004)(2616005)(66476007)(31686004)(186003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: /IesF5YfaciWjHCTBTk+oFGRdNJaQMRbQfUrcxdbIsYFmGkqnQ+03x6rZ/lEP9cjRKDL53O/6ofEmeFt+Lmn2NdpN7YIY9RcyVvPJR/HCSPV4YeClZw+wLfrVb9xeuMP3VFXw0IhEJyJ8KoKD3aA1kGaFN1Ehxk4sKi4TsRMyfk7PlFUEZ+Cpk0k/HFx/Vy2PWdrRiPtaA1EH2nptIHXeUxDBewFwz+cC+krWoLZShNMiuYhvjHSpzDAL+EWYo5jqwX/Du50Je/po6iIF93dQFYarnBt13gqqJY+MteCSkgGs7uUbrvOOd7HZK4BPH0O3OCqt6iRE1BCSb2j0DUz2/XafsUd4tZfVT/c6mB866jAGv4q2pS7yt340C/t++cRqxTdDfus3BDontahMoR+pRBroYkuE7NGkEB3eiAa3FVPGRlr/qgvs/NvkuEBilbJwY1yp8CMMCiTgI2ol3qYYMe4G7JOA2tUYS04uFOF8gL2OavqTLttmIVGtP58rvFqQKWldQbUTohfU6dsW+UTfpCXZ7CIT4s10127WQmcx14jaf02yTeiqMI2J0HukyKL9sXySNwAWqu+cfmkmHb/WiDupJ6Tt7oQHZszH4FY9WsgGbLhJNeXHIAXR3XCqncmuPmlqY0ZSymiEngRaWleCA==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f7aac5d-e240-4145-62ec-08d84518c63d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 14:53:18.2077 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gqmLd6GJP/st0k6Y7Hl5WtYUgi3XKsOuuS5dVTfDah84M+K1gx7ELUpWOKni+y7EqOSIjtjwkJrrEk3PkHbg3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5647
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, JMQ_SPF_NEUTRAL,
 MSGID_FROM_MTA_HEADER, NICE_REPLY_A, RCVD_ILLEGAL_IP, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
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
X-List-Received-Date: Thu, 20 Aug 2020 14:53:22 -0000

On 8/20/2020 10:06 AM, Corinna Vinschen wrote:
> Wouldn't it make sense to create a header defining the GCC status values
> as in libgcc/unwind-seh.c and share this between exceptions.cc and
> strace.cc?

Yes, thanks for the suggestion.  New patch(es) on the way.  I called the header 
"gcc_seh.h".  Feel free to suggest a better name.

Ken
