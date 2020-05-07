Return-Path: <kbrown@cornell.edu>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770124.outbound.protection.outlook.com [40.107.77.124])
 by sourceware.org (Postfix) with ESMTPS id 3A97C395B81B
 for <cygwin-patches@cygwin.com>; Thu,  7 May 2020 20:21:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 3A97C395B81B
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggveTrmEJJRKMZ+llbJPILU5GGFsgUHxX50Ldgzv+1Kyd6fVl45h9miE3Ga1+2Dk0M5jacj5cWVcpXWonPCAlCgNEXO4A/dLbwtrdE56TiEsMj4WTUp6i7AL6ng/suwnl240BFRFjDRkb/+jvkdDjvw5i4Chv0M8GAroH/ML9oVELdOWtmKBx21KFJoT+kyzpO3zF/T3Z8EnnRofJ73nWinQCltTLkqIXp2s7GS/e9EvRQsK/rTGT7x0lUolNORE0jlI3qwI8WKhqSYNd7A3s+GVEjzRvDUAMOdIDnuR0bwB5Xa8LBVXAW4p3yIoAo1hv0OEXtvuauZDMM2NRRgNng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+44bUOcJte4g4CGn1J/EaqGXF6gYBFp732SGGQ7EwI=;
 b=amGJ4MpfybufwsR8Hl319oBjuzsnIzVO8V7Kd120OU5lcG9n4p9Mk+AzSoq+ZDFAHUf1HJQPS6JpUuVsFAnpKrasXo/vKrqDfD4uDrLbCXS5GowtkSa8Idpm3sD8GjTgH5i07Kbkh6OrAj+qFoZiyWc00ap7nypYc6gydAsrORj0s+6nTwSZZc4EErCaTQhxSYvlz+X5A8YJGIvuPqwtExR99cTXdsLA7uktvVIqgfWGmIkRGJMQcR4ylmVt+4kOkfIZB/qNNGmQJVkoNIYUQRcioZl+0HCB4UGZ0JrqHq37yaTSkr03jl2SK39dSPDBw7PK+wg6QvNbSqWxYRsnhQ==
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
Subject: [PATCH 05/21] Cygwin: FIFO: remove the arm method
Date: Thu,  7 May 2020 16:21:08 -0400
Message-Id: <20200507202124.1463-6-kbrown@cornell.edu>
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
 15.20.2979.28 via Frontend Transport; Thu, 7 May 2020 20:21:45 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [2604:6000:b407:7f00:e532:58da:20b8:9136]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2bfa32f-d2fc-42b6-0146-08d7f2c44398
X-MS-TrafficTypeDiagnostic: DM6PR04MB4666:
X-Microsoft-Antispam-PRVS: <DM6PR04MB4666C7816B8B65D0BA533CEED8A50@DM6PR04MB4666.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0XvVK5Ba2RgZydQYxXyNcXatCynvKWERdPI+BCM5Nqt8QFVY9yfz1/qae7IRnh+7jMgQi3kF/6FEp1yUhyiQiPqiKqEXHWFUDpCbGmGPf9LmuB7AwzH4O3AoxCF7g7R75+kl3DeOUrrwQw+q7LY9cmDnY0I2fV+KhtK0CvuTLMeZai0V6II3bJiumumpmFq1Pnotcdxa1Gxu7FIwpLmXQ2PNiZzfNmLa6imlsY/vKfxc0Loy8dOfWegRwZCFFJiirMfDF9SrQdOmBQuX3v3EB0oedxz5Lp3YIsarbOFWEw8LI6apwEbbxevSrXrye4ckVQou7cpGrmZi3L/Yd4rWd1JG9XxQ+2xvD02+UTgigffBn0azMqWSJaiiPzuFmLsjtZt8q32Go+ROm8ODn41eBBCOxBsGCEi9BkdsFwZXY+CQbsx9iSu7EN0Yn7e7PM4OOOTIB8CfA1ZAy1D9o5SmdZBV+oPn3RUudszJdg0eADADhTkgOknHotr9pcYRODoH+BL/Tuyd62f+vu3yfALlsUhcW+qYxVh+fcb/7tdFudl1vQuI0S9QzKoffQa6btpi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6075.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(33430700001)(66946007)(1076003)(69590400007)(75432002)(6486002)(66556008)(316002)(2906002)(2616005)(6506007)(6512007)(36756003)(16526019)(4326008)(6666004)(33440700001)(5660300002)(786003)(66476007)(86362001)(478600001)(186003)(8676002)(83320400001)(83280400001)(83310400001)(83290400001)(6916009)(8936002)(83300400001)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: RyL6ejg19w7tsc8Bfs3vwNpAj0PJ9QPqsqTzY9noMF+9+Q0QNUMRe52WjU7IapxdQY0N05GHL/TxVBarm1NhicNu7kBoAHSJG+XSEFtykiir0ccRtsoNGm18Rx7dvqdpMdMrH4YhhJ4hcQWqv3lvVTnIsxc94aa4bA9nDV7N+rguWtTjsRxU+AlSqteQrG1JL3KpwqFXlnhjacSRfa0+c5iB0NnSM7BDcj4ZL6wVI7yjR0WD+QoCshVu8xdWPFtS7wgNqEY62JstCIjQ8wZXEq9QMnsWdHdQinQip31fOEA64pHU/D6nmOT7DaKrADQrOwz7ikCYdvyyk9ls9vvtMHI2d0D+2xt/AI/X1H3NlWW+x0VHL29dqoXHD/pg3D71f3nkNJZfpIfZGRrf01wAaMeNUg3jdz1GWR1TaUrsMW+/T0SkgVhfiJZXNLVji/B2ifBGmrtpj+JZVuy19mDhQb+cUc2J8lm+nlyuO+MuJ7k3gjvMNut7VYTB9aeZMRnEUAQqghwoDzWNkSOxGgnCPjclbHpvb5FPerxJCw6tGsXCzHsJqTKF3U5V/HS6mSZ97i9VNB5Tn+jCiFCYaGrC+YfgfR4w+Hj/R1OfUXdyPRDhEl8Ga3kQeCJPbqUSyacBclQCCwJZvxlvqReYB2CcucVTAVkA23d+msEyrNxB1d7a0ES5OUjkEnaTW/tsjkY7CMy2bQunSm2tXhYXasnBuUydDT817LMgj6aOSyUby3oFwzYPs2YRJ86gryY8UZ5RYNcIIKuf+91V0afJNK9bDAsGXJnlSBxUn2FLcRLa9hgwpdvhQr1vaTRY6/BECh4YbOw1xZP+bMkin9QE6j8tSFKqOdrTYTdAAzrE+IdgICRt7/+j3LhCp1Dur+U9jA5q
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: c2bfa32f-d2fc-42b6-0146-08d7f2c44398
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 20:21:45.9740 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hV0RMryW6i6cu3QOclZbgfXWv1C2VMtCoD9Kh4SDGmqHBZcP6lin5BoHFNGsoJaZMR4U02IboA6mmVn95YmbKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4666
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 07 May 2020 20:22:08 -0000

