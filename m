Return-Path: <kbrown@cornell.edu>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770093.outbound.protection.outlook.com [40.107.77.93])
 by sourceware.org (Postfix) with ESMTPS id A4B8D396E85B
 for <cygwin-patches@cygwin.com>; Thu,  7 May 2020 20:22:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A4B8D396E85B
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4wmpX/4tzVXNhIOxlwDGdSAj/0Y3hsbhQ0CTCM3SRURuv9bYxw48unsUS7DF3LKQfdR353y7n8Q6YUxGxZdIumx8Bs4B7mNVogV9PV8oRTb3aIDaWbWZt+MqUYbt/J6ysGpvGlrjbPsTERixRrNSEF3Rv80DevNVkE5Hva4BcwEdGRraAf92Dh9XLdaVitkT9mMqAGHu8vWzi+tp9PIAzOxCL62YUIoukaD/oIo01spuJlnB425CSDq2rCsYl2mQ+KMfqh6XreFlQQ1DMhi73yvCNIytfmb0r2SZzA6UHtWJILNta6y4VCv0iQh827eoUpHfHrfHDTgOvA1lvDGuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6tRSAW/23LoL7IL9AuXeZ1I74Oh87Sbk5Mjlr/q+Sc=;
 b=f4jViZOVNEPFpY/paLVHQQxXoCvnvClz93G29uW/Bn0Tww7i2R1wBtOAYtxv57m3MUF/OjjOI3/UNWOC/HKqtRSfOIR115QZs75srgtnx0YbvFff8XsJTxb10XUPY8TnkpW35tKw8+rAmyLZqR/Vl86s6fytBdfGkjjSWMP5v218Z6q69u5lPprVGZt7gWu3B3iZPjjSybFSrJgZW2kHTbJLtoTqYV6peY0yJTIPv8Annsux9lLjnE+QAjXUIlIHZfrwomjvxFlb0Cu/NqRhu6uErURqBjUkOoW/+GsnGyl+kcJfiO7v8PcC9ta5nwG93AFQyhMVfIor3bkxDv2iZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from DM6PR04MB6075.namprd04.prod.outlook.com (2603:10b6:5:127::31)
 by DM6PR04MB6075.namprd04.prod.outlook.com (2603:10b6:5:127::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Thu, 7 May
 2020 20:21:53 +0000
Received: from DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4]) by DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4%4]) with mapi id 15.20.2979.025; Thu, 7 May 2020
 20:21:53 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Cc: sten.kristian.ivarsson@gmail.com
Subject: [PATCH 13/21] Cygwin: FIFO: introduce a new type, fifo_reader_id_t
Date: Thu,  7 May 2020 16:21:16 -0400
Message-Id: <20200507202124.1463-14-kbrown@cornell.edu>
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
 15.20.2979.28 via Frontend Transport; Thu, 7 May 2020 20:21:52 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [2604:6000:b407:7f00:e532:58da:20b8:9136]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8142368-63a0-400e-f4b0-08d7f2c447e7
