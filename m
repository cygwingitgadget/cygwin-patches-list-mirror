Return-Path: <kbrown@cornell.edu>
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2090.outbound.protection.outlook.com [40.107.94.90])
 by sourceware.org (Postfix) with ESMTPS id 41E003854806
 for <cygwin-patches@cygwin.com>; Sun,  8 Nov 2020 17:18:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 41E003854806
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbS2kUAJ1L2nJv2+P3fhBpgiKFFeYIZ7jm3CZvTzjOc6OPk5N2EQ66SLq0DihmJKlUFXxUu/05hgIUmtvaaiKoWNXNT/jXHQ9bQoOSkQR8iqSNwqUpRC14CpnBzBKUlKN6ClXV6ZAeuNczQbnquvC3bb6XNeJVQw0nrqf0yG6VS1xEUAd7dvyuq3qRjEikPSsavOwveceiFu0ymcXWvIjn/kwjgAoJRVBlt5u8sDZZ0bxDIqwcHectGIdEHalAKBjxNGWRJb+IZuZujp66yO9LgCt940H/gtFrQ+ENZvGrrnckiixhDicN39kN8zq5tM3YbYwofWkRVe8f1CrUs0kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZwjCQMsxrMLsqsmtHjLuXHIdufCRsUhexsR741joJQ=;
 b=gvDZfxxQo4hgyEB3fStIU9tePIUOQWQMSklobahmaoCRp0r9DJx4tkmhUqmgf97QYVhQq0MSbpE3V1im1wXFpGwPKe40Z2hvNDcJmOVuzY392YUmG9Ipzsj/Rwk4NhZIrTCcpXZ+dKIpSX/GI+J/rKUV2V5o9XmxV4lWL9bSgEgcDp7Pr6cgDZF+eDampL46kD0Pw+M1FBHpU8rO+MY7aXrEMN6Zuaz4QjxWoGTdGwTxo2JCe/QRIuZmkvCD9pmkdrHcLxedkKwiETrud8nWmbjwdpo2RzVqJMF0ml4X2kDeL5qtSBIGu+C46GZ9EDtjiGWtKSN98ZW9i37JIVs6Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB6208.namprd04.prod.outlook.com (2603:10b6:208:e3::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Sun, 8 Nov
 2020 17:18:14 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::113e:c874:1207:eca8]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::113e:c874:1207:eca8%6]) with mapi id 15.20.3541.024; Sun, 8 Nov 2020
 17:18:14 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: fhandler_fifo: reduce size
