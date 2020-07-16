Return-Path: <kbrown@cornell.edu>
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2126.outbound.protection.outlook.com [40.107.236.126])
 by sourceware.org (Postfix) with ESMTPS id 405EF3890439
 for <cygwin-patches@cygwin.com>; Thu, 16 Jul 2020 16:19:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 405EF3890439
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isOFz9lpq5T5aEXOsZqFZxaNEaP1mD8WLW/xiEZazZL9USXsWj338hxJn8j0srT4McZah+WoISOYvo5AwGkClY0eeYgh34fJLWBhLHKOrN+R0UOpbUzwLSZItxC3GlunWDaMnvU8ll8uWd/fX5+x+W09KtNrq1js4Un53/sWKG74XAqnD5zAzGD/eDL8f4mX9+pO7pJvraOBrEQTW1FbsE+ogJxxLAqDNPY+qglHJrm8UtFSNN+zoiMr05sFnvetJf0sC/CKtS4xNEp3GbcexPrigov8zkFwY65jUXwL2Eqkc4/KbJcSfupupKFgW60+/lpRNdMV2IgBJ1RjnwPZbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yq5N0JVgRlV4WIBSnzKB6i//OfesbuNeKH6pmnhtRo=;
 b=gXzFNHo7euxr4qn0z0qX2chGJxQyKpWhylbMd7j/Hc0EE9BZJ6ZMgcLInHJwQEj9tGSM7D6q2oj0k+XlPTI/RScDCoi+l1SUJlV6rUoVScQoTGy1NuAvvOuVIiMdsuwg7Z4J9HZvnWIXUfJm6Sgypi6eh17bIDnwQCnY3aJ/TP7yJCeYjsX5d9w6tZ9voovjCteJvNmiA/WcG6Kj6yYfPzDIcX79qwVd0JyOvKHs7zWKDk/qeAOP+3g55XB0aN9mHz5HeT6zDmQjwyjY4SXVPP0s+EgF0AfsOiLhmZxaDm9Jp4CCiag9bwG45NyloPr0twZ9cR5nWV6WiiLUe03x/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB6112.namprd04.prod.outlook.com (2603:10b6:208:e0::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 16 Jul
 2020 16:19:34 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a%7]) with mapi id 15.20.3174.025; Thu, 16 Jul 2020
 16:19:34 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 02/12] Cygwin: FIFO: keep a writer count in shared memory
