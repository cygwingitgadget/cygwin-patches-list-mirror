Return-Path: <kbrown@cornell.edu>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770124.outbound.protection.outlook.com [40.107.77.124])
 by sourceware.org (Postfix) with ESMTPS id 94D4E396D823
 for <cygwin-patches@cygwin.com>; Thu,  7 May 2020 20:21:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 94D4E396D823
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnoK7a8+t99+pQalarySg0i1MxJWn9UrkWOupdLI6Vg1Ro31742cF4a4PFJo2KBH+LLGKJ01euWL4PgYGH1kTb2d/1BYDZ4EBmnln5e/nMWGaRgEeeHNjgGTPrrw/yRFQuHVHZn1m66F96GHO8Y1rfN7rdr7gSH+aOO0Q4nTxm3CITuOjXZ7S6MWseG8hF0qmHYodWdExiuQSUiZS1JvGk+Exxmapn1+nInjSoZRsdSTicoGrGoLLpYO24dMspdjV6Fo52SsKRgJY5o4xoGz+p5927yCPrahvwHTjo0/GztkaetovBivWKEXLtmgn0KhylDOlk1EEnA+onP8KXc1Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94bCzne9mnt/aZBvuYgB4kOUYND7xRaU8QTP3G/gBqQ=;
 b=TufHvQ2LLNua3EkLYHxZj92LsJOgX80G+M6h9/N6E4FwkQf2Pnr/4YVV3mTfUlunrMMoqt9zLrV7IZQusA2rub1K6/Cs3+ihPfvEwCUfZ4BvXW1mIojFLVz8MReePQfPOV4fRQHeDpLzQupaiOntIPhSRzkinAYaiO9Ijo7YJ6BluLpYAQ/9i8PdcdukM0Xae430jyO8WRJgz7HcAzJ6lROWWZOhxSZT4FpurPftrohIycHA8y3+xAxEX8CWrq/o1XzSJCGV2DN0kbG/nF6zdawPTcl15H+MhpXri3dZbirlEYaYjo+YAit5pZsyxD7y0NhOG6GPDL7RJZ0BT8EX0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from DM6PR04MB6075.namprd04.prod.outlook.com (2603:10b6:5:127::31)
 by DM6PR04MB4666.namprd04.prod.outlook.com (2603:10b6:5:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Thu, 7 May
 2020 20:21:45 +0000
Received: from DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4]) by DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4%4]) with mapi id 15.20.2979.025; Thu, 7 May 2020
 20:21:45 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Cc: sten.kristian.ivarsson@gmail.com
Subject: [PATCH 02/21] Cygwin: FIFO: simplify the fifo_client_handler structure
Date: Thu,  7 May 2020 16:21:05 -0400
Message-Id: <20200507202124.1463-3-kbrown@cornell.edu>
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
 15.20.2979.28 via Frontend Transport; Thu, 7 May 2020 20:21:42 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [2604:6000:b407:7f00:e532:58da:20b8:9136]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b8bbad9-6db3-4dc1-e80b-08d7f2c4421a
