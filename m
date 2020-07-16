Return-Path: <kbrown@cornell.edu>
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2126.outbound.protection.outlook.com [40.107.236.126])
 by sourceware.org (Postfix) with ESMTPS id 4DF073892471
 for <cygwin-patches@cygwin.com>; Thu, 16 Jul 2020 16:19:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 4DF073892471
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8ecD7vieonKrWgeij6n57xPgXMUxqbrwIczeWI9ATho7iKdfC9RBy+7o/qcUPvPPq/p3KmVtZcpM3/Iq05+U4oRsCe7crdCWm0pRd7M4yHITh4QX5nUbql0X6AAyHlNfgKJsku8qhJu2kY9+ADUgo/gGwu0yD3zAs1W0OiRdgFTVN4sFH5r9bThWnz024nlO4OMhM0N6/YS66OL6naSeT1/C8n9r7G+dQQoe5pXJKbnwsH4INqiMaoWzGg2nc3p/ssvXO8+SBA+ubaXO4v+5XHQ3l9snwKI98Aq46SwAgXtm5+HBRxoqlzPsieRxyQtkHrMDnQsc150PYbKTBcwPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgkZGB2mLwE3cP+rfhFQPeK85vviBB1+7htaKWoThfg=;
 b=NFIELCOXnxEHdHXWHI77m40TF8WPNXf+oCS++K1F9rNbJPmJ2PBNhOwiyXkd1io3qR5h7t7w5srlFl3BGCwcwe7Bwzvl8YRu8NqcExnKCgIwL1CBcmMUPlqtosak52WLfFvq8P6qtZxk7ZqIC/pIJHN9/0PC0JeT78FfBzg96W99PbCEGvQZQhrCHkzspgbGK+CV0U4RQEZClh1g3T6HVAuwpR3fOhP3zF2IuLUipDNvkjX3eGiqstAcvAljLl6/6Uj4y36nhj91ds3nw/DsURafl2MUpshbVdrWyJGrWkLXVF4N76O2dPaczjpYniIGBYY7aLwhs/qtEe+i8SXx9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB6112.namprd04.prod.outlook.com (2603:10b6:208:e0::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 16 Jul
 2020 16:19:38 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a%7]) with mapi id 15.20.3174.025; Thu, 16 Jul 2020
 16:19:38 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 10/12] Cygwin: FIFO: allow take_ownership to be interrupted
Date: Thu, 16 Jul 2020 12:19:13 -0400
Message-Id: <20200716161915.16994-11-kbrown@cornell.edu>
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
 Transport; Thu, 16 Jul 2020 16:19:37 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [68.175.129.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59d7d844-ff2b-4b04-2f24-08d829a4095c
X-MS-TrafficTypeDiagnostic: MN2PR04MB6112:
X-Microsoft-Antispam-PRVS: <MN2PR04MB61123FD245B972765F518971D87F0@MN2PR04MB6112.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sNlLGlrUk2dU0Tvn/mGmOi54+co5DJAeJFYQpLmZq8nmYE/mqFkaxtA2JX892ouBzg7ZJ5dI5rqGv05ibbcj+9DBAC26odUfLwvcWIHf4T8AUxN6Ly3HMDVQ2wDRBSY9fA0uDzo3tr6K5XTEa/ydRQKvnKs4SZNP7FBwabYy58RrvpQVJLw03lcJsSydQXMbaYv0QyJiuyZSzPWPjc+pt6bdfOGcZRl31O250nFmNFOPVfil61fybuu9tm2asExm6X9JLkMUDaYQ2k6CbGB4BbHYQsxnGXNBvG2bw+NLup2URJiGjTU3q8BR9RPh2kJ9dxN5Tx3NZ0DEovzUDAAHsvl9vxCwCWJl37MSQmXv8f/YzNJ9bgH/9oqtyaOect+o
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(66946007)(2616005)(66556008)(5660300002)(69590400007)(6506007)(8676002)(83380400001)(16526019)(956004)(6486002)(6512007)(52116002)(186003)(26005)(8936002)(66476007)(478600001)(2906002)(86362001)(316002)(786003)(75432002)(1076003)(6666004)(6916009)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 7Iak4p4t9s4KJrb5nXY0vFWCJ5OsUDNApiitHBjOXCUbsr1qiAUcZN5BmFh++upkVS2Meh4Oyex7scRSdMqNVk2V9IDqQ8luXL268WgA2urEbs7mdslZGlLGsSHditu3Yj8WolnDD36FCF9kFUZa5ZrsxGUVrTMGXYm1EFOUlq86D2XHtFZzpZsCUmykqL38O24SsolzOsrtN8lG+4MOV4uUra7UPA5dUcZUc7ujpsSz6gQwDf7ocIG7Gu8OLeGzUJ50hrI5w/5e5Y8XDCkm1soc/KgiYQYYrk271RsXmWDihelhnkc1Be+5/Z2zchT2E0t9/P9UdiKiHSoxWwNxeo7wXXexxAyZk2XdYZ6ZllnVu0HEL8OGJjCb+lkuI98QBA+AGoLztWorvhDcg8QFDxO/gsAH1Aww6yXQ1Fs0YxhR1jUpX5Vmn14fJnQnF6Ak1DNFhejNISbTSwcvHDo42Cu/kDYVmqedeJmxZfVFCgw=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d7d844-ff2b-4b04-2f24-08d829a4095c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 16:19:38.2756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZXYbzauv7p2BJnByIOSX8E2YktIYSUPV4nMZQxCoAyGJIuD2fjfGd3yZf8ALVXPY924KscoLRvZiTLK8e/uhqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6112
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 16 Jul 2020 16:19:47 -0000

Use cygwait in take_ownership to allow interruption while waiting to
become owner.  Return the cygwait return value or a suitable value to
indicate an error.

raw_read now checks the return value and acts accordingly.
---
 winsup/cygwin/fhandler.h       |  2 +-
 winsup/cygwin/fhandler_fifo.cc | 54 ++++++++++++++++++++++++++++++----
 winsup/cygwin/select.cc        | 11 ++++++-
 3 files changed, 59 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 221c856e6..0e0cfbd71 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1489,7 +1489,7 @@ public:
   void owner_lock () { shmem->owner_lock (); }
   void owner_unlock () { shmem->owner_unlock (); }
 
-  void take_ownership ();
+  DWORD take_ownership ();
   void reading_lock () { shmem->reading_lock (); }
   void reading_unlock () { shmem->reading_unlock (); }
 
diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index fd1695f40..30486304f 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -1175,15 +1175,16 @@ fhandler_fifo::raw_write (const void *ptr, size_t len)
   return ret;
 }
 
