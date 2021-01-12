Return-Path: <kbrown@cornell.edu>
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2134.outbound.protection.outlook.com [40.107.243.134])
 by sourceware.org (Postfix) with ESMTPS id 5C5833850400
 for <cygwin-patches@cygwin.com>; Tue, 12 Jan 2021 19:45:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5C5833850400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikYsHEpg9rabKD8yciE60hExCG6RTSDoPQPzm9ICMl5wmDVpGPg2B5Uj5RR3XlPLl7XmaUeIYPUqCQZdQP3ejqCelfyhUfk6sQQH5KMu3CbNhD2bneN8nFoZxEjuBijp4LxZ9WnxJmfRe39D4UScjWeQYl1eOvvNRSnFCSZ7OHcXZwxT7A8eRlU/Nv+evJYUxsM9/uwO1HEXzJLNBWqnYzPQyZ1VC+YrfTmQKzhlOfv8bw/lBspN3/DCldUzWAjeAcmGn6D7SXdjsh27cq+nSRtUbzfCXxNstZhfqmvBGoBuHhk3/42yiZdxrHa7LnHVkra/QsSlTeFNnDv22iCnlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CQ+Ony8BhLYl3eSx6hxuSTJCSVgP3N5ftPcVX1fB0k=;
 b=dW80lDothVpJ06tCZEg9ZEF6tsjDCXRHArI83aXV/RQykLciEeyRMvGDdKXh5I+l+N9UJpNKwUcZbYRoObScPEE168FEM1G/hUG6pYf9+3uFpHvZWjRiicwFrPjmrUdWcHk1Kvwzc2iYHUa5BnNdii4agSb9bxgQ0hTuVeFCOjBqKz8N84TOR9RgusRlN6vzQaHIrOEpTu4ZPJkKFWjSZMABw7ZA25LtaGlipj+CGp7Tp2Iif5bD68wPasWYlxFSnsKHPVvuM24jqjGgOQvQFOtpc74VwX+I7nrtfWeJ4/7hvospLs8oGOzpF89muZAeCdo4HQSE/eUK9M3E+r3rbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN6PR04MB0898.namprd04.prod.outlook.com (2603:10b6:405:44::35)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Tue, 12 Jan
 2021 19:45:35 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%7]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 19:45:35 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: fstatat: call fstat64 instead of fstat
