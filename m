Return-Path: <kbrown@cornell.edu>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770093.outbound.protection.outlook.com [40.107.77.93])
 by sourceware.org (Postfix) with ESMTPS id 8B2C8396E85D
 for <cygwin-patches@cygwin.com>; Thu,  7 May 2020 20:21:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 8B2C8396E85D
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Af9EzMLUXq8nvdKovS14nft2rSr9GKgqyhQVhTEzFPDosMzt6eBL12pp91RQK3WZDbdRl7QOHfIoR5EQ6JPacjq+/IQq3DBi22BvcFmXKaZ7QSXENhgyT8eyHFxknrPcyU38IisPY+LOWBqPr++x25SDh8HjM0sPfjIFvMJiI7kmbqjWZkAGGFGuXSLT6+vgy7HOJKNbcoxgWhY2+WxgW25ssfmJLK9H+OLtENx4BsP1c2lSC67aZjJMs4MyHoroJAni0ZmBzgzfNrfKUEWnPzWkkFqbfYyQOiNpr2JsEchaJuGpJGi7bgQKO8W7muUC68RZsxFIlEEycnxBRN+qvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/14OdUwTPhi1Xl59sDrOV1O9NAiNuiVcmNG7QSznTyw=;
 b=gNs0EhfLLPRqSvlqtrS7WzRXLj0auGWdZI19nIb2WF5dBdwVbrW+AMXAtpCT3uALP6aPHm8qMNWXwRAI/iN/bkToEUNATpT03D7IYFFYcLnfdD0VJhSoTKA5YDqV+8eoyqcV7jKNbq0UTbp/1YPohDgMx9wf+y1cQETa/f5kb0OJfnBLlS5S2xCi3LP6wiKdZCXusqnNGKa0MVJJLWGZpfA9QPKdKPY/BZdmyGLBin2Wrhv0a2RDMT6lv97YMmmyOpldsSDf/peflrZejF1RaJd2q2DKdjC8yqH3jXQ1pKMnJDPs097pRBQC6hvIzDRgFSBnIfQDVQ3+MC0RqwaahQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from DM6PR04MB6075.namprd04.prod.outlook.com (2603:10b6:5:127::31)
 by DM6PR04MB6075.namprd04.prod.outlook.com (2603:10b6:5:127::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Thu, 7 May
 2020 20:21:50 +0000
Received: from DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4]) by DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4%4]) with mapi id 15.20.2979.025; Thu, 7 May 2020
 20:21:50 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Cc: sten.kristian.ivarsson@gmail.com
Subject: [PATCH 10/21] Cygwin: FIFO: use a cygthread instead of a homemade
 thread
Date: Thu,  7 May 2020 16:21:13 -0400
Message-Id: <20200507202124.1463-11-kbrown@cornell.edu>
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
 15.20.2979.28 via Frontend Transport; Thu, 7 May 2020 20:21:49 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [2604:6000:b407:7f00:e532:58da:20b8:9136]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 913a8728-848a-45fa-01bc-08d7f2c445fa
