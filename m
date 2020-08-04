Return-Path: <kbrown@cornell.edu>
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2112.outbound.protection.outlook.com [40.107.223.112])
 by sourceware.org (Postfix) with ESMTPS id F0E803857C56
 for <cygwin-patches@cygwin.com>; Tue,  4 Aug 2020 12:55:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org F0E803857C56
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLGdOs7l2rj1dMTYer8r7p/Q7k2Idztbcxrjz6VtlPDqN5Hbch6GK7uWIVeUgNLgTDVu5trWW/2rps91wuKL1End+3tIxZa7I5Tn5qXWwEi8Uvw/tKWieDgZikvXiSkxWsEm7tf0aU2fAwuT/znrc0CuM1xIF6x/TVmFM3XM6JxLIdj/7UaTO7VpXa3k5r6XnmNtaAUbiny6XsAOubqqRy311i8hQjJC605qRglbAZ0LcKaULQbA3HWQjJmmfYc2q8JSq2X+Mx+J9VgMj3+Skqkzt/E82qIgZlnlHAijcQLkVjeOxuNTXNRaIAn2TfequIbeQSSrdfSmO2Z+9TR9sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iurcln63TAoOJybkFAS6Gr+yOzH0f0O+IRF00WC86j8=;
 b=fVVt9ypBIlK49rtnYazI9npFdtHA8yxjnM617+dytQR5uQVpZ8Dj3YH6uWx962DTIY/J3Nc2hvMpBF6cQRrI1YA8nOIDytyNdzdfmv2eTDYB0Mxh9/UAN/r+wtG8weqRpKdlywf1tsje+MgDqZw4y4OU5KG2BZyatgJlOeP14Bhi3OGGRfMwm1Puvbezc/y8Ei6+jeAPnjJSGa4lSOcZspfpBvsLQpScsuMF3WIrBVAXtlOtkANVnmDALst/6J7mNChpKfr+ky3wEx3tzoZSgxXM4BIOmCYR3Mb6VSQvbkeWOxMZ15nzz4k91uceXnUQELqNk76a/XVLT31PpVn+Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5903.namprd04.prod.outlook.com (2603:10b6:208:a4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Tue, 4 Aug
 2020 12:55:26 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a%7]) with mapi id 15.20.3239.021; Tue, 4 Aug 2020
 12:55:26 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 4/8] Cygwin: FIFO: reorganize some fifo_client_handler methods
Date: Tue,  4 Aug 2020 08:55:03 -0400
Message-Id: <20200804125507.8842-5-kbrown@cornell.edu>
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
X-MS-Office365-Filtering-Correlation-Id: 024dbb1b-eb87-4efd-431f-08d83875a879
X-MS-TrafficTypeDiagnostic: MN2PR04MB5903:
X-Microsoft-Antispam-PRVS: <MN2PR04MB5903843CA1CE3C896CC9FCDDD84A0@MN2PR04MB5903.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9KllVXgy2bDfHcCy82aeCixicyn3sOX4aUeNGvmyFvomig1dI8TLpAcwLfh3xtDzCdOosalyLQ1F/izZyvI/Hc1FMoLJ5Gz/d6dntA61H1iG0/sZuw6QUSY+Nr8yfmJkVbmKIAPlKVe6Jz9+aZS9vfIKqntsOvMyoi3NocXYw6yi1ae//xNxafHC8yVtWKfw8UI3cXDagPgDqvlBndgF6ddj0XIGzZ7Gbm1U2Mldv6ysjZ9sUJxfD0YtncPHARDL0C/5AoMfLUBONnjS18Jr/eTFRZsbh5Fav6FvsUzv7C2gmtgvEzRPcYtyXGmsshErYGdz1naVzQiC+aeyZgy9r0Z5elbrhaVrTagWwQxIeGRigRRt7GQrK4ctTSkucBh/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(2906002)(5660300002)(786003)(316002)(6666004)(6506007)(66946007)(86362001)(8676002)(6512007)(16526019)(186003)(1076003)(75432002)(2616005)(83380400001)(478600001)(66556008)(52116002)(69590400007)(6486002)(6916009)(36756003)(8936002)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: IIE+5oiNP19gYETQyywukadOGrezdSrVJucgC0PZtMxQjDZZFWumwXGYJEt/x8kego7dv0lItuiAsNxukPwSD8q6FD3J8p45zqPQZJdJDfvBDKugOwhV0U2ugmKltshVh6K9cGmp/AfREIeqhZIk1k+JIsHNez+cKjqkDqrGwSTN4YGs+ya60sDsh5f8hN2FLzIJNW//rBiym9Qfit8pUIRtJH/uBJCbPbfzxTn8tOC7bNkCbTOLoy7/eoe8r/OaUY0ELGz31TXqSsA2+ZqSeluqBVAoywfoUyrbnNz3SNVUFqE+LGv0nLGnieyJxkKIpdMmutUeSkJd2AufgnFI8t3W/mwNSP8IUJx8AVO2xbt5tXhGearRhVZ8FtHP/vHXU6sCn6zFK9K+TtJpWo0mVX9M9alLOBrKhgVHCvf95Qtvkh18T+0bV0gwQioJyMp0NZ8a1ij22IPon4AiHir52YE1hPfCEzxm0hZVQ8LcbsjUPDFbFzznn6xOd74tKFEC6uIUeuSaALYId+OD8f5ui3pksBPOzCUr1KhVytswj7kDyZXRM9qUIAoV+K4oBxdNDCXF0U5L7UHm7ZLnrF+4wNzgKz0hZ0YJ4DBxPkTGJ+7h6BBQ7tstqGCi6KDkjFbMxfwBoh6aBvx8MaJ09HwD4oNB13BIPNAqS6DrOhQj2IHGrUfwYYsd72OJRGrJ0NCK81DY63SSPmMWVfuddFJ4XQ==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 024dbb1b-eb87-4efd-431f-08d83875a879
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2020 12:55:26.4552 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l6FGxkw18IHSMqDIm0a63bvjQeULu2c7YOHZPGJsFTHPBdNyXIChE5DyFGd85sJY5eVkJkUwF1F1rq2GJ7fLgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5903
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 04 Aug 2020 12:55:31 -0000

