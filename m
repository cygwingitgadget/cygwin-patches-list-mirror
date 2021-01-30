Return-Path: <kbrown@cornell.edu>
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2110.outbound.protection.outlook.com [40.107.223.110])
 by sourceware.org (Postfix) with ESMTPS id 7F0333857023
 for <cygwin-patches@cygwin.com>; Sat, 30 Jan 2021 16:35:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 7F0333857023
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RiJ+yBJ+0iNDgFIsjDgP1yhaw/TdcRSEeBFRtz6xWYjUTUHye34TVOK/kCqKr00uy9gjQbbOrEfSpHLowt0y3BZHKaYEXpxq/MSVamoJhiiNvmQY1Xd1lglDGaWiOvF2tMLASESLP/IWMALWr1xnX/WA+YkEfw3FCfZ2I0t5VLsnidTp+zE10Z8/hycPvIjomGYFqiiwpPYWmm7B9/rOn+yMJl+wCYh9K8mjzM64axACxEQh0f8mYNSu0bnCaNZJ+WjDiFNBoPXNxNzCKLDrAuwqNqSJ9ws9opBDnler+fFw0yDy0J7ZGrKokhcu10BdpXl6UBviU6pH7HxypKG4rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Is4LHjIuB4mxfIT/nTQNQnHsACLsqEGKScyiODCxYEo=;
 b=F6nGwsY0KWF2dOUmz0JmGID7eKxcawgpKn/ULPJrBSZ0I13bxThqQ/6Rnk6TWSSH7et6YCSj6l4ooMVcceE7kDpFnOawdTZN7K8yd4s40TcYGD+tf80Cx8sC6GxErPeiOixqyfTBECgl9UsIzLhXnHETqI6N12G89fjBz6R/lijOd0bKts30vp0LEKbj90EMruI4JGDUdi8w82M8oA64Xb49gRZ3TZ73CptQnn/koIUlp47MfRAUmLHhIzpua8B1pT+J+s22m4Q58Dvx/h3l36RI6RBA9AiJ3SC041MNIV48LEaEwBQ3KZSQVW2oVO888fTFG0KKozonKphzVg+tAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN8PR04MB6065.namprd04.prod.outlook.com (2603:10b6:408:55::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Sat, 30 Jan
 2021 16:34:58 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%6]) with mapi id 15.20.3805.023; Sat, 30 Jan 2021
 16:34:58 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/1] Cygwin: recognize native Windows AF_UNIX sockets as
 reparse points
