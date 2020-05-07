Return-Path: <kbrown@cornell.edu>
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2122.outbound.protection.outlook.com [40.107.243.122])
 by sourceware.org (Postfix) with ESMTPS id 2660F396E463
 for <cygwin-patches@cygwin.com>; Thu,  7 May 2020 20:21:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 2660F396E463
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHhSSTJNFF+f/bU0husXq8eRIttf+SSfuA54u6bv3txf6hV7PinwzczydhnWHQf0gVAr9gFQ24enNstuSKHmhkBBebM42dZT58qLEbhpl8dCshpY0RTi1zH0rEmwoU1A5kiOBAF9H+Dkg5slhdwQluKuo1gucyjlrsmxP7z26SmBmR3DWocxNjp5h84yA8tsyTbsL6JmSq3nsMRX68HzGLLQ34aIpjz/1R+P/fZXsUo+5DibuMk8gA3PmEwnWtY+SAxH1twGlSC3rWagMDvvvydwyUMjfhBHxpLsZvZckXgPEnGB8dSGISE/HT1CuSl3J36N5ZMZ6PYeQdOsJBn2wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FddSifo1Y3CK54m+gcyvacCpAmuidnZj/5bKGBDIdHI=;
 b=HKI1iAkYem9Vphs/XD2bHpkBqi+9fdDCAGOWswSFir7Vl3kYRn3AYwUTjtJsWa+bHpb5B4cwEbCKoDZ4x5A+mTNQlPXxbVSWZM0bLI/hD6RQoor1VjIJ+VICFttb/xitKX7Wl0NyCfsXDBRfb1DvzP1qXK0yw/QKJkZKITMSzpEYPWQmqboWLHI8cRyt0C0LWQfqouV5KfLB7l6ahD5V511N7K63Ju/wfW2KwCg+4gpznJhXtu6BiSQbzPDzlZdkVwbZfKPVMtq6EeASOxaOVDiw6xGkdh/N9E0ylPCKZMDUj13hAOsfIZi6Qb4kqhxxqbASj4bXZNeP1WLaDwapIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from DM6PR04MB6075.namprd04.prod.outlook.com (2603:10b6:5:127::31)
 by DM6PR04MB5082.namprd04.prod.outlook.com (2603:10b6:5:1a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Thu, 7 May
 2020 20:21:56 +0000
Received: from DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4]) by DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4%4]) with mapi id 15.20.2979.025; Thu, 7 May 2020
 20:21:56 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Cc: sten.kristian.ivarsson@gmail.com
Subject: [PATCH 16/21] Cygwin: FIFO: add a shared fifo_client_handler list
Date: Thu,  7 May 2020 16:21:19 -0400
Message-Id: <20200507202124.1463-17-kbrown@cornell.edu>
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
 15.20.2979.28 via Frontend Transport; Thu, 7 May 2020 20:21:55 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [2604:6000:b407:7f00:e532:58da:20b8:9136]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 574802ed-9973-4077-8c07-08d7f2c4499e
