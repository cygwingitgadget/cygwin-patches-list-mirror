Return-Path: <kbrown@cornell.edu>
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2126.outbound.protection.outlook.com [40.107.236.126])
 by sourceware.org (Postfix) with ESMTPS id 4886E3890425
 for <cygwin-patches@cygwin.com>; Thu, 16 Jul 2020 16:19:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 4886E3890425
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6f4aptsbD/iSYvIdHZLLDP2r6e2oDxB2R3EdPDXSYjue1bkVetJtJh48Z+3TEJLvzK984v09VvLYqw7ubLD+LDJ3Sxql+gsqcElicGlwdI1MDXfXs23sHuwUCtuEioZte4QhSSjekB+ox4BrcfmYCtRLdMZMdEoZiVefA8eecklkzBF7tSEX7SrJM0j832sAAECeOp/Fg7h8Zk52FzeIo0L7iP4+xvOnwBaQrW/r7A5oTPItHgw+oQViF0yxasEhMxO9eZ2P/HePBjPeJ8FT9aKMsCp7/DxyPA+M+4h/qScYDxxVdhZ2iZiCme8nvSZGLBoZMDVZ3xdG8cYAWI96w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7HhqrkBm4uhCR9c2+lLWCcUwU62lBgEu6yhurncyIE=;
 b=jfI9T8FnD0nCzMVERYTngA9VwevZzGEAGtMkw5Xm6wFCmGaF8Rq3yNFS2DvN30IR0I07+H68+CPhqoF3xlfHiQehYE5r+qXMccHtWqbDBBJcmrEKKvOO3tTbhFqKAz4YC8kkCQNdmyn8/om9KXHh7MCwpWWQqxn3OgR8akLOGKqvFK4lwDsgvcePzqaD1jG5zkyyi/MzxWFpaaLOYJp0MeidFkKv4yvn1XVtTx41Kqzlv7A528BVuS0OSRN9MtFHGsPPQg5FDUTe0anr3gv35azD8WST/D2Cz3UTirfCm7hJQz2m31qCjnolBvD4gZlMjorlSUXuc0kuzVLXHbmLgQ==
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
Subject: [PATCH 01/12] Cygwin: FIFO: fix problems finding new owner
Date: Thu, 16 Jul 2020 12:19:04 -0400
Message-Id: <20200716161915.16994-2-kbrown@cornell.edu>
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
X-MS-Office365-Filtering-Correlation-Id: e161e6ae-9e8f-492c-3d2e-08d829a40693
X-MS-TrafficTypeDiagnostic: MN2PR04MB6112:
X-Microsoft-Antispam-PRVS: <MN2PR04MB61129947F35C93245B497ADBD87F0@MN2PR04MB6112.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7nFvZzLSYZ+dFchZNRs57M5Ylsf+iuOwA17bP8sfWwy5avAmCvwnyhhp6c3Bbc9saGjSHYsdHfxE4d1+OUCyV/dx+4XHCTLcTMjpzwgRHeX66jlWuoD4cS4mmpG58l0+bf+zO5EboIZVbea1fZ9HsRhMQwAZMxAEzCzHasA6wyiCzW3Z88R6V36p6G4M0wl/YkIhKsATvHZ6Qxh2ZhzOS1yRxittd9jkAM586voJEmsFXXrKnB/55cHSW3IElpVwf3VqfcSC7zlAO0RmQ1k/4tHsawDsyDPBdg8OKThkTF7JfvpL/m2feP16wzQliqwCUarrFeprTmFY+S76CKOcig0A3eridLTB6Ig2Z+leokEYDNYjn7+NdAHkhR1M04uo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(66946007)(2616005)(66556008)(5660300002)(69590400007)(6506007)(8676002)(83380400001)(16526019)(956004)(6486002)(6512007)(52116002)(186003)(26005)(8936002)(66476007)(478600001)(2906002)(86362001)(316002)(786003)(75432002)(1076003)(6666004)(6916009)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: CnCrYCombxNkkFppW5jAaHVuZ/2/xzqoc4uOa+RqOOHRNYwPFTGhqgBbyW8ZI0wbHg5nLfyI8TeAwgg+FiVvsUXizXJzfyAabaZ3sxLo2q3cJX5zqsDITJVzStEekOuvGG/75LbR5eYJJUR0FC7LoWCFEu0COWnYaS8NToemqr3QBQFvU86i326YlXQ98/muVhK7TO2mDvC/IXjep+0LRl0XPu/59ZcyrncBTjxTtJ8j/6rNERCUcBY0csDouwEzXUFqzC1LFm87rlzr9CPDnL0ezoCNCRGFq9ZfVFy61D+BMNtTKJM0cQp2DwG1iyspHplGSs13C9SSb0S29hIu2G8BX5XBb//YQO6IGR5g55TPEQusnF0TLtbVHBNtMruSP4y6Y5/PwBZ30aLFIqHZtcJrvGJ9ftqR5EKDDcpAi7Jr+q/VRmCBJJkv95vt/r0pk2/XS4VsW88wPz3ae3hXnnNwqCTKMgDKRGU6NbtWfSU=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: e161e6ae-9e8f-492c-3d2e-08d829a40693
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 16:19:33.6232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xnOTwyd6XG8o5lRHzt5ujW9a1QwzpFYNsOg3kIDrLwphZLAeiPtFfFO/L0fBIja3v81z7vrYn9pYfBP+SDwbtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6112
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 16 Jul 2020 16:19:40 -0000

