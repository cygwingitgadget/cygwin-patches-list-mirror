Return-Path: <kbrown@cornell.edu>
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2122.outbound.protection.outlook.com [40.107.243.122])
 by sourceware.org (Postfix) with ESMTPS id B0610396E85D
 for <cygwin-patches@cygwin.com>; Thu,  7 May 2020 20:22:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B0610396E85D
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4/MA6z/FRb4rwr/hR9/VYAghhlyWZpqyicGvruYeVuU9cQX90uZ6oJfnZWJJ6WtyVcAKhq0p0hb/nBW8otT7IWf4t/z1kDyEGJB0avKLb/d8aPpWWzq4HB+/2ZcNAKmI4Dov9FbKa5CjgdkMWIkh8he7oK/Jo7Kbo18PUualGxiPCcVbg8dpgjHnLa54olCz5xhIAEXNIhwaeAl5AAhOxlptYNoOxK5OjHe9kuDm/ifg+RBOJU4tABstGlnbyy17OU2/ihRW87OrCbogl/MjtYxlyakfxsGZqp23TOzclhQAUKtg16bT0pTg1JBNqw6CTa6CBCjTNjBmrlPlBxdjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usclbiVrBWBHcsc5gxs1o2XVVeyf65yWTPYyo8woxSw=;
 b=ZiQYyGL1YkShE0UmDtaJaswP1DPBIEkhN7TWJ+agBgk/QTlgZNNgk7vyZHb6ZGKawRWvgWC3Rxd6+XFBzVNi8IEb21hkD0JzMnm3Wacr+OQNEqyswSxnZlHqhWfTOIWzniMqTdk4oHpkBKtjLIOvRNfyJsnI8jPPKk1tyoDXiRkdGvNsaE6sxKh/8xPzW7XoIIOACyQ1aaX1oqDDOFXoSOfw/8Eq2+hCl41hjfj9qFqXU8tzE7SQye2gVG4uth5z5vP5pWP/b+cgUViJjJOVJcMDlfPpdV5CLdrdUN6cMSbYnRE2A/XdZxB6BfVZ8ETshvIAROc2ab/q2URLkWMVPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from DM6PR04MB6075.namprd04.prod.outlook.com (2603:10b6:5:127::31)
 by DM6PR04MB5082.namprd04.prod.outlook.com (2603:10b6:5:1a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Thu, 7 May
 2020 20:21:57 +0000
Received: from DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4]) by DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4%4]) with mapi id 15.20.2979.025; Thu, 7 May 2020
 20:21:57 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Cc: sten.kristian.ivarsson@gmail.com
Subject: [PATCH 17/21] Cygwin: FIFO: take ownership on exec
Date: Thu,  7 May 2020 16:21:20 -0400
Message-Id: <20200507202124.1463-18-kbrown@cornell.edu>
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
 15.20.2979.28 via Frontend Transport; Thu, 7 May 2020 20:21:56 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [2604:6000:b407:7f00:e532:58da:20b8:9136]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4808d38f-e00e-483f-613b-08d7f2c44a11
