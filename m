Return-Path: <kbrown@cornell.edu>
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2102.outbound.protection.outlook.com [40.107.236.102])
 by sourceware.org (Postfix) with ESMTPS id D126D3858001
 for <cygwin-patches@cygwin.com>; Tue, 26 Jan 2021 21:31:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D126D3858001
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Womrws59JtJo9TFomlwEBrq2Fgoxqpf8qFpF7eemLcdIa9z2jhsny/Jb19ecigIsHz8xndfKwbI3U6OQntlzTyI61uLP4GrDVLRNI5H0Oqh+IwbY7VrxohJH6fBjjdMYQusPhEbV9qHjjWtI6o0NBtPuxApgub118fsCie/u2t8VaWMi5VgkU2d4Vb/5GVNLl+rl3qrhd3R+IrtjynnEf3SKVPVy5+1sTXlxqPktKtJpZOp46MuYkENbo9GoctK1vifjALQitnP0bnNQh3Tkw8GtWobIinTaiYQGrZXuyfWc2qPz4c86umKK7ka4/aR9t2YaErfMaOY3ZysGaMHiTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6aL8/PQBvLgFqBOhhQRjIWuWVqPIlh3CQROOgqNMhc=;
 b=f0kWIJhOhwcwfyoa8++1un47uJxsoqqU/IdlawzllyUnDee7R1iOuQYYBTRGKpr0ciQE2b5Bb54ekoTbUH53Cr5m8h8L7x6Pq36eaylCEpbyfpVCOiTdMP1EMmwoI5OuaHuB39E1+hH7RkRti5Gd/a90uynLSxCs9Z7SOAOYM3/U0CfQwC/eRUseBXE+S2RRsYApHPGrBaU+PHs6Phg1TGgVNUtCLFhiuGTkKqd4c56SmvKh6vrUAMepv1sxVXJvNsP/OqKRuxcsCB6vhNaO32nmAjWhIpNi16mbLHoPKy0F8tSPkR14Tl3sikgjD2llRnhxS952w2Er9SAzFN4aEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN7PR04MB4050.namprd04.prod.outlook.com (2603:10b6:406:ca::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Tue, 26 Jan
 2021 21:31:13 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%6]) with mapi id 15.20.3784.017; Tue, 26 Jan 2021
 21:31:11 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: fchmodat: add limited support for AT_SYMLINK_NOFOLLOW
