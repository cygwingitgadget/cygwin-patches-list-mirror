Return-Path: <kbrown@cornell.edu>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770133.outbound.protection.outlook.com [40.107.77.133])
 by sourceware.org (Postfix) with ESMTPS id EC4F3395C01D
 for <cygwin-patches@cygwin.com>; Thu,  7 May 2020 20:21:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org EC4F3395C01D
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlDdJOOvlf6YnpUHhUksk94hkCHTBw00IkFRrq/OCIHS/Z0rKc0y5t/SPdb+fa6MDKPo3x9FUD67z4sn41+eOylvtKRk2S+9DgueJSkeVFRNIyfaEfjnfKEcY81j3W0bOcXIz6GFZxV2rlvYmYOeJGhbWTF8+Gg8Of8VVjMN5ma8sEYAxt0K6kHy3f5TfmGfLrGNBO5fNvYaJ00X8jT8wd4uUc4R7/35wE5Ddkr2tjbCe6f6sGqgSCFZ0RGHGGf/szczUkzEE6WvZer7ZRc42eyZNWoGanwbAdqpYH40sSQwu42AOfDlwLaj5SbpzWWeBhozYWOmXi70T78/7bpxxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WA3Gh37Lpahh7eonhpg50X9ZjdNhm7Ox6wClKFcmEp0=;
 b=UBFcaLC4dRmnVs4Phiv0jd19GE2h4NG9SQf8FJK5WQCujvKDkaxnIcr+zoOc/n5DxtjOVUIJ8/rx8XScYs+fjJDwwOgSOyGUoHeTu/2j0Pi30Y4hvF7gt3UmHwomzejSc5AXC05ohhEy9Nk82LrE7S4TJXgXyDTbvf9H4fkKmDXlp7i83fkW4HOXY9YSoIlBEJZI9QoTmCuPZtGMbtHjtGKsgNx1OwhfZvfynvLWX/2s93IdSZ9i9+Q2lF14scUa5WhCgLdXxdhM4J2CS+QBoaWwdpl5OuU+gP3lKyp2txXw2HQIWWjLXCS0FDrgy4beTbkPHTa6LSBQnWaazTjGnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from DM6PR04MB6075.namprd04.prod.outlook.com (2603:10b6:5:127::31)
 by DM6PR04MB6075.namprd04.prod.outlook.com (2603:10b6:5:127::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Thu, 7 May
 2020 20:21:47 +0000
Received: from DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4]) by DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4%4]) with mapi id 15.20.2979.025; Thu, 7 May 2020
 20:21:47 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Cc: sten.kristian.ivarsson@gmail.com
Subject: [PATCH 06/21] Cygwin: FIFO: honor the flags argument in dup
Date: Thu,  7 May 2020 16:21:09 -0400
Message-Id: <20200507202124.1463-7-kbrown@cornell.edu>
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
 15.20.2979.28 via Frontend Transport; Thu, 7 May 2020 20:21:46 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [2604:6000:b407:7f00:e532:58da:20b8:9136]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3a4efd8-fc82-4a35-5ce9-08d7f2c4440c
X-MS-TrafficTypeDiagnostic: DM6PR04MB6075:
X-Microsoft-Antispam-PRVS: <DM6PR04MB60751A021AF796397FA7AC5BD8A50@DM6PR04MB6075.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RTNsuybbIl+9ylzUXPpcb067t5nVwzBjQb9EfdA0mf+c1HoSQHK4UYRDV/7JwiALnTdr5Rus0u4BaOQrfybTBplCpVbLzvg9Q8e95cC6DdfHRcRlgIgaA5nLl511XG0uTH6frDKrcC3cVPiuQdwhf3yQVuQPjiyWF8QURHE4B/p5WSezRG9U/8Grup7ieXlsxrPyPEH7vpFmkV67auE/l1lRMCQ+BO7vdkUxRylL3ZbyXFGWkqyA2PWvQGKTqYFDOFzSxoY0DcIQnN+thMFwuHK6ufJvMRbq8ddkj7nHQmYGhF+w3mQiXbZb3asrdiER09ekO1gZSm4U4qeehYkc7C6ErEyLlkHUPsx+tIbyxCn03ZHLRhSHGa7p9STeqMivUUGlSPGqI7aIGVjUMx3JrK96xHSlc77pslByoTQ5a3kvdgPSKfePayY4EQrt/3dZ6mlH4j5H3cAVNzz/5qCPatxfCx/86Ci/oeGX55pfIC+NMPSEEH6ViMVDq2eympTdVbQBNg1sFDjup/obuCKAZjtw7YbpUW4ZLAJ9G+es6MPoH2VozxLffQwse3btfnZc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6075.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(33430700001)(33440700001)(6512007)(6486002)(478600001)(786003)(8676002)(66946007)(1076003)(5660300002)(8936002)(83300400001)(66476007)(316002)(83320400001)(83280400001)(83310400001)(83290400001)(66556008)(69590400007)(75432002)(36756003)(2616005)(4326008)(86362001)(6666004)(2906002)(6916009)(186003)(6506007)(16526019)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: DQmK4lo97mHVAbWSsO0ceTVF/bD6IKbUK+WSUh2xF/vYlqSMH8Zkpqw1vldFMdHBeD7FWRAXr1Ejt1vl0KCoOj91CAApl+hc0ZTnr1RKIk+EHsqcWzUPpQFsPdQI9DfR22aCJNmk0vsIDJ27jIl9a6JAFabsR5/h2fbITVObouqSbfIHwMmSMW3mHHcn9Kt5d0ho+b8LrT5IuyqbGOVRD7R/+GzfaDiJMKTfpnGky+PL/dvKsCsWU+8nrUXja3sH9dIN9uURpe/kCXgx5MMa+DCXgYrH0zUzxhr4QO0i7Eqmb47Q/icQySPrVpqjbzuAPjsckjCBvu1L7XroSUre9fUFIJpPURT+nuSZa6ZVb/XpIBHhe2N9X4qUAnJ6TYneQVEziqOHCgeOLPwSjNysCRKY1Txq//q04nRuDWSnPDPd7/7yu38XzEiit8cN+53CRdWQGw4utRFExaGfMc4xkYWSrx4dmQjyjDxV8MlxkowqD/jazZ4YOOqHt71szMvycbro28Ju5yakFrRnAZvLpxhwbxKnJQAqM5QMdBc2B2k2SiQ7rhuKXIubUfCHgmbfc24NF9tHrwhtdVkMbcZL0eMPRyM0w4+QWeQjlIz+Y9NfS9IR5TS49w7qBOJTte9RqGs1R4bOfDIa2xgywd9gwiYNhP2X0MMkIefpSfe8LsJNjeWqEfcQIH8UFhH8/phtRVnyMcOTrQfba3t4OKOHVXoUa3kVQq5LJDAUSVP6/pGVaw0hAXdOW6MfG23ThFTQj23ISge+o4NIOUnqdF/hw8+PcI+dReGqY6nfSALXGB4vCesmtsShZAhxGIDTNecCqanF4Y2xhvQkuDIkMPTYxcopRhVYnFF0reMTxJVbWnyNhice5m3vEiSSUOGlck8m
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a4efd8-fc82-4a35-5ce9-08d7f2c4440c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 20:21:46.7565 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+Sm916Azsm27hHReW1ilayVZ+6x1jDSYkQ8n6yS0FFbgyd75uwW2JxSzMO3ImXVdtk5+ftsBqf5+1nYrL0Sww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6075
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 07 May 2020 20:21:56 -0000