X-MS-TrafficTypeDiagnostic: DM6PR04MB5082:
X-Microsoft-Antispam-PRVS: <DM6PR04MB50827E4CFCE70A7F657CAD16D8A50@DM6PR04MB5082.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iLQyrjh0rqP/JzF5aRKKE+MXyE5tARaVJ3OW8O3ygjh1nAhkbeh5uPLGn2shfBmnnwJkcii1iH4Rh/jnyPUItu7j3AWbqzYcANYSS3d7K5T1tNHQwTBTXXJdLKnHiTGWVLnbOO7b4WiSuEcviZoMqOYwlIJRN17XBx+XSUgLXg6AZ+nvjwbqtf1lgV1xDzdSVh9BZesCBrddj4MQTXxvtUs1t4Q/dQyWjxkuN+iGMpL1KyFma07TBt6HqR+cPf6bM6SPdOy3fmFeHNb27dQ/wkDa/6HHTvWORa/WJhR/6PGQuCcZjk0Du6svZxkx8MDVoPk6gM5ffkFdj+dbfdMHczY4WwjT7QuflkOX5k1EBoh9QiFZzZlDPh7k9ZbZdukATTztcNd99XYBVuePiOPzn7W8QhpldrsSyy2knuv9lLsaujre1IAoyuR04dDkRup1euznNskcfFwhp9J9hFyTFZlzm4aLFyVqCtsVqf8jAdfzt74ub6hJU2hj3SVok2y4T9Bv/uDYfS1n5AUvmqBy7On1fIwNyPPPEExsop50WGzNuQ6BE1ztvnooOCY73mzD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6075.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(33430700001)(66556008)(86362001)(786003)(6666004)(186003)(6512007)(75432002)(52116002)(66476007)(69590400007)(316002)(6506007)(2616005)(4326008)(478600001)(5660300002)(1076003)(36756003)(2906002)(33440700001)(16526019)(6486002)(66946007)(8676002)(6916009)(8936002)(83320400001)(83280400001)(83310400001)(83290400001)(83300400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: wJIjkSe2w3mYSka9qTX3/v6CHzF/N73rc/ppvMlCG2+7EIOFlBnw2fX96PBHzs73bjg8zVwmdy4T9Th4vYg4HfARbwSjKGAl15lKdmmGrmdgW9XMeAXqAISYd8Jkbl5Xx6oCCnb2BbeDXKX6OZFkx3sL3kLzJWeYpUiFaDyGnCxl39dL8SyVOhM5nwrk3Qliy5etdwrrm4tLCHfvipQ90xePzJZb/b1rDXdvPBR/j3lSuvguPTyQ7qnrnRsh9vChmof4J5iaam5ThdczOaVe14OO+95YhfMkGtp3wdd7Lr4JCWvp7wNXbeTYCdmZ2wXoZN9R4FmHDYZaNsZw3Q5uzJYN5kNKfrx4YRAIe3Ee4j46y1BJGbQKAuJwEgRw17r8L/ZA6OvdINW52Zs4nBQtKOBLpQ0RYq0fvP2q5wSiS6VPXl+egWiV0k5h44aFOUajMLeBE4aULiz7TrPhaXrVKH/zHN2O2QkndPqyb46IgfoDiPPORf5rjbiCQhJx2VNBnANskSRiYHS25waR/myZd4ILR/HP5ZStl85X8k8LQ3pFPRZvyYEVohKG7lPJLffQJ8jC4wQ634kRt5RI5rtXnJvHqKV/ziSaymoCwpK/O5/B657D2NwBFDR3W6AV/elSZy97fYJwpqD99kTTiW9KvG8Gp/lrr969XlQPhIT2WG4023mgh2IieH5YgMq5IwVSBGWLX7VgluWfgQm2CfDht05wtumFIQNdxUag0l4ZulLyrsWFEaszXTikZyu2j1k2mg1RcI2l56xmOQYeX0Qtb75D+A3tLSumXZgY6XFOPNyr32rCakgTmj85D4pXOSDI+UIYtEaZPb6i7GHAqOFXCQ93jmKbKhhlCRWJQb9+bPSR4GVGGTGokISkEyPZOf9w
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4808d38f-e00e-483f-613b-08d7f2c44a11
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 20:21:56.8897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W93ZAlkQzQguRQt64Lae8DVqrQ8o4MXG8CiK5Qq3Ch2CMGdQZFPNizOB6II1IcrCbpesS1Py8IFnrnPbUElRLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5082
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 07 May 2020 20:22:11 -0000

If fixup_after_exec is called on a non-close-on-exec reader whose
parent is the owner, transfer ownership to the child.  Otherwise the
parent's pipe handles will be closed before any other reader can
duplicate them.

To help with this, make the cancel_evt and thr_sync_evt handles
inheritable, so that the child can terminate the parent's
fifo_reader_thread (and the parent will update the shared fc_handler
list).

Add an optional argument 'from_exec' to update_my_handlers to simplify
its use in this case; no handle duplication is required.
---
 winsup/cygwin/fhandler.h       |   2 +-
 winsup/cygwin/fhandler_fifo.cc | 151 +++++++++++++++++++++++----------
 2 files changed, 107 insertions(+), 46 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 34b209f5d..1cd7d2b11 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1414,7 +1414,7 @@ class fhandler_fifo: public fhandler_base
   { return shmem->get_shared_fc_handler_committed (); }
   void set_shared_fc_handler_committed (size_t n)
   { shmem->set_shared_fc_handler_committed (n); }
-  int update_my_handlers ();
+  int update_my_handlers (bool from_exec = false);
   int update_shared_handlers ();
 
 public:
diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index 846115ad4..1c59bb3f4 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -104,13 +104,14 @@ sec_user_cloexec (bool cloexec, PSECURITY_ATTRIBUTES sa, PSID sid)
 }
 
 static HANDLE
