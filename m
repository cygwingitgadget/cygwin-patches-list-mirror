Return-Path: <kbrown@cornell.edu>
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2122.outbound.protection.outlook.com [40.107.243.122])
 by sourceware.org (Postfix) with ESMTPS id A85C4397248C
 for <cygwin-patches@cygwin.com>; Thu,  7 May 2020 20:22:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A85C4397248C
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cg/agNMY1Q15X0F/a3SSYKFTsRg/AFtefXjaFsn5+bdnIToWD2cSkT0edhfN/4PaNr+gK9eLpMtaFUUloVCz4RXlN05P/oX/aq4wqyVHFkS0IL/SZu7LwlerFdOxTGjsu1tvhqgI6pDOFtA9jP5YEi73JWB5XEAscQbYXN9kE9RwfdlazQ5eZhgs222Nts2UxbGTi8rnogRXU3ukz4WMrzQu4vaLO1O7hOCAs5qoXg/zFA8IhFsxf7ja39YZ3A9Lt4AIPk3AhNUd558M3AXRyQTqMzprvCzTICXiKDY8bQmpoZjqts0ZQSGka16OpretlHC5BBdENI1/+qQmYbaWBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ia59ejloJrKqygZLolctx5HRmfzIe6LG1SdbTThkzrU=;
 b=DLq7DtWo6eDHEXiyQPNcqc6VPv3s/MqUy6RjjcwRM35WGIjRoMzEFSLO1RDXX24MZ9/1xqmDtlw0rXIHnqnU6qs9ayP3D2PivKyPSYQMK6IJeEnvZ+4uj95VRjt4SreqrEUCcAn1cZl1xLFGCdAsiXdAv754agwdo9S7deMDghzy6fJee3VvS05tEtaBBXQFuwq8h2T6X84N4Kk8DCJrxxBHfhd6KH/YWnJfeMRxwqXe/cQhUJuhfgZZ7ZtwCEo1d7SVHoyBDW7D7RIX/G6vLse0IGY5mF9IKM99ncbMTZyNTqoQcdCpbFvyAGHh9gGGYg4TMeNx1qktFwhz7Juetw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from DM6PR04MB6075.namprd04.prod.outlook.com (2603:10b6:5:127::31)
 by DM6PR04MB5082.namprd04.prod.outlook.com (2603:10b6:5:1a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Thu, 7 May
 2020 20:21:58 +0000
Received: from DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4]) by DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4%4]) with mapi id 15.20.2979.025; Thu, 7 May 2020
 20:21:58 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Cc: sten.kristian.ivarsson@gmail.com
Subject: [PATCH 19/21] Cygwin: FIFO: allow any reader to take ownership
Date: Thu,  7 May 2020 16:21:22 -0400
Message-Id: <20200507202124.1463-20-kbrown@cornell.edu>
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
 15.20.2979.28 via Frontend Transport; Thu, 7 May 2020 20:21:57 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [2604:6000:b407:7f00:e532:58da:20b8:9136]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b9df87f-43d1-4ac3-9d92-08d7f2c44b0d
