Return-Path: <kbrown@cornell.edu>
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2126.outbound.protection.outlook.com [40.107.236.126])
 by sourceware.org (Postfix) with ESMTPS id 0013E389043E
 for <cygwin-patches@cygwin.com>; Thu, 16 Jul 2020 16:19:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 0013E389043E
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vc6U0IdhJ+X9XqGcLi6hMaBZ89FZ+7iwa2d58YDVowi+Q+1fYa11sKJyTrbKkpaERxClHNND8rqvk99d2vlnuLHAPq4TT0EcSvxyh0jMcHRH+18pLRJ95NvvtcLJje92TvizzM8p6ScB7k7I23/Nng7vrNVorDz++j/8tDS6LnQ81E4JB1RYA8/EpzIvwzLS1PU+5pGF2ANMMNZTxEz8Eyg23tnz/Qaos/2BbFB4TkJcRTsw9wwqbHDLiTi+By/t5Biker/tZwTAz6KnGvv+niU5GG43W1tasLuYvm+gaRbV96MWwaY/oKGxORo/YgY7oD0RZ3mUkuTtZjSE7c5Bcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24T5gMwbsTZyCIbZEOIra7GDfCyGrdSn1UNWfzs3ueU=;
 b=jWTx6Q8fbypONRJMZrEkPXfsnyJFDUqWiTtAaoMwMZZchmKZGu0SOFuVG8Kr8wfEj9Myv9boRih6NRWImiH+soYKuvjZIxnsTcQRbckvxZKhySXgAB9cZDF0EXON4zFHBd3Wi3XaLVHl+QrW7pLffErf32CCBYdBv++bMIi53ptPO4YrvjkvRiigD3dCJFMWxpTT9WxEsW38M4Vga6XrzX10+yJeKMtbPi9gMJQUwXstfijLzm7On+GjuaUacg1zui8WyMyKv1sfW06m/0HXIiikBXAZNOAus3nxxYLTDXy5L6sa00iHyecZKcNRtuBEUQPRR08Pq2AgvuVLXiNXVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB6112.namprd04.prod.outlook.com (2603:10b6:208:e0::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 16 Jul
 2020 16:19:35 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a%7]) with mapi id 15.20.3174.025; Thu, 16 Jul 2020
 16:19:35 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 05/12] Cygwin: FIFO: improve taking ownership in
 fifo_reader_thread
