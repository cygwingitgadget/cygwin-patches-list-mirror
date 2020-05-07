Return-Path: <kbrown@cornell.edu>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770093.outbound.protection.outlook.com [40.107.77.93])
 by sourceware.org (Postfix) with ESMTPS id D655E397280B
 for <cygwin-patches@cygwin.com>; Thu,  7 May 2020 20:22:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D655E397280B
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3htb1svugBHjFUSQe7oTZG/HaGUNVQTA21u7PqHPPdvcTI4fo6xUrR5tkDIlgOSHSLbronKN3Oqb0zVMCPgRcNTupJJXdb30NLH3/oDdBvAIAlsBResM9XgzWeJBJYM+YkXNvDG8+xgFEth/6GQW/tRxHTj5amZPVSiodbp/szFFrWHQ+6YwGptxTz9+VsWgvx5F7RJAI02/edMaxl/4ABvz7iprE8CEyv2fkvR0NJHyG5tI/kJEigvo+5Vh9+eBwDUxy/4sMca+gV13S4/5wTFyql/JL3NFAJHA2YIy7RJy3khHNgHuwdXmM8nn4vYIyK/5X9aIVB/+W/qtu6aBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MeQEBl+15H/uSxllAUK9IefCJKlrWXTN/KnzpWL1/tk=;
 b=QJVCFZgiVNpfZ16So3D4tUHw3H42ZRG4sRp7l9KZBTvyA1nRx/K/N8spboTrtrQwV5ctBo6Liwv17+5Kfm8gnVOzvTpYVjGTJ/uv/j4o7WSBY1ZDMGOPT71SwXzT2Xmqh9MvfPuNQoztvbV1SvRkTIiWs99hdRR/zN1KU76MeO+C6MIQFAY18fOIqzOccM1+HsA+ek+G4a1dUXI1AjenGhH0N2pR05k0CtRgcLF64CPKcrkF9FoGBJORUQSxM1GPueBXN7iSf61zAY18fmPWj+8G7X2zJu+xA/wwZOv64D/B1tXHUcfH/Qt1Hqfbb+z/e6Ezf6G3LfBtm4n/bZfZUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from DM6PR04MB6075.namprd04.prod.outlook.com (2603:10b6:5:127::31)
 by DM6PR04MB6075.namprd04.prod.outlook.com (2603:10b6:5:127::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Thu, 7 May
 2020 20:21:54 +0000
Received: from DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4]) by DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4%4]) with mapi id 15.20.2979.025; Thu, 7 May 2020
 20:21:54 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Cc: sten.kristian.ivarsson@gmail.com
Subject: [PATCH 14/21] Cygwin: FIFO: designate one reader as owner
Date: Thu,  7 May 2020 16:21:17 -0400
Message-Id: <20200507202124.1463-15-kbrown@cornell.edu>
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
 15.20.2979.28 via Frontend Transport; Thu, 7 May 2020 20:21:53 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [2604:6000:b407:7f00:e532:58da:20b8:9136]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e9d30d1-0105-49d9-737f-08d7f2c44892
