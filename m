Return-Path: <kbrown@cornell.edu>
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2112.outbound.protection.outlook.com [40.107.223.112])
 by sourceware.org (Postfix) with ESMTPS id AFBCF386186E
 for <cygwin-patches@cygwin.com>; Tue,  4 Aug 2020 12:55:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org AFBCF386186E
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbtd0EDrhpN/r5OlBQXzSo1OboR18aN6MZa0obM+tVnG+cf1myDWPCL70vn2DTH/5VYlnbAfKFBZGDdag1648F7lvoNF7yMhNM/XfAW7zucFNtm/C9ag7i/90x5EBv31mt6s6euB/dEQq8jnAqRSUymMAA1fCviUpDeWHNHTsrxBy6JH3+TwNK3PqGwdIwYo2ReKqoBfEi+q0UaXjrmXBr4rbKPsjB2Ku/VGcsrd+UImy714GjJs3foN6MXpbo7g4CJbsAyAwEdItuYFaGrD4KZYblkKHqg4M6/n8NpnUFykvyCkHMpwKQiPPZzsvmxYmny/1Ye1FMbucoM6j3MEpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22J6op8M5/NzuV1kso5A4aqI6Rz8SL7iQCHuVMn3TUE=;
 b=iEsbcGWnX2LDZBL2jcHyphxhZ+jCTSQX/Ggc+qXGCdW42HPOrkbbVywftf43+4bU/+mIO2BCqAAz9vh8Q++1aODFBXyLN4GxP7i8hqcYz8k4AQgcS6lqK0wjT9faS0U2hWbvI0M5+fVwJ7OwgejDEnEfraDXdGyVoTwLhymOAM0ZRqROdkjM5lOMbKIrgqCqwhsFmDtAyEE7QO6h87QYYL8Ks8Be/TFjuKGtD/0/GU433Evbn2G2W1lzLu5kxpyjbQ6DFP7WM80FDB7GcozW+Q+I2hme9pwHo6UaIsMQLfP8JGnoki4ZvNr+RC9DbR5gAwWRmStcCf790539YJRF6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5903.namprd04.prod.outlook.com (2603:10b6:208:a4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Tue, 4 Aug
 2020 12:55:25 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a%7]) with mapi id 15.20.3239.021; Tue, 4 Aug 2020
 12:55:25 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/8] Cygwin: FIFO: fix timing issue with owner change
