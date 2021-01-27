Return-Path: <kbrown@cornell.edu>
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2137.outbound.protection.outlook.com [40.107.236.137])
 by sourceware.org (Postfix) with ESMTPS id A9EA83861030
 for <cygwin-patches@cygwin.com>; Wed, 27 Jan 2021 18:54:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A9EA83861030
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iryUEF+LfCgDtnV8I8jGMo1ig7M2YFOhY7YzbOCOuLUF+dZXdaL33OQ9nFlHccvu5PH9n3geIiGy/+uHC87mnSiJeXKnv6gN84Sn/MKTpcI1FYx2KqwoBf3g/beRXeNzZLQtjTwNWPu3wQDnBwlnX2QJ/QymqmCA+Hk493JlvRAIlssiUVa6e+om0oWyjRudM4jXbqX2IhAHUdKc9aatKSL023jfgNMC1eZfPx6VMPY6K/4xiVVFt/T0s0g1RF2v5glIwfHTKrHrrVekNDkzw4/GKjVVFw9ikBtI/u4JWJxEiN+1wJNYxSHup9OG1vsV0iExU82FdHzMaAqfsd4VxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LIm23/OUiT25ug1UI3HAT1/NfNGfszzf5H71k/dNxe0=;
 b=c5B58c3HohbrZmavWID8Wu0e274lNqMGR5ZzqsXsnl5IWX4vsxXDnodImwJfC69e8e1fyyFZiIDXosYPclk/eOP9clkFK7msqsAKc8Tbf3t9Pk4Uiv/VRUQqE+x/EJdJqZQTovr/s4keoTqsOkNJj3k/wtrA8yFZ/aMg+IR9TnLM8Z0MOozOzT0f7e1SUuCohXmQqhpWU0LCjzYXnXu8OZghxC6aTrfUNPFpkwYBJFtXt2dQJTo74lOQMSZWkLDb7GcG1X0zaLICT5RomFnaKi8BS+eS8nTMHvIwjKVpIskqKfHEtOxTQbPqa5JwZV63FKZqWn5x1KtjpWc+tXXUMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN3PR04MB2321.namprd04.prod.outlook.com (2a01:111:e400:7bb2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Wed, 27 Jan
 2021 18:54:09 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%6]) with mapi id 15.20.3784.017; Wed, 27 Jan 2021
 18:54:09 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2] Cygwin: fchmodat: add limited support for
 AT_SYMLINK_NOFOLLOW