X-MS-TrafficTypeDiagnostic: DM6PR04MB5082:
X-Microsoft-Antispam-PRVS: <DM6PR04MB5082002E7FBE82D25018BBC8D8A50@DM6PR04MB5082.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:144;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8lPxiE+16ZTdzJlFPQRemzGPVROjZPoPQnO99VgRMzavWYoxYnMgevWHB3rubXBAixkIJyyCxyamGZL3vrY5lDJOQdg/YIGStCgM8uLUKOZvGgo54dOOzBep4xDvvxtNmcQw+g/pTiP7XXsEaZWECg4/x5L1PIFZaJGaFlGAJ5GTddZqzQ60uqcYSY8UDKTFMz0ucLjaanzmd1vsgmOLRJhv+shgkvxElr3Lp8oPNYdW+zGT442sJbQFZGioGopIjWMRS0n9uKArx3ozrahYkw0+LqUNAdldMaWvLC2xahjPu9ZUM7Q8B+xGH9qUk5wQHoLDWkhypt3n7FlR8T9z7v1bB2FrB3TDMrDt0RcjAFRZRDaY8Njiso1XioX2mD7LzBNAGuxv5PDGZt3GNK7eM82XW0dV1v/eUN5tGJ1OUovtwZR5853M2EWcwz3mMJJrv4uHvHPcYKV2NPGptznrzUwGemOh4ZXZA6DawIuTYyxCvx2BYxDs5Is96PuSOEpUptlq7FavQWWqBVj/1To4Ejv3XgQiNyk+O8HIonGqBKcoO/hmc6ii+sN8BClDSvbB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6075.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(33430700001)(66556008)(86362001)(786003)(6666004)(186003)(6512007)(75432002)(52116002)(66476007)(69590400007)(316002)(6506007)(2616005)(4326008)(478600001)(5660300002)(30864003)(1076003)(36756003)(2906002)(33440700001)(16526019)(6486002)(66946007)(8676002)(6916009)(8936002)(83320400001)(83280400001)(83310400001)(83290400001)(83300400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: GWGKo4NHAlzGkfMvOlOZXC35gyVmq5hYi4exOhSxAQC5ShJYHUBT/E2oemlhMS+/03uG9SQ+/TeHCERW3u4YpyiHopMSwzXybfit6aEB5Zi3P2V03etSadepsreBit6mftRt2DATOst8iuuPwtsV7KhnsXvuy1AcHJvuEf4Cxh6PlTdsiWedG0PdGihUmF4vJWvFdUmMPKlBNC6w9irUUjBS+B7AcpjSds+/mDoStymrx1SaJAV4JNLJrMf228mWTjHqgHxFqBBHMzO2e/v9UQ3bwWTYb9HJqr68JSstKWcbe7MbPFkKMpptffELx0VmLtwnKsSHHBS3SASZcWQ0PvFRfGQjJbm6v0MFkqGxPRgFaF94cxXt1+1nW+bE1MLlytj1POv0CtsdzQiQ3SG6/6TEDcBj8M2P9pLXTkXIB29/RhfajIsOHLVG1INWyKR6i08QYRBvfEgrVWUW8mYrKYwynmFOLVOg6SjR3bG8tifhkUxNQDeFaX03VvC6PyLauCZZ2cZ3XgB9aWu2RmOjLHP5t/6y4VAlzD6dwvLxjmnhtlFwa7C6Wf/Yy8oox2PdfrR35JsvdBMTztDRAMcm77OaQu9UDDTsdXnCqGm8p3b3z/cJ6or4pDfNKDNoVSrjlJvEYT3J1ZbH3WVtjRTijxhZ9+5fmsfy2vZdifH7yoAiuv0CKLOoscWY4/unwgZ763mvvf+ncfUSFEJdv/rBSZqnbbrSOVXcdimMujMVcrEYvnmjKFQ4XVLwfIeZRpGQyr5G72ddiMhPbRSecuAwEs3n3XrESkB3VZrg5Hxakl1muwEZo97jnPKojEG2C6AkoCnCtcKSnxj+lXhEVzKymo0f5tf9uPinWTdYP5pzyY+X4/alvTfUa12gtiee7Q5J
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 574802ed-9973-4077-8c07-08d7f2c4499e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 20:21:56.0702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hrs7dhzvf5Pf2Yk+yQPkwLaNLuwcRtoJBxlIlPXkaF+qyh0+0WeRUwRrdpz8yL28bPbnLxXVFy8ri/VmV87dAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5082
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 07 May 2020 20:22:08 -0000

This is in a new shared memory section.  We will use it for temporary
storage of the owner's fc_handler list when we need to change owner.
The new owner can then duplicate the pipe handles from that list
before taking ownership.

Add several shared data members and methods that are needed for the
duplication process

Add methods update_my_handlers and update_shared_handlers that carry
out the duplication.

Allow the shared list to grow dynamically, up to a point.  Do this by
initially reserving a block of memory (currently 100 pages) and only
committing pages as needed.

Add methods create_shared_fc_handler, reopen_shared_fc_handler, and
remap_shared_fc_handler to create the new shared memory section,
reopen it, and commit new pages.  The first is called in open, the
second is called in dup/fork/exec, and the third is called in
update_shared_handlers if more shared memory is needed.

Modify the fifo_reader_thread function to call update_my_handlers when
it finds that there is no owner.  Also make it call
update_shared_handlers when the owner's thread terminates, so that the
new owner will have an accurate shared fc_handler list from which to
duplicate.

For convenience, add new methods cleanup_handlers and
close_all_handlers.  And add an optional arg to add_client_handler
that allows it to create a new fifo_client_handler without creating a
new pipe instance.
---
 winsup/cygwin/fhandler.h       |  43 +++++-
 winsup/cygwin/fhandler_fifo.cc | 253 +++++++++++++++++++++++++++++----
 2 files changed, 269 insertions(+), 27 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 4f42cf1b8..34b209f5d 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1323,17 +1323,33 @@ struct fifo_reader_id_t
 class fifo_shmem_t
 {
   LONG _nreaders;
-  fifo_reader_id_t _owner;
+  fifo_reader_id_t _owner, _prev_owner;
   af_unix_spinlock_t _owner_lock;
 
+  /* Info about shared memory block used for temporary storage of the
+     owner's fc_handler list. */
+  LONG _sh_nhandlers, _sh_shandlers, _sh_fc_handler_committed;
+
 public:
   int inc_nreaders () { return (int) InterlockedIncrement (&_nreaders); }
   int dec_nreaders () { return (int) InterlockedDecrement (&_nreaders); }
 
   fifo_reader_id_t get_owner () const { return _owner; }
   void set_owner (fifo_reader_id_t fr_id) { _owner = fr_id; }
+  fifo_reader_id_t get_prev_owner () const { return _prev_owner; }
+  void set_prev_owner (fifo_reader_id_t fr_id) { _prev_owner = fr_id; }
+
   void owner_lock () { _owner_lock.lock (); }
   void owner_unlock () { _owner_lock.unlock (); }
+
+  int get_shared_nhandlers () const { return (int) _sh_nhandlers; }
+  void set_shared_nhandlers (int n) { InterlockedExchange (&_sh_nhandlers, n); }
+  int get_shared_shandlers () const { return (int) _sh_shandlers; }
+  void set_shared_shandlers (int n) { InterlockedExchange (&_sh_shandlers, n); }
+  size_t get_shared_fc_handler_committed () const
+  { return (size_t) _sh_fc_handler_committed; }
+  void set_shared_fc_handler_committed (size_t n)
+  { InterlockedExchange (&_sh_fc_handler_committed, (LONG) n); }
 };
 
 class fhandler_fifo: public fhandler_base
@@ -1360,24 +1376,47 @@ class fhandler_fifo: public fhandler_base
 
   HANDLE shmem_handle;
   fifo_shmem_t *shmem;
+  HANDLE shared_fc_hdl;
+  /* Dynamically growing array in shared memory. */
+  fifo_client_handler *shared_fc_handler;
 
   bool __reg2 wait (HANDLE);
   static NTSTATUS npfs_handle (HANDLE &);
   HANDLE create_pipe_instance ();
   NTSTATUS open_pipe (HANDLE&);
   NTSTATUS wait_open_pipe (HANDLE&);
-  int add_client_handler ();
+  int add_client_handler (bool new_pipe_instance = true);
   void delete_client_handler (int);
+  void cleanup_handlers ();
+  void close_all_handlers ();
   void cancel_reader_thread ();
   void record_connection (fifo_client_handler&,
 			  fifo_client_connect_state = fc_connected);
 
   int create_shmem ();
   int reopen_shmem ();
+  int create_shared_fc_handler ();
+  int reopen_shared_fc_handler ();
+  int remap_shared_fc_handler (size_t);
 
   int inc_nreaders () { return shmem->inc_nreaders (); }
   int dec_nreaders () { return shmem->dec_nreaders (); }
 
+  fifo_reader_id_t get_prev_owner () const { return shmem->get_prev_owner (); }
+  void set_prev_owner (fifo_reader_id_t fr_id)
+  { shmem->set_prev_owner (fr_id); }
+
+  int get_shared_nhandlers () { return shmem->get_shared_nhandlers (); }
+  void set_shared_nhandlers (int n) { shmem->set_shared_nhandlers (n); }
+  int get_shared_shandlers () { return shmem->get_shared_shandlers (); }
+  void set_shared_shandlers (int n) { shmem->set_shared_shandlers (n); }
+  size_t get_shared_fc_handler_committed () const
+  { return shmem->get_shared_fc_handler_committed (); }
+  void set_shared_fc_handler_committed (size_t n)
+  { shmem->set_shared_fc_handler_committed (n); }
+  int update_my_handlers ();
+  int update_shared_handlers ();
+
 public:
   fhandler_fifo ();
   bool hit_eof ();
diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index 595e55ad9..846115ad4 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -21,6 +21,7 @@
 #include "shared_info.h"
 #include "ntdll.h"
 #include "cygwait.h"
+#include <sys/param.h>
 
 /*
    Overview:
@@ -65,6 +66,9 @@ STATUS_PIPE_EMPTY simply means there's no data to be read. */
 		   || _s == STATUS_PIPE_NOT_AVAILABLE \
 		   || _s == STATUS_PIPE_BUSY; })
 