X-MS-TrafficTypeDiagnostic: DM6PR04MB4666:
X-Microsoft-Antispam-PRVS: <DM6PR04MB4666BEA69BD63D12DB30B4EAD8A50@DM6PR04MB4666.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /yF0qaVBZvjo0sD/OORZwjJCeT2UZ0PMc1X0qHsdW1sy+/rknhjTwMieI+C4FTUwhNljyekTB0zZRUpuvbyb2cr+TJjCWcuWm1swssiD7E/5EZRNHN7/+qqzAh7msmWypKZ3P0ZA9AI79CR6c2GRFo33YP5faLxDcyTJhl3DBXzmwvRbRnp4qXSqPFaUCNsnctQQhSH8FYsJYsd78tqc1voM1xj8T7N+Mbsuk8yI5F8xdj93zrBHASDe/YMVcEDmutTBOPKdeVNZK14Um5KM4RxkWuzKDvzdVONtk8N3pgJTDecvCOoCv/6ZRtkXFf3O3R9wOn0aITE+gkEDWn3y5ruRwoos0DqsE2t3MU8W3k0SS93dltLExlc63QEWEFhOi9ztD4o58ZAzH9EVSnsoEuGd3lFhp/PG+ewXh/qHmip/gQNTOd2fFgwF7JaWhwfz5eMR2KR22m9566+Sd7TU9HCwk+aV7R3QQO4yrniFZVdeZTwQxEStwtrn3XwGu4GfvQxB3WFTZ9wT7D4v2layJ/p8p7FU9/OZ9NX8T+jd5r6GAqDPsg7UG8LYqrnaD0eA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6075.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(33430700001)(66946007)(1076003)(69590400007)(75432002)(6486002)(66556008)(316002)(2906002)(2616005)(6506007)(6512007)(36756003)(16526019)(4326008)(6666004)(33440700001)(5660300002)(786003)(66476007)(86362001)(478600001)(186003)(8676002)(83320400001)(83280400001)(83310400001)(83290400001)(6916009)(8936002)(83300400001)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: gN/fWgrJ/waLAPpt0G1tu5X8YEI2H770azXIqIRz2R74nmardjljy7VeJ3q3xFwSRh7ZaEQUrQaCTUf/MbcA0J0+TX/ki8FWcPGW+emRC4GqDH/qt5Wihh4yw1MMqbREGzeapTrnOS+2Pwe5dqH9UJq2pF6vIAaatMTBAJBSoZ9th8E3U2HEq3mmeTYYArgK5gpwdO3HWW2iBFwc1P7YQpxUwDZ2T2Pt0FXKHblr2RfMsQrNaHTCbVkgb1j9uOwjDIqFYzRvmQgG1gSA59wPz2UpRRVcFs/damk6/EYW7UJtPEdkQJmLoo5IDQwp2/esVu9gi1NaJRGEVun71/UmVyO2Uh0SH/D7XmjLAZqgalCmvdZxNy0JnKGYddHhdNrkEe7Vtbw3qGMI8DfCp5ULhD5gvnSgN4wj20kdM2giGDEHkm9dHNLaUm3B9mdJpDjX0pTYNptv0FSe7sfFe7WT5qwQvcCcOZtXfMV/g+2zVfiXm6gU2e2VzX2gXMGlsl5Js9KCRAbPgVKF1XoC/7+gsklUG0w165TLRIOKPMaglZ2cN/k/b0pkt1l7FIpYXkAUBKb9cEEXGD9/52HDN0ZRmI0B6uICe9CMSttjkcAIjGtIt5bbWdGGkvZnuZZ1zns52S2WcWU6BLXbdio0hjHziSvfiUGolN2wQ0ugd5Madm8vCcKF1bqEMaQRTgQprAaAjGgxuxyX625qsn+U50k1faf+Ed8muDZiy082V8OqYGVMFCw1OjhbH1uO1sNKwrk3iqUQ/25nMyoOsanI+CVqwrkIkstTzP0MzEYwY0MKk8YTNotzGfxW6GD0szHWrFzpcdgwZ/52c3s/Ykj+EmePgXNOa+QvAHK86RiA3wCPqafewwRD/Xq5CMLxbO8MsSvF
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b8bbad9-6db3-4dc1-e80b-08d7f2c4421a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 20:21:43.4694 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CtdkIk2zqI//t30at18dawfhH0bdF27p99FYOyWAODpqFoWJGnsabd3pTY4Bakx/xBC+zlgMrcpcTc0ZI3huhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4666
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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

