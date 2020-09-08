Return-Path: <kbrown@cornell.edu>
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2128.outbound.protection.outlook.com [40.107.243.128])
 by sourceware.org (Postfix) with ESMTPS id 773143850410
 for <cygwin-patches@cygwin.com>; Tue,  8 Sep 2020 16:51:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 773143850410
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UqBEm1MV/LZ6U3JbwAaNe8Rhgt1Xq+Dt/C8767eq2+ZTbq3tjGOEoNHIRJwEBZ4AIbmp/U6FvbOKYXfJSpzFPHT2L7ITGlJLfMp+6DR1U30dOt1xZpFYK1/Cxml1r4i1Eg1CGJ13Z3/RZVGDRZlIERqmE0bXJ9nxVcnthR1YWWSlUKCgyQguG4rbGC5oEs9EnwUaLcA962G+vSYj+GgS5uZyR6eYxlsjTklx7ZhqiPXjR2oG1Au3UjX83reP7t4BOHcNQi/+RPhJKA6t4lXptnTG93B5hmdQmJb/FOWdQ7m4Eh2Zj+8zlIkT4jaAE4oxx40MPTQbuliM4KSy9vE7oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ag1Gf4OhprrQLcwbCB3W3wQKfIGPncfHn9c/iKo+Kt8=;
 b=DdStyurJIu8dbT67M9erzK1PzckRz2HsXmfp1po7CPmWofxpjk+DhNzufSoKxYEU3jHYMKvC+dITJcbgYJu7Ba3VUJOMI7EdvytGHe5N8kOaaU+PPG2RJfZwiocnAtV1GrXTF8xvp6KsQDCaclfrQ3y0YeIxuTH8L/A0wXpv2Z/U0KO9Nf5h22W7eL4IXwTwsPzo8qXK3XObrhgfi4JpMmZPxvOtwJD9sM3altoNf3mnTqQIF0n7TtN2g+qKZtgWQVJS9haSvuWJmq/tjOVQQs1jyl2Nf2ED3929khZxA1r9oWuo7/ILbAqVp5qP3BgLA6g0q0c+MeF/7MjPXXEIuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5744.namprd04.prod.outlook.com (2603:10b6:208:3a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Tue, 8 Sep
 2020 16:51:06 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44%7]) with mapi id 15.20.3348.017; Tue, 8 Sep 2020
 16:51:06 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/2] Cygwin: format_process_fd: add directory check
