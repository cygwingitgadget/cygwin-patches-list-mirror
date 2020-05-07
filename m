Return-Path: <kbrown@cornell.edu>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770133.outbound.protection.outlook.com [40.107.77.133])
 by sourceware.org (Postfix) with ESMTPS id 9ACBB396DC11
 for <cygwin-patches@cygwin.com>; Thu,  7 May 2020 20:21:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 9ACBB396DC11
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BN4Xvw3c8afaskq7eoL9sJ28k6vtTpFwrYpinSM6/hicRIe4iYSMwdyg2z8NRWSavoFi6X/u4qWiY72HhHQPeaoSLHLSDi8q8Y7QHqUYR0s8JuGkJOod/0zGrFfOFAK+OIC81Cvh3MM0W3c7aCxj6RrTHkUd2pnrCDbkBmwhew8U8gVmQC2tkAOyIeyCoZa5tbe/Z+x2mLWu25yR57ovLTui4ZePuUaFiJ7GZjK40oCEBYDvalH8IxoDddb0H9e0jynF4Forah5DhSb3FYe8YvR9waPlKooTgzC071/jIlj+hCYw3CRyjiTmfg/sShOEtDquOpqFNNPlyUpIevaVqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lblmTLKyGBLIxBpgs5xYnWoQSpWC31PMa0hlaIEn4GM=;
 b=Ncsa3Fz25qmfNhAmGIva4x45+2KpkiyYYqTvyLREkLL9J+RB6bbozazhDv6tM0cuL2KEkfCDgHyQb3r7OuILjJ5ijA9M83AVJ9evQzEwFMenUhRFzzQ23Ta3Ou3W+Em4NVTEA5B6Zs4/4UrHE3mp8fM4DDayBX4VyQdJtYWoaDzmAjw2NVXDnQlvKv5hTBSCGJROJV8jPL7J6plg6Tb0MXYPERzz/WKxIcgTFqQBj5Q4QvKCGzqbPeJCnbpWsMuFonfRCt7E5NfHZxMgOcQM+aAu3gupPIrjxUKOKQ252JTkpE1+43W98Feb6IOT3+W/iHdsoLZP+oh2rD/RezRsBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from DM6PR04MB6075.namprd04.prod.outlook.com (2603:10b6:5:127::31)
 by DM6PR04MB6075.namprd04.prod.outlook.com (2603:10b6:5:127::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Thu, 7 May
 2020 20:21:49 +0000
Received: from DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4]) by DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4%4]) with mapi id 15.20.2979.025; Thu, 7 May 2020
 20:21:49 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Cc: sten.kristian.ivarsson@gmail.com
Subject: [PATCH 09/21] Cygwin: FIFO: make opening a writer more robust
Date: Thu,  7 May 2020 16:21:12 -0400
Message-Id: <20200507202124.1463-10-kbrown@cornell.edu>
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
 15.20.2979.28 via Frontend Transport; Thu, 7 May 2020 20:21:48 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [2604:6000:b407:7f00:e532:58da:20b8:9136]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06b33399-e027-4ad5-e769-08d7f2c44582
