Return-Path: <kbrown@cornell.edu>
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2112.outbound.protection.outlook.com [40.107.223.112])
 by sourceware.org (Postfix) with ESMTPS id 2F7FF384B806
 for <cygwin-patches@cygwin.com>; Tue,  4 Aug 2020 12:55:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 2F7FF384B806
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfcVG7V04P+T3WH4PSGuDYz0GzhUuXbCe9aJY/yaTSD1FxzVp2onMWytmJkQOV91gE/OG/zDZB3Q1YWUqwuD+uEYNFsi/QFMsKsqGXtVXosUQpbS35vfJQEOkcimRdf1EUJ3gAtVOBuFkU4shqSMCyMr93IQBIlURmInQpjaYrSHzWasI1BR8owdRtzdMDk1Odi0TUqUnQNncMuQBoovI6jdZLXuoa2RfxTZcINnYHdax+iDOthbJL1Xj0NFFLWY20PPJjIkPulQM9pbfbvnKO5kJ00tvLrYC3OJDJI2F7fLEA78e7X1/+iOXnE7X3QuGxp09PzZrniOEQO6msXkYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHQRLZ4LhQq5ZJ+rYJWxSyEdJUH/g5Ljc0xHDnjzPOE=;
 b=HB7IP4VPSS9880yV57u4hC/IeQOFn+839kN2Pa1NzJVsvkAj/9gXbgFHB5bPv8j+EmZrCkhhgI13kX0NCFq4uaxRLUP0T8fxQWRFcLkBKWWUM/K+OqirgQ9ZOC6r+TxaKabp92xBnXT1qd3qBHttpVM+paLmASOiXnLTxP6k5Ir1/VsxokYiQ0SF26D+oNpBkEWASIHPpo2i9/mJb5Ea9PvQ+zRyUBq4nxj24Hkhv6oZESmroKbCEsHb1GhQNjwU+uoPQ7pTYXdRvi9f0MUXxuomawrmSVdza7l8YTq0/TgMT+Y3BXX6nwOc4P0DIejG0P+4IK1sWsTpHOXBfJ/JQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5903.namprd04.prod.outlook.com (2603:10b6:208:a4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Tue, 4 Aug
 2020 12:55:28 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a%7]) with mapi id 15.20.3239.021; Tue, 4 Aug 2020
 12:55:28 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 7/8] Cygwin: FIFO: fix indentation
Date: Tue,  4 Aug 2020 08:55:06 -0400
Message-Id: <20200804125507.8842-8-kbrown@cornell.edu>
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
 Transport; Tue, 4 Aug 2020 12:55:28 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [2604:6000:b407:7f00:8093:2a79:7de:1dbd]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9e72bb0-82cc-41c2-da54-08d83875a9be
X-MS-TrafficTypeDiagnostic: MN2PR04MB5903:
X-Microsoft-Antispam-PRVS: <MN2PR04MB5903594A3694E29B6DA19406D84A0@MN2PR04MB5903.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: suts9AhKjsAsquX/jmW8dENeknqNO4MzLKHt7XGjdajlzVHLZJZKCiYQRjxtDk7NY/uxec4W6LfTDlNdaWc59gMAANtK2fFEUpFAxPb215HvZIhdHftO18DgtJRHLLnSDtPAwAWhu2Fax4HKFq7iAbZjzhDS34AL2he3wWpjukolDEYJtFEMwkfOjGrcnldvXj/qrLn2SDRo4IPxZ5tnVXpCcVadnicV3WBJp+5XdyPkku3jD5UnG/IndWg6XeH10YqeBxTK+h1GwL5vZiJpWYmEFssEm+RP9rqTTaScdezT0KenkRYuuhFCLsiiWC0ODfsoOYvPTt391s9vxVk2YpZzsZPS7sIS8HqZw/WCpNChOde5F5OKvfbsRIzM/PbN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(2906002)(5660300002)(786003)(316002)(6666004)(6506007)(66946007)(86362001)(8676002)(6512007)(16526019)(186003)(1076003)(75432002)(2616005)(83380400001)(478600001)(66556008)(52116002)(69590400007)(6486002)(6916009)(36756003)(8936002)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: akhbSYA87y4eMwmEHQfifmUSjehKpJiWfaLZ4IsGWi3bgfUvOVmyyvA4Z4ldF/XaFR8joZsO2GuL5Bfzsat7p51SUtoNZO4Nu4SzBTXKdDCpugK3ycHA62GpbHgbsYMn2meeNFafh1nxVwU6oAZpylWHOCLx8M6gms5iSIITnuT1hCItmGltEyOlLMnQH19dD715akvP0yies15dEC70VNDim22j/nqujfCRgmcKqw/4KdcJQLPiw9OgvZ8BVPy7d3sm8oVhrjp5gLa/kn5mcFdoXq5Yd/PHkM7B3oJtVmRHzXXaXwz556y0iT8ySPtP+ILcklXmQXGLvQHU7RS8UAhRB+xk2iJ0+ZqrkimG1GcmTZ6lNlXr/i2KSPPJb4Tc4kSZzEnvR1uVJAE1qwyaHhdOuQ2AiBwqjD8CfU3cNdKEhmyTedT+VMFPgx5kK/8aogirso6kAh6NfMuCPLeR5qwdJgYA9beT6UvowzqnJilzOd39MzfW+yRKus5Q+7TbEOmexHCLaABeIIyoAZ6mTsTjDlq59/ejYWmudQOrrWjMgsOh2YmYsIhSjkiusTOLYiMyODzCHxX6hXyA67rODoDwm1vJlQfR6KDOjZneGbSgSsJk5KgugW+m5JABcpb6YVa8RcyM3sroCivrVhhrTtUzQfrbTzsOYuKVysanQGfBtqbuoDRWxyNVfm5mPAc8+c35KsErhzMM/8H6j0NfSQ==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e72bb0-82cc-41c2-da54-08d83875a9be
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2020 12:55:28.6179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RxW7b4d3fQVUqd6hz7Xj/4K8TkKmneiuvmEF61s8f3Lo/8Jm2bKl7J2KrbEcIvOHuieoFxJ3Irhs46GvJxkusw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5903
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Tue, 04 Aug 2020 12:55:34 -0000

