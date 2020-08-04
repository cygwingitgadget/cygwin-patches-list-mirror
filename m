Return-Path: <kbrown@cornell.edu>
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2134.outbound.protection.outlook.com [40.107.223.134])
 by sourceware.org (Postfix) with ESMTPS id 54C65386186E
 for <cygwin-patches@cygwin.com>; Tue,  4 Aug 2020 12:55:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 54C65386186E
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qu4zeENzLMiPLdMxXTNUw5Lw/fkcFBO4M4dgiLKDM9aCwRwtGz1bTvU33qQFhaF6roUqybocF81OcAppi+9JEhfkjE9t1Ladn/RolfbE2WABk40y2JeCJj9YDcoBA1PMT7jpe8iA/GIg8GLfnhDFklWh7hVOTRNIJ5QsJTRKCY4IYFH6f6aouE1SwERDLFCUnW/Drv0E0OYk4I33ZFyqxPI3NIuOlEm7a+v//AzkGL9cuk91ZxwlUvtustTOFCClJt4obYyNhpkyz0+Sv7Bkn0VelFPkrP7q11JUQ+k3Exqbf9RrkrtByHM3v4mTQuIitefv0+MQGR07LUhQu3X7ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHCmaDnFB71B/LJTgPjID/ZcQnIv+nFEvzgndaiASUs=;
 b=hJmxPBC8E9FQL3YVSbSqsiOfPpiLkpS06+DCFuDrl7sBRUgJs+2u449xuNW2oyAbyAPw5PMvcJ1KoeEYPH/csEgrJGmbfguPPBzs0LHnSdqwi2vd9NJAx2ftbXZKHz2pBsBvNNa0RTTGKR3tWPqFZJXNO6kUI2ZysgUFNnzJR59N1HHFZszBClEq2GjDTypZJXmlLwCtHW2eQsV6BPRsMlpb60uQAhbZpEVdwMU5p9yXFIWJtIb7cuT2SrrqVmYVuXdjlXqAYb0fAF60K0sGFblYHzcGKNAIWvxiMAMRjPBk60SIU4PSBtxy3yGooGo8TJtRgnOM0PyXdRKKu0c8zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5903.namprd04.prod.outlook.com (2603:10b6:208:a4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Tue, 4 Aug
 2020 12:55:25 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a%7]) with mapi id 15.20.3239.021; Tue, 4 Aug 2020
 12:55:25 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 3/8] Cygwin: FIFO: add a timeout to take_ownership