+/* Number of pages reserved for shared_fc_handler. */
+#define SH_FC_HANDLER_PAGES 100
+
 static NO_COPY fifo_reader_id_t null_fr_id = { .winpid = 0, .fh = NULL };
 
 fhandler_fifo::fhandler_fifo ():
@@ -74,7 +78,8 @@ fhandler_fifo::fhandler_fifo ():
   fc_handler (NULL), shandlers (0), nhandlers (0),
   reader (false), writer (false), duplexer (false),
   max_atomic_write (DEFAULT_PIPEBUFSIZE),
-  me (null_fr_id), shmem_handle (NULL), shmem (NULL)
+  me (null_fr_id), shmem_handle (NULL), shmem (NULL),
+  shared_fc_hdl (NULL), shared_fc_handler (NULL)
 {
   pipe_name_buf[0] = L'\0';
   need_fork_fixup (true);
@@ -286,10 +291,9 @@ fhandler_fifo::wait_open_pipe (HANDLE& ph)
 }
 
 int
-fhandler_fifo::add_client_handler ()
+fhandler_fifo::add_client_handler (bool new_pipe_instance)
 {
   fifo_client_handler fc;
-  HANDLE ph = NULL;
 
   if (nhandlers >= shandlers)
     {
@@ -303,11 +307,14 @@ fhandler_fifo::add_client_handler ()
 	}
       fc_handler = (fifo_client_handler *) temp;
     }
