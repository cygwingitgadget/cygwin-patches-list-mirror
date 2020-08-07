Return-Path: <kbrown@cornell.edu>
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::71c])
 by sourceware.org (Postfix) with ESMTPS id 2684B3857C45
 for <cygwin-patches@cygwin.com>; Fri,  7 Aug 2020 13:51:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 2684B3857C45
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjWevuktOFenmjQiaMLNKmqYcuhqE/K6DLJuO8VIRMb3//udwwD9vqhVCLeai0PU9oiNZsAkt8h2q6nt9Pqy85chsuS6l6yrNNvV8KH7UeYtfvbPT4fNh/io4iUkSye+ZfvuJ4PV1/SP7l8FRk1o9lSnn0aC26X/VX133rZU0z0ApemdisqlvPKfQD0GSXcdEpuoZYSau/8tLVLeYa7JIjuZPC7h5CyEYX+PrT1Rs7HJwp5/TkJmXH3IQ1YZDBGdGw25jze4NE8RNYWVcb++HkkZ27Tz0nyBRqpsEHgg67biq7mTFE3Am8ZV6cKVwP6oHJW1HYQHQl/Wy/V5EeXd5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbAJGW0DEudhRanF5OCaHCz83kWaWuM+WnDylIKiQYQ=;
 b=jG1VQh+HQoo9yBTXDBrQ36Lcx0qSt6pR2dVqI9AlAzuUGyyCVoZN/D4BuTnFklyOu1DzXqPaLBd1uEQ3E0BgWoW2kze1+i5xDP65qTjJoTo/j0P4U3Ry/lMv9f/VBNJ83Oj6NN1xd5NdFAJMdOJSvR2ayV0s+9Szk8g1Nyrzv9mjLPK88eOey5jifQcHL5mVy1krwPQfseoMbKLEzSrk+J7mQ/nDH3MMc8QVDJTzahI9hczpTesl3BDXoKyFJDS5FN8JdHvIqw4PxrH0VWEF4sqErEW97xzHq/IJTCtl2UsGETg7FCbciRZkYVbhTsc285RKwIOFvIhCOxJetS88oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5934.namprd04.prod.outlook.com (2603:10b6:208:fd::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.21; Fri, 7 Aug
 2020 13:51:28 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a%7]) with mapi id 15.20.3239.024; Fri, 7 Aug 2020
 13:51:28 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: cygserver: build with -Wimplicit-fallthrough=5
