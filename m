Return-Path: <kbrown@cornell.edu>
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2131.outbound.protection.outlook.com [40.107.93.131])
 by sourceware.org (Postfix) with ESMTPS id 45B30386F400
 for <cygwin-patches@cygwin.com>; Sun,  4 Oct 2020 16:50:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 45B30386F400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jm3SDtlPvH88erdih38MaZcIj7KKE5Nnjxl6QIwuHsHbDm3QW0ufdP86sArB6ZiA2y0YW1gY/JWsiojmMy0DffMOPA5457vqqngjxzGG03WZb3BJPIhJgHdaAjslolx2DITtXrBeDnlo5emfRZTZcQRH7dnFIXkUmajtn2qKrNHuPfGfxAdkfzExmnp4+RFSarYxGK8q/1JNkU6v8PgH57zI1VZ8NJ5SVIcTJpEA7OISY2lUnocThOqQyzWvGktTGQUncc5ji+CNBFwczkMUbrBUc2Ky8dWC4H8TazYKSJ+g2ZHEeJS9x7aOCFW1DvfjIWDTBMLmGXDnumjDm8w/WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjei5GHOtMKVUj7cpndgsyt2OQt49dxiTFyflsi0eRM=;
 b=icKsdr20xBWU5Y2aWJUxgeLBmI7Aay4iBjI305mnCzbtHy6DrJUtW/D3JFoScFSGV6Rjcv9tdjfkmFQethKO0keH/iORc0Y1SpwNTLYVKWqiGa2KTuRTMwEOt2ZXXq75ij0Rtjz/VVdtxwc/QnAZwGX/PkSk7J5rywsat0kFcXUUCjAt09R0PwbERHMM36OpzYPZxIZ+QpgmqfScSE4SPf2bRO9HnDjz4funYTUhUCPP6vs3oAvq/OFImvAs5f7wJ1mbWL1ENofAnzjBTQdL9dnaD+TsSAQJtJSSaUZMBjb4PGFV37WrI5NvOJHa7sbbWaHVNWJXRXupmA87TIw8uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Sun, 4 Oct
 2020 16:50:10 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44%7]) with mapi id 15.20.3433.042; Sun, 4 Oct 2020
 16:50:10 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 6/6] Cygwin: AF_UNIX: open_pipe: call recv_peer_info
Date: Sun,  4 Oct 2020 12:49:48 -0400
Message-Id: <20201004164948.48649-7-kbrown@cornell.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201004164948.48649-1-kbrown@cornell.edu>
References: <20201004164948.48649-1-kbrown@cornell.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2604:6000:b407:7f00:48c7:bebb:3651:4c42]
X-ClientProxiedBy: MN2PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:208:23a::19) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2604:6000:b407:7f00:48c7:bebb:3651:4c42)
 by MN2PR03CA0014.namprd03.prod.outlook.com (2603:10b6:208:23a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36 via Frontend
 Transport; Sun, 4 Oct 2020 16:50:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4ededa7-a6ca-49eb-ae73-08d868858e29
X-MS-TrafficTypeDiagnostic: MN2PR04MB6176:
X-Microsoft-Antispam-PRVS: <MN2PR04MB61761A6DDB7817A16EF2F18CD80F0@MN2PR04MB6176.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xFis+GC6/tJPTL5kjMGgFSssAfSAQg8seYxYFbyabG5TRiE5CDEfnqMwaanWT9VhXYSAR+avA8cyePIIwpJYCznBseNJ/xgJ+kuOQtEAkIaOF2+B/lUz8zEzOoyrfL7qA38qNpFBeubNcKYMPvdQsDILPvdynvmE91geUYut2NkOhCjL+9L8jf986qgzU68Lpz80By7c9eO4puye1TEkBG4m71TQWmpnj7kg6OmwViVKQ8syHh9tNlsMufcT/kSVRJxt5mjVmhPwUj6eARfTjXVS8V0Gzn8aPxZQ6UgfpwLmPK+ftqUyDiEBjip9GYq1g3EnJ06R3FWXGIKueApB6buiSV4Cnyby9nkEwteW8pcbuyTZbPypjCmQHo9UKdeN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(2616005)(186003)(16526019)(5660300002)(75432002)(52116002)(66476007)(66556008)(66946007)(316002)(786003)(8676002)(36756003)(6512007)(6506007)(478600001)(8936002)(1076003)(69590400008)(6486002)(83380400001)(6916009)(2906002)(86362001)(4744005)(6666004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: VswipgJ3LRft3zwawQXXT0/VGrOxZqioMo9t8pyYHLStdXmdFav61ngyxvDAB4Xv1Td/tjgkYZjdGfDnG/+dCLPawtOXp3G27Os2+FWEwIt5nWBSP4ibuStCnC/U/PY2pBwMemK6tCCJnRRpmHYC2n4Mh/velQfl1srtvBYuj1ualUf9IeePcjLzu9wrdX6pwLscPeedosqvaqc/wpvdOvxIX2uplo/VKvSpeGEPSfh2nQ0Y+9Wpn8pzwbbg16Pu2d/66F2oKN1b92ROppUd9jKcIpxQgzVVtlCeKHH2PXjpz/0vOFxr0NcneeS1cPUQeVAMWxd32Rm7mHIu+XUuhwpeo980ETDW6pbjWx5gAHhon4BUb76mVSsQ+GDZIcdsrUx0JMOSz0/1ROBBZIIvmRgC/ZizJYWrxKayYZy0WJghviZhlU6QIc0Dv6nY7LtS0Iaf3T5qDNabQ/1ZxTjqsqh4Vx6DyWv540Hna435BW+VyXCTdSBdDsjvQW2fEAYheII/bl/dJwf1r4i7IgvqfS+0HwtnJjZy1kgmEBuTyFqcucc0ywb+RCpBjz0NICD8o7LMBEb28jazKwE6UmbT57DMuUbTYGguI81YG2moDEv0kXC7vYSY5Iwl92Va/JtlopoX2Fe6bFS1Le+8GiwscWkDtqU1ccjXIJkXrOVjjtKns0ZmU6WnzxHggK74LO+ebA3QQWY7d8UoNCMbHbjCog==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ededa7-a6ca-49eb-ae73-08d868858e29
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 16:50:09.9739 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fned7pPVt4Ff4pQhnVFfj0DR9yTEJcD8BC9nHxTQ3vgRgtY5Kvdpm8KDjd7gFrpvdnpgeOXE/01sLjf+Xm7n3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6176
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sun, 04 Oct 2020 16:50:17 -0000

If open_pipe is called with xchg_sock_info true, call recv_peer_info
in addition to send_sock_info.
---
 winsup/cygwin/fhandler_socket_unix.cc | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_socket_unix.cc b/winsup/cygwin/fhandler_socket_unix.cc
index 1a9532fe5..9f7f86c47 100644
--- a/winsup/cygwin/fhandler_socket_unix.cc
+++ b/winsup/cygwin/fhandler_socket_unix.cc
@@ -941,7 +941,11 @@ fhandler_socket_unix::open_pipe (PUNICODE_STRING pipe_name, bool xchg_sock_info)
     {
       set_handle (ph);
       if (xchg_sock_info)
-	send_sock_info (false);
+	{
+	  /* FIXME: Should we check for errors? */
+	  send_sock_info (false);
+	  recv_peer_info ();
+	}
     }
   return status;
 }
-- 
2.28.0

