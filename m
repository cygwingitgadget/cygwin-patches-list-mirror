Return-Path: <kbrown@cornell.edu>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770124.outbound.protection.outlook.com [40.107.77.124])
 by sourceware.org (Postfix) with ESMTPS id 536C0395C02C
 for <cygwin-patches@cygwin.com>; Thu,  7 May 2020 20:21:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 536C0395C02C
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9ER5bM41+DHFAnkRAIEJKTnnpEZ4h4+zbdBD2JnqUKAAkvQ0CEeDiK35ihGLtv8omWwX1Pb8qZcJIuL+zXEiQo54GYbFLRs0fTeA3VzAgA/CjaAtE4asBWBUOb4apyXYydBDYTfnmokf8p4Q6LpOixTsx4gEkzIFQYpuDHozuM9tazw1+IbSUXimlJzpigm9EEPmJY4cY8sowbMBAF7ikFwyggUV5J+dmF0oRG2S1KygEgJGJXbbGn/l1LoRvvy+WHKuhLGpJ0ILSA6vA/M9IiQa7e5VUu3sXmAzSY7LTv4F9oc/7CndEMwEO03DdijFG/MUP8PYy9Zsho3GUzDXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+q/QpFHo1sBLXlMSYidsMsywywOEZENCfwwom7Zj7E8=;
 b=fWmiVeEYkxtCIVAS3dTvG3+QcJg+y/9+Z7VaovdJu8DBkl4kX2DsBMSvU3YnzVPMYAsYOqt+a0xgUgdkz5qw/6noSfhjaE96Ji14vBAien6UTfwsOU++uLfZDJt4mF0ot1EFc2H+vM+UeUJLTnWEL3cfpG4/ap9762Lg6347icQc8mO8cfkH3fYHY9mWf/4VaJ/tdHwmN4uUx5uaolxGF2w0E36xcScJyBZvnvcnzif9sKgY1IRuOFszD5DbrhJ998xiYwpwdPIbCspAtHpPCP5Jln5l2vvTIHgXNHUqiec9aPlY/yFFqcob7XPAMTJLhFNp+4O5EwwRCIDEAhwaIw==
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
Subject: [PATCH 01/21] Cygwin: FIFO: minor change - use NtClose
Date: Thu,  7 May 2020 16:21:04 -0400
Message-Id: <20200507202124.1463-2-kbrown@cornell.edu>
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
X-MS-Office365-Filtering-Correlation-Id: 89c0d89a-262e-4737-841e-08d7f2c441a1
X-MS-TrafficTypeDiagnostic: DM6PR04MB4666:
X-Microsoft-Antispam-PRVS: <DM6PR04MB46669506D31CCF6AA2DB6EE7D8A50@DM6PR04MB4666.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:255;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qDkGXUEmT3r2B7h7HQnPeLbqsyhE5ddM/5OQG9jyEyIroX1rub8IEo2+l27hVUpSxHKumw4RyfLGQRERhotZDkTKPfrtihmbUrOWLi5zdlcFlyR0oKp0/rxBQF3OsnnLk2jJxmQuRpEwFsPS7kJG9e7alhCwSuNeXDNz3aYnEGy4YvPdVwTHRUZSIZdnkRu0oMyK5gyE3+gIpNHvUAkVsN0VnHAQjWs6cqd2yM6nDB7VeFgEspkLrlwA7ncQhQkxwQTqKIXOP2FUJvdQio7Zks3H5h4vKh8nvX7m8nJysAKuY7ofZcfovlnouTe/JhxOhhvSGJuomPpqny58ON5+FRRV9hjWPZdwWrB4wjcpGQ46GC9p/VT9hz2WzQRWQ75s1DTyVKD1HqbzpzFgaWJTPdMF5cxLhdmCiHoSY2mN17xBz2Czjd/iCfNdQloCDEoekobwM/vyzt9VJpESdTQ5GYiXGpiULi5TCVJMu8e1iu9SnBzZ1tO8v+6Ap5Mox92L1Zspfw8KsIlcUyxJTfwp6lznoqQlg086o/9+eg3Gxsg7dwHCvVYOT4CJPsUDQf0D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6075.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(6029001)(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(33430700001)(66946007)(1076003)(69590400007)(75432002)(6486002)(66556008)(316002)(2906002)(2616005)(6506007)(6512007)(36756003)(16526019)(4326008)(6666004)(33440700001)(5660300002)(786003)(66476007)(86362001)(478600001)(186003)(8676002)(83320400001)(83280400001)(83310400001)(83290400001)(6916009)(8936002)(83300400001)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: KXNi3398uURriIlk+T033XBRJTxc2liBVO+ggN/dzfNER++ZnSN3TZtrkyXYSvVlMDoQqhJspLZyCCu/VVvBiTu5mVeKbZaD/By69T+3Hc8abOa/LVzOZtR/6fuwq3Dq2IhpPGCd2J/7MX3z2mpgDZX0cwjd9vbScKsprQKkCEgc98iSXvrnFWfeZMhGDr0hymAQnTMOjNoeYTAYYlpmSPlGCz1pRFvsLVvr9k8P4gOFC8vPEX7MNd3xsKEwItj+IeKWpIIRw0KKwPKRMJt6P6kaOZ0+RVymsapY1TSQiVJK6Zj6yIOnOFcy85vtAB7xTHma1Rwv/NKjexhQSl/1E8UBvVlY9W0+aMh7kSTLAyzK1nRbCubPEWCdFwpMvemWnIrv1MQZoMYAnq6xKrbZW2cZDYa6IMT/gbnNdIx2fB7hRMmtNI4MtFzs2QtCkBlcJpGqrAzVfHeq9wp49USCTVbo1oO5dYH469NRLGsTmLTq1j3+Xz1s73WTXqABmIeCW11sSGbk5yk91z+pRedOVhEBT8XuxooAR+bRqF9VTK/TEvK6Dr5hxUKnhV3Dnze4sndEJwU3gkLOEaHj3qs9xEiKb5O4v1DSAO3mPw5X9VnvlHdH0OvM0DFYpxS2rsa7aSixeoL7lt4PANbCYeg/9cpYsHTjCnjD+chcBJV3E8RoIVuVZySf2TsT3fMLIIqINo2GDkFxi1cWLp0xHs/6E1k/gtJm6WWfbpsGO8trGIaiLPuX2hPv3nGe48u4MvkI0PrSi7Fhb3VPn2YsJtOFuFLb5RLsN58nPesGSkF6wZkb6HRhrFeg9h1jyOYTC7C5v/iR2JgPXRxuFom1Z49guhYyHQQM/8PE0Mix6/9RTwE8HxtLsnQkRC1sAj5nJgMe
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c0d89a-262e-4737-841e-08d7f2c441a1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 20:21:42.6589 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JtabdhkYgXtBCIxt4Ox/iQe0Mk3cwanLC0hvTEF/77n/C5sFhacd6hOFDN9pCOId5JKlyBCwZggFc9zKfQ8pSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4666
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 07 May 2020 20:21:56 -0000

Replace CloseHandle by NtClose since all handles are created by NT
functions.
---
 winsup/cygwin/fhandler_fifo.cc | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index 19cd0e507..c091b0add 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -319,7 +319,7 @@ fhandler_fifo::listen_client ()
       __seterrno ();
       HANDLE evt = InterlockedExchangePointer (&lct_termination_evt, NULL);
       if (evt)
-	CloseHandle (evt);
+	NtClose (evt);
       return false;
     }
   return true;
