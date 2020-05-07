Return-Path: <kbrown@cornell.edu>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770093.outbound.protection.outlook.com [40.107.77.93])
 by sourceware.org (Postfix) with ESMTPS id 94A07395CC1E
 for <cygwin-patches@cygwin.com>; Thu,  7 May 2020 20:21:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 94A07395CC1E
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MsasYM4JDfpTcYpn8WbaL1lQ/VRDhReqeDUTQfzNHJvsAeUykKpCW7dcxf0nKdKL1i/mB9Q/TO6RjFQPoW6d0i6rcTSynVZTaFPfp6JHRd287NkhqDS1xIyOPhzeP6LY0Z17MheIXS5vjttipkq9stVpNDs6YH3SKEF7E32kpl1Lg6ug1BnXbNJohoMbGJp9E7wZScpyt8C8EiLcZSEsgXuHrV9dtb+8G4HkRNNQFNK8LaNqyPc2vPEplgtBifu7Q6xaxVnAP0ZjmaK5c5tiWzBZ5TaxUXO58k8X00hPFscmiwe5M3V667cujbsqT6Gi+tBObsc1or1MDOKbrFb8Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaUEt8aQZxalSFqAQfrJwLYvbRkssbAQUmuYamAqnXI=;
 b=g1gUVxe67Mpq9TZkFgUkzK2Ix/jczMA9wU7S2IJXHCYLcB2crgdwIzArADVgmO2CW+ysbEr0hNUkR70fTjGVHQcap1WGP+M//19hqH7adYs1Y+RCFnz2+DzJoYCzlBOQlrqDtmOxug8GwTioFDDZlc9uFcBNxfAd1/pEYb9NiGCl0QodanR44k7E1y3FFVWllAwBFn+0Yao/QlDWgciaxuKEmyYwNlUTDkFyNVRulWSyWlN3Rlp7PnaXcfHFH4pxl8bdBbdEfuF/XR67mwDwAujqyiE5/OGEnbwXXMSKbucgO8+uIn0JpNOZnj0EuuPHgF/WnoihKpglWC7nANBo1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from DM6PR04MB6075.namprd04.prod.outlook.com (2603:10b6:5:127::31)
 by DM6PR04MB6075.namprd04.prod.outlook.com (2603:10b6:5:127::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Thu, 7 May
 2020 20:21:48 +0000
Received: from DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4]) by DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4%4]) with mapi id 15.20.2979.025; Thu, 7 May 2020
 20:21:48 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Cc: sten.kristian.ivarsson@gmail.com
Subject: [PATCH 08/21] Cygwin: FIFO: fix hit_eof
Date: Thu,  7 May 2020 16:21:11 -0400
Message-Id: <20200507202124.1463-9-kbrown@cornell.edu>
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
 15.20.2979.28 via Frontend Transport; Thu, 7 May 2020 20:21:47 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [2604:6000:b407:7f00:e532:58da:20b8:9136]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a3116a9-7720-4d4d-aa81-08d7f2c44509
