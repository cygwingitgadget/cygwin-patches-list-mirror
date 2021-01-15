Return-Path: <kbrown@cornell.edu>
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2099.outbound.protection.outlook.com [40.107.92.99])
 by sourceware.org (Postfix) with ESMTPS id 369F63857819
 for <cygwin-patches@cygwin.com>; Fri, 15 Jan 2021 17:42:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 369F63857819
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxSqmVbGVKTv2llZptW8viD04TCpSjskN6mBb4pc4nz3e6eFHvrdslSHntYro+1xji2kRb5BTgDPjOESGWMneJnG/wsYkQRZyfFxnyrOyVnmDkN30zvNYoTMqaMFUalRWS4jLbtJ6XclcS9yjCwty5FtZbA+dTa361qnY75K1CxHIri0cx4UUqxq401SlApijI5q+5XC3JbzKSoAhduU0cGbg4ug4dbgmVQPlsxpJFBTP1rpncdNpJgw11Hu6mbh3CCIixyb6ElLMx5DE8OiGFQW3SLvGdLI507HBbpTSlEla4n+lNmeSiBhxcF4hT1CBYDi5NbKzFlQpWpKMxyo9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5orA3JC48XuX1oRIpH5KZ7yuBbCQWegQ5Td2Uh20mI=;
 b=PGaHwtElsm7QXf15nj/qwMD/+N5Y7Lwj483KJHQcTieHmk9igN4f+mATSShdts2rH/AWANEcVDeBsmXPru2crrSc2D496zl8yQZ4RL1i/sasCNy2P8O7lufqzW5Asr+lYEylN8URrghvq1eSaG9TjP4yVM1JHgOoPARdh0n33FRZziRkXqM1VmhxMIF9b2ConKVL/jfaB839iMy2DqXkyN2JQYKooBRzUqZuGlchRqWx8w1Is5mdnxNJFCzNMGGz+gI/WQ6J31ap/DCFoMBEBocNaGGW6TU8n6okyHeiLqf+rABzuANiatEw6J4fR1X5FFF9dNI7U36ds3HS/sWfiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN8PR04MB6161.namprd04.prod.outlook.com (2603:10b6:408:50::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Fri, 15 Jan
 2021 17:42:33 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%7]) with mapi id 15.20.3742.012; Fri, 15 Jan 2021
 17:42:33 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: document a recent bug fix
