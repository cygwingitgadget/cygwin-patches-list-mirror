Return-Path: <kbrown@cornell.edu>
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2120.outbound.protection.outlook.com [40.107.244.120])
 by sourceware.org (Postfix) with ESMTPS id ABCEB3972004
 for <cygwin-patches@cygwin.com>; Thu, 25 Feb 2021 22:48:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org ABCEB3972004
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXbmPgJ1MEn9KSGyRY+Pp9hz9BrmdWSxMtpHecCxkkcj3RMmRuCe/nl/xSl/+tb3dwNp6ZWeS8i6K/JSL8oGCa7CI6tHk3C6jTYm/rXirLYeK41S2ltMc8BzBdQwNPKomro4cn9HH/S7D4CPyLKusu5sH30ZHPtF0QDeI8xIWbr3F9wCwFA17/Z5qp/G1S84hLpI7dPoxxtNncz5IVljrLcuODcWtlqcAEnHCmp7RyF2Fz/055YEs9Zdpyvr5tsxC1DpUxU0y6DQFY1PyTKEOdh2DDaod9tTn8DAmSsQnwSWykNTjZoipaYn9FfbR8FxMGmQZDJ/cosQFWOrkMviiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfaGa4scx+gni5LLJ++7/YlEdXA0QIrRZfvCUvk1BHM=;
 b=je6X1esl/lbNkbanp5Ym5w/ieHcILNCJWTTJ0vN7q1TgEE0C3VCtGfqnY6/vvMb/P+GEYSAuA69qNIqbp6h2Q4gY5tyVkLFgSMrbNblsV0o/Pl7S3tHEcUzIhDMe4v2j8SE66SlldBAI1zHBRSFu0AwSLNX5vcIoeojo7xeCenH61MUtY4baKKA1gOssMuJLL51/Mkqy4/A7cg8Ep5XFfdWqbpRnJv5AcokjW4+lgoKVGSUaLcyX5CiT1SdrPffQesCssRYBhdoqNbo3axEBwoATi5GGRPWlsxg5iXFLROdfYucivVLuBEPw4Q/08b6Mq1D4BJzbC1e3wWeK2GgR1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN8PR04MB6163.namprd04.prod.outlook.com (2603:10b6:408:5c::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 25 Feb
 2021 22:48:33 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%6]) with mapi id 15.20.3890.019; Thu, 25 Feb 2021
 22:48:33 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/7] Fix some system calls on sockets
