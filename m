Return-Path: <kbrown@cornell.edu>
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2090.outbound.protection.outlook.com [40.107.100.90])
 by sourceware.org (Postfix) with ESMTPS id 4FAB33972019
 for <cygwin-patches@cygwin.com>; Thu, 25 Feb 2021 22:48:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 4FAB33972019
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGMTVNEJqJSXk1Dyc8bPt9iXFsx0KUgXN2WO6eEgGz73zKBY9OR4Hhha+B8zF23j4qk3ic/dLI1JUVVqhLsNLvc9OLRvU4ZXqrAc6yorI7jvN/e7wUZs+dCGaoJx+86TuMBY04HGv1i62j8WOVtvlxsJIjcssJ8V7J1pyXl8xUua76zhZmYSkBlfOvIgadzTLvh9Fid/+Ec8WarvS43UigMhvfOE57y+BQZI4hUt+tVNPQSweNgaWWoWLG4UeWdZts3tE48SnXmuTBo48h1Rb5T8NZ4a9B+YYWevqWGAMNJz/1NgvITwU/VS33jQhgVc7H84ErjTWrwCIem7EV9m1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTH1ajyqRPenclfLOjj1L5bE4tKyU6H3J57W35fcu5Y=;
 b=loT44p+QpWxwoH8ZAqaVoGkbS5E4l8zuDpHNvxyfNWoX3qppICVvnSIQsG7Hl7guQDN9pdhAiA2mF5eVWo4iq2eS+Gn2Wsk30+uH7NN272fegqjcp9oX2Dljm4IXRVja0VngpsWVXKOy9RNOOF+zdQeUFj8p7cNYTAohXMO7Au0H7vljZDFA9UgaHsYmZsxRb1E45/FargHWuHtxgvs/sF9g7SOnVck6342l86NksiL5NWMaqeaJpjHbfbGdEmLl9+pF4f4J0nX9wR8bLXFh80Z8Hau1e7kThgO3a9Dcg+fkK3cX+IQoMFa89/72Q97QL3+g3z75p8cTRdhRcf755g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN7PR04MB5172.namprd04.prod.outlook.com (2603:10b6:408:38::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Thu, 25 Feb
 2021 22:48:36 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%6]) with mapi id 15.20.3890.019; Thu, 25 Feb 2021
 22:48:36 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 3/7] Cygwin: fix fchmod on sockets that are not socket files
Date: Thu, 25 Feb 2021 17:48:08 -0500
Message-Id: <20210225224812.61523-4-kbrown@cornell.edu>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210225224812.61523-1-kbrown@cornell.edu>
References: <20210225224812.61523-1-kbrown@cornell.edu>
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
 Transport; Thu, 25 Feb 2021 22:48:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad45a4ed-973c-4d00-8f40-08d8d9df7c15
