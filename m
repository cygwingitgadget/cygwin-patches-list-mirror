Return-Path: <kbrown@cornell.edu>
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2120.outbound.protection.outlook.com [40.107.244.120])
 by sourceware.org (Postfix) with ESMTPS id 742243972004
 for <cygwin-patches@cygwin.com>; Thu, 25 Feb 2021 22:48:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 742243972004
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNPrr3xl0cbeQmII2jGqEMgCXjRdhRjPv1oqrlXvVCrAN07BbVXhrdSUHLZZTdXv585tn9WPNnZGTuPSBnFx4D8fsmHvlY60zgCUXALx+e7RVUl8SBCmtbXhModnw9HDsndt/Pu3Cz1ccJBke/x4hP9V7YMwShaf/P/cVtWtFfUEoHp41cieIeZDdF/VwfWV4V0CjfyTgHf5fEluU5l0sOAsii2QyGVwOyuJDB3+e5W4E+tf/z2ssX5Q6EwJFBYCutEKX5mMEDRIW7eBYSV0BqThuQX1cSDBOGWA5q4CTpGPi3oBOKMb8Ty239Ds/w5p5+ptDDYTFBGNImrUEQEW4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gm4MWYZWwGgojYUd6KKYmWaxgu895AJlsYYO+Qo35Hg=;
 b=EPP+zzCJ7/SchIFv5+Urm2lRH4HfSctbX9XjSQtnpQLFzvPARdGZNhoj/UP9jGFrXzl7xPxVgwRhFxa5LlDwvCBL22jEs6DQFhNN0uLQi05ndVsJFmkXUthZUAxEMFzI9Yvt1X+ltIlwyHZ43MWrW6CMs5+UdQyVmJ8GATi+MoVCz1JoXp4OoWiI9Q3nLP8NQ7qwXrgzSbhi7b+IddlgiiDCC2c0BkYnxOS4Tq1KhZQAcV9Z3bsGi24Q0h7QztgQzwwM0mg5C8FrL5T8GrQe3GSdTRi8cUnGt8NRaMcK/JR9Fgsciehy9kXpPS4LJGbUA/fzTUn6d2ZZcK+Es3Q1OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN8PR04MB6163.namprd04.prod.outlook.com (2603:10b6:408:5c::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 25 Feb
 2021 22:48:40 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%6]) with mapi id 15.20.3890.019; Thu, 25 Feb 2021
 22:48:39 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 6/7] Cygwin: fix linkat(2) on sockets that are not socket files
Date: Thu, 25 Feb 2021 17:48:11 -0500
Message-Id: <20210225224812.61523-7-kbrown@cornell.edu>
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
 Transport; Thu, 25 Feb 2021 22:48:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 524143fb-a156-4d62-e122-08d8d9df7dc7