Date: Tue,  4 Aug 2020 08:55:02 -0400
Message-Id: <20200804125507.8842-4-kbrown@cornell.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200804125507.8842-1-kbrown@cornell.edu>
References: <20200804125507.8842-1-kbrown@cornell.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:208:d4::37) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2604:6000:b407:7f00:8093:2a79:7de:1dbd)
 by MN2PR04CA0024.namprd04.prod.outlook.com (2603:10b6:208:d4::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Tue, 4 Aug 2020 12:55:25 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [2604:6000:b407:7f00:8093:2a79:7de:1dbd]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c347ab4-29f9-4a90-fc77-08d83875a80c
X-MS-TrafficTypeDiagnostic: MN2PR04MB5903:
X-Microsoft-Antispam-PRVS: <MN2PR04MB5903BC66905BFEA41CA4135FD84A0@MN2PR04MB5903.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lihCRiV1D3bmthnW2DgyE7B/36USo+hDeJVO+j82iEgo86U1p91iehcHGDfPx2jNPOZsFJSLyz90iyZdehqF6RGulhK+/e9tZjR4HBcDy1C44xYv7JmWVZZ4UlK82NAETD2XzJlJWM6X/Udhed59cmfkaA5Doj0n/XcClhs20ckWT51Nqc+mAd3a01/7DzQIiiZ7rKB+RV5r+QGKtqrwryO6iFysHNmm6WGTsZC9mCJxkefoFKXFi4vpF05149TeHIA2SOnsW2RjEFEqws25/DsFpzGYMeIL8MGc82L2c7cCoSbBAV5kk4Ecw+531A+5Sb4uhtjn/SgvUhab/3XoB17tsogBC0+Bsj8EbPP0+vPhYY3OMFSM0022UqaZDYZw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(2906002)(5660300002)(786003)(316002)(6666004)(6506007)(66946007)(86362001)(8676002)(6512007)(16526019)(186003)(1076003)(75432002)(2616005)(83380400001)(478600001)(66556008)(52116002)(69590400007)(6486002)(6916009)(36756003)(8936002)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: nMVFO1MkMNGuL2EJhEJsJu1OXvwWxtaw9VGx/4tTtzXYeRCdMBJgsEqwYZvnIV+8qNs1B84P1VLT6z8XFnA6FR5UhT54nxSD1uTujeErmw+ekvasQya06ltFJNeqArVBSci3+HfPvHQiJtsrkLDGv6Ysw4GKEkmR6ZA93ndVHTy8qSG086DEIFHHTs5bqvB8qajP/0++EeZ12i1QAJOERhfDHFH+XGygTQvwZN3OWTVaz9NJsOjtixvo5H0fDO9826fpPv8A19aE69k1xnV/k/JcJv09aS2s63+lXe78j3hmHtXV9+NwGq5vcwDtpcN4BLcsdlo3vNLTSc4SQdELsjupAwRE1DQvGmoYOUwoK4pCfHdMtF+/2Z2PO0xnUvZwwYo1+L5Y209RwsYThz3QPFBBdZ1UbulFmyKd6mLwkNMKXbcMKF/p9dVyr1f/WwK8+MycPSsIrKIobeCZK/YJstCyV2v/XLdl/IqQ5jDDmV4Ei52fRRyvGq0mormZEWUrfCrI7ODLt70Jwbu2AAMxeOShcyipozc6Qfc31Ou0nFNYTpn1VFih7M+GrmReDmEHw5DNYaZdrLZtnTRgkGh2Cc/8MicpAfqVQBeDPdPsVQ0AgWLs+452i04c3onQLZanlzm1P1L0vF8n3sucu22Y22z5DkYEHW/4inpiAuiGOXY11UP/OORND9ZU22oVibPnxi96hWWU1EI+tNbjdjrINA==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c347ab4-29f9-4a90-fc77-08d83875a80c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2020 12:55:25.7705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ADlTBo0LOOh3n43hVZKeYsATVsXTA5hqzgnnVQaInqJSjNFaMY15XekWT3S28PiPMOkizap4/R4vL8r0S+EjHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5903
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 04 Aug 2020 12:55:31 -0000

fhandler_fifo::take_ownership() is called from select.cc::peek_fifo
and fhandler_fifo::raw_read and could potentially block indefinitely
if something goes wrong.  This is always undesirable in peek_fifo, and
it is undesirable in a nonblocking read.  Fix this by adding a timeout
parameter to take_ownership.

Arbitrarily use a 1 ms timeout in peek_fifo and a 10 ms timeout in
raw_read.  These numbers may have to be tweaked based on experience.

Replace the call to cygwait in take_ownership by a call to WFSO.
There's no need to allow interruption now that we have a timeout.
---
 winsup/cygwin/fhandler.h       |  2 +-
 winsup/cygwin/fhandler_fifo.cc | 74 +++++++++++++---------------------
 winsup/cygwin/select.cc        |  7 +---
 3 files changed, 30 insertions(+), 53 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 60bd27e00..5488327a2 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1487,7 +1487,7 @@ public:
   void fifo_client_lock () { _fifo_client_lock.lock (); }
   void fifo_client_unlock () { _fifo_client_lock.unlock (); }
 
-  DWORD take_ownership ();
+  int take_ownership (DWORD timeout = INFINITE);
   void reading_lock () { shmem->reading_lock (); }
   void reading_unlock () { shmem->reading_unlock (); }
 
diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index 7b87aab00..b8a47f27f 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -1214,16 +1214,17 @@ fhandler_fifo::raw_write (const void *ptr, size_t len)
   return ret;
 }
 