Rename the existing set_state() to query_and_set_state() to reflect
what it really does.  (It queries the O/S for the pipe state.)  Add a
new set_state() method, which is a standard setter, and a
corresponding getter get_state().
---
 winsup/cygwin/fhandler.h       |  9 ++++--
 winsup/cygwin/fhandler_fifo.cc | 50 +++++++++++++++++++---------------
 winsup/cygwin/select.cc        | 28 +++++++++++--------
 3 files changed, 50 insertions(+), 37 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 5488327a2..f64eabda4 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1297,11 +1297,14 @@ enum fifo_client_connect_state
 struct fifo_client_handler
 {
   HANDLE h;
-  fifo_client_connect_state state;
+  fifo_client_connect_state _state;
   bool last_read;  /* true if our last successful read was from this client. */
-  fifo_client_handler () : h (NULL), state (fc_unknown), last_read (false) {}
+  fifo_client_handler () : h (NULL), _state (fc_unknown), last_read (false) {}
   void close () { NtClose (h); }
-  fifo_client_connect_state set_state ();
+  fifo_client_connect_state get_state () const { return _state; }
+  void set_state (fifo_client_connect_state s) { _state = s; }
+  /* Query O/S.  Return previous state. */
+  fifo_client_connect_state query_and_set_state ();
 };
 
 class fhandler_fifo;
diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index b8a47f27f..c816c692a 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -340,7 +340,7 @@ fhandler_fifo::add_client_handler (bool new_pipe_instance)
       if (!ph)
 	return -1;
       fc.h = ph;
-      fc.state = fc_listening;
+      fc.set_state (fc_listening);
     }
   fc_handler[nhandlers++] = fc;
   return 0;
@@ -365,7 +365,7 @@ fhandler_fifo::cleanup_handlers ()
 
   while (i < nhandlers)
     {
-      if (fc_handler[i].state < fc_closing)
+      if (fc_handler[i].get_state () < fc_closing)
 	delete_client_handler (i);
       else
 	i++;
@@ -377,7 +377,7 @@ void
 fhandler_fifo::record_connection (fifo_client_handler& fc,
 				  fifo_client_connect_state s)
 {
-  fc.state = s;
+  fc.set_state (s);
   set_pipe_non_blocking (fc.h, true);
 }
 
@@ -414,13 +414,13 @@ fhandler_fifo::update_my_handlers ()
 	{
 	  debug_printf ("Can't duplicate handle of previous owner, %E");
 	  __seterrno ();
-	  fc.state = fc_error;
+	  fc.set_state (fc_error);
 	  fc.last_read = false;
 	  ret = -1;
 	}
       else
 	{
-	  fc.state = shared_fc_handler[i].state;
+	  fc.set_state (shared_fc_handler[i].get_state ());
 	  fc.last_read = shared_fc_handler[i].last_read;
 	}
     }
@@ -614,7 +614,7 @@ owner_listen:
 		break;
 	      default:
 		debug_printf ("NtFsControlFile status %y after failing to connect bogus client or real client", io.Status);
-		fc.state = fc_unknown;
+		fc.set_state (fc_unknown);
 		break;
 	      }
 	  break;
@@ -1280,7 +1280,7 @@ fhandler_fifo::raw_read (void *in_ptr, size_t& len)
       for (j = 0; j < nhandlers; j++)
 	if (fc_handler[j].last_read)
 	  break;
