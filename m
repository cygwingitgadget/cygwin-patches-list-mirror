Return-Path: <kbrown@cornell.edu>
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2096.outbound.protection.outlook.com [40.107.223.96])
 by sourceware.org (Postfix) with ESMTPS id 7B76B385782D
 for <cygwin-patches@cygwin.com>; Wed, 20 Jan 2021 18:00:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 7B76B385782D
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tle41PvT4lidYxHw4f7cid4vp9MIc/Z+r7VzI76TdlZJioXOegN3y5aGkT5fuFkI220ZGssCsoYJ0/bm0XvQfGlWTCqZ/OGn/PFn/MJ6lYE6Y/RHaH8ewrVLy7hSwzddTLFacgvES2A4M8kt7imiBHL1qzUVrPe9CMFUwIVXRChHSOzROQs0uq7X8bNlEdcQRVl0/E70GOTIb1VvD/K2EvvVAndIwEbgJgxV0qxpS2+tnFnn0dLJ5mE04i3wIyWOGrXw4PlCD9McPGRsPuljIdZ5EOPAI9lwbDIG0Q7Xg5XJbfMMhbwd2Xy2/lWpw+fjp8FoHW9JXA+5wby94mVxyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rshcAbq6eWc/QDAHRikTOgVFIHxq7BQJhogJHiQOhpY=;
 b=KL8GVFmPSLYxS5tHfRwZOfHSo7NRX6Vhhery2IRa+BzKNOiMjicHOyae+LFPE8TUmUQHvhwKBo28apv6+slTr+gXgFqFrcK/py1MtF/k+rVz40+ZlzsuU3kNrP5LVhgLrTcK0mvXQwVAXagExlZps3HxtPtz6TcSuUzdxTY1VFJsa6YOo9Fi3ss1rf+t+iB5I2PAd46Ya9s52AXwBeiiFHKXmvPfufLbU2w2cM/Er519V+gfCpeeJ4NABmnLOZdOADcpKNNpJKwiYjzpmV0g+4U1HQTM0sa0GiXE3NRi5WexSaEkaZJm6djOwT56f2QjalqZFtukhhBDE+9NmqSL2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from SN6PR04MB4399.namprd04.prod.outlook.com (2603:10b6:805:30::12)
 by SN2PR04MB2318.namprd04.prod.outlook.com (2603:10b6:804:17::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Wed, 20 Jan
 2021 18:00:26 +0000
Received: from SN6PR04MB4399.namprd04.prod.outlook.com
 ([fe80::e577:7b94:3b0:4b38]) by SN6PR04MB4399.namprd04.prod.outlook.com
 ([fe80::e577:7b94:3b0:4b38%6]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 18:00:26 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: ptsname_r: always return an error number on failure
Date: Wed, 20 Jan 2021 13:00:03 -0500
Message-Id: <20210120180003.1458-1-kbrown@cornell.edu>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [65.112.130.200]
X-ClientProxiedBy: BN0PR04CA0112.namprd04.prod.outlook.com
 (2603:10b6:408:ec::27) To SN6PR04MB4399.namprd04.prod.outlook.com
 (2603:10b6:805:30::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (65.112.130.200) by
 BN0PR04CA0112.namprd04.prod.outlook.com (2603:10b6:408:ec::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Wed, 20 Jan 2021 18:00:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d48b6b9c-aa21-4ddb-f9dd-08d8bd6d4422
X-MS-TrafficTypeDiagnostic: SN2PR04MB2318:
X-Microsoft-Antispam-PRVS: <SN2PR04MB231816B3D37D6D22069DD1F1D8A20@SN2PR04MB2318.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yUoxBiXT+OcMAmwRHVlVgm41J/RS04NP4H4UxytqfhWfecJ+D+j5SMF7kqpDPB8F+JdGrXOYZ1XFjc792bqg08te2hFiTnekPqMGIuibPuoyjbvXAKeLTgytVudYh6N1B2TNo6qz5rh68TwHor7IrJv2p/8YOCtJGGn3UI36p5chLdqbHV/RjSumX/z0Oogi0CexIg12x9P5RyuvdiFNaN2U1fU5+I5UTnHyI6l4HvLYJWmU4Mq6MowKal10GJHIDTssrCYtWd4748+z70lBiczG8xmVGVFR4y6mLpxzM+wCRpgNoVGzVEmhtJDMg2FpmdT8lIyz7dSCnrmIIjOhGRrLKAefty+Wo0H2dgHN1v9MHXAvK9w+a+xNLtM1E35WIGo0tJjjH7xOf9xfzKr20bNBNpvIkQue10XRRUgpZ2fxCfwrkyDYs7usiI3/neAL6WjnzjLIKJ6NxSF/ceTpmIACNHYnwBw6S344LNES8p9zWVs/6ROkOI/3TGv0IE7r7k/0/2Sd2BnPak1bwExGfyx+IVIH8zFxq6o+an4qh/gt1JVTuYLAg3LeixjXJvK2WsiIhQ5uWurTgdjJ5yiMFvwjjS4LVIlyFEk6j1ivDxNTXYllOTEzIUnN9DqWPySdw872HTXpBgxaePCF6ZxV3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR04MB4399.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(2906002)(83380400001)(6666004)(2616005)(6506007)(8936002)(75432002)(5660300002)(6486002)(8676002)(66946007)(66476007)(956004)(69590400011)(6512007)(6916009)(66556008)(16526019)(316002)(26005)(966005)(52116002)(786003)(1076003)(86362001)(478600001)(36756003)(186003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ob4DkprBYnlOog6LGP/ywgScpUaJbH6AlWFrLWz3RrzLJS/UdKhmZ7K2SzZ2?=
 =?us-ascii?Q?2Uk9PUwGwMAoXToS2uFos+dbwk3UW6lUhYojcuWmWsp6S2XCi2B8pd4Qaife?=
 =?us-ascii?Q?VvzMLjuqN+vjCTrCYem8Zoxrd9JduUe1L/VWfsVdyeiFt01xAXa7TeGMLY4i?=
 =?us-ascii?Q?dDK77wxT5wlAcA0PPn7H6zFe3eHj2YlXIeZDAZTRlWni69qjSlQtW5xKXnS4?=
 =?us-ascii?Q?XPI7bKU7kz94XdiKuZHIUgsCJ+QNYPVbsFTQs1WgooQJuD5zS+5iLvbeRkBS?=
 =?us-ascii?Q?1iNfG+GLaq1GUZ+xTlGPfPy2/WlKFtIsXNfZNUODP+SDervghQqez+z5TBt1?=
 =?us-ascii?Q?1p6HuKJmfUWQ4FhSmnbOrcX/gUkFZUNqYLKonxOUfgdertWG0kvxR/8jVJ/X?=
 =?us-ascii?Q?HSOqd4jLnXQDoC1/0LDMy3tFIQaIlUAWeMDlB6UqgZNHxG/TnqIB+1AUArqC?=
 =?us-ascii?Q?xjqKOVIEvAdlxRyzkx1qOFwogSpKQidnO898Uc1md7wvUUhR5R2YYvVOpyzi?=
 =?us-ascii?Q?KdqGc66jNTYZHHTqpF8c+lC022fknlxcrfitVo45cKObbOAUg1+xbGa9eIzc?=
 =?us-ascii?Q?4OWGuuP55k4v+/82J9ZYVBytJdAc0+elac7UgXAnZrAvAsRIkxkWuZu1ys3w?=
 =?us-ascii?Q?KbeuM/WNIYTyEvfmHcyuxFp40TeiYl0M1t1njcnt5i2SxXKgL6dIVj7jj0sg?=
 =?us-ascii?Q?MsIIwIKIAi60tE2dWhEpofbFpTr7UTGgb+HhL+l4M37nIAXglsCXdqxCR+QO?=
 =?us-ascii?Q?GMfKjPCgo6e0cx+Ie0QqZDwAxEbVzlFZNgeH7d89tfVY0JAwg/DHYM2Gtc70?=
 =?us-ascii?Q?vOwsvUIEY5ODkZpRbK9xpNfu4kWHAhjjQGJ4PCGYX5BE5vukZobC3MzDznzb?=
 =?us-ascii?Q?56oS6/s5HTwBb4x13ZRbDvxqtDYtfPCxMTTmMjVjKtYlgkIwxpt4f/15V+w0?=
 =?us-ascii?Q?YbWyaJQYP9tQ9J8r7GkpjaMtw5U9ItHn77hNETaR2aDRbe1vIxMc+BR9zD8m?=
 =?us-ascii?Q?0au9?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: d48b6b9c-aa21-4ddb-f9dd-08d8bd6d4422
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4399.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2021 18:00:26.7671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YaRCilcfkkRoLLc2aRnDUaM0wTwmofIyFsn4cUisnZtieyx4cxoi7+LbiC4CZ83Y8C+Qp+PKG0s3EBlqhEbbgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2318
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, JMQ_SPF_NEUTRAL,
 KAM_SHORT, MSGID_FROM_MTA_HEADER, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2,
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
X-List-Received-Date: Wed, 20 Jan 2021 18:00:30 -0000

Following Linux, return ENOTTY on a bad file descriptor and also set
errno to ENOTTY.

Previously 0 was returned and errno was set to EBADF.  Returning 0
violates the requirement in
https://man7.org/linux/man-pages/man3/ptsname_r.3.html that an error
number should be returned on failure.  (That man page doesn't specify
setting errno.)

Addresses: https://lists.gnu.org/archive/html/bug-gnulib/2021-01/msg00245.html
---
 winsup/cygwin/release/3.2.0 | 3 +++
 winsup/cygwin/syscalls.cc   | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/release/3.2.0 b/winsup/cygwin/release/3.2.0
index 43725cec2..f748a9bc8 100644
--- a/winsup/cygwin/release/3.2.0
+++ b/winsup/cygwin/release/3.2.0
@@ -52,3 +52,6 @@ Bug Fixes
 - Fix the errno when a path contains .. and the prefix exists but is
   not a directory.
   Addresses: https://lists.gnu.org/archive/html/bug-gnulib/2021-01/msg00214.html
+
+- Fix the return value when ptsname_r(3) is called with a bad file descriptor
+  Addresses: https://lists.gnu.org/archive/html/bug-gnulib/2021-01/msg00245.html
diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 4742c6653..18d9e3f88 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -3364,7 +3364,10 @@ ptsname_r (int fd, char *buf, size_t buflen)
 
   cygheap_fdget cfd (fd);
   if (cfd < 0)
-    return 0;
+    {
+      set_errno (ENOTTY);
+      return ENOTTY;
+    }
   return cfd->ptsname_r (buf, buflen);
 }
 
-- 
2.30.0