When the owning reader closes and there are still readers open, the
owner needs to wait for a new owner to be found before closing its
fifo_client handlers.  This involves a loop in which dec_nreaders is
called at the beginning and inc_nreaders is called at the end.  Any
other reader that tries to access shmem->_nreaders during this loop
will therefore get an inaccurate answer.

Fix this by adding an nreaders method and using it instead of
dec_nreaders and inc_nreaders.  Also add nreaders_lock to control
access to the shmem->_nreaders.

Make various other changes to improve the reliability of finding a new
owner.
---
 winsup/cygwin/fhandler.h       |  8 +++-
 winsup/cygwin/fhandler_fifo.cc | 86 +++++++++++++++++++++-------------
 2 files changed, 61 insertions(+), 33 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 7a28adc16..cf6daea06 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1328,7 +1328,7 @@ class fifo_shmem_t
 {
   LONG _nreaders;
   fifo_reader_id_t _owner, _prev_owner, _pending_owner;
-  af_unix_spinlock_t _owner_lock, _reading_lock, _reader_opening_lock;
+  af_unix_spinlock_t _owner_lock, _reading_lock, _reader_opening_lock, _nreaders_lock;
 
   /* Info about shared memory block used for temporary storage of the
      owner's fc_handler list. */
@@ -1336,6 +1336,7 @@ class fifo_shmem_t
     _sh_fc_handler_updated;
 
 public:
+  int nreaders () const { return (int) _nreaders; }
   int inc_nreaders () { return (int) InterlockedIncrement (&_nreaders); }
   int dec_nreaders () { return (int) InterlockedDecrement (&_nreaders); }
 
@@ -1352,6 +1353,8 @@ public:
   void reading_unlock () { _reading_lock.unlock (); }
   void reader_opening_lock () { _reader_opening_lock.lock (); }
   void reader_opening_unlock () { _reader_opening_lock.unlock (); }
+  void nreaders_lock () { _nreaders_lock.lock (); }
+  void nreaders_unlock () { _nreaders_lock.unlock (); }
 
   int get_shared_nhandlers () const { return (int) _sh_nhandlers; }
   void set_shared_nhandlers (int n) { InterlockedExchange (&_sh_nhandlers, n); }
@@ -1420,8 +1423,11 @@ class fhandler_fifo: public fhandler_base
   int reopen_shared_fc_handler ();
   int remap_shared_fc_handler (size_t);
 
+  int nreaders () const { return shmem->nreaders (); }
   int inc_nreaders () { return shmem->inc_nreaders (); }
   int dec_nreaders () { return shmem->dec_nreaders (); }
+  void nreaders_lock () { shmem->nreaders_lock (); }
+  void nreaders_unlock () { shmem->nreaders_unlock (); }
 
   fifo_reader_id_t get_prev_owner () const { return shmem->get_prev_owner (); }
   void set_prev_owner (fifo_reader_id_t fr_id)
diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index 3d34cdfab..2d4f7a97e 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -371,6 +371,8 @@ fhandler_fifo::record_connection (fifo_client_handler& fc,
 int
 fhandler_fifo::update_my_handlers ()
 {
+  int ret = 0;
+
   close_all_handlers ();
   fifo_reader_id_t prev = get_prev_owner ();
   if (!prev)
@@ -387,7 +389,7 @@ fhandler_fifo::update_my_handlers ()
     {
       debug_printf ("Can't open process of previous owner, %E");
       __seterrno ();
-      return -1;
+      goto out;
     }
 
   for (int i = 0; i < get_shared_nhandlers (); i++)
@@ -402,11 +404,13 @@ fhandler_fifo::update_my_handlers ()
 	  debug_printf ("Can't duplicate handle of previous owner, %E");
 	  --nhandlers;
 	  __seterrno ();
-	  return -1;
+	  goto out;
 	}
       fc.state = shared_fc_handler[i].state;
     }
-  return 0;
+out:
+  set_prev_owner (null_fr_id);
+  return ret;
 }
 
 int