Replace the 'fhandler_base *' member by a HANDLE to the server side of
the Windows named pipe instance.  Make the corresponding
simplifications throughout.
---
 winsup/cygwin/fhandler.h       | 19 +++-------
 winsup/cygwin/fhandler_fifo.cc | 65 ++++++++--------------------------
 2 files changed, 19 insertions(+), 65 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 1c7336370..e841f96ac 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1284,10 +1284,10 @@ enum
 
 struct fifo_client_handler
 {
-  fhandler_base *fh;
+  HANDLE h;
   fifo_client_connect_state state;
-  fifo_client_handler () : fh (NULL), state (fc_unknown) {}
-  int close ();
+  fifo_client_handler () : h (NULL), state (fc_unknown) {}
+  void close () { NtClose (h); }
 /* Returns FILE_PIPE_DISCONNECTED_STATE, FILE_PIPE_LISTENING_STATE,
    FILE_PIPE_CONNECTED_STATE, FILE_PIPE_CLOSING_STATE,
    FILE_PIPE_INPUT_AVAILABLE_STATE, or -1 on error. */
@@ -1312,7 +1312,7 @@ class fhandler_fifo: public fhandler_base
   HANDLE create_pipe_instance (bool);
   NTSTATUS open_pipe (HANDLE&);
   int add_client_handler ();
-  int delete_client_handler (int);
+  void delete_client_handler (int);
   bool listen_client ();
   int stop_listen_client ();
   int check_listen_client_thread ();
@@ -1321,8 +1321,7 @@ public:
   fhandler_fifo ();
   bool hit_eof ();
   int get_nhandlers () const { return nhandlers; }
-  HANDLE get_fc_handle (int i) const
-  { return fc_handler[i].fh->get_handle (); }
+  HANDLE get_fc_handle (int i) const { return fc_handler[i].h; }
   bool is_connected (int i) const
   { return fc_handler[i].state == fc_connected; }
   PUNICODE_STRING get_pipe_name ();
@@ -1345,12 +1344,6 @@ public:
   void fixup_after_fork (HANDLE);
   void fixup_after_exec ();
   int __reg2 fstatvfs (struct statvfs *buf);
-  void clear_readahead ()
-  {
-    fhandler_base::clear_readahead ();
-    for (int i = 0; i < nhandlers; i++)
-      fc_handler[i].fh->clear_readahead ();
-  }
   select_record *select_read (select_stuff *);
   select_record *select_write (select_stuff *);
   select_record *select_except (select_stuff *);
@@ -1374,8 +1367,6 @@ public:
     /* fhf->pipe_name_buf is a *copy* of this->pipe_name_buf, but
        fhf->pipe_name.Buffer == this->pipe_name_buf. */
     fhf->pipe_name.Buffer = fhf->pipe_name_buf;
-    for (int i = 0; i < nhandlers; i++)
-      fhf->fc_handler[i].fh = fc_handler[i].fh->clone ();
     return fhf;
   }
 };
diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index c091b0add..6b71dd950 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -252,7 +252,6 @@ fhandler_fifo::add_client_handler ()
 {
   int ret = -1;
   fifo_client_handler fc;
-  fhandler_base *fh;
   HANDLE ph = NULL;
   bool first = (nhandlers == 0);
 
@@ -261,40 +260,26 @@ fhandler_fifo::add_client_handler ()
       set_errno (EMFILE);
       goto out;
     }
-  if (!(fh = build_fh_dev (dev ())))
-    {
-      set_errno (EMFILE);
-      goto out;
-    }
   ph = create_pipe_instance (first);
   if (!ph)
-    {
-      delete fh;
-      goto out;
-    }
+    goto out;
   else
     {
-      fh->set_handle (ph);
-      fh->set_flags ((openflags & ~O_ACCMODE) | O_RDONLY);
-      fh->set_nonblocking (false);
       ret = 0;
-      fc.fh = fh;
-      fifo_client_lock ();
+      fc.h = ph;
       fc_handler[nhandlers++] = fc;
-      fifo_client_unlock ();
     }
 out:
   return ret;
 }
 
-int
+void
 fhandler_fifo::delete_client_handler (int i)
 {
-  int ret = fc_handler[i].close ();
+  fc_handler[i].close ();
   if (i < --nhandlers)
     memmove (fc_handler + i, fc_handler + i + 1,
 	     (nhandlers - i) * sizeof (fc_handler[i]));
-  return ret;
 }
 
 /* Just hop to the listen_client_thread method. */
@@ -331,8 +316,7 @@ fhandler_fifo::record_connection (fifo_client_handler& fc)
   SetEvent (write_ready);
   fc.state = fc_connected;
   nconnected++;
-  fc.fh->set_nonblocking (true);
-  set_pipe_non_blocking (fc.fh->get_handle (), true);
+  set_pipe_non_blocking (fc.h, true);
 }
 
 DWORD
