Return-Path: <kbrown@cornell.edu>
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2118.outbound.protection.outlook.com [40.107.243.118])
 by sourceware.org (Postfix) with ESMTPS id 7B0EA3857808
 for <cygwin-patches@cygwin.com>; Tue, 29 Sep 2020 22:08:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 7B0EA3857808
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKKPP0yX3SP6/sbcTlJC1ZTkhapbrrVZrP2swsFCR6ZabZXUaj3rgOoNGwDuzvMzgNmeFKaVjpxQhNiZNoDcaAuAeRs5VEgpEOwDKmVDIZHpM2vavipXj2vMmiRU1AOOdKCl0e5HqXx2DqiqhFDe7Mp1hxasKPa22IhiZSqOEU7Gr5rdGtWDacQCyZ53BQAQB+d/doOEUMkCX5IWDKbqZ0fEDyVJ7VUXyhab6kbYo6Ckjd1dBWBP6zwF7s1CPbAeKW3DdUYfTrrn2nf7Lu9uEAlzykH0mknG8EUlnVwhntN6/Ib9VasKF+wE1hvQfPGg9HcoVSXlvrmMY9IlmmVrKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xITZBvszE6TDfJLlqxTVvtLRCRC78hvgGYdWIbhn2Jc=;
 b=dmI1b0Ze7+b3XcMquJFPCbFusIo5KGnmPBbKxaPqUYaCdWPyktQLqHj6ZrikHKFyk5r4Hgxj69GrzuPILieiptiJNtfcmrGywfax3/9Po3TB9NMBqSc9yMyl6EvEihElM+5DXCgF3pkz0gylJ9iKgcmZU4QIxxDIlXhg0F+xXQZc/e0j3EwqBmZvwMPN5nUo1YgkfG3LfnwvXz5j3blZvdI/XvSL1GU9Q+CrTWcUvzQ97seWloqBKQaXM7kPuQGpQaz2oPAA/4OS78YFEy4J4M9oE4AzqPre5ioPQgR3IPpI7pVJ2Th7ZcRnp1QWsmhWNQiFHPiCvxGnaqhga9dpBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5486.namprd04.prod.outlook.com (2603:10b6:208:e4::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Tue, 29 Sep
 2020 22:08:22 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44%7]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 22:08:22 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/3] Cygwin: AF_UNIX: use FILE_OPEN_REPARSE_POINT when needed