Date: Sun,  8 Nov 2020 12:16:32 -0500
Message-Id: <20201108171632.39541-1-kbrown@cornell.edu>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [68.175.129.7]
X-ClientProxiedBy: BL1PR13CA0164.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::19) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (68.175.129.7) by
 BL1PR13CA0164.namprd13.prod.outlook.com (2603:10b6:208:2bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.13 via Frontend
 Transport; Sun, 8 Nov 2020 17:18:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebe299a4-19b2-434b-a7d2-08d8840a46a7
X-MS-TrafficTypeDiagnostic: MN2PR04MB6208:
X-Microsoft-Antispam-PRVS: <MN2PR04MB62088EF4ED0BBEF4C0643139D8EB0@MN2PR04MB6208.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rr/5hCfkCLIlzYw9hcuAbCvV3QbnICcisflCdR2mKVu5+igtzmBiK9/RpMZZZfCH1JF/PTzP3CL18L+z3QrKpxgJrP3wUlNE0dnJHWrFadF1Bu1Zx9zHiXlNcoVnfXPbQ1wmFTdc7hpvhBg20TTiLV7nyhTVSvZW0nWB/3F7ySGCtPH57jGn3SHbrLobqwq82H89MJp+/eZ2NcRzk47191vSEo6zVoBoXX9wS1wnZv7LgDjaYO3kTK+1Tt/DsaWuB/2+jdCjhTVbaRFg8HW8vH97ay1zf1IrI3cUCJ98qWYYeM9NNQTVRRC4jdlYjSFf2dvfy96z9Cpbap631nhpD3G8EsuB2zd52B+ALWBONki6C9ssvHbq+wD0oCIANYCk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(8936002)(8676002)(6666004)(16526019)(2616005)(75432002)(786003)(316002)(5660300002)(66476007)(66556008)(66946007)(1076003)(6916009)(186003)(956004)(478600001)(36756003)(83380400001)(86362001)(6506007)(52116002)(6486002)(6512007)(26005)(69590400008)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: odQGq5BZsPIK0y6ulqTjSwUluyOCnzCHFeLrDVaPAjF3HY1txc2DB6MhS7PijkjyQs/rVeoYMC74chBv2mVhMo2cwiXrZpMF9SbPhXavxennFORSsHgDp2dB1OHiJ8rS8MgZBRv721AJAeWZ+0N8OrBXIGHyldoFWwqh5tsBl2+UizsRNo+lUH5SKFDDrG+ondXTIty0B/r1vzfUmmV2bhBPQIP0S6pv1fzFIFVH47n9jLzNVfzZELQKdmk6J89uHaYadl3IWkIhMcyx03x3mUsSqBBKkORJJ7d/wndACqdd7hhHAmgxmwzG6Nh6OR4Kp3BHtMAhpvrfXaAkOocV9O56gzx1fyvG8kcPiJAoNoIdendCtQLDoSgewJFMOXg5+mp7R1IBrfkjlxBLR2luEdsYWT/KNNxrQ/Go9NqKdZkstWoUV9u7oDPrUVbVK9ChObtpQeJzf0RSR+gIbKtyFVXmdOF1hKiLixzhY5uMY75unpfV7sPSiFnrpmCv6I0SPDKdPaa8ENmSMl8MwfL/z5KhZ6+axhB+VxYA9OQ4ul524iJ9R0xp0WCj0m9VP+6WcWy0Bepu+HBY/8dRAcPUylllWyde8qTe4xtfSMom03dxeIH8hrDROlcypAMFPNAWwkdHWfxEl34QSKFImevvWA==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe299a4-19b2-434b-a7d2-08d8840a46a7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2020 17:18:14.4306 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 24AcfGHicgnaFRZaSgKR4KCMxxTEau6aICRT7r5eNW0gOQYzxDtZDywAcBZM+wGyMYWkEq+R5dpUMC2NMTQjgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6208
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sun, 08 Nov 2020 17:18:18 -0000

Replace the 'WCHAR pipe_name_buf[48]' class member by 'PWCHAR
pipe_name_buf', and allocate space for the latter as needed.

Change the default constructor to accommodate this change, and add a
destructor that frees the allocated space.

Also change get_pipe_name and clone to accommodate this change.
---
 winsup/cygwin/fhandler.h       | 12 +++++++-----
 winsup/cygwin/fhandler_fifo.cc | 11 +++++++----
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index d7bd0ac06..fe76c0781 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1384,7 +1384,7 @@ class fhandler_fifo: public fhandler_base
   HANDLE thr_sync_evt;          /* The thread has terminated. */
 
   UNICODE_STRING pipe_name;
-  WCHAR pipe_name_buf[CYGWIN_FIFO_PIPE_NAME_LEN + 1];
+  PWCHAR pipe_name_buf;
   fifo_client_handler *fc_handler;     /* Dynamically growing array. */
   int shandlers;                       /* Size (capacity) of the array. */
   int nhandlers;                       /* Number of elements in the array. */
@@ -1467,6 +1467,11 @@ class fhandler_fifo: public fhandler_base
 
 public:
   fhandler_fifo ();
+  ~fhandler_fifo ()
+  {
+    if (pipe_name_buf)
+      cfree (pipe_name_buf);
+  }
   /* Called if we appear to be at EOF after polling fc_handlers. */
   bool hit_eof () const
   { return !nwriters () && !IsEventSignalled (writer_opening); }
@@ -1512,11 +1517,8 @@ public:
   {
     void *ptr = (void *) ccalloc (malloc_type, 1, sizeof (fhandler_fifo));
     fhandler_fifo *fhf = new (ptr) fhandler_fifo (ptr);
-    /* We don't want our client list to change any more. */
     copyto (fhf);
-    /* fhf->pipe_name_buf is a *copy* of this->pipe_name_buf, but
-       fhf->pipe_name.Buffer == this->pipe_name_buf. */
-    fhf->pipe_name.Buffer = fhf->pipe_name_buf;
+    fhf->pipe_name_buf = NULL;
     return fhf;
   }
 };
diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index 3af7e2f72..eff05d242 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -131,25 +131,28 @@ fhandler_fifo::fhandler_fifo ():
   fhandler_base (),
   read_ready (NULL), write_ready (NULL), writer_opening (NULL),
   owner_needed_evt (NULL), owner_found_evt (NULL), update_needed_evt (NULL),
-  cancel_evt (NULL), thr_sync_evt (NULL),
+  cancel_evt (NULL), thr_sync_evt (NULL), pipe_name_buf (NULL),
   fc_handler (NULL), shandlers (0), nhandlers (0),
   reader (false), writer (false), duplexer (false),
   max_atomic_write (DEFAULT_PIPEBUFSIZE),
   me (null_fr_id), shmem_handle (NULL), shmem (NULL),
   shared_fc_hdl (NULL), shared_fc_handler (NULL)
 {
-  pipe_name_buf[0] = L'\0';
   need_fork_fixup (true);
 }
 
 PUNICODE_STRING
 fhandler_fifo::get_pipe_name ()
 {
-  if (!pipe_name_buf[0])
+  if (!pipe_name_buf)
     {
+      pipe_name.Length = CYGWIN_FIFO_PIPE_NAME_LEN * sizeof (WCHAR);
+      pipe_name.MaximumLength = pipe_name.Length + sizeof (WCHAR);
+      pipe_name_buf = (PWCHAR) cmalloc_abort (HEAP_STR,
+					      pipe_name.MaximumLength);
+      pipe_name.Buffer = pipe_name_buf;
       __small_swprintf (pipe_name_buf, L"%S-fifo.%08x.%016X",
 			&cygheap->installation_key, get_dev (), get_ino ());
-      RtlInitUnicodeString (&pipe_name, pipe_name_buf);
     }
   return &pipe_name;
 }
-- 
2.28.0

