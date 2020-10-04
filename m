Return-Path: <kbrown@cornell.edu>
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2131.outbound.protection.outlook.com [40.107.93.131])
 by sourceware.org (Postfix) with ESMTPS id 5FFFB3857C7F
 for <cygwin-patches@cygwin.com>; Sun,  4 Oct 2020 16:50:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5FFFB3857C7F
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHbzP166bs/Y/y42nF0HYmh0yFSdpmT+6s3m/19oilpWlMGpri3JNgBzyU8dUDd0mDDskT+eOCKqVEtBePV9DgkhRb3BilJZ34A+f8tN6yb5/Udcfpb2+dV+NcSkV2Ehx6oDs7g/Wmi5FmhLZat/pmbKauOLN3OX72mtVvhkZ195Dq5k635sRHmXQlxkbPDpYB0jKAXYdYHmcgZR31KAMvdO6piwvvA4leg+idrU8WPRM0oJtGIk7ksJeLiaf8RSuVggGtwUnNuu8x1T9RF1jb5f38GoxkpNR/0yNJnyxQ0qJGA0wCSF8yAiSmEuS9xA5krPrVoNAN45SpMsBn6hcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3HuX/eK0cr9GHG6XOuEtfH3CY8CABsA5Le0pw3nm7Y=;
 b=X33FA1RIHKbcglavTV+k+fDbCG0CIcybOJ0hG63UoEb/jt8nePufNhm9/BhqaU1D9xw5anUCt9OSo7HetyLjM0loNrDWJ+1M4RWHYrs9EfpWx/7Ne1SivrOhxseqDvXNwRiL/PAHPtP57mmE++0gBZnd/AYWczRHEijghyyOstm9vPACm4Se3AYNFOlbTuhRmw9JwPClFhmSa0U46ktytAtbzsSkY8xJqodTfK35TJkSCwvyBulXCuCuyBZmNxIfaP/uIyh1YIkISiTMx1bclnoYgBKPZ7MU5kBbeb1btmAstOmryHE0Lay6qqZnDvdxI7CIe1ovs2lx3OcY3aoafg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Sun, 4 Oct
 2020 16:50:08 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44%7]) with mapi id 15.20.3433.042; Sun, 4 Oct 2020
 16:50:08 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 3/6] Cygwin: always recognize AF_UNIX sockets as reparse
 points
Date: Sun,  4 Oct 2020 12:49:45 -0400
Message-Id: <20201004164948.48649-4-kbrown@cornell.edu>
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
 Transport; Sun, 4 Oct 2020 16:50:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb61e1f0-26dd-4d37-6837-08d868858d31
