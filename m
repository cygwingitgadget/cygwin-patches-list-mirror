Return-Path: <kbrown@cornell.edu>
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2091.outbound.protection.outlook.com [40.107.94.91])
 by sourceware.org (Postfix) with ESMTPS id 5F20838930C4
 for <cygwin-patches@cygwin.com>; Thu, 16 Jul 2020 16:19:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5F20838930C4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpgpwyCBrv38YH60NTAwFoTmWEFvwkNgC0qg2/HxJ/34b0nnq69r2Z0+t6ACz8piOjfcTvSH5WMagG6ezgVeYPxIqrXyqIBO22f940Z9ItFqdbMZH39ZIaRNzeyH8YC8sWhI2KAAW7vbrGY5wTfh+KU7H9DCFK7PsP4mGeOcU/IKZCBT2uOGK3qqMVOQb9yWPdkilXLurJ9S+QpB2POh5MPRG0qRXILx4RMrfYp+wKAXYOMukOj8oiRmKnf2wgpkr1eHO5aoWmUgBMX7JRdSXM8SU5KD+pdvXI2WnlXWYF1jehHcozIXAaewSiLUL1bzE1fsiauHBXLh230iy0gUrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aD1tVilFU07/IUwx7KY/6MrM9H2tfkhYVoezNdAi8CU=;
 b=ngnXP/e5IoKXk355qf2+uPC22d5vXZLO020D5uFbGEu8c8/3+8/DJjAHmM9dN4PGVGsQYENUOgjh+zk3WJztja2lZxGK0iT7Bj7UQrz/Ux7HJIMOhptoQTEiPVlbSnBdcqOjoOskY4kM32bKmt7onxkKShiXbzq1wPmPKNS57TY6Mw+tEzSGUPkab5SgNyB/N2oj8KKZsftJ3vQPgtSsfXOB+ZygQiAv9qBcVGk6WCy5BI/AfW6iJwLwpMhDsMi4bLZbm7gEaUtweHYTmCCDl7kz9U7aPVWDGwrE/KOp4TjQ6hdLAqU4St5P5ueSeKMDOVnyhKv2GbiXOlctF4jebg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB6112.namprd04.prod.outlook.com (2603:10b6:208:e0::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 16 Jul
 2020 16:19:39 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a%7]) with mapi id 15.20.3174.025; Thu, 16 Jul 2020
 16:19:39 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 11/12] Cygwin: FIFO: clean up
Date: Thu, 16 Jul 2020 12:19:14 -0400
Message-Id: <20200716161915.16994-12-kbrown@cornell.edu>
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
 Transport; Thu, 16 Jul 2020 16:19:38 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [68.175.129.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: faa50016-1362-4518-784b-08d829a409a4
X-MS-TrafficTypeDiagnostic: MN2PR04MB6112:
X-Microsoft-Antispam-PRVS: <MN2PR04MB611213EAF66297214E0CCE23D87F0@MN2PR04MB6112.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bLo++G6XkLuQT73MgbtLDDSHv6JB7c9lpO4w81kD7SJaWSg2uqdr5JvYCM8HekntBE//5vHxoy2nI1I1RGRPfnm5mq7HDSV2KsjnWfdrPA6IX59GT5jfSeRAnNj5GqdjQpSScYjpXdNpHjR5ya/lUIXONlTRPqG1xASYOjSwz0PWG6FJT78LWSkdeb8In+OGWROQxx5VduZ/lJQiohwW5OZFIAVQ01Xk/F7mfxzXDP+YHCOjw+XFWvXxnTJnbOelw5fEpZaAaxYHTTzNDTuJnWAy9MiLBj9BkzNLfUfsnLesiEGQMLCLWL2ubgl2OSJHj/wurddgLsTVBmHRf0hWsoRz9bXGXJSdOrh4wuOAHbm4AE3a2og4nGXDDXHzsMa6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(66946007)(2616005)(66556008)(5660300002)(69590400007)(6506007)(8676002)(83380400001)(16526019)(956004)(6486002)(6512007)(52116002)(186003)(26005)(8936002)(66476007)(478600001)(2906002)(86362001)(316002)(786003)(75432002)(1076003)(6666004)(6916009)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: izNUNVlaZx0YsIjsy0LN6binnIvsLUaSEFkwen9HMNKSHC8QK+CjoO0pE/5297uu9ayrgEyUY69AyMRRGYPlqFfpNbFXt+t13seD8Se67ujWSYEGqSkjTBnUdDZswQL6qCK4cmBkYRCONGcidg405ODbJiyqwmZ2bVccVKdGfZj6cQ7hi77l2iaSODrD8VdjAvFKDCWv3kXW6GiRpsWw/vGx0o8X16JG0t1bk51WipDWGwUaEcBV+LBLouD6cNREYt/59RWDyw5vq8hsVRVdSa5/4HmNY9NQUOtUsn1dObX0OnaSQYnirkdCsx4NHcULFBwqiZrsohrW2K+5zKSYiuRwupTm+CHHJm/6PrGG06ntl8LvF3P1VJplZUm7HNI1Utj/1c5F8ZWVDiYTnxIA9HBMk3xN5Wm0sr0tmqDYYVMwcFHk5UpMuz9l0mroTHO3e5EL5/s06tUB4ldqqxB2TXeWfrE28UOA8DiZ5SqB0i4=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: faa50016-1362-4518-784b-08d829a409a4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 16:19:38.7463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RXwWQ4kwBbyOUrW5plQ+kLkX2E1qYX0IDKtL5BsWyIUhU78RrENspqyuLfZQcIxIOxF4dpDYZ04cwiB1Gfk/9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6112
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 16 Jul 2020 16:19:47 -0000

Remove the fhandler_fifo::get_me method, which is no longer used.
Make the methods get_owner, set_owner, owner_lock, and owner_unlock
private.
---
 winsup/cygwin/fhandler.h | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 0e0cfbd71..60bd27e00 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1437,6 +1437,8 @@ class fhandler_fifo: public fhandler_base
   void nwriters_lock () { shmem->nwriters_lock (); }
   void nwriters_unlock () { shmem->nwriters_unlock (); }
 
+  fifo_reader_id_t get_owner () const { return shmem->get_owner (); }
+  void set_owner (fifo_reader_id_t fr_id) { shmem->set_owner (fr_id); }
   fifo_reader_id_t get_prev_owner () const { return shmem->get_prev_owner (); }
   void set_prev_owner (fifo_reader_id_t fr_id)
   { shmem->set_prev_owner (fr_id); }
@@ -1444,6 +1446,8 @@ class fhandler_fifo: public fhandler_base
   { return shmem->get_pending_owner (); }
   void set_pending_owner (fifo_reader_id_t fr_id)
   { shmem->set_pending_owner (fr_id); }
+  void owner_lock () { shmem->owner_lock (); }
+  void owner_unlock () { shmem->owner_unlock (); }
 
   void owner_needed ()
   {
@@ -1483,12 +1487,6 @@ public:
   void fifo_client_lock () { _fifo_client_lock.lock (); }
   void fifo_client_unlock () { _fifo_client_lock.unlock (); }
 
-  fifo_reader_id_t get_me () const { return me; }
-  fifo_reader_id_t get_owner () const { return shmem->get_owner (); }
-  void set_owner (fifo_reader_id_t fr_id) { shmem->set_owner (fr_id); }
-  void owner_lock () { shmem->owner_lock (); }
-  void owner_unlock () { shmem->owner_unlock (); }
-
   DWORD take_ownership ();
   void reading_lock () { shmem->reading_lock (); }
   void reading_unlock () { shmem->reading_unlock (); }
-- 
2.27.0