Date: Thu, 16 Jul 2020 12:19:05 -0400
Message-Id: <20200716161915.16994-3-kbrown@cornell.edu>
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
 Transport; Thu, 16 Jul 2020 16:19:33 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [68.175.129.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fad4c24d-d5e2-4d34-03c7-08d829a406e1
X-MS-TrafficTypeDiagnostic: MN2PR04MB6112:
X-Microsoft-Antispam-PRVS: <MN2PR04MB61129A0D80372B3C868621FCD87F0@MN2PR04MB6112.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +9KQ1V78f1jbQIt3uynLIad2LubfTSxEZKd36UyHK5bLVO3+9ErlzVYg5kh3FjE2JVmucMOW1ujg30Xxi+Sxa6lkriRftZn2mqFhPw5wPEylJlSOeywi90zsEBNoiNtMv1GNdwlj9FtLvyXENStb4ngPdxKUIztOhLtU6L1Rob8UgClt3eieHFjD6mE7D5c0lZMpiDVXOYaf7g6A7H2kQykk8Z1Uup+ew0KBJQ1pdYuLXaW9T1oOrXi56xE5W0ERuHtqxTbbRZpui3N0zCTaURZ6DOVOP3BQ+WTvkjAwTASFfOJPSvuHlSAjcu5x9p0Fop2DRlHYtrYbB2+ZAsTTu1CzKoF6hvkeeEgzrwikLx4qNxIDS5Zj0E43+fZJYV3G
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(66946007)(2616005)(66556008)(5660300002)(69590400007)(6506007)(8676002)(83380400001)(16526019)(956004)(6486002)(6512007)(52116002)(186003)(26005)(8936002)(66476007)(478600001)(2906002)(86362001)(316002)(786003)(75432002)(1076003)(6666004)(6916009)(36756003)(30864003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: xgJ8Eh/75aMt7jcosgCwZVFoV7C8QMI7wimlQvOAi5w+OPh51ep6/sNUtW68e52k88QOOuOlbIic9YfQI7Z1cFlXMhCKbGCkIZAl+vIEwmb/IDnaAnpJxRKPgeuQRk1dREbJajoBQFfAuJUI/M4oBTEH9BQQJFtf5gsM6/SzTUq7HsPOt8qIhUFLmHzBBiLnMlFDDH3ac4lISEdxx7M91QSf2v+zpyrEuDdJzeQ8lJZzImJmEZyr46RpXfO5BV0YOCSMVBebEhynZeI5o091aKcJ80OgYeeNdx1mCz4+Op/VJT/7HORIVS0ToT8w1g+xeBAbHdw8eO3mFZumgF5hjZRVAVQb3q28TPJE26DsPH1D4Buy34QoLGGgo7PfolPGzZd83bFAlkUxqy2vNIGybyZ9oQgt3Tkhg1C1x2mcnhN5vE4wvSkYCxXWT96WHXXVpYeZHJGEMSEGdEMX+IHmrAR6loEXaoHEusbmyU13nqI=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: fad4c24d-d5e2-4d34-03c7-08d829a406e1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 16:19:34.1469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLTYw0Fnz6/6/jUrW+Fv5wtR0INeNFsrvXsiJVOsGIr6RIgvdKmXIjdhzK/u0B1FvsRwhn48Ra5oP+6ppA9VZg==
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
X-List-Received-Date: Thu, 16 Jul 2020 16:19:43 -0000

When a reader opens, it needs to block if there are no writers open
(unless is is opened with O_NONBLOCK).  This is easy for the first
reader to test, since it can just wait for a writer to signal that it
is open (via the write_ready event).  But when a second reader wants
to open, all writers might have closed.

To check this, use a new '_nwriters' member of struct fifo_shmem_t,
which keeps track of the number of open writers.  This should be more
reliable than the previous method.

Add nwriters_lock to control access to shmem->_nwriters, and remove
reader_opening_lock, which is no longer needed.

Previously only readers had access to the shared memory, but now
writers access it too so that they can increment _nwriters during
open/dup/fork/exec and decrement it during close.

Add an optional 'only_open' argument to create_shmem for use by
writers, which only open the shared memory rather than first trying to
create it.  Since writers don't need to access the shared memory until
they have successfully connected to a pipe instance, they can safely
assume that a reader has already created the shared memory.

For debugging purposes, change create_shmem to return 1 instead of 0
when a reader successfully opens the shared memory after finding that
it had already been created.

Remove check_write_ready_evt, write_ready_ok_evt, and
check_write_ready(), which are no longer needed.

When opening a writer and looping to try to get a connection, recheck
read_ready at the top of the loop since the number of readers might
have changed.

To slightly speed up the process of opening the first reader, take
ownership immediately rather than waiting for the fifo_reader_thread
to handle it.
---
 winsup/cygwin/fhandler.h       |  27 ++--
 winsup/cygwin/fhandler_fifo.cc | 263 ++++++++++++++-------------------
 2 files changed, 124 insertions(+), 166 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index cf6daea06..f034a110e 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1323,12 +1323,14 @@ struct fifo_reader_id_t
   }
 };
 