Date: Tue, 12 Jan 2021 14:45:14 -0500
Message-Id: <20210112194514.564-1-kbrown@cornell.edu>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [65.112.130.200]
X-ClientProxiedBy: BN6PR19CA0118.namprd19.prod.outlook.com
 (2603:10b6:404:a0::32) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (65.112.130.200) by
 BN6PR19CA0118.namprd19.prod.outlook.com (2603:10b6:404:a0::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9 via Frontend Transport; Tue, 12 Jan 2021 19:45:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65a8b15f-0858-464a-df21-08d8b732a0fb
X-MS-TrafficTypeDiagnostic: BN6PR04MB0898:
X-Microsoft-Antispam-PRVS: <BN6PR04MB08988F9B1DFCFD4E458DED5AD8AA0@BN6PR04MB0898.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e+fYD+vViCvZHpyEfqSpzhh4OR33Q2yuzUjEA28JJnlR/DNGllnoBJSfTYriujmYmRl67s7iQ+zzTfagCcubwqEQFMgiyhwp8A1u2VBiVp2+JcEz2YrV8EVsDR7YJsXyv2TrLB/rnlPz9J+TdxtdRnSlXJ43HAOvBhv65b6RDSyqVN5Jj8bF32fyGzpgKGpjdowMGggnrz7TmLxvNccmtIN81prGf34CPft2T7PwK46V1T1ymE5yu8fTFfcrG0tnkGDu//TPAmAA2UJy6W+LzzagQM9LgXIwWpBhhVX/f9/ia5MN3Dv/deTBLQ283flZzHLuztK9+0cV7Ci0LkeJUC504RjI6bmALDpm3snvgyvXrduPYLq9exFE4snyOrKRdTH70c7pyABE7kjt/ZZDPvLlCN0ovz+O7l8iq+WoG/ziE6OL28lQAza5ve+qz79B+oLQk1DxYAUbmzo/BxCuVix5MQd+lG3cuD5PP+o2ljy4MOcnDK3fgkXs+MzSyZojOn60qWdgO++xnFcGTlCB3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(6486002)(478600001)(316002)(186003)(16526019)(86362001)(1076003)(6666004)(786003)(8676002)(36756003)(6506007)(75432002)(5660300002)(69590400011)(66556008)(66946007)(2616005)(6512007)(2906002)(8936002)(956004)(83380400001)(66476007)(26005)(52116002)(966005)(6916009);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?8QLVwfAle+4u+jtqichigbltJSTZWeygsQxhUX0LGLsFpnA8Sj4qPfdJHwdJ?=
 =?us-ascii?Q?U15jESUcMwyJpMusUQduv+uhn4dYJrfVsb3QcFtQO45lEom4sRf/omJCvJ8j?=
 =?us-ascii?Q?ehvzBFhIKeFKASugteEKKZY8TDnfkVopzg7L+tAlKLQ9+/kSzE2IffIAx50i?=
 =?us-ascii?Q?GtqFa3f5rjKD6vCuRv//civoMsg2za4FjwKl/DFbm7yXmaaOOC133NGSDLzP?=
 =?us-ascii?Q?q6mV9ZFYMJdXp330oPW2ZP2mcBaa1jOcQkWBjkCzZbNCt0ZJb0WZ1rXkeF00?=
 =?us-ascii?Q?Yg5AEM3GdXIYPmcHFikBzcVEtm7PUJT0BiIC6RbOtXOgGT3eZPleGQskvZeA?=
 =?us-ascii?Q?JJYwUqIjQZpFfgZ6Q1v/gQmKu2W34YnTNQBfhZwiJ0MSCdGd6CjzbzVdKqtj?=
 =?us-ascii?Q?h0kjpdRw4AWU7cZKzia2AxNx2Z+TXjHmQq8fOWVJuDYbhYgZhewA7D63L8Mn?=
 =?us-ascii?Q?tIi+4qxh1LGYznmELVEGInE8GaWDHc4uJ3AJTU6bJbryVbbeSDS5CBiJryB1?=
 =?us-ascii?Q?VOaCmhL1vJYrhKRyGOHu8NULyAKHZhYQak4HvpUOCGR1dN75FEWeYyofZyg7?=
 =?us-ascii?Q?cSNnRH7kTuQ7s6CZI3sx8Rq+byT5ygKXSYy070yhVQenNe6lmmSRIKRrhlc0?=
 =?us-ascii?Q?S56qC2VsulVC65jVrcRExbeITT6cZq3jqcHlauX2wv6xpnt1nupkrGb01ctJ?=
 =?us-ascii?Q?ip9VP+4oj1DkTAdkJ3TED4BfO3O5yDnjtyKZyX/TZrBuMaMz2lTtv/Pe/OUK?=
 =?us-ascii?Q?YSDKFVHw/2E5YeKDE6kwqKrpAKok5dj8IwrDmmC8tEAYdM5GuWyxYeXhzcc6?=
 =?us-ascii?Q?zW8EnMM0SZHO3i1fv5rQX/XoZSr5wY63XJWQnWFb7dddzy/MSBGkP2hIib5B?=
 =?us-ascii?Q?JCy316Qy9/BBKs/4l1vttt1Ul1vk+HouVhAKotk4/fCX4V1IPgmsVfTj7t5W?=
 =?us-ascii?Q?gOuoq6Fs6/UK/OQjLKPWc4P1c5A4G31JGPufinf6caBRsqxgw4njjBvIJbv0?=
 =?us-ascii?Q?AMlZ?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2021 19:45:34.9834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a8b15f-0858-464a-df21-08d8b732a0fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+c95xA5eEp/c7WxDr0uUJCUA6iB2ybotHe+7y3b0Ai6mQffRogTua5iWYn9BU6OlrgpDNyh9kl9mO4ecny3KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0898
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Tue, 12 Jan 2021 19:45:37 -0000

This fixes a bug on 32-bit Cygwin that was introduced in commit
84252946, "Cygwin: fstatat, fchownat: support the AT_EMPTY_PATH flag".

Add a comment explaining why fstat should not be called.

Addresses: https://cygwin.com/pipermail/cygwin/2021-January/247399.html
---
 winsup/cygwin/release/3.2.0 | 3 +++
 winsup/cygwin/syscalls.cc   | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/release/3.2.0 b/winsup/cygwin/release/3.2.0
index 22f78e7a7..132d5c810 100644
--- a/winsup/cygwin/release/3.2.0
+++ b/winsup/cygwin/release/3.2.0
@@ -42,3 +42,6 @@ Bug Fixes
 
 - Fix return value of sqrtl on negative infinity.
   Addresses: https://cygwin.com/pipermail/cygwin/2020-October/246606.html
+
+- Fix a bug in fstatat(2) on 32 bit that could cause it to return garbage.
+  Addresses: https://cygwin.com/pipermail/cygwin/2021-January/247399.html
diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 885ca375a..525efecf3 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -1929,6 +1929,9 @@ _fstat64_r (struct _reent *ptr, int fd, struct stat *buf)
 }
 
 #ifdef __i386__
+/* This entry point is retained only to serve old 32 bit applications
+built under Cygwin 1.3.x or earlier.  Newer 32 bit apps are redirected
+to fstat64; see NEW_FUNCTIONS in Makefile.in. */
 extern "C" int
 fstat (int fd, struct stat *buf)
 {
@@ -4852,7 +4855,7 @@ fstatat (int dirfd, const char *__restrict pathname, struct stat *__restrict st,
 	      cwdstuff::cwd_lock.release ();
 	    }
 	  else
-	    return fstat (dirfd, st);
+	    return fstat64 (dirfd, st);
 	}
       path_conv pc (path, ((flags & AT_SYMLINK_NOFOLLOW)
 			   ? PC_SYM_NOFOLLOW : PC_SYM_FOLLOW)
-- 
2.30.0

