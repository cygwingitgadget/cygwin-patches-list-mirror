Return-Path: <kbrown@cornell.edu>
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2119.outbound.protection.outlook.com [40.107.223.119])
 by sourceware.org (Postfix) with ESMTPS id E36A13834421
 for <cygwin-patches@cygwin.com>; Fri, 29 Jan 2021 19:24:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E36A13834421
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Voyg02T1zN4gH4noRB9a8S8epOFR4OtArznddmMx5fyaa/Y2VuqyAQRaPgCGfqPDT+iHju+tBqzXNMG+pBPXHhM6EsyymjeTrq4E83RPsqlZi0XVo5cLGZb9le4C3MDnJqBYwSK6Tj44a9y+Npucs5HH/3K3bb/YjU6GfMIRw8yw2T+QmjFT2syiwBmQJld9kcje07N1qWR3mczaJWWDBMBtc8aiPBkJZ0r3kW1yzi6+nBP2giuB+gcfpA0XErOoqp49oRemOW5seedHsxZS4ix0nnmU6OLfEOXfF2A+zHsbPtmtkbX3Imn/S/D6XDxmlHc/nvpidD3Iq07D5tpTlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6P4+0sMARcH0hMjFBqwDDWXVcc4ywQ07y6CUbjGnNg=;
 b=Hkl6Dr0Q5MzdFcLJe8o290g3KcTuoRYceEwq/IWBs2gO83BZp8oJWKRIE+G+OY8fjZx2moWFWEgsozpJOQ3qhsIFqPwHB+UIV90WAy9nIpbDzb55o5kpYF/XiPb7jG8O3Fv79eFumY4KnqaYgXwnqRwPNz30YckGvgaJLFxprVMEX0KLZ9E4t6VkadtIcK9t51TWWVciObDmkknwxQeosaClMSSYa5xwCk7ME8coGcBru2FpSgt+mnvzwZ9A/XIDNvqpG2V32NBTBcXzC49PfzAmAEdt0PYAUpiiZd8t5ycXd45gwZy1Ea0lZ7wodNcpe8rGrv9/njE5sOfZ1qsVQg==
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
Subject: [PATCH 3/4] Cygwin: remove the OPEN_MAX_MAX macro
Date: Fri, 29 Jan 2021 14:24:20 -0500
Message-Id: <20210129192421.1651-4-kbrown@cornell.edu>
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
 15.20.3805.16 via Frontend Transport; Fri, 29 Jan 2021 19:24:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 838c3311-6784-4426-601a-08d8c48b8b02