-/* Info needed by all readers of a FIFO, stored in named shared memory. */
+/* Info needed by all fhandlers for a given FIFO, stored in named
+   shared memory.  This is mostly for readers, but writers need access
+   in order to update the count of open writers. */
 class fifo_shmem_t
 {
-  LONG _nreaders;
+  LONG _nreaders, _nwriters;
   fifo_reader_id_t _owner, _prev_owner, _pending_owner;
-  af_unix_spinlock_t _owner_lock, _reading_lock, _reader_opening_lock, _nreaders_lock;
+  af_unix_spinlock_t _owner_lock, _reading_lock, _nreaders_lock, _nwriters_lock;
 
   /* Info about shared memory block used for temporary storage of the
      owner's fc_handler list. */
@@ -1339,6 +1341,9 @@ public:
   int nreaders () const { return (int) _nreaders; }
   int inc_nreaders () { return (int) InterlockedIncrement (&_nreaders); }
   int dec_nreaders () { return (int) InterlockedDecrement (&_nreaders); }
+  int nwriters () const { return (int) _nwriters; }
+  int inc_nwriters () { return (int) InterlockedIncrement (&_nwriters); }
+  int dec_nwriters () { return (int) InterlockedDecrement (&_nwriters); }
 
   fifo_reader_id_t get_owner () const { return _owner; }
   void set_owner (fifo_reader_id_t fr_id) { _owner = fr_id; }
@@ -1351,10 +1356,10 @@ public:
   void owner_unlock () { _owner_lock.unlock (); }
   void reading_lock () { _reading_lock.lock (); }
   void reading_unlock () { _reading_lock.unlock (); }
-  void reader_opening_lock () { _reader_opening_lock.lock (); }
-  void reader_opening_unlock () { _reader_opening_lock.unlock (); }
   void nreaders_lock () { _nreaders_lock.lock (); }
   void nreaders_unlock () { _nreaders_lock.unlock (); }
+  void nwriters_lock () { _nwriters_lock.lock (); }
+  void nwriters_unlock () { _nwriters_lock.unlock (); }
 
   int get_shared_nhandlers () const { return (int) _sh_nhandlers; }
   void set_shared_nhandlers (int n) { InterlockedExchange (&_sh_nhandlers, n); }
@@ -1380,8 +1385,6 @@ class fhandler_fifo: public fhandler_base
   HANDLE owner_needed_evt;      /* The owner is closing. */
   HANDLE owner_found_evt;       /* A new owner has taken over. */
   HANDLE update_needed_evt;     /* shared_fc_handler needs updating. */
-  HANDLE check_write_ready_evt; /* write_ready needs to be checked. */
-  HANDLE write_ready_ok_evt;    /* check_write_ready is done. */
 
   /* Handles to non-shared events needed for fifo_reader_threads. */
   HANDLE cancel_evt;            /* Signal thread to terminate. */
@@ -1417,7 +1420,7 @@ class fhandler_fifo: public fhandler_base
   void record_connection (fifo_client_handler&,
 			  fifo_client_connect_state = fc_connected);
 
-  int create_shmem ();
+  int create_shmem (bool only_open = false);
   int reopen_shmem ();
   int create_shared_fc_handler ();
   int reopen_shared_fc_handler ();
@@ -1426,8 +1429,13 @@ class fhandler_fifo: public fhandler_base
   int nreaders () const { return shmem->nreaders (); }
   int inc_nreaders () { return shmem->inc_nreaders (); }
   int dec_nreaders () { return shmem->dec_nreaders (); }
+  int nwriters () const { return shmem->nwriters (); }
+  int inc_nwriters () { return shmem->inc_nwriters (); }
+  int dec_nwriters () { return shmem->dec_nwriters (); }
   void nreaders_lock () { shmem->nreaders_lock (); }
   void nreaders_unlock () { shmem->nreaders_unlock (); }
+  void nwriters_lock () { shmem->nwriters_lock (); }
+  void nwriters_unlock () { shmem->nwriters_unlock (); }
 
   fifo_reader_id_t get_prev_owner () const { return shmem->get_prev_owner (); }
   void set_prev_owner (fifo_reader_id_t fr_id)
@@ -1462,9 +1470,6 @@ class fhandler_fifo: public fhandler_base
   { return shmem->shared_fc_handler_updated (); }
   void shared_fc_handler_updated (bool val)
   { shmem->shared_fc_handler_updated (val); }
-  void check_write_ready ();
-  void reader_opening_lock () { shmem->reader_opening_lock (); }
-  void reader_opening_unlock () { shmem->reader_opening_unlock (); }
 
 public:
   fhandler_fifo ();
diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index 2d4f7a97e..26b24d019 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -87,7 +87,6 @@ fhandler_fifo::fhandler_fifo ():
   fhandler_base (),
   read_ready (NULL), write_ready (NULL), writer_opening (NULL),
   owner_needed_evt (NULL), owner_found_evt (NULL), update_needed_evt (NULL),
-  check_write_ready_evt (NULL), write_ready_ok_evt (NULL),
   cancel_evt (NULL), thr_sync_evt (NULL), _maybe_eof (false),
   fc_handler (NULL), shandlers (0), nhandlers (0),
   reader (false), writer (false), duplexer (false),
@@ -429,24 +428,6 @@ fhandler_fifo::update_shared_handlers ()
   return 0;
 }
 
