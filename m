Return-Path: <kbrown@cornell.edu>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770133.outbound.protection.outlook.com [40.107.77.133])
 by sourceware.org (Postfix) with ESMTPS id 241FC396E85B
 for <cygwin-patches@cygwin.com>; Thu,  7 May 2020 20:22:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 241FC396E85B
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9YUszr6LJRYcVtQ8betOUK154x2WQIwRDAnSKhgNai9XoylqDLGML2hBZek4DjUMAKzehNmSo5jNlK+regBq78Gm+KMfCZ7SLXX/tNldEcLTOHO1XhdZ06ndWJyDVOhfCmMO4gV85U5NY7OS+50VBx/u91jnkLLp50WG00CoVYifjboyyA0VGtK18oYH0WoWiONSlsy5RqZ3Q0E1coGLAjlL30s9XYvGrmjAwf7nGH6sQ4VGp2D0ZfTc9JMK/Sv7XOPH37uAywZvZKKy6VExo+qgpAW4rjlWn4YKSwWosCisQG9V7Sd53ZRgj9E8pvKgHGiUu6Pdl4gAC3Mds8n+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CRZA1GVh6TsCVrGg73o29xuF8pZvvxPGO/H8tdKPQs=;
 b=CYnBaMzfD1jJXY/oocp23DV+BB2T1iD1q0Jy0jXStluUIWN2i2loXnQbQxwFJt+xZaDlzwArzCxCFyATF8aaOclfSubgXWoCJXCpBXYO18dyTSp2p3VEVZpZDlp1PI5WoihEnViTvaZyw2gPdma/dP5LGVw8zW5kfnaI6K3RKWJVo9LtYGM/qkb7sI1oHOIU67ap6Dut7ndk3lJ3tZ6Ub+9Q2wQJKk0IK91sf1VL0poTN99NJGfwBJ6Y2fuKmEEeJPnQ5Y00qUbzVLvnnpbSIJ0CVNufCaUpPyLwTfOYkWKm1Q86XDOvWZIVdpMNCtPK547kGH4ywzZ/KP+M/07WPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from DM6PR04MB6075.namprd04.prod.outlook.com (2603:10b6:5:127::31)
 by DM6PR04MB6075.namprd04.prod.outlook.com (2603:10b6:5:127::31) with
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
Subject: [PATCH 18/21] Cygwin: FIFO: find a new owner when closing
Date: Thu,  7 May 2020 16:21:21 -0400
Message-Id: <20200507202124.1463-19-kbrown@cornell.edu>
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
X-MS-Office365-Filtering-Correlation-Id: 9efba4a8-3f31-42df-eb90-08d7f2c44a93
X-MS-TrafficTypeDiagnostic: DM6PR04MB6075:
X-Microsoft-Antispam-PRVS: <DM6PR04MB6075442D3EB2982F24F0CED3D8A50@DM6PR04MB6075.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:561;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MicqpW3WTEwDiai3GNxKzZJkgpbuVNdu7zchVhAKKV+8y6+uk+fZTc9nzyVyXyYxcBCaFeu1YNmtsvrpSIbRkcC2o8jErk2/v2U4PKZmfvUGlXYpm5SsjiXeBtDssjEgGjzO9LceCvZZLZP/q1y4wY47TRPwe4uIt1gkSUtjyUb6kf+QpeBuO7MnKgEDhmLi5NDO8jDpLiv5fESMYD+TpA9/3JTTe43nsDcVOvjz7lAVPpFq+FzyCaOY7K6jMehUgDvSF+Q2qiVImj0KCqSQGLEFX1M4ZKP4+XCY9lRDaSKLEH6R2/LpZS0uqAgExc48nb87w4FqUExIfwutLt0GJgSaHgzdhYSqb8ydd2gpWss+Yt3nSTVPE7+CJoY3H6nD9/zCSTXXHKt4grF9PmW31PCYzdCbz8O2SDYAuflkQfWcTIZDpD58XZRwZh5aP3TDOcroqzotBTh1raZupU0PawxFIqnlqhnB0LEkp95WLpjmXQdgze1PEGedbrZGROJpPYZn7k0aybVvtUyj5O4H8BB48gPCbXXfF7jMuZXBsJB654Ji48qropBsNsvjtFTF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6075.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(33430700001)(33440700001)(6512007)(6486002)(478600001)(786003)(8676002)(66946007)(1076003)(5660300002)(8936002)(83300400001)(66476007)(316002)(83320400001)(83280400001)(83310400001)(83290400001)(66556008)(69590400007)(75432002)(36756003)(2616005)(4326008)(86362001)(6666004)(2906002)(6916009)(186003)(6506007)(16526019)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: M4grvbknVfNjrYeqVZC4RrxwNLQgXkWE/6ymcniqozG3e+jGBPJxorVT1+kbqP+0xtlrmSrL4i74dxivxBbtehCAyArNE/ljPdzQzRi/u0lGg0yjRTMfBHbd3PrTTHHQ0YWmCwEekK3fh8cEiG53HDfMaBoZ4ndQT7HU/Kl9tO4D/5ki1zNKAFi3pMYPW6Noca8BKgNtvEFdMqdvBb+7e5OdS6/349tTqPi5jv1GgrRyCZC21e3UjT3ZiPA3cu8ijtnVufKDl7iBSMJiOw/WXHl1b9B+y86ZsXX+eAhXKZYJlDHluuxwKt5ObTu1dhc4A3qZbj0Jqwjs7dzUb1cU93D9vkpIhXrYO1E+0aPE4kiz9fYTw8YWeRordUyoXG8DiDu2Fj/5lsq4IxfLUfQ27YebZQY84fQRdefyUy9yyMQhaethpwcnseaJvxG3daDk4eqjdHrIWC4rwp13/8oGlOpdBfxlESlwwE7xsIS432lxAiRwliCOrc53IWipMBzRcCI0pvwPvv2D0C/xWMEcTq4WlKGprmwuKTn9oub0OZmrT4a4EftRPN5WQynPXYFT/xco9+Y/YjjRnVZRC3hUDCfMg80h6e0i+tatQ+M2kUnf8AZbHFvJcUExc5+5MyoxfE8RuWOjdmTVYoB/Srm0JBgMIN5Z/wNvOxJGWxhK+vhQEl3/I8NkyEruoGkdbSRoD5YbYTLfHRAspLAnQDvdDlwXBb5pcSGgHAObbDUPLPrcqjs81IxDDbmq0v5wqGSrtvMPZKJVvJ0UM1IGbstfnkX+pR5WO3vpbrkpTewRs1R0mMFeM/NXS1AsF0hqtND/klfBQttG69Z3utWF20BHEl8Y2C2TWp+AdFRjeER85IVQSxvGgtWIxn/8CuZIxIls
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9efba4a8-3f31-42df-eb90-08d7f2c44a93
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 20:21:57.7053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Z7DNhHGE2jAg9C8k7/LZ/4gtBYt4eSCnNkzBYYrt755LpsnNdcp6sIO15XzdQFEbP/3IbKazWjs0lMb4PKmSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6075
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 07 May 2020 20:22:20 -0000

