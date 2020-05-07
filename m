Return-Path: <kbrown@cornell.edu>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770127.outbound.protection.outlook.com [40.107.77.127])
 by sourceware.org (Postfix) with ESMTPS id 9A72C395C02C
 for <cygwin-patches@cygwin.com>; Thu,  7 May 2020 20:21:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 9A72C395C02C
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlmZdHNk8MuF22keyz3bKFU4moUaTjbeuNYTK3PiHJXAE5zAzgisHNjRyxmKdyri/DC1iRQ4kgH4m2oU4bmjLUcR0p/fkcw+WT/nhqhtKojw/91l/holZ7ekHD9URTo1gGVCHD0h1Cy2HriW5p2Lt2jXIyDXtb9KsgvcvOBDmSt5R9Y/8NHAO3D7PEovzS1VyLam7Wyu+JlFfEbuyCBE3kcYyhjGx06+Xw5fnhqscgg1kvJvgzaN1B5i4e3M1EnQyg+vj/X05VrxMODSvX7EUNZhlkyUhiNTxLixO8AI1P8SXG+cjZlVTLgLiDeY894hrdmEKhDsAH2f2NOt1I4Q+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahyxGddY3rvxmJqezv9gpyuT7aSmlxWbDbsBAqOL7P8=;
 b=OVISjt9xm9ImFps7dmROTrvf0MJ9jQHNh/i+g57lukSEYLlYXeMDaAcezXAA+GGwYO4YSJVhH7miEl2XOdmS9ymHH+8boWq2ua/6lcfY5c8+JhhRfcjk6OhGpIYP6MAUuqhWBM2RBcN8ejpPbvr5reJ5BV+ykJjB/nO+4Nc662kBC/ajwPXmJtZBkTB4p0zPG3HEQQpye4LNPAeHgtPdjQ2e+2nBf0bBfeRUJ4HUQjxYCPOa+GPXWUwd4Z+tLfBs3oZgebbtNiNsYQlruST4o/oMZvQc5vL3TORmpYHfzOtC5agUIjcbRF4JdPnEdgBPX+FIjvdA66ZIEH/f6pwgYA==
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
Subject: [PATCH 03/21] Cygwin: FIFO: change the fifo_client_connect_state enum
Date: Thu,  7 May 2020 16:21:06 -0400
Message-Id: <20200507202124.1463-4-kbrown@cornell.edu>
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
 15.20.2979.28 via Frontend Transport; Thu, 7 May 2020 20:21:43 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [2604:6000:b407:7f00:e532:58da:20b8:9136]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1db5c6c9-a67b-414b-7c04-08d7f2c44290
