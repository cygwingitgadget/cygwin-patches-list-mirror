Return-Path: <kbrown@cornell.edu>
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2119.outbound.protection.outlook.com [40.107.223.119])
 by sourceware.org (Postfix) with ESMTPS id BF9473834421
 for <cygwin-patches@cygwin.com>; Fri, 29 Jan 2021 19:24:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org BF9473834421
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GE0iA0AEtYLsNeJbx5XaFh2CRcMDFTwFUOe5C2zWVwsvUu0xsoSBqVH9TCBLFb3lLtyfU8wDbN8CL8wVYcf4azV1y7LrvAS5p0ZOv0n4/gVxXfRUCVExY4vEUu+l6xgl1HpkJbpzbRJ9uuBUeGbv+0Uo+RLPfaxF1AH0Iiy/7r+G0bmAzmmgJss+SOxJn7bmx4G8dOImchS9EZyLjmhb/3E8rONeBSyF43Ca4sEZzJ6hL8e6ZJf6M9YW2RT9msItOldpDrA2983DKqEyn2wdh8euItKlKjKZpgG4zbmqeu/dwk7oeuJVe3V+2TNF/PNT/g+XbAzYAMkNmAZhPpqSJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KpMJd7fV+Xoy/TtMjqv4pl+wxDWSeTtHl3eYboAodE=;
 b=JQGscef4iAWt7vyLoHJ/632nAPbuaYEBHuKbhOI91/BvR5iUoOgfICavh8+CWp0vaQaDIwyEy0nmJ+ucrGSGVBh8wn9c0CxtzHij8rxcMSA44YqwCBatsTymu7qy0a3EuXBLEE+MfwU0AinHA6U3g1zMMAY9x2y8G7Xn6Ad1DvsyywrC/r89dSYZWmO6fNJAOU+/tSLFfz9ZBuHVHcJRXx6WZk+IuLYNLl9wHmIZhUwgj5H7P1Acb82O6MdhdtDck+3IL/7Nhn4ZsWV+VXYwwJvl2vAAQDlQvWlUJj7cu8xlzZBWNvDh9rdkIp/n2Kk27hyiHI4MB8QPki0sZFYqoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN8PR04MB5715.namprd04.prod.outlook.com (2603:10b6:408:74::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Fri, 29 Jan
 2021 19:24:48 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%6]) with mapi id 15.20.3784.017; Fri, 29 Jan 2021
 19:24:48 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/4] Cygwin: sysconf, getrlimit: don't call getdtablesize