X-MS-TrafficTypeDiagnostic: DM6PR04MB6075:
X-Microsoft-Antispam-PRVS: <DM6PR04MB6075A6A92ECF778388AC455BD8A50@DM6PR04MB6075.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gk9lHRcCDYj9pvnR/eRmf9yAtqRQK7veuTiZq+bvWRzzCsRnqzd11FDUXEZP108h9zcEUU6946iWxozCZXrVvz4YGOChzhNQwB0xx0fQRFIH4IZjwa++TTdNGxs97yafqXR+IE/02rga55Pz9XrnzsF5aj2V90AEl9kG2GyBbwCpcBcbur7Aw7i/ogWzwnaWprFzmWlFtzc/M1Y+if13Dm9WTydyFs1BXQYhTux8Et1ZmzGZQPyqXsGseQLOMc7hiA/vECmTLQvQ3SxIEsoiOuxokWBlDbJWjjiBZpB7gqTsfRYhJgTP9Yo97oLBOLNwBsmnf7Uy2PRVWUXfM0pNiisbOC3n5jpYFBqUCnABEpiqaPP2ryMcxFsy+X48tD7YJmeJLm14uwxHMEywKgqJtmUvZTLlgh/p/Y0fUs0Nf8mzitcXAKreXN1KgWx1F2iIBdTZClmea2y2vGap2GUYTnEaDSgwECYmmSYLe4S1DolxECHihFoNsrrLW7YFqPFNx/L5FZtVfuMBP259SMWxhgQynYtJguH5D8KKhPdCuxALjiJA6BAkrvOB0bVH4aST
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6075.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(33430700001)(33440700001)(6512007)(6486002)(478600001)(786003)(8676002)(66946007)(1076003)(5660300002)(8936002)(83300400001)(66476007)(316002)(83320400001)(83280400001)(83310400001)(83290400001)(66556008)(69590400007)(75432002)(36756003)(2616005)(4326008)(86362001)(6666004)(2906002)(6916009)(30864003)(186003)(6506007)(16526019)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: yhS7U6lCtpElkbShHTrhB5BA7xysWMMTKpJC9ubYIKJCyMf9TzLyYtGV5g5RqYOUJwD+l5iequjlwfVxBmfqJFQaD5454+IjLYn3/IOLTWgeHwTrZph0gqyU8yKbirYnf/VBsP/l0w8uCxodNEzXxzaTuVri6h9V/i7Xq/frK0LQV+KRXcze4gHGGYoFKtX1/tBN7rTHg80dUw/F9gTN1VHU70IpRwtDDc4XZdPF3C7B0fQxdsPP4tkmDvNio1oBfq2l9u7I5+gcPFmE1WlzF5BZ2XtqUlb0fC+dom+HpJODyV9EuWn7qZfNmO3eyXW66TJip/D+6Wm4xMbvFJpb2neRJC5EX2ITnHW/9hNDiMkAy3r9n67GY2Kze/R1vkdnew6rr9Th3293j6NzTJ27tFtZAvGvi+6FHdOAudlZJGtFn/KRnm1C1gTuQGe6JTBbqD3EGgCUFwRV9obebQqApq6yt4+6+ZFK1eCX4mJjeemxV1xgoc9qR8+F2Ci8EBILeVkdp5saiT88QjD0O/71tZldecB4JcXMsYRZgvdzakm2nFjLfrNr7XInyxcVh5248lm2vL6j7FoyCKDnLmKkxu3w1FurRHyqmxva3MI2Doxu21KjWbTkF4WTAQ7Pm/RsfAqTQrfvtHVjrw7VLKIJgo8UBplUGvu5U3vD+4El65z+TWdNofsatctn5Hgkno2BWfMmgBOf4ounHKg5Wz7oyO2CE/c6x42yTfLyYUTFgL97JQgRcmaibxWIOk0hjX1rPgZaREjCEZy++WwzzBDsUzqAnXvOZ6/1L9Y1OkmRACOJqTZKHB1ZD3SjAGMQQ99gVJstrc4vRjQ9bVw7cyKB8anyTyIcj/XiNW9CXDJRFcGjvUevI1doxKF4r2yQfQKz
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 913a8728-848a-45fa-01bc-08d7f2c445fa
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 20:21:49.9957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KAhYVZk+CrEXFllcsKX77B1MU8GaUky/AdCD9a+9fSKnQ7Q5mzwLltiKxom8PqWmbJOopdqOsjIgcojR3kkdSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6075
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 07 May 2020 20:22:08 -0000

This will simplify future work.

Rename the thread from "listen_client_thread" to "fifo_reader_thread"
because it will be used for more than just listening.

Remove the fixup_before stuff, which won't be needed after future
changes to fixup_after_fork and fixup_after_exec.
---
 winsup/cygwin/fhandler.h       |  17 ++--
 winsup/cygwin/fhandler_fifo.cc | 173 +++++++++++----------------------
 2 files changed, 65 insertions(+), 125 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 2516c93b4..5e6a1d1db 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1307,9 +1307,9 @@ class fhandler_fifo: public fhandler_base
   HANDLE write_ready;           /* A writer is open; OK for a reader to open. */
   HANDLE writer_opening;        /* A writer is opening; no EOF. */
 
-  /* Non-shared handles needed for the listen_client_thread. */
-  HANDLE listen_client_thr;
-  HANDLE lct_termination_evt;
+  /* Handles to non-shared events needed for fifo_reader_threads. */
+  HANDLE cancel_evt;            /* Signal thread to terminate. */
+  HANDLE thr_sync_evt;          /* The thread has terminated. */
 
   UNICODE_STRING pipe_name;
   WCHAR pipe_name_buf[CYGWIN_FIFO_PIPE_NAME_LEN + 1];
@@ -1326,11 +1326,10 @@ class fhandler_fifo: public fhandler_base
   NTSTATUS wait_open_pipe (HANDLE&);
   int add_client_handler ();
   void delete_client_handler (int);
