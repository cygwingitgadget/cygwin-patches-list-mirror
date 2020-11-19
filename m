Return-Path: <kbrown@cornell.edu>
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700102.outbound.protection.outlook.com [40.107.70.102])
 by sourceware.org (Postfix) with ESMTPS id C85E63857810
 for <cygwin-patches@cygwin.com>; Thu, 19 Nov 2020 20:36:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C85E63857810
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=et0pDao6FjfVBbDRmAO82VvFssRN+A8f1yV8e8G/0LkooeY/IfadFzlRXZgcTcsiC9lL47L1HCOWzXowuQxaC4WhdeV4whAyuebr1jjZTpJlybsGnac4qywkWP0qMATDrrUCuE2DKz7mbL34xoGo2heieSgP6IakKkvaO41i1PEn7LIrpDtEEWtoLSnuhJ+6VvFfvGKwlgxwrcXVh6s3kDy50yM/0YN5FjijAtaauvc8QIC+MgTDixr+dhbJqH8YRa3m7PtvwjOr0bSDF/t25YtQ1h7vzhKsADK4YDJoaoupeGTqiF3zwow0t9slD4XmbU4zHMvLRlGK5W1LniOZKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOX6KRvsb/P1eCGcNLB3Ay0CmWJ0qqvQAvpqOizksZA=;
 b=UTJugHggj7644GYUPQpM66ahs4fGIdL9nAWds3hm7RDbToBmUQWmi037ukeWe16w/X4rNpWUO/Swy2SHVoy9hlKEb3FevAHxt/u7At5cwbgPd4ZPqOhw0YmcrlqGXcyElOJeRj3wqZvYQi+p0sUAnA4rwTtDuxfmDDJcZ/Jnd7vftZfmkY70Rwd6Sb6DF9/5jOf/5Z16Yjb9pGv/X8GmxkEDx4k2ldUph8ZLJ8TrNeJ9yPy6hM67ZxRCtMAVmxW9Oh6R3UWEmz7JzP0llD1La5cs4Vear2T762IGHbWg03NZ4j2cd6sS6yWdkiSJkyrdmz31f1+dAks7Hcvx9YhqiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5645.namprd04.prod.outlook.com (2603:10b6:208:3c::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Thu, 19 Nov
 2020 20:36:18 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::113e:c874:1207:eca8]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::113e:c874:1207:eca8%6]) with mapi id 15.20.3564.028; Thu, 19 Nov 2020
 20:36:18 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: fhandler_fifo::cleanup_handlers: improve efficiency
Date: Thu, 19 Nov 2020 15:35:58 -0500
Message-Id: <20201119203558.44754-1-kbrown@cornell.edu>
X-Mailer: git-send-email 2.29.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [68.175.129.7]
X-ClientProxiedBy: CH2PR10CA0010.namprd10.prod.outlook.com
 (2603:10b6:610:4c::20) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (68.175.129.7) by
 CH2PR10CA0010.namprd10.prod.outlook.com (2603:10b6:610:4c::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20 via Frontend Transport; Thu, 19 Nov 2020 20:36:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 689fd9b5-955b-4b81-55ba-08d88ccac487
X-MS-TrafficTypeDiagnostic: MN2PR04MB5645:
X-Microsoft-Antispam-PRVS: <MN2PR04MB5645F3FAC2E919B9E653A0D7D8E00@MN2PR04MB5645.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pczc71gvSIOEnTJ59A7IXxEaItfq4/Nt9Q8CZWDqqrDrdiZ2QnNrj+vkorNS0cA1Qt2s7Yto6bhe+zVhcOwRR3sevrA77x+7L/5M68bQ5tMEBCUpetUNLUQzfW0UJbNHzXL0J4By0aX8Jg1XLvB0wwnVGdLLvpDhcP8Z3xadnMAAEyWvm038gUa/LlUydaaY/MRHqwLGjQXeOIFKQbi+D8Mt0XCrM6OVzyVmAnRkQy0j+fXSndJ8LFxGS0kNe8rkhibrRknbUkfIEaYxn/sQP61RSkm9ODR+DZI2DkMSbUgvrWlHoKfJm4cNMBha9AXoImQAh/7Ctn9dMGA+FYP664FudPqBB7jYTZsfwh5MPQgfH9dCTdeY4FTOMoViU7sT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(8676002)(66556008)(86362001)(956004)(69590400008)(66476007)(83380400001)(2906002)(75432002)(66946007)(6512007)(6486002)(36756003)(2616005)(316002)(6916009)(52116002)(6666004)(786003)(1076003)(26005)(8936002)(186003)(4744005)(6506007)(16526019)(478600001)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: fJBEsn0k3BQyEsUtbClXefGDKExIsdQbRRjDgHYSPgevWU3JaoOxOxCPeNX8k8JRRRrvsnHXBMYh8K7jho7SLQ014chN37A/t+86YZj8kzzfyOQJFgitBx9VRACOzZ59gtGyOjjRj0i9VkFhSJ/tntfvADcVOPlpwdp2wEnOe/ZsXyOat/drNF0TxLWC13orM4c9E/feNRoPQeD4YRd8dasYMmb/mdKECOCOldgRUtjaBx6pCpUELh+IdMf9pExlqFVXOJ/GdLo3eWFjB1TUIop421+nsNDq1kE9ZCduHO7hOzrz9Epf44W2PBmhjIoyYzVPy+TbO1qLag4BbS4rk3a83NZCUt5WGHBt3U+wDA/hkm1evtSqc9IA9gLv9mxDzbJ1WFANfGGYY3BxAIguVEGtcek676INlwkOM/edeYi3LhTrcjcu1ZCqZqBYHuAwzKajXL3UkUz4dL5X5FxoRPIIxZ1JgM7Dt+S+J52SE3CyDPZPlXS85mlZU/TvhE851RQO/73ByYfHgSALDTmQVkH4SdfXVo3tVMFVbAoo1CffLTeJvwp2SAI0vV0y+CXw4LTM7gKuqZ7FC3ecV0R4pbxlnBDy8O9poqblcnWZW2GGik7NPMFjyBjYHXzfIEG8QweVoQaJcJpI6qI3FifKlg==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 689fd9b5-955b-4b81-55ba-08d88ccac487
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2020 20:36:18.3670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VfRU4WbvICnswFlT1MBnQPyBTywm45MvzmSVcAPxkkGgz2zM32Hu7U069QrMG4znHjRpBqwHpqhfD4OKoe0UuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5645
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 19 Nov 2020 20:36:23 -0000

Traverse the fifo_client_handler list from the top down to try to
avoid copying.
---
 winsup/cygwin/fhandler_fifo.cc | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index eff05d242..8b67037cb 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -395,15 +395,10 @@ fhandler_fifo::delete_client_handler (int i)
 void
 fhandler_fifo::cleanup_handlers ()
 {
-  int i = 0;
-
-  while (i < nhandlers)
-    {
-      if (fc_handler[i].get_state () < fc_connected)
-	delete_client_handler (i);
-      else
-	i++;
-    }
+  /* Work from the top down to try to avoid copying. */
+  for (int i = nhandlers - 1; i >= 0; --i)
+    if (fc_handler[i].get_state () < fc_connected)
+      delete_client_handler (i);
 }
 
 /* Always called with fifo_client_lock in place. */
-- 
2.29.2