Date: Tue,  8 Sep 2020 12:50:47 -0400
Message-Id: <20200908165048.47566-2-kbrown@cornell.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908165048.47566-1-kbrown@cornell.edu>
References: <20200908165048.47566-1-kbrown@cornell.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0062.namprd02.prod.outlook.com
 (2603:10b6:207:3d::39) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2604:6000:b407:7f00:fc34:902a:527a:1c90)
 by BL0PR02CA0062.namprd02.prod.outlook.com (2603:10b6:207:3d::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend
 Transport; Tue, 8 Sep 2020 16:51:04 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [2604:6000:b407:7f00:fc34:902a:527a:1c90]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8aca1099-c61a-43b9-1c4b-08d85417604c
X-MS-TrafficTypeDiagnostic: MN2PR04MB5744:
X-Microsoft-Antispam-PRVS: <MN2PR04MB57441B6D5298BFB92C64249CD8290@MN2PR04MB5744.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h2xmRyJ/rWi9ePt/icJhlyvh8NU/yMbji1S73PyZuNGP20lQ3zHg0Hl01j+rHTVyayiTsYyqqCWl7BuBB2oQgIqMl+qq22e0z2KEAkeMC7JhME6WbbSKwMltPUa53dkxKk/4GIHX5SY+OxBcpRA2aYKprMHSparS4W/zSGoh5UlbBZ0IB5vOSt9Po1l8bPaUXNdTRVj8AMp1LWlFgaJD/bJtLAzwe13hv10xWL/MiFsPFXfLXEipbGbtMLrBoMbyEZ/gYRE2/c16D01GxlQ8AHhg3GJEpVEdIaiB+WCUQOELsbg1xVyaBGZfoM19F/RqPd3vBzoXJL4nbIRN+aLMPTDAjvjnoYTCw4nbGMJxQMApRRTTkyts2tlRCc2ENlh3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(66946007)(66476007)(52116002)(6486002)(5660300002)(6666004)(69590400008)(1076003)(316002)(786003)(6506007)(6512007)(8676002)(186003)(2906002)(2616005)(66556008)(478600001)(75432002)(86362001)(6916009)(36756003)(8936002)(16526019);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: erUivb4FRvQBBH74I0oc9RcdVcZGCPD1B34ivZeOeh8vQJ23KfK3uEGFjCywtUpxoSNtWwgcqrwS4TMdmkwrD1mGFzABjk8uN9bJKrIZ09/atRsIo0ie0eIg4Wa1ltpQcIiOfD9AlJQX+SJVVt59syQT7GUm2rl4cLtvBZquCBR5k4HGx9eeQ5E761TLNLT/x1K6RBm6OhByIQtBJuDq3V5zKr7LafKKj9MlcYUVo8RHPAH5hf0q3aQli8fSDly9a+yZO/I9f8iLBUxzojcQWWociBRanyJ7ldSTdtNaaCeuFJHi1rbAbD7bZFNrsPuZfLfdyJZQi45RPNBaSzc/jDIhwkGlnDN4Z9xGtrAp9WoilLKGSkIFUJRU23IDyfddDVh4XFgmKtwliquT4AlY8eFD0t9KhHxA872n2Qo3rpFMyxw+sJdMEAEgarSYx7kD8JBP/7tuV5bFp+Rax7/3Nvv0syN3cg4Gg1OJJXDZ/KGcB8taniIoYO7Qiatr9Z87dwC7H30BfiudsST0wWz0dwmwcxhPRP/hWxs1BiS0veR/Zs+AV0a9xDxARGjEG18ps8kV06WpT/UmEcUNtT/RrufI1I8Vzo+v2Ug3SurcSjDh4NZOSULazJUS4YeaMA5EY1PQCz5QesGBbgUmGFnB4LLqGERfidMJmp26UhYFnWwvXC4SvRPFagkSOk6Bh8+suni7PN+UWrZKMenLmSCPaQ==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aca1099-c61a-43b9-1c4b-08d85417604c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 16:51:05.9061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GXZ9SVLPR/mYTnNAtifyyZEz/vLwz6RgfAK8HTxLFAeSQw54XwcXfqE4+5T+nPrTpDqm9LvMI4fF8JqDbz5zVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5744
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, MSGID_FROM_MTA_HEADER,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Tue, 08 Sep 2020 16:51:10 -0000

The incoming path is allowed to have the form "$PID/fd/[0-9]*/.*"
provided the descriptor symlink points to a directory.  Check that
this is indeed the case.
---
 winsup/cygwin/fhandler_process.cc | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/winsup/cygwin/fhandler_process.cc b/winsup/cygwin/fhandler_process.cc
index a6c358217..888604e3d 100644
--- a/winsup/cygwin/fhandler_process.cc
+++ b/winsup/cygwin/fhandler_process.cc
@@ -398,6 +398,21 @@ format_process_fd (void *data, char *&destbuf)
 	*((process_fd_t *) data)->fd_type = virt_fdsymlink;
       else /* trailing path */
 	{
+	  /* Does the descriptor link point to a directory? */
+	  bool dir;
+	  if (*destbuf != '/')	/* e.g., "pipe:[" or "socket:[" */
+	    dir = false;
+	  else
+	    {
+	      path_conv pc (destbuf);
+	      dir = pc.isdir ();
+	    }
+	  if (!dir)
+	    {
+	      set_errno (ENOTDIR);
+	      cfree (destbuf);
+	      return -1;
+	    }
 	  char *newbuf = (char *) cmalloc_abort (HEAP_STR, strlen (destbuf)
 							   + strlen (e) + 1);
 	  stpcpy (stpcpy (newbuf, destbuf), e);
-- 
2.28.0

