Return-Path: <kbrown@cornell.edu>
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2118.outbound.protection.outlook.com [40.107.243.118])
 by sourceware.org (Postfix) with ESMTPS id 1BE9E3857C62
 for <cygwin-patches@cygwin.com>; Tue, 29 Sep 2020 22:08:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 1BE9E3857C62
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCqjo4rDIiEggg8sEn+bjNgP4VOJFQxKBtctGt4M8SvaKr+tD5YEQojJZ6n3wHLeRAjaqscONxJSIYINR1RLfqu8nS7rRSsMYwmXsj80UmTUWt6goTUU8THLEpQ5wClP69m3GK0pw817msuiuwLIzwwrKXLbsT+buwAufjn9rv09yCDYj7KQiEkOvU01/6EWD2g0PspPgGx50cBEs3x3R9t6DKQEYrpy1PBGmF/CoTrcUUYHe0Nb46v00+4e69GDMSHwirT5jiIrfiTre9JRWfSJnV+gcY/e132G7b1u1bvIHFSeUdqyCJCgTKGDTZmMGA0M499Aqqe+qPwXstI1Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3HuX/eK0cr9GHG6XOuEtfH3CY8CABsA5Le0pw3nm7Y=;
 b=QO/IRyiPpK/hNgxvi6Uwqwz3WfwFv+eM+hbki+/KGeq1dNghQfnw1uHXFf7H0xQSMiScO66SbmFP3Y5z4Po4DDNPpczilFy87v6I1Cl/bPMfL52WLnSDhEKpjQ3iKfIL8qf1JwWX6FsZC5wAdZ9bCfwaYFzxT3s6XhLFvjSBk2VGyT4l6RT8uaPHk1nk8eRB+f800qh96J0N8ZOgM8/GqlDt43PzI6LNSgdS8KAq6WKnyRRFCM4xi/DEgwfLHMLs46GopANObxyk+ZUHbuAazJslijWNdAriq3NROYUG3ZmmFxGIvpTOdK/DJio0+6U4MyVZdaFwsGvwz3ywiecQ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5486.namprd04.prod.outlook.com (2603:10b6:208:e4::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Tue, 29 Sep
 2020 22:08:24 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44%7]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 22:08:24 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 3/3] Cygwin: always recognize AF_UNIX sockets as reparse points
Date: Tue, 29 Sep 2020 18:08:02 -0400
Message-Id: <20200929220802.9980-4-kbrown@cornell.edu>
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
 Transport; Tue, 29 Sep 2020 22:08:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e798aa8f-39e0-4959-3289-08d864c42ee4
X-MS-TrafficTypeDiagnostic: MN2PR04MB5486:
X-Microsoft-Antispam-PRVS: <MN2PR04MB5486F4E50849A57E28DC09DED8320@MN2PR04MB5486.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tRSrnhGfvXqjRByFahvaQgj/csRITdlVfBZKrBDxHTI/Rc/Dhd2bAZIhR8VAFZX45MRKo8khMpkvoDy3iiQ5U4g2aLx00pEv6wcCTEgzt5I80fOeMQb5EGokL97+MYbJSfsUmvJ665ysXcbcX0fFiQ64ZqkQICXkJiT6dvnyvV35MAWgT86gfAGMre0WKa0JlbDLOlJHuzKr5e7y30vYzU71uNYt6lURuP1xBEyOwhAkyxJpK0Nbidh0nqrSu5zQAKUBPn0RRy45SSOLQAiNhGyYdD4D134fDaR0fUt9qAgcoRr+uMdt3ykmf/1xtYmgXvwevya1CxPQPPeZkW3NrwP6QsNmShWGB1NVJ+Lqv5bJAOTbboHz+nHtCoWvmNxyDH/LX+eZ8Yho1hgwrh0+T1tipAHIGic3bYhUNurMjSCLjh35HyaUDFoGoXkef2bv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(366004)(376002)(396003)(39850400004)(83380400001)(75432002)(16526019)(8936002)(8676002)(2616005)(186003)(6916009)(1076003)(6486002)(5660300002)(66556008)(66476007)(69590400008)(6666004)(478600001)(6506007)(36756003)(66946007)(2906002)(52116002)(6512007)(316002)(86362001)(786003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: UN5X6WB2ALjr9RBQKA5VqaIcaNRZMM9Zy19bc1/dX0o9hExoORQ32yPwGBYByl9zA7x7AkqxjzxLneYurOcCeov5TYm+0GwieKck4lwnmPtFYxrjI7fs3NkSXaThBsdxsytbwmUX+jL4fFTw75yDVHqiNeGzM+Puxx4y1cO1OU1/zskYDrkefIlO22Ox2JV6Tz5HGw3YOqy7BUKYSCTeweGUaMapG9ZFfRTqLZ6OLG/kszJfMvfCcuFlEseawNyJPGuTRjk9mKygKmnqWyM7VgysEs1123OOKVgcONrQe/34FmggCtsDyOVl62DyPXdYOLtag0vvGQ9x/9hQuUhWlIJDZrPhi2Yf3lObfrIfZraSdUphLzgxG7yIQ1OzgmSbyEVrBmbutYR/ZZqv24nYZhdlgqM/BU8CZ1dtXNCxBvNQkkF1Q8sKKMEXIFKDBU1UoZ1gVdmoH9lnFR8iVS8IHJ3gx1FfnaKmHOZ3mYCM9YJsh+Ty0gkP5kX0LykwWdvBK8UN9+kYLov+B29QhbAx2upxEsCl0tZnHBc/bo5R5s4EhkD5h6HXs1ChLhsPRxX8Nz5CBsnt7dzFXVW2fYc0PHS0wcsDf8+Ugw345qiMXFOsI+tUFynG39iOAtkVy9i3GyZnPByHzSHmioeZ3rBE7xcmHapz8qmwl/7+Ow3irkUuLoINy3qqUw2KFQdFApeAyP5s/tp36xVbZ95VAi6UvA==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: e798aa8f-39e0-4959-3289-08d864c42ee4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 22:08:23.9228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IwYq8nees/4fsjGLPytD4P8N+9/nlzRxomNUsqCJN0oY0A7DrylbFxNxdQ1fofBXknlELO2gHxxkGXV1ip5soQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5486
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Tue, 29 Sep 2020 22:08:29 -0000

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

