Return-Path: <kbrown@cornell.edu>
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2119.outbound.protection.outlook.com [40.107.223.119])
 by sourceware.org (Postfix) with ESMTPS id 66E2D3834421
 for <cygwin-patches@cygwin.com>; Fri, 29 Jan 2021 19:25:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 66E2D3834421
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cw77n67fD3i4TgDIV1EsBkZ1lDfIBvJq0k7cPnGD01f1QnS/QZkMDJvpYWogJjF2c8J7AD8RbzLav5u1oaFXyKtb22W7yWKE7eI7NcM3pyzF/jqtW2/FzDBLlc+umnHfhiKPMN/ySrwnXOy3ecqxFvUctpq1VB8862O32pWiDr/FZCRo/5BZLDnKicRR7+eTfJhmrV+oFIp1Mhf89q84Dm59xAXSjSmtSps23KBUncvcfS6stuw64uNPAAU7d+IPCBFfpT9i1re5Ci+bSw/4X1PXF7jBJxz1rF6BZcHNmIqijW/oGx2MB7AeiC0YTvlgqBJiZNk+HCqG2G5cq0hQqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wCUaDfcAwU6EJjb+9TxT/fGmUElZa2AFLhNIS+ZrLE=;
 b=Y36TgMhImXT4O4AcC7NMcVhNZedrJWnuGuW6XeaSv11fTPj3wtHzgRGWZehPsPoGoJjLclXoMwp9uubV0uFhSwgWPmn/2vdjyKCmu2djShqAchB6OZJbwS7ggHa6gu6x5vrdjSuBwFo3JESq9S0eF97sOdVArFIAcPVt15+rIPGfhas0zxkabBfDYz6u9C/ZLdUPm0PkJuWtP696Tb5Kw5OVNICCH/UJuUcw5FRsHLv4aUFSxtB0P5mNND5QSqb2R4/H9nf0Yc++3vy/2POhz9cZl0Weia4DB2CyW/A1m9bYJc/OvMmwBw3ovaOVyl3LJWzVeoMhRNcWNvmNLmT4Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN8PR04MB5715.namprd04.prod.outlook.com (2603:10b6:408:74::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Fri, 29 Jan
 2021 19:24:49 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%6]) with mapi id 15.20.3784.017; Fri, 29 Jan 2021
 19:24:49 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 4/4] Cygwin: include/cygwin/limits.h: new header
