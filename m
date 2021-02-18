Return-Path: <kbrown@cornell.edu>
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2119.outbound.protection.outlook.com [40.107.223.119])
 by sourceware.org (Postfix) with ESMTPS id 7873A3950C5D
 for <cygwin-patches@cygwin.com>; Thu, 18 Feb 2021 17:14:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 7873A3950C5D
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jck0WIWdcUGIH9D3Tynov2iykWoJ58NUBdvF2uSB54N2wm461l6QNHGqvDGQErMANPlUm/3ZMFa4T8QYMpqkl4uKepTbDaZwoDAEEEHfZJ6GN5hfzhDRzvV1xX3jmIbBrM1zVccXnVCgdarUfCXz+aguAhRxLzDCZdxK/XwZmKOqlw1IJbmiUTX2QCxsYN5mjgReW/7cPLXSdP6Thvf0/WXqBnA3K7yxauT921MmtlbsIRhqGqy7soNbP1SbtrVMPFrdXqQzIMvwpA6qUXxaF9Msk2dvoex/34l2WGqpNYxqDb+DMCh+KSUxEemG9sTLMvFLaFp9i6GNnUSCVc6/sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMbPma1ygrWUcEXz9/hi25LvWQDs12psLPE5wTT2mAA=;
 b=iTCpQTeB9jbQ9c57/4KTnJU80HNQT5qt9DTv2l5NKG9zWO+2psBuamf/IFZHaEwTFALSp/O3/3YktBbVLRdcyjkVPt2S9Zmw/GAiTMC/06iYh8nhrbEMmMfDAmYuiBsV0pwKwDI1L9cdzXT6XUXI43Iy3cLUNU1n2zmg6bYjkf1zdNb6+YR+bocXtZBVioaErWuGObJhFnArYa7Opehm+AOcdPB7HkhDEqjFk8c8N26SuR06nonjxOBPEYElLoradlaAD3ds2cf9DhvPnDPL0gSGQgP7W/E8oSqw8qFnndxUzXczdtwC6ipAxWDAm5U7gGYpEUELuXbB0Mqnh9suUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN6PR04MB0434.namprd04.prod.outlook.com (2603:10b6:404:95::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Thu, 18 Feb
 2021 17:14:08 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%6]) with mapi id 15.20.3846.038; Thu, 18 Feb 2021
 17:14:08 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/3] Cygwin: define fhandler_fifo::fstat