-/* The write_ready event gets set when a writer opens, to indicate
-   that a blocking reader can open.  If a second reader wants to open,
-   we need to see if there are still any writers open. */
-void
-fhandler_fifo::check_write_ready ()
-{
-  bool set = false;
-
-  for (int i = 0; i < nhandlers && !set; i++)
-    if (fc_handler[i].set_state () >= fc_connected)
-      set = true;
-  if (set || IsEventSignalled (writer_opening))
-    SetEvent (write_ready);
-  else
-    ResetEvent (write_ready);
-  SetEvent (write_ready_ok_evt);
-}
-
 static DWORD WINAPI
 fifo_reader_thread (LPVOID param)
 {
@@ -532,15 +513,13 @@ fhandler_fifo::fifo_reader_thread_func ()
 	  IO_STATUS_BLOCK io;
 	  bool cancel = false;
 	  bool update = false;
-	  bool check = false;
 
 	  status = NtFsControlFile (fc.h, conn_evt, NULL, NULL, &io,
 				    FSCTL_PIPE_LISTEN, NULL, 0, NULL, 0);
 	  if (status == STATUS_PENDING)
 	    {
-	      HANDLE w[4] = { conn_evt, update_needed_evt,
-		check_write_ready_evt, cancel_evt };
-	      switch (WaitForMultipleObjects (4, w, false, INFINITE))
+	      HANDLE w[3] = { conn_evt, update_needed_evt, cancel_evt };
+	      switch (WaitForMultipleObjects (3, w, false, INFINITE))
 		{
 		case WAIT_OBJECT_0:
 		  status = io.Status;
@@ -552,10 +531,6 @@ fhandler_fifo::fifo_reader_thread_func ()
 		  update = true;
 		  break;
 		case WAIT_OBJECT_0 + 2:
-		  status = STATUS_WAIT_2;
-		  check = true;
-		  break;
-		case WAIT_OBJECT_0 + 3:
 		  status = STATUS_THREAD_IS_TERMINATING;
 		  cancel = true;
 		  update = true;
@@ -582,7 +557,6 @@ fhandler_fifo::fifo_reader_thread_func ()
 	      break;
 	    case STATUS_THREAD_IS_TERMINATING:
 	    case STATUS_WAIT_1:
-	    case STATUS_WAIT_2:
 	      /* Try to connect a bogus client.  Otherwise fc is still
 		 listening, and the next connection might not get recorded. */
 	      status1 = open_pipe (ph);
@@ -614,8 +588,6 @@ fhandler_fifo::fifo_reader_thread_func ()
 	    NtClose (ph);
 	  if (update && update_shared_handlers () < 0)
 	    api_fatal ("Can't update shared handlers, %E");
-	  if (check)
-	    check_write_ready ();
 	  fifo_client_unlock ();
 	  if (cancel)
 	    goto canceled;
@@ -629,8 +601,14 @@ canceled:
   return 0;
 }
 
+/* Return -1 on error and 0 or 1 on success.  If ONLY_OPEN is true, we
+   expect the shared memory to exist, and we only try to open it.  In
+   this case, we return 0 on success.
+
+   Otherwise, we create the shared memory if it doesn't exist, and we
+   return 1 if it already existed and we successfully open it. */
 int
-fhandler_fifo::create_shmem ()
+fhandler_fifo::create_shmem (bool only_open)
 {
   HANDLE sect;
   OBJECT_ATTRIBUTES attr;
@@ -640,16 +618,22 @@ fhandler_fifo::create_shmem ()
   PVOID addr = NULL;
   UNICODE_STRING uname;
   WCHAR shmem_name[MAX_PATH];
+  bool already_exists = false;
 
   __small_swprintf (shmem_name, L"fifo-shmem.%08x.%016X", get_dev (),
 		    get_ino ());
   RtlInitUnicodeString (&uname, shmem_name);
   InitializeObjectAttributes (&attr, &uname, OBJ_INHERIT,
 			      get_shared_parent_dir (), NULL);
-  status = NtCreateSection (&sect, STANDARD_RIGHTS_REQUIRED | SECTION_QUERY
-			    | SECTION_MAP_READ | SECTION_MAP_WRITE,
-			    &attr, &size, PAGE_READWRITE, SEC_COMMIT, NULL);
-  if (status == STATUS_OBJECT_NAME_COLLISION)
+  if (!only_open)
+    {
+      status = NtCreateSection (&sect, STANDARD_RIGHTS_REQUIRED | SECTION_QUERY
+				| SECTION_MAP_READ | SECTION_MAP_WRITE,
+				&attr, &size, PAGE_READWRITE, SEC_COMMIT, NULL);
+      if (status == STATUS_OBJECT_NAME_COLLISION)
+	already_exists = true;
+    }
+  if (only_open || already_exists)
     status = NtOpenSection (&sect, STANDARD_RIGHTS_REQUIRED | SECTION_QUERY
 			    | SECTION_MAP_READ | SECTION_MAP_WRITE, &attr);
   if (!NT_SUCCESS (status))
@@ -667,7 +651,7 @@ fhandler_fifo::create_shmem ()
     }
   shmem_handle = sect;
   shmem = (fifo_shmem_t *) addr;
-  return 0;
+  return already_exists ? 1 : 0;
 }
 
 /* shmem_handle must be valid when this is called. */
@@ -787,7 +771,7 @@ fhandler_fifo::remap_shared_fc_handler (size_t nbytes)
 int
 fhandler_fifo::open (int flags, mode_t)
 {
-  int saved_errno = 0;
+  int saved_errno = 0, shmem_res = 0;
 
   if (flags & O_PATH)
     return open_fs (flags);
@@ -802,8 +786,7 @@ fhandler_fifo::open (int flags, mode_t)
       writer = true;
       break;
     case O_RDWR:
-      reader = true;
-      duplexer = true;
+      reader = writer = duplexer = true;
       break;
     default:
       set_errno (EINVAL);
@@ -844,29 +827,26 @@ fhandler_fifo::open (int flags, mode_t)
       goto err_close_write_ready;
     }
 
-  /* If we're reading, signal read_ready, create the shared memory,
-     and start the fifo_reader_thread. */
+  /* If we're reading, create the shared memory and the shared
+     fc_handler memory, create some events, start the
+     fifo_reader_thread, signal read_ready, and wait for a writer. */
   if (reader)
     {
-      bool first = true;
-
-      SetEvent (read_ready);
-      if (create_shmem () < 0)
+      /* Create/open shared memory. */
+      if ((shmem_res = create_shmem ()) < 0)
 	goto err_close_writer_opening;
+      else if (shmem_res == 0)
+	debug_printf ("shmem created");
+      else
+	debug_printf ("shmem existed; ok if we're not the first reader");
       if (create_shared_fc_handler () < 0)
 	goto err_close_shmem;
-      reader_opening_lock ();
-      if (inc_nreaders () == 1)
-	/* Reinitialize _sh_fc_handler_updated, which starts as 0. */
-	shared_fc_handler_updated (true);
-      else
-	first = false;
       npbuf[0] = 'n';
       if (!(owner_needed_evt = CreateEvent (sa_buf, true, false, npbuf)))
 	{
 	  debug_printf ("CreateEvent for %s failed, %E", npbuf);
 	  __seterrno ();
-	  goto err_dec_nreaders;
+	  goto err_close_shared_fc_handler;
 	}
       npbuf[0] = 'f';
       if (!(owner_found_evt = CreateEvent (sa_buf, true, false, npbuf)))
@@ -882,36 +862,23 @@ fhandler_fifo::open (int flags, mode_t)
 	  __seterrno ();
 	  goto err_close_owner_found_evt;
 	}
-      npbuf[0] = 'c';
-      if (!(check_write_ready_evt = CreateEvent (sa_buf, false, false, npbuf)))
-	{
-	  debug_printf ("CreateEvent for %s failed, %E", npbuf);
-	  __seterrno ();
-	  goto err_close_update_needed_evt;
-	}
-      npbuf[0] = 'k';
-      if (!(write_ready_ok_evt = CreateEvent (sa_buf, false, false, npbuf)))
-	{
-	  debug_printf ("CreateEvent for %s failed, %E", npbuf);
-	  __seterrno ();
-	  goto err_close_check_write_ready_evt;
-	}
       if (!(cancel_evt = create_event ()))
-	goto err_close_write_ready_ok_evt;
+	goto err_close_update_needed_evt;
       if (!(thr_sync_evt = create_event ()))
 	goto err_close_cancel_evt;
+
       me.winpid = GetCurrentProcessId ();
       me.fh = this;
-      new cygthread (fifo_reader_thread, this, "fifo_reader", thr_sync_evt);
-      /* Wait until there's an owner. */
-      owner_lock ();
-      while (!get_owner ())
+      nreaders_lock ();
+      if (inc_nreaders () == 1)
 	{
-	  owner_unlock ();
-	  yield ();
-	  owner_lock ();
+	  /* Reinitialize _sh_fc_handler_updated, which starts as 0. */
+	  shared_fc_handler_updated (true);
+	  set_owner (me);
 	}
-      owner_unlock ();
+      new cygthread (fifo_reader_thread, this, "fifo_reader", thr_sync_evt);
+      SetEvent (read_ready);
+      nreaders_unlock ();
 
       /* If we're a duplexer, we need a handle for writing. */
       if (duplexer)
@@ -919,6 +886,11 @@ fhandler_fifo::open (int flags, mode_t)
 	  HANDLE ph = NULL;
 	  NTSTATUS status;
 
+	  nwriters_lock ();
+	  inc_nwriters ();
+	  SetEvent (write_ready);
+	  nwriters_unlock ();
+
 	  while (1)
 	    {
 	      status = open_pipe (ph);
@@ -937,46 +909,39 @@ fhandler_fifo::open (int flags, mode_t)
 	      else
 		{
 		  __seterrno_from_nt_status (status);
+		  nohandle (true);
 		  goto err_close_reader;
 		}
 	    }
 	}
       /* Not a duplexer; wait for a writer to connect if we're blocking. */
