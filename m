Return-Path: <kbrown@cornell.edu>
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2122.outbound.protection.outlook.com [40.107.243.122])
 by sourceware.org (Postfix) with ESMTPS id CF9FF395B81B
 for <cygwin-patches@cygwin.com>; Thu,  7 May 2020 20:21:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org CF9FF395B81B
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVA/TgWOYdzSVKPRX9aoBPZTbJy2PUn53eTe24cN8fKkO8qKouf9D6iAbhhXdGxvMc0DfJt3uGMJ9Jz2bVCcq8CQk07Q/DlahIyjHV07CFUENG3xUYpPjqjLqWtXdyNSBs8zCZir9ROkogEK+2wyEjzUamRSy/sso3XQdmr79RQePHkXiDcRsc7/hvWEGcGkqH4lR7smmjnMmqAB2U+/LlmCBH1yOP520zXn7qW6QUchiTE7Wt69ya5twlurnegofnn81N3uEmwYe0RMsZV7jdSkkK5i69xzYqDh2ZWsvv9Bqgmmr/OIxFMyJI/aSHggSeyqBwB/ZuyFQcXDBjBDMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aykqxLdBttzyL39p9+zVYh8dAMjMC9Hg+xHIQgmS2vQ=;
 b=KT7j6mfVL2yy/jrPoeLGtULzXWCBZfonzcrGBRdm61Jy7tGmkEWNEcpKrNRNYy2hK51n323G2yLILX1Tv7USQw+Vho0mPj58X84C4c+9O5n1XfA1WT2PnM2KAli54VZus80UJOg+nMvJzoaC6iEYkExHG8sW6GMC472GMPZZIXd3WhvJzSGz4/m4ddSLcYLlXI+She9kEua7ZJZkkFYoX78ExeW6A9i9qUfN9vK6C+sbjJjtu7WmB/SRtaeqMVBWH/BGnwryRjvu67PwhvabQF+qwYg0urtPRW6PVSXFSKPBGIGuBTIsGlpW8zKy/c1tAmNdRj2gH20W8V10Zdn2Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from DM6PR04MB6075.namprd04.prod.outlook.com (2603:10b6:5:127::31)
 by DM6PR04MB5082.namprd04.prod.outlook.com (2603:10b6:5:1a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Thu, 7 May
 2020 20:21:55 +0000
Received: from DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4]) by DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4%4]) with mapi id 15.20.2979.025; Thu, 7 May 2020
 20:21:55 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Cc: sten.kristian.ivarsson@gmail.com
Subject: [PATCH 15/21] Cygwin: FIFO: allow fc_handler list to grow dynamically
Date: Thu,  7 May 2020 16:21:18 -0400
Message-Id: <20200507202124.1463-16-kbrown@cornell.edu>
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
 15.20.2979.28 via Frontend Transport; Thu, 7 May 2020 20:21:54 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [2604:6000:b407:7f00:e532:58da:20b8:9136]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ef44252-065d-4c40-0111-08d7f2c44925
