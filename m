Return-Path: <kbrown@cornell.edu>
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2126.outbound.protection.outlook.com [40.107.236.126])
 by sourceware.org (Postfix) with ESMTPS id 1D368389245C
 for <cygwin-patches@cygwin.com>; Thu, 16 Jul 2020 16:19:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 1D368389245C
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4mudYSYz1/i4IJSDNjSz0AMnJeH+PoXR26efwJ26qsnYCEqHaB+MJTFiN3QJ8vhAgQBAqmXP2W3aCFMg5wjeZbZzwU2L+m34Wr8xXBYhG8d7ucDzDbfE9B7QqdcM0gyKGNavppiRJry2VEPvTFec+GylV6J9EK2uTH69X03qRvt3N3jeFlRWK/wXyLAuosDjtQGFdVezboFhKX9fTTjMq5g0IzkYDyUzJ/2JLIexwtuUe2uiZn5jjVtwV9hIVu3t9vvjCYjyJbNFG5hjR6z4VImvw2HAnHnrw699FWnVS71VFpUsYm7AU0etoUHJOVll/HzXD/2wJzif00VtSQ/bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4kT7QnW3CZKwb4di2nWaAne5CJ/ZtzXPuHLCyIhcWY=;
 b=CUAYzy5mQ2+IhWoIlErUqVfBHgL5Zf4odKKXeRal9RY9Vi3JLYQPqEb/rsAu5tO/z7rwCkCef0N231RbE3uYzQOhld80mC1P1EnrWLpDhMeF5BPQEqtwpWdxoh4Xx3KrEutsSBx19Yf6b96NaBCaLZMXEPAUZk9v6G6X3/BUM1vPVoMbez85rQXFhZ9hnMp2n+fY3TGgvmlDiO8ci46natB+aQOUoR544W5XcsT2EBUDvGSDc493bUXA1slO6+IyIL26i11s+aFO3wV5gMdGw1LpeSHEn6v5KGGKkySlldMp/Q/ooa1K6g4BLhYCRfb0WoMMLzXE2yiZtbZ4Vz0Dzw==
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
Subject: [PATCH 07/12] Cygwin: FIFO: make certain errors non-fatal
Date: Thu, 16 Jul 2020 12:19:10 -0400
Message-Id: <20200716161915.16994-8-kbrown@cornell.edu>
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
 Transport; Thu, 16 Jul 2020 16:19:36 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [68.175.129.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 046a9815-e2e1-45f3-362f-08d829a40876
X-MS-TrafficTypeDiagnostic: MN2PR04MB6112:
X-Microsoft-Antispam-PRVS: <MN2PR04MB61121B803C5AB8A96FEDABCAD87F0@MN2PR04MB6112.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WvlAijgYUSJMKqVolM8UHp7SRQBEc/YnZ/FdM3mD6kWZLHstxmTv2VaCXe+wXPd96aLVJ8DDkXSTPSsOrlSqN/Tb5DGEYf/AqUrvkyl0kHxuYf5dTadLluHGM+qEqKWt94lPR+V1q68BEGbVI1OyyS+skjUwsQyvsx8UjbAt0v/5/eqUAQbNC6PohC73GM12i80xw7g++i4ZJLeehT3l2br+KvbYbHp9DWdqNLLncsT7LCjMAhO9oIWm8Hc8Y9yrTojx7m0XU7mpCKO/yd888204KK5RzVsNZeLy4+TtMzKLJ5Q4VpAkBJRdcC+A5WvLyY9ZYBnw9A201VDXUFEh+kb8Hv95ux97GIBP9o6dbaoRKWdspG55LQHrOze7iW3O
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(66946007)(2616005)(66556008)(5660300002)(69590400007)(6506007)(8676002)(83380400001)(16526019)(956004)(6486002)(6512007)(52116002)(186003)(26005)(8936002)(66476007)(478600001)(2906002)(86362001)(316002)(786003)(75432002)(1076003)(6666004)(6916009)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 3eX85udqNZD3evRsK1fd+M786C636QC+gF+l+0DyJjKWxArP63oMMOn6BelMmnIMqNBc2WO82qLyKYSbrQ+/dT+xoaPJtXHQprQWPCP1weuebpc9JT3k0luxWPiVhrDdwclzkyNM1juU/CoXW/61yuELi9V4Cqq0RomZo1oyQKioFz3ZmEo2nh+00ZHWPuYu4wZCzUspmLx/9iVgTSJigPKPbl5AJhWS20v6pzoh507CrsILNp/j0LoxzWDmGXZdFJS/9J6/4LIN2Fp+StTMKmtWQU+xiEldNiMXNz/yac8MTQ3YWyOnqsnOOLaVkOpu9ueJjriIwyB+H6rY0HQbzpQQo4P/rFRJGTdye/ap6NCgLM9Hrk3HnbPvQR+6T5BloR2RADbxHpVMfKbzojzEO/y8P/BQejyiwSkGIWAeaIYYIVChhp2MGs1/BNq3qhE7hDHk/iejCj8PFuZfKMBWEpmWPqNcI9X69DTwk6nfcro=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 046a9815-e2e1-45f3-362f-08d829a40876
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 16:19:36.7784 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHsLI9GNGY3wjjk83/5beKjaVHofGIcvRPoxUf7rsj+nQiLFNfgyVC+Rz7IHVVMn93JY8v4P1zuJKBNXYnryPA==
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
X-List-Received-Date: Thu, 16 Jul 2020 16:19:45 -0000

If update_my_handlers fails to duplicate one or more handles, just
mark the corresponding handlers as being in an error state.

But if update_my_handlers is unable to open the process of the
previous owner, it's likely that something serious has gone wrong, so
we continue to make that a fatal error.
---
 winsup/cygwin/fhandler_fifo.cc | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index 69dda0811..91a276ee9 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -383,11 +383,7 @@ fhandler_fifo::update_my_handlers ()
   else
     prev_proc = OpenProcess (PROCESS_DUP_HANDLE, false, prev.winpid);
   if (!prev_proc)
-    {
-      debug_printf ("Can't open process of previous owner, %E");
-      __seterrno ();
-      goto out;
-    }
+    api_fatal ("Can't open process of previous owner, %E");
 
   for (int i = 0; i < get_shared_nhandlers (); i++)
     {
@@ -399,14 +395,17 @@ fhandler_fifo::update_my_handlers ()
 			    !close_on_exec (), DUPLICATE_SAME_ACCESS))
 	{
 	  debug_printf ("Can't duplicate handle of previous owner, %E");
-	  --nhandlers;
 	  __seterrno ();
-	  goto out;
+	  fc.state = fc_error;
+	  fc.last_read = false;
+	  ret = -1;
+	}
+      else
+	{
+	  fc.state = shared_fc_handler[i].state;
+	  fc.last_read = shared_fc_handler[i].last_read;
 	}
-      fc.state = shared_fc_handler[i].state;
-      fc.last_read = shared_fc_handler[i].last_read;
     }
-out:
   set_prev_owner (null_fr_id);
   return ret;
 }
@@ -493,7 +492,7 @@ fhandler_fifo::fifo_reader_thread_func ()
 	      set_owner (me);
 	      set_pending_owner (null_fr_id);
 	      if (update_my_handlers () < 0)
-		api_fatal ("Can't update my handlers, %E");
+		debug_printf ("error updating my handlers, %E");
 	      owner_found ();
 	      owner_unlock ();
 	      /* Fall through to owner_listen. */
-- 
2.27.0