X-MS-TrafficTypeDiagnostic: DM6PR04MB6075:
X-Microsoft-Antispam-PRVS: <DM6PR04MB6075AB6D9357253BF9C654F0D8A50@DM6PR04MB6075.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:489;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0lbAKe+dMWm96Z+d+HkdPjzSAn7+yOecNX/2scUibXWnOQ1V5jDcNmKkPUJQSxm28G9mwXqbdVHq2OpbWoPrDwKYhIGjBCsBScUoLXDO3AuD6LfoGU34/cZ3PijRXgsGeZnL1e8utqb9wr+1gIti5Woajkdqg9WR3apYD3OKLLSdPqV7ofEjmagVM1frzxZNUV+Lq5radbmLLAlA3euhMCWHa1o5EVmX2WmEqf0GQ9bJ7vHtCbrwoNT/DYv/82HNu2ASjYVQW/sovK8UxFgMEPuPeCDDs+CtqYWNDzg9uuDdQukcy0pBpg0iAvaZUoDvh6KCx8tckeu8qI+l+vgeznWRpQp1N+p3sgALuFXTzi9+7fyyK4MAyF6lvmmVc8qll4vqFjSE7bCYGXtriW5ta++euH/F/McgOQz/f871pQADgrg39MDty9oww32Bferg/L6XLNj+S3K3bPsYKb5cjMfxUsOzf0aoARQ4yHYab0BUSGZ7Vb7ufQl+jMZhPK+Fmnkf2XNP64eZkNbSvsXQN7byUilpnmy/ur6nvgUQcFSzcy1maz+I3r8W7pCb2fUf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6075.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(33430700001)(33440700001)(6512007)(6486002)(478600001)(786003)(8676002)(66946007)(1076003)(5660300002)(8936002)(83300400001)(66476007)(316002)(83320400001)(83280400001)(83310400001)(83290400001)(66556008)(69590400007)(75432002)(36756003)(2616005)(4326008)(86362001)(6666004)(2906002)(6916009)(186003)(6506007)(16526019)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ETZiiJeottgiKpmZHlCaEYjOM4hjIMly+97iiYNXZrdc4z2FUYI2Cl7dugDZE79iGd0L6Gn+2tM46CtmC3779zetf0fXSntMHq5ZF9+nvUq/dbLRkGB16rxiBMQwRvbE9zHo9/TgHeb09GOso6fcxtJs3lKuXJUVO5c601M64Fqz09k0gY9ERjtDKWVfR0iDQk44YNzx195l3780soBtuPdfVR5x38RixHo45r0KcKJ+LFYxmlL220rXMsivCDc3va+txFmXSk9sDuRTiuzVx1k4nnbbcV8qToFSE1ANSgPpe0b1KTP9J1V62GUxVSs19fcG+hYLhhe4ehurpNmzsyncDh/eHExBoYI9j4JdYQq9QvKMXOC30adsHc2bBrmy8TTvrDOG2bhJHnAIltupsOFyDB46ecXY40/h1fxMwB1boEB+sXUYL+Wha94Xj+QscKA3uLehuKoBrjb1qh3dUgMXM1TGxmAR0BvsbVNlLQK6WoawPAilShHHSLevT81tIaYXIKleoMcIZTRvojdkeC1E3KVovJ1wy3VwgXL8TfL+5lMAQcSY8QnjzmoMBlc9UGp9LoK3rqkh/sAQZ1hkDZCrwnPF0Cg4F1+Pp9RM8IJwYoerK264su8y9VviPf4T26s2yiaSbz9d8qnjVGft9Tosqhq+9OGQw03Rg3PC/f2l/slyfrUl8flxLlnGDOjq7P4TuK1qU52yJ0rqBhPd+FB5PliXwkrxZljxpNkFlWbIU3ov/hO/aWiiBxoGglgsCq0+MS+ezWsCHwXE27ZnvQrMMbZnBgk7pLtW4Xn+jyrtcDxy6Qquz4faJ7kTwMbcK+7jol968SKcCjUePyobdFEGiO9kWL3OQT137SzxVl1cuUQidcHP/UXI2T0B72jK
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: b8142368-63a0-400e-f4b0-08d7f2c447e7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 20:21:53.4817 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YuRpxS42T0bQXqPhDU80GJNkJB1LUh512qmyADoyu2R+Qmg9OZj6zUq6L5YEgDXfA49Jk9goFBOVoGYO3s6yGg==
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
X-List-Received-Date: Thu, 07 May 2020 20:22:12 -0000

This uniquely identifies an fhandler_fifo open for reading in any
process.

Add a new data member 'me' of this type, which is set in open, dup,
fork, and exec.
---
 winsup/cygwin/fhandler.h       | 23 +++++++++++++++++++++++
 winsup/cygwin/fhandler_fifo.cc |  9 ++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index b2ee7e6b6..65aab4da3 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1300,6 +1300,26 @@ struct fifo_client_handler
   int pipe_state ();
 };
 
