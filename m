Return-Path: <kbrown@cornell.edu>
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2104.outbound.protection.outlook.com [40.107.237.104])
 by sourceware.org (Postfix) with ESMTPS id ABAF53890425
 for <cygwin-patches@cygwin.com>; Tue, 23 Feb 2021 22:50:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org ABAF53890425
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3zs8q51SHMbLUoQvF6oX7a+ZAD7quBijGMHX6hjvfYSykE45P2YcxElfHZa8zJj3thPMCQcW/75rnB7FDJxT2rRMBBwNNnzuJ4k9xFkGIqSPWBrGXTP+nVWcuY2bH37L++ul19nvmLshNlIorqeggNdLQP67XU56yGnzDDGAi6sNWXI6TbppJFu1kKAJk56XhU+G9Bw1lHuTymnvlIRKzwgsKY6xSoPhINwhYQeddDDGMFnSyPhHvNlK6WaUeBMR7JEg9N3OshhaaD7HveaRu7B8pwCN2ykFGnhh4vOjeWyxRFD9kY+DRbUg5eF7tFWfPek4J6+6t22j0cws997AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOSvNeVjTSBebeLP5GXuIg0HyGLREu0Tw0usUX+FzE0=;
 b=brZB/MpspAnAs14Zex4vFzqog7xVTw3RmPbnVaHZ/2fmbaqnIhJDoRd34xFmR88kr3f3Eman1Yj37IBKJsqfXgXcH2UXwHPewiXpaNgfhJkGXPl9gTcCmO7ejc6ahiAU/PzpPe3yZmzwKuRU5+uhmWe4xRpz1wVdGz18Jzre09GpNOLIOYKHTVPW3E9OV4Zs/LsBtDbXmG7bBW8mushme7BeEwM6D2vBE18FiBYsOfRX0+Ixk0fuWZXqFUfUPuGrdxnweUSeFhd9v2uNw151Wl5Cq9RUXqmgoZZHrGeRK6Al34t7C4p7VMETRx5ZgkHaRVpkanen3YLpTe6cZ9AriA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN6PR04MB0866.namprd04.prod.outlook.com (2603:10b6:405:44::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Tue, 23 Feb
 2021 22:50:10 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%6]) with mapi id 15.20.3868.032; Tue, 23 Feb 2021
 22:50:10 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/1] Cygwin: facl: fail with EBADF on files opened with O_PATH