X-MS-TrafficTypeDiagnostic: DM6PR04MB5082:
X-Microsoft-Antispam-PRVS: <DM6PR04MB5082D6553B9F9A6555DCF5ADD8A50@DM6PR04MB5082.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BjmaeMnLRsgM20/8xrz0k+i20/vHWN3kPg7Ta7XC7YlgS12Bo65bZd/UrVaLoQr+/LdCuq6Ju0Eg+CCkSa+E12BcHYRFKbWicSkfLd0JyBEGWj3lgAdRYl9SnLoxHeR4hANHIzOBTpd0+ydj4R4vKZnnNbALF67nESY8hVJygVgz5e5cmjTRHzCkiB0DhMSzNUtf0tTG9bowGe5FtQtYlrAET72Ccp5rfGQdn+LKeLE0bhPVfLDcl7IRMi8A5e3kqDJZDBDK/OPda8VmJ2sklrXqv/7D/pwESg9iSNvt8YqTbmX9AykFq9P2MRBs5Vf8ewPczD+RW5QVXkIeJjrp8v5u6CoC4AY4pcObS95nNXazvFTP02CTSbb5EuAFt0Ry2GOG7e0ngnWWehx3BcjYF3bi+m1U264r1XLIlP199+WmAjJx6JMTPq0d+uiAhVcpS6c2SKJTObWfMy6eruTVN/jfxl4ZobKpkiutRDlQKChCKOw7f1kgTcsHAE3ti3lGD/AzmX1NaiRphSClxWYGYpl1I53FJF+w29vJXP6kfQ17ho+xAqvFTbcuXGcf75XZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6075.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(33430700001)(66556008)(86362001)(786003)(6666004)(186003)(6512007)(75432002)(52116002)(66476007)(69590400007)(316002)(6506007)(2616005)(4326008)(478600001)(5660300002)(1076003)(36756003)(2906002)(33440700001)(16526019)(6486002)(66946007)(8676002)(6916009)(8936002)(83320400001)(83280400001)(83310400001)(83290400001)(83300400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: PaLEhJJfyslNto0QyZ7OxZzFMAB9jsnl3BvNXWD3NY5CBABrqquJIQOJsSDGztnWhnoFD4du2pW37WYFaBVz+1JUdnO9MookFt0o3W8LU5BAlvAa+YupMM1pz1/WvFeenidJRfWwyrqx8958IQZaygUro53BUNYa2L6Gj6xsi7qk97Feme4UiUV72WfNqlihllriOCxz+JXWfpORQSLkRVc2fYR+0B1PTcYl1B4sDmE12qMERZ4QVk3gEcH3n3yq9ce7CafXyNhMk2r5UMJ4jgWdRXq3VliWmEPGlJogkSwbZ3Goh4gTvtgkcmt8/RhlvOIVcyrzCNi2xGS4Mx6OK+M95f66+ipJ2Mx8tZK6bT4bVJzYsEF1KRVvt0sHjJN2O6UddJyTvQfSD+TahSQkt6zKQ/hxo7b276qXcPHiDmJ+qAU2AoKOjHbXdEawcZSJ+vRaNU6lQ5XWhHz/4aj0n054476zLxf+epn8D60Oci6vrMTXw8nrOcaTTNAU9BHXSZEDhwrRAt+M89kemBhAeoBUJ3QB0z6jEsUI8GbckUjoCXxx26InqIbhJkN39wDssPoj3Cqx7k0VeSxXZFR9emY87XEgWUkkaEvbU5ampmOHmuBqT1IlqJRgyOdLzGu6VG40NST5nSlTxW6yj0VYctBLQN7Ddmb/1QuOjefwA7StVvRFoeZOheEVYfwYv0P0cW8wBADr0511grB8IVpYJ8gWqLPI3x5pPvjRT+r1tT9RkoavHAFv6BT36kA1k+70AXhgg3Kng+fbNGb3iSXSG/j4v38y+x4IiQXUokcpR9+004uqbFHbMDy38Jp30D+OJVRhMV67lNVZntxRyTVKMB9UB6yopH7MoTCrX+j6auiTtHj16Unyr7HKWJsOGtoB
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef44252-065d-4c40-0111-08d7f2c44925
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 20:21:55.2817 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IZ+ej8M1y67YTzD516bbmmTG8WFb6IyTKKSCXIzEuGSpx5a2L/zkaeLkLlTHK3qzKQaq7T5fJHDkv1tzKFrEKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5082
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 07 May 2020 20:21:58 -0000

Make fc_handler a pointer to malloc'd memory instead of a fixed-size
array.  The size is now a new data member 'shandlers'.  Call realloc
in add_client_handler if we need to grow the array.

free fc_handler in close.  As long as we're touching that code, also
remove an unneeded lock.
---
 winsup/cygwin/fhandler.h       |  6 ++---
 winsup/cygwin/fhandler_fifo.cc | 41 +++++++++++++++++++---------------
 2 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index bd44da5cd..4f42cf1b8 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1268,7 +1268,6 @@ public:
 };
 
 #define CYGWIN_FIFO_PIPE_NAME_LEN     47
-#define MAX_CLIENTS 64
 
 /* The last three are the ones we try to read from. */
 enum fifo_client_connect_state