-/* Called from raw_read and select.cc:peek_fifo.  Return WAIT_OBJECT_0
-   on success.  */
-DWORD
-fhandler_fifo::take_ownership ()
+/* Called from raw_read and select.cc:peek_fifo. */
+int
+fhandler_fifo::take_ownership (DWORD timeout)
 {
+  int ret = 0;
+
   owner_lock ();
   if (get_owner () == me)
     {
       owner_unlock ();
-      return WAIT_OBJECT_0;
+      return 0;
     }
   set_pending_owner (me);
   /* Wake up my fifo_reader_thread. */
@@ -1233,18 +1234,25 @@ fhandler_fifo::take_ownership ()
     SetEvent (update_needed_evt);
   owner_unlock ();
   /* The reader threads should now do the transfer. */
-  DWORD waitret = cygwait (owner_found_evt, cw_cancel | cw_sig_eintr);
-  owner_lock ();
-  if (waitret == WAIT_OBJECT_0
-      && (get_owner () != me || get_pending_owner ()))
+  switch (WaitForSingleObject (owner_found_evt, timeout))
     {
-      /* Something went wrong.  Return WAIT_TIMEOUT, which can't be
-	 returned by the above cygwait call. */
-      set_pending_owner (null_fr_id);
-      waitret = WAIT_TIMEOUT;
+    case WAIT_OBJECT_0:
+      owner_lock ();
+      if (get_owner () != me)
+	{
+	  debug_printf ("owner_found_evt signaled, but I'm not the owner");
+	  ret = -1;
+	}
+      owner_unlock ();
+      break;
+    case WAIT_TIMEOUT:
+      debug_printf ("timed out");
+      ret = -1;
+    default:
+      debug_printf ("WFSO failed, %E");
+      ret = -1;
     }
-  owner_unlock ();
-  return waitret;
+  return ret;
 }
 
 void __reg3
@@ -1255,38 +1263,12 @@ fhandler_fifo::raw_read (void *in_ptr, size_t& len)
 
   while (1)
     {
+      int nconnected = 0;
+
       /* No one else can take ownership while we hold the reading_lock. */
       reading_lock ();
-      switch (take_ownership ())
-	{
-	case WAIT_OBJECT_0:
-	  break;
-	case WAIT_SIGNALED:
-	  if (_my_tls.call_signal_handler ())
-	    {
-	      reading_unlock ();
-	      continue;
-	    }
-	  else
-	    {
-	      set_errno (EINTR);
-	      reading_unlock ();
-	      goto errout;
-	    }
-	  break;
-	case WAIT_CANCELED:
-	  reading_unlock ();
-	  pthread::static_cancel_self ();
-	  break;
-	case WAIT_TIMEOUT:
-	  reading_unlock ();
-	  debug_printf ("take_ownership returned an unexpected result; retry");
-	  continue;
-	default:
-	  reading_unlock ();
-	  debug_printf ("unknown error while trying to take ownership, %E");
-	  goto errout;
-	}
+      if (take_ownership (10) < 0)
+	goto maybe_retry;
 
       /* Poll the connected clients for input.  Make two passes.  On
 	 the first pass, just try to read from the client from which
@@ -1332,7 +1314,6 @@ fhandler_fifo::raw_read (void *in_ptr, size_t& len)
 	}
 
       /* Second pass. */
-      int nconnected = 0;
       for (int i = 0; i < nhandlers; i++)
 	if (fc_handler[i].state >= fc_closing)
 	  {
@@ -1375,6 +1356,7 @@ fhandler_fifo::raw_read (void *in_ptr, size_t& len)
 	  len = 0;
 	  return;
 	}
+maybe_retry:
       reading_unlock ();
       if (is_nonblocking ())
 	{
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index 3f3f33fb5..1ba76c817 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -867,16 +867,11 @@ peek_fifo (select_record *s, bool from_select)
 	}
 
       fh->reading_lock ();
-      if (fh->take_ownership () != WAIT_OBJECT_0)
+      if (fh->take_ownership (1) < 0)
 	{
-	  select_printf ("%s, unable to take ownership", fh->get_name ());
 	  fh->reading_unlock ();
-	  gotone += s->read_ready = true;
-	  if (s->except_selected)
-	    gotone += s->except_ready = true;
 	  goto out;
 	}
-
       fh->fifo_client_lock ();
       int nconnected = 0;
       for (int i = 0; i < fh->get_nhandlers (); i++)
-- 
2.28.0