Date: Thu, 18 Feb 2021 12:13:46 -0500
Message-Id: <20210218171348.3847-2-kbrown@cornell.edu>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210218171348.3847-1-kbrown@cornell.edu>
References: <20210218171348.3847-1-kbrown@cornell.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2603:7081:7e41:6a00:a842:7b47:be73:d167]
X-ClientProxiedBy: CH0PR03CA0065.namprd03.prod.outlook.com
 (2603:10b6:610:cc::10) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2603:7081:7e41:6a00:a842:7b47:be73:d167)
 by CH0PR03CA0065.namprd03.prod.outlook.com (2603:10b6:610:cc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Thu, 18 Feb 2021 17:14:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2d1d69c-8439-470d-884f-08d8d4309a2b
X-MS-TrafficTypeDiagnostic: BN6PR04MB0434:
X-Microsoft-Antispam-PRVS: <BN6PR04MB04344FF087D1F284B318CC20D8859@BN6PR04MB0434.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TKKMaBOeeheOA7ruJ2dTLaqqW+vlOQAt+Qal14OFuXXLA7DFEuvUpMOJms7ixCAWLHteS+/vnNaVzY00B4K7AYjKw14OW+o37vDaEQ69bWAi7RKgiGMHC5pnQy6NZo7cfJZPg+iIDQEbzf/pZOEImkM+wwx9b2b31qFiN6GUeMSr0s2a62+jUHmLxrZmYWuxbSQTurGGE5BFBe6vRXxJxMgV4cWQt+GkmPtuQGrv/EsC6STDLssHl//JJVSGbf/o5JVtZY/2im7AqUGtnwGZgq9hG31HoiA1WXBihdejyEff5mqQRowMfQ3rC02dl4NO5G7dKHF/Kry1wETRcwlolodpxSlmG3ILhZQpGZhVr+2iCQ3EM5S/XgJAc//p03u7fcC3leFHMntd/+XqnS3V/8iYxVWj0qUH/ZmKpdVMFQe/yRClLqZTmNFECW/GfM3ZqGJYzgCvdYpZvvJlvJuJS42ToVx/FdI75buA9UyOe6lGFEVdzTDE16DeVH8hB+UUADVScYoSpXgkbGuM5MlhO822L14j9IX2ZNvBDjyRMmoXhL8LpiQ1jVxbc20fhULyrisfn65CUe4sXYrsZjVLGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(6486002)(6506007)(16526019)(86362001)(5660300002)(66556008)(186003)(66946007)(786003)(6512007)(52116002)(2906002)(2616005)(478600001)(316002)(8676002)(1076003)(6666004)(6916009)(66476007)(8936002)(75432002)(36756003)(69590400012);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/X3fmYa/woP5Nc6Zu86MxZh4/3JBxtZFlylgwrPeeUaBzAhz8+VvYoj1+BUy?=
 =?us-ascii?Q?I2H4XujMdeTJa97lC061VMIK54j+MYyNPrS56Z5ZiTPTDLWaP2F+v3qUUjHq?=
 =?us-ascii?Q?Nq1QhTwMcYYQcIC+IJBRj6xp1f+RfuFCFaNlY0J0NPdbZFMhN64UTs7HBjg4?=
 =?us-ascii?Q?Clev8u+pu7wO4cDZvg3QEu23nN+83zvmsIwkaRxT5qdOv/7nCeB7GrOa9RvV?=
 =?us-ascii?Q?cpfN6wdS/QOdHyePCt1oKYvMGmRr0FImOjbKdHlsg+5KfcEBmsMMjGv0f42l?=
 =?us-ascii?Q?N/12FYPH9gPLI+po4ONqXobD4cRvIz9RkYCzCzV9CLlNgarbkIAgKF+F5nV8?=
 =?us-ascii?Q?2+1/OXsslzqQdvg3KCmyt2sGtTc3d1DLJbHo8rfgsfZMJL2NZKplKATdPka3?=
 =?us-ascii?Q?Fx1btFb2x86c4FR1hbSLE3mTMJlzEbWazj2ytU9aj4WxLOVq5LTtlMmtBdFl?=
 =?us-ascii?Q?HPbRuxaXuiZ8bsiLV9R15uqeX0UFhM4Lv2NIM6QoCU3r+8BxhXNhiiznZeUk?=
 =?us-ascii?Q?ysjb9pBL01f74m55bs8x/7QlFHDcO2KC32ls/SppI/HwxIcxfGdujaP5QBic?=
 =?us-ascii?Q?mQbQ+kZsNPsIFseLfMGaGq6JaeGrG0Ciz+6iCR/sZaWxNrpaes/2K7IwKJDn?=
 =?us-ascii?Q?cWVMnTzAeqtjWE+20o0maXFnPHUd9x4zdhrT8LvaIUljKsdJ4bEB5x7fzA4u?=
 =?us-ascii?Q?U1UkqVQw/9gzAna/DrL5jsQH1dAE24c8sLbqaIu39jC3nLnT8yDeSVzoPdlx?=
 =?us-ascii?Q?yBfF3sATxwC8Ks8exZeYUvvo7kGLZcdvS73no9DE2xtSvEwxnY+k9S82PNFY?=
 =?us-ascii?Q?jU+3/r/qZns2y9q8Gm4zqEjV145f8ywm81B3wwqshboPsprsY53cwj/hGCKb?=
 =?us-ascii?Q?665u0a14s7+hT3qGuILixyiBAc9NGZmg6II+tLh7XyjmYJxsXSWWM9P+tHRm?=
 =?us-ascii?Q?WIqqgS+OPPv/r41bADiI1LV/VX9W+gQ9AN9MhHH7ngoNzQ7l7mf4+hq1b85U?=
 =?us-ascii?Q?StmSIOJMzLxDPsEOym2CIXw5St5YQvEH2JNGjKCKe9PkHSksgau0P3DRvYlP?=
 =?us-ascii?Q?cLmov0lPHq6dcXjLaHzM7sLDFAKFe1452k34GiXupKhAQULclTPNlEHOf5li?=
 =?us-ascii?Q?o60JXRDF8tL2fCiO1rtkTRGx7Z0CdAQtiZQ79+tyJQAjS/iMWExHR9ZYCwcx?=
 =?us-ascii?Q?VDH5HLNIoN45pAXzIrHjDXTkNaMPL2laLcPjxrlUwU3/1Rbv5dB7kVb0pCj8?=
 =?us-ascii?Q?mxDow/QRJOcTcU5zQQb+ODZvzfEIph52drDCJcu9KAZSQ7DAFxMeRizj2tcL?=
 =?us-ascii?Q?0UDmtXSf9iUbrsh+osOI1f/7nigea8HA0uHeusJePSDWsZdRjIy+JWPFutYV?=
 =?us-ascii?Q?amKj1cXg/U17vjIuiyzO1YQt2vam?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d1d69c-8439-470d-884f-08d8d4309a2b
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 17:14:08.5956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HzNGmfNwUgMIURCOf19dGbZ2fpUa86403Wu3EfZJrP5KUR/BK8ibc68eNAZk+Eoqz9VGyVX7BLtt3aO65WkLQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0434
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
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 18 Feb 2021 17:14:13 -0000

Previously fstat on a FIFO would call fhandler_base::fstat.

The latter is not appropriate if fhandler_fifo::open has already been
called (and O_PATH is not set), for the following reason.  If a FIFO
has been opened as a writer or duplexer, then it has an io_handle that
is a pipe handle rather than a file handle.  fhandler_base::fstat will
use this handle and potentially return incorrect results.  If the FIFO
has been opened as a reader, then it has no io_handle, and a call to
fhandler_base::fstat will lead to a call to fhandler_base::open.
Opening the fhandler a second time can change it in undesired ways;
for example, it can modify the flags and status_flags.

The new fhandler_fifo::fstat avoids these problems by creating an
fhandler_disk_file and calling its fstat method in case
fhandler_fifo::open has already been called and O_PATH is not set.
---
 winsup/cygwin/fhandler.h       |  1 +
 winsup/cygwin/fhandler_fifo.cc | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index e457e2785..78d9c7984 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1510,6 +1510,7 @@ public:
   ssize_t __reg3 raw_write (const void *ptr, size_t ulen);
   void fixup_after_fork (HANDLE);
   void fixup_after_exec ();
+  int __reg2 fstat (struct stat *buf);
   int __reg2 fstatvfs (struct statvfs *buf);
   select_record *select_read (select_stuff *);
   select_record *select_write (select_stuff *);
diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index 8b67037cb..365f14053 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -1494,6 +1494,29 @@ errout:
   len = (size_t) -1;
 }
 
+int __reg2
+fhandler_fifo::fstat (struct stat *buf)
+{
+  if (reader || writer || duplexer)
+    {
+      /* fhandler_fifo::open has been called, and O_PATH is not set.
+	 We don't want to call fhandler_base::fstat.  In the writer
+	 and duplexer cases we have a handle, but it's a pipe handle
+	 rather than a file handle, so it's not suitable for stat.  In
+	 the reader case we don't have a handle, but
+	 fhandler_base::fstat would call fhandler_base::open, which
+	 would modify the flags and status_flags. */
+      fhandler_disk_file fh (pc);
+      fh.get_device () = FH_FS;
+      int res = fh.fstat (buf);
+      buf->st_dev = buf->st_rdev = dev ();
+      buf->st_mode = dev ().mode ();
+      buf->st_size = 0;
+      return res;
+    }
+  return fhandler_base::fstat (buf);
+}
+
 int __reg2
 fhandler_fifo::fstatvfs (struct statvfs *sfs)
 {
-- 
2.30.0