Date: Fri,  7 Aug 2020 09:51:11 -0400
Message-Id: <20200807135111.22024-1-kbrown@cornell.edu>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR08CA0030.namprd08.prod.outlook.com
 (2603:10b6:610:5a::40) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2604:6000:b407:7f00:c47c:aa71:f7d0:e31f)
 by CH2PR08CA0030.namprd08.prod.outlook.com (2603:10b6:610:5a::40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.19 via Frontend
 Transport; Fri, 7 Aug 2020 13:51:27 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [2604:6000:b407:7f00:c47c:aa71:f7d0:e31f]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fb6538e-31bb-4f36-5e7e-08d83ad8fb99
X-MS-TrafficTypeDiagnostic: MN2PR04MB5934:
X-Microsoft-Antispam-PRVS: <MN2PR04MB59348DC0023578CCA44517ACD8490@MN2PR04MB5934.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YzWaeNCF6LbnO90bwUAFyctb+mjFJapulf6Tk7xWWL5KvE++od/TN11Xv+b3QjfYxmxhIhqx4Vp0gqHR430qu6SJnq2ZvpiSymW/TBeW2q9akrcYDqbJRH8kRFzJOrtuqgvAWdEGK4+afRdvDmqeR+q5/Pe3OVlj8lr1RY9YKCF+QLYIyLVj1MZYvXlpNxUcVlgMOk40bGQv0mJyXKUci8h0DtS+nJ9qqIcNRzZCn1nqmNAe4EGrjMQf3pjdaqBnWYdw7JsAzorTQuFkbxEZC9gZYWCle3nSL+qXLoZhAUxVdz0QOePBGA8xNxgPAmm3N5DnEpqWEHHJZk5vwFZVbtQb1NypK1nWwIDpWB52Fj1goX02qL8trt27svaTjqmp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(6512007)(1076003)(69590400007)(66946007)(66476007)(66556008)(16526019)(6506007)(6666004)(186003)(36756003)(52116002)(2616005)(75432002)(786003)(8676002)(8936002)(478600001)(2906002)(83380400001)(316002)(6916009)(5660300002)(6486002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: +Jt4W2PcHr/Iv1tJYlXv72krGjcvv3x8DS0fnZpBQmxPEy9WDejRwKNAahXn8m5MbjSQSv+cTQCdErFt0I+uLUL7DIbfcSuMf+S3yn344rFomBmeqn0YTX3WkB4y06yRRYufdMn5eG8BbZ3jPCFSLN4DYMgoRBGMA0Jl0olysVzR2eNHQ9L34TNYr2ump+kNosSf6EXWyaSv9M/QihgnTQF+n3/DwzkZzCf2Wyo4I9SoZWZgdsopK7ef029uXHwINaNLL3CVHTk+0Dw+Lpk4XtI1HB2kzvcw58zydjvn5ed/DuBkNcBAQdB76+mMPk58R8/DytmoEJH9FbPqvb3aVhKmhzGQugRjtZiFL53VHEN4M3p8/qB8SK+bbNM3xI9YKZ4vh840vewkysHRB6j0pmn/mGBGLR5RnyDwUvmQnozHxg2mmArt+6UxMr4QE6p5aMGJN5dQPnAmJnzJzRNYAU/sgSc7dGuGA7m5hz7jVayO9ebN6ioAIwTG5D15Dk2H8Zt/UFIijtvj9whcr5LVpxRmCLE4Hh/MNKLFKQx2ub1dVjl0fT19FF/SJy55oVv6YpIXTffoiBrrrPJTdfjOO1gFzpqnquLwERUijcXs9TWilvs4XvggjHyUK3rCeB1aFVIa/ZqX20EMo2xpkfD16S0yrRQMnGnYzroCUwjHT7b5ugFK2biFCEqRcZHoAB3hJ41ZFTgHSZYTY+2vejKS2A==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb6538e-31bb-4f36-5e7e-08d83ad8fb99
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 13:51:28.3083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BtxEzqYCxAdQWS3KlJvepYxVU3cI/5Ch1ZygxruY2qNIplFOQKoWef5HY0msoSGYUVZdnfWiK+1Tpzwtd0uRNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5934
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, JMQ_SPF_NEUTRAL,
 KAM_NUMSUBJECT, MSGID_FROM_MTA_HEADER, SPF_HELO_PASS, SPF_PASS,
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
X-List-Received-Date: Fri, 07 Aug 2020 13:51:31 -0000

Define the pseudo keyword 'fallthrough' in woutsup.h to support this.
---
 winsup/cygserver/Makefile.in   | 2 +-
 winsup/cygserver/bsd_helper.cc | 2 +-
 winsup/cygserver/bsd_mutex.cc  | 2 +-
 winsup/cygserver/woutsup.h     | 2 ++
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/winsup/cygserver/Makefile.in b/winsup/cygserver/Makefile.in
index bbdfc25fb..70f38233c 100644
--- a/winsup/cygserver/Makefile.in
+++ b/winsup/cygserver/Makefile.in
@@ -16,7 +16,7 @@ export CXX:=@CXX@
 
 CFLAGS:=@CFLAGS@
 override CXXFLAGS=@CXXFLAGS@
-override CXXFLAGS+=-MMD -Wimplicit-fallthrough=4 -Werror -D__OUTSIDE_CYGWIN__ -DSYSCONFDIR="\"$(sysconfdir)\""
+override CXXFLAGS+=-MMD -Wimplicit-fallthrough=5 -Werror -D__OUTSIDE_CYGWIN__ -DSYSCONFDIR="\"$(sysconfdir)\""
 
 include ${srcdir}/../Makefile.common
 
diff --git a/winsup/cygserver/bsd_helper.cc b/winsup/cygserver/bsd_helper.cc
index ecc90e117..38639647e 100644
--- a/winsup/cygserver/bsd_helper.cc
+++ b/winsup/cygserver/bsd_helper.cc
@@ -120,7 +120,7 @@ ipcexit_hookthread (const LPVOID param)
     {
       case WAIT_OBJECT_0:
         /* Cygserver shutdown. */
-	/*FALLTHRU*/
+	fallthrough;
       case WAIT_OBJECT_0 + 1:
         /* Process exited.  Call semexit_myhook to handle SEM_UNDOs for the
 	   exiting process and shmexit_myhook to keep track of shared
diff --git a/winsup/cygserver/bsd_mutex.cc b/winsup/cygserver/bsd_mutex.cc
index 13c5f90e8..0cda87a5b 100644
--- a/winsup/cygserver/bsd_mutex.cc
+++ b/winsup/cygserver/bsd_mutex.cc
@@ -326,7 +326,7 @@ _msleep (void *ident, struct mtx *mtx, int priority,
         break;
       case WAIT_OBJECT_0 + 1:	/* Shutdown event (triggered by wakeup_all). */
         priority |= PDROP;
-	/*FALLTHRU*/
+	fallthrough;
       case WAIT_OBJECT_0 + 2:	/* The dependent process has exited. */
 	debug ("msleep process exit or shutdown for %d", td->td_proc->winpid);
 	ret = EIDRM;
diff --git a/winsup/cygserver/woutsup.h b/winsup/cygserver/woutsup.h
index 272f978c0..7b799f156 100644
--- a/winsup/cygserver/woutsup.h
+++ b/winsup/cygserver/woutsup.h
@@ -12,6 +12,8 @@ details. */
 #error "woutsup.h is not for code being compiled inside the dll"
 #endif
 
+#define fallthrough	__attribute__((__fallthrough__))
+
 #ifndef _WIN32_WINNT
 #define _WIN32_WINNT 0x0500
 #endif
-- 
2.28.0

