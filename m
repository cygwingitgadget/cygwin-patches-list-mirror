Return-Path: <kbrown@cornell.edu>
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2102.outbound.protection.outlook.com [40.107.92.102])
 by sourceware.org (Postfix) with ESMTPS id 214FC3851C3B
 for <cygwin-patches@cygwin.com>; Thu, 20 Aug 2020 14:57:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 214FC3851C3B
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2PKnf6GhXF2qD52gmxyfboMe/bazjBoEYX6tmwU3LJcdJeD3wXhNKE8IgMHZX4OPJvJRauyeP+3FPQ0CTlb66l73tYlHbS5VW+eZ91/lsEWIkddLKfzHAGFtEst1qJ6xCgoIplCyfOWxUuEXyohUPu2JOGpsksSw69d0y7xvkIA86WnRkdipuU5Q2qIqgXlRDH10UJtERrNBHBlimUF01Rwa3I+truAAUzGFLOmXh34Z58GMYcM+sHlBNowl/nA6pjpP+RUICvqdpc6+MlohjGuJVHcDolNc5J1GBskUj1hV3AcM50R+bVWdyvkl3lYmEHiIA2e+2zuLCPiqyyalg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsT48aqxN+ENc+Xy1cnF218yDDB4z8PMZnnFGIpMLtE=;
 b=d4mWdETnnmeeZ0Np8MCs3T8+rWkgPe8uSW6XojArmqxx+8CyFaSuPPtYJwFXMA6HlMzOH4HTloeLjOPvDYxC9a+IT31Xx6T0xZ7rWRUZ1mNlEc/IY+Siq/BCCDYgKBIos8k67mNagRKPl7uZU3rW6bEFNAE1Pgq+Fyg3eV92eGmB3qVJVJQK8BQw6n2ahTnCHjhmuVY9ABjRpTGE/3Wv+hhAy8u7hNeCvlFquXMt1N4EcnqSjiYlcJfr/JdLXKH/x3hs8YU6v3SfHf0UAPz9M1OpaWtZti0LO/Qcbpx94D74Gcy5UakvQ6kE+p4fXmg+ehYfGcDynPngND7f1bWBoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5647.namprd04.prod.outlook.com (2603:10b6:208:3f::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Thu, 20 Aug
 2020 14:57:45 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a%7]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 14:57:45 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/2] Cygwin: add header defining GCC exception codes
