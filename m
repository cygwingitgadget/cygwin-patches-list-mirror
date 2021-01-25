Return-Path: <kbrown@cornell.edu>
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2124.outbound.protection.outlook.com [40.107.94.124])
 by sourceware.org (Postfix) with ESMTPS id D7AB9385781A
 for <cygwin-patches@cygwin.com>; Mon, 25 Jan 2021 17:25:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D7AB9385781A
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8Kp1NosR/OgpAFXE3pCSilyYiRGjtzHaEX9bo8L/yRT3QnLNwTY3O6A+Jl1W/C+cIsGaZz9pkjpd8Qwqw5544tWR7UDn0ZmG4BBb7dp2VNzDANtyI+gXT6FwjuKPPZpInFM8pIDARn+6QcerWjC6d0MErlKS5SUwbSMxrhbQbcrQUBC5qG8smgbZAVXaVODPVVwez5TcDLzUbojs3EIzcoSuu9wxEOMQ4PaXaIVP2wjfLmmJlbPVoJxwKuOdsn4vD8of0NiCgJN70+6ksB+Ys242AQLROOx/xMIUh3BL81mQXZgi3jkQ+Em5BKpXiULBvqih4mp2llMbM/nWPvDsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyipFeTgyRlhYbFf3X+RYuZaxFXncKu9KO8P/zPjAxs=;
 b=MrIFx+DQgJk312WG5iezjC8Cllud5jX4BhDI9+wTy1xIAtNDj23jOLz49eKaIMSzgfxZn+mf31NaAC60ylT7RU6uYwZSqS5lSLWu4+ihgwAc6KFnZDoj3q+9OzxukGNo39UxWQlVzqmEZHZHxkjeGyHs+PW8GDBLlqGPv2KxljUAsxeTc1OQC/M5CdOcGXbs76M7qQSB3KQD04USInQb4j4WccWA2Td1JSpgkRAwg/Q1o4kBPFZF2xxx9C+mn37oO2PPiqRdfuLbjvQtcYAbVDEjgS5GGvDNy3PsbjDKwJ4XOw8Be8NRNsx7WCpYsdfHFIIDbU6JGROH2FjZL/atrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN7PR04MB4052.namprd04.prod.outlook.com (2603:10b6:406:c0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Mon, 25 Jan
 2021 17:25:16 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%6]) with mapi id 15.20.3784.017; Mon, 25 Jan 2021
 17:25:16 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: chown: make sure ctime gets updated when necessary
