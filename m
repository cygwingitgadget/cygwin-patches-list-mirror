Return-Path: <kbrown@cornell.edu>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770093.outbound.protection.outlook.com [40.107.77.93])
 by sourceware.org (Postfix) with ESMTPS id EBCCA395C064
 for <cygwin-patches@cygwin.com>; Thu,  7 May 2020 20:21:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org EBCCA395C064
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsovI5SqGJe/HsWKWI5S5jBH2FQT9IgHKfP96aRl8I/vn7Pl+rHPp2rPmdQtZjotgCc/Q9lTNRyeVUmtBXl/6MmvfszyYMa2EvsoS9UY/G3gJWD0mvr54nQ5kmVebqquAs8uXZbTWZqYL7FnUNm+wtSOOpihyA9/fbgC5htpN9jXkmigodbp/sa39NjikzUVBG3Z0dF+CYMaqyGBdgilUMFMMbiIMY3QPCz6TQMV4QzLBrbyIl9QvrRKZXqh0sN1jmxTi58lmgTCDNC9sIBR7L8g9FKzImDS8IuF3p5wS26lGOYEuETAW128NHdVsgZPR6lJxbFPWYoDbzwOH92pwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLOuISc/Lrzkq5LKrxoMG5hfdDsX50Ia/tZuAS1wVrI=;
 b=nf+uMDiC48dAkkBLqwUUyWK87ZQwowvz68hg8KZ+r54raNwt0/w8xLdSnjdfhp1Pms/VHzmCCyY99Iwcp50EzmVrvZr1dvAxb4Ep8B61yYBMkyCODmuc7DQSLcT0Iugcg6YJQWTWnkXXesvmgu3E0eUPFhgtKaDqsYENje3TBb1y8ooqAGk07MGxkMPg+VHFp7P+RA6cmtCItSt1lzqVILJIcSM2aJ3wIN8QdqaMVxRKKVuoYaummqQ8X1a6PcRob5hbW/WrYdL2/7v+vqQCXbI8G+CpEM7Sf7HjjlF7zHSdF7mAZTy2H/yeOsQ7aeK2pJ7ZoIv7oEGLgMXAJU3eoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from DM6PR04MB6075.namprd04.prod.outlook.com (2603:10b6:5:127::31)
 by DM6PR04MB6075.namprd04.prod.outlook.com (2603:10b6:5:127::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Thu, 7 May
 2020 20:21:48 +0000
Received: from DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4]) by DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4%4]) with mapi id 15.20.2979.025; Thu, 7 May 2020
 20:21:48 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Cc: sten.kristian.ivarsson@gmail.com
Subject: [PATCH 07/21] Cygwin: FIFO: dup/fork/exec: make sure child starts
 unlocked
