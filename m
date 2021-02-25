Return-Path: <kbrown@cornell.edu>
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2120.outbound.protection.outlook.com [40.107.244.120])
 by sourceware.org (Postfix) with ESMTPS id 31FBF3972004
 for <cygwin-patches@cygwin.com>; Thu, 25 Feb 2021 22:48:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 31FBF3972004
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKICRqhZfmhQaqOy2Fm7ZDhBSC5Pvh0cUMJZG01Dho5z7ST0MiTzx9HHlNzlfeWPUivUuFhUUsgsNg46AuNJUbiyKJzCD1VxGCFZdLNwAoUlq5bac5J9EnCkzbBUvlZzEk2h5H7NjTJyfg5V6D79C2/mIJW0YosQgctG2EX4aaUm4Mp8VmzzX5bDansc+SsAbUTHekMBpNRtFp4UJWaLtr+EIf25qrAgtAtgpvPzeTksdj7HpTWwzv7bbzVd5qoIEs6f+Ntr0+Be16s9g83m1wRyOD15yj8I53z4KgSG+mXpFWpy+cyZFuMhefVSj/R0d/QGj/jCaHLGKfnspFySRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uykVZ1sZaxbExm1Q3YPEO6jwKeTM5zp3UYUqgcsy0Ug=;
 b=RMkQtiyuLD693Yqyqc3E4+SZqSzB5dOQoyzzohSSz68h512+QhDYJv0GXIrRNa9X4xtFAtiSZjt2kDkt5CbCphxFdbIi84em6CUze6Ol2JvAejpKWwwi52KhdxJcWIovyzw1/INKDB7XZNY/LlY5gz4pBWPag1vdbGDPWdWsjFrjBPty7FvU/WJY4co3np/FI5DlhzrApGY1eSoPwF9Ff1avykmZYpK7Ib+hXa2LXvGDzNOBj3wMeprkiBmSeFXyDfdzJ37f4SUNMZo0TWxkBWHf38SwIBNGZGTg+paEVFthXbNpv40fwUi9rkfrIb2+QK2rYoPIzR7vd+RRNNld0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN8PR04MB6163.namprd04.prod.outlook.com (2603:10b6:408:5c::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 25 Feb
 2021 22:48:38 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%6]) with mapi id 15.20.3890.019; Thu, 25 Feb 2021
 22:48:38 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 5/7] Cygwin: fix facl on sockets that are not socket files
Date: Thu, 25 Feb 2021 17:48:10 -0500
Message-Id: <20210225224812.61523-6-kbrown@cornell.edu>
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
 Transport; Thu, 25 Feb 2021 22:48:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f45274d-c27d-4cba-1080-08d8d9df7d53