@@ -1414,41 +1418,59 @@ fhandler_fifo::close ()
 {
   if (reader)
     {
-      /* If we're the owner, try to find a new owner. */
-      bool find_new_owner = false;
+      /* If we're the owner, we can't close our fc_handlers if a new
+	 owner might need to duplicate them. */
+      bool close_fc_ok = false;
 
       cancel_reader_thread ();
-      owner_lock ();
-      if (get_owner () == me)
+      nreaders_lock ();
+      if (dec_nreaders () == 0)
 	{
-	  find_new_owner = true;
+	  close_fc_ok = true;
+	  ResetEvent (read_ready);
+	  ResetEvent (owner_needed_evt);
+	  ResetEvent (owner_found_evt);
 	  set_owner (null_fr_id);
-	  set_prev_owner (me);
-	  owner_needed ();
+	  set_prev_owner (null_fr_id);
+	  set_pending_owner (null_fr_id);
+	  set_shared_nhandlers (0);
 	}
-      owner_unlock ();
-      if (dec_nreaders () == 0)
-	ResetEvent (read_ready);
-      else if (find_new_owner && !IsEventSignalled (owner_found_evt))
+      else
 	{
-	  bool found = false;
-	  do
-	    if (dec_nreaders () >= 0)
-	      {
-		/* There's still another reader open. */
-		if (WaitForSingleObject (owner_found_evt, 1) == WAIT_OBJECT_0)
-		  found = true;
-		else
-		  {
-		    owner_lock ();
-		    if (get_owner ()) /* We missed owner_found_evt? */
-		      found = true;
-		    else
-		      owner_needed ();
-		    owner_unlock ();
-		  }
-	      }
-	  while (inc_nreaders () > 0 && !found);
+	  owner_lock ();
+	  if (get_owner () != me)
+	    close_fc_ok = true;
+	  else
+	    {
+	      set_owner (null_fr_id);
+	      set_prev_owner (me);
+	      if (!get_pending_owner ())
+		owner_needed ();
+	    }
+	  owner_unlock ();
+	}
+      nreaders_unlock ();
+      while (!close_fc_ok)
+	{
+	  if (WaitForSingleObject (owner_found_evt, 1) == WAIT_OBJECT_0)
+	    close_fc_ok = true;
+	  else
+	    {
+	      nreaders_lock ();
+	      if (!nreaders ())
+		{
+		  close_fc_ok = true;
+		  nreaders_unlock ();
+		}
+	      else
+		{
+		  nreaders_unlock ();
+		  owner_lock ();
+		  if (get_owner () || get_prev_owner () != me)
+		    close_fc_ok = true;
+		  owner_unlock ();
+		}
+	    }
 	}
       close_all_handlers ();
       if (fc_handler)
-- 
2.27.0