Date: Thu, 20 Aug 2020 10:55:59 -0400
Message-Id: <20200820145600.21492-2-kbrown@cornell.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820145600.21492-1-kbrown@cornell.edu>
References: <20200820145600.21492-1-kbrown@cornell.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0051.namprd16.prod.outlook.com
 (2603:10b6:208:234::20) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 MN2PR16CA0051.namprd16.prod.outlook.com (2603:10b6:208:234::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Thu, 20 Aug 2020 14:57:44 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [68.175.129.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 936d82dc-220f-47d3-060d-08d845196564
X-MS-TrafficTypeDiagnostic: MN2PR04MB5647:
X-Microsoft-Antispam-PRVS: <MN2PR04MB5647F2040F2727D73ACAEB1AD85A0@MN2PR04MB5647.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1P5xxMF8kh6uOCvD/NGMrYfyzc2/6pq8edSJaeEthB6zZBVy89m8NPfD8H875QtrRhMIiv+JnW6u3bp5zoSlw7CCko7UzzxMds0EB+iiLEpvAadi8sY3/ilR3N94bmge43DsYjUq2wXJGlI417lREJk18mlJ3+xJDCX88of2SpyDurhSIAAW5rQUAMWKKgMaPh52vQe4+64lT1mwRX7ebNhMbdOpZ55KWkCj8KGNExqxfFxkLd+imJOcGkHBdkjuAx21eqHIKZud7+KmIPfh5Y3OjChaJdXECvkiNyUnfwOI5+JXSPbkzuRt6bNCQzUR4U0ti4k0+cvPWP3HBocJqz3A6a2sF1IyKm1Dr5Vc5rRVgeHBzxvPyIl7ADvnizBE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(36756003)(5660300002)(1076003)(6916009)(16576012)(83380400001)(786003)(316002)(6486002)(110011004)(66556008)(52116002)(478600001)(6666004)(2906002)(75432002)(86362001)(8676002)(26005)(66946007)(8936002)(956004)(2616005)(66476007)(186003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: v+2eK7+IYN3+/XcBkh5rehNPBxXrvGd2nW6q8EEIZlqoP/CiC66MZds8jF61294Z9Rl00hnwCRMfgWWnylfdkqGHCdNxckCPQDkEu0M81vfVzoedhsKOyimuKufsTi6oqQOgz+PijELrVa8HSzPa8qfOxFh65KLNWnx9269IzymCN4RO5PVYxtM+e7kN5aSepc7I8KAJ409Rx2C41Ep4exzNYquLSS/gdfr/XAtCB2hcck0bj7kJN3LJofnLtqfCk81gDFuc2rM3aAYoBOXFrfNbLO74qnE42Glz6VWmbLitRcpLKKGe8fm2mG2vTzxyrJbfVRVAtUNZ1GG7PWdh0kbo8XyZr3E9WrMjF3wqemG18cW42gmZFp3bd4Jqx8qiMTmOzIuONkzieHtPcRtcmCJ7wDXfLI4MH+X+afH23Jjx2oW0+hF7iYIs6/r/+1La/z6DXCsXuKGlaMiW1T1Ba9i5yBpyN+BIT8QzLKL8jbEjmhSr0YZyRAq3v1uCHABIf1UhO25XFbpqm1F7b5Dh3AiXtb+m/PME31nHba6ZJM3zt1wBUyjOyFxFeTrmhpXk7PQL3El0LJbE70rVvj0fRscG+t4JwSzjqjrRcVMJ/kU1hrQtHlG6IyQnF4ceQasdUODwe52Bi7C0Ee0ndO3JFA==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 936d82dc-220f-47d3-060d-08d845196564
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 14:57:45.2447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fmVpjphLc6dSq/P9a+NHSJZYTAyWh+4pJtMR6VdqWQcfTXGYVJnto70MPS8v6ftiqGP4qVZMfJ2a+pyahBTi3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5647
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, MSGID_FROM_MTA_HEADER,
 RCVD_ILLEGAL_IP, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS,
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
X-List-Received-Date: Thu, 20 Aug 2020 14:57:48 -0000

Include it in exceptions.cc instead of defining the exception codes
there.
---
 winsup/cygwin/exceptions.cc | 10 +---------
 winsup/cygwin/gcc_seh.h     | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 9 deletions(-)
 create mode 100644 winsup/cygwin/gcc_seh.h

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 61406e5d1..bb7704f94 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -28,6 +28,7 @@ details. */
 #include "ntdll.h"
 #include "exception.h"
 #include "posix_timer.h"
+#include "gcc_seh.h"
 
 /* Definitions for code simplification */
 #ifdef __x86_64__
@@ -763,15 +764,6 @@ exception::handle (EXCEPTION_RECORD *e, exception_list *frame, CONTEXT *in,
       return ExceptionContinueExecution;
 
 #ifdef __x86_64__
-/* From the GCC source file libgcc/unwind-seh.c. */
-#define STATUS_USER_DEFINED		(1U << 29)
-#define GCC_MAGIC			(('G' << 16) | ('C' << 8) | 'C')
-#define GCC_EXCEPTION(TYPE)		\
-       (STATUS_USER_DEFINED | ((TYPE) << 24) | GCC_MAGIC)
-#define STATUS_GCC_THROW		GCC_EXCEPTION (0)
-#define STATUS_GCC_UNWIND		GCC_EXCEPTION (1)
-#define STATUS_GCC_FORCED		GCC_EXCEPTION (2)
-
     case STATUS_GCC_THROW:
     case STATUS_GCC_UNWIND:
     case STATUS_GCC_FORCED:
diff --git a/winsup/cygwin/gcc_seh.h b/winsup/cygwin/gcc_seh.h
new file mode 100644
index 000000000..fb779ef73
--- /dev/null
+++ b/winsup/cygwin/gcc_seh.h
@@ -0,0 +1,19 @@
+/* gcc_seh.h: GCC exception codes.
+
+This software is a copyrighted work licensed under the terms of the
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+details. */
+
+#pragma once
+
+/* From the GCC source file libgcc/unwind-seh.c. */
+
+#ifdef __x86_64__
+#define STATUS_USER_DEFINED		(1U << 29)
+#define GCC_MAGIC			(('G' << 16) | ('C' << 8) | 'C')
+#define GCC_EXCEPTION(TYPE)		\
+       (STATUS_USER_DEFINED | ((TYPE) << 24) | GCC_MAGIC)
+#define STATUS_GCC_THROW		GCC_EXCEPTION (0)
+#define STATUS_GCC_UNWIND		GCC_EXCEPTION (1)
+#define STATUS_GCC_FORCED		GCC_EXCEPTION (2)
+#endif
-- 
2.28.0