-  ph = create_pipe_instance ();
-  if (!ph)
-    return -1;
-  fc.h = ph;
-  fc.state = fc_listening;
+  if (new_pipe_instance)
+    {
+      HANDLE ph = create_pipe_instance ();
+      if (!ph)
+	return -1;
+      fc.h = ph;
+      fc.state = fc_listening;
+    }
   fc_handler[nhandlers++] = fc;
   return 0;
 }
@@ -321,6 +328,21 @@ fhandler_fifo::delete_client_handler (int i)
 	     (nhandlers - i) * sizeof (fc_handler[i]));
 }
 
+/* Delete invalid handlers. */
+void
+fhandler_fifo::cleanup_handlers ()
+{
+  int i = 0;
+
+  while (i < nhandlers)
+    {
+      if (fc_handler[i].state < fc_connected)
+	delete_client_handler (i);
+      else
+	i++;
+    }
+}
+
 void
 fhandler_fifo::record_connection (fifo_client_handler& fc,
 				  fifo_client_connect_state s)
@@ -331,6 +353,65 @@ fhandler_fifo::record_connection (fifo_client_handler& fc,
   set_pipe_non_blocking (fc.h, true);
 }
 
+/* Called from fifo_reader_thread_func with owner_lock in place. */
+int
+fhandler_fifo::update_my_handlers ()
+{
+  close_all_handlers ();
+  fifo_reader_id_t prev = get_prev_owner ();
+  if (!prev)
+    {
+      debug_printf ("No previous owner to copy handles from");
+      return 0;
+    }
+  HANDLE prev_proc;
+  if (prev.winpid == me.winpid)
+    prev_proc =  GetCurrentProcess ();
+  else
+    prev_proc = OpenProcess (PROCESS_DUP_HANDLE, false, prev.winpid);
+  if (!prev_proc)
+    {
+      debug_printf ("Can't open process of previous owner, %E");
+      __seterrno ();
+      return -1;
+    }
+
+  for (int i = 0; i < get_shared_nhandlers (); i++)
+    {
+      /* Should never happen. */
+      if (shared_fc_handler[i].state != fc_connected)
+	continue;
+      if (add_client_handler (false) < 0)
+	api_fatal ("Can't add client handler, %E");
+      fifo_client_handler &fc = fc_handler[nhandlers - 1];
+      if (!DuplicateHandle (prev_proc, shared_fc_handler[i].h,
+			    GetCurrentProcess (), &fc.h, 0,
+			    !close_on_exec (), DUPLICATE_SAME_ACCESS))
+	{
+	  debug_printf ("Can't duplicate handle of previous owner, %E");
+	  --nhandlers;
+	  __seterrno ();
+	  return -1;
+	}
+      fc.state = fc_connected;
+    }
+  return 0;
+}
+
+int
+fhandler_fifo::update_shared_handlers ()
+{
+  cleanup_handlers ();
+  if (nhandlers > get_shared_shandlers ())
+    {
+      if (remap_shared_fc_handler (nhandlers * sizeof (fc_handler[0])) < 0)
+	return -1;
+    }
+  set_shared_nhandlers (nhandlers);
+  memcpy (shared_fc_handler, fc_handler, nhandlers * sizeof (fc_handler[0]));
+  return 0;
+}
+
 static DWORD WINAPI
 fifo_reader_thread (LPVOID param)
 {
@@ -355,6 +436,8 @@ fhandler_fifo::fifo_reader_thread_func ()
       if (!cur_owner)
 	{
 	  set_owner (me);
+	  if (update_my_handlers () < 0)
+	    api_fatal ("Can't update my handlers, %E");
 	  owner_unlock ();
 	  continue;
 	}
@@ -368,19 +451,7 @@ fhandler_fifo::fifo_reader_thread_func ()
 	{
 	  /* I'm the owner */
 	  fifo_client_lock ();
-
-	  /* Cleanup the fc_handler list. */
-	  fifo_client_lock ();
-	  int i = 0;
-	  while (i < nhandlers)
-	    {
-	      if (fc_handler[i].state < fc_connected)
-		delete_client_handler (i);
-	      else
-		i++;
-	    }
-
-	  /* Create a new client handler. */
+	  cleanup_handlers ();
 	  if (add_client_handler () < 0)
 	    api_fatal ("Can't add a client handler, %E");
 
@@ -391,6 +462,7 @@ fhandler_fifo::fifo_reader_thread_func ()
 	  NTSTATUS status;
 	  IO_STATUS_BLOCK io;
 	  bool cancel = false;
+	  bool update = false;
 
 	  status = NtFsControlFile (fc.h, conn_evt, NULL, NULL, &io,
 				    FSCTL_PIPE_LISTEN, NULL, 0, NULL, 0);
@@ -407,6 +479,7 @@ fhandler_fifo::fifo_reader_thread_func ()
 		case WAIT_OBJECT_0 + 1:
 		  status = STATUS_THREAD_IS_TERMINATING;
 		  cancel = true;
+		  update = true;
 		  break;
 		default:
 		  api_fatal ("WFMO failed, %E");
@@ -459,6 +532,8 @@ fhandler_fifo::fifo_reader_thread_func ()
 	  fifo_client_unlock ();
 	  if (ph)
 	    NtClose (ph);
+	  if (update && update_shared_handlers () < 0)
+	    api_fatal ("Can't update shared handlers, %E");
 	  if (cancel)
 	    goto canceled;
 	}
@@ -532,6 +607,100 @@ fhandler_fifo::reopen_shmem ()
   return 0;
 }
 