---
 winsup/cygwin/fhandler_fifo.cc | 96 +++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index 2b829eb6c..017d44e54 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -619,56 +619,56 @@ owner_listen:
 	/* select.cc:peek_fifo has already recorded a connection. */
 	;
       else
-      {
-      switch (status)
 	{
-	case STATUS_SUCCESS:
-	case STATUS_PIPE_CONNECTED:
-	  record_connection (fc);
-	  break;
-	case STATUS_PIPE_CLOSING:
-	  debug_printf ("NtFsControlFile got STATUS_PIPE_CLOSING...");
-	  /* Maybe a writer already connected, wrote, and closed.
-	     Just query the O/S. */
-	  fc.query_and_set_state ();
-	  debug_printf ("...O/S reports state %d", fc.get_state ());
-	  record_connection (fc, false);
-	  break;
-	case STATUS_THREAD_IS_TERMINATING:
-	case STATUS_WAIT_1:
-	  /* Try to connect a bogus client.  Otherwise fc is still
-	     listening, and the next connection might not get recorded. */
-	  status1 = open_pipe (ph);
-	  WaitForSingleObject (conn_evt, INFINITE);
-	  if (NT_SUCCESS (status1))
-	    /* Bogus cilent connected. */
-	    delete_client_handler (nhandlers - 1);
-	  else
-	    /* Did a real client connect? */
-	    switch (io.Status)
-	      {
-	      case STATUS_SUCCESS:
-	      case STATUS_PIPE_CONNECTED:
-		record_connection (fc);
-		break;
-	      case STATUS_PIPE_CLOSING:
-		debug_printf ("got STATUS_PIPE_CLOSING when trying to connect bogus client...");
-		fc.query_and_set_state ();
-		debug_printf ("...O/S reports state %d", fc.get_state ());
-		record_connection (fc, false);
-		break;
-	      default:
-		debug_printf ("NtFsControlFile status %y after failing to connect bogus client or real client", io.Status);
-		fc.set_state (fc_error);
-		break;
-	      }
-	  break;
-	default:
-	  debug_printf ("NtFsControlFile got unexpected status %y", status);
-	  fc.set_state (fc_error);
-	  break;
+	  switch (status)
+	    {
+	    case STATUS_SUCCESS:
+	    case STATUS_PIPE_CONNECTED:
+	      record_connection (fc);
+	      break;
+	    case STATUS_PIPE_CLOSING:
+	      debug_printf ("NtFsControlFile got STATUS_PIPE_CLOSING...");
+	      /* Maybe a writer already connected, wrote, and closed.
+		 Just query the O/S. */
+	      fc.query_and_set_state ();
+	      debug_printf ("...O/S reports state %d", fc.get_state ());
+	      record_connection (fc, false);
+	      break;
+	    case STATUS_THREAD_IS_TERMINATING:
+	    case STATUS_WAIT_1:
+	      /* Try to connect a bogus client.  Otherwise fc is still
+		 listening, and the next connection might not get recorded. */
+	      status1 = open_pipe (ph);
+	      WaitForSingleObject (conn_evt, INFINITE);
+	      if (NT_SUCCESS (status1))
+		/* Bogus cilent connected. */
+		delete_client_handler (nhandlers - 1);
+	      else
+		/* Did a real client connect? */
+		switch (io.Status)
+		  {
+		  case STATUS_SUCCESS:
+		  case STATUS_PIPE_CONNECTED:
+		    record_connection (fc);
+		    break;
+		  case STATUS_PIPE_CLOSING:
+		    debug_printf ("got STATUS_PIPE_CLOSING when trying to connect bogus client...");
+		    fc.query_and_set_state ();
+		    debug_printf ("...O/S reports state %d", fc.get_state ());
+		    record_connection (fc, false);
+		    break;
+		  default:
+		    debug_printf ("NtFsControlFile status %y after failing to connect bogus client or real client", io.Status);
+		    fc.set_state (fc_error);
+		    break;
+		  }
+	      break;
+	    default:
+	      debug_printf ("NtFsControlFile got unexpected status %y", status);
+	      fc.set_state (fc_error);
+	      break;
+	    }
 	}
-      }
       if (ph)
 	NtClose (ph);
       if (update)
-- 
2.28.0

