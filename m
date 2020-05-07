Return-Path: <kbrown@cornell.edu>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770133.outbound.protection.outlook.com [40.107.77.133])
 by sourceware.org (Postfix) with ESMTPS id A48E1395B81B
 for <cygwin-patches@cygwin.com>; Thu,  7 May 2020 20:22:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A48E1395B81B
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVkXuK46LYhYjHU22poIRG0jCH++34+kQwpqbOLyw81ri7i9UmKmQ0aibjjxuJ7HuOkQN4nk6h3Q91v1Z0GdkBFcXbI9kpMiYWeCg4bd8hBrmXBmC5YgCiHwq3z5Ndn0p1ljv/2UAfvSJDWn4hsjok1Bi10dFXqq9RF8qSszKIrlWCcrr9RepwGWv/i0YIVfokD8blXsPT87yk5rCiFKJY4k5U3rzJFxcdxgK4WfjExLg0lcJfsECJAUZaQvo+IE708zOCdjcMw41KvNR31UegJPBVsIY7xzDIV2/j4Y8i+LH/rpHOCK+O1/nZlMYAgL7RkJdgwpasyFMg/5+vKSdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFngu5h+aGKgX5jg/2TcCQdXSsKaGkxkAuJcua8qHtY=;
 b=cM4VA/ouxTylfqhepVmPe3hSfzkaMGvcJhvPgxZWjBNbuUcfgjQAvRY5tRQ6cxOwsBaWTEZcwiNrqb/v245Hzh66wiGyUZnQdlsQUglyIffI75t0Ig9asizFElsDWlUWFXf1wapKCbYU8+WWr51toWdr0gAU4ktuZb+DOdb4z7yhh/q9S3Bz/f+aFsSP7sN28n8W+cFRiSikQ4pQThnuulk/JVT5Wa9luobOFjyrhqql6AYw1dGmFuP6OngcL9lcNChCT5Ztjo5s2rLXvIDAZScImJp00YG5XqUTt3hKbY3ONgLxARbUYbWfsYtxmCVoMKGEtWmntoCi3ZOEMkd9uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from DM6PR04MB6075.namprd04.prod.outlook.com (2603:10b6:5:127::31)
 by DM6PR04MB6075.namprd04.prod.outlook.com (2603:10b6:5:127::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Thu, 7 May
 2020 20:21:52 +0000
Received: from DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4]) by DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4%4]) with mapi id 15.20.2979.025; Thu, 7 May 2020
 20:21:52 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Cc: sten.kristian.ivarsson@gmail.com