Date: Tue, 23 Feb 2021 17:49:50 -0500
Message-Id: <20210223224950.40895-2-kbrown@cornell.edu>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210223224950.40895-1-kbrown@cornell.edu>
References: <20210223224950.40895-1-kbrown@cornell.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2603:7081:7e41:6a00:7520:1923:6c05:708b]
X-ClientProxiedBy: BLAPR03CA0111.namprd03.prod.outlook.com
 (2603:10b6:208:32a::26) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2603:7081:7e41:6a00:7520:1923:6c05:708b)
 by BLAPR03CA0111.namprd03.prod.outlook.com (2603:10b6:208:32a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Tue, 23 Feb 2021 22:50:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3086ce51-431a-49ec-046c-08d8d84d5f1d
X-MS-TrafficTypeDiagnostic: BN6PR04MB0866:
X-Microsoft-Antispam-PRVS: <BN6PR04MB0866D898ABE1322391CF8A1FD8809@BN6PR04MB0866.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E9Ry0NYJfzO0ROCshi34e8QQ9zsURGFpxmVA2d4qiPm/Rvr/2w8tzzFmPGMkqjf6A5XqlhAYfrsNFag+1QC6SYI/LfUNsaWnBb0LUuXg7mh/00Gfo9LKFmllpZqVyT/igtp/nh9v3SsN06TzZGMAqEga7ftnYgwQKo7s2/w+YX9ZPZbo9AhsWPV6OhmOILj40SVr4Zwiyiqxoi5SWBhtehiRf+niikO5WtJw4Jjqnhm7wSGWvKTAfAQwV5zCBhBcDozt9Q6f/t9AFDZvdAzUS8TNwHDnAD70T23iregV8jY+yvji2X/xPOMFB9ITwNSFt1LOr94VABlb3lskBEEFq9P7/jK2ppfLBi8lqRXIFZWuy2Ekjg8K2xyHbrIyvo4OoCtFrjmqvwuSvY+j2LhcZzx6JtS4/rAFeattQx2ZbyBQetwILHz6F/UKXO2D19e3LrhlN6V2lYp67A/MQhZXdo823PaFpXOsAB7vtcjvGriCNCNJKZe0x/eGctCUSduD8vH5uDHMUcok+2+SCiFw1bLbf7T/QQ+u/QQm+VY1To1/GUXY0pMWOvWq81coTWkA0S2bCNpimzwI44+pThi+Lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(6512007)(4744005)(8936002)(8676002)(5660300002)(69590400012)(6916009)(2906002)(86362001)(478600001)(6486002)(36756003)(75432002)(66476007)(66556008)(66946007)(6666004)(786003)(52116002)(16526019)(186003)(2616005)(1076003)(6506007)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ZPTpkMjnvt3+qlRuDYmQ5zEuxTDWe8L1ZT5QDNuNtM7mPhudtqAxP3XRsZ06?=
 =?us-ascii?Q?dqDA+owwih4OpQ85lsS6XG5kWrjc9cTt1wREghHrxg7xQGBI1L5245QtL4WT?=
 =?us-ascii?Q?dfPvsEdvqXx6N+sCWU8Mp/kYr65krngyi+gB6J9HmftgV8OXeg3bAkFJthKo?=
 =?us-ascii?Q?HTsDmGVZ//1UAUFWmBmk28WDuENZ6Ym8C1IcYoCfUB01yyAB0ixY0abI3Gdq?=
 =?us-ascii?Q?PmhEAhk8z+tM1NCLtwgCqAVfSFRE1dDgFNjmhVjUe8SfozR9vhFViOMUax+0?=
 =?us-ascii?Q?intlLJ5MV7y03R4KcGqICN0ZhLD3DVqVjbsLqSuahwHMOyjd3LgGjMHJgYCi?=
 =?us-ascii?Q?r/njZ7uXjoGi5sqAUktAmCBh6xXmmW3dvWZw7H/zHQ/JRz8nhwp7QuvEWu7h?=
 =?us-ascii?Q?CzyXTXs2kPHNxPaoGCqs68Kxxpyxh6Lj/pMEK5qesl7ocj1RXSvJN0YnBFIz?=
 =?us-ascii?Q?Re/zOsA24kLeUoUFYRYnsXQQAbHtKjMEidAM5oIAqQfP8McEWIEpqvWST3UM?=
 =?us-ascii?Q?1C3o4gSm1H0iPak3zogljhE5hYksfJ5T1I+JCe+bVTHi4YHO//dStyh8SFgz?=
 =?us-ascii?Q?KxW5Hq+NYiCuew/2ygUtFN3dagCsaQk4sqGhloA60gt2kU/o6SLTswwnFEOl?=
 =?us-ascii?Q?7zWejJ5oCqzG2u1GA6IgpX9B97pshxxglyIQ06WYVA4W8skPp2N0L4CrOBzg?=
 =?us-ascii?Q?CC2K3H/rJM5AMJNHx/UFyhjK7IOrhYSNVe02chRG/KYj4mCS7PlpD9WIoPkf?=
 =?us-ascii?Q?dGEFld/xWyasx45AFSZMV1f6lBnLJeP4KGaEl2RtFbODRhO7f59ps3D9DKFB?=
 =?us-ascii?Q?AtM9nGP7ZijEwb0U0Ee9jQJrpZelWOqo47d4ffxTTmf0K2PWK+DdzoByF90N?=
 =?us-ascii?Q?08cC+fEIE7SbdWk/jM6wrBtSzpXzwALTUsTBlRjFPSP4rJbPtjz9QcIlyhhD?=
 =?us-ascii?Q?lNLjqzTdSbs48YqsAsGhCZ/g5yU5WS0x6tyOI8aQDoMy5/u7ULkGWS7dzrLK?=
 =?us-ascii?Q?d2uKLnL8HZzByK30/a96MMnNaEqqlyNnCu7bkDKIoUoAsHaFTpCsnE8c+SoF?=
 =?us-ascii?Q?XCgGngXfD7OLhh827L+oJKpVx1PBQ1Wbov1Fi+ekaYfp3xbN4NVGgTYOFLPZ?=
 =?us-ascii?Q?H6ARrQwysmzlowKcpH9UIIPISWQ+5LBgXw1Umzzi8TTteGUlqJrL6g4PIH2S?=
 =?us-ascii?Q?MZUFYGfcsGhtmVVhPodIpib2Y0+81UqJfyM8iv7YTMPYRhCBwl5n+cYZ/+xR?=
 =?us-ascii?Q?ZoDeDH5ILlfNDqwzRi7nuzGn6O1tQnMn5dAMS4Xc1jcuRH8owqHECO6trfFz?=
 =?us-ascii?Q?YJ7RCSWEzVKXNBD8lKQXWdta5s3EiF8RtxCq5VfFt5Cz4ovgtiih/eN4yPyo?=
 =?us-ascii?Q?tirHReBdnjFA3v+QufYSgBOcUReq?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3086ce51-431a-49ec-046c-08d8d84d5f1d
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 22:50:09.8610 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /YvjnEGQCCYIMqqnBHisPnze/tYgZiEI4gkXzsCVJyMA/hzrOqoiwU/PmHYYsW0kx0I9Kp1+ChxAhMEr6LwV9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0866
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, MSGID_FROM_MTA_HEADER,
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
X-List-Received-Date: Tue, 23 Feb 2021 22:50:12 -0000

This is in the spirit of the Linux requirement that file operations
like fchmod(2), fchown(2), and fgetxattr(2) fail with EBADF on files
opened with O_PATH.
---
 winsup/cygwin/sec_acl.cc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/winsup/cygwin/sec_acl.cc b/winsup/cygwin/sec_acl.cc
index fe015728d..90969b639 100644
--- a/winsup/cygwin/sec_acl.cc
+++ b/winsup/cygwin/sec_acl.cc
@@ -1246,6 +1246,11 @@ facl32 (int fd, int cmd, int nentries, aclent_t *aclbufp)
       syscall_printf ("-1 = facl (%d)", fd);
       return -1;
     }
+  if (cfd->get_flags () & O_PATH)
+    {
+      set_errno (EBADF);
+      return -1;
+    }
   int res = cfd->facl (cmd, nentries, aclbufp);
   syscall_printf ("%R = facl(%s) )", res, cfd->get_name ());
   return res;
-- 
2.30.0

