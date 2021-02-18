Return-Path: <kbrown@cornell.edu>
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2119.outbound.protection.outlook.com [40.107.223.119])
 by sourceware.org (Postfix) with ESMTPS id A8E013955422
 for <cygwin-patches@cygwin.com>; Thu, 18 Feb 2021 17:14:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A8E013955422
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZG6IH62NGLE61d5u9d1qL/kkKozRW1vwPRXzN4Vf93ZGkVaT+FFXh6q6h9wFRSaNXlb+ik2kt9fswBvjC91+NJxW8WLUuYruQEseHlULBziQtQAhl/Kr8NX2z9nJTbCqVL6P52XxSJyL21MWG5T6HE53MxhasRG9U+iTyX4FeehT1vXKbACLjawt+3EBvjGmo/oKtq2TYB38z+JId6YBFWV3n0c4Inxe7mPXfJWog65C6QCKdiAttddQJ2bPSXZoTMNAXOyFtFCJKGSf5d3lpSxEn1jIxKBle0PHXT8D554QMS8xVqK4Epr8Ndy64uf7I/fswF0kw0B2WjOaz++CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhWBcKD8Bd4Wp49ArVnQLtSCD8bMPFsF9xGg+AbHw9s=;
 b=IfFN2R/MJ+Cdk/TXEY02PMOxL5vGfy+7IBDUlY4AJ1D6ZOTm1+iC1KJmv+FCUabQPcbctxImVCUR5VcWuqKoh/LqZFnICG/DTWcbPfUPgHFb7OmUR+wy3Qbd2qPm6Q0qSdSlXso+8s84amyAB3Qbd8swLF2Jotp46jKMTwGsZNqO7fLfnWr3JteDSfcotOb9dSpIJxla5jV+eD6QYp9DkFG4VZ9f9WfWKuFnuxkTlceA/9ZKSN67VmB1dnrKU+fjFHggunq4LMpRLlMkq7Sr8miPvZU06D31+fIip2J0mnZ0HsfDppplrB48+90FgxT8aoc2PqT918V4drAXVQuZsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN6PR04MB0434.namprd04.prod.outlook.com (2603:10b6:404:95::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Thu, 18 Feb
 2021 17:14:09 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%6]) with mapi id 15.20.3846.038; Thu, 18 Feb 2021
 17:14:09 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/3] Cygwin: fstat_helper: always use handle in call to
 get_file_attribute