Subject: [PATCH 12/21] Cygwin: FIFO: keep track of the number of readers
Date: Thu,  7 May 2020 16:21:15 -0400
Message-Id: <20200507202124.1463-13-kbrown@cornell.edu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200507202124.1463-1-kbrown@cornell.edu>
References: <20200507202124.1463-1-kbrown@cornell.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0064.prod.exchangelabs.com (2603:10b6:208:23f::33)
 To DM6PR04MB6075.namprd04.prod.outlook.com
 (2603:10b6:5:127::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2604:6000:b407:7f00:e532:58da:20b8:9136)
 by MN2PR01CA0064.prod.exchangelabs.com (2603:10b6:208:23f::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.28 via Frontend Transport; Thu, 7 May 2020 20:21:51 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [2604:6000:b407:7f00:e532:58da:20b8:9136]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0768228d-baba-4dcc-45c4-08d7f2c44704
X-MS-TrafficTypeDiagnostic: DM6PR04MB6075:
X-Microsoft-Antispam-PRVS: <DM6PR04MB607556E90B6D973272EAFF02D8A50@DM6PR04MB6075.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ael3C2mWZXRhDC/zMvCkrT6kLFDEX28c5sZJkaWpmT/qjBTIiQc03jdZ4zafWUrTmRXK0WSaz1ZoMhMr2u8aV4GyVMzD5NiMk/JeUlljtuo1LT78QIMplL9OjgnX8hRJOzwNcI+SOtXIbVpx5qBvvtMBhLd6w4Sd/AEwxibZSgduWcO00A7EYVEM9pzphs7XdqXT8MX6dx60cb9tEpXhCk1dC+Hbu682/i2eaFfOMVlXhciH2MMsnkRunaPOysv6uag87z49ztsEB2R63bzO9Gc5zLdWk/Cg0VswH/4MLK1lrLVz8OYAREio9YciBp2gJL+Eiod7N6+Q/uboENttU/8cG3ZAFNug6YUyIO/o3zXlWJeiVICIdnj9kY6aVpzAMAU5zyY/gTQQe1U3J4WpWx0PnJ66ydiIFGqrsn8/UDPc9eLEVh+6LdNXNy2E9E5tpG0LvMWewdN/wZCX+Y/HN/YJC0Hh7JWjZwfwjEubo+HPvn+v9GOmGLmd2oQhG3/xa530Q2Mfp252iuybhSfPxljZsVptamE2hD9mKgjrhU6yiWqOg5yvVKjkQ3hRFvUz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6075.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(33430700001)(33440700001)(6512007)(6486002)(478600001)(786003)(8676002)(66946007)(1076003)(5660300002)(8936002)(83300400001)(66476007)(316002)(83320400001)(83280400001)(83310400001)(83290400001)(66556008)(69590400007)(75432002)(36756003)(2616005)(4326008)(86362001)(6666004)(2906002)(6916009)(186003)(6506007)(16526019)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: IXLJqlmgZ9sYduM2nLC29m0KFwRCO+fp2/ACm20R6/8YVQKPknlME7p6g+xDB2H+qdwYAQ+PVUbVczEDeH7i2hTx4f+Sv/atKlzCvsXQ509E0CfM8ywXzc5ctcmZetciSfwZSYLAddwgcBiT2+7lqn0+VglIM7x9o25S9Xlqf6OWh7pDeUHH1gzXOqiL3tKLkxV8W3+eCmuw5Uzo1Fp7WiziLbIwIjWqBngZmd70pFzEBFiAKJJTK4WtUXXhV6tlP11WiLY6Q53DVdQKXecNc/ZwQGIXe8SU4qGfoUFpZFKyRYRxiqA9TEa87rUAgnI4q9nP8jyHLRnbg5XaDFX9HxyHs8OkA1+LyAGUONKbIO0q5eXDpOBzgAPGl2+qBC3MoTP5UkqoAt5MyzqLcIENZa9i0jfb4Pby+gI647uHwqz8lQwSzEtsSZ3kTXdKhDUBO1cEpnrF7dLDkxXR5/FibOZ5kX9n8IRHuYguHpc5mZQpLXeUq45dK2SX6DQt1WSJLAVRTnZ/mKPKCtQliusCpqGZDEGJn+JrNSnJf4kHxOqWjZ6dV6Kasn7DWDq7eH3K5MDhV0hB7RtVHZTigCiTO1wEJ9+mZwHnFQH0N5nWMbY5gdpmnBFvLsvmBi7J/T6b0MY6OJw0RgkkLxyHxofXtdSTPQFgdhER4X6Q7xpwPTyPkB4x/eovk3cDAbqft69yxqAjcMccguXrxPhp2FAyt3SqAWtWZDgNj7FGnTEsLoklnGv05ajQMDukDUhH4Ajd1IHd+AExiox5eqkgwN94cXYmkdIZpr0vyb1+CqjM6OJ/ipEoa++/mV0uvh68+GIkipINQR39QdMm7+mUOuVsuqPk7Fc/DEtjJj6aKPwPNHWpJSbnV0ZAG2SW0A4o1jO3
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0768228d-baba-4dcc-45c4-08d7f2c44704
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 20:21:52.2304 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +VAODIRCiSknmigb3J1mRZAN1+QCFr/9w5lg7+SDzTm6TxkvffpFp3pMYKIm3xYWKLPdFO/jnYUm/QsytTQeoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6075
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, MSGID_FROM_MTA_HEADER,
 RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
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
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 07 May 2020 20:22:14 -0000

Add data and methods to the shared memory that keep track of the
number of open readers.

Increment this number in open, dup, fork, and exec.  Decrement it in
close.  Reset read_ready if there are no readers left.
---
 winsup/cygwin/fhandler.h       |  8 ++++++++
 winsup/cygwin/fhandler_fifo.cc | 22 ++++++++++++++--------
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 8d6b94021..b2ee7e6b6 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1303,6 +1303,11 @@ struct fifo_client_handler
 /* Info needed by all readers of a FIFO, stored in named shared memory. */
 class fifo_shmem_t
 {
+  LONG _nreaders;
+
+public:
+  int inc_nreaders () { return (int) InterlockedIncrement (&_nreaders); }
+  int dec_nreaders () { return (int) InterlockedDecrement (&_nreaders); }
 };
 
 class fhandler_fifo: public fhandler_base
@@ -1342,6 +1347,9 @@ class fhandler_fifo: public fhandler_base
   int create_shmem ();
   int reopen_shmem ();
 
+  int inc_nreaders () { return shmem->inc_nreaders (); }
+  int dec_nreaders () { return shmem->dec_nreaders (); }
+
 public:
   fhandler_fifo ();
   bool hit_eof ();
diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index 9a0db3f33..d87070ac7 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -570,8 +570,9 @@ fhandler_fifo::open (int flags, mode_t)
       SetEvent (read_ready);
       if (create_shmem () < 0)
 	goto err_close_writer_opening;
+      inc_nreaders ();
       if (!(cancel_evt = create_event ()))
-	goto err_close_shmem;
+	goto err_dec_nreaders;
       if (!(thr_sync_evt = create_event ()))
 	goto err_close_cancel_evt;
       new cygthread (fifo_reader_thread, this, "fifo_reader", thr_sync_evt);
@@ -680,7 +681,10 @@ err_close_reader:
   return 0;
 err_close_cancel_evt:
   NtClose (cancel_evt);
-err_close_shmem:
+err_dec_nreaders:
+  if (dec_nreaders () == 0)
+    ResetEvent (read_ready);
+/* err_close_shmem: */
   NtUnmapViewOfSection (NtCurrentProcess (), shmem);
   NtClose (shmem_handle);
 err_close_writer_opening:
@@ -1003,15 +1007,13 @@ fhandler_fifo::close ()
 {
   if (reader)
     {
+      if (dec_nreaders () == 0)
+	ResetEvent (read_ready);
       cancel_reader_thread ();
       if (cancel_evt)
 	NtClose (cancel_evt);
       if (thr_sync_evt)
 	NtClose (thr_sync_evt);
-      /* FIXME: There could be several readers open because of
-	 dup/fork/exec; we should only reset read_ready when the last
-	 one closes. */
-      ResetEvent (read_ready);
       if (shmem)
 	NtUnmapViewOfSection (NtCurrentProcess (), shmem);
       if (shmem_handle)
@@ -1116,8 +1118,8 @@ fhandler_fifo::dup (fhandler_base *child, int flags)
 	goto err_close_handlers;
       if (!(fhf->thr_sync_evt = create_event ()))
 	goto err_close_cancel_evt;
-      new cygthread (fifo_reader_thread, fhf, "fifo_reader",
-		     fhf->thr_sync_evt);
+      inc_nreaders ();
+      new cygthread (fifo_reader_thread, fhf, "fifo_reader", fhf->thr_sync_evt);
     }
   return 0;
 err_close_cancel_evt:
@@ -1161,6 +1163,7 @@ fhandler_fifo::fixup_after_fork (HANDLE parent)
 	api_fatal ("Can't create reader thread cancel event during fork, %E");
       if (!(thr_sync_evt = create_event ()))
 	api_fatal ("Can't create reader thread sync event during fork, %E");
+      inc_nreaders ();
       new cygthread (fifo_reader_thread, this, "fifo_reader", thr_sync_evt);
     }
 }
@@ -1180,6 +1183,9 @@ fhandler_fifo::fixup_after_exec ()
 	api_fatal ("Can't create reader thread cancel event during exec, %E");
       if (!(thr_sync_evt = create_event ()))
 	api_fatal ("Can't create reader thread sync event during exec, %E");
+      /* At this moment we're a new reader.  The count will be
+	 decremented when the parent closes. */
+      inc_nreaders ();
       new cygthread (fifo_reader_thread, this, "fifo_reader", thr_sync_evt);
     }
 }
-- 
2.21.0

