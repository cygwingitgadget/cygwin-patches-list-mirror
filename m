Return-Path: <kbrown@cornell.edu>
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2118.outbound.protection.outlook.com [40.107.243.118])
 by sourceware.org (Postfix) with ESMTPS id C51013857C62
 for <cygwin-patches@cygwin.com>; Tue, 29 Sep 2020 22:08:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C51013857C62
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkCyMsl8KGPGCxjqNURwB8KLpLN9WlBhOnM6QgC90D2tVnNtCl0yBzo5Ngz5V3piBFEDuhUG29pfsxX6Bx3YjdgeabY1d2Tx+X+yVSeZA+PCWii6FLgP9kGTyQsAbhHujYh5aDig8VJPpIzjl3JRj+NthnTtasXqFytvjlSU3Boc5AdKJo4l9WOjKvlHi2HmkrbKgYanxyJ15dEXv3D4xmDZeUAP7ZMnPQ4AXFOjcIlxBgxVCSwCesx4DpQqAWgno6gHU5F8YVQj9EpWWIDkgzet1tzLI2dVCwx0uiuM9BemLo3fvoVNlLIO0P40CCuQIcCqwlW93i9iGe4cb+MvoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=If/HRExOv3tfeR6MHgiQIYmEK1lYtec7qIy3whZSQw8=;
 b=dvXK8uGGwvSooCbI931oBb0KM0yZYpjJoeRSU+XSaT4v9vIfRoAtXIWFSYnXAFeSulwl1iK3a51HLFTh5VNMdrUUDM/9zymuUZt/aM1DRO/lGxCEZ69evvD7Ma4JGlwjAEKsjcGlvXJvXld1/QvZL4jfstzVUY0yPchnLJBms3SBlFnZWAxRcSWfqRBVsgjaiMmxXNAMpAMx7pz6kCJzpRadz8R9yCwy6mG8x9/ydNaK+xWHJiaf3xIYYdj93TdyRGPFTdiY2GKVx40h5Vx87u4DI6IK5x/ZCbZFwiEFAvj5xZmukszcy+qWKDGLtQsBqFdF3bf94n8cfwJ32Ab2QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5486.namprd04.prod.outlook.com (2603:10b6:208:e4::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Tue, 29 Sep
 2020 22:08:23 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44%7]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 22:08:23 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/3] Cygwin: fix handling of known reparse points that are not
 symlinks