+/* On first creation, map and commit one page of memory. */
+int
+fhandler_fifo::create_shared_fc_handler ()
+{
+  HANDLE sect;
+  OBJECT_ATTRIBUTES attr;
+  NTSTATUS status;
+  LARGE_INTEGER size
+    = { .QuadPart = (LONGLONG) (SH_FC_HANDLER_PAGES * wincap.page_size ()) };
+  SIZE_T viewsize = get_shared_fc_handler_committed () ?: wincap.page_size ();
+  PVOID addr = NULL;
+  UNICODE_STRING uname;
+  WCHAR shared_fc_name[MAX_PATH];
+
+  __small_swprintf (shared_fc_name, L"fifo-shared-fc.%08x.%016X", get_dev (),
+		    get_ino ());
+  RtlInitUnicodeString (&uname, shared_fc_name);
+  InitializeObjectAttributes (&attr, &uname, OBJ_INHERIT,
+			      get_shared_parent_dir (), NULL);
+  status = NtCreateSection (&sect, STANDARD_RIGHTS_REQUIRED | SECTION_QUERY
+			    | SECTION_MAP_READ | SECTION_MAP_WRITE, &attr,
+			    &size, PAGE_READWRITE, SEC_RESERVE, NULL);
+  if (status == STATUS_OBJECT_NAME_COLLISION)
+    status = NtOpenSection (&sect, STANDARD_RIGHTS_REQUIRED | SECTION_QUERY
+			    | SECTION_MAP_READ | SECTION_MAP_WRITE, &attr);
+  if (!NT_SUCCESS (status))
+    {
+      __seterrno_from_nt_status (status);
+      return -1;
+    }
+  status = NtMapViewOfSection (sect, NtCurrentProcess (), &addr, 0, viewsize,
+			       NULL, &viewsize, ViewShare, 0, PAGE_READWRITE);
+  if (!NT_SUCCESS (status))
+    {
+      NtClose (sect);
+      __seterrno_from_nt_status (status);
+      return -1;
+    }
+  shared_fc_hdl = sect;
+  shared_fc_handler = (fifo_client_handler *) addr;
+  if (!get_shared_fc_handler_committed ())
+    set_shared_fc_handler_committed (viewsize);
+  set_shared_shandlers (viewsize / sizeof (fifo_client_handler));
+  return 0;
+}
+
+/* shared_fc_hdl must be valid when this is called. */
+int
+fhandler_fifo::reopen_shared_fc_handler ()
+{
+  NTSTATUS status;
+  SIZE_T viewsize = get_shared_fc_handler_committed ();
+  PVOID addr = NULL;
+
+  status = NtMapViewOfSection (shared_fc_hdl, NtCurrentProcess (),
+			       &addr, 0, viewsize, NULL, &viewsize,
+			       ViewShare, 0, PAGE_READWRITE);
+  if (!NT_SUCCESS (status))
+    {
+      __seterrno_from_nt_status (status);
+      return -1;
+    }
+  shared_fc_handler = (fifo_client_handler *) addr;
+  return 0;
+}
+
+int
+fhandler_fifo::remap_shared_fc_handler (size_t nbytes)
+{
+  NTSTATUS status;
+  SIZE_T viewsize = roundup2 (nbytes, wincap.page_size ());
+  PVOID addr = NULL;
+
+  if (viewsize > SH_FC_HANDLER_PAGES * wincap.page_size ())
+    {
+      set_errno (ENOMEM);
+      return -1;
+    }
+
+  NtUnmapViewOfSection (NtCurrentProcess (), shared_fc_handler);
+  status = NtMapViewOfSection (shared_fc_hdl, NtCurrentProcess (),
+			       &addr, 0, viewsize, NULL, &viewsize,
+			       ViewShare, 0, PAGE_READWRITE);
+  if (!NT_SUCCESS (status))
+    {
+      __seterrno_from_nt_status (status);
+      return -1;
+    }
+  shared_fc_handler = (fifo_client_handler *) addr;
+  set_shared_fc_handler_committed (viewsize);
+  set_shared_shandlers (viewsize / sizeof (fc_handler[0]));
+  return 0;
+}
+
 int
 fhandler_fifo::open (int flags, mode_t)
 {
@@ -599,6 +768,8 @@ fhandler_fifo::open (int flags, mode_t)
       SetEvent (read_ready);
       if (create_shmem () < 0)
 	goto err_close_writer_opening;
+      if (create_shared_fc_handler () < 0)
+	goto err_close_shmem;
       inc_nreaders ();
       if (!(cancel_evt = create_event ()))
 	goto err_dec_nreaders;
@@ -724,7 +895,10 @@ err_close_cancel_evt:
 err_dec_nreaders:
   if (dec_nreaders () == 0)
     ResetEvent (read_ready);
-/* err_close_shmem: */
+/* err_close_shared_fc_handler: */
+  NtUnmapViewOfSection (NtCurrentProcess (), shared_fc_handler);
+  NtClose (shared_fc_hdl);
+err_close_shmem:
   NtUnmapViewOfSection (NtCurrentProcess (), shmem);
   NtClose (shmem_handle);
 err_close_writer_opening:
@@ -1012,6 +1186,14 @@ fhandler_fifo::fstatvfs (struct statvfs *sfs)
   return fh.fstatvfs (sfs);
 }
 
