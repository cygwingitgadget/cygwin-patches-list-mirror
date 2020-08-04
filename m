Return-Path: <kbrown@cornell.edu>
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2112.outbound.protection.outlook.com [40.107.223.112])
 by sourceware.org (Postfix) with ESMTPS id E9F253857C56
 for <cygwin-patches@cygwin.com>; Tue,  4 Aug 2020 12:55:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E9F253857C56
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Twrc1dRGXdURRswi1RtjtoAfSF3YH0doq9OEGHoJ5Z1m7FhB6VOm+p3No+amTAYoVyMN7Rt6Ek6xA4/Ogcsc0eOmKF9fbdXtX8mTR/TtWFKsATT15VtVP3Jta1etvuOHGwO9Pr29Z3lcDMdfe0GFzMHVa4rsEj60ZjlUt+jT4dSMniaoW2USpNLXu08BxylINaSW34n0ZzlIdmfIAPcnb7SYXjCRYnIAm/ANQrC4eqcJCqhnD+m/h8MwSs0u3xi20M/Y1n9CYWm5GGD7/TepVXH3mMkBL6cgGAD6/BfGAvEErKzLFfnkfUv5ZfRV73y4KM9kADwPacGsatZs9fSZhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmrEHKwEtS9wySE/bjdsU6IuDce4iI8ie3tWhKOzQrU=;
 b=BmhusxpM3zCuDJIAylKR0eVs67IOAv0jpD+R7JuELvoZmecegjG2BiRRak53t3DEyi/SPgaOzYZFO+RYjvrfh4nY8fhSh+s8NEcLxiddgEqicH1dD7u9qgmV7DPjRJDt6iWcnPKmDWkyux3tEYSe6PYI2fJqCdworNy91R9E47xsntp4XvUKDjxEqYHh6Ullb4zowFb07GAeL2amNa+qrUDUHqUu++DgXGh6YGX5v0Oxg9/qUoe/m4AuWWtArECj5ei/1hPU84Fw6E48BKMVC4Jdk17c9JY1fk1AGyeG8qxSEtcXyzJ6v978kKr1Q3Oxw9HlEWi10jq/8nKCJqCuEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5903.namprd04.prod.outlook.com (2603:10b6:208:a4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Tue, 4 Aug
 2020 12:55:23 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a%7]) with mapi id 15.20.3239.021; Tue, 4 Aug 2020
 12:55:23 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/8] FIFO: bug fixes and small improvements
Date: Tue,  4 Aug 2020 08:54:59 -0400
Message-Id: <20200804125507.8842-1-kbrown@cornell.edu>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:208:d4::37) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2604:6000:b407:7f00:8093:2a79:7de:1dbd)
 by MN2PR04CA0024.namprd04.prod.outlook.com (2603:10b6:208:d4::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Tue, 4 Aug 2020 12:55:23 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [2604:6000:b407:7f00:8093:2a79:7de:1dbd]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91b52776-29c6-4aef-4727-08d83875a6c3
X-MS-TrafficTypeDiagnostic: MN2PR04MB5903:
X-Microsoft-Antispam-PRVS: <MN2PR04MB59038C675285ED9710EC7A43D84A0@MN2PR04MB5903.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WyrCHOS/C0UzyUA5UA99UtaPcxnFbrnNl37qJ8yNKYkUzmQ70N5+RQEcWDavhmM3aY1+Nm/xvOrsAe1jUXSX5pDb6YeWuXnHuAIRswJ+PamgRJKORXtjj0etlwACllP/i2frVkuLAWRHGCw+Y7a4/tpQ23PUr88gmyQqLxr+YgXtfn7vo84sqmrRbceojNXv1aiWLXJr8RBOEbTVNUZz4Jg+Sjltcd2n8Ms3hBgDIc2Vryw9Q82Tq0Lowe/T3DgI5zb5MlSorogGeMHVpjmsAr9RmyDzyaxyVn1cjfiytOiOPiIDhIc+YiynXjH7yOyJJYOt9LNpII7+z0wGOiiCibbXIMDSQskKaAShJBsK3rIbWe6LectjVmE6pITkfeZD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(2906002)(5660300002)(786003)(316002)(6666004)(6506007)(66946007)(86362001)(8676002)(6512007)(16526019)(4744005)(186003)(1076003)(75432002)(2616005)(83380400001)(478600001)(66556008)(52116002)(69590400007)(6486002)(6916009)(36756003)(8936002)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: YUiZcWNRGcAAvbwydhroEsAc52FaA/eZkbagcbXcMlJ755JYoMOktt/JzIr4Okgp/xdBkc1DeuthlWcbWNJ8wloJt+jrFFc7iLNYUDl0OH7gE+DT7C81PGRNNtydo+u8q7Gb7u2h2c6YC3KdH4pK5F3kjWMpdzxc854ObmoV3HCak3u1n98mnGaTxUg9cQjri+xEW0Z12rnFI2IW3FPHvdwhFWgZgOiByeSSBHocymUtzAEeAA+mgWCQXhA+PdSofA40NhvnPCvsRpI7RwYsj7kF9Je5/cELzgYOUs/t5h3//DEgc9+kNcGubsxyBNnoJzjY1M6N7Xka7HmZ741MuTHrYPk+QhClRnSODVlo1Y5bWfAhLrTmovjsWNSZPl16ItqGqokqMEoavmYrHcmrH2AuRerjgguNppmHK4fJcM3JOOwmZDRv8lhZgWs0WNeQJPNSZBZfr+YnwhtTfQoUuieiQER+UcrX1I2a7iScjadllufy8fiU2fLb1vUOhno1c47gWZkAW5XSJN3BXyHfZJMc5jGDo1Hhr1xEctJWL84a3uHoEp3M8IflnEJ8TDptUVcG03t1/fDZTRSVjR6toTU25rfRAuOEz4pB6210pGPSZvC6UiTk5DkXp3zqlQH/zhHIDOCWSgmIEPE74uzqgOcgaCoNoaHcH3CM/9iRzhwji04si5nTEJMGXL+im2mVJmO8QnNezsJqlBt6jRHqYA==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b52776-29c6-4aef-4727-08d83875a6c3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2020 12:55:23.5668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t2/FitTbOh7FSp2YoaX4Gy91a6HJ2BPzj5ZsR7HKAeoShEH42ospBwe6YYwxn6ZgqMspT7vQioFCw2nGZCV7yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5903
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 04 Aug 2020 12:55:27 -0000

The second patch in this series fixes a serious bug that has resulted
in observable hangs.  The other patches are minor bug fixes or minor
performance improvements.

Ken Brown (8):
  Cygwin: FIFO: lock fixes
  Cygwin: FIFO: fix timing issue with owner change
  Cygwin: FIFO: add a timeout to take_ownership
  Cygwin: FIFO: reorganize some fifo_client_handler methods
  Cygwin: FIFO: don't read from pipes that are closing
  Cygwin: FIFO: synchronize the fifo_reader and fifosel threads
  Cygwin: FIFO: fix indentation
  Cygwin: FIFO: add a third pass to raw_read

 winsup/cygwin/fhandler.h       |  24 +--
 winsup/cygwin/fhandler_fifo.cc | 358 ++++++++++++++++++++++-----------
 winsup/cygwin/select.cc        |  38 ++--
 3 files changed, 268 insertions(+), 152 deletions(-)

-- 
2.28.0

