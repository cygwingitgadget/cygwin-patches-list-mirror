Return-Path: <kbrown@cornell.edu>
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2125.outbound.protection.outlook.com [40.107.243.125])
 by sourceware.org (Postfix) with ESMTPS id 8DD31385480F
 for <cygwin-patches@cygwin.com>; Wed, 20 Jan 2021 15:40:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 8DD31385480F
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBd7bCjmsw6fn/txwvbBIKCvtifyFoUS1GotMayhC6Hott3vfN4vrDeMT5eaGl8ssSQRqfSwboQBMLQW1tLxTomUfeoWjikYjPXO+tMr6sj4U0hSv2dDNkjC+1Va5QtmVmpijb/Ze2rdNeX/i4MWJwpn9ys+qo8Njp/EHMTX3XfYy7aih/LmqYp1Z4y7OIFZoPPnGtYuUPuLBRMY7MgAZjWft1ZR890fL3X1pE/PDTYsTym6xEoZN4NNDly5hiZ80I8zuKwima7ccUyy5gC26Tm4cFITRPcDFcZ0OroZ45vJ7a5Rjyr7S5oGEylK+J1w2aWZU1jd5iGCMooKwlLbvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFgUVpezIKNG3ljnt7yzBRGbGXgE5b3lHSKX+gowDOc=;
 b=P/yLqnHHIlbXgAzAqMXGm0QC6ybP9z3NpLjPV8PGnywYbANROLQwKCtGpPL5Bg4FKVdU2zJ18Ogl/RIM9oT2pRLuO7hq9qf17pMryNORees8YNV4dViWrOYnv/nOxmx2NgGfD9MVj8dpreX5lxdAW9enKpsN4TOAZb1qRtS9+A1rJIxNt36Qo8cFRCJDRyRQSXmI1HNyjbSqMBvGoiJKpirNATUJHZWvT/FRY79DdnUON7u7VI6oWKpKFuL0hV+AdGT3IIhFaWOJ2alVD5USmyQh1i+mfFGc9TW0QDIsyvUaGEdMHOk2r0QrL4h3ULXeYWlTuae2TJOi+FcHb3WQKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from SN6PR04MB4399.namprd04.prod.outlook.com (2603:10b6:805:30::12)
 by SN6PR04MB3965.namprd04.prod.outlook.com (2603:10b6:805:44::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Wed, 20 Jan
 2021 15:40:28 +0000
Received: from SN6PR04MB4399.namprd04.prod.outlook.com
 ([fe80::e577:7b94:3b0:4b38]) by SN6PR04MB4399.namprd04.prod.outlook.com
 ([fe80::e577:7b94:3b0:4b38%6]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 15:40:28 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: normalize_posix_path: fix error handling when .. is
 encountered
Date: Wed, 20 Jan 2021 10:40:06 -0500
Message-Id: <20210120154006.53040-1-kbrown@cornell.edu>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [65.112.130.200]
X-ClientProxiedBy: BN6PR22CA0066.namprd22.prod.outlook.com
 (2603:10b6:404:ca::28) To SN6PR04MB4399.namprd04.prod.outlook.com
 (2603:10b6:805:30::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (65.112.130.200) by
 BN6PR22CA0066.namprd22.prod.outlook.com (2603:10b6:404:ca::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9 via Frontend Transport; Wed, 20 Jan 2021 15:40:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 033ac559-3c8c-4658-d7a4-08d8bd59b628
X-MS-TrafficTypeDiagnostic: SN6PR04MB3965:
X-Microsoft-Antispam-PRVS: <SN6PR04MB39650703D584C60B4FD115E3D8A29@SN6PR04MB3965.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eKf5NHqOWJJMZQKHb+iXbewjrVRAiH3ksOTZZvrXAKm2kElkmSjjKj/u9uqThr1IxmXoQCNLNcXZyvKX03Wu3LusUxR/9N0VW/woeJ9PsYsO3zM7DYbuw3SNvv0i/mxkzlx0LHBJmEY1zVa4lAfVmBbZENAcSqjQAohVmB22/+fKCtt9tacQXbycl2QJ4VULTvtvjMPHHEU+3Azv6vuuPP1k+j01qMMIOMdCMviJbZ/shysXoi349rrITCCeYYeLlO+s8APIgH2HUgQdcIImt0+hcQ3RryvCurhvBpWCUvtM2QI85UlMQw0oixn8rw0973WaglXi/1YLX6JUArRpOoM6UZ/CylaTMVRJYlCb0q45+l1cLUn14w40KHR4o6dab2Mz7aWnqn4/9kzyc5XDaNisTSlrmPZKLmiRVIGm8fSRiww10l6G3ej1WTTJiyjw4d+jkULItgwacrnBhAJJ73IQlFxz8HEutENyBuE1TUFlfZEGROPSQYDI1zwh6ZaQThFsLp8lZ9HxvnuB8XOB+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR04MB4399.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(8676002)(966005)(6486002)(8936002)(1076003)(6506007)(52116002)(66476007)(86362001)(478600001)(66946007)(6666004)(2906002)(6916009)(66556008)(16526019)(316002)(36756003)(6512007)(26005)(69590400011)(186003)(2616005)(956004)(83380400001)(75432002)(5660300002)(786003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7gg8XTzsogobAgJxm4kMvpqx5QSRN9aYxrlv4v9+FLM0PV/VtfwwpC0owG/O?=
 =?us-ascii?Q?dUgawpEGdNztEsMmuSH1m21A8e42DztjvIDMgyphRCw2jl8x38HwL+VmFnTB?=
 =?us-ascii?Q?tvrtmc8tr7MwYLU9QVv0UF1b5SMLqKxIvTF1UDMQvTfZN4FuodJxw8K7nHKl?=
 =?us-ascii?Q?QZT7hRjUSanowVEzF4RvRUI6CkWsDATUW/JfmvEhlonrk/0A/AYhdSeCrsme?=
 =?us-ascii?Q?7Dle8nmCn8yN3ZLHGzIAP7C4wuRUZbCcRgRg/CUIW5cSRdOjjI9b+7ITkmz5?=
 =?us-ascii?Q?u3Lsw0vVMJzPbMw2Fv3VhR8bi2S6uT2Ce6Bc0UKRDfajNArUPrxsNhv2OlAR?=
 =?us-ascii?Q?LLP9aBHEMmADh1XOlA/3RtBOutAH48pk5Z+7xUGwLR75jBArPm8tPekJsbii?=
 =?us-ascii?Q?elPW5mj9pOMOssuUVitijxJc/Hs/+jE7gMO3bMzGbhNi4So5vW8tNyntQZCS?=
 =?us-ascii?Q?DbWAR9gX/K3axNaaX9LxF1Ce7m7E3PEgp0A/+MXMi6ZujZXgRY2VK5z8EUKF?=
 =?us-ascii?Q?/fsbSnCZSliBcvWMmrPQEEVLLIXKCI3V+XKYBR/wEv7gw5W7cGPR/zhwPopK?=
 =?us-ascii?Q?gocH3rp6iLpbTgb2NehTvaM1+tf94uXHsflDez4T8ElDEaTzA0ahI2f4WrR3?=
 =?us-ascii?Q?tOzgwQUJAYdU9SIb/Y0sJg9I1pHxeh/9C2pVuV5CXmF5oH3Epbz4LXIJX9Hf?=
 =?us-ascii?Q?CMYkOg+NB6mCMlMoQHypL1qWN7y7AWTlEUHCdIeNvE7wOI+gzp45D2xpTW52?=
 =?us-ascii?Q?xXeM7r657Kis47q9n9EPWlgMGD9O/pKmgFiYFNO7Rk9SQnFRSWbWQIz0aVdS?=
 =?us-ascii?Q?CE+SOFyWa6zuByQa8MbI/4DgNh2lP8D0aWdgnXDOT8yG11bwlwgU6p3DE1yq?=
 =?us-ascii?Q?oP/Zlk6vw50/aTDQIGLf8YKgF0Hl6Zg1dMb6/k7sEez6xpIQBPJ/dFAwaqcU?=
 =?us-ascii?Q?6lx/E6AGPX24caXJDyTt7jNcR6y/znTUVaectQxshxNcO8JqTYYmciUy9IrG?=
 =?us-ascii?Q?P3ip?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 033ac559-3c8c-4658-d7a4-08d8bd59b628
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4399.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2021 15:40:28.1422 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWGPY4VIBe0FpiEwdLRcrrGoFrlQgB5QrHaYrmJs6o1luzgAP8pYNtoA6jrnn4pp3G8dDkFVjhWt/fn3byELPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3965
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Wed, 20 Jan 2021 15:40:33 -0000

When .. is in the source path and the path prefix exists but is not a
directory, return ENOTDIR instead of ENOENT.  This fixes a failing
gnulib test of realpath(3).

Addresses: https://lists.gnu.org/archive/html/bug-gnulib/2021-01/msg00214.html
---
 winsup/cygwin/path.cc       | 4 +++-
 winsup/cygwin/release/3.2.0 | 4 ++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index abd3687df..6dc162806 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -323,8 +323,10 @@ normalize_posix_path (const char *src, char *dst, char *&tail)
 			  if (!tp.check_usage (4, 3))
 			    return ELOOP;
 			  path_conv head (dst, PC_SYM_FOLLOW | PC_POSIX);
-			  if (!head.isdir())
+			  if (!head.exists ())
 			    return ENOENT;
+			  if (!head.isdir ())
+			    return ENOTDIR;
 			  /* At this point, dst is a normalized path.  If the
 			     normalized path created by path_conv does not
 			     match the normalized path we're just testing, then
diff --git a/winsup/cygwin/release/3.2.0 b/winsup/cygwin/release/3.2.0
index c18a848de..43725cec2 100644
--- a/winsup/cygwin/release/3.2.0
+++ b/winsup/cygwin/release/3.2.0
@@ -48,3 +48,7 @@ Bug Fixes
 
 - Fix a bug in fstatat(2) on 32 bit that could cause it to return garbage.
   Addresses: https://cygwin.com/pipermail/cygwin/2021-January/247399.html
+
+- Fix the errno when a path contains .. and the prefix exists but is
+  not a directory.
+  Addresses: https://lists.gnu.org/archive/html/bug-gnulib/2021-01/msg00214.html
-- 
2.30.0

