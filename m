Return-Path: <kbrown@cornell.edu>
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2101.outbound.protection.outlook.com [40.107.244.101])
 by sourceware.org (Postfix) with ESMTPS id C349D385041B
 for <cygwin-patches@cygwin.com>; Mon, 20 Jul 2020 13:35:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C349D385041B
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyF8Xie0Ns+KGkF2LmP11WJqT6dsYGzyE2YiyFpEBGYrZxh0pAr4YQeFRL/F7yxM3QFb1v6qUeQDv7HBfLlts3j2Pr+vo5eC4xCEYOK1G/JnYRjofF10buvVu8q9X6GooQYxwyD4XNq8sTtHzGYeN1Px6nOJBYBIVlxH3h1V7Gq7QD3IKlPcbxt4fzaV5esTL1yz1b1Hz7lVuyhibWS0ofwOMPLZuGew8URZ+kQMH2WnQIenLyJ8xWayK3V5XP2BASSpaYNV9oXzSuV6N/0Lilb9JKYoWSx9CoveqiGng0dfo327g3Z7VqhKOOuhZH6MdQU4HlEe5Nk/evYGcKXhbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWQHsqrsXc08O2wujqJKBO+185io+ccECHCoY2GTSHE=;
 b=TzYDjYI6W/gZhcRCzN7MrvrRM8eG3dAgrZi8RPpyS/LINovYl9G9QYRBwEJd5mCfZaa/P+gJXoPlP5aXl8DuA51yQFx7aHp4yZYfWhvn2Puv4plXlT2YzYfA1JQ0GcO2dlD6Wth/kHnwqZem5PcPbfNY7xlXNmXa2kUeZPd7tV/cAx3od+iwoPbGsePi2kRQ6IPFL5sWDXOrGJwtTMvmp5L+eJaFjdmpOWjdy1nN0x2EQSg9mzrd7d3qCqACntu0uvTq5b4hA2hqW009r0NgNAeQ5zJC1WDn6clvw9m5bmfgD6uywPYJxTF0wjgId8fKvxQvs7IACVJEUtWeCfLDsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5856.namprd04.prod.outlook.com (2603:10b6:208:a2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Mon, 20 Jul
 2020 13:35:00 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a%7]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 13:35:00 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: mmap: fix mapping beyond EOF on 64 bit
Date: Mon, 20 Jul 2020 09:34:42 -0400
Message-Id: <20200720133442.11432-1-kbrown@cornell.edu>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR11CA0027.namprd11.prod.outlook.com
 (2603:10b6:610:54::37) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2604:6000:b407:7f00:b097:c784:8595:264e)
 by CH2PR11CA0027.namprd11.prod.outlook.com (2603:10b6:610:54::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend
 Transport; Mon, 20 Jul 2020 13:34:59 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2604:6000:b407:7f00:b097:c784:8595:264e]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c62bab01-f381-4857-1669-08d82cb1b327
X-MS-TrafficTypeDiagnostic: MN2PR04MB5856:
X-Microsoft-Antispam-PRVS: <MN2PR04MB58561DBEE2FC818B45EA3D71D87B0@MN2PR04MB5856.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cUCTt19iD6a0wISdUZ98k2Gx+v1lxd61PnQcCkcd0SFSGWOOpMQ5Gapi/rrcMMcPmrBcwVvYixXCR03xbgQJeYkFaTlBuCo3vwD2XP4FWLucRUEkc2/sNS0re2+EzoXydwWliktAu8vT/17Mijq/wheg4w+s5K1IbktyfR3LDkuYH4D9+LzJ6ONnEue/qTqBz87+zkMilN3ME1bjdTOYOHo7vEMldp2m65ZxNtZmeHEw8TKELLzLcFK0rCR0wTN6V85uFqrftFluN0Rvp0vPKF6hYI6cm22nbZBAUEUBSf9oD8giGRjhpnCPXO9hL6xj/rpePM+A92h4Vm90IJVoejgR2AVX57NZ6OOrLA/zMJOuhk2fIk4W1heir2tBU1kra288i068P4fa1c3EY6POTzWZ8cZBrWU9Wxmwm4v3BfOzuYZW1Bnx983MGvgHdUkaGRfxaZl+gN/SPGUQVfIkrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(16526019)(186003)(52116002)(6506007)(66476007)(66556008)(66946007)(1076003)(966005)(6916009)(2616005)(786003)(5660300002)(69590400007)(6666004)(6512007)(6486002)(2906002)(75432002)(86362001)(8676002)(36756003)(83380400001)(8936002)(316002)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 3M1Y7j80zXSNK5iosk5JjQXR5WNCs22xO6UH6UbdZpqvPLKleFxP2kPlNI9PiAOplzFxZ66mB5oNNft5SUEa++dwjkZ3BLUCHRO+vjuEIXTxR3ISrca31dWKzMCfFV89J518suvOW7ZUA32PDX3lD73d/Fr9HNJJXfO5c7P9UxXCEGlxpCUx+X/VbWVsiV5KvmVnhLcY3MjI/gVUf6sZwgePzwljxhv05VsEgxQSFRTq6JUORwAwkGDsxF9IciR65X4D8Pz4UF7DV2yOBCtWVrmR0k40I4wuWKyzHSl3fyupVGeGsQ99KHg2FtkkGtiSRfQvmUh69+kk/JIlAU6GMoh9fV8Zt2P+UK74TTgz3xaFGouYJfEr9GscArm7y6WifWG9BysvYq+a6S6ayVRf2eIjUShxu3l/YwEVOc7aDgFF7m7ucVr3R5f9OltHe4wmEYf6x6+dVljdPUUZrYZ1+hZSsF0WO2KZbI62NM5HTLNa4UlUa12YWKRkWLN9LYzZod74UAtx2LHhhrln+pHzXlAQaiWObZC2oBitOFvY24U=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: c62bab01-f381-4857-1669-08d82cb1b327
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 13:35:00.4279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nmqb3qgdwPJFtNToxMgg/o5QopZ9SuUfn5f8luPIHLcczj2ujev3x2LCmuVlBWflWIXllK8V+Y41BvxCyUQ2Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5856
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Mon, 20 Jul 2020 13:35:04 -0000

Commit 605bdcd410384dda6db66b9b8cd19e863702e1bb enabled mapping beyond
EOF in 64 bit environments.  But the variable 'orig_len' did not get
rounded up to a multiple of 64K.  This rounding was done on 32 bit
only.  Fix this by rounding up orig_len on 64 bit, in the same place
where 'len' is rounded up.

One consequence of this bug is that orig_len could be slightly smaller
than len.  Since these are both unsigned values, the statement
'orig_len -= len' would then cause orig_len to be huge, and mmap would
fail with errno EFBIG.

I observed this failure while debugging the problem reported in

  https://sourceware.org/pipermail/cygwin/2020-July/245557.html.

The failure can be seen by running the test case in that report under
gdb or strace.
---
 winsup/cygwin/mmap.cc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/winsup/cygwin/mmap.cc b/winsup/cygwin/mmap.cc
index feb9e5d0e..a08d00f83 100644
--- a/winsup/cygwin/mmap.cc
+++ b/winsup/cygwin/mmap.cc
@@ -1144,6 +1144,7 @@ go_ahead:
 	 ends in, but there's nothing at all we can do about that. */
 #ifdef __x86_64__
       len = roundup2 (len, wincap.allocation_granularity ());
+      orig_len = roundup2 (orig_len, wincap.allocation_granularity ());
 #else
       len = roundup2 (len, wincap.is_wow64 () ? wincap.allocation_granularity ()
 					      : wincap.page_size ());
-- 
2.27.0

