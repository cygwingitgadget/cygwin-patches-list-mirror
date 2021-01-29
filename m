Return-Path: <kbrown@cornell.edu>
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2119.outbound.protection.outlook.com [40.107.223.119])
 by sourceware.org (Postfix) with ESMTPS id 715623834421
 for <cygwin-patches@cygwin.com>; Fri, 29 Jan 2021 19:24:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 715623834421
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5q6TR71OZHK0rurCQ31y4FHGgtwWiM7NtWBB018C6qy2f5NCZwBElCvspx2og7ErGkoOwlA89rVtIVQEfYYg67/i5HOXXNuWABSif42M+yIiexxMZtAYnmlg3nvCRmiKW8AOzlbUk+GLWylhTUoW+A/ceggRHstl6ONJFzVJw61N8+CuilrlsHQ03mhcrlxUODy47UOyQjOFDslR2FHrWGMBoZvL4+ifDcpbz4dxP6zK0ukvxWzCWXzI3+gAiBqWpLqW/8xtsgAeYNvdF1Jka+G9YUT4GAll/q56La4njOcke5Y3aRbdkH5kvu/Co9QWthhcJ3H8jg2P7MizDN61A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6+3kGhtjQ8Q3EKMaXNHhIz3irmJN1NOwLLsDjpmr9U=;
 b=JAL5ZXssVGZsWiP7oAAfMNRRQ5q0JIW18IiZLltp1kGn4NSkYF+8a4xL0Rq1zp+QzRy19Le1crUQBN3ySiLRRKUussQLhA/c3HUr/Rl8XAWzKmK2dM7ieMFtiD8mFgm8Fn+lwiPAlmM3Z+HVyT1fEnGhQMS5QAwvKyQiwObI1jCcUR/t2VEp/cUmO/0Frg09sBuHc32Qr/74GdBXt8HgTVxyGy5nSAOWbg4B5S22EVR8PCD2cdtKlMUSUexDFOC/m6c8Jco40NoxrnkunhcQZ4UDpvJyeKZuel8B2wj4pV6Tu2D0kQubytofsyGbGFjfdCtLdBDTCF/8qdBxUZvg2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN8PR04MB5715.namprd04.prod.outlook.com (2603:10b6:408:74::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Fri, 29 Jan
 2021 19:24:47 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%6]) with mapi id 15.20.3784.017; Fri, 29 Jan 2021
 19:24:47 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/4] Cygwin: getdtablesize: always return OPEN_MAX_MAX
Date: Fri, 29 Jan 2021 14:24:18 -0500
Message-Id: <20210129192421.1651-2-kbrown@cornell.edu>
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
 15.20.3805.16 via Frontend Transport; Fri, 29 Jan 2021 19:24:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f469634a-6d93-4e41-8439-08d8c48b8a3b