Date: Thu,  7 May 2020 16:21:10 -0400
Message-Id: <20200507202124.1463-8-kbrown@cornell.edu>
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
X-MS-Office365-Filtering-Correlation-Id: 556eb825-0126-4178-5408-08d7f2c4448a
X-MS-TrafficTypeDiagnostic: DM6PR04MB6075:
X-Microsoft-Antispam-PRVS: <DM6PR04MB607539A7623AE318981E7F47D8A50@DM6PR04MB6075.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5v+1kHVXfC/VZ5kjZU33UYV6qt3aLbzuDa8J3q/CZ+pYCOyaheQbfz8cEYfc7HpoRwecRf+zLSH/4QLMPeQdbcQtHeelgGs6+l+Eh8VkLQBl7MhwBSqZwhP+kxH6iPphzebfq7OqaMDkXs0Br0tGzpifs0esh1OvUgh1tXcoYgzPNIxjocS3TT1LDN+OPE/YudyH1QobXOFVqg5bt86Du7+LIUA0reOwrKnEgDuyJfhv1Qbl8RZkaUw7Vhvj8Gi1svgKFidPpxHYzn1K1JnzeZ1o4uEpxGSduN1bf2olWg0WuMyOnLb385KpAkYeWsA3C0wcmi1LB4i/XyOc5A6YlhZ2ILIVqfTHFVxupW4vwpVBrrIx70qgfnjriSq2VUUzVeDl5hRUR0in98AWxQI85Vfhz25G1orap9eVmSI8LMDLAVP+kFuyjXvElVeaSBbh/uLMFKD6XLbodrctcXsfYQoDjP6wL0s5n0HsK8YmTKRWCQncw5G2XtKsmFbi8/0ApOM7lk6DrH/ivL7TiEiOkvmopRAxg26jS0yyRBhHSzq/x8LH4E2JU/7AFalv7B4D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6075.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(33430700001)(33440700001)(6512007)(6486002)(478600001)(786003)(8676002)(66946007)(1076003)(5660300002)(8936002)(83300400001)(66476007)(316002)(83320400001)(83280400001)(83310400001)(83290400001)(66556008)(69590400007)(75432002)(36756003)(2616005)(4326008)(86362001)(6666004)(2906002)(6916009)(186003)(6506007)(16526019)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Ic8bJ9Q9WT0l3XmwmzmUz38WQ9x82dkFNumJNFEp8M3hDC0ByFSvoNn5wXseQz5JxF6emy+6Gk2slWajopJ2W7WA7nFK2rqKLyyVIMKkk+YUWDrI/74NbzfVFlNDUDRGzsx3dnqOzTcMedcqRG2QiToJh8WPVaNt51yIpCJPzfV6mL9tWnuxaBoRdvnZ1mEIig+jcb8zwq9cOh2+4FTmKrxdzV8yudOfE/Fcgkz32YDAXFAYikcu55Wc9eiJVqOHdqwtC3FqV3XJde1boRITUbc9mgUMHZoqWaK0EQWa0AGbs5Wm/Hx9nhmVEHupZS032lV4jwQqitjYPbHObQLuFge+dvGAdMt5vd6WOtvzN+hXKw90CgmQNex/ILhEzdLFMQpqmkZdpor0d3NDEBa7RZe2g1e1x/GwWFXQkM97NAYHNmV5xvZuWEs4VepiQinPRqjacUhfOhiwMoSVQ4Y4nIuSwaOjaADQ0/qhLNt4S0I7IIkl8IPECtoCrywfL4pF6/VtxY20PlmlWJay2OqBM6e2XgCIPzII1ZpeTvItI/mzX6uh2qIOk6chSfYSw2qexb3/AbMb2bsoqOnj2jVwvVZD6mC6bSj5q4KjAqrvKm4qykyHyWo2h/FquR1rPfWN9LC8jV21P9ZuJBcn0DvB+I1h/RdQSJNsCmJjBGocYWRegBXBIT10NSymxx/ZyOybNZoJc+BHlBlTxvK5n8y+4GIay3la+fZ77AQAMgXzs0o91o/Q0SnF0iz25PJltEwfooMZf+HHUhuOqnAFq/r9zNyjgkJeGYkqN1FQCKCs83Sf0+S8dDAQvdzsGDEpG1PERFI3ybIx6F2HBR0apQAZEzVO7zyibTDtzNiNOPmmTpK99VyDNzEem7mVGzSUETJq
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 556eb825-0126-4178-5408-08d7f2c4448a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 20:21:47.5921 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XYN6d4MGjMFU2nCWiz+Lm5nYfqBur67xbPM5fcbAkN47jl3UJhuNsxd5iLPgT2hb/pmfZSh15nDSx8QS9gCDtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6075
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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

There can be deadlocks if the child starts with its fifo_client_lock
in the locked state.
---
 winsup/cygwin/fhandler_fifo.cc | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index f61e2fe72..4904a535d 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -981,6 +981,9 @@ fhandler_fifo::dup (fhandler_base *child, int flags)
     }
   if (reader)
     {
+      /* Make sure the child starts unlocked. */
+      fhf->fifo_client_unlock ();
+
       fifo_client_lock ();
       for (i = 0; i < nhandlers; i++)
 	{
@@ -1025,20 +1028,32 @@ fhandler_fifo::fixup_after_fork (HANDLE parent)
   fhandler_base::fixup_after_fork (parent);
   fork_fixup (parent, read_ready, "read_ready");
   fork_fixup (parent, write_ready, "write_ready");
-  fifo_client_lock ();
-  for (int i = 0; i < nhandlers; i++)
-  fork_fixup (parent, fc_handler[i].h, "fc_handler[].h");
-  fifo_client_unlock ();
-  if (reader && !listen_client ())
-    debug_printf ("failed to start lct, %E");
+  if (reader)
+    {
+      /* Make sure the child starts unlocked. */
+      fifo_client_unlock ();
+
+      fifo_client_lock ();
+      for (int i = 0; i < nhandlers; i++)
+	fork_fixup (parent, fc_handler[i].h, "fc_handler[].h");
+      fifo_client_unlock ();
+      if (!listen_client ())
+	debug_printf ("failed to start lct, %E");
+    }
 }
 
 void
 fhandler_fifo::fixup_after_exec ()
 {
   fhandler_base::fixup_after_exec ();
-  if (reader && !listen_client ())
-    debug_printf ("failed to start lct, %E");
+  if (reader && !close_on_exec ())
+    {
+      /* Make sure the child starts unlocked. */
+      fifo_client_unlock ();
+
+      if (!listen_client ())
+	debug_printf ("failed to start lct, %E");
+    }
 }
 
 void
-- 
2.21.0