X-MS-TrafficTypeDiagnostic: DM6PR04MB6075:
X-Microsoft-Antispam-PRVS: <DM6PR04MB6075E668D157BF01578077D9D8A50@DM6PR04MB6075.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bRy+ULNpfd/5vTaVIMSsuA6VDrh3jENcj8F/9GgEa7L8tWpYwwGEKpQDZBwzs+rGNYu4y70Ug0+lkBi3A53M4cAw+8UBLSuuKogf9BrgPreLABRCU7bHYXxbS/5Ts2ffYOybM5Hwv9SCMT2f6YubIOvsYiTOGHkYc8rhHMWitheMMdNsfU83MCa071faIyBbwIqEJXnjVWu7Y2+ha0Yj7g3HavZhujw/9alJ+wm6HEWZ8BI3I5kPhBtPEo9iebDvIeYUv5v25n8B0kHD7rGKxAt42V0Iluba/fbItJVfR+vMKqm2YoLp3ha7w1MTOhbKN5u1JaWZqWgeewmxqVx2rut0ABkbMbnCzZm0nSPkQbgogHCEK84prY3GsTj3O+Rdr88+WN9HhWVs3bcGnpX2kx2wNqf+EmvQJox1qeJJcyeqodXZC7QR+V/b9abnKXXs7fWSHTJQ5PDmkyscP01cNeEAIkq0srEh22nLi/bVu+qHjr8GXXYE/0vVQMHcfnE8lwnzh7UiBdIOYDKq9wSD2ySYCcO19nNrolXWhmuWDux1yZN2Tb8nvntT4bdf32We
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6075.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(33430700001)(33440700001)(6512007)(6486002)(478600001)(786003)(8676002)(66946007)(1076003)(5660300002)(8936002)(83300400001)(66476007)(316002)(83320400001)(83280400001)(83310400001)(83290400001)(66556008)(69590400007)(75432002)(36756003)(2616005)(4326008)(86362001)(6666004)(2906002)(6916009)(30864003)(186003)(6506007)(16526019)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 6jL6kebbxxgtmr+3TGQtF10TU2WCwt+mMJZbt06sBOku/OMwtM43YqH98ID6Sj56x1dPCZvNAaNjPIXjFUaoFjMlG7i9XSykwPEO7jcFHefj9X9KfkKcN9DAzSl17FYuKEbuS3Zx1MNd9alMzSOnuqX3rQpD/bDUwFt30cqz+rk/XSTPz90/4MjaNhNiNpKfaFvUaeycZqMjOjwnFIN5xfVL7vKmvRfZ0AqgHGPqqScmswxUd+P0NLNElN4WJT4iM0scy8Amf3fkrbZ7x6ositHiXSassMbLksojEUXytNTR+nOsC75bJdNB7svmA+Ise3KYMq3mMkxjN0R4gHqkqmMgxIuR46J8rwDX3DJfd9qBNrlelGlqWQLiJw9D5f/T211ofLQhYriqYBHCM9FinE7WT9r3WQYTu3zXP0xxDITg4SkU1N4cLajmkZeO8GKTo7z8aLEXooxZvVBoAoVlnJGpqUgHj1h2xC0HlEKstNGtHm3OsEeYkjQb6vyV9o0AnVM89+3lOOkowt1uUUVPUGj/DfxM0NqPdXXw6JZYdogAYYWrh+MyDPJ7Na3LDnC19kUR3q1DPTwEWhT6nZVtBEsjROEzb5Y1fIXaKGn6UtzEowEthvA5C+Sak4ppWmyTOODNonZ4oLNs7P0UYlTqChXKMUkZakVfloD9Ar8RQGknqXcrd7Faed6FSJiY5jC88+SgkQVGvACsqpzSnxKJP5d8l0RX+rPFF8cDtdiV4BAQ6jUea8pV7BmviTMifkNwc7zGOklervGNLkLh5ab/GXvAjcasOeUD/OhJUCOOHSMjURfprfz/t6baHNEYLeD3xGWjk+yoc8jpwuXmJYTrPrR1kDcyelxQTyLR6AJTXJSLi2equU+TSbKO0scnmbt3
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9d30d1-0105-49d9-737f-08d7f2c44892
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 20:21:54.4651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O4cEWG1pj504wIZsS6ke3Lg8Ed6CdZSyBQFXAKlAqh3/UqgX6VkVfNVbqW0IehG8TSxmdWpx64XV2HR6JQWFqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6075
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, JMQ_SPF_NEUTRAL,
 MSGID_FROM_MTA_HEADER, RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS,
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

Among all the open readers of a FIFO, one is declared to be the owner.
This is the only reader that listens for client connections, and it is
the only one that has an accurate fc_handler list.

Add shared data and methods for getting and setting the owner, as well
as a lock to prevent more than one reader from accessing these data
simultaneously.