Also improve the error handling.
---
 winsup/cygwin/fhandler_fifo.cc | 60 +++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index 44919c19e..f61e2fe72 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -955,56 +955,62 @@ fhandler_fifo::fcntl (int cmd, intptr_t arg)
 int
 fhandler_fifo::dup (fhandler_base *child, int flags)
 {
-  int ret = -1;
+  int i = 0;
   fhandler_fifo *fhf = NULL;
 
   if (get_flags () & O_PATH)
     return fhandler_base::dup (child, flags);
 
   if (fhandler_base::dup (child, flags))
-    goto out;
+    goto err;
 
   fhf = (fhandler_fifo *) child;
   if (!DuplicateHandle (GetCurrentProcess (), read_ready,
 			GetCurrentProcess (), &fhf->read_ready,
-			0, true, DUPLICATE_SAME_ACCESS))
+			0, !(flags & O_CLOEXEC), DUPLICATE_SAME_ACCESS))
     {
-      fhf->close ();
       __seterrno ();
-      goto out;
+      goto err;
     }
   if (!DuplicateHandle (GetCurrentProcess (), write_ready,
 			GetCurrentProcess (), &fhf->write_ready,
-			0, true, DUPLICATE_SAME_ACCESS))
+			0, !(flags & O_CLOEXEC), DUPLICATE_SAME_ACCESS))
     {
-      NtClose (fhf->read_ready);
-      fhf->close ();
       __seterrno ();
-      goto out;
+      goto err_close_read_ready;
     }
-  fifo_client_lock ();
-  for (int i = 0; i < nhandlers; i++)
+  if (reader)
     {
-      if (!DuplicateHandle (GetCurrentProcess (), fc_handler[i].h,
-			    GetCurrentProcess (),
-			    &fhf->fc_handler[i].h,
-			    0, true, DUPLICATE_SAME_ACCESS))
+      fifo_client_lock ();
+      for (i = 0; i < nhandlers; i++)
+	{
+	  if (!DuplicateHandle (GetCurrentProcess (), fc_handler[i].h,
+				GetCurrentProcess (), &fhf->fc_handler[i].h,
+				0, !(flags & O_CLOEXEC), DUPLICATE_SAME_ACCESS))
+	    {
+	      __seterrno ();
+	      break;
+	    }
+	}
+      if (i < nhandlers)
 	{
 	  fifo_client_unlock ();
-	  NtClose (fhf->read_ready);
-	  NtClose (fhf->write_ready);
-	  fhf->close ();
-	  __seterrno ();
-	  goto out;
+	  goto err_close_handlers;
 	}
+      fifo_client_unlock ();
+      if (!fhf->listen_client ())
+	goto err_close_handlers;
+      fhf->init_fixup_before ();
     }
-  fifo_client_unlock ();
-  if (!reader || fhf->listen_client ())
-    ret = 0;
-  if (reader)
-    fhf->init_fixup_before ();
-out:
-  return ret;
+  return 0;
+err_close_handlers:
+  for (int j = 0; j < i; j++)
+    fhf->fc_handler[j].close ();
+  NtClose (fhf->write_ready);
+err_close_read_ready:
+  NtClose (fhf->read_ready);
+err:
+  return -1;
 }
 
 void
-- 
2.21.0