X-MS-TrafficTypeDiagnostic: DM6PR04MB6075:
X-Microsoft-Antispam-PRVS: <DM6PR04MB60750C7A48EE2981E96F549AD8A50@DM6PR04MB6075.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3daSv2KFDVulhtPF89At2GiJVSfF2U21cui4HlQeU7OYzm7CuTKwxPnX5lcCGuY5OnagjX0ZxEEX3hSSXs85G/f3yoIo/kwyo3QumuykVgxR0qZMgi9TS5GRZLXC1QB5yzX+yY0fpU9QhuXt8GNW+R226gpVl81T3PGCC17wKNQ47lXnyRlsYKTyVKfrUq6eZ0hUUEY55fGk+Qf44FsOteY8kaon+uyAwFEGs1LxPD5RZsA+YVOU9u2c8fiqadGq7PF7XGQcprFeW7xTbpL419YoPW3hvStMnJlyguwp54/vXdbn929uO0ZeU6qM/gzt92McQXXmnC3PV4QVoUIOBRHlIrG+npd3fSFx6547Q3K2p0HLknXdkYISjecBjpuSwzCAr6JdqWcEo0TohKhg5EKIO5otEqbJIT0FH1wJCbXaRsyQFVvoKCZI5i/fYnbHULOcxcOIwthoagkbWUKX5kEyx5yjMHQfjSgsNmfc5gpWLdeTAqQlBoJHSjhc5pkYF+3oHStBzUeH1SV6VQKg69V9EWxferZUmFFt5R1MGMTHUnx3AnJBho2pF5Zv0akE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6075.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(33430700001)(33440700001)(6512007)(6486002)(478600001)(786003)(8676002)(66946007)(1076003)(5660300002)(8936002)(83300400001)(66476007)(316002)(83320400001)(83280400001)(83310400001)(83290400001)(66556008)(69590400007)(75432002)(36756003)(2616005)(4326008)(86362001)(6666004)(2906002)(6916009)(30864003)(186003)(6506007)(16526019)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: SYzJ3eKyQzsqjzbSLgDFcA+WQyJmelhPTDm5sanh/IuMXbWazOGb4y1B6b8mLUz9g0Eenb0nIIhl9q2irkKFRTCvYEliyZnkEQgSQYrvYO5viHVY+czureyVDhsSJVTBdyrzojLnRf9PkI/SDRXfSzf5DFkUsQ+Cg833/njeNgUMKs5E80Ko7UwOUTyQ2n/GfBjySpEY0pnD6TFHhS2A4N1ZMecrHcukCJqApTuoyr0W19wH0dAaP7OdkY4CFvIN/FAelpb+BfZ0rdMhgYC9DuABwLmaqqbywXzXGNqOBMRWCmHo2Puyc6Bg6y3nxpnNPZwlFfQDZCyGEKh+FRI2xD0d0em5zyTvWDtiXh/QSasAvn1b4ncippWPwD+N/6sdLF8VCNuoo5x1plQs4/TI/L4mHXsuLMulu8eC4fdWXzTGKWZA2C1KtvYy16/fVQBnDAcnlQ1uopUklt2qp8dtfV2+DDow/hkH/Iyb8zz+Zu99NaU+mYNu6lZqC4vmrjC1XzV8OM+YQ6Ti8UXabbzfiPiFCiRcVuWRzcsS4qQpaBIiahjmrYA+jRF/BuA5RCcIglcn/2ufUIo5Acxw6tZFXY3iO2/446Phayve3rK6BF7DUc/kL1dTn6g+hCNwW0jgomNer8lDqWJX/cv2GMuLTyhrOz+//mgiOn79hotoS1l78MwZlSIC0NSuDAgZkLUvJOm+LmbOc3+BjpI4Xke8IKW6RpGT+RxHc9GL6S3g7jd3yDFTBqO967MOovH/LH8lpg27j79rLksvofxGRoUbw75Yrh8fzxLsgND+yYfpK3YCZerANme82lot252GhHCPerryRftB4epvyH40kC/mjg4aY96ijfkRlCBrX9Pbzp0NO6ZsbgezipH3ok+cQjzz
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3116a9-7720-4d4d-aa81-08d7f2c44509
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 20:21:48.3986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uRf6qC4aUKviFOWkxWyD5wpjTj4SxtXlMoHTlF50deC6FKFQRgk+WfBnHaF6XLpz8vfKlen4ajH5WTG9fC1HhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6075
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, MSGID_FROM_MTA_HEADER,
 RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
 TVD_PH_BODY_ACCOUNTS_PRE, TXREP autolearn=ham autolearn_force=no version=3.4.2
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

According to Posix, a FIFO open for reading is at EOF if it is empty
and there are no writers open.

The only way to test this is to poll the fifo_client_handlers as in
raw_read and select.cc:peek_fifo.  The current hit_eof instead relies
on the value of nconnected, which can be out of date.  On the one
hand, it doesn't take into account writers that were connected but
have since closed.  On the other hand, it doesn't take into account
writers that are in the process of opening but haven't yet connected.

Fix this by introducing a maybe_eof method that tentatively assumes
EOF if there are no connected writers after polling.  Then check for
writers currently opening (via a new 'writer_opening' event), and wait
for the fifo_reader_thread to record any new connection that was made
while we were polling.

To handle the needs of peek_fifo, replace the get_fc_handle method
by a get_fc_handler method, and add a fifo_client_handler::get_state
method.

Remove the is_connected method, which was used only in peek_fifo and
is no longer needed.

