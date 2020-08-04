Return-Path: <kbrown@cornell.edu>
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2134.outbound.protection.outlook.com [40.107.223.134])
 by sourceware.org (Postfix) with ESMTPS id 81CD438618E8
 for <cygwin-patches@cygwin.com>; Tue,  4 Aug 2020 12:55:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 81CD438618E8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pdw0kkyVGQZegVwpxaVjdloGNUGnCsRMOquYLnex2fmVEBmYYpxiPQH9f2Pz4St9ZtPaYBxas/5PxfoZjr2XrsefJdaJnnZLkPB3482FOuL7aOfE/+6DkbfqHff383YvCmEsHolanUEOsocDfwwcAfR1GknHiZkGfSO3trbKzFE5WLZHO5A+dUxO2ICoQXCTJx8De/84H95G5pTFk90Jgtu97RsRgbDQJmD5FcWbrqFtE++bu4T+nH5afmGWiEQHAQNgyWINre47wujzPHWEaqWnDW+LbIccr+QRnVWhGsfSnnElRmuQFqTrUPS515/sPXHTuUQ6DzRlJqkz7VwXdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYOdmBpb4p4Ke/Lh1sYuFitYZrRwcaw3HnFMqdcTNrU=;
 b=WW3Wa871DE/PMxcAnfL02RK9FBtEdUBU9BKEe/qZM+k6Fm+f+P6ykgoYpAjfMXEHPWOWsRgHDELuNp2M7YB93tpQ1sv2N3G/l6CxJE3CQpSi0N1bjwsngk0qChuzq3JYGdQNt6PlBFEjzTtuYGZTiRF/EUmCtfS2f7VqJWlTPc1dJbzWtQLiGAvnxXZCFaE7cu7aJQzNBqNMWE1PxzKoHDosne7LB34bpzdm7DMp6GBjvueej1bqU+wXn/lpnPw4hR/Pejhpp210m9YNHPGgfvzrsS6Pj54ITu9NGBLI0IBzNlhoisymb2vXaJkM+QRj34b0zJ1hUmR2odWv4Cjoew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5903.namprd04.prod.outlook.com (2603:10b6:208:a4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Tue, 4 Aug
 2020 12:55:29 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a%7]) with mapi id 15.20.3239.021; Tue, 4 Aug 2020
 12:55:29 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 8/8] Cygwin: FIFO: add a third pass to raw_read
Date: Tue,  4 Aug 2020 08:55:07 -0400
Message-Id: <20200804125507.8842-9-kbrown@cornell.edu>
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
X-MS-Office365-Filtering-Correlation-Id: 966cae7a-896e-4590-944a-08d83875aa46
X-MS-TrafficTypeDiagnostic: MN2PR04MB5903:
X-Microsoft-Antispam-PRVS: <MN2PR04MB5903D82B167205534ECC3B0CD84A0@MN2PR04MB5903.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zmRka00istvD4/lJ/78trmQZ3r68/qD6nCN5yG4tTPMXoepBsNnEmtx60kjaBwPyqzPvkOjtdcfAjNNqkbKDPE/REYmFjwx6SMrLUH9gfJ0qFGKTsZGG3ecHQMXYrh1ub4FpBxD4WfdEdxGCVo0d5DswwjnHRyr84Je5CuVFRJB+/07SztQLZ1SW+rVLxTfL6qWKyVhP8XzkMF1dhuetphRBxurIJ4r1RMXH6rs7ykDcB3s/3q1+RzaLWOeIMCc0jrmOlRGcCd7t5CjKGJUYaXj9VrG09QVkbrjzwBZsXQT1KwG1SZ+4Sfb8i96UGM2iVHsf4Yol+NiH7SK3Shgcn2NIkTFuRIM8uwBfiHa2yn+9C1zrSo6frZ+Kgif00ioj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(2906002)(5660300002)(786003)(316002)(6666004)(6506007)(66946007)(86362001)(8676002)(6512007)(16526019)(186003)(1076003)(75432002)(2616005)(83380400001)(478600001)(66556008)(52116002)(69590400007)(6486002)(6916009)(36756003)(8936002)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: GtixH84T04nAHeM9MgPwNBPz/BsckeRGQAP/SOJfCKUrugO4IWK3Ciz6IrrUZ9rFPG+jJrgncVHBW7cZEHKcpcn4kDyui8ngWoBHzWerB3MFLesBIMKP5ZZfhrTv7LvlNKJN06UkM/2NMKLv0/Ul28O3uOZVhmwde5g0Obvm9DCqzIrgjGnRgT6ZMMIO32Pkz8srFpCxiOHus/3OaCIaJujHGDs4Ac/ilc6ZyS2GdwoQV8o1qDmCRTm5JVJ74Rnp2e5h9GRRxOHqAiDN9OUtxYgj+tRUxqWgjrV9cslfz7/piFRQ4BxDL8fmCaJmFZmYDGXEZC3VBbUXSMtdD9KNo9wLI7w4143EB/40QW+Sr5KatjEYeZDK57RRcjGDuq26JqdaXEHs18swo/MRk4bOSu9nw38vESAxpYtYgTyXGuzswc1f0ECzsxRUmnvS5n8I6/oBYJsNaAJ1lAW4snExivPd8N6MifYCxIyxPEqm/2P6nqhVyYN9ORxzDLnHfc51RD9sTs2YvGQxrBZ33w6l4dol9T8OLf0gz3QzWtRkfSujYZLRbyhcJ9ovk7tUN5XyEE0IpOn7TyksvEV3oZZZQvNE3g/cFAPtnAlTSnZuREBo1rQ1AKXXIcks8LtiH5e45D1EzqeTfnciHHa14A8Jp4tBfcqTQ+XlwIQ9bc0Ln1aCyCoh1wOWM0GbHndS/T7y2hSVEQdNqTyDNdvRIdedkw==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 966cae7a-896e-4590-944a-08d83875aa46
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2020 12:55:29.4754 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q68cBGTyVK+pPnQT41GrGEsXB+ZI6wEtyZM8iJubfeRD60fclxYiPN1W1S+fpwmvLb+zpFOIW1OfQyPkmBkbrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5903
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, JMQ_SPF_NEUTRAL,
 MSGID_FROM_MTA_HEADER, RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS,
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
X-List-Received-Date: Tue, 04 Aug 2020 12:55:34 -0000

