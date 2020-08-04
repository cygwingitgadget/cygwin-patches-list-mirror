Return-Path: <kbrown@cornell.edu>
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2112.outbound.protection.outlook.com [40.107.223.112])
 by sourceware.org (Postfix) with ESMTPS id CD4903851C13
 for <cygwin-patches@cygwin.com>; Tue,  4 Aug 2020 12:55:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org CD4903851C13
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTYq/c4vsaROuwFxbrjkd9zPvbfOfXcNPCLUzOXtRnmdwftBCRcayMwIsQH56qldyDyRCCBB9aX3F0xHowOTjLAX9vRlkW5YLTPRSnT4C0xRi8ozJZ4LfmBaduoMHtxD0e8pjaLc8gAtVg5S5xRefCc6g1wNR8haJI28sVv6b1Phi3vtTQa/YnIzbWbYxlViy7PtF04SoZa7gMPDNhj+OyX0pIxjhcBXyUQ6qXjAIn4mkC8UIzzmrZjTzfBHAVnslv6Eh1dA0TEaIFNOQc/CuHsb6hNNHIq9kqZUcHXjIeJmjftivZSi6iivO2F5TTTaBNOYpyWLKVkP/qWwsx3jyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHJofz1eIYCvMidjBdMMmukEgszzO2Y2oSfGkczkzuA=;
 b=HtlO3dfBmOWVtmSWRAND3gY/89mdwQxPUU1ifnAjSh5gTxhcoD1z7sSHeipj2WFdCn/je990o+iOzWI28kwXyamdWIGvcKdaXTpj0Ks09tGy9QXqmJfteZRUe548qtukrwBKKg3LKWeC4rUKehNe8GaQ0IvyXoI206Shi1Mp0d4nqqK5FejO0cEk1JQ4jiQJ3zg69kQbmmGl6Y9Bgtfo0rO2WiYan9KhIXZw0KB7Eb15LVqWBD/RGr+icb68ZjKttcQwL4D5acsrdTeoFq9hMriyjbmJHlpViJJq0osT7IQbIOV5yu4uG4ejzPiR1fiFeR/IFByVfTKrL85R3ytNWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5903.namprd04.prod.outlook.com (2603:10b6:208:a4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Tue, 4 Aug
 2020 12:55:27 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a%7]) with mapi id 15.20.3239.021; Tue, 4 Aug 2020
 12:55:27 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 5/8] Cygwin: FIFO: don't read from pipes that are closing
Date: Tue,  4 Aug 2020 08:55:04 -0400
Message-Id: <20200804125507.8842-6-kbrown@cornell.edu>
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
 Transport; Tue, 4 Aug 2020 12:55:26 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [2604:6000:b407:7f00:8093:2a79:7de:1dbd]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac8379c9-ddd5-4a54-f17a-08d83875a8eb
X-MS-TrafficTypeDiagnostic: MN2PR04MB5903:
X-Microsoft-Antispam-PRVS: <MN2PR04MB59038E0495FEC855B96A1B46D84A0@MN2PR04MB5903.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xfVGScH6hKMZ5DZGgO8/m3qIvtnMZI3DuCe3HYth36M+Y68SHEjz7yy9Q3BRxawo9/mC6OhJSV4eFWEU/4BohdTLhhUgdN8qsmJ9xk/raIUMxIV5jWQ9n0Fe7tup5ugEFcP+3CBOGsRr33BxcjZZK6HX49EvmZ9yGhRu7qG26wuWkJtcNJBJTxPVRPFS/h8cXUBdSscJNOt8HfGTPa34hwC4jP5EQH2lQEww3ExG8q9nWNkCbTPXgvB42krmJm1frtJkI7mGTXT/Ov0vFj504QQmSUaniGlltZFRL4S1ut04o7X3VpeU9bE6FtkG/z0NC5IjyUf4nFTLhtFLgkjT5oTiPXmYms3X3THaswfsX+nyrHBMrlii1HimXk26Z+zu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(2906002)(5660300002)(786003)(316002)(6666004)(6506007)(66946007)(86362001)(8676002)(6512007)(16526019)(186003)(1076003)(75432002)(2616005)(83380400001)(478600001)(66556008)(52116002)(69590400007)(6486002)(6916009)(36756003)(8936002)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: zzB/dp1QFpAz2AA7CBYHQWM5Go8BPjS6Nja583Y9WqK7LX0nUVpp8R3zwNgDGmf32jX/qiSbF40t0BI89jpwvtKmeE5rUuHqbdh6SbOKePYMjQuGRb9XXGWImWZCyUGCsZDY978m9R4LcYz1eoq3VxIHK510Yve/9e6c++jTIHzY+9AnzEdUy6ehVXEej8zIoqWubx/OUOlA/99zi6cConHxYOVHMEhQh2qo7SRmREHHN0CYE8dO/JJ83YUBA/0VR310OtGmBRBrjt6McvtVLU7alYdI1OkKP6qR8Du1W8VBdyCThAF7wpYXoKITIw5Hf/zqrkEyCcgRUrnjjt2WfNPQOFBOt8SdVKwa/da64mMkdPp281J3YwSvxVrrq30wtZhCY0HO/jt8LVfBgld8iTqQn2/nq/EGwmvVEl41Yv/U1wl21O5T8oVZjnBT4xcgnYLxrMuNxsabiZvgVpUen2oCF1lXFjSNpv4ZZ3ZJhaP4qqurmFXBFBsoKKADSqhNk44OwIo6FX7tJmwq2+gWqXipj4u2eG3/L6mTtwj+tk1K2Z1jchHA8IlooGsEqYDhSsFdiLAqBNmgtm8RPqk2HhvUnliM4V0iYdrAvjeTbYrxgf0yGIjOPJtCNojPKXWe2ktZgXFWN8ZFn4/s6alc7W4i6N5K3R/rWXMHVowNz7mmh4HEhM+w8XlkZAqBSD125vgKyxapvpZ60y6S0sY/4Q==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: ac8379c9-ddd5-4a54-f17a-08d83875a8eb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2020 12:55:27.2227 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nvRircX8NNCXHJ53fYsRqVeWcjc1h/D35UlvjwQooxkQTpCT3arFprTZSyRx0kbgbZuUwDnvtaHiAqVHUIm8eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5903
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Tue, 04 Aug 2020 12:55:33 -0000