Date: Tue, 29 Sep 2020 18:08:00 -0400
Message-Id: <20200929220802.9980-2-kbrown@cornell.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200929220802.9980-1-kbrown@cornell.edu>
References: <20200929220802.9980-1-kbrown@cornell.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2604:6000:b407:7f00:f15c:4f14:d254:947b]
X-ClientProxiedBy: MN2PR15CA0031.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::44) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2604:6000:b407:7f00:f15c:4f14:d254:947b)
 by MN2PR15CA0031.namprd15.prod.outlook.com (2603:10b6:208:1b4::44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend
 Transport; Tue, 29 Sep 2020 22:08:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f752768-7b42-4885-328b-08d864c42de7
X-MS-TrafficTypeDiagnostic: MN2PR04MB5486:
X-Microsoft-Antispam-PRVS: <MN2PR04MB54861316968B2926EE8FDBDAD8320@MN2PR04MB5486.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uzV9sxw7uYrtGC4zWpFN0C9IiQVOW2fu+7/8tLe1mBYZQmkxU3opxmVaXqn3yzDLPYayHEZV83a1ABRe3gRKRW3It8PYEmJSvXXcUBMQckCuHujaNb9BIYhdg83pCtKW/cgx8NxPA6oiCtipTvCbjdH7Bnp02pYHGecNnEvWxtgZbbpL9InefaESdRzRF2xV+rrwAHunpWSTIpvUAIrVveUzVXZCXapACE5fJ0vnMXwi2RPqzUXsF6KTnBdsNR3ysxqNznWyyt793NspZlem7OltcIwdTagAy5DaYuZDmbsvxphfVjlITdRLeevPfRFMazHn+YKBj14uvhy2Mc8DCPA2ahRbQ0y+kFdFMDEr0E300pIIsDx6X45FfmeaHKNijQMjcI6kyadXJ/hO8WUfYi4plh0JL4Rzy48kLLZHZlIefssHdN11gEiigNArH9Tz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(366004)(376002)(396003)(39850400004)(83380400001)(75432002)(16526019)(8936002)(8676002)(2616005)(186003)(6916009)(1076003)(6486002)(5660300002)(66556008)(66476007)(69590400008)(6666004)(478600001)(6506007)(36756003)(66946007)(2906002)(52116002)(6512007)(316002)(86362001)(786003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: duKTntkee6DiaB+V3BYyFgLxo7bhMwAapJE6JqOIyZ6WGesFsiNerzYmFLeDkFRwl91/TK/NfRtXpZu0sT+Yf8KwFq5s+5tUeFYnDmg50w4qsTZMPU3rM7r7rp1LUKj4UESgqCqQ7Iw0mSVrWPNbobP06Q3EGd64gJNb9wvvW1n+1ND5uIzGSczPMqTPwzEimpyLhZfIHIwOcgCES37/Gwzs7XnjuqXya9prZkXEiMVDIMRMDBDmIltIvdBnDv7RjAOKbsW2wpRxPPnQBphlK3Xln65o7Qup+x44gjGN49/LmR/qrc2oEmi0FxMkuS5EhaTEq6G/9uxVu+AbBGVKLRQ9Ya02wM4MOz98PRK5pMNReuOcCDIKmRZ8anXpUv+NIYFtroHw1qEMEzyxWvPGjUU7zDQmR36Q5iVK1VJPrOIc+GGw2UtSr0HQcQTcDyarS/CQ4wNuXVnDNSi8+t90B4uBbLfrA0t9kzAbnuhhp0eMdNjxVJovA7fcw6eTRW8PvHKuE6oxwzIvfiAYUL2gGRN8Hbp6XlWEjEc1gdcg7yBE7tDRWYpVX4PrscW55bCgzTv9V62ReRio8hIT3zvm7O0sBwdFIXH64Cwl6ws0I54bm8misuqESmCKGiIsBMrcE6CkGbz4qm9jd/ZKW+zn7lgVB+q0c/gIICuRlr4ol/rcTyiUgD6NvFyCLSSTHqN6HcxAQkR8Amodnxlka0B6EQ==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f752768-7b42-4885-328b-08d864c42de7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 22:08:22.2947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: utw2aBxPhNxx/SGMnf7Go1Fj2H02x4+iJ9zw+qt1iYWlx8cW5z1zYBEWMob8OzfOku6OB1zvWWARe/17+GBUWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5486
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Tue, 29 Sep 2020 22:08:26 -0000

There are two Windows system calls that currently fail with
STATUS_IO_REPARSE_TAG_NOT_HANDLED when called on an AF_UNIX socket: a
call to NtOpenFile in get_file_sd and a call to NtCreateFile in
fhandler_base::open.

Fix this by adding the FILE_OPEN_REPARSE_POINT flag to those calls
when the file is a known reparse point.
---
 winsup/cygwin/fhandler.cc | 11 +++++++++--
 winsup/cygwin/security.cc |  4 +++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler.cc b/winsup/cygwin/fhandler.cc
index 82b21aff4..5dbbd4068 100644
--- a/winsup/cygwin/fhandler.cc
+++ b/winsup/cygwin/fhandler.cc
@@ -620,13 +620,20 @@ fhandler_base::open (int flags, mode_t mode)
   else
     create_disposition = (flags & O_CREAT) ? FILE_OPEN_IF : FILE_OPEN;
 
-  if (get_device () == FH_FS)
+  if (get_device () == FH_FS
+#ifdef __WITH_AF_UNIX
+      || get_device () == FH_UNIX
+#endif
+      )
     {
-      /* Add the reparse point flag to known repares points, otherwise we
+      /* Add the reparse point flag to known reparse points, otherwise we
 	 open the target, not the reparse point.  This would break lstat. */
       if (pc.is_known_reparse_point ())
 	options |= FILE_OPEN_REPARSE_POINT;
+    }
 
+  if (get_device () == FH_FS)
+    {
       /* O_TMPFILE files are created with delete-on-close semantics, as well
 	 as with FILE_ATTRIBUTE_TEMPORARY.  The latter speeds up file access,
 	 because the OS tries to keep the file in memory as much as possible.
diff --git a/winsup/cygwin/security.cc b/winsup/cygwin/security.cc
index 468b05164..91fdc1e42 100644
--- a/winsup/cygwin/security.cc
+++ b/winsup/cygwin/security.cc
@@ -65,7 +65,9 @@ get_file_sd (HANDLE fh, path_conv &pc, security_descriptor &sd,
 			   fh ? pc.init_reopen_attr (attr, fh)
 			      : pc.get_object_attr (attr, sec_none_nih),
 			   &io, FILE_SHARE_VALID_FLAGS,
-			   FILE_OPEN_FOR_BACKUP_INTENT);
+			   FILE_OPEN_FOR_BACKUP_INTENT
+			   | pc.is_known_reparse_point ()
+			   ? FILE_OPEN_REPARSE_POINT : 0);
       if (!NT_SUCCESS (status))
 	{
 	  sd.free ();
-- 
2.28.0

