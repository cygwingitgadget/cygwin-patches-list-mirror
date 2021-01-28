Return-Path: <kbrown@cornell.edu>
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::71f])
 by sourceware.org (Postfix) with ESMTPS id 2A81A386101C
 for <cygwin-patches@cygwin.com>; Thu, 28 Jan 2021 02:52:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 2A81A386101C
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBeS/pYCvfbiuRtxnMQHCAIet8H6c7IhikRDZrr3Kt81cihP8mehz72sYxC0p1aefKLMPPuThI5maF1WPZbqIoVtgjrMy4z/qxdqNLN+1ErOpVgr09MD8Csx6lqsdCCnKCrNhXthBsyCwi8TFGJZ3jWOD657jjxCfFIfJIytoS/NdJ7ZZEjhYabJuVqyWGPTjmwYYRVIzfujNH6bcsGhhijjJbZcJdix0WUQuvVpvlpLEkVds81/E94g4Xgzq6mBSW6Avim6TilnhDuGdtVg6pqMihBMeYIUcBIV33T/Bja3twIYiY1jkjYbyDN2wZw15STQxQDYbHKBUx+sSKdpbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQr64fcpo5U2Vy2OeToAzgSsn0o0UanMGUJOXyxR95Y=;
 b=Ui9B5w0McwY2jkRoNzbk3udHrZslmPAMzHsajxektSfbTQwKmAAMm2WPNBHhdAxSee7rUKzjy7VlFehK74uTA3YmjBFb4MgGZvUKpGUM3zox6T0FKOyieKt9qzkds8mQbH+q5E6bsptRV2BDAu2ynhxVsvGCB5rQdzetMzM5o50vpO+C9V1cqfDTAGe9vIQ8R9Hmvsz6Ybu4HOrGvUyj4CGMHpXiqC8GHts5Ze5GyTa4K2WhfniT+0/w62MU1gPwAbetjSniH9VFZLUBcuptSSQw9FFTUpIajmwmykvvyEbaiKxZEQQrRzLPOR+REek380OGcgKi5b2m8f5qpz3mTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN8PR04MB6356.namprd04.prod.outlook.com (2603:10b6:408:7e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Thu, 28 Jan
 2021 02:52:13 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%6]) with mapi id 15.20.3784.017; Thu, 28 Jan 2021
 02:52:12 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: getdtablesize: always return OPEN_MAX_MAX