Date: Wed, 27 Jan 2021 13:53:48 -0500
Message-Id: <20210127185348.44805-1-kbrown@cornell.edu>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [65.112.130.200]
X-ClientProxiedBy: BN6PR08CA0056.namprd08.prod.outlook.com
 (2603:10b6:404:b9::18) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (65.112.130.200) by
 BN6PR08CA0056.namprd08.prod.outlook.com (2603:10b6:404:b9::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.17 via Frontend Transport; Wed, 27 Jan 2021 18:54:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7579b5af-409a-4331-c552-08d8c2f4eddf
X-MS-TrafficTypeDiagnostic: BN3PR04MB2321:
X-Microsoft-Antispam-PRVS: <BN3PR04MB232180C254D5EEA874BA2621D8BB9@BN3PR04MB2321.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bX86hfYTN3fPi+7uMyhIGeP9Hxb2+w5iBeOp1m66cQjTmkAd71OkH6HDVSA1Msou+NW8MKuqy9q9iqJFPwoo3oTuH1UXFB9BKyq9Q+usc0OnG7vR7pzehjBOHt+yUJMfBbpdn9m7Dn71zRW6RE5QIGmfzTunXUxxNBQMlphopdUq1YaG/CkV2eGLJ4DWj5VdWPwA4DlityquuxgpvSTvUNelzl26m2BVZmepfZZhwfJxB2G+KWkFY9l9O5qzs1n4mj91rDpFiiU+8S/0fJHz0rZLznxAy8uoDdkZjLlkRkCmGRxv0woArT+7fCnwLcYhyT8TYNR2V0OJBKXJSNse6dRBiDTqD3H7+LQkiyWFFB+YQR0eT/dtXG48eFpCwmk9bVPK5tRFW8Ky8HhWLW0AcViIxCm5g0c679xG6RbDkZoSSlpWWXiVYgk+BxnQ7OGh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(186003)(6506007)(6512007)(26005)(1076003)(6666004)(5660300002)(86362001)(16526019)(2906002)(956004)(75432002)(2616005)(52116002)(478600001)(66556008)(8936002)(66476007)(66946007)(36756003)(786003)(316002)(6916009)(69590400011)(8676002)(83380400001)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?QzAKxwrdaxGc13eDAKxgztI3DrdigHjUXPXaA3gv5RJwQW9IsHIZPAIVYhvA?=
 =?us-ascii?Q?/4zgZWKgxWKkhBubdSySh5B1WvAqmVMrGhvHm6rHiJoiW8RBuj7AIjtWSb0N?=
 =?us-ascii?Q?dqadYdk8Rj9Hb3kNtQZJE29S/lwplJ4NeAxUpRfW8mAu5fcIzpkqLBEAUOs5?=
 =?us-ascii?Q?efHiLC63M2slJfWe9KgYEhy+n5oGye+2Z4Pw8eAqQcScXpRwnUp5mjW2BVre?=
 =?us-ascii?Q?7yoIDox8jhjlmrG9x2yanbo4kB7y1kTym9BLPQJaBl8XhwWo95FRniNgTx2d?=
 =?us-ascii?Q?IMxp12GEO2/K89TzT7cspicuTe/Y0k9UZTPsI4os9hi/I1tRAEm/+dgRVvyf?=
 =?us-ascii?Q?2JpV4/+Rr739IeBjPFIvxmfYDavRrZ3Espbz+8kD6NPJY6W+CqO11hTXv5G4?=
 =?us-ascii?Q?2F2iMDQNgoRTbbbGSP5N20xqJjbSou7rT99CoUz9XXS5NRfYMWgXo0yNsHE5?=
 =?us-ascii?Q?s/eoK+jh+PirHyJxNuZA0OOC1qBGfbt+ya9NWFwTUNkOVt+ZTYJ9oenE6D73?=
 =?us-ascii?Q?GZ3reX3JgAmHbqOju7ihs0YSETqhQGkAjuPZFWHEYLLaASFLl5lEg1IqA6hr?=
 =?us-ascii?Q?N1yxcAFvDeQ0xtAGtXyXLX7ume7YK52CmfIhgDP9w/pCVDrZCVw8NdSij379?=
 =?us-ascii?Q?Fn45rseG/HhpcUWCSgHvge9vsWZTc8JL5OtLYwG11pcd+9gm0rBxIY9iyBIj?=
 =?us-ascii?Q?btv/HuAalV3DfQqKUwaydQm2cF4a32VfFVTlxtb1IYfOzw73MtHLMmnqlogk?=
 =?us-ascii?Q?VxTMlZdwq4Z5sd9WUsT3UcieD14f/z1ETu2CO4bO7JTOco+k53h6TFtFcZ65?=
 =?us-ascii?Q?gA/viyTamdnTAQISi8yw09m4tLd5q5P6iQo4x0V0XHzSNhvpWXFf5LNc6OOH?=
 =?us-ascii?Q?N+vQuUkwweWLTyt8C6mTXSOYk2ezuu9SnrmR/zllzdppoP3QErKlo5w7hyif?=
 =?us-ascii?Q?4Axa+JdD7kVYZ/Vmo8OOcT6/bYPZywsTsOS6gqXwPC1ZIBEysB8jFinZqb5C?=
 =?us-ascii?Q?rZV/VhKmCN1ptgIJSOYWBpvUUsxCHWB+JOmC+cpg1x9bTKZaz2rSd9Q/ach9?=
 =?us-ascii?Q?K0vWSudm?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7579b5af-409a-4331-c552-08d8c2f4eddf
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 18:54:09.2888 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E4vITO5L04q/OUMtHUTkViJ3J2yS7p3Az9SXs0EUr7feyRfv2CY0blH5s6TrYPf0zD5AoSXLLeplTlPJTEIVQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR04MB2321
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
X-List-Received-Date: Wed, 27 Jan 2021 18:54:12 -0000

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
index 4cc8d07f5..5da05b18a 100644
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
+	  path_conv pc (path, PC_SYM_NOFOLLOW, stat_suffixes);
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

