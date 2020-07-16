Return-Path: <kbrown@cornell.edu>
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2091.outbound.protection.outlook.com [40.107.94.91])
 by sourceware.org (Postfix) with ESMTPS id 193303857C7A
 for <cygwin-patches@cygwin.com>; Thu, 16 Jul 2020 16:19:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 193303857C7A
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2jLOHg2844kMDh25DsgUCkoAduLd7VZojC5CQ0RniVS3w+Ao6GP7cN6VZ8q8l1Thhgaj4lTuB1YUiFQoNoapcqg2W9W1mBMZ9AXNnwZGtIayWTUXmuM6wbUnB8fmI1cwvM2Hd+vBh8171lEPZzUEEsDh365vg0HDrQCIdJeq3GH913lWiH1jFCoblQQI3Kde2Dej5LOkM55/7Ie6bDke6At7X5NziJ8+r9dRdDeKg5j4Wkwaz7x70ub+ePLJXuvLnb6/Fx30dSAbLXwqn92pJv/FkgFeJ6sLIMxsGrzUHY/Ul2xuEQj5HCtrI0OwgJOnnZlSYvOjoaqRqG7DC8Alg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DgR2CF0XQAxxiXyVt4x3aTqsC7iSyowsfc8HRobB4s=;
 b=Ugs53YxyYWPNmBfZv+/l9uVRWOjXMOAserkhLAVD3R4X1YzN+16CrHyqC23ci04qAev3g5/4Mk+Uz7wWcbWvhtn23aA5vGwplGoL8alOHUoPAdIIxCezK2RU/Ak8P/BxmR4/atyytGe170FkrFZ3Shk6LLGOUVFLT3llgbzyeXSG7Lozu7+Oo6C13tJkUq3k/vJxNJifBU6xb3r3eYtDBFH/8fFHuEpCRUXMxHaApnKwVF8ZQ2W9g70DFCMG8wZVxTr41Xe2fIIQBsk/38AFlqf3O2qfYyyZiDiCqW0ilD7gbNAd9qlgGg0EBRYDThwI10yXCrv4EiDMJzg6GicyZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB6112.namprd04.prod.outlook.com (2603:10b6:208:e0::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 16 Jul
 2020 16:19:36 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a%7]) with mapi id 15.20.3174.025; Thu, 16 Jul 2020
 16:19:36 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 06/12] Cygwin: FIFO: fix indentation
Date: Thu, 16 Jul 2020 12:19:09 -0400
Message-Id: <20200716161915.16994-7-kbrown@cornell.edu>
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
 Transport; Thu, 16 Jul 2020 16:19:35 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [68.175.129.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ce1c34a-1fea-45d0-1884-08d829a4082c
X-MS-TrafficTypeDiagnostic: MN2PR04MB6112:
X-Microsoft-Antispam-PRVS: <MN2PR04MB611236C41FF11F4B79FF268AD87F0@MN2PR04MB6112.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cub0uborw5U1W0TrE2xLoy96NIp/V3m/Ou01MTF4Vnh7Dd4v/h9HEJbGUISIlSgzXBQsZkUvF1GZ7goGRfIG4Hh7PslVLjcSHiRBdhgGZWNs/hrfpA/cTSxSX3nFIQAmV+IrobSEf0HLV70OfAADYVnVB/E8bbNwYKMe2/gd76si6tdxr93jJmYIXfyHQRpSui3cVYub53MUrCLyK6uosSdr4uIsol5CsWrVbfV124hHnlUoczsDZVRwdsM7k3sh3PpklH9hjMgInYyLoM6pF48vhpEbj3+b0qUGSxPI2NES4wio2JxxreajRHOipGa9q8XDdghhiD2SK0Ixbi33r28AlV3d44e6zbuqm58dKk+uo/sUApnQPs+2BEZgOwRj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(66946007)(2616005)(66556008)(5660300002)(69590400007)(6506007)(8676002)(83380400001)(16526019)(956004)(6486002)(6512007)(52116002)(186003)(26005)(8936002)(66476007)(478600001)(2906002)(86362001)(316002)(786003)(75432002)(1076003)(6666004)(6916009)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: llPIdyY1Q2DDXSFy2KNnpRD+N3OXub/7p3K+g/ek0/smCH2JWwH0l4LTGALVGq1VL0ri+oHKXkout0KpKsGiIHMvHn+AEYm8DMA8a8wyfhwXw5F9WqirR3FiEY9JZTU0lNPpbVOMkv1Oyxcl5ymqFweYQ7+g8ym0/dPBhJQF+ja7A1E4utUJN2XBvDdaa+ELBwDF1bCOAINkg8KOzKohP+K4P90kVypLX9orHfCahhl7ZrY3q+7kPQX1aoqCNhPXgDGgrEftq3OGAMgs2KOGrwFPcYXq1QH6DF9BYjWrdO6cvmFX2df8wYm8GdE9OvY2ywh0iE3QUnu38EeuArucPXA+RoXqBPEmMNIhvvzooAVSCryrFEaqsNFt+h9qwKhTOiwNXihX9XdAVHjlzI2Bl47sP8cKWvImIgH2GB+7NG2pVbojQ4koufv2YqJ2Wk1Dj22q71c62O9bSikdi1TImQx4Jm+BZP8gjcoC2KU87p4=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce1c34a-1fea-45d0-1884-08d829a4082c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 16:19:36.2987 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uGq/KFH5HNpY80tdUkcXKCsIysu3XHKeV90NhiF1lx7LhK/hkkmQM+wqFkOl9hl1iYlYcRYxU156BS40KXFPrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6112
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 16 Jul 2020 16:19:44 -0000

---
 winsup/cygwin/fhandler_fifo.cc | 168 ++++++++++++++++-----------------
 1 file changed, 84 insertions(+), 84 deletions(-)

diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index 1fb319fcf..69dda0811 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -501,98 +501,98 @@ fhandler_fifo::fifo_reader_thread_func ()
 	}
 
 owner_listen:
-	  fifo_client_lock ();
-	  cleanup_handlers ();
-	  if (add_client_handler () < 0)
-	    api_fatal ("Can't add a client handler, %E");
-
-	  /* Listen for a writer to connect to the new client handler. */
-	  fifo_client_handler& fc = fc_handler[nhandlers - 1];
-	  fifo_client_unlock ();
-	  shared_fc_handler_updated (false);
-	  owner_unlock ();
-	  NTSTATUS status;
-	  IO_STATUS_BLOCK io;
-	  bool cancel = false;
-	  bool update = false;
+      fifo_client_lock ();
+      cleanup_handlers ();
+      if (add_client_handler () < 0)
+	api_fatal ("Can't add a client handler, %E");
 
-	  status = NtFsControlFile (fc.h, conn_evt, NULL, NULL, &io,
-				    FSCTL_PIPE_LISTEN, NULL, 0, NULL, 0);
-	  if (status == STATUS_PENDING)
-	    {
-	      HANDLE w[3] = { conn_evt, update_needed_evt, cancel_evt };
-	      switch (WaitForMultipleObjects (3, w, false, INFINITE))
-		{
-		case WAIT_OBJECT_0:
-		  status = io.Status;
-		  debug_printf ("NtFsControlFile STATUS_PENDING, then %y",
-				status);
-		  break;
-		case WAIT_OBJECT_0 + 1:
-		  status = STATUS_WAIT_1;
-		  update = true;
-		  break;
-		case WAIT_OBJECT_0 + 2:
-		  status = STATUS_THREAD_IS_TERMINATING;
-		  cancel = true;
-		  update = true;
-		  break;
-		default:
-		  api_fatal ("WFMO failed, %E");
-		}
-	    }
-	  else
-	    debug_printf ("NtFsControlFile status %y, no STATUS_PENDING",
-			  status);
-	  HANDLE ph = NULL;
-	  NTSTATUS status1;
+      /* Listen for a writer to connect to the new client handler. */
+      fifo_client_handler& fc = fc_handler[nhandlers - 1];
+      fifo_client_unlock ();
+      shared_fc_handler_updated (false);
+      owner_unlock ();
+      NTSTATUS status;
+      IO_STATUS_BLOCK io;
+      bool cancel = false;
+      bool update = false;
 
