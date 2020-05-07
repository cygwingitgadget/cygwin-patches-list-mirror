Return-Path: <kbrown@cornell.edu>
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2122.outbound.protection.outlook.com [40.107.243.122])
 by sourceware.org (Postfix) with ESMTPS id 93825396E816
 for <cygwin-patches@cygwin.com>; Thu,  7 May 2020 20:22:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 93825396E816
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aIaP0q1YSjW2H/+n3pnPslgTS//QXDIHj8sARXC2YNBtMYKEaoDm8YJpA1ZQF8O7tOB8Ftbam1M008f4mZcL4FlRwAfwQHYlPi3lRDJyVozq2yGTdPVCY8CjbcIY57UvQbfQkBvFevF1UDZ2xPSCkTqs0tRmQiRIGmdZH4bx40+mfARTfIbFtzo+K0MJnDtpf76cVnSB/I5g/Z2+Be5K8R2HWMUmf1U3NQExnoQ9MdT1rUPM3c2XjWFmCF6oVcoEi/iIEfXYxSX5P3Lj7a8bcl3yVsBTxigqyvhv+r8mWxmLowxzagiKZijZppT/3glGrwTpVvFrRJmvgtQBBHNSkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYxZKOtwoOOn0lTf3zUVaKsMrXonc4ewnxdVyAlY3mY=;
 b=jz6k0CpS11ve6vT62NPIfhthfNfhc+4s6/QPeRIFMZTl70a8leilruV+jKg3Rd16jD2TLlZLB5jal6iMFrz4juvz+sAzp/bAzygVPSWNCvU3R8y6SSPpNuz3Qi+Eeiz8LhWuHG89O8THfdoT9L1kbsmPYYFvSPmXCGiEJlmkxWipXXxfjKEtydM1IDaDyav1kYAQWvVqkLomzilizMf3P5pghF828mzGs3mXZmomifcGEsf8V193NMzOupOvDZ+ZmUw6EqwBI5m35hH1kMLAogtkBlZFkKAy+7LkKI8N2XmlCtEOOLXrmrhxcm5bNy5NgOg7zzbY8qBMpsn+Q3GDYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from DM6PR04MB6075.namprd04.prod.outlook.com (2603:10b6:5:127::31)
 by DM6PR04MB5082.namprd04.prod.outlook.com (2603:10b6:5:1a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Thu, 7 May
 2020 20:21:59 +0000
Received: from DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4]) by DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4%4]) with mapi id 15.20.2979.025; Thu, 7 May 2020
 20:21:59 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Cc: sten.kristian.ivarsson@gmail.com
Subject: [PATCH 20/21] Cygwin: FIFO: support opening multiple readers
Date: Thu,  7 May 2020 16:21:23 -0400
Message-Id: <20200507202124.1463-21-kbrown@cornell.edu>
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
 15.20.2979.28 via Frontend Transport; Thu, 7 May 2020 20:21:58 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [2604:6000:b407:7f00:e532:58da:20b8:9136]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e87a151-5d4d-460c-e2c5-08d7f2c44b8b