Currently raw_read makes two passes through the list of clients.  On
the first pass it tries to read from the client from which it last
read successfully.  On the second pass it tries to read from all
connected clients.

Add a new pass in between these two, in which raw_read tries to read
from all clients that are in the fc_input_avail case.  This should be
more efficient in case select was previously called and detected input
available.

Slightly tweak the first pass.  If a client is marked as having the
last successful read but reading from it now finds no input, don't
unmark it unless we successfully read from a different client on one
of the later passes.
---
 winsup/cygwin/fhandler_fifo.cc | 66 ++++++++++++++++++++++++++++++----
 1 file changed, 60 insertions(+), 6 deletions(-)

diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index 017d44e54..a33c32b73 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -1318,17 +1318,30 @@ fhandler_fifo::raw_read (void *in_ptr, size_t& len)
       if (take_ownership (10) < 0)
 	goto maybe_retry;
 
-      /* Poll the connected clients for input.  Make two passes.  On
-	 the first pass, just try to read from the client from which
-	 we last read successfully.  This should minimize
-	 interleaving of writes from different clients. */
       fifo_client_lock ();
+      /* Poll the connected clients for input.  Make three passes.
+
+	 On the first pass, just try to read from the client from
+	 which we last read successfully.  This should minimize
+	 interleaving of writes from different clients.
+
+	 On the second pass, just try to read from the clients in the
+	 state fc_input_avail.  This should be more efficient if
+	 select has been called and detected input available.
+
+	 On the third pass, try to read from all connected clients. */
+
       /* First pass. */
       int j;
       for (j = 0; j < nhandlers; j++)
 	if (fc_handler[j].last_read)
 	  break;
-      if (j < nhandlers && fc_handler[j].get_state () >= fc_connected)
+      if (j < nhandlers && fc_handler[j].get_state () < fc_connected)
+	{
+	  fc_handler[j].last_read = false;
+	  j = nhandlers;
+	}
+      if (j < nhandlers)
 	{
 	  NTSTATUS status;
 	  IO_STATUS_BLOCK io;
@@ -1349,6 +1362,8 @@ fhandler_fifo::raw_read (void *in_ptr, size_t& len)
 		}
 	      break;
 	    case STATUS_PIPE_EMPTY:
+	      /* Update state in case it's fc_input_avail. */
+	      fc_handler[j].set_state (fc_connected);
 	      break;
 	    case STATUS_PIPE_BROKEN:
 	      fc_handler[j].set_state (fc_disconnected);
@@ -1358,10 +1373,47 @@ fhandler_fifo::raw_read (void *in_ptr, size_t& len)
 	      fc_handler[j].set_state (fc_error);
 	      break;
 	    }
-	  fc_handler[j].last_read = false;
 	}
 
       /* Second pass. */
+      for (int i = 0; i < nhandlers; i++)
+	if (fc_handler[i].get_state () == fc_input_avail)
+	  {
+	    NTSTATUS status;
+	    IO_STATUS_BLOCK io;
+
+	    status = NtReadFile (fc_handler[i].h, NULL, NULL, NULL,
+				 &io, in_ptr, len, NULL, NULL);
+	    switch (status)
+	      {
+	      case STATUS_SUCCESS:
+	      case STATUS_BUFFER_OVERFLOW:
+		if (io.Information > 0)
+		  {
+		    len = io.Information;
+		    if (j < nhandlers)
+		      fc_handler[j].last_read = false;
+		    fc_handler[i].last_read = true;
+		    fifo_client_unlock ();
+		    reading_unlock ();
+		    return;
+		  }
+		break;
+	      case STATUS_PIPE_EMPTY:
+		/* No input available after all. */
+		fc_handler[i].set_state (fc_connected);
+		break;
+	      case STATUS_PIPE_BROKEN:
+		fc_handler[i].set_state (fc_disconnected);
+		break;
+	      default:
+		debug_printf ("NtReadFile status %y", status);
+		fc_handler[i].set_state (fc_error);
+		break;
+	      }
+	  }
+
+      /* Third pass. */
       for (int i = 0; i < nhandlers; i++)
 	if (fc_handler[i].get_state () >= fc_connected)
 	  {
@@ -1378,6 +1430,8 @@ fhandler_fifo::raw_read (void *in_ptr, size_t& len)
 		if (io.Information > 0)
 		  {
 		    len = io.Information;
+		    if (j < nhandlers)
+		      fc_handler[j].last_read = false;
 		    fc_handler[i].last_read = true;
 		    fifo_client_unlock ();
 		    reading_unlock ();
-- 
2.28.0