If the owning reader is closing, wait for another reader (if there is
one) to take ownership before closing the owner's pipe handles.

To synchronize the ownership transfer, add events owner_needed_evt and
owner_found_evt, and add methods owner_needed and owner_found to
set/reset them.

Modify the fifo_reader_thread function to wake up all non-owners when
a new owner is needed.

Make a cosmetic change in close so that fhandler_base::close is called
only if we have a write handle.  This prevents strace output from
being littered with statements that the null handle is being closed.
---
 winsup/cygwin/fhandler.h       |  14 +++++
 winsup/cygwin/fhandler_fifo.cc | 109 +++++++++++++++++++++++++++++----
 2 files changed, 112 insertions(+), 11 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 1cd7d2b11..f8c1b52a4 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1359,6 +1359,10 @@ class fhandler_fifo: public fhandler_base
   HANDLE write_ready;           /* A writer is open; OK for a reader to open. */
   HANDLE writer_opening;        /* A writer is opening; no EOF. */
 
+  /* Handles to named events needed by all readers of a given FIFO. */
+  HANDLE owner_needed_evt;      /* The owner is closing. */
+  HANDLE owner_found_evt;       /* A new owner has taken over. */
+
   /* Handles to non-shared events needed for fifo_reader_threads. */
   HANDLE cancel_evt;            /* Signal thread to terminate. */
   HANDLE thr_sync_evt;          /* The thread has terminated. */