X-MS-TrafficTypeDiagnostic: DM6PR04MB5082:
X-Microsoft-Antispam-PRVS: <DM6PR04MB5082B84F4CC46A84D67204B6D8A50@DM6PR04MB5082.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bu9+G9OjFwHYcKyVpXl3T3bJGInuXHZMbbw5a2kSxoEu7mWApxNkZDeyxIM6IEg22NVXwH5c/IumNO05RnTecoeBJ0jNNE7IF0X/XNqy+M7eWF5J8WtAExQa8ciNHT/QcUK3/qCXuK/Kdkcqe0A1yT3ZZ1EakHn0JDTaKZrILhStOr/1MVp8/EAvFAANpFkxlFeD/G4y+Az2S3HX4BruK39Gd3sbR4EQ/lzaIvzauirMdJ6dQ7xSsTpoW10CfUlIWRHPnKEi1IaZj9zX4M9oIjIyFIbG5x/Ke+PwNpoO//WfUGwgEE11vzuUYujBYdqk5LEj+chkl01cTpNv9fUzBfiSMpUdmUqeUnDJvzOPuY3QwPbHPg4ka0cpNgTkOybYbj32j3MB1BNVbmChnfxq/scR6yi6CgEmmrZl+4aVTYjRt7N0LRFxDAM5spwN4RYHd2PS3lUbwGiCbJIlU1L6H3jV0Foc7bDRk3KoCNlvhvtEr7Aid0vTA2TEKw6mJ8jxyltxrLxW01SxDeCKPVrKlyyhxrsrrHXOuY6Ny/kuhmHps/RNJFMopjsG0KE/z6fq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6075.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(33430700001)(66556008)(86362001)(786003)(6666004)(186003)(6512007)(75432002)(52116002)(66476007)(69590400007)(316002)(6506007)(2616005)(4326008)(478600001)(5660300002)(30864003)(1076003)(36756003)(2906002)(33440700001)(16526019)(6486002)(66946007)(8676002)(6916009)(8936002)(83320400001)(83280400001)(83310400001)(83290400001)(83300400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 0hlTLZ7EEZ9RBb6vlp5uibk3v6+nYt9gziG5hdE60GmkUbDUp4+7a6zPv11LueHnBy3g3E+VmCN9oMcxFIrSGK/bmxOtbTB9FLbu+1e9g9J4ZvGPmT61ptWxL6BH5bRgTMuuXXAeuQgLUV3SWvXsyp1a2OPftfrRWU+3/xFdI9modW5iHQ5BOAHBwIC13ESr1pubbNUf8ClBVyAmikGocwYP+CdZ9kKx1J3+IooV/jqirQUbSisJaVtbWCmP1lNaJC2oQ3YUfm6/C2c8hxvwVEUvMkf9QHRI3gTxcHCk19+5tse+3tFw6yCVLFNLVr+BY81Kvm3mLIrJANdpkcd6n1JK3VUplPidvwjFFNhQxv1y6SjfByVa6oY1SUeqqP0/gmJ5ZPQWJeCdniAsCpwMePLF1O7Imh8yQHCVSGxoX0MYmlQx73lTTRLoGjX5ZzEKYmfomYLYzzi2dJJTSY3ATaZyjqTXJkCyGx1rayB7P0+PxVdpYAbvGDK7xnZXYpRutQhliIsfIoucFCiw3Q5qJfyjk4S3mrZvGVfBSkG3m45xmsiQVkQ1tP00GA67hRcgsH09jDCkANN0CgndBCZWPG9yFeaJtwTIVlKoH/m2H1lHQqbZhhs61HO8x3JCliLEjmc2lTEbgMdM5ihrn3PDtB9CuZHTFIygFZZ+bNk8roS5e/QRCcxWlvYATl8LAw/wRPSU70QDk+3t8pg6mpWYTEx1ZPdR0+RiXBG2AaRSFykPrZxiil232mQZdJx7so8rw0/c6dk4FI1fYeIotpLQSWI0DrZ7oD2ZEGBQDNw4IyE3+EhNDbAN7XN/EWhuU9xduiVTipjOFDT36dRrFciixbdaEy9VMvq4d8YRc6v7OkuV7eyKzodeiv/QPrhfwfeo
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e87a151-5d4d-460c-e2c5-08d7f2c44b8b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 20:21:59.3373 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xjF7om+zB+P7rs8qlVD0+hMGMwe5z3bPmDn6x9eqdm6ohIEyvcJuls5LAmonIlMOUexgJZCFowX9GJ3YbiSrZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5082
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 07 May 2020 20:22:22 -0000

Although we can have multiple readers open because of dup/fork/exec,
the current code does not support multiple readers opening a FIFO by
explicitly calling 'open'.

The main complication in supporting this is that when a blocking
reader tries to open and there's already one open, it has to check
whether there any writers open.  It can't rely on the write_ready
event, whose state hasn't changed since the first writer opened.

To fix this, add two new named events, check_write_ready_evt and
write_ready_ok_evt, and a new method, check_write_ready().

The first event signals the owner's reader thread to call
check_write_ready(), which polls the fc_handler list to check for
connected writers.  If it finds none, it checks to see if there's a
writer in the process and then sets/resets write_ready appropriately.

When check_write_ready() finishes it sets write_ready_ok_evt to signal
the reader that write_ready has been updated.

The polling is done via fifo_client_handler::pipe_state().  As long as
it's calling that function anyway, check_write_ready() updates the
state of each handler.

