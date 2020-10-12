Return-Path: <kbrown@cornell.edu>
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700115.outbound.protection.outlook.com [40.107.70.115])
 by sourceware.org (Postfix) with ESMTPS id 63DA1386EC49
 for <cygwin-patches@cygwin.com>; Mon, 12 Oct 2020 18:02:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 63DA1386EC49
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTX8gsXAIe872+BHWn5CMhKWyxtpGzzoRlMNHdVArLI4CVlblFXj/PoFVo+er3EQnqoVpcFuY0e/ZPMWntF5YRMR5By1Qsy+Ctgn18/+CVQgOFZ4gQO9frXhWZ+63VpgLVLelH3RObZt62jp+Rc9TKe5kkox2ewIIqlj2n/nNtD4wsQYBfy28kVPbXkeHCT887p7WxGJewPlZ4q5omyD1ZReqAH/EQMj/82V/tfnU9K9prZiZ9W1OVkedADFFSpBxXLT1yhjjuRybPqEaImpLJKN2mAeTXds+lELbDPvnJUh+lPOT+7SkutkOBeQTH9yCF/GSl45qYDGnygQAhtLTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3k7+/SLbSw+EBmHgVvRWKxkcDf50Omm+ZVFgJ9MV7zQ=;
 b=c8YbjIf4rzYD6PjFT3PkLlBoFsVhVQMeLCNEFsbuUul7gNJ0HePmg+HknA+L9/FtXZ1PJSlhUSf4NzrsViOOANy7aj5hyfjUT2PRZVAV4zi2k8nOnnec6MMNWmXbESyrNt6ABEK2jYJt8Efga22j9QRG+fw7fvi+J/O4N/xFJ1jBew9HaRE74C6BBuqw3/x90Uhz+X0gtmqJzbCAmEce9rbVnDANppLoKFHMRYbiHnULnmAod3DtOQajce4iNdFMGVGgLwvazzJKYzyWu0oulx62+LCWENyXMQAQeCzEJWEky43I44Uhtm+ohiap51k8pB+2U6N2qdF5CD4QKZ42HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB6047.namprd04.prod.outlook.com (2603:10b6:208:dc::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.25; Mon, 12 Oct
 2020 18:02:34 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44%7]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 18:02:34 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/1] Cygwin: AF_INET and AF_LOCAL: recv_internal: fix
 MSG_WAITALL support
