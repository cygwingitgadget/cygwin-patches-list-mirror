Return-Path: <kbrown@cornell.edu>
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2090.outbound.protection.outlook.com [40.107.237.90])
 by sourceware.org (Postfix) with ESMTPS id 56B0C385703A
 for <cygwin-patches@cygwin.com>; Thu, 27 Aug 2020 02:03:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 56B0C385703A
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIE2yZAoXrVbIGDB3oWKGnwOY1j07NKdS9re3y6/qCj1nYOkkzyrxVM9xBV2k9lbu9oNRQ3wNKj3PT1GfzWJAuh8lsj4feKvp3845sIK9IufVupWvCAbgNk63tPzu7xgdadagCM0+2IXarQq02sDAT+eGgqNahaGvYvvztN0IpQH6tiqFmUpEQBUrWDXRJA+TyqmrdgF8FjuA/sUAXtTIkjiaWm9T/ip0rUVt4agzSYvHYZdTRTHQv4sf5pwcJdcfolCMkeUHvBfGczbId1jtUYCzDMq/SjH4pA4gKdf2cJE8jQGbX9yDkpjpxPT1XlAMV9q1pl05BYIOSBYu3MZpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKzl+1dwq+t56A2Bc1QtebFYW+1xocfGcmoFAY80PQ8=;
 b=oSKEFPo7/kn4ObJPMIggvDoDxBuIzdS1jYIICwRjbF1WysLg1equL4vaGNKhmCV676ad2UGENEJNdRVZdbjbRn43wGGERSXzNYaRZyf7C5VvGqjZl/VtREmWmLLlKcSoJbGQHzXYI8oGM91N/fO41VoMc/7Fr+JyoEwq5zzyZt5jEAN4f/3yQr5uMMnyG/p2OtFjbh3Fo8uBmKUkQSTI84e1f+RCqLc2HfOIUYHTcQlzFdw+8lxZ1bU0RkLpemj2Fydaa+a/YjrfPtg6384SoUCKHl6dVuICu0RD3KJMi/M6toTCnb9BmnqvrKMO0Y66uROkaac2Cgtv9mYxdUAN6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5631.namprd04.prod.outlook.com (2603:10b6:208:a4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Thu, 27 Aug
 2020 02:03:28 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a%7]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 02:03:27 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: fhandler_fifo::delete_client_handler: improve
 efficiency
Date: Wed, 26 Aug 2020 22:03:11 -0400
Message-Id: <20200827020311.5450-1-kbrown@cornell.edu>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0051.namprd02.prod.outlook.com
 (2603:10b6:207:3d::28) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 BL0PR02CA0051.namprd02.prod.outlook.com (2603:10b6:207:3d::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 02:03:27 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [68.175.129.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a59fba8-6bbe-4e19-07ed-08d84a2d635e
X-MS-TrafficTypeDiagnostic: MN2PR04MB5631:
X-Microsoft-Antispam-PRVS: <MN2PR04MB5631B607B1831A6EB2783A6DD8550@MN2PR04MB5631.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sdkDuMGnbAQueKAtw6F6eLAba1oNjtx78m1PA7/ajqfQiFIe1DR3Zj6wKzfJVLs2akzpuaQVWD5h8QtdrfW/5Z5I4SWwhlaPgyRzz2qPJj/LB0lgxzNJowdvldRoHsKrdkVuUmdLWtXiioC7BUJnpZ3jqbIK+12mXReNFeoKcp1XDcIinGN6rqKtGMvvd/GH8YYqoJJrjyzNKZU35F3ovTwOcJccyg+0Umve2ZyxCB7GJPEXwYaMGOuZwTLIMLBNiKnzFqzwefEvl++1bPp5YHfrT+yhxeHDiGTFh6Q3w0qgfPI9uXHxX7cFPHEYLeACHxGqv5vicSrcwcJeTuNELA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(86362001)(26005)(66476007)(186003)(66556008)(66946007)(8676002)(16576012)(6916009)(316002)(786003)(6486002)(36756003)(1076003)(5660300002)(478600001)(83380400001)(2906002)(52116002)(4744005)(75432002)(8936002)(956004)(6666004)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ocC3vc+YoblMhR59w8OGTcpP3nYQM4qSqxo0SNfS4cG1S+S5Nbab8H3GZEuoDZCgDqkK0swEUHLPyYQi3jUjs++DeEbUYePvCcoT2RCKkjvRqlDCtRwObDYBGN1AmTfRC6xjOjPGZwip9GqF3/Bz+KLioIgem6A+XFZmCD47yqvrSG4Q3PLN9141UkNGsBi2Z398PE9GLBQF66IroZ/hDZi6IlWPXwSUMxUC/OYQIB/4ehA8Ov6Hz6PdNfXI4WxmeV+RgdSWSO/2DNXmKdj08QNxVhQ7y2s6kDNqmyUaNk4ZmNnCgTyFQeIFKaolVYcvXGtcyENkGH8p7xjhONaX2OxRU4LOzudaFhhEsO4gW0y4YH+m+8MlCnk8Q0wdQzIJrp1q39L2LZcst4URCQvwmOPb7aihAtlD7sBRwp0zhKzqS7a56PYeAiQh/fxy58OHXc1jJr1cxqqmCBQyV6Tb3/1LFEVbRbVcDA55HcJIVqEPIoQGi/XiRSzBiPt5C9T/cIULtBkfRBsGDHriQvGx6hCkRAwayG0wPWrrO3iHnQ3Fp2n+jZtad7bTrQAEDAZgXAD+8U71parvZTVFx3rEZ9CCI9ZeVJF1wN6I2XdBL/07sl29T9j+YD9tw7xI+F42A4JutUB0UcMsugqHxfMwEg==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a59fba8-6bbe-4e19-07ed-08d84a2d635e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 02:03:27.6574 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mcHvlbfc9ykrao2UTQDmywufZW8v7H/SWdWf18+0Y29b4or36t3iDkrx7+1dWg2ggRs9fliJo76wZbWZ1OCgCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5631
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, MSGID_FROM_MTA_HEADER,
 RCVD_ILLEGAL_IP, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS,
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
X-List-Received-Date: Thu, 27 Aug 2020 02:03:30 -0000

Delete a client handler by swapping it with the last one in the list
instead of calling memmove.
---
 winsup/cygwin/fhandler_fifo.cc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index b3c4c4a25..75c8406fe 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -377,14 +377,14 @@ fhandler_fifo::add_client_handler (bool new_pipe_instance)
   return 0;
 }
 
-/* Always called with fifo_client_lock in place. */
+/* Always called with fifo_client_lock in place.  Delete a
+   client_handler by swapping it with the last one in the list. */
 void
 fhandler_fifo::delete_client_handler (int i)
 {
   fc_handler[i].close ();
   if (i < --nhandlers)
-    memmove (fc_handler + i, fc_handler + i + 1,
-	     (nhandlers - i) * sizeof (fc_handler[i]));
+    fc_handler[i] = fc_handler[nhandlers];
 }
 
 /* Delete handlers that we will never read from.  Always called with
-- 
2.28.0