X-MS-TrafficTypeDiagnostic: DM6PR04MB5082:
X-Microsoft-Antispam-PRVS: <DM6PR04MB508225514CDD1683FD079CAAD8A50@DM6PR04MB5082.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:451;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P9ruPny+a9TWpIGU20z4SfMqwZgqNTuxhgoEH72FuLgJYI14cV7Z7QXWOv4b/ELGpr2TCDkh6JO3EUO8derGRYfopM872gxmeHFA0HSwdtkb8jPyrMUGm6nlxPbSyfbxc2QLHIMmGWCXZvryttSIVBWzMVZIvc+Pap+bMnFn7hD1AJaF7viGwFAMIGrQvAeYFY5LSJ4MUEnBGibG7hL6M/ZvqbINTU74zJWdYskuIdYr/1TNZERTx6FbRWAoJmt3/3E6LRNZBFvHpv+bQLDAcUCvZf7oAY53Mc6PdgNbLFt7fyhfG2O2QHpQVAEpylY5MwwWAtxxTPCtwju8H2LWukA5BYbN6soNSllC517B4FvQc6cuCZ1AzjQH/aY9W6OPnixjbhjjz6OqomPZS3wkS1IkdgnE5Pl6a1SWVt5gntoDFsosr62n+dNfS315Iqp9fdx3eMq+h525EphKMH3757MI6qFFV7thLg7MYPhLLcF1W/QlB9aPd25Kvxuu1wFN2lf+HOwVn1Pys6SvDzaj01WeIp2gTvyuQplYwiG7OuozwyF49XyYZDgj2nmqwC6i
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6075.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(33430700001)(66556008)(86362001)(786003)(6666004)(186003)(6512007)(75432002)(52116002)(66476007)(69590400007)(316002)(6506007)(2616005)(4326008)(478600001)(5660300002)(30864003)(1076003)(36756003)(2906002)(33440700001)(16526019)(6486002)(66946007)(8676002)(6916009)(8936002)(83320400001)(83280400001)(83310400001)(83290400001)(83300400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 4/saOuubevyocSjKCYCjpdgSCf6s8h373+CBf0grscK35DPd2ciL1Sn9nMdWcvi1l10OfCISl8Y3MgquJPY4JtzAgdl+dndzo5O5RBz+wX0v93/ky7fa+F3ddsYc1f6bUcOnF4PeKcJi/+MVvUcpycP7Bn2Jfy+9gdNp2/y9eor5ssNTgKNREDrGjZTodWfgbRyRVhAHhPfVRl/GGhgnNJS3givuMGq6sNIbn0a/H+ixZ2clBdgPYi5SNexOusQVo7jEh2isWBO0TJ0WB3ZtBc/AtQFpZ5zFrHsmflMGVuuBbd1wDwIny1m/OtbidLUEbMvWRLScgcmSKawcwUz9Vk4/kJ7avRIMEpFZ0t/x84VHCl4GMsz9eCa3fK2xJGm9FS6KPI27PpAu782+uzuu9FkSgURos8t81pHQzqHrf0xkXWjE8MJpmpB50BxPkHSRLS/MDdNYUEwkymwB57BdVC4lujIGQ1PR/eo8GTEYn4Yi0O5X1mosy88cTxgKi/ZyI+5YczW4c+FATdkQZOP0EE4hSDN3zoWIw2AW9RfyzFmrLnzJ2FurxG9w9YFvEYMgQQ8LYK3AdQhwbjCnoR5bzmCKve+l/9MeAdT70N72fzExjEfLfCMHgG9inAPXItldmFVFPRr8OGm8L6LUdOQPDe3lYQqwcTPwLdqn4vrciRrC8x4DhOpsPXq/JGrLZz6hQPLRmCk1Hp3X+Z00r7Q/qqjejJp0agRzel91Qe0giBbf/ZUSPr7YzjqhMy0bgtQKC6O/X8sucQLV868HhLsR2H0zQHP1GmeaSLGyP+vy0+4OalDgJSCCKP74Jp/dwRU6m15euFlgSgBrp1/a1lMLAJ0RTtNj7Qhhv0RCw/xT6CnKhLf9WrRQlhpEn9fOQOlg
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b9df87f-43d1-4ac3-9d92-08d7f2c44b0d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 20:21:58.4768 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z1See1BZw9BOa66cfREITfC1E4IVShn+zeS2eUY5QnmKw10YbyYrFzXwyFbwYw2gv9iTgmBEJJsH6rsut/GjFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5082
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 07 May 2020 20:22:20 -0000

Add a take_ownership method, used by raw_read and select.cc:peek_fifo.
It wakes up all fifo_reader_threads and allows the caller to become
owner.  The work is done by the fifo_reader_threads.

For synchronization we introduce several new fhandler_fifo data
members and methods:

- update_needed_evt signals the current owner to stop listening for
  writer connections and update its fc_handler list.

- shared_fc_handler() gets and sets the status of the fc_handler
  update process.

- get_pending_owner() and set_pending_owner() get and set the reader
  that is requesting ownership.

Finally, a new 'reading_lock' prevents two readers from trying to take
ownership simultaneously.
---
 winsup/cygwin/fhandler.h       |  28 ++++++++-
 winsup/cygwin/fhandler_fifo.cc | 106 +++++++++++++++++++++++++++++----
 winsup/cygwin/select.cc        |   4 ++
 3 files changed, 122 insertions(+), 16 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index f8c1b52a4..31c65866e 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1323,12 +1323,13 @@ struct fifo_reader_id_t
 class fifo_shmem_t
 {
   LONG _nreaders;
-  fifo_reader_id_t _owner, _prev_owner;
-  af_unix_spinlock_t _owner_lock;
+  fifo_reader_id_t _owner, _prev_owner, _pending_owner;
+  af_unix_spinlock_t _owner_lock, _reading_lock;
 
   /* Info about shared memory block used for temporary storage of the
      owner's fc_handler list. */
-  LONG _sh_nhandlers, _sh_shandlers, _sh_fc_handler_committed;
+  LONG _sh_nhandlers, _sh_shandlers, _sh_fc_handler_committed,
+    _sh_fc_handler_updated;
 
 public:
   int inc_nreaders () { return (int) InterlockedIncrement (&_nreaders); }
@@ -1338,9 +1339,13 @@ public:
   void set_owner (fifo_reader_id_t fr_id) { _owner = fr_id; }
   fifo_reader_id_t get_prev_owner () const { return _prev_owner; }
   void set_prev_owner (fifo_reader_id_t fr_id) { _prev_owner = fr_id; }
+  fifo_reader_id_t get_pending_owner () const { return _pending_owner; }
+  void set_pending_owner (fifo_reader_id_t fr_id) { _pending_owner = fr_id; }
 
   void owner_lock () { _owner_lock.lock (); }
   void owner_unlock () { _owner_lock.unlock (); }
+  void reading_lock () { _reading_lock.lock (); }
+  void reading_unlock () { _reading_lock.unlock (); }
 
   int get_shared_nhandlers () const { return (int) _sh_nhandlers; }
   void set_shared_nhandlers (int n) { InterlockedExchange (&_sh_nhandlers, n); }
@@ -1350,6 +1355,9 @@ public:
   { return (size_t) _sh_fc_handler_committed; }
   void set_shared_fc_handler_committed (size_t n)
   { InterlockedExchange (&_sh_fc_handler_committed, (LONG) n); }
+  bool shared_fc_handler_updated () const { return _sh_fc_handler_updated; }
+  void shared_fc_handler_updated (bool val)
+  { InterlockedExchange (&_sh_fc_handler_updated, val); }
 };
 
 class fhandler_fifo: public fhandler_base
@@ -1362,6 +1370,7 @@ class fhandler_fifo: public fhandler_base
   /* Handles to named events needed by all readers of a given FIFO. */
   HANDLE owner_needed_evt;      /* The owner is closing. */
   HANDLE owner_found_evt;       /* A new owner has taken over. */
+  HANDLE update_needed_evt;     /* shared_fc_handler needs updating. */
 
   /* Handles to non-shared events needed for fifo_reader_threads. */
   HANDLE cancel_evt;            /* Signal thread to terminate. */
@@ -1409,6 +1418,11 @@ class fhandler_fifo: public fhandler_base
   fifo_reader_id_t get_prev_owner () const { return shmem->get_prev_owner (); }
   void set_prev_owner (fifo_reader_id_t fr_id)
   { shmem->set_prev_owner (fr_id); }
+  fifo_reader_id_t get_pending_owner () const
+  { return shmem->get_pending_owner (); }
+  void set_pending_owner (fifo_reader_id_t fr_id)
+  { shmem->set_pending_owner (fr_id); }
+
   void owner_needed ()
   {
     ResetEvent (owner_found_evt);
@@ -1430,6 +1444,10 @@ class fhandler_fifo: public fhandler_base
   { shmem->set_shared_fc_handler_committed (n); }
   int update_my_handlers (bool from_exec = false);
   int update_shared_handlers ();
+  bool shared_fc_handler_updated () const
+  { return shmem->shared_fc_handler_updated (); }
+  void shared_fc_handler_updated (bool val)
+  { shmem->shared_fc_handler_updated (val); }
 
 public:
   fhandler_fifo ();
@@ -1449,6 +1467,10 @@ public:
   void owner_lock () { shmem->owner_lock (); }
   void owner_unlock () { shmem->owner_unlock (); }
 
+  void take_ownership ();
+  void reading_lock () { shmem->reading_lock (); }
+  void reading_unlock () { shmem->reading_unlock (); }
+
   int open (int, mode_t);
   off_t lseek (off_t offset, int whence);
   int close ();
diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index bf33a52d6..81473015e 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -74,7 +74,7 @@ static NO_COPY fifo_reader_id_t null_fr_id = { .winpid = 0, .fh = NULL };
 fhandler_fifo::fhandler_fifo ():
   fhandler_base (),
   read_ready (NULL), write_ready (NULL), writer_opening (NULL),
-  owner_needed_evt (NULL), owner_found_evt (NULL),
+  owner_needed_evt (NULL), owner_found_evt (NULL), update_needed_evt (NULL),
   cancel_evt (NULL), thr_sync_evt (NULL), _maybe_eof (false),
   fc_handler (NULL), shandlers (0), nhandlers (0),
   reader (false), writer (false), duplexer (false),
@@ -436,6 +436,8 @@ fhandler_fifo::update_shared_handlers ()
     }
   set_shared_nhandlers (nhandlers);
   memcpy (shared_fc_handler, fc_handler, nhandlers * sizeof (fc_handler[0]));
+  shared_fc_handler_updated (true);
+  set_prev_owner (me);
   return 0;
 }
 