Remove the nconnected data member, which was used only for the flawed
hit_eof.

Add some comments about events to fhandler.h.
---
 winsup/cygwin/fhandler.h       | 19 +++++---
 winsup/cygwin/fhandler_fifo.cc | 84 ++++++++++++++++++++++------------
 winsup/cygwin/select.cc        | 44 ++++++++++++------
 3 files changed, 98 insertions(+), 49 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 4d691a0fc..3bc04cf13 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1296,19 +1296,26 @@ struct fifo_client_handler
 /* Returns FILE_PIPE_DISCONNECTED_STATE, FILE_PIPE_LISTENING_STATE,
    FILE_PIPE_CONNECTED_STATE, FILE_PIPE_CLOSING_STATE,
    FILE_PIPE_INPUT_AVAILABLE_STATE, or -1 on error. */
+  fifo_client_connect_state &get_state () { return state; }
   int pipe_state ();
 };
 
 class fhandler_fifo: public fhandler_base
 {
-  HANDLE read_ready;
-  HANDLE write_ready;
+  /* Handles to named events shared by all fhandlers for a given FIFO. */
+  HANDLE read_ready;            /* A reader is open; OK for a writer to open. */
+  HANDLE write_ready;           /* A writer is open; OK for a reader to open. */
+  HANDLE writer_opening;        /* A writer is opening; no EOF. */
+
+  /* Non-shared handles needed for the listen_client_thread. */
   HANDLE listen_client_thr;
   HANDLE lct_termination_evt;
+
   UNICODE_STRING pipe_name;
   WCHAR pipe_name_buf[CYGWIN_FIFO_PIPE_NAME_LEN + 1];
+  bool _maybe_eof;
   fifo_client_handler fc_handler[MAX_CLIENTS];
-  int nhandlers, nconnected;
+  int nhandlers;
   af_unix_spinlock_t _fifo_client_lock;
   bool reader, writer, duplexer;
   size_t max_atomic_write;
@@ -1326,10 +1333,10 @@ class fhandler_fifo: public fhandler_base
 public:
   fhandler_fifo ();
   bool hit_eof ();
+  bool maybe_eof () const { return _maybe_eof; }
+  void maybe_eof (bool val) { _maybe_eof = val; }
   int get_nhandlers () const { return nhandlers; }
-  HANDLE get_fc_handle (int i) const { return fc_handler[i].h; }
-  bool is_connected (int i) const
-  { return fc_handler[i].state == fc_connected; }
+  fifo_client_handler get_fc_handler (int i) const { return fc_handler[i]; }
   PUNICODE_STRING get_pipe_name ();
   DWORD listen_client_thread ();
   void fifo_client_lock () { _fifo_client_lock.lock (); }
diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index 4904a535d..21faf4ec2 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -66,9 +66,10 @@ STATUS_PIPE_EMPTY simply means there's no data to be read. */
 		   || _s == STATUS_PIPE_BUSY; })
 
 fhandler_fifo::fhandler_fifo ():
-  fhandler_base (), read_ready (NULL), write_ready (NULL),
-  listen_client_thr (NULL), lct_termination_evt (NULL), nhandlers (0),
-  nconnected (0), reader (false), writer (false), duplexer (false),
+  fhandler_base (),
+  read_ready (NULL), write_ready (NULL), writer_opening (NULL),
+  listen_client_thr (NULL), lct_termination_evt (NULL), _maybe_eof (false), nhandlers (0),
+  reader (false), writer (false), duplexer (false),
   max_atomic_write (DEFAULT_PIPEBUFSIZE)
 {
   pipe_name_buf[0] = L'\0';
@@ -295,7 +296,8 @@ fhandler_fifo::record_connection (fifo_client_handler& fc,
 {
   SetEvent (write_ready);
   fc.state = s;
-  nconnected++;
+  maybe_eof (false);
+  ResetEvent (writer_opening);
   set_pipe_non_blocking (fc.h, true);
 }
 
@@ -465,6 +467,13 @@ fhandler_fifo::open (int flags, mode_t)
       res = error_set_errno;
       goto out;
     }
+  npbuf[0] = 'o';
+  if (!(writer_opening = CreateEvent (sa_buf, true, false, npbuf)))
+    {
+      debug_printf ("CreateEvent for %s failed, %E", npbuf);
+      res = error_set_errno;
+      goto out;
+    }
 
   /* If we're a duplexer, create the pipe and the first client handler. */
   if (duplexer)
@@ -518,10 +527,12 @@ fhandler_fifo::open (int flags, mode_t)
      listen_client thread is running.  Then signal write_ready.  */
   if (writer)
     {
+      SetEvent (writer_opening);
       while (1)
 	{
 	  if (!wait (read_ready))
 	    {
+	      ResetEvent (writer_opening);
 	      res = error_errno_set;
 	      goto out;
 	    }
@@ -540,6 +551,7 @@ fhandler_fifo::open (int flags, mode_t)
 	      debug_printf ("create of writer failed");
 	      __seterrno_from_nt_status (status);
 	      res = error_errno_set;
+	      ResetEvent (writer_opening);
 	      goto out;
 	    }
 	}
@@ -559,6 +571,11 @@ out:
 	  NtClose (write_ready);
 	  write_ready = NULL;
 	}