Date: Thu, 18 Feb 2021 12:13:47 -0500
Message-Id: <20210218171348.3847-3-kbrown@cornell.edu>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210218171348.3847-1-kbrown@cornell.edu>
References: <20210218171348.3847-1-kbrown@cornell.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2603:7081:7e41:6a00:a842:7b47:be73:d167]
X-ClientProxiedBy: CH0PR03CA0065.namprd03.prod.outlook.com
 (2603:10b6:610:cc::10) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2603:7081:7e41:6a00:a842:7b47:be73:d167)
 by CH0PR03CA0065.namprd03.prod.outlook.com (2603:10b6:610:cc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Thu, 18 Feb 2021 17:14:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8bbea44-7a9c-427d-825c-08d8d4309ab9
X-MS-TrafficTypeDiagnostic: BN6PR04MB0434:
X-Microsoft-Antispam-PRVS: <BN6PR04MB0434F74CF5544E33A764B38FD8859@BN6PR04MB0434.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZmvsKZkzYiQwGOsMxauIhJ2aYqs6ehChz+rWslVsV7V0nh9gtiDwDH/83sF80mBwxGboPi7gWHW5lpynVkGvpiiN4/lzDjWDPeYZRF6pJZaDT9MYdF4/ILMkkO0z0C9jfGLSWMrhIwlZO/FHaN8ZUqdmHV5d8PEoXWqHU6gsvzAWfE48K1Oj/6XRSHmAZudjMxFPuI+gBGobFlwXW8OefGKWzkHFt1M3OmERfZeSwCBZcZs/qAhev+yfrEVV6PcEw5XiGJKuW25ptPq+ZbPM5oorNAEP843GVkh8MQrW0lEYzSKXXmoxOVyO1S7xUDDXEo/csmyhX3DXDRjKlVmttF3N3/k18sZB/vln8Yo/FmD1oA0QO0nj1gSVtnTxt6AqzqIwohzui72F6+yidBQ6fG3FRDtNAxCb/YQuGblSdVKovz/oxso64bDjtdydvssnRPfBlSItrnmfXRKw5oUuiPe1hOHDmxl1AuOg1Dct4GpE7XI516jZUMtVsdLT7ZFztbphomY/jx3W9+x7kHHkbjzBkpXnB5Mo/SHKO+KFOQiXGkM5hXm9RjGlf/ugPhAJVoJjlce3QU1FpZDhiopc+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(6486002)(6506007)(16526019)(83380400001)(86362001)(5660300002)(66556008)(186003)(66946007)(786003)(6512007)(52116002)(2906002)(2616005)(478600001)(316002)(8676002)(1076003)(6666004)(6916009)(66476007)(8936002)(75432002)(36756003)(69590400012);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?RAtamfb6937zOHMVdosWlbNeE3cwlR3RVxijhoC2nY3TlEQzoPsmRHeQUAp2?=
 =?us-ascii?Q?jEzlTrxRb69I02gqbVG2SC0UoAN8u6JEiOpxIEGPdGmOqDxqDxOsaOS85DOk?=
 =?us-ascii?Q?gUKJXgdW803EoX9nmhTNoM1Zz1RTsbA4ilgbtSKwQ/QThiuuR3TR+mBe5yzv?=
 =?us-ascii?Q?/oo9J3Raw3MHjOO9j57rx/xS06zIg3FLtT8AZOAreD9q2w5aGPndTfhFrHl1?=
 =?us-ascii?Q?wGeWhvvN3AltZDu72R0DpLCeCAkQLlLvElhfFXdoq/aD3eNQ1J0v9WJTKx8M?=
 =?us-ascii?Q?CcZWmVQO7Kzl/i7U7XBsLnIeL2tTEbtKwDAlohxbpRru5xdn7h5/NgZt8tYa?=
 =?us-ascii?Q?EHwkAqVrjEdTt6h/Ytc+XBEUNj2DR5s6Vyg13K0GEtjkvt03V5DEQxyBc55e?=
 =?us-ascii?Q?PMxFQTKjWZmB4p0PwZt+J7huuWhZNM4z0Xn0vV5I/ctr4zKwydPIr6f50f3M?=
 =?us-ascii?Q?caMx5v6E9lgKYacmWIB9j1CG1wMAkjLCRCrQDACV8gLEQCfWtidNEvaf4pMX?=
 =?us-ascii?Q?awKI3ArvcxBDGTmP8Jnft66/pE2ZNnTtISEiRXdffpZywTY5JyMblgwJi2AP?=
 =?us-ascii?Q?n1w7pyWDhkQVSft7DhHghL3dSgjtDFV2dXE6nrIrGDKwRpg92GxlPGx+lefQ?=
 =?us-ascii?Q?OSz4Mq8eIyTV/ICSpYfBHAgJNdeh2R+hitPnaNCrJNv0D3pjE02s6gjjGC7g?=
 =?us-ascii?Q?eOHOxiw1MtcFFgIm8uxCNaxf1ciQ2XpxW+hSlJNK7cXKAW9HkeKXCtS++2X5?=
 =?us-ascii?Q?9mr+KBfbATBeNMk35IhurMQtRB3/KT1kwtRfagGdWtzkm6NFiBATYN1nWEiG?=
 =?us-ascii?Q?glw3n3eb89kx/yqn5VCurLLP8KP431tj+GYcwJygM0hj325o8xsVDMZEL73A?=
 =?us-ascii?Q?q25jwD8AoLi31KAjTVHz1NCgLp6GpdEr677myyVarDFG1+jXKOULcncVRH9Q?=
 =?us-ascii?Q?XyrA/gE4mj13oQX1hUzhnYJpj4bUqQV7AvsvRNtfHs/LooSjMy2OvH+OEUQJ?=
 =?us-ascii?Q?NfeqSXPMpvTa5i/qJQlpS59354twq3TiS03Bknil9fMygBTRMPEyyEAsyj1G?=
 =?us-ascii?Q?6CsZNuwD6VSIRsXC0Hu1tmIDMSDeVx0sXkCfu6ESZULfWhHiZftujkwRB1vw?=
 =?us-ascii?Q?4mf8lm+3o+c8+VvEROvBgs2VtcbGAZa2XFXZYpA29HdI2lfI/YVb1t6u+Zai?=
 =?us-ascii?Q?vBOBUE8gP030fpV6DNiZCFxjyqnOfex1bQy2qEPelHFNMQX2aCHLEdob3nVG?=
 =?us-ascii?Q?yiWSZdaIIXr3oYYGPflKSWYL951SM/dY0xGnVkQd2ZvPQZecaDW/M/1lkpyG?=
 =?us-ascii?Q?107xTuXYfMPPqqTixsipkJPy3bTDNedqKQJld46fnhswInByiSad8kQB+JBa?=
 =?us-ascii?Q?ZfJIaYyLdehvJHv4BrRwePQaeImR?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: a8bbea44-7a9c-427d-825c-08d8d4309ab9
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 17:14:09.6660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cOpv0wrsIu+0IlqpQNeDNDnCFdATGgjdeobjmlJh2oU7l5oAc0k3Nv9o4kJBimztJWg86hFf8hersaoV1aoBug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0434
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 18 Feb 2021 17:14:15 -0000

Previously, the call to get_file_attribute for FIFOs set the first
argument to NULL instead of the handle h returned by get_stat_handle,
thereby forcing the file to be opened for fetching the security
descriptor in get_file_sd().  This was done because h might have been
a pipe handle rather than a file handle, and its permissions would not
necessarily reflect those of the file.

That situation can no longer occur with the new fhandler_fifo::fstat
introduced in the previous commit.
---
 winsup/cygwin/fhandler_disk_file.cc | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_disk_file.cc
index ef9171bbf..6170427b0 100644
--- a/winsup/cygwin/fhandler_disk_file.cc
+++ b/winsup/cygwin/fhandler_disk_file.cc
@@ -475,8 +475,7 @@ fhandler_base::fstat_helper (struct stat *buf)
   else if (pc.issocket ())
     buf->st_mode = S_IFSOCK;
 
-  if (!get_file_attribute (is_fs_special () && !pc.issocket () ? NULL : h, pc,
-			   &buf->st_mode, &buf->st_uid, &buf->st_gid))
+  if (!get_file_attribute (h, pc, &buf->st_mode, &buf->st_uid, &buf->st_gid))
     {
       /* If read-only attribute is set, modify ntsec return value */
       if (::has_attribute (attributes, FILE_ATTRIBUTE_READONLY)
-- 
2.30.0

