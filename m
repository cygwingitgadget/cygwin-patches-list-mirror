Return-Path: <kbrown@cornell.edu>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770133.outbound.protection.outlook.com [40.107.77.133])
 by sourceware.org (Postfix) with ESMTPS id AC13A396E86C
 for <cygwin-patches@cygwin.com>; Thu,  7 May 2020 20:21:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org AC13A396E86C
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/y+NJqNxXx/ygahSM0MvMJ6b1NkiXEAQqhVtzDqndrkP4fHe30t+jEp2kDp2RU3FvmziHzKfXUbiVXvV5tsPEkmZwoGmH11gLXEOh45zc8U4Jo8dHqBgcVQ01q0E6oq9kFazXxua2Ydcq1dP3TUKPvRsrd4G4v6VBBFqPLF1RngeZcmgqU6xCuLm+dx8Xtb4biWHxLOHcOLIXypgL8qXq6iGUhND0LtQuq/EE6jAJW3Ccy9n76871YIZMtZMMtKwNDlCzqrSK3k6I0s/mNDMyrC5zxT9kI8FOyI9NowRfORekILvPysidbGylpjdEsL+QILhpJDWRCeMjYdzSQoxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewVKPekPANohJL40elSzmzWLU0PMufMRe4Hg5GnPfds=;
 b=nQaXEKCqinvrf97lCOC/K40fJvpksf5veUlasOvllp6j+irhRBQPdPuN2zMMUIsgjgJAJQPS+v84BLvjuxCLF5v8KoducQ2Rznu1pgSbc59xlHL+S0iqP1y43uGjgq1K5HCuz14rMcoAHSL9HLvWfHKLzjapgtbyuhO1VahNqvUIhpaHibB8R+eGG1N9j4FM2aHw+3hgg1gE2JEXSzr2V7bDeQSoIMUamwUi/2kZyUCkn4z8fyPzaHdXZeripABZj9QvW4x2VgKbH+EzxEOTqdl2YEbSQCi2iRI5K8o7gZ8OQpyFwsfeqgtiEFX8v1n2XDFzjbwSxdfNiaC1by5QdA==
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
Subject: [PATCH 11/21] Cygwin: FIFO: add shared memory
Date: Thu,  7 May 2020 16:21:14 -0400
Message-Id: <20200507202124.1463-12-kbrown@cornell.edu>
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
 15.20.2979.28 via Frontend Transport; Thu, 7 May 2020 20:21:50 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [2604:6000:b407:7f00:e532:58da:20b8:9136]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54838dec-105e-4e7a-908f-08d7f2c4467a
