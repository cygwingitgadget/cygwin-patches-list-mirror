Return-Path: <kbrown@cornell.edu>
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2112.outbound.protection.outlook.com [40.107.223.112])
 by sourceware.org (Postfix) with ESMTPS id 451E13857C56
 for <cygwin-patches@cygwin.com>; Tue,  4 Aug 2020 12:55:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 451E13857C56
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpvAV1vs4WrgWvpdEb0NDXL3s2vq/vkC9XWoKyoiqNe0TPN/Tbcs+D7oifqlvv/UfupjQJ9t/j8EKgngMGuL8iWslIcGAF/J9eQf9Y4qmk1QBBnHb+NFG7GXm0gRmjUtR9e/VqQro8N3ZQW1Gw8rcf9H2dS6lAqaOtV6yoGOA+mOreZzPZAIU16zPHRg1UcWVcHDBgmfDvAtb3iZ+KB+9HnvbYUfB08vzgdlrPfUH6oEGGEeNsx7nlPn5TrREzHdFSJ2W4zpN7V9tpc0hJspOBdb+VE29qOfROBxwWynyRH6sLyDm0cOMqPKsDVEzPvWOkDLv438W+i/IjM3qc+Aew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8x/D+QaBw8UWc4c6QDemz4tssvKG5LPgbG9jxgrXVRw=;
 b=VwD+KNdFPGCwukGIww12cYxdURrAHrAz5DDPs7X/CH+aS1Oj2j4axo/TL/ulD/YIj1PQRUGTpixrm3pI3M+PGFD9QufNjjc+5EQ51gQrdEuG4AJGctJfbohqEb++nQqSw4ce790DB7wsSTa2x2RDEJ0z/kc6GiYrfp5JzORT1Afoqq1TBbTHEa2979otcRof7fr0HjLA2zteCtB7Rb/mR/b8qFy6gjgQJ8JrPbu8SOsIv0WMxoNhVVh9zBmqIjYLR6bRAvGuewjIwomfI/vBy+9iG06GC7AzWPTSG2LsDwfdEh2BY25q4LNv6huCFmcP5Xh39DdRXKevSwCyMU1sNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5903.namprd04.prod.outlook.com (2603:10b6:208:a4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Tue, 4 Aug
 2020 12:55:24 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a%7]) with mapi id 15.20.3239.021; Tue, 4 Aug 2020
 12:55:24 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/8] Cygwin: FIFO: lock fixes
Date: Tue,  4 Aug 2020 08:55:00 -0400
Message-Id: <20200804125507.8842-2-kbrown@cornell.edu>
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
 Transport; Tue, 4 Aug 2020 12:55:23 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [2604:6000:b407:7f00:8093:2a79:7de:1dbd]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 981692fc-3eb8-4b5b-dc83-08d83875a726
X-MS-TrafficTypeDiagnostic: MN2PR04MB5903:
X-Microsoft-Antispam-PRVS: <MN2PR04MB590319AE45AECEC9ACCAFE3ED84A0@MN2PR04MB5903.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a1lfturCMHu+n57LEZUavgiW0n1asPZQdNxVe9S3J5jw16a6DMRY7iByzXJpyLYk0FZndBTkv6i09QFwfTWHEFoX5+NODC+kMVYkzCJSODrlC5AifXvBjsrnxiWV9ryVdSq90N07jmRvhTb3HsTUpqqaVpB4/ebwXRWMrxuYVhFXK8E9zbYcV5zHy2dvo09J64/jVb4/O+l7Op9IS0MQDnUvAsAFoREmUjcJFfM7TeOBEKL2T9P20pykaeeQ8BDNdU/0hYnPDyMX1eyLxUauiFkHZKgV08TLRx1+xHL4dXIfQL/u8q8J/EwL810rhQMcXPDLeAOzKSJ0Ve10nxEzJ5JGkG4wfbx8KL2U1uaPgEu4RPAEHlLWLKuWtiefDxV4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(2906002)(5660300002)(786003)(316002)(6666004)(6506007)(66946007)(86362001)(8676002)(6512007)(16526019)(186003)(1076003)(75432002)(2616005)(83380400001)(478600001)(66556008)(52116002)(69590400007)(6486002)(6916009)(36756003)(8936002)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: EhQfdttyQud+g/p32/0DGbproSw7Ok2xEdXpqY6FmjoUxcrzNwx5dyLcf5hVatrmMtOd6rr+vt1B/Q2w5YcCCMyJHXC0Hmind7DTlIXO2y0lLVbaFBGV2E0Tu1T/fhIh5ApudkEB5m6tYWNRla/kN48oYp0sc1KeckW6eBlREZFHHDes7EsGTvmZddu+xAzdAYMYsi9LVR213kAHH/gyig0icsOoaQJwYE3AKVaGE8lLibQIiKM4z8gwNXFODDinLfzZyt5RY+prX41RO6lt/5UeoOMBtW10jBJULlwy0BDD7F93M0wWfhjO+vng0JtvJasPji8X0vYJRBTNevGAzi55+G6C8NMRZyjH+SBPdZcsE9JsSnYD3COPJ2rmC4USPf7uIoVbq/Wt+q0VGgbe7++egY1N88u/uQT8We8F9JGXR7zdde0X54NesYyu3X0WSU1UQoenS722R6yHxcTZ4wQG20nhPgQnFfiQo0z7h8jk96HOgbOiLmQIatKBYp92IrmN6TuONd8XH8zcaSwPghDSx7eyVyO7GTXpXpH16C53it0etxG679DhlNEvNNOcCJhBlVl7kjey/uLKoauN0mERcYYT950B77CDHsYpcHZGS+8PDoOOtVNsTjU/tkPslvA/NRvciUHL5X7vTqAVOigfhhcsFIX7q1V6zUfMl3T2hVastAYOJuvqrYP+W5PXc6vWcTUjoJRe5fQLQG+8Nw==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 981692fc-3eb8-4b5b-dc83-08d83875a726
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2020 12:55:24.2844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VcHpFHMc2iZLHLuMVRRXzJKQ3WgXH0w3COjD12yYzzEN89yUa33Pans6WX+4B3rGwflAO0LjanJPx5GwGciRqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5903
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Tue, 04 Aug 2020 12:55:28 -0000

