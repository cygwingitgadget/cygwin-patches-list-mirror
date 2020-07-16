Return-Path: <kbrown@cornell.edu>
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2091.outbound.protection.outlook.com [40.107.94.91])
 by sourceware.org (Postfix) with ESMTPS id 6F49F3857C7A
 for <cygwin-patches@cygwin.com>; Thu, 16 Jul 2020 16:19:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 6F49F3857C7A
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/tRalP0JJGDo9L/tmpqRXdgfTTqJDrKC0XTB8wduqNwBqdn3ddDEYFohWn84GPIFHuicPfcuO94uTeMiKX6ptej9O309pPeKtUAhESfpJvchTagru6mO9pM8mmv3IXCJthl6jmzmW6So6j9KQdeXel+LtFCyD3pYct5QbKt0/xnDgQuZaY/+hIiwe1+ycGubtYu5siYak6y5iWyF/9A3Pg7QOjidjx0gtHOcG6vHVhFdVG0SrhuDXzZ/Wexjru0IknxVi+/PfJZ4EjeQs1QPTIFLLohzzdb/8rw4529mxPn98Y4Jh/RJNo/QUVhdQiq7doiUTiaiiA8ChxCsahHsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnVn0XjnpZp5uRTZbNbJ5UFlgYlyxryNdUQWRpWDKPE=;
 b=dlmC/ok+cZM9N9yQfCtVeAF/nQSLbH4KbDIk6xHN02mym574tYYW17x6uPPQVxaTK6/Os4ys5D8wnI8Fey7w0gykNsNi3jy9xNjbOBzGQbiQ6+dS4FVxVKo5bjECV7+4s+wWsL7tj5XToSSgyUg4MR8GguR3q65o37+l8yEPhv3GeK5b3dwV129FlU4ravwy/ZzZnS/dPQRj4dQxcSiY0FPm4JGw0jSaXOoYex3ZaPPO0F51BIfs06jieEdfTg7NR2A5kl7M0mOkmD8wMPxwTcid+7X7IkVXEpeFapFAZrOsKYgEqbUI00toQ7XnWXt7qB7AKDKLLom4wPWB+1IAPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB6112.namprd04.prod.outlook.com (2603:10b6:208:e0::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 16 Jul
 2020 16:19:35 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a%7]) with mapi id 15.20.3174.025; Thu, 16 Jul 2020
 16:19:35 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 04/12] Cygwin: FIFO: reduce I/O interleaving
Date: Thu, 16 Jul 2020 12:19:07 -0400
Message-Id: <20200716161915.16994-5-kbrown@cornell.edu>
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
 Transport; Thu, 16 Jul 2020 16:19:34 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [68.175.129.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5acdd6af-ca4a-4b62-a6be-08d829a4077b
X-MS-TrafficTypeDiagnostic: MN2PR04MB6112:
X-Microsoft-Antispam-PRVS: <MN2PR04MB6112F7030E628DC90BF95219D87F0@MN2PR04MB6112.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RLAIUaC2Ag9/8PreYVPonEdLO00EjziqxZSun5Du9yatfMYtlZ1yobXjaQdmX2LYwT0rQJJIPYgg/pv5ZGYyqPuRexpWkFBt68C4m1BjDsXHpbXDS64Mb0MaF8O10SyxJDBEuj3bSmZ6/EJOFsSbNZnH8Fwq30HqBEXz7ABwDewZlWne4HSRHJTQgZ+gMbpkliBH3yrmGeqyJ8LqTuWxnvJcmpP6ttxJizLiotxRCA9koQ9hff99l3pro8PNd7BFfGO7cuj6cvyK0QE4pZpVhiXr5RXjoVmwOQHEfGcRxfgQPHdHkFo9ieU621yCGH75sQw1gzffLVqraZBJdFNUfAUOZoDSyrzLDj5E2Eut9Fz2CGWteWScQILUmU2Su/aQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(66946007)(2616005)(66556008)(5660300002)(69590400007)(6506007)(8676002)(83380400001)(16526019)(956004)(6486002)(6512007)(52116002)(186003)(26005)(8936002)(66476007)(478600001)(2906002)(86362001)(316002)(786003)(75432002)(1076003)(6666004)(6916009)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ihQDff0KRb+XlckqaMTJ9gOkEz+fj1gfz+dAgY24ARRqNi6cIce9lkx8w5NGtM+fZKmxCg97tIiiPLRoh5Gw/7h1w3bTxm8JJWrA2RlOPQPEvdvIlXYERi6eolTALnHzZLR7lEEGCcKm/J0+Y4SmS86BSP1kWK2ozsavXnx3RvGItcwBOUaSFYP/bGun+cH4VIIHiZRZcOIgIw0cjA7m5QnoRhcknr68S2LeI5WBpDb9vCtuahIWD13tal+bxpJiFzQkjAmb9fSxOlRj/BEeFhEajZq8YZaM5s1OWCjTdE+77ONWsoiJU5ekfKbAIPIdfF2kpxQcVlfjyi3doH7hQuuGrbXF1lbhIzz47TTxKQRh9THy7E5ZUSZnKTb6fkFE9PNxbmcLkpgN6D+jC9M6DHGeiC9t5g6dzsiKcl+2tCGqZAUQjYELPiIu/ULS9BOrFXWZiQhcCPjvt/LtLW5GCR09j6n24DNq2wNyIBCddd4=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5acdd6af-ca4a-4b62-a6be-08d829a4077b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 16:19:35.1863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N1cswR7GBdmIdqQiRig8ujl2aawCGorji4u22B0aj4bvNuzjOYw0Kw4cX7NoJyjFtNhz23YfhFNAXxbf4qIaDA==
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
X-List-Received-Date: Thu, 16 Jul 2020 16:19:43 -0000

Add a bool member 'last_read' to the fifo_client_handler structure,
which is set to true on a successful read.  This is used by raw_read
as follows.

When raw_read is called, it first locates the writer (if any) for
which last_read is true.  raw_read tries to read from that writer and
returns if there is input available.  Otherwise, it proceeds to poll
all the writers, as before.

The effect of this is that if a writer writes some data that is only
partially read, the next attempt to read will continue to read from
the same writer.  This should reduce the interleaving of output from
different writers.
---
 winsup/cygwin/fhandler.h       |  3 +-
 winsup/cygwin/fhandler_fifo.cc | 55 +++++++++++++++++++++++++++++-----
 2 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index b5bfdd0b3..221c856e6 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1298,7 +1298,8 @@ struct fifo_client_handler
 {
   HANDLE h;
   fifo_client_connect_state state;
-  fifo_client_handler () : h (NULL), state (fc_unknown) {}
+  bool last_read;  /* true if our last successful read was from this client. */
+  fifo_client_handler () : h (NULL), state (fc_unknown), last_read (false) {}
   void close () { NtClose (h); }
   fifo_client_connect_state set_state ();
 };
diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index 3685cc0c2..afe21a468 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -404,6 +404,7 @@ fhandler_fifo::update_my_handlers ()
 	  goto out;
 	}
       fc.state = shared_fc_handler[i].state;