@@ -1405,6 +1409,16 @@ class fhandler_fifo: public fhandler_base
   fifo_reader_id_t get_prev_owner () const { return shmem->get_prev_owner (); }
   void set_prev_owner (fifo_reader_id_t fr_id)
   { shmem->set_prev_owner (fr_id); }
+  void owner_needed ()
+  {
+    ResetEvent (owner_found_evt);
+    SetEvent (owner_needed_evt);
+  }
+  void owner_found ()
+  {
+    ResetEvent (owner_needed_evt);
+    SetEvent (owner_found_evt);
+  }
 
   int get_shared_nhandlers () { return shmem->get_shared_nhandlers (); }
   void set_shared_nhandlers (int n) { shmem->set_shared_nhandlers (n); }
diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index 1c59bb3f4..bf33a52d6 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -74,6 +74,7 @@ static NO_COPY fifo_reader_id_t null_fr_id = { .winpid = 0, .fh = NULL };
 fhandler_fifo::fhandler_fifo ():
   fhandler_base (),
   read_ready (NULL), write_ready (NULL), writer_opening (NULL),
+  owner_needed_evt (NULL), owner_found_evt (NULL),
   cancel_evt (NULL), thr_sync_evt (NULL), _maybe_eof (false),
   fc_handler (NULL), shandlers (0), nhandlers (0),
   reader (false), writer (false), duplexer (false),
@@ -464,14 +465,23 @@ fhandler_fifo::fifo_reader_thread_func ()
 	  set_owner (me);
 	  if (update_my_handlers () < 0)
 	    api_fatal ("Can't update my handlers, %E");
