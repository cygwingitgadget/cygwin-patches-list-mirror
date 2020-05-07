Return-Path: <kbrown@cornell.edu>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770127.outbound.protection.outlook.com [40.107.77.127])
 by sourceware.org (Postfix) with ESMTPS id 247DC396E460
 for <cygwin-patches@cygwin.com>; Thu,  7 May 2020 20:21:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 247DC396E460
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7lC8AE3M6mtUBMn0TYMG46b4Hn1H8/r4NBasDdQvctEdnxv1ECSJPe/TeO6gelpl+4gR2p/W5FpF76QuKyne0OnJU3Z+ZGXv8IkSQfiKhC7JlOfaNnzUHcvLuRmsvx1EImqnryovYyTzivMem3HWLLMTdGup+TPwW801Kp31HPv9CXnnYD43fZCDjWTSEt645/+uKQoo2OHG75kUR6AX1V//J3pm1n4lmmUF/dTJGTmhvsyGWMc5yddNym6/2iAGC72aigffJ3xTM4gfcLNIOXZkUF7lCNDT5sExfovJ7L7/iKQPjIsdjd2BXy1HASxPK7n+h3ij/1Vzn40eGJ4JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3D+qtZPX9YEiWbACVAcAgKKZPlyN6OlxMwjFkRDOdIo=;
 b=cB7JwADaXNqcAyucHhxRZ1Wop4rN1WuwBSERpYsMXXQiMQ0GywmkZQWfKeM7jwNZpMfAdyXi8yfODT36dD6D0Xnb1AKuwaXKWb3DR2zyHT9RsrEYXM34fZ6c4n74b3FoQ1mFvjsXmILQQ+SCtNYF96RngFJ287wbB/EK1sdLtoJDlUKqyRsPwKnBnmEnNkBqq/ew0GQMiYvFY3eqjhmWxKw4nJyi4AGsW8dIJwlH7+zOZMqsglgNhT4MnZ5wv1p/zEriD8uf171e4CesiKNHW+b3JoVAbzLqzXgCUsvemX6k9/YutCN1lox22fsiG1nph3PTshsucMAfTBR1qrGbNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from DM6PR04MB6075.namprd04.prod.outlook.com (2603:10b6:5:127::31)
 by DM6PR04MB4666.namprd04.prod.outlook.com (2603:10b6:5:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Thu, 7 May
 2020 20:21:46 +0000
Received: from DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4]) by DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4%4]) with mapi id 15.20.2979.025; Thu, 7 May 2020
 20:21:46 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Cc: sten.kristian.ivarsson@gmail.com
Subject: [PATCH 04/21] Cygwin: FIFO: simplify the listen_client_thread code
Date: Thu,  7 May 2020 16:21:07 -0400
Message-Id: <20200507202124.1463-5-kbrown@cornell.edu>
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
 15.20.2979.28 via Frontend Transport; Thu, 7 May 2020 20:21:44 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [2604:6000:b407:7f00:e532:58da:20b8:9136]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 523d7f77-87ec-4841-3a2c-08d7f2c44316