+void
+fhandler_fifo::close_all_handlers ()
+{
+  for (int i = 0; i < nhandlers; i++)
+    fc_handler[i].close ();
+  nhandlers = 0;
+}
+
 int
 fifo_client_handler::pipe_state ()
 {
@@ -1062,6 +1244,10 @@ fhandler_fifo::close ()
 	NtUnmapViewOfSection (NtCurrentProcess (), shmem);
       if (shmem_handle)
 	NtClose (shmem_handle);
+      if (shared_fc_handler)
+	NtUnmapViewOfSection (NtCurrentProcess (), shared_fc_handler);
+      if (shared_fc_hdl)
+	NtClose (shared_fc_hdl);
     }
   if (read_ready)
     NtClose (read_ready);
@@ -1069,8 +1255,7 @@ fhandler_fifo::close ()
     NtClose (write_ready);
   if (writer_opening)
     NtClose (writer_opening);
-  for (int i = 0; i < nhandlers; i++)
-    fc_handler[i].close ();
+  close_all_handlers ();
   if (fc_handler)
     free (fc_handler);
   return fhandler_base::close ();
@@ -1144,8 +1329,17 @@ fhandler_fifo::dup (fhandler_base *child, int flags)
 	}
       if (fhf->reopen_shmem () < 0)
 	goto err_close_shmem_handle;