Date: Fri, 29 Jan 2021 14:24:21 -0500
Message-Id: <20210129192421.1651-5-kbrown@cornell.edu>
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
X-MS-Office365-Filtering-Correlation-Id: 67afb9de-d1e9-4644-4854-08d8c48b8b5b
X-MS-TrafficTypeDiagnostic: BN8PR04MB5715:
X-Microsoft-Antispam-PRVS: <BN8PR04MB5715F6801A82B1688ACD94D9D8B99@BN8PR04MB5715.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Mf7RwGxXay9ymckAKHCrKZcVw6DHaE1vgewJopS6MubDS9TLe3c/LX5EXR4qAjPaCuWH2UHIG23Y6P9m6wLfIDmVrG7twki/OpNUy7zRo1Db/q0S0ArGJSUVY5bib1TqSNdPP7csC6yuN7NQQbnhnipY0WhdP5c7jZ45CA792jgd75RAqDIexDmnSU3A8g18mfBSiJlJ847jYg74agletA+CcEPigfKiNi0Wwn3a+hGU2psxTro2QEMpDFOlkVsIwzO+KHdyYTqwcUwm6F/VAy4mLgXbsmSw8hGlpo7NFuTVIgFPdZBKrD9a4rGbhvri4cRmOYVMmF+aMdVna1vDurb3GLvEBxJhwJpo/XIg8JwawZ9e2+PEKnurdMbBuv5roI4lXwWhKs5lfKy1p/3u9no/Or18lR5j6wozPHxvhgqB6OVBYMpKxsGAdxSDRiOAv4vyoYYzmAcrudbwjythiubwVqsveeu/XTV148YyLv1EORWOBYhYuUF8gz9k4fdGczbqlQYQ5ojVgv23urmf81xRrx0tAYEF/Iuhic3IcSzpweyAT44SOL75D1OPz9VocFr3ZJYd5pLGWKAg/uMgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(6512007)(6916009)(16526019)(186003)(36756003)(1076003)(6666004)(8936002)(66946007)(26005)(6486002)(2616005)(956004)(30864003)(66476007)(52116002)(83380400001)(8676002)(786003)(316002)(2906002)(75432002)(5660300002)(478600001)(69590400011)(86362001)(6506007)(66556008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/cvPEUTgz5B29jcw1ZCmbdkkgnhgD/36doZ9QX6WfdtcRwkPUPJMCVe1SFXJ?=
 =?us-ascii?Q?vsmYoHrAAVyIId7Pb7F3C5BteB3d7CceqmaAVaAe08Vvim9hik+ctZgSEQW1?=
 =?us-ascii?Q?ymhqnltBh2Y5vQSuF323XOkJ21y1FOo9fztNUBJBz7yp+C9ZfReoujtsV916?=
 =?us-ascii?Q?qmRwJcjs/8sRED3uaU2Yr5uILFcBNXelkMduEkRcZ2RcQyrJIpMJbhmqtm6Y?=
 =?us-ascii?Q?DJcEQuPREQqjbVpgxrBPnlw8nHHJfqhC5vEMnCcq5lGvwoArG6N1Uft9HP1Y?=
 =?us-ascii?Q?ETKfzG8XxU3B3VC4rG1SwSy1tKZa7QogbpPOC57gzn3ibjLI3eyTIsND1SX3?=
 =?us-ascii?Q?6eW5CJNLhGJOj3NifxedkJUeNtMa1qregPJNxocctWAO8RMgK/7eNpw/ADH3?=
 =?us-ascii?Q?qTu1wEX0HbTuMMyVbO5EBrVfjSjOrIbzWpA86yKvMiSzd/SuvOD2wF86l2Oi?=
 =?us-ascii?Q?Psf6wB8gVQr+gv9UVBSjcPMXDeDwPv9DtL+3FoQij5qVnqdfvnZFeQJCtHGP?=
 =?us-ascii?Q?taKU95t4HAraXPLMZxXQh/2PrgsZ3jc35+fE1OJ/GPoAnPEv1LSGt3QAWwib?=
 =?us-ascii?Q?wewPbML3uzA9iN/iZqSzHxACiyfypBgn0euHwGiZh2NUk61ohkFoXniXGJQP?=
 =?us-ascii?Q?712Zqdz5ZZBpAZDSv7wrHMfBH2MtoL4O7e693T6UF7JL5co4/H0uXXS56EMP?=
 =?us-ascii?Q?4M5iV9W5w0xSplGT9/6o7rm3NGsP2CgGEU9ChyNY73PAS22dQnGc9IdZwxH1?=
 =?us-ascii?Q?0s45LTgoovnBx02jdTckxNl4x33t0j9aLXqhwV9IqmUb83Z0B8UlaxDuihdq?=
 =?us-ascii?Q?5wbGXQG5Ep3RbC0kH65ivus1o7lTmBaZ6SpvE94hKAyFKDKpbRbPNskzfVWG?=
 =?us-ascii?Q?m6hA4EJab0u+Fbc+k3b8lBkepvT8CRfZVqMXSOy8PBVbnN8l7ws18Wo+LrpI?=
 =?us-ascii?Q?itdUfNduCgBSYhFCLPgIbjWdGjWYyhTjoeGEr6/1I2MZKmZVfik/dey/3vTi?=
 =?us-ascii?Q?HYafp3rXG0nWR0L9s9HIRM15euoyBXXZ+wzXcF+a68sounOG8HQrBc50FhRU?=
 =?us-ascii?Q?tg5aZ4cc?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 67afb9de-d1e9-4644-4854-08d8c48b8b5b
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 19:24:49.2247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OeHEhLFVmCzOdMv+4pMB00RwSDxO9hFKF/MFc9lQwZvdQwicj9XQW+KizXB97QkOsnYJ/DwKvWggfyv0NIiiPA==
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
X-List-Received-Date: Fri, 29 Jan 2021 19:25:11 -0000

The new header defines some Cygwin-specific limits, using private
names.  It is included by include/limits.h.

For example, we now have

  #define __OPEN_MAX 3200

in include/cygwin/limits.h and

  #define OPEN_MAX __OPEN_MAX

in include/limits.h.  The purpose is to hide implementation details
from users who view <limits.h>.
---
 winsup/cygwin/include/cygwin/limits.h | 65 ++++++++++++++++++++++
 winsup/cygwin/include/limits.h        | 80 +++++++++++----------------
 2 files changed, 98 insertions(+), 47 deletions(-)
 create mode 100644 winsup/cygwin/include/cygwin/limits.h

diff --git a/winsup/cygwin/include/cygwin/limits.h b/winsup/cygwin/include/cygwin/limits.h
new file mode 100644
index 000000000..f005d5742
--- /dev/null
+++ b/winsup/cygwin/include/cygwin/limits.h
@@ -0,0 +1,65 @@
+/* cygwin/limits.h
+
+This file is part of Cygwin.
+
+This software is a copyrighted work licensed under the terms of the
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+details. */
+
+#ifndef _CYGWIN_LIMITS_H__
+#define _CYGWIN_LIMITS_H__
+
+#define __AIO_LISTIO_MAX 32
+#define __AIO_MAX 8
+#define __AIO_PRIO_DELTA_MAX 0
+
+/* 32000 is the safe value used for Windows processes when called from
+   Cygwin processes. */
+#define __ARG_MAX 32000
+#define __ATEXIT_MAX 32
+#define __CHILD_MAX 256
+#define __DELAYTIMER_MAX __INT_MAX__
+#define __HOST_NAME_MAX 255
+#define __IOV_MAX 1024
+#define __LOGIN_NAME_MAX 256	/* equal to UNLEN defined in w32api/lmcons.h */
+#define __MQ_OPEN_MAX 256
+#define __MQ_PRIO_MAX INT_MAX
+#define __OPEN_MAX 3200		/* value of the old OPEN_MAX_MAX */
+#define __PAGESIZE 65536
+#define __PTHREAD_DESTRUCTOR_ITERATIONS 4
+
+/* Tls has 1088 items - and we don't want to use them all :] */
+#define __PTHREAD_KEYS_MAX 1024
+/* Actually the minimum stack size is somewhat of a split personality.
+   The size parameter in a CreateThread call is the size of the initially
+   commited stack size, which can be specified as low as 4K.  However, the
+   default *reserved* stack size is 1 Meg, unless the .def file specifies
+   another STACKSIZE value.  And even if you specify a stack size below 64K,
+   the allocation granularity is in the way.  You can never squeeze multiple
+   threads in the same allocation granularity slot.  Oh well. */
+#define __PTHREAD_STACK_MIN 65536
+
+/* FIXME: We only support one realtime signal in 32 bit mode, but
+	 _POSIX_RTSIG_MAX is 8. */
+#if __WORDSIZE == 64
+#define __RTSIG_MAX 33
+#else
+#define __RTSIG_MAX 1
+#endif
+#define __SEM_VALUE_MAX 1147483648
+#define __SIGQUEUE_MAX 32
+#define __STREAM_MAX 20
+#define __SYMLOOP_MAX 10
+#define __TIMER_MAX 32
+#define __TTY_NAME_MAX 32
+#define __FILESIZEBITS 64
+#define __LINK_MAX 1024
+#define __MAX_CANON 255
+#define __MAX_INPUT 255
+#define __NAME_MAX 255
+
+/* Keep in sync with __PATHNAME_MAX__ in cygwin/config.h */
+#define __PATH_MAX 4096
+#define __PIPE_BUF 4096
+
+#endif /* _CYGWIN_LIMITS_H__ */
diff --git a/winsup/cygwin/include/limits.h b/winsup/cygwin/include/limits.h
index 497d45419..6bdc9b40b 100644
--- a/winsup/cygwin/include/limits.h
+++ b/winsup/cygwin/include/limits.h
@@ -10,6 +10,7 @@ details. */
 
 #include <features.h>
 #include <bits/wordsize.h>
+#include <cygwin/limits.h>
 
 #ifndef _MACH_MACHLIMITS_H_
 
@@ -156,67 +157,66 @@ details. */
 
 /* Maximum number of I/O operations in a single list I/O call supported by
    the implementation. */
-#define AIO_LISTIO_MAX 32
+#define AIO_LISTIO_MAX __AIO_LISTIO_MAX
 
 /* Maximum number of outstanding asynchronous I/O operations supported by
    the implementation. */
-#define AIO_MAX 8
+#define AIO_MAX __AIO_MAX
 
 /* The maximum amount by which a process can decrease its asynchronous I/O
    priority level from its own scheduling priority. Not yet implemented. */
-#define AIO_PRIO_DELTA_MAX 0
+#define AIO_PRIO_DELTA_MAX __AIO_PRIO_DELTA_MAX
 
 /* Maximum number of bytes in arguments and environment passed in an exec
-   call.  32000 is the safe value used for Windows processes when called
-   from Cygwin processes. */
+   call. */
 #undef ARG_MAX
-#define ARG_MAX 32000
+#define ARG_MAX __ARG_MAX
 
 #if __XSI_VISIBLE || __POSIX_VISIBLE >= 200809
 /* Maximum number of functions that may be registered with atexit(). */
 #undef ATEXIT_MAX
-#define ATEXIT_MAX 32
+#define ATEXIT_MAX __ATEXIT_MAX
 #endif
 
 /* Maximum number of simultaneous processes per real user ID. */
 #undef CHILD_MAX
-#define CHILD_MAX 256
+#define CHILD_MAX __CHILD_MAX
 
 /* Maximum number of timer expiration overruns.  Not yet implemented. */
 #undef DELAYTIMER_MAX
-#define DELAYTIMER_MAX __INT_MAX__
+#define DELAYTIMER_MAX __DELAYTIMER_MAX
 
 /* Maximum length of a host name. */
 #undef HOST_NAME_MAX
-#define HOST_NAME_MAX 255
+#define HOST_NAME_MAX __HOST_NAME_MAX
 
 #if __XSI_VISIBLE
 /* Maximum number of iovcnt in a writev (an arbitrary number) */
 #undef IOV_MAX
-#define IOV_MAX 1024
+#define IOV_MAX __IOV_MAX
 #endif
 
 /* Maximum number of characters in a login name. */
 #undef LOGIN_NAME_MAX
-#define LOGIN_NAME_MAX 256	/* equal to UNLEN defined in w32api/lmcons.h */
+#define LOGIN_NAME_MAX __LOGIN_NAME_MAX
 
 /* The maximum number of open message queue descriptors a process may hold. */
 #undef MQ_OPEN_MAX
-#define MQ_OPEN_MAX OPEN_MAX
+#define MQ_OPEN_MAX __MQ_OPEN_MAX
 
 /* The maximum number of message priorities supported by the implementation. */
 #undef MQ_PRIO_MAX
-#define MQ_PRIO_MAX INT_MAX
+#define MQ_PRIO_MAX __MQ_PRIO_MAX
 
 /* # of open files per process.  This limit is returned by
    getdtablesize(), sysconf(_SC_OPEN_MAX), and
    getrlimit(RLIMIT_NOFILE). */
 #undef OPEN_MAX
-#define OPEN_MAX 3200
+#define OPEN_MAX __OPEN_MAX
 
 /* Size in bytes of a page. */
 #undef PAGESIZE
-#define PAGESIZE 65536
+#define PAGESIZE __PAGESIZE
 #if __XSI_VISIBLE
 #undef PAGE_SIZE
 #define PAGE_SIZE PAGESIZE
@@ -225,23 +225,15 @@ details. */
 /* Maximum number of attempts made to destroy a thread's thread-specific
    data values on thread exit. */
 #undef PTHREAD_DESTRUCTOR_ITERATIONS
-#define PTHREAD_DESTRUCTOR_ITERATIONS 4
+#define PTHREAD_DESTRUCTOR_ITERATIONS __PTHREAD_DESTRUCTOR_ITERATIONS
 
 /* Maximum number of data keys that can be created by a process. */
-/* Tls has 1088 items - and we don't want to use them all :] */
 #undef PTHREAD_KEYS_MAX
-#define PTHREAD_KEYS_MAX 1024
+#define PTHREAD_KEYS_MAX __PTHREAD_KEYS_MAX
 
 /* Minimum size in bytes of thread stack storage. */
-/* Actually the minimum stack size is somewhat of a split personality.
-   The size parameter in a CreateThread call is the size of the initially
-   commited stack size, which can be specified as low as 4K.  However, the
-   default *reserved* stack size is 1 Meg, unless the .def file specifies
-   another STACKSIZE value.  And even if you specify a stack size below 64K,
-   the allocation granularity is in the way.  You can never squeeze multiple
-   threads in the same allocation granularity slot.  Oh well. */
 #undef PTHREAD_STACK_MIN
-#define PTHREAD_STACK_MIN 65536
+#define PTHREAD_STACK_MIN __PTHREAD_STACK_MIN
 
 /* Maximum number of threads that can be created per process. */
 /* Windows allows any arbitrary number of threads per process. */
@@ -249,14 +241,8 @@ details. */
 /* #define PTHREAD_THREADS_MAX unspecified */
 
 /* Maximum number of realtime signals reserved for application use. */
-/* FIXME: We only support one realtime signal in 32 bit mode, but
-	 _POSIX_RTSIG_MAX is 8. */
 #undef RTSIG_MAX
-#if __WORDSIZE == 64
-#define RTSIG_MAX 33
-#else
-#define RTSIG_MAX 1
-#endif
+#define RTSIG_MAX __RTSIG_MAX
 
 /* Maximum number of semaphores that a process may have. */
 /* Windows allows any arbitrary number of semaphores per process. */
@@ -265,12 +251,12 @@ details. */
 
 /* The maximum value a semaphore may have. */
 #undef SEM_VALUE_MAX
-#define SEM_VALUE_MAX 1147483648
+#define SEM_VALUE_MAX __SEM_VALUE_MAX
 
 /* Maximum number of queued signals that a process may send and have pending
    at the receiver(s) at any time. */
 #undef SIGQUEUE_MAX
-#define SIGQUEUE_MAX 32
+#define SIGQUEUE_MAX __SIGQUEUE_MAX
 
 /* The maximum number of replenishment operations that may be simultaneously
    pending for a particular sporadic server scheduler.  Not implemented. */
@@ -279,15 +265,15 @@ details. */
 
 /* Number of streams that one process can have open at one time. */
 #undef STREAM_MAX
-#define STREAM_MAX 20
+#define STREAM_MAX __STREAM_MAX
 
 /* Maximum number of nested symbolic links. */
 #undef SYMLOOP_MAX
-#define SYMLOOP_MAX 10
+#define SYMLOOP_MAX __SYMLOOP_MAX
 
 /* Maximum number of timer expiration overruns. */
 #undef TIMER_MAX
-#define TIMER_MAX 32
+#define TIMER_MAX __TIMER_MAX
 
 /* Maximum length of the trace event name.  Not implemented. */
 #undef TRACE_EVENT_NAME_MAX
@@ -311,7 +297,7 @@ details. */
 
 /* Maximum number of characters in a tty name. */
 #undef TTY_NAME_MAX
-#define TTY_NAME_MAX 32
+#define TTY_NAME_MAX __TTY_NAME_MAX
 
 /* Maximum number of bytes supported for the name of a timezone (not of the TZ variable).  Not implemented. */
 #undef TZNAME_MAX
@@ -322,35 +308,35 @@ details. */
 
 /* Minimum bits needed to represent the maximum size of a regular file. */
 #undef FILESIZEBITS
-#define FILESIZEBITS 64
+#define FILESIZEBITS __FILESIZEBITS
 
 /* Maximum number of hardlinks to a file. */
 #undef LINK_MAX
-#define LINK_MAX 1024
+#define LINK_MAX __LINK_MAX
 
 /* Maximum number of bytes in a terminal canonical input line. */
 #undef MAX_CANON
-#define MAX_CANON 255
+#define MAX_CANON __MAX_CANON
 
 /* Minimum number of bytes available in a terminal input queue. */
 #undef MAX_INPUT
-#define MAX_INPUT 255
+#define MAX_INPUT __MAX_INPUT
 
 /* Maximum length of a path component. */
 #undef NAME_MAX
-#define NAME_MAX 255
+#define NAME_MAX __NAME_MAX
 
 /* Maximum length of a path given to API functions including trailing NUL.
    Deliberately set to the same default value as on Linux.  Internal paths
    may be longer. */
 /* Keep in sync with __PATHNAME_MAX__ in cygwin/config.h */
 #undef PATH_MAX
-#define PATH_MAX 4096
+#define PATH_MAX __PATH_MAX
 
 /* # of bytes in a pipe buf. This is the max # of bytes which can be
    written to a pipe in one atomic operation. */
 #undef PIPE_BUF
-#define PIPE_BUF 4096
+#define PIPE_BUF __PIPE_BUF
 
 /* Minimum number of bytes of storage actually allocated for any portion
    of a file.  Not implemented. */
-- 
2.30.0