Also add a new lock to prevent a race if two readers are trying to
open simultaneously.
---
 winsup/cygwin/fhandler.h       |   9 ++-
 winsup/cygwin/fhandler_fifo.cc | 129 ++++++++++++++++++++++++++++++---
 2 files changed, 127 insertions(+), 11 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 31c65866e..8a23d6753 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1324,7 +1324,7 @@ class fifo_shmem_t
 {
   LONG _nreaders;
   fifo_reader_id_t _owner, _prev_owner, _pending_owner;
-  af_unix_spinlock_t _owner_lock, _reading_lock;
+  af_unix_spinlock_t _owner_lock, _reading_lock, _reader_opening_lock;
 
   /* Info about shared memory block used for temporary storage of the
      owner's fc_handler list. */
@@ -1346,6 +1346,8 @@ public:
   void owner_unlock () { _owner_lock.unlock (); }
   void reading_lock () { _reading_lock.lock (); }
   void reading_unlock () { _reading_lock.unlock (); }
+  void reader_opening_lock () { _reader_opening_lock.lock (); }
+  void reader_opening_unlock () { _reader_opening_lock.unlock (); }
 
   int get_shared_nhandlers () const { return (int) _sh_nhandlers; }
   void set_shared_nhandlers (int n) { InterlockedExchange (&_sh_nhandlers, n); }
@@ -1371,6 +1373,8 @@ class fhandler_fifo: public fhandler_base
   HANDLE owner_needed_evt;      /* The owner is closing. */
   HANDLE owner_found_evt;       /* A new owner has taken over. */
   HANDLE update_needed_evt;     /* shared_fc_handler needs updating. */
+  HANDLE check_write_ready_evt; /* write_ready needs to be checked. */
+  HANDLE write_ready_ok_evt;    /* check_write_ready is done. */
 
   /* Handles to non-shared events needed for fifo_reader_threads. */
   HANDLE cancel_evt;            /* Signal thread to terminate. */
@@ -1448,6 +1452,9 @@ class fhandler_fifo: public fhandler_base
   { return shmem->shared_fc_handler_updated (); }
   void shared_fc_handler_updated (bool val)
   { shmem->shared_fc_handler_updated (val); }
+  void check_write_ready ();
+  void reader_opening_lock () { shmem->reader_opening_lock (); }
+  void reader_opening_unlock () { shmem->reader_opening_unlock (); }
 
 public:
   fhandler_fifo ();
diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index 81473015e..cc51c449a 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -75,6 +75,7 @@ fhandler_fifo::fhandler_fifo ():
   fhandler_base (),
   read_ready (NULL), write_ready (NULL), writer_opening (NULL),
   owner_needed_evt (NULL), owner_found_evt (NULL), update_needed_evt (NULL),
+  check_write_ready_evt (NULL), write_ready_ok_evt (NULL),
   cancel_evt (NULL), thr_sync_evt (NULL), _maybe_eof (false),
   fc_handler (NULL), shandlers (0), nhandlers (0),
   reader (false), writer (false), duplexer (false),
@@ -441,6 +442,45 @@ fhandler_fifo::update_shared_handlers ()
   return 0;
 }
 