X-MS-TrafficTypeDiagnostic: DM6PR04MB4666:
X-Microsoft-Antispam-PRVS: <DM6PR04MB46661F6F8EB358A9164ED28ED8A50@DM6PR04MB4666.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FEhFeqcp8hiIwKoNvXReg/jGy/scPkvPzwVGKGEH5jZR7tUki3w6ebmKeY+i7bCA4Q+eODAy0Bi2OIwTVI63mltoEaHc/QxSKuEEkfm8Mjj37iozN0Hl++aHw1FmB2LZ724hP6aOHEsLgonj6lI++Y97j4a/VgBaOVYY1HeGJBo4EBMU221+Z0CcJaMPv0NoHq+sV8dGFQxQr0KW/kbeOhurl22iezdIyT3L3NAZHDTf38Y5S9JmUX1qQuq+wDO7beMqdmM1xq4uSR1MbhJpyjto4OeZd22QbIrCL/DVNK/1+swHL1Fok7/Mhgb7GS9Ve1cbVjll+FlqZAQIjQw1XO20jsSPUY0aNUUB8wEQOJ4aCTcvL7zdmD55MPi8t/C3cToQeVtmYFGA3hrr6FUiO4iPiJJ8su0f5vo6bbj8FOxNcQEpDZSi2TzGIPOBV+f0x2jJqFT1odi7A+aMquGXBlTPFtZMaZzBA7UZdExbFyc34VSdqYmwfAKrDsBqKRqXHxlzINASTcUNQRfpRrNw+EuoI0X7RRJeZ7tOYH1fqOHY75hVgXt2xTNfs2ypzuL2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6075.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(33430700001)(66946007)(1076003)(69590400007)(75432002)(6486002)(66556008)(316002)(2906002)(2616005)(6506007)(6512007)(36756003)(16526019)(4326008)(6666004)(33440700001)(5660300002)(786003)(66476007)(86362001)(478600001)(186003)(8676002)(83320400001)(83280400001)(83310400001)(83290400001)(6916009)(8936002)(83300400001)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: yj/fdZE+eYMgf9gX1lG0/XFAlcoO88cto/bxZTQ1gwYlv8y3ElmeA3uGPYBPKo66R7MXDvz4nJa8hHS+oKSZUx/NfONXWk54Aym6pphAukwE9DFIseC4GQgv6xWWxYb/2Jb8JI+Nc4/3LnhHrYsRzu5CHURqFD+AxtZBaXzwSKk+nTw0eqe1faVxJJsG/nWrtEor0N457rI8pqUdf3TiFWil4HzqQOZLIbzO4/ZoEZ4eUSRYFPsjFRVJiJy0rqXG9Wg2+i/+vRUb3LPf3dqWHhc9uPTapsvlV2SxVqXd9npaLLSPbziGx7Df53M37SjrjnPbFw+HNH92dtFhOIA0vCMN1yUOoYJHPRyuxOX/9Ihe1ZykFhcdoipq8nANCB9sJRNmmFBr/u9fz4yTVB5ko+wEr1cBb81JXynwHMOyd/t5zR8mhO/OeNyxgp6u+EbSgYcyM+qQ3DOYhEnubWFTjQEwUBPgTUPBssVwlUevUftyPH+aCZ2CnYSOAyFsDMv/uL4zwxATY4KNw0ufEYEP82xUAEbxZiNJnV/uheWuCBIwLXlxxt4MS3tE4Sh/EYY1pbxDf/FUad/4yYNoprTJkq2k3QL+W+S+vP9zhx4f4f/raKMGAY3RwvcCBsaDeuzxmTedqE9TNSFZi/we07leZIxqeh8iPq2I41n2ax/zH0ZwhYDLiwSuTnZyKHQZeBE1dLlqWzXvxBO4RtLvsqy9/3nibgVsVI2FpWoTSnt2BlAOPxibjaatxQ+rcOyOFxS4v82foEividfoL7QCJMUDGXCtOJVzdZxftvnds0tNiH4BnG/uCWs01r3eLnC2VGLvR7EkCNnMvL9Yd+gIPy6Y89Qzi3pOvALdvqxqYO8hSAWtwIFLzblV30KOuh+TYK8X
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 523d7f77-87ec-4841-3a2c-08d7f2c44316
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 20:21:45.1715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fg18VF+8lUuu0JiI/sunoeBpeKO9ofkuQFArdy9QT5p2qdlwq8DX/M82zUmQ6/DWtoTOZbUzhxZmalUqJDoKeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4666
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

Always return 0; no one is doing anything with the return value
anyway.

Remove the return value from stop_listen_client.

Make the connection event auto-reset, so that we don't have to reset
it later.

Simplify the process of connecting a bogus client when thread
termination is signaled.

Make some failures fatal.

Remove the unnecessary extra check for thread termination near the end
of listen_client_thread.
---
 winsup/cygwin/fhandler.h       |   4 +-
 winsup/cygwin/fhandler_fifo.cc | 117 +++++++++++++--------------------
 2 files changed, 47 insertions(+), 74 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index c1f47025a..c8f7a39a2 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1319,7 +1319,7 @@ class fhandler_fifo: public fhandler_base
   int add_client_handler ();
   void delete_client_handler (int);
   bool listen_client ();