Date: Sat, 30 Jan 2021 11:34:36 -0500
Message-Id: <20210130163436.21257-2-kbrown@cornell.edu>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210130163436.21257-1-kbrown@cornell.edu>
References: <20210130163436.21257-1-kbrown@cornell.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [65.112.130.200]
X-ClientProxiedBy: BN6PR19CA0061.namprd19.prod.outlook.com
 (2603:10b6:404:e3::23) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (65.112.130.200) by
 BN6PR19CA0061.namprd19.prod.outlook.com (2603:10b6:404:e3::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.16 via Frontend Transport; Sat, 30 Jan 2021 16:34:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d442383b-454c-4da9-0741-08d8c53cfb2f
X-MS-TrafficTypeDiagnostic: BN8PR04MB6065:
X-Microsoft-Antispam-PRVS: <BN8PR04MB60656C225952A443C888B0D7D8B89@BN8PR04MB6065.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m5ue2MRYwcE3rLhIRPlxX9QOQ4f0o8rjg7YcAbBYrZ5XOIhmCNOSCY7bwQbX4WqMW7AOUWs1P+33Xq0U+OPLVc2kpIarQ3/YooDHh8KVsqxrzq247gp8BEQfvTdblkYyaDc5jeWTzkGOKIYOCoiyANAWY0hrLqcxqXkdww6BZqPiFUlZoL4LmDhGM6zYFFqjTxxVEFM31YDKAGHkKwQDB2l1n3/GCJdx+pmzCjcLDXWuoeLt2HKgUHk1qqTSkm8EyXz+NgZF0fLn/Tgc7K5n9LWm290ro3aJxd5bkObcU4+rzmMz8L6GlmU8sRm9PTK07t5DZSARkAGPI9IHFwQJ6oa+Sbn7mrLWRNPF7M15N+xVPTASCnihtfJkvkoCnVkEEfkvYLYcUG0z8in0NWxYwCtGkD9WnmqZODty3GsJ4sQeGQH6o4Yvw62ljNz8MI/yRAZhfmn6bl1rSsHawwIxKATVZcmsJc2yVGXe5HiMBGpuYj7h7d1IDmo8HHotVej2X13LGSieDoGDfu8V6FQkG15yE4WhMMSJ6UihPBZ7pr58/Ij9tcdIdi5ztBII89g6AG4CeqRvDaJUG0XNxLtIoeCAU5cI5QD3iktydtSEHWIGx4d8mpEatFynpq92TOyVEdTjHGSN3dPNV53Prp2uY/1d0L2kSUjVrduB512DF8o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(396003)(39860400002)(346002)(66556008)(966005)(66476007)(52116002)(5660300002)(1076003)(186003)(86362001)(16526019)(66946007)(75432002)(316002)(786003)(26005)(6512007)(69590400011)(956004)(6506007)(8676002)(2616005)(6486002)(6916009)(2906002)(6666004)(8936002)(36756003)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?O654DPXKhR0t0WeWT/WhD5gpqZhkr6K/CBHYQyM5n2W9p2Q66+WIkjWS8YD8?=
 =?us-ascii?Q?rwgCgy1HYHNSYRrROJJdIpu6B4fS0e+jK72i2p/sz4X0Qazp7NpRVOwrAoWq?=
 =?us-ascii?Q?GxlOV3DGXSA2O6vA1MRhKsHMfdhl6FqZGLq4KId7uZ+g5BZ02zLmggZmDIps?=
 =?us-ascii?Q?T+73gBW2WgFO1XbmFkyXEw0bwVjXJ7u7WzdPkHRHrtPsleE/nyaLhO2HctOE?=
 =?us-ascii?Q?jIieLlRajnhR4BcVMp2bqdsEMmEOA5PzcalyZI2k9bZNnzDLt3uMuzxZ6tAD?=
 =?us-ascii?Q?3OooFmOICTx46fhu3PnX1hiO/DGzEx79ggJJqIS2TqV6DBfunxVa+LA0+GVA?=
 =?us-ascii?Q?KmbYhm4ypLfvTLhsIrHCibyzsI6Cq4FGOOoNzVlc0K8cAYasyWlUu5XoeQqX?=
 =?us-ascii?Q?ur+MhK5Lujd2L2D8TlDu8EbSI/RSuelO79opnq1pvrh0j4uDE6gAexHMF0nD?=
 =?us-ascii?Q?1PIJxIPbeQfa1smiLdFdH+z0j7Josp31x8hIXjqWezRXn6i3P3kUaD+VpDtU?=
 =?us-ascii?Q?BJTt0w9YoqotEWHM4+PbHekg+/U5zGDnbgaPNocO9c6qxrnEsCGK8boRCxnQ?=
 =?us-ascii?Q?i7Xnmfg0djeJaLoaDiOjsSSPH7LdPd9/avFF90wAYumeQaBwgD9uyGwktAlr?=
 =?us-ascii?Q?hGvLE1RBMlXlZXNux6kNNzgj2LVe/EneLxwwRP2ZpwD46U1avQl2AbnBUWtg?=
 =?us-ascii?Q?u0rTEW/iXJxwf6FOwtosWx3EtZsbj+yUIzx5Ew5BxgLH+ThIA1vmhRS3TOzr?=
 =?us-ascii?Q?uyBivBCoN3wLbXFfGI9sGoGro+JwiznwvGwZQrN/BOOK24CpD8d+lmoFcNbI?=
 =?us-ascii?Q?JQrvk68vwVBq9HE26DtWW2/wBgl4j0xYnUXGLziGdzzuKXOh9QkhGytdws1G?=
 =?us-ascii?Q?X0AI0rUmiF2Knw7rqmYa6vSageuPHYs4OCFz9HJQmEn8iudhzxqyevS2t5b1?=
 =?us-ascii?Q?8RIbPUEEPkiDzAkibJFPBIZhyd3Y/ZBnJPo0mU4kh1CyqcJ2R4SIOtuQ310Z?=
 =?us-ascii?Q?OGntHlr8W9PZ/lLA/5ebPMB28VQ+U4eRTPRFL7KlZViBqFGCMXanEUZ3ko59?=
 =?us-ascii?Q?R+ATUs/S?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: d442383b-454c-4da9-0741-08d8c53cfb2f
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2021 16:34:57.9625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PuoLGWgl3juSU8I395j1cZilCMzH5KL9H8IapKOCFtUJwigJafeqzt1y7+XHQgdHIbXTiFV7SYl8tcQFDZuOvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6065
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sat, 30 Jan 2021 16:35:03 -0000

Allow check_reparse_point_target to recognize reparse points with
reparse tag IO_REPARSE_TAG_AF_UNIX.  These are used in recent versions
of Windows 10 to represent AF_UNIX sockets.

check_reparse_point_target now returns PATH_REP on files of this type,
so that they are treated as known reparse points (but not as sockets).
This allows tools like 'rm', 'ls', etc. to operate on these files.

Addresses: https://cygwin.com/pipermail/cygwin/2020-September/246362.html
	   https://cygwin.com/pipermail/cygwin/2021-January/247666.html
---
 winsup/cygwin/path.cc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index 6dc162806..9d2184d6a 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -2640,6 +2640,10 @@ check_reparse_point_target (HANDLE h, bool remote, PREPARSE_DATA_BUFFER rp,
         return PATH_REP | PATH_REP_NOAPI;
 #endif
     }
+  else if (rp->ReparseTag == IO_REPARSE_TAG_AF_UNIX)
+    /* Native Windows AF_UNIX socket; recognize this as a reparse
+       point but not as a socket. */
+    return PATH_REP;
   return 0;
 }
 
-- 
2.30.0