+      if (writer_opening)
+	{
+	  NtClose (writer_opening);
+	  writer_opening = NULL;
+	}
       if (get_handle ())
 	NtClose (get_handle ());
       if (listen_client_thr)
@@ -717,28 +734,23 @@ fhandler_fifo::raw_write (const void *ptr, size_t len)
   return ret;
 }
 
-/* A FIFO open for reading is at EOF if no process has it open for
-   writing.  We test this by checking nconnected.  But we must take
-   account of the possible delay from the time of connection to the
-   time the connection is recorded by the listen_client thread. */
+/* A reader is at EOF if the pipe is empty and no writers are open.
+   hit_eof is called by raw_read and select.cc:peek_fifo if it appears
+   that we are at EOF after polling the fc_handlers.  We recheck this
+   in case a writer opened while we were polling.  */
 bool
 fhandler_fifo::hit_eof ()
 {
-  bool eof;
-  bool retry = true;
-
-repeat:
+  bool ret = maybe_eof () && !IsEventSignalled (writer_opening);
+  if (ret)
+    {
+      yield ();
+      /* Wait for the reader thread to finish recording any connection. */
       fifo_client_lock ();
-      eof = (nconnected == 0);
       fifo_client_unlock ();
-      if (eof && retry)
-	{
-	  retry = false;
-	  /* Give the listen_client thread time to catch up. */
-	  Sleep (1);
-	  goto repeat;
-	}
-  return eof;
+      ret = maybe_eof ();
+    }
+  return ret;
 }
 
 /* Is the lct running? */
