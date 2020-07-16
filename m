Return-Path: <kbrown@cornell.edu>
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2091.outbound.protection.outlook.com [40.107.94.91])
 by sourceware.org (Postfix) with ESMTPS id C0D433857C7A
 for <cygwin-patches@cygwin.com>; Thu, 16 Jul 2020 16:19:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C0D433857C7A
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYB+ZfVSQk9g2R74/Gyx3FA/usTVP25TMa/tV+CbdOtUD+f1kfcxnbiim0GX23AXMPvgDg8pQkCBNp7yJ+payEM0qO8dugC31bJBf3rh9GOGHAcHBTEx0We8Juv0tWkaV9hB8JBup5Vd3Lf8MBXe7Uv33B2bEeiycd2jY0ATmbJ0GdpTjanVKCxEzAzDWvyQW/Tsbci82cnazSx06Nzs5Eaz8N9PittoLYMlqOdKV2m3QGyHpoE9Q0OwlVLCi+9Zhc9CRAvd86dFvBcYKCGjdW0RKG6Xqgg//zAd9bNbERyXXES71zj5nyObwWOwRDlhcvpDjpv4OoOFI/3+qgYQdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8UOMJpTKswc1jvDWnoOZUfZTrjC07RdYR2K5mlZn6c=;
 b=UT4EeyWS5Ea4kzdH3lAfSEIVQFV8ZUs8ccZnIGWxA+2vzFydCK9p3DGBHr7gZge3y68z5oCeFDbDpaIVaiZahyFBo0x6Y2z/K3sUqvVzpNdIEN5UK/w1WLIuMiUJJ3XfG9TdB9ATnimrN3GxgkrwHZGH6CSqXj8OelYcf+QQjAM2Rkzu+YqJ4ab7ejRBf+OivXS7+XMFRS8ivNp6Ul7VnnLVQUQcykVJqmLGvm2/F4qUVqHGtTwJsGQA0TL/azrc1acvx56+CIIZREhL3yZ5IBdDA23KClZFSHYa5d8HbpVdwhggmy60OSNSjb4xhrYWle6vhsu6gLmBUXy5TJ2Jqw==
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
Subject: [PATCH 03/12] Cygwin: fhandler_fifo::hit_eof: improve reliability
Date: Thu, 16 Jul 2020 12:19:06 -0400
Message-Id: <20200716161915.16994-4-kbrown@cornell.edu>
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
 Transport; Thu, 16 Jul 2020 16:19:34 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [68.175.129.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ee5b866-4c40-42a9-9215-08d829a4072d
X-MS-TrafficTypeDiagnostic: MN2PR04MB6112:
X-Microsoft-Antispam-PRVS: <MN2PR04MB6112416ED3434D704CA358B6D87F0@MN2PR04MB6112.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:252;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kKQzv73kQhYtC29JebEz5twpS0O9YwR8PFHX05cRGMTrPl4tLgO2zyOEKWmr7phrlYxknDfPJXnvTTz7VgakEV4ZL6HLbNvUg2FCk2PwoNjagsjMqEYR3//t5eEsaLzStSOvrlVuuUdBgynnbUNeIsAaC17eksYUvwu2LffeqYaTiKxaX0ApYm30cxNhLMr6xoL7lwe9BF3TvRBQgLV5rpBbHTxu+b9JNdskLEG6UENMAewCHCZPKrZDsQM5EX2ENhHBbEHQvbkJn5qoSfqA3WZ4V5vNqnEiIMMt1qbRcdCQxNPbIWeKXz9lmMHElfsMlNiDyRkOThKISFGi94IdGKz+Zs06CfrMemhtEIOcy3CyPs5LwxQJD9DsRs4+/ub5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(66946007)(2616005)(66556008)(5660300002)(69590400007)(6506007)(8676002)(83380400001)(16526019)(956004)(6486002)(6512007)(52116002)(186003)(26005)(8936002)(66476007)(478600001)(2906002)(86362001)(316002)(786003)(75432002)(1076003)(6666004)(6916009)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: yJavCOJJqm2+vqgB89j6CHZgcoNlhzzex9JXWAdUUKF2xji3v7uTlQKVuVFf9kram9FGOeXj88moUxKEmKTv2GU8k+eXRm68j2qi2vOmEvVBr6El0+yUnVXWU8ZdvrNvz6Zn7IGGfgdVcbZpEr2L0Z3T+6ctM/sN8L3Twn22z1ALCb50BCFIlOovQ7YKbcWl8CfYsvPFl488bVwPiLCKIL8ak+3kADdBHNyQErewJCop9i5JEl4l246gV6ZM1Dwo9cNaNqGHw0d4f9b0CQgtH9up1xbkkU2P5TNCjGPKe+ya/9LQHaOmMPPZbWlRlpmYAWU5Y55Knc0Bx1DITsKS+4dzxyTJMeX2jjCc0NRYvo7cLkJO/IAGax7MLRObc1cXfjOy2BwTpMTYNuwEZm8V9jWQrGBqsjOTeAeElVWzH6je3lzgaX+pEDMC9cLURN29Jv1cXgLj2/BcqKSQKr/oOFvSdEBf+YFXkCegyNZk0HE=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee5b866-4c40-42a9-9215-08d829a4072d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 16:19:34.6396 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zvUJdbYOEIy/Ng/7NSJwu36himghhG8q9dzaxIE5zmcTdqNkurvKz8BewyQPDljBKJ5xf0WJTGwe3xWnzdkzwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6112
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, JMQ_SPF_NEUTRAL,
 MSGID_FROM_MTA_HEADER, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS,
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
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 16 Jul 2020 16:19:41 -0000

Use the writer count introduced in the previous commit to help detect
EOF.  Drop the maybe_eof method, which is no longer needed.
---
 winsup/cygwin/fhandler.h       |  7 +++----
 winsup/cygwin/fhandler_fifo.cc | 26 ++------------------------
 winsup/cygwin/select.cc        |  3 +--
 3 files changed, 6 insertions(+), 30 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index f034a110e..b5bfdd0b3 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1392,7 +1392,6 @@ class fhandler_fifo: public fhandler_base
 
   UNICODE_STRING pipe_name;
   WCHAR pipe_name_buf[CYGWIN_FIFO_PIPE_NAME_LEN + 1];
-  bool _maybe_eof;
   fifo_client_handler *fc_handler;     /* Dynamically growing array. */
   int shandlers;                       /* Size (capacity) of the array. */
   int nhandlers;                       /* Number of elements in the array. */
@@ -1473,9 +1472,9 @@ class fhandler_fifo: public fhandler_base
 
 public:
   fhandler_fifo ();
-  bool hit_eof ();
-  bool maybe_eof () const { return _maybe_eof; }
-  void maybe_eof (bool val) { _maybe_eof = val; }
+  /* Called if we appear to be at EOF after polling fc_handlers. */
+  bool hit_eof () const
+  { return !nwriters () && !IsEventSignalled (writer_opening); }
   int get_nhandlers () const { return nhandlers; }
   fifo_client_handler &get_fc_handler (int i) { return fc_handler[i]; }
   PUNICODE_STRING get_pipe_name ();
diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index 26b24d019..3685cc0c2 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -87,7 +87,7 @@ fhandler_fifo::fhandler_fifo ():
   fhandler_base (),
   read_ready (NULL), write_ready (NULL), writer_opening (NULL),
   owner_needed_evt (NULL), owner_found_evt (NULL), update_needed_evt (NULL),
-  cancel_evt (NULL), thr_sync_evt (NULL), _maybe_eof (false),
+  cancel_evt (NULL), thr_sync_evt (NULL),
   fc_handler (NULL), shandlers (0), nhandlers (0),
   reader (false), writer (false), duplexer (false),
   max_atomic_write (DEFAULT_PIPEBUFSIZE),
@@ -361,8 +361,6 @@ fhandler_fifo::record_connection (fifo_client_handler& fc,
 				  fifo_client_connect_state s)
 {
   fc.state = s;
-  maybe_eof (false);
-  ResetEvent (writer_opening);
   set_pipe_non_blocking (fc.h, true);
 }
 
@@ -1173,25 +1171,6 @@ fhandler_fifo::raw_write (const void *ptr, size_t len)
   return ret;
 }
 