-      if (j < nhandlers && fc_handler[j].state >= fc_closing)
+      if (j < nhandlers && fc_handler[j].get_state () >= fc_closing)
 	{
 	  NTSTATUS status;
 	  IO_STATUS_BLOCK io;
@@ -1303,11 +1303,11 @@ fhandler_fifo::raw_read (void *in_ptr, size_t& len)
 	    case STATUS_PIPE_EMPTY:
 	      break;
 	    case STATUS_PIPE_BROKEN:
-	      fc_handler[j].state = fc_disconnected;
+	      fc_handler[j].set_state (fc_disconnected);
 	      break;
 	    default:
 	      debug_printf ("NtReadFile status %y", status);
-	      fc_handler[j].state = fc_error;
+	      fc_handler[j].set_state (fc_error);
 	      break;
 	    }
 	  fc_handler[j].last_read = false;
@@ -1315,7 +1315,7 @@ fhandler_fifo::raw_read (void *in_ptr, size_t& len)
 
       /* Second pass. */
       for (int i = 0; i < nhandlers; i++)
-	if (fc_handler[i].state >= fc_closing)
+	if (fc_handler[i].get_state () >= fc_closing)
 	  {
 	    NTSTATUS status;
 	    IO_STATUS_BLOCK io;
@@ -1339,12 +1339,12 @@ fhandler_fifo::raw_read (void *in_ptr, size_t& len)
 	      case STATUS_PIPE_EMPTY:
 		break;
 	      case STATUS_PIPE_BROKEN:
-		fc_handler[i].state = fc_disconnected;
+		fc_handler[i].set_state (fc_disconnected);
 		nconnected--;
 		break;
 	      default:
 		debug_printf ("NtReadFile status %y", status);
-		fc_handler[i].state = fc_error;
+		fc_handler[i].set_state (fc_error);
 		nconnected--;
 		break;
 	      }
@@ -1417,45 +1417,51 @@ fhandler_fifo::close_all_handlers ()
   fifo_client_unlock ();
 }
 
+/* Return previous state. */
 fifo_client_connect_state
-fifo_client_handler::set_state ()
+fifo_client_handler::query_and_set_state ()
 {
   IO_STATUS_BLOCK io;
   FILE_PIPE_LOCAL_INFORMATION fpli;
   NTSTATUS status;
+  fifo_client_connect_state prev_state = get_state ();
 
   if (!h)
-    return (state = fc_unknown);
+    {
+      set_state (fc_unknown);
+      goto out;
+    }
 
   status = NtQueryInformationFile (h, &io, &fpli,
 				   sizeof (fpli), FilePipeLocalInformation);
   if (!NT_SUCCESS (status))
     {
       debug_printf ("NtQueryInformationFile status %y", status);
-      state = fc_error;
+      set_state (fc_error);
     }
   else if (fpli.ReadDataAvailable > 0)
-    state = fc_input_avail;
+    set_state (fc_input_avail);
   else
     switch (fpli.NamedPipeState)
       {
       case FILE_PIPE_DISCONNECTED_STATE:
-	state = fc_disconnected;
+	set_state (fc_disconnected);
 	break;
       case FILE_PIPE_LISTENING_STATE:
-	state = fc_listening;
+	set_state (fc_listening);
 	break;
       case FILE_PIPE_CONNECTED_STATE:
-	state = fc_connected;
+	set_state (fc_connected);
 	break;
       case FILE_PIPE_CLOSING_STATE:
-	state = fc_closing;
+	set_state (fc_closing);
 	break;
       default:
-	state = fc_error;
+	set_state (fc_error);
 	break;
       }
-  return state;
+out:
+  return prev_state;
 }
 
 void
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index 1ba76c817..0c94f6c45 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -875,18 +875,22 @@ peek_fifo (select_record *s, bool from_select)
       fh->fifo_client_lock ();
       int nconnected = 0;
       for (int i = 0; i < fh->get_nhandlers (); i++)
-	if (fh->get_fc_handler (i).set_state () >= fc_closing)
-	  {
-	    nconnected++;
-	    if (fh->get_fc_handler (i).state == fc_input_avail)
-	      {
-		select_printf ("read: %s, ready for read", fh->get_name ());
-		fh->fifo_client_unlock ();
-		fh->reading_unlock ();
-		gotone += s->read_ready = true;
-		goto out;
-	      }
-	  }
+	{
+	  fifo_client_handler &fc = fh->get_fc_handler (i);
+	  fc.query_and_set_state ();
+	  if (fc.get_state () >= fc_closing)
+	    {
+	      nconnected++;
+	      if (fc.get_state () == fc_input_avail)
+		{
+		  select_printf ("read: %s, ready for read", fh->get_name ());
+		  fh->fifo_client_unlock ();
+		  fh->reading_unlock ();
+		  gotone += s->read_ready = true;
+		  goto out;
+		}
+	    }
+	}
       fh->fifo_client_unlock ();
       if (!nconnected && fh->hit_eof ())
 	{
-- 
2.28.0