Date: Thu, 25 Feb 2021 17:48:05 -0500
Message-Id: <20210225224812.61523-1-kbrown@cornell.edu>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [24.194.34.31]
X-ClientProxiedBy: MN2PR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:208:236::23) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (24.194.34.31) by
 MN2PR05CA0054.namprd05.prod.outlook.com (2603:10b6:208:236::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.9 via Frontend
 Transport; Thu, 25 Feb 2021 22:48:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d40f551-2ecd-4a3a-2658-08d8d9df7ab3
X-MS-TrafficTypeDiagnostic: BN8PR04MB6163:
X-Microsoft-Antispam-PRVS: <BN8PR04MB6163E0BDA2165022A562A8B8D89E9@BN8PR04MB6163.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ieGQavohPGjx+sHVj0ZAuZuoJNy5lYyUR03e/o7OCktxpVpotNhP5il7WwfRGgHgIRh7RbTB186ARgCqNaRPgy5b2VRZBfMesfwvqAoBn2RLbz6F3fVYNG5KRcJ32KAxkDuhzZf3Vvlnqept+vT4nv4hNMx7biNbC+r9LoLr2ObJyJxQERsyql1CWYN2j1YeMo1QPifThzM4S6DdFdRa1A+udo/nI5lfBOU0ojCEPgI1dVbDRu/hR+9SO2hvvTYWNK43y8VGDDbD1XYCsdlbjcWI+N8RnMNZOf8IalC/zMr/+v5b3UIfQUlG+wNByUTHDwUAIXfxl0dUy5WU7oleSGNSgMVx4ghvUTfKt9fTjBjklUr1eomvHtDDWV0taQtBzYqCGXz7mb4402GcZrE80Q0ccCBTYMXoR6kyX62dBJN7GgHg6DMTU8PhcQAHixEd9OPz3SubXEPKdJNI9Q8WsV7i7iDHNqPRewJzucfO4SPi0HlHq6DU7qylmO4A+hH4FIP4mjeFlO/jMk8lWmZvEgqkSOMsHxybUh9o4poP0Xh1cIrVTt7gvco6XOqYQzSg+4S0ZNQNHAxiU+6irEZCgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(1076003)(26005)(8936002)(66476007)(66556008)(86362001)(6916009)(16526019)(186003)(8676002)(66946007)(2616005)(316002)(36756003)(6512007)(956004)(75432002)(52116002)(83380400001)(2906002)(6486002)(69590400012)(478600001)(6506007)(786003)(5660300002)(6666004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?n0E70qTeB/gKamYrLAWuN602r6xAJ5WRg4gCCFDluCEj8Yb2HvvPGa57bdfA?=
 =?us-ascii?Q?mzwYa23o68bFQUuTzKjmAuj6WLqoFbG5MbvWHPWfxk0ki8xMHPVF+60MMrq3?=
 =?us-ascii?Q?EWz2H+dIUQz/0p921JgV3X6P+jixadn7SIS1OcyRJfLtXejGZ1MA/jF7rU3T?=
 =?us-ascii?Q?/1wVRScNbH3MNRICzEUP1bKTdf3NYNlz/MyGDXSTzBhGQDeJPZVwnAGaY/4m?=
 =?us-ascii?Q?Xrw9lNNlTyONBsz+3l7lACDaMW1eAbfo2BDPWmNb045+jWwTUVBesZemtQmZ?=
 =?us-ascii?Q?+EjQWRLX1EyUVlFPox9RLYdHnMc/QoNtNdbrbysS43kzbBVUWhlUsITmz05c?=
 =?us-ascii?Q?vxCn3pL+RdoPiG6XlBRbHagxmJHnks+tGyEfZzZSOtyrJbZiCu/BDZVSWCpL?=
 =?us-ascii?Q?NRvaozv+cyPFe22Tvd9dvWlxJspRnKvXpWszoHYYQ3tCFl8+eJbgIp5y2rQv?=
 =?us-ascii?Q?qTFo/FUMxyGeVXeEyCHJsD7DQjJWHJ3H2PXsgeH8jfqELsx9TCQBmQgxGeuD?=
 =?us-ascii?Q?xGHgVe94XgJWsnmUsyq3q1GVy9liLKxGS99flJgnSisPLH/ztbQxREyFnFEg?=
 =?us-ascii?Q?1UK3QAxEhDccZEAEL5h2KlD4alAkmy1GoUHnyn+jblmEnYKHJjE5x6+rchze?=
 =?us-ascii?Q?iMj1V2IobSS5Xq5RyN+D1KKe+q3bOCZFlaBbmr8e2TeZHQI/piuUcVIrcIiH?=
 =?us-ascii?Q?f3Bnmog9nSsGe1DrHDuFVy2jpC0aJa3zbV0mi8w/PxPGa8QdZuSTFkgnIT1n?=
 =?us-ascii?Q?oTGu3i9U+edxAuwrdfMhVYoayEuwXC8ChW0OZEjVZ3eB7Koxvzs7xHICJEd0?=
 =?us-ascii?Q?S32XCQzhDND1PnlIQrDWGbuXpRnwYJgpyj6Zhaq1+sOzOeIfDimFxvxTD+KU?=
 =?us-ascii?Q?+jY0FqxOhA4OtNb3SSs3NISU3wbWIezXCsy55OqaJT6h7oz0oVG9lrFjHaNj?=
 =?us-ascii?Q?kvcKoqmHvdDJx/gF5ZqPnpcL0vep80JPYVE+tVnFy1Y9z1HYUG6rWKGoujeJ?=
 =?us-ascii?Q?0AlYhROdCA6Bu72OclYlxSB+znKnoHOaJZdJ/lANvR6XyT+kctTkfEJqQ/u6?=
 =?us-ascii?Q?4lz0QudsLLNIEt5bxTgAQJFSgVRSR7YyXipNziDU38TJW44zr1qdrvS9JmDb?=
 =?us-ascii?Q?mZtywgYOmgPaEynISHg/fciP442tqdwwZT2LzqkefNaDegah/4lc0lL/jWVe?=
 =?us-ascii?Q?CLft0xeauzH5tK1GRTL4+ZIVlCuo2gf1dZR5nv9T7dJrmy9E097ae4Q08THt?=
 =?us-ascii?Q?c85ExUZbsJ+JGhwHhnE0uK29BKmEb292AwoiuAIJinGKmYsPeWm0M6kzV8vK?=
 =?us-ascii?Q?n1VvSf80Aj7a73X6StVeKCoi?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d40f551-2ecd-4a3a-2658-08d8d9df7ab3
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 22:48:33.4299 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pixfJ3cVNyEC7q/UvoFuUvYPXZHSTlFzOBSVIb+tzLUjfe8cW9hL4d78gNo3Z3TX5vDz7nc0gbAraEuyEgkqdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6163
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 25 Feb 2021 22:48:37 -0000

Several of the fhandler_socket_local and fhandler_socket_unix methods
that support system calls are written as though they are operating on
socket files unless the socket is an abstract socket.  This patchset
(except for the last patch) attempts to fix this by checking whether
the fhandler is associated with a socket file.  If not, we call an
fhandler_socket_wsock or fhandler_socket method instead of an
fhandler_disk_file method.

The last patch is just a code simplification that arose while I was
working on fhandler_socket_local::link.

Ken Brown (7):
  Cygwin: fix fstat on sockets that are not socket files
  Cygwin: fix fstatvfs on sockets that are not socket files
  Cygwin: fix fchmod on sockets that are not socket files
  Cygwin: fix fchown on sockets that are not socket files
  Cygwin: fix facl on sockets that are not socket files
  Cygwin: fix linkat(2) on sockets that are not socket files
  Cygwin: simplify linkat with AT_EMPTY_PATH

 winsup/cygwin/fhandler_socket_local.cc | 39 +++++++++++++-----
 winsup/cygwin/fhandler_socket_unix.cc  | 56 ++++++++++++++++----------
 winsup/cygwin/syscalls.cc              | 24 +++++++----
 3 files changed, 81 insertions(+), 38 deletions(-)

-- 
2.30.0

