Return-Path: <kbrown@cornell.edu>
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2126.outbound.protection.outlook.com [40.107.236.126])
 by sourceware.org (Postfix) with ESMTPS id 31F653892452
 for <cygwin-patches@cygwin.com>; Thu, 16 Jul 2020 16:19:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 31F653892452
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9oCldsowuAh3kwmSHmbOqVCdJD4sXyQAyLe3vaDmwmj0mVQgTxEDXVC1gmLcuoW3vkuJATuc5JEN9XjYckgScGe2wzcrTBoZnpW5Ed1d4914wg9LV7yBo9xP0e3+t3Zu7joasJLMR8+xAFIl9DNnEaMAX4DdJ2wbNyXqhKDKZ0VhuQvBwfUG+RukhhfYZP5/AwjqQYJ8soeq5MfHWlQmuMZctyo9Jt0lX6LTOMYbWZGPJe/PepEcr8h3KuP67pejR3Se10ncofZZ/90Tq1f9aN4CW8sHPaUKjz0RQuFKSIBVDfd1sPicl+hjfULxjlKnJHnDJOhkimfvjACiOlraA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPhu+gSoRE+kHLHL+V0MOcwG2mKmhNOexaKLpRBCmmw=;
 b=JyJE+sys2Y3iofgGHMLXIzoh8sbGLDXTfltLD8s1I6mtZD7yKS9m2d6SiSbKiHtjRxtH+7vqSv/xvlWwxSZHQAZ1jLGdg+39C6TPqyEgcUMIh2qCYRbgHaE8DKD/bZ7Hy8/GushVyVd4EbwdDmAEUqQoAwYqVFIv/Mxge8kcpWsUxFr/pNQSBLdw6P8nmafMPXzws5gBPa5CBo/sVIX1D122tjz+cqTDz+iGJZEE2iEaEgnaOpVjF5ui8EsMeC7c7xKkHne6ox91eG15FTWMDOOtZK33qZ3lz5uoykSdoiax/7vBnPghEVic0HCse4D9Cu5xIDyJM3x7mzegoaI3Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB6112.namprd04.prod.outlook.com (2603:10b6:208:e0::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 16 Jul
 2020 16:19:37 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a%7]) with mapi id 15.20.3174.025; Thu, 16 Jul 2020
 16:19:37 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 09/12] Cygwin: fhandler_fifo::take_ownership: don't set event
 unnecessarily
Date: Thu, 16 Jul 2020 12:19:12 -0400
Message-Id: <20200716161915.16994-10-kbrown@cornell.edu>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200716161915.16994-1-kbrown@cornell.edu>
References: <20200716161915.16994-1-kbrown@cornell.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR06CA0014.namprd06.prod.outlook.com
 (2603:10b6:208:23d::19) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (68.175.129.7) by
 MN2PR06CA0014.namprd06.prod.outlook.com (2603:10b6:208:23d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend
 Transport; Thu, 16 Jul 2020 16:19:37 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [68.175.129.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 335d82fd-252a-437d-c368-08d829a40911
X-MS-TrafficTypeDiagnostic: MN2PR04MB6112:
X-Microsoft-Antispam-PRVS: <MN2PR04MB6112606C526A0503999A1609D87F0@MN2PR04MB6112.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XUAmNxAbC7ubmPLW02fuxzJ319sYIIor7ZnuleSvDr1hCy4PVrs5yrlqRvFIa1mz/5BSLXPz9/eB7YUmQfx3SfXqJmYS6wig6TWSVpOafLPN42FQFS0kk2gz0LVER4MKxBu34HM1fd7kYhg0fMoghutMdk4Yf64e5kAaPGcBczGXzsTsfgIAgNFLc/OC5mjECiHmfqH0pN/p+vMlR+1j4lS17QOEwU2wAmVi0/fDmhoU1iCbC8ieap25RvWToGd6TASWen3aBj8/ZI2xX1xisfe9+E1/3Yyd7e0DCPgOF3IX59hESJ3IWIwF55549ikVH6i2N4JlsWzKvyI/IzO4IGykxkzEWI5bebR6ROlbJeeWhmLmNwvqs6XIGYj0rHZq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(66946007)(2616005)(66556008)(5660300002)(69590400007)(6506007)(8676002)(83380400001)(16526019)(956004)(6486002)(6512007)(52116002)(186003)(26005)(8936002)(66476007)(478600001)(2906002)(86362001)(316002)(786003)(75432002)(1076003)(4744005)(6666004)(6916009)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 1MvwNGOKJEHShDuYZ7nSZNj6X069UIP0UDZHUxuVMI2Rdv5akutnNxoU3PB6BXwNKSAE86Lq9BJgh2nuRTnYlMvCaoEJU3LDpGDZwHn5OkWyFpibnJAgYWFMkIgpGl3QRP1Kp5wlatuyy38SkztNvCWP993UZmZew96BgjMiG7cR42Hb6VuBsWYNq08cSIaZCq97swBdzNoPn9GLMXITcEb5bXy7P12Mjum8P/dmoX7DZSD45npsH2KCrZeqtKt8pZl9UQdKdXKUSckjpPyaOSs/Vtq5rmu9ExkozFdl5rL6rU8c9/oJ+05s5kyU1aSHzMEvLGRa2TsMQH4zyq7mLDdVUaEARhucH++0pjzXeaKJZOHGoCHQmENZRg7Z2CJPmvRTGmKuqEx94gsrGpozw609tYzJHlPcXyW5PXgNI6zwPzlXj9EjgCX64UlOFkZJaJz/QvlbOgTNPiotsbd9lGJ5Whfp+xSvPRit2++Cbng=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 335d82fd-252a-437d-c368-08d829a40911
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 16:19:37.7968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ulpEJnJ7ESUMHj0kQnmwlw4mz7xKDDQIQBRh57bUXRwWOcxIlai2fAWIGU1OySos3Pg/0mZDlLgtatTXoNSJDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6112
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 16 Jul 2020 16:19:46 -0000

Don't set update_needed_evt if there's currently no owner.  This will
cause unnecessary churn once I'm the owner and am listening for
connections.
---
 winsup/cygwin/fhandler_fifo.cc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index b6e172ddc..fd1695f40 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -1186,8 +1186,11 @@ fhandler_fifo::take_ownership ()
       return;
     }
   set_pending_owner (me);
+  /* Wake up my fifo_reader_thread. */
   owner_needed ();
-  SetEvent (update_needed_evt);
+  if (get_owner ())
+    /* Wake up owner's fifo_reader_thread. */
+    SetEvent (update_needed_evt);
   owner_unlock ();
   /* The reader threads should now do the transfer.  */
   WaitForSingleObject (owner_found_evt, INFINITE);
-- 
2.27.0