-create_event ()
+create_event (bool inherit = false)
 {
   NTSTATUS status;
   OBJECT_ATTRIBUTES attr;
   HANDLE evt = NULL;
 
-  InitializeObjectAttributes (&attr, NULL, 0, NULL, NULL);
+  InitializeObjectAttributes (&attr, NULL, inherit ? OBJ_INHERIT : 0,
+			      NULL, NULL);
   status = NtCreateEvent (&evt, EVENT_ALL_ACCESS, &attr,
 			  NotificationEvent, FALSE);
   if (!NT_SUCCESS (status))
@@ -353,47 +354,72 @@ fhandler_fifo::record_connection (fifo_client_handler& fc,
   set_pipe_non_blocking (fc.h, true);
 }
 
-/* Called from fifo_reader_thread_func with owner_lock in place. */
+/* Called from fifo_reader_thread_func with owner_lock in place, also
+   from fixup_after_exec with shared handles useable as they are. */
 int
-fhandler_fifo::update_my_handlers ()
+fhandler_fifo::update_my_handlers (bool from_exec)
 {
-  close_all_handlers ();
-  fifo_reader_id_t prev = get_prev_owner ();
-  if (!prev)
+  if (from_exec)
     {
-      debug_printf ("No previous owner to copy handles from");
-      return 0;
+      nhandlers = get_shared_nhandlers ();
+      if (nhandlers > shandlers)
+	{
+	  int save = shandlers;
+	  shandlers = nhandlers + 64;
+	  void *temp = realloc (fc_handler,
+				shandlers * sizeof (fc_handler[0]));
+	  if (!temp)
+	    {
+	      shandlers = save;
+	      nhandlers = 0;
+	      set_errno (ENOMEM);
+	      return -1;
+	    }
+	  fc_handler = (fifo_client_handler *) temp;
+	}
+      memcpy (fc_handler, shared_fc_handler,
+	      nhandlers * sizeof (fc_handler[0]));
     }
-  HANDLE prev_proc;
-  if (prev.winpid == me.winpid)
-    prev_proc =  GetCurrentProcess ();
   else
-    prev_proc = OpenProcess (PROCESS_DUP_HANDLE, false, prev.winpid);
-  if (!prev_proc)
     {
-      debug_printf ("Can't open process of previous owner, %E");
-      __seterrno ();
-      return -1;
-    }
-
-  for (int i = 0; i < get_shared_nhandlers (); i++)
-    {
-      /* Should never happen. */
-      if (shared_fc_handler[i].state != fc_connected)
-	continue;
-      if (add_client_handler (false) < 0)
-	api_fatal ("Can't add client handler, %E");
-      fifo_client_handler &fc = fc_handler[nhandlers - 1];
-      if (!DuplicateHandle (prev_proc, shared_fc_handler[i].h,
-			    GetCurrentProcess (), &fc.h, 0,
-			    !close_on_exec (), DUPLICATE_SAME_ACCESS))
+      close_all_handlers ();
+      fifo_reader_id_t prev = get_prev_owner ();
+      if (!prev)
+	{
+	  debug_printf ("No previous owner to copy handles from");
+	  return 0;
+	}
+      HANDLE prev_proc;
+      if (prev.winpid == me.winpid)
+	prev_proc =  GetCurrentProcess ();
+      else
+	prev_proc = OpenProcess (PROCESS_DUP_HANDLE, false, prev.winpid);
+      if (!prev_proc)
 	{
-	  debug_printf ("Can't duplicate handle of previous owner, %E");
-	  --nhandlers;
+	  debug_printf ("Can't open process of previous owner, %E");
 	  __seterrno ();
 	  return -1;
 	}
-      fc.state = fc_connected;
+
+      for (int i = 0; i < get_shared_nhandlers (); i++)
+	{
+	  /* Should never happen. */
+	  if (shared_fc_handler[i].state != fc_connected)
+	    continue;
+	  if (add_client_handler (false) < 0)
+	    api_fatal ("Can't add client handler, %E");
+	  fifo_client_handler &fc = fc_handler[nhandlers - 1];
+	  if (!DuplicateHandle (prev_proc, shared_fc_handler[i].h,
+				GetCurrentProcess (), &fc.h, 0,
+				!close_on_exec (), DUPLICATE_SAME_ACCESS))
+	    {
+	      debug_printf ("Can't duplicate handle of previous owner, %E");
+	      --nhandlers;
+	      __seterrno ();
+	      return -1;
+	    }
+	  fc.state = fc_connected;
+	}
     }
   return 0;
 }
@@ -771,9 +797,9 @@ fhandler_fifo::open (int flags, mode_t)
       if (create_shared_fc_handler () < 0)
 	goto err_close_shmem;
       inc_nreaders ();
-      if (!(cancel_evt = create_event ()))
+      if (!(cancel_evt = create_event (true)))
 	goto err_dec_nreaders;
-      if (!(thr_sync_evt = create_event ()))
+      if (!(thr_sync_evt = create_event (true)))
 	goto err_close_cancel_evt;
       me.winpid = GetCurrentProcessId ();
       me.fh = this;
@@ -1338,9 +1364,9 @@ fhandler_fifo::dup (fhandler_base *child, int flags)
 	}
       if (fhf->reopen_shared_fc_handler () < 0)
 	goto err_close_shared_fc_hdl;