@@ -456,20 +458,44 @@ fhandler_fifo::fifo_reader_thread_func ()
 
   while (1)
     {
-      fifo_reader_id_t cur_owner;
+      fifo_reader_id_t cur_owner, pending_owner;
+      bool idle = false, take_ownership = false;
 
       owner_lock ();
       cur_owner = get_owner ();
-      if (!cur_owner)
+      pending_owner = get_pending_owner ();
+
+      if (pending_owner)
 	{
-	  set_owner (me);
-	  if (update_my_handlers () < 0)
-	    api_fatal ("Can't update my handlers, %E");
-	  owner_found ();
-	  owner_unlock ();
-	  continue;
+	  if (pending_owner != me)
+	    idle = true;
+	  else
+	    take_ownership = true;
 	}
+      else if (!cur_owner)
+	take_ownership = true;
       else if (cur_owner != me)
+	idle = true;
+      if (take_ownership)
+	{
+	  if (!shared_fc_handler_updated ())
+	    {
+	      owner_unlock ();
+	      yield ();
+	      continue;
+	    }
+	  else
+	    {
+	      set_owner (me);
+	      set_pending_owner (null_fr_id);
+	      if (update_my_handlers () < 0)
+		api_fatal ("Can't update my handlers, %E");
+	      owner_found ();
+	      owner_unlock ();
+	      continue;
+	    }
+	}
+      else if (idle)
 	{
 	  owner_unlock ();
 	  HANDLE w[2] = { owner_needed_evt, cancel_evt };
@@ -494,6 +520,7 @@ fhandler_fifo::fifo_reader_thread_func ()
 	  /* Listen for a writer to connect to the new client handler. */
 	  fifo_client_handler& fc = fc_handler[nhandlers - 1];
 	  fifo_client_unlock ();
+	  shared_fc_handler_updated (false);
 	  owner_unlock ();
 	  NTSTATUS status;
 	  IO_STATUS_BLOCK io;
@@ -504,8 +531,8 @@ fhandler_fifo::fifo_reader_thread_func ()
 				    FSCTL_PIPE_LISTEN, NULL, 0, NULL, 0);
 	  if (status == STATUS_PENDING)
 	    {
-	      HANDLE w[2] = { conn_evt, cancel_evt };
-	      switch (WaitForMultipleObjects (2, w, false, INFINITE))
+	      HANDLE w[3] = { conn_evt, update_needed_evt, cancel_evt };
+	      switch (WaitForMultipleObjects (3, w, false, INFINITE))
 		{
 		case WAIT_OBJECT_0:
 		  status = io.Status;
@@ -513,6 +540,10 @@ fhandler_fifo::fifo_reader_thread_func ()
 				status);
 		  break;
 		case WAIT_OBJECT_0 + 1:
+		  status = STATUS_WAIT_1;
+		  update = true;
+		  break;
+		case WAIT_OBJECT_0 + 2:
 		  status = STATUS_THREAD_IS_TERMINATING;
 		  cancel = true;
 		  update = true;
@@ -538,6 +569,7 @@ fhandler_fifo::fifo_reader_thread_func ()
 	      record_connection (fc, fc_closing);
 	      break;
 	    case STATUS_THREAD_IS_TERMINATING:
+	    case STATUS_WAIT_1:
 	      /* Try to connect a bogus client.  Otherwise fc is still
 		 listening, and the next connection might not get recorded. */
 	      status1 = open_pipe (ph);
@@ -807,6 +839,8 @@ fhandler_fifo::open (int flags, mode_t)
       if (create_shared_fc_handler () < 0)
 	goto err_close_shmem;
       inc_nreaders ();
+      /* Reinitialize _sh_fc_handler_updated, which starts as 0. */
+      shared_fc_handler_updated (true);
       npbuf[0] = 'n';
       if (!(owner_needed_evt = CreateEvent (sa_buf, true, false, npbuf)))
 	{
@@ -821,9 +855,16 @@ fhandler_fifo::open (int flags, mode_t)
 	  __seterrno ();
 	  goto err_close_owner_needed_evt;
 	}
+      npbuf[0] = 'u';
+      if (!(update_needed_evt = CreateEvent (sa_buf, false, false, npbuf)))
+	{
+	  debug_printf ("CreateEvent for %s failed, %E", npbuf);
+	  __seterrno ();
+	  goto err_close_owner_found_evt;
+	}
       /* Make cancel and sync inheritable for exec. */
       if (!(cancel_evt = create_event (true)))
-	goto err_close_owner_found_evt;
+	goto err_close_update_needed_evt;
       if (!(thr_sync_evt = create_event (true)))
 	goto err_close_cancel_evt;
       me.winpid = GetCurrentProcessId ();
@@ -943,6 +984,8 @@ err_close_reader:
   return 0;
 err_close_cancel_evt:
   NtClose (cancel_evt);
+err_close_update_needed_evt:
+  NtClose (update_needed_evt);
 err_close_owner_found_evt:
   NtClose (owner_found_evt);
 err_close_owner_needed_evt:
@@ -1136,6 +1179,24 @@ fhandler_fifo::hit_eof ()
   return ret;
 }
 
+/* Called from raw_read and select.cc:peek_fifo. */
+void
+fhandler_fifo::take_ownership ()
+{
+  owner_lock ();
+  if (get_owner () == me)
+    {
+      owner_unlock ();
+      return;
+    }
+  set_pending_owner (me);
+  owner_needed ();
+  SetEvent (update_needed_evt);
+  owner_unlock ();
+  /* The reader threads should now do the transfer.  */
+  WaitForSingleObject (owner_found_evt, INFINITE);
+}
+
 void __reg3
 fhandler_fifo::raw_read (void *in_ptr, size_t& len)
 {
@@ -1144,6 +1205,9 @@ fhandler_fifo::raw_read (void *in_ptr, size_t& len)
 
   while (1)
     {
+      /* No one else can take ownership while we hold the reading_lock. */
+      reading_lock ();
+      take_ownership ();
       /* Poll the connected clients for input. */
       int nconnected = 0;
       fifo_client_lock ();
@@ -1167,6 +1231,7 @@ fhandler_fifo::raw_read (void *in_ptr, size_t& len)
 		  {
 		    len = nbytes;
 		    fifo_client_unlock ();
+		    reading_unlock ();
 		    return;
 		  }
 		break;
@@ -1187,9 +1252,11 @@ fhandler_fifo::raw_read (void *in_ptr, size_t& len)
       fifo_client_unlock ();
       if (maybe_eof () && hit_eof ())
 	{
+	  reading_unlock ();
 	  len = 0;
 	  return;
 	}
+      reading_unlock ();
       if (is_nonblocking ())
 	{
 	  set_errno (EAGAIN);
@@ -1327,6 +1394,8 @@ fhandler_fifo::close ()
 	NtClose (owner_needed_evt);
       if (owner_found_evt)
 	NtClose (owner_found_evt);
+      if (update_needed_evt)
+	NtClose (update_needed_evt);
       if (cancel_evt)
 	NtClose (cancel_evt);
       if (thr_sync_evt)
@@ -1443,8 +1512,15 @@ fhandler_fifo::dup (fhandler_base *child, int flags)
 	  __seterrno ();
 	  goto err_close_owner_needed_evt;
 	}
+      if (!DuplicateHandle (GetCurrentProcess (), update_needed_evt,
+			    GetCurrentProcess (), &fhf->update_needed_evt,
+			    0, !(flags & O_CLOEXEC), DUPLICATE_SAME_ACCESS))
+	{
+	  __seterrno ();
+	  goto err_close_owner_found_evt;
+	}
       if (!(fhf->cancel_evt = create_event (true)))
-	goto err_close_owner_found_evt;
+	goto err_close_update_needed_evt;
       if (!(fhf->thr_sync_evt = create_event (true)))
 	goto err_close_cancel_evt;
       inc_nreaders ();
@@ -1454,6 +1530,8 @@ fhandler_fifo::dup (fhandler_base *child, int flags)
   return 0;
 err_close_cancel_evt:
   NtClose (fhf->cancel_evt);
+err_close_update_needed_evt:
+  NtClose (fhf->update_needed_evt);
 err_close_owner_found_evt:
   NtClose (fhf->owner_found_evt);
 err_close_owner_needed_evt:
@@ -1496,6 +1574,7 @@ fhandler_fifo::fixup_after_fork (HANDLE parent)
 	api_fatal ("Can't reopen shared fc_handler memory during fork, %E");
       fork_fixup (parent, owner_needed_evt, "owner_needed_evt");
       fork_fixup (parent, owner_found_evt, "owner_found_evt");
+      fork_fixup (parent, update_needed_evt, "update_needed_evt");
       if (close_on_exec ())
 	/* Prevent a later attempt to close the non-inherited
 	   pipe-instance handles copied from the parent. */
@@ -1578,6 +1657,7 @@ fhandler_fifo::set_close_on_exec (bool val)
     {
       set_no_inheritance (owner_needed_evt, val);
       set_no_inheritance (owner_found_evt, val);
+      set_no_inheritance (update_needed_evt, val);
       set_no_inheritance (cancel_evt, val);
       set_no_inheritance (thr_sync_evt, val);
       fifo_client_lock ();
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index 9323c423f..2c299acf7 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -866,6 +866,8 @@ peek_fifo (select_record *s, bool from_select)
 	  goto out;
 	}
 
+      fh->reading_lock ();
+      fh->take_ownership ();
       fh->fifo_client_lock ();
       int nconnected = 0;
       for (int i = 0; i < fh->get_nhandlers (); i++)
@@ -888,6 +890,7 @@ peek_fifo (select_record *s, bool from_select)
 		fh->get_fc_handler (i).get_state () = fc_input_avail;
 		select_printf ("read: %s, ready for read", fh->get_name ());
 		fh->fifo_client_unlock ();
+		fh->reading_unlock ();
 		gotone += s->read_ready = true;
 		goto out;
 	      default:
@@ -905,6 +908,7 @@ peek_fifo (select_record *s, bool from_select)
 	  if (s->except_selected)
 	    gotone += s->except_ready = true;
 	}
+      fh->reading_unlock ();
     }
 out:
   if (s->write_selected)
-- 
2.21.0