X-MS-TrafficTypeDiagnostic: DM6PR04MB6075:
X-Microsoft-Antispam-PRVS: <DM6PR04MB60750BCA67248DED13F6BD91D8A50@DM6PR04MB6075.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a3YThW2O810DeSmlImlSvIJYV7Vs72a1SC7y2cRVVUreJ4X0eKNOiR7koTe8IwKVvmAHvKSbl7GVn6da9J1ZRKZoP1sOFpUryfTPWuCbZNuusHCiPnysueppB6GqftKIoYDJ/j+q2G5FWoAq/QdCY4mgCf65cBy6mfoFWHGpHp86vJX3FJTgWytGDROTLX4LogajqW0UFcsGr/kgqck6EWnQn8uO9tCAXbuNt5QLXvmlh+b0GOxqkTJP7QWcyPP40/aNRT9h+wYlh/frJKfDlIGoJt6jeApbeH4/hnW0RtSQPnyrQr5eHqXm1TYMlMjr+fELYWJzF/aUP1ZfRfkM9fcBsQGvVRp+dI9h+ts0MKexr7suJQNB7Q44qwXdXi4Rd0arYkyfMZFJbtu0oaS4MRhqTtKPvE0cVzZ8vc2I7nBJ0NAwcF4P7Dw3GQR8X0Fg/m+Os27wktr2Um1rLMwCrVct2mTVoJqp5GWRCxEjLgDRW3mDNHwGbVZvAa2nNZGFdeW9QgiU5ygRwPoy8I2oswTGnPuJWWV2fUAw1lJxNHDFy5yQtjJQaImWS62vyZoh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6075.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(33430700001)(33440700001)(6512007)(6486002)(478600001)(786003)(8676002)(66946007)(1076003)(5660300002)(8936002)(83300400001)(66476007)(316002)(83320400001)(83280400001)(83310400001)(83290400001)(66556008)(69590400007)(75432002)(36756003)(2616005)(4326008)(86362001)(6666004)(2906002)(6916009)(186003)(6506007)(16526019)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 7H51zSxDVBVuQWu4c5ANYI8mlWCpDo+zA8D3kJ7wje8OukIhbbgPZpbOvEgHwxk4rkiUaH9cBHE94IsQg3MahVvjSBLZ0AyOK/A2v6o6FSRr81ElcekPxNu2hN+SXbVTQq26iLmjjOb2axHPKCbBar0vvcwiVEK7NfuiAjtkN1ZOjB3LghWuq0/RFR+MkZInwhsWPtV9YF3BUy7jhCM5zF6UwMDymn2zlvAZVzdJgnba53NLmwTicb89bins9m0IDAJ571i6FO8yl9XVeJsuVtpTuypBFU3C09rc0MitoW6L8bi4C5uLkHE9bNYyi3H+7aqmLnE9adcTrcRqkNil4/gM8tfHgwn2TeHeLVHm/5hUOz8GaNDum2duIY2UJOHefgBTXMUy+8n/TIXXl+Yd+QdHnIZcyBZ5gGZud2m5bUrbSBVasGOoWbkgG0tdsuxRFwStQvzn8GNi4VHKVDZepeX6nowZs9h36368XKX4BY+oHsFDw6BZQkMW1uAZkwgEYlRCVqO0g9RhEw5EQrUhBfZ+CMPHqw7kfrVSns1HgkpNxC3RMDVu2gmIz8kcvfu/xBmEqionRpHp131jtjiMG6Q09tymbzAlEsKbe/TT34td+sdRVeIlIy3yNp1+bQ6F6dKElD+tENuneS8Ai9RvS8oVbkhFOPU7uik9266xXmS5ZcN/kD0yZZkvKbvJhDUuDYJxkSivEQs8Q9mi8PGwvVIG8HqtD7F0wZdZC+CcR2OUenG3SmpDnwvUFoYyKW5HY9JdXj8VlMMfq4yoKRalkm+GO8seH8/vNhwx6dMEGeviXisIbg6l20vHJ7HGLnGem1sSNs07Gyz4tC74deXxkSQjEBoW03I3nNVqJJAekezoFVWbDFQkyeabeIYOso1G
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b33399-e027-4ad5-e769-08d7f2c44582
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 20:21:49.1572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TRQF8NbeLMQRz2tgJkHQLUQgHVP677Q0Ge14Zg3NAm5OozPxYZShYsatX/mYc/oVFPD7in1RE+oKMIWWXVQOLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6075
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 07 May 2020 20:21:58 -0000

- Make read_ready a manual-reset event.

- Signal read_ready in open instead of in the listen_client_thread.

- Don't reset read_ready when the listen_client thread terminates;
  instead do it in close().

- Rearrange open and change its error handling.

- Add a wait_open_pipe method that waits for a pipe instance to be
  available and then calls open_pipe.  Use it when opening a writer if
  we can't connect immediately.  This can happen if the system is
  heavily loaded and/or if many writers are trying to open
  simultaneously.
---
 winsup/cygwin/fhandler.h       |   1 +
 winsup/cygwin/fhandler_fifo.cc | 267 +++++++++++++++++++++------------
 2 files changed, 168 insertions(+), 100 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 3bc04cf13..2516c93b4 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1323,6 +1323,7 @@ class fhandler_fifo: public fhandler_base
   static NTSTATUS npfs_handle (HANDLE &);
   HANDLE create_pipe_instance (bool);
   NTSTATUS open_pipe (HANDLE&);
