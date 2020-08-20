Return-Path: <kbrown@cornell.edu>
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2092.outbound.protection.outlook.com [40.107.243.92])
 by sourceware.org (Postfix) with ESMTPS id BBEF4386F465
 for <cygwin-patches@cygwin.com>; Thu, 20 Aug 2020 14:57:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org BBEF4386F465
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQjAIv+zpveT+7anT530hjwa6vu5EYDjixEzcjYs7R9kCAlAHT4r7GD6Ml/lq841DW9tPZigGT3GtCy06h2tHhj1fNtzn+a4xei/UzFYxhcerqwtFga4r5j9iLWVmqx/FrSayCk35JM0ttHgDeSrZrVmoQHlYIHX0Jm2PvsEI15PfNw9Hbke0TkTxA/zYyC7PUlNxO5+dqXkSsdYCnVISGWpJU53IykDry/HYeA25BG8HBjZgGeL2Pr2X/9di9KlSS4OC+RmJpWlVZxe3Ci+8brqvwgkTMDDUECFBpb1u2ireFFguCNPRbVNqcRhzLqxnCa8rWVu9PP5yhMnH6q9DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7rOTcy03rJKWdk7PbNLyXE/AmS+dIPQLGPJwibZKx8=;
 b=Ay7zGpVI3BFKiPCTvQ2cqrxqC5JihRFcKLOD4/ZZzrFnhYs0LL4UUkYkOaXiuPgVEYCu5rtHWotf+dC4JdFzJ0CLekfdxE4opyKd0JQLekGi3LTsLgCtDB85inGXfojqDqs+B2zXNppuKM3lkZtsEGuP9xWhlAoNgySC+aieVlTOnn4JNp3YPYnkiYdNj5uAnZCaM+AzVywW0OIdI/SAgERsi4N63EpG6sNmHyKt0cLbmw4nz7fzjeuzeQgVW5ZUNAhinlbw9ZF1Mbfhs/ZFoDr95HGq6SOgOiJd7hZIkJnRKYiX5QIzo/bx1+tYpyaxdHoaOSv+cpvyCo+kK35uOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5485.namprd04.prod.outlook.com (2603:10b6:208:e2::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Thu, 20 Aug
 2020 14:57:46 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a%7]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 14:57:46 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/2] Cygwin: strace: ignore GCC exceptions
Date: Thu, 20 Aug 2020 10:56:00 -0400
Message-Id: <20200820145600.21492-3-kbrown@cornell.edu>
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
 Transport; Thu, 20 Aug 2020 14:57:45 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [68.175.129.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aafb0d87-b714-4185-d085-08d8451965c1
X-MS-TrafficTypeDiagnostic: MN2PR04MB5485:
X-Microsoft-Antispam-PRVS: <MN2PR04MB54859D43BC3073FD62710C60D85A0@MN2PR04MB5485.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e8At3/qSbGOwx35OpeAOXFLOfkf/i1Jwj/A3nhcK4EhlvG2A+scGrG8qZaavgkkUjEGtmJnZ7QakOJiC34ZzF4jsQa9hiywcvCnNcyxpxRS5g80IgrTOuw5Tu2fDrXuhUNBXBanRgHxnU2ddHNXYtFa4ZV9JilSaK/wqw3E+ShDB4KR+jlN79rRusM8wku1pV0+JCvfvDurD2pQz/7hILR9gGmqSr4wKitTwaVIlEGkUVcZjCgPfeF8pb7aRE+ltIM+FTnpagv1ot0Dq8TOqYHUVd4fpkJv640rMY5PxSzqdLYl3p0WtLxxakE8RIGfHMdONuSW1VmBUem/MHVaInKt3hgOxXgb98lD3stS3rc/Q1dpwTvTzsGyUsO3QEu+m
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(956004)(16576012)(186003)(6916009)(6666004)(52116002)(8676002)(66476007)(26005)(2616005)(6486002)(36756003)(478600001)(66556008)(5660300002)(2906002)(66946007)(86362001)(8936002)(75432002)(1076003)(786003)(110011004)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: wUAx3HaUwnwdVSS6qJVmZHUVLmcYbQX9FUxRD6cPcWGD8/l84wQPim1Qbos9aSkPOxs8QHybULdavKlPkTWf9dfu6jV5IPiTI2Eo8M8oQF71u9zg5WEHOHGJ/yA0j+g3FgWQT2wfj9me2ygOeP0a1noWwX8zbaxLzb/TaHV+KHBeN6z4MMBsMVjjgdmqP9ermvg/NaEjfEVVLu76pgOtg4SYCivFdWx2lnsfQklDPSmZqiVWP1NdyI8V43D67Tdcs1UK39UnQg4XQhW1Kzipx8ZawddraWtTWbQTkEEEMqLu6LaOKGh5iq8rhTqHXxTc+1XNOYszyKZapOEdNFnuKdDWjFMG5FigzosxguEYFm0Nap8xiSFVodnVlnXqjgtlnh3qzTBmAdXIvgcKBIQ1LepL5WUahRAb2Xy0xXFdw4OUKiKDKsHdX7pFb/D7NgYdCo68cocngZwzRPiV5ZnlqimYlG7DCWJ5nDDGEHvKsYZBQcTd9wKqVbZuVXNyM2FRUXuhAgN6jqsuISY90WUoJzI3B/OXpZtDQaXiKrvIF/9e0czJzoZ/lixYszIBedaSkTvjvno51ck4ca+8bcAvN/spzCYWBhuocmWbCHHMab2+Ul8+jcBWF5qz1qBkS3ioHqR/mVbXDnI3boJyGYy7Bw==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: aafb0d87-b714-4185-d085-08d8451965c1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 14:57:45.8703 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BUi3WIAx3Ug1t+/MCHIcGn2L7v2DnmcLXo+OggftxNgGBR+8ZNeG/ogXzjxdCws+XandmK5xsDXFmlyyTh5ALg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5485
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 20 Aug 2020 14:57:49 -0000

Any C++ app that calls 'throw' on 64-bit Cygwin results in an
exception of type STATUS_GCC_THROW (0x20474343) generated by the C++
runtime.  Don't pollute the strace output by printing information
about this and other GCC exceptions.
---
 winsup/utils/strace.cc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/winsup/utils/strace.cc b/winsup/utils/strace.cc
index 9b6569a70..b96ad40c1 100644
--- a/winsup/utils/strace.cc
+++ b/winsup/utils/strace.cc
@@ -25,6 +25,7 @@ details. */
 #include "../cygwin/include/sys/cygwin.h"
 #include "../cygwin/include/cygwin/version.h"
 #include "../cygwin/cygtls_padsize.h"
+#include "../cygwin/gcc_seh.h"
 #include "path.h"
 #undef cygwin_internal
 #include "loadlib.h"
@@ -790,6 +791,13 @@ proc_child (unsigned mask, FILE *ofile, pid_t pid)
 	    case STATUS_BREAKPOINT:
 	    case 0x406d1388:		/* SetThreadName exception. */
 	      break;
+#ifdef __x86_64__
+	    case STATUS_GCC_THROW:
+	    case STATUS_GCC_UNWIND:
+	    case STATUS_GCC_FORCED:
+	      status = DBG_EXCEPTION_NOT_HANDLED;
+	      break;
+#endif
 	    default:
 	      status = DBG_EXCEPTION_NOT_HANDLED;
 	      if (ev.u.Exception.dwFirstChance)
-- 
2.28.0

