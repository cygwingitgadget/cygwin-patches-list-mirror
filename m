Return-Path: <kbrown@cornell.edu>
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2134.outbound.protection.outlook.com [40.107.223.134])
 by sourceware.org (Postfix) with ESMTPS id DD2AD386196F
 for <cygwin-patches@cygwin.com>; Tue,  4 Aug 2020 12:55:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org DD2AD386196F
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kb1W4M6JDO316+LMzXy92XA7arGl2UiCJNQ5cYB4B9m2ZTgG+jResCUkvN5L1CUNhljMpNrq0+w1aqvy4f4bRNB5SvSYHgAOsm6dz7qmUKkj6eroqL+DlArf+q6uN3LiLQEOjVo6hnMjd9ttU9L48sEoBDqtc5kSQJz73yJ4roJtez3B1svX+KsuOiTgvwbvci1LJOM5m85MnUumtOKtxJGVPVZOmY/gNgPZf0Eo8yoOFSLnPPF4h7YjqxpPjJa2AEElcxxgqp+Ho4bqOksRIhstndbGRQbawn7KwIjKYUOwSktvR5RVnYN/E0XGpqIh/na3iszB7ITQFM22NnfbFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgAjPMOruRSZLNACMG4t+cE+fdpgCDOvisCkFzGEFQ8=;
 b=BTAwrQQ7UcpwFJvLIGh1jYoEzQKPMIHRuWHdrok8/dWX9hCboNeeircG/jmZEk5mVl5tJv79EFesqJTxkSGgpas2lsiZXjJG7P78aVLxNZzdlOi0pT338bDzm6WqdZ1o0kZlnaVUbhifklNGQ+GU5lHZiifJOrfQUksIMF1c6JDri9zrwya5mplUfR9A4K19zld89wNF88Q5DgVOl43hdC9CXwpEF9ojf5Te0CGDgzImFownuef+1+LZVPWdAKtJqh9B2Hxsy9cbmgBmzf/3E2Jpcpsej7D0sgTeQwEJjVFhlp6oluu8Tq8n+t80iGhhQG9Z1I79FNS6Twya6Jf2pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5903.namprd04.prod.outlook.com (2603:10b6:208:a4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Tue, 4 Aug
 2020 12:55:28 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a%7]) with mapi id 15.20.3239.021; Tue, 4 Aug 2020
 12:55:28 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 6/8] Cygwin: FIFO: synchronize the fifo_reader and fifosel
 threads
Date: Tue,  4 Aug 2020 08:55:05 -0400
Message-Id: <20200804125507.8842-7-kbrown@cornell.edu>
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
 Transport; Tue, 4 Aug 2020 12:55:27 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [2604:6000:b407:7f00:8093:2a79:7de:1dbd]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e02ca1cb-c8ca-456c-04e8-08d83875a955