Add some missing locks and remove one extra unlock.  Clarify for some
functions whether caller or callee acquires lock, and add appropriate
comments.
---
 winsup/cygwin/fhandler_fifo.cc | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index e9d0187d4..ee7f47c0c 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -316,6 +316,7 @@ fhandler_fifo::wait_open_pipe (HANDLE& ph)
   return status;
 }
 
+/* Always called with fifo_client_lock in place. */
 int
 fhandler_fifo::add_client_handler (bool new_pipe_instance)
 {
@@ -345,6 +346,7 @@ fhandler_fifo::add_client_handler (bool new_pipe_instance)
   return 0;
 }
 
+/* Always called with fifo_client_lock in place. */
 void
 fhandler_fifo::delete_client_handler (int i)
 {
@@ -354,7 +356,8 @@ fhandler_fifo::delete_client_handler (int i)
 	     (nhandlers - i) * sizeof (fc_handler[i]));
 }
 
-/* Delete handlers that we will never read from. */
+/* Delete handlers that we will never read from.  Always called with
+   fifo_client_lock in place. */
 void
 fhandler_fifo::cleanup_handlers ()
 {
@@ -369,6 +372,7 @@ fhandler_fifo::cleanup_handlers ()
     }
 }
 
+/* Always called with fifo_client_lock in place. */
 void
 fhandler_fifo::record_connection (fifo_client_handler& fc,
 				  fifo_client_connect_state s)
@@ -398,6 +402,7 @@ fhandler_fifo::update_my_handlers ()
   if (!prev_proc)
     api_fatal ("Can't open process of previous owner, %E");
 
+  fifo_client_lock ();
   for (int i = 0; i < get_shared_nhandlers (); i++)
     {
       if (add_client_handler (false) < 0)
@@ -419,10 +424,12 @@ fhandler_fifo::update_my_handlers ()
 	  fc.last_read = shared_fc_handler[i].last_read;
 	}
     }
+  fifo_client_unlock ();
   set_prev_owner (null_fr_id);
   return ret;
 }
 
+/* Always called with fifo_client_lock and owner_lock in place. */
 int
 fhandler_fifo::update_shared_handlers ()
 {
@@ -435,9 +442,7 @@ fhandler_fifo::update_shared_handlers ()
   set_shared_nhandlers (nhandlers);
   memcpy (shared_fc_handler, fc_handler, nhandlers * sizeof (fc_handler[0]));
   shared_fc_handler_updated (true);
-  owner_lock ();
   set_prev_owner (me);
-  owner_unlock ();
   return 0;
 }
 
@@ -509,7 +514,6 @@ fhandler_fifo::fifo_reader_thread_func ()
 	      if (update_my_handlers () < 0)
 		debug_printf ("error updating my handlers, %E");
 	      owner_found ();
-	      owner_unlock ();
 	      /* Fall through to owner_listen. */
 	    }
 	}
@@ -602,8 +606,13 @@ owner_listen:
 	}
       if (ph)
 	NtClose (ph);
-      if (update && update_shared_handlers () < 0)
-	api_fatal ("Can't update shared handlers, %E");
+      if (update)
+	{
+	  owner_lock ();
+	  if (get_owner () == me && update_shared_handlers () < 0)
+	    api_fatal ("Can't update shared handlers, %E");
+	  owner_unlock ();
+	}
       fifo_client_unlock ();
       if (cancel)
 	goto canceled;
@@ -1402,9 +1411,11 @@ fhandler_fifo::fstatvfs (struct statvfs *sfs)
 void
 fhandler_fifo::close_all_handlers ()
 {
+  fifo_client_lock ();
   for (int i = 0; i < nhandlers; i++)
     fc_handler[i].close ();
   nhandlers = 0;
+  fifo_client_unlock ();
 }
 
 fifo_client_connect_state
-- 
2.28.0