+  NTSTATUS wait_open_pipe (HANDLE&);
   int add_client_handler ();
   void delete_client_handler (int);
   bool listen_client ();
diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index 21faf4ec2..5c3df5497 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -222,7 +222,64 @@ fhandler_fifo::open_pipe (HANDLE& ph)
 			      openflags & O_CLOEXEC ? 0 : OBJ_INHERIT,
 			      npfsh, NULL);
   sharing = FILE_SHARE_READ | FILE_SHARE_WRITE;
-  status = NtOpenFile (&ph, access, &attr, &io, sharing, 0);
+  return NtOpenFile (&ph, access, &attr, &io, sharing, 0);
+}
+
+/* Wait up to 100ms for a pipe instance to be available, then connect. */
+NTSTATUS
+fhandler_fifo::wait_open_pipe (HANDLE& ph)
+{
+  HANDLE npfsh;
+  HANDLE evt;
+  NTSTATUS status;
+  IO_STATUS_BLOCK io;
+  ULONG pwbuf_size;
+  PFILE_PIPE_WAIT_FOR_BUFFER pwbuf;
+  LONGLONG stamp;
+  LONGLONG orig_timeout = -100 * NS100PERSEC / MSPERSEC;   /* 100ms */
+
+  status = npfs_handle (npfsh);
+  if (!NT_SUCCESS (status))
+    return status;
+  if (!(evt = create_event ()))
+    api_fatal ("Can't create event, %E");
+  pwbuf_size
+    = offsetof (FILE_PIPE_WAIT_FOR_BUFFER, Name) + get_pipe_name ()->Length;
+  pwbuf = (PFILE_PIPE_WAIT_FOR_BUFFER) alloca (pwbuf_size);
+  pwbuf->Timeout.QuadPart = orig_timeout;
+  pwbuf->NameLength = get_pipe_name ()->Length;
+  pwbuf->TimeoutSpecified = TRUE;
+  memcpy (pwbuf->Name, get_pipe_name ()->Buffer, get_pipe_name ()->Length);
+  stamp = get_clock (CLOCK_MONOTONIC)->n100secs ();
+  bool retry;
+  do
+    {
+      retry = false;
+      status = NtFsControlFile (npfsh, evt, NULL, NULL, &io, FSCTL_PIPE_WAIT,
+				pwbuf, pwbuf_size, NULL, 0);
+      if (status == STATUS_PENDING)
+	{
+	  if (WaitForSingleObject (evt, INFINITE) == WAIT_OBJECT_0)
+	    status = io.Status;
+	  else
+	    api_fatal ("WFSO failed, %E");
+	}
+      if (NT_SUCCESS (status))
+	status = open_pipe (ph);
+      if (STATUS_PIPE_NO_INSTANCE_AVAILABLE (status))
+	{
+	  /* Another writer has grabbed the pipe instance.  Adjust
+	     the timeout and keep waiting if there's time left. */
+	  pwbuf->Timeout.QuadPart = orig_timeout
+	    + get_clock (CLOCK_MONOTONIC)->n100secs () - stamp;
+	  if (pwbuf->Timeout.QuadPart < 0)
+	    retry = true;
+	  else
+	    status = STATUS_IO_TIMEOUT;
+	}
+    }
+  while (retry);
+  NtClose (evt);
   return status;
 }
 