Don't try to read from fifo_client_handlers that are in the fc_closing
state.  Experiments have shown that this always yields
STATUS_PIPE_BROKEN, so it just wastes a Windows system call.

Re-order the values in enum fifo_client_connect_state to reflect the
new status of fc_closing.
---
 winsup/cygwin/fhandler.h       | 9 +--------
 winsup/cygwin/fhandler_fifo.cc | 6 +++---
 winsup/cygwin/select.cc        | 2 +-
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index f64eabda4..40e201b0f 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1276,20 +1276,13 @@ public:
 
 #define CYGWIN_FIFO_PIPE_NAME_LEN     47
 
-/* We view the fc_closing state as borderline between open and closed
-   for a writer at the other end of a fifo_client_handler.
-
-   We still attempt to read from the writer when the handler is in
-   this state, and we don't declare a reader to be at EOF if there's a
-   handler in this state.  But the existence of a handler in this
-   state is not sufficient to unblock a reader trying to open. */
 enum fifo_client_connect_state
 {
   fc_unknown,
   fc_error,
   fc_disconnected,
-  fc_listening,
   fc_closing,
+  fc_listening,
   fc_connected,
   fc_input_avail,
 };
diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index c816c692a..1e1140f53 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -365,7 +365,7 @@ fhandler_fifo::cleanup_handlers ()
 
   while (i < nhandlers)
     {
-      if (fc_handler[i].get_state () < fc_closing)
+      if (fc_handler[i].get_state () < fc_connected)
 	delete_client_handler (i);
       else
 	i++;
@@ -1280,7 +1280,7 @@ fhandler_fifo::raw_read (void *in_ptr, size_t& len)
       for (j = 0; j < nhandlers; j++)
 	if (fc_handler[j].last_read)
 	  break;
-      if (j < nhandlers && fc_handler[j].get_state () >= fc_closing)
+      if (j < nhandlers && fc_handler[j].get_state () >= fc_connected)
 	{
 	  NTSTATUS status;
 	  IO_STATUS_BLOCK io;
@@ -1315,7 +1315,7 @@ fhandler_fifo::raw_read (void *in_ptr, size_t& len)
 
       /* Second pass. */
       for (int i = 0; i < nhandlers; i++)
-	if (fc_handler[i].get_state () >= fc_closing)
+	if (fc_handler[i].get_state () >= fc_connected)
 	  {
 	    NTSTATUS status;
 	    IO_STATUS_BLOCK io;
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index 0c94f6c45..9ee305f64 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -878,7 +878,7 @@ peek_fifo (select_record *s, bool from_select)
 	{
 	  fifo_client_handler &fc = fh->get_fc_handler (i);
 	  fc.query_and_set_state ();
-	  if (fc.get_state () >= fc_closing)
+	  if (fc.get_state () >= fc_connected)
 	    {
 	      nconnected++;
 	      if (fc.get_state () == fc_input_avail)
-- 
2.28.0

