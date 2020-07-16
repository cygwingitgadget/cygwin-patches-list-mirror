Return-Path: <kbrown@cornell.edu>
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2091.outbound.protection.outlook.com [40.107.94.91])
 by sourceware.org (Postfix) with ESMTPS id C13BB3857C7A
 for <cygwin-patches@cygwin.com>; Thu, 16 Jul 2020 16:19:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C13BB3857C7A
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3IIAamLLmzNwCrr097Z6f8Yw9YcNtCkyHVzo22hPLmVZpn1jSZC25HvPlg4ItA1XJr61/A1RqPrC9ttPPctNLojms5xDo6+Zo1z07xTai3rwd3CFjEuIBMQ3A96lAXSoH3d74g2hSsjWjnnb9HhqxypKQRxx+idPr7duG/6i+m+LvuKi0s+Zy0FNi5pe1XkeekHWDODp6STzBELnThN55JClZfDJhX4ko0Vx4Cldm8F5Wr2hU2VLbn1e+C9iNHvhIF1H9kc0e6n9iG8nL8dg/gsYQv/UiXh/9+apZ7aPk90QgMvXeDWfp8tm+BvVWWF0crPm4qHwurj1PShrsnS6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fv9iA5/v/Rep+WLoEEYeM1UdFZ0Sjdfu6BrCVL4LpTg=;
 b=EkEjGAVY+p2tVknR5GRlym8ufa7a5x7jEoGOxDo1h2UwDHIJc1BsVfiOdXbtgm6BQ33iwN7QE2CGb/SluKE9JMdvliaEhYyPn3DGZ1ikCiNe7dd6mWHUox4ha7VKxYzTWg71SSZ9++gGZPfWaaG/3JShSzr4lD4w/3z6A+NLysQntgRFLp2Dr73I2zmySCrPS/6LYRrPQICYN07DA0rt1HQZ/bc+FzMhtP/xHnmPCxPFlgUi4X3nMo/tzuMKadPJHR6Aw1XSXsHYVOygz0uzkAQrGqYR9Y8DVtsWf4OogD67ieYz5sJlZx8VhrguS6SBwroJERe5uJJ7faH2+kdGiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB6112.namprd04.prod.outlook.com (2603:10b6:208:e0::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 16 Jul
 2020 16:19:33 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a%7]) with mapi id 15.20.3174.025; Thu, 16 Jul 2020
 16:19:33 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 00/12] FIFO: fix multiple reader support