@@ -294,7 +351,6 @@ void
 fhandler_fifo::record_connection (fifo_client_handler& fc,
 				  fifo_client_connect_state s)
 {
-  SetEvent (write_ready);
   fc.state = s;
   maybe_eof (false);
   ResetEvent (writer_opening);
@@ -327,9 +383,6 @@ fhandler_fifo::listen_client_thread ()
       if (add_client_handler () < 0)
 	api_fatal ("Can't add a client handler, %E");
 
-      /* Allow a writer to open. */
-      SetEvent (read_ready);
-
       /* Listen for a writer to connect to the new client handler. */
       fifo_client_handler& fc = fc_handler[nhandlers - 1];
       NTSTATUS status;
@@ -405,19 +458,13 @@ fhandler_fifo::listen_client_thread ()
 out:
   if (conn_evt)
     NtClose (conn_evt);
-  ResetEvent (read_ready);
   return 0;
 }
 
 int
 fhandler_fifo::open (int flags, mode_t)
 {
-  enum
-  {
-   success,
-   error_errno_set,
-   error_set_errno
-  } res;
+  int saved_errno = 0;
 
   if (flags & O_PATH)
     return open_fs (flags);
@@ -437,8 +484,7 @@ fhandler_fifo::open (int flags, mode_t)
       break;
     default:
       set_errno (EINVAL);
-      res = error_errno_set;
-      goto out;
+      goto err;
     }
 
   debug_only_printf ("reader %d, writer %d, duplexer %d", reader, writer, duplexer);
@@ -454,135 +500,151 @@ fhandler_fifo::open (int flags, mode_t)
 
   char npbuf[MAX_PATH];
   __small_sprintf (npbuf, "r-event.%08x.%016X", get_dev (), get_ino ());
-  if (!(read_ready = CreateEvent (sa_buf, false, false, npbuf)))
+  if (!(read_ready = CreateEvent (sa_buf, true, false, npbuf)))
     {
       debug_printf ("CreateEvent for %s failed, %E", npbuf);
-      res = error_set_errno;
-      goto out;
+      __seterrno ();
+      goto err;
     }
   npbuf[0] = 'w';
   if (!(write_ready = CreateEvent (sa_buf, true, false, npbuf)))
     {
       debug_printf ("CreateEvent for %s failed, %E", npbuf);
-      res = error_set_errno;
-      goto out;
+      __seterrno ();
+      goto err_close_read_ready;
     }
   npbuf[0] = 'o';
   if (!(writer_opening = CreateEvent (sa_buf, true, false, npbuf)))
     {
       debug_printf ("CreateEvent for %s failed, %E", npbuf);
-      res = error_set_errno;
-      goto out;
-    }
-
-  /* If we're a duplexer, create the pipe and the first client handler. */
-  if (duplexer)
-    {
-      HANDLE ph = NULL;
-
-      if (add_client_handler () < 0)
-	{
-	  res = error_errno_set;
-	  goto out;
-	}
-      NTSTATUS status = open_pipe (ph);
-      if (NT_SUCCESS (status))
-	{
-	  record_connection (fc_handler[0]);
-	  set_handle (ph);
-	  set_pipe_non_blocking (ph, flags & O_NONBLOCK);
-	}
-      else
-	{
-	  __seterrno_from_nt_status (status);
-	  res = error_errno_set;
-	  goto out;
-	}
+      __seterrno ();
+      goto err_close_write_ready;
     }
 
-  /* If we're reading, start the listen_client thread (which should
-     signal read_ready), and wait for a writer. */
+  /* If we're reading, signal read_ready and start the listen_client
+     thread. */
   if (reader)
     {
       if (!listen_client ())
 	{
 	  debug_printf ("create of listen_client thread failed");
-	  res = error_errno_set;
-	  goto out;
+	  goto err_close_writer_opening;
 	}
-      else if (!duplexer && !wait (write_ready))
-	{
-	  res = error_errno_set;
-	  goto out;
-	}
-      else
+      SetEvent (read_ready);
+
+      /* If we're a duplexer, we need a handle for writing. */
+      if (duplexer)
 	{
-	  init_fixup_before ();
-	  res = success;
+	  HANDLE ph = NULL;
+	  NTSTATUS status;
+
+	  while (1)
+	    {
+	      status = open_pipe (ph);
+	      if (NT_SUCCESS (status))
+		{
+		  set_handle (ph);
+		  set_pipe_non_blocking (ph, flags & O_NONBLOCK);
+		  break;
+		}
+	      else if (status == STATUS_OBJECT_NAME_NOT_FOUND)
+		{
+		  /* The pipe hasn't been created yet. */
+		  yield ();
+		  continue;
+		}
+	      else
+		{
+		  __seterrno_from_nt_status (status);
+		  goto err_close_reader;
+		}
+	    }
 	}
+      /* Not a duplexer; wait for a writer to connect. */
+      else if (!wait (write_ready))
+	goto err_close_reader;
+      init_fixup_before ();
+      goto success;
     }
 