X-MS-TrafficTypeDiagnostic: BN8PR04MB6163:
X-Microsoft-Antispam-PRVS: <BN8PR04MB61638992EF136FBE96E4BE82D89E9@BN8PR04MB6163.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jltmUo8TofT6qOkZSDgbAf7HfgEMMgUwislAqyTOj7j5be+vS5sP5BWBIqRMP+LLZR3vv9iua+epBkuJcn/4RNsSj1l4HqXMcm6Zxenhh8B/iXn61lYOJmsTAj0b4SYIm94bhnSaZ9WoFOGlqVmkZbkUSid6M/jIZsO0IXgzJjfpmfmqaA2ZOFKVDvGMPCP4+VnUGOXC40Z2ay1cu5C2ckqf7/rOxibaC7orfHhX1qVlh6fFTeim0JZ0HPcxYXOX764Yn46JzQi4YGh6CJOsWv+h5QdmnWcHiRV4RlhfxvwSwqncPynOMzC/xcFyWlOvw/y0uThvwJRpmbSCeay4hHvMPPaKB7IGlxREth/+RTxR8cyG6H3cIeYPynWFT+8+PQ4ks6o4a5ipNcjkdklcBAy0HnYXZK2wbeox9VofKIMeFM3XP14/mJPFTNMM4YaXPxxUbs7x+i+ZtlepVKsYWqhiWvLhv//66pNiJwZaCslNVVqINLXD5CzjapcN3Oo2PF9tA9ujtLRapC9CrtKKdCzqWked+fjScLR9dYeh8IXVKxkcEDM/XddGb5cFYDoPvP/4Hee4NXD06nNEGvG0VQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(1076003)(26005)(8936002)(66476007)(66556008)(86362001)(6916009)(16526019)(186003)(8676002)(66946007)(2616005)(316002)(36756003)(6512007)(956004)(75432002)(52116002)(83380400001)(2906002)(6486002)(69590400012)(478600001)(6506007)(786003)(5660300002)(6666004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?fzzyfh04hAKMt62bqrlTbaHaCgHrANdIsTi8eLskCzw1/JR/fUjKz9Y9cwB2?=
 =?us-ascii?Q?UQxuH0eqQapEkIGfDUoZ+VfyYFpKpvIBCpjWNuVoSguZHb6kHhgTZhuSvulT?=
 =?us-ascii?Q?XlwZFUYBujOpWKfawG9GXYZKIS172Zd0jr4Mc2NnCZaKP28iawS8Arg0dg0e?=
 =?us-ascii?Q?8oO10H7L1Jb6k2i5/a9h+QS5n7RXYelkqBf6fordMGZAlKY3Gt4rFztk5KMW?=
 =?us-ascii?Q?dGMuL271J3HuYvNhkQuJJxC4RjAEslcX8QNGnG38Bqc1IQPskef6xxlNqifF?=
 =?us-ascii?Q?vv5Xy13oB7I+SlId9pt5BaZNPeDdgEzBqLq3BY75RDNvB/oV8OFXmGQ6ZSw6?=
 =?us-ascii?Q?H272myBq8uRqd+zBhQ6lhTCumW3ZG48HuvXsIVjHaeKAHacZmO2j+p0yOO76?=
 =?us-ascii?Q?OKxCdqib3V1NuYO+6JY9n42o/yNj2ZWg1HY1QXcQiBy2dyJu8D/2vLNgY7bl?=
 =?us-ascii?Q?IaSwr7i31l/5eso44Wrjo2dEteuFI+hVJ9Zs2txqj6k444Et0orqX6MMcUIe?=
 =?us-ascii?Q?FyqbshvHeXQ/4WaGyiuEzVwK1obEGyvFyUNTZmUoXWnSICp4zCKDr1ARl6w9?=
 =?us-ascii?Q?mTyADnJlFdVLgljcoY7ScC1tAbeCbbUurcuYb+AKBQVn5iatU/IguXwCcETR?=
 =?us-ascii?Q?u2IHS5WGYdV5cM2RUn8XWbg9JKLbdNCSPbp7ti8Ih+GyKHrK1SBa0Fv6so3W?=
 =?us-ascii?Q?Qz9fGRlY8eC0CNjQp+GPal8M45+V5nKcxnuFvsbuN6eqq3vTvYSo2xR413jf?=
 =?us-ascii?Q?KIDWM5JgbV/taL7/ZNJqvtK+mlcgKsJtM9j4NlTYogzMKpOiz8Zc42M/a/bF?=
 =?us-ascii?Q?s+jOKRNRZ3vqB5fl7iA9Sv97x1lCLRVPK7FG5ugD6PmwQm9NuqxFnzyMphxR?=
 =?us-ascii?Q?GxvwxfSAAV+d1Sc5JM1TZwdOiOfG1SMw31YUrU3kW8VkWTNlHVAjO/JeSXcy?=
 =?us-ascii?Q?AmcQp7bnWgaVpDjN2OTONSzq1pPvVBXFQt0wHxCx8szHhJuLbf4uhvuqb9RJ?=
 =?us-ascii?Q?KpqG8aqhKEHB8L/ubz0QvhSR66jczRFT1/YRJ4x1aMlthk6w54ZaPUCfObV2?=
 =?us-ascii?Q?whEnLBAQuR8+sfTtYkWwfZpJ1GrNA2aXSmW2xKbWXFayu/zPTX342vgUq0TI?=
 =?us-ascii?Q?v7zGY9FPelPpXWyuV0DX9/UehcV3Govyl1JMaq/T+33yp3sB3+mFqceoTZYc?=
 =?us-ascii?Q?srIg9ye3/eBV8HiQSabhXnQyja5cc8lUcCz94Hchlwp4tPCQfmmMgbd66ssM?=
 =?us-ascii?Q?Q8nwdNrvZZUe/7+APBA2Ij2RAR/220vTzl/4FF9iKt307emimKpE+bCPR6rz?=
 =?us-ascii?Q?saYecLen4XPvueU9E6jceqB/?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f45274d-c27d-4cba-1080-08d8d9df7d53
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 22:48:37.9653 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28S3sj/AU1IOXRB46VJW1M0rtGXPBgrKlfSVBF22Cxn2vsyb4JG5at9KOdu6s72aDexwfcZ5+GWibq+4slmwJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6163
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 25 Feb 2021 22:48:44 -0000