X-MS-TrafficTypeDiagnostic: MN2PR04MB6176:
X-Microsoft-Antispam-PRVS: <MN2PR04MB61765252B9B2EFC79D555DF8D80F0@MN2PR04MB6176.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cLizx5RWsRBAVDn+9+FvtIYV8QWqjnGtz+vuBiAGZod62ACq0gieOr2l+wtOuG5KRBB28woiRcQ444+qk88v2Lt7DMzntu/AfbIfjN7kut4UQPyhtKcad5fOSypvbbFCn20wo0i3qSdRBnV8J1K8L7c2XIMRr6qJV2dcUMka3x7Wc4/Fg7iNN/P7X9IK2I9VK4e70vnzB8u6FDzIv7Nc9PshODw8l+1l2Mjc7k/FxTGra5SRh5iqczPeJrfvht3XobpQ3cI2eP1cNJmFdY0xx4Co71UcpfN+o/4TbZyDon2LRV1D7UrEoK8NZfoQdUiD2tFsHffJNpuXTbBvQ1TaK2As1S7Rtdsk8OWEewCsd/B124bzOq4xVS+9BVVnITg0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(2616005)(186003)(16526019)(5660300002)(75432002)(52116002)(66476007)(66556008)(66946007)(316002)(786003)(8676002)(36756003)(6512007)(6506007)(478600001)(8936002)(1076003)(69590400008)(6486002)(83380400001)(6916009)(2906002)(86362001)(6666004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 54g1oED/1pAhmskJ+rU0ZAxD9I9tRGccVAm7Mm20Qb02ymG4tE3N6Kxzi30DkR4sKxRichU8JuObpmMRR6iJHG3262F6AzesO+ImyszLfNwns0RBz0l0RSVLzGQlTIzUTtWHdrS7sm1DFT17FRPY/EhjIfem7W3zNhJuYJxrLAvKSAb/3XkHWeo77lFYt1DvK5fVFZh+edhYZEBiMXOFg5FwDodZwr6F4rAxSRuSnbF4Laa9omQzOHXzLApMGFkwg6ocmWCN1ZosQMHNY2wQiYNNCGhOfGXbTtql/SSlF0rFU1cDV/71Tl6Plj9WtFuvSEHZH4QBJAaZXrrwC8koHdD+rTbZu+pR2bRFtELsuwHV4eR0ZsxPBx1lhiLiAOUYVhyW/VOspq+uXe9ZkY0AkEWhhnc6DgO4mAJg54zRhGau5XaPGUET/xbmqO2fkgXjk00f4oCUs/Pag9pOWW4MoTr1ufuzE26QFVzXfJAsAsWtIIHoK6HkRODZHh3lLaa7wERTenrDnh2ptiejzEgUtZuqI6bbt3M4/JnGtjj/OE2iGVVZMHZ3tubQ8bIZ6e9fUkh24un/GXps0hd4wTOOa4yruxHKcGciRLmZ4a6yfuDiDZKcCnCZCVxqNbADr/UftOt3JD0PGVv0CU6cZNll4fVjBtMEzVKn5uGzkf0cpyr4qD+DRS/JZQ7PfF146tMSvOLT/SqVh/KaN4A9EUksKg==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: cb61e1f0-26dd-4d37-6837-08d868858d31
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 16:50:08.3768 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+EFv3t0g6z6CRjty0+2oROMmcM4m/q8Hgg/wnKCCezWshTOVaZKdB2ikMPfhV19JoTfMYnqPn/aQBOzO+6Fkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6176
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sun, 04 Oct 2020 16:50:13 -0000

If __WITH_AF_UNIX is defined when Cygwin is built, then a named
AF_UNIX socket is represented by a reparse point with a
Cygwin-specific tag and GUID.  Make such files recognizable as reparse
points (but not as sockets) even if __WITH_AF_UNIX is not defined.
That way utilities such as 'ls' and 'rm' still behave reasonably.

This requires two changes:

- Define the GUID __cygwin_socket_guid unconditionally.

- Make check_reparse_point_target return PATH_REP on a reparse point
  of this type if __WITH_AF_UNIX is not defined.
---
 winsup/cygwin/fhandler_socket_unix.cc | 17 +++++++++--------
 winsup/cygwin/path.cc                 | 10 ++++++----
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/winsup/cygwin/fhandler_socket_unix.cc b/winsup/cygwin/fhandler_socket_unix.cc
index d7bb1090e..429aa8a90 100644
--- a/winsup/cygwin/fhandler_socket_unix.cc
+++ b/winsup/cygwin/fhandler_socket_unix.cc
@@ -8,9 +8,17 @@
    Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
    details. */
 
+#include "winsup.h"
+
+GUID __cygwin_socket_guid = {
+  .Data1 = 0xefc1714d,
+  .Data2 = 0x7b19,
+  .Data3 = 0x4407,
+  .Data4 = { 0xba, 0xb3, 0xc5, 0xb1, 0xf9, 0x2c, 0xb8, 0x8c }
+};
+
 #ifdef __WITH_AF_UNIX
 
-#include "winsup.h"
 #include <w32api/winioctl.h>
 #include <asm/byteorder.h>
 #include <unistd.h>
@@ -124,13 +132,6 @@ class af_unix_pkt_hdr_t
 	   (void *)(((PBYTE)(_p)) + AF_UNIX_PKT_OFFSETOF_DATA (_p)); \
 	})
 
-GUID __cygwin_socket_guid = {
-  .Data1 = 0xefc1714d,
-  .Data2 = 0x7b19,
-  .Data3 = 0x4407,
-  .Data4 = { 0xba, 0xb3, 0xc5, 0xb1, 0xf9, 0x2c, 0xb8, 0x8c }
-};
-
 /* Some error conditions on pipes have multiple status codes, unfortunately. */
 #define STATUS_PIPE_NO_INSTANCE_AVAILABLE(status)	\
 		({ NTSTATUS _s = (status); \
diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index 2e3208d2d..4f5f03a76 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -2476,8 +2476,7 @@ check_reparse_point_string (PUNICODE_STRING subst)
 /* Return values:
     <0: Negative errno.
      0: Not a reparse point recognized by us.
-    >0: PATH_SYMLINK | PATH_REP for symlink or directory mount point,
-        PATH_SOCKET | PATH_REP for AF_UNIX socket.
+    >0: Path flags for a recognized reparse point, always including PATH_REP.
 */
 int
 check_reparse_point_target (HANDLE h, bool remote, PREPARSE_DATA_BUFFER rp,
@@ -2618,15 +2617,18 @@ check_reparse_point_target (HANDLE h, bool remote, PREPARSE_DATA_BUFFER rp,
 	}
       return -EIO;
     }
-#ifdef __WITH_AF_UNIX
   else if (rp->ReparseTag == IO_REPARSE_TAG_CYGUNIX)
     {
       PREPARSE_GUID_DATA_BUFFER rgp = (PREPARSE_GUID_DATA_BUFFER) rp;
 
       if (memcmp (CYGWIN_SOCKET_GUID, &rgp->ReparseGuid, sizeof (GUID)) == 0)
+#ifdef __WITH_AF_UNIX
 	return PATH_SOCKET | PATH_REP;
+#else
+        /* Recognize this as a reparse point but not as a socket.  */
+        return PATH_REP;
+#endif
     }
-#endif /* __WITH_AF_UNIX */
   return 0;
 }
 
-- 
2.28.0

