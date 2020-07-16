Return-Path: <kbrown@cornell.edu>
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2091.outbound.protection.outlook.com [40.107.94.91])
 by sourceware.org (Postfix) with ESMTPS id 0B09C3857C7A
 for <cygwin-patches@cygwin.com>; Thu, 16 Jul 2020 16:19:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 0B09C3857C7A
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mA0rzwB375SuNqN2oBOU9dOd5UzhBMj3wdqinNaO0d4BLohmri695jzpNnaXoQOlFyGPcUOODA+EV4mqfIUkzs2keAqIaUR/8nDge/XD43AP+rMNwM46ufvWm04GvJwQZuepsVGoIPYVcDfrxzBPw2hDUOBZUs/ioBlFkVOyL9iQp/3OEyDxrI7/1t3Bc6GKFfGefHyJ/jqy4MXCZp+o9fkZeTdLPUMXAA4c/KX9Hb/b0L1K5EanfjvhX80jCotMP4WkEeLQZvoeDCQJ4qzESqZd4Qn5JZismtCub2I3+UCUBPVgWSKOGhCTNtFuWu4RUpZG7UG9tdyjMrZNk3vQrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvu5EPmx/biOPaUxAT9WvhhEGbdKFMb7cwKtqN0IBzc=;
 b=XrLLqQOWy7pn6aqgBPDcGtr1mkZYDS0RTXfeAawXdiXXrJOZAmHy6dPK41F80vL5wRMc+TE47mpAmSK8FIvNaglZWZsSyssWParJ+K7jValinfGr4gsw4GgYRuMEvGUldfUXEzKo3r04R5+KRCXTxq+uRycf1asxRgGINJajtfjLF/aIUnoYPTwPg/9ImpOUan/tbRxvzZDvb9NOMRS5KuDvZqO5YwtQ4z+2boQj0AHFLJr+0I/dgSIXzSmltk+DbqAlnYyqVKssnHEedoRMkHTIxi4jCYhQkYzcqJRBKA/HbzueIdZuC6GLl10itY139aGYHl1tuySwVzLUampcbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB6112.namprd04.prod.outlook.com (2603:10b6:208:e0::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 16 Jul
 2020 16:19:37 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a%7]) with mapi id 15.20.3174.025; Thu, 16 Jul 2020
 16:19:37 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 08/12] Cygwin: FIFO: add missing lock
Date: Thu, 16 Jul 2020 12:19:11 -0400
Message-Id: <20200716161915.16994-9-kbrown@cornell.edu>
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
X-MS-Office365-Filtering-Correlation-Id: 84efb0db-bcb4-4321-1b80-08d829a408bf
X-MS-TrafficTypeDiagnostic: MN2PR04MB6112:
X-Microsoft-Antispam-PRVS: <MN2PR04MB6112A93CC74F662BCC114FEDD87F0@MN2PR04MB6112.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b1ePqttW8vOYpSguQHUKqO/ZrdHFV6ABQ9OaIuROFJ5UiEfqu+Cw7m2yqzWNG3jffF0ZmdmwlxSznoa2E+Xfjdmqr+h0j3wr4Zb/L4T1MDSuSovaN8o2F0hj1uAE718BT+qbtIwhAzDYhS2+6CxaGJTmlqHDmJwPvFRe0SJJqFWPfm+mM/Qc3I9PFl0XMpjQzsCqv67ZKarkqvwrtU5kuWn5fc4LtJiyANAkkhBL0V8k7MeRvd9BWXprcqw7dG/ufP/PHLNg46j08jwHpjOt1RwA/j6LhRyF9DE6lRfC76J/FXGiUf9lX9wgCU0/7zujXdkhEVuYpoyTlHH8Cp3Nxhkq5BKvGYSpRtMoL8KBG603hCn6E/+iQbZGEZ3TCT8+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(66946007)(2616005)(66556008)(5660300002)(69590400007)(6506007)(8676002)(83380400001)(16526019)(956004)(6486002)(6512007)(52116002)(186003)(26005)(8936002)(66476007)(478600001)(2906002)(86362001)(316002)(786003)(75432002)(1076003)(4744005)(6666004)(6916009)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 6/W1SPRHJDtDxFU437npDC0tZg7WnxQXyorZxa/Tplr2X6qE/wN3p1sCvFH60AfsC345JgvwcRIz5IR5Y/27XBZTStr7sFDnUyiYQFARjUPnsOjKF//ADjHgteSgHxZp/RXQNGmuzs8M5SDmmtGru/Bfv709cA5PkdmNeWgtf+yLsld4t4dzbr11rxJEuIzkfGDn2bE3XhXixO7AjLtD51dDy/94Rp+gFjtWN7b1KMeNW8soWv8FnJg3oXtZlODaZmxuwzxO5bRp+6/NsqVHbUTjcbs1SJ6yhYEK16oGb9Xw1zx0g2DL0ALf+1Sxwe2kalfcTSzuaZISzpEmdkI5SbHglYvTQo0vY6A7gKlTY+fJYSrkkzvcrEbeT4NogaVYX9kKRfA2cUx2HVN23tQwwgO669DspAW70S0cVQBbEJ3TrRlqloZoLJJmWIucD0j9Oj0OUdLvB7vasd2XXOkw1uKjeyQv9wNUD6es7IX+XyM=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 84efb0db-bcb4-4321-1b80-08d829a408bf
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 16:19:37.2811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: APm8FIk4QYhuCekyBkbLV2wfQfU/JA7iEf2BOz+KObpwGUBFj6vgU1Ht78/UcrOPMFrxJz0k6eLGGh8afIIIlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6112
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 16 Jul 2020 16:19:46 -0000

---
 winsup/cygwin/fhandler_fifo.cc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index 91a276ee9..b6e172ddc 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -422,7 +422,9 @@ fhandler_fifo::update_shared_handlers ()
   set_shared_nhandlers (nhandlers);
   memcpy (shared_fc_handler, fc_handler, nhandlers * sizeof (fc_handler[0]));
   shared_fc_handler_updated (true);
+  owner_lock ();
   set_prev_owner (me);
+  owner_unlock ();
   return 0;
 }
 
-- 
2.27.0