X-MS-TrafficTypeDiagnostic: BN7PR04MB5172:
X-Microsoft-Antispam-PRVS: <BN7PR04MB5172E171E75FC3B30D96ECB8D89E9@BN7PR04MB5172.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dS3fbtE7PAj2JW98wvAM1E+ZXyiS5TS8bEHziFro30OEhZJl2fQaH8qumvMI9aLtEKlNrJS2SIlAL1NDaE9cwjkckX44WF2cXToQceTQtVopFyMF60OthqcZvqyKyJiZ5fxQ9oHtQdnlzhh5W8GW+sj9gkqII+0vCu8bZOrRewnWGWmyFIu7IlEH4XwZgPJe/V3+aNrEbGK63R/gPNjBhBt2gejRoPHj6ijsGnl+SVbSb3sAKgdANDp5DRD9NCPD4a+/ALOstMS4Kjxip/4M7/EurT/0dW3R3Y/pXpF+4up7AGnzzyV7HUWChgF/3RN1HBf0B0BmBrhzJ6RQeJBSS2pijmQ5FzU/Xglw2kVnuBXtkZBuD3Q6Pd03ci+I3bgVPRYID/4/qxCt6fq7PnUAHWQ7CdHoCqjOQJ6nZoQSYJalWKp1I9cd4+KO74NSyZbmUSgZsT12Qz+RVPAacr6lA6wsXt0w/rbYAcrJRfJ5LxxBsYQY1Mk+lTKPa46PZukOk+an+54MVCwYAN+kGEGhliPN7SSDBjW7lQ99RlLcZ1CzwMKHdI1d4Eu+IQf8hMt3UeRSZ0op2TBJcMlKvKCwCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(83380400001)(52116002)(75432002)(69590400012)(8676002)(8936002)(36756003)(2906002)(786003)(316002)(86362001)(6486002)(2616005)(1076003)(6916009)(478600001)(5660300002)(6506007)(6666004)(6512007)(186003)(16526019)(956004)(66946007)(66556008)(66476007)(26005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hd2432v9CJ66//PIP6LGaGF/lUt9Ju9jP0kpK/GjzRLo9ebr2mAul019QkyP?=
 =?us-ascii?Q?MUi3QVC4I/MloxDSMIgjBWkCUqQfmAyRxh+EknSrshc/24+IRH+Yp7Fu0d4G?=
 =?us-ascii?Q?6u9E5+qxA06GKj61xVynpB08TyF+hDDjq9wPt4dIwBk5NG0LBJVSHPbgW1mw?=
 =?us-ascii?Q?k4Cvt4iIO2wQ/6O+EuGor2EF0J5ZOb8S1FfVXqGMy1v5c7hTq4TgwrzaHaUr?=
 =?us-ascii?Q?1v4nKJkpVR28Dqkgxcz6SIzjZdSfjZWlRodZjeKy7lCDpyVi4CWPtkZltP65?=
 =?us-ascii?Q?m2O/qJzQL3uNeB5A6vN03kywPPywJLa27nW5bm93ZcfbhmvoAF+3YhE/UZsV?=
 =?us-ascii?Q?naM7Q9yBEF8rcmcAz07YSNZemmqxW/dob92BUPpalZe29vl3PVDq10WRjMTn?=
 =?us-ascii?Q?gyQ/XNK6z3Y4kpaL32WAqbPEZWi1kpEYcqhr13DV9OzNSfUWnSMt9p0bXxQg?=
 =?us-ascii?Q?5TUkERCGbeGBy9+qMA9uKP1A5Nn7wEl/Nb4Fqv5Kg23y+yGH4/hwfX/0cX1X?=
 =?us-ascii?Q?3RkWO5ORmKokMvWKLDXB1T3Je0M0GXSZEJu1GC24iBOHVllcfKhA/QEynTz7?=
 =?us-ascii?Q?g2KBRUPrC1wb5MCfPBxv471RE+woQ/omWGJ9DWrcmvTQrP/gtaKIAHDs8Vv7?=
 =?us-ascii?Q?AqJUoG0W0+ONOBvG10vf121okyNCayWtnTCbJDcL52Gb+8zQOJ0lua9Wf1Rr?=
 =?us-ascii?Q?yLZ6VHKV+8633h5fKIAYB0us6wNmSHiy6nLnfapNXN5c2yFzl529GG6APpsc?=
 =?us-ascii?Q?RrtB3X+jOYkBJBP7WqvfRj9+dGtkHDuJ0BZfVGS4rg7FGM0qyYfWH2lYLFP7?=
 =?us-ascii?Q?ywKQ5yaA0GpJ+nAmKX8UhOqhshHyBmSGBpJGPGYtiQGX+36W8L9jIq/qY3My?=
 =?us-ascii?Q?DTFBNYqCuAW20YosZ6X6Zl0sR4Ey83RKXGWVe3tKzIGfzzXo/RDW7J1P8/JZ?=
 =?us-ascii?Q?sRTrIvKU2ACIak8i+RAd5+VE8StPmMSO4SsmUSzT5/EqBqY0jm/95Rjcezyh?=
 =?us-ascii?Q?E/tFvq6DqungzuJYgVQ+CRB2wGVnuheU2SmmtSnh1NjrlftrerGb2Rz6UPhN?=
 =?us-ascii?Q?9ILfG8sqIlVr4X8SGV9t/C4102CLqmKJgq3iAhFYOUipjmDCRWkqvioevw0P?=
 =?us-ascii?Q?g+GEtJkQ8xwvCBgsHNh6eXdTng0P8DUxaHQL02KQhdnMiVTN4XFJ+lZ06mbD?=
 =?us-ascii?Q?XDGOPBNA6L30YElMnyMdqK6C+uedrjOBuvO7r8EnZjEHrxuQrmLKKgGEg/3k?=
 =?us-ascii?Q?LS64O2pkN3N1IgqJsZcmxcGTFlOFHXvkN7NwJyKfcerzYHIVmKBxUZ60ZaOc?=
 =?us-ascii?Q?RWLsNGCraWVYL4kvdG6ZGwNB?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: ad45a4ed-973c-4d00-8f40-08d8d9df7c15
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 22:48:36.4402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MyWoMMLwIsfOSombHmngrCn7nNAOJQoYUJDFVcPmdsu0G/K7OCPVQRF+q+Vh6El/w3t95++lq7DWnyPoUE1o2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB5172
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, MSGID_FROM_MTA_HEADER,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_PASS,
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
X-List-Received-Date: Thu, 25 Feb 2021 22:48:38 -0000

If fchmod(2) is called on an AF_LOCAL or AF_UNIX socket that is not a
socket file, the current code calls fhandler_disk_file::fchmod in most
cases.  The latter expects to be operating on a disk file and uses the
socket's io_handle, which is not a file handle.

Fix this by calling fhandler_disk_file::fchmod only if the
fhandler_socket object is a file (determined by testing dev().isfs()).
---
 winsup/cygwin/fhandler_socket_local.cc | 6 +++++-
 winsup/cygwin/fhandler_socket_unix.cc  | 8 +++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler_socket_local.cc b/winsup/cygwin/fhandler_socket_local.cc
index 5ca6d8550..d1faa079a 100644
--- a/winsup/cygwin/fhandler_socket_local.cc
+++ b/winsup/cygwin/fhandler_socket_local.cc
@@ -710,8 +710,12 @@ fhandler_socket_local::fstatvfs (struct statvfs *sfs)
 int
 fhandler_socket_local::fchmod (mode_t newmode)
 {
-  if (get_sun_path () && get_sun_path ()[0] == '\0')
+  if (!dev ().isfs ())
+    /* fchmod called on a socket. */
     return fhandler_socket_wsock::fchmod (newmode);
+
+  /* chmod on a socket file.  [We won't get here if fchmod is called
+     on a socket opened w/ O_PATH.] */
   fhandler_disk_file fh (pc);
   fh.get_device () = FH_FS;
   return fh.fchmod (S_IFSOCK | adjust_socket_file_mode (newmode));
diff --git a/winsup/cygwin/fhandler_socket_unix.cc b/winsup/cygwin/fhandler_socket_unix.cc
index 06db929ed..e08e9bdd9 100644
--- a/winsup/cygwin/fhandler_socket_unix.cc
+++ b/winsup/cygwin/fhandler_socket_unix.cc
@@ -2374,10 +2374,12 @@ fhandler_socket_unix::fstatvfs (struct statvfs *sfs)
 int
 fhandler_socket_unix::fchmod (mode_t newmode)
 {
-  if (sun_path ()
-      && (sun_path ()->un_len <= (socklen_t) sizeof (sa_family_t)
-	  || sun_path ()->un.sun_path[0] == '\0'))
+  if (!dev ().isfs ())
+    /* fchmod called on a socket. */
     return fhandler_socket::fchmod (newmode);
+
+  /* chmod on a socket file.  [We won't get here if fchmod is called
+     on a socket opened w/ O_PATH.] */
   fhandler_disk_file fh (pc);
   fh.get_device () = FH_FS;
   /* Kludge: Don't allow to remove read bit on socket files for
-- 
2.30.0