-  int stop_listen_client ();
+  void stop_listen_client ();
   int check_listen_client_thread ();
   void record_connection (fifo_client_handler&,
 			  fifo_client_connect_state = fc_connected);
@@ -1345,7 +1345,7 @@ public:
   ssize_t __reg3 raw_write (const void *ptr, size_t ulen);
   bool arm (HANDLE h);
   bool need_fixup_before () const { return reader; }
-  int fixup_before_fork_exec (DWORD) { return stop_listen_client (); }
+  int fixup_before_fork_exec (DWORD) { stop_listen_client (); return 0; }
   void init_fixup_before ();
   void fixup_after_fork (HANDLE);
   void fixup_after_exec ();
diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index ba3dbb124..fb20e5a7e 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -324,11 +324,10 @@ fhandler_fifo::record_connection (fifo_client_handler& fc,
 DWORD
 fhandler_fifo::listen_client_thread ()
 {
-  DWORD ret = -1;
-  HANDLE evt;
+  HANDLE conn_evt;
 
-  if (!(evt = create_event ()))
-    goto out;
+  if (!(conn_evt = CreateEvent (NULL, false, false, NULL)))
+    api_fatal ("Can't create connection event, %E");
 
   while (1)
     {
@@ -346,7 +345,7 @@ fhandler_fifo::listen_client_thread ()
 
       /* Create a new client handler. */
       if (add_client_handler () < 0)
-	goto out;
+	api_fatal ("Can't add a client handler, %E");
 
       /* Allow a writer to open. */
       if (!arm (read_ready))
@@ -359,12 +358,13 @@ fhandler_fifo::listen_client_thread ()
       fifo_client_handler& fc = fc_handler[nhandlers - 1];
       NTSTATUS status;
       IO_STATUS_BLOCK io;
+      bool cancel = false;
 
-      status = NtFsControlFile (fc.h, evt, NULL, NULL, &io,
+      status = NtFsControlFile (fc.h, conn_evt, NULL, NULL, &io,
 				FSCTL_PIPE_LISTEN, NULL, 0, NULL, 0);
       if (status == STATUS_PENDING)
 	{
-	  HANDLE w[2] = { evt, lct_termination_evt };
+	  HANDLE w[2] = { conn_evt, lct_termination_evt };
 	  DWORD waitret = WaitForMultipleObjects (2, w, false, INFINITE);
 	  switch (waitret)
 	    {
@@ -372,83 +372,65 @@ fhandler_fifo::listen_client_thread ()
 	      status = io.Status;
 	      break;
 	    case WAIT_OBJECT_0 + 1:
-	      ret = 0;
 	      status = STATUS_THREAD_IS_TERMINATING;
+	      cancel = true;
 	      break;
 	    default:
-	      __seterrno ();
-	      debug_printf ("WaitForMultipleObjects failed, %E");
-	      status = STATUS_THREAD_IS_TERMINATING;
-	      break;
+	      api_fatal ("WFMO failed, %E");
 	    }
 	}
       HANDLE ph = NULL;
-      int ps = -1;
+      NTSTATUS status1;
+
       fifo_client_lock ();
       switch (status)
 	{
 	case STATUS_SUCCESS:
 	case STATUS_PIPE_CONNECTED:
 	  record_connection (fc);
-	  ResetEvent (evt);
 	  break;
 	case STATUS_PIPE_CLOSING:
 	  record_connection (fc, fc_closing);
-	  ResetEvent (evt);
 	  break;
 	case STATUS_THREAD_IS_TERMINATING:
-	  /* Force NtFsControlFile to complete.  Otherwise the next
-	     writer to connect might not be recorded in the client
-	     handler list. */
-	  status = open_pipe (ph);
-	  if (NT_SUCCESS (status)
-	      && (NT_SUCCESS (io.Status) || io.Status == STATUS_PIPE_CONNECTED))
-	    {
-	      debug_printf ("successfully connected bogus client");
-	      delete_client_handler (nhandlers - 1);
-	    }
-	  else if ((ps = fc.pipe_state ()) == FILE_PIPE_CONNECTED_STATE
-		   || ps == FILE_PIPE_INPUT_AVAILABLE_STATE)
-	    {
-	      /* A connection was made under our nose. */
-	      debug_printf ("recording connection before terminating");
-	      record_connection (fc);
-	    }
+	  /* Try to connect a bogus client.  Otherwise fc is still
+	     listening, and the next connection might not get recorded. */
+	  status1 = open_pipe (ph);
+	  WaitForSingleObject (conn_evt, INFINITE);
+	  if (NT_SUCCESS (status1))
+	    /* Bogus cilent connected. */
+	    delete_client_handler (nhandlers - 1);
 	  else
-	    {
-	      debug_printf ("failed to terminate NtFsControlFile cleanly");
-	      delete_client_handler (nhandlers - 1);
-	      ret = -1;
-	    }
-	  if (ph)
-	    NtClose (ph);
-	  fifo_client_unlock ();
-	  goto out;
+	    /* Did a real client connect? */
+	    switch (io.Status)
+	      {
+	      case STATUS_SUCCESS:
+	      case STATUS_PIPE_CONNECTED:
+		record_connection (fc);
+		break;
+	      case STATUS_PIPE_CLOSING:
+		record_connection (fc, fc_closing);
+		break;
+	      default:
+		debug_printf ("NtFsControlFile status %y after failing to connect bogus client or real client", io.Status);
+		fc.state = fc_unknown;
+		break;
+	      }
+	  break;
 	default:
-	  debug_printf ("NtFsControlFile status %y", status);
-	  __seterrno_from_nt_status (status);
-	  delete_client_handler (nhandlers - 1);
-	  fifo_client_unlock ();
-	  goto out;
+	  break;
 	}
       fifo_client_unlock ();
-      /* Check for thread termination in case WaitForMultipleObjects
-	 didn't get called above. */
-      if (IsEventSignalled (lct_termination_evt))
-	{
-	  ret = 0;
-	  goto out;
-	}
+      if (ph)
+	NtClose (ph);
+      if (cancel)
+	goto out;
     }
 out:
-  if (evt)
-    NtClose (evt);
+  if (conn_evt)
+    NtClose (conn_evt);
   ResetEvent (read_ready);
-  if (ret < 0)
-    debug_printf ("exiting with error, %E");
-  else
-    debug_printf ("exiting without error");
-  return ret;
+  return 0;
 }
 
 int
@@ -945,10 +927,9 @@ fifo_client_handler::pipe_state ()
     return fpli.NamedPipeState;
 }
 
-int
+void
 fhandler_fifo::stop_listen_client ()
 {
-  int ret = 0;
   HANDLE thr, evt;
 
   thr = InterlockedExchangePointer (&listen_client_thr, NULL);
@@ -957,19 +938,11 @@ fhandler_fifo::stop_listen_client ()
       if (lct_termination_evt)
 	SetEvent (lct_termination_evt);
       WaitForSingleObject (thr, INFINITE);
-      DWORD err;
-      GetExitCodeThread (thr, &err);
-      if (err)
-	{
-	  ret = -1;
-	  debug_printf ("listen_client_thread exited with error");
-	}
       NtClose (thr);
     }
   evt = InterlockedExchangePointer (&lct_termination_evt, NULL);
   if (evt)
     NtClose (evt);
-  return ret;
 }
 
 int
@@ -978,7 +951,7 @@ fhandler_fifo::close ()
   /* Avoid deadlock with lct in case this is called from a signal
      handler or another thread. */
   fifo_client_unlock ();
-  int ret = stop_listen_client ();
+  stop_listen_client ();
   if (read_ready)
     NtClose (read_ready);
   if (write_ready)
@@ -987,7 +960,7 @@ fhandler_fifo::close ()
   for (int i = 0; i < nhandlers; i++)
     fc_handler[i].close ();
   fifo_client_unlock ();
-  return fhandler_base::close () || ret;
+  return fhandler_base::close ();
 }
 
 /* If we have a write handle (i.e., we're a duplexer or a writer),
-- 
2.21.0