X-MS-TrafficTypeDiagnostic: DM6PR04MB6075:
X-Microsoft-Antispam-PRVS: <DM6PR04MB6075E68C106279FCC6A9AA25D8A50@DM6PR04MB6075.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xz9CaqlWmkkDRNrrr/RlrU3oZCP7IZte50cE92jzKylKaqK9gzUb4Shzt+J89rXtMubDo6HGobqvET51hAopq/WGo6HvD8f1jDBKd0XK2VAl5c08iYC8P1Z9sI3SQ4jwI2fC5LPkAEpvOifciRm6cTzKU0RcHzfwzpGAQSTjIpYMlywb5z9acw9SqjcMyaPm3xwk+ApQ2we5pE/0T2IN4Oamf+GPQ6jmFSWspJeWWn6IuxuNt7c+pDK820lyO9jT7OOLVL0FAPgdWAz1fIRwws03gIDmbCBYdcdeiO45OUC3b+hYfGAZuUVgCbOMJCLVbBB+x6aU+MfIyINc6AdIecW4QgSQB2sf+2/LBwWLlJU4bD/rfwZuoSl+K0yVX/K1jZiUNHLvJbtSk2J8DTaSQrSwwUs1HUWjjraWLKc8yCPBuvNzaGVU1OlIqhj3HyVyyjU67k1eiAIfq6F9rNxx2HSEOiv2ebeUoq1BFkr+mO3sjy/AkoyuWejGt5W8AVtQ3iL1hgHw0t/LcBVjaxaQi/H331fiWTgd+fEKJ6g34kfymGfm2kwEWQ/ekQiv/aw2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6075.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(33430700001)(33440700001)(6512007)(6486002)(478600001)(786003)(8676002)(66946007)(1076003)(5660300002)(8936002)(83300400001)(66476007)(316002)(83320400001)(83280400001)(83310400001)(83290400001)(66556008)(69590400007)(75432002)(36756003)(2616005)(4326008)(86362001)(6666004)(2906002)(6916009)(186003)(6506007)(16526019)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 3xw+6vuTkRpq5Xnt3RRl9NOy4iXKNW2N08iBlVMAFLg0UoxFRKP3y901zmNzQODQ3HOB+vnK5DEJI96SdVtklotN7tuCJxbtpma4dvz0GNnTX/xkVRUc6UuAIt3SZOXR83O/0A6fPau0wmO1/jb8O/2udWcjvjDnIzvy/iclu2c9RjkIZlS267uiPZNYBmaBdaQ9rIBiXi80BZnebM8cha6R6Hb4hyx09H+7if4hsn915Drsbi7ltS8PNlDQYBwRevVvWFyEFH5bC5TgnzKNdoltpgAOprZwEuHlfNZIL2dDrXlaX4QmEOxQUWHotVAYjaXPv0e+GejCfGFbqQ4By939UnCDzjCrDm70mjgDwGkSZFLAhhMMYPBS873yRXjM92wURQmI2uPxzRs01KdWhShy/jnnfaljGqEfvKDDZccX3ImGg9WnNMArXi9DheRJulntS7Wu+WGlWVsWimRlMFcSroW+yybXe6aYkWZwbRlmHlhw7pzUMPiPu/ZG5afXRzGec/mOZHANUpGUySLHiivfaQj46UfuM1aLD3NqixXGXLxabfe3aYhTX+Kgqp4POhns0Ebqu1mXN0QpxKmLuyaviu2W6L9BU+EnLXkHc24schW/CZs3DduZys/us/xnHuQjToxu2FRCFKPwe92JM0j5ha4NjkTBXh2QB3G8NZs5dGxlO9zVZS0d+ZUCHGja/yHpwKvvlq+KATkx9f1NtMoNxGCGADwplZ8Tzn6Evwsd101E32jDbZBru2nUDLu3UKgew37xPAZ+Th4P6zji6dwgZDgPbpydfR4/CF+4s0O4iU6rlztOcImZMhBQMNkSfwv/IexL528IAKfHL4fk2ukOICJTbw8+CkSIcZjbpk5EQRjAWnVp7xQRU4mMc/+j
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 54838dec-105e-4e7a-908f-08d7f2c4467a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 20:21:50.8852 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wdqKJJ+9ZahjK/rFafCvaFjb6V7B+5f44YdfmvXasL/wf2ez2RzHz3yWiihyFliBz+jMpikwBlwdGnZf7sVk5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6075
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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

Even though we currently allow a FIFO to be opened for reading only
once, we can still have more than one reader open because of dup and
fork.  Add a named shared memory section accessible to all readers of
a given FIFO.  In future commits we will add information needed by all
readers to this section

Add a class fifo_shmem_t that lets us access this information.

Add a method create_shmem that is called when a reader opens, and add
a method reopen_shmem that is called by dup, fork, and exec.  (Each
new reader needs its own view of the shared memory.)
---
 winsup/cygwin/fhandler.h       | 13 +++++
 winsup/cygwin/fhandler_fifo.cc | 97 ++++++++++++++++++++++++++++++++--
 2 files changed, 106 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 5e6a1d1db..8d6b94021 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1300,6 +1300,11 @@ struct fifo_client_handler
   int pipe_state ();
 };
 