+      fc.last_read = shared_fc_handler[i].last_read;
     }
 out:
   set_prev_owner (null_fr_id);
@@ -1200,15 +1201,56 @@ fhandler_fifo::raw_read (void *in_ptr, size_t& len)
       /* No one else can take ownership while we hold the reading_lock. */
       reading_lock ();
       take_ownership ();
-      /* Poll the connected clients for input. */
-      int nconnected = 0;
+      /* Poll the connected clients for input.  Make two passes.  On
+	 the first pass, just try to read from the client from which
+	 we last read successfully.  This should minimize
+	 interleaving of writes from different clients. */
       fifo_client_lock ();
+      /* First pass. */
+      int j;
+      for (j = 0; j < nhandlers; j++)
+	if (fc_handler[j].last_read)
+	  break;
+      if (j < nhandlers && fc_handler[j].state >= fc_closing)
+	{
+	  NTSTATUS status;
+	  IO_STATUS_BLOCK io;
+
+	  status = NtReadFile (fc_handler[j].h, NULL, NULL, NULL,
+			       &io, in_ptr, len, NULL, NULL);
+	  switch (status)
+	    {
+	    case STATUS_SUCCESS:
+	    case STATUS_BUFFER_OVERFLOW:
+	      /* io.Information is supposedly valid in latter case. */
+	      if (io.Information > 0)
+		{
+		  len = io.Information;
+		  fifo_client_unlock ();
+		  reading_unlock ();
+		  return;
+		}
+	      break;
+	    case STATUS_PIPE_EMPTY:
+	      break;
+	    case STATUS_PIPE_BROKEN:
+	      fc_handler[j].state = fc_disconnected;
+	      break;
+	    default:
+	      debug_printf ("NtReadFile status %y", status);
+	      fc_handler[j].state = fc_error;
+	      break;
+	    }
+	  fc_handler[j].last_read = false;
+	}
+
+      /* Second pass. */
+      int nconnected = 0;
       for (int i = 0; i < nhandlers; i++)
 	if (fc_handler[i].state >= fc_closing)
 	  {
 	    NTSTATUS status;
 	    IO_STATUS_BLOCK io;
-	    size_t nbytes = 0;
 
 	    nconnected++;
 	    status = NtReadFile (fc_handler[i].h, NULL, NULL, NULL,
@@ -1217,11 +1259,10 @@ fhandler_fifo::raw_read (void *in_ptr, size_t& len)
 	      {
 	      case STATUS_SUCCESS:
 	      case STATUS_BUFFER_OVERFLOW:
-		/* io.Information is supposedly valid. */
-		nbytes = io.Information;
-		if (nbytes > 0)
+		if (io.Information > 0)
 		  {
-		    len = nbytes;
+		    len = io.Information;
+		    fc_handler[i].last_read = true;
 		    fifo_client_unlock ();
 		    reading_unlock ();
 		    return;
-- 
2.27.0