X-MS-TrafficTypeDiagnostic: BN8PR04MB5715:
X-Microsoft-Antispam-PRVS: <BN8PR04MB5715030602CF2BA839327875D8B99@BN8PR04MB5715.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U2quE6yRQqsDrslazf5ug74OQK2deBiY8nBOsYZzhsJPzMs+GviFckNWkq2OkdXaYF8CEGyTfOtsLTNRUzDqwrzYK2lSFLaSajUSQoTTKrb5I9BKaxsczSaQv1HMTnTUTWsvCvnubcS0owo+j6zedMxHw8905A3L6iOwZNFozU/T3f/z8qxAj097T9ckZZSzIvvv8yKi1gaVycDWKSINZNsunsqo6wKEyeXpjhFVAzG32MqOboghccz0aucA9HNX8lkz5TPQu5dKpKGb3/kUDPzZFLkkIbrNH+Lq98U7FZkihvl59Gu0yXRV/spy9PSXsSudxBCLU374ZgGKkOXEzG1/SjrqxwXl5B80qT+eUHQCurUDO6jqeel3zvr7py2ryg+0NRnMx8a/o8R/takSrnyOWF4SXekQ886IJR3Ytf1JYQDp/X/QDtGQv41vKoKOYZn80IOsSr7vQ4vXn6jF0EXeouh8fsN1mX20Tm2FroAAFfmhzBrToYqUkFv1l+oCHV2GWHnvjUtOxgwojlfUpEi0+v9J6YQuIqRFZ57BvPIkAlvstdAy4Ea8UtDx8bwTr7SCnMsh3oYXXBzjLn79lQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(6512007)(6916009)(16526019)(186003)(36756003)(1076003)(6666004)(8936002)(66946007)(26005)(6486002)(2616005)(956004)(66476007)(52116002)(83380400001)(8676002)(786003)(316002)(2906002)(75432002)(5660300002)(478600001)(69590400011)(86362001)(6506007)(66556008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?lxQFtH2IdeXwl4naFV2MfaQlj8epxPP9QOSnYSl3jdom2uTNCmh5hdPdsifA?=
 =?us-ascii?Q?tOrd3eKsTvTwCGtkDIK4ACE7neDhHsuEEkrLvdyz4SXbs2dPVFbZ/s85k6bv?=
 =?us-ascii?Q?712bs1tvK6wXK1p9YfdhqHtQ4zguzth6Dye5BfAzeEK5tDKMdewjY95K6qSN?=
 =?us-ascii?Q?OjHxg+dtTPPtEA8H6Yrgqmw9hhkU8qsn9mwbo8bcoRCQZsILXWLJjdmSYoLX?=
 =?us-ascii?Q?ehdtcv/dUC3w5KJnb2DTtbYyT9tRYu0nyoMTw33T2GqyjYMrU5v/aIT0Aneo?=
 =?us-ascii?Q?kxCIurTcAmqhK7yEA8t3BIEPLNSbMFrgu5dVvFLIVSg8CdT3Km0ufVjniZOY?=
 =?us-ascii?Q?pse/9a+rLI2/YeI0x33s2BEEHDcpqL674vBvH8oXmhG6jGZhQlAy/srGt6pB?=
 =?us-ascii?Q?roujjKgGwunK43ERj/QzIXndg8yEg20kdW7+egC7lvxMtjWm7H41imVwRxeX?=
 =?us-ascii?Q?/euQ9GqyvPtPZ5LU6b0+YzUNKsf2unkfe+Q5Gr7wWrWTmBtvQW6H++/xi9mo?=
 =?us-ascii?Q?TbcI9HS1N+DG6qH+MfZiuY+6k3brBlymO516S6jFF/xzLyazf1jzxMK1mkh5?=
 =?us-ascii?Q?AzhSKEo+zSyywVTPb8OqPWi0sxvLOYRzsMHKA0BsdT8XUZYVC5HBaZmuSssr?=
 =?us-ascii?Q?uLKyz3Mwkre8Y66ROGXiNKk0l2Rjq9NEqSJ/q+rKuPcOLJUNC33JVplKf7yW?=
 =?us-ascii?Q?4LdAJxHrez5N940jS/faLSTAv1ULP53V7Et8hpHJwIn/9HMmrx8pgb+0I3/s?=
 =?us-ascii?Q?i2cha7LwlPmBh00cfoqLUPatI74Cuiu7qI2WmHARntN+PZfRSTrveNBCShiR?=
 =?us-ascii?Q?PDJFYm+9is8B/Z1b96lFh1Tko6p061pSLQfAA8KKTCHGlG+ViSH+y3GLGZ80?=
 =?us-ascii?Q?6bOqpBi4Hg7cNPGwWMMQ2qy0/uGOI7C/1YZ0N2eCtffMTHnTTgDMWa8fVuZ1?=
 =?us-ascii?Q?CXITdXMV0yVvjUDKGE4YmBlE+rmGolz6vqb3R8St6JpgGwrb3QqTQH7oQaFw?=
 =?us-ascii?Q?iFIqGTNa02u4y3pxzr5lhsoKcG9MJydlcTERYS3WFTJiVm1HKMqs85I8GN0m?=
 =?us-ascii?Q?GTf36Arx?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: f469634a-6d93-4e41-8439-08d8c48b8a3b
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 19:24:47.3908 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4uhE70ZU0fskfsH2Z7R5Dz/0OIObuG0K6LgImuif/eErxwjeKzcslAjnb3eGoE2mzhHbT9craGKgSDvGBPsFlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5715
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Fri, 29 Jan 2021 19:24:54 -0000

According to the Linux man page for getdtablesize(3), the latter is
supposed to return "the maximum number of files a process can have
open, one more than the largest possible value for a file descriptor."
The constant OPEN_MAX_MAX is the only limit enforced by Cygwin, so we
now return that.

Previously getdtablesize returned the current size of cygheap->fdtab,
Cygwin's internal file descriptor table.  But this is a dynamically
growing table, and its current size does not reflect an actual limit
on the number of open files.

With this change, gnulib now reports that getdtablesize and
fcntl(F_DUPFD) work on Cygwin.  Packages like GNU tar that use the
corresponding gnulib modules will no longer use gnulib replacements on
Cygwin.
---
 winsup/cygwin/syscalls.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 82ddad46d..d293ff2c0 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -2887,7 +2887,7 @@ setdtablesize (int size)
 extern "C" int
 getdtablesize ()
 {
-  return cygheap->fdtab.size;
+  return OPEN_MAX_MAX;
 }
 
 extern "C" int
-- 
2.30.0