Date: Fri, 29 Jan 2021 14:24:19 -0500
Message-Id: <20210129192421.1651-3-kbrown@cornell.edu>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210129192421.1651-1-kbrown@cornell.edu>
References: <20210129192421.1651-1-kbrown@cornell.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [65.112.130.200]
X-ClientProxiedBy: BN8PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:408:70::21) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (65.112.130.200) by
 BN8PR04CA0008.namprd04.prod.outlook.com (2603:10b6:408:70::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.16 via Frontend Transport; Fri, 29 Jan 2021 19:24:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64388b93-9289-48a0-1935-08d8c48b8a9f
X-MS-TrafficTypeDiagnostic: BN8PR04MB5715:
X-Microsoft-Antispam-PRVS: <BN8PR04MB57155913296094061B8B04F9D8B99@BN8PR04MB5715.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wOoePi94AVNx9Na0O+LALceZ9rooF1BZPZGeRz9s/OKQ61liB7iQFo9d7stV1jWiacxhHgOlifvIc4lDPoIxnP6xxoXBwb0l7q+THx8yrVcjHQVEiR1LmJZ1SpS3yBy65atGG+ztA7xBSbs63FWd6P1d6xlZ1DxeypTPqvWdi6OjJ6aAnMIDj+BT5sE/UKNo64QF80AWU+avASnzl0/sY51td+7V56tONIx4e91bmeQ7+aQWSlzUqKLlWtxMUt75iJVlgnVjyo71rOSN884TCao9H1THwpBl1k9HvJL6F1NfWYI1c+OKG4/zCe8YGnV+vO6zUcT+NM9Xk/uSUDG+8fVyQuHNV5ebCkiDqQukUQeqqqdJWDX8zdVGiR9hWD2tipZu0ZxISPZ0TLDRUDZB5f5ch0cNAd6uLtIBL2zDP+JSNp07SgGV93z3GcQco9t/vt001H0KayRzryKHOZ02eHYbCKeoZTc5wy9RyWo2pr18cbo6/tL0+TIZr8ikfveILrFbg0XQqHMaVZZ2z9acb4KglGGzX5BuRpl2kS7/5m+Vg19LPyQZ9PVwYWuU84+XIZyinDx3njRikBj/OhCR8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(6512007)(6916009)(16526019)(186003)(36756003)(1076003)(6666004)(8936002)(66946007)(26005)(6486002)(2616005)(956004)(66476007)(52116002)(83380400001)(8676002)(786003)(316002)(2906002)(75432002)(5660300002)(478600001)(69590400011)(86362001)(6506007)(66556008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?geM7b7PXj4w0LiEAkD+YwYXsluTjFIAgP5zYoRLKoFFEvTBY080RGOPUiHud?=
 =?us-ascii?Q?R/aAtboLTgmfTyNVGTxgtCljtKjdh+kR2dSxk4OVNa9xr3xOEzCJ+YtfquvD?=
 =?us-ascii?Q?xFYkeUpaSSelDuWD157ecnc2uQwfNxupW2v36M2Hfp1DLNRh15x+3R57eDF6?=
 =?us-ascii?Q?FvCu6e+6OSXtyKh2RZsRNxY1nbQ+xrRJRorqVmcLI32A9x1yuyCHEYMjThWw?=
 =?us-ascii?Q?OZdBt4r8PPZxddWqL02nfghzse6wLqcDKhirK11k9K75m5/F7ZbPiznb4gSX?=
 =?us-ascii?Q?v1izc3uPkPB7MDAL7QUv/Hk9shwvunijbU2d2MSFHst8Vsc+zHXDW9bRE/t1?=
 =?us-ascii?Q?JJX0GCWz9MdPRWCvIDS3G1qio5BhxAMz4LIFasKMrOCUYG7UeEPpvH00br+s?=
 =?us-ascii?Q?pwcsuWObQrafD8o26W1hHm6/9Mg7aFturbsOS5rqppr0+cev29aFXPG/T+sq?=
 =?us-ascii?Q?b80hr0x7zv5rw+LEVLOrz2RbLYT8+FhmJb+ysUdJRL+Ea6a/WIDctNCWUcv4?=
 =?us-ascii?Q?s2CM9uMr0FMt04HdbiVITHf8uHnwU7bzI0E0OyRWVk9I1vYMAjBsT/wXYyPW?=
 =?us-ascii?Q?y3ADgAqXpGNHHwiZE4NjyJ/ntIhftelvrXJLcze9JDxFC49NWSJCnmoND8Mw?=
 =?us-ascii?Q?vN2UpH0/edUOcAN/PQHf82w7XwnjQ+iS4E4EOTdateKACkAaY4qldlwHRULP?=
 =?us-ascii?Q?WGaSbeppruv5ucLGNfUxqkxXPpKO5kvChefU1IfeQ+Apl0ILr6of2fhEtzQm?=
 =?us-ascii?Q?SaDZck14w6QEW8KWudIypLfPdmuBaYrsTC92vlc8iaiWv4KDCAmB5xsSeiIJ?=
 =?us-ascii?Q?4lkzwztAHvjcIBqf5y9qTjiclcBDcA5UtQu7vS3RegHzLo+zpMNgdx0yWRHE?=
 =?us-ascii?Q?u3Bj/3sv4qOBf8gHWpMiRDbg2Kbkd2icwaqZp+LtPqmtmOj0vs4rLNPHAw4L?=
 =?us-ascii?Q?g0ixykoulPVNwNFTmuSPHjKKtt9A48+jYMVaImrAy/hJia38ytxE3llH6XcL?=
 =?us-ascii?Q?XQ2fW7lR/ET5yzpR2SHGzDWAvxVgm0w9mBZ6qs3JV26nEKVRcIt9yp9uTFZR?=
 =?us-ascii?Q?wuo5FWLc?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 64388b93-9289-48a0-1935-08d8c48b8a9f
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 19:24:47.9814 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKX+zgGCjswPSNZePQSN/nTXX5BExoZ0I+vKHKjfVVZBA27azpZDyTNNiZZQRslcGF2Jsgtcy0fd0yEhlit5zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5715
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Fri, 29 Jan 2021 19:24:59 -0000

Now that getdtablesize always returns OPEN_MAX_MAX, we can simplify
sysconf(_SC_OPEN_MAX) and getrlimit(RLIMIT_NOFILE) to just use that
same constant instead of calling getdtablesize.
---
 winsup/cygwin/resource.cc |  5 +----
 winsup/cygwin/sysconf.cc  | 11 +----------
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/winsup/cygwin/resource.cc b/winsup/cygwin/resource.cc
index 9e39d3a04..ac56acf8c 100644
--- a/winsup/cygwin/resource.cc
+++ b/winsup/cygwin/resource.cc
@@ -182,10 +182,7 @@ getrlimit (int resource, struct rlimit *rlp)
 	  __get_rlimit_stack (rlp);
 	  break;
 	case RLIMIT_NOFILE:
-	  rlp->rlim_cur = getdtablesize ();
-	  if (rlp->rlim_cur < OPEN_MAX)
-	    rlp->rlim_cur = OPEN_MAX;
-	  rlp->rlim_max = OPEN_MAX_MAX;
+	  rlp->rlim_cur = rlp->rlim_max = OPEN_MAX_MAX;
 	  break;
 	case RLIMIT_CORE:
 	  rlp->rlim_cur = cygheap->rlim_core;
diff --git a/winsup/cygwin/sysconf.cc b/winsup/cygwin/sysconf.cc
index 001da96ad..d5d82bb4a 100644
--- a/winsup/cygwin/sysconf.cc
+++ b/winsup/cygwin/sysconf.cc
@@ -21,15 +21,6 @@ details. */
 #include "cpuid.h"
 #include "clock.h"
 
-static long
-get_open_max (int in)
-{
-  long max = getdtablesize ();
-  if (max < OPEN_MAX)
-    max = OPEN_MAX;
-  return max;
-}
-
 static long
 get_page_size (int in)
 {
@@ -520,7 +511,7 @@ static struct
   {cons, {c:CHILD_MAX}},		/*   1, _SC_CHILD_MAX */
   {cons, {c:CLOCKS_PER_SEC}},		/*   2, _SC_CLK_TCK */
   {cons, {c:NGROUPS_MAX}},		/*   3, _SC_NGROUPS_MAX */
-  {func, {f:get_open_max}},		/*   4, _SC_OPEN_MAX */
+  {cons, {c:OPEN_MAX_MAX}},		/*   4, _SC_OPEN_MAX */
   {cons, {c:_POSIX_JOB_CONTROL}},	/*   5, _SC_JOB_CONTROL */
   {cons, {c:_POSIX_SAVED_IDS}},		/*   6, _SC_SAVED_IDS */
   {cons, {c:_POSIX_VERSION}},		/*   7, _SC_VERSION */
-- 
2.30.0