+	  owner_found ();
 	  owner_unlock ();
 	  continue;
 	}
       else if (cur_owner != me)
 	{
 	  owner_unlock ();
-	  WaitForSingleObject (cancel_evt, INFINITE);
-	  goto canceled;
+	  HANDLE w[2] = { owner_needed_evt, cancel_evt };
+	  switch (WaitForMultipleObjects (2, w, false, INFINITE))
+	    {
+	    case WAIT_OBJECT_0:
+	      continue;
+	    case WAIT_OBJECT_0 + 1:
+	      goto canceled;
+	    default:
+	      api_fatal ("WFMO failed, %E");
+	    }
 	}
       else
 	{
@@ -797,8 +807,23 @@ fhandler_fifo::open (int flags, mode_t)
       if (create_shared_fc_handler () < 0)
 	goto err_close_shmem;
       inc_nreaders ();
+      npbuf[0] = 'n';
+      if (!(owner_needed_evt = CreateEvent (sa_buf, true, false, npbuf)))
+	{
+	  debug_printf ("CreateEvent for %s failed, %E", npbuf);
+	  __seterrno ();
+	  goto err_dec_nreaders;
+	}
+      npbuf[0] = 'f';
+      if (!(owner_found_evt = CreateEvent (sa_buf, true, false, npbuf)))
+	{
+	  debug_printf ("CreateEvent for %s failed, %E", npbuf);
+	  __seterrno ();
+	  goto err_close_owner_needed_evt;
+	}
+      /* Make cancel and sync inheritable for exec. */
       if (!(cancel_evt = create_event (true)))
-	goto err_dec_nreaders;
+	goto err_close_owner_found_evt;
       if (!(thr_sync_evt = create_event (true)))
 	goto err_close_cancel_evt;
       me.winpid = GetCurrentProcessId ();
@@ -918,6 +943,10 @@ err_close_reader:
   return 0;
 err_close_cancel_evt:
   NtClose (cancel_evt);
+err_close_owner_found_evt:
+  NtClose (owner_found_evt);
+err_close_owner_needed_evt:
+  NtClose (owner_needed_evt);
 err_dec_nreaders:
   if (dec_nreaders () == 0)
     ResetEvent (read_ready);
@@ -1255,13 +1284,49 @@ fhandler_fifo::close ()
 {
   if (reader)
     {
-      if (dec_nreaders () == 0)
-	ResetEvent (read_ready);
+      /* If we're the owner, try to find a new owner. */
+      bool find_new_owner = false;
+
       cancel_reader_thread ();
       owner_lock ();
       if (get_owner () == me)
-	set_owner (null_fr_id);
+	{
+	  find_new_owner = true;
+	  set_owner (null_fr_id);
+	  set_prev_owner (me);
+	  owner_needed ();
+	}
       owner_unlock ();
+      if (dec_nreaders () == 0)
+	ResetEvent (read_ready);
+      else if (find_new_owner && !IsEventSignalled (owner_found_evt))
+	{
+	  bool found = false;
+	  do
+	    if (dec_nreaders () >= 0)
+	      {
+		/* There's still another reader open. */
+		if (WaitForSingleObject (owner_found_evt, 1) == WAIT_OBJECT_0)
+		  found = true;
+		else
+		  {
+		    owner_lock ();
+		    if (get_owner ()) /* We missed owner_found_evt? */
+		      found = true;
+		    else
+		      owner_needed ();
+		    owner_unlock ();
+		  }
+	      }
+	  while (inc_nreaders () > 0 && !found);
+	}
+      close_all_handlers ();
+      if (fc_handler)
+	free (fc_handler);
+      if (owner_needed_evt)
+	NtClose (owner_needed_evt);
+      if (owner_found_evt)
+	NtClose (owner_found_evt);
       if (cancel_evt)
 	NtClose (cancel_evt);
       if (thr_sync_evt)
@@ -1281,10 +1346,10 @@ fhandler_fifo::close ()
     NtClose (write_ready);
   if (writer_opening)
     NtClose (writer_opening);
-  close_all_handlers ();
-  if (fc_handler)
-    free (fc_handler);
-  return fhandler_base::close ();
+  if (nohandle ())
+    return 0;
+  else
+    return fhandler_base::close ();
 }
 
 /* If we have a write handle (i.e., we're a duplexer or a writer),
@@ -1364,8 +1429,22 @@ fhandler_fifo::dup (fhandler_base *child, int flags)
 	}
       if (fhf->reopen_shared_fc_handler () < 0)
 	goto err_close_shared_fc_hdl;
+      if (!DuplicateHandle (GetCurrentProcess (), owner_needed_evt,
+			    GetCurrentProcess (), &fhf->owner_needed_evt,
+			    0, !(flags & O_CLOEXEC), DUPLICATE_SAME_ACCESS))
+	{
+	  __seterrno ();
+	  goto err_close_shared_fc_handler;
+	}
+      if (!DuplicateHandle (GetCurrentProcess (), owner_found_evt,
+			    GetCurrentProcess (), &fhf->owner_found_evt,
+			    0, !(flags & O_CLOEXEC), DUPLICATE_SAME_ACCESS))
+	{
+	  __seterrno ();
+	  goto err_close_owner_needed_evt;
+	}
       if (!(fhf->cancel_evt = create_event (true)))
-	goto err_close_shared_fc_handler;
+	goto err_close_owner_found_evt;
       if (!(fhf->thr_sync_evt = create_event (true)))
 	goto err_close_cancel_evt;
       inc_nreaders ();
@@ -1375,6 +1454,10 @@ fhandler_fifo::dup (fhandler_base *child, int flags)
   return 0;
 err_close_cancel_evt:
   NtClose (fhf->cancel_evt);
+err_close_owner_found_evt:
+  NtClose (fhf->owner_found_evt);
+err_close_owner_needed_evt:
+  NtClose (fhf->owner_needed_evt);
 err_close_shared_fc_handler:
   NtUnmapViewOfSection (GetCurrentProcess (), fhf->shared_fc_handler);
 err_close_shared_fc_hdl:
@@ -1411,6 +1494,8 @@ fhandler_fifo::fixup_after_fork (HANDLE parent)
       fork_fixup (parent, shared_fc_hdl, "shared_fc_hdl");
       if (reopen_shared_fc_handler () < 0)
 	api_fatal ("Can't reopen shared fc_handler memory during fork, %E");
+      fork_fixup (parent, owner_needed_evt, "owner_needed_evt");
+      fork_fixup (parent, owner_found_evt, "owner_found_evt");
       if (close_on_exec ())
 	/* Prevent a later attempt to close the non-inherited
 	   pipe-instance handles copied from the parent. */
@@ -1491,6 +1576,8 @@ fhandler_fifo::set_close_on_exec (bool val)
   set_no_inheritance (writer_opening, val);
   if (reader)
     {
+      set_no_inheritance (owner_needed_evt, val);
+      set_no_inheritance (owner_found_evt, val);
       set_no_inheritance (cancel_evt, val);
       set_no_inheritance (thr_sync_evt, val);
       fifo_client_lock ();
-- 
2.21.0