X-MS-TrafficTypeDiagnostic: MN2PR04MB5903:
X-Microsoft-Antispam-PRVS: <MN2PR04MB5903DA661AE7D4B9A5E59F95D84A0@MN2PR04MB5903.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UM8Zv0mMxvoP8h16qCdQf7W5xfyVKrNZCOYxfkDJ2SO1cG7IMbOsnl0UH7q9YZDrk/3hCouaA1Lh/wctVavtIOuOoShFsef5/nkL8PZ4wu+DLgNMBsSxUdd6Co1apFZOwjNhTm/p3wf3gkt9iiiengS3q1QxbCPFzis614i+r4ER84K7NT3uRfz9jjj/P2K6nsP7iAT9BFsxIuts91wmclO2ahMGS2oa9CJxsQ81xv4Ajex5Kp+izCFrbWALnujo/I224u9fi3XjCDn/jiInVpd5FpeP9bAFzGP4AS+EXcZTIGOwZql9lLg16jEJem3gxPW5xtskOVk8Sw2RT6hAXF2aI4QXWmmuGL02O46SIb3tFfBrx2pHXhnif2rrlby6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(2906002)(5660300002)(786003)(316002)(6666004)(6506007)(66946007)(86362001)(8676002)(6512007)(16526019)(186003)(1076003)(75432002)(2616005)(83380400001)(478600001)(66556008)(52116002)(69590400007)(6486002)(6916009)(36756003)(8936002)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: i9Bs0AHv7ymrOnwr1AzcdfOq1zjzdswpnOy+vcA7wej5/agOxXxVJWdYOL/CpU8Df13RXWSjVzamuY2iWEW2JqdC7A8aBJdDLmssVITOo0DgJcAl2HRDdNj1LjM5bL26n8Fsim6lqC48SqEZWJDZWby2AJYPTwwZ3k6Cgrx+JJ4Eqkz1wT57cK5yFlprkxastDEo57AzcQqcCh/v5/fHYygAo+TJWxq2sj3479VaznmDV5fx01AeSAFdjrY08QW8kooVL1XBRyq+uTGsTbRywJX3EHHM/CtGrEVpsOV92jWvBSIsWiQ+coDcknKm1bB4YBzGMkG1wfXD8WJ32QNFhBqOWf57nrtIJMYirk7vm0vMt/gjTasS1h4Nbb/xW2eMKCht+iBq/G4TBS5IAf84zmcUxNntphSu1YByEWL//UXy72gdJb3d78+3w+e80tYfZt5+pWbaa8r1jQCHcafHc205+9fHDIPJu0GMOTI6UW8Yl2dp7rzJdMnRpzTrlRzcuLBPavnhN+l40YMeCjiw+Ww1CqjZe0ylNOpzAlcP0c5V4vFFD+8XGWm1z3X0A87tHWWUfU3pkiHnypYA/4+QD5gmhS4LZXJVB9I/54+ZKfB4lrbskbodudqmZPmz3CtMjMYbe58uukfLFxoZAcwzqYycq4V/12tPoOWMFmAHWxKTZOen0PtIOqoU2lU5J1IzWzbUpWSD1E+aN5QEIYrWOQ==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: e02ca1cb-c8ca-456c-04e8-08d83875a955
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2020 12:55:27.9263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +BWddB8e4yzSLhmUriO7s7AnBMUq/DCZIbI/acA2XPYfFMfdn4SSxAikr0EeEoS1azYo+8guHce9iZAQ9jpkVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5903
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 04 Aug 2020 12:55:33 -0000

The fifo_reader thread function and the function select.cc:peek_fifo()
can both change the state of a fifo_client_handler.  These changes are
made under fifo_client_lock, so there is no race, but the changes can
still be incompatible.

Add code to make sure that only one of these functions can change the
state from its initial fc_listening state.  Whichever function does
this calls the fhandler_fifo::record_connection method, which is now
public so that peek_fifo can call it.

Slightly modify that method to make it suitable for being called by
peek_fifo.

Make a few other small changes to the fifo_reader thread function to
change how it deals with the STATUS_PIPE_CLOSING value that can
(rarely) be returned by NtFsControlFile.

Add commentary to fhandler_fifo.cc to explain fifo_client connect
states and where they can be changed.
---
 winsup/cygwin/fhandler.h       |  4 +--
 winsup/cygwin/fhandler_fifo.cc | 60 ++++++++++++++++++++++++++++++----
 winsup/cygwin/select.cc        |  5 ++-
 3 files changed, 60 insertions(+), 9 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 40e201b0f..a577ca542 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1413,8 +1413,6 @@ class fhandler_fifo: public fhandler_base
   void cleanup_handlers ();
   void close_all_handlers ();
   void cancel_reader_thread ();
-  void record_connection (fifo_client_handler&,
-			  fifo_client_connect_state = fc_connected);
 
   int create_shmem (bool only_open = false);
   int reopen_shmem ();
@@ -1482,6 +1480,8 @@ public:
   DWORD fifo_reader_thread_func ();
   void fifo_client_lock () { _fifo_client_lock.lock (); }
   void fifo_client_unlock () { _fifo_client_lock.unlock (); }
+  void record_connection (fifo_client_handler&, bool = true,
+			  fifo_client_connect_state = fc_connected);
 
   int take_ownership (DWORD timeout = INFINITE);
   void reading_lock () { shmem->reading_lock (); }
diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index 1e1140f53..2b829eb6c 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -37,11 +37,42 @@
      "fifo_client_handler" structures, one for each writer.  A
      fifo_client_handler contains the handle for the pipe server
      instance and information about the state of the connection with
-     the writer.  Each writer holds the pipe instance's client handle.
+     the writer.  Access to the list is controlled by a
+     "fifo_client_lock".
 
      The reader runs a "fifo_reader_thread" that creates new pipe
      instances as needed and listens for client connections.
 