+class fhandler_fifo;
+
+struct fifo_reader_id_t
+{
+  DWORD winpid;
+  fhandler_fifo *fh;
+
+  operator bool () const { return winpid != 0 || fh != NULL; }
+
+  friend operator == (const fifo_reader_id_t &l, const fifo_reader_id_t &r)
+  {
+    return l.winpid == r.winpid && l.fh == r.fh;
+  }
+
+  friend operator != (const fifo_reader_id_t &l, const fifo_reader_id_t &r)
+  {
+    return l.winpid != r.winpid || l.fh != r.fh;
+  }
+};
+
 /* Info needed by all readers of a FIFO, stored in named shared memory. */
 class fifo_shmem_t
 {
@@ -1329,6 +1349,7 @@ class fhandler_fifo: public fhandler_base
   af_unix_spinlock_t _fifo_client_lock;
   bool reader, writer, duplexer;
   size_t max_atomic_write;
+  fifo_reader_id_t me;
 
   HANDLE shmem_handle;
   fifo_shmem_t *shmem;
@@ -1362,6 +1383,8 @@ public:
   void fifo_client_lock () { _fifo_client_lock.lock (); }
   void fifo_client_unlock () { _fifo_client_lock.unlock (); }
 
+  fifo_reader_id_t get_me () const { return me; }
+
   int open (int, mode_t);
   off_t lseek (off_t offset, int whence);
   int close ();
diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index d87070ac7..5676a2c97 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -65,13 +65,15 @@ STATUS_PIPE_EMPTY simply means there's no data to be read. */
 		   || _s == STATUS_PIPE_NOT_AVAILABLE \
 		   || _s == STATUS_PIPE_BUSY; })
 
+static NO_COPY fifo_reader_id_t null_fr_id = { .winpid = 0, .fh = NULL };
+
 fhandler_fifo::fhandler_fifo ():
   fhandler_base (),
   read_ready (NULL), write_ready (NULL), writer_opening (NULL),
   cancel_evt (NULL), thr_sync_evt (NULL), _maybe_eof (false), nhandlers (0),
   reader (false), writer (false), duplexer (false),
   max_atomic_write (DEFAULT_PIPEBUFSIZE),
-  shmem_handle (NULL), shmem (NULL)
+  me (null_fr_id), shmem_handle (NULL), shmem (NULL)
 {
   pipe_name_buf[0] = L'\0';
   need_fork_fixup (true);
@@ -575,6 +577,8 @@ fhandler_fifo::open (int flags, mode_t)
 	goto err_dec_nreaders;
       if (!(thr_sync_evt = create_event ()))
 	goto err_close_cancel_evt;
+      me.winpid = GetCurrentProcessId ();
+      me.fh = this;
       new cygthread (fifo_reader_thread, this, "fifo_reader", thr_sync_evt);
 
       /* If we're a duplexer, we need a handle for writing. */
@@ -1119,6 +1123,7 @@ fhandler_fifo::dup (fhandler_base *child, int flags)
       if (!(fhf->thr_sync_evt = create_event ()))
 	goto err_close_cancel_evt;
       inc_nreaders ();
+      fhf->me.fh = fhf;
       new cygthread (fifo_reader_thread, fhf, "fifo_reader", fhf->thr_sync_evt);
     }
   return 0;
@@ -1164,6 +1169,7 @@ fhandler_fifo::fixup_after_fork (HANDLE parent)
       if (!(thr_sync_evt = create_event ()))
 	api_fatal ("Can't create reader thread sync event during fork, %E");
       inc_nreaders ();
+      me.winpid = GetCurrentProcessId ();
       new cygthread (fifo_reader_thread, this, "fifo_reader", thr_sync_evt);
     }
 }
@@ -1179,6 +1185,7 @@ fhandler_fifo::fixup_after_exec ()
 
       if (reopen_shmem () < 0)
 	api_fatal ("Can't reopen shared memory during exec, %E");
+      me.winpid = GetCurrentProcessId ();
       if (!(cancel_evt = create_event ()))
 	api_fatal ("Can't create reader thread cancel event during exec, %E");
       if (!(thr_sync_evt = create_event ()))
-- 
2.21.0