-	  fifo_client_lock ();
-	  switch (status)
+      status = NtFsControlFile (fc.h, conn_evt, NULL, NULL, &io,
+				FSCTL_PIPE_LISTEN, NULL, 0, NULL, 0);
+      if (status == STATUS_PENDING)
+	{
+	  HANDLE w[3] = { conn_evt, update_needed_evt, cancel_evt };
+	  switch (WaitForMultipleObjects (3, w, false, INFINITE))
 	    {
-	    case STATUS_SUCCESS:
-	    case STATUS_PIPE_CONNECTED:
-	      record_connection (fc);
+	    case WAIT_OBJECT_0:
+	      status = io.Status;
+	      debug_printf ("NtFsControlFile STATUS_PENDING, then %y",
+			    status);
 	      break;
-	    case STATUS_PIPE_CLOSING:
-	      record_connection (fc, fc_closing);
+	    case WAIT_OBJECT_0 + 1:
+	      status = STATUS_WAIT_1;
+	      update = true;
 	      break;
-	    case STATUS_THREAD_IS_TERMINATING:
-	    case STATUS_WAIT_1:
-	      /* Try to connect a bogus client.  Otherwise fc is still
-		 listening, and the next connection might not get recorded. */
-	      status1 = open_pipe (ph);
-	      WaitForSingleObject (conn_evt, INFINITE);
-	      if (NT_SUCCESS (status1))
-		/* Bogus cilent connected. */
-		delete_client_handler (nhandlers - 1);
-	      else
-		/* Did a real client connect? */
-		switch (io.Status)
-		  {
-		  case STATUS_SUCCESS:
-		  case STATUS_PIPE_CONNECTED:
-		    record_connection (fc);
-		    break;
-		  case STATUS_PIPE_CLOSING:
-		    record_connection (fc, fc_closing);
-		    break;
-		  default:
-		    debug_printf ("NtFsControlFile status %y after failing to connect bogus client or real client", io.Status);
-		    fc.state = fc_unknown;
-		    break;
-		  }
+	    case WAIT_OBJECT_0 + 2:
+	      status = STATUS_THREAD_IS_TERMINATING;
+	      cancel = true;
+	      update = true;
 	      break;
 	    default:
-	      break;
+	      api_fatal ("WFMO failed, %E");
 	    }
-	  if (ph)
-	    NtClose (ph);
-	  if (update && update_shared_handlers () < 0)
-	    api_fatal ("Can't update shared handlers, %E");
-	  fifo_client_unlock ();
-	  if (cancel)
-	    goto canceled;
+	}
+      else
+	debug_printf ("NtFsControlFile status %y, no STATUS_PENDING",
+		      status);
+      HANDLE ph = NULL;
+      NTSTATUS status1;
+
+      fifo_client_lock ();
+      switch (status)
+	{
+	case STATUS_SUCCESS:
+	case STATUS_PIPE_CONNECTED:
+	  record_connection (fc);
+	  break;
+	case STATUS_PIPE_CLOSING:
+	  record_connection (fc, fc_closing);
+	  break;
+	case STATUS_THREAD_IS_TERMINATING:
+	case STATUS_WAIT_1:
+	  /* Try to connect a bogus client.  Otherwise fc is still
+	     listening, and the next connection might not get recorded. */
+	  status1 = open_pipe (ph);
+	  WaitForSingleObject (conn_evt, INFINITE);
+	  if (NT_SUCCESS (status1))
+	    /* Bogus cilent connected. */
+	    delete_client_handler (nhandlers - 1);
+	  else
+	    /* Did a real client connect? */
+	    switch (io.Status)
+	      {
+	      case STATUS_SUCCESS:
+	      case STATUS_PIPE_CONNECTED:
+		record_connection (fc);
+		break;
+	      case STATUS_PIPE_CLOSING:
+		record_connection (fc, fc_closing);
+		break;
+	      default:
+		debug_printf ("NtFsControlFile status %y after failing to connect bogus client or real client", io.Status);
+		fc.state = fc_unknown;
+		break;
+	      }
+	  break;
+	default:
+	  break;
+	}
+      if (ph)
+	NtClose (ph);
+      if (update && update_shared_handlers () < 0)
+	api_fatal ("Can't update shared handlers, %E");
+      fifo_client_unlock ();
+      if (cancel)
+	goto canceled;
     }
 canceled:
   if (conn_evt)
-- 
2.27.0