+     The connection state of a fifo_client_handler has one of the
+     following values, in which order is important:
+
+       fc_unknown
+       fc_error
+       fc_disconnected
+       fc_closing
+       fc_listening
+       fc_connected
+       fc_input_avail
+
+     It can be changed in the following places:
+
+       - It is set to fc_listening when the pipe instance is created.
+
+       - It is set to fc_connected when the fifo_reader_thread detects
+         a connection.
+
+       - It is set to a value reported by the O/S when
+         query_and_set_state is called.  This can happen in
+         select.cc:peek_fifo and a couple other places.
+
+       - It is set to fc_disconnected by raw_read when an attempt to
+         read yields STATUS_PIPE_BROKEN.
+
+       - It is set to fc_error in various places when unexpected
+         things happen.
+
+     State changes are always guarded by fifo_client_lock.
+
      If there are multiple readers open, only one of them, called the
      "owner", maintains the fifo_client_handler list.  The owner is
      therefore the only reader that can read at any given time.  If a
@@ -374,10 +405,11 @@ fhandler_fifo::cleanup_handlers ()
 
 /* Always called with fifo_client_lock in place. */
 void
-fhandler_fifo::record_connection (fifo_client_handler& fc,
+fhandler_fifo::record_connection (fifo_client_handler& fc, bool set,
 				  fifo_client_connect_state s)
 {
-  fc.set_state (s);
+  if (set)
+    fc.set_state (s);
   set_pipe_non_blocking (fc.h, true);
 }
 
@@ -583,6 +615,11 @@ owner_listen:
       NTSTATUS status1;
 
       fifo_client_lock ();
+      if (fc.get_state () != fc_listening)
+	/* select.cc:peek_fifo has already recorded a connection. */
+	;
+      else
+      {
       switch (status)
 	{
 	case STATUS_SUCCESS:
@@ -590,7 +627,12 @@ owner_listen:
 	  record_connection (fc);
 	  break;
 	case STATUS_PIPE_CLOSING:
-	  record_connection (fc, fc_closing);
+	  debug_printf ("NtFsControlFile got STATUS_PIPE_CLOSING...");
+	  /* Maybe a writer already connected, wrote, and closed.
+	     Just query the O/S. */
+	  fc.query_and_set_state ();
+	  debug_printf ("...O/S reports state %d", fc.get_state ());
+	  record_connection (fc, false);
 	  break;
 	case STATUS_THREAD_IS_TERMINATING:
 	case STATUS_WAIT_1:
@@ -610,17 +652,23 @@ owner_listen:
 		record_connection (fc);
 		break;
 	      case STATUS_PIPE_CLOSING:
-		record_connection (fc, fc_closing);
+		debug_printf ("got STATUS_PIPE_CLOSING when trying to connect bogus client...");
+		fc.query_and_set_state ();
+		debug_printf ("...O/S reports state %d", fc.get_state ());
+		record_connection (fc, false);
 		break;
 	      default:
 		debug_printf ("NtFsControlFile status %y after failing to connect bogus client or real client", io.Status);
-		fc.set_state (fc_unknown);
+		fc.set_state (fc_error);
 		break;
 	      }
 	  break;
 	default:
+	  debug_printf ("NtFsControlFile got unexpected status %y", status);
+	  fc.set_state (fc_error);
 	  break;
 	}
+      }
       if (ph)
 	NtClose (ph);
       if (update)
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index 9ee305f64..43f07af43 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -877,10 +877,13 @@ peek_fifo (select_record *s, bool from_select)
       for (int i = 0; i < fh->get_nhandlers (); i++)
 	{
 	  fifo_client_handler &fc = fh->get_fc_handler (i);
-	  fc.query_and_set_state ();
+	  fifo_client_connect_state prev_state = fc.query_and_set_state ();
 	  if (fc.get_state () >= fc_connected)
 	    {
 	      nconnected++;
+	      if (prev_state == fc_listening)
+		/* The connection was not recorded by the fifo_reader_thread. */
+		fh->record_connection (fc, false);
 	      if (fc.get_state () == fc_input_avail)
 		{
 		  select_printf ("read: %s, ready for read", fh->get_name ());
-- 
2.28.0