-      else if (!(flags & O_NONBLOCK))
-	{
-	  if (!first)
-	    {
-	      /* Ask the owner to update write_ready. */
-	      SetEvent (check_write_ready_evt);
-	      WaitForSingleObject (write_ready_ok_evt, INFINITE);
-	    }
-	  if (!wait (write_ready))
-	    goto err_close_reader;
-	}
-      reader_opening_unlock ();
+      else if (!wait (write_ready))
+	goto err_close_reader;
       goto success;
     }
 
-  /* If we're writing, wait for read_ready, connect to the pipe, and
-     signal write_ready.  */
+  /* If we're writing, wait for read_ready, connect to the pipe, open
+     the shared memory, and signal write_ready.  */
   if (writer)
     {
       NTSTATUS status;
 
+      /* Don't let a reader see EOF at this point. */
       SetEvent (writer_opening);
-      if (!wait (read_ready))
-	{
-	  ResetEvent (writer_opening);
-	  goto err_close_writer_opening;
-	}
       while (1)
 	{
+	  if (!wait (read_ready))
+	    {
+	      ResetEvent (writer_opening);
+	      goto err_close_writer_opening;
+	    }
 	  status = open_pipe (get_handle ());
 	  if (NT_SUCCESS (status))
-	    goto writer_success;
+	    goto writer_shmem;
 	  else if (status == STATUS_OBJECT_NAME_NOT_FOUND)
 	    {
-	      /* The pipe hasn't been created yet. */
+	      /* The pipe hasn't been created yet or there's no longer
+		 a reader open. */
 	      yield ();
 	      continue;
 	    }
@@ -995,7 +960,6 @@ fhandler_fifo::open (int flags, mode_t)
 	 and/or many writers are trying to connect simultaneously */
       while (1)
 	{
-	  SetEvent (writer_opening);
 	  if (!wait (read_ready))
 	    {
 	      ResetEvent (writer_opening);
@@ -1003,7 +967,7 @@ fhandler_fifo::open (int flags, mode_t)
 	    }
 	  status = wait_open_pipe (get_handle ());
 	  if (NT_SUCCESS (status))
-	    goto writer_success;
+	    goto writer_shmem;
 	  else if (status == STATUS_IO_TIMEOUT)
 	    continue;
 	  else
@@ -1015,34 +979,34 @@ fhandler_fifo::open (int flags, mode_t)
 	    }
 	}
     }