-/* A reader is at EOF if the pipe is empty and no writers are open.
-   hit_eof is called by raw_read and select.cc:peek_fifo if it appears
-   that we are at EOF after polling the fc_handlers.  We recheck this
-   in case a writer opened while we were polling.  */
-bool
-fhandler_fifo::hit_eof ()
-{
-  bool ret = maybe_eof () && !IsEventSignalled (writer_opening);
-  if (ret)
-    {
-      yield ();
-      /* Wait for the reader thread to finish recording any connection. */
-      fifo_client_lock ();
-      fifo_client_unlock ();
-      ret = maybe_eof ();
-    }
-  return ret;
-}
-
 /* Called from raw_read and select.cc:peek_fifo. */
 void
 fhandler_fifo::take_ownership ()
@@ -1261,9 +1240,8 @@ fhandler_fifo::raw_read (void *in_ptr, size_t& len)
 		break;
 	      }
 	  }
-      maybe_eof (!nconnected && !IsEventSignalled (writer_opening));
       fifo_client_unlock ();
-      if (maybe_eof () && hit_eof ())
+      if (!nconnected && hit_eof ())
 	{
 	  reading_unlock ();
 	  len = 0;
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index 9ae567c38..80d16f2a7 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -883,9 +883,8 @@ peek_fifo (select_record *s, bool from_select)
 		goto out;
 	      }
 	  }
-      fh->maybe_eof (!nconnected);
       fh->fifo_client_unlock ();
-      if (fh->maybe_eof () && fh->hit_eof ())
+      if (!nconnected && fh->hit_eof ())
 	{
 	  select_printf ("read: %s, saw EOF", fh->get_name ());
 	  gotone += s->read_ready = true;
-- 
2.27.0