If facl(2) is called on an AF_LOCAL or AF_UNIX socket that is not a
socket file, the current code calls fhandler_disk_file::facl in most
cases.  The latter expects to be operating on a disk file and uses the
socket's io_handle, which is not a file handle.

Fix this by calling fhandler_disk_file::facl only if the
fhandler_socket object is a file (determined by testing dev().isfs()).
---
 winsup/cygwin/fhandler_socket_local.cc | 6 +++++-
 winsup/cygwin/fhandler_socket_unix.cc  | 8 +++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler_socket_local.cc b/winsup/cygwin/fhandler_socket_local.cc
index 349ade897..22586c0dd 100644
--- a/winsup/cygwin/fhandler_socket_local.cc
+++ b/winsup/cygwin/fhandler_socket_local.cc
@@ -737,8 +737,12 @@ fhandler_socket_local::fchown (uid_t uid, gid_t gid)
 int
 fhandler_socket_local::facl (int cmd, int nentries, aclent_t *aclbufp)
 {
-  if (get_sun_path () && get_sun_path ()[0] == '\0')
+  if (!dev ().isfs ())
+    /* facl called on a socket. */
     return fhandler_socket_wsock::facl (cmd, nentries, aclbufp);
+
+  /* facl on a socket file.  [We won't get here if facl is called on a
+     socket opened w/ O_PATH.] */
   fhandler_disk_file fh (pc);
   return fh.facl (cmd, nentries, aclbufp);
 }
diff --git a/winsup/cygwin/fhandler_socket_unix.cc b/winsup/cygwin/fhandler_socket_unix.cc
index 573864b9f..fae07367d 100644
--- a/winsup/cygwin/fhandler_socket_unix.cc
+++ b/winsup/cygwin/fhandler_socket_unix.cc
@@ -2408,10 +2408,12 @@ fhandler_socket_unix::fchown (uid_t uid, gid_t gid)
 int
 fhandler_socket_unix::facl (int cmd, int nentries, aclent_t *aclbufp)
 {
-  if (sun_path ()
-      && (sun_path ()->un_len <= (socklen_t) sizeof (sa_family_t)
-	  || sun_path ()->un.sun_path[0] == '\0'))
+  if (!dev ().isfs ())
+    /* facl called on a socket. */
     return fhandler_socket::facl (cmd, nentries, aclbufp);
+
+  /* facl on a socket file.  [We won't get here if facl is called on a
+     socket opened w/ O_PATH.] */
   fhandler_disk_file fh (pc);
   return fh.facl (cmd, nentries, aclbufp);
 }
-- 
2.30.0