@@ -441,7 +441,7 @@ fhandler_fifo::listen_client_thread ()
 	      ret = -1;
 	    }
 	  if (ph)
-	    CloseHandle (ph);
+	    NtClose (ph);
 	  fifo_client_unlock ();
 	  goto out;
 	default:
@@ -462,7 +462,7 @@ fhandler_fifo::listen_client_thread ()
     }
 out:
   if (evt)
-    CloseHandle (evt);
+    NtClose (evt);
   ResetEvent (read_ready);
   if (ret < 0)
     debug_printf ("exiting with error, %E");
@@ -617,16 +617,16 @@ out:
     {
       if (read_ready)
 	{
-	  CloseHandle (read_ready);
+	  NtClose (read_ready);
 	  read_ready = NULL;
 	}
       if (write_ready)
 	{
-	  CloseHandle (write_ready);
+	  NtClose (write_ready);
 	  write_ready = NULL;
 	}
       if (get_handle ())
-	CloseHandle (get_handle ());
+	NtClose (get_handle ());
       if (listen_client_thr)
 	stop_listen_client ();
     }
@@ -775,7 +775,7 @@ fhandler_fifo::raw_write (const void *ptr, size_t len)
 	ret = nbytes;
     }
   if (evt)
-    CloseHandle (evt);
+    NtClose (evt);
   if (status == STATUS_THREAD_SIGNALED && ret < 0)
     set_errno (EINTR);
   else if (status == STATUS_THREAD_CANCELED)
@@ -819,7 +819,7 @@ fhandler_fifo::check_listen_client_thread ()
       switch (waitret)
 	{
 	case WAIT_OBJECT_0:
-	  CloseHandle (listen_client_thr);
+	  NtClose (listen_client_thr);
 	  break;
 	case WAIT_TIMEOUT:
 	  ret = 1;
@@ -828,7 +828,7 @@ fhandler_fifo::check_listen_client_thread ()
 	  debug_printf ("WaitForSingleObject failed, %E");
 	  ret = -1;
 	  __seterrno ();
-	  CloseHandle (listen_client_thr);
+	  NtClose (listen_client_thr);
 	  break;
 	}
     }
@@ -1001,11 +1001,11 @@ fhandler_fifo::stop_listen_client ()
 	  ret = -1;
 	  debug_printf ("listen_client_thread exited with error");
 	}
-      CloseHandle (thr);
+      NtClose (thr);
     }
   evt = InterlockedExchangePointer (&lct_termination_evt, NULL);
   if (evt)
-    CloseHandle (evt);
+    NtClose (evt);
   return ret;
 }
 
@@ -1017,9 +1017,9 @@ fhandler_fifo::close ()
   fifo_client_unlock ();
   int ret = stop_listen_client ();
   if (read_ready)
-    CloseHandle (read_ready);
+    NtClose (read_ready);
   if (write_ready)
-    CloseHandle (write_ready);
+    NtClose (write_ready);
   fifo_client_lock ();
   for (int i = 0; i < nhandlers; i++)
     if (fc_handler[i].close () < 0)
@@ -1070,7 +1070,7 @@ fhandler_fifo::dup (fhandler_base *child, int flags)
 			GetCurrentProcess (), &fhf->write_ready,
 			0, true, DUPLICATE_SAME_ACCESS))
     {
-      CloseHandle (fhf->read_ready);
+      NtClose (fhf->read_ready);
       fhf->close ();
       __seterrno ();
       goto out;
@@ -1084,8 +1084,8 @@ fhandler_fifo::dup (fhandler_base *child, int flags)
 			    0, true, DUPLICATE_SAME_ACCESS))
 	{
 	  fifo_client_unlock ();
-	  CloseHandle (fhf->read_ready);
-	  CloseHandle (fhf->write_ready);
+	  NtClose (fhf->read_ready);
+	  NtClose (fhf->write_ready);
 	  fhf->close ();
 	  __seterrno ();
 	  goto out;
-- 
2.21.0