Date: Wed, 27 Jan 2021 21:51:50 -0500
Message-Id: <20210128025150.46708-1-kbrown@cornell.edu>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [65.112.130.200]
X-ClientProxiedBy: BN6PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:404:10a::27) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (65.112.130.200) by
 BN6PR13CA0017.namprd13.prod.outlook.com (2603:10b6:404:10a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.8 via Frontend
 Transport; Thu, 28 Jan 2021 02:52:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7b7289a-d06f-4e81-3d43-08d8c337b68d
X-MS-TrafficTypeDiagnostic: BN8PR04MB6356:
X-Microsoft-Antispam-PRVS: <BN8PR04MB635637987B7620ECD213547AD8BA9@BN8PR04MB6356.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2k/+l8G/biNtBYAVdQ5noJ5QJYrNVI3gWXrtpMr7tG3aBxZl/alOr8O9I6tBwFpXmzo+2UkVjUcoKwCQDUc0iYdraBZ8Yb9uzaXx8qRR5PwKEwg8mQ98hfRBR+1NXzp2hmaDqiGNBjx8ivkusVkvY9ngatnD3mswkGseTKHgDm9TbS39pWNNkYc5mgbgBFwc5UVZHg2eIaAscPuuOZmmui7ekcIazRskUAPKSe+CWEeSBCGP5n3rKmM3p1FZWG12jIB4iTVIUoIYy3dnBfpqBnXxRAUC5zOa++ROME52jLK9fiKYMn2SbJJpVI+5dZmRxMlrVFz38mTUIjujhkdnITI058xMdxg8g2p/nqpdJNCEdL4dfwNhuX3EA5ypcGYfGN7ck8nj3Fq4cGxT1h8DZp82MWEXikBDH0ULRCo1PBJbBCBD6PcTWApn9VC1esBnP+1X8/SWESFuzKAxLMejJrGrM7rlwOeu0tn9V981RcZEIYa1vHJ4H0FFInP0m8oX/CphQqJYMwBcOjOpar7awELuDbnPhFpwx9MVJDb8kWPlPwc2EhxyWVxMPjWsbSVinv1lsSsQOHAKMXUFV4nMJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(26005)(16526019)(36756003)(956004)(69590400011)(75432002)(6512007)(186003)(2616005)(2906002)(83380400001)(6666004)(6486002)(6506007)(86362001)(786003)(5660300002)(52116002)(6916009)(478600001)(66476007)(8676002)(1076003)(8936002)(66946007)(66556008)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0ZCfV9uSVlQ+XQ5rh+l3OPXLgV5DdVkEX/40J826E5MgYk7aI/FLXXicYE2/?=
 =?us-ascii?Q?M4PIVzxR354u10rdPuV2K6U4QaTIYoR4WhSrls9R/fjhpuLTUdCfqzf1iY2/?=
 =?us-ascii?Q?bspZbYv3hgkHKOyXf5OBGqHpKV8hZvhw3VJG0C8ItJenreIC1mW9eZAeBdN7?=
 =?us-ascii?Q?qj1Dkg7BRPJnKEc/v1iyVzATBu4WE8lKQCZ+5XXFjH8mAMv/HLZo+A34/exU?=
 =?us-ascii?Q?/m6noBA0k5CSI3B9+KRskyFlCCvcHPIDJ/zYsgj41X6caAPFpoY8wtXOnZBk?=
 =?us-ascii?Q?FFAPnRfpBP0SiCqv7NjD7o4vbBx+mF01pKCE55aeI3q1+8oFX57uRx0Wdt/V?=
 =?us-ascii?Q?IlyRCEVxAnpL38WAtm/WVX2BGy9TrmzyS8vs7wnGjTbnWpIfnTNHrpZso8JF?=
 =?us-ascii?Q?JG5O7LmNqCzpyHiYYoDAxZC9sPaErp6Ku3Oy5KX648nGhaCm3h9Rxv5csmb/?=
 =?us-ascii?Q?E4EYLPo4e1NeYPLEZN20cgpMFrzRYNPlnPNKf3eR2RcpL2dY2y6d2WZY1vNJ?=
 =?us-ascii?Q?wnrGBSdkuS0R7BYioAiO3HrF3HI63Jj/Qf45QH3Jg+PvkSWUmfM2x9kphX+y?=
 =?us-ascii?Q?xPvT0LwkSXK4VAjSLOBE4QgG8otIkp1OdMtFxw+XupAxbHpqUuY3pMfwv7ab?=
 =?us-ascii?Q?5E7g1cYNkP0c91z5BsxXXiGZPAjLHLs9oVp8VxJvPSgOMVlJ10qonRi+ZV+F?=
 =?us-ascii?Q?6nvZXMTF38aqZWJ7nmoqbX1MYPKeEnCi2ltfAc3EnV0h7f2y41xneWG5Y8My?=
 =?us-ascii?Q?YVm2BLvyTiXT4A1RNZgjodkPzRmMBcW6AJ/zD1g+Xj7rE7gJo2S60IJNevoP?=
 =?us-ascii?Q?2xn/ZCeYS4PPTpdk7+bVJjq5nQa26rZQwnGV1Z21g5vmIZ/Mkt/Q78X1mFsh?=
 =?us-ascii?Q?/IicIW68zQJr55bA8SCWQ7CkYGBLMrpnqDExzaPB5iH9eqQ94pH9etltIZ58?=
 =?us-ascii?Q?vxRT/SZbYsVJG5zO5+l/bEnkZEcMKZUrmICbyoMxqRDPx5UvtwSZLOuB26sL?=
 =?us-ascii?Q?BeuOiDSFQQmwwW0/6kl+C1aVMSvF6EnRD0zwfqFM8OzIwIw6O9gc95XvPGb5?=
 =?us-ascii?Q?D4TzzEFg?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b7289a-d06f-4e81-3d43-08d8c337b68d
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2021 02:52:12.8710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FJ5SueD/4wbmx80aVO3VsacnCzfRu81n5ZLMgfkGNCMfgLj9n7pcq3WaOaJ3EIX7g+mY48kkfTtK435rYCMBig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6356
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, MSGID_FROM_MTA_HEADER,
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
X-List-Received-Date: Thu, 28 Jan 2021 02:52:17 -0000

According to the Linux man page for getdtablesize(3), the latter is
supposed to return "the maximum number of files a process can have
open, one more than the largest possible value for a file descriptor."
The constant OPEN_MAX_MAX is the only limit enforced by Cygwin, so we
now return that.

Previously getdtablesize returned the current size of cygheap->fdtab,
Cygwin's internal file descriptor table.  But this is a dynamically
growing table, and its current size does not reflect an actual limit
on the number of open files.

With this change, gnulib now reports that getdtablesize and
fcntl(F_DUPFD) work on Cygwin.  Packages like GNU tar that use the
corresponding gnulib modules will no longer use gnulib replacements on
Cygwin.
---
 winsup/cygwin/syscalls.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 5da05b18a..1f16d54b9 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -2887,7 +2887,7 @@ setdtablesize (int size)
 extern "C" int
 getdtablesize ()
 {
-  return cygheap->fdtab.size;
+  return OPEN_MAX_MAX;
 }
 
 extern "C" int
-- 
2.30.0