+/* The write_ready event gets set when a writer opens, to indicate
+   that a blocking reader can open.  If a second reader wants to open,
+   we need to see if there are still any writers open. */
+void
+fhandler_fifo::check_write_ready ()
+{
+  bool set = false;
+
+  fifo_client_lock ();
+  for (int i = 0; i < nhandlers && !set; i++)
+    switch (fc_handler[i].pipe_state ())
+      {
+      case FILE_PIPE_CONNECTED_STATE:
+	fc_handler[i].state = fc_connected;
+	set = true;
+	break;
+      case FILE_PIPE_INPUT_AVAILABLE_STATE:
+	fc_handler[i].state = fc_input_avail;
+	set = true;
+	break;
+      case FILE_PIPE_DISCONNECTED_STATE:
+	fc_handler[i].state = fc_disconnected;
+	break;
+      case FILE_PIPE_LISTENING_STATE:
+	fc_handler[i].state = fc_listening;
+      case FILE_PIPE_CLOSING_STATE:
+	fc_handler[i].state = fc_closing;
+      default:
+	fc_handler[i].state = fc_error;
+	break;
+      }
+  fifo_client_unlock ();
+  if (set || IsEventSignalled (writer_opening))
+    SetEvent (write_ready);
+  else
+    ResetEvent (write_ready);
+  SetEvent (write_ready_ok_evt);
+}
+
 static DWORD WINAPI
 fifo_reader_thread (LPVOID param)
 {
@@ -526,13 +566,15 @@ fhandler_fifo::fifo_reader_thread_func ()
 	  IO_STATUS_BLOCK io;
 	  bool cancel = false;
 	  bool update = false;
+	  bool check = false;
 
 	  status = NtFsControlFile (fc.h, conn_evt, NULL, NULL, &io,
 				    FSCTL_PIPE_LISTEN, NULL, 0, NULL, 0);
 	  if (status == STATUS_PENDING)
 	    {
-	      HANDLE w[3] = { conn_evt, update_needed_evt, cancel_evt };
-	      switch (WaitForMultipleObjects (3, w, false, INFINITE))
+	      HANDLE w[4] = { conn_evt, update_needed_evt,
+		check_write_ready_evt, cancel_evt };
+	      switch (WaitForMultipleObjects (4, w, false, INFINITE))
 		{
 		case WAIT_OBJECT_0:
 		  status = io.Status;
@@ -544,6 +586,10 @@ fhandler_fifo::fifo_reader_thread_func ()
 		  update = true;
 		  break;
 		case WAIT_OBJECT_0 + 2:
+		  status = STATUS_WAIT_2;
+		  check = true;
+		  break;
+		case WAIT_OBJECT_0 + 3:
 		  status = STATUS_THREAD_IS_TERMINATING;
 		  cancel = true;
 		  update = true;
@@ -570,6 +616,7 @@ fhandler_fifo::fifo_reader_thread_func ()
 	      break;
 	    case STATUS_THREAD_IS_TERMINATING:
 	    case STATUS_WAIT_1:
+	    case STATUS_WAIT_2:
 	      /* Try to connect a bogus client.  Otherwise fc is still
 		 listening, and the next connection might not get recorded. */
 	      status1 = open_pipe (ph);
@@ -602,6 +649,8 @@ fhandler_fifo::fifo_reader_thread_func ()
 	    NtClose (ph);
 	  if (update && update_shared_handlers () < 0)
 	    api_fatal ("Can't update shared handlers, %E");
+	  if (check)
+	    check_write_ready ();
 	  if (cancel)
 	    goto canceled;
 	}
@@ -833,14 +882,19 @@ fhandler_fifo::open (int flags, mode_t)
      and start the fifo_reader_thread. */
   if (reader)
     {
+      bool first = true;
+
       SetEvent (read_ready);
       if (create_shmem () < 0)
 	goto err_close_writer_opening;
       if (create_shared_fc_handler () < 0)
 	goto err_close_shmem;
-      inc_nreaders ();
-      /* Reinitialize _sh_fc_handler_updated, which starts as 0. */
-      shared_fc_handler_updated (true);
+      reader_opening_lock ();
+      if (inc_nreaders () == 1)
+	/* Reinitialize _sh_fc_handler_updated, which starts as 0. */
+	shared_fc_handler_updated (true);
+      else
+	first = false;
       npbuf[0] = 'n';
       if (!(owner_needed_evt = CreateEvent (sa_buf, true, false, npbuf)))
 	{
@@ -862,9 +916,23 @@ fhandler_fifo::open (int flags, mode_t)
 	  __seterrno ();
 	  goto err_close_owner_found_evt;
 	}
+      npbuf[0] = 'c';
+      if (!(check_write_ready_evt = CreateEvent (sa_buf, false, false, npbuf)))
+	{
+	  debug_printf ("CreateEvent for %s failed, %E", npbuf);
+	  __seterrno ();
+	  goto err_close_update_needed_evt;
+	}
+      npbuf[0] = 'k';
+      if (!(write_ready_ok_evt = CreateEvent (sa_buf, false, false, npbuf)))
+	{
+	  debug_printf ("CreateEvent for %s failed, %E", npbuf);
+	  __seterrno ();
+	  goto err_close_check_write_ready_evt;
+	}
       /* Make cancel and sync inheritable for exec. */
       if (!(cancel_evt = create_event (true)))
-	goto err_close_update_needed_evt;
+	goto err_close_write_ready_ok_evt;
       if (!(thr_sync_evt = create_event (true)))
 	goto err_close_cancel_evt;
       me.winpid = GetCurrentProcessId ();
@@ -908,9 +976,19 @@ fhandler_fifo::open (int flags, mode_t)
 		}
 	    }
 	}
-      /* Not a duplexer; wait for a writer to connect. */
-      else if (!wait (write_ready))
-	goto err_close_reader;
+      /* Not a duplexer; wait for a writer to connect if we're blocking. */
+      else if (!(flags & O_NONBLOCK))
+	{
+	  if (!first)
+	    {
+	      /* Ask the owner to update write_ready. */
+	      SetEvent (check_write_ready_evt);
+	      WaitForSingleObject (write_ready_ok_evt, INFINITE);
+	    }
+	  if (!wait (write_ready))
+	    goto err_close_reader;
+	}
+      reader_opening_unlock ();
       goto success;
     }
 