Modify the fifo_reader_thread so that it checks the owner at the
beginning of its loop.  If there is no owner, it takes ownership.  If
there is an owner but it is a different reader, the thread just waits
to be canceled.  Otherwise, it listens for client connections as
before.

Remove the 'first' argument from create_pipe_instance.  It is not
needed, and it may be confusing in the future since only the owner
knows whether a pipe instance is the first.

When opening a reader, don't return until the fifo_reader_thread has
time to set an owner.

If the owner closes, indicate that there is no longer an owner.

Clear the child's fc_handler list in dup, and don't bother duplicating
the handles.  The child never starts out as owner, so it can't use
those handles.

Do the same thing in fixup_after_fork in the close-on-exec case.  In
the non-close-on-exec case, the child inherits an fc_handler list that
it can't use, but we can just leave it alone; the handles will be
closed when the child is closed.
---
 winsup/cygwin/fhandler.h       |  13 +-
 winsup/cygwin/fhandler_fifo.cc | 237 ++++++++++++++++++---------------
 2 files changed, 141 insertions(+), 109 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 65aab4da3..bd44da5cd 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1324,10 +1324,17 @@ struct fifo_reader_id_t
 class fifo_shmem_t
 {
   LONG _nreaders;
+  fifo_reader_id_t _owner;
+  af_unix_spinlock_t _owner_lock;
 
 public:
   int inc_nreaders () { return (int) InterlockedIncrement (&_nreaders); }
   int dec_nreaders () { return (int) InterlockedDecrement (&_nreaders); }
+
+  fifo_reader_id_t get_owner () const { return _owner; }
+  void set_owner (fifo_reader_id_t fr_id) { _owner = fr_id; }
+  void owner_lock () { _owner_lock.lock (); }
+  void owner_unlock () { _owner_lock.unlock (); }
 };
 
 class fhandler_fifo: public fhandler_base
@@ -1356,7 +1363,7 @@ class fhandler_fifo: public fhandler_base
 
   bool __reg2 wait (HANDLE);
   static NTSTATUS npfs_handle (HANDLE &);
-  HANDLE create_pipe_instance (bool);
+  HANDLE create_pipe_instance ();
   NTSTATUS open_pipe (HANDLE&);
   NTSTATUS wait_open_pipe (HANDLE&);
   int add_client_handler ();
@@ -1384,6 +1391,10 @@ public:
   void fifo_client_unlock () { _fifo_client_lock.unlock (); }
 
   fifo_reader_id_t get_me () const { return me; }
+  fifo_reader_id_t get_owner () const { return shmem->get_owner (); }
+  void set_owner (fifo_reader_id_t fr_id) { shmem->set_owner (fr_id); }
+  void owner_lock () { shmem->owner_lock (); }
+  void owner_unlock () { shmem->owner_unlock (); }
 
   int open (int, mode_t);
   off_t lseek (off_t offset, int whence);
diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index 5676a2c97..0b9b33785 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -164,7 +164,7 @@ fhandler_fifo::npfs_handle (HANDLE &nph)
    blocking mode so that we can easily wait for a connection.  After
    it is connected, it is put in nonblocking mode. */
 HANDLE