-writer_success:
+writer_shmem:
+  if (create_shmem (true) < 0)
+    goto err_close_writer_opening;
+/* writer_success: */
   set_pipe_non_blocking (get_handle (), flags & O_NONBLOCK);
+  nwriters_lock ();
+  inc_nwriters ();
   SetEvent (write_ready);
+  ResetEvent (writer_opening);
+  nwriters_unlock ();
 success:
   return 1;
 err_close_reader:
   saved_errno = get_errno ();
   close ();
   set_errno (saved_errno);
-  reader_opening_unlock ();
   return 0;
+/* err_close_thr_sync_evt: */
+/*   NtClose (thr_sync_evt); */
 err_close_cancel_evt:
   NtClose (cancel_evt);
-err_close_write_ready_ok_evt:
-  NtClose (write_ready_ok_evt);
-err_close_check_write_ready_evt:
-  NtClose (check_write_ready_evt);
 err_close_update_needed_evt:
   NtClose (update_needed_evt);
 err_close_owner_found_evt:
   NtClose (owner_found_evt);
 err_close_owner_needed_evt:
   NtClose (owner_needed_evt);
-err_dec_nreaders:
-  if (dec_nreaders () == 0)
-    ResetEvent (read_ready);
-  reader_opening_unlock ();
-/* err_close_shared_fc_handler: */
+err_close_shared_fc_handler:
   NtUnmapViewOfSection (NtCurrentProcess (), shared_fc_handler);
   NtClose (shared_fc_hdl);
 err_close_shmem:
@@ -1416,6 +1380,13 @@ fhandler_fifo::cancel_reader_thread ()
 int
 fhandler_fifo::close ()
 {
+  if (writer)
+    {
+      nwriters_lock ();
+      if (dec_nwriters () == 0)
+	ResetEvent (write_ready);
+      nwriters_unlock ();
+    }
   if (reader)
     {
       /* If we're the owner, we can't close our fc_handlers if a new
@@ -1481,23 +1452,19 @@ fhandler_fifo::close ()
 	NtClose (owner_found_evt);
       if (update_needed_evt)
 	NtClose (update_needed_evt);
-      if (check_write_ready_evt)
-	NtClose (check_write_ready_evt);
-      if (write_ready_ok_evt)
-	NtClose (write_ready_ok_evt);
       if (cancel_evt)
 	NtClose (cancel_evt);
       if (thr_sync_evt)
 	NtClose (thr_sync_evt);
-      if (shmem)
-	NtUnmapViewOfSection (NtCurrentProcess (), shmem);
-      if (shmem_handle)
-	NtClose (shmem_handle);
       if (shared_fc_handler)
 	NtUnmapViewOfSection (NtCurrentProcess (), shared_fc_handler);
       if (shared_fc_hdl)
 	NtClose (shared_fc_hdl);
     }
+  if (shmem)
+    NtUnmapViewOfSection (NtCurrentProcess (), shmem);
+  if (shmem_handle)
+    NtClose (shmem_handle);
   if (read_ready)
     NtClose (read_ready);
   if (write_ready)
@@ -1560,6 +1527,15 @@ fhandler_fifo::dup (fhandler_base *child, int flags)
       __seterrno ();
       goto err_close_write_ready;
     }
+  if (!DuplicateHandle (GetCurrentProcess (), shmem_handle,
+			GetCurrentProcess (), &fhf->shmem_handle,
+			0, !(flags & O_CLOEXEC), DUPLICATE_SAME_ACCESS))
+    {
+      __seterrno ();
+      goto err_close_writer_opening;
+    }
+  if (fhf->reopen_shmem () < 0)
+    goto err_close_shmem_handle;
   if (reader)
     {
       /* Make sure the child starts unlocked. */
@@ -1569,15 +1545,6 @@ fhandler_fifo::dup (fhandler_base *child, int flags)
       fhf->nhandlers = fhf->shandlers = 0;
       fhf->fc_handler = NULL;
 
-      if (!DuplicateHandle (GetCurrentProcess (), shmem_handle,
-			    GetCurrentProcess (), &fhf->shmem_handle,
-			    0, !(flags & O_CLOEXEC), DUPLICATE_SAME_ACCESS))
-	{
-	  __seterrno ();
-	  goto err_close_writer_opening;
-	}
-      if (fhf->reopen_shmem () < 0)
-	goto err_close_shmem_handle;
       if (!DuplicateHandle (GetCurrentProcess (), shared_fc_hdl,
 			    GetCurrentProcess (), &fhf->shared_fc_hdl,
 			    0, !(flags & O_CLOEXEC), DUPLICATE_SAME_ACCESS))
@@ -1608,35 +1575,19 @@ fhandler_fifo::dup (fhandler_base *child, int flags)
 	  __seterrno ();
 	  goto err_close_owner_found_evt;
 	}
-      if (!DuplicateHandle (GetCurrentProcess (), check_write_ready_evt,
-			    GetCurrentProcess (), &fhf->check_write_ready_evt,
-			    0, !(flags & O_CLOEXEC), DUPLICATE_SAME_ACCESS))
-	{
-	  __seterrno ();
-	  goto err_close_update_needed_evt;
-	}
-      if (!DuplicateHandle (GetCurrentProcess (), write_ready_ok_evt,
-			    GetCurrentProcess (), &fhf->write_ready_ok_evt,
-			    0, !(flags & O_CLOEXEC), DUPLICATE_SAME_ACCESS))
-	{
-	  __seterrno ();
-	  goto err_close_check_write_ready_evt;
-	}
       if (!(fhf->cancel_evt = create_event ()))
-	goto err_close_write_ready_ok_evt;
+	goto err_close_update_needed_evt;
       if (!(fhf->thr_sync_evt = create_event ()))
 	goto err_close_cancel_evt;
       inc_nreaders ();
       fhf->me.fh = fhf;
       new cygthread (fifo_reader_thread, fhf, "fifo_reader", fhf->thr_sync_evt);
     }