@@ -1351,8 +1350,9 @@ class fhandler_fifo: public fhandler_base
   UNICODE_STRING pipe_name;
   WCHAR pipe_name_buf[CYGWIN_FIFO_PIPE_NAME_LEN + 1];
   bool _maybe_eof;
-  fifo_client_handler fc_handler[MAX_CLIENTS];
-  int nhandlers;
+  fifo_client_handler *fc_handler;     /* Dynamically growing array. */
+  int shandlers;                       /* Size (capacity) of the array. */
+  int nhandlers;                       /* Number of elements in the array. */
   af_unix_spinlock_t _fifo_client_lock;
   bool reader, writer, duplexer;
   size_t max_atomic_write;
diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index 0b9b33785..595e55ad9 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -70,7 +70,8 @@ static NO_COPY fifo_reader_id_t null_fr_id = { .winpid = 0, .fh = NULL };
 fhandler_fifo::fhandler_fifo ():
   fhandler_base (),
   read_ready (NULL), write_ready (NULL), writer_opening (NULL),
-  cancel_evt (NULL), thr_sync_evt (NULL), _maybe_eof (false), nhandlers (0),
+  cancel_evt (NULL), thr_sync_evt (NULL), _maybe_eof (false),
+  fc_handler (NULL), shandlers (0), nhandlers (0),
   reader (false), writer (false), duplexer (false),
   max_atomic_write (DEFAULT_PIPEBUFSIZE),
   me (null_fr_id), shmem_handle (NULL), shmem (NULL)
@@ -287,27 +288,28 @@ fhandler_fifo::wait_open_pipe (HANDLE& ph)
 int
 fhandler_fifo::add_client_handler ()
 {
-  int ret = -1;
   fifo_client_handler fc;
   HANDLE ph = NULL;
 
-  if (nhandlers == MAX_CLIENTS)
+  if (nhandlers >= shandlers)
     {
-      set_errno (EMFILE);
-      goto out;
+      void *temp = realloc (fc_handler,
+			    (shandlers += 64) * sizeof (fc_handler[0]));
+      if (!temp)
+	{
+	  shandlers -= 64;
+	  set_errno (ENOMEM);
+	  return -1;
+	}
+      fc_handler = (fifo_client_handler *) temp;
     }
   ph = create_pipe_instance ();
   if (!ph)
-    goto out;
-  else
-    {
-      ret = 0;
-      fc.h = ph;
-      fc.state = fc_listening;
-      fc_handler[nhandlers++] = fc;
-    }
-out:
-  return ret;
+    return -1;
+  fc.h = ph;
+  fc.state = fc_listening;
+  fc_handler[nhandlers++] = fc;
+  return 0;
 }
 
 void
@@ -1067,10 +1069,10 @@ fhandler_fifo::close ()
     NtClose (write_ready);
   if (writer_opening)
     NtClose (writer_opening);
-  fifo_client_lock ();
   for (int i = 0; i < nhandlers; i++)
     fc_handler[i].close ();
-  fifo_client_unlock ();
+  if (fc_handler)
+    free (fc_handler);
   return fhandler_base::close ();
 }
 
@@ -1130,7 +1132,8 @@ fhandler_fifo::dup (fhandler_base *child, int flags)
       fhf->fifo_client_unlock ();
 
       /* Clear fc_handler list; the child never starts as owner. */
-      fhf->nhandlers = 0;
+      fhf->nhandlers = fhf->shandlers = 0;
+      fhf->fc_handler = NULL;
 
       if (!DuplicateHandle (GetCurrentProcess (), shmem_handle,
 			    GetCurrentProcess (), &fhf->shmem_handle,
@@ -1206,6 +1209,8 @@ fhandler_fifo::fixup_after_exec ()
 
       if (reopen_shmem () < 0)
 	api_fatal ("Can't reopen shared memory during exec, %E");
+      fc_handler = NULL;
+      nhandlers = shandlers = 0;
       me.winpid = GetCurrentProcessId ();
       if (!(cancel_evt = create_event ()))
 	api_fatal ("Can't create reader thread cancel event during exec, %E");
-- 
2.21.0