X-MS-TrafficTypeDiagnostic: BN8PR04MB6163:
X-Microsoft-Antispam-PRVS: <BN8PR04MB6163BABDDD6AEC253B3131A2D89E9@BN8PR04MB6163.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K11bvvoANHkiNdnf4y2+75pclZ41DJEwZFBZwms6Inabr94rufdTNXSOstYXOY71YM9hYcN2ZoLnmtbrYNtz0U/AvSM44402GmZHBRKWY2m4uBaqgKkwa2kwixIueNTAn1N4+4N9+hry2c0Bw7wauX9HbkGm3d5yD/8RD8CF6ILVxtJz4Hs/2zEmbAc5vnu5tXDkjKn2SqeGPM4dL52VR6+emZu4CQyiZMI/La9jY9EvNF1KgY+AoH/ji4dluNrs48BIfY75xnzC4nf38bQmZgjZz/aCtetBqZiZgz0kOB2EAJMny99USJpiK2fAG2uhk/IeDdCswiTc5leMhABfV4jkjg9ZPnsLMgcy9j788DZzmmRUTHlE/9sOpmpj5YYlCukvYndIuoD00iNVk191dJ9zJG3UiaBXDYoEkxRyxXYtnRqAhaywuUTNL/bagHakDrSpSGTWHjvITJpq4Z80OB8XfInH9ix0zG6Vs2svGKJ0RPNwX1MpC5AxNwrVnbumE5pkowOd92x7EdRKNLi2E7K5pUV+kIeYrxvZ/6ruOF0sBBFuYzwkLIuXu8TESylHqcYL92gzKKdzsvrlyk6aww==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(1076003)(26005)(8936002)(66476007)(66556008)(86362001)(6916009)(16526019)(186003)(8676002)(66946007)(2616005)(316002)(36756003)(6512007)(956004)(75432002)(52116002)(83380400001)(2906002)(6486002)(69590400012)(478600001)(6506007)(786003)(5660300002)(6666004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?U5XvI87GHvCpZss5BcQutBYhP+4hPU4Y91E6mJiQyggLqEiVloPo0CiMM+hF?=
 =?us-ascii?Q?Fz0imhxAmV5N4ZRm9aUuNwJqtdXbAyLbyACo05Ywys5eTQk/keCMUvegROhf?=
 =?us-ascii?Q?UAUaM2ShxE7vXVFhfnyg0IA73g0V1qIyrGF6dB58gy02U4IxrLr9PL6aPtD5?=
 =?us-ascii?Q?bD1P2Y/+PyFqKCy0PlI8Iz/fmplGa6lQSucj0Ixb6d/sJxchELE/lVSMUAbe?=
 =?us-ascii?Q?XaA09xxYD1olVhgZkdSs4NWFChZpGbgGNeIs/zTKYxViXgtkvF/OHDqOs1ay?=
 =?us-ascii?Q?D6PwaFRZ1P0vvqGZTFu65wbFEkqXfuYG7EvwJ0JZsTZ4pURl2OXB6tuHuviB?=
 =?us-ascii?Q?aq6uw5YekdY9RAinxdLqomYTEflaDOAtSHxWXfumMcliSfFZVLsEVT3E/peH?=
 =?us-ascii?Q?hZeRER7G/d40ZBQwQIMMNQQau8bfHX25VXxMJybe+YlaZzTLBQrS2dvU4+1x?=
 =?us-ascii?Q?0ZLG7wOAym5k4kAbgjt19KgqFgpadXNn8WkeWFnBiuuFuRvk9oG17HDmKZMd?=
 =?us-ascii?Q?QpSixjBn4GyYPHbmT9f1BSy4e3gdQU2izkLJBSHHc33PHwnqfNuvxQrwBCPt?=
 =?us-ascii?Q?hNmaWnZ/S3aoTG3hISIa3egmMIqjIyUyce701eA0fiO/60lH84r9jvEb7bpL?=
 =?us-ascii?Q?bcJwXXxsfBApI6RUsFK/Bmi0XyLgw6pybNFpUCif6WqWdEUv4oIr0KwbDZt6?=
 =?us-ascii?Q?CIpRrKH8bvTGAgK1SVu1HB8eULHbAaDuRlkuDvPW1C7OhwguigA/Tq8pPEUo?=
 =?us-ascii?Q?UeEMMA6t7w9ghNe9hxhv6ZOYpurvAvRO1mcIi4cDQ9tnC8jnkVKEI/lBWVKe?=
 =?us-ascii?Q?ZwUghcNO/1jza0yDr1RpbyPnt2H01zVCZOoTEPqsR1DpYPsNY7ZKXSzyvpvC?=
 =?us-ascii?Q?oivOpEBiqoXMZBa7TMcFyvAqdvtWetYF17NUtWY8Sz94ZZmyZZjt4CmRRfec?=
 =?us-ascii?Q?m3kVh06Q7/CfN4A9elNvuodJ0Xl8Y2Or9BAl//Hkcoqnsgt5gPv4JAyJUKY1?=
 =?us-ascii?Q?BMZARZrJSU4/36sz/ndJqV+80Zbvifg2ZLbaiRQt4ZWV06SOje1UuTXxQufj?=
 =?us-ascii?Q?LBPqexvDT4PJLB4RYFkGt62NSTK4mhV7iLRwk8M0vguzbixwf12FXGdUzE0k?=
 =?us-ascii?Q?2bsgfrtl8HgNFGspmPxpLIUoU1R6j3yb1+5Zeti1Xm8rvz6ytzCZ8r29IGcb?=
 =?us-ascii?Q?HkObZNYkMNt6xGTiQ1nrK4sfLZG7wcq/xZNRNerDG++A7GB7U0ZUbKFl1yXH?=
 =?us-ascii?Q?FV/e/b7SpzJPK9QgJdhRM0LxmrePkg82BjZOS0HmnNx1rvKDjGR/a1UhfFZX?=
 =?us-ascii?Q?vwTCR7Uqo56rmgpNxGZEg2Ub?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 524143fb-a156-4d62-e122-08d8d9df7dc7
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 22:48:38.6369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gPMEC2T6PYBSUgkX8h0GGj/gMRtfRdzyAfuu4PIk0zn3Gv89hHYXMxOQwX6tPBwuSCAWWrqFeolLSop/r1Rs2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6163
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 25 Feb 2021 22:48:46 -0000

If linkat(2) is called with AT_EMPTY_PATH on an AF_LOCAL or
AF_UNIX socket that is not a socket file, the current code calls
fhandler_disk_file::link in most cases.  The latter expects to be
operating on a disk file and uses the socket's io_handle, which
is not a file handle.

Fix this by calling fhandler_disk_file::link only if the
fhandler_socket object is a file (determined by testing
dev().isfs()).

Also fix the case of a socket file opened with O_PATH by setting
the fhandler_disk_file's io_handle.
---
 winsup/cygwin/fhandler_socket_local.cc | 7 ++++++-
 winsup/cygwin/fhandler_socket_unix.cc  | 9 ++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler_socket_local.cc b/winsup/cygwin/fhandler_socket_local.cc
index 22586c0dd..ad7dd0a98 100644
--- a/winsup/cygwin/fhandler_socket_local.cc
+++ b/winsup/cygwin/fhandler_socket_local.cc
@@ -750,9 +750,14 @@ fhandler_socket_local::facl (int cmd, int nentries, aclent_t *aclbufp)
 int
 fhandler_socket_local::link (const char *newpath)
 {
-  if (get_sun_path () && get_sun_path ()[0] == '\0')
+  if (!dev ().isfs ())
+    /* linkat w/ AT_EMPTY_PATH called on a socket not opened w/ O_PATH. */
     return fhandler_socket_wsock::link (newpath);
+  /* link on a socket file or linkat w/ AT_EMPTY_PATH called on a
+     socket opened w/ O_PATH. */
   fhandler_disk_file fh (pc);
+  if (get_flags () & O_PATH)
+    fh.set_handle (get_handle ());
   return fh.link (newpath);
 }
 
diff --git a/winsup/cygwin/fhandler_socket_unix.cc b/winsup/cygwin/fhandler_socket_unix.cc
index fae07367d..252bcd9a9 100644
--- a/winsup/cygwin/fhandler_socket_unix.cc
+++ b/winsup/cygwin/fhandler_socket_unix.cc
@@ -2421,11 +2421,14 @@ fhandler_socket_unix::facl (int cmd, int nentries, aclent_t *aclbufp)
 int
 fhandler_socket_unix::link (const char *newpath)
 {
-  if (sun_path ()
-      && (sun_path ()->un_len <= (socklen_t) sizeof (sa_family_t)
-	  || sun_path ()->un.sun_path[0] == '\0'))
+  if (!dev ().isfs ())
+    /* linkat w/ AT_EMPTY_PATH called on a socket not opened w/ O_PATH. */
     return fhandler_socket::link (newpath);
+  /* link on a socket file or linkat w/ AT_EMPTY_PATH called on a
+     socket opened w/ O_PATH. */
   fhandler_disk_file fh (pc);
+  if (get_flags () & O_PATH)
+    fh.set_handle (get_handle ());
   return fh.link (newpath);
 }
 
-- 
2.30.0

