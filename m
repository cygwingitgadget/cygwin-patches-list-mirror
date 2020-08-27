Return-Path: <kbrown@cornell.edu>
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680122.outbound.protection.outlook.com [40.107.68.122])
 by sourceware.org (Postfix) with ESMTPS id B2E24386EC18
 for <cygwin-patches@cygwin.com>; Thu, 27 Aug 2020 22:40:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B2E24386EC18
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBWaJXGGqVKrIOUIIQ0moUMvuGVQeOCHag5+lmSEN63Pme3Pt1KHA/z6RBU4W4KTHK7enZhP+T0b3sDAtXM+uXeytNoONWDQtSNNtbtjOm/Oi5yF5QPs0AOzG+RmmPKrcry/az9emqrkmghvU+EFpcKLKVb88WJHMydYowtNO8J0w2xVaJJzDzpK4XBSnLqRKTqZGj41ajrOY9YIBIp+JHri55UmshaK6h416PY2QJWX92eiu4CCMqihpp0M5uJKQ57q2OVwDIoTNvvKED0WQ8706zTu3nOfRFuIzCWVPLYOKJMg1P8OOYEDUq7v+b9HgRnuwWm3xNq+Q2o4dSyLvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6FS33NLnYjJKVDIXvGLPCPuWgQT9JDon1RPf33GcZ0=;
 b=HiI/b6zPpQbxwalCTqoFIcpz4BC6R3RcSQ1N68AhsVm/Gu7K2eToOXPKl3McqGrA6RlLSAWeHWPz5qUwUOcpSngqV4EFsbmkAcdyqMLeYZZeSr20nGx4jRxH4awEb0zKJXpm/Upen83ffWjfo/yxJIsGPUnfYrlQRToz1pIpPvSOcq9jqbkOxjIT0oyGUa6RpX8MAtdacybkRJOLDT3gd8ZpxEy4ws8aih8W69YVLuPdy7YbAcC7RuW6ybjDT8BFvDSG8uvxLsSxGvezVT1opSnKcd7k6Eid0C2BmK+DW5uTi0b037l3sdpUq8kEztbiFfzU6RHnGgnlpaFy6XmIcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5613.namprd04.prod.outlook.com (2603:10b6:208:fd::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Thu, 27 Aug
 2020 22:40:50 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a%7]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 22:40:50 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: sigproc.cc: fix typo in comment describing nprocs
Date: Thu, 27 Aug 2020 18:40:32 -0400
Message-Id: <20200827224032.6553-1-kbrown@cornell.edu>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:208:256::16) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 BL1PR13CA0011.namprd13.prod.outlook.com (2603:10b6:208:256::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.7 via Frontend
 Transport; Thu, 27 Aug 2020 22:40:50 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [68.175.129.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d1937da-5b02-496f-3fb8-08d84ada3f93
X-MS-TrafficTypeDiagnostic: MN2PR04MB5613:
X-Microsoft-Antispam-PRVS: <MN2PR04MB5613AB161BED14F52D4E31B0D8550@MN2PR04MB5613.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v1oREL/NVVu3Q8WEqvgXrWoTSZoTnKBDNAb1Esoy2tf91ZFOeOXeuX+4e3aePXLwKSTtfhxOfqBrFPojsjjGTRI8KvaekKbrDDR+MagNyMf6EwEKowh8eLcZnUQDy6cS28rXqnil7kqOBPmDLnueawCvGtLKoin376/2z5tocpQzBVSp9ebIOcU5WVjs9MhkRMu0xEI0aSx1o1Wp9or0O4P4KiQ/7IT3N5Y8Xi+YjX0EXXPyDdj3UypFmRsvRhAgfvdvkUsPHY1PS1CbUj8kKBmymuKzb8o0rSyQ5UXED0kTTfk/R8opPv16Xst0iJtk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(66556008)(66476007)(26005)(86362001)(8936002)(478600001)(5660300002)(6916009)(75432002)(6666004)(83380400001)(2906002)(8676002)(66946007)(6486002)(52116002)(786003)(4744005)(36756003)(186003)(1076003)(16576012)(956004)(316002)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: JEJBdqgWC9o1EAKmBJr2cbAw3wj+w1Vem9qRm2khS8SSBcX+eCVHopE5eKKxR4dkkSE3+tCNneKMUbEniLlTrr66x4CZc6ezSQV53vxglAk594XQ+ADzRxRvEGWhTycc+iomTk9kaiBRNh+wCLO2by/NgNM+0HoYwckdGVXl6IlVTnVzT4OuvlchMAnKImPLchHv4zDfziec1EBUrf8qc1a32uKq1uuKUU6nYdDvzcLG/9mlgXnhexK5+LGIM1R2Z/gknt60rNPLPnIrrPpkk5fa4O5CfRdBMq/AboagLGCN/PXCYAiORU+bMGepbSRBtQ6h8oCtZKv0y6zwiB709XSb9WCnjMjxX4zWL+oU8+OR4WZJ/qEH6G/RqdvmdWRT61q8MilL/9EqBZdWmZJ5/2+jLehyeuD8qfbwqN245YbmnF27RCEN1Zpzno8ZuFyGuD6rpiwjY1/kXkuW0pim9XJBT6Pn7S7yMRn0WGSBYERKDWKwdgpqV9vSKi7418Q/bulOBB4uWlVLW7YFHiwseETUac3CSiL4qmNzHzBZkSsjkucHBk+nzjWlYr7bW9SMooaR2rf4W2/ClvXux81x57cSYREHAbFUX7gmL+QZZ63DiCEnfoB0sNuIzGkGCs419A2AQR5QpkPFMdZvDASfYQ==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1937da-5b02-496f-3fb8-08d84ada3f93
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 22:40:50.5254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pz2yEb94bOJi6I0TFoJ9WZIkbG/EjgxbMq4Em1M4SaQhO5Exmkbb3YneMNsuBPpLOS5Qukriny0sIxNTDVSNUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5613
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, MSGID_FROM_MTA_HEADER,
 RCVD_ILLEGAL_IP, RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
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
X-List-Received-Date: Thu, 27 Aug 2020 22:40:53 -0000

nprocs is the number of children, not the number of deceased children.
The incorrect comment used to apply to a variable nzombies.  The
latter was removed in commit 8cb359d9 in 2004, but the comment was
never updated.
---
 winsup/cygwin/sigproc.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index a5cf73bde..30c799f8c 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -44,7 +44,7 @@ char NO_COPY myself_nowait_dummy[1] = {'0'};// Flag to sig_send that signal goes
 #define Static static NO_COPY
 
 
-Static int nprocs;			// Number of deceased children
+Static int nprocs;			// Number of children
 Static char cprocs[(NPROCS + 1) * sizeof (pinfo)];// All my children info
 #define procs ((pinfo *) cprocs)	// All this just to avoid expensive
 					// constructor operation  at DLL startup
-- 
2.28.0