@@ -984,6 +1062,10 @@ err_close_reader:
   return 0;
 err_close_cancel_evt:
   NtClose (cancel_evt);
+err_close_write_ready_ok_evt:
+  NtClose (write_ready_ok_evt);
+err_close_check_write_ready_evt:
+  NtClose (check_write_ready_evt);
 err_close_update_needed_evt:
   NtClose (update_needed_evt);
 err_close_owner_found_evt:
@@ -993,6 +1075,7 @@ err_close_owner_needed_evt:
 err_dec_nreaders:
   if (dec_nreaders () == 0)
     ResetEvent (read_ready);
+  reader_opening_unlock ();
 /* err_close_shared_fc_handler: */
   NtUnmapViewOfSection (NtCurrentProcess (), shared_fc_handler);
   NtClose (shared_fc_hdl);
@@ -1396,6 +1479,10 @@ fhandler_fifo::close ()
 	NtClose (owner_found_evt);
       if (update_needed_evt)
 	NtClose (update_needed_evt);
+      if (check_write_ready_evt)
+	NtClose (check_write_ready_evt);
+      if (write_ready_ok_evt)
+	NtClose (write_ready_ok_evt);
       if (cancel_evt)
 	NtClose (cancel_evt);
       if (thr_sync_evt)
@@ -1519,8 +1606,22 @@ fhandler_fifo::dup (fhandler_base *child, int flags)
 	  __seterrno ();
 	  goto err_close_owner_found_evt;
 	}
+      if (!DuplicateHandle (GetCurrentProcess (), check_write_ready_evt,
+			    GetCurrentProcess (), &fhf->check_write_ready_evt,
+			    0, !(flags & O_CLOEXEC), DUPLICATE_SAME_ACCESS))
+	{
+	  __seterrno ();
+	  goto err_close_update_needed_evt;
+	}
+      if (!DuplicateHandle (GetCurrentProcess (), write_ready_ok_evt,
+			    GetCurrentProcess (), &fhf->write_ready_ok_evt,
+			    0, !(flags & O_CLOEXEC), DUPLICATE_SAME_ACCESS))
+	{
+	  __seterrno ();
+	  goto err_close_check_write_ready_evt;
+	}
       if (!(fhf->cancel_evt = create_event (true)))
-	goto err_close_update_needed_evt;
+	goto err_close_write_ready_ok_evt;
       if (!(fhf->thr_sync_evt = create_event (true)))
 	goto err_close_cancel_evt;
       inc_nreaders ();
@@ -1530,6 +1631,10 @@ fhandler_fifo::dup (fhandler_base *child, int flags)
   return 0;
 err_close_cancel_evt:
   NtClose (fhf->cancel_evt);
+err_close_write_ready_ok_evt:
+  NtClose (fhf->write_ready_ok_evt);
+err_close_check_write_ready_evt:
+  NtClose (fhf->check_write_ready_evt);
 err_close_update_needed_evt:
   NtClose (fhf->update_needed_evt);
 err_close_owner_found_evt:
@@ -1575,6 +1680,8 @@ fhandler_fifo::fixup_after_fork (HANDLE parent)
       fork_fixup (parent, owner_needed_evt, "owner_needed_evt");
       fork_fixup (parent, owner_found_evt, "owner_found_evt");
       fork_fixup (parent, update_needed_evt, "update_needed_evt");
+      fork_fixup (parent, check_write_ready_evt, "check_write_ready_evt");
+      fork_fixup (parent, write_ready_ok_evt, "write_ready_ok_evt");
       if (close_on_exec ())
 	/* Prevent a later attempt to close the non-inherited
 	   pipe-instance handles copied from the parent. */
@@ -1658,6 +1765,8 @@ fhandler_fifo::set_close_on_exec (bool val)
       set_no_inheritance (owner_needed_evt, val);
       set_no_inheritance (owner_found_evt, val);
       set_no_inheritance (update_needed_evt, val);
+      set_no_inheritance (check_write_ready_evt, val);
+      set_no_inheritance (write_ready_ok_evt, val);
       set_no_inheritance (cancel_evt, val);
       set_no_inheritance (thr_sync_evt, val);
       fifo_client_lock ();
-- 
2.21.0