-fhandler_fifo::create_pipe_instance (bool first)
+fhandler_fifo::create_pipe_instance ()
 {
   NTSTATUS status;
   HANDLE npfsh;
@@ -187,14 +187,12 @@ fhandler_fifo::create_pipe_instance (bool first)
   access = GENERIC_READ | FILE_READ_ATTRIBUTES | FILE_WRITE_ATTRIBUTES
     | SYNCHRONIZE;
   sharing = FILE_SHARE_READ | FILE_SHARE_WRITE;
-  hattr = openflags & O_CLOEXEC ? 0 : OBJ_INHERIT;
-  if (first)
-    hattr |= OBJ_CASE_INSENSITIVE;
+  hattr = (openflags & O_CLOEXEC ? 0 : OBJ_INHERIT) | OBJ_CASE_INSENSITIVE;
   InitializeObjectAttributes (&attr, get_pipe_name (),
 			      hattr, npfsh, NULL);
   timeout.QuadPart = -500000;
   status = NtCreateNamedPipeFile (&ph, access, &attr, &io, sharing,
-				  first ? FILE_CREATE : FILE_OPEN, 0,
+				  FILE_OPEN_IF, 0,
 				  FILE_PIPE_MESSAGE_TYPE
 				    | FILE_PIPE_REJECT_REMOTE_CLIENTS,
 				  FILE_PIPE_MESSAGE_MODE,
@@ -292,14 +290,13 @@ fhandler_fifo::add_client_handler ()
   int ret = -1;
   fifo_client_handler fc;
   HANDLE ph = NULL;
-  bool first = (nhandlers == 0);
 
   if (nhandlers == MAX_CLIENTS)
     {
       set_errno (EMFILE);
       goto out;
     }
-  ph = create_pipe_instance (first);
+  ph = create_pipe_instance ();
   if (!ph)
     goto out;
   else
@@ -349,92 +346,120 @@ fhandler_fifo::fifo_reader_thread_func ()
 
   while (1)
     {
-      /* Cleanup the fc_handler list. */
-      fifo_client_lock ();
-      int i = 0;
-      while (i < nhandlers)
+      fifo_reader_id_t cur_owner;
+
+      owner_lock ();
+      cur_owner = get_owner ();
+      if (!cur_owner)
 	{
-	  if (fc_handler[i].state < fc_connected)
-	    delete_client_handler (i);
-	  else
-	    i++;
+	  set_owner (me);
+	  owner_unlock ();
+	  continue;
+	}
+      else if (cur_owner != me)
+	{
+	  owner_unlock ();
+	  WaitForSingleObject (cancel_evt, INFINITE);
+	  goto canceled;
 	}
+      else
+	{
+	  /* I'm the owner */
+	  fifo_client_lock ();
 
-      /* Create a new client handler. */
-      if (add_client_handler () < 0)
-	api_fatal ("Can't add a client handler, %E");
+	  /* Cleanup the fc_handler list. */
+	  fifo_client_lock ();
+	  int i = 0;
+	  while (i < nhandlers)
+	    {
+	      if (fc_handler[i].state < fc_connected)
+		delete_client_handler (i);
+	      else
+		i++;
+	    }
 
-      /* Listen for a writer to connect to the new client handler. */
-      fifo_client_handler& fc = fc_handler[nhandlers - 1];
-      fifo_client_unlock ();
-      NTSTATUS status;
-      IO_STATUS_BLOCK io;
-      bool cancel = false;
+	  /* Create a new client handler. */
+	  if (add_client_handler () < 0)
+	    api_fatal ("Can't add a client handler, %E");
 
-      status = NtFsControlFile (fc.h, conn_evt, NULL, NULL, &io,
-				FSCTL_PIPE_LISTEN, NULL, 0, NULL, 0);
-      if (status == STATUS_PENDING)
-	{
-	  HANDLE w[2] = { conn_evt, cancel_evt };
-	  switch (WaitForMultipleObjects (2, w, false, INFINITE))
+	  /* Listen for a writer to connect to the new client handler. */
+	  fifo_client_handler& fc = fc_handler[nhandlers - 1];
+	  fifo_client_unlock ();
+	  owner_unlock ();
+	  NTSTATUS status;
+	  IO_STATUS_BLOCK io;
+	  bool cancel = false;
+
+	  status = NtFsControlFile (fc.h, conn_evt, NULL, NULL, &io,
+				    FSCTL_PIPE_LISTEN, NULL, 0, NULL, 0);
+	  if (status == STATUS_PENDING)
 	    {
-	    case WAIT_OBJECT_0:
-	      status = io.Status;
+	      HANDLE w[2] = { conn_evt, cancel_evt };
+	      switch (WaitForMultipleObjects (2, w, false, INFINITE))
+		{
+		case WAIT_OBJECT_0:
+		  status = io.Status;
+		  debug_printf ("NtFsControlFile STATUS_PENDING, then %y",
+				status);
+		  break;
+		case WAIT_OBJECT_0 + 1:
+		  status = STATUS_THREAD_IS_TERMINATING;
+		  cancel = true;
+		  break;
+		default:
+		  api_fatal ("WFMO failed, %E");
+		}
+	    }
+	  else
+	    debug_printf ("NtFsControlFile status %y, no STATUS_PENDING",
+			  status);
+	  HANDLE ph = NULL;
+	  NTSTATUS status1;
+
+	  fifo_client_lock ();
+	  switch (status)
+	    {
+	    case STATUS_SUCCESS:
+	    case STATUS_PIPE_CONNECTED:
+	      record_connection (fc);
 	      break;
-	    case WAIT_OBJECT_0 + 1:
-	      status = STATUS_THREAD_IS_TERMINATING;
-	      cancel = true;
+	    case STATUS_PIPE_CLOSING:
+	      record_connection (fc, fc_closing);
+	      break;
+	    case STATUS_THREAD_IS_TERMINATING:
+	      /* Try to connect a bogus client.  Otherwise fc is still
+		 listening, and the next connection might not get recorded. */
+	      status1 = open_pipe (ph);
+	      WaitForSingleObject (conn_evt, INFINITE);
+	      if (NT_SUCCESS (status1))
+		/* Bogus cilent connected. */
+		delete_client_handler (nhandlers - 1);
+	      else
+		/* Did a real client connect? */
+		switch (io.Status)
+		  {
+		  case STATUS_SUCCESS:
+		  case STATUS_PIPE_CONNECTED:
+		    record_connection (fc);
+		    break;
+		  case STATUS_PIPE_CLOSING:
+		    record_connection (fc, fc_closing);
+		    break;
+		  default:
+		    debug_printf ("NtFsControlFile status %y after failing to connect bogus client or real client", io.Status);
+		    fc.state = fc_unknown;
+		    break;
+		  }
 	      break;
 	    default:
-	      api_fatal ("WFMO failed, %E");
+	      break;
 	    }
+	  fifo_client_unlock ();
+	  if (ph)
+	    NtClose (ph);
+	  if (cancel)
+	    goto canceled;
 	}
-      HANDLE ph = NULL;
-      NTSTATUS status1;
-
-      fifo_client_lock ();
-      switch (status)
-	{
-	case STATUS_SUCCESS:
-	case STATUS_PIPE_CONNECTED:
-	  record_connection (fc);
-	  break;
-	case STATUS_PIPE_CLOSING:
-	  record_connection (fc, fc_closing);
-	  break;
-	case STATUS_THREAD_IS_TERMINATING:
-	  /* Try to connect a bogus client.  Otherwise fc is still
-	     listening, and the next connection might not get recorded. */
-	  status1 = open_pipe (ph);
-	  WaitForSingleObject (conn_evt, INFINITE);
-	  if (NT_SUCCESS (status1))
-	    /* Bogus cilent connected. */
-	    delete_client_handler (nhandlers - 1);
-	  else
-	    /* Did a real client connect? */
-	    switch (io.Status)
-	      {
-	      case STATUS_SUCCESS:
-	      case STATUS_PIPE_CONNECTED:
-		record_connection (fc);
-		break;
-	      case STATUS_PIPE_CLOSING:
-		record_connection (fc, fc_closing);
-		break;
-	      default:
-		debug_printf ("NtFsControlFile status %y after failing to connect bogus client or real client", io.Status);
-		fc.state = fc_unknown;
-		break;
-	      }
-	  break;
-	default:
-	  break;
-	}
-      fifo_client_unlock ();
-      if (ph)
-	NtClose (ph);
-      if (cancel)
-	goto canceled;
     }
 canceled:
   if (conn_evt)
@@ -580,6 +605,15 @@ fhandler_fifo::open (int flags, mode_t)
       me.winpid = GetCurrentProcessId ();
       me.fh = this;
       new cygthread (fifo_reader_thread, this, "fifo_reader", thr_sync_evt);
+      /* Wait until there's an owner. */
+      owner_lock ();
+      while (!get_owner ())
+	{
+	  owner_unlock ();
+	  yield ();
+	  owner_lock ();
+	}
+      owner_unlock ();
 
       /* If we're a duplexer, we need a handle for writing. */
       if (duplexer)
@@ -1014,6 +1048,10 @@ fhandler_fifo::close ()
       if (dec_nreaders () == 0)
 	ResetEvent (read_ready);
       cancel_reader_thread ();
+      owner_lock ();
+      if (get_owner () == me)
+	set_owner (null_fr_id);
+      owner_unlock ();
       if (cancel_evt)
 	NtClose (cancel_evt);
       if (thr_sync_evt)
@@ -1056,7 +1094,6 @@ fhandler_fifo::fcntl (int cmd, intptr_t arg)
 int
 fhandler_fifo::dup (fhandler_base *child, int flags)
 {
-  int i = 0;
   fhandler_fifo *fhf = NULL;
 
   if (get_flags () & O_PATH)
@@ -1092,6 +1129,9 @@ fhandler_fifo::dup (fhandler_base *child, int flags)
       /* Make sure the child starts unlocked. */
       fhf->fifo_client_unlock ();
 
+      /* Clear fc_handler list; the child never starts as owner. */
+      fhf->nhandlers = 0;
+
       if (!DuplicateHandle (GetCurrentProcess (), shmem_handle,
 			    GetCurrentProcess (), &fhf->shmem_handle,
 			    0, !(flags & O_CLOEXEC), DUPLICATE_SAME_ACCESS))
@@ -1101,25 +1141,8 @@ fhandler_fifo::dup (fhandler_base *child, int flags)
 	}
       if (fhf->reopen_shmem () < 0)
 	goto err_close_shmem_handle;
-      fifo_client_lock ();
-      for (i = 0; i < nhandlers; i++)
-	{
-	  if (!DuplicateHandle (GetCurrentProcess (), fc_handler[i].h,
-				GetCurrentProcess (), &fhf->fc_handler[i].h,
-				0, !(flags & O_CLOEXEC), DUPLICATE_SAME_ACCESS))
-	    {
-	      __seterrno ();
-	      break;
-	    }
-	}
-      if (i < nhandlers)
-	{
-	  fifo_client_unlock ();
-	  goto err_close_handlers;
-	}
-      fifo_client_unlock ();
       if (!(fhf->cancel_evt = create_event ()))
-	goto err_close_handlers;
+	goto err_close_shmem;
       if (!(fhf->thr_sync_evt = create_event ()))
 	goto err_close_cancel_evt;
       inc_nreaders ();
@@ -1129,9 +1152,7 @@ fhandler_fifo::dup (fhandler_base *child, int flags)
   return 0;
 err_close_cancel_evt:
   NtClose (fhf->cancel_evt);
-err_close_handlers:
-  for (int j = 0; j < i; j++)
-    fhf->fc_handler[j].close ();
+err_close_shmem:
   NtUnmapViewOfSection (GetCurrentProcess (), fhf->shmem);
 err_close_shmem_handle:
   NtClose (fhf->shmem_handle);
@@ -1160,10 +1181,10 @@ fhandler_fifo::fixup_after_fork (HANDLE parent)
       fork_fixup (parent, shmem_handle, "shmem_handle");
       if (reopen_shmem () < 0)
 	api_fatal ("Can't reopen shared memory during fork, %E");
-      fifo_client_lock ();
-      for (int i = 0; i < nhandlers; i++)
-	fork_fixup (parent, fc_handler[i].h, "fc_handler[].h");
-      fifo_client_unlock ();
+      if (close_on_exec ())
+	/* Prevent a later attempt to close the non-inherited
+	   pipe-instance handles copied from the parent. */
+	nhandlers = 0;
       if (!(cancel_evt = create_event ()))
 	api_fatal ("Can't create reader thread cancel event during fork, %E");
       if (!(thr_sync_evt = create_event ()))
-- 
2.21.0