X-MS-TrafficTypeDiagnostic: DM6PR04MB4666:
X-Microsoft-Antispam-PRVS: <DM6PR04MB4666B1928761D8A9549112EBD8A50@DM6PR04MB4666.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1qbaRJTw9NDh3vlJg1O576KmxcKrknm2/4vlZgTbJ8TeZsieNMOwpotum0VgcSjiS/LgLJ1aoUQ3wbdgcSrwN5QiNm6ptdXRExvpv1qpAlgvFvQyFU+A8I/vXsP2zCup0cwgkKJtpuTxYUEKN95pPttbFiL5nkrmxSEiBa5YACC7L2fJVlMv73DyHH1IK+T49MkgdtLt+KSHN0nmtIiaOWj5Fh7BVfY/YbGlPXo2QtvWdGmD05YBBB0g0L+nQ6Vkm/FLZUvg6N76XmulRBIM9tSq/UOFWBWdd9tCiBKn6iBlnOgxEQParYSdOE+VWkDUiJNeAJrC2DN13qhvODfOiW6dGOqOYuVlD+yNe7nZsMPIfHvVGdsOl5jbFE4JgzdTeCv2WqeaMzmAVsRXZnlvdq1IhXZW8kO3qWbo0nT5EAODxV63OGnYaqdaIlObaOKcgsjOogE9sBiHgPqH+hdD/CsDlghZVXTUGQO8RHMZ5vDKUL5cy1yk3U5OUjatvWa6mUPcyR3hCjy49Ilz3SmiTQq93la/b4lBFawDMhv1Y4H+QXqM/PVHTnVeSZLkCAP9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6075.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(33430700001)(66946007)(1076003)(69590400007)(75432002)(6486002)(66556008)(316002)(2906002)(2616005)(6506007)(6512007)(36756003)(16526019)(4326008)(6666004)(33440700001)(5660300002)(786003)(66476007)(86362001)(478600001)(186003)(8676002)(83320400001)(83280400001)(83310400001)(83290400001)(6916009)(8936002)(83300400001)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: l81eL6c5dtQ9TmrdVflwMsgfzE0XntGCygBhR1zuxbcGD/RIkPFe0+oIu4hmXdE+kVqvAOl2mN3aElA34xBOdNOTer37BeJ4jsQq/986S7eFG0JoNKF2R18GldlEP7zt4hE/jVBTTv5J22xXEC8QEQ4VQNL/JQYcfsmJPfuIzcj7Va7GuApncFMaLR2jsrbf3mL8V6RBWnLq7fG/PWhugA7c+h+M8IqOWzi7VGG3UBljcYtC9Z+C5tsnf6nwP/tUmXRGCbQsAk/xx9MS3b0xM/EGUsfsongTQWtlo3n5FMfO/Kqci+0q1XSHtg0sFY12MoNsxGdREgwwe702QHRxS8cJVd7+IVc+CDsf3BPB+JSMIY3XNYs0CkxzSyJN/+NCdN0QE1bN+vk3py3cc02bCuibvgLA75GgsD7yNDuNzFJmsKNHlm1cqL94KAHRKQhHgOI2OWajUnDCTAlXLMrHU98RUqfScL+qIGdLL0iB6/FW2NuJpAJmb0dz5lMsMbeRuyAmqrLjmKUnjU5rqUJpsWK09Hkl+vvtpChYtzyfDnG/MivVsyGdpm7GcL0VvGk2p/tstKRz+AwLfOY5AOJPBI8rr/QLZs2ImF5gYjTr3cb6X8vAIsAfX/kDie8ruoxOFggdedVrHgoahwcXtwCN1OGiBHuSyv8nmhRKFCNNkCL6ZFRLuIF8+Y52sbEFnoamUcEq98Rdx2uYM6UOHvnXFui7rU8upJ2Ya4yQrn4nwBJlJRneojVBpfKrAwjcmY0Vrbqya+ZEQXFoloWH3hKLouRZrv3SE72Cnshmu69ftnTWl4BN4fyVSXUSKTd0gmGxRxsg86uQVsBXv2KD3p36KCIL7usPv8P9s7K84KEJuSr/7VEuNRp0+jxfz0hlYyO7
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db5c6c9-a67b-414b-7c04-08d7f2c44290
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 20:21:44.3110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+oNa3Lvqtqlrdzkc0YHkyNg0x8fylcQ02dAipR9SWokS5wz4D1Ho13o6Qm2S8YriB6BCEuWF3nlNESCYiEpFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4666
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 07 May 2020 20:21:58 -0000

Make the values correspond to the possible return values of
fifo_client_handler::pipe_state().

When cleaning up the fc_handler list in listen_client_thread(), don't
delete handlers in the fc_closing state.  I think the pipe might still
have input to be read in that case.

Set the state to fc_closing later in the same function if a connection
is made and the status returned by NtFsControlFile is
STATUS_PIPE_CLOSING.

In raw_read, don't error out if NtReadFile returns an unexpected
status; just set the state of that handler to fc_error.  One writer in
a bad state doesn't justify giving up on reading.
---
 winsup/cygwin/fhandler.h       | 10 ++++++++--
 winsup/cygwin/fhandler_fifo.cc | 29 ++++++++++++++---------------
 2 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index e841f96ac..c1f47025a 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1270,11 +1270,16 @@ public:
 #define CYGWIN_FIFO_PIPE_NAME_LEN     47
 #define MAX_CLIENTS 64
 