X-MS-TrafficTypeDiagnostic: BN8PR04MB5715:
X-Microsoft-Antispam-PRVS: <BN8PR04MB5715876572C526D10A4204BBD8B99@BN8PR04MB5715.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 58VffucE0ILQ2thFygk64vf7TxWWqgSSjE0y1FV4yljTIvz8bL2tamCceBHI+bgKVzKVwpEZzgVGxwpaHfxiccITcnP7cMnIPYlMt0nfZGiljAKMKgAXiFEk7ocyzSejPMFELheFwUeET9mJjRiVwIaSYPdwWNmP7/HHBc/XaTaMlSnYJ0uJw1qyy9SgiST4Zl0fglCQvq7u52WJnQgpeCBP18/BpYylTLilRvgWZ3bqxbCuC28XsFO5+nI4EGCrkzutgZYpNtv+X3gDfBkpyzruoNsavs2UqW0nSU0y2sDowRZsuf8wRvGkaud41lfg2nfkJtZjXzBP02tAzYSHJ1+wGGTOTMabFdXJmJZSoChUsQ8qDTdUbLFlI9l+JERWOeTmW4ZBb9TxmVI6iT/Quy6w9K4aWVyJAnD77XrC9kGZJhTwXzyEFKdCO+GQe/0Vb5PNyh12/sOEK/7BhLN8Belo4lRvRVREAK3cpmK7Q3Bd+IiqRfLMR9LqFtmAT35AU3Dt4oEK8IiwMBKNzDbucrSV9uYpB53iWkogUim5toydBMzJNRu3kN1cB8wa69hge5l1pOWUSvyknAF92tw5Pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(6512007)(6916009)(16526019)(186003)(36756003)(1076003)(6666004)(8936002)(66946007)(26005)(6486002)(2616005)(956004)(66476007)(52116002)(83380400001)(8676002)(786003)(316002)(2906002)(75432002)(5660300002)(478600001)(69590400011)(86362001)(6506007)(66556008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?3RTdlGZswwmTuBaRfaedrwPPe91ayHK+/x9QEbDSXE1bg2MLPkhJOo2k8Ke4?=
 =?us-ascii?Q?2k75J/Ui9+4ql976jSxBJ0hJb6qQKbgXYu/j5bsvXg35kjEflqhzFY4Fmtlj?=
 =?us-ascii?Q?nZSiYwYxANPAKTJ56uCQ1sJZo1JS4DtUsxQiB724roTssd1Dnf7mbuWxi3qn?=
 =?us-ascii?Q?xqmmDkaEmQUbi89FWdH28SqDvUlQuKJz/tFyCPGj9uYGC38moAiVGxTriu8Q?=
 =?us-ascii?Q?o9qms9+xDi6IP9Nx0U7Zz4Fp3dUi1zyxZU1LOeOjzlsHkGqIH0rx5KFTMCcG?=
 =?us-ascii?Q?5C6OgjwIL92z1yukAvGn/YwUj7106ZHJvvjuHfPUzqFB1/BrLypOX1JG3KnI?=
 =?us-ascii?Q?A45GGRWeNzMccMb6JbnTRccxJntQIh8f2OCQGVMxzo6vOmr0IQaGDrhPZtqG?=
 =?us-ascii?Q?nV9zwngDG1Nb47wqgIOh2oGeh0RgCxwLuVpd6QdQUkC/LVH5rgzmZQuhvk2A?=
 =?us-ascii?Q?mg4TV3lYxPj8oSbhsIhb9L7YXA7VZ0bakzxLj+xSNUgtW66zFfwE8ZEoYgoZ?=
 =?us-ascii?Q?Qvz3gc0YRfEK8TQF3STsYG8Bhtn1SKJ5K2dvOkdshs3IFXLYQRkOrgqrn97r?=
 =?us-ascii?Q?ztQO5+5R679feNIoxwuFzg7b19Pa0yKAns8e7yikgXGjJgPJVyLOvENxlmWY?=
 =?us-ascii?Q?LAKQA9ESzMOvRd9UORacCr+eg5yKCp60OsLQbihmB3tIpw4aG/tIsG/HNgOE?=
 =?us-ascii?Q?3KxNovuc1J5rZJJ4PVbwgbQaxJSLry0cgkqy2bqjUmux5t9TVFKIq1oeAbIW?=
 =?us-ascii?Q?ZKFtFOAPNnWeysLhuBJySW4J14V5BDJr4Y3dLXDN2AWKShqha6kB+yvRHQ1Q?=
 =?us-ascii?Q?nsxJBQdvQDegQ1Ec4IHVt9eHu65UpKPVDtSvoGfWAi2WMGfOtwl/2nrxA/Hm?=
 =?us-ascii?Q?tFWGANyazejcquia8tXuYkd+bYRlPurtJRG7J5zhQknMbs1QateFH1iJ5HhB?=
 =?us-ascii?Q?UTXNIc36fYCRyaBmVVaPnJNszISHK6Eni86eKR7x4u4n9bORBTzg2kgkbWSG?=
 =?us-ascii?Q?7zI/iGzOdhPgwA2iKPxzDfO8UwNaRtzdq2HHUAbmhZzTZ++KQ2a8z4vUsaTg?=
 =?us-ascii?Q?zwE160PP?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 838c3311-6784-4426-601a-08d8c48b8b02
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 19:24:48.6511 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rah4ngcRY9LH94YOlu2pfg8TT2kHKjxZQfK2mzX8vcG3rWdsdBqrIOLoHgKIRERktxGy1TN3CM2gBseHiWpvLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5715
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Fri, 29 Jan 2021 19:25:05 -0000

Replace all occurrences of OPEN_MAX_MAX by OPEN_MAX, and define the
latter to be 3200, which was the value of the former.  In view of the
recent change to getdtablesize, there is no longer a need to
distinguish between these two macros.
---
 winsup/cygwin/dtable.cc        | 8 ++++----
 winsup/cygwin/dtable.h         | 2 --
 winsup/cygwin/fcntl.cc         | 2 +-
 winsup/cygwin/include/limits.h | 7 +++----
 winsup/cygwin/resource.cc      | 2 +-
 winsup/cygwin/syscalls.cc      | 8 ++++----
 winsup/cygwin/sysconf.cc       | 2 +-
 7 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
index 9f4210797..ad4b59211 100644
--- a/winsup/cygwin/dtable.cc
+++ b/winsup/cygwin/dtable.cc
@@ -74,10 +74,10 @@ dtable::extend (size_t howmuch, size_t min)
   size_t new_size = size + howmuch;
   fhandler_base **newfds;
 
-  if (new_size <= OPEN_MAX_MAX)
+  if (new_size <= OPEN_MAX)
     /* ok */;
-  else if (size < OPEN_MAX_MAX && min < OPEN_MAX_MAX)
-    new_size = OPEN_MAX_MAX;
+  else if (size < OPEN_MAX && min < OPEN_MAX)
+    new_size = OPEN_MAX;
   else
     {
       set_errno (EMFILE);
@@ -735,7 +735,7 @@ dtable::dup3 (int oldfd, int newfd, int flags)
       set_errno (EBADF);
       goto done;
     }
-  if (newfd >= OPEN_MAX_MAX || newfd < 0)
+  if (newfd >= OPEN_MAX || newfd < 0)
     {
       syscall_printf ("new fd out of bounds: %d", newfd);
       set_errno (EBADF);
diff --git a/winsup/cygwin/dtable.h b/winsup/cygwin/dtable.h
index 0f745a75a..e1a8461b8 100644
--- a/winsup/cygwin/dtable.h
+++ b/winsup/cygwin/dtable.h
@@ -10,8 +10,6 @@ details. */
 
 /* Initial and increment values for cygwin's fd table */
 #define NOFILE_INCR    32
-/* Maximum size we allow expanding to.  */
-#define OPEN_MAX_MAX (100 * NOFILE_INCR)
 
 #include "thread.h"
 #include "sync.h"
diff --git a/winsup/cygwin/fcntl.cc b/winsup/cygwin/fcntl.cc
index 9ef7e521f..507ba61f7 100644
--- a/winsup/cygwin/fcntl.cc
+++ b/winsup/cygwin/fcntl.cc
@@ -57,7 +57,7 @@ fcntl64 (int fd, int cmd, ...)
 	{
 	case F_DUPFD:
 	case F_DUPFD_CLOEXEC:
-	  if (arg >= 0 && arg < OPEN_MAX_MAX)
+	  if (arg >= 0 && arg < OPEN_MAX)
 	    {
 	      int flags = cmd == F_DUPFD_CLOEXEC ? O_CLOEXEC : 0;
 	      res = cygheap->fdtab.dup3 (fd, cygheap_fdnew ((arg) - 1), flags);
diff --git a/winsup/cygwin/include/limits.h b/winsup/cygwin/include/limits.h
index 6a55578f3..497d45419 100644
--- a/winsup/cygwin/include/limits.h
+++ b/winsup/cygwin/include/limits.h
@@ -208,12 +208,11 @@ details. */
 #undef MQ_PRIO_MAX
 #define MQ_PRIO_MAX INT_MAX
 
-/* # of open files per process. Actually it can be more since Cygwin
-   grows the dtable as necessary. We define a reasonable limit here
-   which is returned by getdtablesize(), sysconf(_SC_OPEN_MAX) and
+/* # of open files per process.  This limit is returned by
+   getdtablesize(), sysconf(_SC_OPEN_MAX), and
    getrlimit(RLIMIT_NOFILE). */
 #undef OPEN_MAX
-#define OPEN_MAX 256
+#define OPEN_MAX 3200
 
 /* Size in bytes of a page. */
 #undef PAGESIZE
diff --git a/winsup/cygwin/resource.cc b/winsup/cygwin/resource.cc
index ac56acf8c..97777e9d2 100644
--- a/winsup/cygwin/resource.cc
+++ b/winsup/cygwin/resource.cc
@@ -182,7 +182,7 @@ getrlimit (int resource, struct rlimit *rlp)
 	  __get_rlimit_stack (rlp);
 	  break;
 	case RLIMIT_NOFILE:
-	  rlp->rlim_cur = rlp->rlim_max = OPEN_MAX_MAX;
+	  rlp->rlim_cur = rlp->rlim_max = OPEN_MAX;
 	  break;
 	case RLIMIT_CORE:
 	  rlp->rlim_cur = cygheap->rlim_core;
diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index d293ff2c0..52a020f07 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -143,7 +143,7 @@ extern "C" int
 dup2 (int oldfd, int newfd)
 {
   int res;
-  if (newfd >= OPEN_MAX_MAX || newfd < 0)
+  if (newfd >= OPEN_MAX || newfd < 0)
     {
       set_errno (EBADF);
       res = -1;
@@ -164,7 +164,7 @@ extern "C" int
 dup3 (int oldfd, int newfd, int flags)
 {
   int res;
-  if (newfd >= OPEN_MAX_MAX)
+  if (newfd >= OPEN_MAX)
     {
       set_errno (EBADF);
       res = -1;
@@ -2878,7 +2878,7 @@ setdtablesize (int size)
     }
 
   if (size <= (int) cygheap->fdtab.size
-      || cygheap->fdtab.extend (size - cygheap->fdtab.size, OPEN_MAX_MAX))
+      || cygheap->fdtab.extend (size - cygheap->fdtab.size, OPEN_MAX))
     return 0;
 
   return -1;
@@ -2887,7 +2887,7 @@ setdtablesize (int size)
 extern "C" int
 getdtablesize ()
 {
-  return OPEN_MAX_MAX;
+  return OPEN_MAX;
 }
 
 extern "C" int
diff --git a/winsup/cygwin/sysconf.cc b/winsup/cygwin/sysconf.cc
index d5d82bb4a..70cdb0fbd 100644
--- a/winsup/cygwin/sysconf.cc
+++ b/winsup/cygwin/sysconf.cc
@@ -511,7 +511,7 @@ static struct
   {cons, {c:CHILD_MAX}},		/*   1, _SC_CHILD_MAX */
   {cons, {c:CLOCKS_PER_SEC}},		/*   2, _SC_CLK_TCK */
   {cons, {c:NGROUPS_MAX}},		/*   3, _SC_NGROUPS_MAX */
-  {cons, {c:OPEN_MAX_MAX}},		/*   4, _SC_OPEN_MAX */
+  {cons, {c:OPEN_MAX}},		/*   4, _SC_OPEN_MAX */
   {cons, {c:_POSIX_JOB_CONTROL}},	/*   5, _SC_JOB_CONTROL */
   {cons, {c:_POSIX_SAVED_IDS}},		/*   6, _SC_SAVED_IDS */
   {cons, {c:_POSIX_VERSION}},		/*   7, _SC_VERSION */
-- 
2.30.0