Date: Mon, 25 Jan 2021 12:24:55 -0500
Message-Id: <20210125172455.64675-1-kbrown@cornell.edu>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [65.112.130.200]
X-ClientProxiedBy: BN6PR19CA0050.namprd19.prod.outlook.com
 (2603:10b6:404:e3::12) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (65.112.130.200) by
 BN6PR19CA0050.namprd19.prod.outlook.com (2603:10b6:404:e3::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.14 via Frontend Transport; Mon, 25 Jan 2021 17:25:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4bf7f296-f747-4dc5-122f-08d8c1562e36
X-MS-TrafficTypeDiagnostic: BN7PR04MB4052:
X-Microsoft-Antispam-PRVS: <BN7PR04MB4052080744C74352DD07A66AD8BD9@BN7PR04MB4052.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DNzif3f/yCHh6jCRw1NIZV4o8J80FpF31xpTgS+suSBe6lidDV/D2+2MoD1qIPHDYQdNL9kqfiCZmAi0OCRCsZ99EmVZCf6Vczre59dXM8DvGs3tJp/d4Jj066YAOhpOF7lWbZ0mThNPn6RJ6d/nQKR4Bj0xSZ1qphIHv4Qx3NnYQCoyA5WywdxLwFBDk9KTrQKLaZ5lmvUQsPHcWub3erUmho1k/zGPWqNODcatgh9S6u8CX0DJ2z0rMWkaUUkNn03LliOQU+Z47wfhqjRA2nqr2ppgXFHAACVz+QWBmaIaxT51GsSAxDohgC6QwwPj/Euz4uGItfQevUnX5a1BvLRn/I5rjksyx0FNN3bsLBchVWa3Hfk1MuqVesfGBqFr2bIMx9KXzVf6tFUxeoyu7hAN6CS/AcuFb59fAJnpO0kSDlTNOhVIsS1SG4O0McMEKN76/ohaE5MPT8fyMsLStuwcoiQoxWE2EW49KvspbIdAzqb+sqotcTemgdWlxDZOcOxcaBTi822I+bt+y5TEuzpK2ysqI69alG9wqaOnLTkbukXmroBVFB9KQcJfC3fyHLEsveO55BCZiz3pnxpZsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(66946007)(478600001)(66476007)(8676002)(6916009)(1076003)(6666004)(36756003)(86362001)(66556008)(956004)(26005)(2906002)(316002)(5660300002)(69590400011)(75432002)(6512007)(16526019)(6486002)(2616005)(786003)(8936002)(83380400001)(52116002)(15650500001)(186003)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?iiEKz8DZDb/GueFZ3Pl6veaI1ZKBSf8AmWwXAKGGMW9UZz4DPR8RbT6rIugt?=
 =?us-ascii?Q?BDAZsJLWnn91WA/PFiT6uH8xIaXG+BPtaXXadqpCrit/xpf6IrItc+CyXsIn?=
 =?us-ascii?Q?Qby9FsEFQJmfby4UOWb9Qq7XgrKl/IYuWykSX2RatcWh5b13Oz3aufiF/K1B?=
 =?us-ascii?Q?MD6F0sg7URNsUMyidMiimDPGodONZ+1EV8Yl6C6lf5nwLOZVFRF9au0Danng?=
 =?us-ascii?Q?6sSP0xLJlP0PEB/Mn4ArnNUZx6uCCOzax5uwMjmIoR5fwvIvfFiohHNulL27?=
 =?us-ascii?Q?kcb0BPA20OgJ0ja0HSYRTPI9r865r2SWX8u7wEwSnD6qnBG+fNLIUh22HoSk?=
 =?us-ascii?Q?l3lvu4DQsciaFY4x7zR9j0HaTjEIcJtp1dfpiKUU7kXMbF7jy082Wh42BJMx?=
 =?us-ascii?Q?Ca9S0ChbXvx0Mt4AvP9zq2sxv0IVJ6oqI+d35R7knfozwSbRxl+1+fBbdMqr?=
 =?us-ascii?Q?YlDTeCuQyJjf11d3nj2/SyfFNFsTjpFCaZEYpBQcawqBByDsEh3hs5zNVxE2?=
 =?us-ascii?Q?PVJTK6NtcxdCFi0gNkvp2xhGaPggUFojCH6w2mWMFlB8paHeWkEfw3Z9Jd0e?=
 =?us-ascii?Q?zMYOCNY0qLLaerL34hhPUyj5KOVq8WJZIn/zueZwpVsXXnAV67g1zheqMRwF?=
 =?us-ascii?Q?wJHxoedmOHvJ7vDlFPCOC4Chz+Rrxza86rMmDzEbGrVUJRckIbW7THkz3QgF?=
 =?us-ascii?Q?HAz7IunGpBGMKGR+0PZzM1SmgRKlcSJ5rY+TRdWkHlQfj9ShjPugAp8pPb8T?=
 =?us-ascii?Q?pEwMzzAvdEpsocJvqNEY6nAjLCKCQbDp32WqhPOpVaQ6vMIIdwdTBp+Z3eBz?=
 =?us-ascii?Q?x7yWpT3D+yLiv8BWr1xNtaWxV82Mt3EKY5bOuew+zvTfV75iui8uAJTwD+tV?=
 =?us-ascii?Q?xt87xl05ilomgxyVkLi62l1xx2J5NKmRWtCUCEW3fHX3zJ/G5eWnYnnh5GyD?=
 =?us-ascii?Q?xdbY1gQsnuxqLZe086CWlDT8gYkjVmtkHfHimAGbQoRHKVhRNSqngHH/FWrF?=
 =?us-ascii?Q?5+2+oxWNIqFkJFbaPsv0CblmqkQ9Ddpk/URduCFLdRojHj8WYOgGcth3UEW/?=
 =?us-ascii?Q?MxFSJb1c?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf7f296-f747-4dc5-122f-08d8c1562e36
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 17:25:16.1058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WZu0U9YlrSk4OdRgROk9bcW3DLpfU2TALJMZz6OuHA1cLXLu1PoDqCo0y2LoHbtSpZszqWVxr8GeGLfiKpwIog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4052
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Mon, 25 Jan 2021 17:25:20 -0000

Following POSIX, ensure that ctime is updated if chown succeeds,
unless the new owner is specified as (uid_t)-1 and the new group is
specified as (gid_t)-1.  Previously, ctime was unchanged whenever the
owner and group were both unchanged.

Aside from POSIX compliance, this fix makes gnulib report that chown
works on Cygwin.  This improves the efficiency of packages like GNU
tar that use gnulib's chown module.  Previously such packages would
use a gnulib replacement for chown on Cygwin.
---
 winsup/cygwin/fhandler_disk_file.cc | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_disk_file.cc
index 07f9c513a..72d259579 100644
--- a/winsup/cygwin/fhandler_disk_file.cc
+++ b/winsup/cygwin/fhandler_disk_file.cc
@@ -863,6 +863,7 @@ fhandler_disk_file::fchown (uid_t uid, gid_t gid)
   tmp_pathbuf tp;
   aclent_t *aclp;
   int nentries;
+  bool noop = true;
 
   if (!pc.has_acls ())
     {
@@ -887,11 +888,18 @@ fhandler_disk_file::fchown (uid_t uid, gid_t gid)
 				    aclp, MAX_ACL_ENTRIES)) < 0)
     goto out;
 
+  /* According to POSIX, chown can be a no-op if uid is (uid_t)-1 and
+     gid is (gid_t)-1.  Otherwise, even if uid and gid are unchanged,
+     we must ensure that ctime is updated. */
   if (uid == ILLEGAL_UID)
     uid = old_uid;
+  else
+    noop = false;
   if (gid == ILLEGAL_GID)
     gid = old_gid;
-  if (uid == old_uid && gid == old_gid)
+  else
+    noop = false;
+  if (noop)
     {
       ret = 0;
       goto out;
-- 
2.30.0