-  /* If we're writing, wait for read_ready and then connect to the
-     pipe.  This should always succeed quickly if the reader's
-     listen_client thread is running.  Then signal write_ready.  */
+  /* If we're writing, wait for read_ready, connect to the pipe, and
+     signal write_ready.  */
   if (writer)
     {
+      NTSTATUS status;
+
       SetEvent (writer_opening);
+      if (!wait (read_ready))
+	{
+	  ResetEvent (writer_opening);
+	  goto err_close_writer_opening;
+	}
       while (1)
 	{
-	  if (!wait (read_ready))
-	    {
-	      ResetEvent (writer_opening);
-	      res = error_errno_set;
-	      goto out;
-	    }
-	  NTSTATUS status = open_pipe (get_handle ());
+	  status = open_pipe (get_handle ());
 	  if (NT_SUCCESS (status))
+	    goto writer_success;
+	  else if (status == STATUS_OBJECT_NAME_NOT_FOUND)
 	    {
-	      set_pipe_non_blocking (get_handle (), flags & O_NONBLOCK);
-	      SetEvent (write_ready);
-	      res = success;
-	      goto out;
+	      /* The pipe hasn't been created yet. */
+	      yield ();
+	      continue;
 	    }
 	  else if (STATUS_PIPE_NO_INSTANCE_AVAILABLE (status))
-	    Sleep (1);
+	    break;
 	  else
 	    {
 	      debug_printf ("create of writer failed");
 	      __seterrno_from_nt_status (status);
-	      res = error_errno_set;
 	      ResetEvent (writer_opening);
-	      goto out;
+	      goto err_close_writer_opening;
 	    }
 	}
-    }
-out:
-  if (res == error_set_errno)
-    __seterrno ();
-  if (res != success)
-    {
-      if (read_ready)
-	{
-	  NtClose (read_ready);
-	  read_ready = NULL;
-	}
-      if (write_ready)
-	{
-	  NtClose (write_ready);
-	  write_ready = NULL;
-	}
-      if (writer_opening)
+
+      /* We should get here only if the system is heavily loaded
+	 and/or many writers are trying to connect simultaneously */
+      while (1)
 	{
-	  NtClose (writer_opening);
-	  writer_opening = NULL;
+	  SetEvent (writer_opening);
+	  if (!wait (read_ready))
+	    {
+	      ResetEvent (writer_opening);
+	      goto err_close_writer_opening;
+	    }
+	  status = wait_open_pipe (get_handle ());
+	  if (NT_SUCCESS (status))
+	    goto writer_success;
+	  else if (status == STATUS_IO_TIMEOUT)
+	    continue;
+	  else
+	    {
+	      debug_printf ("create of writer failed");
+	      __seterrno_from_nt_status (status);
+	      ResetEvent (writer_opening);
+	      goto err_close_writer_opening;
+	    }
 	}
-      if (get_handle ())
-	NtClose (get_handle ());
-      if (listen_client_thr)
-	stop_listen_client ();
     }
-  debug_printf ("res %d", res);
-  return res == success;
+writer_success:
+  set_pipe_non_blocking (get_handle (), flags & O_NONBLOCK);
+  SetEvent (write_ready);
+success:
+  return 1;
+err_close_reader:
+  saved_errno = get_errno ();
+  close ();
+  set_errno (saved_errno);
+  return 0;
+err_close_writer_opening:
+  NtClose (writer_opening);
+err_close_write_ready:
+  NtClose (write_ready);
+err_close_read_ready:
+  NtClose (read_ready);
+err:
+  if (get_handle ())
+    NtClose (get_handle ());
+  return 0;
 }
 
 off_t
@@ -938,6 +1000,11 @@ fhandler_fifo::close ()
      handler or another thread. */
   fifo_client_unlock ();
   stop_listen_client ();
+  if (reader)
+    /* FIXME: There could be several readers open because of
+       dup/fork/exec; we should only reset read_ready when the last
+       one closes. */
+    ResetEvent (read_ready);
   if (read_ready)
     NtClose (read_ready);
   if (write_ready)
-- 
2.21.0