-/* Called from raw_read and select.cc:peek_fifo. */
-void
+/* Called from raw_read and select.cc:peek_fifo.  Return WAIT_OBJECT_0
+   on success.  */
+DWORD
 fhandler_fifo::take_ownership ()
 {
   owner_lock ();
   if (get_owner () == me)
     {
       owner_unlock ();
-      return;
+      return WAIT_OBJECT_0;
     }
   set_pending_owner (me);
   /* Wake up my fifo_reader_thread. */
@@ -1192,8 +1193,19 @@ fhandler_fifo::take_ownership ()
     /* Wake up owner's fifo_reader_thread. */
     SetEvent (update_needed_evt);
   owner_unlock ();
-  /* The reader threads should now do the transfer.  */
-  WaitForSingleObject (owner_found_evt, INFINITE);
+  /* The reader threads should now do the transfer. */
+  DWORD waitret = cygwait (owner_found_evt, cw_cancel | cw_sig_eintr);
+  owner_lock ();
+  if (waitret == WAIT_OBJECT_0
+      && (get_owner () != me || get_pending_owner ()))
+    {
+      /* Something went wrong.  Return WAIT_TIMEOUT, which can't be
+	 returned by the above cygwait call. */
+      set_pending_owner (null_fr_id);
+      waitret = WAIT_TIMEOUT;
+    }
+  owner_unlock ();
+  return waitret;
 }
 
 void __reg3
@@ -1206,7 +1218,37 @@ fhandler_fifo::raw_read (void *in_ptr, size_t& len)
     {
       /* No one else can take ownership while we hold the reading_lock. */
       reading_lock ();
-      take_ownership ();
+      switch (take_ownership ())
+	{
+	case WAIT_OBJECT_0:
+	  break;
+	case WAIT_SIGNALED:
+	  if (_my_tls.call_signal_handler ())
+	    {
+	      reading_unlock ();
+	      continue;
+	    }
+	  else
+	    {
+	      set_errno (EINTR);
+	      reading_unlock ();
+	      goto errout;
+	    }
+	  break;
+	case WAIT_CANCELED:
+	  reading_unlock ();
+	  pthread::static_cancel_self ();
+	  break;
+	case WAIT_TIMEOUT:
+	  reading_unlock ();
+	  debug_printf ("take_ownership returned an unexpected result; retry");
+	  continue;
+	default:
+	  reading_unlock ();
+	  debug_printf ("unknown error while trying to take ownership, %E");
+	  goto errout;
+	}
+
       /* Poll the connected clients for input.  Make two passes.  On
 	 the first pass, just try to read from the client from which
 	 we last read successfully.  This should minimize
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index 80d16f2a7..3f3f33fb5 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -867,7 +867,16 @@ peek_fifo (select_record *s, bool from_select)
 	}
 
       fh->reading_lock ();
-      fh->take_ownership ();
+      if (fh->take_ownership () != WAIT_OBJECT_0)
+	{
+	  select_printf ("%s, unable to take ownership", fh->get_name ());
+	  fh->reading_unlock ();
+	  gotone += s->read_ready = true;
+	  if (s->except_selected)
+	    gotone += s->except_ready = true;
+	  goto out;
+	}
+
       fh->fifo_client_lock ();
       int nconnected = 0;
       for (int i = 0; i < fh->get_nhandlers (); i++)
-- 
2.27.0