+      if (!DuplicateHandle (GetCurrentProcess (), shared_fc_hdl,
+			    GetCurrentProcess (), &fhf->shared_fc_hdl,
+			    0, !(flags & O_CLOEXEC), DUPLICATE_SAME_ACCESS))
+	{
+	  __seterrno ();
+	  goto err_close_shmem;
+	}
+      if (fhf->reopen_shared_fc_handler () < 0)
+	goto err_close_shared_fc_hdl;
       if (!(fhf->cancel_evt = create_event ()))
-	goto err_close_shmem;
+	goto err_close_shared_fc_handler;
       if (!(fhf->thr_sync_evt = create_event ()))
 	goto err_close_cancel_evt;
       inc_nreaders ();
@@ -1155,6 +1349,10 @@ fhandler_fifo::dup (fhandler_base *child, int flags)
   return 0;
 err_close_cancel_evt:
   NtClose (fhf->cancel_evt);
+err_close_shared_fc_handler:
+  NtUnmapViewOfSection (GetCurrentProcess (), fhf->shared_fc_handler);
+err_close_shared_fc_hdl:
+  NtClose (fhf->shared_fc_hdl);
 err_close_shmem:
   NtUnmapViewOfSection (GetCurrentProcess (), fhf->shmem);
 err_close_shmem_handle:
@@ -1184,6 +1382,9 @@ fhandler_fifo::fixup_after_fork (HANDLE parent)
       fork_fixup (parent, shmem_handle, "shmem_handle");
       if (reopen_shmem () < 0)
 	api_fatal ("Can't reopen shared memory during fork, %E");
+      fork_fixup (parent, shared_fc_hdl, "shared_fc_hdl");
+      if (reopen_shared_fc_handler () < 0)
+	api_fatal ("Can't reopen shared fc_handler memory during fork, %E");
       if (close_on_exec ())
 	/* Prevent a later attempt to close the non-inherited
 	   pipe-instance handles copied from the parent. */
@@ -1209,6 +1410,8 @@ fhandler_fifo::fixup_after_exec ()
 
       if (reopen_shmem () < 0)
 	api_fatal ("Can't reopen shared memory during exec, %E");
+      if (reopen_shared_fc_handler () < 0)
+	api_fatal ("Can't reopen shared fc_handler memory during exec, %E");
       fc_handler = NULL;
       nhandlers = shandlers = 0;
       me.winpid = GetCurrentProcessId ();
-- 
2.21.0