+  if (writer)
+    inc_nwriters ();
   return 0;
 err_close_cancel_evt:
   NtClose (fhf->cancel_evt);
-err_close_write_ready_ok_evt:
-  NtClose (fhf->write_ready_ok_evt);
-err_close_check_write_ready_evt:
-  NtClose (fhf->check_write_ready_evt);
 err_close_update_needed_evt:
   NtClose (fhf->update_needed_evt);
 err_close_owner_found_evt:
@@ -1668,22 +1619,20 @@ fhandler_fifo::fixup_after_fork (HANDLE parent)
   fork_fixup (parent, read_ready, "read_ready");
   fork_fixup (parent, write_ready, "write_ready");
   fork_fixup (parent, writer_opening, "writer_opening");
+  fork_fixup (parent, shmem_handle, "shmem_handle");
+  if (reopen_shmem () < 0)
+    api_fatal ("Can't reopen shared memory during fork, %E");
   if (reader)
     {
       /* Make sure the child starts unlocked. */
       fifo_client_unlock ();
 
-      fork_fixup (parent, shmem_handle, "shmem_handle");
-      if (reopen_shmem () < 0)
-	api_fatal ("Can't reopen shared memory during fork, %E");
       fork_fixup (parent, shared_fc_hdl, "shared_fc_hdl");
       if (reopen_shared_fc_handler () < 0)
 	api_fatal ("Can't reopen shared fc_handler memory during fork, %E");
       fork_fixup (parent, owner_needed_evt, "owner_needed_evt");
       fork_fixup (parent, owner_found_evt, "owner_found_evt");
       fork_fixup (parent, update_needed_evt, "update_needed_evt");
-      fork_fixup (parent, check_write_ready_evt, "check_write_ready_evt");
-      fork_fixup (parent, write_ready_ok_evt, "write_ready_ok_evt");
       if (close_on_exec ())
 	/* Prevent a later attempt to close the non-inherited
 	   pipe-instance handles copied from the parent. */
@@ -1696,19 +1645,23 @@ fhandler_fifo::fixup_after_fork (HANDLE parent)
       me.winpid = GetCurrentProcessId ();
       new cygthread (fifo_reader_thread, this, "fifo_reader", thr_sync_evt);
     }
+  if (writer)
+    inc_nwriters ();
 }
 
 void
 fhandler_fifo::fixup_after_exec ()
 {
   fhandler_base::fixup_after_exec ();
-  if (reader && !close_on_exec ())
+  if (close_on_exec ())
+    return;
+  if (reopen_shmem () < 0)
+    api_fatal ("Can't reopen shared memory during exec, %E");
+  if (reader)
     {
       /* Make sure the child starts unlocked. */
       fifo_client_unlock ();
 
-      if (reopen_shmem () < 0)
-	api_fatal ("Can't reopen shared memory during exec, %E");
       if (reopen_shared_fc_handler () < 0)
 	api_fatal ("Can't reopen shared fc_handler memory during exec, %E");
       fc_handler = NULL;
@@ -1723,6 +1676,8 @@ fhandler_fifo::fixup_after_exec ()
       me.winpid = GetCurrentProcessId ();
       new cygthread (fifo_reader_thread, this, "fifo_reader", thr_sync_evt);
     }
+  if (writer)
+    inc_nwriters ();
 }
 
 void
@@ -1737,8 +1692,6 @@ fhandler_fifo::set_close_on_exec (bool val)
       set_no_inheritance (owner_needed_evt, val);
       set_no_inheritance (owner_found_evt, val);
       set_no_inheritance (update_needed_evt, val);
-      set_no_inheritance (check_write_ready_evt, val);
-      set_no_inheritance (write_ready_ok_evt, val);
       fifo_client_lock ();
       for (int i = 0; i < nhandlers; i++)
 	set_no_inheritance (fc_handler[i].h, val);
-- 
2.27.0