Date: Tue,  4 Aug 2020 08:55:01 -0400
Message-Id: <20200804125507.8842-3-kbrown@cornell.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200804125507.8842-1-kbrown@cornell.edu>
References: <20200804125507.8842-1-kbrown@cornell.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:208:d4::37) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2604:6000:b407:7f00:8093:2a79:7de:1dbd)
 by MN2PR04CA0024.namprd04.prod.outlook.com (2603:10b6:208:d4::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Tue, 4 Aug 2020 12:55:24 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [2604:6000:b407:7f00:8093:2a79:7de:1dbd]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 778ef776-28b5-498a-814c-08d83875a7a6
X-MS-TrafficTypeDiagnostic: MN2PR04MB5903:
X-Microsoft-Antispam-PRVS: <MN2PR04MB59031E5F8EA42F70AB81C76FD84A0@MN2PR04MB5903.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sfrX9V4lwllS8f6O+p3dnpCA6lFkTSODNCJuGXxaeJM/8rF35WPZYjXlPvGchX5SwYzhtDtGaCqiEWD8HA33FyFedx0fPX8spxlloYXteVL6hcuxZ90ghgFWImA3QGscZ6N8BoLZkHY6Ya6r7x2kpm9h95UGW9eHPrMy0PIv2hGYiTyu1uaYFHMb6TPx0c11evW/UQa3qPWZTCb8G6Hst1X6fQqpK7bRreoUKYn4I5d1QIKB/NL7FBRS/HvTaKUc3ypQwTQLaZIrExBrAOWmWQHgTtwBwLRQ0gaxo0n7ULNDjKnXQ7Xx1oryqn+vBkjvJCerE9qEY7hoM9FePstyURgQ2o+BhLsESSgtsyYNG9i68/PO8lltjPmkHXS1RaiJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(2906002)(5660300002)(786003)(316002)(6666004)(6506007)(66946007)(86362001)(8676002)(6512007)(16526019)(186003)(1076003)(75432002)(2616005)(83380400001)(478600001)(66556008)(52116002)(69590400007)(6486002)(6916009)(36756003)(8936002)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: pdiRnyZd9kbwLXRjVpB2VQ4gWJHc5jNacc4Q76C43tjsY7DxarpFpJDgyPd/g9vhvQB/qp/w4jLXlrA+eemWMUVhfq8O9o01Q10jaU0YSj0yXXvCAqlA6hrRC67/rQa39pyx5nFyfS5v4o6N0JMXQEI0WQ6qYKT2504Ky5+h5u55pq2glcYo1Ied9AkLvsNCshJfKlaIkoQQUnuxQingqlLboVaDFLKVCFxy8Jh68a/w4VEZQMi2yc9wELm2n9DeGu1Br5PlKusF688GrR3BdRYIRGiphHO0Jvg7rCdOm2X9OGn5S1KdF+SQsDIR5xy/bh8azg+yiC4mNlzm6rJcTQZKmdzNpN6xtJ6MqW9CgyUCiEcdHNLhIiE/qVjvBckSoGuxI4WG3xgZA3r5JhLxP2k6gGYQbjhZYPsiUlHis1qR9YrZVeM63mEpxI/7ST804FiJvTTVJ6m5wJFKzC4YvFhEPXyXDYXIKKVAZ1ud45dV30w7YtFqFartvaKbgEHUwf99ySfPYVaChsq5QudaZe2DPEqmqo2GTJU2QGcuJ8pYau5O/DoLRNizm1z7t3R5Me+QvtwhVy6danIwB95Z2I3Sa2QP6pU9U6mYRN3uPGkAVRnAwrJNaDd72TE67t4WQSgSdA/ufnI7JZrskEovAkSPKr6Xwk7sg1WXtyMP08OTPkLWU8UJYkR8pOQcET+iGEws60/PpRWbPegZeFK/QA==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 778ef776-28b5-498a-814c-08d83875a7a6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2020 12:55:25.0889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jVGH4uDoc2rKOkmzAWeXwV3sUrvpM7CPhSWrQPKT+dHuBsdgrNlIAv4RGKiuqJSCRdiE43TIxrijmc+kM2RDLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5903
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Tue, 04 Aug 2020 12:55:29 -0000

fhandler_fifo::take_ownership() tacitly assumes that the current
owner's fifo_reader_thread will be woken up from WFMO when
update_needed_evt is signaled.  But it's possible that the the current
owner's fifo_reader_thread is at the beginning of its main loop rather
than in its WFMO call when that event is signaled.

In this case the owner will never see that the event has been
signaled, and it will never update the shared fifo_client_handlers.
The reader that wants to take ownership will then spin its wheels
forever.

Fix this by having the current owner call update_shared_handlers at
the beginning of its loop, if necessary.
---
 winsup/cygwin/fhandler_fifo.cc | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index ee7f47c0c..7b87aab00 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -472,17 +472,34 @@ fhandler_fifo::fifo_reader_thread_func ()
 
       if (pending_owner)
 	{
-	  if (pending_owner != me)
+	  if (pending_owner == me)
+	    take_ownership = true;
+	  else if (cur_owner != me)
 	    idle = true;
 	  else
-	    take_ownership = true;
+	    {
+	      /* I'm the owner but someone else wants to be.  Have I
+		 already seen and reacted to update_needed_evt? */
+	      if (WaitForSingleObject (update_needed_evt, 0) == WAIT_OBJECT_0)
+		{
+		  /* No, I haven't. */
+		  fifo_client_lock ();
+		  if (update_shared_handlers () < 0)
+		    api_fatal ("Can't update shared handlers, %E");
+		  fifo_client_unlock ();
+		}
+	      owner_unlock ();
+	      /* Yield to pending owner. */
+	      Sleep (1);
+	      continue;
+	    }
 	}
       else if (!cur_owner)
 	take_ownership = true;
       else if (cur_owner != me)
 	idle = true;
       else
-	/* I'm the owner. */
+	/* I'm the owner and there's no pending owner. */
 	goto owner_listen;
       if (idle)
 	{
@@ -1212,7 +1229,7 @@ fhandler_fifo::take_ownership ()
   /* Wake up my fifo_reader_thread. */
   owner_needed ();
   if (get_owner ())
-    /* Wake up owner's fifo_reader_thread. */
+    /* Wake up the owner and request an update of the shared fc_handlers. */
     SetEvent (update_needed_evt);
   owner_unlock ();
   /* The reader threads should now do the transfer. */
-- 
2.28.0