-  bool listen_client ();
-  void stop_listen_client ();
-  int check_listen_client_thread ();
+  void cancel_reader_thread ();
   void record_connection (fifo_client_handler&,
 			  fifo_client_connect_state = fc_connected);
+
 public:
   fhandler_fifo ();
   bool hit_eof ();
@@ -1339,7 +1338,7 @@ public:
   int get_nhandlers () const { return nhandlers; }
   fifo_client_handler get_fc_handler (int i) const { return fc_handler[i]; }
   PUNICODE_STRING get_pipe_name ();
-  DWORD listen_client_thread ();
+  DWORD fifo_reader_thread_func ();
   void fifo_client_lock () { _fifo_client_lock.lock (); }
   void fifo_client_unlock () { _fifo_client_lock.unlock (); }
   int open (int, mode_t);
@@ -1351,9 +1350,6 @@ public:
   void set_close_on_exec (bool val);
   void __reg3 raw_read (void *ptr, size_t& ulen);
   ssize_t __reg3 raw_write (const void *ptr, size_t ulen);
-  bool need_fixup_before () const { return reader; }
-  int fixup_before_fork_exec (DWORD) { stop_listen_client (); return 0; }
-  void init_fixup_before ();
   void fixup_after_fork (HANDLE);
   void fixup_after_exec ();
   int __reg2 fstatvfs (struct statvfs *buf);
@@ -1375,7 +1371,6 @@ public:
     void *ptr = (void *) ccalloc (malloc_type, 1, sizeof (fhandler_fifo));
     fhandler_fifo *fhf = new (ptr) fhandler_fifo (ptr);
     /* We don't want our client list to change any more. */
-    stop_listen_client ();
     copyto (fhf);
     /* fhf->pipe_name_buf is a *copy* of this->pipe_name_buf, but
        fhf->pipe_name.Buffer == this->pipe_name_buf. */
diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index 5c3df5497..09a7eb321 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -32,11 +32,11 @@
      When a FIFO is opened for reading,
      fhandler_fifo::create_pipe_instance is called to create the first
      instance of a Windows named pipe server (Windows terminology).  A
-     "listen_client" thread is also started; it waits for pipe clients
+     "fifo_reader" thread is also started; it waits for pipe clients
      (Windows terminology again) to connect.  This happens every time
      a process opens the FIFO for writing.
 
-     The listen_client thread creates new instances of the pipe server
+     The fifo_reader thread creates new instances of the pipe server
      as needed, so that there is always an instance available for a
      writer to connect to.
 
@@ -68,7 +68,7 @@ STATUS_PIPE_EMPTY simply means there's no data to be read. */
 fhandler_fifo::fhandler_fifo ():
   fhandler_base (),
   read_ready (NULL), write_ready (NULL), writer_opening (NULL),
-  listen_client_thr (NULL), lct_termination_evt (NULL), _maybe_eof (false), nhandlers (0),
+  cancel_evt (NULL), thr_sync_evt (NULL), _maybe_eof (false), nhandlers (0),
   reader (false), writer (false), duplexer (false),
   max_atomic_write (DEFAULT_PIPEBUFSIZE)
 {
@@ -319,34 +319,6 @@ fhandler_fifo::delete_client_handler (int i)
 	     (nhandlers - i) * sizeof (fc_handler[i]));
 }
 
-/* Just hop to the listen_client_thread method. */
-DWORD WINAPI
-listen_client_func (LPVOID param)
-{
-  fhandler_fifo *fh = (fhandler_fifo *) param;
-  return fh->listen_client_thread ();
-}
-
-/* Start a thread that listens for client connections. */
-bool
-fhandler_fifo::listen_client ()
-{
-  if (!(lct_termination_evt = create_event ()))
-    return false;
-
-  listen_client_thr = CreateThread (NULL, PREFERRED_IO_BLKSIZE,
-				    listen_client_func, (PVOID) this, 0, NULL);
-  if (!listen_client_thr)
-    {
-      __seterrno ();
-      HANDLE evt = InterlockedExchangePointer (&lct_termination_evt, NULL);
-      if (evt)
-	NtClose (evt);
-      return false;
-    }
-  return true;
-}
-
 void
 fhandler_fifo::record_connection (fifo_client_handler& fc,
 				  fifo_client_connect_state s)