There's no reason to check for errors when we set read_ready or
write_ready.  We don't do that for other events.
---
 winsup/cygwin/fhandler.h       |  1 -
 winsup/cygwin/fhandler_fifo.cc | 34 +++-------------------------------
 2 files changed, 3 insertions(+), 32 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index c8f7a39a2..4d691a0fc 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1343,7 +1343,6 @@ public:
   void set_close_on_exec (bool val);
   void __reg3 raw_read (void *ptr, size_t& ulen);
   ssize_t __reg3 raw_write (const void *ptr, size_t ulen);
-  bool arm (HANDLE h);
   bool need_fixup_before () const { return reader; }
   int fixup_before_fork_exec (DWORD) { stop_listen_client (); return 0; }
   void init_fixup_before ();
diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index fb20e5a7e..44919c19e 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -93,28 +93,6 @@ sec_user_cloexec (bool cloexec, PSECURITY_ATTRIBUTES sa, PSID sid)
   return cloexec ? sec_user_nih (sa, sid) : sec_user (sa, sid);
 }
 
-bool inline
-fhandler_fifo::arm (HANDLE h)
-{
-#ifdef DEBUGGING
-  const char *what;
-  if (h == read_ready)
-    what = "reader";
-  else
-    what = "writer";
-  debug_only_printf ("arming %s", what);
-#endif
-
-  bool res = SetEvent (h);
-  if (!res)
-#ifdef DEBUGGING
-    debug_printf ("SetEvent for %s failed, %E", what);
-#else
-    debug_printf ("SetEvent failed, %E");
-#endif
-  return res;
-}
-
 static HANDLE
 create_event ()
 {
@@ -348,11 +326,7 @@ fhandler_fifo::listen_client_thread ()
 	api_fatal ("Can't add a client handler, %E");
 
       /* Allow a writer to open. */
-      if (!arm (read_ready))
-	{
-	  __seterrno ();
-	  goto out;
-	}
+      SetEvent (read_ready);
 
       /* Listen for a writer to connect to the new client handler. */
       fifo_client_handler& fc = fc_handler[nhandlers - 1];
@@ -555,10 +529,8 @@ fhandler_fifo::open (int flags, mode_t)
 	  if (NT_SUCCESS (status))
 	    {
 	      set_pipe_non_blocking (get_handle (), flags & O_NONBLOCK);
-	      if (!arm (write_ready))
-		res = error_set_errno;
-	      else
-		res = success;
+	      SetEvent (write_ready);
+	      res = success;
 	      goto out;
 	    }
 	  else if (STATUS_PIPE_NO_INSTANCE_AVAILABLE (status))
-- 
2.21.0