Date: Thu, 16 Jul 2020 12:19:03 -0400
Message-Id: <20200716161915.16994-1-kbrown@cornell.edu>
X-Mailer: git-send-email 2.27.0
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
 Transport; Thu, 16 Jul 2020 16:19:32 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [68.175.129.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0127360-7210-4605-316a-08d829a40641
X-MS-TrafficTypeDiagnostic: MN2PR04MB6112:
X-Microsoft-Antispam-PRVS: <MN2PR04MB6112A23A23454A162D2FEA8BD87F0@MN2PR04MB6112.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pGR/0xtYbKwBCtu7d4rYlcrIkWGcchVFI9aCZoAgcmmgD7ks62wZ/HB+irknWeGsgFPbposYrSrfJiUCE/dg8lDhHEfj6pyuVAeAIdiRCh0X+divLkZ2YoNAii1w7YNSeMnRgf+meOplUVMKsobiFLvabWkSEG/BdbS4nziRymdNfxUDOvI2/5pWQfpy446oyw/LBNwztu+lXCuBx1sn2Qw/asy7In0R/Zl2XwvEv1PhwN1qC5Vw69dd2wvPfO0sclpP6d920mLI8ETyr2pYVvAECS7vRPNSeDMEpMwYeV9kMVrHB3KQjlgazZhII7EZrLMEO8Mr6Gv6v9fX7eYuxBuGQWvSt0f9WSw1LTjODPhWgtPr1eVZkwKunx9YV2oUYsKnd5JZc6qpjsfa7C0YxS2A8LKU6YNXdr1Kaugmrl6/JdFttJfZEAoZtCORBRQ1JESReHvC0eTZqlXgqi6WKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(66946007)(2616005)(66556008)(5660300002)(966005)(69590400007)(6506007)(8676002)(83380400001)(16526019)(956004)(6486002)(6512007)(52116002)(186003)(26005)(8936002)(66476007)(478600001)(2906002)(86362001)(316002)(786003)(75432002)(1076003)(6666004)(6916009)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: kgZk27ekSiMZc3ml8mztYiXQ7grC+xS+3YXkaxrTgvJAa80pCSDFeXY4OQEcZ+OTx6kElH4NQE5OOC9Iak714ADy0nku8/1kEDw9H1f760ajoqW0UKYLQPLTvntymSnrytGTFHjz2YnkzbEeaMSf/ADZ3OtN9Utg6RaVEwgUAYeGSn71xW/jeJ5JD9vH5BotpjMhjtxCzyiv3tE1H6d8mFSSltrkIgOWGcrBdBl+4d9jyxHGPPvXa3ZXafA8eyVUfnplKXqomvXOxc1j4czyDS1UmII8OT3pbc95/nxZiul0tC13XoVMd+drDrHH8CSJNkAs20dnB8YLoyCZnzHeeL+Ido3xc49rbZZQrWwyxj9V6HH4p7X/keOCkY6mlR9y6Ou2XJ/lmO0gxU73i09/9ah55HrY9iJFW4uxxiY6p/xf/vG/w7AvExGy9iDS9k7eK+t/BZhJMQZFaxkpHAB5wemMsrKpaNEc4cPxHyipYJw=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: c0127360-7210-4605-316a-08d829a40641
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 16:19:33.0915 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DBLCirdgZ5vmOBn+VoggPoJkuG88yxBpfQ6JBV6LXHGDqO9gjUheRJIYJkDFJe4hd2+F+Qvep1PzK0l/9n1AiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6112
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, MSGID_FROM_MTA_HEADER,
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
X-List-Received-Date: Thu, 16 Jul 2020 16:19:39 -0000

There were several flaws in my previous attempt to add support for
explicitly opening a FIFO multiple times for reading.  (By
"explicitly" I mean by calling open rather than by calling
fork/exec/dup.)  See

  https://sourceware.org/pipermail/cygwin/2020-July/245456.html

for one indication of problems

The most important flaw was that I tried to use an indirect,
unreliable method for determining whether there are writers open.
This is fixed in the second patch of this series by adding a member
'_nwriters' to struct fifo_shmem_t, which counts the number of open
writers.

We now have to give writers access to the shared memory as well as
readers, so that they can increment _nwriters in open/fork/exec/dup
and decrement it in close.

The other patches contain miscellaneous fixes/improvements.

Ken Brown (12):
  Cygwin: FIFO: fix problems finding new owner
  Cygwin: FIFO: keep a writer count in shared memory
  Cygwin: fhandler_fifo::hit_eof: improve reliability
  Cygwin: FIFO: reduce I/O interleaving
  Cygwin: FIFO: improve taking ownership in fifo_reader_thread
  Cygwin: FIFO: fix indentation
  Cygwin: FIFO: make certain errors non-fatal
  Cygwin: FIFO: add missing lock
  Cygwin: fhandler_fifo::take_ownership: don't set event unnecessarily
  Cygwin: FIFO: allow take_ownership to be interrupted
  Cygwin: FIFO: clean up
  Cygwin: FIFO: update commentary

 winsup/cygwin/fhandler.h       |  55 +--
 winsup/cygwin/fhandler_fifo.cc | 725 ++++++++++++++++++---------------
 winsup/cygwin/select.cc        |  14 +-
 3 files changed, 433 insertions(+), 361 deletions(-)

-- 
2.27.0