Date: Fri, 15 Jan 2021 12:42:11 -0500
Message-Id: <20210115174211.16619-1-kbrown@cornell.edu>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [65.112.130.200]
X-ClientProxiedBy: BN6PR18CA0019.namprd18.prod.outlook.com
 (2603:10b6:404:121::29) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (65.112.130.200) by
 BN6PR18CA0019.namprd18.prod.outlook.com (2603:10b6:404:121::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10 via Frontend
 Transport; Fri, 15 Jan 2021 17:42:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 338c9db1-801e-435c-3936-08d8b97cf023
X-MS-TrafficTypeDiagnostic: BN8PR04MB6161:
X-Microsoft-Antispam-PRVS: <BN8PR04MB61615F0818E56C4F0E3B402CD8A70@BN8PR04MB6161.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:124;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PzwuChHR+Hh+V46ETxAZqJE7NdN75EO4fw7+seUHSdsKa6VY1whjd9AGe+1a8IV8s3fohfQA4F7TpfW33PLJOP0fFly8EkYwRjb9KRc6SIydFa3+j12i6mLnGBH7H+Gy5mFZcW8JRbG1ViPFMgHjErRZMh/Bgj8QXJNSGPOJxDrmt22jqCUIKmfw/cHLCbfb7UxK4fQ5XG03Q1VfNMpZUyW3jRqPjH4yGf8pmrobBj1F4toce+gldXQhgpWQIgHuzzbV1m+VeIPbpuTDcSw8KSgPIs30qkRPtCzhptZc9FDZml3+57rIC+xph5RaR/t2BRJt/ECfO3/HqGJfjXo/OELyMKL8A0i6FYspRQeJ5F8DBxdheYaRwqRUyX78xzCwjKhIFbaOZUCDrI68cEBSc4TxayVgx2+zfUxuMObJsKMcuoGcns/bGEPJYQ5R6zGthKEiVTBODcIE0zWUlH1WvDbjCb5paVvC65S1MRFaRif11ctbCNqU/aIec9O3RVXMwHcXh7fdFn7uAO5+8s2LEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(396003)(39860400002)(376002)(26005)(75432002)(6666004)(66946007)(6512007)(36756003)(6506007)(5660300002)(69590400011)(2616005)(52116002)(186003)(16526019)(6916009)(2906002)(66476007)(8676002)(86362001)(6486002)(4744005)(1076003)(966005)(316002)(8936002)(956004)(786003)(66556008)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?g9VzlToKELQ7gdAtvO9wQsRiB9MKAXPDClL5RbiQL0lQl8dfngeFBea2DNi7?=
 =?us-ascii?Q?TZ0ry54Pn1ErqN8xvSRAX4+UN7l8T0iosROhBTlodZEuDXIIVQ9Ul+EIfKgA?=
 =?us-ascii?Q?0sra/3mQL1WoVkGsJkulf1VosaQoVFwDQgkMdIE6Wf09Lbh4lzH1diuWOYKg?=
 =?us-ascii?Q?sSFhvtuH2KImLNQqYIz1GWfPce+HrAeTKOVicF4p0h48Gk90knl+ldGvfW7A?=
 =?us-ascii?Q?27YSwEZrOXPnKCDUztwlko3on/dtWjicQzP7N91PDiaRRSgoq0GRt5bRWQAC?=
 =?us-ascii?Q?VXvNTuEn7hXElG9Sh4mp2JilAKHxvJyNDxDz3oRZF34XMbnnT22Y/UDrLrxe?=
 =?us-ascii?Q?1BozlAXWHM050gam91QvNoDKIftFtX1fJdApm9RYQh+lTuGD4iVArMvteYDi?=
 =?us-ascii?Q?0Ai12nl7O6x+p7yxCG8tphqOROU2ZklW7sFLH4p/pEGzgqKQuEuy/jDUUMpP?=
 =?us-ascii?Q?+unaeo1ibNCoQRRrbFZYYo6su3YDtCyEQdoOjUNuqaQDDktuT3AoflsUi4cl?=
 =?us-ascii?Q?TSSMvmeDJwn9eCHgscmQ5ckRtG0dPDn+Appz5GJ5AXHnyzWEYH1hNeaw8OH8?=
 =?us-ascii?Q?SOod4vNrf5VsBy0zQGC/gJURQnaFUKYe4yX3ZQVHkAqTJ13/tKg/Otc5pQKI?=
 =?us-ascii?Q?Z6hOSCdMmNW7XW7IBrxXPiZXSya4r2kb9L1hExEDeVbTf98BuJcCxqs2jpU6?=
 =?us-ascii?Q?4pFamdgnOzff5LGfW2/8NouESfCSALn9iIyXF07cDYb7Lxm3WSn+vK7a0ri4?=
 =?us-ascii?Q?Sb35XYSlAlIAsasi0zsS/EsVqwdqxzQ+SpbaIplu0hxThlnSgZHBQT9wTrTV?=
 =?us-ascii?Q?9YQ8FwgZpmm8n0+rFTFKXa4Yp3TurJp3MtL5a8GEV3qCZswDwXW+KiiGtA2r?=
 =?us-ascii?Q?1jXj+hNl+sbSLIVwSLfe7baR3U/UKPy6v9+yjd+WnE/Ws/cuhM6D3FX44y6y?=
 =?us-ascii?Q?IXz4m9s0QdltylZalmeTOC9IgVpOdI9PgvN7zQO5NTa/YWR+XSAjJqlOQfpd?=
 =?us-ascii?Q?7jeP?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 338c9db1-801e-435c-3936-08d8b97cf023
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 17:42:33.5244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1KINVds/hRhquIWkw4PeCEwHF8bztUjQ/JMoxMhQdpNIlV1u+zQ4ZkFTCZIVIe56Y7piiJbCX4dXV5Fvnut/Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6161
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Fri, 15 Jan 2021 17:42:37 -0000

This documents commit b951adce, "Cygwin: add flag to indicate reparse
points unknown to WinAPI".
---
 winsup/cygwin/release/3.2.0 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/winsup/cygwin/release/3.2.0 b/winsup/cygwin/release/3.2.0
index 132d5c810..c18a848de 100644
--- a/winsup/cygwin/release/3.2.0
+++ b/winsup/cygwin/release/3.2.0
@@ -43,5 +43,8 @@ Bug Fixes
 - Fix return value of sqrtl on negative infinity.
   Addresses: https://cygwin.com/pipermail/cygwin/2020-October/246606.html
 
+- Fix a path handling problem if there is a WSL symlink in PATH.
+  Addresses: https://cygwin.com/pipermail/cygwin/2020-December/246938.html
+
 - Fix a bug in fstatat(2) on 32 bit that could cause it to return garbage.
   Addresses: https://cygwin.com/pipermail/cygwin/2021-January/247399.html
-- 
2.30.0