Date: Tue, 26 Jan 2021 16:30:50 -0500
Message-Id: <20210126213050.41241-1-kbrown@cornell.edu>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [65.112.130.200]
X-ClientProxiedBy: BN9PR03CA0083.namprd03.prod.outlook.com
 (2603:10b6:408:fc::28) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (65.112.130.200) by
 BN9PR03CA0083.namprd03.prod.outlook.com (2603:10b6:408:fc::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.12 via Frontend Transport; Tue, 26 Jan 2021 21:31:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52645591-80bf-4c4c-005d-08d8c241b371
X-MS-TrafficTypeDiagnostic: BN7PR04MB4050:
X-Microsoft-Antispam-PRVS: <BN7PR04MB4050A0323EB530AB2AB92548D8BC9@BN7PR04MB4050.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l1DzpwfU/akH5RPiOtg4BdIc+czQaLAatqxl6uVp1OKm/yVCnVqUliu8X0musGIlgE98r3QFrc/e7lyhaNCmnLKjT/E0t9NBEj2SIautWZH891u6egIXeXPeutKpUjzaaeu9JzzLhI2zJCGWhpu5hYtkYghvVREdYEobaOFd3gLljHz6+g9FvByT/3gPG3d1lxYKmPrCQOheZI0metFUPD/uzIfiDYdqjsXGRPychnJDheu3Kkmf6jmZC/+S2igBrwbVyt+ytjND90pv82YD//XMRjeGOWtZM4J7RUTaS40szEmocy2gtWRgSEB/o59gtMhgrxRIYj2Sex0P2bh5UG0d/5VTe0RYqmQ8TyxOmSSHNOtpQghNSLqXYcZgGTg7eRHsJyFE1tjj4ZcRi4pDaJo1uoWvwo+kkeLttbETAktKNaG54SvTPqg+dtIjFXoP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(1076003)(66946007)(786003)(478600001)(52116002)(6666004)(16526019)(6506007)(8936002)(8676002)(2906002)(36756003)(6486002)(316002)(83380400001)(26005)(6512007)(186003)(69590400011)(75432002)(66476007)(86362001)(6916009)(5660300002)(2616005)(66556008)(956004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?e7wnvWe2ikuxgIC5rAYF7wTmPlpqN5TQK6+4ZDwgkIWeNi3tBDbEG8lGCTtE?=
 =?us-ascii?Q?Jz6IGoL3xCfQwe3AK/ihsQT2bbVrX4IIeJyGIQziIBGu2J96PqnNqsUNa+HV?=
 =?us-ascii?Q?/THYT5emPnVe2F9yUHVQExaH7Bl9jiUtswIzmebs+ZYZMmQ4hXkBnjMmDibG?=
 =?us-ascii?Q?E2s1UTrBnSGSe9GtzeoKizN6PKvHvfP/YUHwxzhh/FY/8yx6SrRAooKrR1R3?=
 =?us-ascii?Q?sn2L7FiUiG38LvIQFJABRbdLnq6VG8BRR6szaQXi9oOQL31fKjX9uTWYILzd?=
 =?us-ascii?Q?8VQWRJM+Fg3m8DW2WqdJFSbHw6mmOG3cw1zVOM8BYG4FtG4faeGkia9Fmp/2?=
 =?us-ascii?Q?XdcDyqn2JJuB5pYUeObn1feC9YEhEBESkJcAJNIzYYcICkJXqrp2CLsEXcHo?=
 =?us-ascii?Q?MT9DbT7QmrYoItwjbqCQUVlPl3fGubSfZiaI/acsRUGzb6Cd2hgAuIb/aCRJ?=
 =?us-ascii?Q?0n9kCl5D6/8QYFyVADrCwOxC8GWCB3nZDC9MulM3GrGJA0FdhANXhE7tTEt7?=
 =?us-ascii?Q?w0Is7H35fdNFNZvRi+GfaRRRYJ2khDux2/0Jbfbg0NrQ2juPEL5B6fNXOUMt?=
 =?us-ascii?Q?go3PyPpkBh0w5kYQdzoKQ7SY7mREP75KP0TDfNsMzt6fQsTKLwwVt414yhP1?=
 =?us-ascii?Q?O5AUhsELDJXWFo8VHpFwxlc2Y5fkKiTtnGwboRyG3i2H+lHwfdlR2wgISWNu?=
 =?us-ascii?Q?ER/AFI4Ng9jLJNN40tgWTvScqcHbqR91sIwqVGErYEQXOgeW9dqpNA9hcwRm?=
 =?us-ascii?Q?O+XxX2BCXQxQInE1xkv7fdreEVVLmYdUaVCm6E78bDma/4znbbMZTEpTL7Io?=
 =?us-ascii?Q?9GKIQSMAOmt+aL7MMCmJB5grC4YbPgIqDNdJImB2g+qI/IowrFlRIYaTVaDq?=
 =?us-ascii?Q?Z53T5jrYCo2PWOC0djvLS7/DTR8WojnwYu763/mxUFaYs2LB6pEvWPNaPm12?=
 =?us-ascii?Q?Kuji0I0yjpiwulg+D4K9jZxtR5KZIswqy70CKmLCCZC9R+gNhSEDQdjk3LkV?=
 =?us-ascii?Q?m7Q3CuZOsm6ronn1OJNx4YQFhjeFOOVGqJSor7JgPtjuSLGCdfPFb0dUapuL?=
 =?us-ascii?Q?EeO8dZcy?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 52645591-80bf-4c4c-005d-08d8c241b371
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2021 21:31:11.5023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e0hQuedzvPtREd4DYtYcc7tak7Vvt4eEeqCHdg6j21YJluyem6LduQk2Az1u4UkHjGvOoVl+aonOzgnmQ0YcBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4050
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, JMQ_SPF_NEUTRAL,
 MSGID_FROM_MTA_HEADER, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS,
 SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Tue, 26 Jan 2021 21:31:18 -0000

Allow fchmodat with the AT_SYMLINK_NOFOLLOW flag to succeed on
non-symlinks.  Previously it always failed, as it does on Linux.  But
POSIX permits it to succeed on non-symlinks even if it fails on
symlinks.

The reason for following POSIX rather than Linux is to make gnulib
report that fchmodat works on Cygwin.  This improves the efficiency of
packages like GNU tar that use gnulib's fchmodat module.  Previously
such packages would use a gnulib replacement for fchmodat on Cygwin.
---
 winsup/cygwin/syscalls.cc | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 4cc8d07f5..0983cc76a 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -4787,17 +4787,27 @@ fchmodat (int dirfd, const char *pathname, mode_t mode, int flags)
   tmp_pathbuf tp;
   __try
     {
-      if (flags)
+      if (flags & ~AT_SYMLINK_NOFOLLOW)
 	{
-	  /* BSD has lchmod, but Linux does not.  POSIX says
-	     AT_SYMLINK_NOFOLLOW is allowed to fail on symlinks; but Linux
-	     blindly fails even for non-symlinks.  */
-	  set_errno ((flags & ~AT_SYMLINK_NOFOLLOW) ? EINVAL : EOPNOTSUPP);
+	  set_errno (EINVAL);
 	  __leave;
 	}
       char *path = tp.c_get ();
       if (gen_full_path_at (path, dirfd, pathname))
 	__leave;
+      if (flags)
+	{
+          /* BSD has lchmod, but Linux does not.  POSIX says
+	     AT_SYMLINK_NOFOLLOW is allowed to fail on symlinks.
+	     Linux blindly fails even for non-symlinks, but we allow
+	     it to succeed. */
+	  path_conv pc (path);
+	  if (pc.issymlink ())
+	    {
+	      set_errno (EOPNOTSUPP);
+	      __leave;
+	    }
+	}
       return chmod (path, mode);
     }
   __except (EFAULT) {}
-- 
2.30.0