-      if (!(fhf->cancel_evt = create_event ()))
+      if (!(fhf->cancel_evt = create_event (true)))
 	goto err_close_shared_fc_handler;
-      if (!(fhf->thr_sync_evt = create_event ()))
+      if (!(fhf->thr_sync_evt = create_event (true)))
 	goto err_close_cancel_evt;
       inc_nreaders ();
       fhf->me.fh = fhf;
@@ -1389,9 +1415,17 @@ fhandler_fifo::fixup_after_fork (HANDLE parent)
 	/* Prevent a later attempt to close the non-inherited
 	   pipe-instance handles copied from the parent. */
 	nhandlers = 0;
-      if (!(cancel_evt = create_event ()))
+      else
+	{
+	  /* Close inherited handles needed only by exec. */
+	  if (cancel_evt)
+	    NtClose (cancel_evt);
+	  if (thr_sync_evt)
+	    NtClose (thr_sync_evt);
+	}
+      if (!(cancel_evt = create_event (true)))
 	api_fatal ("Can't create reader thread cancel event during fork, %E");
-      if (!(thr_sync_evt = create_event ()))
+      if (!(thr_sync_evt = create_event (true)))
 	api_fatal ("Can't create reader thread sync event during fork, %E");
       inc_nreaders ();
       me.winpid = GetCurrentProcessId ();
@@ -1414,10 +1448,32 @@ fhandler_fifo::fixup_after_exec ()
 	api_fatal ("Can't reopen shared fc_handler memory during exec, %E");
       fc_handler = NULL;
       nhandlers = shandlers = 0;
+
+      /* Cancel parent's reader thread */
+      if (cancel_evt)
+	SetEvent (cancel_evt);
+      if (thr_sync_evt)
+	WaitForSingleObject (thr_sync_evt, INFINITE);
+
+      /* Take ownership if parent is owner. */
+      fifo_reader_id_t parent_fr = me;
       me.winpid = GetCurrentProcessId ();
-      if (!(cancel_evt = create_event ()))
+      owner_lock ();
+      if (get_owner () == parent_fr)
+	{
+	  set_owner (me);
+	  if (update_my_handlers (true) < 0)
+	    api_fatal ("Can't update my handlers, %E");
+	}
+      owner_unlock ();
+      /* Close inherited cancel_evt and thr_sync_evt. */
+      if (cancel_evt)
+	NtClose (cancel_evt);
+      if (thr_sync_evt)
+	NtClose (thr_sync_evt);
+      if (!(cancel_evt = create_event (true)))
 	api_fatal ("Can't create reader thread cancel event during exec, %E");
-      if (!(thr_sync_evt = create_event ()))
+      if (!(thr_sync_evt = create_event (true)))
 	api_fatal ("Can't create reader thread sync event during exec, %E");
       /* At this moment we're a new reader.  The count will be
 	 decremented when the parent closes. */
@@ -1433,8 +1489,13 @@ fhandler_fifo::set_close_on_exec (bool val)
   set_no_inheritance (read_ready, val);
   set_no_inheritance (write_ready, val);
   set_no_inheritance (writer_opening, val);
-  fifo_client_lock ();
-  for (int i = 0; i < nhandlers; i++)
-    set_no_inheritance (fc_handler[i].h, val);
-  fifo_client_unlock ();
+  if (reader)
+    {
+      set_no_inheritance (cancel_evt, val);
+      set_no_inheritance (thr_sync_evt, val);
+      fifo_client_lock ();
+      for (int i = 0; i < nhandlers; i++)
+	set_no_inheritance (fc_handler[i].h, val);
+      fifo_client_unlock ();
+    }
 }
-- 
2.21.0