@@ -783,13 +795,8 @@ fhandler_fifo::raw_read (void *in_ptr, size_t& len)
 
   while (1)
     {
-      if (hit_eof ())
-	{
-	  len = 0;
-	  return;
-	}
-
       /* Poll the connected clients for input. */
+      int nconnected = 0;
       fifo_client_lock ();
       for (int i = 0; i < nhandlers; i++)
 	if (fc_handler[i].state >= fc_connected)
@@ -798,7 +805,8 @@ fhandler_fifo::raw_read (void *in_ptr, size_t& len)
 	    IO_STATUS_BLOCK io;
 	    size_t nbytes = 0;
 
-	    status = NtReadFile (get_fc_handle (i), NULL, NULL, NULL,
+	    nconnected++;
+	    status = NtReadFile (fc_handler[i].h, NULL, NULL, NULL,
 				 &io, in_ptr, len, NULL, NULL);
 	    switch (status)
 	      {
@@ -826,7 +834,13 @@ fhandler_fifo::raw_read (void *in_ptr, size_t& len)
 		break;
 	      }
 	  }
+      maybe_eof (!nconnected && !IsEventSignalled (writer_opening));
       fifo_client_unlock ();
+      if (maybe_eof () && hit_eof ())
+	{
+	  len = 0;
+	  return;
+	}
       if (is_nonblocking ())
 	{
 	  set_errno (EAGAIN);
@@ -928,6 +942,8 @@ fhandler_fifo::close ()
     NtClose (read_ready);
   if (write_ready)
     NtClose (write_ready);
+  if (writer_opening)
+    NtClose (writer_opening);
   fifo_client_lock ();
   for (int i = 0; i < nhandlers; i++)
     fc_handler[i].close ();
@@ -979,6 +995,13 @@ fhandler_fifo::dup (fhandler_base *child, int flags)
       __seterrno ();
       goto err_close_read_ready;
     }
+  if (!DuplicateHandle (GetCurrentProcess (), writer_opening,
+			GetCurrentProcess (), &fhf->writer_opening,
+			0, !(flags & O_CLOEXEC), DUPLICATE_SAME_ACCESS))
+    {
+      __seterrno ();
+      goto err_close_write_ready;
+    }
   if (reader)
     {
       /* Make sure the child starts unlocked. */
@@ -1009,6 +1032,9 @@ fhandler_fifo::dup (fhandler_base *child, int flags)
 err_close_handlers:
   for (int j = 0; j < i; j++)
     fhf->fc_handler[j].close ();
+/* err_close_writer_opening: */
+  NtClose (fhf->writer_opening);
+err_close_write_ready:
   NtClose (fhf->write_ready);
 err_close_read_ready:
   NtClose (fhf->read_ready);
@@ -1028,6 +1054,7 @@ fhandler_fifo::fixup_after_fork (HANDLE parent)
   fhandler_base::fixup_after_fork (parent);
   fork_fixup (parent, read_ready, "read_ready");
   fork_fixup (parent, write_ready, "write_ready");
+  fork_fixup (parent, writer_opening, "writer_opening");
   if (reader)
     {
       /* Make sure the child starts unlocked. */
@@ -1062,6 +1089,7 @@ fhandler_fifo::set_close_on_exec (bool val)
   fhandler_base::set_close_on_exec (val);
   set_no_inheritance (read_ready, val);
   set_no_inheritance (write_ready, val);
+  set_no_inheritance (writer_opening, val);
   fifo_client_lock ();
   for (int i = 0; i < nhandlers; i++)
     set_no_inheritance (fc_handler[i].h, val);
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index b5d19cf31..9323c423f 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -866,31 +866,45 @@ peek_fifo (select_record *s, bool from_select)
 	  goto out;
 	}
 
-      if (fh->hit_eof ())
-	{
-	  select_printf ("read: %s, saw EOF", fh->get_name ());
-	  gotone = s->read_ready = true;
-	  if (s->except_selected)
-	    gotone += s->except_ready = true;
-	  goto out;
-	}
-
       fh->fifo_client_lock ();
+      int nconnected = 0;
       for (int i = 0; i < fh->get_nhandlers (); i++)
-	if (fh->is_connected (i))
+	if (fh->get_fc_handler (i).get_state () >= fc_connected)
 	  {
-	    int n = pipe_data_available (s->fd, fh, fh->get_fc_handle (i),
-					 false);
-	    if (n > 0)
+	    nconnected++;
+	    switch (fh->get_fc_handler (i).pipe_state ())
 	      {
-		select_printf ("read: %s, ready for read: avail %d, client %d",
-			       fh->get_name (), n, i);
+	      case FILE_PIPE_CONNECTED_STATE:
+		fh->get_fc_handler (i).get_state () = fc_connected;
+		break;
+	      case FILE_PIPE_DISCONNECTED_STATE:
+		fh->get_fc_handler (i).get_state () = fc_disconnected;
+		nconnected--;
+		break;
+	      case FILE_PIPE_CLOSING_STATE:
+		fh->get_fc_handler (i).get_state () = fc_closing;
+		break;
+	      case FILE_PIPE_INPUT_AVAILABLE_STATE:
+		fh->get_fc_handler (i).get_state () = fc_input_avail;
+		select_printf ("read: %s, ready for read", fh->get_name ());
 		fh->fifo_client_unlock ();
 		gotone += s->read_ready = true;
 		goto out;
+	      default:
+		fh->get_fc_handler (i).get_state () = fc_error;
+		nconnected--;
+		break;
 	      }
 	  }
+      fh->maybe_eof (!nconnected);
       fh->fifo_client_unlock ();
+      if (fh->maybe_eof () && fh->hit_eof ())
+	{
+	  select_printf ("read: %s, saw EOF", fh->get_name ());
+	  gotone += s->read_ready = true;
+	  if (s->except_selected)
+	    gotone += s->except_ready = true;
+	}
     }
 out:
   if (s->write_selected)
-- 
2.21.0