Date: Mon, 12 Oct 2020 14:02:13 -0400
Message-Id: <20201012180213.21748-2-kbrown@cornell.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201012180213.21748-1-kbrown@cornell.edu>
References: <20201012180213.21748-1-kbrown@cornell.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2604:6000:b407:7f00:946b:663a:1a3:dfd2]
X-ClientProxiedBy: CH2PR16CA0024.namprd16.prod.outlook.com
 (2603:10b6:610:50::34) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2604:6000:b407:7f00:946b:663a:1a3:dfd2)
 by CH2PR16CA0024.namprd16.prod.outlook.com (2603:10b6:610:50::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23 via Frontend
 Transport; Mon, 12 Oct 2020 18:02:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc91093d-3377-495f-2178-08d86ed8fd8d
X-MS-TrafficTypeDiagnostic: MN2PR04MB6047:
X-Microsoft-Antispam-PRVS: <MN2PR04MB6047AFF0BC84B0BAB669D3F8D8070@MN2PR04MB6047.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9lSDHhkmltbKWGv/tgjYMVoqP0ZQwFszKp03qLa0NZHPfoKQu/clFip4jQMtTVxKVEFLcujyKF/71i61XHVzlGoxrLp6ggGU/36U+ezZEC1xL5T0qPNsMSH0+8sSH5vhuwb7oyDf1JY3Va1Cz36szWD9qRi4/E05dV45hfu2KcV5mZAUsog/v59w5Nady5krWkLz54vjI4h54gvdXChUrDZcaL0NMCH9NqTMFbykcnvAemxoQjXP34bnStpG2nGQ74azJDrsSpa1KwIO9ARFIDlZwlSN+3x8LDSRu3b2r+YNAgDlZ+zKN2hiDEqYIFZhisF1xI7Q6ZJSGPd22yeLeoDNntlLwablDYlpW8aHund/OAQUR5o21z3E5mhWs3Hf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(86362001)(66556008)(66476007)(66946007)(316002)(786003)(5660300002)(36756003)(6486002)(52116002)(6666004)(2616005)(69590400008)(83380400001)(8936002)(16526019)(186003)(75432002)(1076003)(6512007)(6506007)(6916009)(8676002)(2906002)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: zadkntIUPpVjPIjr6PgVhRgR2FoVQG668sjSeGI8p5NGHnkR+OitypZ9aGBPGWEnnAhKfYcVi3u4zOC8tisCnHjeRizrbPM16CbzEr3DopOeL/fTPjofPXJk4s59FPqgofbnVCSGTCDZ1Y3j1+yhLCt8HIsMVNsMWwJTcELARuvIcJIbRGUShd1R4z1ZX/UgYMojMxS5A9pEzMuvuondjMv/KoBm4FJHjv58WTs9M720psQuB2uBFbGP9Zd5ZIjDW48SfzE706GA+Dhz+6COdo6QUqtyrkUetgWJDfjoOEj5ncG2OWiA4zFGER4702iz/cG/p5x/zPgJVoQv6M32PXtxEiHqizPshojrAEoTix54vuV9LiIQVM2C9QtPFac8plZFfFrf2gzT6CH5hBuCCxWDH3DAwesMxdIvjDp978lM/MLWoAIAtp0n7JBGPOEpffbN/MwkJeYqWpXXjNIDTHHVkvcW6yE64RwXo2yi5KG205ZzUsdJodPNrfi5JYpfaO5Qf4VLCILCGfpghxPfnERU3A6G/UMP8NdhgiGqmMX/CrrwVAxIvdVr1V3oZtEtFRl2a4QTyLOZreNpeIpUcMEsw9biOig6QWyCffp/OOzMS6I4Fhho5tSLZO2rp4YeYJnN1V0I8+HTv6axYtEHYDLJccwuy+TY9F5n1Iq1qS1zaKzLchoA6o5fk/G/iL/zUgYwcP1BOgHC8T+9K3KHQg==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: fc91093d-3377-495f-2178-08d86ed8fd8d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 18:02:32.0940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/KL6gXhkC0WDbztpqx5vWhdof7iBWZN9UPooYL0Ag5C+79oWLY7pOze/62+9KTMTltYnXw3FDOgEjDh/q/nfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6047
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Mon, 12 Oct 2020 18:02:36 -0000

If MSG_WAITALL is set, recv_internal calls WSARecv or WSARecvFrom in a
loop, in an effort to fill all the scatter-gather buffers.  The test
for whether all the buffers are full was previously incorrect.
---
 winsup/cygwin/fhandler_socket_inet.cc  | 2 +-
 winsup/cygwin/fhandler_socket_local.cc | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_socket_inet.cc b/winsup/cygwin/fhandler_socket_inet.cc
index 71e92e341..bc08d3cf1 100644
--- a/winsup/cygwin/fhandler_socket_inet.cc
+++ b/winsup/cygwin/fhandler_socket_inet.cc
@@ -1208,7 +1208,7 @@ fhandler_socket_inet::recv_internal (LPWSAMSG wsamsg, bool use_recvmsg)
 		  --wsacnt;
 		}
 	    }
-	  if (!wret)
+	  if (!wsacnt)
 	    break;
 	}
       else if (WSAGetLastError () != WSAEWOULDBLOCK)
diff --git a/winsup/cygwin/fhandler_socket_local.cc b/winsup/cygwin/fhandler_socket_local.cc
index 8bfba225a..c94bf828f 100644
--- a/winsup/cygwin/fhandler_socket_local.cc
+++ b/winsup/cygwin/fhandler_socket_local.cc
@@ -1212,7 +1212,7 @@ fhandler_socket_local::recv_internal (LPWSAMSG wsamsg, bool use_recvmsg)
 		  --wsacnt;
 		}
 	    }
-	  if (!wret)
+	  if (!wsacnt)
 	    break;
 	}
       else if (WSAGetLastError () != WSAEWOULDBLOCK)
-- 
2.28.0

