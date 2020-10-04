Return-Path: <kbrown@cornell.edu>
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2131.outbound.protection.outlook.com [40.107.93.131])
 by sourceware.org (Postfix) with ESMTPS id A7DE73857C7F
 for <cygwin-patches@cygwin.com>; Sun,  4 Oct 2020 16:50:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A7DE73857C7F
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1Br6zxqUFjSKTxnoS7cY7nI6Qs9k0q/1mPqOmcqQrO46vW5uudv/O2CR+Yahg0rkX6OtMEa+tW1+xq54js+zLdZWoGlN1eMetund6jYY4miwVxNzyB0DoeaAeCBpP06vd1lhgCkJq6yJgA5smbN28KS60R3sMunLVDsfr8etls79/vQ1AdIl3E7CuwyLoQA9+Pk87kdRKXyVtBqsxg8wwX+o+d6quvbDmbIpHoH07SoWLF7sQBZzimvhxuN1xUbByKZILll1/F69LLLEkFZYWLJGHkuwuaU5JFezmg18orCxfEU2nyn2nZR38yAGVI2RYtny16ws3sdJVODN8iXWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lpnfoHdm4rVWNJ0rHbh1QQWDf8yxQQvnhWjevCOUUs=;
 b=gYK+x7hSOy7+G2GYKSIvc8N+BQB1GWUojGHpff1VqFvqW0uhNUF683jihmQS8X540+tGa5BEpcGWuneJM3Qa63KoAc6owxuLOs5s6pVH4tavGEypJ68E580skBo2kRgiiXPv0W2KG4PIrZ7CFW9MQrOe60XMYQm60yutLGcigrX4f5014fZQNexjNpoKYMrLaYPae8oPhZIUPbb9AhZPAJMxqhITUP4c00SEWktORX13wwHA055BaBrteiDbkeKTRKyHE6m9JukT5IKIXma+aS7FID024ut/cWNU1JBHCLTuvqkJr0Xri21Db791WNGcGLLUW0vOTjOKsrxhxbo+wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Sun, 4 Oct
 2020 16:50:09 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44%7]) with mapi id 15.20.3433.042; Sun, 4 Oct 2020
 16:50:09 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 4/6] Cygwin: AF_UNIX: socket: set the O_RDWR flag
Date: Sun,  4 Oct 2020 12:49:46 -0400
Message-Id: <20201004164948.48649-5-kbrown@cornell.edu>
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
 Transport; Sun, 4 Oct 2020 16:50:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52b0c079-6e3d-4189-96af-08d868858d85
X-MS-TrafficTypeDiagnostic: MN2PR04MB6176:
X-Microsoft-Antispam-PRVS: <MN2PR04MB61763751F9241459E156E49AD80F0@MN2PR04MB6176.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KQOQI6zhYqiyt6PvdSPsrqvCa9TfrtgCNQYD9m1CpfG5kvn28pyQRkf2sjJTiD0ZmL0PImotvwoNhXiEApLWz7Q0SRkTtK//K7L+hppmmqKqRnslnkkumwpAjgNZpOD8P6crnhxQfAF4bBd64dhtJblLYhR0s330b/xwP7VcLJ8W4PhL6OIVWaqxpiAsn1rawAtWN7HPdZZoz9CAL9GP3MFdYpo2YPaO9BvaehbI/wxaDAkEUHSTlGcFBbpE+bgq3ICrBzm16HyX5dB9UpdQ+0NCOZzpNnynfR50CDoxfQoVkcERN/iq2PuA9KXhFeZKfS16RMZ9wryOPSQr667xIKW0OfqwdfLnubdQkNSKdFrSAR8tjYdHdG+BjIvvSFQP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(2616005)(186003)(16526019)(5660300002)(75432002)(52116002)(66476007)(66556008)(66946007)(316002)(786003)(8676002)(36756003)(6512007)(6506007)(478600001)(8936002)(1076003)(69590400008)(6486002)(83380400001)(6916009)(2906002)(86362001)(4744005)(6666004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: YpFgH1jk+ZrHxvCgB3ZPodMbKcQS1Kbo63V6uqvpmlg1w64hjG3KzTUeMaFfNq/EcTjhXF2K6N/Gir1gqrqTkR6JyurGPbWsBde/YVIxN1Uriuu8wDMdpRUGfm3/yLyDOjUjCADrj65TNLcipwwDKrrW+/i80qsg8Db2+wcoMgKoUCe12/3J9dccWv6AECWtuLjSNr3p0vNVIaR8lehnxv2W15XMDqHuqMCaAY+WEJNjNdmB9mt+P+t4pdQoGZcorYyIWw03BzONTAAxQpRvX0JQ0atbRGk8JI2a1NR2UyONongxZ7WlmznOkSvjTkJteNU6RdDffnGFOSCoTOY/P6AlJDEF86qKzN+CfVp63k0wAJQfol4/JabfMnCaghiJPYg5WgAO0+uNx1np/Eh/ucuuq2vW/tiwX/s9oSFEsb7L3LGB6VEF7dCVednhMJG/lpRh3Uu8pkLaSLfuMpGdBJjNZY21WP4a/uADN3/utN0MB6RK+ccrueLR2CYwYT/A7ps4kCZG/ehb4xBFHbfQP+b7zleJs6MuFDDFWK9aqYxMlPSrjQR8fn3pItdAbakU2P1HXxhN/bey3no8mdGUztF81/30BWAFnE3pEgXubWlQhDCNyCyKGsOnE2a/2f5UJCbxbT2aP4ySZ2WdsKNKL4N8ES4D3fPok97CLfuSyct4d3rVWW7eVFBjwEYSm9EwclYJLHw7dYtvwsth7CeOmA==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b0c079-6e3d-4189-96af-08d868858d85
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 16:50:08.8925 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 89TJL0jx9mUpzGSDIT9pOmGwOy3uPXgTqzSSzWO+sKdF5ejc8jVmBBOzMlukIPS7g1ymrX4Bcx+pgn8YNwzXhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6176
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sun, 04 Oct 2020 16:50:15 -0000

---
 winsup/cygwin/fhandler_socket_unix.cc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/winsup/cygwin/fhandler_socket_unix.cc b/winsup/cygwin/fhandler_socket_unix.cc
index 429aa8a90..0ae7fe125 100644
--- a/winsup/cygwin/fhandler_socket_unix.cc
+++ b/winsup/cygwin/fhandler_socket_unix.cc
@@ -1366,6 +1366,7 @@ fhandler_socket_unix::socket (int af, int type, int protocol, int flags)
   wmem (262144);
   set_addr_family (AF_UNIX);
   set_socket_type (type);
+  set_flags (O_RDWR | O_BINARY);
   if (flags & SOCK_NONBLOCK)
     set_nonblocking (true);
   if (flags & SOCK_CLOEXEC)
-- 
2.28.0