+/* The last three are the ones we try to read from. */
 enum fifo_client_connect_state
 {
   fc_unknown,
+  fc_error,
+  fc_disconnected,
+  fc_listening,
   fc_connected,
-  fc_invalid
+  fc_closing,
+  fc_input_avail,
 };
 
 enum
@@ -1316,7 +1321,8 @@ class fhandler_fifo: public fhandler_base
   bool listen_client ();
   int stop_listen_client ();
   int check_listen_client_thread ();
-  void record_connection (fifo_client_handler&);
+  void record_connection (fifo_client_handler&,
+			  fifo_client_connect_state = fc_connected);
 public:
   fhandler_fifo ();
   bool hit_eof ();
diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index 6b71dd950..ba3dbb124 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -267,6 +267,7 @@ fhandler_fifo::add_client_handler ()
     {
       ret = 0;
       fc.h = ph;
+      fc.state = fc_listening;
       fc_handler[nhandlers++] = fc;
     }
 out:
@@ -311,10 +312,11 @@ fhandler_fifo::listen_client ()
 }
 
 void
-fhandler_fifo::record_connection (fifo_client_handler& fc)
+fhandler_fifo::record_connection (fifo_client_handler& fc,
+				  fifo_client_connect_state s)
 {
   SetEvent (write_ready);
-  fc.state = fc_connected;
+  fc.state = s;
   nconnected++;
   set_pipe_non_blocking (fc.h, true);
 }
@@ -330,15 +332,12 @@ fhandler_fifo::listen_client_thread ()
 
   while (1)
     {
-      /* At the beginning of the loop, all client handlers are
-	 in the fc_connected or fc_invalid state. */
-
-      /* Delete any invalid clients. */
+      /* Cleanup the fc_handler list. */
       fifo_client_lock ();
       int i = 0;
       while (i < nhandlers)
 	{
-	  if (fc_handler[i].state == fc_invalid)
+	  if (fc_handler[i].state < fc_connected)
 	    delete_client_handler (i);
 	  else
 	    i++;
@@ -393,6 +392,10 @@ fhandler_fifo::listen_client_thread ()
 	  record_connection (fc);
 	  ResetEvent (evt);
 	  break;
+	case STATUS_PIPE_CLOSING:
+	  record_connection (fc, fc_closing);
+	  ResetEvent (evt);
+	  break;
 	case STATUS_THREAD_IS_TERMINATING:
 	  /* Force NtFsControlFile to complete.  Otherwise the next
 	     writer to connect might not be recorded in the client
@@ -835,7 +838,7 @@ fhandler_fifo::raw_read (void *in_ptr, size_t& len)
       /* Poll the connected clients for input. */
       fifo_client_lock ();
       for (int i = 0; i < nhandlers; i++)
-	if (fc_handler[i].state == fc_connected)
+	if (fc_handler[i].state >= fc_connected)
 	  {
 	    NTSTATUS status;
 	    IO_STATUS_BLOCK io;
@@ -859,18 +862,14 @@ fhandler_fifo::raw_read (void *in_ptr, size_t& len)
 	      case STATUS_PIPE_EMPTY:
 		break;
 	      case STATUS_PIPE_BROKEN:
-		/* Client has disconnected.  Mark the client handler
-		   to be deleted when it's safe to do that. */
-		fc_handler[i].state = fc_invalid;
+		fc_handler[i].state = fc_disconnected;
 		nconnected--;
 		break;
 	      default:
 		debug_printf ("NtReadFile status %y", status);
-		__seterrno_from_nt_status (status);
-		fc_handler[i].state = fc_invalid;
+		fc_handler[i].state = fc_error;
 		nconnected--;
-		fifo_client_unlock ();
-		goto errout;
+		break;
 	      }
 	  }
       fifo_client_unlock ();
-- 
2.21.0