@@ -357,8 +329,15 @@ fhandler_fifo::record_connection (fifo_client_handler& fc,
   set_pipe_non_blocking (fc.h, true);
 }
 
+static DWORD WINAPI
+fifo_reader_thread (LPVOID param)
+{
+  fhandler_fifo *fh = (fhandler_fifo *) param;
+  return fh->fifo_reader_thread_func ();
+}
+
 DWORD
-fhandler_fifo::listen_client_thread ()
+fhandler_fifo::fifo_reader_thread_func ()
 {
   HANDLE conn_evt;
 
@@ -377,7 +356,6 @@ fhandler_fifo::listen_client_thread ()
 	  else
 	    i++;
 	}
-      fifo_client_unlock ();
 
       /* Create a new client handler. */
       if (add_client_handler () < 0)
@@ -385,6 +363,7 @@ fhandler_fifo::listen_client_thread ()
 
       /* Listen for a writer to connect to the new client handler. */
       fifo_client_handler& fc = fc_handler[nhandlers - 1];
+      fifo_client_unlock ();
       NTSTATUS status;
       IO_STATUS_BLOCK io;
       bool cancel = false;
@@ -393,9 +372,8 @@ fhandler_fifo::listen_client_thread ()
 				FSCTL_PIPE_LISTEN, NULL, 0, NULL, 0);
       if (status == STATUS_PENDING)
 	{
-	  HANDLE w[2] = { conn_evt, lct_termination_evt };
-	  DWORD waitret = WaitForMultipleObjects (2, w, false, INFINITE);
-	  switch (waitret)
+	  HANDLE w[2] = { conn_evt, cancel_evt };
+	  switch (WaitForMultipleObjects (2, w, false, INFINITE))
 	    {
 	    case WAIT_OBJECT_0:
 	      status = io.Status;
@@ -453,11 +431,13 @@ fhandler_fifo::listen_client_thread ()
       if (ph)
 	NtClose (ph);
       if (cancel)
-	goto out;
+	goto canceled;
     }
-out:
+canceled:
   if (conn_evt)
     NtClose (conn_evt);
+  /* automatically return the cygthread to the cygthread pool */
+  _my_tls._ctinfo->auto_release ();
   return 0;
 }
 
@@ -521,16 +501,15 @@ fhandler_fifo::open (int flags, mode_t)
       goto err_close_write_ready;
     }
 
-  /* If we're reading, signal read_ready and start the listen_client
-     thread. */
+  /* If we're reading, signal read_ready and start the fifo_reader_thread. */
   if (reader)
     {
-      if (!listen_client ())
-	{
-	  debug_printf ("create of listen_client thread failed");
-	  goto err_close_writer_opening;
-	}
       SetEvent (read_ready);
+      if (!(cancel_evt = create_event ()))
+	goto err_close_writer_opening;
+      if (!(thr_sync_evt = create_event ()))
+	goto err_close_cancel_evt;
+      new cygthread (fifo_reader_thread, this, "fifo_reader", thr_sync_evt);
 
       /* If we're a duplexer, we need a handle for writing. */
       if (duplexer)
@@ -563,7 +542,6 @@ fhandler_fifo::open (int flags, mode_t)
       /* Not a duplexer; wait for a writer to connect. */
       else if (!wait (write_ready))
 	goto err_close_reader;
-      init_fixup_before ();
       goto success;
     }
 
@@ -635,6 +613,8 @@ err_close_reader:
   close ();
   set_errno (saved_errno);
   return 0;
+err_close_cancel_evt:
+  NtClose (cancel_evt);
 err_close_writer_opening:
   NtClose (writer_opening);
 err_close_write_ready:
@@ -815,43 +795,9 @@ fhandler_fifo::hit_eof ()
   return ret;
 }
 
-/* Is the lct running? */
-int
-fhandler_fifo::check_listen_client_thread ()
-{
-  int ret = 0;
-
-  if (listen_client_thr)
-    {
-      DWORD waitret = WaitForSingleObject (listen_client_thr, 0);
-      switch (waitret)
-	{
-	case WAIT_OBJECT_0:
-	  NtClose (listen_client_thr);
-	  break;
-	case WAIT_TIMEOUT:
-	  ret = 1;
-	  break;
-	default:
-	  debug_printf ("WaitForSingleObject failed, %E");
-	  ret = -1;
-	  __seterrno ();
-	  NtClose (listen_client_thr);
-	  break;
-	}
-    }
-  return ret;
-}
-
 void __reg3
 fhandler_fifo::raw_read (void *in_ptr, size_t& len)
 {
-  /* Make sure the lct is running. */
-  int res = check_listen_client_thread ();
-  debug_printf ("lct status %d", res);
-  if (res < 0 || (res == 0 && !listen_client ()))
-    goto errout;
-
   if (!len)
     return;
 
@@ -976,35 +922,29 @@ fifo_client_handler::pipe_state ()
 }
 
 void