+/* Info needed by all readers of a FIFO, stored in named shared memory. */
+class fifo_shmem_t
+{
+};
+
 class fhandler_fifo: public fhandler_base
 {
   /* Handles to named events shared by all fhandlers for a given FIFO. */
@@ -1319,6 +1324,10 @@ class fhandler_fifo: public fhandler_base
   af_unix_spinlock_t _fifo_client_lock;
   bool reader, writer, duplexer;
   size_t max_atomic_write;
+
+  HANDLE shmem_handle;
+  fifo_shmem_t *shmem;
+
   bool __reg2 wait (HANDLE);
   static NTSTATUS npfs_handle (HANDLE &);
   HANDLE create_pipe_instance (bool);
@@ -1330,6 +1339,9 @@ class fhandler_fifo: public fhandler_base
   void record_connection (fifo_client_handler&,
 			  fifo_client_connect_state = fc_connected);
 
+  int create_shmem ();
+  int reopen_shmem ();
+
 public:
   fhandler_fifo ();
   bool hit_eof ();
@@ -1341,6 +1353,7 @@ public:
   DWORD fifo_reader_thread_func ();
   void fifo_client_lock () { _fifo_client_lock.lock (); }
   void fifo_client_unlock () { _fifo_client_lock.unlock (); }
+
   int open (int, mode_t);
   off_t lseek (off_t offset, int whence);
   int close ();
diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index 09a7eb321..9a0db3f33 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -70,7 +70,8 @@ fhandler_fifo::fhandler_fifo ():
   read_ready (NULL), write_ready (NULL), writer_opening (NULL),
   cancel_evt (NULL), thr_sync_evt (NULL), _maybe_eof (false), nhandlers (0),
   reader (false), writer (false), duplexer (false),
-  max_atomic_write (DEFAULT_PIPEBUFSIZE)
+  max_atomic_write (DEFAULT_PIPEBUFSIZE),
+  shmem_handle (NULL), shmem (NULL)
 {
   pipe_name_buf[0] = L'\0';
   need_fork_fixup (true);
@@ -441,6 +442,67 @@ canceled:
   return 0;
 }
 
+int
+fhandler_fifo::create_shmem ()
+{
+  HANDLE sect;
+  OBJECT_ATTRIBUTES attr;
+  NTSTATUS status;
+  LARGE_INTEGER size = { .QuadPart = sizeof (fifo_shmem_t) };
+  SIZE_T viewsize = sizeof (fifo_shmem_t);
+  PVOID addr = NULL;
+  UNICODE_STRING uname;
+  WCHAR shmem_name[MAX_PATH];
+
+  __small_swprintf (shmem_name, L"fifo-shmem.%08x.%016X", get_dev (),
+		    get_ino ());
+  RtlInitUnicodeString (&uname, shmem_name);
+  InitializeObjectAttributes (&attr, &uname, OBJ_INHERIT,
+			      get_shared_parent_dir (), NULL);
+  status = NtCreateSection (&sect, STANDARD_RIGHTS_REQUIRED | SECTION_QUERY
+			    | SECTION_MAP_READ | SECTION_MAP_WRITE,
+			    &attr, &size, PAGE_READWRITE, SEC_COMMIT, NULL);
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
+  shmem_handle = sect;
+  shmem = (fifo_shmem_t *) addr;
+  return 0;
+}
+
+/* shmem_handle must be valid when this is called. */
+int
+fhandler_fifo::reopen_shmem ()
+{
+  NTSTATUS status;
+  SIZE_T viewsize = sizeof (fifo_shmem_t);
+  PVOID addr = NULL;
+
+  status = NtMapViewOfSection (shmem_handle, NtCurrentProcess (), &addr,
+			       0, viewsize, NULL, &viewsize, ViewShare,
+			       0, PAGE_READWRITE);
+  if (!NT_SUCCESS (status))
+    {
+      __seterrno_from_nt_status (status);
+      return -1;
+    }
+  shmem = (fifo_shmem_t *) addr;
+  return 0;
+}
+
 int
 fhandler_fifo::open (int flags, mode_t)
 {
@@ -501,12 +563,15 @@ fhandler_fifo::open (int flags, mode_t)
       goto err_close_write_ready;
     }
 
-  /* If we're reading, signal read_ready and start the fifo_reader_thread. */
+  /* If we're reading, signal read_ready, create the shared memory,
+     and start the fifo_reader_thread. */
   if (reader)
     {
       SetEvent (read_ready);
-      if (!(cancel_evt = create_event ()))
+      if (create_shmem () < 0)
 	goto err_close_writer_opening;
+      if (!(cancel_evt = create_event ()))
+	goto err_close_shmem;
       if (!(thr_sync_evt = create_event ()))
 	goto err_close_cancel_evt;
       new cygthread (fifo_reader_thread, this, "fifo_reader", thr_sync_evt);
@@ -615,6 +680,9 @@ err_close_reader:
   return 0;
 err_close_cancel_evt:
   NtClose (cancel_evt);
+err_close_shmem:
+  NtUnmapViewOfSection (NtCurrentProcess (), shmem);
+  NtClose (shmem_handle);
 err_close_writer_opening:
   NtClose (writer_opening);
 err_close_write_ready:
@@ -944,6 +1012,10 @@ fhandler_fifo::close ()
 	 dup/fork/exec; we should only reset read_ready when the last
 	 one closes. */
       ResetEvent (read_ready);
+      if (shmem)
+	NtUnmapViewOfSection (NtCurrentProcess (), shmem);
+      if (shmem_handle)
+	NtClose (shmem_handle);
     }
   if (read_ready)
     NtClose (read_ready);
@@ -1014,6 +1086,15 @@ fhandler_fifo::dup (fhandler_base *child, int flags)
       /* Make sure the child starts unlocked. */
       fhf->fifo_client_unlock ();
 
+      if (!DuplicateHandle (GetCurrentProcess (), shmem_handle,
+			    GetCurrentProcess (), &fhf->shmem_handle,
+			    0, !(flags & O_CLOEXEC), DUPLICATE_SAME_ACCESS))
+	{
+	  __seterrno ();
+	  goto err_close_writer_opening;
+	}
+      if (fhf->reopen_shmem () < 0)
+	goto err_close_shmem_handle;
       fifo_client_lock ();
       for (i = 0; i < nhandlers; i++)
 	{
@@ -1044,7 +1125,10 @@ err_close_cancel_evt:
 err_close_handlers:
   for (int j = 0; j < i; j++)
     fhf->fc_handler[j].close ();
-/* err_close_writer_opening: */
+  NtUnmapViewOfSection (GetCurrentProcess (), fhf->shmem);
+err_close_shmem_handle:
+  NtClose (fhf->shmem_handle);
+err_close_writer_opening:
   NtClose (fhf->writer_opening);
 err_close_write_ready:
   NtClose (fhf->write_ready);
@@ -1066,6 +1150,9 @@ fhandler_fifo::fixup_after_fork (HANDLE parent)
       /* Make sure the child starts unlocked. */
       fifo_client_unlock ();
 
+      fork_fixup (parent, shmem_handle, "shmem_handle");
+      if (reopen_shmem () < 0)
+	api_fatal ("Can't reopen shared memory during fork, %E");
       fifo_client_lock ();
       for (int i = 0; i < nhandlers; i++)
 	fork_fixup (parent, fc_handler[i].h, "fc_handler[].h");
@@ -1087,6 +1174,8 @@ fhandler_fifo::fixup_after_exec ()
       /* Make sure the child starts unlocked. */
       fifo_client_unlock ();
 
+      if (reopen_shmem () < 0)
+	api_fatal ("Can't reopen shared memory during exec, %E");
       if (!(cancel_evt = create_event ()))
 	api_fatal ("Can't create reader thread cancel event during exec, %E");
       if (!(thr_sync_evt = create_event ()))
-- 
2.21.0