@@ -355,13 +339,7 @@ fhandler_fifo::listen_client_thread ()
       while (i < nhandlers)
 	{
 	  if (fc_handler[i].state == fc_invalid)
-	    {
-	      if (delete_client_handler (i) < 0)
-		{
-		  fifo_client_unlock ();
-		  goto out;
-		}
-	    }
+	    delete_client_handler (i);
 	  else
 	    i++;
 	}
@@ -383,7 +361,7 @@ fhandler_fifo::listen_client_thread ()
       NTSTATUS status;
       IO_STATUS_BLOCK io;
 
-      status = NtFsControlFile (fc.fh->get_handle (), evt, NULL, NULL, &io,
+      status = NtFsControlFile (fc.h, evt, NULL, NULL, &io,
 				FSCTL_PIPE_LISTEN, NULL, 0, NULL, 0);
       if (status == STATUS_PENDING)
 	{
@@ -424,8 +402,7 @@ fhandler_fifo::listen_client_thread ()
 	      && (NT_SUCCESS (io.Status) || io.Status == STATUS_PIPE_CONNECTED))
 	    {
 	      debug_printf ("successfully connected bogus client");
-	      if (delete_client_handler (nhandlers - 1) < 0)
-		ret = -1;
+	      delete_client_handler (nhandlers - 1);
 	    }
 	  else if ((ps = fc.pipe_state ()) == FILE_PIPE_CONNECTED_STATE
 		   || ps == FILE_PIPE_INPUT_AVAILABLE_STATE)
@@ -948,19 +925,6 @@ fhandler_fifo::fstatvfs (struct statvfs *sfs)
   return fh.fstatvfs (sfs);
 }
 
-int
-fifo_client_handler::close ()
-{
-  int res = 0;
-
-  if (fh)
-    {
-      res = fh->fhandler_base::close ();
-      delete fh;
-    }
-  return res;
-}
-
 int
 fifo_client_handler::pipe_state ()
 {
@@ -968,7 +932,7 @@ fifo_client_handler::pipe_state ()
   FILE_PIPE_LOCAL_INFORMATION fpli;
   NTSTATUS status;
 
-  status = NtQueryInformationFile (fh->get_handle (), &io, &fpli,
+  status = NtQueryInformationFile (h, &io, &fpli,
 				   sizeof (fpli), FilePipeLocalInformation);
   if (!NT_SUCCESS (status))
     {
@@ -1022,8 +986,7 @@ fhandler_fifo::close ()
     NtClose (write_ready);
   fifo_client_lock ();
   for (int i = 0; i < nhandlers; i++)
-    if (fc_handler[i].close () < 0)
-      ret = -1;
+    fc_handler[i].close ();
   fifo_client_unlock ();
   return fhandler_base::close () || ret;
 }
@@ -1078,9 +1041,9 @@ fhandler_fifo::dup (fhandler_base *child, int flags)
   fifo_client_lock ();
   for (int i = 0; i < nhandlers; i++)
     {
-      if (!DuplicateHandle (GetCurrentProcess (), fc_handler[i].fh->get_handle (),
+      if (!DuplicateHandle (GetCurrentProcess (), fc_handler[i].h,
 			    GetCurrentProcess (),
-			    &fhf->fc_handler[i].fh->get_handle (),
+			    &fhf->fc_handler[i].h,
 			    0, true, DUPLICATE_SAME_ACCESS))
 	{
 	  fifo_client_unlock ();
@@ -1114,7 +1077,7 @@ fhandler_fifo::fixup_after_fork (HANDLE parent)
   fork_fixup (parent, write_ready, "write_ready");
   fifo_client_lock ();
   for (int i = 0; i < nhandlers; i++)
-    fc_handler[i].fh->fhandler_base::fixup_after_fork (parent);
+  fork_fixup (parent, fc_handler[i].h, "fc_handler[].h");
   fifo_client_unlock ();
   if (reader && !listen_client ())
     debug_printf ("failed to start lct, %E");
@@ -1136,6 +1099,6 @@ fhandler_fifo::set_close_on_exec (bool val)
   set_no_inheritance (write_ready, val);
   fifo_client_lock ();
   for (int i = 0; i < nhandlers; i++)
-    fc_handler[i].fh->fhandler_base::set_close_on_exec (val);
+    set_no_inheritance (fc_handler[i].h, val);
   fifo_client_unlock ();
 }
-- 
2.21.0