Date: Thu, 16 Jul 2020 12:19:08 -0400
Message-Id: <20200716161915.16994-6-kbrown@cornell.edu>
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
 Transport; Thu, 16 Jul 2020 16:19:35 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [68.175.129.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8e7f25f-a5a8-493c-70a4-08d829a407d9
X-MS-TrafficTypeDiagnostic: MN2PR04MB6112:
X-Microsoft-Antispam-PRVS: <MN2PR04MB611268DF144046E8425212BED87F0@MN2PR04MB6112.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qfarVisH5SL9ce59saAaEtIRHw7foz6si4m+Sc7yxqZtEbkjG3CIycuCC3jNGNiAsONhYfKeUs/6W9dZ2hpfFykb7veOjauEJsAjE2sdSPx5D30U6c/xB54GvB0BkZp1j+XkpvE057Z0565U9O2dUZLumykt9OLthePdSptnB7E4IpMOtH4EOacWOunG2V5KM2eU+KTPyXwuL7W6fr+PLNgWsTQ1gsJBwZ4dgWVOS16zqFQQAhUjVENthqAGdSSPvJE4+VUbA4R+W23dVnZIaaF6n6pJymy9g+xsbpVs3IzTyxJMCZ0Slxhf2QhyYUZL9VEfwU0AiCn5/9eC7pzuXdpGx3yKVGwy9i45IipO9dnqOKPPZDls1668ErdSoBsr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(66946007)(2616005)(66556008)(5660300002)(69590400007)(6506007)(8676002)(83380400001)(16526019)(956004)(6486002)(6512007)(52116002)(186003)(26005)(8936002)(66476007)(478600001)(2906002)(86362001)(316002)(786003)(75432002)(1076003)(6666004)(6916009)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: vu9IyCMOabsWIUi8c78lNKVPuC/fnQzGiqKvgl8GQgOr+QJnCg/k3kI9eEz9VLggdGHG4If39PlPgrtDUZWMVfOFZy46no4Xh8p+qV/TrmNrIgKoLPahvlmK/drKL7R+BSN3ba+zNSEb6jP8NxFWvV1QI5cAbCS+KzGI3QE1mLXhvNgmAkaV3rcywDmZ6ivav2YcHF3slJq3JDDHw7NKCn6JBtauy/+tX3cPqknUcTZ1C5Nv1Xb7Zqj4jaSYWBywk+ytoVyhXSQdl49EKk6Md8Hkr1nXItc5GbTHLUPFm2ZkN9GPo95GNg40W/e5A2qq/t8Ypg1iJ3Acs7FNbLaqRRb+W008lsYhzJzXNb7isIMuJk4ih0RsXaOwC7qGqojS2gJRR0mlCD9cBDTxeoyXPRCcDdSEtkqsqI6a2khfhTueOFuPRI3OhuLuJaF8J3NLK3KGxBxaf+ceNmVJAoumrk54huvjpkBaOjOEXAQPy/s=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e7f25f-a5a8-493c-70a4-08d829a407d9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 16:19:35.7590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ng0TF8yY7itOQRXVy+iSpJCXHETIv0ABjtIAMpIP9mZdmykD8YiQ6ZB4eQDuLGdLBCDlWkWJfOOkWBQdsjuidA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6112
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 16 Jul 2020 16:19:44 -0000

When a reader takes ownership in fifo_reader_thread, it now goes
directly to the part of the main loop that listens for a connection.
Previously it went back to the beginning of the loop.

Also, if the reader has to delay taking ownership because the previous
owner has not finished updating the shared fifo_client handlers, it
now checks to see if cancel_evt has been set.  Previously it might
have had to spin its wheels unnecessarily only to eventually find that
its thread had been canceled.
---
 winsup/cygwin/fhandler_fifo.cc | 44 ++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index afe21a468..1fb319fcf 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -462,12 +462,30 @@ fhandler_fifo::fifo_reader_thread_func ()
 	take_ownership = true;
       else if (cur_owner != me)
 	idle = true;
-      if (take_ownership)
+      else
+	/* I'm the owner. */
+	goto owner_listen;
+      if (idle)
+	{
+	  owner_unlock ();
+	  HANDLE w[2] = { owner_needed_evt, cancel_evt };
+	  switch (WaitForMultipleObjects (2, w, false, INFINITE))
+	    {
+	    case WAIT_OBJECT_0:
+	      continue;
+	    case WAIT_OBJECT_0 + 1:
+	      goto canceled;
+	    default:
+	      api_fatal ("WFMO failed, %E");
+	    }
+	}
+      else if (take_ownership)
 	{
 	  if (!shared_fc_handler_updated ())
 	    {
 	      owner_unlock ();
-	      yield ();
+	      if (IsEventSignalled (cancel_evt))
+		goto canceled;
 	      continue;
 	    }
 	  else
@@ -478,26 +496,11 @@ fhandler_fifo::fifo_reader_thread_func ()
 		api_fatal ("Can't update my handlers, %E");
 	      owner_found ();
 	      owner_unlock ();
-	      continue;
+	      /* Fall through to owner_listen. */
 	    }
 	}
-      else if (idle)
-	{
-	  owner_unlock ();
-	  HANDLE w[2] = { owner_needed_evt, cancel_evt };
-	  switch (WaitForMultipleObjects (2, w, false, INFINITE))
-	    {
-	    case WAIT_OBJECT_0:
-	      continue;
-	    case WAIT_OBJECT_0 + 1:
-	      goto canceled;
-	    default:
-	      api_fatal ("WFMO failed, %E");
-	    }
-	}
-      else
-	{
-	  /* I'm the owner */
+
+owner_listen:
 	  fifo_client_lock ();
 	  cleanup_handlers ();
 	  if (add_client_handler () < 0)
@@ -590,7 +593,6 @@ fhandler_fifo::fifo_reader_thread_func ()
 	  fifo_client_unlock ();
 	  if (cancel)
 	    goto canceled;
-	}
     }
 canceled:
   if (conn_evt)
-- 
2.27.0