-fhandler_fifo::stop_listen_client ()
+fhandler_fifo::cancel_reader_thread ()
 {
-  HANDLE thr, evt;
-
-  thr = InterlockedExchangePointer (&listen_client_thr, NULL);
-  if (thr)
-    {
-      if (lct_termination_evt)
-	SetEvent (lct_termination_evt);
-      WaitForSingleObject (thr, INFINITE);
-      NtClose (thr);
-    }
-  evt = InterlockedExchangePointer (&lct_termination_evt, NULL);
-  if (evt)
-    NtClose (evt);
+  if (cancel_evt)
+    SetEvent (cancel_evt);
+  if (thr_sync_evt)
+    WaitForSingleObject (thr_sync_evt, INFINITE);
 }
 
 int
 fhandler_fifo::close ()
 {
-  /* Avoid deadlock with lct in case this is called from a signal
-     handler or another thread. */
-  fifo_client_unlock ();
-  stop_listen_client ();
   if (reader)
-    /* FIXME: There could be several readers open because of
-       dup/fork/exec; we should only reset read_ready when the last
-       one closes. */
-    ResetEvent (read_ready);
+    {
+      cancel_reader_thread ();
+      if (cancel_evt)
+	NtClose (cancel_evt);
+      if (thr_sync_evt)
+	NtClose (thr_sync_evt);
+      /* FIXME: There could be several readers open because of
+	 dup/fork/exec; we should only reset read_ready when the last
+	 one closes. */
+      ResetEvent (read_ready);
+    }
   if (read_ready)
     NtClose (read_ready);
   if (write_ready)
@@ -1091,11 +1031,16 @@ fhandler_fifo::dup (fhandler_base *child, int flags)
 	  goto err_close_handlers;
 	}
       fifo_client_unlock ();
-      if (!fhf->listen_client ())
+      if (!(fhf->cancel_evt = create_event ()))
 	goto err_close_handlers;
-      fhf->init_fixup_before ();
+      if (!(fhf->thr_sync_evt = create_event ()))
+	goto err_close_cancel_evt;
+      new cygthread (fifo_reader_thread, fhf, "fifo_reader",
+		     fhf->thr_sync_evt);
     }
   return 0;
+err_close_cancel_evt:
+  NtClose (fhf->cancel_evt);
 err_close_handlers:
   for (int j = 0; j < i; j++)
     fhf->fc_handler[j].close ();
@@ -1109,12 +1054,6 @@ err:
   return -1;
 }
 
-void
-fhandler_fifo::init_fixup_before ()
-{
-  cygheap->fdtab.inc_need_fixup_before ();
-}
-
 void
 fhandler_fifo::fixup_after_fork (HANDLE parent)
 {
@@ -1131,8 +1070,11 @@ fhandler_fifo::fixup_after_fork (HANDLE parent)
       for (int i = 0; i < nhandlers; i++)
 	fork_fixup (parent, fc_handler[i].h, "fc_handler[].h");
       fifo_client_unlock ();
-      if (!listen_client ())
-	debug_printf ("failed to start lct, %E");
+      if (!(cancel_evt = create_event ()))
+	api_fatal ("Can't create reader thread cancel event during fork, %E");
+      if (!(thr_sync_evt = create_event ()))
+	api_fatal ("Can't create reader thread sync event during fork, %E");
+      new cygthread (fifo_reader_thread, this, "fifo_reader", thr_sync_evt);
     }
 }
 
@@ -1145,8 +1087,11 @@ fhandler_fifo::fixup_after_exec ()
       /* Make sure the child starts unlocked. */
       fifo_client_unlock ();
 
-      if (!listen_client ())
-	debug_printf ("failed to start lct, %E");
+      if (!(cancel_evt = create_event ()))
+	api_fatal ("Can't create reader thread cancel event during exec, %E");
+      if (!(thr_sync_evt = create_event ()))
+	api_fatal ("Can't create reader thread sync event during exec, %E");
+      new cygthread (fifo_reader_thread, this, "fifo_reader", thr_sync_evt);
     }
 }
 
-- 
2.21.0