Date: Tue, 29 Sep 2020 18:08:01 -0400
Message-Id: <20200929220802.9980-3-kbrown@cornell.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200929220802.9980-1-kbrown@cornell.edu>
References: <20200929220802.9980-1-kbrown@cornell.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2604:6000:b407:7f00:f15c:4f14:d254:947b]
X-ClientProxiedBy: MN2PR15CA0031.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::44) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2604:6000:b407:7f00:f15c:4f14:d254:947b)
 by MN2PR15CA0031.namprd15.prod.outlook.com (2603:10b6:208:1b4::44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend
 Transport; Tue, 29 Sep 2020 22:08:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1adb0e9f-528d-4a59-5a7e-08d864c42e58
X-MS-TrafficTypeDiagnostic: MN2PR04MB5486:
X-Microsoft-Antispam-PRVS: <MN2PR04MB548620A9999E158910BB2962D8320@MN2PR04MB5486.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PYD88sHheD6kfO+lY2+yLHAumcLyJBc5nnjiHhuIhKAcruz3GGid20ilyQpGt5JI9ObQGAxKRwMbx7Xn7Rc7yKdkWr5V+cX6pxU3xcn5uerJoJGtv9iSZOT/kN612WSmOJ+AH8D0tGjk7bdj2RWqvOv8zQ+zcqZOq0B501OJTN4wdc25YAgKcn2LwtEFcCvr5CXPXkouNLQtj5YfwDzzHDKhduaZAHx9WWV2YH2iUP3DehLEffYltP0s9r8tb2UuD9KEF9fnZEpg3T+oSwx0tqAr2RmctYrJUEb4E/HsfvTECmFRPHyTekBhHdVGUHETs3GDHHdmw+tyqwAsOUFL9NsoH2Ix2U9LguPq7hStp/J8dnmNpnHwEPKCqiHp3+uVg1McqxDzc/kuKw7ZAtHMTskYmhzqUWuMu/FMfccQME5v7OHxj0S0w2h3lEGVvKGd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(366004)(376002)(396003)(39850400004)(83380400001)(75432002)(16526019)(8936002)(8676002)(2616005)(186003)(6916009)(1076003)(6486002)(5660300002)(66556008)(66476007)(69590400008)(6666004)(478600001)(6506007)(36756003)(66946007)(2906002)(52116002)(6512007)(316002)(86362001)(786003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: QI/iBjYyyIBJNSEjAmt7mksimgjeDyIhHs1UVkzsWNZ+9z1AIAUU5Dux7xSFRJtp13qSoa4qJy2Th0Lxift737/2DtSowpMMYzhE+HL5MpwtyzQ+CNLWL8Mm8VJV1/jB9dWqVC7Hr4+W6XJIiACPIB+E5S2gHoWJnSHolWHa/bjuk25oKiwfG397wAWK6fFzS7TO048YI/7F68GCNEWdH5X/ewtBcRXI4QQabKGi+c2XEY/jXbxMGckgha6AJR6jGAQEF6q+zVKnV5DNSOg/qQSk76DQArpUy6BXH99KGj9j8xbzfKLOJBNZhJnCpzVBIng7Lv5RhKmrFUucLGMQaxCMbe9jZ7450Sr6/LJJiiNkoDD59u0tMjUZ4kNwp5BteYgjOGFuMlpyEByaTVUTEIc5WnnAl2d1e4G5HJhanw+8fj1Eaur3tcPHkbt17KMsTJmEMpw3n0NCVyCCrL5hS0p099JF+itzt096tymOhIpPL3EJ+9XlW3bwgyNjawpSZ6AfiF8N+hA7UC/m4aBGFRAXJi6wrua8DaLWKKT02G9Xrsn2yejU3F0N3JM/b1/Hd2IKVp51ptccl93dxaeOBud422GAHTBZzOBdL4E53u6rdwEIEIE1ArPewTIcDwLVQZPvN45eq75LHya2CWy4PDcVky1JlfsyLYMeDcBSCGDJ1zUsXwOEKxqIwG9d1LCwJQ+eoxpLfUrO7n67lvNAow==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1adb0e9f-528d-4a59-5a7e-08d864c42e58
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 22:08:23.1572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ahTqkBCzriHsGEry37VLI9/T+WzkHgt6L0cCFXZKo1N0ecOy/VCsj5hQmtx8J+Dm10hFqaVCjb/VseUpZIMGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5486
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Tue, 29 Sep 2020 22:08:28 -0000

Commit aa467e6e, "Cygwin: add AF_UNIX reparse points to path
handling", changed check_reparse_point_target so that it could return
a positive value on a known reparse point that is not a symlink.  But
some of the code in check_reparse_point that handles this positive
return value was executed unconditionally, when it should have been
executed only for symlinks.

As a result, posixify could be called on a buffer containing garbage,
and check_reparse_point could erroneously return a positive value on a
non-symlink.  This is now fixed so that posixify is only called if the
reparse point is a symlink, and check_reparse_point returns 0 if the
reparse point is not a symlink.

Also fix symlink_info::check to handle this last case, in which
check_reparse_point returns 0 on a known reparse point.
---
 winsup/cygwin/path.cc | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index 638f1adce..2e3208d2d 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -2655,11 +2655,15 @@ symlink_info::check_reparse_point (HANDLE h, bool remote)
   /* ret is > 0, so it's a known reparse point, path in symbuf. */
   path_flags |= ret;
   if (ret & PATH_SYMLINK)
-    sys_wcstombs (srcbuf, SYMLINK_MAX + 7, symbuf.Buffer,
-		  symbuf.Length / sizeof (WCHAR));
-  /* A symlink is never a directory. */
-  fileattr &= ~FILE_ATTRIBUTE_DIRECTORY;
-  return posixify (srcbuf);
+    {
+      sys_wcstombs (srcbuf, SYMLINK_MAX + 7, symbuf.Buffer,
+		    symbuf.Length / sizeof (WCHAR));
+      /* A symlink is never a directory. */
+      fileattr &= ~FILE_ATTRIBUTE_DIRECTORY;
+      return posixify (srcbuf);
+    }
+  else
+    return 0;
 }
 
 int
@@ -3274,6 +3278,9 @@ restart:
 		&= ~FILE_ATTRIBUTE_DIRECTORY;
 	      break;
 	    }
+	  else if (res == 0 && (path_flags & PATH_REP))
+	    /* Known reparse point but not a symlink. */
+	    goto file_not_symlink;
 	  else
 	    {
 	      /* Volume moint point or unrecognized reparse point type.
-- 
2.28.0

